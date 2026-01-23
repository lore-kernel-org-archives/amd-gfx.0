Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117A7D77881
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A577810EB68;
	Fri, 23 Jan 2026 17:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WiKeSRGT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509C610EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEqo+zUUeXjd4ofWzN0ww4ygKAWLX/DJIzLZCgTgDqzMtFDwhpQpqfWjh1IwqzB3tgkY5ffawHDU8uQG7Q2BFvWFqyer945cogfmDAaaEV/1T13Trv8hmYaQe92Z5WFEtMsHOs/Ovq1skchUfBcxga4Aw9Pwgf+7NumKcSS/XxNjXyMTykShfFJRT3MQjgvqxhcB9O2vO9abxePtTJmBunyXGt0k7711dM6YNDJ0IesqwmMvaHmFniYbXk7CCT2iFkap4DAZJ3ygIEZ5LGczY8YtVJDXcHqbdX1/VVnwHKOKFWX0j6T6kpDZ2pMZmq2CrVd8C0NyCS02e3DKUZ8X/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv4yPQUD2B7jleC4jPIIdiwuDZOD9eFqQAIRgstkYZc=;
 b=akQ/U1b1kmdn+Zk8Z2MUYiYMzqPNmKwswA42T324TT58M2NDkBGE8yLLkWBxUqvMKd3EqjodzA8su29qZwpK4FXS62gIG6LsMz817Y/8VPUf900QB1QqbBwhO1J7xmIUBlPy1XmEB5KC2+3U69hGHQiDrlgoy5nA8N5Iq2f8dOKUqZQLgI6vPNW+NpzFEsbW0lwtAAXZYc2KYG6539Ypjb+CpNPrAL6A2J2shgDNXiKZfPQd78QUuSnWQCzcX9GkLsyvGdKwxJKpwsQQn272F4RLHCtKbnup5Rwk0k2booXDV//OarGkihnJTEh/D5jFIez9D6c+k+NFOoJCPtbVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv4yPQUD2B7jleC4jPIIdiwuDZOD9eFqQAIRgstkYZc=;
 b=WiKeSRGTjkj5R6z+vdiU5juqPTwKOgY0+fjgyhv+SdfrPfh5wPbpMvjgZBVZrPIO3Do9ieX+QOxJUoLl5NB7KyGAYLjrvdiiYSbwIATQMyjZocQ8lXR5FbNsDg6mivijMizWVbCJpKDD3QMt7kd16DQ7aWFuxhaT/4fIoUJLlNQ=
Received: from CH2PR11CA0024.namprd11.prod.outlook.com (2603:10b6:610:54::34)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:46 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::48) by CH2PR11CA0024.outlook.office365.com
 (2603:10b6:610:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:19:44 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/11] Improvements for IB handling V6
Date: Fri, 23 Jan 2026 12:19:26 -0500
Message-ID: <20260123171938.16814-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd1a2e9-14c2-4d23-f875-08de5aa39aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFNJYXI2K0FpYk4vRTRSWDJneE55bXJpTEZpeXRmV2ltZ3pMT0FGdU1SNFE5?=
 =?utf-8?B?d04yNTZRY3RFdEdJcTdVMG1STjF0OVJ4Qm5YS2pNTlZKbm90cTdyckxBRUg2?=
 =?utf-8?B?OFlhYTFMbVlRK2VQL2xsU1pYTVpJL2cxODZjUEpLTk5kWTFVRk1pS0FudENB?=
 =?utf-8?B?NnBtb09HYy9sWWFEanM1TkpmWjB4Z3BUUnpEaFQrZnlxYUtITitJZFAyKyti?=
 =?utf-8?B?OStad0RGdnpGZ05sQkdSeldKV0c4U1lXQm5kRzhhcnFTU3JRek41dzViVVlD?=
 =?utf-8?B?M0JVRmhaL2k3RVVlbTdjU0NnLzZvMDdsNDg0THUxZzBkV05VNHh1d3dQM05k?=
 =?utf-8?B?eWJ4VlgyaTZpWVAzU3c3eFpvMTlXQlhuVHdzcWR5ZC9XRWdtWUZxWHJkUXA5?=
 =?utf-8?B?Znc1QjRiaDJqRkloR3QxaHo2Z2JXSklXNUJ1TGJPWG9qUWVaV2ZMQThUSkJo?=
 =?utf-8?B?UTFsRXk2SDNFZEIxR0c5cURJQWJkV0daQmVNQkJlQjF0ejZTZURVanB4RU1D?=
 =?utf-8?B?bWZYemhmVkhkWjdyME85QTVRTjBDTWs2d3ZyM2UwSkVKTVZwSGFSalhHc2dx?=
 =?utf-8?B?N1BmWVdXZkVsbUp6SHo4VUxySllsM0R4WlpFZ3FEdVkxVEk0blBpNGxFcTB2?=
 =?utf-8?B?QUY5eFF2djZ1Z3ZNenpITitmdWNvdm1rQXFlK2t1YmY4aWUzZnVvK00vVi9D?=
 =?utf-8?B?TGJBVjNyOUt1bytPdDU5czk3M1c2S1BTd1p2NXBFUUtvMGU4NGVYU25Kblpo?=
 =?utf-8?B?TTJ5QjhqQjBpc1BscEJtdDVFcFh0bUMzNjhqRGUvWXhORDV6OXgzaTVPMmQr?=
 =?utf-8?B?V3VJcUl3ZlhtVitadWxFRFd5RXdJTEM0MkpsSStIRHhJRmdqOWRnOU4wMXl3?=
 =?utf-8?B?OG11V050WGttVVFvWUNOMzdPV2pMS08zbU5mQXRGd1dFdkNTWDJJRzl4M21W?=
 =?utf-8?B?Z004SUM4K1dhTmVQc3Y2MFZ5TXljZXRYOUlWaHVxZ3JueXZpZGMxcW1uTCt1?=
 =?utf-8?B?aUpQaGZ6RHl4MUNVMkVya0ZZNERTaEZsVlZ5T1VxWHZOaVNYeTJOREoyVWdp?=
 =?utf-8?B?azc5QzRGN3J5Q2pWdmZ3bGFvMXcyR2hFY2R1cjBucnhacjNTN05vaHh2SXBs?=
 =?utf-8?B?akF6aXphMVFaOUVib2FJaWVIejhXMVk1b0JZbzFxWFhwOE1wdWxLMlM4ZXlS?=
 =?utf-8?B?NDRlV2xlS2Fkb2xWcHRjN0lsTXNHakNqakhzcEdoYzdleTZEVEZDbTIyK3Av?=
 =?utf-8?B?S3hveWY5ZkJsVzBpTlI2clljUWFENUhrQWF3eHltTUY0RGNzcngzZjVXRlBH?=
 =?utf-8?B?MElWWHU0MWFRQ0tDZXpKVlBNUVdFZDJ2M3hhL1RHWTE5T0ZCazAzM1BGRFIw?=
 =?utf-8?B?Tk42RDRjM05XS2JSc3JoRVJNeUZadGg5b3pMQXBtbDEvS3hmckE4QzVyc0N6?=
 =?utf-8?B?amExVkxNV2c5M0U2akd6am1nNGUrcVZLZUpOSXl3dldock5kV0o4TmU5TWxP?=
 =?utf-8?B?WkZCSHo4dmlQa3R6RFUwMWRRNEtyTTRyVVZPQVpFd04xejRCT3oxUDhDai9Y?=
 =?utf-8?B?eHhMRlE2V1BsaHBOcWExemdaVGlMdXNaWjVXZitGWVY4UUlsd3BxUG5ReU14?=
 =?utf-8?B?a2dHeDhwQzNPSmt3MU8vMll1dTNQd0RPSVRHeTNpd3Q2MUhleWxObjl0OXky?=
 =?utf-8?B?eFVUOUliVCtxZm9CbTVKNS9HaXl6d1BRN2JlbXlhY3ZyeG1rZkpYWXBORVh5?=
 =?utf-8?B?aVBWMlpMTmpETGp4S1Byb1lxdjNnVndOVHBRZ3AzeFNGUHZrRnRvTkYzbko4?=
 =?utf-8?B?U1g2OENFWExFTXZRSHpnSUFQZ09ER0k3VXBTYTR1dmJueHV2YTh1TEVsTzgw?=
 =?utf-8?B?L1NyRnhhMW04Tm1UdGZSb3dFYW5oYWtXNTNCUGdFRkdzMm9jMThlWUlscEtK?=
 =?utf-8?B?Y2dZT1g2RW8xb0xZOHVEOS95KzlDOUlyUzNmNDNNcnk3Z05Yb05rYUdHVGx2?=
 =?utf-8?B?aHcrS1hsd0ovVVZ0WmJVUTk5SDFMVnQxTXZVb2kxZUFzcFFFbUZIdU5UYTkw?=
 =?utf-8?B?SGwyb1g1Yk1NNmlzQ2ZSYS82Z0o5cU9ON1BEV2N0ZFFOTGRBckVBLzk1OG5i?=
 =?utf-8?B?aWNCcXorOGNqWmUrTkJ4RUNJM2NYMjhUaVdtOE1OdnRBM2pONk5mVmxMS2sv?=
 =?utf-8?B?aEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:45.4748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd1a2e9-14c2-4d23-f875-08de5aa39aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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
the three patches from V1 are already reviewed, so I didn't
include them in V2 or V3.  The first patches from V3 have
been reviewed so I did not include them either.

Patch 1:
Fix for ring resets.  No change in V6.

Patches 2-4:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP. V4 uses the pool type
to determine the alloc flags. No changes in V6.

Patches 5-9:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helper. No changes in V5
or V6.

Patch 10-11:
Rework the backup and reemit code for per ring reset so that
we can safely reemit repeatedly.  This removes the current
single reemit limit currently in place.  V4 saves and restores the
fences rather than emitting them directly and also saves
and reemits the vm flush contents. V5 simplifies and further cleans
things up. V6 reworks the IB schedule sequence to cleanly split the
vm fence state from the IB fence state.  This greatly simplifies
the reemit code as the VM state is no longer intermixed with the
IB state.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements6?ref_type=heads

Alex Deucher (11):
  drm/amdgpu: re-add the bad job to the pending list for ring resets
  drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
  drm/amdgpu: switch all IPs to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: don't call drm_sched_stop/start() in asic reset
  drm/amdgpu/cs: return -ETIME for guilty contexts
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: simplify VCN reset helper
  drm/amdgpu: Call drm_sched_increase_karma() for ring resets
  drm/amdgpu: reorder IB schedule sequence
  drm/amdgpu: rework ring reset backup and reemit v6

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 124 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 154 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  26 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  50 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  37 +++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  31 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  24 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 139 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 138 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  37 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  36 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  36 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  36 +++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  29 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   2 +-
 40 files changed, 717 insertions(+), 691 deletions(-)

-- 
2.52.0

