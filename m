Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF4BC76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7921E10F33C;
	Fri, 31 Mar 2023 22:44:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9E210F339
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lahRdGzr9wEpo1aY68MuNz0Oofa2BV8hQ+MxeSgS1KLffO/dbbn89cjINhHQ9NZ35C17bjGNr8K3FDf7TuK76cHwQ0y7usFrZAx7lRijmiEcCNxi9Gie4IwFiskY3lbyeYg5zIzDAjvABRMipza/eKicIwgJIZRMXzCv+J94yi83rzsK0GATkKvMQbqDPMZGci4yVi1AwU4IlPTjMdQ85r0IooNQX375LrZTLSPxqtG5ulJYFLy3kiSNTH4rlkXWBW7AX5QDBGS5L7X2D0kz73t1yTkJC9Dfzv0HH+r5ZwZZ6090znt2vd66V8HtujqOb7B9zB4mEiPxRWnKko1kUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg0ZsGJFkf7wPRQro3DR1cDNdYJwG4I1M8eGc8zq+oA=;
 b=kAQf0E8Keu/tofRFEeoSmuN3v0hWXFWH06VR3FccVgGm0M+ALuuNdaukm/Dst1gLQrDDFuHULFko+i9T64+oJevIUsVEHqWEIOaPdpI8isnPimq5hiXGcF/uDqFVMzm58/Kgfnzi7zoz04pH2aDJA/UMtOOiZ6B6VPnDMdlpfcm13m96NO0dCrq48AnoSi3L8klg3dE27WpttwFEb6YnYEnS6ovEq41Wn18JKu6hHeM+AbWmgPmirvOfJscqEkn8EvlxxwV7UixD0HtE58c4ZFWaBe7eMuiqENZGMAxtR8YPisPkQufRfcd0NMnOEFgDPlC/TPozuiN1ioy/nKdKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg0ZsGJFkf7wPRQro3DR1cDNdYJwG4I1M8eGc8zq+oA=;
 b=3GC0GtBR2Q9+GzretpRNlV7U5Y06EFl9nXIW4UsI3yYSOTR2KVkBrZhCJK0kCHzL0p7KSg1kLhbqxxqZ0J6uILdKOjLlAXuBrdNtjcnxf2iZ1HfbLMVb1NLXdLnMQc3VMq9mjY+b6nmZQ1Rk7tuiF1ohEIywp/Se/M50gaRO9IE=
Received: from MW4PR04CA0389.namprd04.prod.outlook.com (2603:10b6:303:81::34)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 22:44:48 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b5) by MW4PR04CA0389.outlook.office365.com
 (2603:10b6:303:81::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu: Add query_ras_error_status for mmhub v1_8
Date: Fri, 31 Mar 2023 18:44:24 -0400
Message-ID: <20230331224425.8755-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: d808ab80-5acb-4ac5-083e-08db32398834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTLKOu+cQW+uMPeBZC6OO/ferqhDAG3ik+s01c+oRds0lm17NpvmnwUkKpzeykY0XyB4K8YQpy/9xNVsz9zkWg0drlgrnwbdKL7+lF7fioGLVGeGUeKoEp3zFJZuqcWmNZRfmfRw8uCuXFkW5jWY7v/+4CEDP1d8xg8AS0Q0oaFJU4jQxEu4pmTF/wGzC5u/Rqmu50auj58Mx85BwP8KcWtL4VEAiwBnY45L9mEWrZUuWquWrIc3QYxtPEdv3XFka2vSzx8xjTQEEJ9o4hMoEor4gEnnkxaBgLybL7YS2QBh7vUsxjTmwr007wpojbnR40ncOF1xWIFMT1BmgWKzeDYp4ithUg8od0ONzug/LWokOLCbn47wJxMlr+Ir+MLOgEK4WwZoInabF8Rn1XSyxo0RXtJ0blVHfUdGRu48MhjyLZ44XQlDEBSVTa6tvJ8ObHXhvCcpXxbKL0h+uTZfxTaOngBZDiFTgZh3CxdKAIy7LPw/c9nqnwx25Ahtf2M2vG2X5BZNtK+/a1TxcS7NDQa7m0oBTgpGw7/dNnS4asNSreU4S7Hv/igtyZxqlqL4ibTb82iG4l6hToAPZZtw3eh1lHm8BCQDWDUwuetyXn4+qTGnTDr2ZWOl5aJidlyIbEf9a1pm0CRVn1bJCnA4JmZVy6NQsZviTeKeZFM7xizb4bVbAKSOzoIhaDovgd56L9ZaDdKk8Pdn0TAthqri6Wmo3T4Ve3dqd62hjBjfBTg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(186003)(16526019)(36860700001)(316002)(86362001)(478600001)(7696005)(36756003)(82310400005)(8936002)(2906002)(8676002)(5660300002)(4326008)(70586007)(81166007)(70206006)(6916009)(356005)(82740400003)(41300700001)(54906003)(40480700001)(26005)(1076003)(6666004)(336012)(426003)(83380400001)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:48.1130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d808ab80-5acb-4ac5-083e-08db32398834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add query_ras_error_status callback for mmhub
v1_8. It will be used to log mmhub error status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 57eadb83d5f0..3f4db860ed09 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -700,3 +700,59 @@ static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
 	for_each_inst(i, inst_mask)
 		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
 }
+
+static const uint32_t mmhub_v1_8_mmea_err_status_reg[] = {
+	regMMEA0_ERR_STATUS,
+	regMMEA1_ERR_STATUS,
+	regMMEA2_ERR_STATUS,
+	regMMEA3_ERR_STATUS,
+	regMMEA4_ERR_STATUS,
+};
+
+static void mmhub_v1_8_inst_query_ras_err_status(struct amdgpu_device *adev,
+						 uint32_t mmhub_inst)
+{
+	uint32_t reg_value;
+	uint32_t mmea_err_status_addr_dist;
+	uint32_t i;
+
+	/* query mmea ras err status */
+	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i++) {
+		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+						regMMEA0_ERR_STATUS,
+						i * mmea_err_status_addr_dist);
+		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_WRRSP_STATUS) ||
+		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS, SDP_RDRSP_DATAPARITY_ERROR)) {
+			dev_warn(adev->dev,
+				 "Detected MMEA%d err in MMHUB%d, status: 0x%x\n",
+				 i, mmhub_inst, reg_value);
+		}
+	}
+
+	/* query mm_cane ras err status */
+	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS);
+	if (REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_STATUS) ||
+	    REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_WRRSP_STATUS) ||
+	    REG_GET_FIELD(reg_value, MM_CANE_ERR_STATUS, SDPM_RDRSP_DATAPARITY_ERROR)) {
+		dev_warn(adev->dev,
+			 "Detected MM CANE err in MMHUB%d, status: 0x%x\n",
+			 mmhub_inst, reg_value);
+	}
+}
+
+static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
+{
+	uint32_t inst_mask;
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		return;
+	}
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask)
+		mmhub_v1_8_inst_query_ras_err_status(adev, i);
+}
-- 
2.39.2

