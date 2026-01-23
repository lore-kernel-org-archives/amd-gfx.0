Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A99D7788E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C52F10EB6F;
	Fri, 23 Jan 2026 17:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RksTF2A9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA2C10EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTtLtsgXMgKTNqnCHuYk4XLJ3ZjCLrVvGoVGQS8gBKJ89yD2Yj4vuf3q8zTMFxm5RgbzSBRsadCNjMTN0jZdaSuX4/dpOWu9KNC9nbqdQf0GFZoOd0qBTqxBf3iBcGIaS2d2vq75poF+5+Xp2AVeaE4jpD4xcgX4VvXTZgWWbuaPzYmArLIoyYlnpb7662jKhiTHI3pLavJ4O76euTcRhG2nVeRtR3zOWcdz300p8mzG2WG93uiFuGrNGSeRuTBxfAkyBJSaZ9KQCqSQDwXrdMnZYA1XHeNF+EyymeNdOCWoGoZYUpKMAloQ+pKthgHGNXFhd/DHV5CG6CVjt4uF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=A4seHX9hdf1uirrvKGa+AxRbQzkgIRqQDKUnqUInFxIOM7KppNSsDi6vVE20vcTCq6AFCOBkFo5AHjo1WZZYhTmUzpVfqEElCueoSyuJruQbeYq/YGsdslw66mPeQ0bJw6yGcof0iM3tWEQJn8hOit/nVQy3ZWeqWyCxmeEHh+rCYw9hOGKhwWdqdyYBU1d16Y01b7chpzdpKD9RLibZq3Tkb0uiz7Tl4kr4IO2cEJVJGR/IY+GPBGzB68Bu4+LCM5f2GMXsiC7NZLd/Lq4e51ilU3X+Y1mQHLAUjFtxlleHpg2C5Y7azUpKccj8D7IInW3T/wKTYaixqswAxOgUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXLXRpw1NR8YD998dRw5MsDAJxaMIUsip+1aSoadBWo=;
 b=RksTF2A9Fh8Wt0byXsQpjhAe5bEU6zPdHzjMoYsteXfeW6l4uKOsnqQmLtScMfL3Orv5PSsWDu2PJTC8ecLj39NRR7a+iOlUJxp9i75NsN19QVJyEnPqQxGWNZNv46dJE5tHBcw7LEc0K/WC4M0aKX/0M7PuqANpfR2Ov/BUWrs=
Received: from CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:54 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::cd) by CH2PR11CA0016.outlook.office365.com
 (2603:10b6:610:54::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:19:47 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/11] drm/amdgpu: don't call drm_sched_stop/start() in asic
 reset
Date: Fri, 23 Jan 2026 12:19:31 -0500
Message-ID: <20260123171938.16814-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5be213-626c-470d-f3b9-08de5aa39fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGOmoqw+aMaRNdmQMkpENSuU/HJiab8U6FLBSPmHQsCt5u5MxlNc+bBzYVAp?=
 =?us-ascii?Q?LFGm2OtQe9EeNFDhFRflojk5AYz9Edw9HYk47d//Bw0p5wDzWbTp9S95p6Sn?=
 =?us-ascii?Q?0ewbu21DbArcoqbrLzStgD6ONF9+Ks6F1MdStCRZ/ucYuZc1ftWuCm4+y9gN?=
 =?us-ascii?Q?EX5m6B8BpnulEUzluRgWOtdKtR9uAwjgYJQZzxNOJfc6mF3XdCaweToQGThu?=
 =?us-ascii?Q?WYSnScsSTBgYUUy7WgCxMicstc54VVzbW65YaPp8F73Q+Yk1uA1l4aVbJ2F/?=
 =?us-ascii?Q?6dQEQImnes2QK+F9bEbcfIWzLQjR8i+7vsTwqcZKSBOS12Cw0rkUBOvQsP4p?=
 =?us-ascii?Q?wIiynYBZzshMdO2C8Truh+cPrIM/crMbFAKKB0b6bZ/G4hREiJdw9SDNC9iQ?=
 =?us-ascii?Q?Uy2I2U/UIwHFlYeSSJuySs6he1fffejPOQD4So9mgi5sWt/XUc06l9GTfcQC?=
 =?us-ascii?Q?kvcgW1UCtA7KlkO/D4t9GOwDW+7OWHeWMAtoDLZpVvZjy1kqFr62r+DvLoHl?=
 =?us-ascii?Q?cm+uPK7Qx8K+BumSyb4lwleSuZCaPIdUML1XOiB7a4muKza/J911NIAsgDrx?=
 =?us-ascii?Q?OWplF7crrX9WsM/immCGWE88hsNYXqaMxZvq/w964ftgUNeznYP0iI+05TuC?=
 =?us-ascii?Q?HA9UG6fAPQ1wWgy9QoOQACaaMvNixUVKZA3LCbc2bkYc0P1YMlaVAJ+uGi70?=
 =?us-ascii?Q?ucOyxvBjf2aPKcGrFiBFF6lo4h2yCdUgHpbFXCfOZUhhYWa+AoRIdLQ00amq?=
 =?us-ascii?Q?bB32RRhdVgzWQ5u2mmJG93F5zrxgWP3loSMFj+Q1KlOrH4DCU/LWN1NzDg4/?=
 =?us-ascii?Q?yUGC4uF+iTDOXwpdQdxDci6m1rzwuiEgurbDcs4pNldxyHNtpo683q6iFdqA?=
 =?us-ascii?Q?Xsccrai3o1vidYgE3Hz9bTSWyfe/KaD9O2/PD7jxQvBpsEDjE02kQEm86YPQ?=
 =?us-ascii?Q?3sjmSEZ8MUMt+3O3CKKQ47392/7NzoipVDmUCBaGoOgtmnjghSuKLjZFaP/O?=
 =?us-ascii?Q?yFRantFS9d3q9QZSJWMn/Nkqg2QcVCDBEdWPD2anatRAFWpRRC6RLYTLtOng?=
 =?us-ascii?Q?WDDb460bSVYC96IXD3eaLVUZI+pL0xGUTWlTle8PI8ydRPhDynTmxIHnCXSy?=
 =?us-ascii?Q?KnTfBtwapzM8Xo5u2qJgXZwfJ+dsVCJOUyTYEVHRij6jYXBuI0evHgKYwwA3?=
 =?us-ascii?Q?oXSbYRbXTIvVf/vmGV1HOyq1pNTbULuKqEbvHOSA7fCc+ZinlQVnhDLVP2G2?=
 =?us-ascii?Q?BQe85PSaix84ZzIej9zn0DBIaxDSzVPRWx1ZHmi4A4EeymgkaYuYoaQe5WH8?=
 =?us-ascii?Q?FRpFb2UkCr5TUOnPBLrcKGSDdFQ9bV8HTdK+p6bTS4qOsbvgGxTnRBzpJdnk?=
 =?us-ascii?Q?y64/Qb+Nj0Jaa9gZGvM9BhoWGuUgu2fUH7uGGFiPvc2saF0gJXWJAMkw3ayP?=
 =?us-ascii?Q?F61eWZvvLPPAkjyVaIiNBnF8FTlMffBeiVNF/GQmSIbIx++y16ilsA4gEEUm?=
 =?us-ascii?Q?jvVDhx1UTKs9DbCXEPlB/DOXzO+Ka40A5uXguwGyXskkOhZOcuPf1EhRhtvX?=
 =?us-ascii?Q?j09eUbTHrpTIu6Y+VXlLfFPmatNuyUdMXO0vPwXsJVnxD2SvREOnYVY2RdyB?=
 =?us-ascii?Q?9Ovtx50fDKd4uQsip5RnN09VHqEmnV3T5vhE41TxylBCOV+2UrqTyAJCgUol?=
 =?us-ascii?Q?YIj+mw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:54.1918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5be213-626c-470d-f3b9-08de5aa39fec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
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

