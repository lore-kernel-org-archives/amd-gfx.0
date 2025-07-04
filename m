Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E426BC8303D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8691A10E9F6;
	Fri,  4 Jul 2025 10:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQ1W45Ss";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D8910E9F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9M/8/t8kn4nYsUsmLbuV0e5+4lgvcFEEm3ogCMWHSethy9aWcoT/rOgO3zkqkDlaiWV/k3uJKbOmsW548flaXm6oE/C829jgBmnGcxrAOX6UO/M9oOoZOUU1In2+cPhn7eEqyZSSJgGIIRWS3TUYgOBnEZzBs1Dt/FfT/a7yUZUsfblRZRKGN4LmZ2WkQ9ClQ+qf7qEHks6cF507Wyv9ML2/fBY0cGvwZ8QebjGJEQV2+n0CVbZiahnSHI8slNz1Go49SGRwOJ5svyJkEd/kP03AQ79VD8UZfDYKF2QbmXj96iD3yv+vfQNX0w6eZORAcz5buipNH0wTPA4HnOw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndIYEQpPgBH/rCG+9Oq2dCFAi4HQ4PJIwDFOjhAXLYc=;
 b=vwfidBRI5vfUOd2FW06vEYDvNtzl/xq6wfffDl0lGay9SOCWNzdbfAla+iiUq/mEZR+S13zaFDsEIijDUPvk9tZO0eX1Bny0k1s39X0+P38mb/dsVLpkJVDB4rcrkoJ+ySkh9u4wukxa/Thm5PMgX3Y+5Sd3zm7l5iKJvUx11RIRUpr2iT+WPy57Yy3ASYjNQ1SZW1VFbztqLNQ37a+M8awwvj1MCN7gOUX6GjhIvte9LTLJ2lffeILmDi9UpUeeTNc6EXjz4DsyHSZJPRJ4wDLJmwfflx5UMLmaFdNcueK3bs7u8QWsvujsCXn4TNFJKr2cpJXTgAONXkUsSgnfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndIYEQpPgBH/rCG+9Oq2dCFAi4HQ4PJIwDFOjhAXLYc=;
 b=RQ1W45SsPaLt7haVMSo7Oxu00nC/bsk6EIDHDQlTRWEdlUi3ZWAObl4GUj3U2dzLtJ4O4EmEfTPI1KQux2XIfoClxU6QVlGuqMRpSFAgY/Fe2iKjJtL2MrE4H9Uu4Szv3dQJDx74f2qOglehbM/BkykcklWKP5nR2wiswW+q14k=
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Fri, 4 Jul
 2025 10:33:31 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::90) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.16 via Frontend Transport; Fri,
 4 Jul 2025 10:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:30 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:28 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 7/9] drm/amdgpu: add userq va unmap validated helper
Date: Fri, 4 Jul 2025 18:33:06 +0800
Message-ID: <20250704103308.1325059-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb675d9-c7ba-409e-5df8-08ddbae6382a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lyBvURKrU5MDD89rpM+Juk68bjzqg7BRiVtU6zxc2QFTjLGZTQeytiQ+kcCW?=
 =?us-ascii?Q?3qQJrwkpwRiMzyRAmcOetLGxKSl8f59KxxAEl+IMnma6psSswHaWj2l8d/KZ?=
 =?us-ascii?Q?dqJglRyGE0RggnFC0YytKPsLwR7wzp0DHa8xsMOJGGf2AnQWTuqYCVxZR/uk?=
 =?us-ascii?Q?XESAd4A47dJkxXFyW1u9mHVJ/OXn0T0x2Aw7nO/zb4oI4My3ha3mKdCoV6s0?=
 =?us-ascii?Q?yOFL2RkZh9rFLIBYVW7pz8URuXY2htPcJeEcBmgwccDFpZN6BNE4iA+L/o8k?=
 =?us-ascii?Q?lgchZO7UX4MDiiIE179MOLbuPKCI+dFAAREAQClHBmmmJxP078R/j8uK0Sju?=
 =?us-ascii?Q?pBQb+rjkPKsYlPeYSx0nxKfqPIpNO0CmOdmuXmyOCB8JGirfSqu/c/2gY/nN?=
 =?us-ascii?Q?1CFWan+wk0VguNmQ/YboKUbxdwn1PlZL3iAB6JwfBB9hPjMEuYDDaThfGDqg?=
 =?us-ascii?Q?lHBHtntiz8EnP2jFBnsrKMHr9idK3NChtvSW/cQbt/xBKsCD57HQuVr9JZn9?=
 =?us-ascii?Q?7wwHTEDp7NVC81NnDWK6pLGsa3t3/4dJ4P2XOfjmrqewgCfFONvpQLq3Sik+?=
 =?us-ascii?Q?S89jFEEdQOrkaSmL08XpkN0mK7d/JtglONQWFXdH9wEkoCP0J589WGpmkJXe?=
 =?us-ascii?Q?Mbm+aOCtVlgxOCd2tiPG6V0IyI7W7UoB97xILAybMoYg1qnjM5VTbHXL75bn?=
 =?us-ascii?Q?DX6QYSWMKro/yuL52yx1xURZ6bR4q9jAQG7TBrSSBR5hah4PhvXwd/r/QcHD?=
 =?us-ascii?Q?/5V2PSCziEGa7H3xfR+nBkARZgKVFtadpWwm5kTYsk7S5ZebFNYqxvlz9KF+?=
 =?us-ascii?Q?E0eq/suzUpBu5MtuJgXBKKZVyEo+d+lRu1t85836C9nFrt094mysGHg58TKu?=
 =?us-ascii?Q?YA3HB8tWsbbqorfGdSy0hPtcePzuCNAXQD+Bf5RCs6S8n+rlnL4uRBUlvGwA?=
 =?us-ascii?Q?e0aXhX6A5ZsgVnhTzT3CWGGi/1naLGZAbyohaDsmdW9LTSPjZ7nog0a3Cnb3?=
 =?us-ascii?Q?oCMs+BFdU3SOpJ9sUPAUfuaZSHKyM5tva1L++5F5bXCGISwBtNS5GnZ8Gs3I?=
 =?us-ascii?Q?DDqMAZkNxUAI+5GF/7vhlN0Nl87kpm+b3PEKYzErTp4efmR0zpo0INIgSzNt?=
 =?us-ascii?Q?kBsHEJizpz5MpCmfwNx2DfFr2GrsKy8hacGMS9FfzYzUI7RySGO2y05FXbVl?=
 =?us-ascii?Q?h9t2Yd4iGySKjCnEqNmtcWHOebU0QJwo0Tb2TpJhMUCGTzdxgGDtlj7iTBGN?=
 =?us-ascii?Q?vgBnHWdc1dACf483eos37zzZoDcQiTQhW716Sq3UKJFc+b+9GPHtjEmdP6+X?=
 =?us-ascii?Q?k4FJ96//UvU9+Ef1i1mlj+SYd1jnwKJIAoVGuJXLVAjEu907Kj9n7zLnMhUy?=
 =?us-ascii?Q?TIU2hQxzJmSnxCLnsjh0++IQz2d0ysmjafZleJmdmyiNc+0K5SI1ZHdEJG//?=
 =?us-ascii?Q?35RoWRgnqXClrEC6YwC2Fe8T8BUS1eceLr4DgQndAVj2zmFRdB8UhtMqXjCf?=
 =?us-ascii?Q?QkW+HOV7N0h7k2uzxcAtywTa4XBNHd67yEsI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:30.2683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb675d9-c7ba-409e-5df8-08ddbae6382a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

This helper can validate the userq whether can be
unmapped prior to the userq VA GEM unmap.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 78 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 25a35ab7395b..30838e5279bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1180,3 +1180,81 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+							uint64_t va)
+{
+	va = va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;
+
+	switch (queue->queue_type) {
+	case AMDGPU_HW_IP_GFX:
+		if (queue->queue_va == va ||
+		    queue->wptr_va  == va ||
+		    queue->rptr_va  == va ||
+		    queue->shadow_va == va ||
+		    queue->csa_va  == va)
+			return true;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		  if (queue->queue_va == va ||
+		      queue->wptr_va == va ||
+		      queue->rptr_va  == va ||
+		      queue->eop_va  == va)
+			return true;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		if (queue->queue_va == va ||
+		    queue->wptr_va == va ||
+		    queue->rptr_va == va ||
+		    queue->csa_va == va)
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va)
+{
+	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+
+	if (&fpriv->vm == vm) {
+		struct amdgpu_usermode_queue *queue;
+		int queue_id, r = 0;
+
+		if (mutex_trylock(&uq_mgr->userq_mutex)) {
+			/* If here the userq bo is busy and needs to deactivate and prevent reusing it.*/
+			idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+				struct dma_fence *f = queue->last_fence;
+
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uq_mgr->adev->dev, "queue(id:%d) not belond to vm:%p\n",
+						queue_id,vm);
+					continue;
+				}
+
+				if (f && !dma_fence_is_signaled(f)) {
+
+					dev_warn(uq_mgr->adev->dev, "try to unmap the busy queue(id:%d):%p under vm:%p\n",
+						queue_id, queue, vm);
+					/* Need to set a resonable state for avoiding reusing this queue*/
+					queue->state = AMDGPU_USERQ_STATE_HUNG;
+					r++;
+				}
+			}
+			mutex_unlock(&uq_mgr->userq_mutex);
+			return r;
+		} else {
+			/* do we need a try lock again before return*/
+			return -EBUSY;
+		}
+
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 194ec7a6b3b2..08c49d738ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,7 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -148,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va);
 #endif
-- 
2.34.1

