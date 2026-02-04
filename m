Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F7CE8B39C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 04:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC97610E14B;
	Wed,  4 Feb 2026 04:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPXJ2FPn";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2627610E14B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 04:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSq8NIV7wMq3aOV4TpcD3eOFqnt58FSNPGbLURhl7R+dpx6XtRE9C7Ooz4VRwOXkdaSQYe9gpLTeWfBWgLGDTjC48A/CX3m6T0W6DLgosYV/Q+xG8Zugs5VWKLY+qYR3bPgCBX2kIfRFugwGCaD0xpPzjDs7F5Enlc/pyolgmycUdFBI0wIG+O0ZJMaLcfc6ViNxbWcoGBOvlJ5tqtjSQG43lEcLQhC6NlWnyiXRNUC4DWn1TonkCK65F1hfOdZ1OVzNpCxkalkNosgUs1xfRDyqI6eE1gApQaPAXZ4wdFhe57WKqFNLpae92k1ygwsIM2krWunTJpEZYMwj6EXEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztvhdTT7bIccl0qa7+xZhhnTOZ3G3IdTxXzRGzY+o6c=;
 b=IAr3di1WCnIQWBs73po6OrEqdHVkH8jlV8/E85SihlUKz0gpIaDX+1oV4ma4R3KDWWD3Z/AswlbpSHhYqYAdQPAyBtGiJgYHoPlRE+LUbYwbeb+v2MlMPBXfsSRtpbtvn1R2k9IaxWxpkLFz5GZunHAdvUixOi8y4cia68dAjnjfbuOvowuGkNB4Zw+jxodlJ2aqVVaKb15UeZQn/ZPX3MPIbgBLuZMa+wlzfc1Hlvc6lNK1DwSxqGC1nXALvYEgxzZyJwaTMaGXaKfkWLqebkaJHlTbTZ0y8oMfwObmagE67xaJvjU0lzFRQx3eup5WiUAXMpK8iL8fTUdsZ2LbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztvhdTT7bIccl0qa7+xZhhnTOZ3G3IdTxXzRGzY+o6c=;
 b=oPXJ2FPn8hw+xon16knwb5uPEhI9LDv87dgVExHO2FCxMupJ+CBNJvXyGUU3aJq1rfLWDZViqCeZ5ah2P/mfg/bAzsgctr7TenF+hH57HEsYOW2NrXqvflOD4b+eEMjia3RIOHP2hra4jKarHZPwOPHK6/yrfZ4orybRVxTDs2A=
Received: from BN0PR04CA0181.namprd04.prod.outlook.com (2603:10b6:408:e9::6)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 04:43:58 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::18) by BN0PR04CA0181.outlook.office365.com
 (2603:10b6:408:e9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Wed,
 4 Feb 2026 04:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 4 Feb 2026 04:43:58 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 22:43:56 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v2 02/11] drm/amd/swsmu: Add new param regs for SMU15
Date: Wed, 4 Feb 2026 04:43:29 +0000
Message-ID: <20260204044338.96093-2-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be62cd9-dd40-4b58-9ef4-08de63a802c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xuYcxn0Pn5jB0OgnAMs89A+KrgapAW2WcrJDTYHIXrjcVpF2zKtM2UZca7Mi?=
 =?us-ascii?Q?5wpg08Nn4TBli5/5vGrqwErNpcIK62CKLyBtWDInGJqWFYDbi2wJjPyQhvKH?=
 =?us-ascii?Q?ofXC9zaDF/9/cmR1uymKitBppM92IZLinp2sFMtfuxe4yEv2UDlR5J4N3UtU?=
 =?us-ascii?Q?8cF626+bKRAjtetShu71g51ZRIHdmpJUbAuFpStgYLy22iAxtWjT3STgPo5f?=
 =?us-ascii?Q?wxYu+VHPJdukxLp0ljRd/SkJHtWsgA828GQLnqcoKQMjlycJ0j9RSFq7SXp8?=
 =?us-ascii?Q?Fgi1KRCUsyNjgQYkTsYRwgGKIpd461YFmcrbP+f514V9LJHDZwT2sFs4Iitx?=
 =?us-ascii?Q?9mcE6Hd4VyFGtGZ0UzSnSNOK/ddU3RYefLHonoPuaNdUE0J6FyUvm8fkZm9Q?=
 =?us-ascii?Q?jsvTL1hLGxkjFU04FmSY1IzQ+UYoKM84FIfeBDERBfCwaS4utD4CpN2RZXL8?=
 =?us-ascii?Q?KGwT2birH3EpHa/2H7al+9oNdYzfM9kFc+8VhfNeR8GpXlbtjSO8lGJDM1gc?=
 =?us-ascii?Q?98WgGdNdXNmeLZI6zPBVEJOOI4BBsteHm0s5X5zGCgNGcTUnNdRbFQlCErgd?=
 =?us-ascii?Q?vYg3OR9jhsbdzyoCrLRPL5o50I/31U2HqQFPVq4XDPTpXhnBr/ehDWHpy+pd?=
 =?us-ascii?Q?Ww7pEaUT+jh95KPFwbmoIVtXpy4Y7VT+xcqK70WzJmaiR/16JGLH0JWzMDeQ?=
 =?us-ascii?Q?rNaaWcXsHoIjD08mz/Qk6U6geHhLpEkggaMdsNa/uc91xIJ15ipLWqOJJIwC?=
 =?us-ascii?Q?KI+yiI3qjdct5dNzoN57BInEedbC0DsBEwwHhQ8kKF/rTcl273Uzn4Xjv5Kw?=
 =?us-ascii?Q?ZHbVQ0A8FaPUpS/dSLMGm6tFaI0j8LRcpburpRMizoXTimdu8e8GhfIxKVh1?=
 =?us-ascii?Q?t/kZm71WJheR9x7WN4yR3PEiv0vsaojMAE+EQjvOtDBzOWKSBYRf2HIqFJ2t?=
 =?us-ascii?Q?TmkdqxcjsYcsk9LdSem4lycryo7Zbn8bSvKwlNNuEwEXr33oH55xOaTXBueN?=
 =?us-ascii?Q?/h18b8JlVKZTRUOxvEO+D+vSIbAnfGPDYj+kqUo5XPexafaH6WkgETOiQPOY?=
 =?us-ascii?Q?h9BVPU3XcpTT3ZXHLiowQg2BnLJmQBrQ6y8fshH45TkVRW2ciuhOXhWasjX9?=
 =?us-ascii?Q?KhD217vIRL6S169fxDmMY5nhXmpYmDTrGCnPzE/biMZ3/M9X6Df8hSOsuiHq?=
 =?us-ascii?Q?Dv6kmMQKrc8ynTbmq7EgdSDeUYuFxRLXcCkF5iaRTpT8Q4os4fXT7y2rTHDH?=
 =?us-ascii?Q?wEUZo4HIDI5idGSpTVFtqRQ5iFK6jiMqyx0vgO+kL8w2STQwgG+OL7JMhndt?=
 =?us-ascii?Q?TfmsqRES1gnsYB3Fi9dy2MkeT37CuMgub8dJa0+/w8BhdNVisbfdLySw2PuV?=
 =?us-ascii?Q?mpMCWAxKILJMLqKpZJ8zD4/4K+mQqw8RWU0T7Q6gwaayEnSRgnKfZTVFEyxr?=
 =?us-ascii?Q?g3UamsgyzDjAmnS6GYxlpN0gbj8Q8JB4a45M6BmG2VGIRML1JEFsBzVwtfhM?=
 =?us-ascii?Q?rExmKss6mv3ISPHyvH6Q5+P9WxWYo9cvACdfdp2wlgSo6gmrTg3OETpJ0UGp?=
 =?us-ascii?Q?YbsT5/Ex0cu0nbIMWgYT9t93dMUvbNHxCQJDJt1Zdyy7TNqKSGHjwg/2vAtV?=
 =?us-ascii?Q?HhtFtsrZzze5s9LocLvf6NGUQJgu9/0IlszOEAT9f7oBjCnERIMLN23r/W4T?=
 =?us-ascii?Q?wzSXaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t7kyOrKQsnFi5HEMzk840SRzd0POMSO5Lo8hmJYnbZXTqQsb7k6BlB3gr1fbD6jGAuYqBpEgVgyCJc26hn4iNUvepZX3GFgvSK83OUrimhYxBLL/dvMnOsODEp19jRaEjVuwOHiuyu/p4589ABotYt6qbzHAoYEXTroXQYJNpX74XsbR5ZFb9iWwjL93Xiv2mlFVkWHJ46RGXd9qhioxkH5xieH0g6aSnOC/IeFc9jSUQlgLe6CD+ihHO0uxKtxXsPNF45PIZgAPYD0GnnOFKcLXvo/4zBixOmaBy3cHLLZP/y/fOXos3HLclMjKj2ISR4vD46oP2X/jT3wKjCVW7x9C5SxJgUJZw/eoWmDeZ76/5zqBCzbkXKPSaYSx9hAPo9t2p14cbV0zMoUsLUq0LJR/DZ/6168Uai1KOUCrV4TbBLDEhEooiK4i3Wf8ROOj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 04:43:58.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be62cd9-dd40-4b58-9ef4-08de63a802c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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

Some SMU messages have changed to multi reg read/write
Initialize during smu_early_init

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c3f22844ba2f..d58b0bc2bf78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -52,6 +52,12 @@
 #define mmMP1_SMN_C2PMSG_32			0x0060
 #define mmMP1_SMN_C2PMSG_32_BASE_IDX		    1
 
+#define mmMP1_SMN_C2PMSG_33                   0x0061
+#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
+
+#define mmMP1_SMN_C2PMSG_34                   0x0062
+#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
+
 /* MALLPowerController message arguments (Defines for the Cache mode control) */
 #define SMU_MALL_PMFW_CONTROL 0
 #define SMU_MALL_DRIVER_CONTROL 1
@@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_context *smu)
 	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_30);
 	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_31);
 	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_32);
-	ctl->config.num_arg_regs = 1;
+	ctl->config.arg_regs[1] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_33);
+	ctl->config.arg_regs[2] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_34);
+	ctl->config.num_arg_regs = 3;
 	ctl->ops = &smu_msg_v1_ops;
 	ctl->default_timeout = adev->usec_timeout * 20;
 	ctl->message_map = smu_v15_0_0_message_map;
-- 
2.43.0

