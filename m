Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01F6C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 01:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990B010E49A;
	Tue, 24 Jun 2025 01:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrSvpM69";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A170610E497
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 01:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+22pnI9N4HgW+2avNO6VxMeLJSQoohrp4MbJnQ0BytmyHfg9EtaH11q1IAH7R6X+1v2nSGjUSDs/GlWendqV5c58s8LlGB0uuRxjU/nfXj45jLv2jcPSjzpfL5c2UUP1isNDLXHf2vJic1/N/cXsi+L0ZbG4KyZjzmZzpK3jmRYeDzBx9frNBF736pbx2VPRhtR/SaPuS58rv7oUH2kkWyU9suvY6RdBzPOEbMIwMqBNESmjeH4uY89urm1IBL6RUjJDjCsRbbJsq6OHdfZW6rQJCy2joVuEuQUBPxJ3IoKJ0AHEzkfeqvAj4Z5ONdX/1tIcckKOds5GaYBimUBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3W7275QjOWK6DML4axK0/t7ZRf15GtEu3ruuyNwFTo=;
 b=S1no1LcIAsihI6XZny1n5pabfQn0mhVsqOLUnh1U/67/Nvnv0ga+UEKPxNObHoNufIQBesMM1OvM3Nz0k6h3U7KzpeGf+rDds1+qHenjbX9+e5NQWfXfzlBkgymoO+knyrfKE93gUmEbG/uH3DKPjlgJ79pTwuXJ0q2J3RG63PnD0KAUKBXA7D4RP31sLRRy72sfKZUsgtnkUx/P+lBW26kjdIA2PL+WwCFYL1TlfVOR2NtsByRbJ31t/l6/czjb40zy/0ETkXdrMMCl2UYa0e4FuAhkTCrf28oT10oJNyhSLMmFwQSRVZnAL7C0CN56nr/rbOJKzmcXQM383MKpaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3W7275QjOWK6DML4axK0/t7ZRf15GtEu3ruuyNwFTo=;
 b=YrSvpM69zk2P128AHv9cspRmj1xEJhwX0KlU+upxtAGZGHnWoYxVD/4qgNyy7HQT/TGRwWQNW6cUwUH+wwpyiTOeM8Q2i5TvnAxq7jFph/T1aMIAGRcCw3PRJ1N4TSco44jgiRzdCMB4VW8YKKLwXUqhaV9MGdO9a+/oPaiLH/0=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 01:53:27 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::e1) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 01:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 01:53:26 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 20:53:23 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH V3 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Date: Tue, 24 Jun 2025 09:52:54 +0800
Message-ID: <20250624015254.1162196-2-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624015254.1162196-1-li.meng@amd.com>
References: <20250624015254.1162196-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e412a2-05eb-46d8-571c-08ddb2c1e933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Ben4Qnl5+3XKRXYrJIvzuUvwI9wzADNa/yLmtoYTPPktOCMczCuSY7ovmhS?=
 =?us-ascii?Q?ECJEYcp+3uU8JIofuArz1u8azYjlIOZhgZsOrOB52GnzZu4/BQeL0ma6v7WV?=
 =?us-ascii?Q?KSXe7Ohh1AIQd3IhwhPVl3mHlf2f5ZP32rrqOTDZkzM/7aHlGalHWce/IdDu?=
 =?us-ascii?Q?oQbNxvDeyrTuwFqAIBPeN//U/LAQzWQeSFVESxKUBePo0A91l5kQ0zy9wyrH?=
 =?us-ascii?Q?I5MGnkyWXbT15OWS4baabSBCFBK3jJcr1h8WRBUJC1cOmYSbe9kqeATEY9zn?=
 =?us-ascii?Q?MRMbqxnSN9oHJyd3lxiaeUnIjlOVimg3JDc7Y1QDpTGBk+xaWrt9EvKm+rYT?=
 =?us-ascii?Q?CWxDGq+LdcmpOsll89Z2wKPVPnSl9gpcwJumWSwLa6LN0jQNCB2aZJG/yf3D?=
 =?us-ascii?Q?4NO8CpCDuoA4oq1KIxnmdjrQ0vIIlbaTe+U6AOlQ83vnqlV2q9mEZbed1uvR?=
 =?us-ascii?Q?6TXqSMJFllW+ah/ocIlex8DNraJLPwFHTmxlp+vAzNRBVTCdQ7Yyf9f5jKWR?=
 =?us-ascii?Q?tbFtzRvcjf52TDSYizcugStgW7D4pDTv4BchOMqktSv+mxlu44bskYOtg9g1?=
 =?us-ascii?Q?OWHpxfqr6ggkRbnt6omtz9Df2uW55Z30ZLpNLOjzotbEBR67mCMxPemNi3bW?=
 =?us-ascii?Q?VqzasygyypivpInY9UmF5AHVK+TV+Ii7ft5t6BMFp19ekb9A9SHKMKr58e9N?=
 =?us-ascii?Q?c5UdDfB9fkWypJ4UpQ19iiV5sQ+cgZjnqP5pjSUM6nfv1CD5zI0HgRl29Tjw?=
 =?us-ascii?Q?aes0Hn23xA+2eXSbd1nkJDm9i4PgWIuPRUDkn+SkfhDgsKugOcXdD1uXa8yD?=
 =?us-ascii?Q?SkZ7c3Uu6wTF8QhmYWkFNHA3o/6FphOl8ZtyKlv8S5nXq3QjzrjgvXDOBrZC?=
 =?us-ascii?Q?VixO6Cm9AE3LMYhpm6TjB9u9+Bie7fXSab5ohFtQ91obNollkxNNegurcTe9?=
 =?us-ascii?Q?aFNWcOJbBFuQ286reSKl9HQ285xDdrTKcCWB8xpuzYc/CIPzKBqZkFl8Zq01?=
 =?us-ascii?Q?fR7wq2ViNSpl6JCVtIjFL6AyiAOVUWKBTy9GYIQh9a5LRJH9NntTeixvzEZG?=
 =?us-ascii?Q?gI98xpy91QmL5meUxEwSVIt7bkzZRiIlCxxYwyTrM42zQQPUe60vxUcyB8DH?=
 =?us-ascii?Q?Hz4iNy5uv16BteYFfIQCIj42N3EFTGNsgNrUdTVaBAvAUcrOHv7s80AQp7x6?=
 =?us-ascii?Q?qeM3Z7t4orTslfs0UJgfitGXhPA4pjWQVjKsxIFy2kvk98RY6WqXiuzg6H6g?=
 =?us-ascii?Q?6kaiW1nt6NRaG8VDaiQBwcBMHEljdy6Qsuuo7R7c8aChidiAnhdj3g/AB7ZZ?=
 =?us-ascii?Q?rgYwoFWeVORc1KzvnWJKL9OqG7Q+EJZuK1iYekKibNkVmoyLNmZEsI6zrGiF?=
 =?us-ascii?Q?FPhkEzovjMr8vzmHuzRW90AxhHRUJ8KLp/Wy2uCLYMW7IQDb9XpP8RrTdaJH?=
 =?us-ascii?Q?NJH3tyHbsl1q+ubisWhMLrIAjSNPSfZnpWPyiVzs7QCmEfgCBghJUvNndoV2?=
 =?us-ascii?Q?b0bW7vZ7BKEOGDTEu+hAUqITwVnfLYd3yqQy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 01:53:26.6933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e412a2-05eb-46d8-571c-08ddb2c1e933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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

Add a new API amdgpu_xcp_drm_dev_free().
After unplug xcp device, need to release xcp drm memory etc.

Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Meng Li <li.meng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 322816805bfb..70c44961af95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
 		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
 		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		amdgpu_xcp_drm_dev_free(p_ddev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index faed84172dd4..3a8f3dd19a12 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,18 +45,29 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
 static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
+static DEFINE_MUTEX(xcp_mutex);
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
 	char dev_name[20];
-	int ret;
+	int ret, i;
+
+	guard(mutex)(&xcp_mutex);
 
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
-	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		if (!xcp_dev[i])
+			break;
+	}
+
+	if (i >= MAX_XCP_PLATFORM_DEVICE)
+		return -ENODEV;
+
+	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
 	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -72,8 +83,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[i] = pxcp_dev;
+	xcp_dev[i]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
 
@@ -88,16 +99,47 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
-void amdgpu_xcp_drv_release(void)
+static void free_xcp_dev(int8_t index)
 {
-	for (--pdev_num; pdev_num >= 0; --pdev_num) {
-		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
+	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
+		struct platform_device *pdev = xcp_dev[index]->pdev;
 
 		devres_release_group(&pdev->dev, NULL);
 		platform_device_unregister(pdev);
-		xcp_dev[pdev_num] = NULL;
+
+		xcp_dev[index] = NULL;
+		pdev_num--;
+	}
+}
+
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
+{
+	int8_t i = MAX_XCP_PLATFORM_DEVICE;
+
+	guard(mutex)(&xcp_mutex);
+
+	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
+			free_xcp_dev(i);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
+
+void amdgpu_xcp_drv_release(void)
+{
+	int8_t i = 0;
+
+	guard(mutex)(&xcp_mutex);
+
+	if (pdev_num > 0) {
+		for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+			free_xcp_dev(i);
+			if (pdev_num == 0)
+				break;
+		}
 	}
-	pdev_num = 0;
 }
 EXPORT_SYMBOL(amdgpu_xcp_drv_release);
 
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
index c1c4b679bf95..580a1602c8e3 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
@@ -25,5 +25,6 @@
 #define _AMDGPU_XCP_DRV_H_
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
 void amdgpu_xcp_drv_release(void);
 #endif /* _AMDGPU_XCP_DRV_H_ */
-- 
2.43.0

