Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1841AC36003
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F98E10E56F;
	Wed, 19 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KEKO3Kv8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E09610E564
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br5I11Ic+30LnHuA1ozG7dxj7TafrLQ3WCbJ4EMR+jYoXZHpeM3j5kihvDu6c4QrI9n88geg010K15Lx3kPHczZuD5o2Vu2mQJ2T8FMeq4k3fWnhk8Gm9C5veYIVrT8/+Brhey+4L8AeT2M59j920x3mKR29kuzevDUGfesLx9cQNG8RnFr9G2GRx+9XfLwY0o1NPRzqxgoUz5VzVFoSssRbR72q4AJ1Xx4y4JYGdf1oP06GzsphIxMTROgxEGre+Kj4aITtBO6E4nePfGu/PQhND1IwD1AzzjDAUB4VVShaTE5sfi37NGQpbvC5Fxsqi7gD25LgmAJIX6kd055yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtCSE9fiAkpqlnSmqg3tOiDP9DsYyHYMf0MzD3knG4M=;
 b=TynGfqlrXkgM7T12JAKz8zfmtJlN8ZB0HJPbtAYByFlTsCXBrz6ca5HqljprnZfUBGK4E1RqmH1oD8dQSDBjKEDYaqNd7xllHaIDi5iXU2sVCxm5KyZoxP6GwDUopFoR7nApzyGIMTGy/uLX6bhwQ90EqnyT4YBxTFegXcQHFUiBQJbs5CV5lqsJvTfRCJNw7T/aFy4uL9aPivgSBBuSZoEMltswG/fFOyD3rFcLgtNguPGGk6d1rId0q6e8DnZvW/4SSDk0NZGWzXbLxig6/b3cRJ1crwN5ocF6UVXd321acq4JroCTC8RS59Zh3sp4ZSj27+zmoQzVPXpoMRDPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtCSE9fiAkpqlnSmqg3tOiDP9DsYyHYMf0MzD3knG4M=;
 b=KEKO3Kv8BXUqjtINFWJh89TTUZp6FOcyk9C1Sux3SI21MWa3/SD+xjOvEmvjb3V+lHB3ceYMF5mF3YqfXp2qQ2ZhaqGDPKlRiSvVbtOQrkd3Uefaa3+VTah+bxqi9HrvTTiw3mkZIaFLzomxNzg7t9z2fWGTj1WVjsMxMGi81mk=
Received: from CH3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::24)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:30 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::49) by CH3P220CA0018.outlook.office365.com
 (2603:10b6:610:1e8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Wed,
 19 Mar 2025 17:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:28 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, JinZe.Xu <JinZe.Xu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/16] drm/amd/display: Use sync version of indirect register
 access.
Date: Wed, 19 Mar 2025 13:55:18 -0400
Message-ID: <20250319175718.2578234-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f6a76e-bed4-4803-099a-08dd670f8428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xCxzNOfXky+vjdtjkezuht1es+HpG4MSEl5AMXGSyeJoy1WGUFBHKkRmBzw/?=
 =?us-ascii?Q?hWPg7Lu/X6aP5ojsbGZJlbJsjmxlpdfMewHfVFXyOyLQNwF+i+c728YdFQZn?=
 =?us-ascii?Q?HI91rMuRsY3po7L5QNhU6O3xJLo8K0YYd+1yq+oq2yMMw2LEl/x62aQEdzjD?=
 =?us-ascii?Q?TlWiEGk34mUOBTw+jQY2+HSIlYhMYpf/PhVo4C3kbbRdtUl9UBfGT+aYXdMe?=
 =?us-ascii?Q?c2s9RV07v/rmw8t09w1AJAciUsmv9RVCJTpyweiAJ2PzKR76wljJguxSkGU2?=
 =?us-ascii?Q?fIrDWilttj1Wim0i2J/DkmVRr8Jsdxtp8u4bXhUyOPrZrAhwdHd517m9WSFw?=
 =?us-ascii?Q?8VB9TbOggA3TgmfGBqT+9QnmghREUNmJGBrvQwqxkc31rweKqqN0l5ql5bTn?=
 =?us-ascii?Q?wFdlCjeNg7EEnS55ncie0NtXcToOgY+9eAPGTL9MslpCotUwBB4+KVpUL5zk?=
 =?us-ascii?Q?xbcfjebSBwI8Tg/aHCL5SKDhByLzaCBCl1hEjov16OMeFs9AOApHCHN/0Cg2?=
 =?us-ascii?Q?8qpnEeDzdiZqT9X1wM6+HfTBCgCIVUa0mdetuv2vhx6ool+NrVea22//oNrD?=
 =?us-ascii?Q?/9YlcLkFRbBz/z3BckOxzEK30Ezb+ug4qWPZTfzUZ4NIovwxgMRgQtwtO+jf?=
 =?us-ascii?Q?jhccfP5HPpwHSUBirDfaUgSqaQd/9vR/creHhkhWPVOmqpVwzE0pq+sDMZVL?=
 =?us-ascii?Q?Nq3cVB/aaxZGQU8XwlKc5MHbkxSF0nPDsf/QXGKRBjdOgkTcezO7xiCVQYYX?=
 =?us-ascii?Q?y7lUOGil36747g4lQYPKt86vw8IKk/11bZDVR1jefueG2mxwr6cxSB1XDV7+?=
 =?us-ascii?Q?yj7NNt3mbYVnWzy5b4ndRcIcw260MWNjcJ2ubasZrPFz0zKHVL1ghtQMDNQn?=
 =?us-ascii?Q?8uyaIfBSQXEb0++jAznfvKm9MAiIIBtxMQOrhNRX32assMzxPbE8Sfy0PCU8?=
 =?us-ascii?Q?xGfehA/8Ytofn/54p1p9+3PpTI+ahQkumKtnQkoxZ+FHU1L4DsiE78aAhx3D?=
 =?us-ascii?Q?kfXEjbBmBZkQgbdsfjYcvdosN6pT4e2S+l9iZXIxAu9fEg94auPA9bp/7TkJ?=
 =?us-ascii?Q?EcAln6IcZ2ww8sPD6Wb1BqFgTRznLW3lH0YkyYlD910v5j09xIK9rqt+C15s?=
 =?us-ascii?Q?QOFJ2suIeuuPzakpP1pdvaK+67X4VjzsY790QCER1NEZrDwxsQyw6+2D8g6H?=
 =?us-ascii?Q?NmKwTWkqCC7tZsxiWa4awUMo/uBISV7JyNQVqvjxad0JrlyuJA2865wMw5mz?=
 =?us-ascii?Q?ZR8bQCiqsmP1SdqdupIZaBeB7r64Vxwfj6BZMaRHdLKXgAKQeCXjFU/IaLFi?=
 =?us-ascii?Q?gvkT7mlX62EtDbSkk2oXxWZPXo03/YeFi0K186hrBiI1Bw8VII3Pg7dmFrXT?=
 =?us-ascii?Q?rD0lfPsNW4u8WUsmhx0UaKtbQPbeYm7wxesW0AAtxlLFlvc2TFPdrVJtq8mP?=
 =?us-ascii?Q?aI6lEmflYnrYFSlQDELF5XcxMgR/mJoTMHaUc7P5EcCGK6TDQhHVFBQsALk5?=
 =?us-ascii?Q?pJc4RDJ6rzrwsQE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:29.5240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f6a76e-bed4-4803-099a-08dd670f8428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[Why]
Access to indirect registers by DC and other components are not synchronized.

[How]
Use sync version of indirect register access.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 29 +++++++++----------
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  4 +++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
index 2d14346b680e..478b4d6a3544 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
@@ -49,12 +49,9 @@ static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E0000
 					{ { 0, 0, 0, 0, 0, 0 } },
 					{ { 0, 0, 0, 0, 0, 0 } },
 					{ { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } } } };
+
+#define CTX clk_mgr->base.ctx
+#define IND_REG(offset)	offset
 
 #define regBIF_BX_PF2_RSMU_INDEX                                                                        0x0000
 #define regBIF_BX_PF2_RSMU_INDEX_BASE_IDX                                                               1
@@ -67,9 +64,6 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
 #define FN(reg_name, field) \
 	FD(reg_name##__##field)
 
-#define REG_NBIO(reg_name) \
-	(NBIO_BASE.instance[0].segment[regBIF_BX_PF2_ ## reg_name ## _BASE_IDX] + regBIF_BX_PF2_ ## reg_name)
-
 #undef DC_LOGGER
 #define DC_LOGGER \
 	CTX->logger
@@ -77,6 +71,13 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
 
 #define mmMP1_C2PMSG_3                            0x3B1050C
 
+#define reg__MP1_C2PMSG_3_MASK					(0xFFFFFFFF)
+#define reg__MP1_C2PMSG_3__SHIFT					(0)
+
+
+#define data_reg_name__MP1_C2PMSG_3_MASK		(0xFFFFFFFF)
+#define data_reg_name__MP1_C2PMSG_3__SHIFT		(0)
+
 #define VBIOSSMC_MSG_TestMessage                  0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
 #define VBIOSSMC_MSG_GetPmfwVersion               0x02 ///< Get PMFW version
 #define VBIOSSMC_MSG_Spare0                       0x03 ///< Spare0
@@ -153,12 +154,10 @@ static int dcn315_smu_send_msg_with_param(
 
 	for (i = 0; i < SMU_REGISTER_WRITE_RETRY_COUNT; i++) {
 		/* Trigger the message transaction by writing the message ID */
-		generic_write_indirect_reg(CTX,
-			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
-			mmMP1_C2PMSG_3, msg_id);
-		read_back_data = generic_read_indirect_reg(CTX,
-			REG_NBIO(RSMU_INDEX), REG_NBIO(RSMU_DATA),
-			mmMP1_C2PMSG_3);
+		IX_REG_SET_SYNC(mmMP1_C2PMSG_3, 0,
+			MP1_C2PMSG_3, msg_id);
+		IX_REG_GET_SYNC(mmMP1_C2PMSG_3,
+			MP1_C2PMSG_3, &read_back_data);
 		if (read_back_data == msg_id)
 			break;
 		udelay(2);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
index a402df225a76..26cb1459b743 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
@@ -508,6 +508,10 @@ uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 				initial_val, \
 				n, __VA_ARGS__)
 
+#define IX_REG_SET_SYNC(index, init_value, f1, v1)	\
+		IX_REG_SET_N_SYNC(index, 1, init_value, \
+				FN(reg, f1), v1)
+
 #define IX_REG_SET_2_SYNC(index, init_value, f1, v1, f2, v2)	\
 		IX_REG_SET_N_SYNC(index, 2, init_value, \
 				FN(reg, f1), v1,\
-- 
2.49.0

