Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC271C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58E061931
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 03:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58E061931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4126E15F;
	Mon, 22 Mar 2021 03:05:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6692D6E15F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 03:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R66WmRtLPIs9Mm26rKCuGkD7nm9uAlpi/yTKVSb7rMfRLiwRkKwPEbN3qATNh/QcZabaKwHwNz1Zau8kDNa9Xlguj7vRZdo7XCPfNSddUnFEQQbDf5COKUVd5PYz+GzyjkZkz/YphLnZfE+t71I3q1EPGVit0xdZqM9njx0DQQ3cphh8XFYzI53ika+yyQRgiDgFvM4aRB+ciGnmRsMMmRP1d0uOgBIkCv0oe9YvTaxcEX4GFSe8aafc2P5WhkT5JzW12okEei10B/eNsHEg1uYFOS95t/nVclcS3opZIty7waYYOcN3rnpqxR6MTwBtcCyDp1BzG8waAoCaVCqiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XY4CksWKq13SglVdUHCe3NCobLwOslthlXFkBkWH6M=;
 b=B6gXcaVy71VJopz2L1QTSNxz9K7YBvKG1CUBw5HQuVSRNICv8XbH9Rzdou4TYDAlOzJ1uA1RSzoivXKi/U2S+roWZuw3LPRwpWpPOsuR0BcbyYsIsrET7YWhiSkiolS0HqbR0dSfHpzjS/SvezpCMl4yzy5TxcJrooU35KHPKETl0CZag9iphtONm3BDcHwv0p1AkzxHh0LiHIeJmBY6BG0Af5m3l1sPHAV39WGEm29l6gQ/qsd2X51ZyqPy8I0aokl0F3cVH8/9ImKxbSfB3Uyy91WDm/5TiqIXMVODi3MEEHRt8oTtxuU9+AD9avIHbtJITXbkB4AtuqacrxJCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XY4CksWKq13SglVdUHCe3NCobLwOslthlXFkBkWH6M=;
 b=10WM+NsshFITIdlyoylOPTeVVum4liOrp9wav0zpf+NRkHLYodtRl/e7jN6nuh38DB13HyOIo497fHe/XbeNZ49rQl+OnvbP+QAzP9d4kTOSr97PqEFX9VD215bDMVgUap1NAKvAeNM8tsDdDJaTzUHUBcOXyD7YXzOceA9gNQU=
Received: from BN8PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:d4::39)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 03:05:20 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::ec) by BN8PR04CA0065.outlook.office365.com
 (2603:10b6:408:d4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 03:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 03:05:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 22:05:19 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 22:05:18 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: Track fences on KMS
Date: Mon, 22 Mar 2021 11:05:09 +0800
Message-ID: <20210322030510.31607-5-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322030510.31607-1-Roy.Sun@amd.com>
References: <20210322030510.31607-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fef79c6-235e-4e3f-aef4-08d8ecdf543b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4407:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4407E51877C9CF05BDF08577FF659@MN2PR12MB4407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MRUmYBduBU3utyDZakOODtjC3SMXomB2lHS3z81iWGL6maC0EnPJdgFnE0I+tM9wZ5Sg0POR15H8V6yIdpS0BuHt+R78nte/3T7tdjvEUbNpc6hjN+YEs7ZTSrE/CrUZEjpFuLnPQpWYVPZMMf+1Tji7yvh+yKxsX6XIp539gsFb2fJSsX2dww5j3BGIctE5oBKTXAFRT/KbZeFod3bd42+PhyCz5KLSym5s+OBgr+o2vjhqRHgsXH14rMMmhWDsCIFxmNBoQmdOamGz6iDnadC4ohBpMFFQsz5SgQw18Ma5TdrSDyXx4qXLsxx2/ZQEF7jjUmxFs02iKye3YThb9vY9QdDk+GIrLFGbHtRgC8n4T/vAAo2h0sHphYckuzUQSuMhCniI/hlRx2JGk6+wIKZXUzpHxaxgEiNRrCSFsgew1zt4qhvNNZ23TidqWAPlSOIe54L6nDAW2KUwFpqZEsQBvluUQiT/G55drAYaWQ892y2ADXDWTGUUQsH8tOVVhlxw5R2IXXoo1S6mdU3DWkpAxMhK9FGDMPrNnXfUHTsZU79fWEl0LcZF3tAXu7gzh3rC/4giBCMWbFJ65r4VEYR35gpTMOcVCHq3IuvwGrOlE9OyonszCUZ9wbA8XfdKi3Wel/NCmhlNI4L5zVEo6QFHQrOj2pcYsjecqeRNsisdeCjdyeml/jYho2N/W49
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(7696005)(8676002)(426003)(4326008)(6666004)(6916009)(1076003)(82310400003)(2616005)(5660300002)(478600001)(36860700001)(336012)(70206006)(70586007)(86362001)(2906002)(8936002)(26005)(83380400001)(81166007)(356005)(47076005)(54906003)(316002)(36756003)(186003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 03:05:20.7525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fef79c6-235e-4e3f-aef4-08d8ecdf543b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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
Cc: Roy Sun <Roy.Sun@amd.com>, yehonsun@amd.com,
 David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David M Nieto <david.nieto@amd.com>

Create SMI fence tracking structures of KMS open

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f98843eeb084..bc63a9662ca0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1679,7 +1679,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_display_freesync_ioctl, DRM_MASTER)
+	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_display_freesync_ioctl, DRM_MASTER),
+	DRM_IOCTL_DEF_DRV(AMDGPU_SMI, amdgpu_smi_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ada807de978b..c393cbf87656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -41,6 +41,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_smi.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -210,6 +211,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		pm_runtime_put_autosuspend(dev->dev);
 	}
 
+	/* SMI */
+	mutex_init(&adev->proc_lock);
+	idr_init(&adev->procs);
+
 out:
 	if (r) {
 		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
@@ -1135,6 +1140,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
 
 	file_priv->driver_priv = fpriv;
+	fpriv->file = file_priv;
+
+	amdgpu_smi_create_proc_node(adev, fpriv, pasid);
 	goto out_suspend;
 
 error_vm:
@@ -1177,6 +1185,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 
 	pm_runtime_get_sync(dev->dev);
 
+	amdgpu_smi_remove_proc_node(adev, fpriv);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
 		amdgpu_uvd_free_handles(adev, file_priv);
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
