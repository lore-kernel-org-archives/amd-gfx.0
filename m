Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEB2D49C7D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 08:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0512C10E97E;
	Fri, 30 Jan 2026 08:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Plnh7DP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA5210E97E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 08:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urJjKqWZIZ/H/SkALxn/Dl9+gIGTAe15q9CztOdJWcRalV2xtpJvij5dvrqyV/YCarLS2B32eTv584sgq8MbNMP/Vt3baRXHwlWm6mpLrsxPCbQYSH32FbIQOdUNwZymr/LET2Tfwz7sHziAccBCTYCriRr1phEQ9/NFgIfA432SsiDChlHHbOa/0F/kejx1WnoOtQnVNlduJgpfzk8CSoRVwNSLcEF5wkcrPJWOvJiM/7YmrkKdRbWmFe5m67qK3lm8EsWHWBiqWeltZWC1Nh8rDWZyBw4VbnV0CJPLCGICk9MiCP2Tnw+Xny3R/44CP1n8nMp5sONTUdgdFqin/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvRXQCmw74zdZ8s1V2xMNTmgQ4gBVKvyexKYQmE6p/s=;
 b=IMgBMu6rTc84pb+CXMxEBV8iWmJSslBQpP/4PIXQM3YA3SNMxfryB8G+LYOjj8WA4AarcWnjB7OI6SU0NqlMyd0bdJus9CgDT0g0go7Cu96t8fzTc4TKYdnBOyUls8xDNER2o1qjvg4rXGtMhl+qN8SW8DfUgcBdJDlkyHrXq0PBcaPjXnlHOCs9AQx+o0g652cGCX2I9fKOuJANmH4E/38uETQ1gOC18GM6hFrWi0iPRm/2K0Dn2yrqsrzBpIB2FctY8oqDdJmL3Usj+jOlujcqbmClO66JQ0XWf82WgcQLIWCLDbf4GiV9u50ii/JSZ8zhboJU5x8PnYxJiRNwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvRXQCmw74zdZ8s1V2xMNTmgQ4gBVKvyexKYQmE6p/s=;
 b=2Plnh7DPIWt1sEp2wMu/xoR7Yt8QE1DVpLzowSlG5gJCsa7qI1VMtoDC9VxkHVQCiBoLMf+/1k1xJyAskeHKIoZmvBcctANHudytWV8x6++ms2iF4ECi4ftxOetWbQMWIcYjGlncyBFzI4M9B64/j8F+lCmGhgaaRw6sGy+VqMo=
Received: from SJ0PR03CA0128.namprd03.prod.outlook.com (2603:10b6:a03:33c::13)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 08:42:26 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a6) by SJ0PR03CA0128.outlook.office365.com
 (2603:10b6:a03:33c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Fri,
 30 Jan 2026 08:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 08:42:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 02:42:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <David.YatSin@amd.com>, <Lancelot.Six@amd.com>,
 <jonathan.kim@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v5 08/11] drm/amdgpu: Add ioctl to get cwsr details
Date: Fri, 30 Jan 2026 14:08:02 +0530
Message-ID: <20260130084137.2906792-9-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 044807ee-a604-4776-dff3-08de5fdb7ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sY5n47OKd8ce6r7lVSQICrJ9PFRS+DcHn6nPPEbHcpTiIXETgqp10Z7loIPb?=
 =?us-ascii?Q?Z27AH8pTyUUubFiU17cd69Vo1qCC8JQyVELh4rzFU5XYSljy1fN9oujsFywp?=
 =?us-ascii?Q?2Vyj+C3IqVhQlozI87ada9ELcKHfhyNJ+hIZWHO/7sfJ8O7F9+WjBXtWZ6cB?=
 =?us-ascii?Q?dgJ9tx1bqSufCwhxM8/d3+PFXAr75HHNrz0PZw9NvTspig9MUl+iU7HWPFMW?=
 =?us-ascii?Q?vY20hg9QBc2HzILUBhutuNm7KlsJV9h0aCWYNQRlF9u68QWrPPRBk8dyCI06?=
 =?us-ascii?Q?BhcX5d2uH4nQp2xvcoiofC+IjZksF71v6yu5L/56/L0ZHQ70t2QIvf1+tJqD?=
 =?us-ascii?Q?FY4pIMf1JiPVAuhaK+lwJGoOnTsFSKvcYPui0Qun77dVZtK8y9ykAAR1y6GC?=
 =?us-ascii?Q?/sPCE8A3s1yGpbE1nr8S+OCbvMGAwrYKKmCiUCvgRXWhHsOZnQff+NjweRbi?=
 =?us-ascii?Q?d2uDAhnjtK9snBh9bant4KG0vtmyl/zLhZTyqEMlIRCy31HBE5Ukqq9uoTey?=
 =?us-ascii?Q?R9V/6Mhzh1axJYu9XmPliN6MDMvirr15TQh6vc6atMBVRNdGOBKr8JaFOH5X?=
 =?us-ascii?Q?9gfZ0XgGXzCTjLHsyfB62DGJZe4dXspxeu8xmd3+pwSgZmy9VVkQc/pUvtWE?=
 =?us-ascii?Q?IQkP3G3OnP5dr2Iosyq15C7gdtjaNDXhEcav87564o+1cOz/Farhmzd+BU+u?=
 =?us-ascii?Q?mnByZGYClgp+wY6arde+EX4BOt3ViBjO4m8UBKbUyS43A8OGLgGWwby5/xjW?=
 =?us-ascii?Q?WcUix7dJBvx7Lf/hcVeDm+YCUKBqCOoJ4FY1B6gSuI8BMePVGfwMQGfzcmG0?=
 =?us-ascii?Q?D6aCIoslCv/h0XxbmN/ZuxQ7l1okFSH/GzdRyM0OYrAJhlje++63uzmYY/P7?=
 =?us-ascii?Q?x+dGIJmrge9Pz4Ewjk56YBQxj3Jbd3048EAMf1uT89lxuYcHkJMcYsfYNsnG?=
 =?us-ascii?Q?r1oxfO/XCAltMYxDfPeiETr0YizNvUhAmKJzVTAc+BC7U110zheHIhUf3jIT?=
 =?us-ascii?Q?vvq0gZ2JhX4LeLbkLqbCHhl3rfirHGML9D6vU0bQYRMbbs17TGtZz2L28fcG?=
 =?us-ascii?Q?xScu2+q29hOlc6SqPVtRlYKRyS2ohczjfyTM8yxEqjYqRCEtsP+CaDsAN2vE?=
 =?us-ascii?Q?QAcdYbR96veWO2GD0xWk1iSWJqSE+1uJe0sF1wJtmv28Nlp7VvKh4/SW2ONG?=
 =?us-ascii?Q?gMr6TrZ8AHKu1sn4YXaD0F+aL7oMktmA02QhxgUiVHwddA/KDoUFTQoCdZUN?=
 =?us-ascii?Q?mIklh7CmdC7MsbV4MfPnE6U8puGb00kM8GnB/45MUUF9u5rsJ3ToVm2UUkCU?=
 =?us-ascii?Q?9Sou/QZmz5zkrrG489Xp6r8JUPmCvfT38x1SuEsgDnXEgF3nhwscoVT0Im/b?=
 =?us-ascii?Q?zXAi+3BrO2eV2OwnhVaNIk1rFuUbUut5NtZxJdZ9qHl47fuZhiQkOVSPPBYm?=
 =?us-ascii?Q?a7kHEpmSUUhtJi9wk+DeUfeqIMYm7dLSYv0fj+KEjtvy1Ix7fwetTmqQKToI?=
 =?us-ascii?Q?LDdgdu60lEy8ojDt5dpT8GKZXbf0kCUJvkGKmiT5QCZsoBG6kkS/2DASVGsM?=
 =?us-ascii?Q?dzBV5Rm+KtR7BJh/45j0o8r9y6L21NprEjGouLgvr/BB8uqcjkjOjqaA1VPY?=
 =?us-ascii?Q?EZJ33pxzHWXy6A5Y9FXjYNqhnk7fO1/cO5iFFKhW/w4VCNje0XAWqSfxiyxS?=
 =?us-ascii?Q?Oulapw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P/3zTwasJUF2gxeoUQQXqgWeSe1ZS6kNwyycpxZ+zcXgizpRnLHPgqYL0UKOBZxWr+whF3Me9xwleGFAGDJQyB5PNNzk9yQps11Mgxpf2AjKzt54GEDGv69lYOMbT8c0dXVpLXIrfS7xYEfOP8Pc5ZHNRlcdnKVIjqiVgykaE4oVlY6afcdyLaPlp5Sp5T1W2Z2w/3Z3gYDlxt6MQm8jt+pq0UlpBH0RnGjghDPAYh4s2TeD3adHE4N0edhaqB3XrTzA/V8EDUR35ITYwwFx321tDOvkmX1KiXkGtfz+QNx/7MeCfEgt01LmF70u+Dy1xmFHUulXVOxKQTjtjvG0XGDMFbzyMMX4BXIaJ+flqhcFHMkU6GEZlmKcI1HQVFZk93rsvCW0rZMce7rkvMCSKLH5WdxqTXztxIYyr6ZCRcf1raVQfXB/jF6TlGqlJRth
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 08:42:25.8864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044807ee-a604-4776-dff3-08de5fdb7ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

Add an ioctl to return size information required for CWSR regions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 21 +++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fed15a922346..945c89fde616 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1426,6 +1426,27 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			return -EINVAL;
 		}
 	}
+	case AMDGPU_INFO_CWSR: {
+		struct drm_amdgpu_info_cwsr cwsr_info;
+		int num_xcc, r;
+
+		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
+		if (!amdgpu_cwsr_is_enabled(adev) || !fpriv->cwsr_trap)
+			return -EOPNOTSUPP;
+		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		cwsr_info.ctl_stack_size =
+			adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+		cwsr_info.dbg_mem_size =
+			adev->cwsr_info->xcc_dbg_mem_sz * num_xcc;
+		cwsr_info.min_save_area_size =
+			amdgpu_cwsr_size_needed(adev, num_xcc);
+		r = copy_to_user(out, &cwsr_info,
+				 min((size_t)size, sizeof(cwsr_info))) ?
+			    -EFAULT :
+			    0;
+		return r;
+	}
+
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ab2bf47553e1..c178b8e0bd3f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1269,6 +1269,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
 #define AMDGPU_INFO_GPUVM_FAULT			0x23
 /* query FW object size and alignment */
 #define AMDGPU_INFO_UQ_FW_AREAS			0x24
+/* query CWSR size and alignment */
+#define AMDGPU_INFO_CWSR			0x25
 
 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
@@ -1648,6 +1650,20 @@ struct drm_amdgpu_info_uq_metadata {
 	};
 };
 
+/**
+ * struct drm_amdgpu_info_cwsr - cwsr information
+ *
+ * Gives cwsr related size details. User needs to allocate buffer based on this.
+ */
+struct drm_amdgpu_info_cwsr {
+	/* Control stack size */
+	__u32 ctl_stack_size;
+	/* Debug memory area size */
+	__u32 dbg_mem_size;
+	/* Minimum save area size required */
+	__u32 min_save_area_size;
+};
+
 /*
  * Supported GPU families
  */
-- 
2.49.0

