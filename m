Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3353DC04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 10:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07EA98C35;
	Thu, 28 Jul 2022 10:31:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5AD2B97D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 10:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMoPrfHLqOugqhdGjTNHPvHhNVCkDEs+sOswhP/3xS5NHZupawZ8tE6NES1p5nqX8dO5fZ83EVa3DjoQEZgGXGIZJlwbkXuCkkRq4fvvStETTA0U0ucHu740Q/cKIbfqtexRKVZhgTnpe0g5bHp60mZ+R2iK26T4EuUcXlQk1e47SHUOONFHmK6oF9j7UwRYftViDREMWqPdJXmx1/jqNHaDsbJOVlYsvSS2ZWzLoeeKmtRgOq+JPtaqivlFPZrDm0AZ2qzkln+M/0TS25Yff5XKQtF77kWw45g5YciyC4ft5tz4ti9oBIGoydNQQ31UtWIESICJA+ls73A8D44RGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSrNm0AvnSlIXookwRAJRJivvchh12CNhGvBX58+7lo=;
 b=RE37CwMaPl+o45swJrNWeEKtQliN23JYEX6ND0EEq0ZmvOj+wi9ZQ82Vf6iSCKpCcntB/NqGgW07XRB+ijefvZKPpvDJ0nuRQDdGoSres3hoKamEHuR1ug5WN3ktyZyCnMUHwWHkHf/ySDTr4+EOlI6q6K2nX74RwkVfmWFrf6viwT448E1I4zDW3AY6XZ/qKu2Bmb/iEmg82mL1hA3W9S/yLVG5VJwSkGTpBlAukcySn0PN1/XSqw1cVomL7UIEluZWw3Rxug9slb8gNyWyFuUwt7tDjSHWainSMFdVBylJlm2GsatFJ2pN3psN2dn1Bx2z9N8XSJ/IVRgL9jab7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSrNm0AvnSlIXookwRAJRJivvchh12CNhGvBX58+7lo=;
 b=OGmXGlsIMo/OWrBiZokz0j6h2Ms2JKdHrBsIAQDzbixgR9f3Ib760fyM+dJyKXX/ZxPzHorwShPmrh8TbnXSnnwRE524Nu+oaV96eds7RDbV9j1xWRlKNfrVrwtdRznyoDJvT/6f3Y4We8+27iBsp3/OCQysSAovhrFskkwQ/3Y=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by BYAPR12MB3445.namprd12.prod.outlook.com (2603:10b6:a03:ac::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 10:30:48 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::d9) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11 via Frontend
 Transport; Thu, 28 Jul 2022 10:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 10:30:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 05:30:46 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 28 Jul 2022 05:30:45 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/6] drm/amdgpu: reduce reset time
Date: Thu, 28 Jul 2022 18:30:27 +0800
Message-ID: <20220728103027.27255-6-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728103027.27255-1-Victor.Zhao@amd.com>
References: <20220728103027.27255-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d52f173-c24d-4cbc-562f-08da70843c52
X-MS-TrafficTypeDiagnostic: BYAPR12MB3445:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ww6rQGoCpWkQRkjIp/QXbGXciP/gj7eEJ0lYvAoO+ZZ/VrG1ixCYMTRZGJHoOYOVfmbXNyfqX/z1wDBXQeLMHmiqCL23nVG/vO1+oY9XwgVH6H8lDIOLiEbBElqK9ICP59doefwxDaUnE17qud4QafOVRZkQtw2c51mOLRF+2+JBWkD/5oc9OcbsgatKQtQzPQpMk/EvPcXyTaLxk7c87X9Ph1+xpvV6Zz2v03u1wCtf5ii/gbstcqbw3d0/1IqPZUDVJHQ7Q8TGpqvHSnDuXoQ2UD58qRB/TkLVadh2DUZ+qUSMzkqrw5Ts/HMgYjgtNClD7qenFRUif1+WMQNZjmjeuBfftDMes8uY2jTvzlTqO1muTES6La4PGPCR83kQwIGr3tOnfF69MRsGVdD4M0XP2JNEZxy3t4Zt2MjjLaMx979nETLRDMGQNPCiiw60CGpGqmIjiV1yMKi9pBmtVqMN2lSMzTNTLqUoDqPWcaLWXNdOErKB/B8zfYYjqjF3bdqIpD52Ewad44GAMTD8N7XiYTFJDp9dlC9s8DGnE4pv+mk4AugUNyxkXzpMJKxuD1baoSpn0u1N1E+xoFbsBUG2AHD2vVtDqXJRjKzs11DUknoaVr0/vcxpkO14cS+xvb6gfewcuTp8VC+e9/I3njN5s1MmaLKRo1gSkJ6LKoic1NJuqGMWnZkyNUHbiUkw1XTBCJZ0YeUZwLA6U9vwV4XgDLXMFZeUrEzXiZmgmwCjX3eTnHYQzc5MieNpNqDOh5yz36JXPteFoyDPaOaa3n5vfO6VgDN2etuQlKljWCOI7LegnktMDTaCgnZzeGIIXdhuQmN5gh9MhQTfQAcpDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(40470700004)(46966006)(36840700001)(478600001)(36860700001)(8936002)(1076003)(186003)(316002)(6666004)(5660300002)(36756003)(7696005)(70206006)(40480700001)(41300700001)(47076005)(70586007)(2616005)(82310400005)(26005)(336012)(2906002)(426003)(8676002)(83380400001)(356005)(86362001)(6916009)(4326008)(40460700003)(82740400003)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 10:30:47.5744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d52f173-c24d-4cbc-562f-08da70843c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>,
 Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In multi container use case, reset time is important, so skip ring
tests and cp halt wait during ip suspending for reset as they are
going to fail and cost more time on reset

v2: add a hang flag to indicate the reset comes from a job timeout,
skip ring test and cp halt wait in this case

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 11 +++++++++--
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 222d3d7ea076..c735a17c6afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -27,6 +27,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 
 /* delay 0.1 second to enable gfx off feature */
 #define GFX_OFF_DELAY_ENABLE         msecs_to_jiffies(100)
@@ -477,7 +478,7 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
 
-	if (adev->gfx.kiq.ring.sched.ready)
+	if (adev->gfx.kiq.ring.sched.ready && !(amdgpu_in_reset(adev) && adev->reset_domain->hang))
 		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&adev->gfx.kiq.ring_lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 6c3e7290153f..bb40880a557f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -49,6 +49,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 	memset(&ti, 0, sizeof(struct amdgpu_task_info));
+	adev->reset_domain->hang = true;
 
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
@@ -83,6 +84,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 exit:
+	adev->reset_domain->hang = false;
 	drm_dev_exit(idx);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 9da5ead50c90..b828fe773f50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -155,6 +155,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	atomic_set(&reset_domain->reset_res, 0);
 	init_rwsem(&reset_domain->sem);
+	reset_domain->hang = false;
 
 	return reset_domain;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index cc4b2eeb24cf..29e324add552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -84,6 +84,7 @@ struct amdgpu_reset_domain {
 	struct rw_semaphore sem;
 	atomic_t in_gpu_reset;
 	atomic_t reset_res;
+	bool hang;
 };
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fafbad3cf08d..a384e04d916c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_reset.h"
 #include "nv.h"
 #include "nvd.h"
 
@@ -5971,6 +5972,9 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
 	}
 
+	if ((amdgpu_in_reset(adev) && adev->reset_domain->hang) && !enable)
+		return 0;
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		if (RREG32_SOC15(GC, 0, mmCP_STAT) == 0)
 			break;
@@ -7569,8 +7573,10 @@ static int gfx_v10_0_kiq_disable_kgq(struct amdgpu_device *adev)
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.gfx_ring[i],
 					   PREEMPT_QUEUES, 0, 0);
-
-	return amdgpu_ring_test_helper(kiq_ring);
+	if (!(amdgpu_in_reset(adev) && adev->reset_domain->hang))
+		return amdgpu_ring_test_helper(kiq_ring);
+	else
+		return 0;
 }
 #endif
 
@@ -7610,6 +7616,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 		return 0;
 	}
+
 	gfx_v10_0_cp_enable(adev, false);
 	gfx_v10_0_enable_gui_idle_interrupt(adev, false);
 
-- 
2.25.1

