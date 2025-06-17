Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10241C7115F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8F410E483;
	Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwCfSbXo";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01B810E3BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbl0FefitgAstsNlhsia5l4GLu+EcJzYTh52D9L3D5Hs1/3HNvnrCTjpwwvqOvPajMdBYfl9Y3bBuxmW4rQPRGFOzB4UnwLH16P9lzs+PPck+SN6fAmQqjobrRGPrI+u57eg8iLCR95kgYijVSCXKXpMO0TmOxUvhN+rtjD9cCbLFz34r5DXc/L/KKVhNE0JM6Vs7AraY80Wu/nG4cAsFCxMaCCAuQ0UdCSVfKhjjFh0Dzye2bEpwh0N+bRzEzDF8TTBfSpx+xYwFxSignW136Rfve+jfF+e2QyJD5HVXJ+BZpMpuBlVG0lN3aru8LF6yQtG8ZTuoJh6y1fK/HetCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt4nkXDW3chcPgud3WsfPkAwz4CZaypdC3EAsU1XNxI=;
 b=imkFnt6mLvEwSwMP3R5dOoueC01Pls3kF7s7mdVhtmwvB7Y4eFaQ4OXe1/WwNCpCxmu05nR6l/GCw5Ls9pxUucCFYIcWoKjkfrw8n8UjiWU2GnkwCKq65Thnv2J61jQ7HAfxb552byrt3Er/DT4Zc4MWSOpv4V4KKPe6Gf+nabDC+TUFshaeST54VuQ/aHkImrDvdj4CVqnpz1y7Sv3nJeOFbrKbBzZ6wTIi5zl+vNghEPwEDsACiqZ2Q6/8oYCu9kbVu37gJ06VAMVqZ00pSpcoJ1vOiebCzTRrcGgDoygMcYGNwA7um8CSY0EVujTl+uoNp4BXzpJaJjk5XAjI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt4nkXDW3chcPgud3WsfPkAwz4CZaypdC3EAsU1XNxI=;
 b=MwCfSbXot5tpxpewH8lYa+O+5Z7ylpGMKjJpIjn368TPTXPkvL8KPE2swUFfFlMdTfbHV8j4lwHD0zHzWsNTdKY4OfLgjE7zemMGoeBp7r6QtxOiR+i9S0ZAbYXeuzp8UNCmtr1trbD6vjL076heOHzrcNU5frWZr+tApfWIIRQ=
Received: from MW4PR03CA0009.namprd03.prod.outlook.com (2603:10b6:303:8f::14)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 03:08:31 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::a0) by MW4PR03CA0009.outlook.office365.com
 (2603:10b6:303:8f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V9 00/36] Reset improvements
Date: Mon, 16 Jun 2025 23:07:39 -0400
Message-ID: <20250617030815.5785-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8a3f7-6ded-4c83-246b-08ddad4c3cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qmp6QXJGeW1CZGw4a21NVktkNjJCRmo3d2thZzFaL281LzZVYkF5UWRaNHYr?=
 =?utf-8?B?amtKNUFFRi9SS2VUNzNPU1hBK2ZFV3R4Q2E4N3loMHA0Uk9uUDNmU2RBY2k2?=
 =?utf-8?B?WDFkbUhlMTJYN2ROVE11ZkllM3AwZDRHbFNkcDZZcHlBTjJKZGZtZ2R5NEk4?=
 =?utf-8?B?bCtEbytHdjFYaXgvb1dkeWF1alJKcXdnWFpKYkQ0R3BGRVh3TGZNb3IwY0k4?=
 =?utf-8?B?d3JLQWdEK0tRN2lmeUlVamduK3NaSEw0SG9NK09nSVEvSXh3TFlEVEJCV0Vt?=
 =?utf-8?B?Y3NGRXdTMXhFVGEyNWlVc0FrME11Tk1lcVNCM3dnWXFNSEN2dkExMzBYdVRt?=
 =?utf-8?B?Yk9RZDZ3Q3FVeVZYWTNtR0NHMXQrMno4TDZKM1NmeTB2NWZKTllsZmRpVXRP?=
 =?utf-8?B?MVZ4ZG5FQTloY29XODllK0c1ZmtuZjJFY3VMMG1jTHBEVVdPYjBNUytGd2I2?=
 =?utf-8?B?REYzSnBzaVlqM0ZkMnZjUnI2RGh0TE5tQU81RWN0QlozR0hCaDE2S1I2MHNX?=
 =?utf-8?B?R1RRbTFMc1RvbHcwODBqK2FtemowWTRCYkZNWWI4Z3FnUXk4aFRTUTd6Q0cr?=
 =?utf-8?B?ZFJXb0pYQ0poREpUMDF5cnl1UE54cGJTdWcwUmh1WEZjTmFYSTVsK25SWU1P?=
 =?utf-8?B?ODRla0ZLbjhOSG9MaHJ4T052RUp2N0pZdTBhSWtRb2lQbkhScXRUTVhPaWZF?=
 =?utf-8?B?Q0VQU1BkcnFEQ1VBeUIzdXRTUDQ5Y2JNdWRqTVVzZ2JiYThSdVcrdS9tazdk?=
 =?utf-8?B?MlBnV1FTR0FlcC9sd0d2VVgzZVR2SVptMmY0REhEOE9NSE1MRE1samtQalQ4?=
 =?utf-8?B?dXRCU3pQOTRhdjFyS3V5cWg5TGtqNDhiT2pTK1psOGdpT2ttcmdLRFJSUXlC?=
 =?utf-8?B?b1ZQdURLbFRCSmo3Yk42VUVGMWExNFFPWUpMTG9iNG1wL3d6aHVRTXpneHNo?=
 =?utf-8?B?Um5vemJLWUExTnJHbS9qb0FJeEhUc0NzZVREZHRaWlkzalhWVDk3b0NpWlVF?=
 =?utf-8?B?MXh5cEpOYlBIMkFzemQ3UndOSUkxYm41UHB1VFZxbVpRc2dFczVTZkJlMnBN?=
 =?utf-8?B?b1ZkYlE3NFRVYUpVQjlUNXBjMElQa1JVR25TQ3dTT2RLK0tUUE90K2lVR0lW?=
 =?utf-8?B?UElIREpRZVZJWHYwV2VybFRPdC9yaVpMSXZGS0ozVTFydjcrS1ZzelBPME1R?=
 =?utf-8?B?cGhGMzIyVndWTmhGYVhqUGhWN2dLYVRzc242bSs1enJtSWNCWmZsTHYxclN4?=
 =?utf-8?B?TFBqZW9ONDVxczUwS3lseVVXazZxaHdjNGJOSlExS1I5SDBKbWszbFRKendR?=
 =?utf-8?B?eWhBN2lKVXdWZHdVT1VWYUZsdVNIUVRkSTljbkNrZVJ1UDJvbEFWbTh2cGZN?=
 =?utf-8?B?aGNHSGY5WldHREQzRVdnSGU0bDZ1SDlZRGU5cUwvUFArS3BEVXNGSkVIWmtv?=
 =?utf-8?B?N0FJWGhRd05XQ2p3VlVJYlA4UnNUc3ZWekVGWXFmdkIrRGxUeTIzWXlHZUZ2?=
 =?utf-8?B?aFgxU3RKaklpektVYzF2OW1yaUV3cHJTbFBxQjduUWhMTHh0amJqK09MRFk3?=
 =?utf-8?B?dm5Xc2tadUlMc3ZFcSsrZ1RpR1MyUnRVMy9INmpQQ2FKd0FtQmNqUVYvcUhm?=
 =?utf-8?B?TmlGV1lzSFZQSE9CcHA4aDl3NUFLNmtrdE8wUklQUFJEN2xySWI4UDhlOUFZ?=
 =?utf-8?B?QjNRQzh4eXUxT3BvU2c0cFlNTHVPWStrOEJEYjBEaXJtRUVVaDB1Qy9qaFNm?=
 =?utf-8?B?bk1EaE5VZUJMVE9iZDdFekg1YktPRFppK21WOTdMZmMzK1dZUGFOYnJ2eDlQ?=
 =?utf-8?B?WFNML2NRdXlQMThubEM2amJUWExjOElia2VJNnpLS2RmVk84ZXphVFMyNkZk?=
 =?utf-8?B?cnhRTXBIN0hvNHp3NUY4ZW9NaFp6NTViQ0dwQWhyaFNGd0grdldBREVzeUMy?=
 =?utf-8?B?WEVwaFZFdHhLcUpxWER0cTlkZEpmTG83TEJrZHdBRjNaOGNwekhHRkg1RUhh?=
 =?utf-8?B?VXNPTkhWNVNRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:30.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8a3f7-6ded-4c83-246b-08ddad4c3cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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

Git tree:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=heads

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

Alex Deucher (35):
  drm/amdgpu: switch job hw_fence to amdgpu_fence
  drm/amdgpu: remove job parameter from amdgpu_fence_emit()
  drm/amdgpu: remove fence slab
  drm/amdgpu: enable legacy enforce isolation by default
  drm/amdgpu/sdma5.x: suspend KFD queues in ring reset
  drm/amdgpu/sdma5: init engine reset mutex
  drm/amdgpu/sdma5.2: init engine reset mutex
  drm/amdgpu: update ring reset function signature
  drm/amdgpu: move force completion into ring resets
  drm/amdgpu: move guilty handling into ring resets
  drm/amdgpu: move scheduler wqueue handling into callbacks
  drm/amdgpu: track ring state associated with a job
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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   5 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 175 +++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  19 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  60 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  59 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  43 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  64 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h     |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  42 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  33 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  33 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  11 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |  11 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |  14 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  49 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  17 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  17 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  25 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  25 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c       |  25 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |  24 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |  24 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   8 +-
 38 files changed, 629 insertions(+), 275 deletions(-)

-- 
2.49.0

