Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C38C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D3D10E6A1;
	Wed, 28 May 2025 17:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJDIZUGK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC66210E632
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiD6KRDfdTFHR/KXKdatawBPxeRDm1i3wp9CFyYGm63JWmB67vDuMCzsZoOg7+OVtXbbYaf2h48voNuBjrYB3VaCdMLi7eZvvsXF+8E6Wyn09VMjnY5Efk4irAGPBuMxRBQWnfbrSe1RGdP2IfkKcLtbLSB7zEzN3alXz+NMU0RB/C077JraG+xqWF0Y9th5zvWSp0qreJuhzpovyKTon/QlPwydYn8bYKUpkTu06xsA0wYtfOEyQfXEqA9HlkPtCwCvmeYM+eR6b6qbNb7lCofGblPAezqTpzP0wiuZmYNpjJ015+g8DNxaa0ELRq7rT/hbqJWJ22rtXKe4/Ji92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V9eq9uMB/pgROlnep3gYCDwFvoS81j5ry4PjMNqgYI=;
 b=IdotOgMk3E2XO4q8S4ZC3RY+uFqA6NI4riEVROfTMcKcgQrPui7mFWIosm5PeYgdPpbOf+6pKiYe0IykDa0Y5OzMTJpcA9Jmi7e1jNivOccsI4DP2sD6hVNSY4OdrZFMWG44jNQqQfg7jTiqT4EtvJHmZy7usHofNPiTZokJqNdWnD+XMqyrnGkt3XWc7IYY1S6R1KVuVgRyuysFD8eVak50MZb89zZAsbESnkRxSL5l9NqJieEpxpOc3HV3ArLmefFyCNm3YBHQj2lPjPXlEr640ljTLKx6h7XJA82e/DmmctuxDPxwgpRavCgSaPN5oEctituyFViVUfPhxvPibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V9eq9uMB/pgROlnep3gYCDwFvoS81j5ry4PjMNqgYI=;
 b=NJDIZUGKx1LP03EolM//1wE1yZnCgCRVfxKh28TegXRCuQpyjxngjvB3PXY7dMLdDagpt5yrrLinObV43vgf//pTiPC48IqWeiLs3fGpOvyWLfh2zGRd+FfAzl3ILcfjUF9aRTntGKCWkhpm1S9C/6unRMAjMXuQcmyZvQ8WXq4=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 17:28:16 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::46) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Wed,
 28 May 2025 17:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V4 00/16] Reset improvements for GC10+
Date: Wed, 28 May 2025 13:27:45 -0400
Message-ID: <20250528172801.34424-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7b7893-5c14-4b2a-383d-08dd9e0d07b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXorcklEYzIvZ1gwdkRxODYxVmRMRHNmcE1VSTRMK0NKaGZDdUx0dzVGaHFr?=
 =?utf-8?B?amh0d2RYeHR5UmVFVXRDMWhYQ1o0SkllUDVPWlBQS05SRzFtbFlVeHVHQVE5?=
 =?utf-8?B?RVRwZTFNcDdFL3RnMU1JRnI4MTNDQllzcE9VZlFTTUtZK1BnRWFRd0JLSUxC?=
 =?utf-8?B?NlF0NDhKZk1yZHpCZjBWaDIrMTJqZDlFeTVnU3YvOEYzNUlLNUZnYkxxUU1s?=
 =?utf-8?B?SnlDV0c0VlhHeG1XVzFBVVQrSzRQaGNsSkNGQnJjWU83KytQSWhBblBITTZ2?=
 =?utf-8?B?VjNLSXYwVnljckZ0U2dpTlAvMEF4MkZ6SXFFWFE3VStJNGM3eFVRdERKODB0?=
 =?utf-8?B?V1dBL3N3b1JOZ2gvL1NaQ1hRYS82bTNzRmcwbUR1L1daU01tbDlYY0RvL0hz?=
 =?utf-8?B?ZmwrN1BOaFdiYXNyeXpDQk1McUdxOWh5VUZaWVQyb0hFY29yeGVpMEdwYkhC?=
 =?utf-8?B?WFZhZTNsdXlzVDVOL3JZSEFUZHNuK1BQM3I3QmpNelpQT1RtRFJnaGUzcnFj?=
 =?utf-8?B?b0tTcjVFUk1UYXJFeUVjbFIvRVNPN0xwSkVrNTkwUDZubFh2bFo0QTExcTFv?=
 =?utf-8?B?M0lLTkFPMEtOdnhJTWJxUXZUTkl0ZXhGZVN3OHZNVDdWZEZ0enpGUXpnVGJM?=
 =?utf-8?B?eXVBbEhsUFY4bDVNdnBBUnlvd3gvY0FrZlJ3a2hmcHpYTGkvNW82Z1NxMXhq?=
 =?utf-8?B?YjhabmNhRFd4WTdLOEU0d3lLOHQ2V29kTmJwS3dWWXdEOUU3NnZJWEkvcDFL?=
 =?utf-8?B?UW5MTGNUcEhrdXFub2FIQUFpVmx1Z3A1Z01SaEU2MXRzT2xrckw4RmZicExr?=
 =?utf-8?B?VWtPM3UzTUVJS3BCUzhPUWhDVXRVVUFKWGx6M0VPOUsxOGo2N0E5aU1Hc3lY?=
 =?utf-8?B?VEFxdzl5d1NsREJFWWROcDVrc0VqQ1BrZGNpUVRyd09venlGRG9HY2lBUW5j?=
 =?utf-8?B?RkxsUUdVd1lrc3JtNnRHSHB4cC83UThVZ2RnYlhCVklFeTVpVk9wWXFnVm50?=
 =?utf-8?B?TjNFcHNjcGFaK2t4UEZUbk14dUpQRTlVOS96aWh0RE1wa3dsSG5VU2NtVE44?=
 =?utf-8?B?UkJUMDlUUkRVZUltMjVMUUc4WlpmL3RPMXpaNTBweGFQN2NaYWNzTVo2eDFu?=
 =?utf-8?B?emlFRGlwU05kSzVjUmhkeHVHWjJ4NENSdmdKZXJ6ZnIrc3hQY3UzRFI3enVn?=
 =?utf-8?B?Qkt1RnpyN1l1UmpFZnlDdkNUMUR0N3c4VFlXZHBGb1VQWnJUMy8rSVBsM0JP?=
 =?utf-8?B?NG1SaEdiTjFRZGNkb1UxWlcxalFLQ0xqSjJpanFiT2d4TUdvT0h5TjQrS1Nu?=
 =?utf-8?B?ZTJTRHRyNGdVOG9XNEdRUG9udi9mc0JRZW5ZNnlITy9UM3I1Y2RMdi9vRjRP?=
 =?utf-8?B?NWlTOHVGYVRoUmFiaWs0dTVQTHRPOFo5Q1dYOE4zY1ZRNndib2ozZEpXYWJp?=
 =?utf-8?B?aTQ3MkprRlI4V1JYQWx6TFVRV09oMnFBQ3lKKzZXL3duZzNhbWY0dzV3ejJS?=
 =?utf-8?B?aThrME5tVjVjMFZJTkozN1g0N3NacXZYV2d2TGlSZ2NGK0taeWw3SWdEa1JI?=
 =?utf-8?B?M3BLWkxBdjZISmIzMkVUcnJ0WlpjYUhhQXlZck5UYVcwVHJ6dHNkWlF0WDVw?=
 =?utf-8?B?TmZSaUIyVG1ueVB4QksvVDFENlpBWDc1cmtpK2k5NUpnelA0RVZvV3VibWFo?=
 =?utf-8?B?NXpueGEzMHRXOWRCbnUzKzVQbVhiRHZRVXl0UG9LQnc4azNNM2w5R2gwL1NP?=
 =?utf-8?B?dURUMUJKNjF2SzZJTk5KZHEwK2ZNNWFjbDV5Z1ZnSGN4aTBZbXFQeWJ2Ykdi?=
 =?utf-8?B?Zy9idTdrWXJIN0tkVEpRU215Z2JFTmdlUlduNnV0eHJBNG9UeXVzVU1iZzZ5?=
 =?utf-8?B?MVg1L3Q0MkEreThPK3NHZzUwZmk2dHozb2hjTGZUNzVxN1lac1FpRllhNDh0?=
 =?utf-8?B?QlJrOXM1azFIV21VYnhmblIvL1MvelhLaGo4b1owTXUxdnhHWXdGZkdjU3ZG?=
 =?utf-8?B?ZHk1ZFRxTW4yU0xzVVBwdW1GdlpLQTR6Q0k4aDZYTFZZejlqT2FqaFh1YXRN?=
 =?utf-8?Q?apvFrr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:15.7151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7b7893-5c14-4b2a-383d-08dd9e0d07b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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

The same approach can be extended to SDMA and VCN in the future.
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

Alex Deucher (15):
  drm/amdgpu/gfx10: enable legacy enforce isolation
  drm/amdgpu/gfx11: enable legacy enforce isolation
  drm/amdgpu/gfx12: enable legacy enforce isolation
  drm/amdgpu/gfx7: drop reset_kgq
  drm/amdgpu/gfx8: drop reset_kgq
  drm/amdgpu/gfx9: drop reset_kgq
  drm/amdgpu: track ring state associated with a job
  drm/amdgpu/gfx10: re-emit unprocessed state on kgq reset
  drm/amdgpu/gfx11: re-emit unprocessed state on kgq reset
  drm/amdgpu/gfx12: re-emit unprocessed state on kgq reset
  drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx10: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx11: re-emit unprocessed state on kcq reset
  drm/amdgpu/gfx12: re-emit unprocessed state on kcq reset

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 32 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 23 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 67 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 60 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 60 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 71 ------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 71 ------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 65 ++++++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 21 ++++++-
 12 files changed, 214 insertions(+), 269 deletions(-)

-- 
2.49.0

