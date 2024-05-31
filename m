Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E994EC27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F5610E316;
	Fri, 31 May 2024 10:49:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5l+Iy9g+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B2310E316
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbZmdGaQeImwxYDQCL97BLZ7Wo6R8P1IdelM2UQpUv3xdkE6GJTTa1Jh/aFwOf07/X8VRDMIms+9Jh1c/4L50A3Qfh+BKypuf+1Ky5OYM3OFMVYBpb9tkzPkUGIDow/mVGiPDADJLct3qHjBnOsFOOcJwuWFU7j5+QyLnsjuYr4Pz/N5s5L9wLC8zorrPfIi5ORdb9A8z5maCzkPkmXOQE0ct6+K9p5ppqlxPxV7dfdMGbGJHeRpPBrrN41kM2SnCc+UBeBitiuAgONpT9d80odbi+J5tAzJfa0QvLjHXADD3bAhlj5rkP+cKP0aM7iJhjb2gKV90av+vKiKLY5Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP8F/LRROM2z4GUpS5N+dRxMt6sY3ADrL4J05aps9J8=;
 b=KBZhB7Yd2UEYBciCzUKUCYJjR02hQWYN5Z+ABvTSXfKMbthU9Sz5FPJh+Jald6OOmldDjMcUyTERTKWNhdovcxXYc7bZlZxWS9KiFWAXpU9tDDC6ckRu39GGnCrvBIqRpH6RRs2/WhEg4ANCpryLoJWHMosV6yyD3HozyWIuCdUiWFfa3DLK80Gc7iHIxJsrQxUoHmCh5bqBICQvfF5q92w2PbDVxul7k3ZT2/ev+OAdO74J6kQbEQJfVClUgVpckocAuZjmvxtMwnGRbdi0gIOYIQI8JrTk0L+O328G2EugOGi9/hL0vgXOYjTCta7G1Vl0h5rxFOgv8jhw58srIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP8F/LRROM2z4GUpS5N+dRxMt6sY3ADrL4J05aps9J8=;
 b=5l+Iy9g+39OfunBJnLBKsJvQUuc3tlz2TEFRK5y5eLo4uGublwGXQXJJvackhpZHaAt8lWV/OQxiyTiIJVRFaskgryFHaQe7csr3ShQM6nM/zs4IxNiFL5FN/WcjVmrDSkxGnFrmBUYi54g4+aaAGbRw7n1CqKrcqgANrFbElts=
Received: from CH0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:b0::7)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 10:49:24 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::e3) by CH0PR03CA0002.outlook.office365.com
 (2603:10b6:610:b0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 10:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:49:24 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:49:22 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: create amdgpu_ras_in_recovery to simplify code
Date: Fri, 31 May 2024 18:49:09 +0800
Message-ID: <20240531104911.14748-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531104911.14748-1-tao.zhou1@amd.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9a8c6e-efd1-4b80-0b0d-08dc815f55d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lMNXFOjuQY/XkIrz6IpKYRRoV2/RSy49i5o+Zw5pwKfc9/qm7nxY4t2zesFM?=
 =?us-ascii?Q?XcwrhA/bFFhnoGjwPLqnrmnmiikwmXh6nAn+o16wqdWjfLXZBP0eV/rfZ5ce?=
 =?us-ascii?Q?/hJuoNXAJ3jNO4/g6kKcGGV4em9OZsZmOkW5va9EfOc5bWVQTCo+6wMD8FDH?=
 =?us-ascii?Q?7UkWGSibst9v9/GY27kYhIi3MeIMNGGtB5Z1jOYPANVgI8JXAQkLfViKReCh?=
 =?us-ascii?Q?rs2L5HrgJFrR0ATJn/YxdkV1HnPSg/t/iU0RtByJFkKQIKaJMYp+FvgszL76?=
 =?us-ascii?Q?TwclQeW/ABN/OW8DLpyYwzYD8ZJb0U8ZQFU2ua9dXbSvPXcX9hBIX4Xgi5rZ?=
 =?us-ascii?Q?f9BdIp+R6wkaTKD9m8GYk34haYlG/slpOfqF62Rm7RjBjJLOUbdEgdhhd512?=
 =?us-ascii?Q?wPOUDmWsuXemvZOwxFiv3dOb1UESedp0DusKKgg72WOCzwryzPYVBFo4GSbY?=
 =?us-ascii?Q?qzaugaFU2MTdkbMZ2bZM1Wh4VXjudZ8c51Csnvj4oai/4Hmp8zEtOsE6It5N?=
 =?us-ascii?Q?hx1WiHUentW3N0ZxVtt/6EhlghEe2gLnrM4YM6gXoCA3HbeTrabZaf2F8DtR?=
 =?us-ascii?Q?RBVIAux9K+UyMkKzBVKjT7qP4zwwrGSGZEewzpAZwX/x6zGoE/9w+/EXBMsI?=
 =?us-ascii?Q?SAMV5/l9JUGTZUzvqRHAhFEShaR1nhwCLMESmQp2+0coxNx6egiwOHulFUgo?=
 =?us-ascii?Q?wzcCEevNAeznLsV1ptE4owVl1WtwD7AGZ0kLv+L/ZIDFLnMMxh8jerdzACRB?=
 =?us-ascii?Q?kIS5HRa413FV5BdqdGoYPW5WHcl8IYPrtrCP8WFX2O24p0Cnux8H09LXjl8H?=
 =?us-ascii?Q?4XhI25zXST5gLnMKmgeYJ7Bo6wxpc1dRTJqURNZrWmb6jqL0kbRD7rG65Fdr?=
 =?us-ascii?Q?5cqM+wmJINlGt7tN1KCwuzH3T1+X6B8/NAJdv+w5eYtiCH3A1WXbge38ifN6?=
 =?us-ascii?Q?KdX2umT0oEF0ttTngeNFmh82JpvN6ZIfD5JRIb0xncNBjkVI2fvvgBJFWjGk?=
 =?us-ascii?Q?6v2UYgseba23rDoeQh1tdNNMJHlQIf8wucfqMUYixGsCMh1MxAQmfZmhYchS?=
 =?us-ascii?Q?ObRsl9aC8Ttv5oarNKrsopyBafP2hyyU9rEfi/UzAoWH8yzhIzOqHsKJwS3K?=
 =?us-ascii?Q?SuqGHtUXBz2LsTwd25j36U2x+zmIdqxTpyU2MHd/MLztRV7huupul7St3bzp?=
 =?us-ascii?Q?Pf9QxNtlIKYGiKX5N78FPZc2Gf/MKcwUrbMPxsw8ksGD20XTskhn8u/qMMl3?=
 =?us-ascii?Q?Z38MfkAMplxkRsNct+Kl6ZzcHh/wfffhU2bD5EJMnXP76XmWwGgFncoQ8sX/?=
 =?us-ascii?Q?IdF3vaeIVCCr440lJ8zWs19nvGM2+ZKYM5S1yg9qLt4m0dBWj4FhDpiaEwC+?=
 =?us-ascii?Q?AXTSjSXpAI9bCKKBwX9RO/3WELmG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:49:24.0535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9a8c6e-efd1-4b80-0b0d-08dc815f55d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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

Reduce redundant code and user doesn't need to pay attention to RAS
details.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 14 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 31 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  5 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 12 +------
 7 files changed, 29 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2ba8c4d5dc76..1811c7ba9bdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6325,20 +6325,11 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	struct amdgpu_reset_context reset_context;
 	u32 memsize;
 	struct list_head device_list;
-	struct amdgpu_hive_info *hive;
-	int hive_ras_recovery = 0;
-	struct amdgpu_ras *ras;
 
 	/* PCI error slot reset should be skipped During RAS recovery */
-	hive = amdgpu_get_xgmi_hive(adev);
-	if (hive) {
-		hive_ras_recovery = atomic_read(&hive->ras_recovery);
-		amdgpu_put_xgmi_hive(hive);
-	}
-	ras = amdgpu_ras_get_context(adev);
 	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-	    ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    amdgpu_ras_in_recovery(adev))
 		return PCI_ERS_RESULT_RECOVERED;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 68505eaa92f9..fb5fc1fe6ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -505,9 +505,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	struct amdgpu_hive_info *hive;
-	struct amdgpu_ras *ras;
-	int hive_ras_recovery = 0;
 	int i, r = 0;
 	int j;
 
@@ -532,16 +529,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	 * This is workaround: only skip kiq_ring test
 	 * during ras recovery in suspend stage for gfx9.4.3
 	 */
-	hive = amdgpu_get_xgmi_hive(adev);
-	if (hive) {
-		hive_ras_recovery = atomic_read(&hive->ras_recovery);
-		amdgpu_put_xgmi_hive(hive);
-	}
-
-	ras = amdgpu_ras_get_context(adev);
 	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
-		ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery)) {
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
+	    amdgpu_ras_in_recovery(adev)) {
 		spin_unlock(&kiq->ring_lock);
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 10cbcc0d1a1a..ff2d34dc9718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1409,11 +1409,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 	const struct aca_smu_funcs *smu_funcs = adev->aca.smu_funcs;
-	struct amdgpu_hive_info *hive;
-	int hive_ras_recovery = 0;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1425,15 +1422,8 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	    !amdgpu_ras_get_aca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
-	hive = amdgpu_get_xgmi_hive(adev);
-	if (hive) {
-		hive_ras_recovery = atomic_read(&hive->ras_recovery);
-		amdgpu_put_xgmi_hive(hive);
-	}
-
 	/* skip ras error reset in gpu reset */
-	if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
-	    hive_ras_recovery) &&
+	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
 	    ((smu_funcs && smu_funcs->set_debug_mode) ||
 	     (mca_funcs && mca_funcs->mca_set_debug_mode)))
 		return -EOPNOTSUPP;
@@ -2444,6 +2434,23 @@ static void amdgpu_ras_set_fed_all(struct amdgpu_device *adev,
 	}
 }
 
+bool amdgpu_ras_in_recovery(struct amdgpu_device *adev)
+{
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int hive_ras_recovery = 0;
+
+	if (hive) {
+		hive_ras_recovery = atomic_read(&hive->ras_recovery);
+		amdgpu_put_xgmi_hive(hive);
+	}
+
+	if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+		return true;
+
+	return false;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
@@ -2807,7 +2814,7 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 	struct ras_err_data err_data;
 	unsigned long err_cnt;
 
-	if (amdgpu_in_reset(adev) || atomic_read(&con->in_recovery))
+	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
 		return;
 
 	amdgpu_ras_error_data_init(&err_data);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 437c58c85639..37e1c93c243d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -952,6 +952,8 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block, uint16_t pasid,
 		pasid_notify pasid_fn, void *data, uint32_t reset);
 
+bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);
+
 __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 				const char *fmt, ...);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 825786fc849e..04533f99f1e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1863,7 +1863,6 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	u32 fatal_err, param;
 	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	fatal_err = 0;
 	param = SMU_RESET_MODE_1;
@@ -1876,8 +1875,8 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 	} else {
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
-		if ((smu->smc_fw_version >= 0x00442c00) && ras &&
-		    atomic_read(&ras->in_recovery))
+		if ((smu->smc_fw_version >= 0x00442c00) &&
+		    amdgpu_ras_in_recovery(adev))
 			fatal_err = 1;
 
 		param |= (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fa78665458a7..d1766a603bb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2786,10 +2786,9 @@ static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
 						uint32_t *param)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if ((smu->smc_fw_version >= supported_version) &&
-			ras && atomic_read(&ras->in_recovery))
+	    amdgpu_ras_in_recovery(adev))
 		/* Set RAS fatal error reset flag */
 		*param = 1 << 16;
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 15c0aa0ad443..c1d7528a6dc8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2573,24 +2573,14 @@ static int smu_v13_0_6_get_thermal_temperature_range(struct smu_context *smu,
 static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	struct amdgpu_hive_info *hive = NULL;
-	u32 hive_ras_recovery = 0;
-	struct amdgpu_ras *ras;
 	u32 fatal_err, param;
 	int ret = 0;
 
-	hive = amdgpu_get_xgmi_hive(adev);
-	ras = amdgpu_ras_get_context(adev);
 	fatal_err = 0;
 	param = SMU_RESET_MODE_1;
 
-	if (hive) {
-		hive_ras_recovery = atomic_read(&hive->ras_recovery);
-		amdgpu_put_xgmi_hive(hive);
-	}
-
 	/* fatal error triggered by ras, PMFW supports the flag */
-	if (ras && (atomic_read(&ras->in_recovery) || hive_ras_recovery))
+	if (amdgpu_ras_in_recovery(adev))
 		fatal_err = 1;
 
 	param |= (fatal_err << 16);
-- 
2.34.1

