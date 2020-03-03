Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3485C3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABE32073D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J93CVAMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABE32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504986E096;
	Tue,  3 Mar 2020 16:13:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555DE6E096
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 16:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvfOLsBFsKSNxrf5e0zm24uSZ/eBij4wgG350ImBVg5sYpDK6Y2/T0LvDQePG27MN0GvkPfuiVIcIFqU5ajsEJHP5jh4ikpX946JIP8Im8qzPXjkoZB4JGEWOVXp49AzvbsF9vuexh+YlRCM3ZPVositdBiHjoX/t2I2EzdflNPXvKcIvavHv66BjXs/LZozVAKxvHzc6ykbTjgiy8dYu7evEqsE54MBR0L5OeqXlvDhvmgV2s8wXaYKcM5KEveeCmwA2d15MQznbtWHzUnY6XAS7SkKbMsVDCNl8/Dd0wC4CJpSU/itTZXBssffoyUHQli+TIqhQNNSThh2d/0Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk/Vlcg4BNlRyOheSpcYOj1tONcufLwMkkJ5nePa5sw=;
 b=TNXYdGSqbifd0ROK5t4tqNKeeiCtqBahMMWEBpPPu9JcPE8FrY9T/KEqXfRq/Q4EX0YsMGzntSod0jTE+9mRPG/egqI6H8S/+QA4R9n5QRir7EFBa6eQO9yWnjyQWq/XI7x83PvRlbdomGvEUCDsq3RGqi9q8sTVszZSR31aKvjhJicithHzwCe398QY14FZMD9TooNnYQOy9huXpXd0RgUYEgdKd9KaWAZmw5Io6zkUjP/N6hLGQXSovYuaSrSjqfCNG/OfYR9S+sgh2NHfRd99rjsiH/sLJLnbeX3Der/3a1lXWCzYzR72nm77Rardv/LF8aJg80EG//xz+iiY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk/Vlcg4BNlRyOheSpcYOj1tONcufLwMkkJ5nePa5sw=;
 b=J93CVAMDkUARrr9ZCmxyoQvVfcPkb1ucD+0BnsnmxSeicVwXWUMXsj6hpcP6mUxOFIae6lJyYEOMH4J0Foh023Pc51JqNwN1hFydffOk+8bVuhJpKpTijrC4DIcQUjRrYzm4pHKtxg4SFr+jOGRBKuThMwDQrZuATH5FuYaEVOo=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 16:12:58 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 16:12:58 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Topic: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Index: AQHV8FRyok5cRxATf0SYBiJ9i8QZh6g27AOAgAAERJiAAAjwgIAAAzfWgAAF1YCAAAWQtYAAA8gAgAAAxT8=
Date: Tue, 3 Mar 2020 16:12:58 +0000
Message-ID: <MN2PR12MB3376AD43D394205D458985F59BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200302053529.5736-1-jacob.he@amd.com>
 <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
 <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
 <06d9d31f-87c5-b1f1-da93-992531dd57ad@amd.com>
 <MN2PR12MB3376F4FF11CA27726C7A7CE29BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
 <21a8a363-1ebe-a4cb-150d-f84442f322fc@amd.com>
 <MN2PR12MB33768819020B42D37DFDB6809BE40@MN2PR12MB3376.namprd12.prod.outlook.com>,
 <2830d70f-1292-a880-f952-98533056d5d1@amd.com>
In-Reply-To: <2830d70f-1292-a880-f952-98533056d5d1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T16:12:21.0600814Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6298a311-0e53-4054-9237-08d7bf8dbd73
x-ms-traffictypediagnostic: MN2PR12MB4256:|MN2PR12MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB425695108F650A599312080F9BE40@MN2PR12MB4256.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(76116006)(66446008)(2906002)(64756008)(66476007)(91956017)(86362001)(66946007)(66556008)(478600001)(55016002)(53546011)(7696005)(6506007)(9686003)(19627235002)(110136005)(81156014)(5660300002)(81166006)(66574012)(26005)(52536014)(15650500001)(186003)(33656002)(316002)(71200400001)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8PaJgPhNWG8q3Z1b+4WOS99VtqCvMdxu2CziIqJnmIJyGNXWDr4l6yxm+akJMikIoQ95iWRcuV0fx4/CabEODsjXiF/5NGbVs/4BZgTkjAJf1ZX204evb8pHjVFqO6ncx5TJKLDikRdt9cu7lG+0pyxx1Ku1jX5D+ZhL/BOqTIwMsyou42DIScLp6QuzahFd+LFCB+Xadf4kp3ySmqByTElirqU84g5gLZ7Kh2U5PmlcfUO9Mcu7SV6ZGNJg7YE8E5i+wZYJQDfEnDb5c8Odp6MrF2FSG4U8tTVVeYu4tOKHoe1TrWSGIZr7KQ9IDEzmb47gChQYLVOmFWz6vni8Nok9YdNNP78lEQzBhOObngaT64VvAtWEhGMCc7xbuT9kIA8sMloLr1G8/hOtePmjHnek/MXwZXCpPvgvB7u68PGTujEQlPhDE5AAGY+tsvG
x-ms-exchange-antispam-messagedata: GBG+gF23GQS0kDWf6QtjSvYc1MC6VLJIsjE0L9rmp6/4nvEHuGKPM9PLH8WPd8/Bpjp991aLgeGWLCFqnMvSatDmxtsrqU5c6HoVR+V1VVQuD96JPg99RDRg6/cItBIlGS05PY1YTWnQqMk53WxpYg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6298a311-0e53-4054-9237-08d7bf8dbd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 16:12:58.5076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LYkzduWJyAnUNgSjE8Soqx0EW923Wr0LUCJS7/BCZacrokMfDzKrWMS+Qbm9nMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Content-Type: multipart/mixed; boundary="===============0594849000=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0594849000==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3376AD43D394205D458985F59BE40MN2PR12MB3376namp_"

--_000_MN2PR12MB3376AD43D394205D458985F59BE40MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Thanks million! I=92ll change the patch.

-Jacob

________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, March 4, 2020 12:09:36 AM
To: He, Jacob <Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@li=
sts.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when a=
pplication reserves the vmid

Am 03.03.20 um 17:07 schrieb He, Jacob:

[AMD Official Use Only - Internal Distribution Only]


Oh, you are right! If SPM_VMID is updated by other process while the SPM en=
abled commands is executing, that will cause VM fault.



Is the wait vm idle right before unreserve vmid still necessary if using as=
ynchroneously setting SPM_VMID?

No, that are alternative approaches.

Updating the VMID asynchronously sounds a bit cleaner to me, but feel free =
to pick whatever is easier for you to implement.

Regards,
Christian.




Thanks

Jacob



From: Koenig, Christian<mailto:Christian.Koenig@amd.com>
Sent: Tuesday, March 3, 2020 11:36 PM
To: He, Jacob<mailto:Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailt=
o:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when a=
pplication reserves the vmid



See the SPM buffer address is set using CP commands as well, right? And tho=
se execute asynchronously.

When we now synchronously update the SPM VMID we risk that we switch from o=
ne process to another while the new process is not ready yet with its setup=
.

That could have quite a bunch of unforeseen consequences, including acciden=
tally writing SPM data into the new process address space at whatever buffe=
r address was used before.

This is something we at least should try to avoid.

Regards,
Christian.

Am 03.03.20 um 16:28 schrieb He, Jacob:

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












--_000_MN2PR12MB3376AD43D394205D458985F59BE40MN2PR12MB3376namp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal">Thanks million! I=92ll change the patch.</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">-Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 4, 2020 12:09:36 AM<br>
<b>To:</b> He, Jacob &lt;Jacob.He@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Am 03.03.20 um 17:07 schrieb He, Jacob:<br=
>
</div>
<blockquote type=3D"cite">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered
        medium)">
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Bookman Old Style"}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:windowtext}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
.x_MsoChpDefault
	{}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Oh, you are right! If SPM_VMID is updated by other=
 process while the SPM enabled commands is executing, that will cause VM fa=
ult.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Is the wait vm idle right before unreserve vmid st=
ill necessary if using asynchroneously setting SPM_VMID?</p>
</div>
</div>
</blockquote>
<br>
No, that are alternative approaches.<br>
<br>
Updating the VMID asynchronously sounds a bit cleaner to me, but feel free =
to pick whatever is easier for you to implement.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<blockquote type=3D"cite">
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"">Thanks</span></p>
<p class=3D"x_MsoNormal"><span style=3D"">Jacob</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-top:solid
            #E1E1E1 1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal" style=3D"border:none; padding:0in"><b>From: </b><a=
 href=3D"mailto:Christian.Koenig@amd.com">Koenig, Christian</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 11:36 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">See the SPM buffer address is set using CP command=
s as well, right? And those execute asynchronously.<br>
<br>
When we now synchronously update the SPM VMID we risk that we switch from o=
ne process to another while the new process is not ready yet with its setup=
.<br>
<br>
That could have quite a bunch of unforeseen consequences, including acciden=
tally writing SPM data into the new process address space at whatever buffe=
r address was used before.<br>
<br>
This is something we at least should try to avoid.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 03.03.20 um 16:28 schrieb He, Jacob:</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal">Thanks! &nbsp;Could you please take an example of =
trouble &nbsp;=93<span style=3D"color:black">This way we avoid a bunch of t=
rouble when one process drops the VMID reservation and another one grabs it=
.</span>=94?</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"">Thanks</span></p>
<p class=3D"x_MsoNormal"><span style=3D"">Jacob</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-top:solid #E1E1E1
                1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From: </b><a href=3D"mailto:Christian.Koenig@am=
d.com">Koenig, Christian</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 11:03 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</p>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Am 03.03.20 um 15:34 s=
chrieb He, Jacob:</span></p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt; font-family:&qu=
ot;Arial&quot;,sans-serif; color:#0078D7">[AMD Official Use Only - Internal=
 Distribution Only]</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><i><span style=3D"c=
olor:black">It would be better if we could do that asynchronously with a re=
gister
<br>
write on the ring.</span></i></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Sorry, I don=92t get y=
our point. Could you please elaborate more?
</span></p>
</div>
</blockquote>
<p class=3D"x_MsoNormal"><span style=3D"color:black"><br>
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
<br>
</span></p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"">Thanks</span></p>
<p class=3D"x_MsoNormal"><span style=3D"">Jacob</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<div style=3D"border:none; border-top:solid #E1E1E1
                    1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From: </span></b><s=
pan style=3D"color:black"><a href=3D"mailto:ckoenig.leichtzumerken@gmail.co=
m">Christian K=F6nig</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 10:16 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"colo=
r:black">Am 02.03.20 um 06:35 schrieb Jacob He:<br>
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
;&nbsp;&nbsp;&nbsp; vm_flush_needed =3D true;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
</blockquote>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
</div>
</blockquote>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3376AD43D394205D458985F59BE40MN2PR12MB3376namp_--

--===============0594849000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0594849000==--
