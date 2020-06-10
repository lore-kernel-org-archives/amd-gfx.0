Return-Path: <SRS0=jeuu=7X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2B4C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 10:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62230206F7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2020 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3c75FYYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62230206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1162688EF0;
	Wed, 10 Jun 2020 10:57:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 239EB88EF0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2020 10:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLgVbX5NZu334nwE336o4ekJrH8zyIGWhO1JhAsYO7DfBEPUIBmnPG1px5UrPXI4lTLWkSgZIzVTgWMC1VeXWv23xIOHP3rB/+Z89pZJuhAdRfoCoLYYVb1kB+zAbs3BHM+hkP8C6M5uS4pkZX+L4pq/TOfaxa7Mm8JbPfquR+C27GwGw3dH837wp/sdPWyWGqG69EfF8DWh4jzLxT4WpD7IHcFt2iL7mX7fLwtLWsFVKdEiBvzHs2GVWosjc3PHOtwoeSJq9IynZDFa64oe9UPL+AU8DAJiMcikRdtlZBlbbDw0UzN0+1PYtkm3QP3G7WWjbjDdrdVX6ggF5lYO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob9wDTXNyz1NHxWYfF1nQdGGeMt2RMl7fRCaVaDP1Do=;
 b=Ej5btI7WhtYR4NNpQ4KHkKFjvCqcodGrIEZrWzCtfAeCZwovEgX+5tA5LFbJqnu2haqNm5UqCqpJED6rI5r34ty+STKtI5EHnrw/24ue3ubTYO17zBd1R9+xB8NUkCRLmCnitWkzWmdsTSGc4uz+G9nJcSt9xiSc8r/yweBKylD6cx6TMQyjJNZZKBWvXh9eGRCqaVbf7NnG4OEkxJy9pDezpVAULF3M4liP6kGIBJjrXiRzsYzKUJ1W9TIHeHWSdzxbijMXQp3akGfBLBy3vNyKy9YGPLOOiaS0nAI6Bt1slZDm0FcJk0Nyl98CXjf8SBsihHQMHAQH4xgZuSBj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob9wDTXNyz1NHxWYfF1nQdGGeMt2RMl7fRCaVaDP1Do=;
 b=3c75FYYFYmkhFrZfR5N5J+JE8Rdycx7beIjngkyW044BVPQllt8mUrjQLf8IBC74m5GogudTQEqeN5yfvScZMF6Jdh8btDDostlusUA1nFr1Myj+HOHAxGs3KXoIEBt7oiCziM0KbYhLC3t5ZbrGp7p5VzZJ7XO1M+6zyTZrvmU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.20; Wed, 10 Jun 2020 10:57:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 10:57:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial
 number
Thread-Topic: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial
 number
Thread-Index: AQHWPwUjjUQvGtGEYU24/3ErTNSjyqjRrbNA
Date: Wed, 10 Jun 2020 10:57:29 +0000
Message-ID: <DM6PR12MB2619D7FBF176EEA50DB3E2AAE4830@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM6PR12MB26194168100E5F96FF94D066E4820@DM6PR12MB2619.namprd12.prod.outlook.com>
 <20200610085653.GA5439@mwanda>
In-Reply-To: <20200610085653.GA5439@mwanda>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=61133f07-20e3-48e3-be9c-0000b585cd10;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-10T10:57:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3cba574-bf6f-4552-0193-08d80d2d1196
x-ms-traffictypediagnostic: DM6PR12MB3372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3372174C916841CD3CA7B20CE4830@DM6PR12MB3372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93K2GhohQZAaiKFaSsAYY4WjNgaPLWPGtLo31eeCaa0ZJwRHJ5bC/APJKWpMciW1L406Ou9TaHeajMcZ8xOYIWe2SqP895F2xY5A9T1l9EbzYOZGUZJ052VfCL1TaL0tA1K+jXIJIzv2OUWr+lvpjDdRabuY43TbnhuBjMBgCCAx1YJfbUTCMs6lHf5xQBqPqCY9T54NN07cE/M1fKLdPQZByotzfk+I9l3ZmsQApcFvQRImhU6NrHjJlq6rVse3N/pB4kc9+iSa23Ac1WPd6oFlMMbGbyWbmTz0Q6fuXyINqD+NrTpDZeuIWdZwutCj9sl6gG/HHJIGcSzNvHyJHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(52536014)(8936002)(6506007)(71200400001)(5660300002)(6636002)(7696005)(83380400001)(8676002)(54906003)(33656002)(110136005)(2906002)(186003)(316002)(4326008)(53546011)(66556008)(66476007)(66446008)(26005)(478600001)(66946007)(64756008)(76116006)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 6woD4hZMM7m2fjiZbB8MZds6dRdMN6mUbyPTB4X0Sg5T5k21XZLG7gHY/m+PUEsMsGqEvcJ93ngpQyaF5fFnbsV2uyftXCLNYkGIMr0XrkWghkX1oqEIMK9XA9/ILmLarDmILiKSPDabVsJhEghj5VmiDIShnVs+K++3+Iqpsb0V97GkXmsPwoYlJWGNX/+jQ4cy21pty1xfQghnv+J1a9GER/TbT8kTj1E+wwtJnLvpOw76QBV+HW4HUrVwR0I5EB0PrehFbUc10AwS+zixX6eI7uNfFrwuR4PwVsN1RmqtXXrTWty1owBDIrXvVxw+ygRA5QXeefUAQ6CChuMGEKHRv1UsmtskWGyXA8mgYW1ypfqF2lIIetuLsJ5BlltwAwLtxERqy9yAV0ZTAseGXgPA0r+k1N4LB5K/abAtBni7+yt8oqaH1p+1Vjk0Xhjd/+1no1rwTTmDA0HVmc63VMAdrDOgQPg8PFM3dDxxqQCiASqZ4RrTbgWLHypCB7gR
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cba574-bf6f-4552-0193-08d80d2d1196
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 10:57:29.0869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0F2EaiB9XtrGcyiwNrIi8wwwqVA9BuRUGg4DFaUspBs8TZb8H5mwKuYOAnAeWtNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Greathouse, 
 Joseph" <Joseph.Greathouse@amd.com>, David Airlie <airlied@linux.ie>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma,
 Le" <Le.Ma@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>
Sent: Wednesday, June 10, 2020 4:57 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Ma, Le <Le.Ma@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-gfx@lists.freedesktop.org; kernel-janitors@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: Fix a buffer overflow handling the serial number

The comments say that the serial number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

The other issue is that "size" returned from sprintf() is the number of
characters before the NUL terminator so the memcpy() wasn't copying the
terminator.  The serial number needs to be NUL terminated so that it
doesn't lead to a read overflow in amdgpu_device_get_serial_number().
Also it's just cleaner and faster to sprintf() directly to adev->serial[]
instead of using a temporary buffer.

Fixes: 81a16241114b ("drm/amdgpu: Add unique_id and serial_number for Arcturus v3")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Change adev->serial.  The original patch would have just moved the
overflow until amdgpu_device_get_serial_number() is called.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h          | 2 +-
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 135530286f34f..905cf0bac100c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -986,7 +986,7 @@ struct amdgpu_device {
 /* Chip product information */
 charproduct_number[16];
 charproduct_name[32];
-charserial[16];
+charserial[20];

 struct amdgpu_autodumpautodump;

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index df7b408319f76..d58146a5fa21d 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2265,8 +2265,7 @@ static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 static void arcturus_get_unique_id(struct smu_context *smu)
 {
 struct amdgpu_device *adev = smu->adev;
-uint32_t top32, bottom32, smu_version, size;
-char sn[16];
+uint32_t top32, bottom32, smu_version;
 uint64_t id;

 if (smu_get_smc_version(smu, NULL, &smu_version)) {
@@ -2289,8 +2288,7 @@ static void arcturus_get_unique_id(struct smu_context *smu)
 /* For Arcturus-and-later, unique_id == serial_number, so convert it to a
  * 16-digit HEX string for convenience and backwards-compatibility
  */
-size = sprintf(sn, "%llx", id);
-memcpy(adev->serial, &sn, size);
+sprintf(adev->serial, "%llx", id);
 }

 static bool arcturus_is_baco_supported(struct smu_context *smu)
--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
