Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7909C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CD722249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GIogwYRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CD722249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310066EA7C;
	Wed, 21 Oct 2020 08:18:46 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FF66EA7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 08:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmwf2BdJvuP4lDy2l13KTlmxtBUnTQF48vPT7zZLoG9Lsq0jjObLEC6fJ89cKH4FSsVv/kXIMWwFeqWAGvlnZ4xFqdl7r23Sxcuk6YmQoDIpQGlXR1iCnoyW6BOPS+/9pvzH3RVz4TXLmsiiFeI7n80YpbfSBLlnQ4prXVmJPXfxtFjePkUyiirEZiBRQ+JmQVBXxYngQ3jqlo23TtMdt4MzS4Z7FYHbdJg1jczjSt0QVLGnmjC+b75bTUwcHyQ8Bnrygb0JAWpn1zFSEE7M/3BgB2lDtBAXRczyaNBoHIfZOLaeu5T1V3R21xOuEzTazeUo6DrefnVfjOnGWiKdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpTQBM6tzik9k90nBXQDsmhUnfkxjp3qd7BT2p9saJs=;
 b=Dcl9LzZSWWDsyYp0XstscovdsEJh/8SkGzv70Wdw+KsL3+M/zON7L4ivuKJaO/ru4Ltxp78vLoiKsG5pdEoOa9tn21gp2kRhNbyPgfQiPq+xYza8FKA/uWEzfagK4j11EwgLpMlsJ8ZSuMjLzDDKDfDrSa62NJV+txADjva2/x1ZOjbTsFVedYo2BfvdfogUk/u/c11wn4nWnH4PsZJ+RzimEgIlCPOyvnGCZt3MXZFdpc6JHXx5J3/cVfbYx2eRy8IzK8G7OFMS8FHGab9RJxai9voyg8SKko5Jem/amkplkNV8TlcTkDsvE56vJZx1/wK2yai2wiV7oCz07t0LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpTQBM6tzik9k90nBXQDsmhUnfkxjp3qd7BT2p9saJs=;
 b=GIogwYRa0P5koaPyzCBma47pe1kEd7wh85psNZstqHkALxCtINtYi3meIMVPNoZhldm8T6V+DDi6sC+wmd2JnfhTLsi7tTNfIvK1Y+QzC2GG2a5MdUmX5u/mR4MKTwOG5NJ+zewvxZGo0EG+aF5IODxT6BEfaIRusPIqm5nZlYo=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Wed, 21 Oct 2020 08:18:43 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 08:18:43 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Thread-Topic: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Thread-Index: AQHWp3+nnXP2AKNeEke8zNXYH8kj5KmhsccAgAAEwOY=
Date: Wed, 21 Oct 2020 08:18:43 +0000
Message-ID: <DM5PR12MB15461E7F203C3C37BA53EC8C951C0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201021075608.16785-1-tianci.yin@amd.com>,
 <CY4PR12MB1287852ADEA303832385E112F11C0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287852ADEA303832385E112F11C0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-21T08:18:42.893Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d299832c-8e61-4a36-cbb6-08d87599ecb5
x-ms-traffictypediagnostic: DM6PR12MB3931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3931F2D324B62BA4EEA6E792951C0@DM6PR12MB3931.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjuIXZZYlNkfg5Y1RZxzaQtoEn+EF5NUn9EDHpTc9smoD2EatUJXfOhGvwGFsHPkvzwMZuhyTlmim2dD5fzknxvXOOioUC1oLXSsX0bGSX0fbLKrsi1CiOWl/05/Zm5XS4UhZvq7jvuOqcwrHkEcB6lY99L/y65mrtIq8ggDMnZi6cMa7l4MGbXaGleC2b5MVZ04spuQa4mF6u2b5Rw13mQP8D4nK+rrQkx7OX1+WgqN81RUT/svnUkVaPoGNvfmidTh+WJ4m/XeqNPvGF3gc140uZmn0IEcggQvM3yToXc28AirepHs3YpFWzlx3JwvlszD8eztetRLkoeKy1uFEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(366004)(316002)(71200400001)(33656002)(478600001)(64756008)(66446008)(66946007)(52536014)(5660300002)(76116006)(91956017)(66556008)(66476007)(83380400001)(54906003)(9686003)(2906002)(110136005)(86362001)(8936002)(186003)(19627405001)(55016002)(6506007)(53546011)(7696005)(26005)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Epu7CkBwag9/uBRr13y2qmejm/HHe3FxfYeydPECtnuEL2fky4WXd1nCQjqK6czTCia2fO2gfwADPNKUToyko3GlzLDqxioKT3P6v1hYbss6WHyRIG2IjXbqCVQ01Ohe5XLmNmWkG9SMnWF2iPEZHH73lz78RINTPLjVzixRwL5xkP9ea+xkhk736fHhxFlk0b+HtankLdqvoiDYH/lotubQNQU1+ykW+K38LeguQTRQLbgLNf4eJr4uSdtjKxb5fcOSoVKs2u3OrygIgOM8WRnOYa7GDa9WsX+LNEPIkPJcHfw8PURqAgG7ybLTw7tQqpavIL2zloVy0yK+mrqL8M60WfoQX671Nf72RZ/e14nZ21KY91HvcgzIlBvb5fZ3uHEUqtXdC9fDCO2ppz3ZtMr6iepypZcQGx2jdD6iqxBGGtzIhptCS1fLBjgvw/l10DUGQzjRULPu+tkgheZr6ETLTQYtuuj6PNz1XSjVxv/ZIT72We1iJBXLkI+44K3rkwrna2auFQWqEN9OqcEwie8OG/f9hrOYzL3pZKMGpaTpZdj9fS/P9nGK8+q3JLnHvNkuHPShsJqsPra6HGgVkR9RX34c5d+ZtsJ4P7QsEFkBAuChBGehDJEeLTFoTr+hVCdJ/3hiWEyuUF2u2dOFKA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d299832c-8e61-4a36-cbb6-08d87599ecb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 08:18:43.4018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87sy0EsamSRJz0nqm8EguF4FImrq+BLa25kS4zwzt+s2ZmXG968PFlkcxbDlZ2Ugpkwxv5vGfGhjNngVq2TU1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3931
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
 Alexander" <Alexander.Deucher@amd.com>, "Cui, 
 Flora" <Flora.Cui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1090207980=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1090207980==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB15461E7F203C3C37BA53EC8C951C0DM5PR12MB1546namp_"

--_000_DM5PR12MB15461E7F203C3C37BA53EC8C951C0DM5PR12MB1546namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks Guchun!
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, October 21, 2020 16:01
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Cui, Flora <Flora.Cu=
i@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>;=
 Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU

[AMD Public Use]

Series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: Wednesday, October 21, 2020 3:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun=
.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.c=
om>; Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com=
>
Subject: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 564336c2ee66..13723914fa9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] =3D {
         {0x1002, 0x7319, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
         {0x1002, 0x731A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
         {0x1002, 0x731B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
+       {0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
         {0x1002, 0x731F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
         /* Navi14 */
         {0x1002, 0x7340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
--
2.17.1

--_000_DM5PR12MB15461E7F203C3C37BA53EC8C951C0DM5PR12MB1546namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks Guchun!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 21, 2020 16:01<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&=
gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com=
&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Y=
in@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain S=
KU</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
Series is: Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Tianci Yin &lt;tianci.yin@amd.com&gt; <br>
Sent: Wednesday, October 21, 2020 3:56 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ch=
en, Guchun &lt;Guchun.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt=
;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&g=
t;;
 Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
Subject: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU<br>
<br>
From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
<br>
Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a<br>
Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 564336c2ee66..13723914fa9f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x7319, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVI10},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x731A, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVI10},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x731B, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVI10},<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_=
ID, 0, 0, CHIP_NAVI10},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x731F, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVI10},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Navi14 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x1002, 0x7340, PCI_ANY_I=
D, PCI_ANY_ID, 0, 0, CHIP_NAVI14},<br>
-- <br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB15461E7F203C3C37BA53EC8C951C0DM5PR12MB1546namp_--

--===============1090207980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1090207980==--
