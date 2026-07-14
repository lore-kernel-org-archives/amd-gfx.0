Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EF2C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912D710E53E;
	Tue, 14 Jul 2026 08:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QGR3eRts";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0408510E53E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZyHs2Wcf5huu+nc+DMCyBICLJekFAbrCN6hXWWmwHMaUem2DHnJi8mL2GU78fbHm7pABCujcRmlg0683+Ch/L0Yj2nJYsLcNM4yRIUSnetnoyMGFsfGR/hXaijh0B8oKNpQVcbZF1calKmNHhcTCXai1frmEOMZTMIdcq9BYdb2ESSaTN64SMIzGD5NZCXfFq4yEn/U9CAsVXh/scdWeTB3zviYvWdTCg/yibD9bKgy/nqBvX5c/ZEADH/OK0KJJbBDUGy3lYusFU4e2ZN8NkNMjegGQgtJlgqBQ9ZkzYyydTKbSugKL2e4whawX1pZ/j1yuDPR4ga3hDMqvplyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsXKuYVt+/mY4Se0ynn1P1ib/UIrgQcsu5OyF+JKs5w=;
 b=YKZepyQkxu/Qnwxa6kRO65iHBJ12efAPz8V9XcKb3KDqQdra7AJM+/gB2v6DsMntSQsa+KNGc6BCo+wj4wJj4/m5OCa51tkHSoyQp0GSJ+1lYA39qFI/AzxnWDF9fsBcS9WqyOCR2a6ciYl/TfI2pL8VvSaNe59xXYJmjz2SkXzqzcCa+XgcuOVJ4x2pvfNAIWa+WIBXcUQHL9sirtDrXscx3NEVqElsJ22RyIQ0B89hPBwEwWKBr4KbbO+nu8eacvxcQAkID/jsI2uQT6Ha9Fk5GTTRu/1/Ooswo0oJQcnJjPonCC2yFlwbryMhHRHfgO/yYxDrFOaRrSlt3sdrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsXKuYVt+/mY4Se0ynn1P1ib/UIrgQcsu5OyF+JKs5w=;
 b=QGR3eRtswfpHl9U3OOXJWHJo/9IMZ7bNesgPjKdMl1kJpbu2Z7l4yiv86vtv0nKBBD3rXZRYPHe72SE7PmvFcM+lRNmbObSFYdJCC7vLkEbqBSC+s2nqLN15UChKhFnaORW+XGvyRtpWL/c4haacaKye3DGgszPo2arzixFfO5o=
Received: from SJ0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:33b::23)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 08:02:35 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::58) by SJ0PR05CA0018.outlook.office365.com
 (2603:10b6:a03:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 08:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:02:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:02:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 0/4] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Tue, 14 Jul 2026 13:32:16 +0530
Message-ID: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c129463-c97e-4b3d-9f55-08dee17e4393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: sauGGxghqNTwRb8LTlqTXzMazmRN9wmV0FhbIMlsXVGMMNvw3/k1MomATM4sjuvW26S0YlfqsW/asfCW3nZaZlzlKql3ILgY39cpyCRREHR6JT0IZMvrmu0lqK43N2WRg4NMQWVk4aQictWXOC6Wv9cNM9GWC0k91+tloEiTpKN4xSYuFlRe8j3/KEKwvSB5ye2R2Sx7yi0NkwWXT6RLm2sqaKz/Ix60NDYQ63OPrbnuEnk1BZQoESQcGQFBK5DTaBAdWDS70u0nXYhpYxuUECCmq/kSHXnWGwWEm0UVsdomV5QjqbErMDv7kM72M0ps+PjlhIcBeTTZi1FqstZfVGjpo6sn7AV1ksJG8oS59D6bYaucITR+fvJ/Yzmjbo0eNYn+IMikNnal9QLfeXSdzOP7RchaLpWbjVOieOHrwglekyW6b2GzMMDzUwGkPI13P6sQShv9/qcpyGFFURE/km1t1p0Tafm3AN+n/ZqAd6RFrVrOiI7FLOSwL4qkqq3y5Jprdv8Xhi4ynncU//A51KQDhmwxvkSRfUZzhjsWM6gRqg0Ywo5Ih6zVsy3ygOktfU5l/AFYgNdnj05rostvjvUmhvoHDA+l58uoY5yoYsIoLwot78oBMv22PL/ufMIGzeEa41Gm4MKlpKFCrXHqCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(13003099007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4XxuIEx1hB8PbnrkF4E/n4iyoXg/eolG5Kae9AEIwL0fQpvvhe49lEuciYrAcXvFCRhY4C6y32aAo3Hdbxfd9VIGwjZjaBmFNS1c7bBNapbFhOEtwx/AXX9ntFo8LSQn9TL+M4hytiumEHVrWH9pqA3OtrJMzd44UXZPcvuiDHO24oA0o5QPYVL3+NmO5EAO/dyvR4rS7zban1lMfwI3veibc1G1gRd66JMW6zy431bfaTPWB8bD+0V3jk/ISijS/ZeI/1Qupvxxfk/JO3iVlGkQuNsI8xF5yQtBXvpEYlkNcCcmUjS2Qd13GZQwWzrcUCkDQ7woqj4YAU4aD4YYf/BArIJ9cg7xj205Y1IeF5aTTrKBWrgzVyW6wIR8mNT09up867TSKxWUkeUr1VoEs7UEFU2CtlJSO7/k1uOXl7dwJ6QpvaJXwHlbzU4tAy5h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:02:34.8033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c129463-c97e-4b3d-9f55-08dee17e4393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
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
support. This series adds the corresponding notification producers for
GPU events.

Base branch:
  origin/amd-unified-interface

Base commit:
  540d68973c0b
  ("drm/amdgpu/userq: fix NULL deref in amdgpu_userq_evict_all")

EVENTFD provides lightweight notification-only wakeups. Event payload
and metadata are retrieved separately through the corresponding event
interface.

The patches in this series:

  1. Signal USERQ_EOP notifications from the user queue fence interrupt
     path.

  2. Properly account for a successfully reset guilty queue by
     incrementing the reset counter, force-completing its fences, and
     reporting the DRM wedged event.

  3. Signal QUEUE_RESET notifications from the common successful queue
     reset handling path.

  4. Signal GPU_RESET notifications after successful hardware reset
     completion.

Changes since v3:

* Added Alex's patch:

    drm/amdgpu/userq: properly account for resets

  This handles reset accounting, fence completion, and the DRM wedged
  event for the original guilty queue after a successful queue reset.

* Reworked the QUEUE_RESET producer to introduce
  amdgpu_userq_handle_hung_queue() as the common successful queue reset
  handling helper.

* Use amdgpu_userq_handle_hung_queue() for both the original guilty
  queue and collateral queues reported by MES, ensuring both paths
  update queue state, signal QUEUE_RESET EVENTFD notifications,
  force-complete fences, and report the DRM wedged event consistently.

* Continue to resolve collateral queues directly through the doorbell
  xarray rather than scanning all user queues.

* Preserve separate reset-counter accounting in the guilty and
  collateral queue paths.

* Rebased onto the latest EVENTFD infrastructure.

The USERQ_EOP and GPU_RESET notification patches are unchanged from v3
apart from rebasing and retain Alex's Reviewed-by tags.

Only compilation tested.

Alex Deucher (1):
  drm/amdgpu/userq: properly account for resets

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 38 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++--------
 4 files changed, 134 insertions(+), 29 deletions(-)

-- 
2.34.1

