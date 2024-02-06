Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A9FC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782F9112DE6;
	Tue,  6 Feb 2024 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uyBBsTl9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF42112DE6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLA44jE4boUY6DNDXwhnAsD+SKKJWYNb5poigCvt4TvVAfsRONjW2Jd7fLQe6CVH1k0B7geyLtHInTCIZ10NMfg6ETn78N9apUcGxyU8xX0yRHW49dvAvFS7sy3wtMwzOywqcuQV+f8qgea1dx2UE4VFMKoOvSdnN75vbat6+CU6fj1BGEAOP7t+Pp8rjfIA610jbLysiy6Yykki2h2iWNC5inJixfirk6KgvLtAaAU+bawQmzwMF2/EljuuUFGFXSk4g9kl5EkVEjfWDEDag6iECzXfB+kLma4wFjdqv0EHwKs9JDV6Sb3gj8b8x3+XItUlC5+dTjqG7ppvw0m7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08+ioCOJxt5LWdcN0Ev6mmCAbaZnjB5O238olwUTGss=;
 b=mV2ED/O7Nj3SwAw6+iaz4aPnKQdgqkXkwXL2wzpFAXSjcgL3rdQXL/J4M4uoNzkDw2Y+Zj6OyMnNYGHCNaEiwVw2lnXd/aTBxESfsCfC9B7tPbJpGP4n4AOleuUfyR9QqplnzF0jaVD/u/VNPY0RRHRMJ0Sp+8EX4mgCl2HOk5HAjSn0P1nnnkwgBKcMXlV61JVZLk8BLPk33jr72lZHUED4jQ+g45j0bQzk6bGGFqzKfHXhf7zt5K8ZAEV/hXcnKBzmekoqCh/YUiAFYVcVwWl1TOIrmFWVwHz5Pl+pQoeLZ4fPMvMmImJXgfxZSndg9QoyqjmS6hVdqe8YiCaKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08+ioCOJxt5LWdcN0Ev6mmCAbaZnjB5O238olwUTGss=;
 b=uyBBsTl9oFMLwcFUN0Aj7eP07FVo6ZQPqf4dCK5cg2zu7g8xzBbZEIaCHAHbeklzppdZlhIqJnv1yifyMe1t1ojlE3sOHSn25UehJE7A11KOPQFhV5PJ1qYcN2pmcZTZnpi9ZQaFjy5l3eM6pAYwY5VwH4lnpFlZ+cIfVd65qjs=
Received: from BL0PR0102CA0072.prod.exchangelabs.com (2603:10b6:208:25::49) by
 LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Tue, 6 Feb
 2024 20:22:45 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::88) by BL0PR0102CA0072.outlook.office365.com
 (2603:10b6:208:25::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:22:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:22:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/3] IH 7.0 support
Date: Tue, 6 Feb 2024 15:22:25 -0500
Message-ID: <20240206202227.1671475-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bb41cb-6c9d-462d-086c-08dc2751603a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlxxAEwU85KpQGqLSVeE1Cew+hupWE/KFRVnUWQEpGAVg/aB9DvCfp8VPzsPwSkcZEVBprPGdhd1T1+SlXTsg6+spwxIqhuhi8nFIryGQJCwFwGqDwCAL5zuQNOVRIkpOc/uMAe223VXzlzPzKBc+QstlGWoMg6aDM+PWNbm0SKVPtC9f2CR02f0N54rKay64kSWwkhqhiY5BGNNMSibptYXwo+mFf1MF0f+xxSjy/r9GytCxtTE4ugTr9cN/jSYKGn+lh9p6Tk2T6ndYvUkdn1JZLq8UrjppefC7Jc4VMQAtFSC7jwlqC7S34QLsZmwxFugWCf3xFmUbooU7SsIFrwbjaXIQMVHmMTAikkk2Y4Zo2hQFwIKBEG1+nMRmhTTzBduAyMtMuuLPaadAfe/Dk4j7oRGB544Qi6o8AA1n8TKPMrR4PCzxmzFoqI0IQ/YB602PRbm8ApQuFGSil2g+AI7aRIOWD2H3c6OU8Mj0rmkEYTvfvApkX8hY27cmbpbehTPg4K2WwRDvDjmpZFwhNCoqJBAw+iTI+VF0ttR9sgimqWmC2z59rcLr7TcG9haHi4vpnciK1pIq2EeCPDAZF1LOYP/O1em2kaTlO/c/YDGJTI4vCzNsj5CXsiyvg5gooiLDZFeANvXvpXS6MbYFuQ7fzmzG5m7UG09j46JmveilURAKEj045aYSA3m9yYbLouJPPkZI2vchclQMYAFKzRckIEXaCJgKn8/ZIvD9K7rc3yvHEFt856zgqSkIm3UEIcLhqDHB2GKyl7gH2bqBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(83380400001)(41300700001)(8676002)(70586007)(6916009)(36756003)(86362001)(356005)(2616005)(1076003)(82740400003)(336012)(36860700001)(26005)(47076005)(81166007)(426003)(16526019)(7696005)(316002)(478600001)(5660300002)(8936002)(4326008)(2906002)(6666004)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:22:43.9549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bb41cb-6c9d-462d-086c-08dc2751603a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series adds support for IH 7.0.x.  IH is the interrupt handler
on the GPU.  Interrupts are written to a ring buffer and the driver
walks the ring buffer handling the interrupt packets.

Patch 1 adds the new register headers and is very large, so I've
omitted it.

Hawking Zhang (1):
  drm/amdgpu: Add osssys v7_0_0 ip headers (v4)

Likun Gao (2):
  drm/amdgpu: Add ih v7_0 ip block support
  drm/amdgpu/discovery: Add ih v7_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |  766 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.h          |   28 +
 .../asic_reg/oss/osssys_7_0_0_offset.h        |  279 +++++
 .../asic_reg/oss/osssys_7_0_0_sh_mask.h       | 1029 +++++++++++++++++
 6 files changed, 2108 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ih_v7_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_7_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/osssys_7_0_0_sh_mask.h

-- 
2.42.0

