Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1B1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5175A112242;
	Fri, 26 Apr 2024 07:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJm2qBea";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1E3112242
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9puBQRbqMVVgDINl9gtwT8v0NePmc4ytUgqSNMobmIJMx3SxpsBPC2xAMXY2srLoEQ1KcFkLWuagTcdB+/Isf1fmOxL7d1yfcN71daDP6U7CBuZ1upLkJfOdExa2UE+buBPjzV6iLU4B0MQ0Jqj0oSSB3AGzQf1MnO/1ZWKujU16pzAYMdicgSd4LvosKXlOrJV1qOWTfSlcBwX+D8xrtxBszLttaotkVr9JVGZG5ugUiX/LRWhLXIVrtOszNRcoldbRHqg7aHbLHINLOV/PL3I4zrvM6oYAx+xNfMReE3fZcsaOln4yjoom3cF47miFwKhW2p1E13YMCuLVOfooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHa0lxUaNPZwmq6CFR+riEvw6Hj2lalS7r0dVkd0S5g=;
 b=QCW9mSxdW+8B061rdxjmK0miSaFDrK2XZnZFLhMuI7mAagTu/EqeEWnUVExJvnF2soIEwtWg/awckOmhsusN/8qx3s/A4OV9aXyKPJy0xpGoDf7be9Zp0XuzIWD8oIT6WSFdpqFckXDJKDtdiDTizHGvDDUNptMGDhekR9lLW+8JHV1GOf70WWHe0+hc5vOOA3pCpINJBRv1SuMiyhc6vl5nrBzXw9f9ndGYUvJP7zuufIRD8XOzeaxhBwEAXQW2lEQGMqOE54ZcylgYcTtu3Pz/tX6vij3PmbaXJE6hCZ1aasfyyQahJX+6eiQCAdvgREmB5AX6zbf0wDKOMo/jDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHa0lxUaNPZwmq6CFR+riEvw6Hj2lalS7r0dVkd0S5g=;
 b=AJm2qBeaQBS3Ca6XLAsAWcQH2J9+cj66cVFibC2uGakk6wctwYz7zeLGRcfIaf7uJNesRDsEn3MX2oSXIoMINP8Pm4g2L7jHAODQ09NrAdUXeR+YFTiB8MTsQqbKI5VwNW5l8vXyF11NsXEedFPTlALGWLNphegxpXidpNGK+oU=
Received: from BN0PR04CA0036.namprd04.prod.outlook.com (2603:10b6:408:e8::11)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 07:28:48 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::d8) by BN0PR04CA0036.outlook.office365.com
 (2603:10b6:408:e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 07:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 07:28:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 02:28:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 00:28:47 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 26 Apr 2024 02:28:40 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: fix the Out-of-bounds read warning
Date: Fri, 26 Apr 2024 15:28:35 +0800
Message-ID: <20240426072835.1052391-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: c47f988f-9d6e-40ba-1abb-08dc65c2836a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yg8TGKN3v+eTjvczyh/BcpoLU3fEY2Y5jXCOLJdCf3o2T7XJ6srUH6Eojkxy?=
 =?us-ascii?Q?GYfBVXOqZn8VxGvpRiMqcXwj4AJOZyPg562gjW8abYLXYGumSKQxQ+XUUQEB?=
 =?us-ascii?Q?Wu0FeB4uu9plxZwtEL8Fbaw5HBBzGfiKJwXMvPeY9NZ5EkKilPijSWC/4axV?=
 =?us-ascii?Q?FmhpLeLAERcpXktpL2whgPcng3/SJicAYM8fE0fz5g1F3AD5MBLUbX9z+Beq?=
 =?us-ascii?Q?1Noj71OlydBQENNNUVgqpFbvAbF9uwg+9bjra23D0XodoPVYTUwJ7meWsAQN?=
 =?us-ascii?Q?MdNyT7rq7X4etf8Fq0QS+QVkBKSXiHoKDp+B278eXqjt03ceAoDEe1GBytHt?=
 =?us-ascii?Q?uhBJXEXLCYqf+X4a6A06YrfoKC/7t+i1r7Il0+Oos02A8TpdJ8W+y+sFk3km?=
 =?us-ascii?Q?3pJHp4oK+P2qy6iGIXHVSjL9KXJ3rIWOXrnAPXGxCW6Prur6WFQ9dvuFa8Is?=
 =?us-ascii?Q?DsdmsjEp3nE6gP+KfS+oxAsRdXfqTeu5XBUd62q2ow8zh9pJL29YfEE3VGT5?=
 =?us-ascii?Q?y97QSNW5XJtTfFr3ohBiMWdZFdLg7wwXTyeJuGKh2AYV0Fs/dwbz+bxOmyWQ?=
 =?us-ascii?Q?ETdRAjx6lfzz925/ULB32loLRH2c0U5ZIcjOqQnkT3iMK+w6KbndquyZ5G4n?=
 =?us-ascii?Q?N8w8fyFZOsb5ubJxES4MPJsy6jmRy2w6uN4S5RXWRzaejHJ2XsAyQjymYMlD?=
 =?us-ascii?Q?6HFJwc5yaKYh1OVHnyx3HciJ69YBJS32nawkn3qQAnCrrThXExeb2C+lPKs3?=
 =?us-ascii?Q?EfmpH8pc9IppIGtCPYZRAyB/1f3rtIpv0HvNkcQ6/nKZzlv1uKd5VLqoZeWv?=
 =?us-ascii?Q?P/0oQl1zsWbpPELLS0P0/FK8yVooYDuuwIvF/iHxXHxY23piTt7hd4RLwJuT?=
 =?us-ascii?Q?dCOlNEYi7hRWBfPmBdCy4eKH/H4Y+8cXoIBI72oXZTZ5MxAeGQy1VayqyoOQ?=
 =?us-ascii?Q?rcGKt/FKKIBowb/+9VdZC4PnV2VNlTnFygFVtNtJ4vw/ll+feWBRXAfHSjJb?=
 =?us-ascii?Q?S5/+EgwmDzOmDbDcncBepcLljMlVhTxvCSzqOvcSh8vKwbGW0rOR8QOSB411?=
 =?us-ascii?Q?uSysV/vZPnvLbA+XSdOzMLFRzgkMY1UJiMbO6XOMXg+FNHT7epP330YtSedM?=
 =?us-ascii?Q?BIzwHCbaOTfZxvnVylk7F92FecVJapuh5eggHFoRMgVquoBOKHzGTIixhjwq?=
 =?us-ascii?Q?hgv5t/s2BYTaAHn2q3B3AZk9AT18blEKV09FnRUnMJR/98nRBfwkBaa+lWR2?=
 =?us-ascii?Q?DK5rHV84ROuV7r024hV5S9TS3M/TTvF4TShafEnV10w2XLeIGbdJtCfv0uHM?=
 =?us-ascii?Q?tYNDEYaPm/qjNncSmp8Xat4EZ9FYb3p9HuRB/km1n+Qmx0VCFL5JsEy43x5k?=
 =?us-ascii?Q?Rs7NBvYp/Ar2Xcta2cv9TVwWPJX/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:28:48.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47f988f-9d6e-40ba-1abb-08dc65c2836a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
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

using index i - 1U may beyond element index
for mc_data[] when i = 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index b1b4c09c3467..b56298d9da98 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
-- 
2.25.1

