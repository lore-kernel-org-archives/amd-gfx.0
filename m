Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C04C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 13:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D27964E40
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 13:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D27964E40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8EF6E51A;
	Mon, 22 Feb 2021 13:25:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19ED76E507
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 13:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4ehK9pWeuMD2HkFx0C+aPp2TWyhIwEnJLDuVJ2M5q0xKn/fdVudkmyt2+S+z8Qi3mpLtb+tYUk30GNzPiDXkKtLe/eXOpCAs+akZUqPZ0jzw+DTYB0JM7ka6XDeoQx49YB07+H0yBVcXVqxNEgnmPklBZXhbDwcqoHf5rSiBLQKQAliclTMOF3gkx3L2MkAluuPjwZ5dOKCQIkc8AkVvXa401AMkYQ+1tUBBKRcdCekRji07MuPzY8p0L3+bdzdYiTpbjVCFNxX1oaRE/WYANDTuhbC1PElLR78FcqFWtiIAZwnzOGMC0rk9rTYlp/VlcFb8FsH+kYTQw0URXgYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpnqzkyw7rCoeWYJQgbuKAYzcdNUH2bzA1SEVo/h374=;
 b=Cm8NqTltwUIsXg1yx9zJJsfl5LB/qx0t5oQLt/R0CXpvMIpNdHrgwdU2d1l+dQ0lNv8cG+F/Qs5Jcl6A2eS+F7YFVpJWiN9LCViaoGxaHRLvdq2v5t+1MYwGpORSs2hdhMCjtFOXMx1fmRHmZ60x5Xdk1E9TmN8ZknGwQ+p0f+1EB9YSiP++L/q9cx1K7C2UJyv5B9j6Oln17nU9y7BrxAvQ5Sg4QcAdMrQvIDXvjfEHYS4CD3V9XwpBPpcOYAfupTUuQy8IeZbhCJvGpfzhg6AM9k2unnlPedL5WhSYpztF73xrACYCiD+X/CLkvOnQzBIMRmNyCcsRC78UTGFxaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpnqzkyw7rCoeWYJQgbuKAYzcdNUH2bzA1SEVo/h374=;
 b=v6icYHlWNWMAQnUMYMQSduL2HLYDEvL+3bwnylYcQj0GmRn6OE4TUInMeSL2dPRQ6/1hTO/oo4RtRx11EdIwB5gB5/F7D/DWO0/bKtXWztdlYN+hpU+WPXfDaX+9BiLms37cAE+DaOgK4+OvC5DdJ9X9nyU2q6ebQzwpAkuo+CQ=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.31; Mon, 22 Feb 2021 13:25:49 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::bddf:50bb:25e4:80eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::bddf:50bb:25e4:80eb%7]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 13:25:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reserve backup pages for bad page retirment
Thread-Topic: [PATCH] drm/amdgpu: reserve backup pages for bad page retirment
Thread-Index: AQHXCReguaPdq51ddkipyumHthB8U6pkKQKg
Date: Mon, 22 Feb 2021 13:25:49 +0000
Message-ID: <DM6PR12MB407588C328E1C3B5628C7D39FC819@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210222123816.30957-1-Dennis.Li@amd.com>
In-Reply-To: <20210222123816.30957-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-22T13:25:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=cd620e7e-37b4-44fa-a2c6-43da0b4bb177;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f99146f6-03c1-4bb6-6010-08d8d7355ebd
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3081A93B735C915AC53C12FDFC819@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hfrfJiA3w1y6K1tfrCnp3LiyzcuVMaNa6HaSG5+OrehWGQiXy4vMJyXn2yY52n6XgO56jNr0JOTSfkD/AmhI1aTb2qSZFn2MVcCujgDYO8ympH7zpb/yurHnjSbznu0Cd2BuZbugQXhlOcYEOArroA/lHpUCHurruOnpJrTRq8ncAQ7b3u0UHFAgnTS12nYDoKxnzNLSdZXQ8GmlaaEeTxlJv23CENrb0nZ9QTba2pZrxiGMqJTmT3HEytaacy5AFFZVRewoSRj7akVUzQyaaBkpXs79kphBIi5SQ9nImGtVZXuy+eKhhSY7c/zd4I2rp8xaxj8JOiMAfduo8H820dnD5AiV4V+FJR6w99kOWcsFm9bdtFp4+Iykf228mDyQ5kYnOeE2XzM+Arefv2J3sW7a+6tGxLnH6yTWqvrEaTMGmFqkQY3U+P/lyGOBp/rjV074/Wu6EOulXXYbRIdbpaoTVwzJW5aINx8NgK49Ty366mdWz07WUvtof1RBrwOuxwFgZg2nVuGbK3qD70bL5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(26005)(9686003)(7696005)(55016002)(6506007)(5660300002)(52536014)(478600001)(8676002)(53546011)(86362001)(83380400001)(33656002)(186003)(71200400001)(316002)(6636002)(8936002)(110136005)(66476007)(2906002)(66556008)(66946007)(64756008)(4326008)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AxJwNq/ovxZwWTUr4Wok9S3DoD99DLWECiBaGJ9cKyZSW9PUP29LC/WJgv06?=
 =?us-ascii?Q?sHQ3CCQZ2lqqEVPTyI7m0fqBXCrJI/WuvFqfZpuPI/oK5fozuUXFe1IUUm02?=
 =?us-ascii?Q?HNqzQyuiVW3Ea91TFGk8evr7uw3OgpdBa8m4+NtqDwtmMcJab2CxvM3I7sSJ?=
 =?us-ascii?Q?oJ7GES2w2UXoWgjZqV8dK6SBnmpiJz7TEqeQUTzI3PSiPt8Di5JCGuCKiSPh?=
 =?us-ascii?Q?FQ79IkkvN2QDCzzzAhl2J+HREAsTXUt51YYDL4AkDJZin92psfKn0xJUVKX6?=
 =?us-ascii?Q?1Ws0we7S9lh8fX0TowM4lm75eYsyTyI9RTUUy6nUp6O8WMF09/vPPisdW2rh?=
 =?us-ascii?Q?Y/Z+y/l5Vdc+xtyZ7IUm/0OwjtOCTIEfXiiopsDihFJrUaH8wYXjRFv1I0oL?=
 =?us-ascii?Q?sDUd3+6/e56m+jFtyMVTTR6nZsUzpHzALNP9JW8dgSkw7SwmPVoBhd5ioOcp?=
 =?us-ascii?Q?I5u2YMukJ62ty9w36BUZ9WE7iI/Aa7+jXxb0VxsxYk3YkyRNHlETNFhGJ8MZ?=
 =?us-ascii?Q?egwcRt02COv2FDfLlUyFU6eAmxrr/9QYT3RLdUPLqXhvj5pKvXnKv4OivJJS?=
 =?us-ascii?Q?zC2vhHwZAqyoqQAsZbzqtIf+yVkurKTdfMr7xW8eSxjGQik1PVxEyk6i1HR8?=
 =?us-ascii?Q?vkKrtaGapivsf4zN7BI0DQEGGz9uAR0xm7pR+qMFVoOt5gMFpuMryhUROT5m?=
 =?us-ascii?Q?VRSpGT7jxlzY6ZePGuFi3U7n/mACbkGD6EljBkD/qKXHt8wmm13UH/GpTxPZ?=
 =?us-ascii?Q?p0whm6OTWL0yZNmQ3c5mKYTcz929NWOBfnUiDuXDSVPi5Ae2XLT94fQT6h8F?=
 =?us-ascii?Q?S49m5gHXGUmtYvr4TiMGjT/JEuQ3DCJNOGuAn1YZlWNQUHk08Zse3dl93W/d?=
 =?us-ascii?Q?N1IwTuuyf2vg/VqolCSvg+qbtsyOaDNfB6cpgj1JK9heKI7Ql3vAa8ohmz7P?=
 =?us-ascii?Q?vfi1kpim0VLOr+VGuSKn1KOZGkrTmgQt9BfIg+V++MSj/bOXTOJygRte35gJ?=
 =?us-ascii?Q?E+AqzAue2IfCTbq2moHviN8QQa306xbRDrIX3YpaiuLbhSog7mgbjTOXrOqI?=
 =?us-ascii?Q?o48A+Aie6PD7wcvDkwgOAHg+dHuW/5Ra6GabhM4cPedXWaxfyY+TbdPIoMXE?=
 =?us-ascii?Q?Ra1XznyhZwaYj+BZ8XKRnSvRp3kII97i9q3+y85oIk+gq8Vd0Kkfph4UKEdw?=
 =?us-ascii?Q?mWeMFrI5yzb+ej3bbzj5uOc7GXSLOjw/7RfPVb87HBtNahpmHHEzBp2chTLU?=
 =?us-ascii?Q?49kO7HdebMsCAQ924cOQYRzTxgwpURmAwA4EhZMTquMYczv3c/RdmWiolQUY?=
 =?us-ascii?Q?NFJs53Pvq9tHMQ1+cR+sieMM?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99146f6-03c1-4bb6-6010-08d8d7355ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2021 13:25:49.4906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/KevukCM956vgxjz7h1mcTfQLi90ZL/hlesHKSE6OM6fPKWtlHJl+JX3tLbiR0kIniGVs8LjB4XmDTBnyUjmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+	if (!con->bad_page_cnt_threshold) {
+		max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
+		amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+
+		ret = amdgpu_vram_mgr_reserve_backup_pages(
+			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+			con->bad_page_cnt_threshold);

This would reserve 0 page at time zero?

Regards,
Hawking

-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Monday, February 22, 2021 20:38
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: reserve backup pages for bad page retirment

it's not user friendly that users' visiable unused memories are decreased when bad pages are retired. Therefore reserve limit backup pages when init, and return ones when bad pages retired, to keep no change of unused memory size.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587484b2..ff4387bbfb1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -170,7 +170,7 @@ struct amdgpu_mgpu_info mgpu_info = {  };  int amdgpu_ras_enable = -1;  uint amdgpu_ras_mask = 0xffffffff; -int amdgpu_bad_page_threshold = -1;
+int amdgpu_bad_page_threshold = 100;
 
 /**
  * DOC: vramlimit (int)
@@ -804,7 +804,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * faulty pages by ECC exceed threshold value and leave it for user's further
  * check.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto, 0 = 
+disable bad page retirement, 100 = default value");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 93699ea4860c..fb1c3f6cef29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1779,7 +1779,7 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_device *adev,
 		tmp_threshold = max_length;
 
 	if (tmp_threshold == -1) {
-		val = adev->gmc.mc_vram_size;
+		val = adev->gmc.real_vram_size;
 		do_div(val, RAS_BAD_PAGE_RATE);
 		con->bad_page_cnt_threshold = min(lower_32_bits(val),
 						max_length);
@@ -1812,8 +1812,16 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	atomic_set(&con->in_recovery, 0);
 	con->adev = adev;
 
-	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
-	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+	if (!con->bad_page_cnt_threshold) {
+		max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
+		amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
+
+		ret = amdgpu_vram_mgr_reserve_backup_pages(
+			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+			con->bad_page_cnt_threshold);
+		if (ret)
+			goto out;
+	}
 
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 69ba8dd4f3ee..927d33d75c22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -52,6 +52,8 @@ struct amdgpu_vram_mgr {
 	spinlock_t lock;
 	struct list_head reservations_pending;
 	struct list_head reserved_pages;
+	struct list_head backup_pages;
+	uint32_t num_backup_pages;
 	atomic64_t usage;
 	atomic64_t vis_usage;
 };
@@ -127,6 +129,8 @@ uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);  uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);  int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size);
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages);
 int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
 				      uint64_t start);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 21d18efca277..b325b067926b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -28,6 +28,9 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages);
+
 static inline struct amdgpu_vram_mgr *to_vram_mgr(struct ttm_resource_manager *man)  {
 	return container_of(man, struct amdgpu_vram_mgr, manager); @@ -189,6 +192,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	spin_lock_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
+	INIT_LIST_HEAD(&mgr->backup_pages);
 
 	/* Add the two VRAM-related sysfs files */
 	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes); @@ -229,6 +233,11 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		drm_mm_remove_node(&rsv->mm_node);
 		kfree(rsv);
 	}
+
+	list_for_each_entry_safe(rsv, temp, &mgr->backup_pages, node) {
+		drm_mm_remove_node(&rsv->mm_node);
+		kfree(rsv);
+	}
 	drm_mm_takedown(&mgr->mm);
 	spin_unlock(&mgr->lock);
 
@@ -300,12 +309,14 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 			continue;
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
-			rsv->mm_node.start, rsv->mm_node.size);
+			rsv->mm_node.start << PAGE_SHIFT, rsv->mm_node.size);
 
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		atomic64_add(rsv->mm_node.size << PAGE_SHIFT, &mgr->usage);
 		list_move(&rsv->node, &mgr->reserved_pages);
+
+		amdgpu_vram_mgr_free_backup_pages(mgr, rsv->mm_node.size);
 	}
 }
 
@@ -322,6 +333,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 				  uint64_t start, uint64_t size)
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	struct amdgpu_vram_reservation *rsv;
 
 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL); @@ -332,14 +344,94 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 	rsv->mm_node.start = start >> PAGE_SHIFT;
 	rsv->mm_node.size = size >> PAGE_SHIFT;
 
+	dev_dbg(adev->dev, "Pending Reservation: 0x%llx\n", start);
+
 	spin_lock(&mgr->lock);
-	list_add_tail(&mgr->reservations_pending, &rsv->node);
+	list_add_tail(&rsv->node, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(man);
 	spin_unlock(&mgr->lock);
 
 	return 0;
 }
 
+static int amdgpu_vram_mgr_free_backup_pages(struct amdgpu_vram_mgr *mgr,
+					     uint32_t num_pages)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	uint32_t i;
+	uint64_t vis_usage = 0, total_usage = 0;
+
+	if (num_pages > mgr->num_backup_pages) {
+		dev_warn(adev->dev, "No enough backup pages\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = list_first_entry(&mgr->backup_pages,
+				       struct amdgpu_vram_reservation, node);
+		vis_usage += amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage += (rsv->mm_node.size << PAGE_SHIFT);
+		drm_mm_remove_node(&rsv->mm_node);
+		list_del(&rsv->node);
+		kfree(rsv);
+		mgr->num_backup_pages--;
+	}
+
+	atomic64_sub(total_usage, &mgr->usage);
+	atomic64_sub(vis_usage, &mgr->vis_usage);
+
+	return 0;
+}
+
+int amdgpu_vram_mgr_reserve_backup_pages(struct ttm_resource_manager *man,
+					 uint32_t num_pages)
+{
+	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
+	struct amdgpu_vram_reservation *rsv;
+	struct drm_mm *mm = &mgr->mm;
+	uint32_t i;
+	int ret = 0;
+	uint64_t vis_usage, total_usage;
+
+	for (i = 0; i < num_pages; i++) {
+		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+		if (!rsv) {
+			ret = -ENOMEM;
+			goto pro_end;
+		}
+
+		INIT_LIST_HEAD(&rsv->node);
+
+		ret = drm_mm_insert_node(mm, &rsv->mm_node, 1);
+		if (ret) {
+			dev_err(adev->dev, "failed to reserve backup page %d, ret 0x%x\n", i, ret);
+			kfree(rsv);
+			goto pro_end;
+		}
+
+		vis_usage = amdgpu_vram_mgr_vis_size(adev, &rsv->mm_node);
+		total_usage = (rsv->mm_node.size << PAGE_SHIFT);
+
+		spin_lock(&mgr->lock);
+		atomic64_add(vis_usage, &mgr->vis_usage);
+		atomic64_add(total_usage, &mgr->usage);
+		list_add_tail(&rsv->node, &mgr->backup_pages);
+		mgr->num_backup_pages++;
+		spin_unlock(&mgr->lock);
+	}
+
+pro_end:
+	if (ret) {
+		spin_lock(&mgr->lock);
+		amdgpu_vram_mgr_free_backup_pages(mgr, mgr->num_backup_pages);
+		spin_unlock(&mgr->lock);
+	}
+
+	return ret;
+}
+
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
