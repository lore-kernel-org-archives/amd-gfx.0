Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ECFC98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC0710EE72;
	Tue, 22 Sep 2026 20:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbBhaS9F";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2133A10EE72
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 20:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra4WIVnyqqTMDUxwxFmEoh7MqWfbISSmYeFx/+30NPaUTbb1aYdKaRoVoh89vvwk03h3MdSQXSXn04D083eBy8QJ76veVTC8f/+KnPHWYbh0+xH7JeQYBYPJnOkn1EDw1kImDNtOTPfIbHKRbKZ7HQyx0JC7+FnD9kOLqYZAZU+5uBPdDzldSG1AF9hFzo5UP10lb10aG/7sHUTDIirLfH3A/kzoHattg9fgt2YWierW3sOZbAo+78qenOPYgJEevoygPTKAaRe7kyn3AoF4gGUqeNXBir63h0pc5O5TuP/wTuDxbbNEdiqQgQZITSoc803YI949+rKfgqhO10e1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohodcC45cSjoNVEeELgxxqpJS4UmNBXVxT6qij2gAfs=;
 b=NV7F4Gr/BF6j9IOKlEkgJ7jBW9TBc6XhfLenc1iscWUIHKtB89dIQKF8obOCg8hJfcwwvd0hioEob/daQTMK59EZQscgMdLVWIb15eAtFjgdw3nCWbm4zyPpTjslATf9zL/RZE2q5Khjv0bhfxBRxVWmEc4O3Ggvtf3n517DjtHUDwJrhRz41GXKiVmJ1m4N/CcVww3rUVPL/PLzS2ac7EUVTzX2ZQSUbO/K56yVyfILa4jDP8YDgGc+lx/CEdAa80SH5hfxHb4HwRftUT/7ODxbPUwqeb4W1RX0O8hGVOdrRX9Svo+qWDT3If97QnzKCoBdejg6CbkIlYj0erH8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohodcC45cSjoNVEeELgxxqpJS4UmNBXVxT6qij2gAfs=;
 b=wbBhaS9FlsNTXjkkR4asZNI449KCpE9u2JRRGQL50RpzfQ3NXgBguYB4nGGFyaZmcfYzoC/e+xaROB13s3/M/8kT1xjgOIpS3MDBt6IMgIyRWNvCAbdLTKXCJ5E6rHwdbNrtJGFLjw7xwqwQCZAGrHATpAUtv5mFMEuC/YFIgYs=
Received: from MN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:52f::27)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:58:32 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:52f:cafe::90) by MN0PR03CA0020.outlook.office365.com
 (2603:10b6:208:52f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:58:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 22 Sep 2026 20:58:32 +0000
Received: from MKMLUIRSHAD03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 15:58:31 -0500
From: Luqmaan Irshad <luqmaan.irshad@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <yunxiang.li@amd.com>, <luqmaan.irshad@amd.com>
Subject: [PATCH] drm/amdgpu: defer XCP DRM device free until primary release
Date: Tue, 22 Sep 2026 16:57:31 -0400
Message-ID: <20260922205731.254264-1-luqmaan.irshad@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 313ad711-3aec-423e-6f32-08df18ec42c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: mtEUPAILdDRT17ogrbQ07c9G73Jc9PDrz9hAAxQXwFcDeqJXB3EFy/JzcX5DVLQWtJuxANHwpAnU0Chp4BKHhRPJEX1RbzZDNcXhk70xXrXipqFuBMniq7QSlqFv3kOhcfrHWjmEutLVq5cI9m4pQdM0bkQ1PKzBAszrWm1SMmcwAMtrtDCJG8QUXZy7j0b1NYX7ZUtxVTCYGlplC03/0PSE/SphFUiIVYlFF9nx+PDjT5TGVIdhnifv6H46qSD3wDfycp7dUf5OqRidsxAwqX7Y1DxuuqOPqBij/LSqXkuZMCstdP09RoWaMb20sdmSiRrwtAJSuPWRdReWWJIN9O/RwCN+TJUFf8SVlAmqf3n6OgXiRzIHgh2eGyH17kJM+MRD8/4poUOkrIN75aMJZtavsECCSN/AHnUKIPoe5wXiMQeBGunrB9WymV018qBmGeog+5+016DahjS7jJ0yD9OEbaeYNK5Y2qIjhLKYDsYC/uGzl+ufJeH2Zygx1y54LGUCA1amMmp+LzpMEZPsaOT9hM1Z/ykwYBV1Oo8WzFyQVHzVfgtTeZmPHIrrg0vMj277JUCCaD98iHnluzEGy+3LyqJptpymeQxI5SAvxBZU4+Jn5TNboU7C4GXHVtI5bkf3gisvtt7szX/Rb/UzqtUzT6ic1GGovbJlrwRu8RgNESE0UUBTQq52lxXN3LlabizqvUBXY00aF9przWuSZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qzoW+O7zj7LKPwN3BRaXo+Ybu/xTZEYHFSaHe9Av/Ov2xR2YuxySpDGvpgSLkiDGHK1uUaeb3uaKCnPN7wFvGJYsHyydCimFdENC0S3C2aqOyN39g6PO4xVMTwb5+XP92W0WYCHH8SGq3F64mPGdmDtXv85JOYWyK5EcXQ+VVQRH/Bb4fankZ+OpQp7BP717gZgwv7d2CLAUeRl0sL4ZE4h/zXNq6gweuCKNiZ71SVC5HPDYIJbPA84JqR4iY1rZND45NAHBBmt7RGVaYcofRja+2jVR33F3cyzaiNazmvfba8TuMW7w6Xe0WtsUaijBNZQ0RdZgnVMd3PxK9Uszp6QuSIVO5GQuzlO6gvtSaqprdmUFqqxUWUxbbZAQpVodWlBt6Ec6r6vbtZPlE5EVz/KplqL2nl7WZ58atT5QdXAclpaNw181RWA/dxRNOVEK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:58:32.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313ad711-3aec-423e-6f32-08df18ec42c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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

XCP unplug currently restores partition minors onto the synthetic
p_ddev and frees that device while files opened through those
minors may still be active. Those files took drm_device references
on the primary ddev because the minors were redirected at XCP
alloc time. After unplug reverses the redirection, close paths
operate on the already-freed p_ddev, causing a use-after-free
and p_ddev refcount underflow while leaking the matching
primary-device references.

Split teardown into two phases. amdgpu_xcp_dev_unplug() only
calls drm_dev_unplug() so new opens fail, and leaves minor->dev
pointing at the primary device. amdgpu_xcp_dev_fini() restores
the partition device pointers and frees p_ddev from
amdgpu_driver_release_kms(), after the primary drm_device's last
reference is dropped and every redirected drm_file has completed
drm_minor_release().

Signed-off-by: Luqmaan Irshad <luqmaan.irshad@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 51 +++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4d..403ca8fb1bc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1638,6 +1638,12 @@ void amdgpu_driver_release_kms(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	/*
+	 * XCP minors redirect their device reference to this DRM device.
+	 * Reaching its final release guarantees that no open files still
+	 * reference those minors, so the backing XCP devices can now be freed.
+	 */
+	amdgpu_xcp_dev_fini(adev);
 	amdgpu_device_fini_sw(adev);
 	pci_set_drvdata(adev->pdev, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a8c79a66df1d..295cd9567512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -412,7 +412,6 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 
 void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 {
-	struct drm_device *p_ddev;
 	int i;
 
 	if (!adev->xcp_mgr)
@@ -422,12 +421,50 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		if (!adev->xcp_mgr->xcp[i].ddev)
 			break;
 
-		p_ddev = adev->xcp_mgr->xcp[i].ddev;
-		drm_dev_unplug(p_ddev);
-		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
-		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
-		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
-		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		/*
+		 * Stop new opens, but keep the partition DRM device and its
+		 * minors alive. Existing drm_file objects still point at these
+		 * minors, whose ->dev was redirected to the primary DRM device
+		 * when the XCP device was allocated.
+		 */
+		drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
+	}
+}
+
+void amdgpu_xcp_dev_fini(struct amdgpu_device *adev)
+{
+	struct amdgpu_xcp *xcp;
+	struct drm_device *p_ddev;
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	for (i = 1; i < MAX_XCP; i++) {
+		xcp = &adev->xcp_mgr->xcp[i];
+		if (!xcp->ddev)
+			break;
+
+		p_ddev = xcp->ddev;
+
+		/*
+		 * Normally this was done by amdgpu_xcp_dev_unplug(). Also
+		 * cover initialization unwind and other release paths.
+		 */
+		if (p_ddev->registered)
+			drm_dev_unplug(p_ddev);
+
+		/*
+		 * The primary DRM device is in its final release callback, so
+		 * every file that acquired a reference through these redirected
+		 * minors has completed drm_minor_release(). It is now safe to
+		 * restore the partition device and free it.
+		 */
+		p_ddev->render->dev = xcp->rdev;
+		p_ddev->primary->dev = xcp->pdev;
+		p_ddev->driver = xcp->driver;
+		p_ddev->vma_offset_manager = xcp->vma_offset_manager;
+		xcp->ddev = NULL;
 		amdgpu_xcp_drm_dev_free(p_ddev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 33157409eda0..e2fd32af9932 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -181,6 +181,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 				const struct pci_device_id *ent);
 void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
+void amdgpu_xcp_dev_fini(struct amdgpu_device *adev);
 int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 			   struct amdgpu_fpriv *fpriv,
 			   struct drm_file *file_priv);
-- 
2.53.0

