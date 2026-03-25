Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132DEFEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CA210E7A3;
	Wed, 25 Mar 2026 07:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XQ6h1v1e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7038A10E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0pQ/Jv5fOR0XhBYSbXVdYgnGNNN7S1zcQW4g8O/S9HvBi64TBkLN1RDG/RgegsktZxxue6eYfV96MuOFR9mHzgpzrHql7e6Gh/6dEP6KVkkglDZKS2w5wRonvYLiPmZaGnDmQhslpl2mComkFVbjuyjBiAmxQew27qRt+fVt/0Ih67PJBuU+nfYTgmtIQio6hJZRWw9jjHFfGgKM8zCljCztfyAUz5xSXvnbuv+ZUmHP7SKzlsDIzVUQdR8n9+4haQFHKHkKWQwlgIev8OBIknCzlZ7ORlWDzEuhjLnv0oGjNs/QKHCtJXxtym9AGDDCyNB6hKHl3wjRdydyryNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yYVbxj8CAfke8eJ6rRKQuTCL/6oEi2PKR2FDabIg6c=;
 b=jaZgfd6gvpWwQT38GU9fM2fLRLW1k4x0SfIKvYE6FuGjnIMAN4jzkX+Dd3uJrM1Ya/qiPRuum5Oqeze1SE7zVNf3zioriziwTLWvJbl0cM5ERLYHzpCT5rHgq9cqTGk2K0izsS2QZ4y5usVJzaQXVT+4XuCKLOtKnKRaWM7JyHz5MGZWR3E/NsjXuvRAtNJWGo2iy1zqxMUCw2qXhlyQCUaOs35kliIAIRYLUIa+jLW49PKP3rL0ZdWMp0HddLIFbWpoL/bXW0YQC8Pu/GJMG4oHYdNAco2I0Oad9PUv2KxUL5gdSJl5TofOjn4JGEizgo+BXS9oCYQJ30u9QalRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yYVbxj8CAfke8eJ6rRKQuTCL/6oEi2PKR2FDabIg6c=;
 b=XQ6h1v1eTlV20DBZPNOmizQfBaMpApKWdnpg5WSRNz+RanaayEgP1c0KfmSWw4R+RkZ4WkjR5B+hw1Aun8WJm1l2cLbklZPWVao1xOzAs4bG0NmNA7Gxk9BTXW+TyaWThNe5nxl5HefNBdjcOAJ2LBNfMltvhNU9ZINV0yg6XVQ=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:20 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::1c) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:09:20 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:16 -0500
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
Subject: [PATCH 12/29] drm/amd/dc: Add link output control for DPIA
Date: Wed, 25 Mar 2026 15:06:18 +0800
Message-ID: <20260325071003.4022594-13-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: c50d388b-d9d6-4759-5c1b-08de8a3d6fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xxl6ocl3khmRtA1CPX4Vkzn087LheDevg7ll4pv7uXIKrzv+SxXzTkJS4FkED9B9uaZSRlGfzHPAGqsj40VEyBq8F3BByAIRvrqF+Evd4fGueAqtlG2ypKRctNvUILRC0+l1znprqLTDzqbcAnMrmmvaVBoKOIdik3wjionfirS+8qkHh7C6IKRuM7c98/9W7QoSu7CS8vJJF7/xwxCDyMg2X7H9hCE8zSz35aq3d8o5m4K+G6Vt7utgl1f9ILPKR0Vd2sFBv5m+HdAC/dkziGud1xR7TWONQsTt9cSnGo5qwSkfv0cM38ydEq+i/apJpLdkJlYs80b7NBt1qJtW6duUm9shx2rb++zNOrA9QkNt+ln2eKlKXhMn3xqyjhsEJjJymuH4gahwBaxV7CQX0uw1DkCwAQ1uJoDNkW8XOAULETO7C9srpmS009Rb0F1Gt1gSiW776LRcb0v+rZkWFCH43OTTj7IK+0qWSuun/lg5KdMyKGWdDdlU/hIgt3F72Gx6ZRCY4QV98Tczygu0F1LzZMASiozbUO4n9VjXVG6gUxki4MhLRa2aCcT1oA8b/6kXatmmOANW/n8s4zEA2HfzU3NsnkyogAtNg9emVhiomWhXGRRp+GwQcYhIyJVVU+/xfbr4C5sIi3hi042CzbYup46maM/Yq7FNHVL8o+1LgAlPii/vU/RQhoOTrrctWXxHAC4rUAXLfvfcBawU7LA3I9/i0ga0JMuJ2esyeIjkfNhBObkT46S+p8NSQ3dEzgCZjrbRxCaZLA2ciIW3Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bYhcu4FvFTftfCgM18uciRENy2QBXwfDLv3VJjKE/23CO3cSNmiHY3FKYEAVWT66WLYI96PquO1MUGgobm6NP8ZSv6jzoP9vkIoUCl99NK2gGyyfq9NmbGGkq0JZa9E/SAB7ExpYLhYjof4xIT+GL+NoiuFzs6+bYVuy3lxejfeRPkR3rLcFXA7L1sKxFpAxsVVYPdMj6t+uV+UFUeZIb8ZaOQ4nMlXL/TOd3PharYekc+lyaf3JFg7y9QxbNE1t1PBPwMHTky1K4th5tcLTYiEwT218Y7OpvzyKRegZfjx/UcJywhH+ZtuT4b32pU8xd0dWInQNg0EORjcUsHWxD6CoFZpUeiYGSXJZkrBOnWAyp9rX9DrLM7mrHhS2MtgMJfGNY9csn5rWhXCNp7+L44SVXlrQXMaksg5EFxvEa2hkhYFBMrRL1foyBj2eI+y4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:20.5041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d388b-d9d6-4759-5c1b-08de8a3d6fbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
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

