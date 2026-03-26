Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD45109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231ED10E937;
	Thu, 26 Mar 2026 03:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rT+IbtxJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A535A10E936
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCN2L8TBSyMWZAdd6VSvr5yHd803Rs6KndJFPIDlJaBwpFjGb5r1+K8U4lLe1O5Dn7IE5ZuSIkoASv402BfDgrJYP66PrTEdVwNOp+1ZUDJ9UbSezUIegyhFVBIxGk8cFic6G/r0NEESljYdCNdKTFVASwDAO6WQRygPa20a3t8TbIoZHpGceiamnw93d+oqmtAbVS6+WpAnpUvmPGAd1MXjcPIm3JvtMBYonSHy2oENZt/KgOvSbYZJ91yIa2rnoVC29fgH2caAfMhkELVTP9ywm0lNv8U4KkPjZlH9AwlFR8XgP99js3Z9lqo0pO6z1Vau5/Y4bCYo7ukN67G2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yYVbxj8CAfke8eJ6rRKQuTCL/6oEi2PKR2FDabIg6c=;
 b=NEp8QnseKEPck8d7QUm1m4qkGbaA1+1ym4SjG8m1LqMPebhVqVBOYrw0WRLdnwnz5lOjDiZSrMcKRIFP6sXtn3E4vkjolnoF/uoJd1R2bcDggNuJJGQW9+MT4gAVxpemPwwU09v6lRnyIAKarAYQ9f48GLZPLC/8rG851wScGUXTg8S6P8DT/GTlAT5j6RET/TbLIa2rDdBX9ORuSqcxVrNVVCIEQ1kk9XJs3dKaA0mq2MeuOW11bfkpz+t6jCBzPhWB7J5MwESpJRDUu/6og0uF8rs0SdAa+vkc5NK9FG2ldq4YiTT4RxliArMfWfhqEISVClLx2d+XOiZDHPNssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yYVbxj8CAfke8eJ6rRKQuTCL/6oEi2PKR2FDabIg6c=;
 b=rT+IbtxJQb51QcHoLC+MfkwcJoDWVkwRw7LYB1JKBd/BFo56o0woCGJ4I046YrqoCRUOzIkp2nD7O9gBRrL2ClmIgOkDZT3k7BfOAfGDsbj9nvPIqIOq3gMjkBSLFIvodSZgsVBi2J0RQJ20tEQ445ya6diDo31qjrvLfeFsrvg=
Received: from BL1PR13CA0173.namprd13.prod.outlook.com (2603:10b6:208:2bd::28)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:18 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::29) by BL1PR13CA0173.outlook.office365.com
 (2603:10b6:208:2bd::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21 via Frontend Transport; Thu,
 26 Mar 2026 03:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:18 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:14 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Lincheng Ku <Lincheng.Ku@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Lincheng Ku <LinCheng.Ku@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH v2 13/30] drm/amd/dc: Add link output control for DPIA
Date: Thu, 26 Mar 2026 10:57:04 +0800
Message-ID: <20260326030153.406612-14-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c66696-8b9e-4004-3d6d-08de8ae3f3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: LzuCVr1+KqaiNPsDU6n7oEMZCCYcvUdAbMOspRp9wAL30CFV7GcH+SZvp2FRMDjYBSfbA+TFLiD0tX2y6o4UUUD6S4ccRz3HBoNIIYu1wvSqx1PJJ81wQ6zTSrGNLgc4E6kcn5DpiFqlH13tTaYT/VPJlzrQCBzOm1lGXBZWFiq5DuammvDB7/ZAw4f3wgxDRlXgzYWnn7hoEOnUj/26gwp7IREERbqZTEenBUyVtaBNOX9yh4v/E0E4prnch2s0Bw0inRTV3MbVg3QEiKQ4qh7pCWIMm/1DzIOMrb/Svl+FuXM7pUEY3vYrsBl9gdjmTn6i4aAoit6H5nvTaq2QuXUloFDLG7CllbFBVzmbSURDIUZ4uw7xN2oUoAVqC4aZyCZ6hJtRHnyGc1xZoLuNmfPhhMy80eQi4T2IB4j6BlNWjhX2PuY20hpcrCs1eNX/8edsoVrLtnXEzKfIb10msNWX5XIgq0eI0I53FwBq+RJN23XZN+5bAaOuTZ2mp+/c9ptfuVNT1dR3zs1cx+8pAYx55KZu3jusJ/oXEEB1G4J2NBIFihztFPYAxfrkOKlC9j3ycqjoARxMxZ0mzl3n2/RoskqjTFJcBsiW0SibkFK55dtT7CRLvYMW5tjaKNCzES7AVfT3QwOGwwoVWQb/l24VAdVPlkGrsXUogxPX11X1CAlg7pZx90XpdK2mAVBPnPT+nyJA0bX2ZCEr6WbpzjPE9pB4kwuh/iUDEd5yh6b7y8MTFrLbtjrmiyVL8MQ4MQ6kZcFBQQzHBRTGu72d7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xr8MpjouYPKwRj9hoqP61jYUs23tm7y07jhgpe/hmAKtk8sni0a0unQ62i8N+eJaa20JctuhD1iAlrslEgxfzz+6pM1OmXGYv3YcSUhzhpQ3uY+ArkaTYH8dgfqmtlBhoM513IwCvq5uPCEwfTJNFjoRN0Ub5GYlT1BSRgzkm1tMeJsgxj9rZgrAlarGm9zdUyq4hlMrOH3xj5d47J094jEuFE2zqQjcRBCCukTgwp7ky3XU60G/YEcYKHKTmiZPFFRih2FNbcPR/hdXnfeqdXcoSumRpczN0YXSLZR+e47urb9fwPR/xYPmqGjdVYo5fO2pzfj9ku5fo9smNexH6HgxT8f/iP5V5U/YB4ggHSVU2d1ZqH/qnc+LRwOnM3BT4nCTr7bMISyKxd0qoSIFQ+6xfeSr8U1eov7YK8rtwQq+NzAbf3Hxb85LTiJgwHnd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:18.2565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c66696-8b9e-4004-3d6d-08de8ae3f3a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

From: Lincheng Ku <Lincheng.Ku@amd.com>

[Why]
To support specific sequencing requirements for DPIA link output

[How]
Implement the dpia_link_hwss structure and define the necessary
control function pointers. The initialization order is
aligned with the core link_hwss definition to ensure consistency

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Lincheng Ku <LinCheng.Ku@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../amd/display/dc/link/hwss/link_hwss_dpia.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
index 81bf3c5e1fdf..5d708039c7cf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dpia.c
@@ -145,13 +145,9 @@ static void disable_dpia_link_output(struct dc_link *link,
 }
 
 static const struct link_hwss dpia_link_hwss = {
-	.setup_stream_encoder = setup_dio_stream_encoder,
-	.reset_stream_encoder = reset_dio_stream_encoder,
-	.setup_stream_attribute = setup_dio_stream_attribute,
-	.disable_link_output = disable_dpia_link_output,
-	.setup_audio_output = setup_dio_audio_output,
-	.enable_audio_packet = enable_dio_audio_packet,
-	.disable_audio_packet = disable_dio_audio_packet,
+	/* Ensure initialization order matches the declaration in link_hwss.h
+     * for strict compiler compliance and consistency across HWSS implementations
+     */
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dpia_link_output,
@@ -159,6 +155,14 @@ static const struct link_hwss dpia_link_hwss = {
 		.set_dp_lane_settings = set_dio_dpia_lane_settings,
 		.update_stream_allocation_table = update_dpia_stream_allocation_table,
 	},
+
+	.setup_stream_encoder = setup_dio_stream_encoder,
+	.reset_stream_encoder = reset_dio_stream_encoder,
+	.setup_stream_attribute = setup_dio_stream_attribute,
+	.disable_link_output = disable_dpia_link_output,
+	.setup_audio_output = setup_dio_audio_output,
+	.enable_audio_packet = enable_dio_audio_packet,
+	.disable_audio_packet = disable_dio_audio_packet,
 };
 
 bool can_use_dpia_link_hwss(const struct dc_link *link,
-- 
2.43.0

