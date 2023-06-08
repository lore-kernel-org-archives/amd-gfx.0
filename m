Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF6CC7EE25
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jun 2023 15:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBB710E5DA;
	Thu,  8 Jun 2023 15:46:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C430910E025
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jun 2023 15:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy/mt5riGrpkNXA35xRHpXU7hrbGFOYW1fvsN+XvxdMbt4HuQJnCDDH20OcFskslMSHmcVwGLJp4Cwys3hcLXQxvY68RSA5GjluakprJKnxOkjmDIGDXSytsw7fXN27NindSXcrP73fyF17GsTl6EYGYZ21eY7Tbpo5iR0bzFTIgaXkZ2fYLxIOUxsvgXSqXs96G05spQ3yn+ftTskOympL8QLe0cSJ4H3Tql2WyFniuGE1Umv6t4S3BTe394EAnrW3JLbEwfWD1AVCsrH3KFzG42TtpaxHqFvmHbZG7dQMVq206FADu7AnxBVWYwJU7CFYlMjBvXU4dlBDm9i0LMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3W05gHaIpEnk07YAZXNvGMTGq2Fe5km7T0ljQlCXmo=;
 b=eEsXbo7hWugIKeU4k0AHTL6xwqWFoHhQhnVRHDszVuvsEIEL1fy4pkocCJo7j2prt3yb/VdRPPQz/sJ38CXmYTOMMrnpqKOkNFfM6foGD/fzMoaPv3/Eu7gIIxQqGLYgQ8+USAtDlE2SaHjtrVCo4M/26BjeSIILdf0honmVOqxaJ5jCdRhVhND7Qgg2d95iOxWT3o5D//0Ey+3x/gAzH2Y0oHKEMME4EtzxP4bAISz207lUSZfgECktHI6yalNsZOG9YuF3kox/JxhALFZitClr1gfO4fO2wqng1cZP8IRjQi6IkSO9jQfH/hpFWvK1LCnJRmHNtoZTVU3Q+Qwxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3W05gHaIpEnk07YAZXNvGMTGq2Fe5km7T0ljQlCXmo=;
 b=aFLX2E2593FBacM87m0dVq5KmP3K0dO8sR4knMMBgyGHP0wuGsKQ2NKIFsAidNzOFlZf2RYRItEM0s2k8SPBMTlgkJCc18/5CGx8qIQptaQ+FC9SNh+kvGNLHNV1QLV07eXRr7AJGa2pZLBC5qb+hXouI/9PwQZC+UeLBE1dauI=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 15:46:18 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%4]) with mapi id 15.20.6455.039; Thu, 8 Jun 2023
 15:46:17 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1
Thread-Topic: [PATCH] drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1
Thread-Index: AQHZmhknEa6h5p7ASUaEgAyxCc8oIq+BDDly
Date: Thu, 8 Jun 2023 15:46:17 +0000
Message-ID: <DM8PR12MB53993BA11A7C9562ADD18E9EE550A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230608145415.825486-1-sonny.jiang@amd.com>
In-Reply-To: <20230608145415.825486-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-08T15:46:16.854Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|LV2PR12MB5896:EE_
x-ms-office365-filtering-correlation-id: 226083d8-e003-4c48-b5c1-08db68377fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ryrm7/l/oI2kIvu/DLNyEocairsbG0YtUrOl8fwlYDCjgwI7J0jS3oP6bzGMrBHVGuiOkHllDfKbSJaX+RZ7dKFyRJxjmkRRy5En8N9btO9JRjxJBfjsYpANUHNBuVdmjq4F/B6HYUc7bKGT0h+kzHWWJnGZ0kOtfMfFHh034LGnI4hqYJfdutZ3jUUYAKsi1x0iBok0NctlWT2t0ECwjuMZzI3dh1UNXA7eHoJ4CAfF1sIEnoEuHa87DNu1no0wGRm6E6FauevOnytqQtfxtyPovw64I5WK0BQlZWjmgwVOIkp/AM1RSThO6XsSwoKTV46COUbjd3ebFuvTP1BYRx5yx1lJGklk7rGpmuoTzHv4tT7sy3CphhQrPGyenQNm6lnUoNa3WE3XjvMh0zjrWIXPcVZ4JUBKRJuj55eVhMuuXXsQaFMPP5RGY+m06B7uAKevVZPI0Mj0V42TvuVLQ5UtXJNpWjZyO2M/UGRmd/qQEUCeBwUDUd5K5k4kvTrmNXDcX+dETfWeE+6RCXD/GweUQKLgPfhFQppIsvrkhBFVFnzbIwsDFA0uuRuxZqXBXN1XwM6rwIozYcjbawDxs4lciSbQCh7bZfbRrsBilJJfIbNx5jgwVlZT5vBbuWDE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(55016003)(7696005)(33656002)(316002)(76116006)(8936002)(66446008)(66556008)(122000001)(91956017)(66476007)(66946007)(52536014)(2906002)(64756008)(5660300002)(110136005)(41300700001)(86362001)(38100700002)(8676002)(38070700005)(71200400001)(478600001)(83380400001)(186003)(19627405001)(26005)(9686003)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SaGzu37Z5xTSWqulGVxgnQT/ucM9JXgOSRlguUp4c0H6Finf/6a67V0kA4RV?=
 =?us-ascii?Q?7M4eCsI5FFsqATIK3xf/PDHeti00wqBIIqa5hapfcy55kTcHWfTcjMkqtWvO?=
 =?us-ascii?Q?o+EXTAp94vHbVkTLbevlG/fu0CJUWOgk8Rlj1ZPisazXY1ZzH3Tce+9MZv4L?=
 =?us-ascii?Q?OKXtaGg9tGPbxLv3qsI6l7u4UinWZQ1fP9yHIOfEROS+VwZr6KOXRGTXNC7d?=
 =?us-ascii?Q?TDJys5XqjNtwKs508kCYnJ83zX45kVRxDy1Ao8/E5cYhJCct9Sj7NEEGAmnS?=
 =?us-ascii?Q?TDMi3LOl67ftLM5bKH2gmH14WJVC4cvT9wj6Pv31OjJVGpl4H01xUve2MhbX?=
 =?us-ascii?Q?jBovu7vqr3r71SvKWp1MBg4Z/fPyOsbxWpG5OHGtU5ToibAxh8KqdSuuEje7?=
 =?us-ascii?Q?5bfb3M3TRkzaefgMx3neoVbhK57Zz2BcV2gjJGDPfBTHTpqOCEf2eqR9dOMu?=
 =?us-ascii?Q?X76yoBPUPk5nXNkH+uAiaK40bgF/9MU+9vOPJkku3wD5izWbrzI4mt6xo6in?=
 =?us-ascii?Q?lNa3v49/8G5A8OE+/5FSOh0AcaFginoPY1vbF0TH627jqJLeKBk0IaMuovON?=
 =?us-ascii?Q?5JjjvT6u+9bu2GkwBYuiR2DrxhcUa+WEmvE2hv7XS4m+QD3Pq4ZponKzuaFB?=
 =?us-ascii?Q?VwfxJyj1w0HUrWFqC+Q7M7GRiSl8vXIYa218KYdyd10hc9EiwUK0yOuW7RIz?=
 =?us-ascii?Q?YKuG4L/EBNs8gjo6sg1vka7G6u+OpKt7+uurt7pgDYcNggDji3dUtBLwuQnl?=
 =?us-ascii?Q?dw8LCNNxvi4vOn2DIX5TGCTm3Mi30Ld3Na2yR1SuQ68sXwB8lasZnXi031DE?=
 =?us-ascii?Q?UhIkflnGUXpZQNp8ilSV6KCEBxxep1PNKf/7MsiBDQHWxOIWtlXPVgzpcRGY?=
 =?us-ascii?Q?uLlRN2gkzeDlwtH3sqz9rdLskHqbh+b3J7Tj1w+IscJk1/9VTeGIG4O66Q5P?=
 =?us-ascii?Q?K27xF8SPcNCI/PAgVSia8qEtwtSWcCSdjf4ST40GImnuRfbDVhDmEEPamD+r?=
 =?us-ascii?Q?uo5N65b4tCUAhZgqvIC6JsXQpAbgy7F+H5TVi5srdOlTw51WoAtEZg8E92OT?=
 =?us-ascii?Q?cKz7cK9CxAIi01mnpJmXYNciYDjOwOKIptxo7bq6l00FAAgIzP6LRqyZe/wo?=
 =?us-ascii?Q?oUFtUgIVYouCWKPyhckxmiroOGj8LUNhbCZF8rIItzFLOfeAvI797S8uFT2k?=
 =?us-ascii?Q?RKygBLE6ev/pdwbpnwLJ9mQwmkbWCf4jXxGCnhl4aCbY5UDRX1aSBAXFbD6o?=
 =?us-ascii?Q?K44v6WBcF+FVvi3P4gCZVB/i37JahIVceSyWy9F01Yu8UWj1gsI8IGGsUrOL?=
 =?us-ascii?Q?xSfofT7uEaOj52+aewFnZPJC1sMw/ZBsKuMyfqEZDjcTNH7agSEZHjT4RslN?=
 =?us-ascii?Q?Y0vPaemFLtnoej1qV5HSLMHTmH1R/YVsXSnrPk9dNmwLnAypWc3wY42G1+rf?=
 =?us-ascii?Q?9i2uEk4NVAxbbHK5P7MfWvvB96kMWIoHQntaBpX59iW8lhDdtl/IxFMY9TnU?=
 =?us-ascii?Q?debgMvrAenClSFw4uvDy9550nsY2iXuK/oMemion4qKP5CjbqZ9aI6NWt7mr?=
 =?us-ascii?Q?VrXqB/zvv25MDwA5AHY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR12MB53993BA11A7C9562ADD18E9EE550ADM8PR12MB5399namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226083d8-e003-4c48-b5c1-08db68377fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:46:17.8939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6+UB5aEdPSnczJQSeiCroDMwgnZIeFvAhmkwlnibFtL7bFyHhx4Nc7mYt/C2cb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM8PR12MB53993BA11A7C9562ADD18E9EE550ADM8PR12MB5399namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Leo Liu <leo.liu@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Sonny Ji=
ang <sonny.jiang@amd.com>
Sent: June 8, 2023 10:54 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH] drm/amdgpu: vcn_4_0 set instance 0 init sched score to 1

From: Sonny Jiang <sonjiang@amd.com>

Only vcn0 can process AV1 codecx. In order to use both vcn0 and
vcn1 in h264/265 transcode to AV1 cases, set vcn0 sched score to 1
at initialization time.

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 8d371faaa2b3..b48bb5212488 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -129,7 +129,11 @@ static int vcn_v4_0_sw_init(void *handle)
                 if (adev->vcn.harvest_config & (1 << i))
                         continue;

-               atomic_set(&adev->vcn.inst[i].sched_score, 0);
+               /* Init instance 0 sched_score to 1, so it's scheduled afte=
r other instances */
+               if (i =3D=3D 0)
+                       atomic_set(&adev->vcn.inst[i].sched_score, 1);
+               else
+                       atomic_set(&adev->vcn.inst[i].sched_score, 0);

                 /* VCN UNIFIED TRAP */
                 r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
--
2.34.1


--_000_DM8PR12MB53993BA11A7C9562ADD18E9EE550ADM8PR12MB5399namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Leo Liu &lt;leo.liu@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Sonny Jiang &lt;sonny.jiang@a=
md.com&gt;<br>
<b>Sent:</b> June 8, 2023 10:54 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: vcn_4_0 set instance 0 init sched score=
 to 1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Sonny Jiang &lt;sonjiang@amd.com&gt;<br>
<br>
Only vcn0 can process AV1 codecx. In order to use both vcn0 and<br>
vcn1 in h264/265 transcode to AV1 cases, set vcn0 sched score to 1<br>
at initialization time.<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonjiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c<br>
index 8d371faaa2b3..b48bb5212488 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
@@ -129,7 +129,11 @@ static int vcn_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; atomic_set(&amp;adev-&gt;vcn.inst[i].sched_score, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Init instance 0 sched_score to 1, so it's scheduled after oth=
er instances */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;=
adev-&gt;vcn.inst[i].sched_score, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;=
adev-&gt;vcn.inst[i].sched_score, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* VCN UNIFIED TRAP */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns=
[i],<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM8PR12MB53993BA11A7C9562ADD18E9EE550ADM8PR12MB5399namp_--
