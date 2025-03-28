Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F9BC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DF910EA7A;
	Fri, 28 Mar 2025 18:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oaxAhxHg";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F7910E11C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:07:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz4JMKVdWKTnNF0HaNb42jzYAal0MHt3wHTOqFczXyiKxweB39qoGUAa8IpE48WyfkgRmk5IwxEHRrJnGiuYgu4vqcuc+UGmnMEuPtneTmGK4mBr91nMsDUTTkPrx4/6Ehs6Sez1V1Jsh8aB9yKh190kc0k9COYtR61T7YPlaarLPNiTh3kMfRih0QEjR8U6UcshYHr0y03q971nekHOgNX/FroQjTqQ5/ntMZIVEhUZJWL1jaRvHmmamX2f1fOyHNKQWTAZkwr8nMGk2rmamMnRg8YFJ5hyubBNQe1DhxouJxY0u9O77gDgJUlEzEhWQjowPhkqAUCvp5sTaUF4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8HKoK+XM6+9xWmOwrZE3ux41n5t5oMvC3nipE/f5j4=;
 b=rv3pJIe75nA16cMBwkTCP3UcsKqbOZKld9RGZlWzcBS4nFqhPoqK2s64UzR5yQWstLChcS2mORO5dYmyVxBRVPnZoicForQr+guRrXK0g9MOHqw85G6LILyjhW63Lva4DyBt7UrlMnb70XcY7f0j4mwgBZ/PJS0XcxVBEmxjXeTrGtpVPicUoNjQcff8F0gVd0/Zoyuu5VDtOf9vGZAKo3trQNIwL9J3VTsNUS9NH7R0JtZB++3/Wl/2tpmWEnWByh2unx7/2XygvYAM/YR2XaLBnqXDhOiUeNN6WjD8qie5xAMXnS39k4WVxO4tJZ5saOhdxMZVvXLzPseTKQwuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8HKoK+XM6+9xWmOwrZE3ux41n5t5oMvC3nipE/f5j4=;
 b=oaxAhxHgiulSRd/zhCDz7O8napMuc5ABMX6bRp+Zryt4SDsaEdRHV8DSsqbszLilpcwAoPJZQP0I0PpP7b9uihLc1I5x3qfI60BlKwccnsvF2u5W0NYo+fM1BnRDo6NoBlTTu1PT1ARlqVwIULQz356nvvFRkPhyuuFm1exqlhg=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:07:08 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::a7) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 18:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:07:08 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:07:07 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>,
 <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>, <dcostantino@meta.com>, <sruffell@meta.com>,
 David Francis <David.Francis@amd.com>
Subject: [PATCH v3 1/3] drm: Add DRM prime interfaces to reassign GEM handle
Date: Fri, 28 Mar 2025 14:06:50 -0400
Message-ID: <20250328180652.2108029-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328180652.2108029-1-David.Francis@amd.com>
References: <20250328180652.2108029-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b252898-8502-4c78-1fd1-08dd6e235ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WcVzuLBrqta2IX+KKTtwazl/ac2egZFHW/cdSgVhSsaK9/20bbOyBcb+nE5X?=
 =?us-ascii?Q?HTbI0VmQ4sZCXp76vkSC3A3vc3f95yU255nSqnls1iK5pUOt+evu2bOed4F8?=
 =?us-ascii?Q?5b2vi0vWzTU9VY//8vJSJHgVg7x29BTxpSaThwW+hkKjYxoUzaYaFrygzGvD?=
 =?us-ascii?Q?18oSSVvhq40rfrVE01PYFad7GW7y/tUegelUI/PYlYqM0EArvoSQ6xspN1E7?=
 =?us-ascii?Q?x8PrI1/HnhcZBfLNrGeA4MBysObeVxhQDhhl4Pz3BHy1DPWiYSB2XVzD+HfZ?=
 =?us-ascii?Q?cFkI9zrqpob+1Hhf2jH5/MrbciUdmnESFH4FMmWw6o3HyZlhzgp2Ra3BX+tu?=
 =?us-ascii?Q?RpjsEprrp7JXIQAkymN6xNTAAUDDd97kIzmueZ2mxHSwQhAQhh1XOwO3K8ya?=
 =?us-ascii?Q?o+KnRnCr0hDalQ3ui+PexOvdWmCFXwEldqsdHnkR7I9KUoFuFVmQzUH1gxnl?=
 =?us-ascii?Q?2lYtukNpZODPA4dRSNMj7q3MD8PidfXDn981J67iWSQynVPjSX6XuOPLOUGc?=
 =?us-ascii?Q?2LI4eh7SMGLKzWyqFKFaTyF7BKr4KYYGfojhcC3k1YxghmFm4HRPOUZHUPh5?=
 =?us-ascii?Q?I0AjKlJglzSzzwKgVgRSxhpm9LnzVk/hmQ/AMMvvf+Z/zja/vxfWht7KNfff?=
 =?us-ascii?Q?GwOvHaSWtg1y+WlQ1rG2mNnmfNFTFVRxhgGY5ZGYww/zLPvou2tdEBJ9ZJ52?=
 =?us-ascii?Q?icahQzqNJGJ6cdD6L7/MMfNzDUxXG3MKRG4qNugMtBDAMjq0WG3FZHlE6Vgx?=
 =?us-ascii?Q?0av4I1DLsakTo3eua1IbvDZhVKhKoPrd1PQ3xcG2gtdNT/R9rixlhVJEQJD1?=
 =?us-ascii?Q?qg1FFLwFt/twBC51hPCUhehf7SUVMpPdt1w11VgNK231+n6uM8VfIA5Prxg/?=
 =?us-ascii?Q?TGmOP3ImdyFQpYr0dQnk+1rBfCNCGEw3VLqQhCAUiUw3YyDBoXBHgyWFR6nu?=
 =?us-ascii?Q?ZQcii/O3/ZIo4Gi/BH8/siEqgajriiJ0kaASdzPjHQ4fnTIWmj7zPi9eOnzZ?=
 =?us-ascii?Q?6yQpS7RxFh/J5OJosV73kNcue3QKfabSG8z3Rfo4lTEcS8zMGPMYHfcK6mZy?=
 =?us-ascii?Q?fvILA0MEim4fB+Qa5KCcMLWG+Ydw3V/VtYHk4NdFTHdPgrXCkjkI2+NJk6xq?=
 =?us-ascii?Q?KQghME9/scn87I35bUZrAAlrnMLZNfAf32SO8jgWTigtVJ0qZrQxzPEvcqp8?=
 =?us-ascii?Q?Vklywcw7gX+smpOKsHVe/F3ijnbwAm0ilJy0Pg8lc34P3XmDMon6uxMJXOom?=
 =?us-ascii?Q?v74KvTdznLb0ZmAEuI/ULkqEsFN3ktgoTTS1AZVVjmnp1TxO+m9h/DVaQyxZ?=
 =?us-ascii?Q?N08jbqP1/4xmHl8xpuB3KF4L/UOaLFnjWW5eA5EZstUE316TnvHIN+NYwHx/?=
 =?us-ascii?Q?izp6vOH29JDfdpfvhq1IGCmNraWjnGPg7hQ+PqCB/JzrCmJqtii7jWU1nx66?=
 =?us-ascii?Q?csmIhG06zIqj/cp9tVpk+YBSQkhe9+9cTIiBEVjFYoPXl7X4g55Asu2rxv9t?=
 =?us-ascii?Q?8HMSTHpeRwX5AI8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:07:08.0845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b252898-8502-4c78-1fd1-08dd6e235ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
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

CRIU restore of drm buffer objects requires the ability to create
a buffer object with a specific gem handle.

Add function drm_prime_change_buf_handle to change the gem handle
of a specified buffer object.

This function calls drm_gem_object_release_handle.
drm_gem_object_release_handle is an internal function with one caller;
make it not acquire the prime lock.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/drm_gem.c   |  5 ++++
 drivers/gpu/drm/drm_prime.c | 47 +++++++++++++++++++++++++++++++++----
 include/drm/drm_prime.h     |  2 ++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index ee811764c3df..f56eeed808d2 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -282,7 +282,12 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
+	mutex_lock(&file_priv->prime.lock);
+
 	drm_prime_remove_buf_handle(&file_priv->prime, id);
+
+	mutex_unlock(&file_priv->prime.lock);
+
 	drm_vma_node_revoke(&obj->vma_node, file_priv);
 
 	drm_gem_object_handle_put_unlocked(obj);
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 0e3f8adf162f..08205b291825 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -190,8 +190,6 @@ void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 {
 	struct rb_node *rb;
 
-	mutex_lock(&prime_fpriv->lock);
-
 	rb = prime_fpriv->handles.rb_node;
 	while (rb) {
 		struct drm_prime_member *member;
@@ -210,8 +208,6 @@ void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 			rb = rb->rb_left;
 		}
 	}
-
-	mutex_unlock(&prime_fpriv->lock);
 }
 
 void drm_prime_init_file_private(struct drm_prime_file_private *prime_fpriv)
@@ -1084,3 +1080,46 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
 	dma_buf_put(dma_buf);
 }
 EXPORT_SYMBOL(drm_prime_gem_destroy);
+
+/**
+ * drm_prime_change_buf_handle - function to change the gem handle of a bo
+ * @file_priv: drm file-private structure
+ * @gem_obj: gem object whose handle should be changed
+ * @newhandle: handle to change to
+ *
+ * Will fail if the gem object cannot be found or if the new handle
+ * is already in use.
+ */
+int drm_prime_change_buf_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, int newhandle)
+{
+	int oldhandle = -1;
+	int ret;
+
+	mutex_lock(&file_priv->prime.lock);
+
+	ret = drm_prime_lookup_buf_handle(&file_priv->prime, gem_obj->dma_buf, &oldhandle);
+	if (ret < 0)
+		goto out_unlock;
+
+	drm_prime_remove_buf_handle(&file_priv->prime, oldhandle);
+
+	spin_lock(&file_priv->table_lock);
+
+	idr_remove(&file_priv->object_idr, oldhandle);
+	ret = idr_alloc(&file_priv->object_idr, gem_obj, newhandle, newhandle + 1, GFP_NOWAIT);
+
+	spin_unlock(&file_priv->table_lock);
+
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = drm_prime_add_buf_handle(&file_priv->prime, gem_obj->dma_buf, newhandle);
+	if (ret < 0)
+		goto out_unlock;
+
+out_unlock:
+	mutex_unlock(&file_priv->prime.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_prime_change_buf_handle);
\ No newline at end of file
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index fa085c44d4ca..5a9288493dd7 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -112,5 +112,7 @@ int drm_prime_sg_to_page_array(struct sg_table *sgt, struct page **pages,
 			       int max_pages);
 int drm_prime_sg_to_dma_addr_array(struct sg_table *sgt, dma_addr_t *addrs,
 				   int max_pages);
+int drm_prime_change_buf_handle(struct drm_file *file_priv,
+				struct drm_gem_object *gem_obj, int newhandle);
 
 #endif /* __DRM_PRIME_H__ */
-- 
2.34.1

