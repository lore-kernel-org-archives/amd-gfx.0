Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3008D73E87
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F27410E288;
	Thu, 29 Jan 2026 20:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvKkvOyF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9010710E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kb5ozkHsMMVN7rTu5tP7XYhDIoa1iwUnpeHokhzpmp6kQVqQ8cVRxdoU11atYJLr0D1BxJ1MsOt+wov76IIqFHJy2Rv+NpsaCE5LWENmhwoAEkOeWxunAviJyoEkNpcTkQtpEM17qpFuimViYZVVgrRqcCs4nus0DpoL9lknZw12qycrGAC5rFHMi/0s8L1LsE2HntwugrY7ylYMeXqZ05o+eLxHBY96lYo1Z7JHSr62eqKNyLcxj5+WFFYKjrFuP+ECDVh4HwDV/JVTYDpmzIFuI0DdvvWJlbcYDYuCtyJi+IIiC070biACfAb7qyeqjo2Ear3UPTjf+FHgfg5WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsnWAnvExfAq3/WXGs5rAown5TD++lPPpxipUYR3Pjo=;
 b=UFgc3DMUWcOlZBN1IO2hk4MPoJePIfRn94hEUPwdOMr5UKBmhBs85OtivCO6V58g3ab7gn7LqL8otc4BS0P3Hx2m6P7+4f4KX0oDs1l8Akts+4XFEEDqqMqqY4ZNd5uWtmwYZr7Go0Nh+RPWc8kQukfasgaliEDG/lbsLpVocQG2HLX9AMmJTMnSY/ivq7KkritxOooMyMnB5hjkia1gxPCKYukwWj4/VEm4zEmTjD4VgxOZTMB7sROhgg5wT2ZfZSpWY3BMwVwVGk3g3XhNA9XRgBgfhVti39zir9PXEQHYeLEX7Bk4xRsTKWWOp6MCCL06BNznMfBMBhCDzYyriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsnWAnvExfAq3/WXGs5rAown5TD++lPPpxipUYR3Pjo=;
 b=JvKkvOyFLawgZBZNIbjBZ5Z6tC8OEWZwyjK5OyU5a1d7mVKmJBioczO0vAUCu/zzQoyXFpzcj+ZjydvLbLA/Bqlwys4pX1fmjQkNEufCktDX/MPbsUUd2TbmJxlG0wiitZ41Z0XZxS9gGOVWipFvGAdWZ1KAU195QLCjkR5odwA=
Received: from CH2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:4e::25)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.10; Thu, 29 Jan 2026 20:37:38 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::53) by CH2PR02CA0015.outlook.office365.com
 (2603:10b6:610:4e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:38 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:37 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:37 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/12] Improvements for IB handling V7
Date: Thu, 29 Jan 2026 15:37:19 -0500
Message-ID: <20260129203731.21506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c9a405-6091-4df3-7929-08de5f763df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mzk2Nk0xbU04cUxTaU1vMDdaRitONUZad01lZk5CdUIydmhZKzhYYnJ1TVFq?=
 =?utf-8?B?dDh5K2tkTWdxWndjSG04WDJXRjdrc0xYZkxkRkV5UzhNWDd5UmNiOVYwNjJE?=
 =?utf-8?B?blQ4dFhjUzNHWDdsTTVJR0pvWk0zQVprb3FtUzFpTzVVK1R5TkZLZUtDVDhX?=
 =?utf-8?B?bjhGRm9GaVVQMnVQV1ZrbzdsMEwza0NUcU1SRFRaTm1JYWduYklzM29VT21z?=
 =?utf-8?B?NU0vRkRNa25WQ0JldFh1UmJuZlJ5TzdJdm54NXFtWjMzSTA5djJGd2FkU3RJ?=
 =?utf-8?B?eTJJWDYvZlhtRkNzRGZuZGQrZXR3TVZnSUlQZUx6a2FrZHI4VVlrNml4NUpT?=
 =?utf-8?B?MWRoRzRIQUpUQ0kyOCtHcmMyU243ZWVsRkNOT1RzbEROQkF5VDZlVHRHNE5v?=
 =?utf-8?B?TnJLR29QWm9uK2pyUzc3S3QzTzgxN1pYenoxY29FZFd6R2Y1Y1IxVjBwMnVo?=
 =?utf-8?B?aGdUM3NXdGQydDVQZ2RPdlhtQnk1T2NTeG9LSHYrcFoyY2VxZnVYSWFpdVJS?=
 =?utf-8?B?Y0ttSVJoSjBKS2dUVnNOaVNJU0VIRExYNzFxZCtEenJmY1FUcWMySHhUbW5O?=
 =?utf-8?B?cEVuT0NUS0hML1NneXFiZDR1ZWRKVHpVM3BkeDdFWDQ3WmpWNzQxNWR1MzNR?=
 =?utf-8?B?RElEMXNNcVAvb0JzeFFiZU00ZklCdHdNNlU4bXBibG5xL0c1c3dYK1dKMG5T?=
 =?utf-8?B?R24xTm1iSlY1L25NNXIwUnVXSGp3VTRZdWMrVE10ZHdxMGNLVGcwaG9weWIw?=
 =?utf-8?B?UzZtVUpxaytBRHVWWlkrbjY3T2hUblpXVUUycnljNXJNVDR0N2U4Qk13WWo0?=
 =?utf-8?B?Sld3d2tEMTBwYzFkcWRhYUFoeXZNS2oraDBncFhlSU1GYjk0RTdEUXlIa3lr?=
 =?utf-8?B?T3RaWHhIdkRMcElBbkVHZ2ZZdC9EN3QrR0tseCtqdHhOSk11NlEzOWdHMzhB?=
 =?utf-8?B?bWV5SFlZQnlKQWhHTEtYY3dXR251QjgwL0puWnExVmFrRFlRMUtXYi9jeWRT?=
 =?utf-8?B?QUtmWWhMc1NXZ3hWQVppQkpweXYzdHQ1TzliMm1sYU9kTE9pTUZ2L1gvRWlr?=
 =?utf-8?B?NkE1RFc1Y3V5Qm5WakRPSXBPeVRxbDZhODhvNGR5dFoxSDlzY3Q0ZlVxcTR5?=
 =?utf-8?B?SmFmZ0psRU1IV210RWxLL21PUnQvN0d6dmhXakhablZTVktlSkZ4MUNyL2ND?=
 =?utf-8?B?MnJTdU8zcFhrVDRlUEVuazlpMjJZUEUzTWNxRG9XU0lWNytOUGpNMDB0M0ZO?=
 =?utf-8?B?RGlrS2lDcXBZK2wrQkJhMTQyN0pBZXl6Mk5oUERubUNxZzlkZ01kU1VqL2U4?=
 =?utf-8?B?S2RaYWxyTzNGaU9MZWZNM0t0ekk2VU5kb3ZmN0ZLQjNlbGFrUnhQemEwRHNO?=
 =?utf-8?B?QUJFUkFRVVFKcTJjNnkxTmxwRUNqY2lWOHkwZUxHMWc0Z1IvUkQ2Q2Fva3pY?=
 =?utf-8?B?YW84SDF0MUhKZEpNTk9ZQ3F2VWh0ak1PMkxoTjNGeHphSEp3eE5XaEZqOG5B?=
 =?utf-8?B?TWFVMW1UY0hPelhlRUVrUGE3alh4VWtKbkRGQ1RPb1hJYkh0N2s2RDZCSGRS?=
 =?utf-8?B?L3poTlE4Vlc3K0M0S1FQT1hlbS9sRk03SVJXVDdLcUxINWV4VzdUWTFGd050?=
 =?utf-8?B?RzA3T21hRDBneFN3Znc4cXdBbStRRC9KQUFUWDRLeThQa2ZTYjFpWmF3WVBq?=
 =?utf-8?B?Um1iemhmQ3J4M2RBOXZteG9QcGxISWlQYW9MRWJYeTlEY3FKZUJudXpydFkz?=
 =?utf-8?B?Zjdudk43R04vMXdyc0dVNDlPQmxaTW9hbm5OT1ZaUVE4MDNLUS9adFVhcUx1?=
 =?utf-8?B?SDZpcW9jVm93a2Y3ekNHbm8zbEdsUlBYYkJleWQxRGZkYzRnSFVrT0lxS01o?=
 =?utf-8?B?eXF2NGRzcGdKbXBxOVdGMmViaEhBUFBCeEhVa3ZZUFUrczlGVlFmSjRvbXk1?=
 =?utf-8?B?WGVWcHh1eDgzcVhXSlJDdGZBVVhnRUI2U0dZZVNTRkpxZFY0SEkycW9uU2tR?=
 =?utf-8?B?ZzNSRy94V1Z0a2xYdlB1SUFKSm5XOEJaYlQ3aklEQnpDMDdrSlk2YU1yOUdZ?=
 =?utf-8?B?TFJPS0FoZW5TSlBYZXVISS90ZGxVY2VEcnNtaEpxQjA2Qk1xKy9aNUYvQzd5?=
 =?utf-8?B?aGxKdUJCVGJkNVpLaGw4NzNQMk9rWkpsNjR6eE5NMGFNR2JLc3dNeGh2TUUr?=
 =?utf-8?B?elE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RIC5pkEFUYPbztWjlwD+V3ghxCwebvxDq5aAJ2WGMll8X7wQmW4OR0pfxjMW8WJHa3fjgwYfl8l2iEN3+WJyEvJYH7DmXcgbMDtuhZ/IxyQlBvnQbDghXSW6ZuccRNzVu9vphifoEF6LIg84J5ZQ4uFDTcF41gwhvTbCgAd9zlwMl0lWf9fEYhUkP1B4OtueIkQCsPtaC+YOaxn+cV+zvxGlBUKAl3+gXUH08GKKBRmud6RZW68dePr/+bqZvw++i0ZzEfq0gjDtL/14kDYtL99KnXJRxBS6ZoOuRsEHPKQZoXj86C717+iOl3wf+SOD/57qprzRpGWa9XnW+7kjFGFYyNnSBwnQ4/v1xVe1uM0NpjkIGI3muf7x4yDD9EKRIoGuR+6a9KN6fOxs30DTjOAwdHqdYCn/Hrg6gx19A5jMHup606U06nuoKE1Rj6qM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:38.3192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c9a405-6091-4df3-7929-08de5f763df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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
Fix for ring resets.  No change in V7.

Patches 2-4:
Removes the direct submit path for IBs and requires
that all IB submissions use a job structure.  This
greatly simplifies the IB submission code. V2 uses
GFP_ATOMIC when in reset.  V3 sqaushes all of the
IP changes into one patch.  Not sure there is much
value breaking this out per IP. V4 uses the pool type
to determine the alloc flags. No changes in V7.

Patches 5-9:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helper. No changes in V5-V7.

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
in the fences.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements7?ref_type=heads

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 124 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 152 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  26 ++--
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
 40 files changed, 728 insertions(+), 696 deletions(-)

-- 
2.52.0

