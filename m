Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A48D0D16C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 19:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E9610E5F7;
	Wed,  7 Jan 2026 19:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gpPR7gD+";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD88C10E5F7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 19:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPybkELCPId3aiJtKI1W4w3Zd4mi8H/bY9LyURIa6wccc/Q29vfAIDI0N8HBIM3sQCON9MVpqrYf7a/pw+R1P4WNvxsC0+S3ftmpEBG/VT5+T6TjeePrtL9V/2LbHOJv4kQ0XyQ3SGzipuWWT3OCyVri5kdGRi+geiw0DZqI2G3/FGWqEaNbrvbwtH40duYNw8DnQPgX/j8Oh4yDszrhX0WGB1v++SA/Ju4kph5lJIBukY9tZewSVTdjeaKVrByO12MMB/Zirw9y9fE1+b1KKaigFkjVm9BcDA4UGYNT33+ngO0oK13wlfoarwT6sRlhDvWBlheY3xke4jGebeWHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rem9BxO/a7exbp/+IKKdB9qiQ9SkhVoXn+HqSOv8ISA=;
 b=lMzX8jggPCy5Jt4xtR1xXVP3pXNeBvOUY7S9UFxRb1Qgbdpb8N3k2nBwNYGfyMpqtNULRxXvuYTeHD7jrywftwlzhAuENK+lxMoJI2FFvV1BJIikpJ5brwmrhEm6065G/UJdA1XFrgjvwxfO6LjUwOPuQ4Ag6qie0KwxFuGvMA9Bz4RNi+VdnvvK9gzc+z5GUQ93GL2YCdxWpsGeMf8nhqVaycoXWipI4UwRv3iA/VO4ZXsPDNctajGIka/rPN07R5aSaoKBkE6QV/eppzzaKUA2fGvoXAyM6I2ZN94L8EaiN4HeOpzZr291smqKsXzfCvH8osYmJGcpqOngRwlB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rem9BxO/a7exbp/+IKKdB9qiQ9SkhVoXn+HqSOv8ISA=;
 b=gpPR7gD+RRQwhqYbOuowOJ3naRgp9gQ3SG004XXlzEc38VAY8zHs8QzB+8c2dz30TMYgZtqvLZaRtWE1tGk2ObzHTa4HdN2cu7/iW1R2ztyL0wgrAg+M6Gws/n1SgxQlE4CzAyci2uNvgh3qpIBjltLCLm500jczX74i+IcDYHA=
Received: from BL1PR13CA0354.namprd13.prod.outlook.com (2603:10b6:208:2c6::29)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 19:25:50 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::38) by BL1PR13CA0354.outlook.office365.com
 (2603:10b6:208:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 19:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 19:25:50 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 13:25:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <kent.russell@amd.com>, <jay.cornwall@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v1 2/3] drm/amdkfd: Move gfx9.4.3 and gfx 9.5 MQD to HBM
Date: Wed, 7 Jan 2026 14:23:39 -0500
Message-ID: <20260107192341.3521748-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107192341.3521748-1-Philip.Yang@amd.com>
References: <20260107192341.3521748-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: e678657d-7db4-43fd-4b34-08de4e229153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2uaFkWH/npZon8F4qiQErR01eo9BBMtZL1Mhkz/1IiMFbd7re3Z5/jvczWLu?=
 =?us-ascii?Q?fyLJkQHiVp67sjLqShzUkEd2oIUGOaGZjshE0KrnWZw+1O4yUo6Im0X4YGb1?=
 =?us-ascii?Q?bEtKJCWuZg5cZEwPMhJJKMCS706cDX4DHlTHWy47XpxB0Ez2zHCel0pxyvFG?=
 =?us-ascii?Q?Rd6L9IAbgk/LUKVZmLvzKqkoc6ryvnWZdgwBRpmpoxF85bS62oRX+xI5LNBa?=
 =?us-ascii?Q?dp2yIutKLPQXmUzbNnpe6acxHu4UpjJiBXSKoySiejHu5Wrt0Bqw3S3lj1Wv?=
 =?us-ascii?Q?+8/3Hdmi9y07cE2sKrgfjevJyhwOhEmFu0GFmqz6X3ysPjqvIqJOGMQ5FQT/?=
 =?us-ascii?Q?NqhNGwAf0UZNmkOa2LTZ0uy4JoJtdC29lZmcJxrdLI2hkzaMMvS3T7tMJEgD?=
 =?us-ascii?Q?fHqI+vfkQRKYNeX64QPInu+74BBJE5y+NItmQoN+LodW0dOAIf/Y0cG5pje/?=
 =?us-ascii?Q?UOg6ip5yFTvcAlRDmJxeTbozvIWGddPP1ppgor5WBGsa6R7YXiGdmLzjh6qw?=
 =?us-ascii?Q?UbKTFA9dNGjtx4jpm5JhPu6m3etXB409iEnsutPQAiIFwFdD1WeeKhF3LumY?=
 =?us-ascii?Q?LtpUSZyhux3kAT8b0kor7jrzZXMksP0S2myMDyqKsZbyPOuKaSOwfNTuaF0P?=
 =?us-ascii?Q?21ZHAfD7WyL6NEy9X+UgtfeDsJOQ+ChVaralSQgciH/mf0KMz8GeWEZX8kt9?=
 =?us-ascii?Q?yC+YSZlvtuaAzqsjxgyCt9jsiop5ok1xrgMuxe985kIT/SZwBckifBDJlBhW?=
 =?us-ascii?Q?MQvl08PgGfGYBCbZGINBJhmGKrtKu7LIKgYrQzXBl29SN9AVrAhAZ9kP8VL0?=
 =?us-ascii?Q?+1SdJda5/Mg5JrGsAtWpi8RYDtwu7xhPhK7QHjwdiY3XSxRDEz2x68f6/a05?=
 =?us-ascii?Q?TN/4Jort0+nBR6BIZJIPU0bdpYrhxWhcifCsogV/t27TqEbMnQ8VgQ789hr1?=
 =?us-ascii?Q?fczYNLJHVUv2e3sAlXLSMaiPbXPBE4lBY5F7yZDK1hwN4/iMUEAsAN8iwuwe?=
 =?us-ascii?Q?l6Tuf9/v02/D2amWDQ7R67EyzD3JUwluXlFFahKgXSfMrgmZZaFU39IWWxvH?=
 =?us-ascii?Q?3vah//7bvwPykJmZXpuoXzJwqzQ9+4LZ7cEHeJQ1pM70czSpZ/xm0dnjX1O8?=
 =?us-ascii?Q?I/Lg506j+lqSjniqKtRhjXPJJSgT0ehzsFSLhFIg4tbJmUNmbBoRAGohsBpG?=
 =?us-ascii?Q?5FAXbmdou8FuJb02G1LObvM3aXamqglLquLJQ3eFc4lMeuN2J8gwSfVWXkJn?=
 =?us-ascii?Q?KNffopbCrmeNOrS724CwMevd9o79OR4l3/zVWih+qKgy8WOfg5+IyQ6iLYkN?=
 =?us-ascii?Q?DYG753agyRbFHVhcZtGOXp+cVpEDugdky4iHJrzCv4rBeo9sxwCi2VfJg1sp?=
 =?us-ascii?Q?7oeSZ1EkQP0nWsC2+SDOgnccf97YPzy0Pu20PqTkHaC3ZynO44pke/f1GYlD?=
 =?us-ascii?Q?v4yjQthcFh9sCQiyPAWZbTkjqzOrvSM+IJAtAsZog55QuzxPArmYl8LyH43f?=
 =?us-ascii?Q?vctXHB5qDzBT7VhhVJR8h5SOcHP5Y0MrMQCyBV2OkUmKX3y0uGwDJi4jEAEw?=
 =?us-ascii?Q?1Nj/7fd9Xv/70VrwZJE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 19:25:50.6754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e678657d-7db4-43fd-4b34-08de4e229153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
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

To reduce queue switch latency further, move MQD to VRAM domain, CP
access MQD and control stack via FB aperture, this requires contiguous
pages.

After MQD is initialized, updated or restored, flush HDP to guarantee
the data is written to HBM and GPU cache is invalidated, then CP will
read the new MQD.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  3 ++-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 39c0b5a385c9..c1ffae9e96d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
 	bp.size = size;
 	bp.byte_align = PAGE_SIZE;
 	bp.domain = domain;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+		   AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d234db138182..d867dccae675 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -109,6 +109,17 @@ static void set_priority(struct v9_mqd *m, struct queue_properties *q)
 	m->cp_hqd_queue_priority = q->priority;
 }
 
+static bool mqd_on_vram(struct amdgpu_device *adev)
+{
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 5, 0):
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 		struct queue_properties *q)
 {
@@ -139,7 +150,8 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			(ALIGN(q->ctl_stack_size, PAGE_SIZE) +
 			ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
 			NUM_XCC(node->xcc_mask),
-			AMDGPU_GEM_DOMAIN_GTT,
+			mqd_on_vram(node->adev) ? AMDGPU_GEM_DOMAIN_VRAM :
+						  AMDGPU_GEM_DOMAIN_GTT,
 			&(mqd_mem_obj->mem),
 			&(mqd_mem_obj->gpu_addr),
 			(void *)&(mqd_mem_obj->cpu_ptr), true);
@@ -739,6 +751,9 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 			*gart_addr = xcc_gart_addr;
 		}
 	}
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
 
 static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
@@ -775,6 +790,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
 		}
 	}
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
 
 static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
@@ -813,6 +831,9 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 					(uint8_t *)ctl_stack_src + xcc *  mqd_ctl_stack_size,
 					mqd_ctl_stack_size);
 	}
+
+	if (mqd_on_vram(mm->dev->adev))
+		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
 }
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
-- 
2.50.1

