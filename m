Return-Path: <SRS0=DGdK=HP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F54FC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 18:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BBF64E12
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 18:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BBF64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCF76E581;
	Sat, 13 Feb 2021 18:43:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D74C96E581
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Feb 2021 18:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLA8zIPxg53eo/FBoxIv+OsLumGTys2vc415Ok7LSEnjTPujc0K7ZuJRmeH3ye6jZ5gKVper1h9pHfMNyzIxr8Of4HwMqqyCuu4yKMKBTqv4cUKLZwnVHl2pGgLWAklh3dZOGaa3NEhGzF/FeF/OFBjzX7yAbQv1NpdwjRI8ZlU3NKKC04j06tfwjbYkzJa+meiF/m4XSApDUQF4wsqIC9tCy42ZlgMuDYo5nbidJjMxguVt2iiheA01kxHF7GrZ8bPiS0orRJzuPUc5Al+Y8raaI9m6QqY1QJTClStkQmRmWtluOybdmy583fejIGfAecvcPncQX0GkdfEhRQayAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT7/WPoDuSYLhliHMIdy52AiCv99GfdZl+dzkuxdAo0=;
 b=mEfb1UI8uXYUNMfRCPbD84udcBoqSGdfMOJuSKPgr3BNY/W99Rnet3gNq2/q4lgtK0Gnsz/B95bccz90Y6ll0PyIYrRAEkuQuOKx07KT7jrKVPlL48Ek6QP/KHVIiZSzwJz2AE6NhuM1iO35dxTfqLOfmBds3beoe4Irxci20tWIdcx6d+8f/FWG76XjhxYkSE1qwq0TG3yb4/8jWQJCYAbACQ64u5/ldULNvF+CowRv+rH7Zf2SjcH77N7dkDHycTrY7CCZiOT8XB1mWShYYeuYe0a7OwnSeT2Wv6kdw1yZ80jRn9GewXtVQA/S7R+Hd1ISOR/QTWDIx9w5MLXUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT7/WPoDuSYLhliHMIdy52AiCv99GfdZl+dzkuxdAo0=;
 b=ps8G6frfBGQYSBHjGUjoZyaXR6aTM805VlUxT8KXDHmF1WtM9Ej7ER/mcKLbU5Qz/54rvCmQp2MTFPbOZ4fUyn5FxLlF+9rfR2z1CObZ51v/R/c3Oufbh27p5qlISMWigiMfTCZMVUFCnQlPw9m3UTOlC4lo8UODEV1BonEjGyg=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 18:43:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 18:43:16 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: AW: [PATCH 2/2] drm/amdgpu: clean-up unused variable
Thread-Topic: [PATCH 2/2] drm/amdgpu: clean-up unused variable
Thread-Index: AQHXAiaWYNUxdcIsIEW2zSM7eyPsj6pWa7GZ
Date: Sat, 13 Feb 2021 18:43:16 +0000
Message-ID: <MN2PR12MB377542B69CB267CB518F7ACA838A9@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20210213163725.17202-1-shashank.sharma@amd.com>,
 <20210213163725.17202-2-shashank.sharma@amd.com>
In-Reply-To: <20210213163725.17202-2-shashank.sharma@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2a02:908:1252:fb60:189b:5676:db16:33fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62d9876c-cac0-4cb0-a4a4-08d8d04f3a16
x-ms-traffictypediagnostic: BL0PR12MB4913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4913E0F60F26D0E55D6BD83D838A9@BL0PR12MB4913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pr9tuhhe7d2079LRHCfBePrmnuJ+YHpiULUOhoGK1gmqUWTqqs/Fgx2AyagMf6hkFRTWYA8StwanUsggne0eSi/sAH/9DTpm61TqLi6/Jak59cc8PQCRplc0DSqQCXSyUAYDq8WKx+khlSKK1DicbsS35Yd8IS7tCuvMeFqb9+GDeZKMDLNR0nxMTPAB1+8jNPA6zN+6sIXNekC4wEWcYKczfcq1Q09gnDMsn1ELLQLXGZsrADpMdSLperTmUfRmXk5ydNJzwb1oWkv4ciazKJ9pBm9bIA4z4gxSVcVsl31+S/K3/VRXKyrisuu8uzA8h9xLi8ccf9ULW9KCZHru8sReP8pTJQnjaq2OGiL91kPXSS5Umr5iEFfaZbx7nV4IcNi0tdaJ0f+uf32vYa4y4Upu/ULk7CNkISQeFB/3+IoLXOLfbr5MbKmMuovHi9BFGDYgzV7b4Za79IGbdZ6B/YldLgzmqSnxi9IROUVBOnoeihWP3XAETFGLDd0yZ9GRnFQ1NgIFpAQQDY0RAOEqhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(478600001)(86362001)(83380400001)(71200400001)(66574015)(9686003)(6506007)(316002)(2906002)(55016002)(5660300002)(110136005)(7696005)(64756008)(8676002)(66476007)(66556008)(66946007)(76116006)(8936002)(91956017)(66446008)(33656002)(186003)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Uk48jMOgrSo3TfEL4fPhJPo77bDQScv9t1J4t8E2xSe7QTSIp4xYqF4XzC?=
 =?iso-8859-1?Q?VEfASuet4Ffc5czohK6NxN5TlS5PoffkCIFvEJkV86jymdAaXmFZSTg2ON?=
 =?iso-8859-1?Q?/On05oivjk7jLY98f/NQP+LVE7+kMhZJCF123ItD6jN4BBI/BLwUSzMEnm?=
 =?iso-8859-1?Q?nzVOat9Uk6cVoD4UKKG/uBJMRShpudvnHtUD9h/Wob5QeJ8Lacv0AqzG0n?=
 =?iso-8859-1?Q?ekbQ3Vs4GJJXUfcOfBTJ6y9d/6hTmOsyZA7i3tzq+vTN0dDxs2cneRIv9F?=
 =?iso-8859-1?Q?39tlAuCc4g8eBIJnMyZ3Ex2l4PXhjT5E1vkXaIPzmRBX2IGReLMm1l1rEX?=
 =?iso-8859-1?Q?nDKdIwNvE3/07kNP/D4kbU/MBtxDFEW02ORPLnAR5EAP1g67FXo1ie0mFb?=
 =?iso-8859-1?Q?gnEJ/RsdzpmnK+A6Uv1qYf5DeOhIMZQ/WppiJiWEnJO6+E+pnzzTa/FqIO?=
 =?iso-8859-1?Q?4tnKWuON7aV4r3H2IVhDxRerjoYeQ72RQGnD/WzmEs1v5FOSInWtvGXlsV?=
 =?iso-8859-1?Q?Qg/Ns72Zw4T/vaP7/OIGwZHtvrmnwVK9HtJ7L1A9oeJxG2IwdzEiQmv3sD?=
 =?iso-8859-1?Q?I/AwNenRJNk/zp4eJYw/Im9m4xOsaywQ514PCcC+lGbGD8IiPstpp180j0?=
 =?iso-8859-1?Q?EBwCq2jD9k4MoXq9m6yoPlIMsw6fEVm3frhHdgyTpcYC740d+gQ6143955?=
 =?iso-8859-1?Q?E1e3lHYZ7jWPAJtJC5/3A6i0E9I13xpbdv4cAcFU6EhziV2r8BQ0T8zMpa?=
 =?iso-8859-1?Q?zy+aO+dTy/AZqy7GfKW78S/YfHHR3ZryAHrKP3uFY1NX2Sna3wheYEbSCP?=
 =?iso-8859-1?Q?U3rsE3N+KaNxvYSDs1ThAXXyHe9CF8tMi7dUnfQ2TmVPHHDkOzrUGPo2A/?=
 =?iso-8859-1?Q?4IdCV9LO93DO1ud0h5f9XuiyPHXAb12OnepCkRtwo4Ftg81vwgeOnzlko2?=
 =?iso-8859-1?Q?WLu1V+imjf4eG7c3PUOoqUp61G2ClBk8V2y1T7/f3XXiv48YYfAr5QEu/W?=
 =?iso-8859-1?Q?WOu3wLEWYJimN6d1v9obPUQJ1RKO8hDni+v9fpWw+DxT/1HP/CUKEtIU6o?=
 =?iso-8859-1?Q?hfeO9OGgJlIjWvezvBXwthwr1kn4FT0u2CikvHJEAu+UELxZIu8jjH41Ys?=
 =?iso-8859-1?Q?cgBHkKY79VMLnUzsksomiG/+k4Xelj8pqD+bSDSEEK3hZlIwSY+qg8A631?=
 =?iso-8859-1?Q?PSVhHJQncpuNBpJ9LujPxK0Pfrdlb9WR2UEBzLdlo4G2zzZPMndWTNSwle?=
 =?iso-8859-1?Q?Zx/X3MyB0jrhRWX0sN0UL4UF9ZseFIcUuZdVURQqZtnx1/xnsYqsaB+uIq?=
 =?iso-8859-1?Q?pIH012llzczx8ZH858hyrb1ewgDCua6bzYlqGEC1ix37i3/iMoclKS0REe?=
 =?iso-8859-1?Q?ZdxilHPk/UAC5rmndAzYgExpwdx7KkWnG/4g5abVWVeoGrzPqVXAAKhzsg?=
 =?iso-8859-1?Q?4okYsDZDWqo0JbiT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d9876c-cac0-4cb0-a4a4-08d8d04f3a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 18:43:16.7332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmDjTPHfZcPp95FQghM91c4EUkuDw2RbaFcriAGp66NVpNHzUh5wp7YyihA38FF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1114126914=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1114126914==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB377542B69CB267CB518F7ACA838A9MN2PR12MB3775namp_"

--_000_MN2PR12MB377542B69CB267CB518F7ACA838A9MN2PR12MB3775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
________________________________
Von: Sharma, Shashank <Shashank.Sharma@amd.com>
Gesendet: Samstag, 13. Februar 2021 17:37
An: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sharma, Shashank <Shashank.Sharma@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Betreff: [PATCH 2/2] drm/amdgpu: clean-up unused variable

Variable 'bp' seems to be unused residue from previous
logic, and is not required anymore.

Cc: Koenig Christian <christian.koenig@amd.com>
Cc: Deucher Alexander <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index db62f3c9d6a5..d3e4d6a06bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -435,17 +435,9 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, stru=
ct dma_buf *dma_buf)
         struct dma_resv *resv =3D dma_buf->resv;
         struct amdgpu_device *adev =3D drm_to_adev(dev);
         struct amdgpu_bo *bo;
-       struct amdgpu_bo_param bp;
         struct drm_gem_object *gobj;
         int ret;

-       memset(&bp, 0, sizeof(bp));
-       bp.size =3D dma_buf->size;
-       bp.byte_align =3D PAGE_SIZE;
-       bp.domain =3D AMDGPU_GEM_DOMAIN_CPU;
-       bp.flags =3D 0;
-       bp.type =3D ttm_bo_type_sg;
-       bp.resv =3D resv;
         dma_resv_lock(resv, NULL);
         ret =3D amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
                         AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_CPU_GTT_U=
SWC,
--
2.25.1


--_000_MN2PR12MB377542B69CB267CB518F7ACA838A9MN2PR12MB3775namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>Von:</b> Sharma, Shashank &lt;S=
hashank.Sharma@amd.com&gt;<br>
<b>Gesendet:</b> Samstag, 13. Februar 2021 17:37<br>
<b>An:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;; Koenig, Christ=
ian &lt;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deuc=
her@amd.com&gt;<br>
<b>Betreff:</b> [PATCH 2/2] drm/amdgpu: clean-up unused variable</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Variable 'bp' seems to be unused residue from prev=
ious<br>
logic, and is not required anymore.<br>
<br>
Cc: Koenig Christian &lt;christian.koenig@amd.com&gt;<br>
Cc: Deucher Alexander &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 8 --------<br>
&nbsp;1 file changed, 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index db62f3c9d6a5..d3e4d6a06bbd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -435,17 +435,9 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, stru=
ct dma_buf *dma_buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv =3D =
dma_buf-&gt;resv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *gob=
j;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D dma_buf-&gt;size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_CPU;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D ttm_bo_type_sg;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D resv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_lock(resv, NULL);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_gem_object_=
create(adev, dma_buf-&gt;size, PAGE_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGP=
U_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_CPU_GTT_USWC,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB377542B69CB267CB518F7ACA838A9MN2PR12MB3775namp_--

--===============1114126914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1114126914==--
