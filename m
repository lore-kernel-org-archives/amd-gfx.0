Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314A4CAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D015A10EB58;
	Thu, 11 Sep 2025 14:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0bFvsdIz";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E405810EB58
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXrRAXhlz5A2mYx17JpdgJyAVWc5imEWIyReO0NHMHXj60dlfvd39oJJc79tFwt9HcYKsZO8/AYdG1PIHEQRHnBBcd+/uy3VjdAY/bQeHg+4aScDJoAU1gdfFQ646+6r4ADx8XhrpJv/PoRbSdwDR+zRKChRtWt74KXq3hcId1EsT1lryFeS9zSmFcvsOwS/ZdH0Ha/aA8a1vpFEt7WipmrL2KQIiHM04+olxJ3h83QDbuqdAkfG9j1GhtANl1ArhIxRCfBOMkTvG1jmDGYdwHWL+GJqakRc0Au9YcqiaObwZMVPLqaS/sIbEDAqmqSlZ2SnwSp01E+fuT/X4iUwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUbq5D25AKo95V54k3NfM0tBA3/7dKQ+rrW6Aiy8+fo=;
 b=vnBHLv7SXPVaOVinaUQaYhBErJj6l358eZ2gqjZGl79mtie2iMokn1nid0Up2PvRS9+KdhTWJOek+2xHcj7v02vkLmaxmmTlUyn2x6StJe+c2jJVg17Ct3p5B9S8uy0Kbbs8Bk0lLZYky6pVNjLc7IPXDfgl/z4yW1kZHvhKYqTeSD28xzIyBLddjtXIj5X30dxfsxWiBcspNT9zrC2G4Ww0s55NBmcVaiegURr63Lds2YM+gFSgw5OlGcy3QquY5VDlK/O/I9weIv1E/XPbQcd3f7i7Ehy92IjI74FK6A3i6E5HBxUYbsEy6dFbggPrmWhxUABvNBfwCkpWlOsrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUbq5D25AKo95V54k3NfM0tBA3/7dKQ+rrW6Aiy8+fo=;
 b=0bFvsdIzvkUqiG2+CtJpfh7UJjxCNoPIQf6hLIqmIsdokAAXRdC641xcd9xNx7kcZUIuEtbAyoafDHJAb4+JWlSzoDgZMl+0cmJT4WM6N2YNLunsjwxjZXUIHBcF/KhMuM3R0HXtE863ZC9wupa80FEy9rS2aXeN667hTV0+E3E=
Received: from SN7PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:f2::21)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:42:11 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::2f) by SN7PR04CA0016.outlook.office365.com
 (2603:10b6:806:f2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 14:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:42:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 07:42:01 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 3/4] drm/amdgpu/dma-buf: Pin MMIO_REMAP at export;
 unpin on release
Date: Thu, 11 Sep 2025 20:08:14 +0530
Message-ID: <20250911143815.825607-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ac48b4-02d9-4617-20ff-08ddf14163ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUdSNWJ1SytBTnlCWHYrNFFNNDRucEJxVlZVUjZHdFRXcUxJWUFjZUh4b1hY?=
 =?utf-8?B?MzIrSmIrOXFJKzArNVRDd2wvSlJCNEhUMllHZkY3MjR1KzhDOXUxNjEyZGZQ?=
 =?utf-8?B?MWNUdmNrRW1sWkRlN2hmdUZNRG44VVZQVmcvYnBSMDVvYkc5M1Q0RGQxNnla?=
 =?utf-8?B?cmlEQVJLTzVDM2o5TUxWUTdnSjU0QklmMUJEdGpyS0d1cS91WjQ0MVlIU3dO?=
 =?utf-8?B?RFhpVlJCS2c0UVJTNGFISU40bC82YUgxVC8vZE5rWE5PT0o4Ykd3bzdWc2F6?=
 =?utf-8?B?K1V6Z0c2OGR3Y1NTYytvZGMrY1VhUWdLc0lWUnlHd1Y4UUZPdGd0QjhkbEx1?=
 =?utf-8?B?WDd3N2xhUXVoRVhoUG1XVEpMNTJqUFNaL05PYjlxRnJ6YUNrS2swR2d6Mjdp?=
 =?utf-8?B?cEtWMDZjQTMxd3VMMitYemNweUdnQTBES3BDSm0vQ0o2M0g4ODgwK1VSUGJv?=
 =?utf-8?B?anVIOGJJZDdEQUd6NWtjYko5QnMzenZnMm5MZlhmMWhlK2o4eStQWWxyRkww?=
 =?utf-8?B?OURucUV2ZXBLc0E4NnZDc1hEa1hKSWhJdEhOdHR0K1RqUnMwcExkQXpTdzVD?=
 =?utf-8?B?TnlYQVd2akF1ZjA3S0tmbGptRGZQVU15bXg2a3p1UFhyTDd6d2owcWtHRWgw?=
 =?utf-8?B?MWZoQjVoNmVrV0xRNUtIL2tLckc2a3N0UGFWT2ZZYnZUazdRWnBXZFg5aVR2?=
 =?utf-8?B?dWNqck1jL3JTYVNtYXFGNHV3UHU5bm1oNzRGc2NWeHBKMDYrYzF4Q2ZGbjFS?=
 =?utf-8?B?NTdwZlpmait1UzBGRWpsZEhRUk5hakxLYlN2TTRZeWtzVDhWQTdWMis2RnRT?=
 =?utf-8?B?L0xzMnlIK2V1aDdiYWlBbFhReTRlZkZMTDdsakNENWFkdWNZQU0xREFWT3l0?=
 =?utf-8?B?QWNwTVJDSjltSXJMUUdzMzRzMGp0bU9xeXRoeit5OXpWOTR1dk1BOUV3cjRW?=
 =?utf-8?B?TXZLS045YnVVSnJZL3R0OENXL2lIQXMzQkZ5U0dTdzZTbmdxbzJ0eHhGeU5C?=
 =?utf-8?B?YlBWWURxUW9lNks3dGMzNEdnc0pucWd1WHRaZHFVUitOWFdaSXllWElsUFJy?=
 =?utf-8?B?RE9rb2hkNitIc3lKVnVHbHBWSlFkZWJuVklENHJKUE1LYzVNUXd0bXBSWURQ?=
 =?utf-8?B?ZWlyT3EzQkJXK0ZSREVtMi95MDl5ZFRkY0hFRjZMV2twSGNoQjJCV0xxVGR3?=
 =?utf-8?B?ZDRNZUxwY2NLb2tKbkx5TXQzMzlSNmprcTZmbVg3bVZydXAzMDJ2OTN5SHlq?=
 =?utf-8?B?aWVZRSs2Z1BSMjNlclJONkN4WXhpcTJMUEk0M0dTWUo4VERNWVIyc2ZHcE1B?=
 =?utf-8?B?YWtBUzBvd0xYaDZSQnJVZFZpZjAraXVYR2o1ZzRWblVWVGNrNGpFdFRHcVVv?=
 =?utf-8?B?RWcyeWRzcFUyN2V2T3MvTm0rSFJZUE5MdlpYbzhXdGJHc0o2S2VoWVA3RnM5?=
 =?utf-8?B?djk3OXMxQjVmVmRkYmQwME9SUGhpTzI5dC92NzRVUXdoalBJeVdTQnNhenNW?=
 =?utf-8?B?a0ljdUV4dnMzZFVaR0ppdmlIUXJ6UHJXb2ZjcHV3YWpJZlg0VUozcG1LZ21C?=
 =?utf-8?B?R2IwZGZkVmxiQk9sMEk5eGdvbGdWVXNTWUswT295M1Z3Yys3azkwKzJnN3p2?=
 =?utf-8?B?cVA5THQraXp4TDRSVmhQanhXTDFYT2NzSXNEVVpXWnpwZkxQQ0lKa2EvR0xm?=
 =?utf-8?B?WFNYbHV5NUg3czdKZWhVYW1hWlRBZkhYTXVWOVkvQnJVUUNCeFlIQmo4dEI1?=
 =?utf-8?B?U2NIa2dtdzZlc0huclRTSURtRUxLN0s2c3k0ODROdklFN1ExQmlSQWdhY2tS?=
 =?utf-8?B?TFZFR1N0UVZvWnRmWWlYRG54NE9tOURZR3lZWjl1eEdtaVlyakZyZHBKTDBq?=
 =?utf-8?B?N1U1a21TZlJ5L3JES3JqK0E3V3dEdzZYQTUxMExwUENBOS9YNmRXTDQ1aVpl?=
 =?utf-8?B?TlBzcEFRVXltTTJqMjhQcXJrMGdYUUlzdlgwYkNSSnd6RkJDMm9sOXd4dXln?=
 =?utf-8?B?ekxsZnlrUHVTTzM1bGZyMDlPRkVyTVR3ZkNnMGZXQjBoL2dOQ1FDRy9pYVZE?=
 =?utf-8?Q?8L2gRU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:42:10.4199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ac48b4-02d9-4617-20ff-08ddf14163ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005
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

This keeps MMIO_REMAP fixed for its whole lifetime.
Other buffers (VRAM/GTT) are unchanged.

This change pins it when we export the dma-buf.
If the export fails, we undo the pin.
When the dma-buf is released, we unpin it.

MMIO_REMAP (HDP flush page) is a hardware I/O window, not normal RAM.
It should never be moved

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 36 +++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index f85e16be438f..31d78561ab95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -47,6 +47,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
+static void amdgpu_dmabuf_release(struct dma_buf *dmabuf);
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
 /**
@@ -377,13 +378,27 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
 	.unmap_dma_buf = amdgpu_dma_buf_unmap,
-	.release = drm_gem_dmabuf_release,
+	.release = amdgpu_dmabuf_release,
 	.begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
 
+/* Drop the export-time pin for MMIO_REMAP when the dma-buf is finally released. */
+static void amdgpu_dmabuf_release(struct dma_buf *dmabuf)
+{
+	struct drm_gem_object *gobj = dmabuf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+
+	if (bo && bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+		amdgpu_bo_unpin(bo);
+
+	drm_gem_dmabuf_release(dmabuf);
+}
+
+
 /**
  * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
  * @gobj: GEM BO
@@ -399,15 +414,30 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
 	struct dma_buf *buf;
+	int r;
 
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
 	    bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
 		return ERR_PTR(-EPERM);
 
+	/* MMIO_REMAP: opt-in + pin at export so later paths never migrate it */
+	if (bo->tbo.resource &&
+	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
+		r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+		if (r)
+			return ERR_PTR(r);
+	}
+
 	buf = drm_gem_prime_export(gobj, flags);
-	if (!IS_ERR(buf))
-		buf->ops = &amdgpu_dmabuf_ops;
+	if (IS_ERR(buf)) {
+		/* if export failed, drop the pin we took */
+		if (bo->tbo.resource &&
+		    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
+			amdgpu_bo_unpin(bo);
+		return buf;
+	}
 
+	buf->ops = &amdgpu_dmabuf_ops;
 	return buf;
 }
 
-- 
2.34.1

