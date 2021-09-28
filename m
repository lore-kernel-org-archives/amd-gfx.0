Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051BEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F686101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F686101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7164C6E8CD;
	Tue, 28 Sep 2021 16:44:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B276E8CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6lJIlpTILWWFb94VPmg5wh4iYx1/m/KXaxKbrQqiUl1WnZpW/j3jvWFBOjYouAFCI1TXxe6Ayp+TaNhGhF11U3sfXKEMb9BMynKxQ4WmuSAU3cl/kCAKWREZ7aigXMo1YMmVcylIggdgCymiLLpY5wxUxKKgwwwER8kFaTZRb1Yp21gL+GQjs80HjEEisJrRoYEiIjQ243xV+OsNNSkl2TGhxEMKFMowPZJ46oPO1yIQqHKZqCUmQXJESntDEg6kioOJb3FyD9biY8mLVz/CXuGFyTuaHAmYyEHPLkxIPpTho+FZD7pxOGkb4UCqaYuXteI9W/qpi15MuDUuEk4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1P8kd+0IHDbuRo7cGOewPBF5EjxJI0NG4HtF+KVZD8A=;
 b=U0PClwymqqMKCgLlJhJ0NyBnNOzjuSNeQtoEMuaVjrnDWes1QXchXYPzIAVcXFANiCRxdp/LpkXkWZmWEAc0xB8D6JCyXBByEvqyDcgI52ExPYzLTD4RZBSXQUPSxRiIgmsrSJ+toczKTa5eaEQrreGtYRVXqZsr2xo1EPCSRHClX6CidZcZDInh10EhlTqkPWxCs+lE5vq4BcOvC38ndcYMRYV15IrwQqqcRumRhRyiGTLHfHTQue482a/5Lg0L/9uvT3yptckEkU8uierJ/eAPLYTyK6A8yXhnLgKTfZ7vlbhxskJex0mf8wWfiIZgrL+/F+4+KBypMCEtGxtaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P8kd+0IHDbuRo7cGOewPBF5EjxJI0NG4HtF+KVZD8A=;
 b=wnmy8oG9nqYNoT8W4dL+hd+D3Nkg2+r+oeqGwNyuNcE1x2r4yckq47DNIMxNst14+xbEBofBqJ/yu6Cn6FN85W8hR+iTou2y7CWkwjgFb9sr4uT+Xf1TgIQnC4CZup2W5XXzd12RNy9YWrd6AmLCBBV0YiP8ky3/pfgYiMNb8hI=
Received: from DM6PR11CA0058.namprd11.prod.outlook.com (2603:10b6:5:14c::35)
 by BN6PR12MB1492.namprd12.prod.outlook.com (2603:10b6:405:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:44:38 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::cf) by DM6PR11CA0058.outlook.office365.com
 (2603:10b6:5:14c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:44:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/64] drm/amdgpu/nv: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:00 -0400
Message-ID: <20210928164237.833132-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db4a34f9-0c07-40cd-0fa0-08d9829f4299
X-MS-TrafficTypeDiagnostic: BN6PR12MB1492:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14927A2136E1C449BD612F10F7A89@BN6PR12MB1492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QjVZA7ikUFJLf5XtD+1e1cOvxEVi3CknrTzrpyWFPQxrpfZqfTEKA+L0yNY6ex2b6GVLWRwhv0zMWs5f7zRZ6oSn0YM/CT54yPIDn21s8esTPXCYxLEMMqUNuWLHIK8COeBuFr0tlcYlLckoXjcmiMaeQVLAXb27YrKgJDpNXmPy8HlP2+SDFJXsHGJ5U71ibRWwEqpLqoHP2Q4ijLFMF6rLsAzYklza29k5ET6MaiCBQSf2He772chBQh1ksUeR7MfHOVlNOB1N9QPUIYBTxByL4o645iLL6bNCBuvColgvneWGOnEill8/PyEyx73d3NV9QYGh1MSEQW/c6H0pRKuKUHlcOWCYG9+R3mSRWV2ciNSCiMCgHoP47JUrt0ctnyCegscnHrFEBpHYZwEVE3bnjr19LzvoPE0/fFEVWxicrjkiqB/KXJoKu/PgBeSk6Y+r48Bgrb0RMFl35fDl5HkJFKpxFRGhY+yELxYpZ1K2wt4UB9tgGxAN5/Ctwk7JVyzvWCCeq2VmOKiJQpgKnj2V6V7s3Vc3E2HftVDw/QziBDaP0FvUTxJjy+B51SYnRCP4nNR/OZpNsDTRyeuhAbX5WO7puwO6rbES1VMqpdXpMc752xie2zZ4I/WM+sJF3jghusZAd6n2tArels75DFHaZIfQDDGnrwsGj2FCgFCchwTd2MU5x8hTfKqDF5hAhfjW4GSS9WroKj92xL7RoUyKqqZksqB1UIfcmGssw8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(6916009)(47076005)(82310400003)(1076003)(6666004)(7696005)(36756003)(508600001)(81166007)(336012)(356005)(36860700001)(186003)(4326008)(8676002)(316002)(2906002)(8936002)(70586007)(426003)(70206006)(83380400001)(86362001)(2616005)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:44:37.7594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4a34f9-0c07-40cd-0fa0-08d9829f4299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 75 +++++++++++++++++----------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 0dc390a7509f..57be517d70bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -180,8 +180,8 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				 const struct amdgpu_video_codecs **codecs)
 {
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[UVD_HWIP]) {
+	case IP_VERSION(3, 0, 0):
 		if (amdgpu_sriov_vf(adev)) {
 			if (encode)
 				*codecs = &sriov_sc_video_codecs_encode;
@@ -194,29 +194,27 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 				*codecs = &sc_video_codecs_decode;
 		}
 		return 0;
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_VANGOGH:
+	case IP_VERSION(3, 0, 16):
+	case IP_VERSION(3, 0, 2):
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
 			*codecs = &sc_video_codecs_decode;
 		return 0;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(3, 1, 1):
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
 			*codecs = &yc_video_codecs_decode;
 		return 0;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(3, 0, 33):
 		if (encode)
 			*codecs = &bg_video_codecs_encode;
 		else
 			*codecs = &bg_video_codecs_decode;
 		return 0;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
 		if (encode)
 			*codecs = &nv_video_codecs_encode;
 		else
@@ -511,14 +509,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MP1_HWIP]) {
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		return AMD_RESET_METHOD_MODE2;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
 		return AMD_RESET_METHOD_MODE1;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
@@ -1042,8 +1041,11 @@ static int nv_common_early_init(void *handle)
 
 	adev->rev_id = nv_get_rev_id(adev);
 	adev->external_rev_id = 0xff;
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	/* TODO: split the GC and PG flags based on the relevant IP version for which
+	 * they are relevant.
+	 */
+	switch (adev->ip_versions[GC_HWIP]) {
+	case IP_VERSION(10, 1, 10):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_IH_CG |
@@ -1065,7 +1067,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_ATHUB;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(10, 1, 1):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_IH_CG |
@@ -1086,7 +1088,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 20;
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(10, 1, 2):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
 			AMD_CG_SUPPORT_GFX_CGCG |
@@ -1115,7 +1117,7 @@ static int nv_common_early_init(void *handle)
 			adev->rev_id = 0;
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(10, 3, 0):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
@@ -1139,7 +1141,7 @@ static int nv_common_early_init(void *handle)
 		}
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(10, 3, 2):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
@@ -1158,8 +1160,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
-
-	case CHIP_VANGOGH:
+	case IP_VERSION(10, 3, 1):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
@@ -1182,7 +1183,7 @@ static int nv_common_early_init(void *handle)
 		if (adev->apu_flags & AMD_APU_IS_VANGOGH)
 			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(10, 3, 4):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
@@ -1201,7 +1202,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(10, 3, 5):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
@@ -1218,7 +1219,7 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(10, 3, 3):
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
 			AMD_CG_SUPPORT_GFX_CGCG |
@@ -1247,7 +1248,7 @@ static int nv_common_early_init(void *handle)
 		else
 			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-	case CHIP_CYAN_SKILLFISH:
+	case IP_VERSION(10, 1, 3):
 		adev->cg_flags = 0;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x82;
@@ -1374,14 +1375,14 @@ static int nv_common_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[NBIO_HWIP]) {
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 3, 1):
+	case IP_VERSION(2, 3, 2):
+	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
+	case IP_VERSION(3, 3, 2):
+	case IP_VERSION(3, 3, 3):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.31.1

