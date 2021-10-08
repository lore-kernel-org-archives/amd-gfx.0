Return-Path: <SRS0=CorL=O4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB60C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDFA60FF2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Oct 2021 16:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DDFA60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5856F518;
	Fri,  8 Oct 2021 16:14:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361C66F518
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Oct 2021 16:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLf6SDAKFU+y9iu5JhzZ8v+CH/tld6DHzmqfhj5Zf0dy1EQxiu3r5AutImxLoqrkbxRl6dMptXFO6UyCBmrPeynMGep4FOvauAb5D6hT5sTicOghQbYrACEEIyVsKflMxoNPvKt6m12bBSIqwA7tEWsKgJSw1oTApLalQwk1JN2cilM6sfikMTHqoEWEY0IesCCwpyA09ePDNhSc7AG3Uex76lST496S5XD71952IIBYHLAFjmhVdRNorgkUaIFwZTDsrd0Z7BgOJJxO6GCSdcRuHW9PBNGukKFp1yjSgEc2JEt8EFbTEjga2asDahvVwnWqvOab2yov06JuPRK2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2lDHQocgxwlspelANJAnyQp3JvnpElYAQHi+svhwf4=;
 b=d8fiOjg59t64RP5hTm3pMTYSpLn/abTSaqdvNjnRBEfJE93sHQhzKAoX6mcNs7hJqWNsfz08axhHG+Kuh3c3SuVa0CDZ7disZANIzE8DiZg+Fxgl7zPAODkGiNzw5G6GiTwhC60fgsD5QEiW1Xg5Q5N7FQ5d+HwOb8dFpORSj0yNB47EL92Nu0Dd6iKqW8HemjfIU5JPvUZ/XH0c7LuUhbA/oN0MQ/VKhXnAD0aNMPQSo5thivUwQNq75PXOZzC+CFYe0sf7GA+WopkxMJQtpBag2ZPtaFHoUBPMlV9LNdNtUJsNrvcFbJDA8hn8qRG/Zp2s8L7lBtzsKY70epGISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2lDHQocgxwlspelANJAnyQp3JvnpElYAQHi+svhwf4=;
 b=jIe4lH6MAhUUgJgVFC3CamdTXC2pAnPxMjM1JVBq43kTGZnno+7VHdVXkR4zFuX9i8DAgzv4B22XUoBCctE9Zr+YGoCwOtmaEF6eYLkYfYAlXK5RILkcQsbxO3F9tKkTiqZBSxgFiwahDHxp0pKg7D6PWvElBbAOTay9O4TJCtI=
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 MWHPR12MB1822.namprd12.prod.outlook.com (2603:10b6:300:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Fri, 8 Oct
 2021 16:14:20 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::53) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Fri, 8 Oct 2021 16:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 16:14:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 11:14:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 09:14:18 -0700
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 8 Oct 2021 11:14:17 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Roman Li <roman.li@amd.com>
Subject: [PATCH] drm/amd/display: Enable PSR by default on DCN3.1
Date: Fri, 8 Oct 2021 12:14:15 -0400
Message-ID: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07472e6c-4fc5-4a94-2da7-08d98a76aee1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1822:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18225B1E09A05C7F82935D47ECB29@MWHPR12MB1822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKIBYi0XrAX0awg6g1kpE0ihXdZ8KI+jn88A6jdKF03vyrz9edwtxPj4RCvnh3yo75kk6v74Uw3C9aJXrZ5wNLHtxFmeuQub+N4OlgDCE/PXQGprEmhavXmmhaJ/dZC4NdMIMLQ8zTVNVWnPa5nmU0rNfr2HcwwpT2yL4jVOYeiCssDYOEjvjQGic724WzRkmYUVQVi4P+13QI2afxm2BQesZ/oQ6xz41V0tOGjTvDUmsCtuQO0euQJjgW2TukzFNMvesjly8/cEJtHexjBfMWtrnyus5LBVCbdqHABWVZ2amyzv51FJ+5TcWdzGcekeU3wMw9tn8b4pbhOA057Xa/+EVK/cl+JEgjsql5sqyTT9rpZckb5HO22xEIy27SizP5mtq197mGjPZ1To04S8EQGqjUXR8+dej465IMueMVnh5F42IcsehEqVOslQxI5uGy8RkSa3gS7aI3o8gBVd6myRoiYQypTcHAZGKmRTciZgEpTiM5l/mcBvzLIOn9fbwBu1g9fhqqd+C6QSg0M44v0CFLusBS9G4iAcbtmttBLql09buUithuFFC4pZa9x2IrKAvbzoOQ4cW3inlizjPRFxMz1BIDYIsSJWHzui/UsF4f7uS9QuELRr2+R46RSz9HZ8VnQtGGgyAHsYMrIFPmqJYs23Lgn/m9jpvWUYfffX3TYyR5yGFxCWSihDENadO38Aunc+Zf754TyzGPXPAPHG8tlak5fLMEI5uK18aAI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(336012)(2616005)(426003)(83380400001)(6916009)(186003)(508600001)(81166007)(356005)(2906002)(1076003)(36860700001)(70206006)(8676002)(36756003)(82310400003)(47076005)(54906003)(316002)(86362001)(44832011)(26005)(5660300002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 16:14:19.3383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07472e6c-4fc5-4a94-2da7-08d98a76aee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1822
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

[Why]
New idle optimizations for DCN3.1 require PSR for optimal power savings
on panels that support it.

This was previously left disabled by default because of issues with
compositors that do not pageflip and scan out directly to the
frontbuffer.

For these compositors we now have detection methods that wait for x
number of pageflips after a full update - triggered by a buffer or
format change typically.

This may introduce bugs or new cases not tested by users so this is
only currently targeting DCN31.

[How]
Add code in DM to set PSR state by default for DCN3.1 while falling
back to the feature mask for older DCN.

Add a global debug flag that can be set to disable it for either.

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h        |  5 +++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dc595ecec595..ff545503a6ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4031,6 +4031,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	int32_t primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
+	bool psr_feature_enabled = false;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
 	/* Update the actual used number of crtc */
@@ -4113,6 +4114,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
 			      adev->ip_versions[DCE_HWIP][0]);
 	}
+
+	/* Determine whether to enable PSR support by default. */
+	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
+		switch (adev->ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			psr_feature_enabled = true;
+			break;
+		default:
+			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
+			break;
+		}
+	}
 #endif
 
 	/* loops over all connectors on the board */
@@ -4156,7 +4170,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
 			amdgpu_dm_update_connector_after_detect(aconnector);
 			register_backlight_device(dm, link);
-			if (amdgpu_dc_feature_mask & DC_PSR_MASK)
+
+			if (psr_feature_enabled)
 				amdgpu_dm_set_psr_caps(link);
 		}
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 257f280d3d53..f1a46d16f7ea 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -228,7 +228,7 @@ enum DC_FEATURE_MASK {
 	DC_FBC_MASK = (1 << 0), //0x1, disabled by default
 	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
 	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
-	DC_PSR_MASK = (1 << 3), //0x8, disabled by default
+	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
 	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
 };
 
@@ -236,7 +236,8 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PIPE_SPLIT = 0x1,
 	DC_DISABLE_STUTTER = 0x2,
 	DC_DISABLE_DSC = 0x4,
-	DC_DISABLE_CLOCK_GATING = 0x8
+	DC_DISABLE_CLOCK_GATING = 0x8,
+	DC_DISABLE_PSR = 0x10,
 };
 
 enum amd_dpm_forced_level;
-- 
2.25.1

