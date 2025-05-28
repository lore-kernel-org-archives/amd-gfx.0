Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6106C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F9610E545;
	Wed, 28 May 2025 04:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hHcBff5M";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D764610E1C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAaRjEutBOLHo7zMBfgbZmAQQhUOqdigLFDlOocd0S/SBws9bFY/vP8TQLnIVAkFM4wFqgSSjyVsfZ53P06mlq7KRV7pheYga4jTf18xghVWzSIgx27YVBg5lfIkH8lKpm5FIBT7LWgS5b9x5ElSZ7Aa/bihERL9C6Z+Yiu+tedQsGu9bh4HqKsOUEU0GvcCEAQhmhc3YKC3rQnfn9/ZlUYs2rfMeimlTJx/hHC5MMWXw4gd4T5Yz1Jq2xwWn7RfY2WvwjcEixeknN0WlA/xSt+eXbzpaodfkRjia4wE0MKG10euo3VtxA3DkdfyA2KfGyIAuEJk2YWkLjQ31NhSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYjip72b6O2a8x1cSO4lfYwSq4+dHk5SRa+IFYZog5s=;
 b=J04JHx47yG3sn00XmwhaWwUeU5XkUboTgOSK/uzVPe0nczij/jDfqPFf8om0JpCrCnH/BMD9fw4aRMeIOnkNcBv4YIUEa6yYamgwTtjIsIh0YfmYFGzQ0yPfemVYhpQFxAU3bvH5Hl8YLLyb5EVKUaOMmDpelPZch5S9x2B5dtRknHvOOSSG1csQotMThqCoDYpiYtoFHzkpETrGJDzaT5tSUAourB96hzZBxg2Ks7TZFTrqJLDUN/za7TntZ5fO11ztmgleZcQ2FXkAIzhy7uJTu8srvryBzHMD0xhd44WTfERtluqcBbuwhCIwEB2LLWwAfdoZOMdk1V7YxD3Org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYjip72b6O2a8x1cSO4lfYwSq4+dHk5SRa+IFYZog5s=;
 b=hHcBff5M9yB8UCu/FYiekyGcnEbAvXzhVby963fGHpPmU4y4yWvxNLvj1BhdhaoWAue7sjWto9CLzNdontsHyPhqvjtb9mLuqoMnnGmJjpY/tQe9Zztbdjx7dwPxaGvv9ihyToNPIhSreioW72qX7DzLJqybPhiOQ0TcmptQ2I8=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Wed, 28 May 2025 04:19:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::48) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 04:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V3 00/19] Reset improvements for GC10+
Date: Wed, 28 May 2025 00:18:55 -0400
Message-ID: <20250528041914.5844-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: c786fdc6-642e-4e26-4533-08dd9d9ed757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUMwYjhDU2pCeWovZ1RNOGwxZVJnSkJ6eXRTQ3lwZWdibkRpMTROc3dmNXY4?=
 =?utf-8?B?UEdKTTJBbkdoTDdVZk5NcHlVaWQzUU5mRi9jZzZzQVAzVlA1c0ZjT1YzVDZC?=
 =?utf-8?B?UGpXNVR6bUxmRDJXQ2Y2bHlsZkt1cHoyd0dPR0wvTHJQSEtYMDVvYVRDYmYz?=
 =?utf-8?B?MG0zZmVHQXBMT1kxa0c0WWk3SmtNdFVxY3BaSzJFUEtBcngxUlJYNGdjd3R4?=
 =?utf-8?B?SFBMZEI0MGhWQWhlVXIxNFZDZ0NhNGFOeFU1aE0xZ3QyeWhsUFZBbjJOVXFY?=
 =?utf-8?B?UmxScThNMlZaZERyNEt6Sk1CSk5jKytoVTlaK1FhbTZTQlZabEhzaUgweVdL?=
 =?utf-8?B?cEpWTWIvdWw2VDFRMm4ycWpuSnl4QXk2RHNWMFZDbENONnRvbm5vRmxVMjlu?=
 =?utf-8?B?aDEwNUh2NTJjQm9ubG54eE9HSFluQmM2WStMNi9yZlZVNVVqa3RQM3NVTzM4?=
 =?utf-8?B?bndFanZXTVYzRjdxcVJHTDgyamRvdWFIUnV6TmRLcDVMWVRObnBJUlR2UTQ2?=
 =?utf-8?B?NDF2Q2l5Y1ZLc1Z4RVAxMWZPcEtsblJrVFpQL3lxbTFaYlZlVDJLUUkzUUwx?=
 =?utf-8?B?TmZZMGEvdGR5RlBZOTJYNXB5RFZ1TkdXT3JmYktsbWVKZDhySUhWSUlrelV4?=
 =?utf-8?B?UWIzbWY2eDRvZlYxQ3dMZ3pETDVNK28xT2s1cEhEaTJDbElWWUJmU1QxVmJC?=
 =?utf-8?B?aWcwa2o1ZDNtNlArZzlMV3VZTFBVWkl6NWdWL2xTNlROSmtOZ3VNREJ3eDBi?=
 =?utf-8?B?RmVpMmRmSmVFM1pVNktvckNJZVB3QmlZSmJ6TUxOSS93eGg4UUhEWkRBb1hW?=
 =?utf-8?B?REtUcXA0SWY2K3RsSzlRMVY0amZkOHJpSmladUQ3bUZLZ3Zwa0dYNHRhRHFK?=
 =?utf-8?B?VXpzWVhYRUowdlBsdmZ4cjNDWTJPSVp4OVhqYklGRGVPWXdEZzJveVJTNFZE?=
 =?utf-8?B?cmtKM0ZwQUVPMzZPSXVQQlBBcWoza2FTc1JreHdLWlZDTHdRYTU2U0kwSWl6?=
 =?utf-8?B?Nno5ZlJNL1ZVWFNQaVNlQlhVRTQ4bmMwRFpMZUhaaW5HcnpwT0YzRW1xL05N?=
 =?utf-8?B?cEJZWU1OTGhVNHVUbEREVFpzMFhjaUorUWZ4aWZHNmlyaGZuRWFkTFIxYTVM?=
 =?utf-8?B?VVJOSVR1QUpyckJ3VjRCaHcwWTlsb2gwcHlPRkZYYmYwcUp5YlQrcytNZG5G?=
 =?utf-8?B?bEJTMWJFMTZvdWhOQXBsT1RSOU1JL240VkMzaHhoVjgrVUxPZjVyYTdUUWNa?=
 =?utf-8?B?emJUM2JVRXZheUJnNWkxQUM2dkZvL2l4UzNmbVlVWk5YaGRFNi9uR0RYQnZI?=
 =?utf-8?B?MEFXYkNnTGFmZjgyL1VjSnhsekQwSUs2ODJDV0Y5bTVrb21GcTN6LzFGbUNS?=
 =?utf-8?B?WjR6a2EyNEcvQTYzdmo1U204RVp2a3Y2dHRoS2RKNnh6Q3ZidWdKUkd5UmNG?=
 =?utf-8?B?OTVyMk56UXQwNkV5Tk4wUUpUczVrZFk5RXBCV21PVjZocHk3YVBmZ24zYUEz?=
 =?utf-8?B?L1BWOVBoQWFsY1dHbzk4QjRMMmV6VGwrZ3JFTVJUYzFROUtOR091OU84UnJU?=
 =?utf-8?B?ald3RTg0b1lQRmpXcjJIZk54V2RMTzVNTXZlOGVKcjEzK3oyVkZ4SXk2VVp3?=
 =?utf-8?B?Y1JScmxFc2QwdjFnUENiN2ZVa0xMSldJUkVpZDA1b3VvdzBqcGpSSlY4MG5G?=
 =?utf-8?B?d3c5OUllZytZRDVRczJ2UDVKZDBEMlhyRnZPcEtBNUo3bmxNNnlSaXZ2MGNY?=
 =?utf-8?B?UTZZUVhoMzRiakdiWm5sZzhMTFBWR0ZCWnBBMjNtTVBqNlpjNTlNWTNmN0wz?=
 =?utf-8?B?UUJhQTRoNmUzSkdsMXd6ZVY1dGdjOFN1RnJYRC9RLzB6Qkd1VWhUK1ZGbWVy?=
 =?utf-8?B?R05XZlZpRFI3QTZRc0NBd1FZMTlHVTZNYlZBaWlZWGdOUGNYY1FBcFozdVB5?=
 =?utf-8?B?ekZ0SWR1ZzBGYzhhS016QTNQb3ZJWEorZk5MY1VQaSs3aFZ0dTA4ZHpTWTVl?=
 =?utf-8?B?TjBya2paWHQ1Y3YwM2Vab0FhUmpuMmVlZXYxcHJHeUVlRU9jSFBzRUxUZkNm?=
 =?utf-8?Q?etYWwm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:29.8901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c786fdc6-642e-4e26-4533-08dd9d9ed757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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

Alex Deucher (18):
  drm/amdgpu/gfx10: enable legacy enforce isolation
  drm/amdgpu/gfx11: enable legacy enforce isolation
  drm/amdgpu/gfx12: enable legacy enforce isolation
  drm/amdgpu/gfx7: drop reset_kgq
  drm/amdgpu/gfx8: drop reset_kgq
  drm/amdgpu/gfx9: drop reset_kgq
  drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
  drm/amdgpu/ring: add helper for padding the ring
  drm/amdgpu: pad ring in amdgpu_ib_schedule
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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 32 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 52 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 57 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 48 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 48 +++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 71 ------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 71 ------------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 59 ++++----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 15 ++++-
 13 files changed, 192 insertions(+), 278 deletions(-)

-- 
2.49.0

