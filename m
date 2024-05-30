Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE3FC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F7D10EBE9;
	Thu, 30 May 2024 03:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lO3NUsq";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C1610EBE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+JfA9/vFExDYCnD0wsp3tBJkURLRJC5dX4Vt7uuwkfY2Hpf4vky/wzaHn/bSOuNB6hMCFync0BrY7yl3mDwYu54AAovplLD3ykzTOhqlWXWf+PY/uc2t7MjVs/VNmr0axfmUdw05hu1k7+7stsRdRxp6tMaWPN7pQcoxdEFaQMwLQB1Pqh6qBlESVfQNRkUmC65rt0sd9QHZWBVnUeHMC5BXMBEhXEPfgFbqkAj9fuLfa2gI+gj7fv9HnKrj47LkdkrkfHN7a13FVN7/Jl5vVKajtT1ZwBTbUQ4DiFhZoxQr0Fi99rC22UdzxG4WJxu/IILV42CgT8d2rOmv3HAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0J5zmZWVW9sG9GBkwSXkAYPlNBcMbF9o/F6gEpqaKLU=;
 b=nxfngHZTFpkUu9EJTk3mCvRpr12j1LmQ5Ej9/e/ZRdbrgO3MnqhsDTEpxrnMpEcIYjfYOrinbc/4UzE8sQo0SLkcp6Vl0iIYORAMDM3w/PueOtOgc0fEcPMKwxQNqdYj1QV3wRmmfN56/nOjaQ6H3lXtp4KwuWE6iaLAtx+4d+CAYOXnrnOZLUxnzGtagg2ZGIHCZx3/ouQLwVwx60lBa6f/jI+WW7HiNlIswE4cyeBomhD597jzyPTf/YHOPPuvF6ABI+Xi3TU8GJtxllgLQEDorgDb4kt3ge6I2tAxuqF5A85z9lr1DiDj8LqRvhTJmU5Bl5kTXBAbm23HXKiKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0J5zmZWVW9sG9GBkwSXkAYPlNBcMbF9o/F6gEpqaKLU=;
 b=0lO3NUsqYCu64Y7KmY2HLla7N+bzHjfUkqKBk+AS9gSZuqk54xBYASFuaXflxWeIs3zDqSDnuTZUzziFPHS787FGOuNFb/GayyRszqRmaJPwel80pvDOeUztcCD+77L/3NqygNZbceJqwLpZbMsgMSYax7mzIV5mXsdGldWGPcY=
Received: from CH0PR03CA0242.namprd03.prod.outlook.com (2603:10b6:610:e5::7)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 03:49:59 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::21) by CH0PR03CA0242.outlook.office365.com
 (2603:10b6:610:e5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 03:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:49:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:49:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:49:51 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 6/8] drm/amdkfd: remove dead code in the function
 svm_range_get_pte_flags
Date: Thu, 30 May 2024 11:49:50 +0800
Message-ID: <20240530034950.2341520-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbeb76d-4d3f-457d-0f6c-08dc805b9409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SCWIyt5wUTzIO8n4JEfHWjZsG9Lb8YV2OTTQsiP3OWtiy4dimb96sBY3TM8N?=
 =?us-ascii?Q?1nqUojAAYNHEvFHT9xqEVR1GJCRwq9tuTyHLeaiLBecD12iqetykoILZw/FH?=
 =?us-ascii?Q?2I14sXgaF/h0fYnHzaFkb3zp2CTJuFAQsjtubKaprduYgj3eY4Npv7Cfb38n?=
 =?us-ascii?Q?irBG6y6dBmZxEnyX9w2dWc/psO4sW6BkT2/Kof38Qrmufk5PKh+nCwCiVTtV?=
 =?us-ascii?Q?cA8WM+SPHnlo0sslbhBD+5MAt4ORJmx0tGegzZP+PmaGZXaLof5ckddKaDO/?=
 =?us-ascii?Q?OpNUi6dmOeZOgZt8ic7YVUlguM6aTyQ1fsE1zJHxGATwJHIrrOnVVKTNga3V?=
 =?us-ascii?Q?KMdin9R82SeOpeYz+XeV6L3MFFIfyXkP9ebr9znEQ/ZxL0zzPkE8hThy+EZG?=
 =?us-ascii?Q?SCAJ2jBE6SvpqZwRa435JUOMaP5Rd0VagpzNniMrJaSJ3LB9d2dRz5+X+cmn?=
 =?us-ascii?Q?XWa+YRFS7KFg+N15UcqvKTGSivmtCSqikjrJJX/VyXhf/CrMbIP90kCVr9gs?=
 =?us-ascii?Q?IahTTtn6qe+bJKLI3HhrCoiAfd7Pv2N92cw0CS3tcfvjZPybZ1TjnoGFXLzo?=
 =?us-ascii?Q?vAsPhePKWgV+O7duH7cZVjazgyBLXNL7RUI2+V5KSmKUmTbo801Q6uvSFTeo?=
 =?us-ascii?Q?0nRzxuk4mooVQm4Y/sXHoXTtetXPVBzGVNjAxbI3bmOaXX5WlXRy2YmKk9En?=
 =?us-ascii?Q?/fv6faOP0fro5nOUJMQwOFZBSwVUhvJg/TNiPnT4qSd5HtWfg/rAYViTClS5?=
 =?us-ascii?Q?6/4Vg8mGDvxZbP+hfwO/df+OfGJwnLRWVhg0aMex1DpTVoy675EVMZW/cQFk?=
 =?us-ascii?Q?ptVAoqq7lPSkc1aDu8ScefX6tPVHHOMu8Yspz7d75KjEjytSIq8AWYnFDl+s?=
 =?us-ascii?Q?AQSNzFeTBsbLa11mYDrs0iWPYsBNyq0kCzULHpKLXUuUB5mp/MGZOApHyCNp?=
 =?us-ascii?Q?ezfvG69t7yF9eXGXZdcVk1w/KTXuNDiQCVKNhMPweXWbufze4dDiNEnq5C9U?=
 =?us-ascii?Q?mugRRAE2v6H7MPYJ6MbNE9/zrABdhMETQGk6mb9jq9Gm2F8KdbLJmwG+nOG1?=
 =?us-ascii?Q?5H45k6g8Vwn5A7NShTYGD6sA7y6f29pbxR7q/QkmzI9DDfOSg6SF0kD6Jlcn?=
 =?us-ascii?Q?IZiDvG1+mA0Kox2v2Brz1TBUOWv8wq6TqQvbOVvhTIRS1U0/s5UJr51RmQLA?=
 =?us-ascii?Q?EL2nngie+r5YIPZkHK8Bry+KL9LJEkoYcVsAerr+L36JO/BN/lm7szzjcaQC?=
 =?us-ascii?Q?b/ytCavstCZHAYPnREGL19ELLQsM7hjWcZDuxpuc3zLQkLOWhuV3FV0AtJQc?=
 =?us-ascii?Q?K0uEo+NwhuIWE0ut5UQDtQSpe6oF2b4oO5jNNyJgQF7Ufmm+FjaR9i9N35f5?=
 =?us-ascii?Q?s+yevu3fiDbU89w0WLOQ0FfCA1Zt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:49:59.3300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbeb76d-4d3f-457d-0f6c-08dc805b9409
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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

The varible uncached  set false, the condition uncached cannot be true.
So remove the dead code, mapping flags will set the flag AMDGPU_VM_MTYPE_UC in else.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..bd9c2921e0dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1171,7 +1171,6 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
 	bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
-	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
 	unsigned int mtype_local;
 
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
@@ -1220,9 +1219,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 		snoop = true;
-		if (uncached) {
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
+		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			/* local HBM region close to partition */
 			if (bo_node->adev == node->adev &&
 			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
-- 
2.25.1

