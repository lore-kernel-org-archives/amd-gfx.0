Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21038ECAAD5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 03:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7866110E983;
	Fri,  9 Sep 2022 03:19:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9008B10E983
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 03:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahQc3jyUcZ+jMj9GYKozhHPs9iqtEo7242e6h56O79xUuW5I0iOcLgiSvRUMpkbwYD+7fb1ImWbmt7ijAPQ5vDobgPgSXzjVzcUFTYCgW+q2NLCzOPQzFifhhJc2kMJ03c+Q3k9N6TeXmiplUMr4b/jWXNkXobm4klN9HpqSuSajzOiijmyQ4RzXDSPjKVLaXKqem6e90YfBdRE0czsQJg3FaTx+7Xp2BQ+QM2sjIhmxDgaqMoXfT6qksYZ+JxNmKC3xdQtSDcBV+yYJaM6lbcW5dSKEkCb6CvLJZfOxNXy5HqRE4bsHoUek0otIwXDHN675PmRvlTq+3DbsOIJxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/nujTJYiIS7RxRjukbGBi7UcVs1Ef3QQj8wquK/xLI=;
 b=OlI1kDuyp8NRKHwrLqWCL6Qj9XS0lnbwj5WpsuIOVdHM9L6XnbfPp0CIjLP7eM2Kq2P1gPEm7Me0hNFO8MnHuRKOIiKRLFXNB/4RbVLaIRz34Bqmn+/4e2fVpDGBbqaLPoRnW2yoXDAKcAp7HsFKjzd9jRbcHL5bjcdVlFMhFIrHoid45RXrBrM5ViRCG6hoQSzW0Kd1hwhWHcsLjQHvbQB6vjIDD3JWXoVfohT3uvmyjWa3pN5pO8/1Adg4gUcdG17FbXC0yMI5twyWNJfJgF0yGPNhp2hmStxg9/9ekRLj0Ij61wdCwwFBOtFVBbE8BKEUk/u5jgVdom4qNys17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/nujTJYiIS7RxRjukbGBi7UcVs1Ef3QQj8wquK/xLI=;
 b=cnrhJ0CoICrQ5yGnmaPXVYWE7hqp0lA14AkFfGIA7fum9ka4t9X+omNG8ynuOpLt7LbYbszgZowZhWmGiPaUUXK/VXElMseDyCIzJUIC1wRp9dJ7bnltErMxQJsr5k5NQFlip8jd0jKJf+b/rBX//6QAMAXoanU187Cja3yR9fI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 03:19:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 03:19:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: change the alignment size of TMR BO to 1M
Thread-Topic: [PATCH] drm/amdgpu: change the alignment size of TMR BO to 1M
Thread-Index: AQHYw/pWkEkF+Py/kE+vtcmBA3zti63WbSus
Date: Fri, 9 Sep 2022 03:19:35 +0000
Message-ID: <BN9PR12MB5257F80C5B9E967E0443FDF7FC439@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909031428.3147161-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220909031428.3147161-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-09T03:16:33.6503773Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6939:EE_
x-ms-office365-filtering-correlation-id: 791de180-af59-4cf7-8c3c-08da92121f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ODvxKpni9ThvopOMqwXY+VizBYwokLEiKwSjoqLQ9T21q0NxI/dvNRZWLpCcCq4aUHh59NcM8iFtttnYeBMcNfp4hMfF+oY3Hx/B7gzsEdp6d0XKiXTyMKLVUQ6SgW8Ef9iYQFNjHkQ5ya74kTF+bhteF+5XOf6mx4wEqZvxG+aL7G8avYYCcLR1XldUOaEy3gCNt9LKz9NXOIFnUONkJ4jh2fYFbLQG3uMo7TVrvSYzRs7nvAqRq+AQc/eb/faigp+MWwY/pUJLEP5mL+laAaprqO1/PKrlP/W/50qwoDO3BPNuE81NrI/Cn36m7qf0mOJZiRQwB5OKsomBxMKRjIrifjoHWPYAiP/eY+R7onVkiOW46Vmz9PvEOxFqFCdBXqsYdB6EEzjiE8SilQyTHtBXs2iHlmfPNATZcwSNqvPwTJTu804LXEk1C40pG9YzyqRfQbNKHeR+s0yNc6QFREOdQ/L2RfzfT9IfPlAhGx51pQgR9b95w80Em7jMT3qtRorRjzT4wy8t+PQOfuS6QOEbenrcxLeYCK7v2+oIiAXBqMAWb6q1vTx33igY48RCFP0GL7lffOTOJ055qZIGFPgqwrCAIAlbrazDeesEeFt12k0IEzg47lweld6OsACwGpnT3sA84+v9HqFwxxNKwH0OhZ8FbgN/99OxSBP6rwVKD2AHVZmiQVFPRmsboqPp0IvkaMt4tatwl4H+rDaiJIvm/CHF2ulJ4FUj2An5w9yjheATnq5hznUkcE+fcfkcPXRlYT4JyMQkHP9k2N97g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(41300700001)(5660300002)(33656002)(52536014)(76116006)(8936002)(91956017)(26005)(8676002)(83380400001)(64756008)(4326008)(66446008)(86362001)(53546011)(478600001)(186003)(66556008)(38070700005)(66476007)(122000001)(66946007)(38100700002)(2906002)(6506007)(9686003)(71200400001)(55016003)(7696005)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?+7PgrgCeuCBkKEoiQrNPChCz8v4SIXIZHDqU3kkic25hiaEttPb79WSw?=
 =?Windows-1252?Q?AmQyvElUC5gobe8snp3ZmLKbEx51rFoX7kCKEUOXVcm7pYqh4S+ytf2b?=
 =?Windows-1252?Q?sBBHkU3USYU1XP803WAXcd1hPNcZattr1vFtlT3r5R8gklvH9uJsSWZM?=
 =?Windows-1252?Q?QLO89C/MSEArutoTgqo/fa3eJqhL3R9nu9cyzccPEIMJE0bdFIjXjuYl?=
 =?Windows-1252?Q?TkLGx0eMkoeRhZLKzTbrJghmDFlgOZ9Uamd56kQJw2G4cQY3FZ5K5Arj?=
 =?Windows-1252?Q?8DHCMIGMnkO46cuv1mRQvc2eRDPvDuNovwjAns4kIWvNQiUimobfhdUe?=
 =?Windows-1252?Q?lv94Xf3vhNM0ziegPSel/s/1Wq7UK+cQAgjjZ6HBq1VxajFb8xfzEYju?=
 =?Windows-1252?Q?nTtbn26JdzXJusZbti4x3HqgS+ZcxGrLQh0olTqNWi7gMZLTY4SrWinH?=
 =?Windows-1252?Q?WVB5PyNXYSyl/zNx+WEz4T0FYnoJPgO3hazZDqmiPK9gJKDtGhAhL0FD?=
 =?Windows-1252?Q?r5sJZe61jMeviBIFh+SEMlKGF54R91PbAkOYpAi1T/+om4V8f7Qvt9MO?=
 =?Windows-1252?Q?WBxUo5VDpSSj55Dzi4F6zyEFGTUX9JKSo++WRHGiizv/V13j2pq+lDOD?=
 =?Windows-1252?Q?YwMzdF98VOhjdXObqNaf3FYq2SBYuoz6DrBQII7HHakEGoxd7qHIo3oe?=
 =?Windows-1252?Q?7LtfL6Iig4wjLfkH9Bv63lFasHpS7OElIRnwvIKZYcZ2JYgyvU61DhQF?=
 =?Windows-1252?Q?vfOjGHUiGP2gLV1F5lWhRs2ddHjk2Zg5MH2zA6x1RPxrckcWIKH8s7fq?=
 =?Windows-1252?Q?uLhZh4+D/vkPoPmcnfgUAw/fjFgpqpcsb94GRLkWO+WP68MBlYGqyBcv?=
 =?Windows-1252?Q?eem28NxDRT0FGJ9g+RZAITUwLhCgMD953aR33RH1lkCuBtDAgwBDM/MK?=
 =?Windows-1252?Q?HluN29VmcilDgxCzx/nOA/gAS18F2vX4yoswTCiBoUjJVsqSE7N2RmEN?=
 =?Windows-1252?Q?ts/q+1x3tjKrwRdsUFz6mK2+8yIzYu2lyGj117maQnL0w9fkfp0dN5qh?=
 =?Windows-1252?Q?etfgwhoYn6RrYE45cUXDFXYSjjX5GV0IrfNiE3gPSE89RPESZlXcn31P?=
 =?Windows-1252?Q?8BCoeoAS7RUTTvxiT1UL0xh9uqnrGeUs5pim886/Jo7JSaCDVP04OHWy?=
 =?Windows-1252?Q?OIHwL3Pb2SzDkMA5JviJOPZqZqIrZ7qjOVuPpx6w6uGRCA8CGwzfqtQK?=
 =?Windows-1252?Q?Uy7DZad3sLiDkxlOy2PQHSfMeWzCo3H/9NC4NxOQtewBIIxvi/orCD9O?=
 =?Windows-1252?Q?rntyviYPfcSVasfVS3F9lm3WT4xTbswGfPUi37xhyBT3/OYpg2563sJq?=
 =?Windows-1252?Q?T9oqiyNC4eXCDqdtN0reGD26LED0Fr+ZzHD463+bkSXZvxFSzLAqE6jD?=
 =?Windows-1252?Q?9W9Le3pNRGgZfW76o4/KGYPE3spXj0wHLgbElBmvJZBlYQ+mhZZZTRy1?=
 =?Windows-1252?Q?qq+AzawSP5shp7zlzBjGfuBr8taWDDniKSLp6OOqKR/YPqsMQdvyoqau?=
 =?Windows-1252?Q?qyNbc5NGEvF33TZADI+YYF0SniCA/1fg/Q9T4X7sJ2iJ9Dea+nsTTZim?=
 =?Windows-1252?Q?IqOHLn/TjzGdY3psgoyRr0uM/OEYzREWInh1W73Bu7p2zTXVTwLGU26/?=
 =?Windows-1252?Q?kaMCIUcOhSZK1AL6ezddzd0Mrpb1TFyQS8Gh/6uvGS7zfgOtr7zjOA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257F80C5B9E967E0443FDF7FC439BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791de180-af59-4cf7-8c3c-08da92121f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 03:19:35.9799 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvLygU90oHyyvYRG1LxMFUeUxiLYwETS0CuUu2Nr25CGyoHcze/FqURdiXWwHTV5OcZM7qiqWFlEH/EkFY2nRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257F80C5B9E967E0443FDF7FC439BN9PR12MB5257namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Let=92s create a new macro PSP_TMR_ALIGNMENT in case we need to support ASI=
C specific TMR alignment in future.

Regards,
Hawking
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Date: Friday, September 9, 2022 at 11:14
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>, Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: change the alignment size of TMR BO to 1M
align TMR BO size TO tmr size is not necessary,
modify the size to 1M to avoid re-create BO fail
when serious VRAM fragmentation.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index cfcaf890a6a1..5585cda8d24b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)
         }

         pptr =3D amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
-       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE(p=
sp->adev),
+       ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, SZ_1M,
                                       AMDGPU_GEM_DOMAIN_VRAM,
                                       &psp->tmr_bo, &psp->tmr_mc_addr, ppt=
r);

--
2.25.1

--_000_BN9PR12MB5257F80C5B9E967E0443FDF7FC439BN9PR12MB5257namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Let=92s create a ne=
w macro PSP_TMR_ALIGNMENT in case we need to support ASIC specific TMR alig=
nment in future.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Wang, Yang(Kevin) &=
lt;KevinYang.Wang@amd.com&gt;<br>
<b>Date: </b>Friday, September 9, 2022 at 11:14<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: change the alignment size of TMR BO to =
1M<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">align TMR BO size TO tmr size is not necessary,<br>
modify the size to 1M to avoid re-create BO fail<br>
when serious VRAM fragmentation.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index cfcaf890a6a1..5585cda8d24b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -766,7 +766,7 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pptr =3D amdgpu_sriov_vf(p=
sp-&gt;adev) ? &amp;tmr_buf : NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, tmr_size, PSP_TMR_SIZE(psp-&gt;adev),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, tmr_size, SZ_1M,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, pptr);<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257F80C5B9E967E0443FDF7FC439BN9PR12MB5257namp_--
