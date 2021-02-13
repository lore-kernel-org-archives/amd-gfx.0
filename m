Return-Path: <SRS0=DGdK=HP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9349DC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 18:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0D564E12
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Feb 2021 18:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0D564E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA40A6E215;
	Sat, 13 Feb 2021 18:42:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF166E215
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Feb 2021 18:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvmJM2aMWf0sVaHpIM4RctoCF/4DFXfB1sA5W1T1R6vPFiQ6qrm+Um/Mpw2Q6F+scvQ5yIOYjq+yyRIRzZdFtxZ4Bm/0wIDUXc85iMKP96tRaZKgh5tKR7UMKpXm9GSi1OABfAykyC9pT2i+cQGKGZxG700Sl1c/TVE4sQiw/0Bt7iXMpygBah2Kl3NKbm6BQNagOV7GnWaTIyvCee0ftkdN1cE+sErP55dTOvS+Ga3O5reeJxwnz/4N/by7p8U1wLrVzEOtCFLtmzPoXRn87pjDs4tXOkGXaiuTu9jbcoL0jZ3WxISSSsw6+MBXJlncli9iMj0wL5aa0zBIyFOYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yenp1kQQyThC0M/aYd332UbDPPx5o9Qy30JJYnwpbGA=;
 b=lGKHYVYJdhwvANKj/qKXVF8Fdfc2pv/KqaZwWEaYvSWaayZKC2KWUn1x7pB0XgMybnzEe/0j/ztrePvJ9VfUVLM7VoL71zoE5MsQ8/qlWQoM4D1+pFlaM0R1kRIRuUvcczxAKuasuBt+dm/8+KRjsmaY+KztrZmo+vLjes8OTC5SJTfXWCBhm0e/Px1RD3E1fUzv5Z8LjFgClOebJcKQe208B9Jic6AIkGzLNoP48Yxj/v64Y696BgZrCWj8DtNFFMkiMnb0owrGe22qDhuEmL3e5K7qmqFt8ocd+XCkh5wRU3Ob3zZ3izvyBRkC8DxvXJleAA0xuqMwmGgmEUBtlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yenp1kQQyThC0M/aYd332UbDPPx5o9Qy30JJYnwpbGA=;
 b=LrguwI2o6+9cXFbfQbWz8sItK7fZ6G/lufy9NqDt53tDWm7HODffDv8WkixzglBhmjxzvHF6qQtpnG/CMCkE+JABofvXvTVPUvsv/oAMhex9AIyxRi0xRX2p2IhSprW6Qk9Skw6PhQF9HBn5BwXTbEqBv/GrZreLvPOg8pN0auY=
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 18:42:09 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.038; Sat, 13 Feb 2021
 18:42:09 +0000
From: "Koenig, Christian" <Christian.Koenig@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: AW: [PATCH 1/2] drm/amdgpu: Set GTT_USWC flag to enable freesync
Thread-Topic: [PATCH 1/2] drm/amdgpu: Set GTT_USWC flag to enable freesync
Thread-Index: AQHXAiaT8fHyrgX81EayzeGBn0pdwapWaoUh
Date: Sat, 13 Feb 2021 18:42:09 +0000
Message-ID: <MN2PR12MB37759D139085A07796472EB0838A9@MN2PR12MB3775.namprd12.prod.outlook.com>
References: <20210213163725.17202-1-shashank.sharma@amd.com>
In-Reply-To: <20210213163725.17202-1-shashank.sharma@amd.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2a02:908:1252:fb60:189b:5676:db16:33fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60131664-d4b9-4798-3272-08d8d04f120a
x-ms-traffictypediagnostic: MN2PR12MB4157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB41578F873FF59AAFFE8A85BD838A9@MN2PR12MB4157.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hzLlTWVdtByvBJuivBtPAfrZNpE+uxWnfe4wYt4kyGW6q708Q6RSxYGf+8OHdCEQK/ckS22tQlWnGSGr4eotRovzwE2HUYnW/OOIoUCbvhDFGJu35/OkmivTee0UrZbzUSg5f1smXbXyN6EH3iljMmOrb5/d0PdyHP9NqNuDESYraPNpWxqDY0pdK0IIEGyDLOYR8wqzbmWls55n7+4wsuoOzMxoiljCLnC4+2nwNDLoyiWsDUZsZwdTquFk6m1M3SANbBUHeiE1AbTJMF4bkqXkXijwCgvfuS0SY3baUXr/WeTwCND3myjYdiSOipVHkrKy1mtsViLD2AZ5SKmy+ltBDOnfcHIUUEq+4UekGDNrq1j4gbOL0nZC0zOpR7EcApMg52/5FZnvia1tul6mO0rsf3Hubb8KmN+mKGzmauBIy2DYw1p5JQU4bWJP/Cf01apN1o8cfbNPS2DMhlOkM4iKqtUP1G4Lw5AWZUO6Slwbbx/Z/Cd01alqUCebPn+a1BkYvN7oNJ2Mka6EaqytQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(71200400001)(66476007)(91956017)(86362001)(2906002)(186003)(6506007)(83380400001)(76116006)(33656002)(7696005)(9686003)(4326008)(5660300002)(55016002)(110136005)(8936002)(316002)(478600001)(8676002)(66946007)(52536014)(66556008)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?BYEeHVJVwJ/9O9PKq3p7EoQDHVIkZn7eeegoHbucWfdBi7Eu0RbXrV67eZ?=
 =?iso-8859-1?Q?/5K5pkVhwKnRyy+E1cG8VY1mD75vcaykTMUvLEkrq2pSFNx5euB9K7fnvC?=
 =?iso-8859-1?Q?rb2OOnU0lSXKK5OtmHGznBVhVbe8YsYhOy4nnQUml5FBELaiSZ8eiop4nS?=
 =?iso-8859-1?Q?Vvb5od3JSiZEMqKd6sJG2BT+lNL1BV14xGsDmwDYkhRWwOnaJ7ij82PlE4?=
 =?iso-8859-1?Q?qTdUD+ND2Qel54ax7RIRam5N8zQjwg2ePh+/SiTKFRFMhxqIZugBfiTXIp?=
 =?iso-8859-1?Q?Qxq87N17GX8kD/oh2sCIZzSUvDmfd/9dlxMcpNxbJMvyca4weaHV9wAa8F?=
 =?iso-8859-1?Q?Wn2RNdPvbvgKhUphwSyI7zk8XV1wPYla1D85FYBtxeeoVQnDKABal00oje?=
 =?iso-8859-1?Q?VzYVGYk4+S+2ooDQfU+61Ah39HYN5UVJVxXRnz0vXQ9MScRoQa8woPzzQR?=
 =?iso-8859-1?Q?1v7r2XrWoVKp9PRUZ1XigL4lv505D9iYdjC8kp5NvNW3Rav1MyCBQpE3eE?=
 =?iso-8859-1?Q?+VA2mSAfE+/DFgMl0d3ejt/vyQbeIMJXwkNQP/E8caa53tI4kXFvRy9XaR?=
 =?iso-8859-1?Q?MwQGG/pC+iFQ+93f9kmPkzHk4hSpKFGQ8uakU1hu22huxWCjoPRVmePjfM?=
 =?iso-8859-1?Q?jyZzrponmVWbLTgCmX2wnvRrXNtXH/BOjcVIJQ7FZz1Q7py8ZMtkm+ozCQ?=
 =?iso-8859-1?Q?zHHC3lYKtLeyqu/ac6uQtJdp/hU3YCPWeEivpBI94hKL0cXuojRx4WtXvP?=
 =?iso-8859-1?Q?ZYW51Jwrg4Yo0S98i0W8OVALPmiD/nq3EEIX3ehj1aesdK7z5cUgmfZZV1?=
 =?iso-8859-1?Q?xiDrri0SYZ7NPMilRpp5ucci0D9Dg4BJt2eJDKlyfKckEcAN0ztq0L54Xg?=
 =?iso-8859-1?Q?6sKMljT3vLuY7y7jM7QlPPzgRIN1SkUS+zt0tnOL+f2zEWTaGFaw6DFZvA?=
 =?iso-8859-1?Q?d1Fe5qyHhjq/T/GngcyGmvgKaFYkx7GnTfB1m8NZ0x7ua9qwP619pOE3/V?=
 =?iso-8859-1?Q?SJv8Eb4Q8t2fb1PorcTg8T6juyt49ttqdjCd85hQc6/DT7i/3n5i7lIOM7?=
 =?iso-8859-1?Q?Y7o9GEUNGglLoGvtZbgJLTq+WznEKedx7u8m2q5yRvQ96xjQSdeKbCO94U?=
 =?iso-8859-1?Q?h3IMXJWW0tOft2vJ1fgHMomga1DPaAHVGtWic5qlzkettiskrNxJmC3lgD?=
 =?iso-8859-1?Q?OQ0+JCr3/okZI9AdKAVz0Q1YYrOfbKzSHRTF7HjTsOLRDidxKuprMq6x4D?=
 =?iso-8859-1?Q?7j6MD7z6nN+hJlfp8h5dEzGtB5C5Qu6DmV6VIR3zTF34TGdkxNt+wQzARC?=
 =?iso-8859-1?Q?hYd+7EfcD6iPa/zVGLGoT3C42wlOpfR61Xd5MWItD7bMLCzXXw49dw+tl1?=
 =?iso-8859-1?Q?z/8TKoYjVNzgnfc+u/PCX6BLz9kEgevxjSuUcBXmTmClX9JssJ5/M=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60131664-d4b9-4798-3272-08d8d04f120a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2021 18:42:09.5807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nLlcLBMS8wLJiZDWIJYv0lpY2isdbw0X3+g7iKSq4QVUNinkKSko7i6lpL3CfF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Content-Type: multipart/mixed; boundary="===============1267944032=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1267944032==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB37759D139085A07796472EB0838A9MN2PR12MB3775namp_"

--_000_MN2PR12MB37759D139085A07796472EB0838A9MN2PR12MB3775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Well that's unfortunately a NAK.

We currently can't communicate by DMA-buf if USWC is possible or not.

For the short term we could add something like a special handling for A+A c=
onfigurations here. E.g. check if the imported BO is also an andgpu BO and =
set the flag if it is also set on the exported BO.

Regards,
Christian.

________________________________
Von: Sharma, Shashank <Shashank.Sharma@amd.com>
Gesendet: Samstag, 13. Februar 2021 17:37
An: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sharma, Shashank <Shashank.Sharma@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Betreff: [PATCH 1/2] drm/amdgpu: Set GTT_USWC flag to enable freesync

This patch sets 'AMDGPU_GEM_CREATE_CPU_GTT_USWC' as input
parameter flag, during object creation of an imported DMA
buffer.

In absence of this flag:
1. Function amdgpu_display_supported_domains() doesn't add
   AMDGPU_GEM_DOMAIN_GTT as supported domain.
2. Due to which, Function amdgpu_display_user_framebuffer_create()
   refuses to create framebuffer for imported DMA buffers.
3. Due to which, AddFB() IOCTL fails.
4. Due to which, amdgpu_present_check_flip() check fails in DDX
5. Due to which DDX driver doesn't allow flips (goes to blitting)
6. Due to which setting Freesync/VRR property fails for PRIME buffers.

So, this patch finally enables Freesync with PRIME buffer offloading.

Cc: Koenig Christian <christian.koenig@amd.com>
Cc: Deucher Alexander <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index 47e0b48dc26f..db62f3c9d6a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -448,8 +448,8 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struc=
t dma_buf *dma_buf)
         bp.resv =3D resv;
         dma_resv_lock(resv, NULL);
         ret =3D amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
-                       AMDGPU_GEM_DOMAIN_CPU,
-                       0, ttm_bo_type_sg, resv, &gobj);
+                       AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_CPU_GTT_US=
WC,
+                       ttm_bo_type_sg, resv, &gobj);
         if (ret)
                 goto error;

--
2.25.1


--_000_MN2PR12MB37759D139085A07796472EB0838A9MN2PR12MB3775namp_
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
Well that's unfortunately a NAK.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
We currently can't communicate by DMA-buf if USWC is possible or not.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
For the short term we could add something like a special handling for A+A c=
onfigurations here. E.g. check if the imported BO is also an andgpu BO and =
set the flag if it is also set on the exported BO.</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Regards,</div>
<div style=3D"font-family: &quot;segoe ui westeuropean&quot;, &quot;segoe u=
i&quot;, helvetica, arial, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;">
Christian.</div>
<div><br>
</div>
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
<b>Betreff:</b> [PATCH 1/2] drm/amdgpu: Set GTT_USWC flag to enable freesyn=
c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch sets 'AMDGPU_GEM_CREATE_CPU_GTT_USWC' a=
s input<br>
parameter flag, during object creation of an imported DMA<br>
buffer.<br>
<br>
In absence of this flag:<br>
1. Function amdgpu_display_supported_domains() doesn't add<br>
&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT as supported domain.<br>
2. Due to which, Function amdgpu_display_user_framebuffer_create()<br>
&nbsp;&nbsp; refuses to create framebuffer for imported DMA buffers.<br>
3. Due to which, AddFB() IOCTL fails.<br>
4. Due to which, amdgpu_present_check_flip() check fails in DDX<br>
5. Due to which DDX driver doesn't allow flips (goes to blitting)<br>
6. Due to which setting Freesync/VRR property fails for PRIME buffers.<br>
<br>
So, this patch finally enables Freesync with PRIME buffer offloading.<br>
<br>
Cc: Koenig Christian &lt;christian.koenig@amd.com&gt;<br>
Cc: Deucher Alexander &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Shashank Sharma &lt;shashank.sharma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index 47e0b48dc26f..db62f3c9d6a5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -448,8 +448,8 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struc=
t dma_buf *dma_buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D resv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_lock(resv, NULL);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_gem_object_=
create(adev, dma_buf-&gt;size, PAGE_SIZE,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_CPU,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, ttm_bo_type_s=
g, resv, &amp;gobj);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_CPU, AMDGPU_GEM_CREATE_CPU_GTT_USWC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_type_sg, =
resv, &amp;gobj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB37759D139085A07796472EB0838A9MN2PR12MB3775namp_--

--===============1267944032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1267944032==--
