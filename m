Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F46AC2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 07:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA8C206E9
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 07:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EN5Fvb+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA8C206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17946EC84;
	Fri, 10 Apr 2020 07:59:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC38B6EC84
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 07:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOsfxdj/vyDsgUWEC/fTIlgyF52oOTZ2MD9Uc7LQADm8ddu8Ty+UZu1v1DpJ2dAO6A8rex+WGMPdcXk6h2OZiEkuHqzc9IVWx4ltAQAxuPd/WKzhESU5QDRZys4L2HhmBEWSb3CJ0dsg4XLiirhaQmTXowxup/j/Fk+1irjuhgkqb9wPc/QOgrcBw1YoJxUPwkqB9ujKVdDinDj96DfTCLqqVMFkoAv2y7LT7um8Vkf2CWgXltayvicfRRMlT7AMwIkUoR89gcnH0pQV63iIFNrKNl1vOditXcpZo8EPMiIMjB52IdoboLbHzSFN01IxJKQF61uoPLBn684tb0IHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0sLPkxKvvBzz3Atr20hE+dhh1AWtT4kTf1+H/exh3A=;
 b=lxGmqdn23lxpwtH+RDdq7MNB6Kqt1lq9ULPdqTMOCl8AGfYgcLotwNuj2kwQoDx16MBQbiGDQU8E7oH9a7l6FaxxGqfBBuw0PGqklS++MgFrBsmlfHM/4qJ475ZLZ8cj/qZeTTULH1yFqOFUEY1aPuvaYkJGM4ENTAoxY+TCFF9Spui8BHZw+qbs69SNdk0m2QzRbvUecW+/hk6fiChNqsJRR0x9Czo6QOU1qYuFdNQMxvzbNAFWMdS5lb2i6N24sHVFI8Ny8kGDzfT2YiH0vczuEwH4v5kA/I3qriTmOJz13y69r/h809N+BzB0MzGTWZGP2VCRQmwK0zYK/qKRWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0sLPkxKvvBzz3Atr20hE+dhh1AWtT4kTf1+H/exh3A=;
 b=EN5Fvb+WbyGny9mcZiHSfzHy1En4VHshIVnVaMA3A21GZ/1ajK00ueksGM7rzvx4uoQDo17Fcjftvet/4IVFFUo/tZKg6g/eaYavPEXUhG3U3oXYONDBprgYfG++OFH9Zzc2Ypt4pp3PHhZmHOMeXi4IbkYybScYw4xTmbYaPf0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1524.namprd12.prod.outlook.com (2603:10b6:405:4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 07:59:27 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::60b6:8e56:2853:614a%5]) with mapi id 15.20.2878.022; Fri, 10 Apr 2020
 07:59:27 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: refine ras related message print
Date: Fri, 10 Apr 2020 15:59:09 +0800
Message-Id: <20200410075909.4610-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR0401CA0006.apcprd04.prod.outlook.com
 (2603:1096:202:2::16) To BN6PR12MB1283.namprd12.prod.outlook.com
 (2603:10b6:404:19::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR0401CA0006.apcprd04.prod.outlook.com (2603:1096:202:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Fri, 10 Apr 2020 07:59:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a7218c9-17e3-4dfd-316e-08d7dd251752
X-MS-TrafficTypeDiagnostic: BN6PR12MB1524:|BN6PR12MB1524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB152423DA734E9BA0DD21A76CF1DE0@BN6PR12MB1524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(16526019)(66946007)(66556008)(81156014)(2616005)(956004)(5660300002)(8936002)(2906002)(66476007)(86362001)(186003)(15650500001)(6666004)(7696005)(6636002)(316002)(478600001)(8676002)(52116002)(4326008)(1076003)(44832011)(36756003)(6486002)(26005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR2E58CKxsytGeNhB+wu8ad5wjUBYZsajNiRpVXjukkfy6n7YlXE/ue6ZHwE0R/2Rq8ns+6+EaWSiuZa7oL+C/nQoaIVw3tKiIKM72F2SFWT/fc5NT5u61+wMxR8RxS7XH/QH1GnLTBE5S/4DrQea351ioRChnfk3INe66HdIhLwUU7wPkCeUzSzBQsZnMmkoadIzJSfpqfvKBmpOyGSfZR1JbP+qo918QnLZIxAV4sFsjbl9OptXnoj/o0O0XWFqxc1wjnx4lb9KhTRTvxE3Et2d1SOBxH9RYArbQb0EoflRok1v6BvuTyLkdgn4P8LnkemWTOdJ29A7DTbUlK1UblFmzfAsfWr+qrxRPG4IxpSeRKpKwZz/7P1YWnZ7t7k9lZRhPn4FxSi1lSVhmTLI8h+Xz7iUud95Kh/CAK7Y6eKUxZw3tVaKvrsd+JPfnyo
X-MS-Exchange-AntiSpam-MessageData: j0MMExXi4Sg/9Wn337k7Ecu3/5RLQ4A79DILFcZBPMoF21dw6uBLuNoI/8LgTh8teEK64V2ahxh4HZ82rSqEraP0QgL4bdHPOLQSWpQCvKRLUnpoYnBOUvURFwx0XpP69EoUeA76MAaqEs6jS57gew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7218c9-17e3-4dfd-316e-08d7dd251752
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 07:59:27.3854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTAjs21QPcU3zrSAWh0FXilcb3iQUxq2Y0FLqv8aYlx5pMyQl5dr1mmuwCz9cSGA/9wO2zKuXg3jKHrIYn/y2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1524
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prefix ras related kernel message logging with PCI
device info by replacing DRM_INFO/WARN/ERROR with
dev_info/warn/err. This can clearly tell user about
GPU device information where ras is on. And add some
other RAS information printing to make it more clear
and friendly as well.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 51 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 10 +++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  | 16 +++++---
 3 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b0aa4e1ed4df..73ae913aee26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -296,7 +296,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	int ret = 0;
 
 	if (!amdgpu_ras_get_error_query_ready(adev)) {
-		DRM_WARN("RAS WARN: error injection currently inaccessible\n");
+		dev_warn(adev->dev, "RAS WARN: error injection "
+				"currently inaccessible\n");
 		return size;
 	}
 
@@ -324,7 +325,8 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 		/* umc ce/ue error injection for a bad page is not allowed */
 		if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
 		    amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-			DRM_WARN("RAS WARN: 0x%llx has been marked as bad before error injection!\n",
+			dev_warn(adev->dev, "RAS WARN: 0x%llx has been marked "
+					"as bad before error injection!\n",
 					data.inject.address);
 			break;
 		}
@@ -590,7 +592,8 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	if (!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, &info, enable);
 		if (ret) {
-			DRM_ERROR("RAS ERROR: %s %s feature failed ret %d\n",
+			dev_err(adev->dev, "RAS ERROR: %s %s feature "
+					"failed ret %d\n",
 					enable ? "enable":"disable",
 					ras_block_str(head->block),
 					ret);
@@ -632,7 +635,8 @@ int amdgpu_ras_feature_enable_on_boot(struct amdgpu_device *adev,
 			if (ret == -EINVAL) {
 				ret = __amdgpu_ras_feature_enable(adev, head, 1);
 				if (!ret)
-					DRM_INFO("RAS INFO: %s setup object\n",
+					dev_info(adev->dev,
+						"RAS INFO: %s setup object\n",
 						ras_block_str(head->block));
 			}
 		} else {
@@ -758,12 +762,17 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		dev_info(adev->dev, "%ld correctable errors detected in %s block\n",
-			 obj->err_data.ce_count, ras_block_str(info->head.block));
+		dev_info(adev->dev, "%ld correctable hardware errors "
+					"detected in %s block, no user "
+					"action is needed.\n",
+					obj->err_data.ce_count,
+					ras_block_str(info->head.block));
 	}
 	if (err_data.ue_count) {
-		dev_info(adev->dev, "%ld uncorrectable errors detected in %s block\n",
-			 obj->err_data.ue_count, ras_block_str(info->head.block));
+		dev_info(adev->dev, "%ld uncorrectable hardware errors "
+					"detected in %s block\n",
+					obj->err_data.ue_count,
+					ras_block_str(info->head.block));
 	}
 
 	return 0;
@@ -807,13 +816,13 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		ret = psp_ras_trigger_error(&adev->psp, &block_info);
 		break;
 	default:
-		DRM_INFO("%s error injection is not supported yet\n",
+		dev_info(adev->dev, "%s error injection is not supported yet\n",
 			 ras_block_str(info->head.block));
 		ret = -EINVAL;
 	}
 
 	if (ret)
-		DRM_ERROR("RAS ERROR: inject %s error failed ret %d\n",
+		dev_err(adev->dev, "RAS ERROR: inject %s error failed ret %d\n",
 				ras_block_str(info->head.block),
 				ret);
 
@@ -1549,7 +1558,7 @@ static int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 							&data->bps[control->num_recs],
 							true,
 							save_count)) {
-			DRM_ERROR("Failed to save EEPROM table data!");
+			dev_err(adev->dev, "Failed to save EEPROM table data!");
 			return -EIO;
 		}
 
@@ -1577,7 +1586,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 
 	if (amdgpu_ras_eeprom_process_recods(control, bps, false,
 		control->num_recs)) {
-		DRM_ERROR("Failed to load EEPROM table records!");
+		dev_err(adev->dev, "Failed to load EEPROM table records!");
 		ret = -EIO;
 		goto out;
 	}
@@ -1651,7 +1660,8 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 					       AMDGPU_GPU_PAGE_SIZE,
 					       AMDGPU_GEM_DOMAIN_VRAM,
 					       &bo, NULL))
-			DRM_WARN("RAS WARN: reserve vram for retired page %llx fail\n", bp);
+			dev_warn(adev->dev, "RAS WARN: reserve vram for "
+					"retired page %llx fail\n", bp);
 
 		data->bps_bo[i] = bo;
 		data->last_reserved = i + 1;
@@ -1739,7 +1749,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	kfree(*data);
 	con->eh_data = NULL;
 out:
-	DRM_WARN("Failed to initialize ras recovery!\n");
+	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
 	return ret;
 }
@@ -1801,18 +1811,18 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-		DRM_INFO("HBM ECC is active.\n");
+		dev_info(adev->dev, "HBM ECC is active.\n");
 		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
 				1 << AMDGPU_RAS_BLOCK__DF);
 	} else
-		DRM_INFO("HBM ECC is not presented.\n");
+		dev_info(adev->dev, "HBM ECC is not presented.\n");
 
 	if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
-		DRM_INFO("SRAM ECC is active.\n");
+		dev_info(adev->dev, "SRAM ECC is active.\n");
 		*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
 				1 << AMDGPU_RAS_BLOCK__DF);
 	} else
-		DRM_INFO("SRAM ECC is not presented.\n");
+		dev_info(adev->dev, "SRAM ECC is not presented.\n");
 
 	/* hw_supported needs to be aligned with RAS block mask. */
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
@@ -1869,7 +1879,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (amdgpu_ras_fs_init(adev))
 		goto fs_out;
 
-	DRM_INFO("RAS INFO: ras initialized successfully, "
+	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 			"hardware ability[%x] ras_mask[%x]\n",
 			con->hw_supported, con->supported);
 	return 0;
@@ -2055,7 +2065,8 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		return;
 
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
-		DRM_WARN("RAS event of type ERREVENT_ATHUB_INTERRUPT detected!\n");
+		dev_info(adev->dev, "uncorrectable hardware error"
+			"(ERREVENT_ATHUB_INTERRUPT) detected!\n");
 
 		amdgpu_ras_reset_gpu(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 8ffa015bc1dc..af1b1ccf613c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -110,7 +110,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		 * even NOMEM error is encountered
 		 */
 		if(!err_data->err_addr)
-			DRM_WARN("Failed to alloc memory for umc error address record!\n");
+			dev_warn(adev->dev, "Failed to alloc memory for "
+					"umc error address record!\n");
 
 		/* umc query_ras_error_address is also responsible for clearing
 		 * error status
@@ -120,13 +121,14 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 
 	/* only uncorrectable error needs gpu reset */
 	if (err_data->ue_count) {
-		dev_info(adev->dev, "%ld uncorrectable errors detected in UMC block\n",
-			err_data->ue_count);
+		dev_info(adev->dev, "%ld uncorrectable hardware errors "
+				"detected in UMC block\n",
+				err_data->ue_count);
 
 		if (err_data->err_addr_cnt &&
 		    amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt))
-			DRM_WARN("Failed to add ras bad page!\n");
+			dev_warn(adev->dev, "Failed to add ras bad page!\n");
 
 		amdgpu_ras_reset_gpu(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 72bdd06ed508..e629156173d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -323,14 +323,20 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		obj->err_data.ce_count += err_data.ce_count;
 
 		if (err_data.ce_count)
-			DRM_INFO("%ld correctable errors detected in %s block\n",
-				obj->err_data.ce_count, adev->nbio.ras_if->name);
+			dev_info(adev->dev, "%ld correctable hardware "
+					"errors detected in %s block, "
+					"no user action is needed.\n",
+					obj->err_data.ce_count,
+					adev->nbio.ras_if->name);
 
 		if (err_data.ue_count)
-			DRM_INFO("%ld uncorrectable errors detected in %s block\n",
-				obj->err_data.ue_count, adev->nbio.ras_if->name);
+			dev_info(adev->dev, "%ld uncorrectable hardware "
+					"errors detected in %s block\n",
+					obj->err_data.ue_count,
+					adev->nbio.ras_if->name);
 
-		DRM_WARN("RAS controller interrupt triggered by NBIF error\n");
+		dev_info(adev->dev, "RAS controller interrupt triggered "
+					"by NBIF error\n");
 
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
