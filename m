Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF0260527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DF0260527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBE06EAB6;
	Tue, 21 Sep 2021 18:08:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0036EA75
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWVSADdn/cZnmx3j9FXypJxF08+vwEV+h3cw1nA6KwVKrtG8D/vA7TCXcTQKOFpuSyEcYAhcHUBZ7L59caGnj6SNsRvOmnjdC5VWAo5HDkanAt2taaeTEqcJgOX2hphvYIeN4iN5J5QKAF0JZagW5nFPRARFrN9tDOTJAWiuWhoxvB88Y9SiT6YBDjNuqfYRzVGjnJ+SRSdt8iRpUXFpt9oNFix5HNPx7xRzL0ehJ1jyBDHhwGgbEaPo7xkFsX2egCBDcj3Rz4/sWLMP+2bFUAPOHQ1fzRQuSiLTvz8o7Cwr5cbN2fQMJyz8vFm/JwdBr7eTgkYwqMspdfkNX80Y/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hvfGbLfkfjMM100RKS17znXjWN9hip41ylQx8feX8jc=;
 b=IzJdCitrUKDVIbHaAROCztotu22TqM2a52/ngn57yO6PNAfmvEosHvV1sD3SJ9rnHYsfqvdCir1ovZ+hCAf+TxHg5RQYog/ZM/8x343rCfIdXRT0uGMF884LqU8prUKzHedilj8m+Sdb1h/+IWpvk4zwex4CpCEv5PIiiOwajJb/OwjKRE04lljgv82wTQvkeMiCqUrNP0ulxeqMrWBLP4YsYipIUTJKWlXakkuZ2LnKLZvkreacrUN8CFDBD8opmgsrJVJ5+hJqP+mv7jCZpI/X3KD+AaFyKU7KQBDu7/mZlRJ4s75Hs8qW5g5wrAUv6RoSXb6qXOmWB0vyET38fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvfGbLfkfjMM100RKS17znXjWN9hip41ylQx8feX8jc=;
 b=RJQD9Lra/McOnO5Y3ZE0DDUPi48g0Gj6KjmtBj+GcFCYho3C++YkI++2cQ7VygI0Hj3rlxQ4PxPgTLLJbLkDvV0CKAZGLs6/QJv3hrL7DU9icfClME8h7Dmwfd8Nj+RBWLZWEWaVJ+ybW8o7mf3KEr8Pk208P2myw5uXHY5sXeI=
Received: from DM3PR12CA0049.namprd12.prod.outlook.com (2603:10b6:0:56::17) by
 MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:07:59 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d0) by DM3PR12CA0049.outlook.office365.com
 (2603:10b6:0:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:07:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/66] drm/amdgpu/hdp4.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:58 -0400
Message-ID: <20210921180725.1985552-40-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6cc8c6b3-92c7-4555-0ae4-08d97d2abec5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4992:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4992564BC22D0D28CF948BD1F7A19@MN2PR12MB4992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WC50PTvOFkNZ/o3eQzZ+xoLrynIe5xPF8ydWzIo648Wn4A1Vuk2Wj/VHW9Eho2C+gEYC35lQnfw3JqdMkIWqOQ7O3jFbhM22Rd5izLSVKptORSdD7sdJ49RStMCCzoJie/VLdSE8oO+ZTf803FeLCEKoWFIp2GQj0Od5OhYBngqWN++C+RkSRoX6IJAWQuvQ1tVE682fABbUi549m2TDSA4yM9mxT14UHsYgjgWV9Jdvlz8qi/B5yteVM7rjjJvs132HrY6IGoOYZLX9Y1j3xLRmRkAG05qs/CfrZCaDH138+SDWEzcxcwHrCW6RFX+z11+iYz04qPTTZMGu3ZJieCHpCvfworCR/mVLJ2X5oMe64iIoadafGgbCoStLaZVDrhL7YoeY5H8wQMdDEbU0aQjnJ2wu1XNtRtehTQtB493nk6VpifYGy+2vyjQOa7JQTmE2rarecdAPGPqJcDA2HlGDyByuET9kl8I9MUd8RNXcJz/xX/dR2UrmLi03ns/pwkqh/xIuAMF8nAPoBdK1DqL2pD5TiAf8DUk4fG6NSzW+JyB3QIN6gS64Fc7Gigf/n9skRuS7/vmlZqG430lsFdfjbayTM+lW9JsUOmYv0k9MZnYn61+9KcLsIjCpLClA+QTeli9Tnaon2vniIhf/SwrGIqgwrmYVkiN94ZlkjUngrvY6889ye9CIk05waFikPHc2NqnDsQrlODEjAMVy3ZBDN6PQYmTAKKENnOnNQVM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(316002)(86362001)(47076005)(82310400003)(36860700001)(186003)(6916009)(16526019)(8936002)(8676002)(1076003)(2616005)(26005)(508600001)(81166007)(70586007)(2906002)(5660300002)(356005)(7696005)(336012)(83380400001)(70206006)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:59.1449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc8c6b3-92c7-4555-0ae4-08d97d2abec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
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
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 74b90cc2bf48..88938115557b 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -49,7 +49,7 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
-	if (adev->asic_type == CHIP_ALDEBARAN)
+	if (adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 4, 0))
 		return;
 
 	if (!ring || !ring->funcs->emit_wreg)
@@ -79,7 +79,7 @@ static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
 		return;
 
-	if (adev->asic_type >= CHIP_ALDEBARAN)
+	if (adev->ip_versions[HDP_HWIP] >= IP_VERSION(4, 4, 0))
 		WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);
 	else
 		/*read back hdp ras counter to reset it to 0 */
@@ -91,9 +91,10 @@ static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
 {
 	uint32_t def, data;
 
-	if (adev->asic_type == CHIP_VEGA10 ||
-	    adev->asic_type == CHIP_VEGA12 ||
-	    adev->asic_type == CHIP_RAVEN) {
+	if (adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 0, 0) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 0, 1) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 1, 1) ||
+	    adev->ip_versions[HDP_HWIP] == IP_VERSION(4, 1, 0)) {
 		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
@@ -135,8 +136,8 @@ static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
 
 static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[HDP_HWIP]) {
+	case IP_VERSION(4, 2, 1):
 		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
 		break;
 	default:
-- 
2.31.1

