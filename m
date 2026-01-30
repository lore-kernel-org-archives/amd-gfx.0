Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4BAE6BF31
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0298010EA2A;
	Fri, 30 Jan 2026 17:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w75uBQ/d";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F085110EA2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nziFGHnhwMcniIv/j8qdGWZ8m8TqxHOI914jt16mCiGUxa6R9Et1fmR9HaMFIYh4gBuMdFJTdSDAVqiD9PMlblWMq97Usi+Z4WFs6SvqkVXEDeeGckr/9F1ill+qIBTgsJz6QwlDEz/I6+fkXuHHRs7vndmuM+ibhpvX3LElqMFbs1pgz3NDV162K9By0EE6WvvYENMqwpJ/ncNoCpfyE4yDJ8DW5KWPe8xKz+bF5+ewj5qYrtr75v29uukyFtcb+9O6zlrnscPlAIlIBLXg5HzUINz44WOwLeFh4HIcbP0pG7uza4qifZrcO7mEaC9310pUf3Wr019l5pK7jMWIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syP7a0NE4+DKJ71oPChpT5o3cVlbyndXjwSe3qV5IZ8=;
 b=uC13Ch7NFnvnFB9O54a55urV2FyHG6jb4Jlk3+CpY2R/10qJb4MIOJQAiJXsxrQYC19yGSdHuqlbgNKifI+EuGED9ta0V9sMgDECjMCkhUPFOi8hxnqK/SVVCqJwS9ribmNZG2i0tqtwmxnpSKQ8Gn+h1TlZu/G2JXg8lJNKR0gos9zrAVZf80TgzTfKeHRhwf/BIxQyfVFqN9Oo2cq+ntkydDTPzJPaADR5MYGd5ZtdG6/t0eqyvlIOUciCa+IF4ZJimwePiUiszm2C3ugQdD88ShMURL/hq1+YiSw2aMt0ZnQ27PcTRuKAq4ImRV8oMeBze803EaAGoB0Imb0qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syP7a0NE4+DKJ71oPChpT5o3cVlbyndXjwSe3qV5IZ8=;
 b=w75uBQ/dPqgmb8RPAv2a3vsd//fClGnuSOzici4335iL6tIJB1Muip6wR/wQTZH4WL+srkYbdlR4iELaTxp2qRXyeCq/zoG6A0sRBzgzXfqA9lHL+pQ2NGDqTHuSCj2dtc35FOk3W9Unv7xfqsaAbHBY8u3/VtSEpqwfPxE6DMM=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 30 Jan
 2026 17:30:59 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::92) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.4 via Frontend Transport; Fri,
 30 Jan 2026 17:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:30:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:54 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/12] Improvements for IB handling V8
Date: Fri, 30 Jan 2026 12:30:30 -0500
Message-ID: <20260130173042.15008-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a7c65a-55ae-4c41-bcaf-08de60255316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnB1bExiWUp2bURZaTFCaEdzLzFCWGJMc2xGR0xqakZYUGM1aU83YzFDYThW?=
 =?utf-8?B?ZW93YlI5VW9HUnU2R1k1N1JFMWhHNEVPV0k4ak8vRVFDOS9wajZNNnAzZlph?=
 =?utf-8?B?b2pJSTYzM0lYWHpXRUFhbS9YdzljbmppM2NEOXNvSWJWUkRDNHphakZwTkhS?=
 =?utf-8?B?UkxscUVWWGtDdnRNVHY1NkFLd3RuOFJ5cVk0Q1JOMTIxam1IWXNRVnBncDlK?=
 =?utf-8?B?Q1drYmtLUmxSRUJySXZXNk5OeEZ1UGhCMUpUemQya25yU1BUb1hmWXVtZnVQ?=
 =?utf-8?B?QVV1SnM2OU5hOHI3dXpLNjRjRDU3M0FhVTNLVzNvNWpqbklqK1ZHUlZ3czhM?=
 =?utf-8?B?MnRpOEhIbGkzTFRCK3hrelVzdmllR0d1bkEyNGRTYzJrcGlXVElGdkFrOStm?=
 =?utf-8?B?YUxaSTdEdmNOSUdwMkpPTjJQdk9IUTNEdjhzWjBXeHd3cW12ZVF3eEN6VGFs?=
 =?utf-8?B?d25sQk9ZdldiTDZsRFlZQXpwamd3ZW9lMUZpOENiaFlLWkRtbVBwNmFpcmF6?=
 =?utf-8?B?UlorelhpQ2pIZEQ0RXZMOFRoc25QZDBCbVdJbVlHdzNteWZJQ0NkNWtka2t5?=
 =?utf-8?B?YUxVRHhBeU9RaWtTVGRkQktlR1lPeklKVTVpY2ZNeUw5UWhsejF0TFc4aDdP?=
 =?utf-8?B?YWhhQWNNbWlleG51SlNPUGtibUZ0ZmVleUQ0S0liOWRUZjhPTUQzbVhWMzNJ?=
 =?utf-8?B?NVJhS2RKQWlSa0tGS2RlOWhGaVpMSDNjekYwU3JkWXBzOVBUN3MxUDlLRFFK?=
 =?utf-8?B?cldRUU1KVnhqbS9NYXRIbGxCVU1IL05EZklWZUR4RDE2eHhYQ295QmdubS92?=
 =?utf-8?B?VFQvQ3VXbm90MXNaUUZlMlJRWUZNYjhrNTBNTEtnZGFUYVBnRGU1Mkw2a1NY?=
 =?utf-8?B?NUdtK211UFNjME1iMTlxU1pVby9Ka3NqNjZOY21tNFBSbTBScTg2M0NOK3Yr?=
 =?utf-8?B?ZEdCeXo3VHZUVHhtRVpFb1FlT1hQelpoWnNhaWJkMDNIVlQ5bHh5S3Q2OHMy?=
 =?utf-8?B?QVNMemFjbFBqbFhacHdTM3JaK3FaV00rRmFlRlhNS3NpSzVHSnJiRjk4MmpR?=
 =?utf-8?B?V3J5QktiMVg1Vk5qcGRKcnNIR0N0b09ZMHFrSTUvbytnVC94alYxdTZUemcx?=
 =?utf-8?B?ODZUaWtHaWgrbGpNbXJwaVp0ZVU4ZzBIU3c5WEVwc2ZuM1dPL3VIM3pickw1?=
 =?utf-8?B?WE9lYS81bHN6OU1WQmF0dHZyOG9zNTA5enpiS1BnOUdhY0ZEeTJsWnljQ3pY?=
 =?utf-8?B?d0syZFFVTTJMR1dwMlZjRlJlT1N4TDdPODNRUHdRTjBuckpTNXVWVnRXTzJk?=
 =?utf-8?B?UzRscDFNZnFlbC9hU1MrS01lWXIyN3YyOXM2NVovbzhJSTFjc01xS3pYVWxS?=
 =?utf-8?B?aE9PNjZxWjF5YzBYWDJmYW5wUkJYSmdZZXh6MldXaEpVKzEyQ2wwUXgxMWVo?=
 =?utf-8?B?UldtL2JwMTBjNkZWekZTcjBpSVpCWUZ6bEY3cjYvYUM4dkxTbWczeDU4ZGEv?=
 =?utf-8?B?VUpZVTNNbVgzOUs1NXVnbjhSL0hzMk83U1hlSyt6Nk9HLzRyQVAxRHUzZXMx?=
 =?utf-8?B?WEdrU2grdjFOMDlKUXN3anZFWXhLMXRMMUpzRE9BdHErczN6TUMyR096M3F4?=
 =?utf-8?B?cUlDcmhWcFpvdjZocGlnUXBwMXlSMUZLMGpVaVdvK0MwZ2NmaW8veVMxeUdR?=
 =?utf-8?B?a2VnU3RGaFBhM3NQTUJxaXZKdzVzUFhzZVBnV0FHZE1Lbk5LOXlodmNJaGRR?=
 =?utf-8?B?T05seW9QTFA1ZE9zQ1JCamhWUFhONlFxUDlHQ0xuZnBFS3k5OENndVpMSk9h?=
 =?utf-8?B?UUxld0ovcmtLSXNwRU9XSW1iUzdENWgzNXpJcWhYc0pzdE55UzZKcktOR24v?=
 =?utf-8?B?SnFnblFnbWFqcVZTajJmbU02SmtJOGpOd29ET1hRRFhKNTJDbzRwRjF4WWFr?=
 =?utf-8?B?WkZTTnhKMVRYaEJUYTZJY2t5QW1rRWVHTFlydTVtbEJoY2tlSWtIclJ3OThm?=
 =?utf-8?B?eFJGc3dNWmhnc25lU25CNzRmd1FVNDFOMzFxQXl5Y0lpdk9sOVZIem1OVGU3?=
 =?utf-8?B?RWFLK3J2ckcyRk83c1JUaE13VjJZU3hMVVlTL0t6US9tWVo4VEc0L2I1RUJt?=
 =?utf-8?B?RUJFNlZNQ2lXYSs2U1EyQUhrclk2MEhFcnJQZkd4YnRDMVc1VE9hSXRreEtU?=
 =?utf-8?B?MGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nd0zp310tWxpqClMusHSwt7LXlL/JUi2rAaUgGd8sDp1il6IEqcb2xbn3FvJUZFmNdmRaJToK94Elyu6hpLrQxkYquB9NSOi4oEsTdkTxdJBqT+yXFVsKcLvsxP8Y2u38rkyrRcQDdCKURYtPJD/Lc8Ap0bhj2RKfP/fpwHHDlwU0/SZhe/6Ohl1HQWHWCgx+/zZuChaoTfXoij+TSh7pqzx/bSihIRXdv6PtXxrEGaAF7RmFOwBlkZblXlt8PeODrKSOWK/rwqSiOtBFUKMlWKfMTf7qExxKxoCBirO0lBxlntSVdTbOP7XDDfvBgbkRu/6d34G3PV9cU7Owsyeav4e0pM//BREuGI6sCG5Hi9+TZy8HIeJ14QXLHivDvlcfycVIUwCu4hfxTQfFZ9Y9TmmNifr9rXfC4/uOI3TXkuKgm6uL5kTPBnzxdxUx/Sc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:30:55.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a7c65a-55ae-4c41-bcaf-08de60255316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
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
Fix for ring resets.  In V8, return the proper job status so scheduler
re-adds the job to the pending list itself.

Patches 2-4:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP. V4 uses the pool type
to determine the alloc flags. No changes in V8.

Patches 5-9:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helper. In V8, patch
5 is updated to return the proper job status so the scheduler
adds the job back to the pending list itself.

Patch 10-12:
Rework the backup and reemit code for per ring reset so that
we can safely reemit repeatedly.  This removes the current
single reemit limit currently in place.  V4 saves and restores the
fences rather than emitting them directly and also saves
and reemits the vm flush contents. V5 simplifies and further cleans
things up. V6 reworks the IB schedule sequence to cleanly split the
vm fence state from the IB fence state.  This greatly simplifies
the reemit code as the VM state is no longer intermixed with the
IB state. V7 adds some minor improvements to the IB bookkeeping
in the fences.  No changes in V8.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements8?ref_type=heads

Alex Deucher (12):
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
  drm/amdgpu: add a helper to calculate ring distance
  drm/amdgpu: rework ring reset backup and reemit v8

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 124 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 152 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  27 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  50 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  44 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  37 ++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  31 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  24 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 139 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 138 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  38 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  37 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  29 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   2 +-
 40 files changed, 725 insertions(+), 697 deletions(-)

-- 
2.52.0

