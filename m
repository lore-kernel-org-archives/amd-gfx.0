Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1159EC3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 07:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF8B10E0D4;
	Tue,  8 Apr 2025 07:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gc/0X/nv";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1960410E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 07:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs0jklKLDZf5sklho2NKlFKbWWaYjkpcxeNeN1d81+Torid/H/kkah2Tye72cOMcg8h1pd9KF4qFbZwxFpPq+GZzks4twQFkaQYyChJDJ+RJuxVabKaH9mxRaDWC+MYcTWYteSXJlfOTIf9+WZnnew91Cy89vIYnmU9vorM8bDDtbuPxBpHUP85d58swAM55oWK81lY6d6qe0f20td3/NzW7REhN50IrkJ7nxY9G1ifKpKIIt75SuifxWYY93uQZMUnvKtsupc/ZEiZ8ibFMO99ljty94fmafFyb1D0Kofvnhg0is8jpfrOBVQtVj4+FCZo+gSZkuZtAog6Fmyg45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUCQllRD7i9VAxvaZc2yntSfCLw+M8oJv3fnkVZQrFE=;
 b=BEVaXxTfIZ/WUnWiB9czBaUoMJP+eanu2pc4XqksQhlMiJXKn2uEUCw/oY+vZhaIEfZKsGHTjTwvSx5rcldwis/ZXEty8ZUWT9YxwS4nVkHZIQTKUHrSdJp/LJnIJoXSIwIhRzUHuKtI6Si05fs60cLG0yfD+9rLNblajAQCe6/6AKGOdqKI/s9IfwRB1d8m7iMDB4cz7BKdo8+OF6DhEGAfXqw3Sw1HgUlNtcWA/a3/7XOj2eOot6DaRbPekDfmFjZTjrnn75YXqj4AmaGZkczPL0tROcyQlWSmwC534x5H9gBh6AS/SGyAMJ+nXVmU4AbkA2ZX2uBLbizYuI89Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUCQllRD7i9VAxvaZc2yntSfCLw+M8oJv3fnkVZQrFE=;
 b=gc/0X/nv8KJFKQeU9j10aYZYnBNOMoQe4bhPhFzFKTLL4nthnmvm/Vk+mSIzXSTp1ycI0ooz2lr4npYYmWyPvnv81skNKjeE9PG5jVT4vseHCly4UY5xm8JLCKePmxt5dVSOH1thowHNgRpHYuqYZjvOk08goC4RafN2j+YCI5g=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 07:15:52 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8583.045; Tue, 8 Apr 2025
 07:15:51 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Reset RAS table if header is invalid
Thread-Topic: [PATCH] drm/amdgpu: Reset RAS table if header is invalid
Thread-Index: AQHbqE1rQKTSK6W8gEmX+mrHCt7RQrOZW32g
Date: Tue, 8 Apr 2025 07:15:51 +0000
Message-ID: <PH7PR12MB8796D57F3EE5C0B837070280B0B52@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250408061339.526898-1-lijo.lazar@amd.com>
In-Reply-To: <20250408061339.526898-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d07dde40-9425-4264-99e1-617908c2184f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-08T07:15:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CH3PR12MB9147:EE_
x-ms-office365-filtering-correlation-id: ac9a10a1-56f6-4424-4d56-08dd766d3208
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JPqjCc4+FBNm+KcWAYr+OyjCNac9pQScz+kHNeYwTRtXDiyS27uJ76pi67pQ?=
 =?us-ascii?Q?4c3iSVJxszzuDIy8KmovBmbfYxtzrnvt/W8Om7q+waJ1vNZ+7WH95zKJXH/Q?=
 =?us-ascii?Q?uIXJJzpcCGkFnccgmJTqJibWxBbOt7JLbvOXi636XzF/Hr5x5BQqXiFh7nOb?=
 =?us-ascii?Q?KDhm+ZuZ3f7oAa6HCESWGJErLDImyMsIS6BUCy62D0Eh7ZA8uPqaRtK4oEJE?=
 =?us-ascii?Q?gVAZAoG8MGZo/n/hYOrEPxD2umSIwVuBYKdVpIUxkLiwKYP275vXo0xljOy2?=
 =?us-ascii?Q?FStJLXL+YLcULtvtS87V1FCcJXo2WXo87MS3QsmKFoa4B4DDm+qlYmcXZrA0?=
 =?us-ascii?Q?pTwos6O0tPBaue1onmWnwJZBPgnpmgoJRVmdMj59J2r/dK6GnlRDH8VyFuDY?=
 =?us-ascii?Q?pI2fwGj/sUkrMeJKZQafWaX7XHUzQpM9vfffnkAckIG1Sq4mC4M0cIlFbeHT?=
 =?us-ascii?Q?8ek0uCcWux+EpUpCDl8G0x+37V+SQuJo4I9HLXYd286luflDLrD7hd93fFx7?=
 =?us-ascii?Q?kD3XXUbIHf4lWRzT1cHNulqH7xIJG1Bu7BWe2LuKOXhw4kcpy0EkPvDx4M2f?=
 =?us-ascii?Q?8J/IyDljG0BJ0/3cFPz79K3uEjBnehD00Hw4IL+LCViEycmfq8n6j93EPn9D?=
 =?us-ascii?Q?qfy9al7C1imgWxQInS+KWi1wRj2S6GSJxhP1LREdOzUKyL3AkqRVy8ouTkl7?=
 =?us-ascii?Q?3loUF7E/ZX+9PY+wBJQpYcYo3exhPiKGQQ8YsiJv7kWDKfOD26CqwC6hJDkx?=
 =?us-ascii?Q?nmcyJqhIfInGXu1DwcyjiY0S8pktrvLHLDeSPy5JAWGVB95PyOlffm4Fge6P?=
 =?us-ascii?Q?jV3m2qJDVOO2ayo0xIRwRMvMmHTPXLW178OcK2whQVGtMJ6UgtVgvxa7z8XN?=
 =?us-ascii?Q?v+RiMpIvKD2Fl3cE3lkhFo9XrB7r67IiM1uOT3uV3pixEGU4qYfuA+xTosx3?=
 =?us-ascii?Q?7E3HTJeHQvQja/h94h/7y1Jqx8ud8Gu3hSgp/Jd26ts0lWx/k5ZTQqPn4P+Y?=
 =?us-ascii?Q?WqUIaIB/k7XyUPNf/hUx7Blezw/LkOb1gdp72ntt7QSCaZhrvGA/QTSSpg3j?=
 =?us-ascii?Q?8d9ZsI38yp2RyN/kUsUNpkZzHczF0GxytNIkVVaqaa+1tzHO4KV3zr4cJMoK?=
 =?us-ascii?Q?MQRUuvK+rUwLOVo2/unCOhYuv5hD7SlFcEDhCBgCGddVoUSaI1jKwOSQpr6Q?=
 =?us-ascii?Q?hoNp/HcQdPTu8g4ofUklaA4H3+Zvuc8PEBl/rL5CcisYM0pMpBLdbpZVzoGz?=
 =?us-ascii?Q?LFi29NiwpCTa32QAbDXPhquXyL71IjMD/o9EjEHPN+C88KrWP8LbPpIBqAVL?=
 =?us-ascii?Q?jFHvdTDTIk2DBllssKhsh8lguNVBy/3Y40F0wNfJWvLdCVB0k+QAiN9loPxj?=
 =?us-ascii?Q?y7/p6SXLSTz0CUE4pAfuiC2Tbui3NaLWct6bq97t5LQZaBQRIzPz7LjaBK/8?=
 =?us-ascii?Q?3S74LL1Yzua7YIqcY0tl35qz1GGUufVM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eItxfO/LO04JsPShgnCVoDSbeNe74ddCR4ZT+ruf1DfvW6LMYGw4+w1SbpUG?=
 =?us-ascii?Q?ycvLnViuggfHkb+8B2asNqkiS0P2ln9B3FNMHhlOdiDFU2+1NbwYzBtaynWU?=
 =?us-ascii?Q?1W99XldpgMukJCk+xf9laH2XF3m9gHT3gAc966M8FU3foqjzGe936Lf74wE0?=
 =?us-ascii?Q?ZZLjifH89Hvyc8SLQZNtpUYEb2myDweY1P9cIi3OckBJu3eKFE4WnPr46Meu?=
 =?us-ascii?Q?dMqj9B1ab2/UfYxkiU/RiUzpIUO5rdj2RGj8Bc5klhXoj8OcEtYnuJ8It2iw?=
 =?us-ascii?Q?SVNsmetSLbQKSCQFZ3fz4PGnC1iv9P9A2S8VfVqzABXO0ULwq+S9pXyJTmSK?=
 =?us-ascii?Q?iX9cB+0ACCo2QEZ6NZOEeCdxtguYR6kq7612vU7LX0JF8RgsQHUwEKOqCE8x?=
 =?us-ascii?Q?ybL7pgNQmKDc2rVXB5nRMyENVlKSFROS27+vTcl1M2EyHyg6P8os9gYXEi9j?=
 =?us-ascii?Q?tsykip6jEY5Vui8OuNklPqOzuzK7oUHmqiR8/oioJTgg+nsPzHqC6AMZKJjd?=
 =?us-ascii?Q?oeRJDgxgdljYqIBVCq2FbU/LBk4tlo7uLSSrUBe7MeK6rhklLChHM4mz7X1b?=
 =?us-ascii?Q?gYwtq4bLen2QntKFz+Y+f7BGh287/fa4xwQiaPWDnSnhOy/SDvROr55nBBya?=
 =?us-ascii?Q?Og4JduoU2dV9j2urM7oZYnpgRaLp1qtRBL8pAV/O0NnQXHP46+t1ejYwCZoY?=
 =?us-ascii?Q?7vPLX3RbyULXqMEOvSa0atiM+/emlyJBKunYt9ihb2tAdRv2ovUYcgOwuqxx?=
 =?us-ascii?Q?7/DF09COXgJQ5bwFGVVOXYemPBmkYjZneyHKiFQPnMQjxUG3dirxDbntja2E?=
 =?us-ascii?Q?AJOQCNFBPQSY+dYN0hxBDI85UCl2wfV3D7hj8xIlezX9sXKdl2HjPhkpTiBt?=
 =?us-ascii?Q?EsStarIHbQNvKFv33e+rCfg+j8rbKCBCAfsXG0dAs+VmfjuUGZ9St7l5d3iC?=
 =?us-ascii?Q?/SHYhFhapIB3g8BPM6FOrAVN4euw8k/dYbH2Vhc/cQdWKXbtDt+Uo8rhccc6?=
 =?us-ascii?Q?CStNMLty9D5SoDUX5ZB27YkU81RWPC4ek+Y4sjddA53AA1P8GIHsYGBFK/YS?=
 =?us-ascii?Q?/5yGH/JWRERgsjl+j8wuPfS1gP9sNlDJHFwUwCEg2OP90lauJYXSp/ef/BMz?=
 =?us-ascii?Q?77iVOJlRt+GUYYe90JawXR3LlmsVkd+E8wWaRsXwMciO8lEgCC5k8lw7DlI0?=
 =?us-ascii?Q?FbpgWwND+NcvzWHgvWnx+FPHNPOvvJfQURuTEgFFE4yaFuIwEMnYn7m1yEhU?=
 =?us-ascii?Q?eLVfhJgGUHlO1MZ9kpSdFbgvT+/gHPPp08h3DH+NFViSPwnUlUSgUNeV/KLC?=
 =?us-ascii?Q?hEW1xmJUoWQAMUpJGERYjZV+ee8EpbpXsm62x+010iFG2cdOAE26aFK/RkPz?=
 =?us-ascii?Q?MztnY24AtELmoDp0ZxdVpksy4CokxGnbimf/JFzp60XDLvzKphqR7vbs8dIK?=
 =?us-ascii?Q?DV+3xTnSK1jdfRwj2BlHW6xZ+IEKc1OagloSiOtZVbnHwPta/DDU2WxeHV39?=
 =?us-ascii?Q?YV9XtU+d8RBcPO35OKtlxaI8OtJaIzdggRWnp5htW6oaBW0kfkZf9rhm36HL?=
 =?us-ascii?Q?3M7+D69hir0cIVDDoBA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9a10a1-56f6-4424-4d56-08dd766d3208
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 07:15:51.9035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8nclaJpTOMm1MFaX4u39lTcSB/Eg0l85qqImvAQLy23CoF8WObDbG/I5Frq8yc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, April 8, 2025 2:14 PM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Li, Candice <Candice.Li@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: Reset RAS table if header is invalid
>
> If a valid header is not found during RAS eeprom init, consider it as new=
 and reset
> RAS table info.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index e979a6086178..bb767fc20242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1392,6 +1392,12 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control)
>
>       __decode_table_header_from_buf(hdr, buf);
>
> +     if (hdr->header !=3D RAS_TABLE_HDR_VAL &&
> +         hdr->header !=3D RAS_TABLE_HDR_BAD) {
> +             dev_info(adev->dev, "Creating a new EEPROM table");
> +             return amdgpu_ras_eeprom_reset_table(control);
> +     }
> +
>       switch (hdr->version) {
>       case RAS_TABLE_VER_V2_1:
>       case RAS_TABLE_VER_V3:
> @@ -1510,10 +1516,6 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>                                        "User defined threshold is set, ru=
ntime service
> will be halt when threshold is reached\n");
>                       }
>               }
> -     } else {
> -             DRM_INFO("Creating a new EEPROM table");
> -
> -             res =3D amdgpu_ras_eeprom_reset_table(control);
>       }
>
>       return res < 0 ? res : 0;
> --
> 2.25.1

