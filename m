Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFBAC19F2D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 04:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721ABA111B;
	Thu, 11 Aug 2022 04:59:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3A8A0E21
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 04:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsyeP4DNt5UMLz1lXJjS0DI/S+5wrExhDEVoWYDTPRq8ijbPctkSV8PCB3NY9OUInotL3dK1Okh07FwIpZfBcTzizkFBYPNDeLm58zCuRxRe2f/RrO9AbUKJrpKEgExqmJHKw7ASAGA+QuX6yFMHSSAxpRYBux/S9CtA1imIXKcwuYJA6bLghtZVsR2aTYyAzfWfUFc5NjSjyIYWcnab1yG2Jo/UShJ6cwLMr4Gz+wb4M0XOL93HMMlTIIFTkXqg6vczfZgDBFQwGr4Oi7k6LGLozv28LXAUpz6APYp4uIzbrz3fXyt9Do51nkErB32d6aS/7fp+L9/mstyGycAnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evkMuligtSiDILAR+aWdDYBfEiUkAxwT0oBqILXiAA8=;
 b=JuNB1iFOUAT7L2al3RmoZ+Qy0lR1LrKPHVxU+74zp6W9DcuEH5tOKiCIv8R9Nuvq+3MHmUd6x2+WvT/0kBR5HwMdlFqbqpvXJ9WeLZkO8pIdb0t1hFjsEpqgeYN42vFkaCE1dzOf/xNTyG8WHhqlfYiUXfFkMrpHW71vykjKCMzyTRAjjXycsnGXeQKXuJhD+Na3CmKNao8g2MTsAhkDSg0oDp8qnataD/1KJBfVF9GdTHJkbODS0r1Hs2LrQsFPoI5etAQpnZSmQfxLd/KZDv8qAfZFeBLTtMTAeTiC6p1TKx2OwO2H4n64LttBqG84tKrbXv2n3lvxnOEGHw0Chg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evkMuligtSiDILAR+aWdDYBfEiUkAxwT0oBqILXiAA8=;
 b=e4XXElACmnjvesD8BApEbxvgkAslvIa8BrJsx0mfXrGShSqW2wInmWn+h+k0z9feA2XVQhymTFC6C66Oj8NBVREadr40ikgD+rCb6tfEa29OPLYBTobOD65rMljFRc5MGSv2rG05a39twN6rwyJPNgka28vU7TY4Edo2ZfW4nNk=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 04:58:44 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::2a) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Thu, 11 Aug 2022 04:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 04:58:44 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 23:58:39 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: add MMHUB IP v3.0.1 Clock Gating support
Date: Thu, 11 Aug 2022 12:57:59 +0800
Message-ID: <20220811045804.3750344-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811045804.3750344-1-tim.huang@amd.com>
References: <20220811045804.3750344-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a270cd-26b9-4c48-aee2-08da7b562ae6
X-MS-TrafficTypeDiagnostic: SA1PR12MB6970:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNAGcShEva8B5YEaEciAJVfT6XFhkFIa1A1VZ3ml3BUokFI4tJaDxOZqKOn7wU7mLv86jqc7IGGBislEl7NvArxKu/Ktu7wwKsFnlHczaJsnGiWXhCPYgt28CqD6/yBd8fd5fYJ+2gRNCrYyoogwlxMoqp+fK/sxM/8ppwK0LLxlYYwdyuWLEa+xwdOSkyfTn7wl99j72j7NNTQBDIJ82mVg4yu8AP3IkkCxEIrxsCroVX53H/3s45MODAKRTjipKykrCICuz8rkuMhWWOPRwf5vm1nG2nz5tTCvd9vPRVRYQt298YT0j+Zj6/VGuNjczs7+zOFllb4MGqk/FdvMsrw0gG1Fgi0iTttfoESmHZfQO5tPcpiJLGy9pev0FQYfuQw9SSnnNTRA1o018q/xpEGV66iVB8C58GINKr2yyUrFAAzVLzfz3PD70EQWR3DF7N3SWmhoyZZY1px0hdFOIwv7lJxmLiD8MbTFBXScMgt7rqXnXgRqsaMTLYYL6ynIpv2AhlGFV5Vc9HUDpzwz7xIxESPWizhc7x8IB6l+S+TsEdCYV+xvhfJ2VSHQ2QFU9dRGBDlI4Vw5oEmxI2aMU+m17mYOIMEIGFEsK2snO8Cwul0EZeBrXuW9VixTBF2FT+rAaSqhYtiIl6FXlKm7nZntIvcv8dgga7NY6I1VrhOH2n2u0Z9/6OAo45d0IRnccEZPVjLTxFO7GoKBf8MC5aDmSlazbUDKbslvndJXsmrF/atSz4XZ/H5wzWl/xYFnClQ5V9rEKwII77/gkZWo0vpaQlu/kwSldjnEtO8ebrRBbUDR7Q/S1W8twYAve1w3Z5TdscUylWtO8lRWyE5ZlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(82740400003)(83380400001)(4326008)(8676002)(70206006)(70586007)(40460700003)(426003)(47076005)(81166007)(44832011)(54906003)(316002)(6916009)(36756003)(16526019)(8936002)(5660300002)(186003)(478600001)(26005)(356005)(1076003)(336012)(86362001)(82310400005)(40480700001)(36860700001)(6666004)(7696005)(2616005)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 04:58:44.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a270cd-26b9-4c48-aee2-08da7b562ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add set/get_clockgating for MMHUB IP v3.0.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 42 +++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index cac72ced94c8..e8058edc1d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -518,18 +518,41 @@ static u64 mmhub_v3_0_1_get_mc_fb_offset(struct amdgpu_device *adev)
 static void mmhub_v3_0_1_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 							  bool enable)
 {
-	//TODO
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
 }
 
 static void mmhub_v3_0_1_update_medium_grain_light_sleep(struct amdgpu_device *adev,
 							 bool enable)
 {
-	//TODO
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	if (enable)
+		data |= MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+	else
+		data &= ~MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG, data);
 }
 
 static int mmhub_v3_0_1_set_clockgating(struct amdgpu_device *adev,
 					enum amd_clockgating_state state)
 {
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	mmhub_v3_0_1_update_medium_grain_clock_gating(adev,
 			state == AMD_CG_STATE_GATE);
 	mmhub_v3_0_1_update_medium_grain_light_sleep(adev,
@@ -539,7 +562,20 @@ static int mmhub_v3_0_1_set_clockgating(struct amdgpu_device *adev,
 
 static void mmhub_v3_0_1_get_clockgating(struct amdgpu_device *adev, u64 *flags)
 {
-	//TODO
+	int data;
+
+	if (amdgpu_sriov_vf(adev))
+		*flags = 0;
+
+	data = RREG32_SOC15(MMHUB, 0, regMM_ATC_L2_MISC_CG);
+
+	/* AMD_CG_SUPPORT_MC_MGCG */
+	if (data & MM_ATC_L2_MISC_CG__ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_MGCG;
+
+	/* AMD_CG_SUPPORT_MC_LS */
+	if (data & MM_ATC_L2_MISC_CG__MEM_LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_MC_LS;
 }
 
 const struct amdgpu_mmhub_funcs mmhub_v3_0_1_funcs = {
-- 
2.25.1

