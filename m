Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015DCC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55702073E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4gWa+SFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55702073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBB66E9C6;
	Fri, 13 Mar 2020 13:43:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F286E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+1iFj04K8x/5KccO8VjfdS2lb5tiwhX5PH8NZw/4bAzxSvY+/CKuuwKwlZgiXgwAPDK9VO5yvggiUOvKMc0PsZqKsoHC9NnD6i25UbG3PFrwlrADdQODYZPCR28EDZktH0zwP1J9P00i8XO3t+FuDu9USs/iXMWszffGumMaMNWuYs8pnKYDk0P/8RrkHyFHcTOwkeMfj0Xf33E72Fn8Dgd4+nUGBaf/ossp1iuTyn9abaOzFeEuMJVAPc5luIUsuslpHVTqpEXzKnVmM1NRuJgjdrleD20FYFr/1wsgeMVnVBlmP2/x92m/DsiAeO7iWdyJOkoEZPI4/E+lRq7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT9TPm/Ug+ADSDKQAyH/NeWcFQJBgEwcuOZmhm4vyCc=;
 b=NggVASs0eER6Rw7RLfg10uXk4K8Wi80Kzds92dMOylI+NPUQ++lIDUrPmrTfQq9ThDKN9tU/3+Viz0eekRBlVu+PTW4Ippoj9kCU/9UZlKHUcQH+OjzY8/0IXzVNLLTfVgII433izukRrR+qkeRLn12Ve9G6F3n34m7UIH1hbJj0joaLoTQnqSIl+1jvEEnlAA0ZOYWVDWUSGOUDRaTIHo4SSfzOqU4NsrPq+Lp0NHkTmsCM0l42v3Nk58bOQcSpyK6bsCylOK2PwfpkVFT2l/o6htg6wAAImuJtgOSKrjUgTJcuVIA25HdELNtUW9gr8yGCn1cODMeMfoRa9pfoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT9TPm/Ug+ADSDKQAyH/NeWcFQJBgEwcuOZmhm4vyCc=;
 b=4gWa+SFw7aqcRl8wlDUILuE+nvf5tLz4VzMtFE75qEBg/DpoQMlMPTU4bS6mF8Zklr1Dag4sPbQA6MYB60IZzKi06LT7bVXnVpAmz3gBNUfDnUvM+z+LxsdZVfpvGh7evEh+zAzX9N5KTQaQR17GfoioqfyRxSGV9Iry2uDLvJY=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2831.namprd12.prod.outlook.com (2603:10b6:805:ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 13:43:03 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:43:03 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Topic: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Index: AQHV+S4ATH3sb2rsUUK6EyNaVWOphKhGhfEAgAABOwM=
Date: Fri, 13 Mar 2020 13:43:03 +0000
Message-ID: <SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20200313115305.32325-1-xinhui.pan@amd.com>,
 <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
In-Reply-To: <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-13T13:39:06.3494787Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.244.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee7b7a61-337e-4635-e458-08d7c75473ee
x-ms-traffictypediagnostic: SN6PR12MB2831:|SN6PR12MB2831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB28316862C96674D0CF0898B587FA0@SN6PR12MB2831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(5660300002)(2906002)(53546011)(91956017)(6506007)(316002)(4326008)(76116006)(478600001)(81156014)(8936002)(8676002)(66446008)(66476007)(86362001)(66556008)(33656002)(64756008)(66946007)(81166006)(110136005)(66574012)(7696005)(26005)(54906003)(55016002)(186003)(71200400001)(9686003)(6636002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2831;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Yq8dEwZkD9pe/UeMbFu7lZMxEGfasXValZ2lkTq6X2C3ClG/sXC4TcBKUFsrblIrRfvVESy7tiDClDOyoPRfJmY+D6jyH6brrK3zrCHc4grMhCOQXOoIgywRoZ9IA4PH5fTxqmOGqdKMxu224cicL+KCmhvuDeWq7/jzGJv7Yw0fK5d12mbtIKlxYVQyNiXUE0Eq5Vhe7BVxkHrqtQqZNJO40fJXScY/7AB/8+bNphQrdGOFQUmOdSju/sJvcKyFO9J3ZLNndGbeUbxWce82MjPvxcc5DqWASqCdIrpqzEkdtRI91uBxI0EdAE4Lj5NStb+tb2WFFGJ+vgUXdcKTQYerNohtTAGwZ1esZdAP3d4/K3RrO6/O+rkxbD1Dz1D9MmSoFjVLOKsG0Qf7vPNR5mTg5YNoTn2QLT4nXzxXDuO+OZyKApmlxwEwW2UCjwv
x-ms-exchange-antispam-messagedata: Bu/ONcN43XEXuUkSsAhgjtN9KgcDVsc3ft6t2w6+QNr9va4yALoxM3UWeiycra28+lnAGCq268wX5kTiU0YKAQaz8CDQrgvz6NRjK23rvp3X0AAW5bpH1sqUXcgdCPFjsGpvwtQdj+/FyBWnVc1YyA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7b7a61-337e-4635-e458-08d7c75473ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 13:43:03.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzvX4tmMnIJi6K5MsRZTWSSieK+uEAJb9w8FEcgdUkPQ0Xeyhspy33MToV5+BIEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: multipart/mixed; boundary="===============0007609112=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0007609112==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0SN6PR12MB2800namp_"

--_000_SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

page table BOs share same resv.It should be ok using any of them, root bo r=
esv or bo resv.
I forgot to unref bos which cause problems. not good at rebasing...


________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, March 13, 2020 9:34:42 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally

Am 13.03.20 um 12:53 schrieb xinhui pan:
> If a job need sync the bo resv, it is likely that bo need the job fence
> to sync with others.

That won't work because this is the wrong resv object :)

You added the fence to the mapped BO and not the page table.

No wonder that this doesn't work,
Christian.

>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Suggested-by: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 5 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9 +++++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index b5705fcfc935..ca6021b4200b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -226,6 +226,11 @@ struct amdgpu_vm_update_params {
>         * @num_dw_left: number of dw left for the IB
>         */
>        unsigned int num_dw_left;
> +
> +     /**
> +      * @resv: sync the resv and add job fence to it conditionally.
> +      */
> +     struct dma_resv *resv;
>   };
>
>   struct amdgpu_vm_update_funcs {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_sdma.c
> index 4cc7881f438c..0cfac59bff36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -70,6 +70,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_upda=
te_params *p,
>
>        p->num_dw_left =3D ndw;
>
> +     p->resv =3D resv;
> +
>        if (!resv)
>                return 0;
>
> @@ -111,6 +113,13 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_up=
date_params *p,
>                swap(p->vm->last_delayed, tmp);
>        dma_fence_put(tmp);
>
> +     /* add job fence to resv.
> +      * MM notifier path is an exception as we can not grab the
> +      * resv lock.
> +      */
> +     if (!p->direct && p->resv)
> +             dma_resv_add_shared_fence(p->resv, f);
> +
>        if (fence && !p->direct)
>                swap(*fence, f);
>        dma_fence_put(f);


--_000_SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
page table BOs share same resv.It should be ok using any of them, root bo r=
esv or bo resv.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I forgot to unref bos which cause problems. not good at rebasing...</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div><br>
</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, March 13, 2020 9:34:42 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditio=
nally</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 13.03.20 um 12:53 schrieb xinhui pan:<br>
&gt; If a job need sync the bo resv, it is likely that bo need the job fenc=
e<br>
&gt; to sync with others.<br>
<br>
That won't work because this is the wrong resv object :)<br>
<br>
You added the fence to the mapped BO and not the page table.<br>
<br>
No wonder that this doesn't work,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Cc: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
&gt; Suggested-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; | 5 &#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 9 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; 2 files changed, 14 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index b5705fcfc935..ca6021b4200b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -226,6 &#43;226,11 @@ struct amdgpu_vm_update_params {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @num_dw_left: number=
 of dw left for the IB<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dw_left;<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @resv: sync the resv and add job=
 fence to it conditionally.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv;<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_vm_update_funcs {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; index 4cc7881f438c..0cfac59bff36 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c<br>
&gt; @@ -70,6 &#43;70,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_=
vm_update_params *p,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;num_dw_left =3D ndw;<b=
r>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;resv =3D resv;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!resv)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -111,6 &#43;113,13 @@ static int amdgpu_vm_sdma_commit(struct amdgp=
u_vm_update_params *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; swap(p-&gt;vm-&gt;last_delayed, tmp);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(tmp);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* add job fence to resv.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MM notifier path is an exception=
 as we can not grab the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resv lock.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;direct &amp;&amp; p-&gt;resv)=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; dma_resv_add_shared_fence(p-&gt;resv, f);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence &amp;&amp; !p-&gt;=
direct)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; swap(*fence, f);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN6PR12MB2800ADC4C5ED7DDCAEA288E787FA0SN6PR12MB2800namp_--

--===============0007609112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0007609112==--
