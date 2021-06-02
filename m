Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90627C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623B461C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623B461C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D37E6ED88;
	Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04946ED1A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONU3Z9ekc82/dr8axgeK6LrItPO5JFjaVY1/mVHF0w84/ppD0NKkqHcrRZSo1y2DeqEJf/mPWYkX7rJg3CGlBRK8wt9N46Pu8hWnIyo5tsOgNHFsvdBXgD0LpQgC/Z6ZKOKPkDzL3HJjxf6VbqDqt0qSxxFqUAox4vhjscPjckzcCMI74FcwsRTjItJew7nD/4UFeRJnJVyi16Q70PC02tmfhT0z9kLAvs8lbov9GPvQXb5pHR83hg97iNx1Wkrjk80yJpkszA38CTuPIbRC6JfsMGg7pU+PkA5yJBvE8NtuYPKFOUaDlmHenbRf+KxBcMiKvDgR03N1CKKXc/HHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qplmo0yg5FJwHnnOhlZT4+OFYiPRxTgVXT6fkylCWgY=;
 b=JYvjI0OIMXsQ86fK2SEaPhfYKhIPS7lSXdx7/x2CY6lfC2at9NeS6L27PFXc9wq54zsgMUita8HN8oelxbyHxqH2X+tMZ67If2xlSWWzkbuE30UQoiXUsAvKLzFA4Rf6jr5ebf1pTgPkDne1bJtidVnSc+uQyqbPGIV7Su6ELa9DzRthhAinpB8BLeRn9I3aNPyxKR7isMNGPphbTqrW1OVpBQn0YAWrvkAjfd0zockN1CeUa5lwNgSIq3AyPHqKC491zhENcuZKr1KNh/aujl7RxU99udq6CTWGHWDWHU9tqNvPc43awlhrhhu6sEV6xsKRPq8/CkWLcf9wbWbpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qplmo0yg5FJwHnnOhlZT4+OFYiPRxTgVXT6fkylCWgY=;
 b=y6hh3om1lN9X89NvKt6M6Qeh402XDT6kJvb6LUzbcXLa3gMdfGT9a4myKtC7c1IjJV0EjYaG+rgImb2OZY15abkXeNFNuYH3O/AyEO7xAB3NSxWZdOV8VxuB2cip9F2uzEeYPvysFSBagiSlncb9rv+iqXgS1AXJLXDSQC+EZxs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:39 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/89] drm/amdgpu/pm: add smu v13.0.1 smc header for yellow
 carp (v2)
Date: Wed,  2 Jun 2021 12:47:56 -0400
Message-Id: <20210602164908.2848791-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76b31ca-8c51-40b7-79e3-08d925e669b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40778ED50104964C4979BE45F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzXo3mGPCvbrU3WgeRJ2oNBOWulmVC26zT6dxshRwd6/PZZ2v4YGiisYYV5aK8G47fcFUUqK7cpQCRnYg7ywUhPvXiMwTib5FZ/EH3bIBms+tgfWMCw+lCYk71YMyyy+4XhTuUU3bopPzd32MFsdHKateOlMfS96HvG4i9dXp6jtpFRB6TcchHuC5Z6x19lnn0Oq1pNd5vLuBY4d9gtMFEwOpC7vZnvgzPx7UbEc8/x34TNMy8AtmFHxeP963LxPwen+inAmvLLfsn8Z3eyimy9+NaORvqoUefFuKhqEZjR2jt2Lv72B3D+jZc7zAuUcntcmHdt4W8DtO25mZSDf31uheT3B9vhiTpyHKdl18kwpZNa2u2Pt5Ke4k2t5Wri2JMbWuqgPRiCca0Mnm8gSo0VpcONl9+emZXOdPVPtKONNSgfgymjg2TlB1qlstZHsdXrOWOGDazMezbnSQvukYMuLgw+pZB5QHQkVPipQQbQc4+xZhO4VXMQWbahOp2Zr36+iuf75/P1mn0NgtGzMUJYSGcg+PK0Xf3nPGqfib/pWnNPi4TZthl/UhL26jvWljuzzHF1TBaR9F0EJ/7sjhrLM5f26flkhUufr26CkOw1kYj+uOrY9jNRWECVgZHz+DzM/Z5OEZrZfbzUBs6n1eUz+ZmcqO81yXvgLNxojGtbaZe/ySj8ZUd2K+qUWZc7V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(19627235002)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MUD6YUtVxR/TBoWBmzyqucL0b8Y3aWkn/fChu0yc4H05KtujHGGbLRcDmMes?=
 =?us-ascii?Q?+U7uzktUq404ap8Uv9lRQsoV+bx2895aIUv9CgFGq6oBjgoWcoPGpfczc4g/?=
 =?us-ascii?Q?vI6DsD+zqjSgc30Z2v711ss1NWsZIMsKLI7X7nZufhf/ymfRhIV3IOZD13hl?=
 =?us-ascii?Q?HlLeR1mkYiLpaYefDoS0rNNxLqfy+dRs+H2KZwWEEGt6tYsm4Q4Zpo4/Cgt7?=
 =?us-ascii?Q?S0mqOxFbJsr82VOoQMpZoo/SnzVXDRnxjmJaH4d1KKZDs8RFfm0/W4bo3Ppa?=
 =?us-ascii?Q?6jdov+6FWdkz+4UE+zziBP0aoHdbw9tNiiKyeGOhCMyGA7+xY4uOlGih8I3Y?=
 =?us-ascii?Q?S7cijvzjAifLy6saH2ag/B4q0nFksI1R9aXLZAmyQu+c/cJjsYBMVWr4zRAY?=
 =?us-ascii?Q?E/iXEzuDppX4A/E+J9/dc8Q4YiPrOO1MbbNF/6EmZG8g8far8hF6t6dM/uBX?=
 =?us-ascii?Q?7at5blfNMhfuZTbcY36QsXJjHi/ShibAozbhZb36kISYm3QKI45I4OcIYBz/?=
 =?us-ascii?Q?IW5YgqsgPGNkPTTPwcVLD1Ia3obHKi17FTC8bl0Uea76vEXZFYMBSOmJtK+2?=
 =?us-ascii?Q?z7D4WWqHUSv05Im+v8WuUeVlLot1RLdDuDQa2hmkbsTe1fKzSpMVvGvWvsSt?=
 =?us-ascii?Q?9BRt5zNkfm5+ZGMHfctreXEx3r2MrloFoEGERCXUwleTF2r+PvcWHANqDjph?=
 =?us-ascii?Q?jrQnfFFmYe78ozH5n1dZAxjL8IIPOJGG9lluee4ZU7MouxWeMtNPplP/Mrkl?=
 =?us-ascii?Q?HWmMyXu/8sRM0cuYCSenLCtwcLdXERYswyvKk1mh+ZIt+7F3wOFKdGn8MyFQ?=
 =?us-ascii?Q?ZWkGga7huOWAlmaZ4V16Sf9zY6mPOSwVAYeB+qKVhBmol4jS5YMPEQnTFQ76?=
 =?us-ascii?Q?awKJ2SSnEwMAut88Moo3nwXgPF+IaEvtR0Xtfq0LTBjrFnGPoh0A0YZi9MK1?=
 =?us-ascii?Q?62sUYG9hu5ES1Ss+dSw1e6JQ5qTw34VghDINO1CXGfbJkfyXAi9V9UeUjisa?=
 =?us-ascii?Q?C8v7IwrWV0Rqjlx5QUVWbqBfgl5OjfqpREz5O+xqTmv65eCcMnFu3eL270qs?=
 =?us-ascii?Q?hWkoZBzHHa+Wfo/CxxpXz0iQWnUWO9BeE+NyRXN7EyarLV5NG187baGpLir7?=
 =?us-ascii?Q?ZQOA/dOfJMjdP9jlHi8Wvr0mAyXacd8U/RjVwp+ohQES1G6Y5FnCPl4wb8Ny?=
 =?us-ascii?Q?nR3TSFPWtCUN/v3mmtQjK8gZP5ot1fzJEo1gvuhBDvzE2GOG/Nawzx0oY6Bi?=
 =?us-ascii?Q?Rv8xIplJoreiJbqcf+1EQiGDVx81uBacnnlQ+zYbrc6MdOrTKisSGPowFma6?=
 =?us-ascii?Q?/Zu2lqhzj5fxqmdQy4Gs6C64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76b31ca-8c51-40b7-79e3-08d925e669b5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:39.8102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI43CcctCAQYjMjRbPMllrDwS9g4aYgK1ti1p8fc0PtmOffMdEWDBqs4Izld7dK3hzJSIR/WEYO7lmRxgWsZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch is to add smu v13.0.1 smc header for yellow carp.

v2: squash in updates (Alex)

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
new file mode 100644
index 000000000000..1d3447991d0c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef SMU_13_0_1_PPSMC_H
+#define SMU_13_0_1_PPSMC_H
+
+/** @def PPS_PMFW_IF_VER 
+* PPS (PPLib) to PMFW IF version 1.0
+*/
+#define PPS_PMFW_IF_VER "1.0" ///< Major.Minor 
+
+/** @defgroup ResponseCodes PMFW Response Codes: 
+*  @{
+*/
+#define PPSMC_Result_OK                    0x1  ///< Message Response OK 
+#define PPSMC_Result_Failed                0xFF ///< Message Response Failed 
+#define PPSMC_Result_UnknownCmd            0xFE ///< Message Response Unknown Command 
+#define PPSMC_Result_CmdRejectedPrereq     0xFD ///< Message Response Command Failed Prerequisite
+#define PPSMC_Result_CmdRejectedBusy       0xFC ///< Message Response Command Rejected due to PMFW is busy. Sender should retry sending this message
+/** @}*/
+
+/** @defgroup definitions Message definitions
+*  @{
+*/
+#define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team 
+#define PPSMC_MSG_GetSmuVersion                 0x02 ///< Get PMFW version
+#define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
+#define PPSMC_MSG_EnableGfxOff                  0x04 ///< Enable GFXOFF
+#define PPSMC_MSG_DisableGfxOff                 0x05 ///< Disable GFXOFF
+#define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
+#define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
+#define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
+#define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
+#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active work load type
+#define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power down GFX, i.e. enter GFXOFF
+#define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
+#define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits of DRAM address for Driver table transfer 
+#define PPSMC_MSG_TransferTableSmu2Dram         0x0F ///< Transfer driver interface table from PMFW SRAM to DRAM
+#define PPSMC_MSG_TransferTableDram2Smu         0x10 ///< Transfer driver interface table from DRAM to PMFW SRAM
+#define PPSMC_MSG_GfxDeviceDriverReset          0x11 ///< Request GFX mode 2 reset
+#define PPSMC_MSG_GetEnabledSmuFeatures         0x12 ///< Get enabled features in PMFW
+#define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
+#define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
+#define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
+#define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
+#define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
+#define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
+#define PPSMC_MSG_DisallowGfxOff                0x1A ///< Inform PMFW of disallowing GFXOFF entry
+#define PPSMC_MSG_SetSoftMaxGfxClk              0x1B ///< Set soft max for GFX CLK
+#define PPSMC_MSG_SetHardMinGfxClk              0x1C ///< Set hard min for GFX CLK
+#define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x1D ///< Set soft max for SOC CLK
+#define PPSMC_MSG_SetSoftMaxFclkByFreq          0x1E ///< Set soft max for FCLK
+#define PPSMC_MSG_SetSoftMaxVcn                 0x1F ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_SetPowerLimitPercentage       0x20 ///< Set power limit percentage
+#define PPSMC_MSG_PowerDownJpeg                 0x21 ///< Power down Jpeg
+#define PPSMC_MSG_PowerUpJpeg                   0x22 ///< Power up Jpeg; VCN is power gated by default
+#define PPSMC_MSG_SetHardMinFclkByFreq          0x23 ///< Set hard min for FCLK
+#define PPSMC_MSG_SetSoftMinSocclkByFreq        0x24 ///< Set soft min for SOC CLK
+#define PPSMC_MSG_AllowZstates                  0x25 ///< Inform PMFM of allowing Zstate entry, i.e. no Miracast activity
+#define PPSMC_MSG_DisallowZstates               0x26 ///< Inform PMFW of disallowing Zstate entry, i.e. there is Miracast activity
+#define PPSMC_MSG_RequestActiveWgp              0x27 ///< Request GFX active WGP number
+#define PPSMC_MSG_QueryActiveWgp                0x28 ///< Query the anumber of active WGP number
+#define PPSMC_Message_Count                     0x29 ///< Total number of PPS messages
+/** @}*/
+ 
+/** @enum Mode_Reset_e 
+* Mode reset type, argument for PPSMC_MSG_GfxDeviceDriverReset 
+*/ 
+typedef enum {
+  MODE1_RESET = 1,  ///< Mode reset type 1
+  MODE2_RESET = 2   ///< Mode reset type 2
+} Mode_Reset_e;    
+/** @}*/
+
+#endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
