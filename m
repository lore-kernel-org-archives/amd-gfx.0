Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF471C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 08:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553FD10E086;
	Mon,  1 Jul 2024 08:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CWmg5yM1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED0610E086
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 08:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFRHu84kC441G+4YcI9kZIugxTSzhNWy4jptltpim3eh1Z1KMFsiIv3qjzPtZf2yAFyLCb0k4tGITkzk42oswcDPYiBWPfaTac3v284l4/IlRszU8n9dJrR7hk8C1BynaxGzDXRrpLyeicnddZ7znURE2o9Lr/lLv1/CuvHMf2Aza0qkYGJ4fiw3cKHPPR8HDRZfl7epQiC57lGJCUXUNeGpbkzoNiqvbx4Ggfj0GwaImHH5gfTM+ifouj1jpm0CYEbSzm23Pt5FJKjMqEjSOO4GR2MzUu+Y/fkZnwPC4RJSJLeBh6m/X3OOQEksxSuVyiB9hvclQBQeFj//JlRsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY4r0BBkl5PbhA3pvnj7Ou915iDKMZw86kWYenAZlk4=;
 b=P5DyUSQIWyOsAUUZUn0ANkfHdmxhLOaBEft3vd8lu2Lbyrl2/cWcYrmqeDcA3QZMyflFXLats4fQrYuZ6YMn2iM6bCOIX2T7f/wY/ApipRJ2ol8lKkIHCTKz/LdoT+wVubFZvcENAjoj+1nizxZROuZ0AGnFo13m1D2QQ+8Buq548JCbQ9XFqKBLQIGMONMgxX0klgI9vY1vDJGVT+ofaEPDcSRlq3Q6W72KQ1aUDY5A5e1I06bXKJkW/UEwx56TaWXDhTX851FJtn8Am7719YmSiuFGfuCKx4iNGmItvOOUsJK8NfWC3IkDegdDBNpEkacpCNcxHvJaSlB0/VIpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY4r0BBkl5PbhA3pvnj7Ou915iDKMZw86kWYenAZlk4=;
 b=CWmg5yM1MnT54DOgTy4iVT4YUoNbPnhm/+FPB2wmk+HEQB3dS/mHbrpr6yeC0uMokdLDr9ZmccWcp5HvxLT38Gc2XPvXASV/qk9AzvAsGDc5AplVW/Pa+wBESbHu9aJcYBSbZRrMZd3ybyWQom7pzkVsyOIdlHq90lI7p8RZuk4=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:00:47 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 08:00:47 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: sysfs node disable query error count
 during gpu reset
Thread-Topic: [PATCH V2] drm/amdgpu: sysfs node disable query error count
 during gpu reset
Thread-Index: AQHay2WGodmb5TbLikCqkVd/a5cpuLHhbJeAgAAWI/A=
Date: Mon, 1 Jul 2024 08:00:46 +0000
Message-ID: <CH2PR12MB42159B6276E6BF34A41B7BCBFCD32@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240701031921.10239-1-YiPeng.Chai@amd.com>
 <SJ2PR12MB799035C37872273C1483E3549AD32@SJ2PR12MB7990.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB799035C37872273C1483E3549AD32@SJ2PR12MB7990.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4fd7e3f3-1a4e-493a-9ef8-686658a6cc69;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T06:38:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DM4PR12MB7525:EE_
x-ms-office365-filtering-correlation-id: 652e093e-f053-46f8-df19-08dc99a3ea47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YvUxEk/1LIk5SoGOdssIvEayHp+2sLxFjc7ZLc+v3ttfVX0Jbz8HX8Ww8ALq?=
 =?us-ascii?Q?kpCrsnthT760ee8gVf6AzHFGCAhORSBmknTgFm2xJ2VSCibOYefVtTQqk/B1?=
 =?us-ascii?Q?HBFQ436INhJhUZ84Qm7nKshJlY/6FkfrFVpKPbM/0K90LQqgrk0hvaFXeKOB?=
 =?us-ascii?Q?n3Cx9AsJMYufQmRVdkYuoKqQyWb2jYg0KFGgEoK07RTLy0pcqm786RtMnHE0?=
 =?us-ascii?Q?yJZzRHRQbf56A7a1dHMBM0iHYIdrOeEqRo5jofnFrtTXu+vrEf68hlgx10Nh?=
 =?us-ascii?Q?KtCIrJ/qOMvxA+busRJ38aVuiI/OAyJfGQdV0Yltikv/37xBSvRFg06Ccm0P?=
 =?us-ascii?Q?9w/IkheM08x4zAgkrqRB47ztDw3UFh2dkl6wc4623oOaLjgadWR5pZEBU0ii?=
 =?us-ascii?Q?koXse5GtwtzyHJQu0x8SkDhqbdRj3n/5MIIl82tn1l3E1nsqWugeQsch/bZp?=
 =?us-ascii?Q?KbzmweD2WpJemcmwO1zSxthPQGjEaBCM7oyESaK2M5sW75aOwzxjCfkNWZJr?=
 =?us-ascii?Q?T42gmTPvLh5SIBtdkMJEkIKQw3X2DvBTvN8XDa1414Mr9HiUvDIX7QX8BTle?=
 =?us-ascii?Q?SgVaTJ/am2UiRLRh1TEk4QQ+CVh3SSwfE0CA+77U/AQT8R1J9FwnA0BK5zRx?=
 =?us-ascii?Q?BcSuJtZn75uQLE3MaTdtXnQnIv1/MXpPC0odE08FBKClvQeHd99U3II/sLoE?=
 =?us-ascii?Q?A+nWFTzDJrUU3CYCW35A7p6Ns4OKJVeV7GEEsFTwxK/h8WS9o7p6AgeqbK9h?=
 =?us-ascii?Q?sQBHxvHXbyB2C/Lbm5/4yOcu32vuvGty9SumIikug6jVRhaYT7Q6NorlPu1Z?=
 =?us-ascii?Q?xAJjfLGa0uCwKpmKe8yTURh3i0s+rer/zETC0WZrGKklDt883Ec22ZdLNPPI?=
 =?us-ascii?Q?Z3uZd9t6tDzseQ7X0emjyM6Kq1dWNTavHPeEmG6UTjYF3zSuoF6LPJ4q/Kf/?=
 =?us-ascii?Q?h17RWDzY2ChQMC/j+DI+qm4tpTCTKV65futWqhI17aHqlibk/VzR6RITZ6vh?=
 =?us-ascii?Q?2FaEVdBaP/Ln9Upw6L1JRmgc0U7a1ZzbS1crhP6cZ+uez+Mu0fY6V/Dmmu7f?=
 =?us-ascii?Q?JThnHJZ6W87cwbAk1jw3T0ZYK/VJMciroejTKyXvbdQkav24k+EKfao+Hee6?=
 =?us-ascii?Q?uwzhhgfCDuZgpkIGEwVZ6HyNaJMv/qrPnC9kNo3LXw/EEWDYety0rrAAxbDu?=
 =?us-ascii?Q?WUvpcSjuNWCFa4ITBtD34XpqrTtgdvLWFMhHqrK3rXsNAe1J/kGOEv40IwYk?=
 =?us-ascii?Q?3JvNgX2cv6M8cdT1gUkvtJD1kL3XjDy0pCNKBQ4f1hSH1YHYu3DZKl6Hi3QY?=
 =?us-ascii?Q?cNw+P1aTEW0eG4A97sAByg8/Yjw1TAsT9KhJik8mSY7k4x/EtSBhCWfeu4g1?=
 =?us-ascii?Q?wt0SsrsIpeHcKOO0pZMRtldcL8fC1MPC7j3SOr503zqgWV/eig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wxgCsdi02DkMaOZIPmJ02124rSv3MMV0nzbhe9mf3jINpqtdlqW9p2q7+WkX?=
 =?us-ascii?Q?AJdoA/O4t/zgX3B0az4ZVKZz3IoJxukTD1DpKHMBYAeUqes/kVtgK718DGxQ?=
 =?us-ascii?Q?C6kirHMKue2xF/GOZ9nBMyY9F3gNkrz264+I7kktKvOMaFC5c14BWhaBNp4J?=
 =?us-ascii?Q?aHC4taR8GGymfen3zWzrWvrkZGvxaDHtxF5IjsPl3zKbhz9Km1Ysj15qNC5l?=
 =?us-ascii?Q?U+DpO/DspXATJFY83lZz0gtPrNrls+5abLa0l8qISJpiyxxt8+z9pnGveWEh?=
 =?us-ascii?Q?Cg5HzJiG9+OoG1uvYNW++QGuO2li4fXoPAl/mNkueu1Vnyt/lrJTS/d/p+0z?=
 =?us-ascii?Q?dBKNT4M/DtMWG+gsVQSnnwnkYEud9fp3RVqfnynIl0LNf2YeUf3DM6vhUslo?=
 =?us-ascii?Q?/V0tZ148g7Z+vJL5On/2ykGyabCiTF6J4p2DWuzCbNY7/xhja22PCEoyc6O3?=
 =?us-ascii?Q?onwxuUARLn3rZZx+fDlu0P9u6TYxDjiADJHZQvXKApzhfTjCmFilnb0mPSrZ?=
 =?us-ascii?Q?pouS6vs9uOdeAVFHfosf9FcsM8ZpIx/bZlhkWnEhBrJWtj840VLC5g2D0Fmq?=
 =?us-ascii?Q?ZAJ6Y+tuyjIN2Xc59YTPIEN/w1/BC5cPPi3ee3Y5yamMdYKrPHbioXYjLw2H?=
 =?us-ascii?Q?t7eJsre14Oz4XFKnCuPH10v+ZlWLEUYn6YaAmaSlYfiTs1dpwVQ4Z8w6++hh?=
 =?us-ascii?Q?dRrRxfAYl/a983xYe3cLtC0UsQesQhpYlTxu9uPgLE+sM1+zwO2zq8gzOJLl?=
 =?us-ascii?Q?vMucXy4Hytos5OtmfAHtfGIe8/NO9EJth+84TbjzUUHjzIpxY50RgWBlqQvg?=
 =?us-ascii?Q?6QiyIvAD98yXOV2QF/LgJ+AUigqex3L5u4Kb4fgdn1X2QQrlpCig6+yb6yeD?=
 =?us-ascii?Q?x03QF5r4EFjSA9M8f9jHCTnJnlqDzKHXyVdunuKuSsWlueZXk8LoyC5zO8gT?=
 =?us-ascii?Q?Hd4n+k5bQYn8VWXTLZ52H2HCzFOxJ7T5BU2TdfbBT6aqAsrBCVp0Y7W7dxrY?=
 =?us-ascii?Q?e3L6K8a6WV3jzjeJ8cfKhPfYwh/13kPEJfXxavWhjhCw7rOEzpzm/GexRzIY?=
 =?us-ascii?Q?EiMUIeDZw2VR0V6TMGd9vGFDzqHs4jW7suCFmg4WogQTxovxNCDs/wVAKhn4?=
 =?us-ascii?Q?2O+FGraCd3kpGbgzkKrkbUa38gqejMXBvnn6AG+U2UMDVBHrTuoewgABeVz7?=
 =?us-ascii?Q?cnuBNY8p6u794PgCcNq2vkclz7JQbDRe8fjTjYdRnzmZAouojdcHeusYK8L7?=
 =?us-ascii?Q?KMv6PsOytHNKI2iaucRX9YEli5+KW792j1Rb7VIMixWFS6epAOLIUu1o8zAp?=
 =?us-ascii?Q?5W33zA/nh6VNArV88i11Q3hWsny0vppdjuH8mz8FY8+AG4TAp8XmMuDHlaK8?=
 =?us-ascii?Q?s1Rd60edb24MNzFyBYX2VihBuiCIiphZdTV0GUiyP/XWZzzs6eQ33FYML4K7?=
 =?us-ascii?Q?VuZEHCJlK7ZrfJUn/76tRh7RnDCo/hPAEn62e9l+Glgt61+T38HereGMW4zZ?=
 =?us-ascii?Q?Yk7v3jR6/xFZHzHNxlULpNYFMWI4eQqOcmL7dhreGAORL04zyc71eXOz+1rT?=
 =?us-ascii?Q?v69izNgOkQ9xxeDTIdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652e093e-f053-46f8-df19-08dc99a3ea47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 08:00:46.8867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zf9bLpLZs+X+8pcC6zo7imxNkhIvdwNIPH55sv6HpvpJwczvropbQ4wfPuxMzTFHtUlB9N8eUqB3N7badzTVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

[AMD Official Use Only - AMD Internal Distribution Only]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>
Sent: Monday, July 1, 2024 2:41 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Subject: RE: [PATCH V2] drm/amdgpu: sysfs node disable query error count du=
ring gpu reset

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Thomas,

I think we can optimize the amdgpu_ras_set_error_query_ready(adev, true) fu=
nction calling during GPU recovery, amdgpu_ras_set_error_query_ready(tmp_ad=
ev, false) -> recovery start -> recovery done -> amdgpu_ras_set_error_query=
_ready(tmp_adev, true), above process can avoid access query error count du=
ring GPU recovery.

Regards,
Stanley
> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, July 1, 2024 11:19 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2] drm/amdgpu: sysfs node disable query error count
> during gpu reset
>
> Sysfs node disable query error count during gpu reset.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ac7ded01dad0..a65b5197b0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -619,6 +619,7 @@ static const struct file_operations
> amdgpu_ras_debugfs_eeprom_ops =3D {  static ssize_t
> amdgpu_ras_sysfs_read(struct device *dev,
>               struct device_attribute *attr, char *buf)  {
> +     int ret;
>       struct ras_manager *obj =3D container_of(attr, struct ras_manager,
> sysfs_attr);
>       struct ras_query_if info =3D {
>               .head =3D obj->head,
> @@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct
> device *dev,
>       if (!amdgpu_ras_get_error_query_ready(obj->adev))
>               return sysfs_emit(buf, "Query currently
> inaccessible\n");
>
> -     if (amdgpu_ras_query_error_status(obj->adev, &info))
> +     ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
> +     if (ret =3D=3D -EIO) /* gpu reset is ongoing */
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +     else if (ret)
>               return -EINVAL;
>
>       if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11,
> 0, 2) && @@ -1290,12 +1294,19 @@ static int
> amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu
> ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct
> device_attribute *attr,
>                                 struct aca_handle *handle, char *buf,
> void
> *data)  {
> +     int ret;
>       struct ras_manager *obj =3D container_of(handle, struct
> ras_manager, aca_handle);
>       struct ras_query_if info =3D {
>               .head =3D obj->head,
>       };
>
> -     if (amdgpu_ras_query_error_status(obj->adev, &info))
> +     if (!amdgpu_ras_get_error_query_ready(obj->adev))
> +             return sysfs_emit(buf, "Query currently
> + inaccessible\n");
> +
> +     ret =3D amdgpu_ras_query_error_status(obj->adev, &info);
> +     if (ret =3D=3D -EIO) /* gpu reset is ongoing */
> +             return sysfs_emit(buf, "Query currently inaccessible\n");
> +     else if (ret)
>               return -EINVAL;
>
>       return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue",
> info.ue_count,
> --
> 2.34.1


