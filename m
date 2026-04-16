Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460A5F433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 03:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7AC10E7DD;
	Thu, 16 Apr 2026 03:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2LgkGtaG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB4F10E7DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 03:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPU1oN+HIkS8vKGrPDAxPTDeW350TsCQjsmv/oDKoFnvnoPZmPjH20xza+QxW7XCV+7reYLfCXrWz/K/nrC8QpL/U2Owi7+SImLVNqPs/IYfqthEeNCYygCfrdx/wNUnYFYZGmBdF4nLbguk9s2BuEnC9/a5eLd1CRdmpcEAjKXKB4mgyujQlG6oL484/5Gq/L6KJd7C+h4O489pg+2VIZnbxeI1IjiFJ5STTRqDxs3QqrsTZcEiJMv7ukdrCgHf4spAOQ1UbExac+Zjzx2c9Jeu+GXKVBMO8cYBM9FyZ/k53eK6nopP/j4+igWkCg5kDtQ9QbNTadjUEPanF+fQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8v2auKL+oWk/oRpL/Jy1xhSbR/zSW6XhAX5/RGCpas=;
 b=hPvsh8qLaVYY0CxB9nOxRFeeEdnFzbzZUxqpBUHsIfFBTvToXwdqC6dh9XtCrcONCmbm9J3FCU5jpxGdSm37oLK+Mo9/f60EjetrUUHobwQIG6wIwSYfpM2MsGcm+/yoqfltbP6Z7psTk+jf0Hn4DwB/NQCnrSVhSrDcEg26QhXfmRA4kvDKW5S1DcdYxRUz17HY99+3ghW7wXrV1Kxfq8j3WrjnMXaSNvGFx5ZWEGN7s8Ou3MNV/ZcyJpDhHCdI2bmHFfQt36o9pFrxoRh0HHaGyzLOXrZPYFlpdOH7kUIiVn6Zo0SislfaRv/8gGc4pL9Whxa1tIoFqGI/OBrneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8v2auKL+oWk/oRpL/Jy1xhSbR/zSW6XhAX5/RGCpas=;
 b=2LgkGtaGbMhbupND/dtaBNgbHx4BLW8yr8BAT6sHMWxYjaKjrgLzhD2ugGHtg1QAtvT0+JKesNqYbvnxvdlduEENw8C1V/GHaZD8glrubNhiZ9DT6UvTJvHvzWmVz4Wsh7tZqMFj1oh4UnywMrEzSuBxM0U6XuLt0UK/1PxHEDk=
Received: from CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 03:27:37 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::9c) by CH2PR17CA0029.outlook.office365.com
 (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 03:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 03:27:37 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 15 Apr 2026 22:27:35 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 10/10] drm/amdgpu: Signal SCRATCH eventfds
Date: Thu, 16 Apr 2026 08:56:59 +0530
Message-ID: <20260416032659.2368054-11-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
References: <20260416032659.2368054-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: b5343c73-639e-4efb-5938-08de9b681b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pZga8Ee4H1qrdVUonYaqDsStjT6x/NJku8hN62q76C269uXbjAxIZFSCJM0kPZjH8i8lRKGXiFtEdbRKK3UWN4zHys1MVTdUesF27aBIvqvCrixfvsUsDk83zE2czbVFzxenTNU1s9yyW0K76Ci2yrolR7d8QjzaR6ENHGltmm/yWLpFTC8TZABW0yOD8fMwUjAyok34duqYWD/EDYSANZK51SC1odpjH4kiGIo0IsDo4VmmpDgfXmpKb34IeE8vRGlzsGqOTKL0aAG1KONntTYo3+0EKp2Lpq+bFg/h87XGvA26Kh/40ODmLW5nbYaM7s3GuGvQogFs7K7P14jPoDPIZkP7VFH0zPzLXrkLOiwYFEGo4OAyGI4BU5yvwaFco3YN63b4CjPlPQkSGar6s03yw3RaM1Vy6/etwvJX09HpoaW1BQbOk9ot6qO6rW8a/iBdGk558lo+PAwMmnNoA7PS4t9YUBvjTmOZrFffKda82MzPhdH+K74O3u1/WjHbL0T6X671hxEtlYQfBobk5UXI3lKeKrC8J20EBjLZWpALt7Gi6p4hkwBo1zvEXU4GyHG8LfbrUsm/lu8dYyBd5M1QYl8yDgEXY6unM2oY4T2kgoJtC20jYx9QJz5K76eOXUMZXsLLUc/ysaXGVvEFuYk7vjOM6NrpQ1BEOpOlHNKjfmbXZsT6AfrmI0PQovi5GTAALLLMsWoI4tNpMpIumALXGrEXWcthYu2bfzRv6pkoij+Xi/uhkuPqP0Vekif2b3ZXknKPKMQmG4wOmjRSng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Er/fml1blIV2IsILx2yA1G0BFKm7o9mSMxnz7Ul1QhDBuSWIDqtKROqseOZVS8J9BPR7ViFU65B6Ha+IxypRMzET7PFjuv4CDaKrZZsuC1x5ZuCmz/Eplujki8BgD87V5b38XX1xeAS1zpET9veMSDM/35/bsToo4g5ebz4sQXZoFLMksUB4Ts/pLZ3bnCXXRnPnS6FYSsD0iwCbzdwo9GACVBQuJ7FGjjCEQvdPS9t+0T96Fzs75g6gxP8G6nJiH/UOyE/qL+1y9JM59Vh+AG829iWNge4RuZSRAh5wuJOkvH752XlJF1XVz4NTBWHuRPjwBYk8qlqexEjsFphLWke2ib1UC5FlABDipd12H90m8Q/QfoU+arG2uZNh0qyGbIX0raYu6kjIV9Knt9fDZZXX9A2muxEGrZcP98LjYJMkgehsbx6tjhO35IGo+DHj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 03:27:37.4580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5343c73-639e-4efb-5938-08de9b681b9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

Signal SCRATCH EVENTFD subscriptions when user queue restore detects
missing VA mappings.

The INVALID_VA queue state is set when user queue restore finds that
required VA mappings are no longer present. Reuse this point to signal
queue-scoped SCRATCH eventfd subscriptions keyed by doorbell index.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 00e9a265c9a7..ea11070abbd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1017,6 +1017,14 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 			drm_file_err(uq_mgr->file,
 				     "trying restore queue without va mapping\n");
 			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
+
+			if (queue->userq_mgr &&
+			    queue->userq_mgr->eventfd_mgr)
+				amdgpu_eventfd_signal(
+					queue->userq_mgr->eventfd_mgr,
+					DRM_AMDGPU_EVENT_TYPE_SCRATCH,
+					queue->doorbell_index);
+
 			continue;
 		}
 
-- 
2.34.1

