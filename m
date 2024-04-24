Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A31C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 17:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578CE10FEE2;
	Wed, 24 Apr 2024 17:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iToT61ZK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B353113CC7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 17:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4r9UK9cbodlQNGdx1JH8979212m0yX/y5rjiU0s/GphVBIFv/pkB5fcd7ADlSOaOhlbaBl9aSfjiECOemtiLBndTxgQZN17dnW8BeVRviSdY6a1tchgHDxsyliph86tl3NvndmHLACgwclcOkYtvq6u3gynnHyYwfwf0F94bGn6j2y9JkNI3TsYPJm8tbm1PQAkUsti2r1U6rB/nc5wUxG2tyUHPsqh5ojNuIbjLrVKhfUMqr+MT+6JoViLaBvSRIKUjjWiGNfJaGwdfQoWMP4+Y1fxRXUPY3zll/X77R7rhbGjz4D6ceSySHnLsVOj4Wvg2O96q/Va1sS3QvpRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwzqi97viYylL7OsfZnjYaSLh9+IBmzv9H8BlGueKR8=;
 b=AJ0ZanZHDZTmKvM7NmQEkk3AfG89hyPYyC4/DiAqi8qPFY9VAumnhkQ3q9jrbpgdDa8f45K5ySqSW43MKJxw61xb/EGry0GMwhYrvihDciX5CGhJKpbJ083mvFqw1JMRYg7Jf2n8NZkpiEWRfodDwaq0EQI0fvvbY1eSSLLwtD71GU49r2BecwJmuRjL44IQjiKtXRl91Esr/vgwC9E2MDDiQVXg3Pke5G/eZcnS2u7I9gMD0v9caBuG3HyaoP/3h37P2VI1s2VDW2AntZYa1yaADPoa4tGLWt2GBvgYSs4tS8AaPeAhDs+QzU+u6YktAWzoIE/pSIP8Bp4L8BMXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwzqi97viYylL7OsfZnjYaSLh9+IBmzv9H8BlGueKR8=;
 b=iToT61ZKeg56vaeE4l0/phMY8CBh68EWrxPLkv4AvA4ipLgvIgm8oIWOhY2XfrOse4rgklcnjpg+mA2Xxuc+qB8sx+t1flcOIGsSGahPtUOAUaQBM8iipknjHhgrN1otjmtdLoQCKYd0GHVuZewQ6DDQiEN2f+Ku4zMzlQcwrdA=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 17:39:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 17:39:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings
Thread-Index: AQHalT+rYGFyGDS+T0yL8t4VvbGACrF3shVu
Date: Wed, 24 Apr 2024 17:39:13 +0000
Message-ID: <BL1PR12MB51447DA8A1DE3AEB163B4717F7102@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240423053239.884297-1-bob.zhou@amd.com>
In-Reply-To: <20240423053239.884297-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T17:39:13.178Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB6566:EE_
x-ms-office365-filtering-correlation-id: 05cfa6bc-adb3-450a-7ef8-08dc648574e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8o9KpoZOnROhYwMDmR7vUHe7c/UlVfJmYczRMbFv0AihWq+Fp9S11BaBCaVa?=
 =?us-ascii?Q?0S6cqU63CAE/b5MFsrqdaHPMtSnlZn5ocOI7P7lnJn2v6HfEKXbQ/EK6Ywg2?=
 =?us-ascii?Q?N0tkYPS1P+Ocjz9XoTfwJoaUXBiif9mukzxlBUHRFrNvQQSrkA+OWYIJculW?=
 =?us-ascii?Q?C+yxd8HANjQqgkc/LV4Ta36xxE3NP9T0lWOWTY/5Gz3Q05y231LaDkubXyPc?=
 =?us-ascii?Q?9kIi8cZ/tlj/uEPLMmb41n0yBndWLROSIFAW3bzWoMgk+nHG++wLEnjPIejf?=
 =?us-ascii?Q?MfNmxgYC1/HylC0xmDRm0miIc0nx6mOqK7WlbLUFS6gQr83LKJvoQgxe1KaH?=
 =?us-ascii?Q?h41KFGFGg/QwpSq05/L4h2qMIa0g+dHzSacoKby4QM19l1fpV2Q+100S95yV?=
 =?us-ascii?Q?59r9KcCl6F5R2wVzLenwreWCpwqLe/m/bKgdovR5XzqFiCgIeISGyjL66KVh?=
 =?us-ascii?Q?baS6knvvH62w4Q+afucCvkJdFjJBBmkQfvTq80LKvbOImEOThEl9NoqsoLtV?=
 =?us-ascii?Q?Zg+/lbJmHs76tKqIz6qMxw17qhxqc/6zes3z7F1e7tmrJ/QW2wyU2Io8u5JG?=
 =?us-ascii?Q?++IGZKn4zguZFqsSJ1i8oUuG1WjDEwes03DbPwmsD1pBdRICXA3Y6nDSCGS/?=
 =?us-ascii?Q?ORoyMEQl4cxLSi6l6+2tfvBAepCJ4P2uxQcpwUrCZ0b8vom2oSakdTVwPdxj?=
 =?us-ascii?Q?UxozJItljnaRqHbsSL4NKlLQZMcUioNp2TDBj33IYYZuw6YtfixfPuUbwbQt?=
 =?us-ascii?Q?dGCrGWY6JOaWJFe3a7ds4vXCZlbn6kQ0yb21e3u3gdU5RAKoRR901swhpNgC?=
 =?us-ascii?Q?O+ehpfVECUDLSylnGcXp406Q0S6Omn7ZHcQIuQl1yMmbPXufwu+wMVoLyNYH?=
 =?us-ascii?Q?oZQA0kt6lZBpUqNgGtN9GtK6FHY79vAMhQq8HaTXW1bvlCBWsdaxQXoDTAJG?=
 =?us-ascii?Q?NeTEWGvHKV+vqBa7KDG5faFOC9okJEqSAqqqX1cmjR3lazbml6EXEkcE+s9Y?=
 =?us-ascii?Q?d1PHkNSBm5/Hhkvwnwf4mLCWSEWj8DYqhHjBz/J0ehpibzhuQxcADSR3oE9v?=
 =?us-ascii?Q?IUJqJQ3/DIOxu0sG67gBFDEF52u6zzA4imP5F4ZoM4VP/PLGJFczamNSsoZp?=
 =?us-ascii?Q?4chaQeI8aYlD1MDeQ3oXUWrzytFjqvkC7M6FpC8VcZMJOA6NIyAl9Oz1i+rL?=
 =?us-ascii?Q?weGz+grmdnIHT82cQ4xjmMgh4f2HJsPByU4X6fY0Qns297MKPwfVS2tEb5q7?=
 =?us-ascii?Q?saeNFnPFgkYTwKCGBqm+fSxawnvz4UGQA1RphSOPcQmL0BQBthFWrYtwKqwa?=
 =?us-ascii?Q?NPiM4tVQACyDwIF15JuVYHhAuwQXWSAlAvxaWdfDT+XnIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpT9ki4HSt71uMeMzGgu2UVmb5F1vQ/qsy7p77b9HozMgrZX9qJY3NctzaPt?=
 =?us-ascii?Q?IsaOxjZXpv8qbucG54iy48mi9WCiQj+UEBH0EKCRHprj1hFVCp9jz8iPL8aa?=
 =?us-ascii?Q?3QMUwYFf8HeSNHiATxLpId6INBkSN6os2vwWB3yBzU6I2v9eCERwJE9odjaV?=
 =?us-ascii?Q?EqSN8G372oczzXiK/Q+xAiN7xegjYR1pyNksHT5h6UV4pbwfhT4ifncWWDqu?=
 =?us-ascii?Q?K3vdOiGDoesnjwVNn1F2OfaSoup9VnstTnVxSMax2M6A9xRHY9ZCCWZVf9N7?=
 =?us-ascii?Q?0ZoK26emHUQ3ESjne5YEwJRBku/Q/wqAiA2OnvFd3Q9Oe7Y651TwfuSvbtf/?=
 =?us-ascii?Q?38FVuKILVc6fKDP+QCOwjahM3TgyH3acGBECv2vD5K4Vs/qvLW+8EeNyUgwm?=
 =?us-ascii?Q?TE2avjFxaKzcxoCIcJd79TwXUdG2pudfuQa0H+v4AHZRQeT1j1weeSIa5jHk?=
 =?us-ascii?Q?bxzqB5s/liDVcJSBQuoNJqTovUoaDFhV/zQlBZ4JxMIOZkNG6O6G8aQWfrvV?=
 =?us-ascii?Q?vdRUr+41DePa2nldY/Q4aIKW6U4naRPNcdIDC4VM4c6G4M+fRQNleFNqNz4u?=
 =?us-ascii?Q?Dznj5g6wYGupvTN5/0MizR9ATjsL2TTx1keqMjNHLSQJ38kp8ncH3kiaUtlE?=
 =?us-ascii?Q?c64fJv+qG1mjvpAcdTFT7HPW79qRHABYUdbihw0JdHRo8ga5QAF2g1kznu4M?=
 =?us-ascii?Q?2wJxZhqxtMR5j9yDArGyjzlWKwc6hH9sI1DRR5dPiSQlZRBfXuqZLedfp6AT?=
 =?us-ascii?Q?NDLOJXEWluHRJhFL2vVg29kQ95E4TTax1VlZzh6o6sLUCw4LTlHa6nEAnR1i?=
 =?us-ascii?Q?4Na7RlzZwrmyGmKqUnjYMtlOMgsGyyvkdYoK74x8vjIGnJTPb6FvrnYBIEeE?=
 =?us-ascii?Q?xEN9UjC1d+KIN7lOPwYvuqtXNbsp2FEUAhDxkS9DE8pWgHr86X3Fj0QHVu2W?=
 =?us-ascii?Q?sIt3g978KLtOGjPXA6z4V7EiqeqatCxCKYk+GnELJXC798aY+ZeeYoWerfWD?=
 =?us-ascii?Q?kyLr9SwlsM7w4LgWpJUHe+CAQHYCoGWNq9B5P8/YKf3C1XJG7xRiNhVK6vYL?=
 =?us-ascii?Q?g5sqBJZiwSyMFCtjItMr46t6WjFmwUxH1BnGYxvxakh3Yy7sKZ22JYVGp21Q?=
 =?us-ascii?Q?RHvoHaZLAlPBM1UyXlq9WN/7cr6Nrmg6vnBHFCiFgUF0UUO6DK5zA8QISiWM?=
 =?us-ascii?Q?Iy15JCQcK0iTxPS1G2io8Dmt+vwDqu58zNoogko2o5mcxVLXONcXrY/DXFT7?=
 =?us-ascii?Q?fWp4SucwzPxdA32ZYeuqeRZeZs+ddYQKJNSgEIWDX2pt/w7hF7rbtSb3+Lfr?=
 =?us-ascii?Q?kgfeXZLi4cez596WbXWB4PJLz81q5XZdZyxxy9Vv34j85fpiIht05maBy54/?=
 =?us-ascii?Q?7ajC+vTEz7z6Us8+BdlIgGE4QyifrJMqs6LI6fPMiEtxSc7JUpzTVJmWdxn8?=
 =?us-ascii?Q?XXkRKpw485+csKjRbnTXjD9FDzJuUpGxmBqJAjs53zOfbJ361yBUdqZKtK8m?=
 =?us-ascii?Q?SqJ9Iqdfdvx7mBBzNBYfY4+sWsTFiJjLAjD3ExhwibpBYe7Uawr4E5yf4+jk?=
 =?us-ascii?Q?VcVrsUjWFsO6n6NXeC4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51447DA8A1DE3AEB163B4717F7102BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cfa6bc-adb3-450a-7ef8-08dc648574e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 17:39:13.4236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5MfYz1te/xGtVZm7ySf1IYWE5/Yzh/u4FO51srOmQfcX0wGgud5CAI6wPl7U2sefC2g5X3htl7AbFFPwdAM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

--_000_BL1PR12MB51447DA8A1DE3AEB163B4717F7102BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Bob Zhou <bob.zhou@amd.com>
Sent: Tuesday, April 23, 2024 1:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>
Cc: Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer warnings

In amdgpu_umc_bad_page_polling_timeout, the amdgpu_umc_handle_bad_pages
will be run many times so that double free err_addr in some special case.
So set the err_addr to NULL to avoid the warnings.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index f486510fc94c..32e818d182fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -170,6 +170,7 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_d=
evice *adev,
         }

         kfree(err_data->err_addr);
+       err_data->err_addr =3D NULL;

         mutex_unlock(&con->page_retirement_lock);
 }
--
2.34.1


--_000_BL1PR12MB51447DA8A1DE3AEB163B4717F7102BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Bob Zhou &lt;bob.zhou=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 23, 2024 1:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Zhou, Bob &lt;Bob.Zhou@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: fix double free err_addr pointer wa=
rnings</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In amdgpu_umc_bad_page_polling_timeout, the amdgpu=
_umc_handle_bad_pages<br>
will be run many times so that double free err_addr in some special case.<b=
r>
So set the err_addr to NULL to avoid the warnings.<br>
<br>
Signed-off-by: Bob Zhou &lt;bob.zhou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c<br>
index f486510fc94c..32e818d182fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
@@ -170,6 +170,7 @@ static void amdgpu_umc_handle_bad_pages(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(err_data-&gt;err_add=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data-&gt;err_addr =3D NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;con-&gt;=
page_retirement_lock);<br>
&nbsp;}<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447DA8A1DE3AEB163B4717F7102BL1PR12MB5144namp_--
