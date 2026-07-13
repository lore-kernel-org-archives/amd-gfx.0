Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A7C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 16:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB73710E61E;
	Mon, 13 Jul 2026 16:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RdkKpr69";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699F610E61E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 16:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYn59PlsdezBZ9DhZiWKAOJlDPKy2aIcSrSiEGTWd1v45+rNpJEBZqo0IU4Go5hAEPUMoc1Wx/skDnrDyleU+JUeWx1KAyhSK9Ich1hGv6qJBFXRPk9InIBQcMmGBMuJPfFVWQ5qs8xivsZXbKSD9cJ7f/ae11niwfCxVLFmSFBQEidmuDr5k/AX5l5PI0rsw72GhDwmg1n8VdNZEo4JtS8n3WBxY2IbqxoHemvIuMha/Q1SrXX4ZWCuXqoov1BPvsID8bfPtD7XRmTSbjXX6YPP4JPZYaoPMAGwYnPhU0FgyYS0R4/8kuNGi1ya9OJte1BzlblIb6rkuDREwEvEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YFurjwwL0+K6R+Tu+dC77e9JflaTPWa3dl9bWn2jF4=;
 b=HnwmQiWbF2gulAD+pZ3p2fJGDoUF6QEOrbUlYw+vBMeyPK3UHqUgD613s0WDLmr0W0A9t3MG8naTXq4WUGkG88wJSxd/Qiv2gfOnGKDMMh0twdDLVsoK2mX+gWiSV8TIZVLZnZo2fq2Oi6FK7oeE8Gt4LPZLf+QyCZlTJV8oq984MFTjWIaBUS5/cgWU4NzGm+L0alRcqNEdH0pzGlNKUsnzXkahA520rRwCj7EJkFVATDBygsLF1/rOdhxOOC8LvSfSiD9/RHPh9A5HgE/JmI8yc+bN2s9nCqy4Py3GykUs/cpTlZqYN7uzov1ePDNepbLg2tWv3fXEz4GEjgK1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YFurjwwL0+K6R+Tu+dC77e9JflaTPWa3dl9bWn2jF4=;
 b=RdkKpr69z/psrAz2rIYYyxy6WoKGFnYDRj3Yf+DPUYwqVpqffLj6ZNvfIjV6sSE1zEOP+VLerNW9mmtBVVasJNm1Zig5Vgxo63u1xtV/+HcatBW4YZGlnhaSHRwl0KlgXZBBaIIkYg5e2XR5Ll+TyU21GFh9dFx0PXwhuZOdfNk=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Mon, 13 Jul
 2026 16:27:46 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::22) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Mon, 13
 Jul 2026 16:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 16:27:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 13 Jul 2026 11:27:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/3] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Mon, 13 Jul 2026 21:57:19 +0530
Message-ID: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: 51419272-734d-406d-87cc-08dee0fbac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|13003099007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3VlmROglJTUmEiZC31xUvJIXIZtyMmMNya7M7Kwd8/b3aBqabbQPponZlzmzWVfAohB6uQzdD5XYOUd26aFtuaaeUlm7yvxkG07KLqj86sTerFFRUDzClbofY3hKQL0be9YBXHEPkVxLYT5tcZfiHfC9Ocru37HcAepWDDu+/zf1KFMeDrS3pNdpCb92TTCeEX6+y69+Dq1ywOhZH7um/T4M3I+54XlQeOu2FWSl7HKqXymldF+xwKEZXzoAffWb8eGSu4ydU/B9/ScP/yGfDiutAwr9IcgbdkWBIIYscfSwAT2kKZk8B6YdaqOom8XGdfwybDHqevHwxpaiqpuN45O3eOF0XLgqSjA+ns2TVo4ddEazfx0iFGbx/zht6xaf4wT4pIIbpREWxr5rDFirFBzrc5TTcsdCNrH4GdhwdoSKFnQtDZZtcvDNmnGmm1MeRPwiMad6/m3DBaZ2CEnpudkejtfwoPa1tN4AcVKEtceyrgfqSIuXg0LGekSA5ZvfHJHmvbL52QPjlttGI/SVOyzm+ldlhqIGmF9BAdCJZKEkL3Dzo1CvVBPIewI1FMVh/fSqzuKg/zCe+lC89FSraWN7i2NEJ5AmHTRDbASXAsWuaGDu3Zzkv+9VBUzQ0zs7rnitD95P9ncEY4YWFVD+dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(13003099007)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OjZtjIoD0C3LGoIHQAT9vW5gOR9fchjPqoLEJkudXcM4mla2T9pnkzDxSB7XpYTvGPYEx+GDZBRoPGGSeMfU64E9bxolY0jihJzyP9Uwa92vEKCo4WddwYS7t6GjNS7fIqszj0oPirSHVYnJm3WDWVJ/94qugc82AsDPTajoixJWxnUflJAmeHvs3xySrw52d8JtK95tELNSMpOu9sY0g7KnwNqoZutXgzuY1HC6P7rInbFw40aBwGkzQ4f/Bht3at14+sQpwtzmRl/8svW56OWEaWRWTUHxC1YBznuE682VUGQR9axztMF5LI1KBjU4CiOZ8JUbyW1yY9GWKeqjxiyoKQ0ExiN4q3Nr/wJmo2zYq0Ae8/HuZ4BmV84kdZtgEWTjdBpatrumSrPi8nL2FU7arLDtiDh6X5BcTP/mhihYdFzAFuXCeHO8KkMM2fiT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 16:27:46.1613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51419272-734d-406d-87cc-08dee0fbac27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564
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

This series wires USERQ_EOP, QUEUE_RESET, and GPU_RESET events into the
render-node EVENTFD notification infrastructure.

It builds on the render-node EVENTFD infrastructure introduced in:

  https://patchwork.freedesktop.org/series/164618/#rev7

That series provides the EVENTFD manager, subscription lifetime
management, event type definitions, and queue-aware subscription
support. This series adds only the EVENTFD notification producers for
GPU events.

Base branch:
  origin/amd-unified-interface

Base commit:
  540d68973c0b ("drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all")

EVENTFD provides lightweight notification-only wakeups. Event payload
and metadata are retrieved separately through the corresponding event
interface.

The three patches in this series add:

  - USERQ_EOP notifications from the user queue fence interrupt path.
  - QUEUE_RESET notifications after successfully resetting a hung queue.
  - GPU_RESET notifications after successful hardware reset completion.

Changes since v2:

* Rebased onto the latest EVENTFD infrastructure.

* Reworked QUEUE_RESET handling to use the queue object already resolved
  by the MES queue reset path.

* Introduced amdgpu_userq_handle_hung_queue() to consolidate queue state
  updates, EVENTFD signaling, fence completion, and the DRM wedged event
  into a single helper.

* Keep the queue alive across reset and unmap processing by taking a
  queue reference while it is being handled.

* Preserve the existing guilty queue handling and queue type validation
  in the MES reset path.

The USERQ_EOP and GPU_RESET notification paths are unchanged from v2
apart from rebasing.

Only compilation tested.

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 39 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 73 ++++++++++++++--------
 4 files changed, 138 insertions(+), 28 deletions(-)

-- 
2.34.1

