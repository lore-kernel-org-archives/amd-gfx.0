Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8FC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 02:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9BE8E47C;
	Tue, 12 Jul 2022 02:55:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4AF8E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 02:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfWq5WpMuHA50MZwSafazQyT8uZ43FTDxZwTeO7VoTsKQu3PLBlSOZ5wSl2XxuofIWnLLUI+hMoaCE6DMTo8TZcY6nayNNgUVBl1juCahW/Vk4YrsJjQ4s+1EFTh+2zbPvm1hFTKz20mKZC1wkO8wRjoS7/QqTUcfiwUS7by/5kbgk5lpG0PEhxye+l+/oVBopBr8sAYK47JXrNEGz+cx242nv5YF8zJqdJ/xPxDLUdAB/MLs2z0fgScvkfYAA3uVVqQJbmZVIc15yXv1pq7Ag9o0Z3SMGzfljI4ZbCZ3w8HFVHq8twPihPz23aE4v52y1vpRChpkuo19q2iSNzEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QJtkTAUCsULOkK5DVEAGVZ3fcbAXtK/+0gXzGSU2WA=;
 b=Q1JqfItA/NVdBFOmIc82Mg+u4QgN5S6lD3W3rB8h317nDxiOl2UGRxf33/+offONglzcipirksjwwbKpHI7tJ3mC3wtSdB8g6EAvaf/zNlx4w/lGwAIH4S39Zgd+Y5gsTd1BY9i8g+1NetHchqZSAB8nzobTiJjqiC2ce/g8atuemZUi+mWSC2lH3PdtXnWXO7r1Awr5BBVCGV3TiLgypIVf+QYJRwwhpB4QhY0xcoyib8eGqiuIfmnlUVk91zJZhmyocdwu6KbZem9lcnf2wKRc+g7QTou1rvsVwyh7+l5yzBkq4EXL+5i0cHWkbfkpdp4wxFzgT91LGVVscneOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QJtkTAUCsULOkK5DVEAGVZ3fcbAXtK/+0gXzGSU2WA=;
 b=L0GxW62qzJlKr5FPAt4fFOzS3KVXdHupCWFEKz0u5ouVDS2ofkVNjXsH7nKJK/isnOIJwXxGtGzs6j69mQ15wXddWbh+A+3pA9f0OzReiDB1LD1zwVOd+ioUBXbBY7JrLj3BxdobADwmkHMrPZwCsoQk67GACGNuHU8IZXzAa+Y=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 02:55:24 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::96) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Tue, 12 Jul 2022 02:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 02:55:24 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 21:55:21 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu/mes11: initialize aggregated doorbell
Date: Tue, 12 Jul 2022 10:54:58 +0800
Message-ID: <20220712025501.2083086-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712025501.2083086-1-Jack.Xiao@amd.com>
References: <20220712025501.2083086-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21a09c1d-10c5-4654-4101-08da63b1f7b1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9Edl/ZJHn4+rUs/m9sIGmKihSi/lZPRF6LoEeBfjY7BHNbf86vUa970HVBzmQVOz9orE76QOaMcH3hdfzju9C+va7A8hEJATKq+RPTUYAllkdLzxK4x8xr44LG/ICw6o8MYWrU2LWJsIG5HkrThUjnpFFaexwIa/bEF/iaZ99pNZTLPwo71vFmVTx2rm0llqCabCJX2v+t8ol90xFRDFxykAKAYYL3BBomQ+Kc36to+zcggvN1GVfyvDOdTJoTYOfEqdfM9uYVCJi0BbQ0uZn39bhJCjX8AvAMPK900bhnuNitTy1FK6Tn5RC1M8uHtqa+gnuY5hJdGwr8awx6HnyiyXFqVqqGbknErTpbDQMAEjUfabg9Q0IDL1uMrr5jP7e93aFPcMz+jSJsEt6xgDefOm4gBD3WzEqzLwlp7nzIcPcIEDwVymikDOXqrpIZSVE/2OPImCMgrmiRKDw4RYNPFOElko27feRKLE28qG7uKasSTgJLPmNs7vcnWA/TPrlG1nYlpSjS2hSik55PaB8byJ1kgqeMD1/PAJXFX4MX5xwUMLocWXpS6sUduLZ/oUsRXsZkcxTOpOjZYQZmu2ngQUPZqPdH3qnBzygiYt7ZDZh2ms7aPz+6noccPgbCQd/l36YCJVSkoce8iJaVIGTlO0kd4svxsyvwunsrEVCnKNt/8nGs1noN5fBFsQkIuMcSs/tTqEbmaE1X72IdYLt+ZQsre8DMNFkwJCpbQ5EA1otePNGUubMlv2D3UWTF9OipuN0MNGdgDBEpyEZifP/5Q7qx9fmszk0LV6oTYWIal+5uMiihfy6lOPN27MOybBF2nw/B6nEKAAR8SWnAafXhiSe2B55LeRKHsT8EK47c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(36756003)(36860700001)(316002)(40460700003)(478600001)(5660300002)(2906002)(41300700001)(81166007)(8936002)(83380400001)(186003)(6666004)(426003)(40480700001)(1076003)(16526019)(356005)(47076005)(7696005)(86362001)(6916009)(82740400003)(2616005)(8676002)(4326008)(26005)(70586007)(82310400005)(336012)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 02:55:24.1671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a09c1d-10c5-4654-4101-08da63b1f7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate and enable aggregated doorbell.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 58 +++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8dbce32fd9cf..777f9268d92d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -348,7 +348,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 
 	for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
 		mes_set_hw_res_pkt.aggregated_doorbells[i] =
-			mes->agreegated_doorbells[i];
+			mes->aggregated_doorbells[i];
 
 	for (i = 0; i < 5; i++) {
 		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
@@ -368,6 +368,60 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
 }
 
+static void mes_v11_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1);
+	data &= ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_LOW] <<
+		CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2);
+	data &= ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] <<
+		CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3);
+	data &= ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_MEDIUM] <<
+		CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4);
+	data &= ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_HIGH] <<
+		CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5);
+	data &= ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_REALTIME] <<
+		CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5, data);
+
+	data = 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -1167,6 +1221,8 @@ static int mes_v11_0_hw_init(void *handle)
 	if (r)
 		goto failure;
 
+	mes_v11_0_init_aggregated_doorbell(&adev->mes);
+
 	r = mes_v11_0_query_sched_status(&adev->mes);
 	if (r) {
 		DRM_ERROR("MES is busy\n");
-- 
2.35.1

