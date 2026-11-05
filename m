Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4B606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o0j8agMv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A4C10E05C;
	Thu,  5 Nov 2026 21:00:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C18E310E05C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 21:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpVySr8h26vIQ65C/ZE4GZpQ/ozoGxkUP9q/dLDy/IvNgHnZfq8KftU0IBsXSVUx/ApBBZ33823416fo47dcH5dDBC3G5LaHvHJv5At4FA3QKwR71TGWEsf0aM9X9p+H2X4/jk3R12PvV0CLZsIw9qLGOCosOURaTKKk9qxY0OeXadgceRIak9hFdr/1yjILD/hpearg23ZDCPoMHCf3Idz5Pnp2vqPG1ClB6LCvSRThqw0w+HWY5gQDckRmtvTgc7G/IANMpthOGC+eLZMs4hoy7GD9B38hnt2uDOPYFVkSPnFmhU5WQ4SrsmE2LQJd76mycBll29enEMtlt3NOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JOLMxHSYOJDcS1Kb9UUkPuQA3IGvkDRgsyRd713hvw=;
 b=U62yxYvs+BZHMmCgUd45CWoeB/3ofhgh07vUtPGViJlZHzgLbCyDEqaDSGWrqKxLGiFyzsm3feIDN5W4EXDsxkTu1bvMwjY66e5CNuVJClxR0+2rcj5AZYBS+b3rnWeYJ3OegDUyHBBzwB3qCFAk/qD0mcsIdX9697XehXEnuhRpur020XVNSBrMwEhlIQhIjju5O/btolAK37ClMPTxOomS1Yi/1qrTWnGgVpkqs01h3L1kKkUSxKHnTvlJ3YKJvztPrXyLeE4dON6tgU4j1ZQCzegAIpFMEECJLcBzPV9hgFxt/BAoOyM/Jbfj3qfC2jsf30ORB92Yt5OVmdu9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JOLMxHSYOJDcS1Kb9UUkPuQA3IGvkDRgsyRd713hvw=;
 b=o0j8agMvHzJUrw3BWBMQne9Z8iSvnfHJNlJDV76zsP07aDbfbUAYG8f6OUgGwJ/FT2ed8vhugmIOGi9Pjz6uG4ee0SO12L1PAsb4qHNJh5d4mzn7luyOxOIkrcjToYUux3E+Ic7wZ87FX8X9JazXhwlKDqmdP0PHAwZXlhjMhNw=
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 21:00:33 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::92) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 21:00:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 5 Nov 2026 21:00:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:00:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 15:00:32 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 15:00:31 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH 0/2] Fix igt pci unplug regressions
Date: Thu, 5 Nov 2026 16:00:18 -0500
Message-ID: <20261105210020.3852328-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: c260e375-2bfe-4897-4009-08df3b7fd4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|18002099003|10067099003|56012099006|11063799006|261028144727099003|261026140227099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ncKXdg6Zw9lFc6+Xm/Z1d+fbqgdXb/NKXjmu7mLp0driY6zpuQcZet8NVCDl+B8FtmfJo8tR1Yo0SPRffKKx3uTXxqOYoHYyG1lpoPuWodeKpjMGG7EBhn2Qiiax7bV7dPBxQ1SkWbMKpnGI8Jz8E0/TuB//Ki6koMDjX+BBqbjBwUhtuu9ePuVKReEB116dTZT0Tdl4GIDKoY0n4KWVjm1r6t7wj2qMHYSyQ98p/Jj4ezjIp/g1BejWiNZ2dv4biIGch4DkvZKbzQuxZHoTVyK0Pp8xOJv1lLXpoNnkYTVa7tpMHKUKYrrOUfec+Q16YE13V9F/XQB0AkiqhKjZKOFzEjWIRFGYarrU6A9b/3ma0fqY6Mu0NR2aAT+QGY3HSlfNEwwNlNGZkTnLdIlcL9cs4ZttTm1/9iP9gdj0bYOnO/ojjXCSW3cGvFLoBN3w2NmTX2Q7Qtqql+8Ohx2p/4MCbjn1f9/kSFbaF5XpA8nmeZ0j9Iukl5E2Vk/q3XZ6rdqRV2wM4lwqNeHoVpFWRgn1hiFVeKeAau7m2b4JHziZ8tuTb1Q+SslpPlAsKbT4M7ksTaRO58F+Qbbnx7+ynBG4ojMxnGFDEcit6pd4ydnpwimMB347MAAG7X6Ysrg++PAFKgCW75lP4FdWv0zh8djQD1aKJ5xOfVxTLTEDb0sd3socir70Cs2lUB04b0Qq8BjNkb85zqkAD5tI9NKIVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mESg3TMxDwSZXB1jhEY0nCwL+WRipSC0Gxqao849FnQd8dnvmGWbXiL1Dw43L95mGCg12te79jwetln2tofmGrZg6TJQqfdu0TOStgBFV47ooYNDv3ms+p6Fxg0x12tRdbDiQVw4jB3LBAohq0MGp2/hkV5jiCvLN0prEotPuxJGc7r1eBTESeG5scuhUEPBjPOY1CoIm5ILPp5L2wNoNpcBrQs7TTNwISoAedPlZoPGJLHI40jZ1DX5RPLKDy/FxdxyMcnJfAdFdhezLtDaK6DN/EKTA0b04QVaHCmvv9WwPRt2y20PGAui8DPcVV4/hpDF7rac07xfFb5z72PZddS2LzVKyJMdO1gqDpc87K3GYXBvZXxbU0+FSO3l+53ArUwxSucgviRm38FbUsMyyjDEXn1W+3Kx5GNZ+EfEnrRQ5XemxVo3HMnWo6BcAPmt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 21:00:32.8162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c260e375-2bfe-4897-4009-08df3b7fd4e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The commit 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
unintentionally uncovered two cases of incorrect error handling, which
leads to random failures in the igt pci unplug tests.

Both of the issues follow the same pattern:
- One user thread is submitting a CS while the other is unplugging the
  device
- The VA op starts while the device is still plugged, and mid-way the
  unplug starts, causing the next (nested) drm_dev_enter() to fail with
  -ENODEV.
- Patch 1 addresses a leaked job when this race occurs.
- Patch 2 addresses a use-after-free when this race occurs.

This was uncovered by the referenced commit because the initial seq64
page table allocation only happened on the first CS instead of when the
drm fd is opened.

Benjamin Cheng (2):
  drm/amdgpu/vm: free pte update job on error
  drm/amdgpu/vm_pt: free PT on error

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.56.0

