Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE41C5DF8C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 02:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 308A810E04C;
	Mon, 24 Aug 2026 02:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ye+oGENl";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640010E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 02:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHLHsKqOPPZ87aek7JTicnePmj6UUkeNWegdfap8qiWJGl6zgFOhvSo66u2PgvVIEg/QFzBEOkwEZ+VjHAr27Y5O8zwXF15v/OTkHNdadMFZ9j0nY/c4t0zfORGGQU21iaNEUWILxI7k0nVm8QQHN8yy4Bx+Z4mQcgWO0oQJzA/GzHIHD3Uo203+zvWWW/0MMZHRz2rIQRog4co0qB+BiIix/yAbGnkATfs/KXOm7wGoqeGtiWwcPsibxuv5bjDWVs5AH+gudEi/HPIk6/NDgbFI03hH5X33gtOyBaS3OzKG1KXOkoUJGjQoaGp9nDd6D3tpxE3vTSVOZIhfCFif0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD9kDQxQWTlKtLS2NIvJqZNOM6TIEliZB0srjSHyE2Q=;
 b=FGsxbIDooEAQ93kGRP4PRGU0SV8Ji8inOCK95araHoxirGFqYutGtc4Z41THfkt7VPggr/i9U/q9H+8543IEyR/m1s3neQV1Z7AI3QEOXAevaN51UcnWtRQaMiOFycWqFnJmAOjlO0l9HjemGYfNXRw/nE/A2F8QFWIoeWrqULTrGZDcATVBrUAGiGmfjhEIc2LKwRsBsi43xuFwckIrYCsXACpJnDEAJ+hw37rlxg9XwkFJ616j5BmJ2s0pkd95vR4IV8qjs+pm6lJgXhci1nxFPTdfWQbcjBhDeN9vEyY4hCtX5TqByRZ8SG101MtfahKBU014YOiC+miDq3JkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD9kDQxQWTlKtLS2NIvJqZNOM6TIEliZB0srjSHyE2Q=;
 b=ye+oGENliXd65MGcA/ZRKJAl0N6qkxuK7MgQs79R9CAoHe7lcSnGOy8h1AgHr3XzdyooTpg1rILyaY6qbNWt4lHWQdWBHy4B9d0614u5hdRNmK+kuJJTQzZvIelaDmvaqS8Rms0pyhmKTHB4IZu2RNE21fU0DSAyecWz9lovMO0=
Received: from CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 02:54:25 +0000
Received: from CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac]) by CY5PR12MB6345.namprd12.prod.outlook.com
 ([fe80::76ea:5e0e:c170:5dac%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:54:25 +0000
From: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
 control
Thread-Topic: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
 control
Thread-Index: AQHdMiC+JQREhAf/CUWELlkFHY3ZJ7asf+EAgAADPnA=
Date: Mon, 24 Aug 2026 02:54:25 +0000
Message-ID: <CY5PR12MB634519AC2518433F688B2C21FAA02@CY5PR12MB6345.namprd12.prod.outlook.com>
References: <20260822102609.84913-1-xiang.liu@amd.com>
 <CYYPR12MB87297410AD7E8695546DF551B0A02@CYYPR12MB8729.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB87297410AD7E8695546DF551B0A02@CYYPR12MB8729.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-24T02:54:24.897Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6345:EE_|SJ2PR12MB8133:EE_
x-ms-office365-filtering-correlation-id: f6014d9d-82d2-4e04-44a5-08df018b01e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10086099003|22082099003|18002099003|18092099006|5023799004|11063799006|8096899003|38070700021|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: ufcsh2MSOjClGaynmQpp5vGloNKg63Hl2rexcA5IypxxBzFSteZCjsDpUTcbWZtqcu+Vmhe6GRBf9HK1mX7vFr3gaBkoVzPnMgxXNe8UL/OKkJeuwdNOoYiQL3H1x33qJkS98JUFdc97FbF8LwCyjJgrXvLZItTF1xl66V3KA7qznHNhmWnEsBO7nE6+XGqoCktdmTlqxhpHZE/GtPYUjJB+gEC8lmwfWX/+Jn+p5L/cM6812WM18DfmOoPcsstPSRdMUqPLaNd62Rgzv+p2VWs7B19T/d55lb4PMAAfGeWzkwW3NhexiTAQ4sG3RgGF+imQcl8KrbGIK4QtFcbuQeFPHjc8XNNq7LsuKjh72JXE/NZrvQDRrhraYMNz2yvku9VD7jIF8AMM4OjOWxxlW0bcgtD8J2iALuKVbKkRxcexxgsZE5IiZ/ppWIKnddLU0U7/8Z7eYzNOsIHANdUozLOSlomqEp+ZsGd5teGfplf5eRdsN3SF3WCn/RYsVDpMguGGXFn5UeTGWMxu70ie8EpqLzDt3E3ngFilAd13nNUk0T039piikFgV8LLEE0BdqWKMGtjFh4hv59nEYIMVzoyiK8gsPIdIF3aKnoxRBUZCd31dvWsuEJVnSxT8Ru1TClLHrKP9EPQWOPjSahlBCJEumJo5tIkX8RTA72QRwHrIDPoFTs099r4/1EV29VpKeQhS4EHm7JG6Sog/lloKPTiw7lRNIAkXMiymhI/V3Rk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6345.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10086099003)(22082099003)(18002099003)(18092099006)(5023799004)(11063799006)(8096899003)(38070700021)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wiWTvpjGabW2nD4K7R1lP/2SFdBdG56EY8/pe+4b/eGQrV9GiH5R1td1P+JU?=
 =?us-ascii?Q?fWPYFWZ4tUsKFN1nYHhTgiTba4Xga4ArBuANQR+URlu3HJBOljtsJn0iyC23?=
 =?us-ascii?Q?ktC8fO69tzOb7gFTFhfuMu/HGZgaMAXvvADDHN1KRdhVmlWald923ZqNOAbo?=
 =?us-ascii?Q?ajadPvMeioxqmKOuJn6HyIbm6a88urX3EjtXsTeFcusgUmtjTIrkASwJVYqm?=
 =?us-ascii?Q?axSRz24js3v+qW/zpinh92eZkrBClqvR/qFTes89dx3lBsaXa3j7kx5nu4s5?=
 =?us-ascii?Q?w7EE+bAs3WJBm9S6/DI5tZOm7jmi051NI7VaepSIO2JH+IpSKfhVCbUwhSR5?=
 =?us-ascii?Q?FX0fyhVQGj7MsfjXwANi9Yz5jd1sy5Yfbi3WlKMev2g62YgP8NVI0XdaI0Jz?=
 =?us-ascii?Q?gb/c6IUZ7/cUv+ctF6oLFKq3FFon7KiF6S1PWWjPYW+29hCc2tj+RALarlUU?=
 =?us-ascii?Q?dWH+MZcuU3cdOhx7A9fH+C8DXx1wquMqwJPOlbQm4F4JnsdaE2u2LIW2TXY+?=
 =?us-ascii?Q?UcXryR2IvppY2GbCHWF9GxuAlv/dv+Li4JxmUK6vMbz8gMJbHUeWbrqVRBlT?=
 =?us-ascii?Q?X0igFdk/8ao4QdO7EnTzvA+eR8TPnr3X56oXwrBDplnJYhu8toMyNI5Izt7m?=
 =?us-ascii?Q?9tjx6fM5q1pwaaKcJXRyuvjHYq6tum5vuNNWGIXoSY3gWEEsL+j4sUiheBhh?=
 =?us-ascii?Q?p+87aH7VaWUib1LZ0tYG3I2xZ69ne3cjOPJkU7gBKROt+KSPBgg4nd8hr7FC?=
 =?us-ascii?Q?T6EAP/K9Va+M2rzbY4BDTM8nG8OknegwDBb/lmuNV9AsnMI2l2hUT2FeCnz6?=
 =?us-ascii?Q?jwYtVL/chjBvTSWUJMZt8bZPslq/ovpHGplj5ytYWHTBRkHxX/kAa2bFuNra?=
 =?us-ascii?Q?Chdw3Ty+L4UjyUZmkER9bM6x8Sg89Mk2LVVNtZRcpSEBUoxIaFaV9bL8VUYw?=
 =?us-ascii?Q?OZ9+FOiJq97mhmkWVLAUgy0WAYNTo15kC3/v18IiarAhW4SmFIAQ2znuw2TO?=
 =?us-ascii?Q?F8QbGuKS/gkCkctdozN4ukKDi2P9umAQDEXMa+oLwBxxACO9Yjk5yZGsxwSb?=
 =?us-ascii?Q?rMd5touLjp4UQMpM9+vIQFd9LPOQ26eSgeFBlOh6sjKm8PGGeeU9lggkxJot?=
 =?us-ascii?Q?ufOVki3To/GTiFllngIh4SD+dsTF3WXXN5kb+NZqFnWOn0bG/gmGyn2wdxb3?=
 =?us-ascii?Q?6p2xOEr+YYF+Bu96yAuOhg5CBtwLL/iDheuOTmVe3sYjXVefR7dNXayPLt+1?=
 =?us-ascii?Q?rihGhk2v7zx6RQaRXeFzz7i/x7exBhVJBM+buunVTUWtZb80dDJ8mNhTA+YB?=
 =?us-ascii?Q?sCVGNYD4YGwk4IWrFM2jc8DcaHFXjLrpXQodpCpmh0LaI8SzENP97LllK/c9?=
 =?us-ascii?Q?NKNkr3jdTr9mHh1bBbF0gLKsExDHFpUQjHTgXYdxPD4Z6TnI67rsgrVo89kb?=
 =?us-ascii?Q?WFr0mzLNQQbqRToklAD+z6fQDXRf3dxVZr6isGVJltknwa4RHlHDKKH54wEX?=
 =?us-ascii?Q?mN04QBjyrRznKbUpSyId0lYoC8zxStZ0igKktJF5wyMtzCpe8JacWiCP6+1O?=
 =?us-ascii?Q?BR8T3tkDSfnprSkrh8rurwCKec3znV30jw8dosWSD3fN9Z2efmFVsxxQ37wA?=
 =?us-ascii?Q?X4cpinLsqZU5DyECCDRcDDkhL5dH7/UQTjBzGdqmGONcKwlhK7ozOH0bqXAG?=
 =?us-ascii?Q?PTtRq1ja8QAoan96iKEzEv0CaUJwaYUySI6pIKRVLcmdO3W6?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB634519AC2518433F688B2C21FAA02CY5PR12MB6345namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6345.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6014d9d-82d2-4e04-44a5-08df018b01e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 02:54:25.3847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBI2SEtWE8fwsO5oX9f+Lh+yyBwncie5kJN3vu/ihoanSFHpqllT2ihYWO83vNe9ulC8Jk/BecYxrd6uwtjJ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

--_000_CY5PR12MB634519AC2518433F688B2C21FAA02CY5PR12MB6345namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Sure, will improve it.

Best Regards,

Liu, Xiang

________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, August 24, 2026 10:41 AM
To: Liu, Xiang(Dean) <Xiang.Liu@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mod=
e control

AMD General

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Saturday, August 22, 2026 6:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mode
> control
>
> ras_mp1_set_debug_mode() reports -EOPNOTSUPP where the control does not
> exist, an SR-IOV guest among them. Treating that as fatal fails
> ras_core_sw_init() and takes RAS down on every VF.
>
> Nothing else in the MP1 block depends on it, so carry on.
[Tao] you can also add this explanation as code comment, anyway, the series=
 is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras_mp1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> index 2452448806f6..781faf6a7529 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
> @@ -203,12 +203,12 @@ int ras_mp1_sw_init(struct ras_core_context *ras_co=
re)
>       mutex_init(&mp1->op_mutex);
>
>       ret =3D ras_mp1_set_debug_mode(ras_core, false);
> -     if (ret) {
> +     if (ret && ret !=3D -EOPNOTSUPP) {
>               mutex_destroy(&mp1->op_mutex);
>               return ret;
>       }
>
> -     return ret;
> +     return 0;
>  }
>
>  int ras_mp1_sw_fini(struct ras_core_context *ras_core)
> --
> 2.34.1


--_000_CY5PR12MB634519AC2518433F688B2C21FAA02CY5PR12MB6345namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Calibri, He=
lvetica, sans-serif; font-size: 11pt; color: black;">
Sure, will improve it.</div>
<p class=3D"elementToProof" style=3D"direction: ltr; text-align: left; text=
-indent: 0px; background-color: white; margin-top: 0px; margin-bottom: 0px;=
">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: black;">Best Regards,</span></p>
<p class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; ba=
ckground-color: white; margin-top: 0px; margin-bottom: 0px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt=
; color: rgb(36, 36, 36);">Liu, Xiang</span></p>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhou1, Tao &lt;Tao.Zh=
ou1@amd.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2026 10:41 AM<br>
<b>To:</b> Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yang, Stanley &lt;=
Stanley.Yang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA de=
bug mode control</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">AMD General<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt;<br>
&gt; Sent: Saturday, August 22, 2026 6:26 PM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao<br>
&gt; &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;;=
 Chai, Thomas<br>
&gt; &lt;YiPeng.Chai@amd.com&gt;; Liu, Xiang(Dean) &lt;Xiang.Liu@amd.com&gt=
;<br>
&gt; Subject: [PATCH 1/2] drm/amd/ras: tolerate an unsupported MCA debug mo=
de<br>
&gt; control<br>
&gt;<br>
&gt; ras_mp1_set_debug_mode() reports -EOPNOTSUPP where the control does no=
t<br>
&gt; exist, an SR-IOV guest among them. Treating that as fatal fails<br>
&gt; ras_core_sw_init() and takes RAS down on every VF.<br>
&gt;<br>
&gt; Nothing else in the MP1 block depends on it, so carry on.<br>
[Tao] you can also add this explanation as code comment, anyway, the series=
 is:<br>
<br>
Reviewed-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
<br>
&gt;<br>
&gt; Signed-off-by: Xiang Liu &lt;xiang.liu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/ras/core/ras_mp1.c | 4 ++--<br>
&gt;&nbsp; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c<br>
&gt; b/drivers/gpu/drm/amd/ras/core/ras_mp1.c<br>
&gt; index 2452448806f6..781faf6a7529 100644<br>
&gt; --- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c<br>
&gt; +++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c<br>
&gt; @@ -203,12 +203,12 @@ int ras_mp1_sw_init(struct ras_core_context *ras=
_core)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;mp1-&gt;op_mutex);=
<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D ras_mp1_set_debug_mode(ras=
_core, false);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret &amp;&amp; ret !=3D -EOPNOTSUPP) {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; mutex_destroy(&amp;mp1-&gt;op_mutex);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; int ras_mp1_sw_fini(struct ras_core_context *ras_core)<br>
&gt; --<br>
&gt; 2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB634519AC2518433F688B2C21FAA02CY5PR12MB6345namp_--
