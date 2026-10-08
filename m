Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9CCA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 19:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A4610E974;
	Thu,  8 Oct 2026 19:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wTxC6vhq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9458810E974
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 19:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lezpg4FQTHne/wMJudyxwI7Xej97uY+ljbulWwII/eaNDcJ8/44BLgrf1JH2TYVOBr5jwnEG2tPJhf+4yDTrSvarlMabA+OQn0LHPyCrBnIKb3IAThIOf7F6ZwtEXvB6tF7noapgW2tzmoFXDoqASw5b3PXe++EI+d8TlY7owKpdgHQwbhc1ukYFpyUnDLIyZ0e/JXDDyp/GHwB2bwtxz2BjlgBBjT0IAB7kwIofjxgaFOQSOc95oziFjo7iycnjlrvOjW39CW/cjCgPl1xS8l5r3bmAARvXoNH3ZQhqbhqwVZW7lwkMi/RbA0UJtFDWflkuIvOO8ftHlavCRagJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeHgBNPDUexFI2VoQbzBDrN+F4WBlkZCkZIj2DhSnRI=;
 b=nZjTNR+PCK0u1G0aB9joKctVW0R7+Dzfu8r31paDSSJVMDn14pp2xghxCPEm3tNxnVSUDZrp0VQWEcfUSBNfQPcQ8gNA0Md8PynUQAgULoufQ4itFrDaqxHvGCC+F5x8RJ+URNDBqET8Gnryzg5Br/bXmrQ8CMwvRLOjWxva5dMJKu+sk9uB34fxXn5PjmLUAJ0xDFiT6ptezJhFiAn7WCnXgkptdYXdBHrCgNxeEn+OcTj1Wbcub7U7apXmkqVppG4Qi2OAA71mu5U9+gds9Pist/GbpBqtglVH7dufl0pq0C0lLs9bUjjPxCmLPJ5OOdcBhLOLHAC34UtnKKQdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeHgBNPDUexFI2VoQbzBDrN+F4WBlkZCkZIj2DhSnRI=;
 b=wTxC6vhqurrQz+rxV2+PfuOUVFFckKbFNBIl48vhc+A7bIuivS4r1dkJg8INbUtjgPSJsIgQbY28wV55cMz0rYUhqQDHxYW2PpR7gxKTPF5WbrTp7XsyTegmTxIRozE1EpA6XjXbH38uzMk+Zj6vkOdvDL5NkMJCnNKs9wZxUnU=
Received: from MW4PR03CA0211.namprd03.prod.outlook.com (2603:10b6:303:b9::6)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 19:28:28 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:b9:cafe::7e) by MW4PR03CA0211.outlook.office365.com
 (2603:10b6:303:b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 19:28:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 19:28:26 +0000
Received: from MKMLUIRSHAD03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 14:28:21 -0500
From: Luqmaan Irshad <luqmaan.irshad@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <yunxiang.li@amd.com>, <luqmaan.irshad@amd.com>
Subject: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary release
Date: Thu, 8 Oct 2026 15:27:42 -0400
Message-ID: <20261008192742.22943-1-luqmaan.irshad@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922205731.254264-1-luqmaan.irshad@amd.com>
References: <20260922205731.254264-1-luqmaan.irshad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: dc82ef8d-1af6-44ba-e5f9-08df25725328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BhPbAPXx2RSynuk+JXz5UWknpN2uPjKplFGeY84/TTJtb/iKRIT72glgOj6cl6zCq87qJplwWjmtJ+mNJxgKP9P/ogEw/H+sPhD9KtEJPNYmCftXFpFFrFzc2W0ZC7ql25miD/MINxgTNHtYSfL/A6fTlYCgjHni2W/JLfGcusoP7QxacJZaMAgGa+lpHwRffL8uB8qjlRSf/QlTLDF1AOafAqMmIfNrTfj176vvfdYgQDspqgWwOquNYIq6RzzFhv6TE7SuH/8eU7xBix7ajAqi/8jrPrZS1thop/NDzMikvVy7I2exKkGQ7/bvJDuEC6TjohVzUuxHKPt7YD6DZ309CjwHgxeSgbOlgy7ntNacFoY5Q0KR/t+p8/UCtBZSFAR0HL37Galx6LA9Vrh6hQIzh1c+gOUdfqZzmyNIH9rSb18311V2uL2JNQ/YCJjXDtfN7BeC0yVq7pFXPVrmS0DpbQjjVqBNJThTxTlBE8GDJ9sPcJMFtzoT1LrDda/P/Cxa6Ju9c5UMTkTeg/4IvjYNj8MdSBdCTp6a/mhXx53ZA1LYaigdNDH6D5XDzTX+i2q7fewJ47uSq8QJjawy1Gmb7P6HCALN+3BD4NjsKEYJkSGKEA+8HnLWqAFRh4KLiYJZi7b3DOZK0i4Ed3u5SY9VZZ2kwMuVvGsyLQEEEUzE8exyYyoxfceSukGKhVdewIMkaTQcPaUUbn3PysFZng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q273goGzmq9pPbA0ZSnL1pnQzBmVkWfVSrqudXAI1rLEthhS7mULmrf4ug5TQQc36DyFLfALH3xEgUtiJEmW+oinVEGTtQLglRNgPVjRkm6c0Ov4flq0xffJQ45e/6I9douhglojDLZrp4iqyrwp3q5n8QVY2pCGwFdHsuT3mZJP0mkuyHndxto0bteXlzlGzztKYcTGUAtrx5y4e1UB52/JYhWsHrSjLnsTo0739QUnIlQAjbsfbI4dR0kiUj7fmnw5cz/kBx/8EQlbYxke9IyjQkSQjxKux8tYyv7wfWsqQOMPEyCpcOUJ71o5z+B5CDPqe/1ksjIaHkBLbI/qTSiYeB0nHG+rdhGoRJdO07fGGPVAB+IHSpcRp20/G6xmzgsWZcmcJ65FdYcBdmlrDoYZIG/mm/F9BSBHAIr/BiVsaje3HyMBWMZqNUg6ggwC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 19:28:26.0239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc82ef8d-1af6-44ba-e5f9-08df25725328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555
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

XCP unplug currently restores the partition minors' device pointers to
the synthetic p_ddev and frees that device while files opened through
those minors may still be active. Those files acquired drm_device
references on the primary ddev because the minors were redirected at
XCP allocation time. After unplug reverses the redirection, close paths
operate on the already-freed p_ddev, causing a use-after-free and
p_ddev refcount underflow while leaking the matching primary-device
references.

Split teardown into two phases. amdgpu_xcp_dev_unplug() only calls
drm_dev_unplug() so new opens fail, leaving minor->dev pointing at the
primary device. amdgpu_xcp_dev_fini() restores the partition device
pointers and frees p_ddev from amdgpu_driver_release_kms(), when the
primary drm_device reaches final release and all references held by
redirected files have been dropped.

Signed-off-by: Luqmaan Irshad <luqmaan.irshad@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 40 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f2f179421c4d..f4bc9e6eb97b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1638,6 +1638,7 @@ void amdgpu_driver_release_kms(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_xcp_dev_fini(adev);
 	amdgpu_device_fini_sw(adev);
 	pci_set_drvdata(adev->pdev, NULL);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a8c79a66df1d..c780d6794b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -412,7 +412,6 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 
 void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 {
-	struct drm_device *p_ddev;
 	int i;
 
 	if (!adev->xcp_mgr)
@@ -422,12 +421,39 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		if (!adev->xcp_mgr->xcp[i].ddev)
 			break;
 
-		p_ddev = adev->xcp_mgr->xcp[i].ddev;
-		drm_dev_unplug(p_ddev);
-		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
-		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
-		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
-		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
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
+		/* Unregister devices on paths that did not unplug them earlier. */
+		if (p_ddev->registered)
+			drm_dev_unplug(p_ddev);
+
+		/*
+		 * All XCP minor files have been released, so it is now safe to
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

