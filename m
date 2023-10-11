Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0255ECD6E54
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 09:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847A510E5FC;
	Wed, 11 Oct 2023 09:42:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0036E10E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 09:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRewoLUNMH8/TgJbTxdRpXSQtFpR/m6Looq3ZXqdrFvVT/E/pa45DJqLM8eX3cmLl/PhNKtBXMQES1nlvtukeSW8sKNqHC8CurJWwgbHoI3ShDfW+FZvbJ/7fqEE3XJ8bN8ULVbiw+HHDlHPX8HLIf0jQWFR6poGSEzI0tZb6Ek7YbFIGBNMAhDR7SCTIFd1ysOQCmQbccCZg7r9SqIRrz4tie4vW8xkkxSNf5SxWgtdAitG3RZO+m1J7zfKpHIpdSzlYo6gqzO7HXjQRr9f4z6kpmqKhVcqY8qRmtU2Sciv5Hq28EU7o64ab81RvX0e9r5HtkX5zlDktx2eGIUeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrAzyEcTJu3zWzLU8fUn0ONEoGF4tf7Qp6qtD0EQy04=;
 b=Iz5BvUxZ/57iI78MKW1ZGJiI2gD41RidMWOS/m+6/Om63E5KTjeThYSvGRRxML3TQqFXVgsu7vwPAMep6YjdzldRfrAKBzNKpsiZ9QVBPzmVkLLoHgp6ibldk3lNsFjaAoGkq0MUkAgaaqvWJCWeitF9LP4nbnVapTBOVWH2H5T4YZm90SNiKCfy8TpTv1SM8i1IAk6a7+97Ba7dMl+Uu5AYF9Y2YAOe7GrK7I2O5pl6esIJoGI10hhjnLPq/QAd/pKYfnOHRSiM+aKDjuCc/xlCUZVG7/qVXVPk4vi3UWqXygGAoBZ0SPhq7MV3gTP5m35rMUZQkkpHADbmRCH1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrAzyEcTJu3zWzLU8fUn0ONEoGF4tf7Qp6qtD0EQy04=;
 b=LfCT4LCdhItQprzDw+WUf2fJZZzHrRkffjZ/qZMGvG0Z6Ysx4bl4n2KglsUWZoVwfc1Fi2jGNKHVifJ5U3SepjETei3ucTpK+9DluJoTMqdwJW70Tw7uWWnb9Mnk4lldurft1Z8VW9+9r1ovA97XnV6lKhf22bJxODCmbnH1kbM=
Received: from SA9PR13CA0043.namprd13.prod.outlook.com (2603:10b6:806:22::18)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 09:41:57 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::c8) by SA9PR13CA0043.outlook.office365.com
 (2603:10b6:806:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Wed, 11 Oct 2023 09:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 09:41:56 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 04:41:54 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Program xcp_ctl registers as needed"
Date: Wed, 11 Oct 2023 17:41:27 +0800
Message-ID: <20231011094127.199320-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: caa912d9-517b-47dc-3f45-08dbca3e4f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pntu/7Xjqns6qvPozA/xRBy+LgHLKOmtYs6gXh9mEASDnAGfKfaynxL4l78H5Xl4cmd40ONShwrs1Zi5v0Jz0K3xbL4httfvBXvYfBL2lwwxdI0eqqJ5IQbvoX1tFJI1kQDTpNvL+j+KKvKlfJu/VBNc/meva7asF6NEkLxrjYgXbkCZfYpR6Jq4S1WIeMkeXhAX3J0DwrixZ9YEi/MyVd9alr6h7syp7gFoGNUCSbqHI1Gm9EWaKgAW40tiDJASkvP+KiRgiaCtqInh3En30jdqJsA/4Thz/Y2bXwUTp68LHYD8NCS+XqXuwLWqsChaAWsQVGTvGXfOa+IMtWGmY0USKAsb6fF0JXQv+fLcEKCZxcLsvGh/fz7GhEabMcHlqhktqe8icw+qfy67+LzQx2RMmQDKP53XWXKM50DR0/ohC42gXIpYKyURHXCSM3CA9jMfl5tMSr6aocBgjNTq1djUfNg4UPGEXGqkOkEYtmAG0+hYTERi0X9f0/NaplbPfcmhqU08Z9qoOwknD4yq7Sg3RjIc+xlJYyH4AhM81ntyqubXQYNczy6ZDgDjLLhrSNVALH18g0mQ635caPbzurfomzJEVuBJ/aWKOV0A2dPq7bQP0OBNYot+GnKehEheoNG5g48aqU4L0N9gLyWzVGuB7B8Ca0dn7ZW51nlqOZtuH71l66h3xD0jZp8HCZUcTIZK+Bv0YmiRy0HUGnTCQ83EX4kgDqY5I5K7jsglompAM6oeFFIBldalIqm47wJMxwRCSkpLzFOqf3+vGvYD8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(2616005)(26005)(16526019)(6636002)(316002)(82740400003)(70206006)(70586007)(54906003)(110136005)(1076003)(40480700001)(36860700001)(356005)(8676002)(8936002)(4326008)(36756003)(426003)(336012)(2906002)(7696005)(6666004)(83380400001)(86362001)(5660300002)(478600001)(81166007)(47076005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:41:56.7777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa912d9-517b-47dc-3f45-08dbca3e4f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 3cf01336313894419498a0d5eb367f092a436195.

XCP_CTL register is programmed by firmware and
register access is protected.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index fbfe0a1c4b19..39bc441695f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,7 +623,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
 {
 	int ret, i, num_xcc;
-	u32 tmp = 0, regval;
+	u32 tmp = 0;
 
 	if (adev->psp.funcs) {
 		ret = psp_spatial_partition(&adev->psp,
@@ -631,24 +631,23 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						    num_xccs_per_xcp);
 		if (ret)
 			return ret;
-	}
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	} else {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	for (i = 0; i < num_xcc; i++) {
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-				    num_xccs_per_xcp);
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-				    i % num_xccs_per_xcp);
-		regval = RREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL);
-		if (regval != tmp)
+		for (i = 0; i < num_xcc; i++) {
+			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+					    num_xccs_per_xcp);
+			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+					    i % num_xccs_per_xcp);
 			WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL,
 				     tmp);
+		}
+		ret = 0;
 	}
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
-	return 0;
+	return ret;
 }
 
 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-- 
2.34.1

