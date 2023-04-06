Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3CC7618D
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 01:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823AE10E0DB;
	Thu,  6 Apr 2023 01:33:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD39C10E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 01:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRC8kQomcAPi1m/fo9S/jWNm8n4IYlFjQHhPPHk+Cu4Jw1qGILviG8X9ogdKMm2Z9CekGowZsmtqVueNrNayqrPUsi028H7GqylbLDv7tPXEZkv+HwqareWQbubQ3C8m1U68suqE2Ak6JNe0HQ/MCsEEVTlV+sSTqA8zA4tqubYLE91FuBxsFw2iGOVLiylK3XTdzOkeL7hCcVfr0iCqdR9LjkVyTYa7y5G5SD/Az9zDmSXZB382W8AZ69d34oRfW0xJmfaa1ajz3Rq+w6eN+WcMNtU122eXmlrpHCi510Thz50SaGekoDzAxeHEJ164IRFWzkwhGKRaXuktwZWhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiCg1TEW62R/cFU8kUhrU1Ii+qbLXA6cRWKdNQeC648=;
 b=LAIrCioQn1TCYPSp6tZZTwghYBJE0AWJAnexLnklAAtodf1NGePQjFN53e6548x0N2WEBXobYtrj2R3PCmXew7JaRfMPB5bL5TD3npfrXbNoznQqvI0GQITIfdRhD1oz1S6CMFUaCCIkLNMl5eUByUdDBzNajH/697hEPG00tk5TIoYgloDUQNIztrzdYV22Zmy8eVw8EPES61O1qDnWK5BQ1RE7YhoGxpaYRSuh4tDNcUZsmVlAJLRpliuAtVd3zw9Uu+75uvDnZoWHE1c7T8FCXp+NgSJizAed8oFiJZl7HAGypkkQyxkKqpejzZmNohAvmcOE9/M9/Ee2fe4OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiCg1TEW62R/cFU8kUhrU1Ii+qbLXA6cRWKdNQeC648=;
 b=fVttRt6vRNKmPygz4wETYNyFLwHJEu2ezcHl6OtGIzYhO4Oaeeot+Wun6crYjWsm+rIvHPeqyqBTYYyvl0vPpG3IRW9gotj9wHKnRPlrXcFEjH5Doy0bAmK2EcRN4iNYYQeUDEWAT/DTr8cgC4AtS4Q4msihtsxX+QynDQ+Jwd0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 01:33:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1%7]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 01:33:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix warnings
Thread-Topic: [PATCH] drm/amdgpu: Fix warnings
Thread-Index: AQHZZ6NyAoGIK9wXnkGknGgbKvhmr68dgDRA
Date: Thu, 6 Apr 2023 01:33:39 +0000
Message-ID: <DM5PR12MB2469C4097EC87663CC07011DF1919@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230405094540.2935900-1-lijo.lazar@amd.com>
In-Reply-To: <20230405094540.2935900-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SA3PR12MB7832:EE_
x-ms-office365-filtering-correlation-id: 40fef6e8-f4b8-4a7e-b7a6-08db363ef30d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aG0Qt+3JNhHZmiztnVZjslz1ki2qEm0f8rMwdT65WCL5+BBHYY8NEbWBM1+3L3KKxHg98RBEzLa1/2ypD+h/YwF0CP/cNiKKbCUpN5MAXrCGLRumyJ17Kc2dxYzP6uuQtGajB9KcB0qCGIi3zdCTZ/iiavqs1W4yX+BItnHpSTP3ph7bRykOjV3txSTyJy1FbS1e4AsasvGoeZU9myI6wU50hzLn7SZ2TkHRQ61UeFL5Kv1umrIyTa4OZFjVaifImNJYQdD+dnjCPEy5lSf+sChKxOgNeene0Wakws92ra9mA5NhICloFGf5AD6tua23NG/JJuL+geL2NXMgwM7W/RFTcwVQxqxyP5pj2D0HG5DbrgnEopfdR4+gsHu5RcBuN4kHtJaSj9yP1tzgSioXF9DiaBjhO/4fOwqVCWWUuhdde9Siyeq0srwX4oguatRbXMHL8yaBbsIjXVsg59p3XsKMnP1BKKsfdkBfHilkLijzSrHDggZyRwSzL000vLfgtjn3EizgZuF5z1etR9rhpYfd39OIOCi0fwnSF2Ed6OxoRjhLZXuQ6dumfFGo/TJqsw5n0/NJgUhPVu0I16SN3jxmeNO0MZBiZitiwZVgnd0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(41300700001)(33656002)(186003)(86362001)(9686003)(53546011)(6506007)(55016003)(26005)(5660300002)(110136005)(54906003)(8936002)(316002)(478600001)(52536014)(66446008)(66476007)(4326008)(64756008)(8676002)(76116006)(66946007)(66556008)(71200400001)(7696005)(38100700002)(122000001)(2906002)(83380400001)(966005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTJ19KJF/dfS1so2bRDRSmT+z8cbGbMDbW0mcuSTroBShWmzQyNaSm6jqamf?=
 =?us-ascii?Q?FxzFzEQmI4xG2xVSizROrCOlXo8r2L/pJ0UDfezPrE8awG4V8oLLn7m85aVc?=
 =?us-ascii?Q?iZay1xY2g11w0Cp2GdnMKZ7mPc7FCEsBdonUT7Mjl0RTrtWNL/PVaNa9ub6r?=
 =?us-ascii?Q?evW4Ro6k5T3u4MbfsIDkdKst9XJyPQ8j1fY47DIL6WQnnGyFkmIYQFrKwli7?=
 =?us-ascii?Q?+bqysVhZRxab/ILgd1pd9xXCcAYAvkWU26jPUO3jQSJDZTf4T+JxJvG8lEdq?=
 =?us-ascii?Q?REt87oCoIpSsb+dUWHwH1gF2fUtkTMVzjAdcE+Q0g9VPHgMUxma8LjcC2prx?=
 =?us-ascii?Q?EjJ/Sld3yTWp8/K+QmofzmjxWzeD7G9ygm7Qk8IOXXW5hXqBY2XU0bxaqF0a?=
 =?us-ascii?Q?ez1vtWEuwDx46MDDCqv0UnJIt+Cfz4NCwtRLixS76aRdDhb/imEsZxqb2P/a?=
 =?us-ascii?Q?xeMF0zw9eqkA8gOqFikLmyOBYz04PIjzW88Kxu1XPFQTgaRNCRU1IK5Ad5cB?=
 =?us-ascii?Q?EqHIEk+ATKBSA5KwJT+snTirLAUcp/OwkeVK8B0VckoOR+LsjEJbYCwmoQq7?=
 =?us-ascii?Q?TbIPpJAwydufq42Gb5qbV1F05h7sKiaRIBtIfHlY+fIo/fTZEp2vXY/LK41k?=
 =?us-ascii?Q?RgGa0ZX54tg5fDEDELExkJLkmYdI39NGkm66Zs+vqmMK01c8tYhRd+c1R1RT?=
 =?us-ascii?Q?tqVlTZD3WeBdbd/3UQM7gj5A0l8tF7S1OJw+OHYOdRWi17LvsAi+6dorXdyR?=
 =?us-ascii?Q?kx0uPgZseRACMcfOFhr9fA/DRPROsfsShY2sI4jqTmlRY8edxVki0XiYta6u?=
 =?us-ascii?Q?gLC6WLSB+U2ULl7ma8KoNXxTBepOBy7X7IryflI42Ntp17hhjTv7bJaxH87b?=
 =?us-ascii?Q?fHRlIg27wpkB5JhBu0yxDhLwVwJ/XcB6NiAgpvcL4XwWdIWc59i8EQjzfRb9?=
 =?us-ascii?Q?lVMZf46gBp4CVmNbLZxdj/8KjNovx63fXoDv7M1A56wzirOhSd+J7pdxLY+p?=
 =?us-ascii?Q?DwM5n3Uvdaoc054skg9IAUbK8G3mRr8q2ZGa+k5Zb+MMqozgZgYI+s+P3H8N?=
 =?us-ascii?Q?fCWVpJ3N4B584Cbm2ef5aVdj0yEZx4WSxZRPnAYRLJ/pSnxGjpMF1uISXBsc?=
 =?us-ascii?Q?vPrE+amXaUTYuy2mhAVhbfmVKpknDGcbfjpVr0Qot6eCxJUH30vDuAzeHO//?=
 =?us-ascii?Q?70s4gPI6iqu1zONOM+mmcc5GW6ju+wF6sMDLVDycUp1IVJsSxCLko7J3qy+Y?=
 =?us-ascii?Q?TweQRpYZyW6ubOxcl7Zv6+yxmVQGRepmRsNhPRMC4N3ZZr3CIjbgGOwER+qT?=
 =?us-ascii?Q?l7aWHpmN1ZSUZweMvIu+XOQuVCkC98uAzM/WuqZTFcdPTAv3jQ3BLKsyv4VF?=
 =?us-ascii?Q?vcWZi8mC84QuDb/sGuA/3q3gfN/xEAZZs4h+Nje0f4eO8hRSXYHtJivnt8dm?=
 =?us-ascii?Q?H5WsMG1JkdZVLbjH1/6TofeXUJ829kjZ5CQ5bO5f/YgrUgXgopzUDigUFEAU?=
 =?us-ascii?Q?KnCcWKxyDPuAddvsfEOK2+PT4aztqF/c/toh2Y0SsIUuPdWw6HytrYASMUcv?=
 =?us-ascii?Q?AxHjbdM2JJtkuA7zGA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fef6e8-f4b8-4a7e-b7a6-08db363ef30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 01:33:39.6262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5auhyXMHl8RS5Pe9TosjrcY0LlkmUXPNB9QUGEcZGMgn/ImBITbBW8rAwwOItEWH4YAjyam8am/50FGDJH1AsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Wednesday, April 5, 2023 5:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot
> <lkp@intel.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix warnings
>=20
> Fix below warning due to incompatible types in conditional operator
>=20
> ../pm/swsmu/smu13/smu_v13_0_6_ppt.c:315:17: sparse: sparse:
> incompatible types in conditional expression (different base types):
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303082135.NjdX1Bij-
> lkp@intel.com/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index bbac4239ceb3..376d14de7602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1241,7 +1241,7 @@ int emu_soc_asic_init(struct amdgpu_device
> *adev);
>  	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs-
> >flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))  #de=
fine
> amdgpu_asic_invalidate_hdp(adev, r) \
>  	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs-
> >invalidate_hdp((adev), (r)) : \
> -	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs-
> >invalidate_hdp((adev), (r)) : 0))
> +	 ((adev)->hdp.funcs->invalidate_hdp ?
> +(adev)->hdp.funcs->invalidate_hdp((adev), (r)) : (void)0))
>  #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs-
> >need_full_reset((adev))
>  #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs-
> >init_doorbell_index((adev))
>  #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs=
-
> >get_pcie_usage((adev), (cnt0), (cnt1)))
> --
> 2.25.1

