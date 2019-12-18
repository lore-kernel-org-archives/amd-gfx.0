Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3786C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8574B218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 08:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HS5nK9o2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8574B218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442F76E260;
	Wed, 18 Dec 2019 08:54:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1786E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obmV5+UyWzXN1dWikGZv2Bmfwky57N9LlQqXzibc850z5xak8+KNNvlYlMrUf+7UFAMVxjPrNtibRLTslFpgqJhiM8IFHcWZYtHmqMuVxD7O9XzC4v5H4WyDxuKAbeuiQ4yBnMf3x4nEWBWIAhuqY+9Nyy6LJtf+i/tjrupTrqOq8EvUBx5vE/BETMXLJz0Kcjanm8+B6hCK2S02baDDE1Fjs3z0x0R1mq8hKecFekbKtQEOTAvZHggxcOMMQ/i1rz5T7JTuRFCl4+6/wKCFAz1KBGAFmg6aOhDrNaxj7XtownyY+9CCALwhykvY5FVZ/4VvERmdLAnea4wLPLBEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRu/3iWZgr5CKT391OapsvkZi4LT73z2sTKtQ3UTKn0=;
 b=TqzGVkOg3x0h7/rRd7r2BfR9bMwqy/5SQ3QKt0PbRDCE5G/jW4XU7IGMT/KI7vIIg4huF7HOIY+6qyHVVrJLRLJePHRZW3B/MRfYB02t4TVs8DnVNDJo3zqXz4Gk6QStm+LZtLeOV4XaV7yFpge1XyMAhm7PgIK03gDTTjSsFCGGuu0k8sFh/be+yI/1VSw5+Dr1XULbiKJL8FSnqdeVphQc8EQf0q6rVVMywwG+emqnizOngfqW7P3Gv/nYXsWp39a4stzGLgtROQFUc/m1cbw9TZpaG/XPcbMi7cIgxA39nsX0Ya6MXSOJd0nF/UBnDyHg9eKJK7S2aiDl/wqmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRu/3iWZgr5CKT391OapsvkZi4LT73z2sTKtQ3UTKn0=;
 b=HS5nK9o2CJlycqOw3J/hhpbvwZ4kPk78Rs2KeK8jZmoCkVPHt6uhesTWABWwBzb+aw+D+I7yKOaPI3nYm/KaPYZM8j9Aaf8BTJJG+plVwRVWssRw/DUnLZUjaAtdL73i2KDHFlgfQfhbtKtzAdKpWUsrXC55Wtc5scJMke7nl28=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 08:54:35 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2cbe:ce2:60b5:7756%6]) with mapi id 15.20.2559.012; Wed, 18 Dec 2019
 08:54:34 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Topic: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer
 reservation(V2)
Thread-Index: AQHVtYBGs+eAGoMxq0+N8VPKprAVp6e/llGAgAAAKM0=
Date: Wed, 18 Dec 2019 08:54:34 +0000
Message-ID: <MN2PR12MB2957813C65155E2397F09CD495530@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20191218085050.28635-1-tianci.yin@amd.com>,
 <20191218085050.28635-2-tianci.yin@amd.com>,
 <MN2PR12MB32961665242FFA632F4711D5A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB32961665242FFA632F4711D5A2530@MN2PR12MB3296.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-18T08:54:34.365Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianci.Yin@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00d7c24c-4947-4d28-4f59-08d78397e7df
x-ms-traffictypediagnostic: MN2PR12MB3615:|MN2PR12MB3615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3615B2852871D0E2DA3C9E8F95530@MN2PR12MB3615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(81156014)(81166006)(66946007)(8676002)(186003)(4326008)(110136005)(86362001)(91956017)(76116006)(71200400001)(8936002)(19627405001)(53546011)(52536014)(6506007)(64756008)(66556008)(66476007)(7696005)(33656002)(5660300002)(478600001)(55016002)(9686003)(316002)(26005)(66446008)(2906002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3615;
 H:MN2PR12MB2957.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhU+sVlKF0AWZHVHjOozH0CmB+PVC67j88L4FP1ZzAjhFhpl/u8vQg8FwSJ5BUHn9B+O8jyNVe4mhOibJt70V2hMPe2fW1YWfkFIKJ3GLwif75z4mieUxPhNGV9LaltOWuOjIcjl7yYNchR3t881QqT8rRuTxrjNs3cj5fd+t45DX1ZMBcJwmGAORLHFauFjPbgMo2t3yE3NCp4U/x/toRzASsKV23uE0LQuLmNfQVQSbK4VZYoLyy6yCfuHRBULwlDTwTpXCLiKEU59QR4fF/sB6rBHfBskTfjmNPom0rTLvQeVTksKUEwgq6r0sKD1Gu0GzBK9rIUy8IrTDQdhoc+2tB4H+fFBKcJ4L5dfN0eNdt640y3/lyhW+KmNRnX2sZyBpsIerjxxamlFh7vweSf1K9ue4UE/kZvcQIoW8J5s35jx3gZehAnDZN1PIAhE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d7c24c-4947-4d28-4f59-08d78397e7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 08:54:34.7897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgDkePHDALhrVUcaye7T1H8jr7Fnjbv+/3vNDBLy53R8NXhInhkmHE3jqTxIvdT1QU/MFdr2nKONkvsnuRIVhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
Content-Type: multipart/mixed; boundary="===============1395488999=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1395488999==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2957813C65155E2397F09CD495530MN2PR12MB2957namp_"

--_000_MN2PR12MB2957813C65155E2397F09CD495530MN2PR12MB2957namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Kevin!
________________________________
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Wednesday, December 18, 2019 16:53
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer rese=
rvation(V2)


[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, December 18, 2019 4:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Yuan, Xiaojie <Xi=
aojie.Yuan@amd.com>; Long, Gang <Gang.Long@amd.com>; Wang, Kevin(Yang) <Kev=
in1.Wang@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer reservat=
ion(V2)

From: "Tianci.Yin" <tianci.yin@amd.com>

IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)
has been reserved, and the p2c buffer is in the range of this TMR, so
the p2c buffer reservation is unnecessary.

Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f
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
index ce5cb854bdb9..476ea4a4dc03 100644
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
@@ -1737,15 +1723,12 @@ static int amdgpu_ttm_training_reserve_vram_init(st=
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


--_000_MN2PR12MB2957813C65155E2397F09CD495530MN2PR12MB2957namp_
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
Thanks Kevin!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang) &lt=
;Kevin1.Wang@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 16:53<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: remove memory training p2c buff=
er reservation(V2)</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tianci Yin &lt;tian=
ci.yin@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 18, 2019 4:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Xu, Feifei &lt;Fei=
fei.Xu@amd.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&=
gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: remove memory training p2c buffer r=
eservation(V2)</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.=
com&gt;<br>
<br>
IP discovery TMR(occupied the top VRAM with size DISCOVERY_TMR_SIZE)<br>
has been reserved, and the p2c buffer is in the range of this TMR, so<br>
the p2c buffer reservation is unnecessary.<br>
<br>
Change-Id: Ib1f2f2b4a1f3869c03ffe22e2836cdbee17ba99f<br>
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
index ce5cb854bdb9..476ea4a4dc03 100644<br>
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
@@ -1737,15 &#43;1723,12 @@ static int amdgpu_ttm_training_reserve_vram_ini=
t(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;alloc c2p_bo failed(%d)!\n&quot;, ret=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto Err_out;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;init =3D PSP_MEM_T=
RAIN_RESERVE_SUCCESS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-<br>
-Err_out:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_training_reserve_vram_fini=
(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB2957813C65155E2397F09CD495530MN2PR12MB2957namp_--

--===============1395488999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1395488999==--
