Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87369606BCB8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sBAE+bPK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCFBE1126E1;
	Fri, 13 Nov 2026 16:50:03 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523E51126E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 16:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwaHLpXnClL1HnCoOuGxAdTTL9WSw0XHfCPCPLntK8qckSFOkHFdlM6v32e1Wr/wx5nxcdIk0HHv/58NHZeGWQbqFsXnYcDImbtNmRVciZiMUJqoKmKB95UdnMTvrbBABayEW3LbYKOEL6ntlGJ2uIfuLpMsiqNPAwwOZ8X5i9Q7/Wgm9NlYbYECk9zPm9uVEZMUoiYuzYJq+ZG5uz7cwGytQQ5jmMzmhIKMk8EtkMcL1USI+jxlXPOfOU7dxkPg0gux0lp8Aiwo+nOTEFpWvj9fJZc+043XSrLVPUbapB1KySExmJmR6SLexMym6daX8GEY4qwlKML6SCAJWbV0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+KMX+5a2Qjg5D9BHsqUP1kDV4eD6VueqJNeubZZCEY=;
 b=gyydPN45NJkYQBl4ugLIYCbABO9NqwVe6XgXxchzuGmfCQpgLxx7wKVrvd23PZ0AENTO7iySf4UdoB5C8UESP7zjnBACrP3vq2qqOHLIWCh/BGctw2wcyFgeFSarnrq9ou3u3X8ibwyrXzWmMPSJkNlbLIU4En8Ry2Z47SdVOYvk7ht0znlxML0dWO5Taqz9GmAY9Q1uRuxY6/lPzATlbJrSOgTwDjPt7KJiFmOldtxuJnxueOKoW4Nm6awAZUpa6/koi/Izd2T3u9ySZWcZ6Rzuiw3PUcZYIudNRksJjmNPE3ogm9K0qSJLf55BSNK69CU4VfH6w5+NzfNiSKnyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+KMX+5a2Qjg5D9BHsqUP1kDV4eD6VueqJNeubZZCEY=;
 b=sBAE+bPKTt7HLGspPau2sX/uhBL/o3/hiaJzyzbDJuSSDAsIBp7pqE0MkJk8/wxR7vNGF2Q6qZSV7Mx7Zwny+3vPQJE8AtQ+KfA7Fut4EIasF69kz41mBBw9oSHvqSERnByXQt2eIfNSPSxWtbPuOg7rR/KrNyWcwbkDGcVPhME=
Received: from SA1SPRMB0073.namprd12.prod.outlook.com (2603:10b6:806:256::20)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Fri, 13 Nov 2026 16:44:00 +0000
Received: from SA1SPRMB0073.namprd12.prod.outlook.com
 ([fe80::41df:58c2:2776:6313]) by SA1SPRMB0073.namprd12.prod.outlook.com
 ([fe80::41df:58c2:2776:6313%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:44:00 +0000
From: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Perez, Randy" <Randy.Perez@amd.com>, "Chiu,
 Michael" <Michael.Chiu@amd.com>
Subject: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3 
Thread-Topic: drm/amdgpu: Patch review for gfx hang on submitted jobs for S3 
Thread-Index: Ad1ziz2v3uv7wCayROSuZM3Cl7nD5Q==
Date: Fri, 13 Nov 2026 16:44:00 +0000
Message-ID: <SA1SPRMB0073292C113C6B98D9282092F87F2@SA1SPRMB0073.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T16:18:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1SPRMB0073:EE_|DS7PR12MB6048:EE_
x-ms-office365-filtering-correlation-id: 8b2ea3c3-4c47-4bd7-310b-08df41a55183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|6049299003|366016|23010399003|4053099003|10067099003|8096899003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261026121527099003|11063799006|56012099006|38070700021|18002099003;
x-microsoft-antispam-message-info: FP4Mo1iCeAx6VLFDGLdHd68wuoCWY14PMRKnEo1zLC55TKpIcp3dZmsdsbWtsPorH/mobE7+2QRt3slRzcTAa4CLPDVi+DPHoh11F4CMbGm+ynrc1A9yS3+m4Ub2xSulOCiLKXnOhnoJqnNEqn2Cb/tUYj4wVy794tE5BNm1yWgu5q+JhUMMLkSWGlchq29QxSGHzOIljdzUnVM/3MANfQ+lTNZK4Ceft6r6olyPiRTHjs3SwlxSwyg0p0c0YOpKwHo4cxudXA3RWemIIHqh++qa7p98Tc/6comH+Hko0bHbaTjDcJKqrmRcpD16zITHKes0y6yhqtgSQXol3p+R6r2IZexXbUuGEUhIGZcVTUA8rwWIJUDqRHF7MkhWBVpIcao3pBOmSepsedU2+LIU4+Q1fjbajx5POp0mfx7r1kEiYg9qQo09VBC1AvygHp73eDnNnzZqTQDY7CFpBP13D6BLd8GOZMj61Yy3DSOs9HoB96tB5GMZTVkpneMSleS6XGTjyrsaewWiiiiElBOXbnZJhnAQYp+KBethFZlI3Tk2d/oS2WHl0xstS5HkDzInU3OfIkHATBSIUiuH3/2BVgImrF/zz/VKGOakxAhQ4MpCFmRKWEC4Gqq1XDnWsnmsk2umJvEVuPEJyNZis8qsZIf46VuPhcbM5/ffd1RKc/P5qjFpT/IZZRmDVf3yUn/PfiuEx6PweD+XMVZT6TazgP0NAe0845FK4MjCxVs1/O0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1SPRMB0073.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(6049299003)(366016)(23010399003)(4053099003)(10067099003)(8096899003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261026121527099003)(11063799006)(56012099006)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xwzw+LnKVam4XDpw68iLUo2BniE+b3k5F9kpeOoo4yByTzv/QlKNQ/kdabn7?=
 =?us-ascii?Q?L2H950YI7KHYiYxcj1JWcTb3P39kGqitvEx/x//UryDz5jZdEtdCNaRSBm1v?=
 =?us-ascii?Q?QvyYSgds2f/a0zZkPW/4cLzc5lbaBOQ5tDhLHIx414S1IW74mWg3WXzRfVXE?=
 =?us-ascii?Q?yglO5xkhYz+D0oxp+x7WmRrjgoDywJ+g+1/Vk7Q1wR1ivuTiN6QNF1TP7tyh?=
 =?us-ascii?Q?NmaQJXHLx8UbHPmIQJtC1BvJOz1uHR4tMh+fzJUJ6g8jvSvf2N5pn+ppE2m+?=
 =?us-ascii?Q?UWskruOmCU7HezgU0kEblwgAz0d5YShHZsSDaIgFePmt5uk1c8lR1gxRAque?=
 =?us-ascii?Q?3Sxzptopw4t+qKgfB81+ZNlmzORpr7icPTcILwcGYxEaMy5VnqxBglT7meLe?=
 =?us-ascii?Q?v7x6tqJpm10dvJWaxfbsIIDJp82F07Duqif+WtSoUl73xh0lTKG7+L0EuBk+?=
 =?us-ascii?Q?4kQx99bT6XUUZOGtgoCzs8O36xg8aEw6AfnH2OMCwYvqm3XbCE4VJsvviPyg?=
 =?us-ascii?Q?dI2jY7dP5wTWt//MzEMGMS+Uv+pkkE4/GokJTWeH0lqFAL9zFhYBJlHCgzmA?=
 =?us-ascii?Q?02LLnIUeOI0l03Jr1dhiPCIZg6HIYcGDzx/eIoPK2Jb3ucwJoZ+yoySWLgnL?=
 =?us-ascii?Q?oJM2vPx2kQ8U3T7z2WEG4qTPSjoq0OprX0Tp7Q/8rQnAi37YjrEZTtJW8DK/?=
 =?us-ascii?Q?IGz6NXxpdT/0Wr+Qqy1XfkzEzn++u46zZLcRhoq9bIUQVT+o9aPYgAKg6EYC?=
 =?us-ascii?Q?Pqbs0p0a+ji5UiZKVcIjOLOp5UuwSLitkt71JFVJt4CkMwtVmiEwiycF9jWG?=
 =?us-ascii?Q?u+qQw1NXcnEWL0WY0kAXp2BMfryNcrt6wKJW+CtIT8ufEQC+92HF3RcNME41?=
 =?us-ascii?Q?r5yXjZlYeW8VakisKnZOou2AKgmSEnJ7vVXhDqKGOr/eTT18OLs4vb6uZ0Hb?=
 =?us-ascii?Q?MFxNGWA3JrGTee78cggIIvHQvHT+7YDU62elxC8H5B04XORdMeee5Kg3T/+z?=
 =?us-ascii?Q?bwKLJBijSIMlZqOv1HFzH9qyYokyA92sjlpJ8NMDcJyn/+RDWDarjv5FOwTQ?=
 =?us-ascii?Q?0SNE82vJt5EnYzQex6TsRN+3xmop1Xqkt6O8bNXqmz1xruv8HLe2DvzuiZXa?=
 =?us-ascii?Q?vMSDPkmiWkOssiyIP7BIa/Xnv5rKQVj92jtthFbDkmo8Meb2AMedoLkbmjZ+?=
 =?us-ascii?Q?8tzn4y5ZBlwwRB6pkCEq6uvK2vbFnHxu6ej5YV5OFJAniER9LuXnBQANVkM3?=
 =?us-ascii?Q?pAxJxDyM2Taugzzeml+O5B8ATkbUkTBEblw9eaVY/Y5QoL6lGHMrvW1QBYrF?=
 =?us-ascii?Q?cLZZK2UpXJNEiK/Edz/2Gyu1ShrBbxqRaB6QlN1NioE7yifdhovn+Hqcxouq?=
 =?us-ascii?Q?2OjiJrpatrr+/VUkJM7ohb3TIJQYAizimF9+DZh2QAOwfNFOTrRW4BtSdma9?=
 =?us-ascii?Q?xH36VqMO+0TkXhQfsKBLFCsirKlXvw85obqM/4caixuEsBWCxeaz8BbtAKS/?=
 =?us-ascii?Q?krvzLMy3nNXFl7qnMJI/B96XJoePlSBtc4XmXT7pGhJ/efsjRS5nLHJ1yiPR?=
 =?us-ascii?Q?CTZ3XTidoCXT5fU03TOjWlK0/jBAx2ih2x3zhjhLXuun2h11f3jwXTGriKr4?=
 =?us-ascii?Q?9irFy2/IaacO4r1kAZm3DIaGSTZZ7V7c7SfcXSgnlxjjFqNIa0SRqjjNjbvr?=
 =?us-ascii?Q?i/YjBIThN7xQrq9cprrArvYj5tq78Mbm24ggkqCCOle5OMuT?=
Content-Type: multipart/mixed;
 boundary="_004_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0073.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2ea3c3-4c47-4bd7-310b-08df41a55183
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 16:44:00.1863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBkTH+KZp//qG/peL1m2v/HdwwKdLSbl4cMwAS3ruuOpcsewQaEgIbHR7T1n2u1kbvlOVb/hEL7N73CGIgKUkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_
Content-Type: multipart/alternative;
	boundary="_000_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_"

--_000_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi,

Please help me review the attached patch.

A gfx hang that occurs 2 out of 400 times when performing S3 cycles. The is=
sue is seen with the kernel version 6.18.8 and on AMD hardware; Picasso gfx=
9 APU.

When going to S3 suspend, the driver checks whether GPU has completed its t=
asks, but it doesn't wait for jobs that are submitted to the scheduler. As =
a result, queued up jobs slip into the ring and are lost when WPTR is set t=
o 0. On wake up, we hit a timeout followed by a hang.

The fix is to wait for all scheduled task to finish before going to S3. I t=
ested the patch and the issue is not seen again.


Thanks,
Tharshan

--_000_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please help me review the attached patch. <o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A gfx hang that occurs 2 out of 400 times when perfo=
rming S3 cycles. The issue is seen with the kernel version 6.18.8 and on AM=
D hardware; Picasso gfx9 APU.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When going to S3 suspend, the driver checks whether =
GPU has completed its tasks, but it doesn&#8217;t wait for jobs that are su=
bmitted to the scheduler. As a result, queued up jobs slip into the ring an=
d are lost when WPTR is set to 0. On wake
 up, we hit a timeout followed by a hang. <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">The fix is to wait for all scheduled task to finish =
before going to S3. I tested the patch and the issue is not seen again.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Tharshan<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_--

--_004_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-dma-wait-on-scheduled-tasks-before-suspen.patch"
Content-Description:  0001-drm-amdgpu-dma-wait-on-scheduled-tasks-before-suspen.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-dma-wait-on-scheduled-tasks-before-suspen.patch";
	size=4234; creation-date="Fri, 13 Nov 2026 16:37:37 GMT";
	modification-date="Fri, 13 Nov 2026 16:43:59 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NDhiZGRhMWQ1ZmVhOTQyYzNjY2Y5OWFmOTA1OWIxY2M2MGVhN2U5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMb2dhdGhhcnNoYW4gVGhvdGhpcmFsaW5nYW0gPExvZ2F0aGFy
c2hhbi5UaG90aGlyYWxpbmdhbUBhbWQuY29tPgpEYXRlOiBUaHUsIDEyIE5vdiAyMDI2IDE0OjMx
OjQ1IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogZG1hIHdhaXQgb24gc2NoZWR1
bGVkIHRhc2tzIGJlZm9yZSBzdXNwZW5kCgpbV0hZXQpPbiBTMyBzdXNwZW5kLCB0aGVyZSBhcmUg
am9icyB0aGF0IGFyZSBpbiB0aGUgc2NoZWR1bGVkIHF1ZXVlLiBUaGUKZHJpdmVyIHdhaXRzIGZv
ciB0aGUgam9icyBpbiB0aGUgSFcgcmluZyB0byBmaW5pc2ggZXhlY3V0aW5nLiBCdXQgYWZ0ZXIK
dGhlIEhXIHJpbmcgaXMgZW1wdHksIGl0IHN0YXJ0cyB0aGUgc3VzcGVuZCBzZXF1ZW5jZS4gQXQg
dGhpcyBwb2ludAp1c2VybW9kZSBzY2hlZHVsZWQgdGFzayBzbGlwcyBpbnRvIHRoZSByaW5nLiBP
biByZXN1bWUsIHRoZSBXUFRSIGlzCnNldCB0byAwLCBoZW5jZSB0aGUgZmVuY2UgaXMgbm90IHJl
dHVybmVkIGZvciB0aG9zZSBqb2JzLgpUaGlzIGxlYWRzIHRvIGEgZ2Z4IGhhbmcgYWZ0ZXIgdGhl
IHRpbWVvdXQuCldhaXQgZm9yIGFsbCBvZiB0aGUgc2NoZWR1bGVkIGpvYnMgdG8gZmluaXNoIGJl
Zm9yZSBzdGFydGluZwp0aGUgUzMgc3VzcGVuZCBzZXF1ZW5jZS4KCltIT1ddCkluIGFtZGdwdV9j
dHguYyB3YWl0IG9uIHRoZSBsYXN0IGZlbmNlIHVzaW5nIGRtYV9mZW5jZV93YWl0KCkgYnkgbG9v
cGluZwp0aHJvdWdoIGNvbnRleHQgbWFuYWdlcgpJbiBhbWRncHVfZGV2aWNlLmMgY2FsbCB0aGUg
ZG1hIHdhaXQgaW4gY3R4IGFuZCBhZGQgdGhlIGxvZ2ljIGluIHN1c3BlbmQKClNpZ25lZC1vZmYt
Ynk6IExvZ2F0aGFyc2hhbiBUaG90aGlyYWxpbmdhbSA8TG9nYXRoYXJzaGFuLlRob3RoaXJhbGlu
Z2FtQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
ICAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5oICAgIHwgIDEgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMjQgKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA1OCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4
IGFmZWRlYTAyMTg4ZC4uYzRhZmZjMzJlYmFjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jCkBAIC05OTAsMyArOTkwLDM2IEBAIHZvaWQgYW1kZ3B1X2N0eF9tZ3JfdXNh
Z2Uoc3RydWN0IGFtZGdwdV9jdHhfbWdyICptZ3IsCiAJfQogCW11dGV4X3VubG9jaygmbWdyLT5s
b2NrKTsKIH0KKwordm9pZCBhbWRncHVfY3R4X21ncl93YWl0X3N1Ym1pc3Npb25zKHN0cnVjdCBh
bWRncHVfY3R4X21nciAqbWdyKQoreworCXN0cnVjdCBhbWRncHVfY3R4ICpjdHg7CisJdWludDMy
X3QgaWQsIGksIGo7CisKKwltdXRleF9sb2NrKCZtZ3ItPmxvY2spOworCWlkcl9mb3JfZWFjaF9l
bnRyeSgmbWdyLT5jdHhfaGFuZGxlcywgY3R4LCBpZCkgeworCQlmb3IgKGkgPSAwOyBpIDwgQU1E
R1BVX0hXX0lQX05VTTsgKytpKSB7CisJCQlmb3IgKGogPSAwOyBqIDwgYW1kZ3B1X2N0eF9udW1f
ZW50aXRpZXNbaV07ICsraikgeworCQkJCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOworCisJCQkJ
aWYgKCFjdHgtPmVudGl0aWVzW2ldW2pdKQorCQkJCQljb250aW51ZTsKKwkJCQkKKwkJCQkvKiAK
KwkJCQkgKiBnZXQgdGhlIGxhc3QgcmVjZW50IHN1Ym1pc3Npb24sIGFuZCB3YWl0IG9uIHRoYXQK
KwkJCQkgKiB0aGlzIGltcGxpZXMgdGhhdCBwcmV2aW91cyBzdWJtaXNzaW9ucyBhcmUgY29tcGxl
dGVkLgorCQkJCSAqIHNvIHBhc3MgfjB1bGwgdG8gZ2V0IHRoZSBsYXN0IAorCQkJCSAqLworCQkJ
CWZlbmNlID0gYW1kZ3B1X2N0eF9nZXRfZmVuY2UoY3R4LAorCQkJCQkJCQkJCQkmY3R4LT5lbnRp
dGllc1tpXVtqXS0+ZW50aXR5LAorCQkJCQkJCQkJCQl+MHVsbCk7CisJCQkJaWYgKElTX0VSUl9P
Ul9OVUxMKGZlbmNlKSkKKwkJCQkJY29udGludWU7CisKKwkJCQlkbWFfZmVuY2Vfd2FpdChmZW5j
ZSwgZmFsc2UpOworCQkJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOworCQkJfQorCQl9CisJfQorCW11
dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKK30KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKaW5kZXggMDkwZGZlODZmNzViLi4z
MDIyZmUzYmE3Y2YgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jdHguaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmgKQEAg
LTk2LDUgKzk2LDYgQEAgbG9uZyBhbWRncHVfY3R4X21ncl9lbnRpdHlfZmx1c2goc3RydWN0IGFt
ZGdwdV9jdHhfbWdyICptZ3IsIGxvbmcgdGltZW91dCk7CiB2b2lkIGFtZGdwdV9jdHhfbWdyX2Zp
bmkoc3RydWN0IGFtZGdwdV9jdHhfbWdyICptZ3IpOwogdm9pZCBhbWRncHVfY3R4X21ncl91c2Fn
ZShzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1nciwKIAkJCSAga3RpbWVfdCB1c2FnZVtBTURHUFVf
SFdfSVBfTlVNXSk7Cit2b2lkIGFtZGdwdV9jdHhfbWdyX3dhaXRfc3VibWlzc2lvbnMoc3RydWN0
IGFtZGdwdV9jdHhfbWdyICptZ3IpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA0OTEwNzQ3NWFmNjEuLjJjYTk5Nzc3MzAwNCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtNTE5Niw2ICs1
MTk2LDI4IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9jb21wbGV0ZShzdHJ1Y3QgZHJtX2RldmljZSAq
ZGV2KQogCX0KIH0KIAorLyoqCisgKiBhbWRncHVfZGV2aWNlX3dhaXRfZm9yX3N1Ym1pc3Npb25z
X3RvX2ZpbmlzaCAtIGNvbXBsZXRlIGFsbCBzdWJtaXR0ZWQgam9icworICogQGRldjogZHJtIGRl
diBwb2ludGVyCisgKgorICogV2FpdCB1bnRpbCBhbGwgb2YgdGhlIHN1Ym1pdHRlZCBqb2JzIGZp
bmlzaCBvbiB0aGUgZG1hIGZlbmNlCisgKiBDYWxsZWQgYXQgZHJpdmVyIHN1c3BlbmQuCisgKi8K
K3N0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2Vfd2FpdF9mb3Jfc3VibWlzc2lvbnNfdG9fZmluaXNo
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQoreworCXN0cnVjdCBkcm1fZGV2aWNlICpkZGV2
ID0gYWRldl90b19kcm0oYWRldik7CisJc3RydWN0IGRybV9maWxlICpmaWxlOworCisJbXV0ZXhf
bG9jaygmZGRldi0+ZmlsZWxpc3RfbXV0ZXgpOworCWxpc3RfZm9yX2VhY2hfZW50cnkoZmlsZSwg
JmRkZXYtPmZpbGVsaXN0LCBsaGVhZCkgeworCQlzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiA9
IGZpbGUtPmRyaXZlcl9wcml2OworCisJCWlmIChmcHJpdikKKwkJCWFtZGdwdV9jdHhfbWdyX3dh
aXRfc3VibWlzc2lvbnMoJmZwcml2LT5jdHhfbWdyKTsKKwl9CisJbXV0ZXhfdW5sb2NrKCZkZGV2
LT5maWxlbGlzdF9tdXRleCk7Cit9CisKIC8qKgogICogYW1kZ3B1X2RldmljZV9zdXNwZW5kIC0g
aW5pdGlhdGUgZGV2aWNlIHN1c3BlbmQKICAqCkBAIC01MjEzLDYgKzUyMzUsOCBAQCBpbnQgYW1k
Z3B1X2RldmljZV9zdXNwZW5kKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgbm90aWZ5X2Ns
aWVudHMpCiAKIAlpZiAoZGV2LT5zd2l0Y2hfcG93ZXJfc3RhdGUgPT0gRFJNX1NXSVRDSF9QT1dF
Ul9PRkYpCiAJCXJldHVybiAwOworCQorCWFtZGdwdV9kZXZpY2Vfd2FpdF9mb3Jfc3VibWlzc2lv
bnNfdG9fZmluaXNoKGFkZXYpOwogCiAJYWRldi0+aW5fc3VzcGVuZCA9IHRydWU7CiAKLS0gCjIu
NTUuMC53aW5kb3dzLjUKCg==

--_004_SA1SPRMB0073292C113C6B98D9282092F87F2SA1SPRMB0073namprd_--
