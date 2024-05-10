Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C91C25B4F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 06:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5339010E402;
	Fri, 10 May 2024 06:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UQfQa2Dq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB7010E402
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 06:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSgSxOrwnsCYTWIsxrdQmWqRCI2zxL+imT5TrQSd6tHHhmMgT62gQ3IyYphlhmFNkwa/H01E5omAXVTQCuSiCnyJ7jogLio8R1o4zjsVcUbROX2UFOZWKY5U34eUstEV9HQTxXhr2ljLwJw4zoxUHXTITaQpGJRSASrVmyKQD92BboOJIa36tu9yXCF3a9ulaFrV1HAJYKNnmZ8MKJQWoNCy6ycAcjOQKKZs1LLlwRe0qQLMh1nMLXxCAf5AW/ilkZ2JJaLRSt0TVWAqX5XVeCWFEzL8Tkf3EdQoO4bMZcjZ062xWdMwoWwE2G+flOJ07NoT83HLlVFhLM7T1WXDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qUqHGcJwv+2Kce5C2U0xmJ8SNPx7Xb7fYEClUqT58E=;
 b=V8YPi7NBSWoc2RQtOkYIMi0xwhyRgp/vjj976s1Jpxdz3f0Abxzi5nIwwIMFYwXYVUgHxIQT0WZIRM4t+q4NcXdRHvkjjLSIGzoRlmVftxD7HSDLM1ZUD8ru0j5+25tzAwgtspBNSBb1jRQKD6WbZfE43DVwVmcLNFfqAwMq5rD4Pq9SC3MeaNrhmgus0VgUdH4fBYLcENPk9Y5IvAWFS2cbGuv0I9817KJR0JUAdM2E1gfSkhAKDe0j91ZoEK9ZlyCmx88MWXRX1mprRKrqhnGcDZWoYCT5p4NtKxg6DMfuM+Jo2/rC5NK4yl3+2htHW5FQMXBa98P5q8opou2aFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qUqHGcJwv+2Kce5C2U0xmJ8SNPx7Xb7fYEClUqT58E=;
 b=UQfQa2DqP6E9reYKf96dJRGz9soNiQ2DJYisvx99gSxS5UjW/SOWXLNzVBRXLaC/1/0jMRzAU5PSZjvwEsYr5+gVlguAPa2BQDbsXXpuugrWtAtr6oCTizQVAyF5MGIoIWpwtDSNUykK38Y+yO6VhyPDVgR+J5tw52U40kB/qtQ=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 06:42:40 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 06:42:39 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
Thread-Topic: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
Thread-Index: AQHaooVMR9JK2r2mSEW+L+rGKJDnMrGP+Yeg
Date: Fri, 10 May 2024 06:42:39 +0000
Message-ID: <CH3PR12MB807428DAB4A5BF1B8E353A57F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-15-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-15-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=59a514ff-b6c5-4492-9e2a-b30cbc7e7e61;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T05:59:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB7200:EE_
x-ms-office365-filtering-correlation-id: cfdd247c-83d3-40f3-5f8f-08dc70bc62ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2bKIeUMyhceqNAXU7I5c36usic5tQDF50hapIQbtSid7JPen3WHTX/CtoD?=
 =?iso-8859-1?Q?xfcJzbCfudpQyBwcEO/vm68TU+IqFZs4Yz8J8qblPRXKHItpl3JkWif0Wh?=
 =?iso-8859-1?Q?5ZOuODM+8PJfHxvn4+/ukQgM+hOsjaInHQG4JmkR6NVTUWIMymnXIMInbv?=
 =?iso-8859-1?Q?oTSB6H/mLmGrZ4eSeyUYcGB/7Hmha/kQOaw8V1tyrTy+LvAN9NOwiDjPoZ?=
 =?iso-8859-1?Q?XPZ/Ah9vrJcnRI4z0MEZoiVaGfgpLY1OGARvFattFfFeiGChAScZ4NfNEi?=
 =?iso-8859-1?Q?M4hxRpFyPANCRf+/z3nZTEinRYZi1V5e5YOAk3lHq+cCo0cQv/kXmHVm2X?=
 =?iso-8859-1?Q?pQks/CA1xPbW2o6Ytqzbc7HyjBXtnIRcYYMBUzXYjpbF1P3Vp8WsvyWFEv?=
 =?iso-8859-1?Q?H8C7nom9KkYDG/fMRwaRJ7p9wsJMxoD5NOIyViPc+egYYvI7Gv8yxblMrS?=
 =?iso-8859-1?Q?FLumWQpwArfv7dNObQp7JYCCgtqWss2plm7T9FUsBYtfZ/MJ/B9pwTwXPh?=
 =?iso-8859-1?Q?ER28PKUWn9l98TAFQBDY+sH2FC9/7NGCWQbMBmAV1DR6W0iOSzbbQS6Vqk?=
 =?iso-8859-1?Q?nkVMCA1m0CGLugi4AAr5Y3wkH8YZXTKZbxCYdWZ9nu7rIAfKalKbrjmjr8?=
 =?iso-8859-1?Q?UBg87XghXj3SuSu532W3vd+BH5lUdd1Sr4eXrd039+D8mjkUw8nWOoxE3/?=
 =?iso-8859-1?Q?JwkGkOB6IiGVGTUzaL/gSWiU68NlaVLvOB/jFJ1F4igTCc28BN/aFIAvY5?=
 =?iso-8859-1?Q?npLuA6NVBvMhWpmMp39x3PI/4nvxAvQF/ef6dATFUCzQYPFaog0uysiQQY?=
 =?iso-8859-1?Q?D0gf/4Z6ncj35nu0sdd+ILUTVNT+v9IDiPBKTDTUJkojEBz45TT31IecoD?=
 =?iso-8859-1?Q?HOpWZq+jG82hxn4Z9ahJ8Iul2+/MTzDclX6F4VNGrmaRc5Qv4wxZt7gy8/?=
 =?iso-8859-1?Q?gwATwkX3XgXNZRsy0lSoH4QA89PoTriJ0gHBMejEMoZ/e+3JcdeOkBdYi0?=
 =?iso-8859-1?Q?J4c7R1gjfiRqnhCFpYFaPT5WN9JXavm1xIPK9tOkpj0vjudmJRkXLCO3hv?=
 =?iso-8859-1?Q?lVft2PB+hIbeSf3e64VDFizZ8zfFHuZ/FkIvVtD3amtTo9uvt04IhJFhQb?=
 =?iso-8859-1?Q?Cz+CEZzXusMTPEwepL4Hfc4xFCegIZnNca+ryGWznpDXHaoZrVjlBf3FD/?=
 =?iso-8859-1?Q?RcaSlh1XZGWVxvMsmr7I7QDex6ZJq27afg6Sh6sdmMFlR2Xq495lRDsESz?=
 =?iso-8859-1?Q?3kulflniU9kzKNirlOH10w+GlSEeXPy0ftRdfbkTjRo9uBYF8tga6WkiYi?=
 =?iso-8859-1?Q?C/Iq5jaVNzKaXsb1KJxHUKqNvFHbRQE0wSn6/hJDlNP5LI1C51sPzYyxe3?=
 =?iso-8859-1?Q?LhWpViiEM20XL7JKM0YO9uoOvtRTXZhw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dfjmsara2gRmN+u//+f0t4spSlFQafak43kR3DmXkugTnVQvA4nP0VQzxC?=
 =?iso-8859-1?Q?bZ+owygUnr2/UZpQ/aWTPArVeVx6U69WtVBE8Kaybag9Yezx7k6qI4q/+J?=
 =?iso-8859-1?Q?7IPLZ+u+WEAcY2UC49DEyPdRRxQqBhUFpL1uWEJuWf4DtUn9nmZfRkhkBP?=
 =?iso-8859-1?Q?PgeBQvCgwOTOn4C3emWafSr2tUEgUy9KN27JL6qzEtws9vCOCPp9zcmI3j?=
 =?iso-8859-1?Q?tEKVrP75zoFTT0IZvdtaXTJxfh0Zh1q6kAThoOeTJGyvKB3qlxhG8PFXFa?=
 =?iso-8859-1?Q?EgEFGL0+PBtxELN8+mR/PpbiYMX/SWsRkK0J3G3XeSrv/ftZxyh+kmyus4?=
 =?iso-8859-1?Q?ltr7uOUV1kWajdZJR42fjOpfjykGH5ULGUTMj+6fPVt7/KyY/fQbruI/Rj?=
 =?iso-8859-1?Q?LS/hEHcSCP4q93yoY3R6rtbeEwqzvWuwFJR4MOsyAQOx8ldZGMd2wBWOiK?=
 =?iso-8859-1?Q?zQaczs2qsnL5adMB78lBKdzMKUv2atlhdv1K+Y6auEtg8+UizN3O54ubXu?=
 =?iso-8859-1?Q?0p/ZWDm7+kmdnQqaDbKb5XiWptfX7UOJ1MoeYm2fwJdCa/SKCz1AtOaLr2?=
 =?iso-8859-1?Q?QtYiQDbU70Z/UCPK3iR7ELL1lZWZovnP6a1t+BbNZYhl0AtBHaizAdtE9c?=
 =?iso-8859-1?Q?kpV9yiaM4HSQykx83vImq62uOVfJmrbBv8XMeF3sjtdRkfw2ZhwLAP3gBr?=
 =?iso-8859-1?Q?b3JrOnfAx7ldOx3+8/vuacOfcTOKbN6Lnq9kIePakit9Y0TsIEUg2YpQvh?=
 =?iso-8859-1?Q?eh8aN8dDNS9r7jBFqPooaLV8XqTNgHO2sfR5inen+B00fANyt5yvdCiz+N?=
 =?iso-8859-1?Q?ZIGHwpXxNxLLfSLq1EO8PctXh+szCIReOjRhoEX+kOAEogwMe/GAKGPAOH?=
 =?iso-8859-1?Q?2ro7XiUfvecIImYb4Up+XJ7qiXLS0MSe+DGR+sB0/XdCgpXvDlRlszB1PT?=
 =?iso-8859-1?Q?zX4LxAldACOV2aOzL4I7rBHofpmyeVienVob4VNVM4n2EjJ5gUYoahVlN/?=
 =?iso-8859-1?Q?pRfKAw46yYEiRGtizYLQTrHLFfbbrs1069EN4AccoaTU57IPLiuaKMrKJt?=
 =?iso-8859-1?Q?8ojOxqQB4BA2CaYLYleFIGiHIu2lkEM7UWiSXzXCfhN+TNCpVJRb9C2t+u?=
 =?iso-8859-1?Q?LeVShdUv4+Jh+47XJGhBtm6MdKTCiaYdSJPuYNkDvyn1PetfYP5wMze748?=
 =?iso-8859-1?Q?JPT79BUD/p9AtLJl9LAV8VOkIoJXxKKxMC+IWHdIw8ZnKxcIssWERVsWvx?=
 =?iso-8859-1?Q?kHLjryzFRXleSIRjRlP9QltBrnDVK7tt7pL6eve3eFEmZ+CPI9xGO2eKtD?=
 =?iso-8859-1?Q?LmD5CxE46ZktC3BkhbOHYONVL+0tDqgEoOO0wpwze6TpbZl+SI7UVkHYXM?=
 =?iso-8859-1?Q?dmigYGsG2jaA9h8Q6wga/6rRsMFGqN1LBuQXQEY0a4DHJHXLZxBR3F+qjs?=
 =?iso-8859-1?Q?q2csvhiKm/Y0WEBmm5KYzD6rGgWwRVX+hQEwRE/KIi/KPprwT/jn1DhWnS?=
 =?iso-8859-1?Q?bm6IXet0Pympvj3a0mcK4NqmkI9Jo/XNJOB+N/xLTpv7xI3u0w5lfKwQUT?=
 =?iso-8859-1?Q?dxhs15m3eMHkoSTR3FHmb27iy1yI5XX6wwTeiIsHsaR6PmxWzm6FnmanIj?=
 =?iso-8859-1?Q?0aXvhqV1xoOVU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd247c-83d3-40f3-5f8f-08dc70bc62ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 06:42:39.2786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7jkWZyWrKiVR3PzJ6j5wDIAisDyrD484ty344abMhAxMcNC/iGMnlO6/YZa0m6D9T55c0s8c7iOyPUQa2bpKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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

[AMD Official Use Only - General]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 10:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 15/22] drm/amd/pm: fix enum feature compared against 0
>
> This less-than-zero comparison of an unsigned value is never true. featur=
e <
> 0U
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 6d1c3af927ca..d439b95bfb79 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -760,7 +760,7 @@ static const char *__smu_feature_names[] =3D
> {  static const char *smu_get_feature_name(struct smu_context *smu,
>                                       enum smu_feature_mask feature)
>  {
> -     if (feature < 0 || feature >=3D SMU_FEATURE_COUNT)
> +     if (feature >=3D SMU_FEATURE_COUNT)
>               return "unknown smu feature";
>       return __smu_feature_names[feature];
>  }
> --
> 2.25.1

