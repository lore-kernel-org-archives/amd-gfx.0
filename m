Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F6BC4BA18
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 18:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350B524650
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2cjyRiCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350B524650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB9F6EB83;
	Wed, 26 Feb 2020 18:18:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CD46EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 18:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj3OVsIWSr3y4yJek2j7vZQjb7F9WSgim+NFlbdgblarZtUQtobp2mFtvafbA5lnJyy2tSChyMcfIdp3r6/DChfXPPkC1AosL6SiC5HiXYUO3NJdLRs4SsLjuiQxEIgFJtZU4ieYAebfZV8PDX8LrirEoCBiQNYxdCp0mIIqJukzuB/FVxbxcMTLeYDMtsXN+KYVYJ2x3gFTHMWXPMYWXDpgsuLhVrqqfCn0ljhx4CMZwM48UIzsE8b62+1fM81XRxZU7rU2dq/OEIJuwBdY0tBdKC9VlrZIqywhmJ3w5DNFpbdATTJs3kG0ws6kadGR9GYaAAJSTHgbw481EawhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUvtYWO9ccIeXrLcnv2k8ZjsPUZIpwSGe2lWTkaJPiM=;
 b=fvy2GGmmQbz6vJqXjIHrHE8v//z7gxPYARFJZpGlU6mJEZJ/A8+BR/sjko2D24ULXaA3ypDbwB19TEilnvPtKJwT0/DjDunFNuRwSA4CfAxXj/8ZT3SyLp18qgu0yUm9bOHF/V8Q/uMmaJ+0OGjWQAFCpiU55f/9+sH5aXmbbsDI2gyxnf7x/asOL54+SBSTx6+isQJgqZLovLsZxhhYJjpaeqtnWaWNkpEv+QuaTxaHp0j8k5gU1k8kQHzHkxqsGrvZXaoGiUhhQAH95AYHln29loK3F8R6y3+wbFAsFdFOcjEOnGauZwu3bCksJNN0UctQ2NnKcGbUCnJdTYuLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUvtYWO9ccIeXrLcnv2k8ZjsPUZIpwSGe2lWTkaJPiM=;
 b=2cjyRiCqqqjM28mRE5BcRx/sWX1NevWuKoLqE9NlHrPcPAWLD6yRuBn++9/QpkUX5udo0Ia9xqRsbVXkzRmMb0ptgIRkBZ0gPYYOAApNQlnfrcgGoyqmeAInyiI6NNKwPySqdgsurBXIFYkVbW2cH7428mosGMjnqB0CFOx/H9Y=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 18:18:49 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 18:18:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Topic: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)
Thread-Index: AQHV7MGBM3ssLVWsx0i06hq40xNhXagttc6AgAAK/gCAAAgHsQ==
Date: Wed, 26 Feb 2020 18:18:48 +0000
Message-ID: <CH2PR12MB3912C9C9EF68C013F25FCA90F7EA0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200226153429.2ae6d7aa@canb.auug.org.au>
 <591615ff-f3ae-c759-504b-582452945d07@infradead.org>
 <DM5PR1201MB0090194AFCE8D5361B68463E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>,
 <DM5PR1201MB0090BB36BD24983079217D7E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB0090BB36BD24983079217D7E92EA0@DM5PR1201MB0090.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T18:18:48.723Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 596ab51b-6755-4510-08d6-08d7bae8537e
x-ms-traffictypediagnostic: CH2PR12MB3815:|CH2PR12MB3815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3815637E5D38A9FBA9BAEF2FF7EA0@CH2PR12MB3815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(8676002)(6636002)(52536014)(55016002)(5660300002)(66946007)(9686003)(66446008)(66476007)(64756008)(81166006)(81156014)(76116006)(66556008)(8936002)(71200400001)(33656002)(26005)(4326008)(19627405001)(6506007)(53546011)(478600001)(86362001)(186003)(7696005)(316002)(110136005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3815;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0oyCF+uidzGmQlK0/BVIvHZCIF7lE/lOfPrd22A9/b6b0dOKfpg1jGrRD4xfIy98cOIfsLlXq+ktWDgOXakRFV4bP/B9DmCe5XTlXBN/QBPvwSt2H00a6mL9BiMKQrzUGmd3YAsfxLWjRbFl81PIyCfkq4RJBocm2pFjcq2kuxN1Iy9Rj0RGRDQhkTDz9Ws1FGrsSK0pWddiNmRRzGxW8v6sA/cHSMsXcibJPUBsLZFRoYlXhZqVmviwVrPBADKSPBfCIwAXSFvs+mtgyK/M3wRGmgYJZeEfCtfa8rr6AK6u/K9IytSPGJ/a2O4iPMH1CWYlX7odT2i/3KGk/kyGga+3KWM9rAVcZRM9aDieLdarDIEYviKVG9KT4mteVLg0KlofmBo286S0KWwKZK8GY7nqQZlaQgHiA58/LLSYfbVsul3Mxjd5zwqcu5a1eR0
x-ms-exchange-antispam-messagedata: irX8+ZQui9wVdFKe9PR7fh+mB1LUXw4Lwinq5Los/+MB0bziekJpDKHohXT4BCTfCfNGK8xyk4h0eJLYWpvyNqQWH3mLMsmhMv58HUO+quA4Epr6Fw8HjM3muxwZZ++9WaEUj+hC0lY0xq7lFYc/pg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596ab51b-6755-4510-08d6-08d7bae8537e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 18:18:49.0043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAJ/5dNDAcOwWAy5GzxShR5XTVLDkY56OuZSKZbL5zPqwvUgm/orqyDstYkKPrchfRy4WBCYOH2bjOvWPSssoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
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
Content-Type: multipart/mixed; boundary="===============2057128657=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2057128657==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912C9C9EF68C013F25FCA90F7EA0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912C9C9EF68C013F25FCA90F7EA0CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'll push it out today.  Thanks!

Alex
________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, February 26, 2020 12:49 PM
To: Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher=
@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)

[AMD Official Use Only - Internal Distribution Only]

I pushed the fix to amd-staging-drm-next. How do we get this into linux-nex=
t?

-----Original Message-----
From: Kuehling, Felix
Sent: Wednesday, February 26, 2020 11:11
To: Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander (Alexander.Deucher=
@amd.com) <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)

[AMD Official Use Only - Internal Distribution Only]

[Dropping most, +Alex, +Xinhui]

Looks like this was introduced by Xinhui's change:
commit be8e48e0849943fb53457e2fd83905eaf19cb1f7
Author: xinhui pan <xinhui.pan@amd.com>
Date:   Tue Feb 11 11:28:34 2020 +0800

    drm/amdgpu: Remove kfd eviction fence before release bo

    No need to trigger eviction as the memory mapping will not be used
    anymore.

    All pt/pd bos share same resv, hence the same shared eviction fence.
    Everytime page table is freed, the fence will be signled and that cuase=
s
    kfd unexcepted evictions.

    CC: Christian K=F6nig <christian.koenig@amd.com>
    CC: Felix Kuehling <felix.kuehling@amd.com>
    CC: Alex Deucher <alexander.deucher@amd.com>
    Acked-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: xinhui pan <xinhui.pan@amd.com>

I'm preparing a fix. Will send it out in a second.

Regards,
  Felix

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Randy Du=
nlap
Sent: Wednesday, February 26, 2020 10:03
To: Stephen Rothwell <sfr@canb.auug.org.au>; Linux Next Mailing List <linux=
-next@vger.kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>; Linux Kernel Mailing List =
<linux-kernel@vger.kernel.org>; amd-gfx@lists.freedesktop.org
Subject: Re: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)

On 2/25/20 8:34 PM, Stephen Rothwell wrote:
> Hi all,
>
> Changes since 20200225:
>

on i386:

ld: drivers/gpu/drm/amd/amdgpu/amdgpu_object.o: in function `amdgpu_bo_rele=
ase_notify':
amdgpu_object.c:(.text+0xe07): undefined reference to `amdgpu_amdkfd_remove=
_fence_on_pt_pd_bos'


Full randconfig file is attached.

--
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

--_000_CH2PR12MB3912C9C9EF68C013F25FCA90F7EA0CH2PR12MB3912namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I'll push it out today.&nbsp; Thanks!</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 26, 2020 12:49 PM<br>
<b>To:</b> Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
I pushed the fix to amd-staging-drm-next. How do we get this into linux-nex=
t?<br>
<br>
-----Original Message-----<br>
From: Kuehling, Felix <br>
Sent: Wednesday, February 26, 2020 11:11<br>
To: Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;; Deucher, Alexander (Alexander.D=
eucher@amd.com) &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Subject: RE: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
[Dropping most, &#43;Alex, &#43;Xinhui]<br>
<br>
Looks like this was introduced by Xinhui's change:<br>
commit be8e48e0849943fb53457e2fd83905eaf19cb1f7<br>
Author: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
Date:&nbsp;&nbsp; Tue Feb 11 11:28:34 2020 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdgpu: Remove kfd eviction fence before release bo<=
br>
<br>
&nbsp;&nbsp;&nbsp; No need to trigger eviction as the memory mapping will n=
ot be used<br>
&nbsp;&nbsp;&nbsp; anymore.<br>
<br>
&nbsp;&nbsp;&nbsp; All pt/pd bos share same resv, hence the same shared evi=
ction fence.<br>
&nbsp;&nbsp;&nbsp; Everytime page table is freed, the fence will be signled=
 and that cuases<br>
&nbsp;&nbsp;&nbsp; kfd unexcepted evictions.<br>
<br>
&nbsp;&nbsp;&nbsp; CC: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<b=
r>
&nbsp;&nbsp;&nbsp; CC: Felix Kuehling &lt;felix.kuehling@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; CC: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&nbsp;&nbsp;&nbsp; Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com=
&gt;<br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&g=
t;<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: xinhui pan &lt;xinhui.pan@amd.com&gt;<br>
<br>
I'm preparing a fix. Will send it out in a second.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ra=
ndy Dunlap<br>
Sent: Wednesday, February 26, 2020 10:03<br>
To: Stephen Rothwell &lt;sfr@canb.auug.org.au&gt;; Linux Next Mailing List =
&lt;linux-next@vger.kernel.org&gt;<br>
Cc: dri-devel &lt;dri-devel@lists.freedesktop.org&gt;; Linux Kernel Mailing=
 List &lt;linux-kernel@vger.kernel.org&gt;; amd-gfx@lists.freedesktop.org<b=
r>
Subject: Re: linux-next: Tree for Feb 26 (gpu/drm/amd/amdgpu/)<br>
<br>
On 2/25/20 8:34 PM, Stephen Rothwell wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; Changes since 20200225:<br>
&gt; <br>
<br>
on i386:<br>
<br>
ld: drivers/gpu/drm/amd/amdgpu/amdgpu_object.o: in function `amdgpu_bo_rele=
ase_notify':<br>
amdgpu_object.c:(.text&#43;0xe07): undefined reference to `amdgpu_amdkfd_re=
move_fence_on_pt_pd_bos'<br>
<br>
<br>
Full randconfig file is attached.<br>
<br>
-- <br>
~Randy<br>
Reported-by: Randy Dunlap &lt;rdunlap@infradead.org&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH2PR12MB3912C9C9EF68C013F25FCA90F7EA0CH2PR12MB3912namp_--

--===============2057128657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2057128657==--
