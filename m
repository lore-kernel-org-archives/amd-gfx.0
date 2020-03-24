Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC0C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCBE20753
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1/CZfD+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCBE20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F336E079;
	Tue, 24 Mar 2020 19:50:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBBB6E079
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 19:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSe50/WEPJcIJ6TGwUAtFUk95fGEfKBcclbdpo8T+dxio7duM8tzRDe2hM/lyrkTVDRBDVvx7LkhXQGGlOGeUuW+OIid4XMweJrIK5+SIy2NI5l9LU9p2k1ZGq1125/0XAMtQ4Bt/gkjrqFpkLd8YWuFlyoG9/567FQcO9Kvzojec/hN6Hfu1a5P1/p+uORE2pvvDlEUJWBwGUzkVbE/TK9xaJD3IbVVvRUsgafCh0qc5ULT1hDyHhKOSob3XV7om3fcwgH7vJW1BzUQzyTqPt560trX/wczbNtXlbmMB8OsMVmapJFEx5EJNZvsHmseIRe2nm2n3rApVUYzutZyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxQRtksLv7nCj47TR00WYd8m4SToLNp6IVxUVnPCpDA=;
 b=cAIpNoDK9KBsI0T7mGBZoPJZD3XXQ9him378r4XeSmDFcync54VZybcXpQMRl6FDJxSB0D2N+cZTKjKMFt7bWlWoahbqiU8wJyMkIRpOkD7ceNrvO6fuz6V+Y0xAILppZhsCq0iKJFPj7SSXvTcIdiG8vhcetiAxR3utsy3rzMoVD3/NUYI+BM27bOYIP385JL8XQxOYCiClJuQC3Vl3gNOCY21XttQgpdf4pwC8SZQ1GoJJW/NMfHWu2/GP8axOV4HBLR2x6NsCyShwR1FnLL+uMrHhvIMoNVWQmd/RCpZb9UF4+3vEWc4U+wNQ1zPzs5NNNhsaFQDANg/nNOOeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxQRtksLv7nCj47TR00WYd8m4SToLNp6IVxUVnPCpDA=;
 b=1/CZfD+CUpuUAVZAUnP87712oufIGWaim1m/6djpVGrJ3yZnmMbLWuVfUcGhv8K4ZeSvX3deIq3UpevehS+jjJmh0lsdoJmlxgqdu+Gb4SYLiOAJhjWYW78HaK/lkNj5jALiyxb+pMxD+nvrLKjLTaqBurQ3sGqCn3AN00b+2Ks=
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (2603:10b6:301:e::22)
 by MWHPR12MB1678.namprd12.prod.outlook.com (2603:10b6:301:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 19:50:22 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::610d:b9b1:dbd1:1150%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 19:50:22 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Tao, Yintian" <Yintian.Tao@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence
Thread-Topic: [PATCH] drm/amdgpu: hold the reference of finished fence
Thread-Index: AQHWAR681ynWScrGR0OJsdS47W0q0ahW1oUAgAD9EgCAAAHYAIAANAmAgAAfFGM=
Date: Tue, 24 Mar 2020 19:50:21 +0000
Message-ID: <MWHPR12MB1453BEA435472167B7558655EAF10@MWHPR12MB1453.namprd12.prod.outlook.com>
References: <20200323142247.3175-1-yttao@amd.com>
 <2a6a579f-062c-3911-d06a-d4e51f5815a3@amd.com>
 <SN6PR12MB2800A5049C6AB62B7A002AC987F10@SN6PR12MB2800.namprd12.prod.outlook.com>
 <be0e40cf-3ecf-ebe8-2d73-1dd937450c18@amd.com>,
 <f6c79722-8b95-5ea5-7910-5c11b9308d21@amd.com>
In-Reply-To: <f6c79722-8b95-5ea5-7910-5c11b9308d21@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
x-originating-ip: [2607:fea8:3edf:fc00:b4b5:34dd:d598:cd95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 165a37f2-c7ba-45c9-7d07-08d7d02c96b5
x-ms-traffictypediagnostic: MWHPR12MB1678:|MWHPR12MB1678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1678558F1ED2A4B9A662A870EAF10@MWHPR12MB1678.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(966005)(5660300002)(66476007)(66556008)(64756008)(186003)(478600001)(6636002)(45080400002)(66446008)(66946007)(33656002)(52536014)(4326008)(6506007)(53546011)(2906002)(71200400001)(7696005)(8936002)(8676002)(9686003)(81156014)(55016002)(76116006)(86362001)(81166006)(316002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1678;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsdVUTjatOHrrvk/Ou4i4ak4H0yy6dQhxw/AziQxVPTqht2jhAT/CAC+6D13df4oyO8mFitZhYMDolyfrdOFxbkYbiTq6+7eUwUYqsMEbn/7pwX1S+wwReFkub0UTLxSfiQe9K/S/G97WhDGF5DKYKIXZqDCM7guBMEnKkFMF/dDt6o888ubHiXLjRGGViSYpkhmHIwV0lmruU75v96EIkSz9e1/ey8bcmJVM9eYa4vdlLv2SXOiLQAokw8J0h0fr4z6iAVpb2R7Pk1vtNkszGiU0HsyjLGUx7HUbEVrAnlf+fyyteP3sWv/a8ItyY3gnFUwx/b/hMi7O20Ug6Xcqx3CxwnBKDyofHnafqYdKTygTjqUzOCC7x/RCRzv6o4SxLM0waMZGol9Qc9bayHKPQrz86iu5hMmOfy+BMuqAGhm2fwjQN2Vt7PKHBukkhDlFFE5SC7/zCeiNrGMjsbJEg3EBkURDGoSUHZcsdCetgI=
x-ms-exchange-antispam-messagedata: 34gQN1MYuzJ15ER9yXCRTZOWl4bGp/ALc2UC+LtvHodxgeJEjRuzZcMmOMxxicWJcUbYC5jrw7pLWTzOavnQrCy2lF/Lae0kabBNTy+rTMH7pOuYY6fYCOJENeBJAY6LROBuvKvwOut5myATc7118qpn09gLFGcPXGDEWmc/3e0rrothAsgg/4DyAClikLwR/RvvKaFQuX73nmjKY87wFA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165a37f2-c7ba-45c9-7d07-08d7d02c96b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 19:50:21.9970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2p+qArAmfQBWqJKq53L4PUOBL4MB5TU3BkQEaERSq8elaYLvqy4f14s2xm7a/Vp1oLmwrXeJkTEbShsQV9s4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1678
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
Content-Type: multipart/mixed; boundary="===============1047087822=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1047087822==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB1453BEA435472167B7558655EAF10MWHPR12MB1453namp_"

--_000_MWHPR12MB1453BEA435472167B7558655EAF10MWHPR12MB1453namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I see now. In that case the change seems good to me.

Andrey
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: 24 March 2020 13:58
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Pan, Xinhui <Xinhui.Pan=
@amd.com>; Tao, Yintian <Yintian.Tao@amd.com>; Deucher, Alexander <Alexande=
r.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: hold the reference of finished fence

There is a misunderstanding here:

Did you find out why the zero refcount on the finished fence happens
before the fence was signaled ?

The refcount on the finished fence doesn't become zero before it is signale=
d, it becomes zero while it is signaled.

CPU 1 calls dma_fence_signal(fence) without holding a reference to the fenc=
e. CPU 2 at the same time checks if the fence is signaled and frees the las=
t reference because it find the signaled flag to be set.

The problem is now that dma_fence_signal() wants to set the timestamp after=
 setting the signaled flag and now races with freeing the memory.

That's a really hard to hit problem, but it indeed seems to be possible.

Christian.

Am 24.03.20 um 15:52 schrieb Andrey Grodzovsky:

This is only for the guilty job which was removed from the ring_mirror_list=
 due to completion and hence will not be resubmitted by recovery and will n=
ot be freed by the usual flow in drm_sched_get_cleanup_job (see drm_sched_s=
top)

Andrey

On 3/24/20 10:45 AM, Pan, Xinhui wrote:

[AMD Official Use Only - Internal Distribution Only]

Does this issue occur when gpu recovery?
I just check the code,  fence timedout will free job and put its fence. but=
 gpu recovery might resubmit job.
Correct me if I am wrong.
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Andrey Grodzovsky <Andrey.Grodzovsky@=
amd.com><mailto:Andrey.Grodzovsky@amd.com>
Sent: Tuesday, March 24, 2020 11:40:06 AM
To: Tao, Yintian <Yintian.Tao@amd.com><mailto:Yintian.Tao@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@amd.com>; Deu=
cher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher@amd.co=
m>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
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
> Signed-off-by: Yintian Tao <yttao@amd.com><mailto:yttao@amd.com>
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
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cxinhui.p=
an%40amd.com%7C65933fca0b414d12aab408d7cfa51165%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637206180230440562&amp;sdata=3Dz6ec%2BcWkwjaDgZvkpL3jOMYk=
BtDjbNOxlXiAk4Ri5Ck%3D&amp;reserved=3D0


--_000_MWHPR12MB1453BEA435472167B7558655EAF10MWHPR12MB1453namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div>I see now. In that case the change seems good to me.</div>
<div><br>
</div>
<div>Andrey</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> 24 March 2020 13:58<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Pan, Xinhu=
i &lt;Xinhui.Pan@amd.com&gt;; Tao, Yintian &lt;Yintian.Tao@amd.com&gt;; Deu=
cher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: hold the reference of finished fenc=
e</font>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">There is a misunderstanding here:<br>
<br>
<blockquote type=3D"cite"><font size=3D"2"><span style=3D"font-size:11pt">D=
id you find out why the zero refcount on the finished fence happens
<br>
before the fence was signaled ?</span></font></blockquote>
<br>
The refcount on the finished fence doesn't become zero before it is signale=
d, it becomes zero while it is signaled.<br>
<br>
CPU 1 calls dma_fence_signal(fence) without holding a reference to the fenc=
e. CPU 2 at the same time checks if the fence is signaled and frees the las=
t reference because it find the signaled flag to be set.<br>
<br>
The problem is now that dma_fence_signal() wants to set the timestamp after=
 setting the signaled flag and now races with freeing the memory.<br>
<br>
That's a really hard to hit problem, but it indeed seems to be possible.<br=
>
<br>
Christian.<br>
<br>
Am 24.03.20 um 15:52 schrieb Andrey Grodzovsky:<br>
</div>
<blockquote type=3D"cite">
<p>This is only for the guilty job which was removed from the ring_mirror_l=
ist due to completion and hence will not be resubmitted by recovery and wil=
l not be freed by the usual flow in drm_sched_get_cleanup_job (see drm_sche=
d_stop)</p>
<p>Andrey<br>
</p>
<div class=3D"x_moz-cite-prefix">On 3/24/20 10:45 AM, Pan, Xinhui wrote:<br=
>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#0078D7=
; margin:15pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Does this issue occur when gpu recovery?<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
I just check the code,&nbsp; fence timedout will free job and put its fence=
. but gpu recovery might resubmit job.
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Correct me if I am wrong.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Andrey Grodz=
ovsky <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Andrey.Grodzovsky=
@amd.com">
&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, March 24, 2020 11:40:06 AM<br>
<b>To:</b> Tao, Yintian <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:Yintian.Tao@amd.com">
&lt;Yintian.Tao@amd.com&gt;</a>; Koenig, Christian <a class=3D"x_moz-txt-li=
nk-rfc2396E" href=3D"mailto:Christian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander <a class=3D"x_moz-=
txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: hold the reference of finished fenc=
e</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText"><br>
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
&gt; Signed-off-by: Yintian Tao <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:yttao@amd.com">
&lt;yttao@amd.com&gt;</a><br>
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
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists.freede=
sktop.org">amd-gfx@lists.freedesktop.org</a><br>
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
</blockquote>
</blockquote>
<br>
</div>
</body>
</html>

--_000_MWHPR12MB1453BEA435472167B7558655EAF10MWHPR12MB1453namp_--

--===============1047087822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1047087822==--
