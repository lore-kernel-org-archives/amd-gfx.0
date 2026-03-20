Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FE1099B37
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 20:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC53310EC1B;
	Fri, 20 Mar 2026 20:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wcrkoO2p";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCD510EBEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 20:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/PkC3S0WCEtPGJxO9ukdUE95voFWV1TIfkYxYEFGL0dkL4y3oAURFdyg3/Fk8naXLDz2K9o/LlJ7l2IU+j4IbWeHJ4ecZFXpJ3lCt3Wrmo/8HRUfm5mqGKUXcbqHLZRunCZJdaZQ/lKwqVYEOXsQq0Rf+PIlNcE8qKtxcMP+sikxg5eCoK09g5vdj0EYABOn8LVz+JTR6JyJKhHk+hLe7X+zrfIR88fjFaz+gaKf6bU09ivWfOJTHnOxFQ+mK2RYt9UnPA1Khnm8K0eY0xoYe5/BwjU+BkJ9HU35Oout5Q/vTuBUPgAcCvJPM4N15IxBKLpa4Bx3idMwJzfdjfwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYXskmD7BC4ic6+HOfTtHax+AuGibYBq4JZBRHGpD+I=;
 b=Tz/7mMAMeNKtKDR9VgIg+nf6/mkDgizYZZbru40lLLXGqzoG27WqXkZIzqfh/08n7KZQ3taM21qHqbWP6IVW4Rm1U5rVL7ScanwEOQQxRiF1eblMUD9uwl8wwmMx8XQXBhiSblQi/3btc8ie8MxIrQ45au5Px5drja4Vjb+hRUmdk0iTExWIlrTIq4IqK3oE3/vCRugfePtPuWz710owOzfxcQXVRQnQiCUS/NuiWLUPLHFWIuyuiTtD/GUdtJwiIalLnXnCz7/bO2FhjYY3J+w/8i8AXWKvuEp+kPtpiBa89phDHH8NdJ2NFhd92E4QP0Xdkm5S45pg+3yYAttLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYXskmD7BC4ic6+HOfTtHax+AuGibYBq4JZBRHGpD+I=;
 b=wcrkoO2pownLI7CKas5Rc6Sglsi8ZAGZqnM0UkBKpePPhyslnzSjGrjC3EXfULycebMoIPTZcZBxBRuMYckb1Q5/KvYFQqJNo+3SFW6lh/nTFkmrElwuyzdTu3t5ikSNG3g1GPfxIm2uJl/nI80GOBcUOJ5YrEBxtmOSyMpPL7g=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.13; Fri, 20 Mar 2026 20:02:36 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::3b) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 20:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 20:02:35 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 15:02:35 -0500
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <Michael.Chen@amd.com>, <Jesse.Zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH 0/8] Support compute queue/pipe reset on gfx 12.1
Date: Fri, 20 Mar 2026 16:02:00 -0400
Message-ID: <20260320200208.1188307-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdaa4e5-ebc3-42b9-64b1-08de86bba155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: A67st/l8kNNb5vKhwcbV79z9KLtPv5GIr8IVsWzi8Abnbr374eQtg7Uh56TRKmYCjczbhSkKbMC2sWX5ls+7GFS05xMWRcLGEgz0mNiXL7MdgRB3xj8CFAa9gY6S29tU6exiNy11OhJAzb0Hn9L7517xDwK4jmv/NAmM6aUN2TwDoy59zfCJ/30rPYmKkWJE3FkJRefuHHfm58VtTkPY7lFLhOJwZSLccY+s9R+tOr44N7MEJwqEy+q105RpKTv7n1x3cAUUCTL3ytnJaXbnIZ44udFjTSPyNwxiDwuZ6brhJRo+mKnGr/0v7Gzj0QlzQUGcNGqfg+1g7aWN2gr1pSVgSLwGwoSCA0ByWW9+lqGZa/3CndqwaYXZUcipc/JMCV8Ng53n7ImRKfiPx0Nzaad4BrJ5AtefL5O/m9mETgkIrt7JkHZ6dbkMcsvWOvwK18mUCneCx8JJzYNShNJPtHXLxRomhxAf+FlFYj0o5xJVELRaGBDv8e1IseuHVx5n9G6WA49nkEhe9Swf8yvRa2DmtNyIWQVeGoKfudwbO0X1gyOAai08v5Bl6oz38/TODUZz2PDBpsRSb2ZN8yjVImy0Q4hJDpXEDgtUZt5qJhsC0JOTU+YcMYQetcZC/k+ZkaNkSITQeYKX/gkokN6iC27Xm4tNn+TZoE61/O9UYRoSuqiG+XFkS169wUPol25Z/WlC3/u3HejCk1GYNy18+kOpLRj5rmQsytCmJIW3rN4ugAoCQaeUGbL5kBcPWhIuIWqIWOdODNG7FDCyBJxxwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wGNG5kpA84IGSf0+HuldpOJiilIenfS7kv3HmbSYXsEk2PRpdk+hfyaHoL7yIy5Kfii++aNzUcjWmmV31sDt3//aBuro/CJieq8f9Q08mqFPX28p+1B690Qekv6HF7QnqawYreIVjaY9RP41WckgBfaN+2oB6yf7W1dyD93FG8UtlkPsWPIXJxj7q0wSj7Y8e7YVY9MJgIbkiBJyPcrACc36JWIUjatqirRaXuEQIKKZCzHugqRO+MCy2UooR+I5S++LJaqdoPsQK5mXtgQ/c9+GZHA/IDhVfjRz2Io6BTeFsPywmHOImU4kUH5+e+/Szq+hVUc2YoL2vB+1yjh6almFvFcZF6uTEE+K/L76/ur1/vBQrbS4IgI0j35lm/Fvsu/XX+9CkUk3S0ep3FTmTL/gkPpz22DF2o0lryAv0l1fgU4PqtJ9jkNyl7x/o5Ff
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:02:35.6364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdaa4e5-ebc3-42b9-64b1-08de86bba155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

Instead of MES does the detection and driver does the reset, this series
implements compute queue/pipe reset with detection and reset both done
in MES.

When REMOVE_QUEUE fails, driver takes it as at least one queue hanged.
Driver sends SUSPEND to suspend all queues, then RESET to reset hung
queues. MES will unmap hung queues and store hung queues information
in doorbell array and hqd_info for driver. Driver finds valid doorbell
offset in doorbell array and looks up hqd_info for each hung queue's
information. Next, driver cleans up hung queues and sends RESUME to resume
healthy queues. 

Amber Lin (8):
  drm/amdgpu: Fix gfx_hqd_mask in mes 12.1
  drm/amdgpu: Fixup boost mes detect hang array size
  drm/amdgpu: Fixup detect and reset
  drm/amdgpu: Create hqd info structure
  drm/amdgpu: Missing multi-XCC support in MES
  drm/amdgpu: Enable suspend/resume gang in mes 12.1
  drm/amdkfd: Add detect+reset hangs to GC 12.1
  drm/amdkfd: Reset queue/pipe in MES

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  89 ++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  23 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  98 ++++++++----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 151 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
 8 files changed, 306 insertions(+), 61 deletions(-)

-- 
2.43.0

