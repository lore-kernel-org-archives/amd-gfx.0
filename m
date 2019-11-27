Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4804AC432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 14:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B51420678
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B51420678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F3F6E2E4;
	Wed, 27 Nov 2019 14:55:27 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790049.outbound.protection.outlook.com [40.107.79.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FAC6E2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGCjDGMozEYIkgajfFLZ0/BfoiwKSNxvrW6CTmOmd1PQ8wub4oRCeuU4zMaxZrNyNc+7PuHXkXEPgd9cBCHhzt3M0WsZmjW3hJ4Dx7D1ohnx8Kd/Kq0EF3mEc5FtUkm8i94qAwUyFWGisEvHI3gPfdAwqu5fSZXRCiut3ALqpXhTZxtLrF3lsGFXshwp4yJL+yPAPsYGTYKd2qHocwBTw0MSeQ1kdN6LCFPCbqVYb+7xVABbOYOXX3XWYphEgn0tFIUAl58b40vFk/bTIPuQs8e8po41cUsdAqij3If41tn0L0d9fIvZwcPR+tDmxFRvoW3oRXOGBJR/zYVwQxP70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxZqLJWfxtysKkjWqNiV4SYCnjdQg490Nct7f0JdDxQ=;
 b=b/YNO8kWmrOWcVMJ8zhw5p1ByW6qUAd5yhamihkScdClOgkmncs/U4Lb0+dEXkS299NoH6LC2xKpCuzws3uSHGMIhunI4xFMlPexEfsmNi/u6JuUInQ0op7jnIY0DeLghhGEXrASWzd+bD0JBFnz4nVJApbdvTf0NHHY9W/APIFNafEG9Zsklzjr55QBhoV5J9TI+zeE8cUySUkE4z7Uix5yA03fRxq1kTf4IRc9+13hUAPosPjmVaQpIvl7vI8tg+Nia79wNMJzMWvUsxy9pQNColWshFs/vRKgEShF4qG8BEKoMeVt46g7JklMIj04bVYIDi1pp1tNWLBD7ZQ0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.103.10) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 27 Nov 2019 14:55:24 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::ad84:4c30:78ae:4f30]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::ad84:4c30:78ae:4f30%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 14:55:24 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Deadlock on PTEs update for HMM
Thread-Topic: Deadlock on PTEs update for HMM
Thread-Index: AdWlMnOsNrqIwkHRSMuzwywKzOgYQQ==
Date: Wed, 27 Nov 2019 14:55:24 +0000
Message-ID:
 <SN6PR12MB26216A095D9839500242F489FD440@SN6PR12MB2621.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.49.240.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a97c586-ade6-45b9-93db-08d77349d51f
x-ms-traffictypediagnostic: SN6PR12MB2814:|SN6PR12MB2814:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2814A23F92B9015632D98F46FD440@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(51874003)(189003)(199004)(6436002)(25786009)(6306002)(9686003)(478600001)(14444005)(256004)(5660300002)(186003)(14454004)(55016002)(236005)(54896002)(7696005)(4326008)(74316002)(102836004)(6636002)(316002)(110136005)(6506007)(26005)(99286004)(52536014)(7736002)(66066001)(2906002)(15650500001)(2420400007)(71200400001)(9326002)(8936002)(8676002)(81156014)(81166006)(33656002)(7110500001)(86362001)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(6116002)(3846002)(71190400001)(790700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pbcZzGRbCciCVr5or18/D0sOltSIJLZn9DYKdKKVKEIpTmg28xKKqUCq+BZwz6+vgvdTWGw6OmIvDia/lwNswgPX/YqHo7QJlHwW0j17PJrSkZkWuD8Gt8EccGUYse4jvBo1pL0ZOBmVnznWphg3GnsxjrmSW7KdFqTqN5w2virx+KdAM6LI9L23Djxh2KfzpUq2vs5u1G7Lg2WKe7xy+CdYUQ9h/9phuQeZ3PJF9uWiWRycCd3OzVHyvV//6pV16VUQAVvgh6tg++/RnLx6CePjst71GONolUPhesY02LOLk5vRHmQi119s9XkPH5d2L9F1LSl1geujEkAGlyEBSXlqyOxVG/hQKaQBDJ6O4X1raPC0NKZVNSuY8qfJ/E2W3Ip3NkfI9P4Ws0pwy0r6HCFYP/Xz/t3ea1OWDveVuUuWqTDTfNI5z7bY2FfEoTkh
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a97c586-ade6-45b9-93db-08d77349d51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 14:55:24.1238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEFZxG0H5zjyyzpfXNjnJhgjzikFzCiKxMrGvsMcAmPDykq4XPyDytuTm9IWytmkoQsO3XC76hifbVwXpU5Apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxZqLJWfxtysKkjWqNiV4SYCnjdQg490Nct7f0JdDxQ=;
 b=XRUKtGXLR7f1YRMv8Uvw/QiLpyjPMI2zMmM3AAYBs4kT3cxeznYQG9F6bI2XDgnqoBU+QrXCPin14vt0DA21qzoKKIJsZFyLR6JmeTcTS9iHgQYGkTQNT6RoFvla2XBmUV1kE1XhHzMJ+HKKT0B6fTidrRP2K+n+/Ypv1k51uLw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Content-Type: multipart/mixed; boundary="===============0727936044=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127145524.incToG12Kzh38ZnKvF4KbeawoFt4zaSi4l43mM9awgw@z>

--===============0727936044==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB26216A095D9839500242F489FD440SN6PR12MB2621namp_"

--_000_SN6PR12MB26216A095D9839500242F489FD440SN6PR12MB2621namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
As you know, we're working on the HMM enablement. Im working on the dGPU pa=
ge table entries invalidation on the userptr mapping case. Currently, the M=
MU notifiers handle stops all user mode queues, schedule a delayed worker t=
o re-validate userptr mappings and restart the queues.
Part of the HMM functionality, we need to invalidate the page table entries=
 instead of stopping the queues. At the same time we need to move the reval=
idation of the userptr mappings into the page fault handler.
We're seeing a deadlock warning after we try to invalidate the PTEs inside =
the MMU notifier handler. More specific, when we try to update the BOs to i=
nvalidate PTEs using amdgpu_vm_bo_update. This uses kmalloc on the amdgpu_j=
ob_alloc which seems to be causing this problem.
Based on @Kuehling, Felix<mailto:Felix.Kuehling@amd.com> comments, kmalloc =
without any special flags can cause memory reclaim. Doing that inside an MM=
U notifier is problematic, because an MMU notifier may be called inside a m=
emory-reclaim operation itself. That would result in recursion. Also, recla=
im shouldn't be done while holding a lock that can be taken in an MMU notif=
ier for the same reason. If you cause a reclaim while holding that lock, th=
en an MMU notifier called by the reclaim can deadlock trying to take the sa=
me lock.
Please let us know if you have any advice to enable this the right way

Thanks in advanced,
Alejandro


--_000_SN6PR12MB26216A095D9839500242F489FD440SN6PR12MB2621namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:106%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoNormal">As you know, we&#8217;re working on the HMM enableme=
nt. Im working on the dGPU page table entries invalidation on the userptr m=
apping case. Currently, the MMU notifiers handle stops all user mode queues=
, schedule a delayed worker to re-validate
 userptr mappings and restart the queues. <o:p></o:p></p>
<p class=3D"MsoNormal">Part of the HMM functionality, we need to invalidate=
 the page table entries instead of stopping the queues. At the same time we=
 need to move the revalidation of the userptr mappings into the page fault =
handler.<o:p></o:p></p>
<p class=3D"MsoNormal">We&#8217;re seeing a deadlock warning after we try t=
o invalidate the PTEs inside the MMU notifier handler. More specific, when =
we try to update the BOs to invalidate PTEs using amdgpu_vm_bo_update. This=
 uses kmalloc on the amdgpu_job_alloc which
 seems to be causing this problem.<o:p></o:p></p>
<p class=3D"MsoNormal">Based on <a id=3D"OWAAMBC6F9A316D814AE993661FC111776=
926" href=3D"mailto:Felix.Kuehling@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Kuehling, Felix</span></a> comments,
<span style=3D"font-size:10.5pt;line-height:106%;font-family:&quot;Segoe UI=
&quot;,sans-serif">
kmalloc without any special flags can cause memory reclaim. Doing that insi=
de an MMU notifier is problematic, because an MMU notifier may be called in=
side a memory-reclaim operation itself. That would result in recursion. Als=
o, reclaim shouldn't be done while
 holding a lock that can be taken in an MMU notifier for the same reason. I=
f you cause a reclaim while holding that lock, then an&nbsp;MMU notifier ca=
lled by the reclaim can&nbsp;deadlock trying to take the same lock.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal">Please let us know if you have any advice to enable =
this the right way<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks in advanced,<o:p></o:p></p>
<p class=3D"MsoNormal">Alejandro<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN6PR12MB26216A095D9839500242F489FD440SN6PR12MB2621namp_--

--===============0727936044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0727936044==--
