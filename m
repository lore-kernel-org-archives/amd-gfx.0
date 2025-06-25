Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F29C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9726610E134;
	Wed, 25 Jun 2025 21:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dIguzT6V";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3825B10E134
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSyjtzwwZEeSHuo1oaNykHYq63Zt5cblipOBvDhXIuvl6H/f2mPTcLMFPbjz9OHsg9+oXztcaFMiZ9CknB9yYYpxC1aeKyV6TolE4KK0h1dm0xqK/cErfkLkywv7PogUbfQHGkor1kCbJqpCIGZ2JNcBNUUy7qWWEIbXlxHKZJJed87h+eOnFIpo3kvSph7JthXBHAG2XnsVyT/VVB7eqrmjOwRdWuzmDeHpwdN/RS5q8+wVD3JyyiGBZHuX3w6S+MpzvZ1UDjqrdEdjU7UsxzD5UNdTs24W2wtm0NLwSRgvsEY/BRmoou2iFOh29p7jHAJGlspyElYUzcr6TI6YKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K5uF0rkXULyULXwUJ6Tkaj82MHi4gvwLX10mzsxWPM=;
 b=C7DPK3TBvedsOEt1oB+NtelFjWxoFp28E91bCyz9xO0VobycK1CTK6cAeBggz1/UkAYlXz3pC1SLLvgAPz1kuNFYw0w+hr3kHOmQrMEP+ecIL+69yYe5MW1EE/vDxVAv+BfHxHrIDo/GuGUVMm6xlkGG14T/FAhdWsiZDicre38C6Zm20u6Js9nOSuZ7nVy2bOZgWl0jbz5xHg4TXXpNdKtPJRtM0msFbl6TySdlzTjiDN+w4T0Jhx9nuId8iiG/gcUjvlrw6W0BcoAOETkAliRGiqjKHWTy95SPfvlSNFugAurzQGaIkjcL6RBBoaLsfCing9h09EeBC69UnyUecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K5uF0rkXULyULXwUJ6Tkaj82MHi4gvwLX10mzsxWPM=;
 b=dIguzT6VBz2YjhmsbQ/g4x/BUaWEtVHmBQWus7vDInSEJTQdSEihOvuIqD8ZdTdemZ0RBsyGlarjfzWAV0zjJXbkE2+OpP4T3xXw+QR7vAe707TTVkwQlAwaWDs+lRjCbsFM6yC/1PFBSg6U2sEIpOef8sWklDfqhnu+PHM1tsg=
Received: from BYAPR01CA0018.prod.exchangelabs.com (2603:10b6:a02:80::31) by
 SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Wed, 25 Jun
 2025 21:06:53 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::88) by BYAPR01CA0018.outlook.office365.com
 (2603:10b6:a02:80::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V11 00/30] Reset improvements
Date: Wed, 25 Jun 2025 17:06:08 -0400
Message-ID: <20250625210638.422479-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 563052b2-47ec-4510-c994-08ddb42c3608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tno2NTNMOU83bjJwMnBnT2NUbldZRW11a0UzVjh2YTFHZUd2S2V1MkZKSmNL?=
 =?utf-8?B?WTNhVndHZFB4TWNKZkFyWDRHVTM1MFRBQy9jSnI3WTBORXZISlBPei9BUGhn?=
 =?utf-8?B?UUNaak1BaUVhVGY0RVNTQ280Rlpia21zTjBiQmRJbE1EV0xpcG5zbU5QVmEw?=
 =?utf-8?B?dTd2QjdTRXBVUkhSUEF3ZkNEaHlDN3o1aUtsb2dTUlp5VzRSOEx2TXhGa1Vu?=
 =?utf-8?B?RE5RYzhRdGVOSkRKa0JYN2xzRjB1bVVBSWVMOTQ3ZUE5a29iL0EzMjg0S0c0?=
 =?utf-8?B?cllXR0FaWXVad21kbEMwVmRxL2g3WWJSOUV4aHJUQmt6bWdEaDBIc28xMm9G?=
 =?utf-8?B?L0VzR2o2b0Q5NWNnQ0hsSlpJTmlQa1EyakkraWY3Z1dJNmV1c05sWjZUNkdB?=
 =?utf-8?B?dHEzSWF1d1ZZMzRXbzcwaExINUZ0SUJ2RGkwSzNEVlV4OUhSdDlDV1lPNm5j?=
 =?utf-8?B?WXdkN0hHR1l3OXphSnJCcGgwRllSWGNmRXNrbWMrdG54SnZvMVREU2RoZ2Vl?=
 =?utf-8?B?ZzE4TTJnN0xVVFlOQWJVUXM2anpDb3lONFVmVWFlV0tjQmE1MU0zMW02ZnJS?=
 =?utf-8?B?elM5WXplQ3dTVUlQbFo1SEpXZ1lraE9SMFhMMEhLQVVJckgvM3k1VEdRWnVS?=
 =?utf-8?B?bWVYSVhldVplMGNkcTh4aE8ydUoxOFRhSFZMMi8xZVhZcUcwYzRqZW16Rmhq?=
 =?utf-8?B?T3FBTWtYeXhyUzRXREJISXFCUGhzVVFvWnlyN2hSY0NWRnh3d2hoSTRBbXlm?=
 =?utf-8?B?Q2xmTkJIL0FhNGRYYkRMQTlaR0E5ZUVIK1MvcGJ6MmZmK0tDdjlLb0dVOUFI?=
 =?utf-8?B?cC8zYmtZUkRjMXpqbFR2dkRXTDNFSnB1WlVqM1BzemdLT0dFQUMrbEllbVJ1?=
 =?utf-8?B?OGp2SG1abkVaKzFtMjhKTGsvT3Jsd0lHTGFxWTVDN3NRVEF4TXJDOWxWNGxD?=
 =?utf-8?B?ZzNHZFcrdnU5WHVCQXYrWm52TDllQm0xbGp0T2Y1T3pXZ0kvWnFjdnJHY0xI?=
 =?utf-8?B?bjNDV0tWdDFHM3o5S0U3V2UvMkFiMkhoQ3V4TzNwRXMwdXQyTDM4WitudlNR?=
 =?utf-8?B?a2tlSk9YdFRmNlg0d2RBWHRoeEVRdWdMME5zeXR4bytSSmRuRDFwdVBPSUhP?=
 =?utf-8?B?ZVVSdEg5TDJRTHFFWlV5Q2drWFJNYUZRTHJ6UXN6U1RlVHdXWHZjeEwvVG16?=
 =?utf-8?B?b2pYTWZrVFc4YzJ0R2tYNTFKYmJnR1ZFd0JOK3R2M3RpOHFrVzIyajVCOVU5?=
 =?utf-8?B?ckVmaysvNzV0RmJ3czRWdWhKazBaS1BVZG8xNHV4WFVvNWUyNjRqbGphQkp5?=
 =?utf-8?B?elYrYUlVemNJMkoyR3M4c1FOL3NuR0g5UWdVR3RiREFna1NQMCtTc0NQUUZ3?=
 =?utf-8?B?Z2tjRmlnNTJSbVVwTmxscC9ZUytuMC9YZDR5K2x2bEVLQVRLWFlxcHI0aG1q?=
 =?utf-8?B?cUJuWlRsTWthLzVZTFU5aU1vcHBsSW05d0hSQUdGcTA5cW9zS1VJR1BmUWFx?=
 =?utf-8?B?WlNsUFVTVHg5bENza0Vsd3Z2RnRNZHdzeHBFT3FyS0FpUFcvaGdXZUlKYytL?=
 =?utf-8?B?cHNUbitMS3JLWmxDZk9IY3djYkFzRjlQbTlPaHcvOFN3VkpDMmp5ZVk1LzZX?=
 =?utf-8?B?MWV1SXM5NGtlQjhUYWkzdlFrM21IaVdNNkd2UE5XaC84N09YS0ZLdXprS3R4?=
 =?utf-8?B?NGN4eklMNythVndzVVZ4TnNSZXgrY3diMFE2ajRRbm5SWHYwWmwxVWoyUnk3?=
 =?utf-8?B?WDFjMFFBTUFXamZkRGZpcFA1OGw3bmhFcXJlendFaE4reXFlOWl2Nk5MQjR1?=
 =?utf-8?B?elIwNytUMUlLWnc2UUZ6TXJWUWx6a1Y1ckduMC8wbWF2aFlvUkN5MWtaVmQz?=
 =?utf-8?B?MUx3NUQ3N1JkdzBOTXA3MDRGRnhjSVRYald6M3Q0UzZQZVFlU3lRSStteE42?=
 =?utf-8?B?eWEzcnMzc0hSTTVpVU1TaENiRWdZOERKTnZHclRMRTZjdm44ZVZDek0zUXF3?=
 =?utf-8?B?NFRGR1I2L09nPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:53.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563052b2-47ec-4510-c994-08ddb42c3608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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

This set improves per queue reset support for a number of IPs.
When we reset the queue, the queue is lost so we need
to re-emit the unprocessed state from subsequent submissions.
This is handled in gfx/compute queues via switch buffer and
pipeline sync packets.  However, you can still end up with
parallel execution across queues.  For correctness in that
cause, enforce isolation needs to be enabled.  That can
impact certain use cases however and in most cases, the
guilty job is correctly identified even without enforce isolation.

Tested on GC 10 and 11 chips with a game running and
then running hang tests.  The game pauses when the
hang happens, then continues after the queue reset.

The same approach is extended to SDMA and VCN.
They don't need enforce isolation because those engines
are single threaded so they always operate serially.

Rework re-emit to signal the seq number of the bad job and
verify that to verify that the reset worked, then re-emit the
rest of the non-guilty state.  This way we are not waiting on
the rest of the state to complete, and if the subsequent state
also contains a bad job, we'll end up in queue reset again rather
than adapter reset.

Git tree:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=heads

The IGT deadlock tests need the following fixes to properly handle -ETIME fences:
https://patchwork.freedesktop.org/series/150724/

v4: Drop explicit padding patches
    Drop new timeout macro
    Rework re-emit sequence
v5: Add a helper for reemit
    Convert VCN, JPEG, SDMA to use new helpers
v6: Update SDMA 4.4.2 to use new helpers
    Move ptr tracking to amdgpu_fence
    Skip all jobs from the bad context on the ring
v7: Rework the backup logic
    Move and clean up the guilty logic for engine resets
    Integrate suggestions from Christian
    Add JPEG 4.0.5 support
v8: Add non-guilty ring backup handling
    Clean up new function signatures
    Reorder some bug fixes to the start of the series
v9: Clean up fence_emit
    SDMA 5.x fixes
    Add new reset helpers
    sched wqueue stop/start cleanup
    Add support for VCNs without unified queues
v10: Drop enforce isolation default change
     Add more documentation
     Clean up ring backup logic
v11: SDMA6/7 fixes

Alex Deucher (29):
  drm/amdgpu: remove job parameter from amdgpu_fence_emit()
  drm/amdgpu: update ring reset function signature
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: move guilty handling into ring resets
  drm/amdgpu: move scheduler wqueue handling into callbacks
  drm/amdgpu: track ring state associated with a fence
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.5: add queue reset
  drm/amdgpu/jpeg5: add queue reset
  drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn: add a helper framework for engine resets
  drm/amdgpu/vcn2: implement ring reset
  drm/amdgpu/vcn2.5: implement ring reset
  drm/amdgpu/vcn3: implement ring reset

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 133 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  20 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  48 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  59 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  27 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   |  76 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |  42 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |  33 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    |  33 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c   |  11 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c  |  11 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c  |  14 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c  |   7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  49 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    |   9 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    |  21 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    |  21 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  12 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  11 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  13 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   |   8 +-
 33 files changed, 532 insertions(+), 227 deletions(-)

-- 
2.50.0

