Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12CFD38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508C810E62F;
	Wed, 14 Jan 2026 16:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0iapI2e";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1BE10E622
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW3CAMt5kzWZvXBaucUvLtDT/GLc6YVbSjwRYppiniW2ThPhVaLhR63gHKlpBMUFJ3rivh079TGnS9walEGybpRCyu3zOC2RpxNcWA1UddURZKRS2IpxBmSCo9f9QzHh1J+AxhmxfIFgRHBmPUzbl9hBxtZQckctZPJHBXeS9ZnuNacl1GKxqS5tFRZQjHdIiy78YXC/h2hZ9HThGBeEbuPwXa65LtTEqNQQRypOiLVQB5dpORC9YdhsBeUP1Vl/M8c6nWRILt66RQoA/vyZ6DHXEdkW7h9STWUlB9wMnFR0z8rkL9Ji3I5El4b8tjvL6Eae5fQW7USFgcWRyjfn/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34jVUm+27f+9aYAn3rEPFs8IdPudmsdN6Zy1+AYuV/0=;
 b=a8KO+RgtEogQ2vcoqyT4dcWMZq/HYhhU6CB/jA3o2h+kRyOnsS4ki15UmCRs8wHmInBbcMb0OcQaoBD5S5hTHruW4X3Zg5h+ei5AWy0OA/SgmYm5KknE5+FgP90q0p+1wRS8PcwQqTYYkpR3sORUPr+hyYE/32HRr6QMvVzkeLLNoRDCteMnaCqva9AxGFZxijAwlL2TPgUAAMLcuKkieotKKyVomUWjILShuYQVbtpCVDWIc3i3spIRYwa2lSk313brEs1wz4l8f1qozjsbsOeufULBZYTDXHOsnbQjpqcEY3QfweE+2VENixfFWVn/J9w+460fycwxFXFvms78LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34jVUm+27f+9aYAn3rEPFs8IdPudmsdN6Zy1+AYuV/0=;
 b=y0iapI2eafSA80xbpjx4qwPumQX0vseF4cY3p4gMGY+lPDupE2TS0K7Ml8L/6vBsEIj5PU7afEeLAQV+93GCZtLYZqa9Av9ABfjsSlnM86m8ELzby+bgrMq6z1+s2LWPnzkV/ihNAGdhwHoSGV++2258g1EXEk/xOLqyx8B8ci0=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:47:38 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::c4) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/42] Improvements for IB handling V2
Date: Wed, 14 Jan 2026 11:46:45 -0500
Message-ID: <20260114164727.15367-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: d2dd108d-78b9-484e-42d6-08de538c9fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9ES3R4VXVhY1E5bWYzMGxmdmpUY0U5bmJ3MXEwU0g4VFVUeEtVd2F5TFVw?=
 =?utf-8?B?WlY2bmlOem1qTVpiREd0UnVIaUhCaHV6UDFkQytKa1Q3VkJRNG50Tk1zeXdJ?=
 =?utf-8?B?V0JoV3hNK0wwL3dxMWhhZnJSZ0JWWC8zY3YzVUlWZ2NYeWVsWFNFQ0lha3ZS?=
 =?utf-8?B?djg5aHNQeGFWbEkyM3I2blFVOE80SVlJV21sd1Bub1E2VGRsRnoxTTNHbDJT?=
 =?utf-8?B?RVRpTU04LzNkRUZKTmI4U2cxaElKNUVRZmNqOUNLSnRGbktPL0pJdFowZGFE?=
 =?utf-8?B?bjNIYmxCRnFlUkEyQ0VjSHVXeVNWZnpGWXd3T3Vsam1kYmhzZmo4U0hxRHpH?=
 =?utf-8?B?a3J2OVUrdjI3UDRMWDdMQjh2OEpjRmFxTnlLTlh1MW41ZUdQVTFxaFQ3MkN5?=
 =?utf-8?B?cmxLVnlhNjlUVjFNL2J4YXUxYWU1TFNZV1VxVm5KQ0Z3MnpyRGtMWW1vY2lY?=
 =?utf-8?B?d0FEOFNseVVVVXc0aHEzaDVlVWdySHg3RStsaFd2S0ZZSjZMTHBxbEZLY3Q2?=
 =?utf-8?B?SnA5aG5GVXBQTW1xUERLSjNTUG4waE5vUGZDaGw3NVEvVzNJZkNGSUlIdWJt?=
 =?utf-8?B?a214Y3U2bmc5MU05VG9tbVhxS0hydHAvZzhSQW1Gd2E5Ynk2dmh1bDJidTlT?=
 =?utf-8?B?WlJaUFhKWVhDbXVRZnBQTUdoeGhWS3EwUFpSRVFVZGdyZTJ5QjEzVHhtRTBk?=
 =?utf-8?B?ZHZJc0t1SHRjbW9sTGhYb1VaZDdMbS9SWnhVK1JIY1V0Vk80QlVCMUg4WE41?=
 =?utf-8?B?TlV3NW9UYk1TdmRScUVrTThyamJCZ1dpK0NWQTFSbkYxM1pIL3Z0a0pqeEVU?=
 =?utf-8?B?ZlRxWGk3WW8zdDZIeHk3QkZDMHFpM0xmSjJuSm9BTTc4UDNVejJBQjFEUkRK?=
 =?utf-8?B?QXNmN3ZkQU9ielVWbUw4OHJ2SzJzWXExb0xKUEtGbFgxUkNqN0lDSy9FTjFH?=
 =?utf-8?B?OWpOQW5FYW1na1NEOGlrQnZ0MlJBVjF6cXJvN1F3UGY0aUJqd0NRL29lTzY1?=
 =?utf-8?B?MW5xbldZVjVKUkpYWnc5QXF3K1BsVjRiNVBlelpVTDB5WjRMU0pSbkY4NTdp?=
 =?utf-8?B?dVNRVTdNNmtCLysrVUIvYzNSMUR4RVdPQTFxSnFGVjh0TUpVMnltajB5Mllw?=
 =?utf-8?B?R2V1RXMwa3RQNzRGUkpoc3pHekFlYWlNNm85eitGNThGczgrWUJPMTY2UjFZ?=
 =?utf-8?B?OStlTFQwd3VBMXlDdTNkaDJzSGl6SFJaVlJmOEwzcVJZOStpWXZKYm9FWkFD?=
 =?utf-8?B?ZTBVV0V0UFE5MURIdnpjY1pzajZhVG1sN05HZ21kSUNFWGZUSmp1TjRiOWJX?=
 =?utf-8?B?RGk0SGdXM1NTd3VSb1BxWjhKRW0vZWhleExKNnR2R2tJODhhUDcvUVVLeUYv?=
 =?utf-8?B?U3l6L3B6T3E0M1RmcCtmeEN5R3NoZ2pJV3MzR3BydWRIdVlMNGMrdklCQUho?=
 =?utf-8?B?amtJZVpjRlNKQ1M3cTNndGVuYTZDTTMvb2tkKzlmbFV2RDdDWGxFSVBqRFh3?=
 =?utf-8?B?OXMvRkQ0WHl5dVQxNWtCeXNkdzBvSmlRTlBydnBXRVF0ekVLbVZmWnovL05r?=
 =?utf-8?B?WUhESmtrM1dyQmR5MGplSCtNcVpTSEJpQjBEZW96SnNjcWVqQnkyMmRyQlNm?=
 =?utf-8?B?TnQ4Zzl1a0QxQytBenZtY0pOOTVLV05meUNkSmpIblY1RFVoUEVkKzZiaGx1?=
 =?utf-8?B?V0RFU3VIRVBhL0pnbUVBR1VaRzJyL0k1Z1VhSXRKZjRZemdZdzdXZmVLUklX?=
 =?utf-8?B?QXV5OHRUYUtCc09UMUZuS2c5aFpUQ256Wk5oeXF6eWZvSUVLMGdjSlBxdG9a?=
 =?utf-8?B?YWpCUXZMV3AvUkNJSnJFZGR3enVoL2VDYm1QYmRURVBiVzVkMUw4Q2lSTVB3?=
 =?utf-8?B?NjNPWnk1Rk03cGdBbHo0bThDWThkSzE5SzhjTGUwRkp1RG5uVVg1cDF4eENG?=
 =?utf-8?B?bC95U1VCaTYyYWRBUnViSlV3Yi9CYnNENHBjSkszM2xBelIxODRQWFVDdGVI?=
 =?utf-8?B?N29JYXNQUVRnc1ZPTVhzWmxCWXZrZFBrVFRscWtjdnpPVncza1JXSnArSm92?=
 =?utf-8?B?K1ZCaTZDWWU0YzRQV3dMc29YdFBzMmNwSXV2NHFGdnpTeFd6cDUzYlZJWEFK?=
 =?utf-8?B?L1BzVmtQdG0xWjdST0hIRXRzclhoQ1VjYXhqK0JPOVVwNXlOUzlDM2Q3aDdT?=
 =?utf-8?B?ZXV2MjR5VVZCdHlQNW9aU1RoUzRUcDVpcU8xaEJTTmd1TVBZOXR0alZwempv?=
 =?utf-8?B?YklXL1l4QW5VLzhKbWlkREhvRWVnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:37.2638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dd108d-78b9-484e-42d6-08de538c9fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

This set contains a number of bug fixes and cleanups for
IB handling that I worked on over the holidays.  The first
the patches from V1 are already reviewed, so I didn't include
them in V2.

Patches 1-24:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.

Patches 26-42:
Split IB state setup and ring emission.  This keeps all
of the IB state in the job.  This greatly simplifies
re-emission of non-timed-out jobs after a ring reset and
allows for re-emission multiple times if multiple resets
happen in a row.  It also properly handles the dma fence
error handling for timedout jobs with adapter resets.
V2 fixes the set_q handling by saving the ring state in
the job and redetermining the offsets as the packet
stream is replayed.  Jobs whose IBs are skipped still
handle the set_q state properly so the re-emitted packet
streams are always coherent.

Alex Deucher (42):
  drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
  drm/amdgpu/vpe: switch to using job for IBs
  drm/amdgpu/gfx6: switch to using job for IBs
  drm/amdgpu/gfx7: switch to using job for IBs
  drm/amdgpu/gfx8: switch to using job for IBs
  drm/amdgpu/gfx9: switch to using job for IBs
  drm/amdgpu/gfx9.4.2: switch to using job for IBs
  drm/amdgpu/gfx9.4.3: switch to using job for IBs
  drm/amdgpu/gfx10: switch to using job for IBs
  drm/amdgpu/gfx11: switch to using job for IBs
  drm/amdgpu/gfx12: switch to using job for IBs
  drm/amdgpu/gfx12.1: switch to using job for IBs
  drm/amdgpu/si_dma: switch to using job for IBs
  drm/amdgpu/cik_sdma: switch to using job for IBs
  drm/amdgpu/sdma2.4: switch to using job for IBs
  drm/amdgpu/sdma3: switch to using job for IBs
  drm/amdgpu/sdma4: switch to using job for IBs
  drm/amdgpu/sdma4.4.2: switch to using job for IBs
  drm/amdgpu/sdma5: switch to using job for IBs
  drm/amdgpu/sdma5.2: switch to using job for IBs
  drm/amdgpu/sdma6: switch to using job for IBs
  drm/amdgpu/sdma7: switch to using job for IBs
  drm/amdgpu/sdma7.1: switch to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
  drm/amdgpu: mark fences with errors before ring reset
  drm/amdgpu: don't call drm_sched_stop/start() in asic reset
  drm/amdgpu: drop drm_sched_increase_karma()
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: simplify VCN reset helper
  drm/amdgpu: change function signature for emit_pipeline_sync()
  drm/amdgpu: drop extra parameter for vm_flush
  drm/amdgpu: move need_ctx_switch into amdgpu_job
  drm/amdgpu: store vm flush state in amdgpu_job
  drm/amdgpu: split fence init and emit logic
  drm/amdgpu: split vm flush and vm flush emit logic
  drm/amdgpu: split ib schedule and ib emit logic
  drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
  drm/amdgpu: add an all_instance_rings_reset ring flag
  drm/amdgpu: add helper to save and restore ring state
  drm/amdgpu: rework reset reemit handling
  drm/amdgpu: simplify per queue reset code

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 302 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  53 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  12 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  83 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  41 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
 56 files changed, 1007 insertions(+), 993 deletions(-)

-- 
2.52.0

