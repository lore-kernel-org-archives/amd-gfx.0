Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DAFC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 09:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF8910E584;
	Mon, 13 May 2024 09:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0Co+EOv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5538110E58A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 09:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c//dmCtHW+p9TF2BSk5WIRtDjxluIsb8Sink6U34ikSZwibvoqbH2P0o5QejSq/HjClcXlE+FXatDCT3TOBbL78QGgseWO/VzyIxaTh/UnadNcsvAkl+/jHz6h8FrZUbKTQnmhrM9sb3bHxH24fIceTZZNrqB2d07OhpXwmY/vyRXZ2dRULDni+17cFPmXF/4IgbIpJ1YjeIBLg3e/Fg8ly2P5Lx49sJGu75BijxIYerkXzV1d6j6pALDWmj1WTV+HI2c9MBp7dUhvIT92Ug5hcQ5EPiIP5YEy42xZjrrWpw0QsZzG6exLDf4eM4KPHAt4f2y6/GV7p1l1TLfW20mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gqwogkPGagFmjI/SfPloQDTgbYEz64RnEnJ+beRfp4=;
 b=TlvH3mFPULqXOf+vi1oCdG9czZm/26hYJHihhGg20OIQWg2j1dPpuiuckWrewLlWR4NjJE4I8gU6pJacoJAzA5KDDp96Jvg+2JGLUPbGuGDe47yLlpR3Gl2vTW+DcYnxL3yG/0aHFaczCCXzc7DxL7bk5lvTb6bCrL5I4nHdluKQDZEisjMQQxvIdq6gP5ECAPmqDo7DvSL/AdMZ7MvwZFB1YK1Lai4EDaff5UI2JBPQv6huRsa/RVW0W9Ph1CP+zniUvh25I9jZXWiYfbOGjk/CmiOXyyr/d+LlzcdDQwfNGVuj960DYrgMcyFwtj8IYSX1Jkm0W9SPbuZkN3xyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gqwogkPGagFmjI/SfPloQDTgbYEz64RnEnJ+beRfp4=;
 b=y0Co+EOv5FeFAIM1jlI4nqB6JPX1hCE1L2gvIKgH/UFU384YkOFaPo/l2iXdj+IRVPgMzcyIhnuOEJGCAa+/VpBNEs9tW/GgK7quIal4LMOxhhSLqoak7b8WJcBRhEPgOoaaY2Z3KbYeVZmODWjtxJ0v3NbH9Zq9bNc3zQLTCrw=
Received: from DM6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:5:1b3::45)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 09:21:32 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::3e) by DM6PR17CA0032.outlook.office365.com
 (2603:10b6:5:1b3::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Mon, 13 May 2024 09:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 09:21:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 04:21:30 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v3 02/10] drm/amd/pm: Update PMFW messages for SMUv13.0.6
Date: Mon, 13 May 2024 14:51:03 +0530
Message-ID: <20240513092111.341168-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240513092111.341168-1-lijo.lazar@amd.com>
References: <20240513092111.341168-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c66152-8df0-4a0b-ff2e-08dc732e141b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UDQ1lXoKkfGIKOGJ90D0HiVTrhkVur9UIsa1tXY4pKv9jZKKPLRDpT9Mt8/q?=
 =?us-ascii?Q?AeECJaE9R6NMiWRgoPCcEHZCZ3zXu9hYpn2cwegzs/l94wOJ2h7OSSaDPvM8?=
 =?us-ascii?Q?XhUbfOxS3Pj1JyLSSmUwp84lhXQcBjcbFN7wLleR5K3eAK3eWO0NxnmXD1Se?=
 =?us-ascii?Q?ziUpjMbQykNRqBI1MxLL0s2XJrxrV3sCirm3+X1U8db8ayN3VFResQ7VCN+Z?=
 =?us-ascii?Q?raJ+mJGvPi7AJaftfX55xZd/Rrca2rHAK3B0IswKYFBCcAfnTroL4XX7cTXi?=
 =?us-ascii?Q?f/jEN7Zn0uo6GBbDlqGKHPkU7KMthQcepD1PEWaPNq/L5/HymD+eT2g7yA4S?=
 =?us-ascii?Q?9u43uZ2C7dhOYODLXaXZwKsi2VrcSg6YRRhdpVCeqs1b5Gkow8g4BHXaQAjt?=
 =?us-ascii?Q?RzeAomb/acQKVWkdbqgejA6hSlqdCN0jGDPgp3hXdCqfFQA4RPN2Xqe0pO/g?=
 =?us-ascii?Q?qfpmVrT0ME7/UdTkZQx2sDtX/s9PyoA1AWmQW+apNUT4SW09yLMOyU2PNPEq?=
 =?us-ascii?Q?NHCiaZDNmI8VnwgkxWPH8+cdBo/d2C02YmXcDp8O/tJQLd/vA59u4AEB6XfL?=
 =?us-ascii?Q?HEgrzLN9fwoCtDh5DSLibb23ZhURdJJW3m4A/lOTbJ0c/6550cfv5DN+LCP5?=
 =?us-ascii?Q?nTH3uj6Kj2iCjF7VFgGlyq+WWIQfHN0IZCsBVmWHs9sWCNs4C/8QcPHF2riv?=
 =?us-ascii?Q?sHX+htyoVZpuu+xwG7/ZDMk6LJPFhnlVSQTfOjsXEenisxBHVxnvl7u2BNNN?=
 =?us-ascii?Q?5soFviKPoZF6mfX+J44D+mMafsPZQb4+SxUNryT7oBq76YliAdKQ2xMmPGZ+?=
 =?us-ascii?Q?2uiTW7hkx2Ar+MNYoCOMotlg29Uz2XTBDly0Y/Fq1rjwR6g6HSt04zzYQTOK?=
 =?us-ascii?Q?Gme+QFB97cr2LshDbIML8Tto+6m1WhTPWrPBeaww1MKEp+srhDjIGtX3f/1F?=
 =?us-ascii?Q?ZV5J54sG9MhK6ycUMcVwacxTlbLKD+einBCtJjf3ZIYc2W+bZC9TfYosXN3m?=
 =?us-ascii?Q?A53MxiWpjsqGHHS7SzmOpsjwcQb4jF8NoWHUqJMdLPv9HpeMZ0Uj/hDtplq4?=
 =?us-ascii?Q?Wfc/n4WiWONh2KXSzjf4B8C1AhtF3qKdclTaPV0mNkQcC8s8idhMDieeuAXY?=
 =?us-ascii?Q?Q+mkNVEaORggQKC1aBfgKwXGFgZmz/RE5pftQFhcXjDgg6T1NvRFzxHJ92n/?=
 =?us-ascii?Q?85HpnO4y4kld8DcqJkspm9KnkpEXIX+wFkrhtuLZcpdlS9zuSEJXD01rd33r?=
 =?us-ascii?Q?xFnHNGvc1QOMrwR6ssgjr/i1CIXTLFoIqYGQx5wP8S2CnGKkK6B8pLEdsXbi?=
 =?us-ascii?Q?omZQbEk8VQzUl5N/3RjRkWSj1+JZ7Vhyy420YAKwR3Cucn+ZqSlSlZxZiUw/?=
 =?us-ascii?Q?NYp87YE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 09:21:32.2055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c66152-8df0-4a0b-ff2e-08dc732e141b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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

Add PMF message to select a Pstate policy in SOCs with SMU v13.0.6.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h                 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 86758051cb93..41cb681927e2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -92,7 +92,8 @@
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
-#define PPSMC_Message_Count                         0x44
+#define PPSMC_MSG_SelectPstatePolicy                0x44
+#define PPSMC_Message_Count                         0x45
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index c48214e3dc8e..dff36bd7a17c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -272,7 +272,8 @@
 	__SMU_DUMMY_MAP(SetSoftMinVpe), \
 	__SMU_DUMMY_MAP(GetMetricsVersion), \
 	__SMU_DUMMY_MAP(EnableUCLKShadow), \
-	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),
+	__SMU_DUMMY_MAP(RmaDueToBadPageThreshold),\
+	__SMU_DUMMY_MAP(SelectPstatePolicy),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
-- 
2.25.1

