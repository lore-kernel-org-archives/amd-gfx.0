Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CCC3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8946020870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kb0Y16kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8946020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 615206E95F;
	Tue,  3 Mar 2020 22:02:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7019E6E59F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 22:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKFiMCZr82xGfd9yyW3tQd0CHoPVevEn8RKTz5qKFgwNG7MRjct+T0ez0+IGD66iyjOpau4HAPruce5np4WU/f5WUjI9LYD5TW6at7QrF5VEVTFHQUzXVSlkYCm5vwrp+GOwONPcevR2wvRVhUWnRkjr6xYOfYC93iuj86AY9OBWoiljr0x4oRwZaBNPyExQ7/97bP+n1Mh/TWR/Xy2cVRSI8kjbKSuu4z1Gc/fVxNuTAOuo22DXNWNz7R7Epdqvz0j8P2dpTwIFbhocTIOQUGl06w/uIu0M+oiF5rtbYvsrZT+tPsjV5cpxdj39M0ZdZ3FpsekO/Ot6xt0QqzHH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpippjnXQE87jfyippK0uWt5irSkN3H3Jje9dHbST3o=;
 b=b8WxpPojPlnITBZkwHekMtMMnJ2247/vdBpuHFDEu9LTsVKvgj/0WX+qb2kv5hLFdi3taIiejjg2XTEGiENnBtUH79paVWbh/8QBz9sWAe+WQj9ZCwvBhethNc7OOLYssBMr037MpwcERhXbb8hhz62vtnYgz9+HOLo23/TXQmS5Evo6ZWEXCNCpvsuWB02DcYKEiw0ZCYrndhOJJmsZWiWP5DtCIJiZQiqtmEgAnKcYAL+s5N55IgqqgSwXXcf+tS+OVQPQ1GyMxYO4YBllNXF0JElPXWarq2CSE2hhcKyKvaaIF8b8cdXrl4zkbHXmUWG6xEuu7eSXdgVkGDI1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpippjnXQE87jfyippK0uWt5irSkN3H3Jje9dHbST3o=;
 b=Kb0Y16kE6qCXHQ7rzYbNXeoAavkYMGQ4/Rei0RnnaDT+bx4N+iRkDuxA/Vus4fnjZnyiQ0lnSoS+ni/Bo/J84abg+acKfF0uphD/qUfAXN/pm0Yd/1726JOX8+2SnjwEnLMulFX7TgvW2WuW2h0867DB3KGjWi3kG/l8OkRvsoA=
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 BN8PR12MB3538.namprd12.prod.outlook.com (2603:10b6:408:96::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 22:02:12 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::5b) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 22:02:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 22:02:11 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:10 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 16:02:10 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/3] Add support for USBC PD FW download
Date: Tue, 3 Mar 2020 17:02:06 -0500
Message-ID: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(199004)(189003)(4326008)(2616005)(8676002)(5660300002)(4744005)(336012)(81166006)(81156014)(70206006)(478600001)(6916009)(70586007)(426003)(26005)(186003)(2906002)(7696005)(54906003)(316002)(356004)(44832011)(8936002)(36756003)(6666004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3538; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4d78f3c-d060-4adc-efd7-08d7bfbe866e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3538:
X-Microsoft-Antispam-PRVS: <BN8PR12MB35382F91D231BBE3D5498B42EAE40@BN8PR12MB3538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxR7PQKv1o+vKv/pqcMJnx2IM9S2k4YVX2rj0+z6zwpPEOKlolBqjblfvlFvDxNf6JW2O5bETp7ywenYbmP0xvFhzuA7G9zzEGE6htT3PQ4wZNkGtpVYGINk7u5t7j+AhbsN3IHFEcDWd5ZivcLCYWaU3KNFee+DFxgZd4tCo22hVZ5RyTRlNLdgs7FTru74fmRXZULt3p5rIKYtdXSk4IHQucGf01mO5xB+dwDZVc9doK4nlkQZ0O1nDStKZ2OlXIn2YhMrGd8jxqDJyhdCfQTZep5vTZrEjW19eQ0Wsd7OIGMnCqVP8skGxyZoOZMq6s8ExyhQpwlcV/uqOW/4Jf7l1YqUx0evllSWxj5b4SEPUHyruXulXq12ga/gTbh10KbHm6n/nj+SvpyW+gD/3NUs77LarAPR6dsgEvdmdcJ/PsqDLXO1KwWjmW8KlXVD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:02:11.5883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d78f3c-d060-4adc-efd7-08d7bfbe866e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset adds the kernel driver part of supporting USBC power delivery
firmware downloading to USBC chip on the ASIC. The FW is placed in DMA buffer
visible to PSP which then proceeds and copies the FW over I2C to the USBC chip.


Andrey Grodzovsky (3):
  drm/amdgpu: Add USBC PD FW load interface to PSP.
  drm/amdgpu: Add USBC PD FW load to PSP 11
  drm/amdgpu: Add support for USBC PD FW download

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  10 +++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |   3 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  |  82 ++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
