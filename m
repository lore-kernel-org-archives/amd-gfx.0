Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BCEC352BE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 11:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B0221D94
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 11:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ptVIHYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B0221D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082C16EB92;
	Fri, 17 Apr 2020 11:14:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9E46EB92
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 11:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaX7qyAiPb2rToQz+9MsOZYm4T0Gi2OCc1+b4M0CHC87E+MqouM807mI5/YC2CTe4w/XUXge3tdbg7Zww6QZ9IpvZI5Zk/vYBAULuuaftkSYPbn7x2OWax5LdEpD/HxUV7gHwoBSVti/UY9gI1IXOFXTtEQg+sOgAVJ9exY3tzw3WEYXLmeM5EII4R+HS/Uxw1KMkbXRGYNxY/zKW4DQ4pXW6y//U+Dm7FBDT2Ap9uhmrkAfujLGWujEMWq48y1SivZJmRmbxZbW6ZPpqy6pN6zxwkk3XwtT3x0+W/GGeVrmJFOiyhWcGGmNEgsMBlLSA6vTCHl7imLEuQkiIhwdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VBOQQtK50doaC6YoyMFHjgx+tloSjn6eE6S+SylPnY=;
 b=WBffYNXmxg83XY1usCnecVCw/Hcwf3DtVBtvflVR7fa4QveNqqaTwW8A1RTYwezMic5ANlCbivAMQLvNvCilI87bL4y/NAR9uyAE+gu9sDbkc6jVGcJ+sfMtehcMd794DAmGdSG8zkMoH11qu5PO49FQ44k03KD1FauhaiiyYRFgznhY6BwS8CQI9PLtfc9F3EBVVXGtkJiCkIJlTe3d4wXrSz3G7CBw+qj23sFYMt9QRH6f2GyN2nPl/lD+VrGHhlD+LU3DlB1B+EAlv0sp5vnbDCHKCX0iKY8h5OASrhbkxTyoU8tUWaqiascqIMOddd+Snoh24c9AEiDT27os7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VBOQQtK50doaC6YoyMFHjgx+tloSjn6eE6S+SylPnY=;
 b=2ptVIHYRCP0hFTMP/M46P2EG6eLjleLKuaO+ZjkadAthC0e50SVsW8LwaVrlCvXCVNYKLcs1nWq5Q/GnCq0zPejOQSyDR/Cuifp6RppQDBasej7L9LB/DxZMq5z8lg6Iru+aQjh57jWM36mK+7qqlTl8sMNXPtxnREp6JqbYy1U=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 11:14:36 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::ec5f:a26:8530:3b9f%6]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 11:14:36 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery
 on sGPU
Thread-Topic: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery
 on sGPU
Thread-Index: AQHWFAaVfdh4W6r+kkG/F5Zmdtnkfah9CfMAgAAdxkyAAAJGsA==
Date: Fri, 17 Apr 2020 11:14:36 +0000
Message-ID: <SN1PR12MB2558759164FDEB24C073E0A987D90@SN1PR12MB2558.namprd12.prod.outlook.com>
References: <20200416154748.32138-1-guchun.chen@amd.com>,
 <050666bc-6754-0fed-7b88-131592fed03a@gmail.com>,
 <SN1PR12MB25584E46D7D494AD099F4CA887D90@SN1PR12MB2558.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB25584E46D7D494AD099F4CA887D90@SN1PR12MB2558.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-17T11:03:55.7438525Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [103.65.43.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b7442ff-589b-4067-991c-08d7e2c08398
x-ms-traffictypediagnostic: SN1PR12MB2431:|SN1PR12MB2431:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2431F9D1E42A1CE5A6C6B7CC87D90@SN1PR12MB2431.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(66946007)(91956017)(66476007)(6506007)(186003)(33656002)(66446008)(64756008)(66556008)(86362001)(76116006)(8676002)(6636002)(71200400001)(53546011)(316002)(81156014)(478600001)(7696005)(66574012)(966005)(110136005)(45080400002)(26005)(8936002)(52536014)(55016002)(9686003)(2940100002)(2906002)(5660300002)(921003)(1121003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EO9w63GgATmA0B5tfiDIyiBe4tHpcocpVeGHjYitTEb0EU9OpiBkiZDLAzVdEnHK8oY8nY8lcTf59CkkuoK0YUV+C0WjxWT1jyC3xR2u9YiogQEN9/OrImWhadpXxJmQRX6uxYFfyZh7Twv2LmYH/v3E4bhGSrpIAhX9OePtGGJmBqLNqZf10osaL6aIHLC8kr9YzO1QT/fIytTqD6TOKqA+DVjoIwXi9TfCwotb/9eV+duJjGRxTjt3oGDQx2mKrRAJYbQKFki9UzGpWw17GJxOrLrJNDhhE01UrksovF2JDVsrpOh+ps8pzTPRQaleaWuS1thJbFpNzV7gkqqBAXUjILwMYdkntZ14x7wk3+9za8u+jjqNfwwCbjQ1DHSEmB+GsoFPeDufz0avwjAYGZj1WFFyARI4tOZfgD1Ru9OJPoGGeP5Vk5zc5QCwiRbb8h1b+tcY+oisGzks3GFczfQbBCUkuEV9jBldFIXN8/PctV09Iv7iE4/j7YEZbgVVKGcnRQU1taPzrE3IVsebm10DqTmfz5N2zxlm1WOlvBo=
x-ms-exchange-antispam-messagedata: 3m3sjFe8VkBMIOr2gexf+fQ0kkv0j5kPUelCnLZIJZVhb/y06crbAEaX3TYIxHquUSSl29TaMq4D0D4FGWmgQ/8hRbsnGLHOjwQ5AwIa/qXxribLjbE+611uMJelG+lOUYz0N+dvqlUWSGl+HZkuzQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7442ff-589b-4067-991c-08d7e2c08398
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 11:14:36.4469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXwdeyAylTqiV5/ylsR16sVdDZxrfuxMue5anlrirgjM62P0MNS1w5rCpTrnxzma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
Content-Type: multipart/mixed; boundary="===============2103689304=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2103689304==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB2558759164FDEB24C073E0A987D90SN1PR12MB2558namp_"

--_000_SN1PR12MB2558759164FDEB24C073E0A987D90SN1PR12MB2558namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

that breaks the device list in gpu recovery.
________________________________
From: Pan, Xinhui <Xinhui.Pan@amd.com>
Sent: Friday, April 17, 2020 7:11:40 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Den=
nis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Koenig, Ch=
ristian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recover=
y on sGPU

This patch shluld fix the panic.

but I would like you do NOT add adev xgmi head to the local device list. if=
 ras ue occurs while the gpu is already in gpu recovery.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Friday, April 17, 2020 5:17:22 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Den=
nis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recover=
y on sGPU

Am 16.04.20 um 17:47 schrieb Guchun Chen:
> When running ras uncorrectable error injection and trigger GPU
> reset on sGPU, below issue is observed. It's caused by the list
> uninitialized when accessing.
>
> [   80.047227] BUG: unable to handle page fault for address: ffffffffc0f4=
f750
> [   80.047300] #PF: supervisor write access in kernel mode
> [   80.047351] #PF: error_code(0x0003) - permissions violation
> [   80.047404] PGD 12c20e067 P4D 12c20e067 PUD 12c210067 PMD 41c4ee067 PT=
E 404316061
> [   80.047477] Oops: 0003 [#1] SMP PTI
> [   80.047516] CPU: 7 PID: 377 Comm: kworker/7:2 Tainted: G           OE =
    5.4.0-rc7-guchchen #1
> [   80.047594] Hardware name: System manufacturer System Product Name/TUF=
 Z370-PLUS GAMING II, BIOS 0411 09/21/2018
> [   80.047888] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index b27d9d62c9df..260b4a42e0ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1448,9 +1448,10 @@ static void amdgpu_ras_do_recovery(struct work_str=
uct *work)
>        struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev, false=
);
>
>        /* Build list of devices to query RAS related errors */
> -     if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
> +     if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>                device_list_handle =3D &hive->device_list;
> -     } else {
> +     else {

The coding style here is incorrect. If one branch of an if/else uses {}
the other(s) should use it as well.

> +             INIT_LIST_HEAD(&device_list);

That was suggested before but then reverted, but I'm not sure why.

Regards,
Christian.

>                list_add_tail(&adev->gmc.xgmi.head, &device_list);
>                device_list_handle =3D &device_list;
>        }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cxinhui.p=
an%40amd.com%7Ca2bb160328c942b51b4608d7e2b02579%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637227118528983724&amp;sdata=3D6bJVduxNT%2FVXKPDWDBAnJfVS=
e3CJI9mdGfwi5V89Kgw%3D&amp;reserved=3D0

--_000_SN1PR12MB2558759164FDEB24C073E0A987D90SN1PR12MB2558namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
that breaks the device list in gpu recovery.</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pan, Xinhui &lt;Xinhu=
i.Pan@amd.com&gt;<br>
<b>Sent:</b> Friday, April 17, 2020 7:11:40 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Clements, John &lt;=
John.Clements@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras =
recovery on sGPU</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
This patch shluld fix the panic.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
but I would like you do NOT add adev xgmi head to the local device list. if=
 ras ue occurs while the gpu is already in gpu recovery.
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Christian K=F6nig &lt;ckoen=
ig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Friday, April 17, 2020 5:17:22 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&gt;; Clements, John &lt;=
John.Clements@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras =
recovery on sGPU</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 16.04.20 um 17:47 schrieb Guchun Chen:<br>
&gt; When running ras uncorrectable error injection and trigger GPU<br>
&gt; reset on sGPU, below issue is observed. It's caused by the list<br>
&gt; uninitialized when accessing.<br>
&gt;<br>
&gt; [&nbsp;&nbsp; 80.047227] BUG: unable to handle page fault for address:=
 ffffffffc0f4f750<br>
&gt; [&nbsp;&nbsp; 80.047300] #PF: supervisor write access in kernel mode<b=
r>
&gt; [&nbsp;&nbsp; 80.047351] #PF: error_code(0x0003) - permissions violati=
on<br>
&gt; [&nbsp;&nbsp; 80.047404] PGD 12c20e067 P4D 12c20e067 PUD 12c210067 PMD=
 41c4ee067 PTE 404316061<br>
&gt; [&nbsp;&nbsp; 80.047477] Oops: 0003 [#1] SMP PTI<br>
&gt; [&nbsp;&nbsp; 80.047516] CPU: 7 PID: 377 Comm: kworker/7:2 Tainted: G&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&=
nbsp;&nbsp; 5.4.0-rc7-guchchen #1<br>
&gt; [&nbsp;&nbsp; 80.047594] Hardware name: System manufacturer System Pro=
duct Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018<br>
&gt; [&nbsp;&nbsp; 80.047888] Workqueue: events amdgpu_ras_do_recovery [amd=
gpu]<br>
&gt;<br>
&gt; Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 &#43;&#43;&#43=
;--<br>
&gt;&nbsp;&nbsp; 1 file changed, 3 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.c<br>
&gt; index b27d9d62c9df..260b4a42e0ae 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&gt; @@ -1448,9 &#43;1448,10 @@ static void amdgpu_ras_do_recovery(struct w=
ork_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hiv=
e =3D amdgpu_get_xgmi_hive(adev, false);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Build list of devices to =
query RAS related errors */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; (hive &amp;&amp; adev-&gt;gmc.xgmi.=
num_physical_nodes &gt; 1) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if&nbsp; (hive &amp;&amp; adev-&gt;gmc.x=
gmi.num_physical_nodes &gt; 1)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; device_list_handle =3D &amp;hive-&gt;device_list;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
<br>
The coding style here is incorrect. If one branch of an if/else uses {} <br=
>
the other(s) should use it as well.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
<br>
That was suggested before but then reverted, but I'm not sure why.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;adev-&gt;gmc.xgmi.head, &amp;device_=
list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; device_list_handle =3D &amp;device_list;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cxinhui.pan%40amd.com%7Ca2bb160328c942b51b4608d7e2b02579%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637227118528983724&amp;amp;sdata=3D6bJVdux=
NT%2FVXKPDWDBAnJfVSe3CJI9mdGfwi5V89Kgw%3D&amp;amp;reserved=3D0">https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cxinhui.pan%40am=
d.com%7Ca2bb160328c942b51b4608d7e2b02579%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637227118528983724&amp;amp;sdata=3D6bJVduxNT%2FVXKPDWDBAnJfVSe3C=
JI9mdGfwi5V89Kgw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN1PR12MB2558759164FDEB24C073E0A987D90SN1PR12MB2558namp_--

--===============2103689304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2103689304==--
