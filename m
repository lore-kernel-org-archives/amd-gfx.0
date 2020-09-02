Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33313C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 23:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F065320758
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 23:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KzauM/vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F065320758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819BE6E0FE;
	Wed,  2 Sep 2020 23:43:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F403C6E0FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 23:43:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H55IzscCwX1GMe0PUwLwKApf0LNDA7IkcZhobTa5nKEtDwhu7Hc+6eDWD/Jd39cdrHu4Re+noQI99D3IZbdSWQ/MJV4MPQjy7wOj6Acm6KBNlpzL3d82014aUnuc6Md4ftPHRD5BrhVSD7ZgkOvitW2qjqyWfXHXDlsyfJai6xnYZl4znXd5wKMR4uBf198/HdZXL3a0l7kaThGdAz7oQt1HPS80cZk+P/6QrSWopdTNHkRjvPVUNPkJlwAYzdv1Py7ZYWcY8hnU8EMh9lL++5scwHFzSy9RQPGEN/Jnh4w3ZVfl43hREcOhGs+wSheZohHEyeVimHkJy3oLGMKVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVKMlBGGqVSkJgpQnUXWFrZkeh+OjUnigXEMQLOK6q4=;
 b=Ehd3MB1jn+zHrYEEos597TEdVRWSNyB6szi27B73gMtFMhYJExdPXmzNFSPm04UU6nFeaGOUiI77F3zH6G3Ayou+SnPDRtwz3yFlaJn7bIJ9tvmzNsSQicFlqcv8myR2iKsfLMbX/XkWeqaFey1JTj7CDVaI1RWf15J2C4BOMeE3VdNuuLkcDlPyc6OOo4YgrzpgsEkAyuLgdoB4//C3uVaYiGlT/3AQH1I614QGNRPqWAt4nTUogWo3k6vhTUvD/wT/sDr5h2DtZxC2Lo3L/RbxxsVlwBFGbU2Pu5OMUxmMdBmBds0yV8YK7MFwgWeHVXqctKv3HAn4qCQN96TqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVKMlBGGqVSkJgpQnUXWFrZkeh+OjUnigXEMQLOK6q4=;
 b=KzauM/vnjxpiaZNDX3VTZNjHDyo/y+7sC+SjHKCvRc0hdAtJSrr7G3pP5KbnpLRJZT0hwUxSS7ZayK5UjKbdTkj+hdgTEdhVeXxUdvRkfAfSTXay7p/yJsziisF+/2MSN9fhprtx3xWFuRPKSCyrLr1ncZGv5kakNbnGgnV+wiI=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 23:43:41 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 23:43:41 +0000
From: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Thread-Topic: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12
Thread-Index: AQHWgVjYeMjo2h7H3UKATg9p5wNSEKlV34WAgAAjJjM=
Date: Wed, 2 Sep 2020 23:43:41 +0000
Message-ID: <DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>,
 <20200902213625.GA269978@bjorn-Precision-5520>
In-Reply-To: <20200902213625.GA269978@bjorn-Precision-5520>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [199.119.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6afa3e3-68cd-41e6-72e1-08d84f9a05eb
x-ms-traffictypediagnostic: DM5PR12MB1753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17534902C4DA5B44F2154A23EA2F0@DM5PR12MB1753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wz3LpykFwIkHl9DHC8O8Rj7eIwXtWlfutbPYdgCgleefilWts54lfSao3UPOyhjcmOB4KCFIEHB3x3NN6a1BELmFwt6f78GMCoMwomPI0df1sWESB1dC8sFEFA5fXJ1K3Mi+3whnVqNht6hXLSzZzT1r9wUqpdvJibh+BOIU4bm8EZsD2s99OGYRWcOaM7+U0MoIFP02bPsEUas1vn4UmYgqHDoWr2xHTOgJWfAMf5jZD0mT9sstMjFMiRstd9bbinPnBjxaVLzvBGyqVasQBWAYZep06mM99bPlzCzDkg2z5z0pnUOTP7o8uBJPwoxINMo2DJxHyTYPsbYd0edaBtDLPcQ/v7pjZcm1ZiqwwyIpa7S0aSboPylNk9mNXF6XlhQGQ9ZnBhlEj9fg/0un3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39850400004)(66946007)(64756008)(4326008)(66446008)(91956017)(6916009)(76116006)(166002)(66556008)(186003)(71200400001)(8676002)(26005)(83380400001)(52536014)(6506007)(5660300002)(53546011)(966005)(9686003)(66476007)(45080400002)(86362001)(316002)(8936002)(33656002)(55016002)(478600001)(54906003)(7696005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: b9zwgAVGls6lxnhF5CAtHImYsyWYSdiwXP3yfmQ0emecAuRj9JlJUDckm385tYNu/Km6ENnlt9J+v1dlCQFQdHGBpqrBRlRDzQMvu7Y6DAcyHQIuqtVdzeKO76mvZ4bgLbiAUZPBJQcgFmHszlyoxM2Rf0hmJ+oUjwm3HI5aELis+puHkT4GXV7S73sLdKpGrX7/d/2KLKMqDrvuKzZig132xZqcdcV4juGQ79tPASOy3FKdj5y+mM7Mtj3dj9cmk1dVmSpdzCe06TBUvsHK1cJqTVGDG9gw7DojWZEZKfkcUQfCwyyOqAeeZ9EQkFes8xfskArOsi/4/mUn345AwjU+GyrYPE66SUlYWvk+eoLDz09SVBVfm+YKjhuDi0yUv3MF4kyNJrRuajdi3UQ/yW1RM8ORiyWp8S1dkMQbDcfnoMCZCA+575JAkjECT+sPctnoyunIZ9MWouJrpU91kEzmjzluGznX9VE9v7jVkoHEh2ycPAfgajfsvxDDk5blw1sYZz4NLAweKWwyHODIhWOIZTuEc+Omq8+n8uDYGWLQR1BO7JD+CXTwhK74nR3cwqEsPRvOOqjl6z9yvLGFDHO5kEdhsMwiam7btewilW/p8nD5ggrq8cp3CBtV+cklPDgt0ASX3lZqsVWhqINH8Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6afa3e3-68cd-41e6-72e1-08d84f9a05eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 23:43:41.4027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLkmRV2ujxyoVq7LJ2eXWhmedF83mKsIp389HtiHKGbxCb4Wafd/0b7kxt87DhhSl1WgHMI5RBJUCh6JOZiAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>
Content-Type: multipart/mixed; boundary="===============1317940640=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1317940640==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0DM6PR12MB4340namp_"

--_000_DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0DM6PR12MB4340namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It's based on v5.9-rc2 but won't apply cleanly since there is a significant=
 amount of amd-staging-drm-next patches which this was applied on top of.

Andrey
________________________________
From: Bjorn Helgaas <helgaas@kernel.org>
Sent: 02 September 2020 17:36
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; sathyana=
rayanan.kuppuswamy@linux.intel.com <sathyanarayanan.kuppuswamy@linux.intel.=
com>; linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; Deucher, Alexa=
nder <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; Li, Den=
nis <Dennis.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Tuik=
ov, Luben <Luben.Tuikov@amd.com>; bhelgaas@google.com <bhelgaas@google.com>
Subject: Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12

On Wed, Sep 02, 2020 at 02:42:02PM -0400, Andrey Grodzovsky wrote:
> Many PCI bus controllers are able to detect a variety of hardware PCI err=
ors on the bus,
> such as parity errors on the data and address buses,  A typical action ta=
ken is to disconnect
> the affected device, halting all I/O to it. Typically, a reconnection mec=
hanism is also offered,
> so that the affected PCI device(s) are reset and put back into working co=
ndition.
> In our case the reconnection mechanism is facilitated by kernel Downstrea=
m Port Containment (DPC)
> driver which will intercept the PCIe error, remove (isolate) the faulting=
 device after which it
> will call into PCIe recovery code of the PCI core.
> This code will call hooks which are implemented in this patchset where th=
e error is
> first reported at which point we block the GPU scheduler, next DPC resets=
 the
> PCI link which generates HW interrupt which is intercepted by SMU/PSP who
> start executing mode1 reset of the ASIC, next step is slot reset hook is =
called
> at which point we wait for ASIC reset to complete, restore PCI config spa=
ce and run
> HW suspend/resume sequence to resinit the ASIC.
> Last hook called is resume normal operation at which point we will restar=
t the GPU scheduler.
>
> More info on PCIe error handling and DPC are here:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.k=
ernel.org%2Fdoc%2Fhtml%2Flatest%2FPCI%2Fpci-error-recovery.html&amp;data=3D=
02%7C01%7Candrey.grodzovsky%40amd.com%7Cc1ab3b293aa543a591a808d84f884058%7C=
3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346793904985104&amp;sdata=3DF=
gfyOmKy7iVq5N6Z7h1c9rrkJReSzOlI%2BbykOE0rfac%3D&amp;reserved=3D0
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
work.kernel.org%2Fpatch%2F8945681%2F&amp;data=3D02%7C01%7Candrey.grodzovsky=
%40amd.com%7Cc1ab3b293aa543a591a808d84f884058%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637346793904985104&amp;sdata=3DrSXEB8NoAD9%2BRfRddEvOGfwBJJ=
80KBnLgI%2B%2BPGsFdOc%3D&amp;reserved=3D0
>
> v4:Rebase to 5.9 kernel and revert PCI error recovery core commit which b=
reaks the feature.

What does this apply to?  I tried

  - v5.9-rc1 (9123e3a74ec7 ("Linux 5.9-rc1")),
  - v5.9-rc2 (d012a7190fc1 ("Linux 5.9-rc2")),
  - v5.9-rc3 (f75aef392f86 ("Linux 5.9-rc3")),
  - drm-next (3393649977f9 ("Merge tag 'drm-intel-next-2020-08-24-1' of git=
://anongit.freedesktop.org/drm/drm-intel into drm-next")),
  - linux-next (4442749a2031 ("Add linux-next specific files for 20200902")=
)

but it doesn't apply cleanly to any.

> Andrey Grodzovsky (8):
>   drm/amdgpu: Avoid accessing HW when suspending SW state
>   drm/amdgpu: Block all job scheduling activity during DPC recovery
>   drm/amdgpu: Fix SMU error failure
>   drm/amdgpu: Fix consecutive DPC recovery failures.
>   drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.
>   drm/amdgpu: Disable DPC for XGMI for now.
>   drm/amdgpu: Minor checkpatch fix
>   Revert "PCI/ERR: Update error status after reset_link()"
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 247 +++++++++++++++++++++--=
------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  18 ++-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |   4 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |   4 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |   3 +
>  drivers/pci/pcie/err.c                     |   3 +-
>  10 files changed, 222 insertions(+), 79 deletions(-)
>
> --
> 2.7.4
>

--_000_DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0DM6PR12MB4340namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div>It's based on&nbsp;<span style=3D"color: rgb(33, 33, 33); font-family:=
 &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial,=
 sans-serif; font-size: 14.6667px; font-style: normal; font-variant-ligatur=
es: normal; font-variant-caps: normal; font-weight: 400;">v5.9-rc2
 but won't apply cleanly since there is a significant amount of amd-staging=
-drm-next patches which this was applied on top of.</span></div>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-va=
riant-caps: normal; font-weight: 400;"><br>
</span></div>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-va=
riant-caps: normal; font-weight: 400;">Andrey</span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bjorn Helgaas &lt;hel=
gaas@kernel.org&gt;<br>
<b>Sent:</b> 02 September 2020 17:36<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; sathyanarayanan.kuppuswamy@linux.intel.com &lt;sathyanarayanan.kuppusw=
amy@linux.intel.com&gt;; linux-pci@vger.kernel.org &lt;linux-pci@vger.kerne=
l.org&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Li, Dennis &lt;Dennis.Li@amd.com&g=
t;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Tuikov, Luben &lt;L=
uben.Tuikov@amd.com&gt;; bhelgaas@google.com &lt;bhelgaas@google.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH v4 0/8] Implement PCI Error Recovery on Navi12</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Sep 02, 2020 at 02:42:02PM -0400, Andrey G=
rodzovsky wrote:<br>
&gt; Many PCI bus controllers are able to detect a variety of hardware PCI =
errors on the bus,
<br>
&gt; such as parity errors on the data and address buses,&nbsp; A typical a=
ction taken is to disconnect
<br>
&gt; the affected device, halting all I/O to it. Typically, a reconnection =
mechanism is also offered,
<br>
&gt; so that the affected PCI device(s) are reset and put back into working=
 condition.
<br>
&gt; In our case the reconnection mechanism is facilitated by kernel Downst=
ream Port Containment (DPC)
<br>
&gt; driver which will intercept the PCIe error, remove (isolate) the fault=
ing device after which it
<br>
&gt; will call into PCIe recovery code of the PCI core. <br>
&gt; This code will call hooks which are implemented in this patchset where=
 the error is
<br>
&gt; first reported at which point we block the GPU scheduler, next DPC res=
ets the <br>
&gt; PCI link which generates HW interrupt which is intercepted by SMU/PSP =
who <br>
&gt; start executing mode1 reset of the ASIC, next step is slot reset hook =
is called
<br>
&gt; at which point we wait for ASIC reset to complete, restore PCI config =
space and run
<br>
&gt; HW suspend/resume sequence to resinit the ASIC. <br>
&gt; Last hook called is resume normal operation at which point we will res=
tart the GPU scheduler.<br>
&gt; <br>
&gt; More info on PCIe error handling and DPC are here:<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2FPCI%2Fpci-error-recovery.ht=
ml&amp;amp;data=3D02%7C01%7Candrey.grodzovsky%40amd.com%7Cc1ab3b293aa543a59=
1a808d84f884058%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734679390498=
5104&amp;amp;sdata=3DFgfyOmKy7iVq5N6Z7h1c9rrkJReSzOlI%2BbykOE0rfac%3D&amp;a=
mp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.ker=
nel.org%2Fdoc%2Fhtml%2Flatest%2FPCI%2Fpci-error-recovery.html&amp;amp;data=
=3D02%7C01%7Candrey.grodzovsky%40amd.com%7Cc1ab3b293aa543a591a808d84f884058=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346793904985104&amp;amp;sd=
ata=3DFgfyOmKy7iVq5N6Z7h1c9rrkJReSzOlI%2BbykOE0rfac%3D&amp;amp;reserved=3D0=
</a><br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F8945681%2F&amp;amp;data=3D02%7C01%7=
Candrey.grodzovsky%40amd.com%7Cc1ab3b293aa543a591a808d84f884058%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637346793904985104&amp;amp;sdata=3DrSXEB8=
NoAD9%2BRfRddEvOGfwBJJ80KBnLgI%2B%2BPGsFdOc%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatchwo=
rk.kernel.org%2Fpatch%2F8945681%2F&amp;amp;data=3D02%7C01%7Candrey.grodzovs=
ky%40amd.com%7Cc1ab3b293aa543a591a808d84f884058%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637346793904985104&amp;amp;sdata=3DrSXEB8NoAD9%2BRfRddEvO=
GfwBJJ80KBnLgI%2B%2BPGsFdOc%3D&amp;amp;reserved=3D0</a><br>
&gt; <br>
&gt; v4:Rebase to 5.9 kernel and revert PCI error recovery core commit whic=
h breaks the feature.<br>
<br>
What does this apply to?&nbsp; I tried <br>
<br>
&nbsp; - v5.9-rc1 (9123e3a74ec7 (&quot;Linux 5.9-rc1&quot;)),<br>
&nbsp; - v5.9-rc2 (d012a7190fc1 (&quot;Linux 5.9-rc2&quot;)),<br>
&nbsp; - v5.9-rc3 (f75aef392f86 (&quot;Linux 5.9-rc3&quot;)),<br>
&nbsp; - drm-next (3393649977f9 (&quot;Merge tag 'drm-intel-next-2020-08-24=
-1' of git://anongit.freedesktop.org/drm/drm-intel into drm-next&quot;)),<b=
r>
&nbsp; - linux-next (4442749a2031 (&quot;Add linux-next specific files for =
20200902&quot;))<br>
<br>
but it doesn't apply cleanly to any.<br>
<br>
&gt; Andrey Grodzovsky (8):<br>
&gt;&nbsp;&nbsp; drm/amdgpu: Avoid accessing HW when suspending SW state<br=
>
&gt;&nbsp;&nbsp; drm/amdgpu: Block all job scheduling activity during DPC r=
ecovery<br>
&gt;&nbsp;&nbsp; drm/amdgpu: Fix SMU error failure<br>
&gt;&nbsp;&nbsp; drm/amdgpu: Fix consecutive DPC recovery failures.<br>
&gt;&nbsp;&nbsp; drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing code.<br=
>
&gt;&nbsp;&nbsp; drm/amdgpu: Disable DPC for XGMI for now.<br>
&gt;&nbsp;&nbsp; drm/amdgpu: Minor checkpatch fix<br>
&gt;&nbsp;&nbsp; Revert &quot;PCI/ERR: Update error status after reset_link=
()&quot;<br>
&gt; <br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 247 +++++++++++++++=
++++++--------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 6 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; |&nbsp=
;&nbsp; 6 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 18 ++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; drivers/pci/pcie/err.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp;&nbsp; 3 +-<br>
&gt;&nbsp; 10 files changed, 222 insertions(+), 79 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB4340FC71C17B28E1601EBCDDEA2F0DM6PR12MB4340namp_--

--===============1317940640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1317940640==--
