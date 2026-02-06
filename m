Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A548EE20A8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACAC10E7AC;
	Fri,  6 Feb 2026 14:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VgkXWRdH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF93710E7AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCS/mxKep/+gED2RAuFJQanrVFPjf0p0jsDkM84EmQW8WvNnaVvp9dQMBPaPVq2tfHReuR+0R7rWpLjkKxj195RhE3KkLtliPCMbucmEC7AubWH0fGdcYVCxaJm27JHUK4wUisFE+CZc8leq4jReBLojwVA52vvZdajmG4y8s/0FrjwRFf+CS49LeVpHeljC00rZB2hBOf0suYMQ3O+kvFY8IxbjVfUrG/Zg4Ho2cTC5TlwEQAvxS/Tg4Jefi+0rTbKO87Y6XdbEMWqESdfYiAKIOQAnToFZ/8//BuPR+1YCO4EiSvN/Gndbx2UKxuDbfeCVdzcP6xh2j/jXJvLBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xtFucezIgTkmokOzCdNocpC5ayTX8g7WUYLdq4i3Rs=;
 b=Lsdr3qmB+Gj8r2JGH4sPo99vqqFKVX7DQYdvUrLwoeUcca/Isn2UYZRyX61/VCLY5GUIz6Gl7MmrjbjyucQ/1PiboukPaVWLkQxxTzRUyCaRA1xuxAfIVrWv7U5u5Pjkk5ggp5Z3Xb0Aff6R2DuV/iLi3RLch35HyRByJ3ZVvTylOoYZwa4DEKhcaUhYfidWNlUP/RY14MAiBf9v6NkjXkyeebfAoZe1ffdSqhFXZ/vqTuWcqRnXqSQEr99WAeJl5zIMCbntdx4KqH/2LwbtnEk0uBBmBV13GniJvTExPN150MfcVCvyyAQCMIor6AotCM3gcbDEvFGXbwZzepJVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xtFucezIgTkmokOzCdNocpC5ayTX8g7WUYLdq4i3Rs=;
 b=VgkXWRdHmZz2HHNqQEPbso743LtWt8TSsFYWD3xP6ISLVr8qvr/l4kHD2YNZBnDPjqBNfd87NGGeLTAJnHloFQW5UwSahabQoau9pLYbKWaUNCRHcqrb+7+/N4n9Mu6Ri8TkifJUUezsazjO1kuLWo22ImqNGW85ZitdqkEcVc0=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 14:01:40 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::92) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:40 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:38 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 11/11] drm/amd/smu: Fix User mode stable P-states SMU15
Date: Fri, 6 Feb 2026 14:00:48 +0000
Message-ID: <20260206140049.105294-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5ee881-f9a4-4a38-7519-08de65884065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bYZIJ7P5UcWLqmZkn9wSc/MO9S63dpKAKE30YE1C/3pSexrmy3XlJ6r+MGEC?=
 =?us-ascii?Q?s81V5+QvYYpfrJxVKqHHDHjHzs+3fU1J48jLIz/mRtHRaWX3mWGfWoYyW9ML?=
 =?us-ascii?Q?RDm4G4Gnvyjl5eaRmL/z+AcbyxeC7YPmshZPiRMQCX8TeAOc6pUcjieZncjm?=
 =?us-ascii?Q?iFoub8vjBrPSylQ1GjleOo5yzAwxk1qlqwFwQDQd52yueOhzi+XRMzmAXmoX?=
 =?us-ascii?Q?Aa7W7T5BcloI9bVA8eDG+miB5Co7iU1bDrubJw0DZDMDCj73wCw6iAdjf3Z1?=
 =?us-ascii?Q?Xuf4STZiUrgtO9e0ojQ0AWtsen+vndlUqpf3+3Hb2j//bFDrOC9fXPyK5/L7?=
 =?us-ascii?Q?trC0c2q1tP5MMLyxt1TKGqnmlcBBLIDEclMX1Cjv+JDSqpsgDArnHZ1998q1?=
 =?us-ascii?Q?KbIhTmnAQv9qf+yRUssX5M33DyjbwdD4WZauRYoJNhgFLrPAt2+cqK9rdigZ?=
 =?us-ascii?Q?SW/qdpyF7saqz9qiOMi5noZ3AkQCQOmkPOg/LTzU3lK0eaVm2TtxXIed5Qe1?=
 =?us-ascii?Q?mAX885RnViqb8B/YGspRjHZdymRc5rEx8w5zZ5B0eUBUoDb2A/O3bDfA7jiH?=
 =?us-ascii?Q?eLs5uSIhVZ4MPO+7mPgQpA3Pzp42n2YYCpDn9AkLUCJgzL7/JZTQOI52sIsU?=
 =?us-ascii?Q?LJrNMpNv6U+2WNPs5f9nRkhHjlXM26rjFRgUTXusZN0AoSF0to6UuG1h6IKN?=
 =?us-ascii?Q?fM7zcIPI93Jwb/nmqUHi0r31DclQUXevShJXB/1NqEUi7AgT22HBI0z2Tf86?=
 =?us-ascii?Q?cw/GJxlr0JUOe0LH5n4znVMPtk9oSbq3TNim8WQZw6ONI7DDkw5tIMTdCMRz?=
 =?us-ascii?Q?jgP/HYXZ/dtvYAWVRopCn1NLS/LswWh/3kGfCkMHPxsrty+mqBKO/Caj8Unx?=
 =?us-ascii?Q?ZB6eFOTmq4s678FRJBlGKjaRUyr1o8r8qfcCPg6bulGvNQEgQI26hHgGeodX?=
 =?us-ascii?Q?h8uCX6Kc2SDXIymAXjzDvxNh/+KTQXRlwE8V7OqdzlQA0NzeOmYpKvPgL7I/?=
 =?us-ascii?Q?8njNoHgc4Gmm1bUQxTEdyvLriOtJSeXCTDAVPhSEovVGwKEGFVHY3LjqfR2v?=
 =?us-ascii?Q?mJA1iHghQo/3gIxE9qL5eNi1fzpImK8+zq4n+iVaJaZqGT9EmGInLy/ERiWR?=
 =?us-ascii?Q?LUKde0Ia5Tp0gA5lQmBE0XdkqZEQJW9fd10maAJxhCu8gBmV2y2x+6+VXkV+?=
 =?us-ascii?Q?K4APMSHR6TzTKkIcR7IbpTCccQihfwk6marHFQAD/MPE9G46b/2TsgEIhIH3?=
 =?us-ascii?Q?y5CfYnbqLuSIbU9RinVRCQrE69YDdPi/ka7Nw2pTsTEuZClV4EGaZMvdabhZ?=
 =?us-ascii?Q?eY7PBaAGbt71u0viK2qEPTXX85aN5EZOuz41B1hQLtIZFp/ORrZPXVgvb1EB?=
 =?us-ascii?Q?cVVoME/vCVZJj6kbScZkQ+oE3le+Xlhhj0lMUu4gVEHIPcK4UF7QBD0w2K8O?=
 =?us-ascii?Q?KSg7PZC6fVfF5ST8jA0UogXFAFHkuqMN7k5LJzDUEUyW6jbjGk16BTBS/7dQ?=
 =?us-ascii?Q?vgcuz0ohSasTK/d2rV9W19gNlvjbx9+b67+mrNUW8Ot/Q+cx5bQndMnHWpFa?=
 =?us-ascii?Q?Y/yAmLRqnlb7qPbkA2QPIoG25tRhB0ZQhYexqKxUDwUn3pDsAcOEdAxJGIKU?=
 =?us-ascii?Q?RY0sromJeV6h/wOjF/992gxe1E+RWxGaivMbbJdfiwTYugiWPiGA9NULTmRW?=
 =?us-ascii?Q?NiAZPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ddF6HtgJe5xFuUDybwmiyALbmp5xfAcThWdusqMwt+T7sFo84aeTRDlzhCjSm2WhjYIshEVW4qOu6WzhxYnyPHTNb4HSbh4oJ9MnsOdWUaYeBHZskyCGR0DdoQBfX9d0GNP7kXImk3YCe1Bpyl4fOBtSxWoQssHJ25/X3hCplgF8ARLiJ6ZnbOEJLDgKTh9TmYytzvGr3bPpdY6N4vdBqHgt6+nTXJ5lDPjbTUP582X3PsZDhjX9hysaWR4Mk4EzvBinJxYx5DFABsD+CYDPPocVey9+6kONVh2ofSAAfZvfg/s7vojZda8J5YEbbGZkm+HJ6IMo+FjddUbmtUKc5P9dXzovvjrYTTohQN5PDPS+dkicc/RjdyxoMZnaX4aYeCgXP8f0TUVLHM1md7eMEvg3kjEwzi1b3G9vZj1fttwXtDgi1+j6FxeT+K2mBJEk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:40.3088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ee881-f9a4-4a38-7519-08de65884065
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

SMU 15_0_0 exports only soft limits for CLKs
Use correct messages

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 9c2a4dafdd7c..66f4385d972e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1065,26 +1065,21 @@ static int smu_v15_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
-		msg_set_min = SMU_MSG_SetHardMinGfxClk;
+		msg_set_min = SMU_MSG_SetSoftMinGfxclk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
 	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinFclk;
 		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
 		break;
 	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
+		msg_set_min = SMU_MSG_SetSoftMinSocclkByFreq;
 		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn0;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
-		break;
-	case SMU_VCLK1:
-	case SMU_DCLK1:
-		msg_set_min = SMU_MSG_SetHardMinVcn1;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
+		msg_set_min = SMU_MSG_SetSoftMinVcn;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn;
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0

