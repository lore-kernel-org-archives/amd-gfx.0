Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB696EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jul 2023 05:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3786010E03B;
	Thu, 20 Jul 2023 05:40:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D4010E03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jul 2023 05:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8dkh4yNdWCPTtES8zLIDBNW7SJD8hxlqU4H2/i6iNbMBvj+7cDlJOUBwlzndsdvH6RkMqLlBGDZSxXrkeKeMt/ARtrsklcIkxTOZBkT0+LeayWbjLZ6bzjw1EkcOSQX7s6qKU77BIokehub7rITqpXXZQQXqJDLCAIsNPp1Gbm4ZVf0yCcQRVK4p0MlvUC40v34yyRRgG1+qACTCMjYGfAbPsByfkzH33fCyvFMNquxeWbPV0mPnXzJwzsCv99Feq+YMeEok22woOPt05BAubPLWrh+9BCF/kQGIvhknYf3F46gw6X2TbvF4Kd/JYQ4Ls6VN+bLLiR5nG+RPwFQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syu2uFP4mm8/CY9QeBJ/Ee9vY5nOUi9Q7OOYyCf8bcE=;
 b=hMMrNkjl1wOGLGuVF1ozZECGcrcU7lKmoEMfE8C7Hk2tPvnd0W9fw/+OzMw2w1qxYaLl/bcutP4Qbd1DCNiG/GaQZdGx5a/gAiKjnpgHxuK4OX8HbimFT/fNjaWDPwij+6giM7WCUlfH90o16PGCjeymz487wNsQ/pXtFvJybMlMG0Tb2EDPwxxOSo9FLzptyqHdzHedf4V0LVQbKAMwft2ItsKMpijWzVGmlhu1ESEQWlD4yBjHRVpm/odziZfh2FLN8OoiUbn+Zed7M1cDBBCKQXSi7eRHi2cHWJUW+64/QOL9l0QFhV4bc53AdG9ortkCLePe6XgIIKWH8dNbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syu2uFP4mm8/CY9QeBJ/Ee9vY5nOUi9Q7OOYyCf8bcE=;
 b=iYXwBQ/Ibw8wIlmtecMyVBjnuyESF+K2bxLs857GidCU4rYaLdrVpYFvoDxqE9kJLj9vslAJLFH5h0ujlGtDOmE4XZGPFs2hx1sqKSgxHFnxgdRzD02WelmdOP536YwQNa9wBC8gtQODmYgglPVstizdfrSVCcQY5BWXddJCxUU=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 05:40:26 +0000
Received: from CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Thu, 20 Jul 2023 05:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT076.mail.protection.outlook.com (10.13.174.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 05:40:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 00:40:21 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amdgpu: Remove redundant GFX v9.4.3 sequence"
Date: Thu, 20 Jul 2023 11:09:54 +0530
Message-ID: <20230720053955.3059635-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT076:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b78b80-b247-4fca-46bd-08db88e3d1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WszxbiWdy5b5Q4zq+ARQGtMHfYCbUC+rex3MEhhSBPIZ1qwQvjOFW2phSwbkJERnkQPCq3QqunE642zNZ5hgvOcJyktVT96F18t4d5jxXcn0cWB4oMOFKC67/sB6gostqdZ2jBKNXgR8j1mDNGboeQ9zI01CIZT4xgvpL17623rlfRvQRN6elch+DU3QaI53P+9Z9D79rrwl8KSIxCo0Xiq7RTfozJ6P6+TYAlPd1oCmFJwxJp+Dq8KxvZuV1LMZ53sn1r1txTYqRCrazcUeluUY5Yqry0azF8SXk47y5UnBwTD2aUDsXQkDuAZH8foR3Ox9TYG97KyG/DE5U7VO6DPtHEaAVy/O7YZgROqqx9q6N4AuhCr9I0a7uZT2xToTFJ+fa+o2A1+BdCuD3MvcKG9X1r/NOjwHF1ULnjm2AiQoIQSMu9LLpD7gC+AtCCudTrSq0o2TVRI310y93rgoa9wqpleXpS9dPIJoc8ZkG+YEhEXWyznbVDzWi1JW2M4GlHEMcJCc+RINaHCzT1tCWLvxHdSIlitVYl/WOanHPBq95eg31O9zTdp/usb/98hQaKxYue6Iq4AmHqaJ22qmT0jNrsGObI6DrikwtFlNFhQgRpdW9Z+1B8CsnvfV/HKQSZNcnMhfk+EfHewUjp9Yt5sZnwWJgYOpGsbUIEUkpQkeYbmnPy/vJLEegLAqAIEr9miWVscaPufX7L8xOZYUg7SmlgF4rUGjYvPxGN+pOpDKTuNMtoXjYg1kMyLluBdE9E9H5r2+Dq3t6sz8Srckkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(336012)(186003)(16526019)(2906002)(40480700001)(7696005)(36756003)(6666004)(44832011)(40460700003)(54906003)(47076005)(41300700001)(8936002)(5660300002)(8676002)(316002)(70586007)(4326008)(70206006)(6916009)(36860700001)(81166007)(356005)(2616005)(426003)(86362001)(82740400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 05:40:25.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b78b80-b247-4fca-46bd-08db88e3d1b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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
Cc: Alexander.Deucher@amd.com, shiwu.zhang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit cd65f5547f06b8c144063b1744011a135157e364.

FW programming is not yet functional fully. Revert till the programming
is in place in FW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 738226ed6e50..c0855c3769d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1034,6 +1034,32 @@ static void gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG, data);
 }
 
+static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
+					  int xcc_id)
+{
+	uint32_t tmp = 0;
+	int num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	switch (num_xcc) {
+	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
+	case 1:
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, 0x8);
+		break;
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		tmp = (xcc_id % adev->gfx.num_xcc_per_xcp) << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
+		tmp = tmp | (adev->gfx.num_xcc_per_xcp << REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HYP_XCP_CTL, tmp);
+
+		break;
+	default:
+		break;
+	}
+}
+
 static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
 {
 	uint32_t rlc_setting;
@@ -1910,6 +1936,9 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 			return r;
 	}
 
+	/* set the virtual and physical id based on partition_mode */
+	gfx_v9_4_3_xcc_program_xcc_id(adev, xcc_id);
+
 	r = gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);
 	if (r)
 		return r;
-- 
2.25.1

