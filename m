Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33241606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VYEWaJ0x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7979E11283E;
	Fri, 27 Nov 2026 08:29:23 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F12110E00C
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 08:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHwe3AsmHYHuyIUMf6S/CxByKM5tWP3FjTL0JDrcxlDAXrcXhy2g/3DUj/I/4UzZtYktva7P5PsJZmlJRTKb3FVlRmWxjWGrxOdUzKmYEjgaBEwhzz1a6vwgYmpHHeDY6PVQ/IqQ1znQ5P4ii2hj3AKyj9YfpW10Lkgl2Rf9pfbxxZtzuHCMbn91Az95COlXbngBgA32o4njceZWjdzK1uIFzeaDsgL/xitWedR4XAsU7hHigVwONS2vsmjg3Pxx9ZJGq08tpycjckSvxz1fGAJajLJA31O05+qL/fTEK8LmYBqNnYkD1wgHtrwA6wFdQ40Lt+548EOFOndWoVmw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypdRP6hKW4EJoShgwUeF4vpDi6HBuGbrmFNg8qW8fko=;
 b=LJ8v5zCGzrTow/qmjHaPsNamvtXgibsVx9YWvKJFDLzKu+L2oznxvCY2R22JWMCVKZoMzRMULWO7bG0T1l6wtWAHeVNoM7WSb6BNshBlV49alCgComLX/SXfJN5lklYPrX2vF6HNLSnO8IfiHSavFDdQVpsGRLaeqi8GfTu1AMpH8UP5jDdzKmVsz9GJA8pgQuoR6vo5yFfpY78yGOZEEzYY1xmc4b2Hrs7KFWODI6ts1kBlefG7oqwBctSZRojllhrJgxXlCu1nxrzAZmMCV5S+MB9EdkJx8NvBxzxntHBLOgS5AHvFeFFoFZ6WecrNGOz3dMsCec7AGr8TTVd/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypdRP6hKW4EJoShgwUeF4vpDi6HBuGbrmFNg8qW8fko=;
 b=VYEWaJ0xxwS/zA546QsyVtd4/43dBOTbzSJpOvDpnT6IG2gUxxPn3PNVjhFZpSS3AU/jghQ57ecVNuFpNc+3ibELHLOcNvt4kSLyHfdIZPaC0X8PwKIbiG++GXDoCU6r3V5ZaG/zcCQDMkf4iGTb3PmAZl2BKZp3RvOJEsgCTMw=
Received: from DS7PR03CA0149.namprd03.prod.outlook.com (2603:10b6:5:3b4::34)
 by CH1PR12MB9719.namprd12.prod.outlook.com (2603:10b6:610:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:29:03 +0000
Received: from DM3PEPF000265B1.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::7b) by DS7PR03CA0149.outlook.office365.com
 (2603:10b6:5:3b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Fri, 27
 Nov 2026 08:29:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B1.mail.protection.outlook.com (10.167.23.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:29:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:29:02 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 02:28:59 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 0/2] drm/amdkfd: report realistic free/total memory on
 GTT-backed APUs
Date: Fri, 27 Nov 2026 13:58:52 +0530
Message-ID: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B1:EE_|CH1PR12MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2f501f-073e-42ac-96cd-08df4c607e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|261022105027099003|10067099003|261026140227099003|56012099006|261021121427099003|261028144727099003|261026121527099003|261021123027099003|261102123227099003|18002099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: jHkNCnfcaZwS0xa7Kk3rco3snousf6XdssULSmRqQYEsCOjz/1469Ifa89idZ1s2sV//aLLCscXo5z1MJR0bBU+V18tmcUIIrcLKcZelILvrDmS3b2yZ96SnIhFudFGH5bmnrnRBbX9WBeFYqfAfPbTumCA1hoKkDOycvWAB1CjpjCSfp65pYaPzbCH5wrDmjljF0zHREV8CUibN9WofrbK5te+PPLutLNSp5xhzwFXm6dgBk2GKe3ixK0k+JdlU+EySFiFr+2O7QaxhX9oi88N5dd7QjiHghv/OsK6bfD8MkRo0YtcKj9TiqHRx6Pea5R7GcAjAeDtD0qN0YtONLIytvXTxkOjOBmd+dC4OPn+pCNciRKMI5TEaQ3TlHOZy76tbh0TeJM0X5d81NDD5nIQLGa60AkGS6PS5u38vlLlzu2z4nRI+n7YmmLw1BczV/Pv/au5Lo/q8LIMwPpOGqmXzLwXAITPq/2b+oMAL8OEi1p79Svxz5HgHpgn0EB4iycYKVa2o5CYJdTr7rM3OSKEwsBkcdbrOmQ75ouFkdUI8pKWNTFqcaRTYCk2F7hzoUYTDmykFlRoIGLiw7Fppc4kwZHdRJovfFr5UfKT5Uni1zL3YwLXjGcC2tJyfdjBHaz2DPAKomBJ117iKTKiwiIspmqYtDFYhr1vVhi4QnE0KlT5L6LnkiP+gOYpyJEdFsNtsjlcDWA0VyfvUk+GL4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(261022105027099003)(10067099003)(261026140227099003)(56012099006)(261021121427099003)(261028144727099003)(261026121527099003)(261021123027099003)(261102123227099003)(18002099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uwXEFufSklSMBTNB5mYfBTuSpeoCrupUvDeHRwNaNz1xbYYnebo4CuQyovEuxZ60PYcyB8ryhLzBxogxNMVwvKWRvLV+ywF7KW+IutM8oWT6ic+musV1XDzIfbgNkbUw2KpeJi9tVrAW4gFc6yGRukuRDSLLNGA5VNwQDKH8lu4c362AtZreVW4VrmOFu4A4+LSm85kBSEIMQIxbBFnVF5798NeNURUNJEb6CVVONiiKNDEMIYFXib6tIM/XJd9Ohp7Lo4VF8ou9T2faonULTaRp/mufxRBkR0cbfa32PgnSrbEquDDlM1losz06zuMJ2tA1l44NVnAkVynEwfK2D22JeIQH2FfevxnJo0oe2qRc1QPrUAiNxHD3WeOwn3heq3skVPebdn/itdl1agkYvu5RoampRt6mYbDtlj46Wk8JxgCLuGBFHA4N24OS/rj1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:29:02.7697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2f501f-073e-42ac-96cd-08df4c607e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9719
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

On APUs where KFD serves VRAM allocations from GTT (apu_prefer_gtt),
the memory reported to user space does not match what can be allocated:

- Free (AMDKFD_IOC_AVAILABLE_MEMORY -> hipMemGetInfo()) only subtracts
  KFD's own allocations, so host memory used by other processes is
  ignored.
- Total (topology local memory size) is the TTM pages limit, which may
  be above physical RAM, while KFD refuses allocations beyond its
  system memory limit.

Frameworks such as vLLM, llama.cpp and PyTorch size buffers from these
values and over-commit, ending in the OOM killer.

Patch 1 bounds the reported free memory by si_mem_available(). Patch 2
bounds the reported pool size by KFD's system memory limit. Only the
reported values change; allocation limits and GTT/TTM sizing are not
touched. Both are skipped with no_system_mem_limit=1. Carve-out backed
APUs and dGPUs are not affected.

Tested on gfx1151 (Ryzen AI MAX+ 395, 62 GiB RAM), HIP free/total vs
MemAvailable (GiB):

  ttm.pages_limit = 80 GiB              stock 7.0.0-44   patched
  total                                       80.00        59.69
  40 GiB held by another process
    free / MemAvailable               59.67 / 20.39  19.60 / 19.60

  default ttm.pages_limit (31.08 GiB)   patched
  total                                       31.08 (unchanged)
  40 GiB held: free / MemAvailable    19.16 / 19.16

With no_system_mem_limit=1 the reported values are the same as without
this series. kfdtest (KFDMemoryTest, KFDLocalMemoryTest,
KFDTopologyTest, KFDOpenCloseKFDTest) results are identical with and
without the series at ttm.pages_limit = 80 GiB. Not tested: MI300A, dGPU.

Strahinja found the issue and wrote the original patches; he is listed
as Co-developed-by. Strahinja, please reply with your Signed-off-by for
both patches so it can be added next to the Co-developed-by tags.

Changes in v1:
- Initial version, based on amd-staging-drm-next. In patch 1 the bound
  is applied in the amdgpu_amdkfd_get_available_memory() wrapper, since
  __get_available_memory() is also used by the is_app_apu allocation
  path after commit 32abf4fe544b ("drm/amdkfd: correct vram_available
  calculation").

Priya Hosur (2):
  drm/amdkfd: bound APU available memory by host available memory
  drm/amdkfd: bound the APU GTT pool size by KFD's system memory limit

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

