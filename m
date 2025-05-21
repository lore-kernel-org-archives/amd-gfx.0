Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45B9C54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4152610E780;
	Wed, 21 May 2025 15:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWUtMEUN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9096610E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfTmX8HQM4lHXc4YKE6zbs+s5elzWKYsMeKXVuJHbd4Xra/OvrZabuJ9sQFlxzep1/RnlxyUdAe/NX57adAYJWrHE30ps+/K9Z7YNGWVqfKLZVRcK9ucHt4V24cXT2WZ0iJTASPPmvtYFJiFTdhb6H3rEX38defLFfSinljqBuns/PT3+nqRzW3oFgoxdUwEV+db3pShzc3oEig05fzCh9jIUFbU78yIfugPjJN58NAwv/0Cq0SnRMNm+YFf+utjQtXfJlbNTHofzdT6Xin/4nZGKEdAeiucgIJHjTCE44Lfm0oG8K9pY3UCThcf/jHyEVjoEVrySt1svYIQW4LUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1/0TbB4De+KthBcXj1jawzGEBOz+N6UYRTK+JyzXqQ=;
 b=W79D/nBY0u3snfFFNgdhM+SMC3MsA+h0mC9qreNDKva75wYZTgVlRY9YAyeYrK5QXqg//WX7i9QC/SdPFmXkWWVUoYGC4czznJ1QF16wP5WM0Vp9wfRsJid/9Ek831xVI+QgK0RSO/xTvCSz7XpACcJKHnQfmSBvObSjQfHH9yuscBDrSZ4iiUJBJ1TWs2VcC9KtHtzfAJTBx9yWVtJ4jywhkqMgn8p/M9E9/nCAyu9c9ntLJf/ImwRggxsZR+T0wQNz9sE7WpeezCccJHrWkDbEvENVhwh/OtbuMy7468pjQT2oCWt5NH6sy8TBMNVeoNUdXzq5JQZ/m47khVFQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1/0TbB4De+KthBcXj1jawzGEBOz+N6UYRTK+JyzXqQ=;
 b=FWUtMEUNhC4LujYOhc+q3fePBnyZVtRUUBsIpfwKtMFYEKzfS7zNYaUWIwYAlmv/a0PQeWBAMheJ/+BT8wJknt4PTb9eJwbw4L7RMmboWvrDjdOkTeHJwVT6AA/DHYohpUh06rgH/Za++fTUn1crbJZA5Z9TRGank4TShlFZiCI=
Received: from PH8PR21CA0006.namprd21.prod.outlook.com (2603:10b6:510:2ce::18)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 15:29:39 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::da) by PH8PR21CA0006.outlook.office365.com
 (2603:10b6:510:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.9 via Frontend Transport; Wed,
 21 May 2025 15:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/10] Reset improvements for GC10+
Date: Wed, 21 May 2025 11:29:13 -0400
Message-ID: <20250521152923.401945-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4b8b26-3f42-4d9a-7690-08dd987c4ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmlFSldpb2E4NHdtN3duS2dTdVJOZk9ua05qdDRsbkltNmR4ZXpyWkFSRWFE?=
 =?utf-8?B?SURCSVhJdmlHbmQyUmFLS3lUalpyakJ1R1c2SW1RMWs2TGdJSXd5WFVHRFJW?=
 =?utf-8?B?U2pqREE3QlJ4SFVvSVJHZ3k1UEdyQ0JaSk9BRmRkMVBKYVEyNDlRb0JxREVy?=
 =?utf-8?B?RG52Tk1QUGZOZ1lZV3dGVXhEWU1qVytZc0hJa3Rld1h2cW01Q2crdEhNaVJa?=
 =?utf-8?B?b0NKb05pM3lDNUtkQk8zMXphU3hOUmR6NmZQZGtGanFYR0RscW5OZXNiY0ty?=
 =?utf-8?B?K2J2OXFqTTRydzNQWEhTdnBlUUVjYXVkcVJ6bjdkN1ZYVm9Ba3hsSFl3WTBo?=
 =?utf-8?B?Um95akV1Uzd3ZkQrNmlOTjBMUVFoY3pSeVAyTkh6aGZLS0RpTzB2NFE0dVVt?=
 =?utf-8?B?blRkOUlOeTV0aWZWbFMvUnVPRUpqbno3TWZtdGxoZTZMaHlGcE40OXRCSlR6?=
 =?utf-8?B?V0s1WXA4L21PdVR6dVhYd1gxRHZ3c1hwbTRkOGJXNml5UnlSeVRqcThUaHAx?=
 =?utf-8?B?Z3pyNlZmNGVQSTEycHR0cVl6eklYcW5HOVpWYkRPTVJULzRNSk95OHpnQlUy?=
 =?utf-8?B?Z016M3FENHVLSTBhQ1pFN0xqL1ltTUxiMXdRK0xzc05FdUVmdmcwVnpjR2tL?=
 =?utf-8?B?TkUwZGJON3dlK3hBNHJ4N0FjNm52cFEyTEprYU1VQjltQnVJaVlDUWFIeWps?=
 =?utf-8?B?VEZnQ1lTUncxNWd3MnE1VEg1RnJDUW43ei9RVWdlbUs5Q2R6ajQ0aUdlZW9z?=
 =?utf-8?B?ZE9GOWtYcitHQk9LUEZkUG5oVXhtcE5mUmo1bkNkMTBvNVJSb29zOEtwcFNT?=
 =?utf-8?B?YUhPRHlNa2VpMmlQWEwzS1lnamFhd1o0Mithb0hZTjh1TnRSQndMdCtPc0tn?=
 =?utf-8?B?cmt4NXpEMG91RG9NakRGQmdwWFpRb1VhMElyVUs2SXF6bG52Qy9rWVlVQlFG?=
 =?utf-8?B?M2FabXU2RWZYS3N0NGQ4RnN2bHJyRXNQOHh2TSt3OHpIdzMxVWZZeHZxM3BF?=
 =?utf-8?B?WEZPNGdBZ2hLRkd4T0t0MmNvQnhTbXFDbCtSRU9FdU9HemJYS0lmbjMxRSt4?=
 =?utf-8?B?MDcvVUI1NXUvcUYveHRiOUdOSGpzcWFjK0RZb09mQ0ZjV2hQTmthcVBpTjgy?=
 =?utf-8?B?WjZ6YXg1b1ROTUQwY3JrbEJYNmZnSnkzR0h6R1dLcjByb2o5cURSNzR2amxW?=
 =?utf-8?B?T2RJUldiSzVTc2kzZmRlSktTRkQ1ZlRpMlJheVNhQjN6aW4xSGkydVI2VGor?=
 =?utf-8?B?RnFvN0pRZnZRUWVDUmZCKzhWVi9hYXZMMlB1NUEyT3dMV0c0aGEwYzR6clRZ?=
 =?utf-8?B?amVIMjlDOURWSWpWWTkvKzNmNGdnNkR2RENqZ0d1enUwMUU4M2hmTk1MU3Bp?=
 =?utf-8?B?UFBQTFA0cGlJcjd6cmN1TjU3SCtTYjJ5NUFSelVvd0RsOGo3cmVrbkFKU01p?=
 =?utf-8?B?TExEQVdtZVhTbC9yTzFnbU1YOEJhWmtQRFpiYngwNVdObHZKYnl5eVZhaXp2?=
 =?utf-8?B?Qm1wdVJrSU8vK0VzMG0zeDhBWWJUajFMaUpENEo1N24zdm84eExFR2Y4QmFY?=
 =?utf-8?B?L0VEYVRQVmxzZG5heXhrNVNCbTY1TlhuUnpKaGhGTzlSQ09rd1BXTUpNZ1lO?=
 =?utf-8?B?eTJnU1J5Zkx2S0Z1NmtFSjc5WlpzZ3MyblQ4bkE4ZDZYbkdrbG1CUHhwbTJV?=
 =?utf-8?B?QklvMkRiRHRSdEtwUklUS2lEUFkrTFFxNzVEL2NBcEVVSEs5Z2hDNFpjR0RV?=
 =?utf-8?B?MDA0MWh5czRCYUxYRlJJSEZLazhiZnV1RFFiNE5oTUNOdmduZjVFUmNCdHlI?=
 =?utf-8?B?Q3lMTHZNM1BwaUJIVm84YzZRNEtjQXFJbW5icDVldWJmOUp0a2V5ZllLaXYz?=
 =?utf-8?B?NnN6Y1dhZnBxZkViSENkTjJMbWlXbG9tUW0wNCtGZ2RpSXN6S0ROVGJ0dGpL?=
 =?utf-8?B?UTA1b0FUS2NzVk1nS2RVdEJZTWl3TWNkMldKT3JGcFdHa2RVQkJtRXpxZE5T?=
 =?utf-8?B?TFRoRWZXaS9ZVVZZQllsZlhBSGY5YytOaWZBMGR0dTM0QUNGQlZDUE00V2tD?=
 =?utf-8?Q?QEoAUG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:38.4944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4b8b26-3f42-4d9a-7690-08dd987c4ca8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
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
This enables the legacy enforce isolation behavior
to serialize access to GC for kernel queues so that
only one process uses the queue at a time.  When
we reset the queue, only that process is effected
which improves the user experience when a queue is
reset.  This mirrors how windows handles per queue
resets.  Tested on GC 10 and 11 chips with a game
running and then running hang tests.  The game pauses
when the hang happens, then continues after the
queue reset.

I tried this same approach and GC8 and 9, but it
was not as reliable as soft recovery.  I also compared
this to Christian's reset patches, but I was not
able to make them work as reliably as this series.

Alex Deucher (9):
  Revert "drm/amd/amdgpu: add pipe1 hardware support"
  drm/amdgpu: adjust ring reset behavior
  drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
  drm/amdgpu/gfx11: enable legacy enforce isolation
  drm/amdgpu/gfx11: adjust ring reset sequences
  drm/amdgpu/gfx12: enable legacy enforce isolation
  drm/amdgpu/gfx12: adjust ring reset sequences
  drm/amdgpu/gfx10: enable legacy enforce isolation
  drm/amdgpu/gfx10: adjust ring reset sequences

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 31 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 29 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 29 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/nvd.h        |  1 +
 6 files changed, 96 insertions(+), 22 deletions(-)

-- 
2.49.0

