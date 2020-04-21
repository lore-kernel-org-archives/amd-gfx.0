Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFB6C54FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145372071E
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 05:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HVQ0t0e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145372071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1646E880;
	Tue, 21 Apr 2020 05:11:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5676E880
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 05:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVXSjNrZrvNLvIQstvndwSnOoyCqov4p85fLeJ6NgZ+DRk5oJ/j/tX5pBTBKkbThZjYYjp4b5Ym3Y+i5iFDhUn2DhU12ujMUqSajS0SbkEhoQkI3aiWXddDyKe2rWJdf6kZYBFsjCKQ8ofKgqAoBbvUsWbjpL0tJmGtFiREbjFjOr1RVUbAAmCGyshu0FbtY61Mp+tToGaZ+IlDzAMNDSOcIrLMV6NrX9eZW8MzQor/DmOvrQGgDvQGyDkS8Evg38N3WlmAlFCZB5m7KW2CcBm7lnPKaNt2vM8mudKbgUZdfI2MMUrM2dWFbl56w6WY4cgorE//0f17q8h3AZgiZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx1/AwhwsArCfRxTmXN+mvD8qkc3wUj4LhAo3SfTx+s=;
 b=kJf7sZeM4RC/CZHCSJUpnV1g20Uvc7wTs6MI7v2VcBjoeiAxk1OB+YqsY+Ci58Ff8Tw91ZbCX9IA6o+FZqWQTiUejTwy/aYxwo01WKIXwUULj4+hZ2vNjacngOrfYd9whHhY0yO+4E+nkgPy4L/sjld1lcvehXlK+0QsZC9yhbsIh3a32lkCVI12zk2QPGaFxNuG5qa4ignsXAad6KThRV8nclg9L7Sbu+ZqcQ55EKHO1gsctufZ15OvC2MwjFWM9N9CKXcmGcWbvffw7/ELiAIOci/22NRJgHsvMrNsyshHBz/Alk12JN6Gm3suygIh5pTDYOABQCkc+rUEGL8ujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx1/AwhwsArCfRxTmXN+mvD8qkc3wUj4LhAo3SfTx+s=;
 b=HVQ0t0e95qYquA8wcqpfPm+DP7qL436FtklkHPIR5hBORmDNOJNLLErmoNxsZRmYPJXySSa1s4ukbNGjb90vIxwgPeK3mKT62YZWZ8f7doRY6XSYinScU2XOzRLP3qyEqO+V0cMiyJzpXdc4NM30skmpAoDPXQrf6M+HLiFbpHo=
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3923.namprd12.prod.outlook.com (2603:10b6:a03:194::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 05:11:17 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1d43:2e08:259d:67ae]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1d43:2e08:259d:67ae%9]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 05:11:17 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: clean up unused variable about ring lru
Thread-Topic: [PATCH] drm/amdgpu: clean up unused variable about ring lru
Thread-Index: AQHWFygw44FrYve+EESnVmn0wDmtM6iCJyGAgADglIA=
Date: Tue, 21 Apr 2020 05:11:17 +0000
Message-ID: <BY5PR12MB40688B281DAAA96F72B8A4A9A2D50@BY5PR12MB4068.namprd12.prod.outlook.com>
References: <20200420152706.37360-1-kevin1.wang@amd.com>,
 <cf3cefe5-1ff4-81d9-060f-39eb9cef6cd4@gmail.com>
In-Reply-To: <cf3cefe5-1ff4-81d9-060f-39eb9cef6cd4@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-21T05:11:16.381Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
x-originating-ip: [58.246.141.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00374459-ea02-45e0-422e-08d7e5b26bd3
x-ms-traffictypediagnostic: BY5PR12MB3923:|BY5PR12MB3923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3923154876E3590E79E64BF0A2D50@BY5PR12MB3923.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:187;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(55016002)(76116006)(2906002)(9686003)(66574012)(19627405001)(8676002)(186003)(66946007)(66446008)(8936002)(7696005)(26005)(64756008)(66476007)(66556008)(110136005)(6636002)(86362001)(71200400001)(91956017)(81156014)(478600001)(53546011)(6506007)(33656002)(52536014)(5660300002)(316002)(4326008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jUXwUHjDXaW8nBtSUT9+BVbHQUui75y4s9VWIrYk5vLOp0yed5ch6yXuwRQeOWSwYWuK1pbPya3L3tRfdQqs307Nmr7hSEvrRVwu5MyM65mPw0JY743PdUm2glS0FyW6SjGhv+WcIA1DT7FWWchWz9nYk1Pg9+0wxyWBcrdRxyvVymWKGxOmeIKc6BXytZiHpUOqYe76itO9AVFXFDhm1EDQrU+zke/1HSn+lo3UaNZbvmpsXlIjLsTQAZErTU1A1Ug207YLrK84ScIwH9wKnAEdRmly5T9qFXha+9t+TisJH4bZd2JgZqCbbV+BwEMt2Nn2sGBlz8UIyt3Xhn8MpOihlxrPIFyyW6koIsqoonim77tKdvQwb4lABWfeLRdYF7zKEMkhEFHqYRcwHTKQQGuCAg0LTNdZaZOTZ6rLmA+WwNcawYp7RVtWK8MPgi71
x-ms-exchange-antispam-messagedata: 1yWHNiu0z4Upf6t5VwSsRMtmW/jy4ho0lP7en3TEK6MReM91ZW2Pvdy7q5AuOC09nSA6AwbZJj1f8ptSrOkFTEI4Qayua2rYLW7C9NXr9SGeWrrlafcGjkS/WXroOnZUwPZECnGh6GpnVqnPmewVOvidG4zoKgd3L3TNWDqfqvzTP4mvvtz410DuVKuT4FhLsoj6a302XM4OFpGzbHK0qI9ShCFr/mAGfjSXvfNDgpRozlOMKnj8yGw7lDBlvI1nr+JMA9OSolN+HBphPPCMKhwzndta4pzSbpYI2egITeKRVNgRcwBnWt3eiQOARNUTAzAmP4OHRcU2KQn9iZyjqYl0z4o3OPUegAO1V23tbwZB8sDAyZr0U9Jy9OH5mi3C6NtOop04ccjVZY4tKnWpgFJwZFhJHOH20LvwRFuRaLjIPYKNnHsLB9ubdi6SOjNXvDFlAO+mkkpAJ0eftWRJfuioPpmvmbTNKygykpktq8g6V/BTmmFpxdsV7lRIEilUhEF1wrIv+HIpsjef3JM6i+xsKA4cSrdoygHbuQreuOFyVV0SULHEzTqUq65Zt6jeJZqDlyEPr/jnVsjrNBNXMdNzZyYxmkfNUB9rHLyyuvzZHBGYfuwjDZ7JjWM1QlAtToHeGTkf99CUxQH5nTH2Et9gehEhDwDIo4tFNGxkGaoUzUncQxbKlhVCTh5RV62DHVd7fDEpvETZZHl9U6+vlY/n3hMjf4d6BNox1L2wpWmbifxkORfstiwdAhlOBz6ET/pg7Tu6BX2Kqluk9C5cHIHd8YdhxUGWRzHVj/MjGcQ=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00374459-ea02-45e0-422e-08d7e5b26bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 05:11:17.0299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEIXiiyqMc1MOV++gSEw0CENo/eRojHe5oVElVS2T9XAtwA2yQhxozhfMf2Wd0+n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3923
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1467618188=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1467618188==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB40688B281DAAA96F72B8A4A9A2D50BY5PR12MB4068namp_"

--_000_BY5PR12MB40688B281DAAA96F72B8A4A9A2D50BY5PR12MB4068namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, April 20, 2020 11:45 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: clean up unused variable about ring lru

Am 20.04.20 um 17:27 schrieb Kevin Wang:
> clean up unused variable:
> 1. ring_lru_list
> 2. ring_lru_list_lock
>
> related-commit:
> drm/amdgpu: remove ring lru handling
>
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>

Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

Found by accident or used some tool? I'm asking because I'm pretty sure
we have more like those.

Thanks,
Christian.

[kevin]:
I found it when I read the driver source code, and then I looked at the git=
 history.
no tools to help.

Best Regards,
Kevin


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>   2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 94dff899248d..e8ab3dde6a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -953,9 +953,6 @@ struct amdgpu_device {
>        /* link all shadow bo */
>        struct list_head                shadow_list;
>        struct mutex                    shadow_list_lock;
> -     /* keep an lru list of rings by HW IP */
> -     struct list_head                ring_lru_list;
> -     spinlock_t                      ring_lru_list_lock;
>
>        /* record hw reset is performed */
>        bool has_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 71ea56e220ae..38eb736091d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2990,9 +2990,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        INIT_LIST_HEAD(&adev->shadow_list);
>        mutex_init(&adev->shadow_list_lock);
>
> -     INIT_LIST_HEAD(&adev->ring_lru_list);
> -     spin_lock_init(&adev->ring_lru_list_lock);
> -
>        INIT_DELAYED_WORK(&adev->delayed_init_work,
>                          amdgpu_device_delayed_init_work_handler);
>        INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,


--_000_BY5PR12MB40688B281DAAA96F72B8A4A9A2D50BY5PR12MB4068namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, April 20, 2020 11:45 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: clean up unused variable about ring=
 lru</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 20.04.20 um 17:27 schrieb Kevin Wang:<br>
&gt; clean up unused variable:<br>
&gt; 1. ring_lru_list<br>
&gt; 2. ring_lru_list_lock<br>
&gt;<br>
&gt; related-commit:<br>
&gt; drm/amdgpu: remove ring lru handling<br>
&gt;<br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
<br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
<br>
Found by accident or used some tool? I'm asking because I'm pretty sure <br=
>
we have more like those.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
[kevin]:</div>
<div class=3D"PlainText"><span>I found it when I read the driver source cod=
e, and then I looked at the git history.</span></div>
<div class=3D"PlainText"><span>no tools to help.</span></div>
<div class=3D"PlainText"><span><br>
</span></div>
<div class=3D"PlainText"><span>Best Regards,</span></div>
<div class=3D"PlainText"><span>Kevin<br>
</span>
<div><br>
</div>
<span></span><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; | 3 ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---<br>
&gt;&nbsp;&nbsp; 2 files changed, 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 94dff899248d..e8ab3dde6a66 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -953,9 &#43;953,6 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* link all shadow bo */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; shadow_list;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; shadow_list_lock;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* keep an lru list of rings by HW IP */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_lru_lis=
t;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; ring_lru_list_lock;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* record hw reset is perfor=
med */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_hw_reset;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 71ea56e220ae..38eb736091d0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2990,9 &#43;2990,6 @@ int amdgpu_device_init(struct amdgpu_device =
*adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;adev-&gt=
;shadow_list);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;adev-&gt;sha=
dow_list_lock);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;adev-&gt;ring_lru_list);=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&gt;ring_lru_list_l=
ock);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;adev-=
&gt;delayed_init_work,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_device_delayed_init_work_handler);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;adev-=
&gt;gfx.gfx_off_delay_work,<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR12MB40688B281DAAA96F72B8A4A9A2D50BY5PR12MB4068namp_--

--===============1467618188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1467618188==--
