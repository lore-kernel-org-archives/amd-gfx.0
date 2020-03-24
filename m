Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDD1C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 14:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF02120774
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X3WJIBSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF02120774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FCA96E4A5;
	Tue, 24 Mar 2020 14:46:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647976E4A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 14:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfTIg9rwCNzKtUyi/Jdp/c14BCRkVBejdtLvVmpi9LgrHBn6/ItA+Rk0MNoIkcsTLgSrasiJzcWrzDS9RC1/XDZ164fipMN8xAQWPKGQib9LW8z0iB7Av3HYkjEiz+prRSHjMxs/1a62bKp0+KMMLQcJucIE37VDKyotMDtMLg9e/LyskE/8UakQFowS66uL0hTgbJQVXtXd7THZuMYGeF0oT+LHYAYDXFbCDWv+6xwwuSC2GS4AI4uDGu6qDMBI/EAxqL3GHu/1Z8KmK0cyxDfQc3UPk3bKqx80oMQ/i1uhdT+6i2KT7o2+HSeiaoBgq+gPu7e8xGJ2t9H2C3LCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxyvtJKi5Dudq8rBxWcsyhWsil86ULTz2pDqUqGbfOI=;
 b=L3NHsvoa5QLQORHPr752gxvO9ksm3pZ9X2+uA20njTHJToypy5i9ieYRKiuB3cfZZxF7BBkrXslsUCfXxOlPjEuTiIOSQjBtMWoiNsalXojgr9rM2ktNRy0hqRsO/RWkVlwPrqpUsj5Si7fVsAZcBR+RS6zM7AvvxZEThc4dKLoIKH0U5QhrADf6jFdDDNoG5bGGmWK9RuY/59AHSnccnGmPq5++xMkLQKQYnx+tQyLJ4Z+BzcUHh2Hy4+XplihdCCSpG6FLZwaVYnzuMEKvuaHw++GAtBx7fJqJohT8mEFbmYQ3GqYE6LWsaseBazKnoUS7jIhZnILWKtowS0jOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxyvtJKi5Dudq8rBxWcsyhWsil86ULTz2pDqUqGbfOI=;
 b=X3WJIBSwZAIRdi10HXUUg+U160zAfWG12qdLVj/y5eYjhLsJnPfevlwswNbiLDs+TAgJaaylYV1Q3CF5gOZr3f3yRSJJiFcvRGoaWFT6wpFXmoDm796Ztgv/Z/pdcOi5oS1sJCGS2/7PvUMcLpd7w6988YF3ZNs4aUKdtJOCqNc=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 14:45:53 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 14:45:53 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Tao, Yintian" <Yintian.Tao@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence
Thread-Topic: [PATCH] drm/amdgpu: hold the reference of finished fence
Thread-Index: AQHWAR6SlPoea5D7BkiixDKMy73BuahXGZQAgAC488k=
Date: Tue, 24 Mar 2020 14:45:52 +0000
Message-ID: <SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20200323142247.3175-1-yttao@amd.com>,
 <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
In-Reply-To: <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-24T14:42:02.9381714Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.212.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88a2317f-f4ae-4a4f-7ccc-08d7d0020d7e
x-ms-traffictypediagnostic: SN6PR12MB2623:|SN6PR12MB2623:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2623F49A7AA6390002B87EA487F10@SN6PR12MB2623.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(6506007)(81156014)(9686003)(53546011)(86362001)(8676002)(8936002)(52536014)(81166006)(71200400001)(91956017)(66476007)(55016002)(64756008)(5660300002)(66446008)(76116006)(26005)(66946007)(7696005)(2906002)(66556008)(33656002)(186003)(478600001)(316002)(4326008)(45080400002)(110136005)(6636002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2623;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIiRpxmP1TvwyBJjU+fi6gHdbEywwBS0jEi83W4TL+KTxwVOO6slk9d+qE4bsggEadlXQDO9n0AKsO4ZF6KeEgS3p7/dOtTfW0aEeOsOBn81gEbiL9qbaXHVlwVivr8RaFqd9r1EoXFO7bZEPnArww308dPzfwe4sPKe+7C86UI+ATn95SQc+Q3LLV4DDAbmFSTQttUzigESSAsUVzBbA7EalKwHoU75LQ6Kmm/oyMOJj6r/3+fdaRLu/KYE6fliqIcr6Xew9esdCVVXAawUMY9EY6YMvhhQlGB9BKC+J3fPcrjLyhRvlvkxoLNnj9zPgj6dmdF+6ufawAGY22V3NHVBbLZCUpKcOm6ZcLsIynLyUrium48G+g2rr+Q2S4A6IkIDEXP6Rwu8gpgNETgZxfdyU55tCIgDWLVVx/RC7+2u9akI3zT0Yks7qt9A1tdA+LFf2fj6ZYsG0zMVZ2klSp/aUGTAzUyf8KpcLvz6ICo=
x-ms-exchange-antispam-messagedata: 436NJfsCFKVX/DaQ/VSpkw76AU2dhFD+ncYNoYklQT6XNM7uuilTK+IeojocNdsrLcLrnn/L69GbNLTgM9UfzWXFFtfXCRUAfHcRSqSzsDf7CA+UFMXW2EGMmkHqcJdFrNWH6wpOfCtxoPLU6LMBjA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a2317f-f4ae-4a4f-7ccc-08d7d0020d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 14:45:52.9870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDwEOhPp63IAljqR8vceta8aeX+bCDAAoKvqbwCkkk46hD+p8o+BtRTnyTbcpS78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1968787497=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1968787497==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800A5049C6AB62B7A002AC987F10SN6PR12MB2800namp_"

--_000_SN6PR12MB2800A5049C6AB62B7A002AC987F10SN6PR12MB2800namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Does this issue occur when gpu recovery?
I just check the code,  fence timedout will free job and put its fence. but=
 gpu recovery might resubmit job.
Correct me if I am wrong.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Andrey G=
rodzovsky <Andrey.Grodzovsky@amd.com>
Sent: Tuesday, March 24, 2020 11:40:06 AM
To: Tao, Yintian <Yintian.Tao@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence


On 3/23/20 10:22 AM, Yintian Tao wrote:
> There is one one corner case at dma_fence_signal_locked
> which will raise the NULL pointer problem just like below.
> ->dma_fence_signal
>      ->dma_fence_signal_locked
>        ->test_and_set_bit
> here trigger dma_fence_release happen due to the zero of fence refcount.


Did you find out why the zero refcount on the finished fence happens
before the fence was signaled ? The finished fence is created with
refcount set to 1 in drm_sched_fence_create->dma_fence_init and then the
refcount is decremented in
drm_sched_main->amdgpu_job_free_cb->drm_sched_job_cleanup. This should
only happen after fence is already signaled (see
drm_sched_get_cleanup_job). On top of that the finished fence is
referenced from other places (e.g. entity->last_scheduled e.t.c)...


>
> ->dma_fence_put
>      ->dma_fence_release
>        ->drm_sched_fence_release_scheduled
>            ->call_rcu
> here make the union fled =93cb_list=94 at finished fence
> to NULL because struct rcu_head contains two pointer
> which is same as struct list_head cb_list
>
> Therefore, to hold the reference of finished fence at drm_sched_process_j=
ob
> to prevent the null pointer during finished fence dma_fence_signal
>
> [  732.912867] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [  732.914815] #PF: supervisor write access in kernel mode
> [  732.915731] #PF: error_code(0x0002) - not-present page
> [  732.916621] PGD 0 P4D 0
> [  732.917072] Oops: 0002 [#1] SMP PTI
> [  732.917682] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G           OE     =
5.4.0-rc7 #1
> [  732.918980] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> [  732.920906] RIP: 0010:dma_fence_signal_locked+0x3e/0x100
> [  732.938569] Call Trace:
> [  732.939003]  <IRQ>
> [  732.939364]  dma_fence_signal+0x29/0x50
> [  732.940036]  drm_sched_fence_finished+0x12/0x20 [gpu_sched]
> [  732.940996]  drm_sched_process_job+0x34/0xa0 [gpu_sched]
> [  732.941910]  dma_fence_signal_locked+0x85/0x100
> [  732.942692]  dma_fence_signal+0x29/0x50
> [  732.943457]  amdgpu_fence_process+0x99/0x120 [amdgpu]
> [  732.944393]  sdma_v4_0_process_trap_irq+0x81/0xa0 [amdgpu]
>
> v2: hold the finished fence at drm_sched_process_job instead of
>      amdgpu_fence_process
> v3: resume the blank line
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index a18eabf692e4..8e731ed0d9d9 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -651,7 +651,9 @@ static void drm_sched_process_job(struct dma_fence *f=
, struct dma_fence_cb *cb)
>
>        trace_drm_sched_process_job(s_fence);
>
> +     dma_fence_get(&s_fence->finished);
>        drm_sched_fence_finished(s_fence);


If the fence was already released during call to
drm_sched_fence_finished->dma_fence_signal->... why is it safe to
reference the s_fence just before that call ? Can't it already be
released by this time ?

Andrey



> +     dma_fence_put(&s_fence->finished);
>        wake_up_interruptible(&sched->wake_up_worker);
>   }
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cxinhui.p=
an%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637206180230440562&amp;sdata=3Dz6ec%2BcWkwjaDgZvkpL3jOMYk=
BtDjbNOxlXiAk4Ri5Ck%3D&amp;reserved=3D0

--_000_SN6PR12MB2800A5049C6AB62B7A002AC987F10SN6PR12MB2800namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Does this issue occur when gpu recovery?<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I just check the code,&nbsp; fence timedout will free job and put its fence=
. but gpu recovery might resubmit job.
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Correct me if I am wrong.</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Andrey Grodzovsky &lt;Andrey.=
Grodzovsky@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 24, 2020 11:40:06 AM<br>
<b>To:</b> Tao, Yintian &lt;Yintian.Tao@amd.com&gt;; Koenig, Christian &lt;=
Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.=
com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: hold the reference of finished fenc=
e</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
On 3/23/20 10:22 AM, Yintian Tao wrote:<br>
&gt; There is one one corner case at dma_fence_signal_locked<br>
&gt; which will raise the NULL pointer problem just like below.<br>
&gt; -&gt;dma_fence_signal<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_signal_locked<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;test_and_set_bit<br>
&gt; here trigger dma_fence_release happen due to the zero of fence refcoun=
t.<br>
<br>
<br>
Did you find out why the zero refcount on the finished fence happens <br>
before the fence was signaled ? The finished fence is created with <br>
refcount set to 1 in drm_sched_fence_create-&gt;dma_fence_init and then the=
 <br>
refcount is decremented in <br>
drm_sched_main-&gt;amdgpu_job_free_cb-&gt;drm_sched_job_cleanup. This shoul=
d <br>
only happen after fence is already signaled (see <br>
drm_sched_get_cleanup_job). On top of that the finished fence is <br>
referenced from other places (e.g. entity-&gt;last_scheduled e.t.c)...<br>
<br>
<br>
&gt;<br>
&gt; -&gt;dma_fence_put<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;dma_fence_release<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;drm_sched_fence_release=
_scheduled<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt=
;call_rcu<br>
&gt; here make the union fled =93cb_list=94 at finished fence<br>
&gt; to NULL because struct rcu_head contains two pointer<br>
&gt; which is same as struct list_head cb_list<br>
&gt;<br>
&gt; Therefore, to hold the reference of finished fence at drm_sched_proces=
s_job<br>
&gt; to prevent the null pointer during finished fence dma_fence_signal<br>
&gt;<br>
&gt; [&nbsp; 732.912867] BUG: kernel NULL pointer dereference, address: 000=
0000000000008<br>
&gt; [&nbsp; 732.914815] #PF: supervisor write access in kernel mode<br>
&gt; [&nbsp; 732.915731] #PF: error_code(0x0002) - not-present page<br>
&gt; [&nbsp; 732.916621] PGD 0 P4D 0<br>
&gt; [&nbsp; 732.917072] Oops: 0002 [#1] SMP PTI<br>
&gt; [&nbsp; 732.917682] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbs=
p; 5.4.0-rc7 #1<br>
&gt; [&nbsp; 732.918980] Hardware name: QEMU Standard PC (i440FX &#43; PIIX=
, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014<br>
&gt; [&nbsp; 732.920906] RIP: 0010:dma_fence_signal_locked&#43;0x3e/0x100<b=
r>
&gt; [&nbsp; 732.938569] Call Trace:<br>
&gt; [&nbsp; 732.939003]&nbsp; &lt;IRQ&gt;<br>
&gt; [&nbsp; 732.939364]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
&gt; [&nbsp; 732.940036]&nbsp; drm_sched_fence_finished&#43;0x12/0x20 [gpu_=
sched]<br>
&gt; [&nbsp; 732.940996]&nbsp; drm_sched_process_job&#43;0x34/0xa0 [gpu_sch=
ed]<br>
&gt; [&nbsp; 732.941910]&nbsp; dma_fence_signal_locked&#43;0x85/0x100<br>
&gt; [&nbsp; 732.942692]&nbsp; dma_fence_signal&#43;0x29/0x50<br>
&gt; [&nbsp; 732.943457]&nbsp; amdgpu_fence_process&#43;0x99/0x120 [amdgpu]=
<br>
&gt; [&nbsp; 732.944393]&nbsp; sdma_v4_0_process_trap_irq&#43;0x81/0xa0 [am=
dgpu]<br>
&gt;<br>
&gt; v2: hold the finished fence at drm_sched_process_job instead of<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_process<br>
&gt; v3: resume the blank line<br>
&gt;<br>
&gt; Signed-off-by: Yintian Tao &lt;yttao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 2 &#43;&#43;<br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index a18eabf692e4..8e731ed0d9d9 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -651,7 &#43;651,9 @@ static void drm_sched_process_job(struct dma_f=
ence *f, struct dma_fence_cb *cb)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_drm_sched_process_job(=
s_fence);<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_get(&amp;s_fence-&gt;finished)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_fence_finished(s_f=
ence);<br>
<br>
<br>
If the fence was already released during call to <br>
drm_sched_fence_finished-&gt;dma_fence_signal-&gt;... why is it safe to <br=
>
reference the s_fence just before that call ? Can't it already be <br>
released by this time ?<br>
<br>
Andrey<br>
<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;s_fence-&gt;finished)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;s=
ched-&gt;wake_up_worker);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cxinhui.pan%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637206180230440562&amp;amp;sdata=3Dz6ec%2B=
cWkwjaDgZvkpL3jOMYkBtDjbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=3D0">https://nam=
11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.=
org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cxinhui.pan%40am=
d.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637206180230440562&amp;amp;sdata=3Dz6ec%2BcWkwjaDgZvkpL3jOMYkBtD=
jbNOxlXiAk4Ri5Ck%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN6PR12MB2800A5049C6AB62B7A002AC987F10SN6PR12MB2800namp_--

--===============1968787497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1968787497==--
