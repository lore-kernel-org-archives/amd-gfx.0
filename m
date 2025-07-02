Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A67C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 17:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E6310E755;
	Wed,  2 Jul 2025 17:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJhH92ql";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D950010E755
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 17:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AERk/GUFhaSku4ZFoRK1stUU85DstKv3U8h0R12huNl/uc3CIPi4e4d4a5Xsp/ozLOBo+dKV7kkCMcX62/KKznBE5bAgssbmOng9I5wT+vNY9a2K4WKJ1l9+3rfl72iTvi7Vcc+u4UdwCck1zyT2UapiEHF7J7iiNt4LOkeNaLX2Is/IL0C+53jrGTFxFU3dftMy84Ny4ie1yQaXDNkeF5mdKbHK7rUz1R1YsPyl2aDn2mtXIurqQesz78PDMmHKFyDtdDWOQm672buFfgPyA+iJ+pTPS4N4sQQWBAa352lquhdybrKR3kCb7+OwfXvWBMD4rZI+AzfeEORTho/0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afll9J+7qe2/P7Qh6aZy72rJzED12ObDfCNUXCyEcks=;
 b=gY1vD5JrRjcnmQioGJ1OFd1R5cVOiPAhFo252Vy/PQHKJo7OkrGU85GG9oLGkRpY8XLPgjN2X545Qh/J+7cpqtwC9cQ8FTK25xUVAx1t6SGySGz3jhhMmw6Ig4DwDkIROmoE0W4DwP6X0Orvn49bnV1cHF0boweR7OS1nhFlLdx+xYxKYnJRU77yIUS17NjHg4DGt5NANLWIc5pymCXIh9Uqx5p1xJZGz9cYpCeNjNMZFjIrrG0bFFS3QJUD71PlVsFYl0TElPsUIH3VFKB3fMJNGMQc+Te1+prnUkRk8PKlpUgDbaEqPquJObUsQXTS66EoyzR9fuToSuzVvyd5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afll9J+7qe2/P7Qh6aZy72rJzED12ObDfCNUXCyEcks=;
 b=zJhH92qlqLXCjoqjPqTNeIu2NWD9xO0yGaKymMqrJ5jdFWTP0ZYuZxgDCZRZCR1WFsryU5ZzHXZBG8hrVrrFcObJS96po+qdAnIrki5F0Xx6XPi6RqXcxgfe5eLkSr2fcS49c+mTnERgJXKXKKwl2SuYv1MQ0A48uVxjwBZ8ZzU=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 17:10:25 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::19) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 17:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 17:10:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 12:10:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 12:10:23 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 12:10:22 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c"
Date: Wed, 2 Jul 2025 13:10:19 -0400
Message-ID: <20250702171020.69028-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: d10aec9b-c907-4373-5fa0-08ddb98b556b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?niIx0dKDXsk0CPYxljGB0xlXZf5aptQPFic/SkjEdPDwrUFxcXsPOzmaJNWx?=
 =?us-ascii?Q?D/q/kk6j7gcFOp2IEQ98wWkmskPmibt0GNz93EFM16ER5HvQ5gEZVzFdDds7?=
 =?us-ascii?Q?zm66Ib6EeqCCxL4Wg/f7JzFp2wGjrOXegi2d32/LWHTJ5Y7TdEoXZDdeePwG?=
 =?us-ascii?Q?Ol4KVKYPhNL/ANAf8QFik6yJdnty5WJWbrQmzPHtICMGdUDbX7Qu77LjVRFW?=
 =?us-ascii?Q?Bne6/qvFZ163hYwEX31AfxWPXkzhOcPuTFQGVojIGXuXru82upZhqLtkgk51?=
 =?us-ascii?Q?yHMdNfSFkiuMiAKFDf4B5BAa8wBByxTmNjNQAmqU5dqCIlAkY3TFl+LdPNhh?=
 =?us-ascii?Q?aeONM2FXnn7CZDe7fOgY8rQnVRzJ8PO5Mf9aEoQwUiNg+dH9QUDHzocANKP5?=
 =?us-ascii?Q?7Mouqh9KSxHxBqMHT3/rTK9+zcHoRjEqaClTYsUF5135QHSC3PxUrBDU8yqr?=
 =?us-ascii?Q?maeK5elQ0RHQw3NMfiGepCWxvcsizXZ5zsebjBuuBLsEiFxR4r6p+FIpA16L?=
 =?us-ascii?Q?jGyqYaNPkrrzu/5D1iPuXHeVmUql+tLj/z2/YqPNfSW5CeW/Rr/SMUPvQ82y?=
 =?us-ascii?Q?tpcbpBLBJdBN+ntuJJpHlRhCvfMPl3/njMqFi2pPQUVimC5Bu7AYGTFik4tr?=
 =?us-ascii?Q?GkXQqoFt6OjBynP2WjctOK43QZd93NkHL0Q+N05CPcaosxiH0c4wJhZ5hwba?=
 =?us-ascii?Q?lNUUMXDrvdVsB8EUywDcqtWjgMrXPtlbvY5OihJdxkyt2IsDhP7wO2UxFKz/?=
 =?us-ascii?Q?w18lp/69X9GZ6gfPQ/ozfGJnJUbxBKG+tXRnFEqzv4cGA2tByO4sWLUhKh5K?=
 =?us-ascii?Q?C+amVimhOUOJACnI/j3yuZLyxLG7fIgLW313yH3MBbtad3nWx5tfs+YDtGKC?=
 =?us-ascii?Q?Md2vb0mY7UaqBl21hCObQCIzFmzh8jHh49QqluMX/R2Hjxv5HDsSltUUO/2b?=
 =?us-ascii?Q?HCPjL7EFkAtc5vrAq0c/z8TECj4VXJ90fIXFcxzcTROEkHYmop5sGaWgdN9c?=
 =?us-ascii?Q?q/Hv6hT7q9r/AOcviXdO9IgrX03LctMYflLy+QjRGeQdBPERS4ltroza9CI5?=
 =?us-ascii?Q?ZVgMBfBiiXZPPdo0dCGTEbL83LPBOxnk5/BFZHTlP+NBrnWQVGeIdpPIfhPc?=
 =?us-ascii?Q?Ed0E897wHOuJs+GDij00eORKns9IEzrM3gtgek1AMsY3WKU8N9+nQcOiq9kj?=
 =?us-ascii?Q?EptPtdhZudfZThZJDRRTFcYjPPdug9bprewIJXspblp45ubN+qvp53q5Cwj2?=
 =?us-ascii?Q?AnsudX/sIsqSbCZAAMhjfQJoavIe3qgdVDPdhc7a9DYQ+oNtVq+CxVzmn8/Y?=
 =?us-ascii?Q?9U5iuKelAr1F8PD0otQ0gFaDWnku33M4q4diOno8QFPOM1MumuxblFoCN6qK?=
 =?us-ascii?Q?zpPcXu5v2drAbBnatna9lWoojytL5t7A0t3+bQG+zqKfHwmnHaVLaT/fVkJt?=
 =?us-ascii?Q?zuuxFIw2mbyjTwcWEQHoZk2UP+ho38pjN/RToO1y9lGtU6ugOyMTbhh0yfJo?=
 =?us-ascii?Q?YlrMDK2pPkwHiTa8lhUq09oirJ8yemkewsna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:10:24.0299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10aec9b-c907-4373-5fa0-08ddb98b556b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

This reverts commit 0203ef5eb3b2a3a10dd31bac8fc2fa3b439cbb09.

The original patch moved `amdgpu_userq_mgr_fini()` to the driver's `postclose`
callback, which is called after `drm_gem_release()` in the DRM file cleanup
sequence. If a user application crashes or aborts without cleaning up its user queues,
'drm_gem_release()` may free GEM objects that are still referenced by active
user queues, leading to use-after-free. By reverting, we ensure that user queues are
disabled and cleaned up before any GEM objects are released, preventing this class of bug.
However, this reintroduces a race during PCI hot-unplug, where device removal can
race with per-file cleanup, leading to use-after-free in suspend/unplug paths.
This will be fixed in the next patch.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4f8632737574..1c54b2e5a225 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2911,6 +2911,20 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	return ret;
 }
 
+static int amdgpu_drm_release(struct inode *inode, struct file *filp)
+{
+	struct drm_file *file_priv = filp->private_data;
+	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+
+	if (fpriv) {
+		fpriv->evf_mgr.fd_closing = true;
+		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+	}
+
+	return drm_release(inode, filp);
+}
+
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -2962,7 +2976,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
 	.flush = amdgpu_flush,
-	.release = drm_release,
+	.release = amdgpu_drm_release,
 	.unlocked_ioctl = amdgpu_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4aab5e394ce2..adba7d0ac147 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1521,9 +1521,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_vm_bo_del(adev, fpriv->prt_va);
 		amdgpu_bo_unreserve(pd);
 	}
-	fpriv->evf_mgr.fd_closing = true;
-	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
-- 
2.34.1

