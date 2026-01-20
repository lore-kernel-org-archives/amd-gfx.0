Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E9D2ECFF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C61F10E29E;
	Tue, 20 Jan 2026 01:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3JhoPzQX";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F397510E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcJrFqFvaoPEIv+dSwMnClnrjuhBTYGX+vytI2wA79xljBPwDfLpd+frOlzoj05fzKWm5TiZtJTNDz4E0iI9Ejd3R6jTLHklq09eS23ZJ/yBmDUyPDtP8nZg0SgKWLD7hzzOGpcoc+BFJra7npgmMRg2wKLpMyC+fStlv6n5U+AT2tCsB1bN8hog85pOivh++xKt/MyT2Itcela6ARuHGJbQ+Mgynds1ozFnyIgum88lHsbG7wo9hMNThDsohsAlY2/cu1qIv8gfBqs5pu11+MgZPNY+oq5NHoSzBEUJGoIzfkJkxOKrXW1j1QLRsZmjYpOSrMHJkaMA6in1/UoYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=bAOkTLIru8Yxsi/2znuLBZPlw3aXhqfdNrae8kr5zdRgeN1syM005z60xzjOgM9W3Qgd9udWKAFm5HFDIg9O/RPWUuvjFOSDANte0nR5EwrjVV/Cyiv9915EHLX/dL5JowJUv14uY675AkWXETZjFJguN5nGJ7g2WKvVcMd4aQ82FJFBpQRoO6v9gqjXcm/+IbMu6ACasbVb5v7DzFjIXcez9H34/BV7PlhfrVln5A3Cgq1vKW1jDzpol7MnQoRqJh2RAd6eGmp+rNE9hZSI96wNMZaw/DvA0uKldNFL+FgKZYpmSj4veBJEVwIdWa/M8tCS9bJ/M2pqVoD/aIn7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=3JhoPzQXI9cTSKRCTXRxDXC1PLpQHh8MuBaJE+clbDehmCYJX2dTjc8OT+qkJKD2siPBQVdTb2SBPAHBdbilD8whTnSC+x+K9WxFPKtnKr/jg3RBRySN39Hs0zvg3G53+712TKdiS9A87RRVTicpJFyrFEtLdJEcIz0VdBj+m08=
Received: from BY3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:254::32)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:34:23 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::e8) by BY3PR05CA0027.outlook.office365.com
 (2603:10b6:a03:254::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:21 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Jan
 2026 19:34:21 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:20 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Mon, 19 Jan 2026 20:34:06 -0500
Message-ID: <20260120013411.15659-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 984d75ae-6ea3-4f17-5199-08de57c40a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ag6mrtirrx6ko8otW8B01dpb5aAcQKMBNvsUPk8hpLVf6V2xuMefRj3TMF0?=
 =?us-ascii?Q?dK6qRDognToWyMaPxedbvj0IgitRSTdXPiN9a2QNvC7fre5rtTUuRqBadSrl?=
 =?us-ascii?Q?RgPxWorXzZnpr1VhdNZulh6/u5Eh/aMmVhDjyxJFWkjxP7UoRtyKWN9rFnEA?=
 =?us-ascii?Q?1RRSY3cR47HmKE2Uv7JZxCVGZyQFtHHqMnwkz761LOlQFNFqJNI8vcGnXkC0?=
 =?us-ascii?Q?xLJ8QZTXgK/urJe+9N5PwGXTzFpb5fnrKIxD5pPLTVHB526LbdliMzHTPo1C?=
 =?us-ascii?Q?pJYlqoE3bunYoQbMSdlgKuXySzuD58Pc8KQSYW5ygmzb3U4+QYkU83K1Yxlq?=
 =?us-ascii?Q?sHNrd570td9kCIfenejMtS/BmR7lqnTGgN0fWzgoZvdLq4tklNC9+a7KGmV4?=
 =?us-ascii?Q?OWYvPpxtArt/wbcY8YaQclDHMSBof3nex05QNJ/+sLjqz19H1EIU6Kvz7Lo8?=
 =?us-ascii?Q?1hUg9LO6izYg/DDv+2B+mCJTXtQOdP9bl0RX5rYjoMQeOe53iUiA96gsdde4?=
 =?us-ascii?Q?IoKha6Q8vU3IoCto5y94FnDRqRbaeup2183oiQIqycAOWiby8lun52p6ylYf?=
 =?us-ascii?Q?9DDm+xdBB3dWfDel5AAGYQvF3seM9J6/CBk2tLKrHdHzVpWP2t1xcdDyBuwF?=
 =?us-ascii?Q?S/UteIkN7UhRfiyR0/iArDSfXKeO5xc6p8yDNRu9GfMZw+vA1Yvg8zjIyzsv?=
 =?us-ascii?Q?S+n4OnFsrCaDUHnxUepROeZfxqTuHA7TXCiLxYA9hIdo9p56Zb95Dzt2Rm6Z?=
 =?us-ascii?Q?7gR18RuxlY40ii6CXqHg51fzQNpuoYr2xVJm/dTrQUZiOdh7B45dxf7HNl8H?=
 =?us-ascii?Q?KNzUnZqMmH9AglnFlLPVWPO2dxpG/7CugXRCbjcYELdagUo204wZhqsO6IoO?=
 =?us-ascii?Q?cBER6809dnpX/5VPLBRaQvblU8jgAc+Gp3rikJyhqc3qZH4bk9TRIF//zdus?=
 =?us-ascii?Q?sU6VL3heu3+2fC6EqmJ+AEOfKER8lmTVAwaFLyXYJ+sQ8nVvrJnKAHHGjEC+?=
 =?us-ascii?Q?uamgzdfrj04Onqqu0WpRGqyK1aOFB6/9Rz9JD5cNfZBV3iWGV+d0koLrqR7L?=
 =?us-ascii?Q?qfsqxSWvhB4VfSnSd8+KSSuQlFl570TJKG3HAnF2Fa3uYeCCeVAV8lvryMGF?=
 =?us-ascii?Q?IZK26PiI0AnGFBmVh6IItXMFANc2CzQiYqRBR7ij/JYJG+m6EOp3WJqcqT++?=
 =?us-ascii?Q?2k7CrwUgcdnz+U+31oQ3E/3y9q8WavFPiJvNZfBpHvMUzbsSi4lXrVuKKDGK?=
 =?us-ascii?Q?lHe4Y7tYNU4U1vK9udNTGkt/JV7guAF0R5OXahyqxHjfi1sKaPW5zl0eTRfw?=
 =?us-ascii?Q?hJqUMyzjjzOXkzwAq5Arzkh+pbB1Cu2gXQ0yg4pisXUu+vuSCWf7tCjJpX+3?=
 =?us-ascii?Q?j2S+O6Lkl1VXpcDHC9XtYqzCSArUuIqKUNxdxOhVdN1uOG+nCHXUGqC/kzCs?=
 =?us-ascii?Q?KthBr1dfYWEYPSXthm09OHLtBySY+HCSx/sL/u8XVJqzEMdGZNQUaoLKe5ZT?=
 =?us-ascii?Q?8MmaASKFpicC+pQ2uMmMVWHS8RPvC3FEY/KP58bs1E5AfzM1mgbqVJjqY4Hw?=
 =?us-ascii?Q?bLmmfzPfZ4N1K0ifVy3ts6xu3vfcwXgktUFxer6ftcJcAFCFLfjIyS3T85vQ?=
 =?us-ascii?Q?DMG+VY6LL7P1DScLOzsRL5YeKv1OcAsW17yRKVmpaenlpKdCVuo4xF9TeYKe?=
 =?us-ascii?Q?bjqJwA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:22.9514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984d75ae-6ea3-4f17-5199-08de57c40a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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

We only want to stop the work queues, not mess with the
fences, etc.

v2: add the job back to the pending list.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 362ab2b344984..05efa31c3f6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6310,7 +6310,10 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
+			drm_sched_wqueue_stop(&ring->sched);
+			/* add the job back to the pending list */
+			if (job && job->base.sched == &ring->sched)
+				list_add(&job->base.list, &job->base.sched->pending_list);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -6394,7 +6397,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_start(&ring->sched, 0);
+			drm_sched_wqueue_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
-- 
2.52.0

