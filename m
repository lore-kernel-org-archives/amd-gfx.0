Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6802EC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE98D10E4C1;
	Mon, 21 Sep 2026 20:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yICiaBhs";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5062910E4D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIwgNaHBBbOVHcmEVxxLzAN48DQ0TSlYI84eUZfSrJSi3E6LaxEu5dN8EcgDwWvI/9M+scVXzFCaGWTJBwbZ/RkKues6nooqz46Yk5yyUMZCSmdNikSw9ut23sX3ihQZ5+Z3jmrqhRFtLUfsdFdmlVNjjTk+yPK9sw2AFvIuWToebXvRP5yGoKFGDtOeWWggNzdP0MOuSb9EZdm3WxjrKhXo2WYnxZOyAq7i2ZurUQV89xW51sxIk80o2SM8J8as/NH4l2cJGQqSN1U49gvKt7ndRpOnT0Zqmp0djR4573IQZ2h3GahepKAxGmIE76OCwnAZb443VAIcfIajPmjivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FEcXgpBYMcZe1X+jIAvEd1mPQMaYAc3YfEkZC2mtMw=;
 b=Lo05ZruZCPXqa/UPPnbp2mb4yh5YwrpRkEM/5BZkY/1PKezj3PNSUgnqeuQXq/IYTrBO1NSdkbzwlP9ps8yEDcNgohdiL0hGBqTMQADJdReokJ4HwFvOKWSzf3xYALpDJ8boR6sYScENT/46/IgEswmoMrTznEMin6YP+yPy1O4LIdBKySlUYp70r3kVMriKx6yhnu4iVHA8HUxl9MOxo4nVxXuNEpX+5UnGZ5bdBWNXrXC2so9NzYlgyu2EUkMGRe+fjoWH7rmMIZgo3Tk1KECElTB/uNWVEFLLVDXt0x4c1C08Q4EErXmBJuXHyg+GNe+CQmXbqrpARkC/rawYZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FEcXgpBYMcZe1X+jIAvEd1mPQMaYAc3YfEkZC2mtMw=;
 b=yICiaBhsQ19Hq5YdSIgqdBB3KaiUDmIwBMLffrefdNu+51Z+Pa5IbZGT8jyR7MP6tVBDOiUx0DmQUkgcEk1a1tTMCWZXuHwEHYlyOR7mPC1ey9RKnkIdPNt1igQYNr/BHv83M5qG0WoKXBDqcTQ/okI2O3Q8CPCTKU8Z+Z+P80M=
Received: from CP5P284CA0022.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:94::9) by
 LVUPR12MB999137.namprd12.prod.outlook.com (2603:10b6:408:39e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:03:22 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10d6:103:94:cafe::92) by CP5P284CA0022.outlook.office365.com
 (2603:10d6:103:94::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:03:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 20:03:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:21 -0500
Received: from work-495456.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:03:20 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>
CC: <jamesz@amd.com>, Bing Ma <bing.ma@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: add amdgpu_xcp_get_xcc_mask helper
Date: Mon, 21 Sep 2026 16:03:05 -0400
Message-ID: <20260921200313.865829-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|LVUPR12MB999137:EE_
X-MS-Office365-Filtering-Correlation-Id: bf88866d-4534-4780-2903-08df181b6335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JBB+y6h8a+yO4zF6Q10PfyRbgEqrFnnd9v8UHO0XeyagOAjEgYS7axa+OW1JDyZKMDJKNHtEveunkH/L/7TOhjEYzjo/F13xVA0Jk3Wuxi/Fb/ddqISLn9dfQSQPUx1yx7mKvJf14JuC9kUK4bXHIF/gkAmY5YrDQtFB5wkRLQzjjT6p+Icbh1aSck2GuZzomBXOYx2XNAWljQrqz4E4LmUTgrl1W6Ht88JmRgl0uCNSeXBJvHRjzVuAlO2qLk+RA7iQkl2xOPC6akaZomKTyYZqZtrKrzsnYQ0srKpSCw4KZnpzwspWLGNiBZuc7BZB13aiHeSdym6DFZ1TX+2Uvvct53wGNDpCTc/Ob9b61EhPb2tjRw+fYlUDmr2bii41UtJ1uyrUwy5oLvdb1z/T2pZVY9KCEiGnu1/okhTM2gM8BiDFkAVygtZdsBkkHh8WZkBDVNxip/lu2bgHtiB+5FKFQpUTViBiFw74No6swbEvncyYyCcvvp5lu+ohuh1HbQZIHd371ceKVAvC1Il0DT3DobIWjMn1+5JWZEKx1L3d4qVM240dPgHaB+6hd0bmUrHRe8kLzt3tmaNE5D8vYzH7VAMgIcoEq0lwEFVZtaBW4ii1Sz4T1kbFzJrpL3i+4ma6xKiirIxhCCOhXnmNs55q7b4PHc99HNoXF4865CIxywGmoTZKELyb5mDclo0CHLM2+YJ56gpyx3cZzTrW6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KuNC0ahNNbaI96XfsonGuXsBksbz4baJz0rtcAq0V8PoFRUhaAVorcFPbnevvnRztGHx25wL7kJKd5gjARfuDmOz1jF+PW/z63LEIzGEJPSo4Jz3BIzuNgfDwBpJ+9KEOzmKDMFWerjo4YISpuCvwL2PZvwPa9w6bhhQh1IQAPND4Ik8K41PS2Z92XF8t8C9t4rXdNPviExA9KR3XNyrN2I0Q7zfkF69tuuv6CR2nkNIJ9fSlynOtD/ewI+yAnwF/3oA4y/c+UT9gzdioa3GgHBDFe8PyKBzCDvVfIsjuKe9kRZW6VmegbotqEikPEPj+NOukRdDpq0iMWFWf9S+CgKLxQFHpyEG4xWQiIlDLHpKj7PsGM0JVG17uSgGdHytak0D+OB5xGd30rCGajW6kC+Cdw+PO6qtJtZ+II0KqH7ChvAimb6XiIVhjJdDf5MT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:03:21.7079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf88866d-4534-4780-2903-08df181b6335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999137
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

Add amdgpu_xcp_get_xcc_mask() to return the XCC instance mask for a given
XCP partition. This is needed by upcoming SPM (Stream Performance Monitor)
support, which programs hardware per partition and must operate only on
the XCCs that belong to a given XCP.

For partitioned systems the helper returns only the XCCs belonging to the
specified XCP. When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is
not partitioned) it returns the device's full XCC mask (e.g. 0xFF for an
8-XCC device). Note that the full device mask is returned even on a
partitioned device; callers that require partition isolation (e.g. SPM)
must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.

amdgpu_xcp_get_num_xcc() is reworked to take (adev, xcp_id) and derive the
count from this helper via hweight32(). The helper is defined out of line
in amdgpu_xcp.c so that the static inline in amdgpu_xcp.h never has to
dereference the (incomplete) struct amdgpu_device; it only passes the
pointer through.

This is a user-visible change: amdgpu_xcp_get_num_xcc() previously
returned 1 for non-partitioned systems (and for AMDGPU_XCP_NO_PARTITION),
and now returns the actual XCC count (e.g. 8 for an 8-XCC device). CWSR
callers (amdgpu_kms.c, amdgpu_userq.c, mes_userqueue.c) scale the per-XCC
control-stack and debug-memory sizes by num_xcc, so the uAPI-visible
ctl_stack_size and dbg_mem_size values grow accordingly to match the
actual hardware resource requirements, which were previously undersized.

Fixes: 4cd417bfec49 ("drm/amdgpu: Add helper function to get xcc count")
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <bing.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 48 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 32 +++++++--------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 +-
 5 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 57fa69c0382d..7782ccd4d28f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1501,7 +1501,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
 		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
 			return -EOPNOTSUPP;
-		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+		num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
 			adev->trap_info->cwsr.xcc_ctl_stack_sz * num_xcc;
 		cwsr_info.dbg_mem_size =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..d19af9cb6ee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -258,7 +258,7 @@ int amdgpu_userq_input_trap_params_validate(struct amdgpu_usermode_queue *queue,
 	int num_xcc;
 	int r;
 
-	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
 	r = amdgpu_trap_validate_params(queue->userq_mgr->adev, trap_params,
 					num_xcc);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2a56f5ec9c76..90846d55292b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -390,6 +390,54 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 	return 0;
 }
 
+/**
+ * amdgpu_xcp_get_xcc_mask - Get XCC instance mask for a partition
+ * @adev: amdgpu device pointer
+ * @xcp_id: XCP partition ID
+ * @xcc_mask: output parameter for XCC instance mask
+ *
+ * Returns the XCC instance mask for the specified XCP partition.
+ * For partitioned systems, returns only the XCCs belonging to this XCP.
+ *
+ * When @xcp_id is AMDGPU_XCP_NO_PARTITION (or the device is not
+ * partitioned), the device's full XCC mask is returned (e.g. 0xFF for an
+ * 8-XCC device). Note that the full device mask is returned even on a
+ * partitioned device: callers that require partition isolation (e.g. SPM)
+ * must reject AMDGPU_XCP_NO_PARTITION on a partitioned device themselves.
+ *
+ * Note: On error, xcc_mask is undefined. Callers must check return code
+ * and only read xcc_mask when return == 0.
+ *
+ * Return: 0 on success (non-partitioned systems or valid XCP found),
+ *         -EINVAL if xcc_mask is NULL, no matching XCP id is found, or the
+ *         partition's GFX IP details are unavailable
+ */
+int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
+			    uint32_t *xcc_mask)
+{
+	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
+	struct amdgpu_xcp *xcp;
+	int i;
+
+	if (!xcc_mask)
+		return -EINVAL;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION) {
+		/* Non-partitioned: return the device's full XCC mask. */
+		*xcc_mask = adev->gfx.xcc_mask;
+		return 0;
+	}
+
+	/* Partitioned system: get this XCP's XCCs */
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id)
+			return amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							   xcc_mask);
+	}
+
+	return -EINVAL;
+}
+
 int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 			const struct pci_device_id *ent)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 692508be23fb..6eed82ad49b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -44,6 +44,7 @@
 #define XCP_INST_MASK(num_inst, xcp_id)		\
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
 
+struct amdgpu_device;
 struct amdgpu_fpriv;
 
 enum AMDGPU_XCP_IP_BLOCK {
@@ -219,26 +220,23 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
-static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
-					 int xcp_id)
+int amdgpu_xcp_get_xcc_mask(struct amdgpu_device *adev, int xcp_id,
+			    uint32_t *xcc_mask);
+
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_device *adev, int xcp_id)
 {
-	struct amdgpu_xcp *xcp;
 	uint32_t xcc_mask;
-	int i, r;
-
-	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+	int r, count;
+
+	/* Derive the XCC count from the partition's XCC mask (or the full
+	 * device mask when not partitioned). amdgpu_xcp_get_xcc_mask()
+	 * handles both partitioned and non-partitioned cases.
+	 */
+	r = amdgpu_xcp_get_xcc_mask(adev, xcp_id, &xcc_mask);
+	if (unlikely(r))
 		return 1;
-	for_each_xcp(xcp_mgr, xcp, i) {
-		if (xcp->id == xcp_id) {
-			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
-							&xcc_mask);
-			if (unlikely(r))
-				return 1;
-			else
-				return hweight32(xcc_mask);
-		}
-	}
 
-	return 1;
+	count = hweight32(xcc_mask);
+	return count ? count : 1;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 16aa22b25098..1c7b2f3227e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -503,8 +503,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 				uq_mgr_to_fpriv(queue->userq_mgr);
 			int num_xcc;
 
-			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
-							 fpriv->xcp_id);
+			num_xcc = amdgpu_xcp_get_num_xcc(adev, fpriv->xcp_id);
 			trap_params.ctx_save_area_address =
 				compute_mqd->ctx_save_area_va;
 			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
-- 
2.34.1

