Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22D9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 16:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432416FA56;
	Wed,  8 Dec 2021 16:00:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA0E7359C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 16:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcZMQo9fJRQeVEcbEyr38E+7FKMOwFk8a0wKny07k8wfSj8Daq7GBN5d3bnaEGJx3B84VXDHa/UKPncxsSXdoVGncaqsoZnwXeGWPZonsX8kgAOsQs73eyiEpUocvpCEDStCY8Q5UBT6y6dKyr09xCswDJviOPUtwczgUMqL+xsjW9cDf3KWVsP8wsw8ovSDbKdKIfoNPxy0buxHfqpt19Ci28Z85BH5XUypf463dlqJXfwakNexSkfgdeNC+XpbsOOfpp6hVkhKcXoUWlV3Jq9Fjkz9m7ARPiNnTkLJYWu6QpSOFzt/G5THpCnv3PWH7m3LmQ+Ut+BQRb4jmLGdZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr/7xtDxLfYZLUEuSpxEK4fCK5S63a+ylWz15MuGz5s=;
 b=HO847g+ZvOzyArC7tB+Mtrg4d2gTNsX81tVdLhlo3GVK608Dvtap2GKVbsEoOT9xpj3SAPM2ZD0CHHz3iaUJgRW7C8vWhYRcs152s6vJzjbjukYAGTS8B0+rUyx2j1h3qlyqJ5lDwi+555GWu50P7kSiCBqacgbk1ujOI0veKJNR7gcZfadCVO9KcLSCB03hJygZLmNWCtjBEi8CSE32/YS6HF/BJZytvnrVVceOowSe2w3K5ZeQ6+BoNkbdFnGQmhnYXmIoGMu5mlTG2Yxjx/kzNH/ZhVOb5zLHm7LVrEdbL5/ahGYLiQn81WQ/b8/JU12kHplSl6RHwVB3vkZ/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wr/7xtDxLfYZLUEuSpxEK4fCK5S63a+ylWz15MuGz5s=;
 b=0kGjgDDYoWPuiT5hc+Kuud1eC8zUhy6xL8vJF8PlmXZHG8G0K/tWQOScjBav44QK54sxq7qcmBWA2BpPfQ197qbGwkwrWsOgPkBHbbPj8lHii30Xy6/lR/IBTtpxxrcVHlomU809HBbw2IsKWJb1ISZpra0I+SLfjs1EPf9X0/4=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Wed, 8 Dec
 2021 16:00:41 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b%9]) with mapi id 15.20.4778.012; Wed, 8 Dec 2021
 16:00:41 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Isabella
 Basso <isabbasso@riseup.net>
Subject: Re: [PATCH] drm/amd/display: fix a missing prototype warning in DCN303
Thread-Topic: [PATCH] drm/amd/display: fix a missing prototype warning in
 DCN303
Thread-Index: AQHX66FVaa+kh+eVRE2Ao+13REt/P6wotjuAgAAH/h4=
Date: Wed, 8 Dec 2021 16:00:41 +0000
Message-ID: <CH0PR12MB5284EC1FDF4A0500436C432A8B6F9@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20211207191825.2463733-1-aurabindo.pillai@amd.com>
 <8e27923b-bc18-09fe-c7a6-82f70f33f57b@amd.com>
In-Reply-To: <8e27923b-bc18-09fe-c7a6-82f70f33f57b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T16:00:40.690Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 153f0a51-1d48-f74f-0c62-583cf3c32060
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ef25454-c5ae-4a5c-13e9-08d9ba63e29e
x-ms-traffictypediagnostic: CH0PR12MB5347:EE_
x-microsoft-antispam-prvs: <CH0PR12MB53472B6943A872204A4F07B88B6F9@CH0PR12MB5347.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:93;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hHq609DMGhfCfpUofTtsgI5cByAdYXqgZpSp1UIYbOjh1T1ALOF+B8jyOp4uufx02Km/srka3O/AIfgOBcTaUBy8AsX98sEN3XvUyfQ4371jqHFtSWiO9ihs1BUV/lO+Zweh+n3h1OiG0cGTSueX95rbbZ0tbwwJ27/9wIbbZp8wsA1gb/RR9Fp98Sjs7H21/tGHyxpaiPlwUMaSp3Bi1rCJfkxe0lEnpHmmVw4AKRe2gt/+WaDwFEPAVo77J+Pmbw27Kloya5ualK2n1XzHlbiZRL4Q0KYQmrJ3R8/HDIgLMhLecaOVDtdMfMD0ELPyOaYmjvxm6riX65tWV8xAE4N3TSadz2HHNZoJXXvscDT7oWqUk7GVoVqaL49TQjqp3RZjMATBY88P3oTSx41nksM4k4op5zHZir2Q69RLOpgA59wFFl42b+h4wzlHM1qdByDeZ9bwdOmGBoJsiLfA1AZFyZup0weFedFUMNUXBqTwhhaQoMuLoL4LjHvwByW5FuYEzKROQ3f/SRPWSoNQwfvJKTbisRVoBLoM7ytM30LXwI1SQJBVdXSQtmoohtAm/1VAYapAgFxtnwL0zhA2Cxf83ZzTsgA2h2EDlgXEmLyGvGS7ysWl39lcxabRst63sPmgIsUc2iQmxC20ya1ZWAWQVe/bcW5geuw1CppB9mbTNP09aXc09XYDBM5i0z1ME8/7srY5Qyk06A9UDYudlw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(66446008)(71200400001)(66556008)(38100700002)(64756008)(54906003)(66476007)(122000001)(55016003)(66946007)(166002)(8936002)(2906002)(33656002)(76116006)(110136005)(966005)(83380400001)(38070700005)(86362001)(5660300002)(52536014)(186003)(508600001)(8676002)(7696005)(9686003)(6506007)(26005)(53546011)(316002)(19627405001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hg7+SoGUW95jZcsEhc8kjS5u72YWO1MEdWUR4L1vmcaPGMMSVW2TZIGxI4ef?=
 =?us-ascii?Q?N9BWFO7d2h4z/MTS0Eb4khE3QmbxSdFVwZfoKoun5c9P4iF0x3Epde5e7c0l?=
 =?us-ascii?Q?liCqd6LSa8ILaAXi8ilaem1T+C+RryD5KRLf4B3d1gwGqGiY7Zdld/l8uZOR?=
 =?us-ascii?Q?90Yzz7rtkleSq5cltv2zIJP3vTLKuauUoqKgMBZFjGOxPnPvLWny9A5F3HCX?=
 =?us-ascii?Q?Iy4lZAPaiQG4Er87GW2eJLgyi+pOtxuOpAy3QsFVCsFu9hv2ul1aXvcItp4g?=
 =?us-ascii?Q?fQc+bIhi92dYH2gg8UNQiDDwh3aUjPKvdipJTUYT1i1hXN3mFn+bOoUAJuPT?=
 =?us-ascii?Q?2xSQu7u3uKEH1KN44F/JxvSaYTOCIpoSzVa1uPMOYdRSYIKmjg2zboGp2QSE?=
 =?us-ascii?Q?JkzDzPEMW/YAgeGuOUOPi2qjH+Esh9AvZg9z6RxZk3mb5rjKnzEjPZn7+2pE?=
 =?us-ascii?Q?ekiSEGFbFYsgNHNDqAMAVxd6IGxHZfkuEzUjkXaoCHjkp1s7oPvi9o/8n/7L?=
 =?us-ascii?Q?lHDz4s04uGaflqebT6Pu8iZUvPTerbNuBfvFOeqtKgYQ6TuPC2kzsfN8jNLP?=
 =?us-ascii?Q?8M4hCmPnWoGVWdrRPJ0KuzxKC+J0L3qzhYYTd9RGcviT4h+zW4Iqxm1khHJA?=
 =?us-ascii?Q?VvC8onrNESc1BXyyOeS4WIMP6LdjsbYh4jwwHomG2a3xApMRuTr2+iZbhFNQ?=
 =?us-ascii?Q?sPVuF2GPpbVrgUCm0Xa88PAJPTDGbOJlis4bzKrDg+clte64hf6jZDrNFV7A?=
 =?us-ascii?Q?6e4KAPJz4iLI1y0qVQGAiU8Y//sZwdHThKlAv+6vKEmz080Y6hFdZy6CsLmG?=
 =?us-ascii?Q?Py37Ar6Tazg9eV4q1dokhsiGiEb5/i1mYUd9jTDcuPscuYuEccvWbJ89eoRT?=
 =?us-ascii?Q?HneK8mLPKvQ4Y8LEueKxgL4aX+Dc6nWYTf+6/S2exeGqmZbkmu+K7C8y7aX+?=
 =?us-ascii?Q?RSly1GeYUjpp0rmo+g7HsWTVj7Ygs8ae5sakO3ZTa3NtODOUBApQdQ/ouEuz?=
 =?us-ascii?Q?HmrhdJpQHF35Y8vCWPkXxoRNsVLFFh99cOCzwjgZZg6yCts4Y22zNCdtH+bO?=
 =?us-ascii?Q?hlFbzMTOjRqy3UBy89useqw+qfoWyUKPqNIHk6cQXpRq/Zie1S9jULW1qV+q?=
 =?us-ascii?Q?Z1CciXGq4obEEH1qyaPkj6sxcTX4Hzwl519s+Bve14RS683BC0XuAWI/yEkX?=
 =?us-ascii?Q?nKkSYqCEX8Lrf8Co+cC5SYDpR8uZd4VfPF0HRleOObSr72qbEEpjHBWOJWq2?=
 =?us-ascii?Q?X7v9/Co95y8Ai0WxB3iMx3jTud83x1DqvgEKBqFKV7PzfWjizhUOrz//rsQC?=
 =?us-ascii?Q?UghJurylqikv7yahSI+Nral2Jy7cuSmx6a9YiYJAOSGOmMVPvRwt5zWe6mCs?=
 =?us-ascii?Q?30kgGWbO1YYsEM2AGSdN2VvDPD1Mta6MXg7541ccnXNiFJtq/1fW0m1zhdGO?=
 =?us-ascii?Q?QpoD9WrktXpmS1GWCybBCQydD0wW0BTGOnR63k4xALvLRcUh3133M61/5NfK?=
 =?us-ascii?Q?L+F4Wh7FuwX/uFB8Oe+5ifV8ayZ7tebGRm2ZQJ9wigkUKMCZFWrflC7t2aN4?=
 =?us-ascii?Q?hJ1C82zGOc6cRopfeV8z9wOeyejLmQrevIrWApuPwyumXfof2HRTQS1XGvKF?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284EC1FDF4A0500436C432A8B6F9CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef25454-c5ae-4a5c-13e9-08d9ba63e29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 16:00:41.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsyvqtHvJCQkoaKDbtFQ1ehcw0Di1oTqKkSn24+U/XXfu34f2noRt4ElbYHq/+GdkpA7ELISOMJkPc34udaW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284EC1FDF4A0500436C432A8B6F9CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Siqueira,

Thanks for the heads up, lets apply Isabella's patch instead.

--

Regards,
Jay
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, December 8, 2021 10:17 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>; Isabella Basso <isabbasso@riseup.net>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Si=
queira@amd.com>; kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/amd/display: fix a missing prototype warning in DC=
N303



On 2021-12-07 2:18 p.m., Aurabindo Pillai wrote:
> [Why&How]
> A missing include statement triggered a warning when running
> a build with W=3D1:
>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:30:6: war=
ning: no previous prototype for 'dcn303_hw_sequencer_construct' [-Wmissing-=
prototypes]
>        30 | void dcn303_hw_sequencer_construct(struct dc *dc)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: cd6d421e3d1a (drm/amd/display: Initial DC support for Beige Goby)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> index aa5dbbade2bd..d59b24a972bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
> @@ -7,6 +7,7 @@
>
>   #include "dcn303_hwseq.h"
>   #include "dcn30/dcn30_init.h"
> +#include "dcn303_init.h"
>   #include "dc.h"
>
>   void dcn303_hw_sequencer_construct(struct dc *dc)
>

Hi Jay,

Isabella made the below patch that fixes this issue in multiple files:

  https://patchwork.freedesktop.org/patch/465821/?series=3D97701&rev=3D1

Maybe we can go ahead with Isabella's patch?

Thanks
Siqueira

--_000_CH0PR12MB5284EC1FDF4A0500436C432A8B6F9CH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi Siqueira,<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for the heads up, lets apply Isabella's patch instead.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Wednesday, December 8, 2021 10:17 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Isabella Basso &lt=
;isabbasso@riseup.net&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrig=
o &lt;Rodrigo.Siqueira@amd.com&gt;; kernel test robot &lt;lkp@intel.com&gt;=
<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: fix a missing prototype warnin=
g in DCN303</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2021-12-07 2:18 p.m., Aurabindo Pillai wrote:<br>
&gt; [Why&amp;How]<br>
&gt; A missing include statement triggered a warning when running<br>
&gt; a build with W=3D1:<br>
&gt; <br>
&gt;&gt;&gt; drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_init.c:=
30:6: warning: no previous prototype for 'dcn303_hw_sequencer_construct' [-=
Wmissing-prototypes]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30 | void dcn303_hw_sequence=
r_construct(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
&gt; <br>
&gt; Fixes: cd6d421e3d1a (drm/amd/display: Initial DC support for Beige Gob=
y)<br>
&gt; Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c | 1 +<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/dri=
vers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c<br>
&gt; index aa5dbbade2bd..d59b24a972bc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c<br>
&gt; @@ -7,6 +7,7 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #include &quot;dcn303_hwseq.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;dcn30/dcn30_init.h&quot;<br>
&gt; +#include &quot;dcn303_init.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;dc.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void dcn303_hw_sequencer_construct(struct dc *dc)<br>
&gt; <br>
<br>
Hi Jay,<br>
<br>
Isabella made the below patch that fixes this issue in multiple files:<br>
<br>
&nbsp; <a href=3D"https://patchwork.freedesktop.org/patch/465821/?series=3D=
97701&amp;rev=3D1">https://patchwork.freedesktop.org/patch/465821/?series=
=3D97701&amp;rev=3D1</a><br>
<br>
Maybe we can go ahead with Isabella's patch?<br>
<br>
Thanks<br>
Siqueira<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284EC1FDF4A0500436C432A8B6F9CH0PR12MB5284namp_--
