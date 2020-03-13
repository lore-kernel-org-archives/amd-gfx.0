Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95693C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692A92074A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 13:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z3NqwPyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692A92074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5A86E9CB;
	Fri, 13 Mar 2020 13:43:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD946E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyS5aTELg15eM1OwUImnyfuWO5W673nCmFUbEZ+ZuExHaITUqmlTM/BetLS9dviMO1GoN/QzsPuWgQh9i/5jPIEooPlaB/qibIm5EStW6A1QJ4NwX0WO0wKzMnKWoONFDEg/sfqKXXztEr/LS4mbP2VznZ0K4O4e5Hrv081R/lPvxvotnU4vhfrnn+5b6Fu7DyUPXf3HYGDRYLG4bM5ilYVzBwpui7mZEwZjaRreLmidrvAlsOLAg5mliMEYDG0a3NBrOIBqf3qukeNk9gfounN2kbLqu9myohUWmuwimxNzW6VGCB9yufax+PnPbW2Uku4iox1LaG1JQUZaUbHDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAwqBXVzz4TB2qT/30cLS0cv2vNjT8KFodtmf8fwl7U=;
 b=DR7QVN7igSuu0rhbPwX3JWOIuPg1N0SaVqETkNxO3mkBkxh9zay0/+U9psyoLfri6hnQfp+zDRDM278plm6az5BPZW9BQRCni38mV7NaOweN6ZdQXXBiZBCM3kOC23C53wYUc75dAZgizrAmi8xdnJSwpN1ZU7odVLD6Nj3rG+FYZwiILNKVy6eDf96eFRCaxl8RwgE5yt/C4aAoY4XFDHRvp1pyCF3uqWByp3RXuiLlvDsrjtjk/BCMug2tK19/rC61TUx8qgjKdsmtVcidLYKJB7sPEK7E2uwClpvjOudgHgikKor497G1icuxKoy2gmKtT0a565dXr38FDhVx0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAwqBXVzz4TB2qT/30cLS0cv2vNjT8KFodtmf8fwl7U=;
 b=Z3NqwPycshGqIvxIJSrgQm33XQJqWw+0yVFnjoVJ8//6Gt49cHBsKb84oFNWhW8oXMc7LBdMY58qwNsOjwMC3p5/NRJmm0tBGMc97d3puAIThACn8T/+dJ5zqJQq+Vrjpg3wYqDhA4o0BbMAaNZN0ui+ll4NP9Dn9sSnGIPP2XQ=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 13:43:51 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:43:51 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Topic: [PATCH 1/2] drm//amdgpu: Add job fence to resv conditionally
Thread-Index: AQHV+S4ATH3sb2rsUUK6EyNaVWOphKhGhfEAgAACdbI=
Date: Fri, 13 Mar 2020 13:43:51 +0000
Message-ID: <SN6PR12MB2800F35B043D523EFA3E7AAB87FA0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20200313115305.32325-1-xinhui.pan@amd.com>,
 <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
In-Reply-To: <46ae936e-d255-bf37-6491-2ff25757eac3@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-13T13:43:29.3421500Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.244.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 028fe716-429a-4b8f-1de0-08d7c75490b7
x-ms-traffictypediagnostic: SN6PR12MB2782:|SN6PR12MB2782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB278206AC554D4E5C8E958BE687FA0@SN6PR12MB2782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(9686003)(55016002)(8936002)(66446008)(66556008)(66946007)(64756008)(66476007)(478600001)(2906002)(33656002)(81166006)(81156014)(4326008)(8676002)(26005)(66574012)(186003)(86362001)(6636002)(53546011)(6506007)(71200400001)(7696005)(91956017)(76116006)(52536014)(316002)(5660300002)(110136005)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2782;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LISeNqLOpDvb5XtmYbH201Ga2SU/I4c5dxzyGDDK/oPsFhgNzFsZc6g9OZ+JCJauwqyA3W6OYWDqfOuA3qMS3xjnwqdawKvGxROmREFHWGG5ui5KHZJAQ6F+0sgX8fP/OkJpnLQscUd318PfIJd5UUgdmJ3g1VuwyPLsTNtv+0agLLj3HYMNagZqBdCGnklLnC3gqcrVYKpYz/qAh5Kmom6W91V+t8M2s8gwAtiLf/JXYHarlO2izFusUliX8Rg0kDp/ugFcLhIZpHOWTOHj5piM2sdnyCYHK8YZjlrrAzuHN8Mb6bDdJKPY9i9bZBv3Z9C5ETNumxrDw+sNRnT5/VR5wwL6ufkV09daH5SQVWrTE6jjMRPtVpHAL/GejdyGI94LNbV3uCckST7H14nNLVEaqMTeOaCn3H3vSoBqygisJCua2yOt19JWW+fkvokd
x-ms-exchange-antispam-messagedata: rX1SGzGezQkGlQP7g9UXwhfd3g5MDnvUS/V2bM7sRITOSjn5kRzh3k62vtlQ7ahIY9Zruha4KetjujTOj1wbTUNai9jmx5eUaHFy6GN50ksOnGeBiK8VVMjPYutrdsFesIbzLD1ErppNm2cWH5Soug==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028fe716-429a-4b8f-1de0-08d7c75490b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 13:43:51.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cS11LzfhO079PG9gsNaBClaeLKa+O1uMaURL/KKR4E9gmDvBcygKSb/1CbeqcxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
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
Content-Type: multipart/mixed; boundary="===============0924945019=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0924945019==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800F35B043D523EFA3E7AAB87FA0SN6PR12MB2800namp_"

--_000_SN6PR12MB2800F35B043D523EFA3E7AAB87FA0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

page table BOs share same resv.It should be ok using any of them, root bo r=
esv or bo resv.
I forgot to unref bos which cause problems. not good at rebasing...

thanks
xinhui
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


--_000_SN6PR12MB2800F35B043D523EFA3E7AAB87FA0SN6PR12MB2800namp_
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
I forgot to unref bos which cause problems. not good at rebasing...<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
thanks<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
xinhui</div>
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

--_000_SN6PR12MB2800F35B043D523EFA3E7AAB87FA0SN6PR12MB2800namp_--

--===============0924945019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0924945019==--
