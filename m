Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6377C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9055D222C2
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LbeMLnmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9055D222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465D16E0A1;
	Thu, 19 Dec 2019 03:03:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF81C6E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi9IJEDisp2kbnj3PO5w5mqSWgTSSMHBtHDRyHZcRitaWRMV/JLJILeYezbebsbxsqroLECfiDEo6Jxv6zwRkHpnwUg/vhKQph68vzbSIIwf6eXNjKV/N2Vez1G8jCHsPf3BhiPLVt+FnEfWWyQ9Zx9yLHjLUe2GZxStvsf6hP//0P8LUO9Kw1Lnt5SFpDjATKlge21P/xvnWPt0QtF8IOXl9AABaxLdcF6USg9Om4MLnGKpRa1x+sJ5Do3yk3qxIuDRgrptIal6GvQyE8C//I33Zc9C6N2OyAQrhhH3YumSoJnFnpS/Om+xu+AgCKXhDpUAzY3nqMAY7xk7fJrjIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMsjBNDqdP9sbcL24gict763X1hSSeQAaS3/346cxJs=;
 b=RgHgzASbjct9Zu3vYkC0AwUrt/BfwnF52tHlkhSY0WzDteszWTRhnt0XPAbprIuj3N5+y/VfSxXt7XycNtm6ZLzRjMylv/50TlujaiP/fPoFfn62UBwINJ0N+pAdoDMoaLra7p40Rlw7bDJ46TTt58Em2e2n4qsdJObUX+iT19WHvAmCgGPETQx7tdg8s/hHKXBZe1gO+Rqdlom0gMTJbtDXxLsPJV6VubyjlJe7PJKel/RGniAbO8TZ/scXbpGHNSwdNB7fTfmFLKFsinNkkfleXZnpFpydmQczEacbgHlJV1VATI+3JA6bs7A0cT2+Q34bFJoaJ8woT1tZglmtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMsjBNDqdP9sbcL24gict763X1hSSeQAaS3/346cxJs=;
 b=LbeMLnmrV81KdbWoflPgYDs4QnyWsqLiv5UwWw1bOUTy1bVrdW+Z5XR6hlc2RI7ZXSXk+XyMXcYGPmv6gWYDpGe1YVDLBHtVBC1q0Ud938JVRZ4kEIqCLYL72jisDz6V+VnLlfdITDO2tCB5aBZzUvFNreyH+LlG/8R0CWLaqkU=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB4047.namprd12.prod.outlook.com (52.135.51.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 03:03:10 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 03:03:10 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Index: AQHVthZAVFn1uwWh9E6kOqB0jJlHIKfAxVEAgAAAJ8Q=
Date: Thu, 19 Dec 2019 03:03:10 +0000
Message-ID: <MN2PR12MB2957A3170401FA181DC21ED795520@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191219024416.32321-1-tianci.yin@amd.com>,
 <20191219024416.32321-2-tianci.yin@amd.com>,
 <MN2PR12MB308711E4D03C5C2750D2CD2789520@MN2PR12MB3087.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB308711E4D03C5C2750D2CD2789520@MN2PR12MB3087.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-19T03:03:09.680Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba1a6631-e5fd-4d32-a0da-08d7842ffac9
x-ms-traffictypediagnostic: MN2PR12MB4047:|MN2PR12MB4047:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB404781790106340EC506320695520@MN2PR12MB4047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(478600001)(2906002)(71200400001)(86362001)(4326008)(6506007)(53546011)(26005)(186003)(7696005)(19627405001)(8676002)(64756008)(66556008)(66476007)(9686003)(66446008)(81156014)(55016002)(81166006)(91956017)(66946007)(33656002)(316002)(76116006)(110136005)(8936002)(54906003)(52536014)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4047;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfutaoGVriiEza6o1T/msvjLuyUAn+kQCCDMHCpEF2evjAqA+4/XXdgCkKxobhWCEHhzuXTIDE2DEPhti3jkT05etUCVVyUaXINqXGxbdwZsU1ht0pnaWhl86ow1xbqtRksB2H96wBqUFkNz1nI4lK7tf6k6Fq6JhRKtRlPLwz8HcPFVWXoMavjEoHD4sLEPcFLvsdRLU9kQ5p9c9QIT349BohBgZ1qWzD1gz4CGjLO2NlX5Sk5zg5wezOY19ckSlDyBQT0Jp8lMF7jL507zmpYdivrr/o3Po/zSE7Q2Jo9qlYfhT31ygdpgQae8X7naCQSuflMxEnlUG/15sm/Pk2j5Zlacu9S78/FxFTRPRnq66D35rfAWN/LmtQ064KmNGxZBRInD+vtxL/cgqNWm0iKyfnxZLbA+ObW2m/mOdIU+hZWJROe0LX7yHTu+VRAC
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1a6631-e5fd-4d32-a0da-08d7842ffac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 03:03:10.1022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uo3rDeCVb1qTqwYh4fFESBg8GxFS/FafYcWlQTK+Ksc+OLQvuc8iXvyc75cXBe2WZ3gHf/ALaULdnD65ewLEMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0933225174=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0933225174==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957A3170401FA181DC21ED795520MN2PR12MB2957namp_"

--_000_MN2PR12MB2957A3170401FA181DC21ED795520MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Xiaojie!
________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan@amd.com>
Sent: Thursday, December 19, 2019 11:02
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.=
Long@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer rese=
rvation(V2)

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

BR,
Xiaojie

________________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Thursday, December 19, 2019 10:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Koenig, Christian; Deucher, Alexander; Zhang, Hawking; X=
u, Feifei; Yuan, Xiaojie; Long, Gang; Wang, Kevin(Yang); Yin, Tianci (Rico)
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion(V2)

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)
has been reserved, and the p2c buffer is in the range of this TMR, so
the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 ++-------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

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
index ec84acdd43a2..60f17e989014 100644
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

@@ -1725,17 +1722,6 @@ static int amdgpu_ttm_training_reserve_vram_init(str=
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
@@ -1744,15 +1730,12 @@ static int amdgpu_ttm_training_reserve_vram_init(st=
ruct amdgpu_device *adev)
                                         NULL);
        if (ret) {
                DRM_ERROR("alloc c2p_bo failed(%d)!\n", ret);
-               goto Err_out;
+               amdgpu_ttm_training_reserve_vram_fini(adev);
+               return ret;
        }

        ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
        return 0;
-
-Err_out:
-       amdgpu_ttm_training_reserve_vram_fini(adev);
-       return ret;
 }

 /**
--
2.17.1


--_000_MN2PR12MB2957A3170401FA181DC21ED795520MN2PR12MB2957namp_
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
Thanks Xiaojie!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yuan, Xiaojie &lt;Xia=
ojie.Yuan@amd.com&gt;<br>
<b>Sent:</b> Thursday, December 19, 2019 11:02<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang)
 &lt;Kevin1.Wang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buff=
er reservation(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - Internal Distribution Only]<br>
<br>
Reviewed-by: Xiaojie Yuan &lt;xiaojie.yuan@amd.com&gt;<br>
<br>
BR,<br>
Xiaojie<br>
<br>
________________________________________<br>
From: Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
Sent: Thursday, December 19, 2019 10:44 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Tuikov, Luben; Koenig, Christian; Deucher, Alexander; Zhang, Hawking; X=
u, Feifei; Yuan, Xiaojie; Long, Gang; Wang, Kevin(Yang); Yin, Tianci (Rico)=
<br>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion(V2)<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)<br>
has been reserved, and the p2c buffer is in the range of this TMR, so<br>
the p2c buffer reservation is unnecessary.<br>
<br>
Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f<br>
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 21 &#43;&#43;--------------=
-----<br>
&nbsp;2 files changed, 2 insertions(&#43;), 20 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 5f8fd3e3535b..3265487b859f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -202,7 &#43;202,6 @@ struct psp_memory_training_context {<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the p2c trainin=
g data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 p2c_train_data_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *p2c_bo;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*vram offset of the c2p trainin=
g data*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 c2p_train_data_offset;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index ec84acdd43a2..60f17e989014 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1681,9 &#43;1681,6 @@ static int amdgpu_ttm_training_reserve_vram_fini(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&=
gt;c2p_bo, NULL, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_bo =3D NULL;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;ctx-&gt;p2=
c_bo, NULL, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_bo =3D NULL;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
<br>
@@ -1725,17 &#43;1722,6 @@ static int amdgpu_ttm_training_reserve_vram_init=
(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;p2c_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset);<br>
<br>
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel_=
at(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ctx-&gt;c2p_train_data_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ctx-&gt;train_data_size,<br>
@@ -1744,15 &#43;1730,12 @@ static int amdgpu_ttm_training_reserve_vram_ini=
t(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_ERROR(&quot;alloc c2p_bo failed(%d)!\n&quot;, ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err_out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_TRAIN_R=
ESERVE_SUCCESS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-<br>
-Err_out:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini=
(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
<br>
&nbsp;/**<br>
--<br>
2.17.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2957A3170401FA181DC21ED795520MN2PR12MB2957namp_--

--===============0933225174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0933225174==--
