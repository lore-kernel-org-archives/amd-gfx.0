Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE1C1061B2D
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8143210E83D;
	Tue, 31 Mar 2026 02:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jC25uKSa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A2B10E83D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMNm7KBIUVd7YSef7akpAE3w4OkDV7Y/ZRBcnpukXcXMJa37UfZcTlKVpqv7GxYAk5YENcHhYVmkDEwYSKWBErpbCDm2l67pYkjjvRvphg/FMr6rdmERqypWvCa+CMPIIUahKHeq/5XFcQsFG8RuV+9f6zGF3dAP++CD7zUG4VHMjHCljlhU3PNH/3NenasmWve0XA31Agbsx5HndjorqPaVKPvYO4M+ZU433kkrLdsIdLGFoNt2gdAkfM740K9FDNurFzx2P7fsHMpySnlPqw+AUJTKBdVi15bZUabXVWq39kHA0/ZslTZ8VKUNTDKOG7hv5+zZbcpraXDGHfFP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRwpjTBw6WapLXawjWED9GFER9LD5bvR0XFYig2XCTM=;
 b=jU5kzxSwYOhQM+4Fv4hEz37ogBrj2ZmYB2HGo3tOoE4E6G1o8f4K1iqGrgozxiQ0NkJLY8Ayv4/JNNsA3GBDY1lwupXIkCjbtB6AtsZUe8vAqoUw/wMg4C6atz6rHsTmkiWS5/XPC2mgmAWuWrrx2e6QqU5TzOpQT8t2i6z4JW92SllHwmXjnlorGM3wrKHpaTfPkLGd+K6uyIr7zy0jIl3G124iXIKskQcB04Lka5J5h5UCvRxjoXwKtp8AqMh3RheE3ICfuIfDz0ONcmg/1sBJ0GI6vpgoXiS0V4yuZ21rtgq36Fc7DYuVLiUV0za6YCCoGcJmZ/INIk1np/+V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRwpjTBw6WapLXawjWED9GFER9LD5bvR0XFYig2XCTM=;
 b=jC25uKSaBlNVyM8UHL0hQvl5h4/1agdMhzA+NFgEtEAIPrAOEmBVWsC+gagudNvuY9wVNBtH8/KIIOIIzxXxYx210D5LXaFL3wdA0CZ/MhkTBV8L2HiDjvrVz0+xjoYjh8hef8mbXtH7Vio6dfmPPqq2D0CO+1/vPGKzqY7ysRs=
Received: from SN6PR05CA0018.namprd05.prod.outlook.com (2603:10b6:805:de::31)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:59:15 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::f8) by SN6PR05CA0018.outlook.office365.com
 (2603:10b6:805:de::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 02:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 02:59:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 21:59:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: use the xarrary for managing the pasid
Date: Tue, 31 Mar 2026 10:59:03 +0800
Message-ID: <20260331025904.3387764-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: f62712a5-0153-4dee-baf1-08de8ed17e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: es2CFP+9Tmq+ixxcbtycAU/MG8rQJ0ysKmYh+YQdiYZh8OLgJuxsjNpkIcKn+4ou5Rj0IyQE3WS2b/IYtoB84OXnAzCxvmE8nY3nlaZAbqjLDHRYNzm1hYM7sITLJIC8wkcDnF8dIQxmESSMxDdTU83jB/h6/syTXPq1CpPKJI5ZTPz+yvY9JVtUuf0htWgRbRxX9yFr2R8WXacev5kahFhLsx//EVVQs3EveCmdAlf9B3gcZVTcfgPYKHXgeTJEeOsTL5fw1tL2dWNJjAycwDD8+fWQiU5H4E1ro+pKEZgDXr+H9+b7ybk4nFQiU3CMy00+kXo4cPl/wi09bhhqy7g55bDOcdWwjZDdJO+qBvOml5gw7U4xmN8qQapLzLf7SvNJDMNKCkHk2/ZHQh6hc+5PoV5V64r5tguTjELdkqUIV0BgpwUX/DeYBlzv1SssJqiBh0uvpBVYyl3Zo+Q6ID9bWGTJJj0JwJRGz1+w1/2dhJCAPl5aJkQAjOw57m9VZwkC23l4Lgu/u9n3YyrCIqKGSjHfKvGVetceAfYJM6NUfJC5rX3sfeiKPqjgSIMqT1LFFyeji1eTSi8X2vOfhZKB/kb0Nd0OPZ5nEXJoo0ZTKSd+qAVhYeAmNWGnJqK87j/ME7dR4pJv2hBAIms+zwLp2aSf5n29bCY/vVQ7Gi2p40bocXkBZPo6mLSTcBjNp1zVXxLVgZerT4Lw3lj8YUQvl8f8Fisk8eARmblNgAFPHw0+WG8t6Ct2gfsy5c5CUOLNd153G2Ck644j/ONwdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yUWUXUoNfg0QHZFHCT07TYVx7ZnNXls1xg1kJ2Bd8MNZx+zc9NUQvJG4bAwgBWVPq2qLNwCSu1lR3322llpqaZKQCh2qaKaIyv3kvmwb3xadhzJaoL4hSZW1POHaOTb+86394BZHXK3jUfHacERCZUKVT108Ku388+AI05Po8JgDMN0t2h+P65J2RADRtnt4w2wOYLLE4Vigjatcr3RXcdofn1h+Z0CFnIhRtJxthmUCnubB2h8rXUiZMqKBOQJt8nT81IkBEsxFb+Hkd5EuLD7x7ji/1azbKk6+5FsvZiEFmUuQj9I+/0VbrmAuptLtnRi6nFKXRYioS9Y1E2ZTiOHacSqUFlWV0i8EaDBPyZBjV0XwNf7lRH6YkKbASC7G+Vv7FfgqI7KG24RuQhndWxcEn4ivxSauhRGgHkMounQ1fbf+siW9WYsP9Yd5+LdC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:59:15.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62712a5-0153-4dee-baf1-08de8ed17e8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

Replace the IDR based allocator with XArray and XArray's
internal state machine can handle memory allocation correctly.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 49 +++++++++++--------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index e495a8fa13fd..7b0afeddbb05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -35,13 +35,12 @@
  * PASIDs are global address space identifiers that can be shared
  * between the GPU, an IOMMU and the driver. VMs on different devices
  * may use the same PASID if they share the same address
- * space. Therefore PASIDs are allocated using IDR cyclic allocator
- * (similar to kernel PID allocation) which naturally delays reuse.
- * VMs are looked up from the PASID per amdgpu_device.
+ * space. Therefore PASIDs are allocated using XArray cyclic allocation
+ * which naturally delays reuse. VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
+static u32 amdgpu_pasid_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -52,33 +51,31 @@ struct amdgpu_pasid_cb {
 /**
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
- *
- * Uses kernel's IDR cyclic allocator (same as PID allocation).
- * Allocates sequentially with automatic wrap-around.
- *
+
+ * Uses XArray cyclic allocator. Allocates sequentially with automatic
+ * wrap-around, delaying PASID reuse naturally.
+
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
  * memory allocation failure.
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	/* TODO: Need to replace the idr with an xarry, and then
-	 * handle the internal locking with ATOMIC safe paths.
-	 */
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_ATOMIC);
-	spin_unlock(&amdgpu_pasid_idr_lock);
-
-	if (pasid >= 0)
-		trace_amdgpu_pasid_allocated(pasid);
+	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, NULL,
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_next, GFP_KERNEL);
+	if (r < 0)
+		return r;
 
+	trace_amdgpu_pasid_allocated(pasid);
 	return pasid;
+
 }
 
 /**
@@ -89,9 +86,7 @@ void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -630,11 +625,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 /**
  * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
  *
- * Cleanup the IDR allocator.
+ * Cleanup the XArray allocator.
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
-- 
2.34.1

