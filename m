Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618AEEF070B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 04:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE21110E246;
	Mon,  9 Feb 2026 04:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGEVt5/P";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C9610E185
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 04:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXDLEdwF9lcK7gL2QorNw3Zht+U0LpNd1E6mYslO1/0lvxGPxdXHBeppoSyhO0CyfrWxpI4tVNetSw2p7S1zYBBmDu9v9722aNDlvpPOfLxnJCg/wmOdcOoVMYK18/xVDD+duyXj28a8Ig4VgnZ3yCw+6xUCpNJDNr4YoU4dzwbQvHOVBlnmLWFSJ0cyhFzJTiFrkp31yNj+fvR/VSBV0tAMjoCRQcClN2x5jx/3Fw5d/0vD2hNv4hMc04aNfJz1jO5lVXI0c+lQCVwcL6/0kqLzJp/7gfUGt9PmFWE2WDf8kYMj4MeuRGAGD8hlDoWpjfaeThsdxmpj9UBsPpnmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=nLVVZcjV9hnY/31JMigU/fu1HrxLYFC1oHbiidErRIBka8bQu53v9wV554pTMUysnL+S+E/ibGxctoCfUNAF7aXObaAbMPb+PAUjmCC8dYt+g6ZSDyoXCEJfobfu8wUasuuZdqO7hsxh2MrjDeHNi8KHPrjiSQpsIaeJrdYJFLMHjigKFheDgIguMEp9i2iShu99ssZ4bjUYSAZWAxK4uMmcmYW8CT5oxYuPSOexyGFeZaCCblbMfOaRV2pQuW9DLKEBkvV7Wh4ICQKJrAgfFQDTyRDnOTdnRZrk738LgIzOs7i7+BgVVdo8ezeiIv0aHHhSymsPucHoggTzU7tffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=oGEVt5/PLq93ljlfus/GcG5pGvVq/wTIY/B4wBurnsUNoS10P8pRSste8/qz68uSFBGvDHO9Z2XFZA2khXLlsj6A9M3A0G0YUf3o+/pZHyUmDrD5jV76NZYR6MNWWUUasaUbcmkPjueqvG4XrbdU2EaIQm3Y6kOCBin5iLzcsZU=
Received: from CH0PR04CA0037.namprd04.prod.outlook.com (2603:10b6:610:77::12)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 04:57:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::81) by CH0PR04CA0037.outlook.office365.com
 (2603:10b6:610:77::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 04:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 04:57:07 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Feb
 2026 22:57:05 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Mon, 9 Feb 2026 04:56:39 +0000
Message-ID: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: f4015e41-1125-4ce9-33bc-08de6797ad0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YNGEKcxR+yW5kK3amlB/9DHgTiRUrXnykSZPR6nS5yL5lR8vYd2zjMSu5Ecw?=
 =?us-ascii?Q?R/VdAxzdwoJ1rPGTJnMdmTnH8RT1puEVLGODNKR1Ipd6imXRCrxVb/AztACW?=
 =?us-ascii?Q?0t0NeBXCkfo9UP2+FeNiNnmWXYAhp7rr78/WkcWrH+YiZdma1VOXxfZSNGwX?=
 =?us-ascii?Q?Yz/GJhDDRJgTWq9Af4ldCr5mTOzd2SbKQyXYrkAgekVg/8a387NPJUlhC+uj?=
 =?us-ascii?Q?lBHK+uOVBAIVIIQar1NUT0pN84d8hcg0QU6RRKioagBWRFR/ArPRftnPrZIE?=
 =?us-ascii?Q?mkSoN8Eu9r16uBQjz8VL8O0w99auKrhABgtZxC8RTU4ORprZT17tGIJsi8H5?=
 =?us-ascii?Q?hN2P0r4gofNt1Mhz6npbKn40c208XayRrYQzVvf/KKiGnUWWljyJ2v9zLEMV?=
 =?us-ascii?Q?gsm3QUgoOwMBYAYc0R7m1eWjRqapI2wW6OpJBmPjil6NXKp9XDB3z/ADDVBR?=
 =?us-ascii?Q?TCV0qVMCwHue3e9jjjR0Ew8Omlu1gg3+vo1Nk+Vh8H3FJdbAtOr/1Zi8eCBx?=
 =?us-ascii?Q?MfPzvgEf6dr/QCOpUSDgxrVOW8ylXB7yjhH7Z8z3ThLeBx8/P+SvPvO5acBX?=
 =?us-ascii?Q?7JbPp9JD7laCCKNJK02NVVey4cd+kYjaBX3HwMOtsNYCZ4cavEB3uu35pGeR?=
 =?us-ascii?Q?AzUvVk5udsVpHk8vX6b+K192orwf80xv9Siw64duns8V8iMLnvD9mMmbWdSQ?=
 =?us-ascii?Q?oNYezh1C6Ww42Fkm+IUaQyNWDN5lBAGvCnaDjblhNSdtTk/EtUDq1ITOd5CO?=
 =?us-ascii?Q?iu2oWyHs6Cg6skd0rsxu9Y/1fAUMZaC3wei3Cvf94M8vRT9fidEZMT6IPA86?=
 =?us-ascii?Q?7IC4GAKIZ51gCITcuquclJR9ByYA/PcNXOBC0muPE6lRfYsY6Rb4kLsbIdJ6?=
 =?us-ascii?Q?s0H14AVCFa/WFc/rv03HP3kHjsJ9THlBObNGaBWWMh6FIj/GSMnf+cTgJpZs?=
 =?us-ascii?Q?eU21gsWZSMobM1RY112u5OS/sFSwieMUVxeOaFmsIk+vuPK4azEG1ZxQBKkR?=
 =?us-ascii?Q?M4lKNXkCB7jKEMTcYtyc1Q/qpPPS9UdDaDECHpdL45DdqN/8Q8n0R5n1pfuC?=
 =?us-ascii?Q?1UyQWBKW79mToBo+gANAAfhCsUoHJBJ387rEt1HqJJn53VQC6Bh+G2EWzrDP?=
 =?us-ascii?Q?O3my2p+LHuWeAC44RGeIBQKurQ/eIDo0ann0BqOcb9V62lTxyfuCkDeNw3lt?=
 =?us-ascii?Q?wTaCBbcJW8/PYpbNgf1xomEBChdSOpjR8FO4wQ5Ow0vSlZ/m9NCQ7nEZxrUy?=
 =?us-ascii?Q?fBq/beEtKSSFD4ECZCcIa7JnIWDOoI5BHEkH1ayneDk4iOwkqMmtWKd/x7zV?=
 =?us-ascii?Q?KMuHwaF87lCFTelgkp+P8j/vm3hExEYl0csCvYOHzdCAb1zWog56nXeOuZd2?=
 =?us-ascii?Q?iYCLMKNKpB6YvsazTcQJ27rtX4ZyZe7sVcoUozOqo0llFaCV2XklvsZAt+Nk?=
 =?us-ascii?Q?uYrXblZHwTcCrEV5AJ4WVWVc599r8OoXhIH8OFAqL9KdYjhRTQ/MwaOIDUiQ?=
 =?us-ascii?Q?H2Vm8+SPSsR8jVXqbSThP0cFQcRyVWLXSITsAbdNKMRrZ4iej6Im/2f/GT96?=
 =?us-ascii?Q?K2YV+PXIGr8xPCw3k+UEAPo3Yf5UJerJr1tW1Ocz07Hqogfs90olirX+OUy/?=
 =?us-ascii?Q?luQ2jwrEH089r8W6XVKhlXurAGV1kb+ZrvVAFUtrg/WJfZZ+g0xjN14vLrn0?=
 =?us-ascii?Q?5VoLiQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qtQYX+tlbamnUu9qeTpKL5EdNT7S1ZJGUns0oAHceFRI02SRUNvWrEg+ezVDpaypci9BRxUrEgk4w6kR6VooWzgwFHNO/czJb2+WwluvxixjX1OekxmDLUox+rzfHTMQf3Qki+CehOiygUKRsbAW/PhLUi745+AOeVoC7cJyCPUQlvLVt1pdEPxTKZVZ665j3U01xxIbe+Bg3Sg7gkZVXlp81EPY+pDlbnSRIkKZSouwau8et3IBdhnG/IW4J9tJ9m5C8Ke9Ow04o9efHt++ytJyN8628fck+1Dar1TGYi3KtuiWjfvtPebxCnf4nU4aTST88CPfq0qat1Ju1nK3Au3wt/e22c/Ahn3+B5UWqSS6D3DKiCbanF/Al5lmmGovLe1RKGte120MZJa9sdSP00Eoj5YSJIf3WkXxAu7iUWzH33th8NoPWpQXeCsRPmxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:57:07.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4015e41-1125-4ce9-33bc-08de6797ad0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

