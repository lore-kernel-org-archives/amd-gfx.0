Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB63AD2ECFD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E1110E04F;
	Tue, 20 Jan 2026 01:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASHwwfS+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B250F10E04F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5kxLTjajKZZ6MI5JHPP1OJ99it+cS3uM4ZR/re5I/GPnaMHaen6etWXvd9z1NhiV4/8EvIegjZ0l0NfF1n9l71IojEs7ICSCq5DCwIH/K5jjS9CV5bksg3UxsQz/VECNmOdvnAnbdJge62NI0XeLwIWdvtoBFq8lxbL26lGkkNjldLb8/v90UPxdhpr4mU9Je0iGpHFMyKfJMYowamkFHhtOgElxCTFlqJnj9adrdgV5L7wP3XzKeGcn7AybV+om5fEGUmMt+7VrTXaUymOxCSJUs3harlmnmG5EH4JYLbt/PoaBvhScghiJ7wUtR6ey1J4hhibOsjHGptyKi+NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFloN/cdp3yCi6HdoPvaTafrsKMbbmlZbEHX+8P8AKc=;
 b=ASdFedp95p78LVnxqySYAHNt6j1j1KVSH5gZq2yyukZmIm3OKJgGC2w2Ki3gZAqq2Q7MT2uHGiiLsciitdRDGBDyitAE7QU3sHL/ahm1rg6M6foChSOeVjHaBWqPWrTH1/KlmV9toF1hV9cxjTGQQmaD4edkP1IZ7mF/tZLNHmrGnUQ66a4Jb8psGdUWadZz6zEbBd1wKx1Peh9Wt9Ew65YmgAJXvhPmIi2Barl7OGNCK5uXFBBltLsfwfcXyArBZNJ+MWFEKrEnRCijH5V+5BBOjT4JSMtMheSS3Y8eWgerPKgPOy+ub+IxbTC8Oh8eiIwTGaPXhmid17IS1wrSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFloN/cdp3yCi6HdoPvaTafrsKMbbmlZbEHX+8P8AKc=;
 b=ASHwwfS++4Hccm7CHqY+fL519fFuxXrRi6ZnMzcJ6NU8RFguNQSG6FJrPC3HYf2Vcxsu6jXWD/9mjpzAkJ0wKo65laIoVZV9VM7pt2WETx1qWGbY5NsPKfAu5ymCirDLSKqwg1DAu0ccmYw3/TqOcFL1MLz96EH4o4e7BXxHeCw=
Received: from BY3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:254::22)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:34:20 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::45) by BY3PR05CA0017.outlook.office365.com
 (2603:10b6:a03:254::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:18 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:18 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Improvements for IB handling V4
Date: Mon, 19 Jan 2026 20:34:01 -0500
Message-ID: <20260120013411.15659-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f5989c-9876-4d6f-8b8e-08de57c407e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHBaVlNtTkRRT09JUy9vakgzVjlsQlFBejN3ZU5qUkUzeVcvcnE3N01ZeWFi?=
 =?utf-8?B?NlJ2NlhweitUOWdSdlNwMzh0TFYwWUVqUG1MWHVWendWV3d4SHVDWWxpQ3Ez?=
 =?utf-8?B?andva25za3BGWHJFUk12cytwQ01jUGxMM2sxcGl6YndyNVFnUlpQVmZRMCto?=
 =?utf-8?B?YjV6UWlXdm1zVzZTTUdhNFh5RkltSTlsRlNxdXR5MVg0Z3ByT3djWmxWV0gz?=
 =?utf-8?B?cThKTmZYMmVUSWVEaDJMNThzbnVzcE5mdlBKMmRUNmdkRW84NXNTWXI0OXZi?=
 =?utf-8?B?YXVFN3pRU25IWEZTMW1NZlc3c3I0NmJOODdNOU1IaXI3WXhZMHFwV2lFcmd0?=
 =?utf-8?B?cVVtanNnaHdPS2M0SVFWRjhzd1Zlc0ZSSWhJd25BUDJLcU53MXRmaXdBaVZ6?=
 =?utf-8?B?d0xqR0srYVJKL3luRVFsS2xKajBZaU5MSHRxQUF3ajYzSEdXcG05UlJSbEd2?=
 =?utf-8?B?ZEY1bG0vTXZ5S2lKL09RWTd3b0JFek9sMVRSRDQ2RHBsYi91bDI1NXRka3Z0?=
 =?utf-8?B?bUdhaUVsY09ZUUlqSUY5ZzBDWEh4UExueEdVS0JjNVIrRGJ5UHNuR3dPR3dI?=
 =?utf-8?B?N2hKc3oyZ2JCc0QzUjFYSDZQTjg2OUpRTUNuajg2Y0FFTmdUQTBHYWp5ZkN4?=
 =?utf-8?B?QXYvdWNLVkxaYjFzUEJ0dHl4OFc1eTd0dkhlWktTZERMWVZlejd6bDhGK015?=
 =?utf-8?B?c3B5QTF6azlNeXZ1b0p1VzUyMmh1bDhlTktYOFdNTFFiZmg2bk9jMDdCNzRD?=
 =?utf-8?B?cGxLcSt4bEkrZjh0YjR4ajdjNUtkNXVONExSa215TGNWTVN0Tis1K0ViaVVx?=
 =?utf-8?B?OEI2QXBXam55VlRtZW95WVJqNVI0aVhnSlV2WXVWcnBqRE9mN1J0ZUs4VitP?=
 =?utf-8?B?K2hYeTdjYWxoMDFMMWkxWXMxWHYzN2I0SEQ3ai9zZjNIZ3pIdnd3V05hd05R?=
 =?utf-8?B?c1g5VngyNFhoWktXS0JMTVMxdU1vaFh5dDRjY1FKZXVYS3dRcnNBRTZwSVg2?=
 =?utf-8?B?cm9UZ2R6ZlZZTUJlTzBMY092RDUrRmJSMXRXVjBNdVJ4Rk94YXcvQVFabFdY?=
 =?utf-8?B?ZzlPNnZrMXRFLzRwZFpxbDlIc1FTSkVodFIzNkx4N1Z1U0c0eDBsdjFNdlVO?=
 =?utf-8?B?c0wvTExlZzRvVGcrM1VwRS91ZmpFWGZnS1VxRGFicVA5RjlvaHlDQmNZa2RW?=
 =?utf-8?B?ajRKWTcyb2RSYUxMdWo5Nm90eVNhcWhkTlRrUFBoejR2NUV0WU5yWlhzSExD?=
 =?utf-8?B?WHpyQk5Cc0JDM1pqTEtiM0ZmTlV3NVRHbTJmcGVvNWJMSDNGY0ZhclVPVStS?=
 =?utf-8?B?MVhRZ2xHSkZ3TFV0d3UvamFzRmxobERDWU1WaUNKWDQvRFN0UzExM1E2dWJN?=
 =?utf-8?B?aXFVQkdLd0F1SnN2bmhrQUZrOENiVElENGdwQlBubHFaNERYWGVRMVFVaGdD?=
 =?utf-8?B?WU5Ha2hkSm1nRmhqTVNpM2x4VUdOSWRZR0haaXpzVHJ4VDRSOXB4a1ZERnVO?=
 =?utf-8?B?YUZDRlRhelM3Qlp2djhqcHhWK3pBUkFDbmRzTmZpejJ2Skx0UTFCYm5rWVdK?=
 =?utf-8?B?MTNTYzYvZjZiTkZiZi9TQ2IyMjFqTkxiS2dTWnRYY3Z2b0lpSEM4N1pDa1U0?=
 =?utf-8?B?WGpaZXNEb21yR1dDeDg0THpYVk1VY052TlNleVV2dWdsYkZpbHJnTG9la2t0?=
 =?utf-8?B?ei9hM1hRSVlUQTB2R081WXk2TU1GR1o4VXh0NkFYVDErKzVpcWxBOFNVMkxi?=
 =?utf-8?B?WHpCb3ZjN2R0MFlWMCtwOE95MnpONGw4ZWRiUTBuYXRDeVJ0NktpMkRvTTkz?=
 =?utf-8?B?bFNtR2ZyTERGcmU5WmJHa2JMMU9lbmxZUXgydHoxeWlubmJmRGFDQ0xabFJz?=
 =?utf-8?B?OC9sWnRnS2Vxak4rM3pENWFsUWFpMGNORjh5U09xeEhTQlMraTlJanRkekxP?=
 =?utf-8?B?alhzY29vS3VubFZzNzV1a1lTT1JKRU1qMHY5TE5xaUd6ekRWTUlya2RXbG02?=
 =?utf-8?B?dUYvV1h2QkdxV0NXbGxwQ0ZQOXdzTTNRQTcrd1ZhL2VpZy9wcXZYK29IWHhF?=
 =?utf-8?B?UzdkWFNPeWlwME5TckRna0RTWGhNZE1DTEdZdWRUWWF4SDFEaWdoSDJJUTFu?=
 =?utf-8?B?b3NRMEVJNkJFUXRGOFcxRWZ2QkdyVzJSbFVlbk1jSHE3eHBWOWsvR2ZuSzRu?=
 =?utf-8?Q?d1FZMg8Rz09bKeOukEF+81I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:18.9509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f5989c-9876-4d6f-8b8e-08de57c407e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670
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
Fix for ring resets

Patches 2-4:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP. V4 uses the pool type
to determine the alloc flags.

Patches 5-9:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helper.

Patch 10:
Rework the backup and reemit code for per ring reset so that
we can safely reemit repeatedly.  This removes the current
single reemit limit currently in place.  V4 saves and restores the
fences rather than emitting them directly and also saves
and reemits the vm flush contents.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements4?ref_type=heads

Alex Deucher (10):
  drm/amdgpu: re-add the bad job to the pending list for ring resets
  drm/amdgpu/job: use GFP_ATOMIC while in gpu reset
  drm/amdgpu: switch all IPs to using job for IBs
  drm/amdgpu: require a job to schedule an IB
  drm/amdgpu: don't call drm_sched_stop/start() in asic reset
  drm/amdgpu/cs: return -ETIME for guilty contexts
  drm/amdgpu: plumb timedout fence through to force completion
  drm/amdgpu: simplify VCN reset helper
  drm/amdgpu: Call drm_sched_increase_karma() for ring resets
  drm/amdgpu: rework ring reset backup and reemit v3

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 131 +++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  50 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  30 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  37 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  31 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  29 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  24 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 139 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 138 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  29 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  38 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  37 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  36 ++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c         |  29 ++--
 38 files changed, 714 insertions(+), 682 deletions(-)

-- 
2.52.0

