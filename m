Return-Path: <SRS0=njeu=7F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10310C433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 03:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17F020727
	for <amd-gfx@archiver.kernel.org>; Sat, 23 May 2020 03:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cfbuR0K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17F020727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5201A6E177;
	Sat, 23 May 2020 03:15:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0A556E177
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 May 2020 03:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrAEKx+HddJ3aUUqWi0/lcBC+fAXXckYmnFp8hfyZpv4kXJpJO3mkn/WrDH+XvCDrG/FRopdyHOT7Rlr1YxlNYkaaPTz61HOedh2hnwBTfH93k7Pae2pFmvUOx768C/QHg6wHz8kDc0aOmdSq9cjRqn5b3+phqlayhBJQfzfPxq8zOzMRkZX90eKH+vXCUiBc55D36z4L7soSq3dvAnxnbaXd1Ec/5CbtB4UxySGpzeEVD2sPGXGkyj4XZOqZUO9voYqOsoO+IWOk9qhCJr3H1BRFT86KHRpJIZGG6Thgr0n9DFtsHkmvVju63AzEvm3+PRWybN7ObtrMOawlf2GyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBcVWndxgEJY39ft/FsWghlv8mRTZY7H4jvRbIxeaB0=;
 b=HqQHWf3Mj5yn80jJ1c5n0+GLZPcOHUbedbi/JRJrpdgSsTCTRa+jZ8ifGsGSG3BUL8U+3DKwjrcye92Z61H8/M10Yw2QOb+VJx1NvsLjbne4EKtWMwBz8rJKAnsodssEmtYAvOgAFvgQb2/CjzKkQIPIIX7LleDPOiruJJPBQOUh5jaEELqrMw4b+amm5hSF2jzRJ2xbo0azw3vUpCUGd0MsBhGq1olKNATX1vnfKAqucS6E/QnetIHG0gMWObloxta1JEfwHj3/VfQa0cWQ/sjKQ/AmUen6uudE74UB8pwn58OwZ/cH2iyVXxAQnkUQ3M2G63BeoilrlHei5l1UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBcVWndxgEJY39ft/FsWghlv8mRTZY7H4jvRbIxeaB0=;
 b=cfbuR0K+8muSYamRmR07NrJxy4JG1qLdVCNIf/jiCsix8JvGT/NX/6p3AxZKu9KwNiLhgV2CkKZGIJALwkbZxHv59owa5xA9lrzd04bFREnGIzodRAiTi1TnT+FKe/44iyY5d1CWJ/N9VOah7tgGzBKWo5RKHvI0BtSLs2417ME=
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3100.namprd12.prod.outlook.com (2603:10b6:5:11b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sat, 23 May
 2020 03:14:59 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%4]) with mapi id 15.20.3021.026; Sat, 23 May 2020
 03:14:59 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Fenghua Yu <fenghua.yu@intel.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: drm/amdkfd: Change pasid's type to unsigned int
Thread-Topic: drm/amdkfd: Change pasid's type to unsigned int
Thread-Index: AQHWMG8K4Olopc1qzUiheduaQ5p34Ki0gLgAgAAcT4CAAGKusg==
Date: Sat, 23 May 2020 03:14:59 +0000
Message-ID: <DM6PR12MB448252364F96A4419AF2B3BFF0B50@DM6PR12MB4482.namprd12.prod.outlook.com>
References: <20200522192554.GA39766@romley-ivt3.sc.intel.com>
 <d6318005-4860-b82f-e2fc-21fa9f1c1683@amd.com>,
 <20200522212125.GB39766@romley-ivt3.sc.intel.com>
In-Reply-To: <20200522212125.GB39766@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-23T03:14:58.741Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25a1256c-ed85-4511-1e22-08d7fec77a05
x-ms-traffictypediagnostic: DM6PR12MB3100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3100A1EB7A65EC91A6E86D3FF0B50@DM6PR12MB3100.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0412A98A59
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7cBTZKT4QWW5zIcodt7hHWre89DqQ6bfc456WAPgUk0s2KXF7TIoUXvlqqylXeup3RLFaCD/Ul7pvob5dUr6Hg3sDFZ5NY3QD4CXxupEOk2p6NdE/I9FjA7yDnQDoP7U1+j6OdhdDWhGBp23TlxyMbM3B4cxRmOVw/rhFvBQwgln33IKElwyvB96eUwV/3LiXKG7lBJk+3d4XfVOuLdl9EqZ2HJEK/DtXDVkRkSH02fPD3xkv4/s/QTZpE62jfFlp8Ya6YtYeGEw4vceydkq0YfHn36uRFgIEJkYeHuICKShMFF/iwH75Dj4pJcbnCbz2cDzJHWvklpjXi7+n2Y8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(6636002)(33656002)(26005)(186003)(4326008)(478600001)(7696005)(66946007)(9686003)(5660300002)(52536014)(19627405001)(316002)(110136005)(8936002)(71200400001)(8676002)(76116006)(66476007)(91956017)(86362001)(55016002)(64756008)(53546011)(66446008)(6506007)(2906002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YyWM3Ccpzt4GKfGYIa9TGdIGoZlJaWZRBeuBKJMU4RE3eAO7rR32JcOe1aHlERS7V2R4HwGW+4XEhO08oDmTXYGiVu89FbpVTPAdYwzzKW1wosm3Q3dqQd41sNlOnF4gfYPQMQtNfCNLOwqoTbJTFpDHbvvzdNj8rbcOIdnYTEVeMla5os59lKq+90r4n5zPCejuaVYNXdRubT8tpke8Mb5PWVNvn16Yiy2L1KV9zig7dqLKMoIt2gGbkV8bVK0lPoPFXURyVv7E7auWElaFrUnxeOrYwxC2Nekrf/XHV0zG8pHjLokHinRZ0Zod+8g+Jeh6mSrvZELYRfjEGlDPhqECwRNWBSM6tFuOR7aYGhBTbqCAqhEMMbZWrLZvrw2uOfRt0PPmRuLVNV/Ok8JQHs784p/tPfuJXbbcyXJiBmwNe4uNEqqx9DHLEZXAWvjZcH8FodeRVQclEMm9oRHmsoye0FkIskUovFthwO/hHTDpVUa1K7Q35AFad6uArTHp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a1256c-ed85-4511-1e22-08d7fec77a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2020 03:14:59.3983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UdSpcba3TAT5sib928OKzqYUIBlckx5JxtG1uE+CpM3P5Zu42+tks3yO5IoY2PF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3100
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
Content-Type: multipart/mixed; boundary="===============1082274882=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1082274882==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB448252364F96A4419AF2B3BFF0B50DM6PR12MB4482namp_"

--_000_DM6PR12MB448252364F96A4419AF2B3BFF0B50DM6PR12MB4482namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Fenghua,

I am okay with the idea.

Regards,
Yong
________________________________
From: Fenghua Yu <fenghua.yu@intel.com>
Sent: Friday, May 22, 2020 5:21 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: drm/amdkfd: Change pasid's type to unsigned int

Hi, Felix,

On Fri, May 22, 2020 at 03:40:06PM -0400, Felix Kuehling wrote:
> Hi Fenghua,
>
> The PASID width in KFD is currently limited to 16 bits. I believe this
> reflects what our hardware can handle. KFD will never allocate a PASID
> bigger than 16 bits. That said, I'm OK with changing this field in the
> kfd_process structure to unsigned int. Generally, I find uint16_t in
> structures not very useful except in tightly packed structures such as
> packet formats or ioctl arguments.

Thank you very much for your insight!

I'm writing the patch set to define pasid as "unsigned int" consistently
in iommu. I'll put the amdkfd changes (only a few changes including this
pasid change in struct kfd_processin) one patch and send it to you for
review.

-Fenghua

--_000_DM6PR12MB448252364F96A4419AF2B3BFF0B50DM6PR12MB4482namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Hi Fenghua,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I am okay with the idea.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Fenghua Yu &lt;fenghu=
a.yu@intel.com&gt;<br>
<b>Sent:</b> Friday, May 22, 2020 5:21 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: drm/amdkfd: Change pasid's type to unsigned int</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi, Felix,<br>
<br>
On Fri, May 22, 2020 at 03:40:06PM -0400, Felix Kuehling wrote:<br>
&gt; Hi Fenghua,<br>
&gt; <br>
&gt; The PASID width in KFD is currently limited to 16 bits. I believe this=
<br>
&gt; reflects what our hardware can handle. KFD will never allocate a PASID=
<br>
&gt; bigger than 16 bits. That said, I'm OK with changing this field in the=
<br>
&gt; kfd_process structure to unsigned int. Generally, I find uint16_t in<b=
r>
&gt; structures not very useful except in tightly packed structures such as=
<br>
&gt; packet formats or ioctl arguments.<br>
<br>
Thank you very much for your insight!<br>
<br>
I'm writing the patch set to define pasid as &quot;unsigned int&quot; consi=
stently<br>
in iommu. I'll put the amdkfd changes (only a few changes including this<br=
>
pasid change in struct kfd_processin) one patch and send it to you for<br>
review.<br>
<br>
-Fenghua<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB448252364F96A4419AF2B3BFF0B50DM6PR12MB4482namp_--

--===============1082274882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1082274882==--
