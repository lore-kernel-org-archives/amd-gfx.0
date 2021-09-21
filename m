Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63DAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714CA60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 714CA60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3196EA89;
	Tue, 21 Sep 2021 18:07:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106C16EA3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWUoOk6SqaHp7ochAzpLJEYRnw8eF5eOPoX5+bdfhTGgrE1sCmWOCEebEE35BqSCFk26mDU3jn3zHZjIAQescf7fAhUWYw1QDgrWQ3uanjPC7WO88mPICKZOiPqf8+QbbjP6IhETUP7/C5C//JMw/tF1ovhiXabpinj4VD7wRq7TZp6BW+FhbGu+g6hxdXm6H9GbCV89v1CjQ3yhoMLmslZZTLSC37xVHNoVnyUb/t5vj9pjZRyQWWN7KFUjD5JWwRGvB/tsaDnVR2H9+8IVS+/uO5984za7xsKvyDFACdMLDFR7awZ4IPt4IScd7wpyeRFKQQ0dqqqwMYbaOFSC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=B8jAFugh0c5GpkwKm5S9gyMEXgWJE7kdHLYafYhyfJE=;
 b=n2O8yp9V9Yt1n+lKBpZdkhwLeiDVwkmb94egPa9HjDOXPRk9qDcfPrYhCVePnX4kDTQ+1e19yzeSQdSR0+62b1mvfsDA3yhyb9FJpg0zPdP07RwtpDgIXhDRkvxD8sUM0i1yW804tH7EEA0HLp99fpKYFTmI9yng99wa9M828NA7EHJKzZ7DCNyU43wCT7uqr/agP3IEIUIUNqL4+euphpm2KUfcrJJf8JJlHvYJDTud2/h03/c56rScpDs7pLSK+VRkeJxPB6zHKrGDurekYYLETGgmCtyXBHBoFECEJUpcHMvLJuVyn8vLzbFLULOPWczM1qJvavNI+yTgQstbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8jAFugh0c5GpkwKm5S9gyMEXgWJE7kdHLYafYhyfJE=;
 b=kMDavUgnvRP4NaTVa6zIdvhVrfHth+7SlA3ao4Rsm9RJAnEwjPWP4WfuukeDetEdA6NInsRdYrXlK+LGm729yozCf/nWgkZGSYYho4wcn0wjokejgzuidbhk+K3ZwSXYxYr16qIqc+9dKGAoj2T60UHz2Xd7mvOnhX95vXyralg=
Received: from DM5PR11CA0015.namprd11.prod.outlook.com (2603:10b6:3:115::25)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 18:07:50 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::4d) by DM5PR11CA0015.outlook.office365.com
 (2603:10b6:3:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/66] drm/amdgpu/mmhub2.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:36 -0400
Message-ID: <20210921180725.1985552-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbe3ac20-f13f-4fea-9f51-08d97d2ab988
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:
X-Microsoft-Antispam-PRVS: <MN2PR12MB483056884C577DA71A0E113BF7A19@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaJTh94eY7dPvbskB9oqT3qTzBl+CNs6WIC2KC9W7jAKLSsUMQU8zaGkJyh+ZXSCiFXNrDbAooopPlikkqmXf4hKZ5xntvF1IsdE5exnqGkj90aM/GEQ59zcQKewypLDz3vHzi1E0RhXRh8+Fw3WwLDa9HDNnFOnnytB0DhJ0IW8mCSqMra+amLDnGmZMlPZ3+kk7wW3RIE9LE8WWOGSp/p9K8m8SndPPUQ8PSnmGcgyAzdCEEepcx1estJlpPTvIA8GOi8tstoNzjXwNtCUK2n6mNZnUyU2JmvH5wPpatbPsEQ1D79Mvqtdb+RA7njN9gwINDprnr4pTmUVW5OrEKhOwMeSIIq48/JhfFy1bh115aWuuc+W/Cxc9KCbLUOKRz8NVFXZLgWRIGbhMXOwrctNPN644KtKjNJCZz2xPZ+jISEumf1NK0k25xcup8xr+10bBqBK8AyH1L0/wSyyYwLxK38rTpMoI2eV/S+wFP6sYzTLsWHztLZT7YizMNW/DHu4U9V8v2eb26dvh7kXVVq/ZZW9dN/CRhwpxH/pl5X7FJU0uzHqKqjYcFGxmw80CTDR618g7n8rQZhV6BoXsVs8Tye4WgDkVgwYRSYvBO+D09+92OUd2R/oo4miL4OabAyaEKhFoS+GfpC3exnBvL6WQWtpCAlwRT9O7y2TYchryrBfs/t0mKfC/Fj1XntLp2FYfNH/ZeXzXoq9uIlJeY0OAJ7drmrAPUTkUBk1sb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(426003)(83380400001)(5660300002)(8936002)(70586007)(47076005)(4326008)(316002)(81166007)(186003)(86362001)(2906002)(508600001)(82310400003)(26005)(2616005)(6916009)(356005)(36860700001)(16526019)(7696005)(70206006)(8676002)(1076003)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:50.3673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe3ac20-f13f-4fea-9f51-08d97d2ab988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
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
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 73 +++++++++++--------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 7ded6b2f058e..e0cb919b4814 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -153,18 +153,16 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-	case CHIP_NAVI12:
-	case CHIP_NAVI14:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
 		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
 		break;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
 		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(2, 1, 2):
 		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
 		break;
 	default:
@@ -571,11 +569,10 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
 		return;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
@@ -606,11 +603,10 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 			  DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
 	}
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		if (def != data)
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 		if (def1 != data1)
@@ -633,11 +629,10 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 	if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
 		return;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		break;
 	default:
@@ -651,11 +646,10 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
 
 	if (def != data) {
-		switch (adev->asic_type) {
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
+		switch (adev->ip_versions[MMHUB_HWIP]) {
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(2, 1, 1):
+		case IP_VERSION(2, 1, 2):
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 			break;
 		default:
@@ -671,14 +665,12 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
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
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 0, 0):
+	case IP_VERSION(2, 0, 2):
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
@@ -698,11 +690,10 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 1, 2):
 		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
-- 
2.31.1

