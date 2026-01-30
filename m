Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21FED49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873F310E97B;
	Fri, 30 Jan 2026 08:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vcT3k8Hg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CF710E97B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcta+IMpbM2Z1byHz9bHvIKIVXqDqCwPR2ZLBB3I/Bk0EzlkzZACL5h/lGBT6XDRQl3I6PKk3mBpA+TvaKsr9moS78emF05r2/FzlHPGq70ljIVHjCOC/ZvtXXgj3IxTtzWMgJ+uWaxj907zaIJ+AWvpoiLP+1wtLyF/uJr0AP9vVHJYtfoG3grNp2kD7Xut3axF4dF5PyCfmR1zqpaFO/kvweAsR3tcYeQqrJd9iBbZd4s753e+G3MFMEvmlEkJSDB4Kh8SQDVdOh2Azs0rNYzS85KUbevX9y+kA8dI1qzM3UaQSIsV6zgLjKqirbyiTBG+3L7g2lHeTqQNSa3TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB2SeQ1nIT+NagpecKWyyu91SaN3O9MB93dZu00jEsA=;
 b=bwKFwEZzasyVU1P6aFQ2lyNgRfx0uxj+rEj/qgo/VVkCPgktFN4kqxX6tSSY8Uj4Q3OuAkUQoblTWsjh18skv7jn6xCJ8vPIpr8qV4cytKW51zhwv4nwXq8dpXXwLHPpM2ozRGSZZQjWXaGXCiQiYy7eiFQxWeK5yFEuf1p5ar0vzzpK50V5i2BhaK8dq5hKdBZHlbm3qGaV5WUEwAL6Yd+OWqmEUYwROV3BtTX9RtMZLxhmcQunJYug7gSUrB3uR7s0BIuBBMcbC271G57E5Rd0nHeFKh+5D8QH6uFAIo89lQWHojLak/8NEtRFcr7SbruCkeyriZeDbsmqLfPZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB2SeQ1nIT+NagpecKWyyu91SaN3O9MB93dZu00jEsA=;
 b=vcT3k8Hgnpw8ZjQfd3WsScJ/djHy0NSQ95tU0VbBJhMcJJCwoIZKW65lDSfdBLyAAKJWM/qADtIbnLuCUpZtjWhXMWii24pE3jtW6mAhYrPMMH4SgfkT/LRdTiCj9YXKqgxvuXJBHTK4+Nf7XL5RmXjuNGnt2Z7pnM/8NWcRKWM=
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 08:42:28 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::34) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 08:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH v5 09/11] drm/amdgpu: Add ioctl support for cwsr params
Date: Fri, 30 Jan 2026 14:08:03 +0530
Message-ID: <20260130084137.2906792-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260130084137.2906792-1-lijo.lazar@amd.com>
References: <20260130084137.2906792-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: ed05f547-cec8-4eb8-82dd-08de5fdb7fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o04e6ynXTDQyHozw9ybdBNz+tMvpm3Ne1xX1WqcByCnjp4wupdpp+HfoZrcW?=
 =?us-ascii?Q?Qz/fclMMEC/2NOH5FSSVIaYsw5UzKcPSZRIdRRobWbHk62Vm/VEQtb3n3j/X?=
 =?us-ascii?Q?pPTvaVuT2dLj7UVG6KtP1GtfgWgeAuiH1AiofIEJFfTS9y3E7bnV14oS8Tge?=
 =?us-ascii?Q?hMqr8lX6vK/o1JckvdWI3wWvIi5MPBwlnbvOOSe0XdRRAXjgxl+xdepB0qA2?=
 =?us-ascii?Q?eNuamccDUjmVN5q4u9ShH3PAAKC2WOixLhMRER/gLiI3I+bveLbUEySuV7vL?=
 =?us-ascii?Q?wYh4rNK4W5sbvP77KIu/1LJGSjPGkA0ssSu4Yq2l93EeIs5ac+bHXM0XzHYf?=
 =?us-ascii?Q?V9aOAXHQ3LbuH5Tj+BqKGT+BjlSm/izLGv9hyPdr8/Keq7qRvcCT7qaFJJ+3?=
 =?us-ascii?Q?e+OXORlijF/unqfv8tbdpTaglbINBuRG7zI6ROMVoJk/K47rmgALsc0j8Fid?=
 =?us-ascii?Q?q1RGrWxk202J6fOtAOaKxS28gc5KtXGBe+lXXwWHhpKIBelTfW1CqVOF1Rsb?=
 =?us-ascii?Q?ixQWnAxmWwZ4+eL6sDkHmYwq64aMOQfY4nDqzi4Axw7DKQGgpiDTAUNMr5Az?=
 =?us-ascii?Q?6tXFX21NEOleRWEvlSGzr+zatic6GmYvLNFxBk150wS6vS7XVG5SwmFfFhHV?=
 =?us-ascii?Q?eqkqZaByRh/8NdpKaeh7/RSBeZHd6DEW3g85vT3IVCa80wcviAN43PiND87r?=
 =?us-ascii?Q?ah2DkcbWLoT3RveNKR9xBaIYulMpkROGsIlg1LCKcuuefmR3r3mn61mINQ3Y?=
 =?us-ascii?Q?wGEUrR0nJN2Yq229b9MVAqkjENYhKKa1gEJtNZv8cxiSHDk821xwEQWNlWuF?=
 =?us-ascii?Q?6ZOyoB2l8E8pAMe8m58ccBIZava2ijOI/yXErCRcTskjfUPgHuKHQOYYAsea?=
 =?us-ascii?Q?wVgjL0Lp7lFpvl9Vj80TUVNzXaeNmNYNS08fVXg/D4R3PeUtkzEDw6n+aFMu?=
 =?us-ascii?Q?y7TQXUPjw8MNj0wFUYmWTPr8vheVLLjl5Is6U3gxUYOMw2ET/J5jYw3ahZdm?=
 =?us-ascii?Q?2EpYOAp8wMnS3NxAz95mfq0zOu6o7YHElGravlNhLaxYTCZCZYLdDn+z0nCn?=
 =?us-ascii?Q?7htDLwRfuVoXf9e1jG2uPnL1oD5whQRwFjH11KTsl9ZeAY2SGWlI/FV92fuh?=
 =?us-ascii?Q?C52uaFLQ+O4oMbW1UBxe296DGCk/qkYBhFxqQLlCLQNp0JHNgjhVLVU/fKFJ?=
 =?us-ascii?Q?fnD8KGcBAmkWEjXIalrTxxDrFc5LvdOhItRDps4RzM+JkqZDJrJ7pbbNC2mN?=
 =?us-ascii?Q?qJIy1NbcNMmR1qouQFr9XY56IMCpwrECsC6mEJXFVNV4wuTBdWl+GL6mfY8q?=
 =?us-ascii?Q?/xlDq7gdDa6+T8a9/GzdEB92yeBYkUI/Yhd+v0yRF/H7xxt+CjTp0+FIsWi0?=
 =?us-ascii?Q?x8rVAExjirr3+m9Q+UZS4/hmuosf6LgRFsfErXwFu2o0sPW0u4URzVcBTyF+?=
 =?us-ascii?Q?KoLURK6VQMlX5v1ZokPv+x2SUazN/2w2+Qqelm8/+3SsHpfedeY5abgAQySC?=
 =?us-ascii?Q?iuTxTSngKY3Hguh4HfQzeGO7MUiE20jkVAfqIIz+1fQShpnb4GA8wlSOrMvf?=
 =?us-ascii?Q?T8poRTykWFDISXvIkN0/595MrU7xbiT2PZHiKqLt65Tw7PyOFXGeDGLix3XS?=
 =?us-ascii?Q?kko2PxVy4yVA45aqByRhuxOAmkx3iJeAO0i8W0bApv60uJboJTrIDlbZGuOi?=
 =?us-ascii?Q?TDhK/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fiovn/a55j9julNtGx/EPeV22JrVbhxwZL55vlLF66U9LQX4snHDInOgUgiN4MdW7MMXvgXwcHpRXCjaGDKxLuuSo1zp717RSi+I9M/5yVxJMrJSZLK6YzSVrqFFp4DZXvmTV3yHrgx9AiPhLyi4ze6Ua5cMRZ7FWPbcdwf4X//QCWaLUFa8QEQkkn/LQgCji+KrOmY6GtkEnUoTWJWYUIUkedZvWgs7GhJxKUXb8L7k9H8kXS3YWubJuGNt67/zI/Qs3rNIUKQ4esLaB587rUOQUOZQ4DIxZi2O75IpuLxwrooh4m6bDUkI90eh8vpSEA8tnEgmB/mawreBtWmYr6vJn9vl5TeXN6XHlK5XPv1AmhCFpiEfg+RRV9IXrYq/kC8mwUZUCZGlaYat6BAw5v68C+EyCiR1j6TewRhjM6j061h2NtWiqfFZ+vFjb0EW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:27.7604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05f547-cec8-4eb8-82dd-08de5fdb7fb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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

Add cwsr parameters to userqueue ioctl. User should pass the GPU virtual
address for save/restore buffer, and size allocated. They are supported
only for user compute queues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 ++++++++-----
 include/uapi/drm/amdgpu_drm.h              | 11 +++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 71a323ad1ac6..9d77f72c4773 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -349,17 +349,20 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
 							 fpriv->xcp_id);
 			cwsr_params.ctx_save_area_address =
-				userq_props->ctx_save_area_addr;
-			cwsr_params.cwsr_sz = userq_props->ctx_save_area_size;
-			userq_props->ctl_stack_size =
-				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
-
+				compute_mqd->ctx_save_area_va;
+			cwsr_params.cwsr_sz = compute_mqd->ctx_save_area_size;
 			r = amdgpu_userq_input_cwsr_params_validate(
 				queue, &cwsr_params);
 			if (r) {
 				kfree(compute_mqd);
 				goto free_mqd;
 			}
+			userq_props->ctx_save_area_addr =
+				compute_mqd->ctx_save_area_va;
+			userq_props->ctx_save_area_size =
+				compute_mqd->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
 		}
 
 		kfree(compute_mqd);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c178b8e0bd3f..41a155fe2c01 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -460,6 +460,17 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
 	 * to get the size.
 	 */
 	__u64   eop_va;
+	/**
+	 * @ctx_save_area_va: Virtual address of the GPU memory for save/restore buffer.
+	 * This must be from a separate GPU object, and use AMDGPU_INFO IOCTL
+	 * to get the size. This includes control stack, wave context and debugger memory.
+	 */
+	__u64 ctx_save_area_va;
+	/**
+	 * @ctx_save_area_size:  Total size (in bytes) allocated for save/restore buffer.
+	 * Use AMDGPU_INFO IOCTL to get the size.
+	 */
+	__u32 ctx_save_area_size;
 };
 
 /* userq signal/wait ioctl */
-- 
2.49.0

