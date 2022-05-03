Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803FCC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B98810E4B2;
	Tue,  3 May 2022 20:43:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B098610E46F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avf0xk+wTZEDfoKfvZKwCc/B8dAy1khk1rQdvyO2+Sc2j2+0SGm64uzWHSzSM+Fu9ljAw3GUa1xcFDtVxeoDPXGtz5MyAZKe3+WNDXP09coFkYB6oXmwFF9bV9jbQG8XUX/whnN/1/OxlCOQhUBB5BnxDxmR8oX4Pg/cnsAWOwFDIgec76SFcGKb4Y3kS8w7K/7P9VriUVE14i5qPJWqjHGA04su1gundcLlbVmRl4rjtVzfsJEcOjOkYuHSImE8JMV4VaenKw6cuRQZnNGmCHtmdPr0iiaw+kexyajNEH+99BconS345Seam6jqKQ0s+XmOGG2y07jr7MFB0CLllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNUAf0MvowpyoGW5JkB8AKMEMuZ5kqLePCJ624KD68k=;
 b=TLdpEflAE0belqnkMwfzdvXIswKFqs6PLcreuP7FJ410ixVdls6sf36ARVd+W4zGSwjPviSPTEpEsCiPWN4SDDBToBvIekLAMTfQyM/NWWHN29stm0s5lniA3k43WFGMT6As6g6tDJErCf8Po89UknI3hx6goR4ThSBBJPozMkGrZmzJq7Vms39zU023Iu2oGy8tgA9WGonktU+AfnyiSBcgTYCZMn5wjy9a2rvDmVlo5fP5m186XeUshMoeMU2++Z065GcmOlnA0A2jZgTgN79SYwu6bGUHl640eySnI2VTn1mZS2O8r3CAmjjdThO9eX9gpttDSOF/SemMaRkBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNUAf0MvowpyoGW5JkB8AKMEMuZ5kqLePCJ624KD68k=;
 b=qN9Z13dHYXy6bfRtiHBYtYcZ5DBjvbU89GvXA8UaOj44hS3YzZIpfK/rDest2lzT7CLlECkkc4tXqQdJB4EYN4yNKrlqiTrSh8NeVTr3nJw2cShIRF5KtB6yrZqttygEeIBNLGQxUzzFVxsRIvMhk8W/w+yuUwzu22zVRo1gMQ8=
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:43:36 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::e7) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:43:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:43:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Add NBIO 7.7 support
Date: Tue, 3 May 2022 16:43:11 -0400
Message-ID: <20220503204314.1250729-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cac6e0ce-c299-4cb2-c165-08da2d4597c3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB531112109A95162423A3A6D0F7C09@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2eLJ4h1fwQ5HkmK5pGSPensyVZ/OUzHyccIqavP3VkedmwWTtE6bkoNtJuekqwTvDMXteVXtpNMynY+xZpoqA3a9OzDwwReCwQFQJcTL1RUPQphet5CXorETo9Llt78KfoOQYAbWrjFMUGVUbaxUryrUPmYnFL0pGPzlB5OgYt/7fjTfTeVu5RLj2L2RkZOprN1NSTPFcCn/tIFBgeRA8zHJ/n2elzLP2gQdXVeTxqjDia/4MwUcSgI/vRuEF6DGQZSyUm5MnPfOpjy75yeSDosfe8ULQJBckqnd5/dnfEtYYrL/IdYR/zQOtfxOJ4NTlDdCCB+A1ohdiUYrp3+3BFEP5ksbExqSamNMNLnZPZLQjNARI+bVg/4KujhqbT5cAtVMLrREgNyysHK+N5UuDde1TKvQi2EpRhMDBFcBzm6ya+I2WuXpYV3edy8ldX0gJ3m57l0wjqG4vVj/yEgzfmb5wqGW9Q1/Y14w+mAgYAidqB4B7z9VuijwMed6O0ow1oLhp4+RJBGULgOIlRxOyHT31ab3HmBx+IE0F+/92DyOtwqgR/M/g5bvjD6APWvb+EGpdJvY1frM/ilNgDdsPazpsux9e5aI1DKV5DZucWJbnh+PMerCsP17HF5D1c+vWYWV29yM+72SN7Ast4K132BfH9dVXQlaY5Peat8+jooEKyEJJLoTQKcfIuTC5uj/NrSWyia2ecSYy4TUojUyiQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(47076005)(426003)(336012)(83380400001)(2906002)(36756003)(5660300002)(26005)(36860700001)(16526019)(186003)(6666004)(1076003)(508600001)(8936002)(8676002)(86362001)(40460700003)(4326008)(6916009)(70586007)(316002)(70206006)(2616005)(356005)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:43:34.7591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac6e0ce-c299-4cb2-c165-08da2d4597c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds support for New Bus IO (NBIO) version 7.7.  The NBIO IP
handles the GPU's interface to the PCI bus.  Patch 1 adds very
large register headers so was not sent to the list.

Huang Rui (1):
  drm/amdgpu: add nbio v7_7_0 ip headers

Xiaojian Du (3):
  drm/amdgpu: add pcie port function helpers for SOC21
  drm/amdgpu: add the files of NBIO v7.7 block
  drm/admgpu/discovery: add NBIO v7.7 into the IP discovery list

 drivers/gpu/drm/amd/amdgpu/Makefile           |      2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |      5 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c        |    241 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h        |     33 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |      2 +
 .../include/asic_reg/nbio/nbio_7_7_0_offset.h |  29654 +++
 .../asic_reg/nbio/nbio_7_7_0_sh_mask.h        | 154403 +++++++++++++++
 7 files changed, 184339 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_7_0_sh_mask.h

-- 
2.35.1

