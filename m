Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32CCC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 05:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765B5112A28;
	Tue, 16 Apr 2024 05:08:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wK2HcDoP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CBA0112A28
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 05:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYnLOCQSWQFGL92bVp8TTQUbB5Q7oPbrvHfrJLCvwdGVo4LVJcc4/ovjAVEHv/EM6zbxX1N65/ebolCwPpmSQsYxngOWhot87rmpoasGIJSpVYJ6XdvgZruvOXSIJCzMLObsHC9BuMN7ecLiLyh0LCTw8+NbcdqpFVVgcnHp85fxhTay4r0Jfmq0ESCvGTQ47FdJWaWzU7ZcaLqLIeKGkIUeUr0KtxPxT6vUVZw6Tmq/mZiwkOUybKRJy+2rwNIcIZhwbqNlfabEYx3WyiItWLULVEYB6lktuyh3u4dm/9PNKkuo/Gd28ldImGiAiOqjJHXGcmXLWO71Puo3nBzXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnsdXc0xF3ir03ttGOyqGtJAqhTzrR5sYeRDlySUf7E=;
 b=Op+3V8zWu8jCQEcs6iaycwcq+6qCU8SwWlBlI/940GIykDk7yx4WVoUwm3tLIGRIIL/TXjl8gzLc6ug//yXlPuICpHdbZ4tAFec0F0+UE2PSVKdBy5gmsaFfojTydGgLB1apKFxSeDhD15gh6sU/k+xo5Nq++Z+k1SRJvW9nDCSNicLs3dqJnBY+Gm1QItx6NXlCK9+mmT+ylbwio5/cuXgToryxh5UGLVQfCp/Tu5Fp+yQ5yJuT2TkbqtORxoqHvEF85NB/8EWG/B+QVmR28oXalPzLPrztAqgkOfpiYKiK1kGdI70mhJgGlPbITZqaf0VDxU7F9OPa3aokKNXiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnsdXc0xF3ir03ttGOyqGtJAqhTzrR5sYeRDlySUf7E=;
 b=wK2HcDoPssz9dbUd+sjlJAg6Dmvag63OnlyqbgyXX88M6fNnyiawj/RR8IFx7l5tNfGLIZomrunlzrvzSFmp7mw9h+NjfQstQ80Zp/EieKT2CilRaNKTM2oc1gzfim4gQV8OKdbBfGKbC3OFsl6HST66xxxVGkNAJWtLPF4v/mM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 05:08:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 05:08:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
 handling
Thread-Index: AQHaj7dXHG5s506KGUiUAGGTaYM8V7FqWLbg
Date: Tue, 16 Apr 2024 05:08:21 +0000
Message-ID: <PH7PR12MB8796D4AAD895AF7D58906AF9B0082@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240416043402.987-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240416043402.987-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1fc3c7a1-ade4-4191-a943-4eec1ef3d016;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-16T05:08:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6279:EE_
x-ms-office365-filtering-correlation-id: cc2ee295-50f7-45df-bbcb-08dc5dd33c97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pbX15xOx2AKy0Dw9oTASNdd6F7CIJmIWYSYHhAqGlrF7PexKs5RR8uHEis5eQoMwbCRkkpUorgAlvLPtPwFpv71zFgmStXUM6csDY+dypQ1EVBWckVA/mtYM625ZyLal63OCa/0qSwdtQZ4vHprTcV5IFRB1nC8wuxgxgI81qxJGGTR5tj4WFxqJpYNO5V8SXGnbBp5bFRd/V2J0aOaI424um38vP7KAEpwhrD5lW2VLb3YINCKTMSiWgT5BrLyDFqT21ve6MA2JUeJuw4yGdLW5OuCtDsrv2+OW/KqzeF+EK8liYX6IhCoyzS0ZSNoLgbGSBW8Hcx2+GnoqreGs/queWsgi/gQmAgcZkfjB3eg6u+gaguhYJETPCb06uGkArY55q/0foErg1myt1l43QB95j68Im2SqGvX1eJNcuP8CT/rwFK5P0HgeRmSIrlVgE35pQvAM0uHCecg2lYnyCzWitpmUOPaL3sYO+dz2GatdhUQA08WPNUV5teoj/PsloJnGUq4tEvdexwrl3YO306Y6adARO6m2d1Bwp2xcGtn5+hVHiN4Q1/uY2/VGZKeJCEVcmq8YLOOa5bKIWEo4r+qtWmlhFeSZMcWrkd7/QbGCUwnJY3NV2Q1yyx/O7mGUqAWrNVHTSBUgi6xHqL+6M0xFT3Db1q+Wqzt0O8TSkjG7128EOgrtSMY9DlYS+gKDrWhP8Yy87Ak/8G0Fl2vNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pdLNYO0/aPF9Q5rlBmFKbLR7uWtTuGFkgp6l3Rz8lNpelVS2a0tqMNzlzNGW?=
 =?us-ascii?Q?mwrTUkECrcv1do/XHHUSzGXTqG0P5+/oTi2p+9HPX8NAJgG6ihip5o9Cg3j9?=
 =?us-ascii?Q?37QalJ57e/JLF+3MdBS+GDcCLTN3JaY71JLl8MfTdIX3PiUG0AGCJJyTQfR8?=
 =?us-ascii?Q?u9fwxurEIUK2H3zKWsh3uDuAsSwuyciHEDWthUx19zTrcn/LXzwmisf3+zuq?=
 =?us-ascii?Q?efviAE0nCa5J5wQtaTMVrKEnY2c0oUnd7OyGPonzxqW8HGP05KL4nmvK3SW5?=
 =?us-ascii?Q?ZBb/5vYE/hA8NSzguyOztwXQVHa3pbIkriZbNAr4ZZcT2rRDXrWhFiLdSGQW?=
 =?us-ascii?Q?Wx7Bm1oJa3As0+2dSwKhlfcFryF7dGTjfEs3+axf/WRZDPLLVcKu/8fFydk4?=
 =?us-ascii?Q?AXF+x5EcDwB5q/CrXSUxG3m6Zye6Qa6d1Cvx3v7vz0Tf0/7Iszvez2mXu2rf?=
 =?us-ascii?Q?5aPjD8xACi79ON4UFnUJKFnGp7TZ1GXptJoNUpLY+iwY1EZF/jECVikF0LUJ?=
 =?us-ascii?Q?dSX0yuPsjBd5HkDWAG6V1jvAcjPYSxXPU00MVa/XN6kuPYtI6/RT2CfEItG8?=
 =?us-ascii?Q?OuVn9ULw4aPbNAD9OVb3Vx6mX+TaB7Istu8lVoMf66rPFS9G/TEeuT6cY2en?=
 =?us-ascii?Q?fsDWCcCc+HZHaTmwWboGsQf68NzE6796KfMAUtx3UsXhj0B/FX+m5pW9mh2E?=
 =?us-ascii?Q?BBpELkAYmdrgy+CaW/H2/aZiw1lpSfgN3/jO8DOmnv56rHK7o2l2+RiwvFK6?=
 =?us-ascii?Q?QH8CrPoTgsTrezl4Kn2F5gAMazXSHMtlEY7JvHk2p7pq9VvYmnrpR4FXDQ0s?=
 =?us-ascii?Q?FR+mFPKIA81mm1F4UbkC/lKkYmpa/ty5x7FqofAi3geudkFLe/dcDjpd+cT9?=
 =?us-ascii?Q?2+GgO4gWFR173CXfdVGd89B7RWc90t/p4hqcw42VyUysqmGY6GuSm/gAHE0Q?=
 =?us-ascii?Q?v4sjnvM99gsma6/uIvhxuqUXMbFdvwnAt++BfhSS4PyxXhFi9ii2tBgKYY84?=
 =?us-ascii?Q?9L71sAaEW/TwgLv8xv5VhelniqArI+AUim6lIkgUJrwrPNqVbpKIJcajA7nL?=
 =?us-ascii?Q?ioKVI8UqxsBMttculCFFi1ybylZIZp0BZdpcrXQgLxotT1Iuvs4NBPtOEYwa?=
 =?us-ascii?Q?ycNVYeYXnT300BlmbKUPIxMn5idR/rpnNRwpM+N92gOzVKT7SHM3b/mwRo8F?=
 =?us-ascii?Q?QJQgS5V/1kEXdybY//5+0v5WdjCumE4Kl/NwC0ECEK/tsg6Ep8P3zexKTgc0?=
 =?us-ascii?Q?XQRToRtXXpj2xrnAlLgpUdUQXeEjbA2brKQzU+9u+DcUeWaSSVD0/qfIdrzg?=
 =?us-ascii?Q?Ht+YETlDyMIuepSe/FTbv06mPz5hDDr7NqAwIvWcPWL3kuCvF5Hw/CpUdgNU?=
 =?us-ascii?Q?NepYQX4o3Uq1K72J4jeq+e1jsRwSmXb0+Xiji5klUR6oWYzz2/OqhTWAsssm?=
 =?us-ascii?Q?nhXhHGJikJUnMVg2y6CXYYMEEs5YE+vjNrFVEw2Or7tlM+IGpdlITHWgGjJL?=
 =?us-ascii?Q?X79cyGUIfr7veeycT6jcJ+vELiiwqcPQ8277SQsq44GnBxUN6dxIGGUxAojB?=
 =?us-ascii?Q?aka0ZlufB3muwCeyfac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2ee295-50f7-45df-bbcb-08dc5dd33c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:08:21.5386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4k8+HphRklxmjaEy/KCGPdClRr4p5WduOZs+n6teJADaYQ+r+gOEeCjIvDHjFl2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, April 16, 2024 12:34 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison handli=
ng
>
> mode-2 reset is the only reliable method that can get GC/SDMA back when
> poison is consumed. mmhub requires
> mode-1 reset.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index c368c70df3f4a..b6caf6eda8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -163,17 +163,13 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE2SH:
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>               break;
>       case SOC15_IH_CLIENTID_SDMA0:
>       case SOC15_IH_CLIENTID_SDMA1:
> --
> 2.17.1

