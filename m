Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8644C282DD
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EA420673
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tq7B718z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EA420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3899B6E914;
	Thu,  9 Jan 2020 15:24:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706926E914
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 15:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELN907P7fkDv+GAPqDGg8qME2sQLDrDfmjgcnGaDg/KhQgM7OkSu9bRTOMjaSoDTZk+e8dQs03yfasG/ghcFsW/X735UsVkQWnBhTxv399bsMSemIEzJvHRvwri9ywl/Sdr2+SQTasFm6pbzxEeeIyWh60wlgnuzDgJ/7grTe0LqS4G2Mt1+R09NQgv1jdUCs0uas3zt2a+efmnpm7pfUgyAqKcYIFZUVLPTL/jepmEN+EYsUnpLYoAPPpSnRai/xktIozFFiAv0LQv7uZAoCtZnN1FjB0+x2X2F3c7fgnlbLQdwlZUbrA3iRSt6WGtFIFq+Q1ygAmUA/x8A612OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P39SWiV+5NfbGbUYPKwqRVK8IkFjUhLhCQj1NfzDCk=;
 b=QJxAPkkK9XapcamQxhh0JBz8/XU6aaR8NXqWZ9QIBjbLSGwEgWN3FRXAlaJR7fwZfz+uD+sT4O2wSmryW6sw7sORG7+2dW1ZN8UC58Q9uUMrjphWA+9Kfsbgj6BgnEJgbN3y3vdGkCBCzeF/RiJSIqOtRa4IDmi4QTeyTx6SfDRHnjMND8xDilgBFwB3wqE7tUW3kT+dAfLXI9Q5gEGSlx/MvYb+gfdcmQcWI21c4JzWnPiRUpEbYCw02W7GyOTZqw0a6gu9dq7gYOqLPXrW3oPHcxMrTDEO+z2VLwhiWsuLVBZwjE6idpmUBEFLQUlQeI7QPNbxSoAbp9u/xiuNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P39SWiV+5NfbGbUYPKwqRVK8IkFjUhLhCQj1NfzDCk=;
 b=Tq7B718z+QDANM/hWhAn8K0jmoXWiyUY4JjGdFF5XqJ0mL8XlN5/pCjGM/pR5Lo2bomdMOH1QPXFAz/rkrDe2NXp6TwxLcM6JI4azAHTKxCh7JHFPdWunY+UAqMHIwmxxovaDQP6H5ZHbmF5W4918B1aGlKsiIlbmOsTOSAkxIs=
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1852.namprd12.prod.outlook.com (10.175.87.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 15:24:36 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b%7]) with mapi id 15.20.2602.016; Thu, 9 Jan 2020
 15:24:36 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing
Thread-Topic: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing
Thread-Index: AQHVxuHfy/DtKhPWJUaMdFUHAEcCKaficyQA
Date: Thu, 9 Jan 2020 15:24:35 +0000
Message-ID: <DM5PR12MB23768130B92B02A64886FDBB8B390@DM5PR12MB2376.namprd12.prod.outlook.com>
References: <20200109114213.5537-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200109114213.5537-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-09T15:21:23.6773699Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
x-originating-ip: [93.229.42.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 123a8fa5-e703-4b8a-7be8-08d795180912
x-ms-traffictypediagnostic: DM5PR12MB1852:|DM5PR12MB1852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1852BAC74D4AEBA85E8797208B390@DM5PR12MB1852.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(81166006)(8676002)(33656002)(81156014)(4326008)(66446008)(110136005)(71200400001)(9686003)(55016002)(316002)(91956017)(66946007)(52536014)(66476007)(66556008)(76116006)(64756008)(7696005)(6506007)(5660300002)(186003)(26005)(966005)(8936002)(53546011)(478600001)(2906002)(86362001)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1852;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JwwMCxKwhWwbHaT3XIy/MwwyYMcWh1hZLzVk3mWcU+8eP19OrFr/6dPI90yKWYeToNvGZkmo0jg4oSWyG98dqCyI/x56XfND7a4Dtxk83fwDGsp415LwB3GCQNT8Q3GW097AKJbVbXNWxm7sBlVvFRSJrvh7d7l3DtH8HBxivuRNX4oQUxn4YIwf4Gpvj6tnZpnxaa8+/8AdLzD7tVvVv3lKUp6/BDGXWosoYCmYOx0oAtypmj4Gj4OiA2XX08VVov3tQEhH0EjpaP6u+zfm6JC2jf7apNCpmvjMOSxjYKqrR7TNj7YkP27EEKJn9cxn19VFE4XTpwuVkEmcRvrpzSNr67bm9iWQ3qsK4RBJniHWsce+vPCbv12qsmgwq+qJ1hY8jnnFmnoOUOjKGYBVIJI0yWuW4dL3SOjY0EDa4d3MW3GPssj85pV3yTKe1TWkuA8PG50hYvyXNJWUBCu2w8QzJDVu6snzRQGr+xtpfRI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123a8fa5-e703-4b8a-7be8-08d795180912
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 15:24:35.9604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fi4buYXQ4wyLJQXnHHGd/VWSJFuhkWBwwYJEX2PhujhFOVZjh6v2PqQOnKPgqxqdmPxwyDS0JFd9wc3BXp9yUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1852
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2124116094=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2124116094==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB23768130B92B02A64886FDBB8B390DM5PR12MB2376namp_"

--_000_DM5PR12MB23768130B92B02A64886FDBB8B390DM5PR12MB2376namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I just got hit by this bug.

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com<mailto:Le.Ma@amd.com>>

Thanks,
Nirmoy
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Thursday, January 9, 2020 12:42:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: check sdma ras funcs pointer before accessing

sdma ras funcs are not supported by ASIC prior
to vega20

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index f4107f9b75f3..c4b4caaf56fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1810,7 +1810,10 @@ static int sdma_v4_0_late_init(void *handle)
                         RREG32_SDMA(i, mmSDMA0_EDC_COUNTER);
         }

-       return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+       if (adev->sdma.funcs && adev->sdma.funcs->ras_late_init)
+               return adev->sdma.funcs->ras_late_init(adev, &ih_info);
+       else
+               return 0;
 }

 static int sdma_v4_0_sw_init(void *handle)
@@ -1882,7 +1885,8 @@ static int sdma_v4_0_sw_fini(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         int i;

-       adev->sdma.funcs->ras_fini(adev);
+       if (adev->sdma.funcs && adev->sdma.funcs->ras_fini)
+               adev->sdma.funcs->ras_fini(adev);

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
                 amdgpu_ring_fini(&adev->sdma.instance[i].ring);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cnirmoy.d=
as%40amd.com%7Cf443faf2f98f4135d8a408d794f8fdd0%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637141669492821558&amp;sdata=3DtKUUR%2BJwv8V19Q0zr0oQg48t=
G9j7goCQ7L6EzNuv6JI%3D&amp;reserved=3D0

--_000_DM5PR12MB23768130B92B02A64886FDBB8B390DM5PR12MB2376namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
I just got hit by this bug.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div dir=3D"auto" style=3D"text-align: left;"><span style=3D"font-family: -=
apple-system, HelveticaNeue; font-size: 14.6667px; text-align: start; displ=
ay: inline !important;">Reviewed-by: Nirmoy Das &lt;nirmoy.das</span><a hre=
f=3D"mailto:Le.Ma@amd.com" style=3D"font-family: -apple-system, HelveticaNe=
ue; font-size: 14.6667px; text-align: start;">@amd.com</a><span style=3D"fo=
nt-family: -apple-system, HelveticaNeue; font-size: 14.6667px; text-align: =
start; display: inline !important;">&gt;</span><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;"><br>
</div>
Thanks,&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">Nirmoy&nbsp;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 9, 2020 12:42:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: check sdma ras funcs pointer before acc=
essing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">sdma ras funcs are not supported by ASIC prior<br>
to vega20<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 &#43;&#43;&#43;&#43;&#43;&=
#43;--<br>
&nbsp;1 file changed, 6 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index f4107f9b75f3..c4b4caaf56fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -1810,7 &#43;1810,10 @@ static int sdma_v4_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG3=
2_SDMA(i, mmSDMA0_EDC_COUNTER);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;sdma.funcs-&gt;ras_la=
te_init(adev, &amp;ih_info);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;sdma.funcs &amp;&amp=
; adev-&gt;sdma.funcs-&gt;ras_late_init)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return adev-&gt;sdma.funcs-&gt;ras_late_init(adev, &amp;ih_i=
nfo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int sdma_v4_0_sw_init(void *handle)<br>
@@ -1882,7 &#43;1885,8 @@ static int sdma_v4_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.funcs-&gt;ras_fini(adev=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;sdma.funcs &amp;&amp=
; adev-&gt;sdma.funcs-&gt;ras_fini)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;sdma.funcs-&gt;ras_fini(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(&amp;adev-&gt;sdma.instance[i].ring)=
;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cnirmoy.das%40amd.com%7Cf443faf2f98f4135d8a408d794f8fdd0%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637141669492821558&amp;amp;sdata=3DtKUUR%2=
BJwv8V19Q0zr0oQg48tG9j7goCQ7L6EzNuv6JI%3D&amp;amp;reserved=3D0">https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cnirmoy.das%40am=
d.com%7Cf443faf2f98f4135d8a408d794f8fdd0%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637141669492821558&amp;amp;sdata=3DtKUUR%2BJwv8V19Q0zr0oQg48tG9j=
7goCQ7L6EzNuv6JI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB23768130B92B02A64886FDBB8B390DM5PR12MB2376namp_--

--===============2124116094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2124116094==--
