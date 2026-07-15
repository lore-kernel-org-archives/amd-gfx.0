Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC096C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 14:28:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472EE10F0E5;
	Wed, 15 Jul 2026 14:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="syNYnP/W";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDAD10F0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 14:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKRZDYSEm5B8amVSrjkBq/PK3Y0RhYhwA5y6z3XfFuHCz0nQXEKE3fE6cBVxmFWReftw7csAOlsSzZ/+IBrER6AEa1zrr/5krle5pLQKDfyKBLYafLXL3FuivKZrvM1RXS56qoRnVTfjqT+c1+n2GiBAQuYY5Fu5DM8Yhrwx7fuagwMd2FCtVJZICmcU0vZQB3g8gaRCXueofYZ2MQIU41HmEWd2iTD0x++EhuVnYB1oKs5aOwOBhflxSxvmLiRL40KFCTOisjLt39HwQ99rtJZBe8Ac8iR185I/Yd5KVj2lySbdG0gk7oSgv0r1L4fvZrcrbfU8bmm8iWd37U+4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vg7NSiC0GDi3sChNKMfROzclJyaQgRoCusPCgB7myA=;
 b=ZEYpwSl3HXdRXuRvRFGGUkOnXLqiNjdXTt6eomnAKMe7dxPYuqS4CLtmGr5QQUTEN9gTHSMDEypkAv7bNGxUWxYleYL4Wy/jaLcdEEBCjLZkfc7syhXNqUxagUcylcsXmL6PdVs0NHxQi9ng9IojgpLp/i1YKyOOjzsD8W0aHYy+rV+DIflICerT1S2RnMF44332Jp6ngd9s0ecBrm+k3cMHMobMcmV88FEX6F/qH1GrFAj6fA7u+l0ZWosgTZqLICc0cYNgjfykVzLLuz/sQ4QgOSodu6H7BAcY2sdviL5m8NS0DEp7w4DZ+gy65u8QS2VB8/afyB7h9QqCK8DpWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vg7NSiC0GDi3sChNKMfROzclJyaQgRoCusPCgB7myA=;
 b=syNYnP/WTcanNu2FPTSi0F/LMnVRD8zJVZlYDMvl1cM864yOL+QyyCN9a05S7PXQ3WkXN4DqdHOxffRNDezOFZSuINlNhNX9jjqXkGaZR6fBOSlZec4yQizbcoDzR8+oEmeIDYCBI0fMipQRbuHyJUDx2FJkc10I0L5sx6TMkqI=
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 14:28:41 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::7b) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 14:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 14:28:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 09:28:37 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 0/4] drm/amdgpu: Wire GPU events into EVENTFD notifications
Date: Wed, 15 Jul 2026 19:58:20 +0530
Message-ID: <20260715142824.3475418-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d6837c-93aa-43d2-1672-08dee27d5d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5dEoXTWnVxuhWwFGtzY9DhAIWmij5jfzs9sx7TUGBpSq0B5Yhtz2/D6iERuDNGW3MmvuLQ+eUxJg56ZRvAq/xtucaD79Pla4lzkp6aVE3VBl6F9CcX6eUsdWzfo3UwcPCIVu+Fu4+NTL7KI9az6kR4Nwaz8cOgHXWgtPyMofK4ZfsD9pz2zYItxOmzgwbyZsbdU4DkrJ1bhvtqCX/QUEu2pMEmNu37Dl46FT4C/HMEvzyynomlJRknIpJDT8NK2yzFA7rufI74kko/XWI2fxMnk5F1dnWx8wRjZSU4m7OvjRA/yHrFtWnYPhWnBNpYIavL4X/h5tXxRIZFYPd/Q97rYJK/AClXPFRa9KAd/ZHzSNQm7zu3IRCN/J54CPafB2I51yg769TeI4n2lnnINztB0a+q5Iuf7EjDD5UEgy71JI0PIw9VCLy1XGZ1XUrh9Mt3qwAv3awPrOarPztxj5leR1fWZiDIDUQ0kh9+uB5/GzoAL0dYajAdaJboJ3QJSvzucnGyIlfn/F+ZVXYG6Hu03nO67tZF6Ac+T+Hb39v30owwnFzSvl6IN9cOHEPcW+koPVLNpKPruDdJE5kGeVWw8vHKuY9+uw+0IyoqLJRVH4y38L1KucCb50u7jE8dEitT/dVBh0VbkyJ4/W6hQuFe7Up/ZONjLO268VPTSgVbhdSGhYgLGEe4Pr47sR7H3+COG5zfAvu9jQXM+TVxAoPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KXK7zT3gBQjRHM/u71/mBeqs/2WpcSIpX22MSZE61OmbN8yARn+ujP161S0vwSlx+wzNmMVPQjcZO+uOY8FCJmX86KjKl89CLlm+lytMpCSKnES3rPn22bOCwbfroDiuII+FKQ4PqAHzWFiGBb7bRzPt5oRB/HIodWKNfBwRVm/ja458Z/oyDU2CaVkiznpZKtAU/JflfVb53VK81lzjRz+MHNIRFmjVf3cJaURdJndZHO7bLottbaxhp69s6BavB3nhDFVwp59hSPzylxgKCHPVwLDKlgbgfRh2+lSAxiAyU1ogQI/2E48D7CgtDM+E2O2RWKgrCO8XywkUI74dCyG7Qiieb0hB3k12bGOQI82rgsXT7BjCCo91olPN+f8nvbvTjfNSDZCwxJTl3pruhnpdDEui0i9yVpA0YFIKGm0IgnC7un6wsjUFJB0dLP5S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:28:39.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d6837c-93aa-43d2-1672-08dee27d5d4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

This series wires GPU events into the render-node EVENTFD
notification infrastructure.

It builds on the render-node EVENTFD infrastructure by adding
notification producers for USERQ_EOP, QUEUE_RESET, and GPU_RESET
events.

QUEUE_RESET notifications are generated from the common
queue-specific reset helper, while device-level reset accounting
and DRM wedged-event notification remain in the top-level
recovery paths.

Patches
=======

  1. drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  2. drm/amdgpu/userq: properly account for resets with user queues
  3. drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  4. drm/amdgpu: Signal GPU_RESET EVENTFD notifications

Changes since v4
================

- Rebased on the latest user queue reset handling changes.
- Reworked the QUEUE_RESET producer to reuse the common
  queue-specific reset helper.
- Kept device-level reset accounting and DRM wedged-event
  notification in the top-level recovery paths.

Only compilation tested.

Alex Deucher (1):
  drm/amdgpu: properly account for resets with user queues

Srinivasan Shanmugam (3):
  drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
  drm/amdgpu: Signal QUEUE_RESET EVENTFD notifications
  drm/amdgpu: Signal GPU_RESET EVENTFD notifications

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 51 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 61 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 77 +++++++++++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 17 +++-
 5 files changed, 173 insertions(+), 34 deletions(-)

-- 
2.34.1

