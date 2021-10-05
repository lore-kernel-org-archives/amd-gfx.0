Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B26C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 05:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1FB61186
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 05:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E1FB61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FFC6E2D1;
	Tue,  5 Oct 2021 05:04:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4686E2D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 05:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKjgossSjtbGlAc2YxbbmZ9/e9j2BzyO/Lk06LZ7ZDRH1bwvPgS0TWaciG+yBt3cVLego1gaXU55QfUskfTWNIw49rqUtx66TWn3bcGLUvYG5vMdTW0aPMkSmyJItER/mvgGmrtJUpn9bGWGB1ATzFoV+Z8iyva+gzDw2ODaeV/eD1tkf4mMTvTG3Yc4erZR31lcZUVIxjuEDHz8rhnTR3lYoK1IOiODvxSHfUqw2ws5lIHqdDaMq/4fvFM5jZAq5Yl4lSOkq33VbX7p4kyhFi1lljvBHlJvAfjzVgJxViY7XVLVtuHDvEplktSHX6C6w72sQ4G31rjNVhVBpYvMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmiIr3Q2LYXgTvpKW4QVzirzys8x/xxQYBPQ8Km6Gsc=;
 b=guD5dvUvURFf9f5GnxTKu7fmlvdVO/QecQQdqhefrmIA57w1CCCKGh2ai5Q6stk83tsMQl3BzUSrv+I+/2zrZnPqL41iuYyyvRiiqtfztuLP1HwZMFP4oUKoXUfWalkZH++rJ/aj3KNBszJqJtX6Dip7eGLRd/+begS52pmdKuM/FQeL/Z0xGgrEPuiWDMWq1vHRNovys8d1AjijK3tD/tfc2M4yU3CGmAZK/h/Xd120ACvccQ2hyzypJfEx3lkzZUsY9uWWsfilSqjJi7ob3O4RDckPaACLj/7YDdFJ6eYLPVruQt6LSm3eOXjGaxiq4PPAD4r1b9MWVWzB3+JvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmiIr3Q2LYXgTvpKW4QVzirzys8x/xxQYBPQ8Km6Gsc=;
 b=3bVvNkBXMHPnl0pzEImvldsUnkbEkKGLAP2WyfPhUwup8qJZ8Np70jPhQ9JOsrY8B3NpAXBMPVTICOcG1y7TNesEvoixjwfTanDnlDSqW4aRlpAm0VoNVN9ED7mXNt/xYasR08TpfRkaTzz+NrfKXR2PW0xdDznggmgN3GOchks=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 05:04:15 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::5ba:1c46:d9ff:d07b%3]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 05:04:14 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power limits
 in smu struct
Thread-Topic: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power
 limits in smu struct
Thread-Index: AQHXuBHJ0dptY4OO8kaVfWPEaOx7cqvCqRWAgAExBko=
Date: Tue, 5 Oct 2021 05:04:14 +0000
Message-ID: <CH0PR12MB538758212431DDDF939AD18CF0AF9@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20211003044658.29238-1-darren.powell@amd.com>
 <20211003044658.29238-4-darren.powell@amd.com>
 <d3b0d32c-0c14-c5ff-4157-501599c502b5@amd.com>
In-Reply-To: <d3b0d32c-0c14-c5ff-4157-501599c502b5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-05T05:04:14.211Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 46a3567d-6fa5-c5aa-2932-6bdead67e3b5
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46a41742-60a6-456b-503a-08d987bd93ea
x-ms-traffictypediagnostic: CH0PR12MB5124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB512490BC19E1BAD80B7B3F02F0AF9@CH0PR12MB5124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ed22fdvBec+9mlWzzRzNSeqlntDsCUL5c6wck2xjfUX6nwCrLWuyIuKPSwa6IjfZeeGh5nvOf2GciQ+vB4Ew1rqe092fFgQjDAtUXi80MBFrdNYZnWVRkWiuMIXB5iuH4RA7U8V6+8AeP+Ls0zVMSjvbnla98HL2yUVirUba/tPeFq6dP7D0LqEJTim1zj/IQll9v6efJH22RXuFZea2wz0jYamB8aJkiG4WOF3xNdiYLFERbOMDwxSQijmdas+oXv5WtUYpyNZK2aEAnwdoyHS8nrxrIr6SEc3s4T1NZqyTmmYVkxn7dZlXy4f8bl863yM+sNVChxpXpYmgpur6yRitCOeTZ3HQdRO8kIRjGtH7Ufi6B3bkgK4a953JN9JWLmqhUji5f/XTm7JmQlX2R44bnvU0Pdr9AsvyBxSIqLtsED0dpXPSjyklJRCtayvKIgImcI3AqhXcOdL6fchTyj5cwFq4E7SgilpPoOXlC/Fg+mt1/gRVuSzigmVMBBLJ2TBmeXsAdFFR5/YNyC7/QNDgPwqUyaEaM1niy/2aunZKn5h5oNgwfAAPf/Fp75YpB86hpF/BJBvulWFarO+rLcvLZgu+CqY2jWsPLxrdf5hIagaStmw9SlbuNgXOs/oe4MseeKkeKOVKeHq3bMMHLiMnSGKTEw4UVHgGi1C7TkyX3lgWbFexNlYl8YgCll4tI6xDfdDHt+5TBPuQmt5nYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(186003)(53546011)(91956017)(26005)(110136005)(316002)(8676002)(71200400001)(76116006)(52536014)(6506007)(38070700005)(122000001)(83380400001)(55016002)(5660300002)(7696005)(66476007)(19627405001)(9686003)(38100700002)(2906002)(66946007)(66556008)(8936002)(508600001)(33656002)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8IxZI3zvw2cwIrAjRbBMqqHOkznjSAEgVFwwof9SNreZXD88nXRBdaY1auny?=
 =?us-ascii?Q?K8REcK14fhT4Jybkgh6onp6uQqQVCyBYV+VeGStA2nhk7SynMmfLxdu/AYpJ?=
 =?us-ascii?Q?VwFdKQWRboFRY35z3ufHTFA3/+s5+j2MLwV56CpyR0rA4NP+tqSrqwNAu7nc?=
 =?us-ascii?Q?kzObh8KRatLDXp631quc4f7DVj70co8D9jgS+zFFyjGTpLKR3Jkz/qr6E9zb?=
 =?us-ascii?Q?8Le6IzPi5kvRk9Eke34mo4qiSw0ciTWkC7nOym0rrdN7FUcnxV3S0R5Djw3A?=
 =?us-ascii?Q?tN97oLPKpySQGEF1MYCUbE92FcZvEroKLsZ/Ozr5CjZSTgBg6MWroPq7nOa1?=
 =?us-ascii?Q?SKu340Ebm3wXaGvt2Goajx4VMCLpKmBFAXhzAwbDCWo7HiHTJV95VsBUhCbh?=
 =?us-ascii?Q?27HIYk8eYYni2AMRWEMOEDwg0KvSf5uo3QxqGCdnRB00JjMfIrKbEDJ/kxpi?=
 =?us-ascii?Q?M8l1fdMFCcQq5XMuTXa416RZCzI7bRIzaIpBjKbASRsMS/2lwMyprs3+xkKH?=
 =?us-ascii?Q?ezdQ5iJjguJqWVVADUiaOzSNWb0sI/siEHCcbGo/h00+DCgTC/neQokyYenO?=
 =?us-ascii?Q?cTitbMOC2VWXnq3GC56UhR7Ck5b4sG80j1udQOSyiFu4xPNAl/PbmzIAqFJY?=
 =?us-ascii?Q?AoCFeJSC0YXPlQXH98kdaNqstI401nr/GirG1Z/m5bQuABsW6otAB6DJuFEf?=
 =?us-ascii?Q?bATHS6eIFjUE2UfiRKSPoAXblEMgomKbLfe+JIzdKf8EERsre2D9E33XEaKk?=
 =?us-ascii?Q?/ABZpDC3LDLUOisHBKUJuJRLr0PRiVfSGOpoKFwhzdVePdUmCsMGIV/BFlB2?=
 =?us-ascii?Q?ZnWPuJv1svmJ1DiZ91817ik2kuA+zOwqWDd3iQuavDVDgq+wmhYjz5MoqmQ7?=
 =?us-ascii?Q?lwtEYNmruCcVJNgx/GW4qi+f9896PrBDCQZSZAP2QsMaxmlPay9uu35wmaIm?=
 =?us-ascii?Q?I7PZdTGqocJ+Wa+SPN3qOtdXP57ei+GuwIfKjy/YIMlUWENPsMVbHNI4BeOD?=
 =?us-ascii?Q?KJkoME7VjlonoTE2HVtep7V+7ABOCq97vfL1nRnYdZ7Bm8csjEWPWYZmJx50?=
 =?us-ascii?Q?eyc16tIfEIi8uTVjPhL+J5c3ZkzwKagwcPnKzBOxrvuQfLCk31H+1ZvwREPc?=
 =?us-ascii?Q?KLz5yq4mkqzzNOoJmzEhrjrTrXBCnVsIwegoeH88HxME1RKAgirQcqgWmZEf?=
 =?us-ascii?Q?edl8IQW9Qw3TFQw6nViC8aTmErjAER5SBixnfW3MiUTmBbI+0TSEWZsPyYeq?=
 =?us-ascii?Q?hoBqHdV1SrTpjMjCPIbWQtn75ru183LYZVdExleSiSh5K7ZkLuFO3APYcru8?=
 =?us-ascii?Q?tnPfpOwvV8zQrCkVlYmSsn1g?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB538758212431DDDF939AD18CF0AF9CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a41742-60a6-456b-503a-08d987bd93ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 05:04:14.9084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yUDLiDRvRHbtf/o2xGl6FUGfre0DZ4rUVDqleLYkxpEVdvBTkK2AW/Xkz6DD9zQtNhNzDKl3Rhhazna6/5YaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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

--_000_CH0PR12MB538758212431DDDF939AD18CF0AF9CH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I'm just looking to clarify this code. The macro eventually expands to look=
 like this

   if ((smu)->ppt_funcs)
   {
      if ((smu)->ppt_funcs->get_power_limit)
          (smu)->ppt_funcs->get_power_limit(smu,
                                            &smu->current_power_limit,     =
                                                                &smu->defau=
lt_power_limit,
                                            &smu->max_power_limit);
      else
         return 0;
   }
   else
      return -EINVAL;

But you have to dig to realize that it's a macro, and that it makes no modi=
fication if the function is not defined. It's not clear without then search=
ing and following the function pointers which platforms are using the saved=
 value. I thought of inserting the following comment or should I just drop =
this altogether?
 /* seed the cached smu power limit values iff get_power_limit is defined, =
otherwise they remain 0 */

Thanks
Darren

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, October 4, 2021 6:43 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached power lim=
its in smu struct



On 10/3/2021 10:16 AM, Darren Powell wrote:
> Code appears to initialize values but macro will exit without error
> or initializing value if function is not implmented
>
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index faa78a048b1f..210f047e136d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -712,6 +712,10 @@ static int smu_late_init(void *handle)
>                return ret;
>        }
>
> +     smu->current_power_limit =3D 0;
> +     smu->default_power_limit =3D 0;
> +     smu->max_power_limit =3D 0;
> +

If this is only about first-time init - smu_context is part of adev, it
will be zero initialized when adev is allocated.


Thanks,
Lijo

>        ret =3D smu_get_asic_power_limits(smu,
>                                        &smu->current_power_limit,
>                                        &smu->default_power_limit,
>

--_000_CH0PR12MB538758212431DDDF939AD18CF0AF9CH0PR12MB5387namp_
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
: 12pt; color: rgb(0, 0, 0);">
I'm just looking to clarify this code. The macro eventually expands to look=
 like this</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 10pt; font-family: Consolas, Courier, monospace;"=
>&nbsp; &nbsp;if ((smu)-&gt;ppt_funcs)</span>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp;{</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp; &nbsp; if ((smu)-&gt;ppt_funcs-&gt;get_power_limit)</sp=
an></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (smu)-&gt;ppt_funcs-&gt;get_power_=
limit(smu,&nbsp;</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &amp;smu-&gt;current_power_limit,
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp;
<span style=3D"background-color:rgb(255, 255, 255);display:inline !importan=
t">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;<span>&nbsp;</span></span><span></span></span>&amp;smu-&gt;default_po=
wer_limit,&nbsp;</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;"><span style=3D"background-color:rgb(255, 255, 255);display:inline !im=
portant">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;<span>&nbsp;</span></span>&amp;smu-&gt;max_power_limit);</span>=
</div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp; &nbsp; else</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp;}</span></div>
<div><span style=3D"font-size: 10pt; font-family: Consolas, Courier, monosp=
ace;">&nbsp; &nbsp;else</span></div>
<span style=3D"font-size: 10pt; font-family: Consolas, Courier, monospace;"=
>&nbsp; &nbsp; &nbsp; return -EINVAL;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>But you have to dig to realize that it's a macro, and that it makes n=
o modification if the function is not defined. It's not clear without then =
searching and following the function pointers which platforms are using the=
 saved value. I thought of inserting
 the following comment or should I just drop this altogether?</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Consolas, Courier, monospace; font-size: 10pt;"=
>&nbsp;/* seed the cached smu power limit values iff get_power_limit is def=
ined, otherwise they remain 0 */</span><span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Consolas, Courier, monospace; font-size: 10pt;"=
><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 12pt;"=
>Thanks</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 12pt;"=
>Darren</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, October 4, 2021 6:43 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/pm: explicitly initialize cached po=
wer limits in smu struct</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 10/3/2021 10:16 AM, Darren Powell wrote:<br>
&gt; Code appears to initialize values but macro will exit without error<br=
>
&gt; or initializing value if function is not implmented<br>
&gt; <br>
&gt; Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index faa78a048b1f..210f047e136d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -712,6 +712,10 @@ static int smu_late_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;current_power_limit =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;default_power_limit =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;max_power_limit =3D 0;<br>
&gt; +<br>
<br>
If this is only about first-time init - smu_context is part of adev, it <br=
>
will be zero initialized when adev is allocated.<br>
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_asic_power_l=
imits(smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;smu-&gt;current_power_limit,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;smu-&gt;default_power_limit,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB538758212431DDDF939AD18CF0AF9CH0PR12MB5387namp_--
