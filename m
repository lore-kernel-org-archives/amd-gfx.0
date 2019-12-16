Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2523C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 13:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EE6206CB
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 13:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EbEeBk8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EE6206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC7D6E195;
	Mon, 16 Dec 2019 13:30:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254C96E195
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 13:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdJRvpYZ5YtAJW+aVGSl+5WYNffoVfAhyTcrDsoXfpEfTG8K9nVpbb6rMHELxT6KprZPgfPk5v31kWqDwG7/98cIJ5Yg6vjyRfxBbiNzzhLW91nCeQw3G07G7Qy6oRG0PGBYIk9/N2/7exvLW3EwWQcppyrwQzeZuUz8Fmc0sIeY92ituN7LKxTiboOBKG7tfwSatNaKCrWna2sK2jbR3Vf5OHQ1/0iUvO1Xzj9RrM1Xcpj+V8D3/cEv/+woPDeMhhVkEPTrueSdING8L+ZpYcj7Vw8aNa4sIPZcPl1cZgXcohS3ZBILFKxxDEWTTRbVHtwALaH9ux2gFBmbtWOuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQwIZm5M5QFeQHJhn51MqY32b1BpLoofu08/XGtTVvA=;
 b=M7qvtLa2xCBcr/i54QI7lWifFK/uEPHK3JQT9HyMGZ8zmLMWDtDV0OGG1z1+t4IjuItF0OdyoH7NSKWp2uU1BKJ+BU+5bD6NOshKLkJPtxN6wPwJKWHSfzGhxHvw4XLRYlFtTmNubEAdWVEmEVOpblMdKP3sAymBH8F0U4JrB7pTJqzg3l/0Ia76EFLYY13Lha7HgOzKjlq/JdJ31BzFxDqh0yARqH+Ek38bkOF41cQfm27/dvIfymD6FSJBsPIWEiaL7IJAAaPExfAZ6C4P+yfOhJ8zm8OJ+DT4IXymXW9B0boh3c49U+WO6D7SItyNEKepcWI2DlT70X4QA/bzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQwIZm5M5QFeQHJhn51MqY32b1BpLoofu08/XGtTVvA=;
 b=EbEeBk8k5EvMRNa0SVxmG+fs/QeooDonnB1qOwfZ+Q+ePPTrVlLzEX1qTTpgBP7ciy0b0TcpbztnQTv/FD+xguL1H8wLxRRvwLCAbSKovY/YZm8p4Txk6/eFWIg/XGDrj1oh82aTMscbh+VEw5mmkYGBf5Ig4rP3xDD9vFda4Kg=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1835.namprd12.prod.outlook.com (10.175.88.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 13:30:25 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b%5]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 13:30:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
Thread-Topic: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
Thread-Index: AQHVsZLiDgVyL8fwz0S+fCSOBSHcLae8xrXg
Date: Mon, 16 Dec 2019 13:30:25 +0000
Message-ID: <DM5PR12MB14185AA2E5909DEA2367F206FC510@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191213085334.17618-1-guchun.chen@amd.com>
In-Reply-To: <20191213085334.17618-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-16T13:30:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=83129ab7-2c72-4813-b440-0000a2d91b3a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-16T13:30:22Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dd8bfca1-f70e-4ba7-88f9-00008335b36e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 569bafa9-a3d8-410e-53ea-08d7822c1c09
x-ms-traffictypediagnostic: DM5PR12MB1835:|DM5PR12MB1835:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB183505BC9A6A43E12DD7CD49FC510@DM5PR12MB1835.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:146;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(13464003)(199004)(189003)(316002)(110136005)(7696005)(6506007)(53546011)(86362001)(52536014)(5660300002)(186003)(66556008)(26005)(64756008)(66446008)(66476007)(76116006)(66946007)(478600001)(55016002)(2906002)(8936002)(9686003)(8676002)(81156014)(81166006)(33656002)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1835;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZzBHRW1V1psfdzTWChuYh9VxDfdOupSlrUPwqZYGi00O6XEpclNxj8wqcs78WI2wqiJ5P0Aavj3T+3k7D5FYcF4YjU8w9RMniG4RKnxHNANAxuBe+bVUSyUZtLnE8xBCSN2XIxKR4TMAaPiB0QuNeJRrrmhqboZD8VJG4QfK3lMUs5xdEK+0oHl9U3wmDdT2MJMPseA4G78ZAJoGpRVJQLidM5Mn9RoI1x1tmw8YCpXlBALw2sG9LDOE610lwiWXzNWCWBBrtbfyNaa5nwxR78WdZ3THfpBtfcpy6dEHV3pmXNzuE6Qg34swphozJN+vliMOiEr16JRDFdtpUtUkP1PfUNHgAeAXts1Ul0F/fujg51SWGsljGF5dPLNzH8hQUcL3vb5tvNEW7Pzh08RpMB26uTEq8XTrP0j1VNx6POQLYF2NJFKx+AYyu+lN5WdKnY8lUUTXoM3lzD4qmhAQMfZ7/KgAJecqTSbSn1xe5r7Kb6ndXx7+qBXRVK+Ci3I
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569bafa9-a3d8-410e-53ea-08d7822c1c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 13:30:25.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/nRVDG6zYvKLq/yXsM+UVQOGD/mYeemF+5sofmbvmbjbeVToJ5begymZRDooV1eNRz2hf+FwWXoJ9BBJlsKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Sent: Friday, December 13, 2019 16:54
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu

BACO reset mode strategy is determined by latter func when calling amdgpu_ras_reset_gpu. So not to confuse audience, drop it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 4 ++--  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 3 +--  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 52c27e49bc7b..056c7e7a6040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -641,7 +641,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 		if (adev->gfx.funcs->query_ras_error_count)
 			adev->gfx.funcs->query_ras_error_count(adev, err_data);
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f4ba408aee0..e9f8decfbc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1872,7 +1872,7 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
 		 * See feature_enable_on_boot
 		 */
 		amdgpu_ras_disable_all_features(adev, 1);
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
@@ -1935,6 +1935,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		DRM_WARN("RAS event of type ERREVENT_ATHUB_INTERRUPT detected!\n");
 
-		amdgpu_ras_reset_gpu(adev, false);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index d4ade4739245..a5fe29a9373e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -494,8 +494,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);
 
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,
-		bool is_baco)
+static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6361b2c9ae1a..9bbe819de46a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -160,7 +160,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry)
 {
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	amdgpu_ras_reset_gpu(adev, 0);
+	amdgpu_ras_reset_gpu(adev);
 
 	return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index d4fb9cf27e21..8a6c733d170c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -132,7 +132,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 						err_data->err_addr_cnt))
 			DRM_WARN("Failed to add ras bad page!\n");
 
-		amdgpu_ras_reset_gpu(adev, 0);
+		amdgpu_ras_reset_gpu(adev);
 	}
 
 	kfree(err_data->err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index bb701dbfd472..7091782266b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -339,7 +339,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		/* ras_controller_int is dedicated for nbif ras error,
 		 * not the global interrupt for sync flood
 		 */
-		amdgpu_ras_reset_gpu(adev, true);
+		amdgpu_ras_reset_gpu(adev);
 	}
 }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
