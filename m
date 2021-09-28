Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C4E61266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0C4E61266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2AC6E8B0;
	Tue, 28 Sep 2021 16:43:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576916E8B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTQjSUrJi8rLbj2bqFuHGTHZEJpjd9Mb0/K8hlfuk6vs9ocofvVS/KgBb20EjzU8/M16Hr3VNwT8OFvn/2hUoDTjveK/ezvB9RPVKkAQwBZET79Ye3uh+Eoeam6J3V8LJLmfsgnCrJj8hCR5XjDRwH0DKIzqRsNv4rPRaSc57P3U6LjhgErNCagN9SflNMHP05jauGkFxNkJvBwosGtXyQ+lJNdQLQql07B54wYqKi2LM64IzyUi/2w7qR6d0skqUFn9It4/0RrM2SxjTG2+QSBGPh90inRBWrj2NMnpjNQuaJroX7IwhW55fx0xjVfv7EW/V33qWGi74LZyqiwVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tBtpbZVjANN/AFG1LMVj3cX4fIgQ93mld0hqVxjpL+s=;
 b=nT8noPyqOMJD6+3oqVHn++CibKNVYCScwIzSLR7RjGr0oP5mU+vFPRpp4BL1RLSy8UyT8P0QjAjFDFZLceYSj+JhuaNmF5Xk8tkdQgD+Rtx+7Iel2NK+pZGlCKh+DQ5Xt8kNBhtBs8afAn4psw2dlRBhMsvXNZesn7EVRd5lBCWQxiYr+a0w/a5312aehLXCXgwP7kmGy1W3g+kfSkLsfXeyPKvRznfYs+r/pb5s4+feanvVu/bhkjOYRoDkLCdCNzD0lbn/D3XwvioaKXRHr+LZ+Uk3vVkA8L5rCtUBXJHDzuaXYOxhtqS+CRRG6Xw46KHG4c4M8rp6WfqAlPQPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBtpbZVjANN/AFG1LMVj3cX4fIgQ93mld0hqVxjpL+s=;
 b=j5DMsS+bPQNY7oUIGXAznIkb+awwSjyhJPDSA96+KDQS7V0xks8a45yDyJjUJPzLoeVLQUOt1kx/bp9VCJGX4BMLTCsLGMSUekxtTmViAK+0TuvdRI5BfA03a1UGB8QFMzkdkS3MWipJiEQo8Q4JZwFL3FOcCRhP6up6rfMSTeg=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by MN2PR12MB3853.namprd12.prod.outlook.com (2603:10b6:208:162::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:43:34 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::44) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 09/64] drm/amdgpu/sdma5.2: convert to IP version checking
Date: Tue, 28 Sep 2021 12:41:42 -0400
Message-ID: <20210928164237.833132-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7873a0a0-60d7-4911-5c1b-08d9829f1c78
X-MS-TrafficTypeDiagnostic: MN2PR12MB3853:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38538B0D41A16A307E6E74E1F7A89@MN2PR12MB3853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKAUwVDMtElebzIRxRGxysLwOXly0h7JY84CkSskg8IezRTxBNFXwnqMbilalo2kLzayWLPRMZO8jS5x3y1uBd8ptaXJ4x8TvDuvwBTA/99sUIypFbmShe0D5c4gBJIAvhnFQ71SDjlq9boZBywzKWgy8VJ8aAg9IX0HBkTg4zmUCpnj/HQcc4pRWsHi/sQsHAp9wiS+Be8M9Cmbz24nJh5V0s2TRw0ibmUiFUxWSQngWu4/SX59QdJxJ+H38LEDiU0v3Vm9y28WdoB1DojJFBg1ydnyAyK+c6/Bw2zjGkJNLAiJNZH63Atp6ifuEu26oLA34hMvmbwANxidna2JrA28GoozCxmwkcYJhrX/p2suuchAu39eJERSRavTmmAuYV9WlnowLGdySMrDn2um4b+M1bgmTNhehhgDEgje9sl98AYQFtUnoOmvwIMEXiD/rLT9QP7Ddx3Hkm6gyirRvSAjknq1wIKPnbEfnCNhtjQcW6gJYaADQaakskXLEe6pVMPztzCmyHTr4NSgFp3vl8pH/kgCKjvI6W4Ll0vhWQrwzkMi4aQk0EvDIsuCxy1QY1gvOjJZQ4gvWj57q4D61Sj8Oup1FF7XskEtQaG/MJk4SqYeGpHEPi7hrT0iYVw5K26GqKUhKnYX4oKD4jZ1IocwZL4bnzizYqe6Wdv8wJpcu0iyqIbKE8qhepIzNL5vy/hBBalwz0A6+xbGiqXVE42W1boIGeCQgIH2K+NMwSM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(6666004)(1076003)(4326008)(8676002)(8936002)(336012)(426003)(2616005)(54906003)(316002)(36860700001)(186003)(47076005)(83380400001)(86362001)(36756003)(81166007)(2906002)(66574015)(5660300002)(70586007)(82310400003)(508600001)(70206006)(26005)(7696005)(6916009)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:33.7807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7873a0a0-60d7-4911-5c1b-08d9829f1c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3853
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

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 48 +++++++++++++-------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e4a96e7e386d..c5252f12eee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -136,23 +136,23 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
 		chip_name = "sienna_cichlid";
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(5, 2, 2):
 		chip_name = "navy_flounder";
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(5, 2, 1):
 		chip_name = "vangogh";
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(5, 2, 4):
 		chip_name = "dimgrey_cavefish";
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(5, 2, 5):
 		chip_name = "beige_goby";
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(5, 2, 3):
 		chip_name = "yellow_carp";
 		break;
 	default:
@@ -174,7 +174,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		       (void *)&adev->sdma.instance[0],
 		       sizeof(struct amdgpu_sdma_instance));
 
-	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 0)))
 		return 0;
 
 	DRM_DEBUG("psp_load == '%s'\n",
@@ -1209,17 +1209,17 @@ static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
 		adev->sdma.num_instances = 4;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
 		adev->sdma.num_instances = 2;
 		break;
-	case CHIP_VANGOGH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
 		adev->sdma.num_instances = 1;
 		break;
 	default:
@@ -1547,7 +1547,7 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 
-		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
@@ -1584,7 +1584,7 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 
-		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
+		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
@@ -1613,13 +1613,13 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
-	case CHIP_DIMGREY_CAVEFISH:
-	case CHIP_BEIGE_GOBY:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[SDMA0_HWIP]) {
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.31.1

