Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4AAC001E0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 18:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAC410E1E3;
	Tue, 15 Aug 2023 18:03:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237B210E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 18:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb/MD/2La8QOI5NPpFt7OqXmuFdx8DDBbwP3bV2FRi2OklL1Pg8+LwEk+wvzsd02Yi20RY6knPgYQVY8H9Cjmr3BwqF5ZnQjPzBp5QucRk38TA6gf95rK6bIKTPAtnMxylTlfP9QyVaUMcWKlLZjp7wvExpDnkWAzMzk53rCWbfqtxOCeYOi2T15DtOVZ+p4jO7bfFAl6lNaC2AImg55Vimo0oyFAMVwUi5v7IDM3qNg97FYkyiblwaL/nTrERGnlr78vnr7qssqKV6L7BCJSXYd0hM6QkLq54sNDGxVcoNdhZfmpc2thNMDJDPN9cNo3MbKRdSZ23d9GkyDJu1A5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaN0+QeJoUWu2HwbXFc2dJfUte0Y7FInNlq4cnzmnts=;
 b=d55mLkLfQhGSC2KN5lpOqt7gx2GeuFkC6hVjXmNmm1o8Udy8gkogCB3GYAA50jSBwjdPJO8NvsvUwXueYIq5VLdqN19GxqG7QKwJPpOzrhhXIIZKNEDVJGSklHhvopTcI3CJ8tL8MeqPOc0DTAYX93W/q00ses9U7GjbIp6RpecYQmVsNKyd0C4SXMgs6gSLXVVxSYdfX8Q/Qs95OGqE516bNKVq+zREbe7X7mhZF+fR/H3eqou07FV66pkXJD2VBUoS+TLxyNy+wsjnvOmrjb64Jeq8KAd+uIYrP813UMOx1pmMhAKch7l/rmw9j35Eqo7Nb+O8rwHPaSrqGrVtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaN0+QeJoUWu2HwbXFc2dJfUte0Y7FInNlq4cnzmnts=;
 b=IR8tM9voKKbmwHs8NgBMNme/IATj0x94ABlwQMRP0Bk/l8ZTjOdlJz/iRsLB8CA8rouivw105+QkVA++n61oI1rKisUfsYyY7iFNiXmYHoIzqCTmkGyaPpfxQbEh4OIusjBD/7UpruOYlB2Rut6KQ2IVicgsGPsgIcU5x3Rkdzw=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:03:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:03:23 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Bokun"
 <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Topic: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
 support
Thread-Index: AQHZz5BWb8xkUx6DCES/fndZ4L8NhK/roM0AgAAFXFw=
Date: Tue, 15 Aug 2023 18:03:22 +0000
Message-ID: <BYAPR12MB4614E6A2747E8A1D8BE138F79714A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <b737e90e-10f2-4ef4-b49a-2eba5f83afef@amd.com>
 <20230815155026.197131-1-bokun.zhang@amd.com>
 <BL1PR12MB514470FC4AD4C833397FBBFEF714A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514470FC4AD4C833397FBBFEF714A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-15T17:41:50.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|BL3PR12MB6450:EE_
x-ms-office365-filtering-correlation-id: 45a99783-6670-4648-fdea-08db9db9ea61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yf6z3BtKZtyHCyMzW+FCmON/2919Knx6wsf8Vb3pyzNE59OUP0+SHEyBfKya691jygxiyOJLQLzfq8L9El5RpRn9aE2h1xOQzvNVK7gHUYiBN+Tq6Ax0+1iCWS8FtTFTK4HYDrPj2nA3PUibJncYsxMWxZ1LOBWumEHFFboqXX0JuNs86xU2Nb3sr+sMvKPAs7tDsb5OdohyZtiTdox8c3N7nDW9aV1LsS9uwn0YNDC2bpoRKxjTojQ/XlwaWqMsQqVoxaUV/6fFR+sGdgfzfIDufTdmYvBnpB1f11ACn6XYOsaAx6G0+143hg0B61oSdHjAuu7nKxeQxSa0wH7PPiQSs+5f4P6fzmqtSZDfCValQrv31lR4nE3ja88vekCchU50M7waSjTj+xpGnoMiRu+PhEztJZbjuugn/y9XbJ5aZBO+K7TzS6bkXLehMfdMi1OunVPD1OXW/9EKT0ZYSlgMeOOdpr3EjMN+aO4Xn3UpAOqrM5/+Wy3pGb6hy9xmCOczxjwsNRnomZcxPtK1AgxZhjFKNtga4lxra6becsL/BRD1youRZHeV0HLvJJNMWLTZLkDINRttIH0o6auHc/nlUPia/lvNuVKoPCqihm0nKCJUsEXpW2EZWxWyvGDb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(26005)(54906003)(316002)(5660300002)(83380400001)(52536014)(8676002)(66446008)(66476007)(53546011)(122000001)(38100700002)(38070700005)(55016003)(2906002)(478600001)(7696005)(71200400001)(6506007)(15650500001)(41300700001)(66946007)(64756008)(76116006)(86362001)(66556008)(33656002)(110136005)(8936002)(9686003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZF6WQVw+xYn0Y0vkjTQJvjPBijM5sJ3Za1wz1ij9gz+syNFkZXpBeCEIVuNd?=
 =?us-ascii?Q?nYiChGUniyBHH286ef14tDUck4FK2z+MH8szLUxpkeAJPyzhUs/AeD4xUIZD?=
 =?us-ascii?Q?TEqwu66gxG3zr1fQ2Sh/v4PJWPp+KstJJpq9pJOMF/nlHF2H91dZhBpRNn3b?=
 =?us-ascii?Q?HAzKg4QN6FrCFd7EQHuiiqLQLmIws5PvKagHObH66e7sKQtaxcmeum88FR68?=
 =?us-ascii?Q?jAdz3hUC6oHbkLjR3CHXSjCJx5R8FXv1wnuZLj3PQ3q9CKk6fVpTurWLF4nN?=
 =?us-ascii?Q?OD/5ErZ/6pztJ087VjQvEL7NTYm3hfagLAOuqvHbQ7AWRRGG4KHUB/1mO2Pv?=
 =?us-ascii?Q?imM+eeNMxtcDjM2PX2PMwalZAlgV4F2dD/04N81cBAsr36TcP+gWbWmHUPpI?=
 =?us-ascii?Q?Tefq8eX9TGq9C9bBn/0/eL+TPAhNP42pLSJpHcOmWsxTA+cDpmjR94jJ1h8j?=
 =?us-ascii?Q?3L6Tu3IfX3nlSd6aD2DbyeBCnAegmc9YWZuorp26LzihUqNh/lIyd6VqGhEm?=
 =?us-ascii?Q?MJZ2BPrsF4bFe75XSGdWXg6Jzk5RvjzPiOEDeOtHlT2YPBnjgLKF6ybJahho?=
 =?us-ascii?Q?et2QeL4w4ibuTWnI5I39rBlDQi9FN276wn8myq/h2tDNdBW/rxoJT3TzU5Cb?=
 =?us-ascii?Q?k/qoPc8JogSyAMiaUHiER0LHKQ7/jnCSzTexonZ2GyINWH4dx1R3zY8TlW9l?=
 =?us-ascii?Q?FIivYsXtB2KPsRHCaVP95S5THrUJWCW+4EXdyry+7qU7B4cHSFIGQpxKPOgI?=
 =?us-ascii?Q?RYGcVZNUKA3sSE7/4/4KBRFBPkQg+QjaO0KjatBQO4j22k0yC8G/gSUXrWc/?=
 =?us-ascii?Q?gSptSa8w84cEItCWJsPpj9NTP5aChcbVagjIXtjzL8Bh1hrjRWFlN9sbGg7l?=
 =?us-ascii?Q?nPyKxANUnYAbp66DZB1Q5zDR0/n7L44lODtbE5h1c175/26tUAXDNwgGXu78?=
 =?us-ascii?Q?FtJEaK/Y+bmomQxTIjmt0Oi+du34YPu/j5BtqKSC+fB2I84STlkBTMFq0Bj0?=
 =?us-ascii?Q?cY2KNiM1o/zQV4uHFR80X5AzLa5xFGfKG3t/pqS2TaRC3XOhPiBVXwGIyQ5b?=
 =?us-ascii?Q?WQiqABJoV3dehDuYB4cFHpG26NNSPw7G++FOEbb+FIqRhtNVwESU2EaAG1Rw?=
 =?us-ascii?Q?rq3IbdbGM3qgzZUWpkBE/CEn3wuWuHTYlvZC0qPjkVmNUlW3xen7yL2jGbHH?=
 =?us-ascii?Q?7MzRZ1N5nrda3b+8zxheHeqCzWlWtOje3b55jHoGPEATRTGhpq4usnyuwakX?=
 =?us-ascii?Q?TnAD9Qu593tW7hxEhm3cOdMLOhk1dVRsPJosCN4Kz3wiND7dzTPrBWmRD3ZC?=
 =?us-ascii?Q?tXkQ28DIkyH9A5Z3nokFs6cM7SEWeSmqL02OjaoyCWPBxJOaQlFDNreqWXXJ?=
 =?us-ascii?Q?TuqYSvdmyOGR/01QCjH1xpI0qlcqdlY92145PwDMFmTiu/UE1p5VNMZv6UUx?=
 =?us-ascii?Q?3IM/ckp6KlQYoJEEICkLBa6nea6BRvRNci9blzcyDEuKVImYqzHrvplYothc?=
 =?us-ascii?Q?cNuWxXjG/NOPDLF/vH0IZj7Djd2NXKo5QMek92gfaYBJyHtdHEb3lWKvk6fM?=
 =?us-ascii?Q?kh9kcdTiPeDWWwoEegIxV4iY2oABERJcA/yAROC7?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614E6A2747E8A1D8BE138F79714ABYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a99783-6670-4648-fdea-08db9db9ea61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 18:03:22.9834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zk0FM+nLjenHXkheH709ShFGnOREcl0vhqpWOalGiTCkly/6tuE2Uh3al7p+wzX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614E6A2747E8A1D8BE138F79714ABYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

There's already another smu callback - notify_display. This can be accommod=
ated there, no need to add another callback.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, August 15, 2023 11:13:14 PM
To: Zhang, Bokun <Bokun.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC =
support

[Public]

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun
> Zhang
> Sent: Tuesday, August 15, 2023 11:50 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC
> support
>
> - There is a DPM issue where if DC is not present,
>   FCLK will stay at low level.
>   We need to send a SMU message to configure the DPM
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  | 6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              | 5 +++++
>  .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   | 5
> ++++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h               | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       | 7
> +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h                | 1 +
>  6 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f005a90c35af..c65bebdbec11 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct
> smu_context *smu)
>               return ret;
>       }
>
> +     if (!amdgpu_device_has_dc_support(adev)) {
> +             ret =3D smu_notify_no_dc(smu);
> +             if (ret)
> +                     dev_warn(adev->dev, "Failed to notify no dc support=
,
> driver may not reach best performance\n");
> +     }
> +
>       /*
>        * Set min deep sleep dce fclk with bootup value from vbios via
>        * SetMinDeepSleepDcefclk MSG.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 6e2069dcb6b9..c8fdc3d0aa25 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1356,6 +1356,11 @@ struct pptable_funcs {
>        * @init_pptable_microcode: Prepare the pptable microcode to upload
> via PSP
>        */
>       int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +     /**
> +      * @notify_no_dal: Notify SMU that there is no display and SMU
> should control DPM

Fix the function name in the kernel doc comment here.  With that fixed, pat=
ch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +      */
> +     int (*notify_no_dc)(struct smu_context *smu);
>  };
>
>  typedef enum {
> diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> index 10cff75b44d5..e2ee855c7748 100644
> ---
> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
> @@ -138,7 +138,10 @@
>  #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
>  #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
>  #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
> -#define PPSMC_Message_Count                      0x4D
> +
> +#define PPSMC_MSG_DALNotPresent                  0x4E
> +
> +#define PPSMC_Message_Count                      0x4F
>
>  //Debug Dump Message
>  #define DEBUGSMC_MSG_TestMessage                    0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..f71fc99447f2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>       __SMU_DUMMY_MAP(AllowGpo),      \
>       __SMU_DUMMY_MAP(Mode2Reset),    \
>       __SMU_DUMMY_MAP(RequestI2cTransaction), \
> -     __SMU_DUMMY_MAP(GetMetricsTable),
> +     __SMU_DUMMY_MAP(GetMetricsTable), \
> +     __SMU_DUMMY_MAP(DALNotPresent),
>
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)        SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..41412cf891a7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping
> smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D
>       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> 0),
>       MSG_MAP(AllowIHHostInterrupt,
>       PPSMC_MSG_AllowIHHostInterrupt,       0),
>       MSG_MAP(ReenableAcDcInterrupt,
>       PPSMC_MSG_ReenableAcDcInterrupt,       0),
> +     MSG_MAP(DALNotPresent,
>       PPSMC_MSG_DALNotPresent,       0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] =3D
> {
> @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct
> smu_context *smu,
>       return ret;
>  }
>
> +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)
> +{
> +     return smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent,
> NULL);
> +}
> +
>  static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
>       .get_allowed_feature_mask =3D
> smu_v13_0_0_get_allowed_feature_mask,
>       .set_default_dpm_table =3D smu_v13_0_0_set_default_dpm_table,
> @@ -2680,6 +2686,7 @@ static const struct pptable_funcs
> smu_v13_0_0_ppt_funcs =3D {
>       .send_hbm_bad_channel_flag =3D
> smu_v13_0_0_send_bad_mem_channel_flag,
>       .gpo_control =3D smu_v13_0_gpo_control,
>       .get_ecc_info =3D smu_v13_0_0_get_ecc_info,
> +     .notify_no_dc =3D smu_v13_0_0_notify_no_dc,
>  };
>
>  void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> index bcc42abfc768..9b9a13fdcef8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> @@ -97,6 +97,7 @@
>  #define smu_get_default_config_table_settings(smu, config_table)
>       smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP,
> smu, config_table)
>  #define smu_set_config_table(smu, config_table)
>       smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>  #define smu_init_pptable_microcode(smu)
>       smu_ppt_funcs(init_pptable_microcode, 0, smu)
> +#define smu_notify_no_dc(smu)
>       smu_ppt_funcs(notify_no_dc, 0, smu)
>
>  #endif
>  #endif
> --
> 2.25.1


--_000_BYAPR12MB4614E6A2747E8A1D8BE138F79714ABYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"" dir=3D"auto">There's already another smu callback - notify_=
display. This can be accommodated there, no need to add another callback.</=
div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 15, 2023 11:13:14 PM<br>
<b>To:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; Quan, Evan &lt;Evan.Qu=
an@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu/pm: Add notification function for=
 no DC support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf =
Of Bokun<br>
&gt; Zhang<br>
&gt; Sent: Tuesday, August 15, 2023 11:50 AM<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Zhang, Bokun &lt;Bokun.Zhang@amd.com&gt;; Quan, Evan<br>
&gt; &lt;Evan.Quan@amd.com&gt;<br>
&gt; Subject: [PATCH v2] drm/amdgpu/pm: Add notification function for no DC=
<br>
&gt; support<br>
&gt;<br>
&gt; - There is a DPM issue where if DC is not present,<br>
&gt;&nbsp;&nbsp; FCLK will stay at low level.<br>
&gt;&nbsp;&nbsp; We need to send a SMU message to configure the DPM<br>
&gt;<br>
&gt; Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
&gt; Signed-off-by: Bokun Zhang &lt;bokun.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 6 ++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++<br>
&gt;&nbsp; .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h&nbsp;&n=
bsp; | 5<br>
&gt; ++++-<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 3 ++-<br=
>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; | 7<br>
&gt; +++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/pm/swsmu/smu_internal.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +=
<br>
&gt;&nbsp; 6 files changed, 25 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; index f005a90c35af..c65bebdbec11 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
&gt; @@ -1410,6 +1410,12 @@ static int smu_smc_hw_setup(struct<br>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_has_dc_support(adev)) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D smu_notify_no_dc(smu);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, =
&quot;Failed to notify no dc support,<br>
&gt; driver may not reach best performance\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set min deep sleep dce fcl=
k with bootup value from vbios via<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SetMinDeepSleepDcefclk MSG=
.<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; index 6e2069dcb6b9..c8fdc3d0aa25 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h<br>
&gt; @@ -1356,6 +1356,11 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @init_pptable_microcode: P=
repare the pptable microcode to upload<br>
&gt; via PSP<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_pptable_microcode)(stru=
ct smu_context *smu);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * @notify_no_dal: Notify SMU that ther=
e is no display and SMU<br>
&gt; should control DPM<br>
<br>
Fix the function name in the kernel doc comment here.&nbsp; With that fixed=
, patch is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_no_dc)(struct smu_context *smu)=
;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; typedef enum {<br>
&gt; diff --git<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; index 10cff75b44d5..e2ee855c7748 100644<br>
&gt; ---<br>
&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; +++<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h<br>
&gt; @@ -138,7 +138,10 @@<br>
&gt;&nbsp; #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A<b=
r>
&gt;&nbsp; #define PPSMC_MSG_SetPriorityDeltaGain&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4B<br>
&gt;&nbsp; #define PPSMC_MSG_AllowIHHostInterrupt&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4C<br>
&gt; -#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x4D<br>
&gt; +<br>
&gt; +#define PPSMC_MSG_DALNotPresent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4E<br>
&gt; +<br>
&gt; +#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x4F<br>
&gt;<br>
&gt;&nbsp; //Debug Dump Message<br>
&gt;&nbsp; #define DEBUGSMC_MSG_TestMessage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0x1<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; index 297b70b9388f..f71fc99447f2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h<br>
&gt; @@ -245,7 +245,8 @@<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(AllowGpo),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(Mode2Reset),&nbsp;=
&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(RequestI2cTransact=
ion), \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetMetricsTable),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GetMetricsTable), \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DALNotPresent),<br>
&gt;<br>
&gt;&nbsp; #undef __SMU_DUMMY_MAP<br>
&gt;&nbsp; #define __SMU_DUMMY_MAP(type)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; SMU_MSG_##type<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; index 48b03524a52d..41412cf891a7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
&gt; @@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping<br>
&gt; smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowGpo,&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetGpoAllow,<br>
&gt; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(AllowIHHostInterrupt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_AllowIHHostInterrupt,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ReenableAcDcInterrupt,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_ReenableAcDcInterrupt,&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DALNotPresent,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DALNotPresent,&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT=
] =3D<br>
&gt; {<br>
&gt; @@ -2601,6 +2602,11 @@ static ssize_t smu_v13_0_0_get_ecc_info(struct<=
br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +static int smu_v13_0_0_notify_no_dc(struct smu_context *smu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, SMU_MSG_DAL=
NotPresent,<br>
&gt; NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static const struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_allowed_feature_mask =3D<br>
&gt; smu_v13_0_0_get_allowed_feature_mask,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D smu_v13=
_0_0_set_default_dpm_table,<br>
&gt; @@ -2680,6 +2686,7 @@ static const struct pptable_funcs<br>
&gt; smu_v13_0_0_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_hbm_bad_channel_flag =3D<br>
&gt; smu_v13_0_0_send_bad_mem_channel_flag,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gpo_control =3D smu_v13_0_gpo_con=
trol,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ecc_info =3D smu_v13_0_0_get_=
ecc_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; .notify_no_dc =3D smu_v13_0_0_notify_no_dc,<=
br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; index bcc42abfc768..9b9a13fdcef8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h<br>
&gt; @@ -97,6 +97,7 @@<br>
&gt;&nbsp; #define smu_get_default_config_table_settings(smu, config_table)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(get_default_config_t=
able_settings, -EOPNOTSUPP,<br>
&gt; smu, config_table)<br>
&gt;&nbsp; #define smu_set_config_table(smu, config_table)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(set_config_table, -E=
OPNOTSUPP, smu, config_table)<br>
&gt;&nbsp; #define smu_init_pptable_microcode(smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(init_pptable_microco=
de, 0, smu)<br>
&gt; +#define smu_notify_no_dc(smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_ppt_funcs(notify_no_dc, 0, smu=
)<br>
&gt;<br>
&gt;&nbsp; #endif<br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB4614E6A2747E8A1D8BE138F79714ABYAPR12MB4614namp_--
