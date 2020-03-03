Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F5C3F2CD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E9E2064A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OWqe+rm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E9E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 314FB6EA75;
	Tue,  3 Mar 2020 14:34:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3366E6EA75
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 14:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrWxBxoNGIHjAOL+R9gahk3zkEZwPeRhYBWgtcGUPOEmE8h+H04M1M02k7rUmfxMIXSYlzVM/3+gbeReEk9rPRGb+u/O7xoZlkbKJ++2CLos/aXMOJBNqMx6qNWG8pHbVtxfW8tO0aopdValb7YDkxK1F2clTzpyRLvYqxh9iD165TAzKhDAuQR1FaSROlkGu+SZ5t/q1fJBSXybNET7EEULKc4peGouGvQXk7l3EuoPsYGtE0O5yo+R9i/pMWYrHqTrPwBiB43Bvbzh72N4MHsRVtnAzHrWTfuc/Y2dbFo2R2eIAzKHO+FG/IS3CiFtReJmDWAv8PBLuaCwUJuPWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP52GsfCGXe9tnAJZtToHskeAPGQ5U+JOEEGOlkFIAI=;
 b=VyEJpUAEOJzSqe92E0b9uxiB9ybI+UFOJAGbY2tW2Rz3opzTy5SJGq3ZOwMD9yIWHtQKlRYS3gpi0gIkv/sogfhsj++SdWXVwVvWMUgFnYkZ3il/5pBDYacF+4rQOEFFikKfshAn0MlBo2rhGfDapeijPoaG9GmQdhFnkz9CHg1RTWhfyojFMdv/E9eI64tXRyZe9M4fGYzTh7crP6DtyB+iCpsZrbn/wUqpOS0iGnfWA7hW6jiPtQd9vS8hS4bhm/0N8XdIvZOmbjJmDawN0YM3wwlWdfURHliS8tHG0EgRD6k3eOelc+c1Vo564WtEZby+Vv9iRdCKbqD1hN4+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP52GsfCGXe9tnAJZtToHskeAPGQ5U+JOEEGOlkFIAI=;
 b=OWqe+rm83E0hFJ8kQzf4L3dE2EkjDJZlQ3kUMJJkQfD3Q8zz6jk4g3LWlkshkfdLNUoGIFn5RsNgZkmAt1xygA+rVTOrF+CTTUwgrFEiqLND0ix+noK19GVv5DKRj6Aau/DF8+9FQ4F5Ezcr9b495v0aQzjIv4k/4D5xUqE7Egk=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (2603:10b6:208:c2::20)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 14:34:42 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:34:42 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Topic: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
Thread-Index: AQHV8FRyok5cRxATf0SYBiJ9i8QZh6g27AOAgAAERJg=
Date: Tue, 3 Mar 2020 14:34:42 +0000
Message-ID: <MN2PR12MB3376C82E9294503F14F928A79BE40@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200302053529.5736-1-jacob.he@amd.com>,
 <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
In-Reply-To: <0bbac128-473d-b8d1-9b5a-ceb25357c81c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-03T14:31:47.3413620Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed460c74-8cf1-45ba-7cbf-08d7bf800305
x-ms-traffictypediagnostic: MN2PR12MB4517:|MN2PR12MB4517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45172F640526E681570F83579BE40@MN2PR12MB4517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(55016002)(91956017)(478600001)(33656002)(186003)(66446008)(66556008)(52536014)(64756008)(26005)(86362001)(66946007)(76116006)(9686003)(66476007)(71200400001)(15650500001)(81156014)(53546011)(6506007)(7696005)(81166006)(8676002)(8936002)(66574012)(5660300002)(316002)(2906002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4517;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6azCdLsLz3JCjoeNHhU2E3/nDeXOXpS4bFIfanXVkoY+wAQp7DZJmp9O3caAGegWkeoqAU4sYpZrefnyn+SJefAQhOPiL4EO56KdjtULszeLWHb25dSdbSMrI1LA9oP6rmYTQflXyR4Bh7OkKIVLZIAyoheLIPA0nlQXBdKOqKz2lG3KJAjSSE+PrQKWCLJ4efVNy7KgUm+XleJ8vu5Vp6HQwR+UKBNIfOT04jVw/NO/5kB4LUeu2IDa+fBKD1+swxu/BM6L9q7fjT+MUe5m0FGchQXBly64zyx71UZQ/7Vm2GXQep9tfWrp2wMl4ooYb7AKtWxQd1clpPmLokX8qdHWXFMIudCTZdxyKHAHS1Wfu4aiiTpbA9lrWDdmZ/UiQtIr/LBEbQKJnuU2wx2SbfI79iB4/RHd6LX9EV70dFHOmMJhEtMyT6F1sd7wPNw
x-ms-exchange-antispam-messagedata: 3qCzWBN6etnCEQZjPVfGnvrHP+4Ovn88zHkEDGgCWqgHwRyRMIuxf3x0biscsBjX8yJJCQiPZ/HjGaRtDEc94nE7fYto7C0nwxxtDxAs0CfxcYgtMJnfzxel3sEXwlmbG+WehMxO9kbmZWrW9IOL0w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed460c74-8cf1-45ba-7cbf-08d7bf800305
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 14:34:42.3095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkZS9tjS1Je6raybYW1HqsmkhxEIGTm29GLRM3iVDbx8z/ndohk3wbMIrEmarRJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517
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
Content-Type: multipart/mixed; boundary="===============0510560024=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0510560024==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3376C82E9294503F14F928A79BE40MN2PR12MB3376namp_"

--_000_MN2PR12MB3376C82E9294503F14F928A79BE40MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

It would be better if we could do that asynchronously with a register
write on the ring.

Sorry, I don=92t get your point. Could you please elaborate more?

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
> Signed-off-by: Jacob He <jacob.he@amd.com>
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


--_000_MN2PR12MB3376C82E9294503F14F928A79BE40MN2PR12MB3376namp_
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
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal"><i>It would be better if we could do that asynchrono=
usly with a register
<br>
write on the ring.<br>
<br>
</i></p>
<p class=3D"MsoNormal">Sorry, I don=92t get your point. Could you please el=
aborate more?
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:ckoenig.leichtzumerken@gmail.com">Christian K=F6nig</a><br>
<b>Sent: </b>Tuesday, March 3, 2020 10:16 PM<br>
<b>To: </b><a href=3D"mailto:Jacob.He@amd.com">He, Jacob</a>; <a href=3D"ma=
ilto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid=
 when application reserves the vmid</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Am 02.03.20 um 06:35 =
schrieb Jacob He:<br>
&gt; SPM access the video memory according to SPM_VMID. It should be update=
d<br>
&gt; with the job's vmid right before the job is scheduled. SPM_VMID is a<b=
r>
&gt; global resource<br>
&gt;<br>
&gt; Change-Id: Id3881908960398f87e7c95026a54ff83ff826700<br>
&gt; Signed-off-by: Jacob He &lt;jacob.he@amd.com&gt;<br>
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
;&nbsp;&nbsp;&nbsp; vm_flush_needed =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3376C82E9294503F14F928A79BE40MN2PR12MB3376namp_--

--===============0510560024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0510560024==--
