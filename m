Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B5D5B85B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B699E10E4DF;
	Mon, 15 Dec 2025 18:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XSV2CMN8";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B7B10E4DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOqKB4rRq5DTlVrVBUZu4OG8r4Hg57h435EQIPjZnzCWv2ZSV1zIyFVCtjutwk43aSRfjlI1CO//O4TcGdb/AaUuOoNUWZR4+PAwEYtMiDW0j4CEU2Obk4MagSsxsM9StBPe0/NFxMJQqrZJHsOy6Eo4UXPhB98WOZpfvvglsDmVh8iOTcW6x7Tq3GZCj+L0wXXeNbC/2hOVeEl4f3SLceOhUb5EaeGqnF6MpKs/mdChT//s/UuMJBpXKNUAbh5IPIClmyIHetdvEj9wsRWO/CibssjQolfkLKPodZ41OwCvUz5Baj74Ijd73RXqNZwl3vUeKI62kpy3xne8F2cspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5phha1AmkuBafWeQcOEcGC5BgA+ySMUIRhMXvp833Hg=;
 b=xqwI7nxtxgKb5R+5qSclNVZzLAis5T1Psk7rQQJl269nIahRnzfvkhESb4RFIKelkE7d2ejFz+F2LpKb4MgnqaXMjPCY63JkruQTVISoJ1EUTvvygt+bqbbfBX2WRBZ3GhEKZNp8VvJMEgX7xGvBArDSgp++5gawa1DtFDlnqhV925TTA/aqOnvNJ6P2787W5ZrOEjxeenJoREt7PM/oH/+wxsLcZ6RrTrDDNyKeaqmxPgsmCjHJGGeZ3wIAZWD0SPZM/nghyRY72S27jmWGcUYfmUJ30FvNRRqrHyuTnvc0lCP8Y6zW6DuDDE0/UvJ8lCsp7rnYqFu3MRRvk8tnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5phha1AmkuBafWeQcOEcGC5BgA+ySMUIRhMXvp833Hg=;
 b=XSV2CMN81e0i3S+3qmfrrkOpKg9spIXvEYOD3AB0K4Td48EN0mHY5PPeIQR7rG5Eh/Wf0aykRgVT8HEcoVtEY0o+DXnxkzkOui7yfQIgdpm4ylfH6yBjnUupAVYDmP5/xBWntuBw9qCRL4Lo+kWDSkfdrf/9Vldj6XhScd+1t0c=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:31 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c5) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Setup MTYPE on SOC models for GFX 12.1
Date: Mon, 15 Dec 2025 13:16:03 -0500
Message-ID: <20251215181607.29132-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ad500d-ac88-46d2-389d-08de3c0612ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KrC/DKHqPBy6ur8OWWDSrMyFeou3x3PIU8B5OYUD+lwP+T4LeE+oYNKRPg2d?=
 =?us-ascii?Q?QhqEnAyNrajQNBAJNxZwy8dQgVYqcIDt6h8ujetRMXuIdzajvE7VOKFS/hYh?=
 =?us-ascii?Q?3sAOT4Z0GlokPgkBOZ8ns0mwkQj/nmeQkpOLQWyxivH5qelLClnulOzhCNY5?=
 =?us-ascii?Q?nbE38E8IG2t0uSdFACRYlvdoQwAHmUGN1zrS0dSTsdrb2NRBiKdsoEEng7bQ?=
 =?us-ascii?Q?yp7LHW/vc3Z7RhyGOHuE7UXOhzz6ihWKjBBO9vl49yTqhSA+cMdb2D4j2qp7?=
 =?us-ascii?Q?JGYfRB5hvFGAkD1nNsv7njx9yxcVSqF273X7H3W2qTNAs0masv7Ep3QlvkfH?=
 =?us-ascii?Q?iHmFJrIBlVgizFl9wS60YG5mpACwU/Bxk0IzuHdcyx1g8s6aFlW1MGoKh6Ts?=
 =?us-ascii?Q?w07BIDqErZlR+6OzhuV2yGGTyk6ZvRLIYFAYEikVaeQLYDlcxFCM8/dd1iHa?=
 =?us-ascii?Q?XStwP1y6doCMtfK3ydD3aWaafD5zkBDg8Mv78QtBxhGVaN/Fv/5QR0/p47I3?=
 =?us-ascii?Q?nTGqNSg6U/6Tbkl7/OgZATQ2fstTuBIhDaUwjem2Tc7Wdpo6RKMTTriFfLIz?=
 =?us-ascii?Q?1IPls23uSEne4mJkEFPSLsvEuC2cpghOL2udshkgUZ/fcUlpfD3qYE/I9T3L?=
 =?us-ascii?Q?n7l2VI0IMwnyTfUzJDEVX/yEFFJc0pKHPDxpaP0JGxeFi6cTUY/GYozBGWem?=
 =?us-ascii?Q?KDA9DBFtYA4A7qHTns0krD74UptaFqjQoS5C/jmQGqW1YT7BzOil9ByKGN2b?=
 =?us-ascii?Q?8RS0nwvoFivsvgKaEehffgEojWTOM2IIVlXOuCLQAvpiu2P/JZ9MTHE7dr6D?=
 =?us-ascii?Q?dpwX9WvFRVkSDGU1CRbqy2qi3TAgmuUVml8WT77LR1QIJZ2bNeVEKg13K73Q?=
 =?us-ascii?Q?2crTsSOtAhH7gOuMBgw5uJ70/JrOR49LE0n9+ZJBAgt9p+1H3Otwb/NLRcnC?=
 =?us-ascii?Q?YIRYDy8KuCLJX7rSi+PxDoC5sFAt6tM8lmmBaNC7o5nS7lW1iZbzvLtQv+AU?=
 =?us-ascii?Q?7BSpkhQi5qgMxdPIEzGB94p5hlQngv2pv7PXXgc7X1pMCBPlcWdvLyN16aWz?=
 =?us-ascii?Q?jRNQPYE8+bdlR1SmRNXuHVlADK1gsr4YGdp9Swi3UXv0OFYBymdPBI7A31I2?=
 =?us-ascii?Q?uGMLGoBeOEfoRjkWU+olYOU3fJ8qWTo34rag942HRG7xNJ6iB4XfvwS04PqJ?=
 =?us-ascii?Q?SadkvEbU3GbNXqDTDBi8G6eO9zLh/8qVSQcXkmAwJ/7D0YCdvuik0/xAInWc?=
 =?us-ascii?Q?WTdJ7Q2M/turkGX5VgdgdVer+0PztziBI6tsLkWjNXSx/2D1R9jEn7Hs7bGl?=
 =?us-ascii?Q?uZBl1MWkchOfWI0fQmtCccafBxfP9q9Qw7bFTp/npcfs1xlLxwISauZIHC9m?=
 =?us-ascii?Q?vfwGlnrxAFB+ZOJzcIrUOO+Pf6gRnYtDK40P5ZxC753Kd8Gjdm0vA7g3B8Pt?=
 =?us-ascii?Q?ql6W0iet+nGcs0iOHm4XFNhyOIa1Zdv7bx6YoTcyPzsAWdsU4bZfHrn29OJ1?=
 =?us-ascii?Q?1ep7n8oYNqMlWPba7k3tAXSAQB0izVmOuTIGxjdQBMAZkIfVL6UdnbX9tRQ4?=
 =?us-ascii?Q?RFCM4DAJ1XX3Njf8fY4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:31.4405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ad500d-ac88-46d2-389d-08de3c0612ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

From: Mukul Joshi <mukul.joshi@amd.com>

Fix it to apply for all models.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 86c0846780935..695f3cf05b6f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -482,7 +482,6 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_device *adev, int level,
 	}
 }
 
-#if 0
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 					  struct amdgpu_bo *bo,
 					  uint64_t *flags)
@@ -536,7 +535,6 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 
 	*flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
 }
-#endif
 
 static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
@@ -582,8 +580,8 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device *adev,
 	if (adev->have_atomics_support)
 		*flags |= AMDGPU_PTE_BUS_ATOMICS;
 
-	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
+	if ((*flags & AMDGPU_PTE_VALID) && bo)
+		gmc_v12_1_get_coherence_flags(adev, bo, flags);
 }
 
 static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
-- 
2.52.0

