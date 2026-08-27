Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0760C61DC2
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 13:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C1910F029;
	Thu, 27 Aug 2026 13:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LufP1Ymv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18EC10F029
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 13:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gluqB2HgLiU08JWldDI4dsmgGmwpf4WR+Xt8+2SgS+SdHu1jDuqbxYocJJRENBcEj1LlLQCB/UQzI82zP9hs1WXHwBPlQJBp60umH3oJIAQCFlhcVgGNTbyYiiWLvKLRxquHnfM3aa4n22Yb514OGEZv1GzNwXoCuHeS8FhLb+6P3mkNi6yucOCvHkvu0eGPUBnaNrrxU8XiZB6vAXQN8NKWWLErxi9m5MMdACMxOuX7lpUMW7LaOLjNIKUoGW9RCt0QwCT8sXb00v+aRgTNeic2FGMTYph0CzRzjDRfZNHKULGCHH5D8HZYKUGL2VDHM9HSt6ozpfX2R6fPfO3Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wydQLMikPsWVSsh9S21IkxhbrMaBRdN79rte+lson7U=;
 b=E3xzxYExEHHBHk1N/kIdupz34NF5UWf4n3wg8830ZhGFE5wNJjgfk50dGERuez0HW2M0cnWw9Xcdac8eiKvhh1eXYgbqryvx3uWOcYjHrG+xR5L7Fl1+v1va+pKAgMwAhC1v4D/fPnDNj45A/IaqjCK9Xvux28ajGa4Lh0+K5Tn6I+VoQ2zX8v8qs4C2PznDWpCZp1oUBIKGxIHbVqdaVIshl+GHQE8ktRPA7JqtCCphfqZ1KAPNY0tkmOgFJ5KVTPAUvWn0uhxri5CpzmKgHYKzNehYmwwO+ynslFq8JtyS/y+IqtdjMaAO7Mu+UXOQAEoGjs0G84Xn/oP8qbE+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wydQLMikPsWVSsh9S21IkxhbrMaBRdN79rte+lson7U=;
 b=LufP1YmvxqdqjC2XKQezTKppyqulLMbCIiW4gXXAYLvF8moKxSIhKbGx1HcgQs2Kc8Dn4yrgpoGgmvsk/0K9H5fbEt9PrKIXSRlKip13RFFO8/hoSIiBrkMNSrw5oaXsNJ8jyPlLI2CWkPv/zZZDgArh/0emDQpqCHK9GZ7N5ws=
Received: from PH7P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::23)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:32:48 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::71) by PH7P223CA0016.outlook.office365.com
 (2603:10b6:510:338::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 13:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 13:32:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 27 Aug 2026 08:32:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/2] drm: Add Common drm_user_fence helper and Convert XE
Date: Thu, 27 Aug 2026 19:02:24 +0530
Message-ID: <20260827133226.4076593-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7d47c2-8a5e-4adf-4935-08df043faf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: QS7zNWAN4DjYDFlhxAg7s8y3+b61uJxPPj6G0ydhdprsjoQPAKVl/6//DiG47hIYSLr5X6OT/l3mWFeE8fuLyIpLVn5YHeFK9ZNTlE0x1CRqkamOnNRT5LYudqo43LqpQQqkge4bUwHm3bEZ/3gASIT9BqOrsnX1RkNyXUhU+mi1D3PsUlTmfTzGd/QQeuh8iN6EkqWo5v+DjPNlUs+DobCLflu6IsK2R/wUJzd2bwdhfy/OAoIwq1CSWfuh+uB27vkJLCU6QfaGslUl0yX+rVzFJ/6R1Kve6XpXbzk372xFD0RDOW8bMPSHFPX+Op+QrRDKQS+A3o8FdjqLrYGNXZSqb6yKlt469khcGbGeN8mgG4+uhFZJed5fY1Z3UjJizt3IditUcIcieW8xlLheO7HqX+sVKjxFsriGpqz/DFS1YnI3wT29D+aRwrI/sj3rB663LwlZ63lgouRiEa/TN3NKGQ6zfFGtKtiqYAyofEJwtAna999wTmsOWj17hYRVo3rwjavpIzp8i0QVC16cdhU2Mb2iarjmjIZduCS8uszK1SRAeSaGLTBSwVHBg9oVZ0/pzdr2aVapb46vYgVWOE+m7g+o8hz6XgYM4sH3LQRUmGYZJr8+Ctmj+qHO2lPI6zG+ySisJl5FvWoCXv1mY3UyZAgMs+WaQhcSZP0j+SiI4jMh6EzWctUVAgaDDkl1yddytcQB5S2zNGjn3swSQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XpVZQnn+slIWN/CG0Y/D2TBiKe/HVH+sol7fqbITXFYqMlKzHwoJ57LZwyaQYOr48lOSXhmRe1UEQuSslr5zfKEUMOzawXaJ5EbppJIxGmD+xjSrmUqTsFOJYfxzvS+JiaQmmyk946K4Q87/7z0s687x5TL/7SkYRylJWSgUV/dQNLv/EPAdtRNFDdRm2O1yFMSLT67qCsIv3y+rRyTLlpp6G19zTDSSBGjRaZ8fzV9Zd3o8JPWy9nW21OesQ69dmXg5uqMk59oBpuHfeYTdEBXwr4gQMYKxQJFICv4sz8WyUcj4EAAfii98i//NJirbNK7vA9q1NWTusNKiQd5TnX+156BUn/LlDk7L3i/PcudjIgT8CNgA+qXdBwakrGVwUpAi7ggCeo8Z2egc3MgBZ7oaRgjxVdx9qcVE/1ZGOOfnK0pi+V7BtQwXJquDbdZ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:32:47.9609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d47c2-8a5e-4adf-4935-08df043faf5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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

When a GPU dma-fence signals, drivers often need to access userspace
memory from a kthread context — either to write a fence completion
value to a userspace VA (XE) or to signal a per-queue eventfd (AMDGPU).
Both require borrowing the process MM via kthread_use_mm(), and both
use the same kref-managed dma-fence-callback-to-workqueue pattern.

Extracting this pattern into a shared DRM helper allows both XE and
AMDGPU to use it instead of maintaining independent open-coded
implementations.

This series does exactly that:

Patch 1 introduces drm_user_fence — an embeddable base structure with
driver-supplied worker/destroy callbacks. The common code handles:
 - process MM grab at init (mmgrab)
 - dma-fence callback registration
 - workqueue dispatch on fence signal
 - mmget_not_zero/kthread_use_mm/mmput in the worker
 - kref lifetime management
 - cancellation via drm_user_fence_cancel() for safe driver teardown

Patch 2 converts XE to use the new helper. struct xe_user_fence embeds
struct drm_user_fence as its base. XE-specific fields (xe_device pointer
for ufence_wq wake-up, userspace VA, expected value, signalled flag)
remain in the wrapper. No behavioral change is intended.

A follow-on patch (not in this series) will wire AMDGPU's render-node
EOP eventfd signaling path to the same helper.

v2:
 - Move INIT_WORK() to drm_user_fence_init() so the work_struct is
   initialized once at object creation, fixing lockdep class divergence
   caused by two different INIT_WORK() call sites. (Sashiko review)
 - drm_user_fence_add_callback() now consumes the fence reference in
   all paths: transferred to the callback on success, put immediately
   on the already-signaled and error paths. Callers must not put the
   fence after this call. (Sashiko review)
 - Add drm_user_fence_cancel() to allow drivers to safely detach a
   pending callback before context teardown, preventing use-after-free
   when a foreign dma-fence signals after driver unload. (Sashiko review)
 - Fix missing newline at end of new files.

Srinivasan Shanmugam (2):
  drm: Add common drm_user_fence helper
  drm/xe: Convert xe_user_fence to drm_user_fence

 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/drm_user_fence.c   | 164 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_sync.c       | 112 ++++++++------------
 drivers/gpu/drm/xe/xe_sync_types.h |   1 -
 include/drm/drm_user_fence.h       |  71 +++++++++++++
 5 files changed, 280 insertions(+), 69 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_user_fence.c
 create mode 100644 include/drm/drm_user_fence.h

-- 
2.34.1

