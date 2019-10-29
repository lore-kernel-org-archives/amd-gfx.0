Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291DCA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F13D20578
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 13:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F13D20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EE3E6E34A;
	Tue, 29 Oct 2019 13:28:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1706E34A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 13:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiCBghmNmil1H/FlsGgWO/wO1+7apDKNkdlkt/wdIDDYwpYt/d0nedmj+pEH7VZy4BZMxcZ+QvxJsFPLZonCiVQiORKDpJKoX0w2IAhZOMwIbQjVWgFGvkMaR4wnFZyV39zBoSQ8pTCPrPOZsH4VrlVx5tpkACY+lE35h6D3/7ziqm1heq6GNblHmBL+UYMEbEitOnR2TEaOMFKrahBrs6SiKowYZfelTtbSMZTyA33q95XasorC7x59yacp8lgBowKoAK8Z5Ui2ZLHHV+ST0VyMe2KEAhCW33yI7W3uw/PTvrno7Ygk5B/yA3Sn0GJFHa3MhCavc4HF5FX69T7TIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSDt+ejLn+HzewfGp9eiX9uL1r1sqMmbN6H+rztckGc=;
 b=bsn2cqVn4pxFy0F4iM6OoTlmNetsU4+8d/n3/2oWVDOHPywbbnCUYmGZ9L2doLdyMNgY/o4+UuOfUqeUQCzHdArEanL3Gd66ILJTN7Wt4+0IyyyFjFYVfDVhEPzqwoS3pXgd55izBFnyc+yNfBhyrCvzlV325Rr6JMxZ05yIVjkyJ1qjRWyJcRL5qluDLnRJ68yFcvVpJlxRvRidMSZ3SV2+DEXNFEi+2rbLU24os2vFXrgzFwUST+j99/PKJBYB4SZDy5pj6xPKrWPUo8cmqiPpQWzg0e3jq03uBhviDuPaBWnbOni/rnqQEFmimGbNv72jth4b5nixgGoXIApqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) by
 DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Tue, 29 Oct 2019 13:28:51 +0000
Received: from DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807]) by DM5PR12MB1820.namprd12.prod.outlook.com
 ([fe80::a0bb:dcbd:9ae:7807%5]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 13:28:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi
Thread-Topic: [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi
Thread-Index: AQHVjjnf+rlHYtDUc0GL+OMw0Po4UKdxnRZA
Date: Tue, 29 Oct 2019 13:28:51 +0000
Message-ID:
 <DM5PR12MB1820FA02897525F55BF5F3D3F7610@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1572340693-122958-1-git-send-email-HaiJun.Chang@amd.com>
In-Reply-To: <1572340693-122958-1-git-send-email-HaiJun.Chang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ff5a836-0609-4023-f314-08d75c73f003
x-ms-traffictypediagnostic: DM5PR12MB1705:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17051CFC95B22B1B55479879F7610@DM5PR12MB1705.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(6246003)(110136005)(236005)(6306002)(606006)(86362001)(6116002)(966005)(6506007)(55016002)(53546011)(229853002)(316002)(14444005)(256004)(99286004)(11346002)(486006)(2906002)(476003)(9686003)(76116006)(26005)(186003)(54896002)(66946007)(2501003)(14454004)(446003)(66476007)(478600001)(8936002)(7736002)(102836004)(8676002)(81156014)(64756008)(52536014)(66446008)(74316002)(19627405001)(66556008)(81166006)(6436002)(71200400001)(71190400001)(5660300002)(25786009)(76176011)(7696005)(66066001)(33656002)(3846002)(105004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1705;
 H:DM5PR12MB1820.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuTX1v7+CmtaKHzy+UGRe+QVuY/7A3l2iqoGzGZ9Z9/OpNMho/+0EuwARoOJuVrmyLr6pZpP/LQYdfwSqPPUreuqdjep2xW3D3LCazdmGRjB94TIywXjvK0cqqIclqHlGu5QazRA9RdCnzVF4xhmTk8Sh3RucSzAoiIiuUt8q2lY+ZW/zpe87w8DUt9bRr0gNDgWlE26HcNYcXKMQ2o6kYASUUpQYNreB5mAysr1nRejM2DihnacoAI8AGC+y3S6XBK16SiCJ5OnZQ+7WvthrPlRs90JtR85wYaoEkDZ8m6FEf8eSVIr5UanKK9lYS1pzpK3vH8rcaZomaWN2lZYPwtbwOO3FvGlgG34NRCuEzkdGLeZnfKju99XZmqFr4l9EZczgzdObXSHFrvAooXeIRmGo/6xV9oUGeGEKBsyu2sIID368A0UHp3TaXlTZM3FPDjqxd6pUxX/t0xkI96447lz8RaNZvaXs+Rzh8aJCF8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff5a836-0609-4023-f314-08d75c73f003
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:28:51.2330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gb4hZZEBTqhcctT2AmsgK39YMzQ/ULLjlLRPBaY1Y+LNOLrfkFWLYfADWwSk3aFK13hYvO76JEImD3LRL7SEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1705
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSDt+ejLn+HzewfGp9eiX9uL1r1sqMmbN6H+rztckGc=;
 b=EHtvm90qCD++Ko0PqfmtdumiDTOS2TTOk0+VWbfmEhqULqOUvoibl0dmWnr/AMAsoB7H/LUV66gLkaCPWiM2/s62yUPhatPes8H6iVFx+FbPbXeezK0cmjyN7c8tSydHKFJ2m4xsHE/YYjLJVQP8ECm1GYTwEqjxtEI3cwk2BZ8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1528236269=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029132851.xWX6ACdXjtNMtdA_7MxhlgJJ05vQ5A02dOBIqx52J8o@z>

--===============1528236269==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820FA02897525F55BF5F3D3F7610DM5PR12MB1820namp_"

--_000_DM5PR12MB1820FA02897525F55BF5F3D3F7610DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of HaiJun C=
hang <HaiJun.Chang@amd.com>
Sent: Tuesday, October 29, 2019 5:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>
Subject: [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi

Cp wptr in wb buffer is outdated after VF FLR.
The outdated wptr may cause cp to execute unexpected packets.
Reset cp wptr in wb buffer.

Signed-off-by: HaiJun Chang <HaiJun.Chang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index d126d66..13363f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3107,6 +3107,7 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu_rin=
g *ring)
                         memcpy(mqd, adev->gfx.me.mqd_backup[AMDGPU_MAX_GFX=
_RINGS], sizeof(*mqd));
                 /* reset the ring */
                 ring->wptr =3D 0;
+               adev->wb.wb[ring->wptr_offs] =3D 0;
                 amdgpu_ring_clear_ring(ring);
 #ifdef BRING_UP_DEBUG
                 mutex_lock(&adev->srbm_mutex);
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820FA02897525F55BF5F3D3F7610DM5PR12MB1820namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of HaiJun Chang &lt;HaiJun.Chang=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, October 29, 2019 5:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix gfx VF FLR test fail on navi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Cp wptr in wb buffer is outdated after VF FLR.<br>
The outdated wptr may cause cp to execute unexpected packets.<br>
Reset cp wptr in wb buffer.<br>
<br>
Signed-off-by: HaiJun Chang &lt;HaiJun.Chang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index d126d66..13363f2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3107,6 &#43;3107,7 @@ static int gfx_v10_0_gfx_init_queue(struct amdgpu=
_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcp=
y(mqd, adev-&gt;gfx.me.mqd_backup[AMDGPU_MAX_GFX_RINGS], sizeof(*mqd));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* reset the ring */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;wb.wb[ring-&gt;wptr_offs] =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_clear_ring(ring);<br>
&nbsp;#ifdef BRING_UP_DEBUG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820FA02897525F55BF5F3D3F7610DM5PR12MB1820namp_--

--===============1528236269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1528236269==--
