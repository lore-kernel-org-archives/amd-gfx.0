Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3D8C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0562075E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MTZizN0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0562075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835E26E165;
	Tue, 14 Apr 2020 14:35:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8926E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bialZAlDA7SZqA+tBC9bIw2I9FNbydGOfu2V9erFwF8fRV9LyxJE/PDMAzjM0QybecRfRpHWU79PjRnB6UAzTwZdYvR5LLQk7R5cr4XtLDibqgMsXfdRPBfeIS19gbMnUVVPl3xNH1ixfHMmpUlKbXFSE/dp1GAfJOil2vUfuRZzRPxJIMgkldj2c6hSiJsrHw2uZy1CtfEsuOSub6Q3qN5jaFG8/nmgunD3UYualNU3nFu1SdDXsILrXiX3a8OrU7MPjdRdvnDlu4fzE1lTG1xzrkV+2XC/pMsE31dtqtMIGiQcmbI9G8smccjatDD9uaT52vnOvnCpfScaWpeKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC6X/gnAxLfMH32Cofm3Gcf19eoz+p2PkiKwLR+2ATQ=;
 b=GKcDzNCvkY/2FZXqmBvVR+9PMuP52utBlQg0sWBCt+KUtvxjSh2St8B44Md5N3Bah3SvA6pKhDoAULmEulPJY0hiIjsfIcFT+L2+ZWplMcApGJJhDvjDGsGrTlhLW1jY+MxjJkmtJOikvlc9FitUh8rjsLmxomZ66L3nQe9MhRuI8uBv9f/Sf1wqslJ/2q6S938rZLtfrt/Rq4az0Cy3NB2dYHCEZJWz4kYtNblMedsRaS4z9Bgb0fIPi6++fPOYopiKA1ZwqNNaoNckbfoM27ltk+4szp9L511h0wYmvewSzYb9XjgKc+/n7ghJSs5NuafAvH6zfLGwyez6Pr/+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC6X/gnAxLfMH32Cofm3Gcf19eoz+p2PkiKwLR+2ATQ=;
 b=MTZizN0WFrBCzxB4Q9YOod03axlk6ufBpY33M0UwLH3Irjm/u++1I70R6kotjMCigXE5XIAs2p2LtX7Kh6gZUcP6l6bPcV/fHjrixPAyan4ImPnZwM2d2nRUGTYVq9RzUuWr1yvK2f+J0AshvQB3p0/9bkVFUgZN5dBzdUGntuI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3599.namprd12.prod.outlook.com (2603:10b6:208:d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.25; Tue, 14 Apr
 2020 14:35:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:35:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Topic: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Index: AQHWEcBBe/ZyxQJNjESAzx7Jqz+vzKh4pBqAgAAHvgCAAARpnQ==
Date: Tue, 14 Apr 2020 14:35:43 +0000
Message-ID: <MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>,
 <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-14T14:35:43.161Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f970fa06-bbb5-454d-7373-08d7e0811d19
x-ms-traffictypediagnostic: MN2PR12MB3599:|MN2PR12MB3599:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB35996ABC8CE3EE38EF2C6AD0F7DA0@MN2PR12MB3599.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(110136005)(6506007)(54906003)(26005)(53546011)(186003)(81156014)(86362001)(8936002)(316002)(8676002)(66476007)(71200400001)(66556008)(66446008)(64756008)(7696005)(66574012)(4326008)(2906002)(478600001)(33656002)(966005)(76116006)(66946007)(9686003)(19627405001)(45080400002)(55016002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUtWGsyEc//Ncr3oJWMJcYnlmLNpH39paM7DGDee5NWoQOafT0gL0/twdwJHBihhUKmXwyddigzHnRPGmYiMORDu7KmjJagCCJgsIHRdC3734OdzS4NySygevmRqbmenrC3P/h07XuzDbG+MrshwSRSwPOKM2hmtyC82p1Iq4xgj2YavCXf1v4n6jDnKam24H9aFcqllaltxbIAs5rFyXxbRnWOhKYuFXI7a4hlsg49m4q9gTE0gfIvQplNw9sOXi7KMM9joo1i78OY1z9imHkq9/T6TTHm5c0uMAx466Rc6eCRXqM77BwyWilVjTyCpTqKSEs6Q2U4xFnTeP/ZZuroc98EzLGx/ltG8X3gpRGzpYATHoXI7AwipFH600Eyq0FoABrJCj2MZscXsnNVEtaTX132qmMc/Rh7AwYbXaWa+kWP6pQEN6vDmPYt0gIz4nphfpK0UN3qpF5YM7GfFlKtA+UvSQVUIY+QFjPMoyrI=
x-ms-exchange-antispam-messagedata: NV/jbRYaOzCsY3B5Zg8O5ZUl6mwTzl6HsjQPlVzTeMxZbTPg8ExLplrQIUZ86WEdpk6pmVBj6hBak3l1eOYunZ6fSa/pJYUTfosIg7NdPPDUqRPNGQvOSSSzdRyqTbxSiFsaXUXkyE0+FQuT31Bs4g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f970fa06-bbb5-454d-7373-08d7e0811d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 14:35:43.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bp4hIGNUzXVBL37gZ6z1epi62szY+ArekIuLMZpffYUcuX+bwhMNqFmImjI+qzQ2m/zEat6j/7qZ5axmaIcofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3599
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Content-Type: multipart/mixed; boundary="===============1590347391=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1590347391==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Russell,=
 Kent <Kent.Russell@amd.com>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@a=
md.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0

--_000_MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
If this causes an issue, any access to vram via the BAR could cause an issu=
e.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Russell, Kent &lt;Kent.Russel=
l@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Kim, Jonathan &l=
t;Jonathan.Kim@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0MN2PR12MB4488namp_--

--===============1590347391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1590347391==--
