Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15D8C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Nov 2022 01:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD4410E051;
	Sat, 19 Nov 2022 01:55:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C90810E051
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Nov 2022 01:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXj1Scw5ZSrjho+C5T5jZ1+bYbwRIDg+NbIifmQvsgq3zFzU8fQHYL0omU/b9hyZY8rKpm2W3fZVlTJIKGJ0Ef+7FcDeuC8Rm/0LhDAcg9WoO/AO6o+SBMePVWUX9gUuR7LUMjhJyzMId9hbiAoZsF6feecWWTsWGeYDM0F2rS2Xz4spkB80FXmboTNdXpqXfWjdtoqmz1cgME3O8O458Q7KRi7R47GNXKVqn2WeXAW7L3ergMMtB4KNwfCDFdz6yZZk7UZm5eMNUbLLXNlsQQcsycWymxVW9oK96ba+85nQ3sPTz5hxU4k337G7A4imfPGh4uByyfsB8z4nMMfb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzCZJio0/hMKGIEyvhbYF/fSOuBxzLxhbu/brR0a+p0=;
 b=b/WzRUeVByWOXriQO9egADLTK0xYH/owzNwDNNneKw1x4RXJ9rgzpjE/fWZRDiI7Awsq6QR3HYbdBDy2d3MoFQ5OS997aGzjr938/kKPEM9By5pWhfAVy97jvKhrrgxk1T5eNXuB6q6S5Xo54TKP7JECM1JukyTF916BHoA/kskbTOC82IbB0HHpGRu3pb88vi3kkYpyx+SQhJRwWQHlxdFz8LaHkyGja8p57bVk3LjP869/4dSeh/JZOq85CFhkb7J3JiSYEU6bcUOlEOjlgpwdoW6ephSU/BN0V3uWbfaGd1EETf6svmN0QRQ7wBVjSMsvDIbGEoQgMYJwAuWjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzCZJio0/hMKGIEyvhbYF/fSOuBxzLxhbu/brR0a+p0=;
 b=vJbkqmNkLEAoxThmIfbKyNPoQCDc+8IBZPOWi8xAYrT63PD0fEI540jNXWyfPzmooQUUu1YIp06YWdpcprMKJWG1WXLH92CLTVeFkgtpOqIMBDTUWG2wt4qxccxRuMI88pFOWkN4DKPNEijVG8TJeOT+wwRiDrDgArWQ3j0430w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 01:55:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::22d5:676b:e089:b677%8]) with mapi id 15.20.5813.018; Sat, 19 Nov 2022
 01:55:30 +0000
From: "Chang, Brian" <Brian.Chang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 22/22] SWDEV-1 - dc: 3.2.213
Thread-Topic: [PATCH 22/22] SWDEV-1 - dc: 3.2.213
Thread-Index: AQHY+4ok7tWQpdhrEECP7ifDDphS365FfOCF
Date: Sat, 19 Nov 2022 01:55:30 +0000
Message-ID: <BN9PR12MB5257BB4C90711BC4B764182FE6089@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
 <20221118125935.4013669-23-Brian.Chang@amd.com>
 <CADnq5_NuC1imDa9kRdr2fKY3HFdC7huMNhnW4_SB0FNs=JEyqA@mail.gmail.com>
In-Reply-To: <CADnq5_NuC1imDa9kRdr2fKY3HFdC7huMNhnW4_SB0FNs=JEyqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-19T01:55:19.0655581Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7659:EE_
x-ms-office365-filtering-correlation-id: 2494c6aa-5e6d-49d8-4b48-08dac9d12323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iivp2zXPrT0e0YPmEbK+QLvS9sJZ+plfsNS70+59i7R1aelzrDRnPsEwABlatbiXB/iMWyherjcMEGJNHp883yGxvD4kehXJQHCAYO5+JFxwp5EqMO4T4aBkvp0OPFTuwZKEWRRYdkxIGm6lfIhutA8+p9Wlgp/9DjR3Y+WUfGTKIzIeRSBdBrGAVuUSqu+P7jRx0u4nsE6smdljpzD4TKX8S/O2yLlAjEFm9zpmbE+uiOjgKQuwFyHIGLONE5lZy5ENTC8Nphxo20HGRH9R4J04KSr+doejm70vXjNG+bIHls0uEvtMBW4jPhuuzypoCn6dpfn/1ZI9LAvczQTWklFhlJg0vJgTC+LuaECEaMPkcd4vw3cyAoUgPFfbh09ohEtZ/b7QbcxNatuahxNoeqho8ZH3DgmmQd35zYxWjEmgxd0ZP3BALbKZA4HlK0uAPD3yGhpaww6AtWYlZOiqA654ZXeWDC2eyI2E9T9gpW7mI1xwIvmim2RhYa7q8cXkwfZf0jl/D7gFv/Rgl0UL5QcA2LWqrqQEupCdXR6WrIx9TulFL+Uy5v4PuykD1jWXPnVL6R8R+XlbL6/7rXNLiVepIjAkf3iJ2DkJyoHVpHjo42JEIAh5TlxyBMHRVKfcN1OQxj9+1j9FllIf6CCNZE7Fs1yxT+xqNufOWiHGi0/pdkgog7aY1ESmAdXcSOMF6g6ayMb0N0Et6qReeVgIJ8GKLi3Jm/CuS4WSXUukWWI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(186003)(122000001)(166002)(2906002)(5660300002)(83380400001)(38100700002)(52536014)(8936002)(55016003)(45080400002)(478600001)(6506007)(71200400001)(7696005)(38070700005)(53546011)(9686003)(26005)(8676002)(64756008)(76116006)(91956017)(66556008)(4326008)(66446008)(41300700001)(66476007)(66946007)(6916009)(54906003)(316002)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qssSvWusW2rgaYMoqRDtkw4w9zfjUKXPdOUjbr31nUEpnoi5iJ6r7/Ic7pRW?=
 =?us-ascii?Q?ugZ73+DwTVQr+0bkLKdbXTRYB7gd8YO2l90V+k3gs9x6i+eoQbH5VzDv0NNa?=
 =?us-ascii?Q?X8IFaLsP8AWK2uUGRl+Ld3ojf0ao6ObQXIhCapo4FrTBTvN8xV/uXb0EKUq6?=
 =?us-ascii?Q?mKz9tHNzn+wyaOtCy8xE+2viwBEJLOe9vRuoH4Zl8FW7ccdTTu94wVlyhEdK?=
 =?us-ascii?Q?cN3bvquMwp6jlEjKY0pH2xpjlTkk0In9IzXfUv0oRLQd2XR+hW5nwXIL5ZBB?=
 =?us-ascii?Q?QFo936zc0KMGz4KG0jWIyLRDjZ4d/CwTlhblyVixFuAzIxG817fBiwsIwSW0?=
 =?us-ascii?Q?Vl4s+GXB9WqHbXfQmG21AY+D+p1D2Ay7q9bU1kUfhDiQXFVuW3KNo4aLjRnq?=
 =?us-ascii?Q?P1FZlasq++aOJrtzi7F1c6r64kiWChVPklAY+R6HNg8FTmUSDRHGRLFqMXlt?=
 =?us-ascii?Q?KPAl8etdiM2+kuJhhS41x0ooIpK5bJXF20oslvc+gIXLH5lO79YSsWAHZI3j?=
 =?us-ascii?Q?nrzu/ucuurq2o/j9eporpLw3wBwiGfARE0t00Er/E7xbC4YKLi6QXXb2om14?=
 =?us-ascii?Q?sVgY7xityoFjb63s3wGDs7Wy6WHDV156El4Unp8NeV8HjPqdRpTIdcKC7Anm?=
 =?us-ascii?Q?Nm/G0/ydmTkgajF4vsAQwAiXiB2cd0KwDT4MWxmRKvUXna/JzL4E19Q+PdMz?=
 =?us-ascii?Q?fLCedKLOqhFeInuOxZw/aBL++IdzHphELp9faV5PLLCxOU+QVKygytpau+Rz?=
 =?us-ascii?Q?+4qQqxK2hj32EpUn/uKI1YHXQErlSLxp7s6Of6KmvCVvac0RQKWhERcb7zmA?=
 =?us-ascii?Q?8bvZjlJGj5mg9rUzfOs2D3zO4sYTta8iHv3vDjgIpB9NVCgYVnfPb8EDt6YW?=
 =?us-ascii?Q?e/1DhYUkHNUt3gRcMktOeB08emQmKZBgOR04IdEmpjk7BGLjnKjXQGc4yGFl?=
 =?us-ascii?Q?StKiD3Ov3O89R7fdv8o5YRwZxdQ3KWfdLR8WYFTws7pd8TLOiIYt2Oy2NGqr?=
 =?us-ascii?Q?iV7zvH/l9usFJiTb8H4Yl8zpzCFlJUWXAPYJzocqllhHrT6sQC67GlscXmH+?=
 =?us-ascii?Q?A1NqVTyRKaHNj+U8Lkjpbu/hKjffYMwEU216wp3/nGnMK+c9g78oR2uvlsH8?=
 =?us-ascii?Q?QbIImbDu3xToDwmdBrI2+i2LECFXpXeBZeGaXGT4tQ5I0BnuzaXHJkZqVpDp?=
 =?us-ascii?Q?al6Skp+3DOiuLqtll/MW+0J0QGzqRBdNeUEq9P1qevWXt60QPfW43K69KYoj?=
 =?us-ascii?Q?beGkoD+8Wqotn/M5MI54bkY0k7Gj0AgI/063iTeYQuvyg2y0SGLOBObRV5Nd?=
 =?us-ascii?Q?FgLGabtc79J4WFKwpei3SuAfbMPna/A3C1FZ5XUBZfP69bsJM/ivIY7UaRJy?=
 =?us-ascii?Q?SN6tpBOx7CbckcH6LhB+jGdK8JZW0+RIcsi9Jf/3lIjaZkE7MJU6EhBjjFO6?=
 =?us-ascii?Q?kFtqHlrpbmJPJDTmqbiR3YX1Tu6vTnnztYsU6yrwyB94KoP6NQsbtJ+opy4u?=
 =?us-ascii?Q?lQ36t/+4mc3Y4y/5ic5alKW7pcgKJOKaNNd2h5CBu/NjyjcvCgAsFpGCmn3I?=
 =?us-ascii?Q?xlfLtKGG3/qvKqmZ9LxUp4q8R3ld0EoJwrycFQ4R?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257BB4C90711BC4B764182FE6089BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2494c6aa-5e6d-49d8-4b48-08dac9d12323
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 01:55:30.0584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYpoKroEO3bYa88ZKzHpx/XGVnGZhQtxLVlZKQ3oRh0exSyBPgCQq1OAw09HwlQFbA8bF6CvLXUcgJ20vpm+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659
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
Cc: "Wang,
 Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257BB4C90711BC4B764182FE6089BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Ok

Get Outlook for Android<https://aka.ms/AAb9ysg>
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Saturday, November 19, 2022 4:12:38 AM
To: Chang, Brian <Brian.Chang@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wang, Ch=
ao-kai (Stylon) <Stylon.Wang@amd.com>; Cyr, Aric <Aric.Cyr@amd.com>; Li, Su=
n peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodr=
igo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon=
.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <W=
ayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierre=
z, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.c=
om>
Subject: Re: [PATCH 22/22] SWDEV-1 - dc: 3.2.213

Please fix the subject.  E.g., drm/amd/display: dc: 3.2.213
or something like that.

On Fri, Nov 18, 2022 at 12:02 PM brichang <Brian.Chang@amd.com> wrote:
>
> From: Aric Cyr <Aric.Cyr@amd.com>
>
> Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
>
> This version brings along following fixes:
> -Add configuration 2 for ABM 2.3/2.4.
> -Add margin for HUBP for SubVp + DRR.
> -Fix no display after resume from WB/CB.
> -Limit HW cursor size to be less than 64 x 64 bytes when the stream is >=
=3D 4K.
> -Lower watermarks for enter/enter+exit latency.
> -Update support types for DCN314 to include z8 only and z8_z10 only state=
.
> -Add new value for soc bounding box and dummy pstate.
> -Override fclk chang latency when calculating prefetch schedule for subvp=
 with low uclk.
> -Add check for DET fetch latency for dcn32.
> -Add check if PSR enabled when entering MALL.
> -Use base MALL allocation size calculations off vewport height.
> -Add YCBCR2020 to CSC matrix.
> -Implement DP-Tx portion to interact with DPIA.
> -Add debug option for increasing phantom lines.
> -Fix phantom plane/stream retain after fail validation.
> -Fix display corruption with VSR enable.
> -Set valid divider value for virtual and FRL/DP2.
> -Add new num clk levels struct for max mclk index.
> -Fix check for phantom BPP.
> -Fix rotated cursor offset calculation.
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index e827cee94e5e..feb7a7f2734e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -47,7 +47,7 @@ struct aux_payload;
>  struct set_config_cmd_payload;
>  struct dmub_notification;
>
> -#define DC_VER "3.2.212"
> +#define DC_VER "3.2.213"
>
>  #define MAX_SURFACES 3
>  #define MAX_PLANES 6
> --
> 2.25.1
>

--_000_BN9PR12MB5257BB4C90711BC4B764182FE6089BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>Ok
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Get <a href=3D"https:/=
/aka.ms/AAb9ysg">
Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Saturday, November 19, 2022 4:12:38 AM<br>
<b>To:</b> Chang, Brian &lt;Brian.Chang@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Cyr, Aric &lt;Ari=
c.Cyr@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland,=
 Harry &lt;Harry.Wentland@amd.com&gt;; Zhuo, Qingqing (Lillian)
 &lt;Qingqing.Zhuo@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.=
com&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu=
@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lin, Wayn=
e &lt;Wayne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.c=
om&gt;;
 Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;P=
avle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 22/22] SWDEV-1 - dc: 3.2.213</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Please fix the subject.&nbsp; E.g., drm/amd/displa=
y: dc: 3.2.213<br>
or something like that.<br>
<br>
On Fri, Nov 18, 2022 at 12:02 PM brichang &lt;Brian.Chang@amd.com&gt; wrote=
:<br>
&gt;<br>
&gt; From: Aric Cyr &lt;Aric.Cyr@amd.com&gt;<br>
&gt;<br>
&gt; Signed-off-by: Aric Cyr &lt;Aric.Cyr@amd.com&gt;<br>
&gt;<br>
&gt; This version brings along following fixes:<br>
&gt; -Add configuration 2 for ABM 2.3/2.4.<br>
&gt; -Add margin for HUBP for SubVp + DRR.<br>
&gt; -Fix no display after resume from WB/CB.<br>
&gt; -Limit HW cursor size to be less than 64 x 64 bytes when the stream is=
 &gt;=3D 4K.<br>
&gt; -Lower watermarks for enter/enter+exit latency.<br>
&gt; -Update support types for DCN314 to include z8 only and z8_z10 only st=
ate.<br>
&gt; -Add new value for soc bounding box and dummy pstate.<br>
&gt; -Override fclk chang latency when calculating prefetch schedule for su=
bvp with low uclk.<br>
&gt; -Add check for DET fetch latency for dcn32.<br>
&gt; -Add check if PSR enabled when entering MALL.<br>
&gt; -Use base MALL allocation size calculations off vewport height.<br>
&gt; -Add YCBCR2020 to CSC matrix.<br>
&gt; -Implement DP-Tx portion to interact with DPIA.<br>
&gt; -Add debug option for increasing phantom lines.<br>
&gt; -Fix phantom plane/stream retain after fail validation.<br>
&gt; -Fix display corruption with VSR enable.<br>
&gt; -Set valid divider value for virtual and FRL/DP2.<br>
&gt; -Add new num clk levels struct for max mclk index.<br>
&gt; -Fix check for phantom BPP.<br>
&gt; -Fix rotated cursor offset calculation.<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dc.h | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd=
/display/dc/dc.h<br>
&gt; index e827cee94e5e..feb7a7f2734e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dc.h<br>
&gt; @@ -47,7 +47,7 @@ struct aux_payload;<br>
&gt;&nbsp; struct set_config_cmd_payload;<br>
&gt;&nbsp; struct dmub_notification;<br>
&gt;<br>
&gt; -#define DC_VER &quot;3.2.212&quot;<br>
&gt; +#define DC_VER &quot;3.2.213&quot;<br>
&gt;<br>
&gt;&nbsp; #define MAX_SURFACES 3<br>
&gt;&nbsp; #define MAX_PLANES 6<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB5257BB4C90711BC4B764182FE6089BN9PR12MB5257namp_--
