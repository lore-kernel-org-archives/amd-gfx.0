Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CE06188B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 02:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CE06188B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CBE89F9F;
	Mon, 22 Mar 2021 02:55:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8863789F9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXd2/2ILMah85Umgj5G7vnk0DBvSXhiU++wvYnW/e/VFTz6mPmtRP8RK2Jy9Nk1CMJq2qgjPGrTjr4yeFv0xkn20O2OfjURZX2GD2C385CXbGAvOkhPavEiSy3sU4m73KOn2VPh+TVYDVZNN2QNETVfWeL4ojdF0c+GCPK6amIqZIeXsfcmf1OUtcS6iC0CoaVPRMrVV8OaUs+7o26A6IgpLcwlTkgTl4t+9eqy7sQkSn7kiXq55a6/5Y72/f9LfvzwgfzTUQ/qQpuGhCtYyUJERo6pUD+KZFTAW5f6RSwjrEH3L88LzgXbziBdGAFAvvgJJ7wpGBweVLmhKKli33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XY4CksWKq13SglVdUHCe3NCobLwOslthlXFkBkWH6M=;
 b=QT2u96Tv+/p9yuk7rdaElvcYTWpJPtkLkHAK9a+M/+WXuzQ2FcKU3uRI2+R3n0ayFHh4GCZfMHUTMLDjUfKAtwCGg5vFZtPiV6jw0qItYCHtx6AO8L2/2JAp1S8XxT7/FQdcIf5N2OjxgA2UggyK1JtximjL8CisYmVJO7aj/etYUE3RU3SsPkGyjYGTTaqR7EAjbDF2iOnHYBbb49vRLsbDF5Ei2Cv65gQvMzzeWldhC4X8qkcyC5kg+lmrYf9MCn4AkaPkf2DsoJebONPokFRA4Y9h4OHJbkX09iWpuw28/MvpuM7gOp2XMSErPo6SXCVufnzi4x6SbQ1+1MpUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XY4CksWKq13SglVdUHCe3NCobLwOslthlXFkBkWH6M=;
 b=r8CefDSWdakov7SjUMuyMOuh+QoaIZIXV4RQOsywbWCfGN4R7rwZVHHX0krbgcsABdMEDUv40Dv8OhqzPrisaURSoL8ufhGc7uNtJxUgydXfloBf1G5i4CGFXvJQ57agk8jlJdgBELv4QJeyKh2ViBb4XDR9PsPV0D6k1wNKyOA=
Received: from MWHPR04CA0049.namprd04.prod.outlook.com (2603:10b6:300:6c::11)
 by BN6PR12MB1347.namprd12.prod.outlook.com (2603:10b6:404:1c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 02:55:04 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::a6) by MWHPR04CA0049.outlook.office365.com
 (2603:10b6:300:6c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 02:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 02:55:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:55:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 21 Mar
 2021 21:55:02 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Sun, 21 Mar 2021 21:55:00 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] SWDEV-275015 - drm/amdgpu: Track fences on KMS
Date: Mon, 22 Mar 2021 10:54:09 +0800
Message-ID: <20210322025410.30570-5-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210322025410.30570-1-Roy.Sun@amd.com>
References: <20210322025410.30570-1-Roy.Sun@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd06a52-ed24-4a7b-77b8-08d8ecdde43e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1347:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13470CF74F576883B67B1D58FF659@BN6PR12MB1347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: llc48v3v/k8x9p+uSz5ERoUP3KWZp7qXxnnoo8CMBBao4c90zAnLL1t76xhNALQkdnO72GcTd4OCcHK2N47NjGHJnti5zuCex7ySXtz6c7Gpv0YbphQw5DzchnPpb3s7YKGHdhGMbVtqWvT6z17VZdubeaCvkOohAI1xbrhCEJb0CGFpv59xMEv0FM4lmzPSHEu5ZiU4+ml3MY7iX9BerGPNgvuLKfzzc/9Qqm5m+qRxfQEpUUx8XN0hVe29YMV81B+SxMEtpjd2pinhSIR1Yclz8b5yClROGEGQ3CiAb/YXFbxwUq9lo8A6h9y1CWSJz4yguEU/g5loJIsKQH08zIjKHo/9zyeUdtzI0BVNGIN/NGcB8IrgKpeOEAAYcl2ezdcG8j0IJTGiD3ruA8XEGfVr3VgiHLw9TXOW9BbSEbLdumHvBTh3ETic//axjCZdLJpjE2L0yeCktA9RUTRskt3s8L38k8JZ4oWBlLtw85X7dRtBdGYTb+3R5RYu7gI5aHZicDyl4cyLjO7yS9QHff/E4+Zf0M8Y0N0Fs9E9qH5anZhAmRKqJAW8tHJOFWOgGNDSNoWMRejDMzfM4NhLm2oqZqZ1v7ui39wSJFnHCOazGYZo64CK/3ApTQQBfONy+O0XBNtMby+FHJdsGZFdP8poL6zNTdnyCUaalNhuWS3nPCV5TwonHOIdpBk+eeA7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(47076005)(86362001)(36756003)(336012)(478600001)(2616005)(82310400003)(8936002)(1076003)(316002)(26005)(186003)(81166007)(70586007)(70206006)(426003)(356005)(83380400001)(7696005)(82740400003)(36860700001)(4326008)(6916009)(8676002)(54906003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 02:55:03.2632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd06a52-ed24-4a7b-77b8-08d8ecdde43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1347
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
