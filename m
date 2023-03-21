Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEADC74A5B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 13:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A0710E0B0;
	Tue, 21 Mar 2023 13:08:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1476110E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 13:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj5flzwDdE/aDlui0O8i77Q/nLFyksRwFT88YpP43lHbBijd2pbxdyFgCEziTKlKxzJnsTwD9O2KzkuphN6bRbOtI2KxkQy3KIJC4YvgoC25tULMBedEDeHLmiR+PhJsZiFKCddEHD4iGJJSA6LVLX2u0zBJiQxxc5n94Q99UjUeO/XKCBDgyjnGgky/ofg0g/I0cthV4Ls7umy5QjHq92hpPTOdZkt3LqrhN35Qxddfans0by+lvUSw/1epaR+2lGuWDTIn2ca4zN+L5GJP0/dFJ63vB7lhWP/fBCr/ybnh43c90imCeMviQE2Artr1dPSm1mEwMsyzbDcSuxNq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYgCJ8SKn5FzmSNDGZwr9jpRcxLllGJYQKzPix6cTgE=;
 b=LhOluaGWJM6X+1Z+iEitsA1rmp7e41EnTFsJUdFH9TNYeQXn2DHfs17+fEcMoCoYn5V5v9FUU5osYzEDcclbA02/Rt6ZVlFdQXWNN+D4NMfVIOzNkUNrd+TdHDM3IYbCPA4HmbA2jLwXvkChK0PDKKpLTVcAT5Q65NZyyEo5QXVzYocNi9So7pP+d/9JdCCSSoCPJ5bQqC+iFrLGfy2BMibpxgB2A0wu2cz4l07lEHbSUqB6/5KtyS5GyIGaeieu9UUptls6JK7Unp1i6Q2XxI4e1QeBj4MyvZtw1LMgkNxTC54tPjyIJpoKUqQYtj/aosJ/vi41Qe5dF2Z87kT4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYgCJ8SKn5FzmSNDGZwr9jpRcxLllGJYQKzPix6cTgE=;
 b=VGKJBDaHQIjTN2G0SG8A1VEhXh1eSneYng1Lq29QoaDTmbFxKTF50HMo9FAoU3R1z/pHZcrRV1HSXFfnKaxXj8qLn5ccBRYDqLQ0FGpNjqDcXuQI+11vLRUzFgaT1hFOAzrmzVQzwbjGMtPnDx+f3OyyeU78b8TKDJzaCJJwkY0=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 13:08:44 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:08:44 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: resume ras for gfx v11_0_3 during reset
 on SRIOV
Thread-Topic: [PATCH 3/3] drm/amdgpu: resume ras for gfx v11_0_3 during reset
 on SRIOV
Thread-Index: AQHZW56hQ+nkXEp0sEeTKPENsW0hiq8FNMww
Date: Tue, 21 Mar 2023 13:08:44 +0000
Message-ID: <BL1PR12MB5334AB2197DD2DA30CAFC5B39A819@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230321024020.139199-1-YiPeng.Chai@amd.com>
 <20230321024020.139199-3-YiPeng.Chai@amd.com>
In-Reply-To: <20230321024020.139199-3-YiPeng.Chai@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-21T13:08:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22db5db6-3f7f-4d28-8001-58b671f44b36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-21T13:08:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9b31b1ae-b616-4bfd-a087-93c016b6f1ec
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|DS0PR12MB8296:EE_
x-ms-office365-filtering-correlation-id: 80b40ca9-7bad-4c72-9c4d-08db2a0d6678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /i8/Lziho65ZbPaWgQYviYdz/TedY/9PUhTW9ICd6tCrMeb1qCy9/FdZnV8Uw7oOtGiJ00TWN/QBI/U50uMZGZFjhi+gIoTWW6x8+mUnHblhiGhwLeW8sjLH+dOVUx3wnB9eCR8tpAtq7R+ix3Dnt5BI/A992GXU1Ndjn2cvW7ZCz5ywVc4EQefsjEKEfZ7OSuHUqAnLcWcRcj6ratUiOLhRgmNpN5oT3tOW0VfEqS50cRUjeIJTv1c0LpBHerjHq44AxW9OzZLhH5NyPz6BwSGO/iGRHlB0DzIkJDzei+uPtCLnWIR522YZ8Cik0IirLpYUPvr1WNdRernMqVMdZ3krIoCEubhZXCavta/zwMPOrGLCHJM+3eu3IZx6+Ic8a3HAOWi6yv5m2ajcRXepwdRu8qxPZAS2p95psC4Ji63R6/3yU+yHWUnddGoaWDdhgKn4dJoQlZheiFy2mUc5str+6adBvPbOM/Z/7U4a427JhkEYFMbNUV3GemZcXIVqi1uzALA7rCHsVSySQQkOGKIemrNr88/xIFVWKYYIdM/SSI6oaB8EpvR6oi6OceAZHxh9HNMqM7c9rn8cFaO2y7pLDDdpGvY4MfwQ3MSUnoEM42DQmguzpk/h6bTZnzg0GE+U4JFgeyH9H2NX84W4eeOCjbYJIz76floZtHgh1GdTC09HwRrY+Mp4zeZ/XXGPPAph0ZQqNL5SBy21AscDnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(9686003)(53546011)(38070700005)(6506007)(26005)(186003)(71200400001)(110136005)(7696005)(55016003)(38100700002)(52536014)(478600001)(2906002)(83380400001)(86362001)(122000001)(66946007)(33656002)(316002)(54906003)(8676002)(4326008)(64756008)(8936002)(41300700001)(66446008)(5660300002)(76116006)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hb4RqEnulVEAMzSJi4FAc46agx5I4kG1BmqJ7jyOq8OAKEkZmceX6I8jqCZj?=
 =?us-ascii?Q?hcWXn0LvFDfqYrUlAyx7Y1VDESG2IvnV2nhTMJrnYaINksEZnwyhKYFZHCyX?=
 =?us-ascii?Q?C2973KlfXyorKaobdMR3ghAktyWJ37LNWasWkayWnpM0PTBTDyTZzRy+DkBF?=
 =?us-ascii?Q?fXiOFYfWsAX2J5yrzJP2YeHh88iUSFAc8D3HNNNnx/M69UeCRiNYkGAwLkfC?=
 =?us-ascii?Q?HNMi56v4MCMM7HfUwaeWO4CuKQIuliZxsYPztRNx3ROSMzpPhx6RlL/Uc6tu?=
 =?us-ascii?Q?i31EB1hL5S/Mp80qOaL2XKOUzujD+7Ujl4RjfOHNlc2bsLGKbS2vKlROo6f4?=
 =?us-ascii?Q?8E8Mim0kq+xoy44qEAKhb9U4qszlXvq8RcUhBkJsqF5mMpveqsU1omlz9SOH?=
 =?us-ascii?Q?jZQqPaUpa/eIrmk0qJNmFQbQBMoPGckhw3/SBl5tXSHMxyhnxvmDdwpGp02L?=
 =?us-ascii?Q?W4Hxm3h2bv3T3bwJeUynoxb3Wg8mgY/FUnehCdSFhEMeJIhzAC7YOFX9OS6X?=
 =?us-ascii?Q?nt/KHpmqU8XBLuu+TwWTh1Z9eF9eu7qIV9AYr0rG6WXaNLMWecDtgXcNc+BM?=
 =?us-ascii?Q?YO1v2QHvhtzNcXOF11ZXchkvyoNBvlUWoQZ2YzZVafdOgUmRi1j7h5zZU31e?=
 =?us-ascii?Q?uFoNJO6cCbfgBmmhxKPalBZx8cUf0D0qfGKfF02m0NsQQnz+KRR9wOlgQimK?=
 =?us-ascii?Q?v7+bBPBgzC2wiLQ75xaDqTmLxJOryybLhp1zIo4rqk99i8lFCM1k3QSg5knC?=
 =?us-ascii?Q?K/SwCYwGdcPS6wCt4ItTvmz7us0IOr4xlsdEM3m2U+8iMpTX6I0Kc2pKFbD9?=
 =?us-ascii?Q?44SQebTSGhCS/MKqYWShvKtzaPLKDEjnLrfz2ME5KpLxXCwoDdq7tGxy/3N4?=
 =?us-ascii?Q?89RziVTYzjLbRq03vrazCn/ieiTwfr3+itiaZ9JAXmygECXyCSz5x0GuK9Qr?=
 =?us-ascii?Q?c0JFN0SHyitgykA4FCt+Z36zbKEvUjmyVeCxMPhsyd9CEVDEgGmXTSR483gJ?=
 =?us-ascii?Q?BG838pqxRF6V7vD0JghG3CzIvEp4i8H6jAdV3s4XwKE/VJWq0j5pTOExTtgi?=
 =?us-ascii?Q?5NQI4Nz8SwjUnOGQR4bhNjtU3ha2d5nemrKgEfczgZbdfcMlqdcCrxro0gdt?=
 =?us-ascii?Q?biYWF/skkqRvDhq3NIDlMttLZDGyGyhxkUEzlefr9rsCDuaFz79FfQgJTOd3?=
 =?us-ascii?Q?cK59jioAXvRfDetFJFHhZUnUOqWzpti33YO0Op1Zg84oRrB0HYbtszYMmlt0?=
 =?us-ascii?Q?SbGrC1x0Cq3JMcj9HCALSGTxdpTHWqJIybKRHFKbyxxJ2/PfmAuS7/jpmWTg?=
 =?us-ascii?Q?udOtlZaFkdKlsyOmPYQ22NivCy3NJCxUtUfeVfKvo2uEMwVNLH0hsgF6+9bQ?=
 =?us-ascii?Q?ZOIzeUpxu6tdRwO5zPak5tXw0GAQSq5jfC06DqIImDalba2sscuvyy8+O7hp?=
 =?us-ascii?Q?f3OF36YQnB5d2keDAtwlr0IogecAcvBEAvd20rrKQS23WixARUg5Fq2Jt4Al?=
 =?us-ascii?Q?4/9rCvUZ/VobqhWPxDEd/WQdkj/GUFgrEWaFfLNU72ydeVfwpr1AlD6Z5pKw?=
 =?us-ascii?Q?PmLkVJyyF4YtHKA6qPY9pEdPaupesdhouH/S6enR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b40ca9-7bad-4c72-9c4d-08db2a0d6678
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 13:08:44.4554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/Qre4ZJ8Y9nqhpcDiZA5LclWn2OI96IF/Gj4m4PZvqiW8N8StcpmKqR1uZF9zJ474BryDOiKXY1ddMWNDo49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> YiPeng Chai
> Sent: Tuesday, March 21, 2023 10:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: resume ras for gfx v11_0_3 during reset
> on SRIOV
>=20
> Gfx v11_0_3 supports ras on SRIOV, so need to resume ras during reset.
>=20
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d74d05802566..14d756caf839 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5313,8 +5313,9 @@ int amdgpu_device_gpu_recover(struct
> amdgpu_device *adev,
>  		if (r)
>  			adev->asic_reset_res =3D r;
>=20
> -		/* Aldebaran supports ras in SRIOV, so need resume ras
> during reset */
> -		if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
> +		/* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need
> resume ras during reset */
> +		if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2)
> ||
> +		    adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3))
>  			amdgpu_ras_resume(adev);
>  	} else {
>  		r =3D amdgpu_do_asic_reset(device_list_handle,
> reset_context);
> --
> 2.34.1
