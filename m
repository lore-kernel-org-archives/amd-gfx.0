Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A788606A321
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qk5ti9d3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E44C711298E;
	Fri, 27 Nov 2026 10:19:24 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8D310E57F
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F71HXNylp4PjheVyCElWNB7oAirq2eWqb5hargxt0XIdc4ADrfW6HFZAc5gdsQCtz+a6ThrrpLuT3O4ohjIsd5YhmFSt6rPDtsp55VmFrgkZlrX6jb0kLBNWy/J47AWuCtEcGMeUaF+/UZl0ZRDCrZ5sdCwcPuRnxe9XbCfe2QAvZ9EPHP+Z/yVceXTzmsGTT+aHRJnAzAVVzgvyxos9JALR6DYOutCpnm+z5+G/dlh6TIMxW89IxkvgvFz70SywjX/xnV0NKL29dxxCi4l9z1XaMxh8EKHS3HuBcOYm5BvDTK1+E2VcQpBsmwYbikpFMvPzuSynErQKBcsnl9gT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22GsWvPjKHGqjd2o6/4Hfr5fjarU7Gi3+GNjLv0SRvU=;
 b=rhXZvl8T4mlPYZY1MHKAKVEeW0uhHZGjDS1QBxYm1nCIRQVw33C9ylKLCXRo5bUaBYACVo1CPRQNKZ5gedLAf5IWOrOF+VqfLd8qouQ8cXoYdVULxovtO04TZqZ382xnfSLXEkPGOAJfZ/ufuD7GQJmaZAosRQIwHJ4uRFmKKtILrvuLe91tWVYJkjQddlt7XNaPzXZmEm12FdmPbmk+FkJYBeXu73hvbVU9g0e2g7cItzLg0XpwZP0WWBaal7sN8tSS5AJg23JnczvnLwuFfwx3eiJHpVwIihyK4qLPxNlkYThMjnBn9Yn4lGvUozr7V61fUKOX8s7IFMR8UZJCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22GsWvPjKHGqjd2o6/4Hfr5fjarU7Gi3+GNjLv0SRvU=;
 b=qk5ti9d3ul6RCRaXg8dc0EYMSHmFzccAGqWE8EL9GIpLMhdzQUoiYfwR+up1COARaUSx+Hue2DQSTT+q7YubD/ikrkOrLHSkfXsfM9VOvIYltXzF51oAWVfQZOs9VJuRShosT1cwAIUpw+BmGGIihnPJA774oryeFXT/PBKXSmc=
Received: from SJ2P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::16)
 by AT6PR12MB932818.namprd12.prod.outlook.com (2603:10b6:170:116::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 10:19:14 +0000
Received: from PH5PEPF0000002D.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::2f) by SJ2P221CA0012.outlook.office365.com
 (2603:10b6:a03:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 10:19:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002D.mail.protection.outlook.com (10.167.243.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:19:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:19:12 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:19:12 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 04:19:09 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 0/2] drm/amdkfd: report realistic free/total memory on
 GTT-backed APUs
Date: Fri, 27 Nov 2026 15:49:06 +0530
Message-ID: <20261127101908.8313-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127082854.112025-1-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002D:EE_|AT6PR12MB932818:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b86ce7-35dc-4aab-9145-08df4c6fe264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|11063799006|261009223027099003|18002099003|22082099003|13003099007|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: dveLX35u+ytSwgxvnwtZmI4NTG7RItyGgJrQKBfPGY5lriK59zC5ui6NycZRERh2jAqMRZ4kt+mOj9zqggzc8H3Tln3Qn1QWPe2bKdbUHU4PhVnoy1wA6WCoIvE2kM2lnz6m4fX8AyAch8lUY95dYpxSu/8AvtlK+Hm2MYn8gyFV8BAuFxjmTXoUJ1eW6gcqVDuvGCXKq//BHh9WneLA9mVUTLyan5XHY2nkbgLdCarCmqh+Vak32UylTF+dq/yy/4cseQe8e8eq8OotqzWZ11miVlAS2T7pHupzGBm1yyYmUMqeCaH5Rjnw1uka1nUDU8jvC6CWbxcbloWdDE3VO57bp1d69I1E/DLg60eLDq5L7xNmJAK6n8Dz2n0hmV8+iOXjGeqyYao/Tn3cd4g0iOV8O372+L3M512T4OT4l18Iy/rgzy7ntoUNkkfKsasiLbpkG+deU9xUBnaJxeiu44Ixtp65M98uMEPx9MXydSNwMjhI96n6pM553nnPQBW1LVuHAHnJjXnwBEpdcSwTZXKUFLu7sjOoF8FwBDnISocgBZWABvLMJIjDhD+lyB9SFc3PIscXUZTFpGvuV82UW3SJhTltnXVNCeyVQfDoxtPfvXgXFEiSDm8zdXOTIQjfkI0tbbYFvcMpPHpR6Jvf7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(261009223027099003)(18002099003)(22082099003)(13003099007)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TQrNKHCx307G4AJAZsHvxp8+p7pcXqXpjhTrtP1H2ElsmXERiqD/P3Ef/ccNVIOWOo6tJG070J2caFuBNBblkps7QEZPWbz1LReRt4gThve/W2rPeOGPZXXcwEXj0+MdIU1L8jx2G2F7ZckHE7A/i7LFpGUD2Y0irwLl76oY+MWS0Jefcd+lpcJvIp+jhsGdf/BLsrfqqO8LZ3LjWZ2rmY63oJ3RsqVRVfqb9FjceVSoc/+6YChAp1g8Sy1WH+3mX29WGH2Koh+NWSjwT5etLwG1zjvdZXewVM/k3d74ENf5JLQPwAcaKY2GvJo4LSZNhVJN4YZxsRi8ODMfvsXt6FzVyiN8GPPpGkkRS+dgJHtEwnrxGbfGbKFLfaEoDGHSXwn8jEYdt4OgdjgzI+h29WDXPRs4RqlEi2tgV2fGQKEfVx0cgPabcsDfspv+p4vh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:19:13.2516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b86ce7-35dc-4aab-9145-08df4c6fe264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB932818
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

  ttm.pages_limit = 80 GiB              stock 7.0.0-44   v2
  total                                       80.00        59.69
  40 GiB held by another process
    free / MemAvailable               59.67 / 20.39  19.52 / 19.52

  default ttm.pages_limit (31.08 GiB)   v1
  total                                       31.08 (unchanged)
  40 GiB held: free / MemAvailable    19.16 / 19.16

With v2 the reported total is 64089890816 bytes, i.e. KFD's system
memory limit rounded down to PAGE_SIZE.

With no_system_mem_limit=1 the reported values are the same as without
this series. kfdtest (KFDMemoryTest, KFDLocalMemoryTest,
KFDTopologyTest, KFDOpenCloseKFDTest) results are identical with and
without the series at ttm.pages_limit = 80 GiB. Not tested: MI300A, dGPU.

Changes in v2:
- Add Strahinja's Signed-off-by after Co-developed-by (Sashiko review).
- Patch 2: round the reported pool size down to PAGE_SIZE, since
  max_system_mem_limit is not necessarily page aligned while KFD
  allocations are (Sashiko review).

Changes in v1:
- Initial version, based on amd-staging-drm-next. In patch 1 the bound
  is applied in the amdgpu_amdkfd_get_available_memory() wrapper, since
  __get_available_memory() is also used by the is_app_apu allocation
  path after commit 32abf4fe544b ("drm/amdkfd: correct vram_available
  calculation").

v1: https://lore.kernel.org/amd-gfx/20261127082854.112025-1-Priya.Hosur@amd.com/

Priya Hosur (2):
  drm/amdkfd: bound APU available memory by host available memory
  drm/amdkfd: bound the APU GTT pool size by KFD's system memory limit

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 ++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0

