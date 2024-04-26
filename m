Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE4EC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 09:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4480510EE09;
	Fri, 26 Apr 2024 09:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t7SGHYGc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C03710EE09
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 09:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXfDOdMNSsEqzIK/Wkc0nom3FX+WzyxyWh0ybU+oX2KgmkP/KJb+tB7wq8zttT1e9gmFfSJJJSBHpaCSw0tA3ik1nv/dgoedPZT3R1WNKHLdMicFR7mH7PGtHeKOQ7OsvtW0xYY5uVS+YJk3TRY1fFa/Zg/Y9QLvNl50ElpBwrwLdO8swwbQ2ZT3GPgnVZeqzgqHnpSAiuXHUnorD+TZWgVG03zkB5yvhDIxbfroYPGFn02ONT5PSGTyjbPO0CnjfOq84MoYJ/MOm1PXH8IjP/M4/dKeLTV/6XTc1LkvnfI/AuU0d5haKQoQjASYah17/95TZI2jOc9R8imMNl7rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR9ZYGw84nns31TLr5HqeWTFebQFM5rEjHypcw8flG0=;
 b=ZUHbY6pwW15wr4qjXLiSRS1Wd3vzOh2rWqXwTUsy07q81ChUeeepoSC2PfTiBOE0ZVd/MsegyLb13T8yvG9zVFFiKmqaadZnswczXTly+cUEY0rO3IejYPo1Emk1jR0sC1b1AHw4al+wY35vbr4MxzrdrDdxp/PK0Ujr9dCWB5X4NQUd8JHvfu+AWksBA93t4pr9QwdJDURcUEDNoyDfMvpWiuaPo24JNdmhlfL11h8SwBbvO099M6cSLpauN7IoTUK/Q1+O4dFg7HmR/4bEdVJh5T/ar0VbmAbgiAA3Q18JCx9+7lFHGj3/y+TzLsbMqEB19FLym3R1jO7Q7V9I8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR9ZYGw84nns31TLr5HqeWTFebQFM5rEjHypcw8flG0=;
 b=t7SGHYGc8dSO173OEqFuiTo15r9JiqmeQkhg21el9v7ux3kwd8JRLrmAIpqfr48P8PNotr9i3JFe1fTTmDZuKhGbMeJAyvjgDpOIrpxQTCzmp2mD1ua60sFGBtg23N5nIkvucPlZtv3jPm11OW0eOEvYvofENRMxYKCGQVClYB0=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 09:37:40 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::ad) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 09:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 09:37:40 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 04:37:38 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Check the return value of smum_send_msg_to_smc
Date: Fri, 26 Apr 2024 17:37:24 +0800
Message-ID: <20240426093724.21682-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 885f1d2f-033a-472c-304f-08dc65d48433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ot8wnMyU7HwCRhuelARSDoSW/hnMeoKjeWmovwLbINdTCAdojRDWW+n6RxnY?=
 =?us-ascii?Q?5NHEnennw3deoLVmSHazJHosoh6+pmA5Ov9eP5kISmIPdG5XoVsq5a8FR/l4?=
 =?us-ascii?Q?2vCe4P/3xmLqhySoqXXKJ9+eM6t9ujuO6IRfK1zz9MBrHAzYqfBfDEcTdt3e?=
 =?us-ascii?Q?kHdkWDxgT7sGAETOTogN/F3HI7ssMI489oJohWXGGbu2Lc7YrBJ+M0g+W+sA?=
 =?us-ascii?Q?1uZLaANXqrpfd55YSw0PK1KFVNzGFHx44xSS8vqhxklVYt071qvBoboE23Ac?=
 =?us-ascii?Q?AYi2Y1wQu1a3KJ3dl/QybwQ7dyhI7uzchKQiYGtHt60U8dWUor3IYTE8W7Qk?=
 =?us-ascii?Q?Z4Gukzidd9fZYSzheJ945yZp/+lhqICUeDqROtizl9MlVbHhgPZgmnFI17Tj?=
 =?us-ascii?Q?qKlEoYPteGjlu0aCB7ghGMW6jPb0/8p06d6r5TeNtaWdPzASknVCJa06jdRc?=
 =?us-ascii?Q?2AQ8hS+CPQA8OJhRekhqH+ybxhK4WgqUPbb2XyAvjwmJt4iZXP74dqfSZL/V?=
 =?us-ascii?Q?k6YSwbfGF/lfYdlk9gjixcA7vx/uOUISvoUR2jMjQo+RRGjufOFcEbH9nftv?=
 =?us-ascii?Q?YPrqb2lOiRE/9Z8KRHdrXZe3Wltz2BZNXkp60ehIJJ4buNo7Gd5ZH80oHWXP?=
 =?us-ascii?Q?SGn9T1rwsUQ9QqLFuTYaVFthwKCN8a5WllsXkxZun2614PapFiyiGw2vUbBc?=
 =?us-ascii?Q?0Q7iff4N48wgVTS4+22a27zBo6/cmvFBNwSz29Mw5u5+c7jSL+Vm3VaH5jal?=
 =?us-ascii?Q?PmGZ0v4JEujr9UV7UPqVGx/1DeXFCdhI+yyeEPRz7GyRCS+1jvAqttKCrJLu?=
 =?us-ascii?Q?fAglOPLO5Tt3oALiiVRpc7tpxLNprdp3H05SARtlwUw5hF1X8NTXnto5rYj1?=
 =?us-ascii?Q?oyXMqWLxDMvgJhKxwNTKecwlTwiRi1a+j4Cb1iEq7ynaSYmcuvhBd7pPA0Yw?=
 =?us-ascii?Q?C0F+XLKGaURgpEaL79Cc9V+33ZUDWbv1c5c4FmnPdLtUcWwjfO672EBdOD8e?=
 =?us-ascii?Q?MyT6ibVx8ROFZaYeIbXw8ff/XFdog3vroHGZGhneUluggmx8HDS6v9RyzJYp?=
 =?us-ascii?Q?JpKFJYVzmS66iIq6e4DlLAKUkvKpXkHaTkDMUcHQlnjJwv8GXSVrbKUJqt5K?=
 =?us-ascii?Q?wmJg/69c06k/SqxMb4SlPtzMuL2Zt90M3ZHd6UsVAs39czc6r4/B3vx2K/gR?=
 =?us-ascii?Q?yVaoJPUS6GDyOEUpWr42u43UB2gYhaRP/78teDtPvVBbAgvxP7gMf9ntypd/?=
 =?us-ascii?Q?OMN18BrgkHSyGiNyQtXsdM4p5g++oU0bSKmi7ttzeSVpTXKmwHMFrm+wP/Y5?=
 =?us-ascii?Q?TFRQncNoUKnaHM9qt3X/QZtc4+SckV6E6bNoQBvfQ+7w1ogMXgGg3jJ3+yH4?=
 =?us-ascii?Q?EjPbHt8QleFNxI/HhNT3IUxmO852?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:37:40.4093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885f1d2f-033a-472c-304f-08dc65d48433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303
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

Check the return value of smum_send_msg_to_smc, otherwise
we might use an uninitialized variable "now"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 02ba68d7c654..0b181bc8931c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1036,7 +1036,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 
 	switch (type) {
 	case PP_SCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
+		if (ret)
+			return ret;
 
 	/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 		if (now == data->gfx_max_freq_limit/100)
@@ -1057,7 +1059,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					i == 2 ? "*" : "");
 		break;
 	case PP_MCLK:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
+		if (ret)
+			return ret;
 
 		for (i = 0; i < mclk_table->count; i++)
 			size += sprintf(buf + size, "%d: %uMhz %s\n",
-- 
2.34.1

