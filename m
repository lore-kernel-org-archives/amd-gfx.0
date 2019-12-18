Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC16C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413B621582
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 02:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nCrE1lOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413B621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAAB96E21E;
	Wed, 18 Dec 2019 02:17:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDBE6E21E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 02:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no3SeZBL+ck6LAGUawKzaEZLy3qbcWqp5m1hALFxIxyv3iKBhL+38yim29DNQrARy+vkQebCde/r/iv+dPEZi/fuZGAtloEyoc5emRvtzBFLEJ1XpX1mMQBen0TYxelZuH/6JdleXdr2C8cLMK3Yq9BadcyfMSHzDBKrftm30avkKxGJpwVeG/b/Tj12wDUigJRuzwpmVWqtWWuGJxclx/CsX0G0bBrLjnPMkpTyTd+adATHhOCerIJEApWmZll7VbzwelJelWoLEq0VJmVMQPoSCQGcYvW3Y0ow/TNRR/TpoDxoOJIHPBWSseNxWT6CXegE/n3ZF00HMHgL9m4lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj+Om6/myuui8w4aGW3ovVMoylBvuzzk24w9RwJp8fQ=;
 b=UjsLPvKF4lEr+s4t7FDbW9d7W5gAzVKtzP/6Hj+UbzGe/fIUmbUXGx7M3umHDApXqs2wsf05YH9rvgoGZshe9TjqAH6YFb6mEcwvofZWiHejJKS6qDP8sGW8ILrD4j07rXCjrt0mWM5mzTwrckojQapi6kGKUpAiyZXhhrS+g821O8vmHtuIOJeH3ZHU7dXWxeXVoF5JxO/zTuZhKI2u24o2f3txxn8/uU08nJy18x5sQP85vap/nm54/VZM8mD2ainE6IGug8BQSvJvk5eHMYdevLUEyx6FdzBOIaDYHSzDvq/6PUt5z1OaAceorooH3Ur+MY6cDS0O2FnDuychUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj+Om6/myuui8w4aGW3ovVMoylBvuzzk24w9RwJp8fQ=;
 b=nCrE1lOsxzE+bClFO4Rts43wINHgb6fkfLKm7KbWrGmUHwDN/7QX72rx+qcTkTTSx1sVWlapTzqHuPy2YDRL7tx1LBa5Pyub09m1XC5mtlc8wF5qfn/y3yLafPDjrr53RRullIMMR8lZJLzbWltl62JcUYDCYVxI7qhOXnpIAIY=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Wed, 18 Dec 2019 02:17:08 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 02:17:08 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation
Thread-Index: AQHVtMx1mf3g9Dmwn0erj2y9Qk4kS6e+XgwAgADKZtw=
Date: Wed, 18 Dec 2019 02:17:08 +0000
Message-ID: <MN2PR12MB29576EE2346078C60E28606E95530@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191217112322.20042-1-tianci.yin@amd.com>
 <20191217112322.20042-2-tianci.yin@amd.com>,
 <BYAPR12MB28061BFCA95C49E7FA245752F1500@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB28061BFCA95C49E7FA245752F1500@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T02:17:07.986Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edb7ded7-560b-4be9-222c-08d783606250
x-ms-traffictypediagnostic: MN2PR12MB3775:|MN2PR12MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3775D5BCA90FF0EC43DAADA795530@MN2PR12MB3775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(13464003)(189003)(199004)(52536014)(966005)(81166006)(110136005)(478600001)(55016002)(54906003)(86362001)(9686003)(26005)(33656002)(8676002)(76116006)(5660300002)(2906002)(186003)(71200400001)(7696005)(81156014)(45080400002)(4326008)(8936002)(66556008)(66476007)(66446008)(64756008)(66946007)(6506007)(53546011)(19627405001)(316002)(91956017);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3775;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qqM9m0e2toZDVjlZ8CRG5L8CDVxlq/p8J99OdODmnoj3ThX/lZ6CbwV5LQQjqgrXyXajZUHafEm9KMkot3Ewr5LyqpwsS136l96BGZ+qxsRC5744WYGMSgM7+OP8S62hSLXobX85eP5Pa1hvF3EqU96ZG9Jp4JIaCItkECSRwyXD+xsLKVMyA4tojPgAo50E0auW/MraIBIuSJeOFdEMbv0RswT5CaiQC/Wh0ADDF1QQCrRwdf8HZmnfRF0LIcqZ0UtsY24CUDWtsaAcGnlPBByVvsuIgIkp9L6jTnPlvXpwiiH83/RGygZQS9cN2gx3OvpwB19OC2ZPaiRmtN8ioPIXII2i5xQCdGeyTkjBkkuMwKGQzG90Z3NLWyyiWzr79fIWZ4nB67mQlinJNgHWmCZJj6PAi87rbaYhd1jDcfUQx7MlgWZ+MwGjYmTK/yVIOyjAz5VS5WaQqao7G25CRCDdpao1psUOHx2SDF1sC/bDB7pZonu+T/Pdd6J/SxERGTh8E0QijrfMsMCqzwq2R4uKWp22KTM+T7swjK7j0Yg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb7ded7-560b-4be9-222c-08d783606250
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:17:08.4403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kK/tUjqMRt607F7iIlT3NOLWNB9L4A5WgMSshrzoX7KiaWIgn5WQVnWPX4ssjG2J7UJDwTXEynOezCaJeLOMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0545259123=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0545259123==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29576EE2346078C60E28606E95530MN2PR12MB2957namp_"

--_000_MN2PR12MB29576EE2346078C60E28606E95530MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Guchun,

Thanks very much for your suggestion.
I will refine it and send it out later.

Rico
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, December 17, 2019 22:11
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>=
; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; =
Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Chris=
tian.Koenig@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer rese=
rvation

[AMD Official Use Only - Internal Distribution Only]




-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tianci Y=
in
Sent: Tuesday, December 17, 2019 7:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>=
; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; =
Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Chris=
tian.Koenig@amd.com>; Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE) has be=
en reserved, and the p2c buffer is in the range of this TMR, so the p2c buf=
fer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ttm.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..3265487b859f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -202,7 +202,6 @@ struct psp_memory_training_context {

         /*vram offset of the p2c training data*/
         u64 p2c_train_data_offset;
-       struct amdgpu_bo *p2c_bo;

         /*vram offset of the c2p training data*/
         u64 c2p_train_data_offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index ce5cb854bdb9..6f0ad1d1d4d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1681,9 +1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(stru=
ct amdgpu_device *adev)
         amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
         ctx->c2p_bo =3D NULL;

-       amdgpu_bo_free_kernel(&ctx->p2c_bo, NULL, NULL);
-       ctx->p2c_bo =3D NULL;
-
         return 0;
 }

@@ -1718,17 +1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init(str=
uct amdgpu_device *adev)
                   ctx->p2c_train_data_offset,
                   ctx->c2p_train_data_offset);

-       ret =3D amdgpu_bo_create_kernel_at(adev,
-                                        ctx->p2c_train_data_offset,
-                                        ctx->train_data_size,
-                                        AMDGPU_GEM_DOMAIN_VRAM,
-                                        &ctx->p2c_bo,
-                                        NULL);
-       if (ret) {
-               DRM_ERROR("alloc p2c_bo failed(%d)!\n", ret);
-               goto Err_out;
-       }
-
         ret =3D amdgpu_bo_create_kernel_at(adev,
                                          ctx->c2p_train_data_offset,
                                          ctx->train_data_size,
[Guchun] If we have to remove such buffer reservation, from coding style's =
perspective, I suggest removing error handler code by "goto" too in amdgpu_=
ttm_training_reserve_vram_init.
After removing p2c buffer reservation from this function, there is only one=
 buffer reservation case for c2p. So direct error handle and return should =
be better.

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cguchun.c=
hen%40amd.com%7C888c561716c342aa9ecc08d782e397d0%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637121786693411170&amp;sdata=3DpH1rob4R5ljvEGo8PSjn1te7c=
tWLG1Wctv30lNCLyx4%3D&amp;reserved=3D0

--_000_MN2PR12MB29576EE2346078C60E28606E95530MN2PR12MB2957namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Guchun, <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks very much for your suggestion.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I will refine it and send it out later.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 17, 2019 22:11<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Long, Gang &lt;Gang.Long@amd.com&gt;; Yin, Tianci (Rico) &lt;Tia=
nci.Yin@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang=
) &lt;Kevin1.Wang@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; =
Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking
 &lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.=
com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: remove memory training p2c buff=
er reservation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ti=
anci Yin<br>
Sent: Tuesday, December 17, 2019 7:23 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Long, Gang &lt;Gang.Long@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin=
@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Wang, Kevin(Yang) &lt;K=
evin1.Wang@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;;
 Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Yuan, Xiaojie &lt;Xiao=
jie.Yuan@amd.com&gt;<br>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE) has be=
en reserved, and the p2c buffer is in the range of this TMR, so the p2c buf=
fer reservation is unnecessary.<br>
<br>
Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 1 -&nbsp; drivers/gpu=
/drm/amd/amdgpu/amdgpu_ttm.c | 14 --------------<br>
&nbsp;2 files changed, 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 5f8fd3e3535b..3265487b859f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -202,7 &#43;202,6 @@ struct psp_memory_training_context {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the p2c t=
raining data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 p2c_train_data_offset;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *p2c_bo;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the c2p t=
raining data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 c2p_train_data_offset;=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index ce5cb854bdb9..6f0ad1d1d4d7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1681,9 &#43;1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;ctx-&gt;c2p_bo, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_bo =3D NULL;<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&gt;p2=
c_bo, NULL, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_bo =3D NULL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1718,17 &#43;1715,6 @@ static int amdgpu_ttm_training_reserve_vram_init=
(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel_at(ad=
ev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctx-&gt;train_data_size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;ctx-&gt;p2c_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;alloc p2c_bo failed(%d)!\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err_out;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_k=
ernel_at(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx-&gt;train_data_size,<br>
[Guchun] If we have to remove such buffer reservation, from coding style's =
perspective, I suggest removing error handler code by &quot;goto&quot; too =
in amdgpu_ttm_training_reserve_vram_init.<br>
After removing p2c buffer reservation from this function, there is only one=
 buffer reservation case for c2p. So direct error handle and return should =
be better.<br>
<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cguchun.chen%40amd.com%7C888c561716c342aa9ecc08d782e397d0%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637121786693411170&amp;amp;sdata=3DpH1rob=
4R5ljvEGo8PSjn1te7ctWLG1Wctv30lNCLyx4%3D&amp;amp;reserved=3D0">https://nam1=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.o=
rg%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cguchun.chen%40am=
d.com%7C888c561716c342aa9ecc08d782e397d0%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637121786693411170&amp;amp;sdata=3DpH1rob4R5ljvEGo8PSjn1te7ctWLG=
1Wctv30lNCLyx4%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB29576EE2346078C60E28606E95530MN2PR12MB2957namp_--

--===============0545259123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0545259123==--
