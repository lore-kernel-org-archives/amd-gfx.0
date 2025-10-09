Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0606CCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 18:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ECB10E013;
	Thu,  9 Oct 2025 18:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuq9MkvA";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C25AD10E013
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 18:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rywuPM5ZlkBHoIMh/8xI/2LQNymz/O9md3TCmNPsun1N/zsurSnodNxOIJFpXD9XNKCuskW8I/YL88OQCCuUFNAMgOmKJoa38MBeQyFdavlneG3hkqXiMQ63NQIdFAPy4uZOsymmWllCCMa0nQS/ehwdp4CW73sD6zes+ENsuzWNO+z8ggWHx2IvLlrrY5q+upsvShxIGHGeOVfIG7JTXer3DNM1oKIPV98s0GDVZCeMvCKI7/GZvRSmHTnGgeEL7ChSZvUDB51KEeoFEmPNHdoxcAeQQ52DBk57j/VBkRVB4/9Nl+FJHzcn83AduB3bpQTmsoINolfleBuTQdTQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2dyHLZBB2yR/E+g6V1hZ7e8qcrWjKnAA/Lh3S7TIc0=;
 b=am9366ufwIndrOgKePk+TaVKvGzCKuZSubfEIW+GDL2T2Fmk7nVgmwjecc/fYgnvELcMjKIQzLSGxQ+9L8EaiRIYs/gnIDROfgieUoDhPxXElERreCt7mLpK0BemB+W7CgxjJt+4/irvR03SugaAGbzz7g5a0cvF9Us4IZemPgHibsNFUjqWZEFu2iVLoaHx5HFwi3ajgxWu8LjY7BzFL568l93Y+21TlUHqNAjp3+mXrxdbrHYT5GKnGxSef0TJvezakHkaP3aEAJRuFk8GFwD/33Vqw6VfjjDCG+cEXz0hA+HINsNu211h5cKGphlacyLJAA+mVftkpsNe7YwGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2dyHLZBB2yR/E+g6V1hZ7e8qcrWjKnAA/Lh3S7TIc0=;
 b=fuq9MkvA+Luft5tirUTNS5HEtwka4448XHtT3Cp0DtThENRZxEW+4MP8klc6NIThwfbJciG3iiFvmaqCMC1JsUE/Joj+VIqjsM70jx7cWsMX3cRKcMqGUCbtKOveLNRJ6dX8al5uPsQ3mTpsdYNOKbpBX8qKK2zKHCJ1Omh1Jq8=
Received: from MN2PR01CA0007.prod.exchangelabs.com (2603:10b6:208:10c::20) by
 LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 18:49:53 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::87) by MN2PR01CA0007.outlook.office365.com
 (2603:10b6:208:10c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 18:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:49:52 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:49:52 -0700
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexdeucher@gmail.com>, <Alexander.Deucher@amd.com>,
 <Shaoyun.Liu@amd.com>, <Harish.Kasiviswanathan@amd.com>, <Amber.Lin@amd.com>, 
 Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 0/6] pre-req fixes for mes user compute queue reset
Date: Thu, 9 Oct 2025 14:49:23 -0400
Message-ID: <20251009184929.1038298-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: de37772d-6d6b-4f42-4f90-08de0764a207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DHMvGO8fqd9f/GF1VRRrlpj6mVFru/dYNQ4vunoT7XM+i892o2VhIFqKDd6v?=
 =?us-ascii?Q?2bXRHnlw21S640D7eQeO7FNOjhDGi0vnSAlj0BVNL3ns0Y6AHlPzzfr0G0XN?=
 =?us-ascii?Q?O7WXLBwi1ylfq4vGnLCaZCURiHATYuXvfExTDpJUK1BIYwRbXjkO09KvJQYn?=
 =?us-ascii?Q?F6oD3rHXWFI90Kard34rabypBZk9uAL8lG0fh5HTMk9B3fa7hgcXDGdMAgQV?=
 =?us-ascii?Q?VHuy3l1awlBVZXqpan+33YL1JOq9m37w9eCw2pHXjbo0/TFIMgY5TdTmoug/?=
 =?us-ascii?Q?jsXm621CCopxLrbkYab9A4p9zyYASziTXrnwDQIw1iWMuzAxNjI7mU9jWFHJ?=
 =?us-ascii?Q?zTB1HcVaCROE9OUoRMec6OENch0hlC05kmqra8P6CMrQqr38cCsfaXb5C8Km?=
 =?us-ascii?Q?4VxWnJuRViM7Sqg0h3HBCDLIg05HM0DJ13LEvrafOLY2oNULsxd7DWo32YZv?=
 =?us-ascii?Q?hxxT9KKjzgaFgpW0Ftk/4ADtOiVPDDaskhUJ8d6tMTEsFJPdKTrVWWKvO9wn?=
 =?us-ascii?Q?lNpFsG/x34Vi4oqT819suuoTM0VQ/0L9igwWj/X30DNQnD+Ceptdl7oec7V9?=
 =?us-ascii?Q?ARiCSXFAb/4fXWBNCsA7SbXRC/+OuFLR8inE4j1N+AqQjQ6+tnyZ1Mdfh0xO?=
 =?us-ascii?Q?4TjPvgVIGV4tz8IR4L67FlsfmRmDWVFjlGbIxFPrUC70t4Zwl9tTfPL+GeMF?=
 =?us-ascii?Q?3HJJt7Dl9VbAGmNT458TCug8vB4NplljRWmzly6EiSYcUOq5bWxev53jkCX7?=
 =?us-ascii?Q?9TK73qgIT00IHXX6fg5FklnPpXSDsqTzEcwI4miIUa5fgpPWDdvXTd7F5QPx?=
 =?us-ascii?Q?UR9WwlkP2qbOof/wwQP5QeeUQJSXcrPiRcFo6akuq4q9gZXyOOXud0awnITL?=
 =?us-ascii?Q?kjk6wksblkYkRW/QNMtJoBob3YHUdFmlhROlA+Jsn0mZc7QCvWJ3/9PcgF75?=
 =?us-ascii?Q?s1kk/v4IveGaUqs4zmY9h0v6zhv3bsdgHmfCmRBb9zIjj0+GwWPKqwNNptXX?=
 =?us-ascii?Q?zKGzBDcsLHY04rNG1ZIPXGf0Xg4fFyNiv7kpic+SJSSELR4y7AAbSlOaRN3X?=
 =?us-ascii?Q?B77F8EddSyJfKqukUhZVvlmEOX4eUX5Pybo7uMCbVUmK3JwP1BlVwfv5SNdy?=
 =?us-ascii?Q?8rtNUIAgIElC/xIe7Csc2flN6sxF54cBnzOxYeaJSm4IwWwYSe6XPX5/rTDa?=
 =?us-ascii?Q?GGjrr7GzhPNiww0yyCjogOah9VHtzNc+ITm+p05+eepQTnqnPOwCi96Vqeyx?=
 =?us-ascii?Q?SgdhA70MhVj3C8LG7hVx3UkxIR+mSyCU+2F4gQyJCWePPVaFRr+bd5rj8Kc4?=
 =?us-ascii?Q?7CvpHbPCygZXtsLVlcr0GQkX2GRS1SAYJnYENoD4DDbhmvFKEbRMZQweeFNU?=
 =?us-ascii?Q?YG3RNXyJS+84aNzSvscU2C9wtJuDzREQBTE5Fd9prcAD3Wi3OtqzeJmTT3pI?=
 =?us-ascii?Q?L3IsvlXZFehusJ5xz6zD1cROPSggvvwwBGz0bPwbWQ6EpZXEkKiZ7WyZhRkZ?=
 =?us-ascii?Q?W61/wY3knFhBnH5EXEoz4qAm0xwjuW4a3NPoZDC6g5dx/s8YTSzlmRHdstRQ?=
 =?us-ascii?Q?p7m6BD3eydB9Ivlg4BE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:49:52.9230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de37772d-6d6b-4f42-4f90-08de0764a207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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

A bunch of unrelated fixes needed to for MES based user compute queue
reset.

Jonathan Kim (6):
  drm/amdgpu: fix gfx12 mes packet status return check
  drm/amdgpu: fix initialization of doorbell array for detect and hang
  drm/amdgpu: fix hung reset queue array return for hws user compute
  drm/amdgpu: enable suspend/resume all for gfx 12
  drm/amdkfd: fix suspend/resume all calls in mes based eviction path
  drm/amdgpu: update remove after reset flag for MES remove queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 33 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  9 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 11 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 ++++++-------------
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 +-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 +-
 8 files changed, 64 insertions(+), 76 deletions(-)

-- 
2.34.1

