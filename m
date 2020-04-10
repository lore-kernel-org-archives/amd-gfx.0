Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2AC2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 09:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E475206F7
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IHFUWboS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E475206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8996EC9C;
	Fri, 10 Apr 2020 09:25:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B996EC9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 09:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaRgIzv/5ALvy1Mx+JeEQcfaJmybqb0V8c3qNDg3T/4q0CFFzqKJJl7KYr1TjXFCNej7ZdP44ZI7694dhixS8T5B4S5RIG3f1M7iEvCfY+nLVq7cPhxhTVbKmUz6mz64Tv0eYKZCkiNycgjaCaEkZsfAafKg542j47E9K4lI/MBTygqJSpZpjpA2OMxAFE7UppQOKS7VJKdv9zr7Yhd+aWg+suqs8OOMf7/xkTSePuiX47tCZONNzCLpjWo3dc6eikQoAwWeJ5Xddwz4dq5hi/4M4W4+lk2LkAQogylSuhSt7fpBhwfcuZSfLMesR4B503i9qykEigjh6VKZJYl/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvVJaf2sSoQ1RRyfBj45Yfz8SJPlgWLZBKHy7sJYA+E=;
 b=Pqqvv5zM9vYhiOOuRsx2LgxDOycNmbX40exA+7QufmX9uLAYuYUQ2FyqnRiQqV7Ajo+dgV7XAwYCoX1v1nHzszVTTMqtPf4sjcJf1262qLAgqStqOHsTHCp8FVoM9uZb35mRljc2LbNNBMFnI0jEmijN1DzlYXhgvtO6LJC4/EeA3epshsNxsX/NHxejyqESg0BKLpLLgualX0I47AqTzn6HPr3xtN8X4p1vsf/TctQHXrQQf2i0QfYsmxSaxHFfYys9A7TrT5rhYzEWJ8nHeoKvsGFWwz/T437La0MJrEFM9ZFNWD8J/GIwOXPbpqCgRvkEq1NZFw5gRBrH502QfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvVJaf2sSoQ1RRyfBj45Yfz8SJPlgWLZBKHy7sJYA+E=;
 b=IHFUWboSVzwlQJBJoKXQz2WjTLCNp64xEVGyFsRpGOryD8iYKcj83vyA1fBU46j2ObaIqgEFpIpdzIkji63QxCtFgGknJy239IlYSJoJQ0UUAJlgKEUobgTJrUWOHqipOGPwl6NHdPOFi01G9DQdBc88QCLOCaeindqZctQTGK0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Fri, 10 Apr 2020 09:25:04 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.023; Fri, 10 Apr 2020
 09:25:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Li, Dennis" <Dennis.Li@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine ras related message print
Thread-Topic: [PATCH] drm/amdgpu: refine ras related message print
Thread-Index: AQHWDw32IrI9CqQAAEKSLox90UeN2KhyFVrg
Date: Fri, 10 Apr 2020 09:25:04 +0000
Message-ID: <DM6PR12MB407576FC68C60E1F16E5F12CFCDE0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200410075909.4610-1-guchun.chen@amd.com>
In-Reply-To: <20200410075909.4610-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-10T09:25:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1d99da58-3a91-494f-a228-0000d878d9bd;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-10T09:25:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d0a59ad5-dd75-4970-9f5c-000052c31113
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcde761b-c47b-402f-0220-08d7dd310d6a
x-ms-traffictypediagnostic: DM6PR12MB3594:|DM6PR12MB3594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35946A6EEBDA0DBFDF57CD62FCDE0@DM6PR12MB3594.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(186003)(9686003)(26005)(478600001)(15650500001)(5660300002)(76116006)(6636002)(86362001)(71200400001)(316002)(7696005)(6506007)(2906002)(66446008)(64756008)(66556008)(66476007)(110136005)(66946007)(52536014)(53546011)(8936002)(33656002)(8676002)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQ/nDKgg7WYL5AoTzVpiONiW1jNdrZe3nard5X0nK8hfo32DIktwF3EaM8rkuQ4tf2c6kT+EfXQpX1Z9vKf6Jciz9lZbTG2ESvUXXZykvVEcf+t13VBojmyBM92MX//r904JhaZBTnEIfH/VAVUx7bm+VE2uzr1Xq1eM6QoBqFAQ1EXE5w311mHekKc7Q3WWNW7W6KdzBkZL64wmE2zZNNOMVb9pbUqEvd8TYWO0M4w3TOjT59hGPMrQ41a1IJsgT8/XISt5VxsYpA0Ely0k7vzlJ7hlLhAVWrqdOcrM7UF0UJR/6qF9eU7eZkVv8h5D6TpXEF7xmqzh4iDNURNmhbMR7bOXmcJLtuyyBTuJ7ts1m5O5kHJFmHkmuKLUJYoCUk08IjNsohygpWA4GehgH/ijbR3N46YyRVUkxeUAopz8JGYNYQ3KXNuY6Cx4qd2g
x-ms-exchange-antispam-messagedata: 0sJ0s5wS/BDMu/h+ytsLrQHyLLT//5nK5m8GXVC30mTzRaAdHHLA+coMH8gdFiuA6V4zqQSvJUGNUXElitq7b/wmf9jsbyHT9DMEeieiTJQibrRX9NUzFzuYWmcdAnc15qtvcsapO4zZ38O1x4FoIw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcde761b-c47b-402f-0220-08d7dd310d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 09:25:04.3107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DjKoprZurlF50fri7ub196R6ZhemjCCvWXU3GePBi3gzasR0R0UQ6Ob7SvZZd0cNCUgYBR0SsxASaMMrJ2KMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, April 10, 2020 15:59
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: refine ras related message print

Prefix ras related kernel message logging with PCI device info by replacing DRM_INFO/WARN/ERROR with dev_info/warn/err. This can clearly tell user about GPU device information where ras is on. And add some other RAS information printing to make it more clear and friendly as well.

Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 51 +++++++++++++++----------  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 10 +++--  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c  | 16 +++++---
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
 	*hw_supported &= AMDGPU_RAS_BLOCK_MASK; @@ -1869,7 +1879,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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
