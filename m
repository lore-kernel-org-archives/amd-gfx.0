Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AE3C2D0D8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F602246BA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="plhXsCQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F602246BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F03E96E2DF;
	Fri, 13 Dec 2019 15:40:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9116E2DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 15:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnqei8Epw9MJ2mvA6yOInm37zvuYkQpJCJfcLZYya0puQOJHbgxaKdrtCAbLAHISHPIJ3BvKlwTNPhbpQNp0neCC2jwYRFZ2amHPz4dnToNmo2A4zUsIoGOcAddTqnu0CmgTSbZTyAtFQvfO4YlX3yD4m3EYnEwrPKqlOPhfMwmd+2Cnpe7qz9Z5LjsFkna5ZIXVN7aW9PJ4u8Z7Swa+ysdk7NQuaYLrwHaQ8Hwl2lFAbdBZ0vLQ/TQQ0IoKu7TvjeOPN/1lBGVRGRKhYCFCtP5E4J9y6ZLhuYGdJuNmHDd57k5T3Xtv1XWaD4GbN1bh0qjEYp4MS1Ew/nuzQxz/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV6Pjcr/HluXLnJuDcf9BeEjko64obS17Yg4sO997PE=;
 b=LJTexkWj61Vk6VFHTFKMdhS+5hSjw0zVpU6WNoX/rk2nqAXt+N0f4/5J2M4QUmthkIfI7PUXm7PAw5GErW+SyF2fAOi3IfZdoInhgMfP8B882TTqhwvRKHeLlxIMhG9jrEeWE6UcL4Al+/61zDjofaAhBXOPipPfq6Di6YWubOeYQWwty6Zw8rIjfiItcIAjaCN/sG7mTaWWvZLNy0G50YLj0KHYw/tkZn3YuSQEWAHQAt6S94DDdpIz7swIr7+KE/VzlMqx+4k9LJCdmoLhkU4+y+66UYClL4e/QD1O6czr9/DJsgndq14GpQvhEViSNycPef9/Ko1UbxtK8qz8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV6Pjcr/HluXLnJuDcf9BeEjko64obS17Yg4sO997PE=;
 b=plhXsCQxak4nH5l6Ov2payf9OffYvDK6mDT4GYpR4vceWF+yYmXwKxpHhKrA/8hST0szj4DsNWMJqGdpQulJSYCjJ40woLHQTbQLCwtljO3ueNPFyCUVrTedF+idltDhw/LplJW4eZoXjXv6HVlv7aJi9Cdo1qqQ6cLo7OkRbfA=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1407.namprd12.prod.outlook.com (10.169.207.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 15:40:00 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 15:40:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
Thread-Topic: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu
Thread-Index: AQHVsZLiaF3YMlxYKkKevgPOpEQCVKe4M++j
Date: Fri, 13 Dec 2019 15:39:59 +0000
Message-ID: <MWHPR12MB1358292EEB0DD239F628E267F7540@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191213085334.17618-1-guchun.chen@amd.com>
In-Reply-To: <20191213085334.17618-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-13T15:39:59.186Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77fd99c0-e402-493f-fce6-08d77fe2b6b5
x-ms-traffictypediagnostic: MWHPR12MB1407:|MWHPR12MB1407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1407B89E6C97986EAAE1F160F7540@MWHPR12MB1407.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:73;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(316002)(66446008)(26005)(9686003)(66556008)(81166006)(81156014)(8936002)(8676002)(33656002)(66476007)(55016002)(64756008)(110136005)(66946007)(76116006)(7696005)(6506007)(86362001)(53546011)(186003)(2906002)(52536014)(478600001)(5660300002)(71200400001)(19627405001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1407;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GP12wF3iRggCAwqqKsFLHzhmEGiMj97QMxFNpKy8ciFOlgszgz9q26wP7dC+NTnWa3oi8Z54CSNL1uZJ/jPiide6HuWm8PrCavQy8N0ZUXYOQu49Eq8NveXNzFUdCCqhYgKShmvgnPxeIgeFXC3mBzIZuzBY4+AHfe9WgF6xKJz5hdtHKntkh/bDnQuzx2S3haYV2/2RmM4Betot6PlxS8HHzSlH4m6bO/FbbT7MccNenwoFPTVRvCCVY/PF1upZZE9Elc5DZ1RaIJ9HhlTO7BWYNLFv+kswe20L23+4FyKNtiGfli6xDwQTP7VwLhxFMgHnV1fd8X0Vw9dHwiMtKW1yFxMpAPPCajZj5Q5kZZKN3dGr9XYG9XGcxHXUXt7qDKP5en/2x3j/3yo6TyQxbE4zo/p8DlMBkHer4jGXezahEuDgB27WjHEP8i/Sh4rS
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fd99c0-e402-493f-fce6-08d77fe2b6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 15:39:59.8732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9Z53uJopZPY6U4SNVdl/sViBGaJwjS/vHqjIl/c42bagEo8vOBLd6OtTnL1xtx1YqTLImNSCx7U9UyrE8uBkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1407
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
Content-Type: multipart/mixed; boundary="===============0150470568=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0150470568==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1358292EEB0DD239F628E267F7540MWHPR12MB1358namp_"

--_000_MWHPR12MB1358292EEB0DD239F628E267F7540MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, December 13, 2019 3:53 AM
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhou1, =
Tao <Tao.Zhou1@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; am=
d-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_reset_gpu

BACO reset mode strategy is determined by latter func when
calling amdgpu_ras_reset_gpu. So not to confuse audience, drop
it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 52c27e49bc7b..056c7e7a6040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -641,7 +641,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device=
 *adev,
                 kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
                 if (adev->gfx.funcs->query_ras_error_count)
                         adev->gfx.funcs->query_ras_error_count(adev, err_d=
ata);
-               amdgpu_ras_reset_gpu(adev, 0);
+               amdgpu_ras_reset_gpu(adev);
         }
         return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 3f4ba408aee0..e9f8decfbc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1872,7 +1872,7 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
                  * See feature_enable_on_boot
                  */
                 amdgpu_ras_disable_all_features(adev, 1);
-               amdgpu_ras_reset_gpu(adev, 0);
+               amdgpu_ras_reset_gpu(adev);
         }
 }

@@ -1935,6 +1935,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *=
adev)
         if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) {
                 DRM_WARN("RAS event of type ERREVENT_ATHUB_INTERRUPT detec=
ted!\n");

-               amdgpu_ras_reset_gpu(adev, false);
+               amdgpu_ras_reset_gpu(adev);
         }
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index d4ade4739245..a5fe29a9373e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -494,8 +494,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev=
,

 int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);

-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,
-               bool is_baco)
+static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 6361b2c9ae1a..9bbe819de46a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -160,7 +160,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_devic=
e *adev,
                 struct amdgpu_iv_entry *entry)
 {
         kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-       amdgpu_ras_reset_gpu(adev, 0);
+       amdgpu_ras_reset_gpu(adev);

         return AMDGPU_RAS_SUCCESS;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index d4fb9cf27e21..8a6c733d170c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -132,7 +132,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device=
 *adev,
                                                 err_data->err_addr_cnt))
                         DRM_WARN("Failed to add ras bad page!\n");

-               amdgpu_ras_reset_gpu(adev, 0);
+               amdgpu_ras_reset_gpu(adev);
         }

         kfree(err_data->err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index bb701dbfd472..7091782266b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -339,7 +339,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device
                 /* ras_controller_int is dedicated for nbif ras error,
                  * not the global interrupt for sync flood
                  */
-               amdgpu_ras_reset_gpu(adev, true);
+               amdgpu_ras_reset_gpu(adev);
         }
 }

--
2.17.1


--_000_MWHPR12MB1358292EEB0DD239F628E267F7540MWHPR12MB1358namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Friday, December 13, 2019 3:53 AM<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ma, Le &lt;Le.Ma@a=
md.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@list=
s.freedesktop.org&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: drop useless BACO arg in amdgpu_ras_res=
et_gpu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">BACO reset mode strategy is determined by latter f=
unc when<br>
calling amdgpu_ras_reset_gpu. So not to confuse audience, drop<br>
it.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp; | 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp; | 3 &#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;6 files changed, 7 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 52c27e49bc7b..056c7e7a6040 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -641,7 &#43;641,7 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(adev-&gt;kfd.dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.funcs-&gt;query_ras_error_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gfx.funcs-&gt;query_ras_error_count(adev, err_data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_reset_gpu(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_RAS_SUCCESS;=
<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 3f4ba408aee0..e9f8decfbc69 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1872,7 &#43;1872,7 @@ void amdgpu_ras_resume(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * See feature_enable_on_boot<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_disable_all_features(adev, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_reset_gpu(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1935,6 &#43;1935,6 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_cmpxchg(&amp;am=
dgpu_ras_in_intr, 0, 1) =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN(&quot;RAS event of type ERREVENT_ATHUB_INTER=
RUPT detected!\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_reset_gpu(adev, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index d4ade4739245..a5fe29a9373e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -494,8 &#43;494,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *=
adev,<br>
&nbsp;<br>
&nbsp;int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev);<br>
&nbsp;<br>
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool is_baco)<br>
&#43;static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c<br>
index 6361b2c9ae1a..9bbe819de46a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
@@ -160,7 &#43;160,7 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_sram_ecc_flag(=
adev-&gt;kfd.dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return AMDGPU_RAS_SUCCESS;=
<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c<br>
index d4fb9cf27e21..8a6c733d170c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
@@ -132,7 &#43;132,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data-&g=
t;err_addr_cnt))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_W=
ARN(&quot;Failed to add ras bad page!\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_reset_gpu(adev, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(err_data-&gt;err_add=
r);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index bb701dbfd472..7091782266b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -339,7 &#43;339,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no=
_bifring(struct amdgpu_device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* ras_controller_int is dedicated for nbif ras error=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * not the global interrupt for sync flood<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_reset_gpu(adev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB1358292EEB0DD239F628E267F7540MWHPR12MB1358namp_--

--===============0150470568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0150470568==--
