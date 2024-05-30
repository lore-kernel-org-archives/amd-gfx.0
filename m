Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A51C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECA610EA10;
	Thu, 30 May 2024 03:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sz/y+pBM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979B310EA10
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPU6+HzT28TPog/lC1m5iqPlAfFMZaF/OUTxH/wAl2zkFh4EsaG+qQQZwja+HL+IYM/bWRSP0yXqezpYlR18OJJpGH3eisXxPIqM1Q25HVt2zAwHN5OR6rbivGet9WK/9LgPIi2A5JfsFHfNRmU31B5wgFrOiTY3izswcN4yd5aRpW/b4Rdu+9mzmxsbceiVuj493VDojfBWaYuXL9WO2NKUcwzAkJoZby3lyKyMVabF7u52CDDXpUmxX/336gpLTEfYbxkccDWH61KK5+qvD9xYABYj6p4mRFDij51+QNV2oBGjIsYcOGZzHXnPu2WHL7Lue1Gx2vaPBY0nqDDCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UUnzIUGf3OR0uv8oDyV52NJ0N3YS6UhtUVTyHhtlbk=;
 b=KhFv7+oa0oIW0TAIl/1qHV2upp8h5cq4h0RVVo0ORwyCO9WseM5Md8ClmbfPzkj3ezZq9H+iFLpWE60Zrpnw3DbOoSFexcqf6tagsjpRCn6pQfqE1sE+9bjKzuQ5tyOVC4I1G76ZwNc1jJLqBua3QMVRHsFEfle7LFiQaPOxJvKAnF44Xn8f3gSRV0kLzLqKiwkwj+P0CYhUjvhh3vCxXRxxUFDIqT0lN61TG1T5bx1VWnxr8uH7EdZEZt2eKwpIExgL90Wh3Bsd+Vh4wekMSnNNV08Qwhu/vDlIea4hTTUbSbOgYUiiHkJTJXUVkE95s8UvB2NPT7t9rliBNm9aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UUnzIUGf3OR0uv8oDyV52NJ0N3YS6UhtUVTyHhtlbk=;
 b=Sz/y+pBM13cSk/pRMPPEw5LprJuPRfFSQgI0uCteimVQlQkiHHTizUwVxb66vfocV6JC6M6HPb6fLpYJnOJNSNeyAi9SUD0lQHLIRjNriWNGEZlgWUWpNEfWWjzEJZPJ/QsPBXSsMJKBPuQB4o0yUUB4t6EqYAKZOMmk5SRJF9U=
Received: from CH0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:610:11a::24)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Thu, 30 May
 2024 03:48:56 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::38) by CH0PR03CA0350.outlook.office365.com
 (2603:10b6:610:11a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Thu, 30 May 2024 03:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:48:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:48:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:48:48 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 5/8] drm/amdkfd: fix the return for the function
 kfd_dbg_trap_set_flags
Date: Thu, 30 May 2024 11:48:48 +0800
Message-ID: <20240530034848.2341406-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6013da-858b-4427-6392-08dc805b6e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kC9uKJuWZfCMheS1zQH8ysAd0FXi/qCICHC4y/PI2w5DcntEV3fgurJ87wie?=
 =?us-ascii?Q?Zn7S5YvWuiBOSG9l1Foy+3PtUF34mTjvopk2J3iQxNJ2k+j/dEQwA0FhRuxn?=
 =?us-ascii?Q?vgYn1/QPtmFDYZC5nMI9iar5DYB49zdBsphhqZSFln8sqnhethagoF1HU8i5?=
 =?us-ascii?Q?q+xcg1slR5EFMvaMbIIL6QESYMcTUlUEHoMW3aOGQauuLpr2YZicphfs1brY?=
 =?us-ascii?Q?mmoC04QhBTKMc1p7pBmzQeycaZqS1wWVoorAeOuhXA2Vry8bA0Rz/yhIQq3f?=
 =?us-ascii?Q?0UfEact+PRHBE0R7jaJfWBkSNqXIYq2kdv4jQucgPTYKBGXZMM0U7MIGGjoJ?=
 =?us-ascii?Q?TgVpMVrRpBWU9zhydgAEWo6squeUO9zLTLhCldLchpuViYJ/XGxp6dndUH+G?=
 =?us-ascii?Q?eHeqfnSBNbwqy/UPyHEne3GZC019UH8Hm26J9luUcVy/cwU/k9me9diwtd27?=
 =?us-ascii?Q?uJ/JndVvnCpH4ysMGbxV3BTGdlZGewAzTfk40zR9Ks7Xf2opJfXsJexWJRhb?=
 =?us-ascii?Q?ChgbzhUCgSlYT43c0tW5/JYuJ/E5XrXYIqdXPQUE+A/+eDICdSeOrZUOY9x3?=
 =?us-ascii?Q?bpOTPlZmdKV/0H0pR0zP38cuFnZfa+owEjJjGDDmgXeHB+dxIvBx0DLOqeBI?=
 =?us-ascii?Q?ZCPCW2w8XJQSjHCnKI9CIMWbFNR4Lpt1IFfC0jvsla3vu2sXSINJV38fFbBR?=
 =?us-ascii?Q?f28D2DufPlvD5q/uuZKi41h7fiwDUsiOhkgsC7O/rUw2lb/Gcy3WO/qf7jH+?=
 =?us-ascii?Q?juS+C4NjCeTBsLsxAyJc35lfJQUfKADDN4h/ZcyqnBX20vhNpYtxsvOk/OGC?=
 =?us-ascii?Q?IVT94PzBntPX5hSF3vhIeCmEHwgaZMwM2CBOGR5uUlP0ORzQB1fwA5joqJu6?=
 =?us-ascii?Q?WCh5Xp/EQ+Z4KH2BGENmJMTeMoDvBR3vhoAkI6/KHj5pW8PM99w3OpmycMfE?=
 =?us-ascii?Q?zRKOz3mP2E54Bza7kmUDBkBMZT43qfbRiKWwh7rVQoF8WHQK2GcRioO7EvJ7?=
 =?us-ascii?Q?yODA5NKa02OIwyo30+ZjvZHI4U1r9ErdAr6Fw5O1rwxxoNc3cKjwdsS30iMi?=
 =?us-ascii?Q?Xv78ma1bb2GcQ/wu+lkA95m1IFIJenV+jsZPDRGXCez63pjyOT8JFhHCTp0b?=
 =?us-ascii?Q?2rQ+3/ldPDqtboiaR7ZDmadvUlzDmTB+iiX1zN7WomuqbPFpg2+m3twayYcX?=
 =?us-ascii?Q?Vw3mL0CDhEh7h7jKcxHl4zkDG+ywSr9fKL8pmL96lwEucrsgdFpYc6z0Th7L?=
 =?us-ascii?Q?b4eXASolODad/u2Jn8TtQ9KparMNwczvq3dczj+o0TgN/9Xhna66pTUWpGCA?=
 =?us-ascii?Q?GGT5+H2hfysqPmKkNwBGKDKCZLXpNv7XYbC/5Kf5sdxg39aLPGztmY7qF/sS?=
 =?us-ascii?Q?Q6j5LHXpGFj44m9KSOGF/IuMeYC6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:48:56.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6013da-858b-4427-6392-08dc805b6e8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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

If the rewind flag is set, it should return the final result of
setting mes debug mode or refresh the run list.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 4abd275056d6..d12e5f29919a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -548,9 +548,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				continue;
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				r = debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd, true);
+				r = kfd_dbg_set_mes_debug_mode(pdd, true);
 		}
 	}
 
-- 
2.25.1

