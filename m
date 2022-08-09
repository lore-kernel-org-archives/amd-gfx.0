Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BDC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 15:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74C8DA6AA;
	Tue,  9 Aug 2022 15:10:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E02DA619
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 15:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgET50VGQU3XKnFzsskO8IKMlvxUy6FfmdmFJTwpg5ypRxYxRFRSAW4sl7OfazgcIj0JGyx89eWaTdCljk5mM9dZwfzeQWvTl/ywut/F0xNgSYALU/cBzgj9XMJE2AZvQ0lOK5AXvxPF+/U0s3kR+qcy+2dP1TsCcBQfS/dMRxILQ2RPTFEQNPrHkIPfonmaGaVt5kOBGCHrd0cr4P3bnPE1SsQvclpO/9+O3V3SPDn6UbmU1ncHhJTI0LjrSAczmTP+Wo3ckCE2eip/IN69mcvPUU6Cw6lp6zpDv8iGEYjROsw1pRr3p2/1GaAJV6G1xEf3JPoL+97h/sEc0oFmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyY47Eex/OqfxJplQ6cHw2emIZIhNvq9brHXBGEI1ls=;
 b=ABlKuLEcIr31uGek/jma4M8SzbU7euMMKzdfL1e7J6idjWvxQ+zpem6X766A92PZD7vFTqeTtjGJhiZlOq9XRxESTB3aa7ehBy8roVK2mUjVnpocML3GxH3+K2VJD4Rfn0gdWz5hEXyDjZ96VjynAu6RKuY5qDKhxTvWsKSEtPOV+PBu7cmhN88EvKZid7g4ZE+GaXZpycxb5lt1gI+dihMUvfwn0oVoaqrvQaS3cxzrlJlM1LQKmmIiEgApTDYjTTehmuQ488Ii5Jwt4jFW3tftW0iIhDxjaqlEjaF23nxAIaNpntcG8FYepPNvyidQi1z9ESMiVqJcMEYHdesasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyY47Eex/OqfxJplQ6cHw2emIZIhNvq9brHXBGEI1ls=;
 b=EOKNPSU/JtlYW1UPcZBvqJNW9jd33LoAh6mPSl3e6zzThf3Q8ZY8vdKEV1NjJRO7Gn7X936e991In/8lq6FhoimJaYcui4kH+eCvXQOo5gLSBycte9pBxC7Gi/HBHNT0rPLzs/8elyDwsGU8AWKlS3D0BI46K8WBwgrycdMFvo8=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 15:10:06 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::13) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18 via Frontend
 Transport; Tue, 9 Aug 2022 15:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:10:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 10:10:04 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] Revert "drm/amdgpu/display: disable prefer_shadow for
 generic fb helpers"
Date: Tue, 9 Aug 2022 10:10:05 -0500
Message-ID: <20220809151008.20376-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809151008.20376-1-mario.limonciello@amd.com>
References: <20220809151008.20376-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 435a0385-eb5b-47ca-a1e9-08da7a193e34
X-MS-TrafficTypeDiagnostic: PH8PR12MB6698:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QspyO4lZeMcplUTvj5nj1ZZWVNXNzer7ETdcqS0j+Oy+3lc3inFz42z4r5YJApjrSpfocFxx4hiHeQTYaC6m63caKOqjDB+g6D5R5rvcx7JyKCSeyW1zfhmVR40N8UVgJ7g8uDBELoWVt5W0TogG3gCg8Z01fJ/pDZlukSfXRM/sEUnkOlVcS+eOkv7yFvrdSBHXz7ITGeGCyjau9zINm/kNYrv2mOcaVxZ8NMpxrf/6ZcTHU51p876N0KUeZpJuTu6GSDQcABTcnNcu3KxJAurPOg/bn4iICZPFdvzNt5T0cyJ+MdYujv9VbsNVjMa7IDWGS6QeDWyXl3qb1inBb6ERjD49zu98DPaZ7VTxEFjDIGCin4PmNjMhotxcb18rMSqYf8zda8MQ07TfIsvkWXxAwkExR1PrHvHdj5feRyVCCwmWfCJ8B6f+5nl19Wmvg3VjRQzUHG8px9WvA5IHNjrZyqADS4ZcxM/MB5+BkrNRFEBBGuZOwLRXjLexY0eNm9U6wTOA5rIy/ICn5G3K08jMsXe4YmxhrS5160SX/FDPS1j+vCYztqVK/QR8KYCoodbjSZPr2qftAU5KQKk6UbwUhr3oZVNrun8ULfFaClNTwekQyr8fqISwBhdGApT4wnXGgzB9hvZ0rmVHvFp2tSso74UY0e7gD0kWmH8T4TmyL5UzRdJwM6cN1KEfJZBU4Xw1mel65LSpdJOXlnSXcSZLrHtv4tZ1g/KV2Ny70gAbpFBNDXswPiIAzT+2/HQbOTdoPM/LKEKXNnJf1s5yBRrtzNqvm+sAPEfujtbt1DofSzTWaQQZrOe/XTJIQQMxJMNLvH85JmBKqeawgL43PWYd0kbr+93xpUH42c3EhfVhE96fJlwDi9fcZvp7p2JE9LaUqydsDt/B4ZDNbuTu4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(4326008)(5660300002)(40480700001)(86362001)(478600001)(41300700001)(1076003)(7696005)(40460700003)(966005)(2616005)(44832011)(36860700001)(82310400005)(2906002)(426003)(83380400001)(47076005)(26005)(81166007)(356005)(16526019)(336012)(82740400003)(54906003)(8936002)(70586007)(70206006)(36756003)(316002)(6916009)(8676002)(186003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:10:06.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435a0385-eb5b-47ca-a1e9-08da7a193e34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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
Cc: Alexander.Deucher@amd.com, h.judt@gmx.at, Renjith.Pananchikkal@amd.com,
 Evan.Quan@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switching to the generic fb helpers caused a regression for S4, but the
workaround for this regression on S4 caused another regression for S3 on
a WX3200.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216119
Fixes: 3a4b1cc28fbd ("drm/amdgpu/display: disable prefer_shadow for generic fb helpers")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             | 3 +--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 108e8e8a1a36..576849e95296 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -496,8 +496,7 @@ static int amdgpu_vkms_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = YRES_MAX;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 9c964cd3b5d4..288fce7dc0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2796,8 +2796,7 @@ static int dce_v10_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index e0ad9f27dc3f..cbe5250b31cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2914,8 +2914,7 @@ static int dce_v11_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 77f5e998a120..b1c44fab074f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2673,8 +2673,7 @@ static int dce_v6_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_width = 16384;
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 802e5c753271..572b9fa7298a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2693,8 +2693,7 @@ static int dce_v8_0_sw_init(void *handle)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 
 	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ddcb7845f642..ee0cd2f279f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3823,8 +3823,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	adev_to_drm(adev)->mode_config.max_height = 16384;
 
 	adev_to_drm(adev)->mode_config.preferred_depth = 24;
-	/* disable prefer shadow for now due to hibernation issues */
-	adev_to_drm(adev)->mode_config.prefer_shadow = 0;
+	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
 
-- 
2.34.1

