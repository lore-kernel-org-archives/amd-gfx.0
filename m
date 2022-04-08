Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 20:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4F610E5A9;
	Fri,  8 Apr 2022 20:55:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646D010E5A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 20:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ9lDGU+afitc2DWFQYigg9Z+5YotpHOFVCXqAaxBWPi0Rh7Qy2TZfmU6PF056Cnp1M5+fajUeUXOEuri8Qcbq62u5Y42JWXzzOMVZM/Cn8OMeUJrWPqFoKFW2/wHT9ay/7aGl1j3YKOO57k+yVB9I+FFHfReIBXs4fuS+mrr4T7hFvAFHJWXM7Dg7arLQJ6eKLBDLGhSHvqg2TdDvMIwagHv7ZmVmPpmcWscVxFd5Kn9NiwIctj19sk56sNlAWMGmOv1BKR49ozNugMVgburuLL5pzxYOYi6alclAHWHgjHNuy1lEY2U59gDVANya73YFbPd1yd5CtdjunlIDCUAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JELBW81vTqrDkMJcze0Xy7xr8jlQPKJ+bmySR07ntzw=;
 b=czlykbf8IA4dqOsrbC5e7Eb/eM4Nd60at0hr/+3UBcyXwHD9XCtwSDf3p+AK7TNvrfBgJigdxs2UC2fYUa2SFIRXqUUsxb7yJ2PkKS3pcDoEE5M8Jn5yjsk/zC/PRbZPmOM3qFnZWzI9sUweeJnGhr8uBuxCZQJfYWrZXQnikdG2/57RlArQDG94B+nRgH2RIyVHQiAtmitPvhuvWQzDAhR9K3O6f6x2VuUZu5cEtNyeHCZhWPUwlDFkEsIQ79enqS+67GhPvhkWolkIf34GAxcZ4g4bdGANTaRcgcOlo7uKh8W+HYrkZgAymudU5w3l48z2rEgD7/Qsp/z27N7vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JELBW81vTqrDkMJcze0Xy7xr8jlQPKJ+bmySR07ntzw=;
 b=ZqryREFFywLVQl1ZBXKrQmNwS/IHyZv+xGJjGiiLssnuNzskHo9WiIHWVF1qEPv4PQwVKZjgdY7HtU4PRtsTQyVz+kvDozSRn99X7HU//OanczMGwjlssleXFsZkEuc+WUpgFfzaGjg88nJb+7/thQVpYZVQxMvDTC3S0CXm2fs=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by BYAPR12MB3573.namprd12.prod.outlook.com (2603:10b6:a03:df::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 20:55:03 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::b8b3:5107:f55f:837b%3]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 20:55:03 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling in
 send_smc_mesg
Thread-Topic: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling
 in send_smc_mesg
Thread-Index: AQHYSxH2UHXl5mySZUWtZrvGd363cazmf417
Date: Fri, 8 Apr 2022 20:55:03 +0000
Message-ID: <CH0PR12MB5387E3101123022D943E70EFF0E99@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220408022639.7909-1-darren.powell@amd.com>
 <ac14165d-ee61-7fa6-56ad-6c336b710330@molgen.mpg.de>
In-Reply-To: <ac14165d-ee61-7fa6-56ad-6c336b710330@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-08T20:55:01.645Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 3baa2efd-88b3-cafd-0c17-339a4d2e24ea
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b83420a7-a063-404e-f158-08da19a20da7
x-ms-traffictypediagnostic: BYAPR12MB3573:EE_
x-microsoft-antispam-prvs: <BYAPR12MB35734A72B33CACB8D1424738F0E99@BYAPR12MB3573.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jTKZErKmU6DPYZKbF1nVj8CY8m+ql9GLddPAa5t2f1gESMcm55IClNwPuhPzgk91AX6cp+aRyOcQM5GYo/psD8lQdbUNjmGmrC36dz7RHOLZaS9rVlgTLbuxVYnzrEO+KpMrTfdLq079Pqdd4RZBo9XbosGpSBN2Y6+hXB6nSEO12TvSq70vBuxOAk4DsJG91e2J7pgV9HwvueNlL1zBk865RhxImaNR498rQOQqGA1ADgZYfwkb+DYr1USE/KAmK23Fn1WoHFUZNdOQvzvIMxQME+1KaJfh4egoKbr4yZpJUIIuafN608MM9mJEFHmXvgSBAAksRmuAFd4OHu5+QZKe5SpUyC1xAuyuJ8HBbmEgxE6QX5iUN+29iFfKMC22IerhmU3MRV9gVNipY2+WClaVnJVlEAoFYlD3ICizXKwc/XTMxO+aTJJIeOQVPQ/WomcMi+o3TXCcdu6e3sj6r+BiK4Qd/i5AznsjDR5gWjQsUGNs7TQ2kQmSH6v/FuPQS+XW6yQNpTfV32f3PcxJDVOEIK8X3191t0Vd1wy/wlmh20JlkUkxktOioPCDYkELQDmNrd/UumK8SplM3Na7sjascqtCbdLGari++iFuFkYMGr8uOuPTzL6EpZQapwswLwUulufOUKt/UPBpfWi1aSDzBuptG9AjqlxyRow3JUkXfPTUmGo3tDKbTtMuAB906I0egkDFCvvPEcsqYCqNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(38100700002)(38070700005)(26005)(186003)(8936002)(19627405001)(52536014)(55016003)(33656002)(5660300002)(316002)(6506007)(64756008)(66946007)(66556008)(76116006)(66476007)(66446008)(2906002)(508600001)(8676002)(9686003)(4326008)(122000001)(91956017)(86362001)(71200400001)(6916009)(54906003)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?BYU4ZWWlRYb9Zkeee6Rgitk5yBUCMOzbfX9j2U0blblBeVwk+rjSLwgR?=
 =?Windows-1252?Q?4qsUChuKZTfn9tbZe8q+CRcdfQ7gFyq4D+69hp5au8Mgr0kmHOmWYlxg?=
 =?Windows-1252?Q?W0lnm06osRZzGPPbsXZyeer3XYi1XnGf6ONf7Mx3NGzxqiHegdXY22OQ?=
 =?Windows-1252?Q?c1NTNbGXS4V1p+WWWrK6nyFyLVG8nx5kczbGSR8VT9tZKb5ddhddFhIF?=
 =?Windows-1252?Q?ffZjNRqo1y9iXOXWWL+oqV01OWlzMb6b404XYJ5W6StRkwc27VE1UeL3?=
 =?Windows-1252?Q?akFkzT2dWJWoUKhUqxhKdN6BkPXjE/3gaNHCvg724c1ieaDrTaGEImPm?=
 =?Windows-1252?Q?71ZmmT8wD2ca8zLl/eSRFczMc8HaWwdujAKem07RnJ6AVEYLcSRwXa4R?=
 =?Windows-1252?Q?1msEkcfM6uNSSqL2XQvJUmHTsl4SK2AYD5YDr8xvKIJqwsgfW4zMDa2u?=
 =?Windows-1252?Q?FdcKqeD8qr1NwAvJa8xtu9qKZ3lM3twQV80w806Kyw0pvSrmA5YsuzvE?=
 =?Windows-1252?Q?gc/uOFlmdiiFSwCzJ3xwVCvI3PBkg1dqoeDe2TwouhiJV7XtwJeCaXtJ?=
 =?Windows-1252?Q?t8JFprGw5DCESBaM9xKaGIY4/u0qnejLnx2md28+yIHfD/ypUMX26kTR?=
 =?Windows-1252?Q?y4Il4xMIc5ezpEmGGpKdep57TiVcCSRqLx6Gy9s5FUAc0dSquWCCNukY?=
 =?Windows-1252?Q?pHSgLRojaR8/jhhnfnec9zHzhkhA8XnYYXu0C/nYUelxStWzNYLOsSeS?=
 =?Windows-1252?Q?ul/btGz1ORN5tvGnyDlreMVMZm8dRnnTRQO/gaQi3utma7BviMx+W+iP?=
 =?Windows-1252?Q?Fl50WddfBqhrHVDyKybDT79dV7p6OfX5b1qwccUaZxGxxcBlb5VsjFKe?=
 =?Windows-1252?Q?3cdWl5o2a0tpQAN3J6sjcXLq8EsyMcwGwsGWb774WwUnOqAqOzXfGhHm?=
 =?Windows-1252?Q?4MwxMmmBKeXEeGcAHW5RsR7pGj+n3E2SvU/gW5KxYyb/LPsvsYd7qweB?=
 =?Windows-1252?Q?HmX/xJphoWG8KKpj8OApyAHfYRnW7JtbFQIUoVoSLUEcqtL/CKR8FjNL?=
 =?Windows-1252?Q?wBObjCXmaWTTy5her7C+dCbereS96AYPjSDt8O3wdP4syWuH/XvrIx8a?=
 =?Windows-1252?Q?zWfRNBVG2H2JxCPYXwJiiLjaoh+jbOkqw9FrsB/lpzRyiM7gu6rYRwcq?=
 =?Windows-1252?Q?tmr7LzER7DXbOziveJveSJ3CaR6sh5S/Enxo5V/IVZ4rg1h1m8/60ZoI?=
 =?Windows-1252?Q?2Fu0Jbm5/c9C1vIX1in4olY5zTz45yLQBaMjIUdwUiJK7GZwqDnluE2G?=
 =?Windows-1252?Q?lTC4EVdthSK6lJhVGXwdAdiMEHGu4lLfYCn5JE8T5g9+SQej1BpQOB9h?=
 =?Windows-1252?Q?g+yYjiT6yQjpjm2rRir+BEhves3chaldIlaIT6i64g6DbiC4noOuJlJh?=
 =?Windows-1252?Q?1fH1K20yjoCQI9pVLu2SCdBzaqTX6zywP7jDhy+HKyBy2KP/Je7BF057?=
 =?Windows-1252?Q?WGOeKdet+c6abn4RDwCQKQMXam1/4ydZC7vnNhxMuo8gYxbGfoeIGZCi?=
 =?Windows-1252?Q?IPhgXL5Sy0r38emY2LN8PkY1c9p1w7enyIqhSfkPQ60uxOCL+sFJkTRG?=
 =?Windows-1252?Q?UyQpou7ojusUww1uz62zFeuucBHus33R3vBhnkVt7HvNcXvpQumPwKos?=
 =?Windows-1252?Q?QlerGyTrmLP94ouo1TuTcEi20GVHSTbEzc7O4y0EtRvkBpc/B3rzlO6V?=
 =?Windows-1252?Q?VeUFcHVUNCFOLVDy6oJRF/WWVN23umO4dsF4Bq1Hamp5GopbkWhl+Etr?=
 =?Windows-1252?Q?OA0RrmTJhtP0NvsBYhCj9EKeTaJLf49Aar9Qjs1D1EGAvETs?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5387E3101123022D943E70EFF0E99CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83420a7-a063-404e-f158-08da19a20da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 20:55:03.0384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJjzN8MXGCxj4tRfeVFwG4WPMl19cHcxGDh59nA303UXpXbHpGBbCeT2wsl8bKVFQto1dEL3BUIKXt0+Q0eEYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3573
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5387E3101123022D943E70EFF0E99CH0PR12MB5387namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

will respin and incorporate your suggestions
Thanks,
Darren
________________________________
From: Paul Menzel <pmenzel@molgen.mpg.de>
Sent: Friday, April 8, 2022 2:29 AM
To: Powell, Darren <Darren.Powell@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Tuikov, =
Luben <Luben.Tuikov@amd.com>; Quan, Evan <Evan.Quan@amd.com>; wenhui.sheng@=
amd.com <wenhui.sheng@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.c=
om>
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling=
 in send_smc_mesg

Dear Darren,


Thank you for your patch.

Am 08.04.22 um 04:26 schrieb Darren Powell:
>   Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
>   cases exist where messages are silently dropped with no error returned
>   to the caller. These cases occur in unusual situations where either:
>    1. the caller is a virtual GPU, or
>    2. a PCI recovery is underway and the HW is not yet in sync with the S=
W
>
>   For more details see
>    commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>    commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending S=
W state")

Please remove the indentation. If you re-rolled the patch, you could
also spell *documentation* lowercase in the commit message summary.

> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..b1bd1990c88b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context *s=
mu)
>    * completion of the command, and return back a value from the SMU in
>    * @read_arg pointer.
>    *
> - * Return 0 on success, -errno on error, if we weren't able to send
> + * Return 0 on success, or if the message is dropped.
> + * On error, -errno is returned if we weren't able to send
>    * the message or if the message completed with some kind of
>    * error. See __smu_cmn_reg2errno() for details of the -errno.
>    *
>    * If we weren't able to send the message to the SMU, we also print
> - * the error to the standard log.
> + * the error to the standard log. Dropped messages can be caused
> + * due to PCI slot recovery or attempting to send from a virtual GPU,
> + * and do not print an error.
>    *
>    * Command completion status is printed only if the -errno is
>    * -EREMOTEIO, indicating that the SMU returned back an
>
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

The diff looks good =96 despite Mozilla Thunderbird quoting it strangely.


Kind regards,

Paul

--_000_CH0PR12MB5387E3101123022D943E70EFF0E99CH0PR12MB5387namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
: 12pt; color: rgb(0, 0, 0);">
will respin and incorporate your suggestions</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,
<div>Darren</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Paul Menzel &lt;pmenz=
el@molgen.mpg.de&gt;<br>
<b>Sent:</b> Friday, April 8, 2022 2:29 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;; wenhui.sheng@amd.com &lt;wenhui.sheng@amd.com&gt;; Grodzovsky, =
Andrey &lt;Andrey.Grodzovsky@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error h=
andling in send_smc_mesg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Dear Darren,<br>
<br>
<br>
Thank you for your patch.<br>
<br>
Am 08.04.22 um 04:26 schrieb Darren Powell:<br>
&gt;&nbsp;&nbsp; Contrary to the smu_cmn_send_smc_msg_with_param documentat=
ion, two<br>
&gt;&nbsp;&nbsp; cases exist where messages are silently dropped with no er=
ror returned<br>
&gt;&nbsp;&nbsp; to the caller. These cases occur in unusual situations whe=
re either:<br>
&gt;&nbsp;&nbsp;&nbsp; 1. the caller is a virtual GPU, or<br>
&gt;&nbsp;&nbsp;&nbsp; 2. a PCI recovery is underway and the HW is not yet =
in sync with the SW<br>
&gt; <br>
&gt;&nbsp;&nbsp; For more details see<br>
&gt;&nbsp;&nbsp;&nbsp; commit 4ea5081c82c4 (&quot;drm/amd/powerplay: enable=
 SMC message filter&quot;)<br>
&gt;&nbsp;&nbsp;&nbsp; commit bf36b52e781d (&quot;drm/amdgpu: Avoid accessi=
ng HW when suspending SW state&quot;)<br>
<br>
Please remove the indentation. If you re-rolled the patch, you could <br>
also spell *documentation* lowercase in the commit message summary.<br>
<br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--<br>
&gt;&nbsp;&nbsp; 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu_cmn.c<br>
&gt; index b8d0c70ff668..b1bd1990c88b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c<br>
&gt; @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context=
 *smu)<br>
&gt;&nbsp;&nbsp;&nbsp; * completion of the command, and return back a value=
 from the SMU in<br>
&gt;&nbsp;&nbsp;&nbsp; * @read_arg pointer.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; - * Return 0 on success, -errno on error, if we weren't able to send<b=
r>
&gt; + * Return 0 on success, or if the message is dropped.<br>
&gt; + * On error, -errno is returned if we weren't able to send<br>
&gt;&nbsp;&nbsp;&nbsp; * the message or if the message completed with some =
kind of<br>
&gt;&nbsp;&nbsp;&nbsp; * error. See __smu_cmn_reg2errno() for details of th=
e -errno.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * If we weren't able to send the message to the SMU,=
 we also print<br>
&gt; - * the error to the standard log.<br>
&gt; + * the error to the standard log. Dropped messages can be caused<br>
&gt; + * due to PCI slot recovery or attempting to send from a virtual GPU,=
<br>
&gt; + * and do not print an error.<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Command completion status is printed only if the -=
errno is<br>
&gt;&nbsp;&nbsp;&nbsp; * -EREMOTEIO, indicating that the SMU returned back =
an<br>
&gt; <br>
&gt; base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7<br>
<br>
The diff looks good =96 despite Mozilla Thunderbird quoting it strangely.<b=
r>
<br>
<br>
Kind regards,<br>
<br>
Paul<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5387E3101123022D943E70EFF0E99CH0PR12MB5387namp_--
