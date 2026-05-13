Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D8CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 15:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D72710E0B9;
	Wed, 13 May 2026 15:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f3WSDBXD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096F910E0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 15:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEM/6xQS1cb/pxfJt5fYMqWhNPdy8DBjwZ+2Sih7tSCBeDKwBYAPo62nvI2KRnqgpOmvI5brF7pTh5+CGkIKJpUie8J4fxsNpvP3vyFCrbot8o8aDfOyu14YTD1BILv2irM2WSMl21ka+uUhwLma3NXZBbxMtvBahXluQvClIywwW7pw7JE45+Wsb4NMQQwd/DMMexJ7Rj1svgqIjKPzpTC9oi4NRFbMagzfy69BjBZjbVXlLST//E1cLN954AXa1YHYB5Ws2m/YuXE9v/ATzgFGMmUS8mdD2KzpA7t0M4nuEmcazoj5eeXYgihFg9jNxvvlsHdij/JQy1N/e6AHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLCRvSGqLn91ZNE+JIdxjZ0NzP/kr1pj7EsxKl2qUi8=;
 b=KUQom5a3OZq+GV5b4OBtJKd1u25E30PE2iTe6W0SrFpSK56mR5AYgJC2A+RuUbypWrDgaX1jHQU8N5ztrvrgZwpSH73f0dB6VqooNDTU3ijhjH5pIKaDoNbEbjr6BNndyqe9kvq/FliIXDUiPvZyoDegNp7eIJj7BBregpjiUqQhfepQGBDuRlbi/t+w54DJxumJuztfhVKytKD2GP3Fu7SJOJPhcbTaRIoDSDRx4wi7wG05SYXmzd3l3pLjM2dXRgp3Rn8EKPXYdKWSsG3lQUdyD5qAMtLPom4Kkwvh3DF+BfGRuuzAazeMU68uUP++5a1vGcleUSneOtxdSvS7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLCRvSGqLn91ZNE+JIdxjZ0NzP/kr1pj7EsxKl2qUi8=;
 b=f3WSDBXD/DW3CmnlktkojEPdW8g4cE4+1F35/vsX9mPOmFi2KGDW9BfzSyYg4zS0UkhmE9zxCuPovuqgqkT6g3mPtHL2JOp3u5rimKzk60W/xfg0Fw0NJoNl1/Xy4j7/21ipxqTeWStQrnQzwwruDeWA+Y/bnBc4iKx87Ig+nE8=
Received: from BN0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:408:e5::17)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 15:39:51 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::ae) by BN0PR02CA0042.outlook.office365.com
 (2603:10b6:408:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 15:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 15:39:49 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 13 May 2026 10:39:48 -0500
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <jonathan.kim@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Fix OOB memory exposure in get_wave_state()
Date: Wed, 13 May 2026 11:38:56 -0400
Message-ID: <20260513153856.2589767-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 67aad6fe-3e0e-4952-04db-08deb105de17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Jrkfh87Uc4vmM9ENYdj39ppiBMe+Lr8IuJdpL0x+cDkNQBsDtGejwPyPMwlYY3AWZ0TWDjTsLg99MtghbrQxBbDrYQutcX/dnOeJ0zQwxgedX9KwzMZNetKU0z0rx9abOb7tDG1OdK7WrmSmY9pemF0uu4sb1luUCEnr5lbK2Cc9/4lZQ4c5YT5UtCIt8PTaV7sqUsZi7J154Y2P0i2vFWcNiP/UH+W43rifm2BAO01A74xAFavmxBuLCaRXaXorrTrQ/5eSyQjfl0Y+W8Ux64NPz5sNYjWGqISHgkgW9JQZsQHz6Whfbs+8PKVWPLqt+WFYIefl7Qor4uiyueHK/7wCdBYMTxUic9RToapAoKiJAcUcMNKrB0+xwkDovbOfazjKaZ73ySXE3AyklZhS6exrxfbfgmt18kVXr9PlCLGccJ4bCC2SV+1d+kCAGaJWqxZ6/4mPnhiIxEpg0EACTkgF/XKh3/vf2a0WAxm0ahpU9n3elg4zfwa7z/BICMS+UPFE1Q8clLbxTu4ncYgb5i+nYGjv8WM9+mWnVG0UsWUxWMlBZQwTcPzH0I55HI3cMfrHUXgfcALsVGHPxD4pEEW9Sax8ZqKu7yyak3u4NKbrMHOAf8PMShbjMeFeVZFHPJL+kbLXoeYd3G2NVkV/bHN3PI5EvxVXOJPyyEXYQIDibnobgOmLr0vgYTWv0+ZXPfMQNKoC1GTkv4BrAyps91Q7LTR+14rH5Wg3Gwf1kw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CZ1JtpYoqCT8xzYJ9CeEXXeZ83mi7VlCJ9pdWJrOWSPEutiOHlXuwq/c9EhvOiPd4F9WhMmTCfoG3ALsPI4Az+LlQUxmBFubsu9Uh6k1GvnVW3f6Yz70ihnHFzAO4Tr42IH43atdDNEs15E7aZJ/4/kL9OFovz9xQtvqXUqjzMiqxUelNo5hoagwDJKPEOwQ9OLWnYzvyJcVKpwCppOPFhCBIFD6Q+mWeTdQ2QYY80Jd3EKTyTpaVFV9grodGqIyui/prlQgymhEwM/WvjYoLSzDS0sN4PduTXgyv68PQ96fsdfqfxFzKAbz8AOQ6jgHBEZPKkPDWivARyDp5MlipfmfTGxeiKk4YsJhKT4aRKvuMCFSy0vHLvskYJo5wKZmyjHPJGI+7cE+t58lUa/iCeZ6VBYWOOkyMEHT9SawNaQBxgpbOEdA5geG7FLe/d+D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:39:49.1756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67aad6fe-3e0e-4952-04db-08deb105de17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

The get_wave_state() function for v9 trusts cp_hqd_cntl_stack_size and
cp_hqd_cntl_stack_offset values read directly from the MQD, which are
written by GPU microcode and fully attacker-controlled on the
CRIU-restore path (via AMDKFD_IOC_RESTORE_PROCESS with H3).

this leads to an unbounded copy_to_user() that can leak adjacent
GTT/kernel memory. If offset > size, integer underflow produces a ~4 GiB
read length, if size is set to 1 MiB against a 4 KiB allocation, we leak
1 MiB of adjacent kernel memory (other queues' MQDs, ring buffers, KASLR
pointers).

Fix by clamping both cp_hqd_cntl_stack_size to the actual allocated
buffer size (q->ctl_stack_size) and cp_hqd_cntl_stack_offset to the
clamped size before performing arithmetic and copy_to_user().

This ensures we never read beyond the allocated kernel BO regardless of
attacker-supplied MQD field values.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7232a0117a00..b311e3918eb9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -395,9 +395,13 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	if (copy_to_user(ctl_stack, &header, sizeof(header.wave_state)))
 		return -EFAULT;
 
-	if (copy_to_user(ctl_stack + m->cp_hqd_cntl_stack_offset,
-				mqd_ctl_stack + m->cp_hqd_cntl_stack_offset,
-				*ctl_stack_used_size))
+	u32 cntl_stack_size  = min_t(u32, m->cp_hqd_cntl_stack_size,   q->ctl_stack_size);
+	u32 cntl_stack_offset  = min_t(u32, m->cp_hqd_cntl_stack_offset, cntl_stack_size);
+
+	*ctl_stack_used_size = cntl_stack_size - cntl_stack_offset;
+
+	if (copy_to_user(ctl_stack + cntl_stack_offset, mqd_ctl_stack + cntl_stack_offset,
+					*ctl_stack_used_size))
 		return -EFAULT;
 
 	return 0;
-- 
2.43.0

