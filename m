Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AF3C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B389710E236;
	Thu, 29 May 2025 20:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efDqcFcA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D229210E0AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmqiB8Oa6w3FteoWlZxkBKvirDV5WxTNDnKF+nNcA3/OfW0nNbOZbVytZzUEE6Yxui4X6Vc3jSalH8UaQGtI4EzIhNTAT+2S52ufBdxj9JSoxAjbFINgRXNChET+EzxdlpdsTcKZkbYtDI39iMjELqmrtQCJLXt6Xu1sZZswt/ObmImWbiC/qLgTqTNcQ/PnPT+EwihTNtSL+Raa9jc9DgYiMh1kk2IYor6iiiBu+9Tu3upaPOCTFyeCIetc2E83WelQzt4rXTQgSDO1Fey2lZDpDSezcI8p+sRzjkDr0/8VQyg7p4OWC4FlM+8FENHdpRxSPk3QKYdpaeBDajqKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Sw9GNJmHmNJ/DkBI1dFufj8Qt7hl7zxEiDjwUI/ARE=;
 b=AWdLhnDaB0O+oCnXkC51Orw2b5w3H85cGIGJbL+ZVdvjWTpWz3zl3gzAes9tvLGQiybheQ5rGZWBKde9aZ3t/fe0GHnUUteb5PoKSrLNmeW92ND1aYvCKMeSYwM/zxMLHM91LvZxkZbyPsQL9ITd5P59rIdbAhT2x2V7tCtyI/DfB7P6DMuiLrfEJE2+u4oNyaKP5TGDlG8gOnA9xKZgCQWXOnmBy7qzApJBowynJIRSlfGWEojrssYpG9yKaXTRT8RYtfi9gYQ7RE4jGZq9VXOiAP2ZOZgiZmrH/n3QkMzbbs4XfXa16Wppru3i+9qunxUyfAisAbWuaquIYLVCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Sw9GNJmHmNJ/DkBI1dFufj8Qt7hl7zxEiDjwUI/ARE=;
 b=efDqcFcAu+fKrEdR/7rm4VN+YPmfBWAfNmL1NLMe9inCmR0P8Z3OHGUPGW0vInqHvCOw6GcTAckimzmslAGC0kVLNDwtkLa3lfegC3wvXTQ/uP26M5Agh12MECa6qkewZ43/6+ZJbj5VDLGSUzU7/twfGsqE7odqnjhg0FCUf10=
Received: from MW4P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::29)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 29 May
 2025 20:08:18 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::f6) by MW4P220CA0024.outlook.office365.com
 (2603:10b6:303:115::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 20:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V5 00/28] Reset improvements for GC10+
Date: Thu, 29 May 2025 16:07:30 -0400
Message-ID: <20250529200758.6326-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 13adb2d6-c440-4a4d-cb72-08dd9eec8d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ryt4Z200RnVoQS9uTTVpT1QxLzd1UXhmLy8zOHRPS2RoVjJseFo2Ui9iblh4?=
 =?utf-8?B?QkdQaXdvbm53Rys0Lzk0elZEeG5aSmZPMjRxaUh2dXJlSW5jaDlZWEZMbFNh?=
 =?utf-8?B?SDQxUVhEaVBSb2tWdlVLTUkxOWV6TmRhL2JLRExDK3FpdmhlSDFtNnl4dUh0?=
 =?utf-8?B?a1V2OUpZY1hXYmZzVGMxTG5IeDJ6STVnZDMzalpmR21wdjZ4aEVNNStZOGhm?=
 =?utf-8?B?blVVV3NZZ2k1ZlZjOW1tMUJCOXVCcXJBMklvb0RRSEp5dFZvN094TGExRnZh?=
 =?utf-8?B?NDQ3ZWhNZU45OVZVMXRzV2ViQU9QT2Y5cnZUUzdnZXJLRWNmdVNabUVXSS9H?=
 =?utf-8?B?UmoxaTl3QnZCOVloZDhQMnhXYWJlMkIyVXFTZHB6KzdGamJXeEQ1a2drbkx0?=
 =?utf-8?B?TG9nMnFGd1hld2ltSnBHZFBQaWdXbE5TVDZVOWZhd2JjKzhuL2NzRlhHaVdQ?=
 =?utf-8?B?alpxVFhhWkZaU3NqUEwzWXV6WlA4TEMxZG8wSnRqUlJHNE1Lc0twZ3hDeXZ5?=
 =?utf-8?B?eVh5MHRIdFUwMlhLdlZEcVpiWkFBSzlsMHlxRmZQSU9kYUNzODNZSW9IRVFQ?=
 =?utf-8?B?YnpQdHFuVlNRcWxzTlA2WEU5cDhSdTJ6Vk85NkNXN25uRVE5a1RkSXVBRVlK?=
 =?utf-8?B?aks5bXZQc202b3pWQ0lJck0yUTVvWjEwZEUvb0pZY210Q2FSR3NaY2t6aWlu?=
 =?utf-8?B?anNnWTkrb3dNdjhtaGltclYwaXpBOEFSWWJ3cFQwYlFRcFN3N2xnT1lHeEtv?=
 =?utf-8?B?MkVqMmFDYXNhOFkvVmI4WjNHWTgzV3dndEFvc1FmWFlkQ1BwWUlONENxYVJX?=
 =?utf-8?B?M0RsR20zTnN6M1ZoMkNGOUp6ZTFkSWJpOXNmTGtUNjZsRWZYSms0Y0VJbFUy?=
 =?utf-8?B?Sk5vMncwTkhPaW1GbEwyVStCUk93L1poUm5XOWkxZG5kenZvcDA4a0w0K0k2?=
 =?utf-8?B?WVB1cVdpQTJFbkFMTER1eVVFOEJZQitVZ29ibUs4RnhrVklVYkk4SzF5cVJH?=
 =?utf-8?B?WUpsajhlaDJyQXRSN3p2S3FzS1VBa3JZS3Jsbm5qcUJld3V2VXFUQmtnRnVv?=
 =?utf-8?B?WUlHZWpCSDZwUnU0Vzh5cUpvN25Ga2pZcll5azdoS0w4R2lDUW9ocFB2cnZt?=
 =?utf-8?B?Vm1mUkphbGYyc3c2SHdtZmxuQ1FacnFOUUhSNEg2OUdGRVlRMG9HSjRheTRh?=
 =?utf-8?B?NlUzYjMyUXp3NmszWVEzTUFnYkpKRitTSVZ6SEowZVdSS1ZwcWVtSnRQMXda?=
 =?utf-8?B?bnM3V0RSbU1NTnJnK2VmY3l1UlY4T3hBYkFrTmlRRzFvOFFOU0VqTWVvZVFl?=
 =?utf-8?B?elhZUGlBV2Irb05SbndjSUxCeVcrTzFSaE1IR3ZvRG5ZalVhNHpwSnEwTUhG?=
 =?utf-8?B?T3Z2bU9veWhjcnZIb0QrdlZkR0gyWDdMZ0VoWVk5L21oUFlZc2RPUnFJODU1?=
 =?utf-8?B?NFhtSWRwTWR6d1RVcXgxTHAydlJBaDZCK2JoUk1vcjNJTTNrWnlwaHZ2ZXNy?=
 =?utf-8?B?OU5SUkpVYUVIZE9yT2hqSktTUmw1dm5UeHdmVVF6Y1BmY01ReGI3UnNmbGhs?=
 =?utf-8?B?cG1iTWdKT1lDNW1DaGlFaWRpZ2JBVHlVYnZzbGFMNnNBM09VQ0VFSjdIVFEz?=
 =?utf-8?B?eVd2MmFaZ1JrR21DNW80UU9GdXVGdThpODBVaGQ3K0g1TGIwRjQ3ZmxZcmlw?=
 =?utf-8?B?MEIxeDNtOXZYZXM1KzhHS0Z4MzNMZVNRQ1NWK3pHK1hlRXhIbDRpM1ZaR2FN?=
 =?utf-8?B?MEFPOFVNMFpwTmFYQXBpMVdZTDVlZnR1aW95TnRzeVdIbDFnOVpodGtYY01H?=
 =?utf-8?B?NGp6VlRnU0YxQjVKS0g4YzdhblhQbjZaMC9oTyt6Y0Z2dW80a3puUWkxM0Ju?=
 =?utf-8?B?eGNkWlNKMnorK082TmFVd0xROFlMakowNnhpZ0todEVzcWIyL3NvRDlzNmlt?=
 =?utf-8?B?S3VEeHpMbzhrM1Fja1YyNXFxdE5kU0VudlR6ZUE5TG5rNU13MCttQSttL0Ja?=
 =?utf-8?B?N2NYQzVTcm15T2Mxb2JVWE1leFgvcC9BamswUDIzTWZ3TkdUMUgwdXJWMzlt?=
 =?utf-8?Q?v8WfkA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:17.5644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13adb2d6-c440-4a4d-cb72-08dd9eec8d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

This set improves per queue reset support for GC10+.
When we reset the queue, the queue is lost so we need
to re-emit the unprocessed state from subsequent submissions.
To that end, in order to make sure we actually restore
unprocessed state, we need to enable legacy enforce isolation
so that we can safely re-emit the unprocessed state.  If
we don't multiple jobs can run in parallel and we may not
end up resetting the correct one.  This is similar to how
windows handles queues.  This also gives us correct guilty
tracking for GC.

Tested on GC 10 and 11 chips with a game running and
then running hang tests.  The game pauses when the
hang happens, then continues after the queue reset.

I tried this same approach and GC8 and 9, but it
was not as reliable as soft recovery.  As such, I've dropped
the KGQ reset code for pre-GC10.

The same approach is extended to SDMA and VCN.
They don't need enforce isolation because those engines
are single threaded so they always operate serially.

Rework re-emit to signal the seq number of the bad job and
verify that to verify that the reset worked, then re-emit the
rest of the non-guilty state.  This way we are not waiting on
the rest of the state to complete, and if the subsequent state
also contains a bad job, we'll end up in queue reset again rather
than adapter reset.

v4: Drop explicit padding patches
    Drop new timeout macro
    Rework re-emit sequence
v5: Add a helper for reemit
    Convert VCN, JPEG, SDMA to use new helpers

Alex Deucher (27):
  drm/amdgpu: enable legacy enforce isolation by default
  drm/amdgpu/gfx7: drop reset_kgq
  drm/amdgpu/gfx8: drop reset_kgq
  drm/amdgpu/gfx9: drop reset_kgq
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: track ring state associated with a job
  drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
  drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg5.0.0: add queue reset
  drm/amdgpu/jpeg5: re-emit unprocessed state on ring reset
  drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
  drm/amdgpu/vcn5: re-emit unprocessed state on ring reset

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 32 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 46 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  8 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 31 ++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 21 +------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 21 +------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 71 ----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 71 ----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 51 +---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c   | 12 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  4 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  7 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  7 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  2 +-
 30 files changed, 162 insertions(+), 289 deletions(-)

-- 
2.49.0

