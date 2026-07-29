Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3B2C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 16:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D79D10E050;
	Wed, 29 Jul 2026 16:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eVlwRgDv";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74EE510E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 16:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuiTm1aViLNEnfAvfRWSMQYsG0OEes6y5RvsVKpXDykB9o0KHBVQREDsHKHMKoVxq2MNkpGomHIlPYG+ipZb9/TfcwTnXFJCJZdYkNu6S1tFjSZstx4wWE49xVPIkI1PDLgOk/yp1iKNieGwTVKKJLRze0jlYPD4AZilhwH8l02Xhl+iQpyfIvIjOgP+JpBt2iT6/OATF9W/80/6VQZkkzMOxDL4L2ZD3Qey7MCvbryC+R3mW0YdokL2pxjikDxbFfl/Rd/9OhjwI4ivttITq1xSkryAAKwSPd93rgL8WOpJKbjibuiJ1oWz4xiJMgSnWbwDiZIJbMj5CnMuhVr7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNa8d5SBp6Vd4V1QxxHnZOyAoK6u5WSFT4Md9sTVpqM=;
 b=LfUuuNVkAGFPBvTL/nFUZnrHFHl57fa+CpVN29+6xS1Uo/R7Fxn4HzdF+/0fCKeDVzqWxvBilaRieBCaWeaFQLJE44ypNNkUc+Lrfj0PKq+E1A4O4yO5Vha7JKPu0c4zSHG5c/kEoW3QpcWXs43i6Tg8ojvpOmI3gwzCLD3mLeqI+TVE1hjJDvX9gUxqJ908PiDfCeHt4LHkWJhNpY3IVpfZh5DX5IJdEaTRSiS7bMCLv/PbG6wAZ79c9XkAJ1Kw1XG6EA0cb2GkZtRohnfTxnGC8B43TDoA0LfMFmaFkOyFK6x5fDcZWlQQ8mprhogB0X4+r6Thy/DHAE+W9nJptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNa8d5SBp6Vd4V1QxxHnZOyAoK6u5WSFT4Md9sTVpqM=;
 b=eVlwRgDvONUy9QK1RJZqxcbH4N7/vpXVBaalvGZNsdzcDVYVfuSUozlDKAbKFXfnLQg04Ewzc4KZM+jpbiyZK46/8R8fsUOORogT1dPKDqJaZCLeE42W7mSdjuMrbKb+VNWhhnvfbjuHmfh1XWlbK4p9RZtMws0YdPwszBSmhm0=
Received: from SJ2P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::9)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 16:36:00 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::8d) by SJ2P221CA0014.outlook.office365.com
 (2603:10b6:a03:5db::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 16:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 16:36:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 11:35:57 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Amir.Shetaia@amd.com>,
 <Kent.Russell@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 0/2] drm/amdkfd: Unmap SVM range from GPU set to no-access
Date: Wed, 29 Jul 2026 12:35:36 -0400
Message-ID: <20260729163538.229530-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|CH8PR12MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e85fc8-68fa-4b17-dc29-08deed8f7939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|56012099006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: OiqOlBLnHHCFF+zbgBoRHmnCh4GiowSsXrNBOEjA8kxGgJMVntWeK16ajCZCwpWHXhLzuuX0ho6u2piF2mIe/wckk5bAsmAx4qytnF0ZfABlTt5O9CgF/UppnikZed1z5gu/jZlKdV9X9MIedKcYhO8m7D0h7oCTf+s9Mv9mUy/h78JbYaAwXetW3F14Vg5mNrvwNyj7xqM25qwcvvUgsYau/kntjwtEEXBnFz2YXcSgmfwrrxZoPcBTsVQ/odjMcolon4p7ud0LSUd5gk18OhHoGgIyaT0MKhr3IV4+I7SJuCmkiD/aq3vBX5IkzrS+TgzMBkXH90IHHujd536Vudn03uz0/hKobhdFTy55pQSMJ98QID83DSNDdZGD2g5CIwjJcAgQU7OnvO8R8RDABoUFq/Zij253gpMvtHfELJh9NSQmtI/XCBhGaCV75S7glsiTybojB5mGngTs575OeCVHr9HCqY6WKIH9cBAfxv0bw4LoHtXxozWWYpjl8Brace5Z8wXbyeOsSqeouGIgWQsNA8CAptIbPBly6w59qoDnfcd1vOZGOprgQV/ca5xMQP9XgiE8wtSy+cOwzN460zAKh8yrgCT4H67itnOA5vcvtB4BVpYETFHWVhno1csI+nOSAl80LCI68q/0jkvXNI26AuXw3Elg5d4iHMLMVRoTSFar49u1Qu0VWlXAexmaz25hSVHU1gJW7ohHW7j6UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GZxJ+o3OQHji0dl73abNIwAs2Dxb+fbvmhEX9y9Vk001QKwogxFtdabV2B3oDdLyPu6ZugQ88JeakJZO8GQauDqFTnikln8TO9BLSerxV8k438yEhE6gBCLGcyB8LLc35e5VYPnBekh32i8MEAGAjXho+HgtUplRuEcl5md0TBdYK6Y1jebR65GwiZmoIBuJ1ygsyh9YW+wz7emm4kjXywym/5OcRdkZMTczgKPYk8s6Ho4QuqxlQK7UM5gPdSRiwqtXTk5QoLImz7zFIqUoyg2m/JiMnMZs4L42/grL4axBAFgDiAbcVenVo8nu8+JSROO8GVPNSKOYgtvrlOzlAeGz8bdEqX0R0FAmE+zFj4un080hGyPxAiFAyliGly5wrYUZe/6M5TwXWoiaiiWng314p3sB+QZ2VKlnmeKz0sopNazWSU0RWbHAGd95mxrZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 16:36:00.1791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e85fc8-68fa-4b17-dc29-08deed8f7939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743
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

Setting KFD_IOCTL_SVM_ATTR_NO_ACCESS on a GPU used to do nothing: the
range stayed mapped, so the MMU notifier kept evicting GPU queues on CPU
page faults even though the app wanted no access from that GPU.

Patch 1 adds a helper to update the fault checkpoint timestamp and makes
the timestamp atomic so the page fault handler can read it locklessly.

Patch 2 unmaps the range from each GPU set to no-access. Once no GPU maps
the range, the MMU notifier skips queue eviction. It bumps the checkpoint
timestamp so retry faults queued before the unmap are dropped.

v3:
 - Patch 1: fix checkpoint_ts atomic double-read race
 - Patch 2: move checkpoint timestamp update into svm_range_needs_unmap

Philip Yang (2):
  drm/amdkfd: Add helper svm_range_update_checkpoint_timestamp
  drm/amdkfd: Unmap svm range from GPU set to no-access

 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 191 +++++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
 4 files changed, 126 insertions(+), 79 deletions(-)

-- 
2.50.1

