Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2E3D262B7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC44B10E10F;
	Wed, 21 Jan 2026 03:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YWSn0CWx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90ABB10E10F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/+DkwUG94tNnLaLLpmBhuULYsCcStoTd1uAEE3VLTFP2eyEGS2R67FOv+/TjIp8w0BmLfGb1cpq5nO6d0VTQjwtHF47vr5NQzWKcPSCTW5pCMMccB9T/Bl+DWaV22+goqJ6uBvBqojDBoRegRlAVNtjpaGhd365dsjzIdZfcXsBfBwGBtr1BXgkDvexqHlntlAe4wSgfdlVtfcerCf8Vpb42jFFkYNVFDr/w71vWvE0nZ4eGb6x5lVwzv2GuW57DuAsbn4AdXa+py9PEjdoVDt+Ggt8loqBVSy9Argc5HeFpZ4QwE01vfMCqQXHypfiBIXbxe3vipsrW3RVHpmIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bB/7ol1oZZ8r2m1pn73AwGjwW4odKrzz0CZw/f22inw=;
 b=W+O6Zyb/FE1dZ9NTUAhJN3Gcw57+wr3pzvOKins0loLIZMTBvi7p4T63dp3FjjD94HK93971gqGtzYQZcdcoahrkc/dxlfXMDUbsR2pO+3rGxd9Ns0dCPOxinOv8wksH+bnkfzj4sFiutA98r4MetbRFjqQDMnVu7wl6HQ6Sc55CKDMQYJm1r91t5y7Mh4iS2HFJCQQxCVEYRyi+7omB+LhoVkw1tbAEqTB7Tc/A9KG1dyP5g07UoagrgDX57F+0Jgwrdw2v/huXbiFPdc5NfjmtyB7x0kaKjGkLCwzmfap0/JwtaKFIAMjB2Mw9nJCljOlwVnEP5w0nEY9PBsNH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB/7ol1oZZ8r2m1pn73AwGjwW4odKrzz0CZw/f22inw=;
 b=YWSn0CWxr1Gvwq/CvmKzQVbPx2/zjYt5MUzLMh/sRuk7fyDMXT7ykjboAHcB200fBisJIhR65f/S7oPOOsQDWTtQODrg5+E38XJqKtfWzyOlWrnTMTcZd9IeFa3+0EUdYg+mHNW6MOk9It6aDd0CPcWmFUXm/zYORnWd0csBIu4=
Received: from SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::7)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 03:01:10 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::25) by SN7P220CA0002.outlook.office365.com
 (2603:10b6:806:123::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.13 via Frontend Transport; Wed,
 21 Jan 2026 03:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Jan
 2026 21:01:04 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:03 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Improvements for IB handling V5
Date: Tue, 20 Jan 2026 22:00:47 -0500
Message-ID: <20260121030057.1683102-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 36062884-52c0-4698-827a-08de58995446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eExFbGJDOFliS2o2SXpXYW8wRUJFMWVQcWNmdWE5ZENVVWZkaHZhaUtLdW9M?=
 =?utf-8?B?aFJhWXRrbEdxaDdtMHN3R1liZjFoRHI4alZFK2xvOHBsWDZ5OVQxNTFabTZk?=
 =?utf-8?B?NWhPUGp1MEN0bWV3N1RDQkcwK1NGYXByZCtGcndKMGtKeU9vWmNjU0tndVhQ?=
 =?utf-8?B?ZFl1OGZiczBpazV3dlRoY010MFNmS1QxWXdZUE9kVURvR3NMS09xWGxacWRM?=
 =?utf-8?B?NlB0eFRRMENBTUhmT29RU25Ga1drUDI3OXFFR0Zsd3pzWWp6aHg2ekpZdmJs?=
 =?utf-8?B?TWRiS0tieTA4dk5ZYm9PdEtwRzFES2d5Rk5uZjltN0ozUW10RUgwenFwSXQ3?=
 =?utf-8?B?TmV4SkQwLzVJbGF5SjJuakxDUDdSODgyaW5WWkpLb1ZCeE9vemhxSnBucFdy?=
 =?utf-8?B?bHlJUTg0MGlKcERtMm5GQ1VTSi9IZldRSWI4ZGNmNzZyeFNJQXdWa2Y2cTRl?=
 =?utf-8?B?VzlOVzlCZzZaSmRrWFRaaHFHeloveXVoSmVrdDZpVFo2STB0RHlBb2VxdzlN?=
 =?utf-8?B?RWVlTzAyRjZHa1VSQ0U5NjBydnB1WEh4QTg2VFFYdWF6MllhTjNHdzVMWmI4?=
 =?utf-8?B?VndPbi9BQnpWODlDOEpvVVhZSnRJYXlWTFRqOXJVdEplbks5UjR5MysxeVIv?=
 =?utf-8?B?OVlBeUhxVGZLdnhFSlhBSGlHK2ZHMEcwcVNZb2JCV2tHOXhBNGE0ZnpoVnMx?=
 =?utf-8?B?dG5nMHFKZHhNREhZNlpJTW9POHoxN3dvbVN1WExPUlpIRVAvaXJRUEVKeGpK?=
 =?utf-8?B?RVpLRDNYM3BnYnlSaXNyTE1yT3ZNMnpyT2dkOU1DRkNqSFc5N2QrcE9wdlpu?=
 =?utf-8?B?c29ZUkFvTXd2N0dGRitkMUtJcVFVcDdvZU9NTzNreWdWaGk2bnVxYmpZU296?=
 =?utf-8?B?bUQ2Q2NOMENZK3lkNmhGNDVqN0s0STUyWE9kdHpTc21hM1RKUGxSNlRzMUp5?=
 =?utf-8?B?czZrc04rOEF0eUJMRlRpVEZlZzFjOTFUelVkUnd1MWErM2UzdlV4U3JtZmtW?=
 =?utf-8?B?eGlZNnRMYW16VkFGSFhVYXFJQitwUExFOGlLajdTWjgyb3dIQVd3R0RFeUQ5?=
 =?utf-8?B?TGUreFA3K2FKbXRSSVRDWk9UeUR4Y2NzZEFiRUF4eFd2OFhRcTBHcTBwK3lC?=
 =?utf-8?B?Q290OUVXM2FrWkJvb0pUY1grUC8yQXZuR0hydGlRY0pEZUZUOUo4RWxhbHo5?=
 =?utf-8?B?c0tWNEI2VWtSc1RjZXlhQTlOTGt3WDJpd3kyVFQvTjR1RkFtYlZESHdpTjdU?=
 =?utf-8?B?ZDlXR25tdDRZcHZhL2xKUnRMS2s5cWVCN0tYZjgvY2xpRWdwb0o0S21oVWNV?=
 =?utf-8?B?eUNlRzMrVXlaVkNVSkMwMWV3eEg2dU1aczZVZmNlMDZRMlFiZ2lCelZBQUkv?=
 =?utf-8?B?aldpYnpyTmN5U2JHZ3MzV1lzaUZPczhuMytqUjJvOEdrZWo1NWM3YTA3Vldl?=
 =?utf-8?B?Z2hQT0c1U0lNWnp1MlZEejc4eGoybjM4OEdzWlFsUURjeWJYcnNOMkJWSUxH?=
 =?utf-8?B?ajJ4SDhLekJlelBFSG1YRE5XdmRxZ3A0MVJoM2UvektEQXIwaHpVcHNwS1h6?=
 =?utf-8?B?aitWRDZTRTVaZHVxUG9VcWdIQjc5Mmp5QlVKUzZINHR1ZldRckhtanBKRUtC?=
 =?utf-8?B?S3AxelhIcW8ydGNESkJjajVhc3YrUE10WjVqUDVNQWlVc0hramNaZXlHR2d0?=
 =?utf-8?B?b2dNVlhHNEdzY0lSWVZCY0ZsREdkVkJBVWYvS1ZaNG8wSHgwV0UvWXY1bnRi?=
 =?utf-8?B?N2Q4RFhQYUs4RTBYc1hUcWg1VXpZbXU3YXYvbDRlR2xCZFRHcEo5VU5RR0Jk?=
 =?utf-8?B?blBDTEdFdEtJRjUyTng1ejhDb0Z1ZUQ3U2FvOWVzeURURmxXRVlRSWNHVGNx?=
 =?utf-8?B?ZlIzRGNTc1dUOU81VmVzd2FOU3N2Sk9SeWpSQVRkaUlUdU82d0FCbURneUtl?=
 =?utf-8?B?dCtodjlJSmlmZU90Qm1lMElvbzRaenYzZURESzFVTlhGOFlyNHRwMFM1cHB6?=
 =?utf-8?B?OFFQc1RjSGI2OFdEZ2FOZXV2OThnNTNVNkJERjdXU041Y0V6UXQ4ZW1aaEV3?=
 =?utf-8?B?QjhGTWtwcFJ6U2taRE9UeFFlZTAvdGFMcDdkcWcwRSs0MEYvRzlzNHlRREFM?=
 =?utf-8?B?Nit6L2M4WFlSeWM5Z01STjN1eDh1S1QwSjlOS2FVYTdSREtXaDhIWG9aTncx?=
 =?utf-8?B?Q3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:09.9028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36062884-52c0-4698-827a-08de58995446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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
to determine the alloc flags. No changes in V5.

Patches 5-9:
Improvements for adapter resets.  Properly add the bad job
back to the pending list so we can stop calling
drm_sched_stop/start().  Return the proper error number
in the CS IOCTL when the context is guilty.  Now that that
is handled properly we can call drm_sched_increase_karma()
for ring resets as well.  Properly set the error on the the
timedout fence for adapter resets.  These changes also resulted
in a small clean up the the VCN reset helper. No changes in V5.

Patch 10:
Rework the backup and reemit code for per ring reset so that
we can safely reemit repeatedly.  This removes the current
single reemit limit currently in place.  V4 saves and restores the
fences rather than emitting them directly and also saves
and reemits the vm flush contents. V5 simplifies and further cleans
things up.

Git tree available as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/ib_improvements5?ref_type=heads

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
  drm/amdgpu: rework ring reset backup and reemit v4

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 134 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 133 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  26 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  50 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  30 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  52 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   2 +
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
 38 files changed, 711 insertions(+), 681 deletions(-)

-- 
2.52.0

