Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADBDC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 10:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBF9710F61F;
	Mon,  6 Jun 2022 10:41:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1015A10F61F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 10:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFSJW4lO15A5GKPsR2FwsMcG98Hi/Fb7JHc9Y6tayxAiKlMejDlfKOpX2w6iQJZV+ybvMT3ArCPpKD9IT1to2rTB501oXu8acZW6BCsyDFdo393mlBE38sF1U0MqoqedeXeYqcH8xqgNpqL0dqNz5B+7I5E/1pxN0xSwXUF5trwv8Fj7WK2O2KRj8Z57puvV80ZMrqNBfOPfToQm4Wa2eUBUaiakGFRKnvAqZ21jQmULEoDXjUf9do5rsVyEyxxwkvuKklIPd/gmPMiaGrt0aYS6W014eVlsuI6WW5oI0uJzzt8rPD01ePqKikpp/z3e5i+vvR/9JOHzHTzFELxTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iWRUhjhlmwOEZcEwmJOE7SVJxCxbyFJwjnmOi/dRKY=;
 b=Y5J04xFj8N+N8wFnuYIYt14hUK4FRVLOugoZ4ywt5WJn8TjWfKwgW9U0iIp/y0TXZrFC++vIvK7CVQvQgCYzWpI9EzSGyd6kxExJhPGUabZ0TPlszGN7J0AT+W30rYg1HpYpV3iCsXABGphxFZdPytDw64V1BhJznVGWAn2htbTwdELAe5Ttg/ztVJK7AfTzxPv7Z7lStF04G74gGUF8QSdPpIzzyt3X2cAOopCpO4c6q5lIuact8N0TgW9dGBziYvtaIKimDix5R6DmIOdcvTNp6H7e+MVDMAQWTo5QJN6K16b4A7x+gzf7iKsN11Aiyo5DhjBX76tFG8zF/3dC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iWRUhjhlmwOEZcEwmJOE7SVJxCxbyFJwjnmOi/dRKY=;
 b=MaCrqtPuT8D+HI5aU61Tt9g0ZHne/iTVCuwLi4Zx4bT2rDS+SFWwFi0n98hqrJw17aecuxOC6KzWydLmZHHw3MiWaMWYw8ww7X66YhejzQfEtjyGYp21PqlV42K1JR4Niijpw0CUn4whdhhOGoFs7+DSSjP/QGgpBrXCXucx3wY=
Received: from DM5PR10CA0019.namprd10.prod.outlook.com (2603:10b6:4:2::29) by
 DM6PR12MB3449.namprd12.prod.outlook.com (2603:10b6:5:3b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 10:41:38 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::b6) by DM5PR10CA0019.outlook.office365.com
 (2603:10b6:4:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Mon, 6 Jun 2022 10:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 10:41:38 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 05:41:36 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Date: Mon, 6 Jun 2022 18:40:07 +0800
Message-ID: <20220606104007.3801900-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11d48e25-02b2-4722-3640-08da47a922ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB3449:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34493E6BE8604ACCCA21F8C3C1A29@DM6PR12MB3449.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4JzujE2bZtU7j984f2Ym19vQnCCQ2tqk5/KzQVtfRIqeqn1qhPLFFN/ySpXYEToJFW1GfUsXQXCx5xqZlimum5hJKUN5Z8L6J7E8E14TkgOwNFf2C/34ej8uzhukVuawSKwP0Ach1DA8YIig3c3wSpliH1adXwyeB48UCbkvg2+ehctrHFNIl0lazwLAan94tK4W364ynHCoZlvdjKvcGUJyK6Lw6cS55FkmLhshv8i6AzoG/g3y9o7tQ+2ZzihujfnO0OiyST/U5fNJTBOhIgHRAVbY9MCregNGQI+CIEcCLXBf8xs0epDve42irQp4CwFQH8XwuJULrDumRt8IWDIwUyYvzLlippBzSiSTJ6C5tDK6vTE3ieXGi2JWkXclbeaITqMuMk877lcY3bBg9mNixAZDfXYLAdL//C17Go84Hn7mm0nDGq3IqJX6HI8ZGceBpzq1aAmbS4CQcpet+v/IlVRBG2OyJsPZeWIupZNAwQwf19qe/891xn/Ky8mUyWnrV+JP7Sd8dyWfT1oIYoRBLk4ivHXukcAuyHcEEZ2j3ncGdj1P8QOPea9tM1kR4E5c6ajgkyUAe/frzya8d0Nzns0T+oloy4RdEcKgagqwMiqknUjJoFs81kPm1gRWfam1pQldRv04GwkZXWXm7LbK2bFuF9VnNAiwxw+IZOuwhmGjgk45rT2Yxrq/cRdhlFblQO8HecLP3bx819VDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(316002)(186003)(426003)(508600001)(6916009)(2906002)(54906003)(356005)(82310400005)(70586007)(70206006)(40460700003)(36860700001)(86362001)(81166007)(4326008)(8676002)(1076003)(26005)(36756003)(47076005)(8936002)(5660300002)(83380400001)(16526019)(2616005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 10:41:38.2074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d48e25-02b2-4722-3640-08da47a922ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3449
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

invalid/prime icahce operation takes effect on both pipes cuconrrently,
therefore CP_MES_IC_BASE_LO/HI and CP_MES_MDBASE_LO/HI have to be both
set before prime icache. Otherwise MES hardware gets garbage data in
above regsters and causes page fault

[  470.873200] amdgpu 0000:33:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:217 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  470.873222] amdgpu 0000:33:00.0: amdgpu:   in page starting at address 0x000092cb89b00000 from client 10
[  470.873234] amdgpu 0000:33:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000BB3
[  470.873242] amdgpu 0000:33:00.0: amdgpu:      Faulty UTCL2 client ID: CPC (0x5)
[  470.873247] amdgpu 0000:33:00.0: amdgpu:      MORE_FAULTS: 0x1
[  470.873251] amdgpu 0000:33:00.0: amdgpu:      WALKER_ERROR: 0x1
[  470.873256] amdgpu 0000:33:00.0: amdgpu:      PERMISSION_FAULTS: 0xb
[  470.873260] amdgpu 0000:33:00.0: amdgpu:      MAPPING_ERROR: 0x1
[  470.873264] amdgpu 0000:33:00.0: amdgpu:      RW: 0x0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index fcf51947bb18..9741b7ff4224 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -541,7 +541,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev, bool enable)
 
 /* This function is for backdoor MES firmware */
 static int mes_v11_0_load_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
+				    enum admgpu_mes_pipe pipe, bool prime_icache)
 {
 	int r;
 	uint32_t data;
@@ -593,16 +593,18 @@ static int mes_v11_0_load_microcode(struct amdgpu_device *adev,
 	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
 	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
 
-	/* invalidate ICACHE */
-	data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
-	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
-
-	/* prime the ICACHE. */
-	data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	if (prime_icache) {
+		/* invalidate ICACHE */
+		data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+
+		/* prime the ICACHE. */
+		data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	}
 
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -1044,17 +1046,19 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);
+
+		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
 		if (r) {
 			DRM_ERROR("failed to load MES kiq fw, r=%d\n", r);
 			return r;
 		}
 
-		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE);
+		r = mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
 		if (r) {
 			DRM_ERROR("failed to load MES fw, r=%d\n", r);
 			return r;
 		}
+
 	}
 
 	mes_v11_0_enable(adev, true);
@@ -1086,7 +1090,7 @@ static int mes_v11_0_hw_init(void *handle)
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			r = mes_v11_0_load_microcode(adev,
-					     AMDGPU_MES_SCHED_PIPE);
+					     AMDGPU_MES_SCHED_PIPE, true);
 			if (r) {
 				DRM_ERROR("failed to MES fw, r=%d\n", r);
 				return r;
-- 
2.35.1

