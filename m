Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC14C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7599F20719
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 06:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W/42D+qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7599F20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288FE6E277;
	Thu, 26 Mar 2020 06:01:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B826E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 06:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwF+O80E2L88UMqkK8Kcu2r6y9oTcLbCvPJCHAaRsmH7/fmHqXSdPghJ+PLH9hl8FfOGq4C2ZdbJ5raA/xaxkOIlDqNbJ5UdougWZjvfmXtMmhTaQeb9csbH+Q8wnSyNHScDsF3Z3tJHkA6PcfmGE4bg4oXw2xbBG+ol4+5K9IBS09sSxledakCGscV8sXH9OKsi8Eft/EAYka5bt5cJhY86yCWIwHaCaNmBPNllYD0lXRQUtp2V/GDMbciA/fXgbB51SEiDSaZBYBHaxQb0X1Bllfz0spRx6eOah+AREOwmnl+3iDBJFe9D0zpjKThnIjMs8ZIn/EkLXRtxdCARQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eY3kXa5YoeKHUny3B3LH3BxvHrf6umibxZW9JCjLN0=;
 b=ScXqL+gnpzuCRfI0FLKZqct9QUTDdbpvu+X6qXB4qSSQQW+LVlDGIH7PXMkwBAFGSZV+swUr/B3Ua5hbGZpfyS/1Gf1YOkvHypEenTlOvanyHpBssdoYJ9a0CocDrCaStbfPApEImqFuVODFlLpq+Z+8dU7b1UFGe6nCpmYNinwAL7zp4q/5eixuCUkZHXy4OWL/CizYsj65PaKySlajLpQXIOgIV/78PjMC/zbx6yILBdUc0CW0daiNea3sJQcAa9bl/sxtqJ/zIzJQI2VzFvdLay5VO3Ek6fPdxtRIDnYUCS79iBYzbTlqLR6ENFqB4gGasYlciD08YXoOQbxwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eY3kXa5YoeKHUny3B3LH3BxvHrf6umibxZW9JCjLN0=;
 b=W/42D+qFXnZ/KNeWOlPL3hzy1i1p1+W6lze8iJqgUO+cm9RbiAzrZLRjdeKx1+yirwEsgLRZnuvR736mIdLSmXsGw39PJzhv6lf4vmAfxQuaUI/gqgR7eUHHYT4ogGJom0EWwIJi3oTqG+SX/OcAZxccCIz65JNrrp8W8828SPw=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 06:01:45 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 06:01:45 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Monk" <Monk.Liu@amd.com>
Subject: Re: [RFC PATCH 0/2] add direct IB pool
Thread-Topic: [RFC PATCH 0/2] add direct IB pool
Thread-Index: AQHWAxKMzQIZxjiVoEK7h5jr744zKahaWVYAgAAGFFg=
Date: Thu, 26 Mar 2020 06:01:45 +0000
Message-ID: <SN6PR12MB2800000B1CB04514C02CD81F87CF0@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>,
 <CY4PR12MB1703BFC301A1A22BF912869D84CF0@CY4PR12MB1703.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1703BFC301A1A22BF912869D84CF0@CY4PR12MB1703.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-26T05:52:48.5484430Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [101.88.212.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb93fda2-548c-42af-a805-08d7d14b29e7
x-ms-traffictypediagnostic: SN6PR12MB2621:|SN6PR12MB2621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2621A867D2796EC7F220587287CF0@SN6PR12MB2621.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(966005)(52536014)(71200400001)(26005)(53546011)(7696005)(4326008)(6506007)(2906002)(6636002)(81166006)(81156014)(91956017)(66476007)(66446008)(66556008)(45080400002)(110136005)(316002)(86362001)(5660300002)(55016002)(76116006)(8936002)(186003)(478600001)(33656002)(66946007)(64756008)(54906003)(8676002)(9686003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2621;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzpAUYAl/aPPRcXjKpxdB4cGmwUcd4mj7qq95FLdHMrw8vawvh6G/uSJJjj/HvhJFjZtvnl2kutnHwqcjyzCes9wCpXV1HlHxx1L7V3FVTD2/xJwPftiJ0tvKo9gcI2sSowBBSd1Wt7WXBsVDt4tBSzOyIf8DIE0NtA7IIDeBk55uW3r2pSiH/YCo5qgRGMTh4EC85BdQTremTK/41rT7RqYWGMa+UkNUn3DY2SVASbUAuEF2L8TYpzfeqDHMJieb0MlIw9zjretRmvjG9RmeSOm2qA0twv3eAT4N3/EpaVcGcCm3fH1WGJL5ijOcsEHcKnafh82UK56vRkiFTI4dzCAVSNX7AEriPh2DWLBa/1Qct3B29OLDBG4T8bhAsP0GjxTDdHzftxzsYxVyPG1y29gWEQldnFg1tDVNRnG8cMti8n3ivHLzChAqyu/9D3bYL+o2xg1CA+F+XjAC0nUYa2vgBa3GlSEq2+qAR5cUAo=
x-ms-exchange-antispam-messagedata: 274Z3OjTkz8kAfJox8CIZcCHd8G7E3R2CX5FhhVdYXVfNzhdxEoV4tijqTAjxOJn6GUW0U9mzD3RJUsF5DQs+gDiFXjdiJB+t2l0FnkkYk6n7fFZkDBWSv7dW8WP8aNHa3dE7pBJdQT6XTbZMA3+LA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb93fda2-548c-42af-a805-08d7d14b29e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 06:01:45.0545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtcHYpeIFlQtigfjqh+ddPle+0ji+555HgEIZliCgdV0rcK/rtrk0clZ83qUK+P9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
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
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0209891244=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0209891244==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800000B1CB04514C02CD81F87CF0SN6PR12MB2800namp_"

--_000_SN6PR12MB2800000B1CB04514C02CD81F87CF0SN6PR12MB2800namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

yes, IB test and  vram restore will alloc IBs.

I hit this issue for quite a long time ago. We test benchmarks on ARM serve=
r which is running android.
Hunders of processes hit too many issues. Panic and memory corruption every=
where.

Now i have a littke time to fix this deadlock.

if you want to repro it, set gpu timeout to 50ms=1B$B!$=1B(Bthen run vulkan=
,ocl, amdgputest, etc together.
I believe you will see more weird issues.

________________________________
From: Liu, Monk <Monk.Liu@amd.com>
Sent: Thursday, March 26, 2020 1:31:04 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>
Subject: RE: [RFC PATCH 0/2] add direct IB pool

That sounds a roughly doable plan to me , although we didn't hit this issue=
 in our virtualization stress test but like a possible issue.

>>> So the ring test above got stuck if no ib to alloc.
Why there is IB alloc happened in ring test ? I remember there is no IB all=
ocated for ring test, are you referring to IB test ?



_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of xinhui p=
an
Sent: Thursday, March 26, 2020 10:02 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Christian <Chr=
istian.Koenig@amd.com>
Subject: [RFC PATCH 0/2] add direct IB pool

druing gpu recovery, we alloc ibs for ring tests to test if recovery succee=
d or not.

As gpu recovery parked the gpu scheduler thread, any pending jobs hold the =
ib resource has no chance to free. So the ring test above got stuck if no i=
b to alloc.

If we schedule IBs directly in job_submit_direct, we can alloc ibs in the n=
ew ib pool. It should have less contention.

If the IB could be freed in time, IOW, not depending on any scheduler, nor =
any other blocking code. It is better to alloc ibs in direct pool.

xinhui pan (2):
  drm/amdgpu: add direct ib pool
  drm/amdgpu: use new job alloc variation if possible

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  4 ++--
 13 files changed, 35 insertions(+), 18 deletions(-)

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cmonk.liu=
%40amd.com%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637207850237679644&amp;sdata=3DcS7S7a8gDmIgyJNbr4qXSPMZTLwK=
z0W429Z%2F2Zo6gek%3D&amp;reserved=3D0

--_000_SN6PR12MB2800000B1CB04514C02CD81F87CF0SN6PR12MB2800namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
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
yes, IB test and&nbsp; vram restore will alloc IBs.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I hit this issue for quite a long time ago. We test benchmarks on ARM serve=
r which is running android.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Hunders of processes hit too many issues. Panic and memory corruption every=
where.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Now i have a littke time to fix this deadlock.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
if you want to repro it, set gpu timeout to 50ms=1B$B!$=1B(Bthen run vulkan=
,ocl, amdgputest, etc together.<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I believe you will see more weird issues.<br>
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Monk &lt;Monk.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 26, 2020 1:31:04 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt=
;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> RE: [RFC PATCH 0/2] add direct IB pool</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">That sounds a roughly doable plan to me , although=
 we didn't hit this issue in our virtualization stress test but like a poss=
ible issue.<br>
<br>
&gt;&gt;&gt; So the ring test above got stuck if no ib to alloc.<br>
Why there is IB alloc happened in ring test ? I remember there is no IB all=
ocated for ring test, are you referring to IB test ?<br>
<br>
<br>
<br>
_____________________________________<br>
Monk Liu|GPU Virtualization Team |AMD<br>
<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of xi=
nhui pan<br>
Sent: Thursday, March 26, 2020 10:02 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Koen=
ig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
Subject: [RFC PATCH 0/2] add direct IB pool<br>
<br>
druing gpu recovery, we alloc ibs for ring tests to test if recovery succee=
d or not.<br>
<br>
As gpu recovery parked the gpu scheduler thread, any pending jobs hold the =
ib resource has no chance to free. So the ring test above got stuck if no i=
b to alloc.<br>
<br>
If we schedule IBs directly in job_submit_direct, we can alloc ibs in the n=
ew ib pool. It should have less contention.<br>
<br>
If the IB could be freed in time, IOW, not depending on any scheduler, nor =
any other blocking code. It is better to alloc ibs in direct pool.<br>
<br>
xinhui pan (2):<br>
&nbsp; drm/amdgpu: add direct ib pool<br>
&nbsp; drm/amdgpu: use new job alloc variation if possible<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
| 12 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 =
&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 6 &#43;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |&nbsp; 3 &#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;13 files changed, 35 insertions(&#43;), 18 deletions(-)<br>
<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cmonk.liu%40amd.com%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637207850237679644&amp;amp;sdata=3DcS7S7a8gD=
mIgyJNbr4qXSPMZTLwKz0W429Z%2F2Zo6gek%3D&amp;amp;reserved=3D0">https://nam11=
.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.or=
g%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cmonk.liu%40amd.co=
m%7C1f5b1a3ba10a452c9de608d7d129b396%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637207850237679644&amp;amp;sdata=3DcS7S7a8gDmIgyJNbr4qXSPMZTLwKz0W42=
9Z%2F2Zo6gek%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SN6PR12MB2800000B1CB04514C02CD81F87CF0SN6PR12MB2800namp_--

--===============0209891244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0209891244==--
