Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5D5C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 11:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3759710E362;
	Mon,  3 Jun 2024 11:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="44dydbbS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A2C10E362
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 11:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFTJhNdfuJrs3OfRo6xnkxHFCVFFBO8I9AGWz3UoqWc1KBTs+0Z3NQbTWDmnQrcdfUNbYVS0H5MwXggn2lJtFKRvn/IJww4/mrawLoeUAjSSbWbmGXjyq41zripV32gf1SQyLAXeKu7LLchvdRS8xqf7+A58HPa9131ClvNx+e9EM02KsdhubCDHyKiQxhgdJRvMVvPYlc/9ciK3+dQL/nCX9K0M5yUMOSY6210lYknQDdYk8ethDJORYDlMTH2OVAgtzh8c+j+Xc9GbqRl44pYW4FGD7S/RQgL/UiRtobx29J1rusJMEGhGCUwuOL8O+3GbxNQuPltwf3Snmqrs+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b8twvmtK+S7NkKojZzwtA93YSWs/cSyu1syzYuobso=;
 b=WdQRIJ1VwDP/Qx9elQGZAKqEF4jalW623nYto/iOF8KpUYP7EJ/ii+smDZyfGgtA02+10c0gh0saPG2A4rHjP22vsOjWHpyEtENWA6VmA4dL8+CWYbSNV3GTW6q3N68/w6ObiAnk2Sa38K1fDj83D+Havas2zmVw4CmuTNxvEF6lUtharg28h06nG/WizyLVtLRnwtGP8+XV4kesmyZIhjNrN99ffMQYHGY7YwoOTkcR5J7c8KAE7Inq1e5YQ9YVt82wwY7UEtMmnPGWfpKUR1SKmCU1/KPzbZVwsRyUwqeXu2QDa3VjIgpoaAO98acw/dG5Jr3QEToAsWPKKTUrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b8twvmtK+S7NkKojZzwtA93YSWs/cSyu1syzYuobso=;
 b=44dydbbSdfwU1H7dpcBA4R1ezdIeNoM5hH9cpET2x1l5pPM9VfGF/HgQLrpN9fejW4kFuzrJBTeoL22lovOTi97qrQ9wx5y+wvVk2BeissUhG4uoRH32O+LYoc7hcz3vMrGLCDc5tOucGhThyuf8SQ0+WdFuoE07EEcVWM/4Bik=
Received: from CH2PR20CA0026.namprd20.prod.outlook.com (2603:10b6:610:58::36)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 11:46:47 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::66) by CH2PR20CA0026.outlook.office365.com
 (2603:10b6:610:58::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 11:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 11:46:47 +0000
Received: from f9br11f2r-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Jun 2024 06:46:44 -0500
From: Yiqing Yao <YiQing.Yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <haijun.chang@amd.com>, <horace.chen@amd.com>, Yiqing Yao
 <YiQing.Yao@amd.com>
Subject: [PATCH] drm/amdgpu: use local xcc write to flush tlb
Date: Mon, 3 Jun 2024 19:46:07 +0800
Message-ID: <20240603114607.4143848-1-YiQing.Yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e259f2-7a8b-4477-fc09-08dc83c2d94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1pHUNTery5pXxO718Igiw1b2mPVTlyaz+nnp/MoG9To8qS/mGfduPeARnH3Z?=
 =?us-ascii?Q?hCOshmTU8y8wQia9t7pq+Upns9v/XH36YRNcAats4ubBc0b9Kd3lX1xnEM7b?=
 =?us-ascii?Q?BKMDC/V0t+h2xaJ40yRks5RjgNFPdIR0UKBl9ya5NPzyAwmrjPzJ6v3ATAsu?=
 =?us-ascii?Q?c3pKkFD1s2wRj3WMlUytmP7/Hhq9VO50aycIBQXWzE6v568q2QpJbqpnzF2x?=
 =?us-ascii?Q?2ZM5p966tn3VyCPrqSmhvh6EwBtnGK2FFnA/MlQhab7YWaPNxh0PZrCzVflN?=
 =?us-ascii?Q?fXCrPtWUu96Jms/qBVCIxddvdNKifIbctIHb+oIDcNviOT/ayw6vf77RCC57?=
 =?us-ascii?Q?r6TEJ7V9n1D6VMebRgfTSG9A2zFaZXZ6bqgMBI9dOHjKBvdCiqVV2+AqW4vy?=
 =?us-ascii?Q?bbFdaDiN2HE8aulkjj7LrH2JG2xxfypf0f4GIOO7mmS4pQJ+vSdtG6f6A51D?=
 =?us-ascii?Q?dpZvI1E13rU8GkAPbSsX/FlDHU5fvYW+qlZliKpeYTNdeiP69q1HIBfkvPYA?=
 =?us-ascii?Q?6OfG7FDUFWy08nzTt6N+Zko1gYJwIykNwiKcNlGNw3uyt/3mJ2k8MMR8IoFL?=
 =?us-ascii?Q?GMZqEd5dngnwTRVowZFcl4KtmN4hAgin/zr+UCxO/hL1UqATQjDlwU+6Tdez?=
 =?us-ascii?Q?+sbIwGrSYqM4AbVfccChQ7ESoBFqLRcRz1hHg/BPhR1lUXMqI6QfIrmSZP/3?=
 =?us-ascii?Q?UwDpb1vuOrbuELWo06Yu9wvi5tC9r5TH0xFMXrOdIYoluvaWLs8EU5jABt86?=
 =?us-ascii?Q?bC4MfdF/jULNNT+r8lgNyDOZUFrYuy2VSgIK3ikkRN9I6shVlnjsSmnj7kzl?=
 =?us-ascii?Q?tXNGkymF8fIsXACcx/5VDo+B2SaYpqBDLkK1MozOK7xr/UvUu18y2SzQnvSM?=
 =?us-ascii?Q?x+yIhrJttybWmHtJnejv64qQdS18RoJC4qqlGiukO8htNmlQfdRCDTLxse03?=
 =?us-ascii?Q?U5QpDxT0WAMoGTl/JNwUfrJFe6+zyJqc26dCXdrac6Gqp4z+v3pUXhqzwsye?=
 =?us-ascii?Q?n4WRsNQ3elx2VVbbWySMKfLVqEG6jGcIl1Ueden5HN1fcCm3Ipd3Dc0/Lctw?=
 =?us-ascii?Q?TiJLOa6iBZ7Mar4O9i6VhjaVM1n9iA/Mu5z31HYWYquU8o3qTDhnsKXdpzAN?=
 =?us-ascii?Q?/sbDqM+Y17Hr/tXA/YlCsgSkekmprfDUBHClv4pCfjTgiMXOu/xuoTt4vqsH?=
 =?us-ascii?Q?4W1lDRAbnEdDpWi7hQ7hy5hyyNQIz4gFygBjfWaWdRgYC6B5mf0oYFRK63A3?=
 =?us-ascii?Q?yixfZj77R8sedFSHAaInTLSYzAllubVVH8Yw1qixnAyhRTK0Zz24Wfas/8zl?=
 =?us-ascii?Q?KkEnIsTGc0p8/i1Tf3sRYRzBAp9xSGRAk3aNAX34Cmce7wNLMLscHZkw9/l8?=
 =?us-ascii?Q?rzKfgTXfGn6B9URwOnokh6L5Sq99?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:46:47.1803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e259f2-7a8b-4477-fc09-08dc83c2d94d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

When flushing gpu tlb using kiq from gfxhub, kiq ring is always
local as xcc instance is selected for it. Thus using lower 18 bits
to access mmregs inside local xcc instead of full address used
when accessing regs outside of local xcc.

Remove redundent code.

Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..864fea31c354 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -853,8 +853,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+		/* Select lower 18 bits to write in local xcc */
+		if (vmhub < AMDGPU_MMHUB0(0))
+			req = req & 0x3ffff;
 
 		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
 						 1 << vmid, inst);
-- 
2.34.1

