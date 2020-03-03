Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1DC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B7D20838
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ysR4CiHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B7D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448D96E44F;
	Tue,  3 Mar 2020 15:28:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937626E44F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 15:28:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xds4Pg5VI+FPmwMQAi2i10OrzGTfAm8tNy7ZiaYLsNQC/OTxECcSHRlk6TLBPA08EH3R1XxAoTEYeNd78UjImuHysbzTlHtytveHY+FYccyHFBg91SNACzBK1HmFlvoe7KWHVNV2QcWr7aFFj3CQmP+BknG59PrW2JX/6m0LJTkk39eJEy8nAePtNqHixAxaHCikYxoHH9b05txP0qFmq34ub4tg+Eu4KO0stSZ2qjxA/T3p4l1MfQlDL8k4Lz4gpEPPmxIqDtrKTcIwO3vSOeXpc/5HcVvZ5YP66B6ksujgL64v1E26E6RZTHYDu2SqWdKQaBv/g8oeKk08jck+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRs/Yq9kNvEydELGoqZS1VLTS4049BunJGBVbwPgU4s=;
 b=nw/+A4cUagyf2ozapeGu9UmxoAR8jgEb1CJHop/TcKQs5r2w/4octjj+zNtUyV5ZzoYLYgBFilSsgLAmZIi6Vy9Oifrlx9fsIqj7ujv7cS/6G/YVQHeYV4baeOkkY3u4ciRdG22fkhSG3YMvca0qbTRd+k09KqHrIBlLtUajj3sWzqmooX0fSSW3bvlYbRWxHge0YgAdH92YBS4I5Vek/GPVc2owtJvkuhJrJRSBa18m3EqV5ajhGLg++yJkuixGyN0RxjCb73cNGmt0mOtS+33vDE+9mlTSSL0lWgrKjskSWaIMi6Kcxafnu1AyS1VWlhmboHI6OB8014g6w6ab1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRs/Yq9kNvEydELGoqZS1VLTS4049BunJGBVbwPgU4s=;
 b=ysR4CiHmmnx6ceLegK1d8xsZVt8XnCF5RhZ1kNt13UsT0Ngszx+SCeLuPrRLHcaHlImKtFn0GLLh69cmW534KzlWUz47PWFWTq1LiueOdY5GN5FE742CNxYRW1xnOAbLSnij8RMPQkiKqiUWGC0akfM0yo1/4vAz2kQPkAddpBU=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Tue, 3 Mar
 2020 15:28:38 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:28:38 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Topic: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Index: AQHV8FRyok5cRxATf0SYBiJ9i8QZh6g27AOAgAAERJiAAAjwgIAAAzfW
Date: Tue, 3 Mar 2020 15:28:38 +0000
Message-ID: <MN2PR12MB3376F4FF11CA27726C7A7CE29BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200302053529.5736-1-jacob.he@amd.com>
 <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
 <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>,
 <06d9d31f-87c5-b1f1-da93-992531dd57ad@amd.com>
In-Reply-To: <06d9d31f-87c5-b1f1-da93-992531dd57ad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T15:15:16.3377496Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2f8ff70-5a35-467d-9103-08d7bf878bc0
x-ms-traffictypediagnostic: MN2PR12MB4440:|MN2PR12MB4440:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4440EC592B9E6C7DF12EB4B49BE40@MN2PR12MB4440.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(76116006)(55016002)(91956017)(8676002)(8936002)(66574012)(186003)(478600001)(9686003)(7696005)(66946007)(81166006)(81156014)(86362001)(53546011)(66476007)(66556008)(66446008)(64756008)(6506007)(110136005)(2906002)(316002)(52536014)(33656002)(5660300002)(15650500001)(26005)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4440;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bO0XE7NA5m8qYRK6YCUK77Qk6Gg8KAZNrC0lUqREHOMlWSOeVAX3I354Z4R1wEknniCu0IDfj7kfi1ZmyOKy+CBDAtYfMIjZgwYgEn0LbnG4lnEhZTwjUh4IZFZMhIPP54JUVxS9XvinOa2PqvXU2m8+7lJ+qQFUIBZzpWQkdczUkkveOHPLoM8HvLJsLOfle8Wry+5GAAmW6b2WNf7wBsVwhRoYKm+sFob4MU29DS9K2IAi+6dAko47y4FokInd2KP5ZKLHtWbhW2r4EYGvuBqeybKhI7EQ/hpMguvrYWtpXFzRwKMpHfoM9JDk8fEkIilEOkpdG2z+RuIPF15LBYwUcxAe8eTJD/IXn7hS7vHt38u0KCXdQ6v0GxMvhgBZOwTJAfLKR6YFbCJPP3znoOqB7f8h5LnD2d/wvT0By0ptPQLpUw1DH6/eA52UzpBO
x-ms-exchange-antispam-messagedata: xHBrJCk4J5a9Egdd93gX9Cb2fYuvcTkCeD5ylxjZ0JG9E2Ah6y2ilHsEWdxH+odSFLkRQc0jiyqF4WApuWY0PXuiMybPc4/pHZz9egL0w8H/I/x1+XcH7LPdc42mlW48vGZqYsL4qVM+UMddR4b4sA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8ff70-5a35-467d-9103-08d7bf878bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 15:28:38.1278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv9TYdQ5BKWCkLnykmTnfwOKI4Gs3qQBi6Ut9pOvs4S25kjTHbOS5Nr446gJAqVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
Content-Type: multipart/mixed; boundary="===============1016478897=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1016478897==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3376F4FF11CA27726C7A7CE29BE40MN2PR12MB3376namp_"

--_000_MN2PR12MB3376F4FF11CA27726C7A7CE29BE40MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks!  Could you please take an example of trouble  =93This way we avoid =
a bunch of trouble when one process drops the VMID reservation and another =
one grabs it.=94?

Thanks
Jacob

From: Koenig, Christian<mailto:Christian.Koenig@amd.com>
Sent: Tuesday, March 3, 2020 11:03 PM
To: He, Jacob<mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailt=
o:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when a=
pplication reserves the vmid

Am 03.03.20 um 15:34 schrieb He, Jacob:

[AMD Official Use Only - Internal Distribution Only]

It would be better if we could do that asynchronously with a register
write on the ring.
Sorry, I don=92t get your point. Could you please elaborate more?

You pass the ring from amdgpu_vm_flush() to the *_update_spm_vmid() functio=
ns.

And then instead of using WREG32() you call amdgpu_ring_emit_wreg() to make=
 the write asynchronously on the ring buffer using a CP command.

This way we avoid a bunch of trouble when one process drops the VMID reserv=
ation and another one grabs it.

Regards,
Christian.



Thanks
Jacob

From: Christian K=F6nig<mailto:ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, March 3, 2020 10:16 PM
To: He, Jacob<mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailt=
o:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when a=
pplication reserves the vmid

Am 02.03.20 um 06:35 schrieb Jacob He:
> SPM access the video memory according to SPM_VMID. It should be updated
> with the job's vmid right before the job is scheduled. SPM_VMID is a
> global resource
>
> Change-Id: Id3881908960398f87e7c95026a54ff83ff826700
> Signed-off-by: Jacob He <jacob.he@amd.com><mailto:jacob.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index c00696f3017e..c761d3a0b6e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1080,8 +1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
>        struct dma_fence *fence =3D NULL;
>        bool pasid_mapping_needed =3D false;
>        unsigned patch_offset =3D 0;
> +     bool update_spm_vmid_needed =3D (job->vm && (job->vm->reserved_vmid=
[vmhub] !=3D NULL));
>        int r;
>
> +     if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +             adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
> +

It would be better if we could do that asynchronously with a register
write on the ring.

The alternative is that we block for the VM to be idle in
amdgpu_vm_ioctl() before unreserving the VMID.

In other words lock the reservation object of the root PD and call
amdgpu_vm_wait_idle() before calling amdgpu_vmid_free_reserved().

Regards,
Christian.

>        if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>                gds_switch_needed =3D true;
>                vm_flush_needed =3D true;




--_000_MN2PR12MB3376F4FF11CA27726C7A7CE29BE40MN2PR12MB3376namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Bookman Old Style \,serif";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Thanks! &nbsp;Could you please take an example of tr=
ouble &nbsp;=93<span style=3D"color:black">This way we avoid a bunch of tro=
uble when one process drops the VMID reservation and another one grabs it.<=
/span>=94?</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:Christian.Koenig@amd.com">Koenig, Christian</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 11:03 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:black">Am 03.03.20 um 15:34 sch=
rieb He, Jacob:<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - Internal D=
istribution Only]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><i><span style=3D"col=
or:black">It would be better if we could do that asynchronously with a regi=
ster
<br>
write on the ring.</span></i><span style=3D"color:black"><o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black">Sorry, I don=92t get you=
r point. Could you please elaborate more?
<o:p></o:p></span></p>
</div>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"color:black"><br>
You pass the ring from amdgpu_vm_flush() to the *_update_spm_vmid() functio=
ns.<br>
<br>
And then instead of using WREG32() you call amdgpu_ring_emit_wreg() to make=
 the write asynchronously on the ring buffer using a CP command.<br>
<br>
This way we avoid a bunch of trouble when one process drops the VMID reserv=
ation and another one grabs it.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<br>
<o:p></o:p></span></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style ,serif&quot;,serif;color:black">Thanks</span><span style=3D"=
color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style ,serif&quot;,serif;color:black">Jacob</span><span style=3D"c=
olor:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From: </span></b><spa=
n style=3D"color:black"><a href=3D"mailto:ckoenig.leichtzumerken@gmail.com"=
>Christian K=F6nig</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 10:16 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"color:=
black">Am 02.03.20 um 06:35 schrieb Jacob He:<br>
&gt; SPM access the video memory according to SPM_VMID. It should be update=
d<br>
&gt; with the job's vmid right before the job is scheduled. SPM_VMID is a<b=
r>
&gt; global resource<br>
&gt;<br>
&gt; Change-Id: Id3881908960398f87e7c95026a54ff83ff826700<br>
&gt; Signed-off-by: Jacob He <a href=3D"mailto:jacob.he@amd.com">&lt;jacob.=
he@amd.com&gt;</a><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 &#43;&#43;&#43;=
&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index c00696f3017e..c761d3a0b6e8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -1080,8 &#43;1080,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *rin=
g, struct amdgpu_job *job,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence =3D =
NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pasid_mapping_needed =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned patch_offset =3D 0;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid_needed =3D (job-&gt=
;vm &amp;&amp; (job-&gt;vm-&gt;reserved_vmid[vmhub] !=3D NULL));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (update_spm_vmid_needed &amp;&amp; ad=
ev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, job-&gt;vmid);<br>
&gt; &#43;<br>
<br>
It would be better if we could do that asynchronously with a register <br>
write on the ring.<br>
<br>
The alternative is that we block for the VM to be idle in <br>
amdgpu_vm_ioctl() before unreserving the VMID.<br>
<br>
In other words lock the reservation object of the root PD and call <br>
amdgpu_vm_wait_idle() before calling amdgpu_vmid_free_reserved().<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_vmid_had_gpu_rese=
t(adev, id)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; gds_switch_needed =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vm_flush_needed =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:black">&nbsp;<o:p></o:p></span>=
</p>
</div>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3376F4FF11CA27726C7A7CE29BE40MN2PR12MB3376namp_--

--===============1016478897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1016478897==--
