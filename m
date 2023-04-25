Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91008C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 09:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B5C10E6D0;
	Tue, 25 Apr 2023 09:04:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6500610E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 09:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEMBIR229W/BNajrgOAWCyr9yDOL+bmE1+M9LhcDdXBh9eWZcT0xZ2mqlHr9OM7S3faTlTpZvIjvJuCVtOoRp5JBJwxqMNVhyUElvdbk8ATaptSH1UIpqLg6Qk2BD2WEnT5REL+Qvfz8uHdseUi3ckS1xJYbfnqLik+7sAmk3om2wahwDv0w02lyGHCHsTXV1/qheAXyRjY1j+jePKh88MtabViC3XqBEWRWRIGgeJHXNZGOIVapap3RuxKbRif16ZB66UO62gnf5XHrtSrneuBlmYXgYYbeWpNK1jkyjZhLIJ5IGScg57QTdihii+dWOr3jWs9OXwMeC+Ugi8iPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoA1Ev/4LqOT8APXVCdU8dTvCKLxPRfIAbcopTDmtMY=;
 b=ZFfIuIizK3nAiGVPydogniFjd/0rGIka6u9oJUVCc51TtteA9sKgr2bmo8Cuot7fxlDrTiKeG/dIMpmSDAneR19tX+MrqcahJ14077XPi8GnDd5/VYVTYc0XKujSWRizB2s95OF4BbezvvJLU3hWK318tsQrDZLvkXtOSpQhfRKwu7/KBKCNX7d0kdH2Tr2R8Jm1cTEDSZKT/vlSS+nGdcCXGymvWVaEYoFa2Rf2tg9UFL9oliZnfITIwRTjhbMmM/vrRDg1bbGLZyKYlVr4x88+2bD5gN0UrzX/xU9yfWpga6+qDnlQHeGZurdP/DjB/9dSkz9j5I1qXdnt26Y0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoA1Ev/4LqOT8APXVCdU8dTvCKLxPRfIAbcopTDmtMY=;
 b=N+JXoofaI1HFT0IVo41t8nmcBJuMv3lS6pfNDGoxtD0GNQk0Hj96gd1vX3ZmzJ0nQmeG9+3va+/XAqoOuQ28oOwIfKRKr6coEaHL6T6Q7L8J0yKQWp0VOMTd16DAgZj1rOGO5BxqFU8z0HuNsknh6bwPMPLfkQd8Q8dNtan7FFE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.34; Tue, 25 Apr 2023 09:04:29 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::dd8d:b994:aaaa:c8a1%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:04:29 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Horatio" <Hongkun.Zhang@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is
 not needed any more
Thread-Topic: [PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is
 not needed any more
Thread-Index: AQHZd0CWIiquruRxhk+w1MeohKEd5K87uquw
Date: Tue, 25 Apr 2023 09:04:29 +0000
Message-ID: <DM5PR12MB2469194340F4BFAA352E0902F1649@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
In-Reply-To: <20230425063837.26701-1-Hongkun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CH0PR12MB8506:EE_
x-ms-office365-filtering-correlation-id: 15f65024-20bd-4c30-1eee-08db456c139e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PrQTBrXeJcn2SbkkyhUTqB2MSa2GAyQJizkWbys+XOI18iSLyb3dy9zt3o6Wvecypp67eB/HCL6PEimvo0sI3KlAKXkT/kW7ua5GxUj5nSe1NlA71j/P2I6x0veoZbkYEXC++2ga6dMpyYzhHtH1AlOxpps1pd79RHq5QzTUzH+SvS5lICpnA8hJsmPy101uKhoszw8ZPqCgimpgADPd2WMeCpjpLqRIJV5IHY4iTcHYH67gB+Kg0hgZXvyuG0yAt4X5c/u/XLYZ54KUFRLrWiA73PwklSEngm7nm4L+gqAbM+n84BU42ex2ddEANprngpdrkVHwKcYrgE/9didyZvQsj4DWjc04OE04to8AhO1OkCH5+gdZyBbFTXuXN/RHOCpRK0GvMG5D5+2aI4LxwproZuUXkduOqB2KoVFX9sjz8c33CYGF3Oue5CTTYZAGgk4jQDyj1HxebOIib/aNCdHuxrvfVlTKlifTh8CkmQybLNeOv3NTCBz2LDaIpMP9Ak+4wJSLiwIlWWM1Td+clU2StXerzZq2kLVe+DD6mF90JffsndlltxSGceEun/VXsgU6a2QEcRg0aszl9ubj+hgVzkLewelqbIKtK50CQ1hYPaNqV2N0XuyZMNqIiW0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(2906002)(38100700002)(186003)(122000001)(38070700005)(6506007)(9686003)(53546011)(7696005)(83380400001)(52536014)(5660300002)(110136005)(54906003)(86362001)(71200400001)(478600001)(41300700001)(8676002)(8936002)(55016003)(66946007)(76116006)(66556008)(33656002)(316002)(66446008)(4326008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tUeHH/J6cBHDWMST5b8fT7QOKN2KLpDhudIPfsbDSCW9egWQgIHVoPv5N7in?=
 =?us-ascii?Q?LMrgN0OsM1IISbcTSKJsqwBUWgZtZ/yTOiuTm++qHsHApmc7PkcaWPLnoxsp?=
 =?us-ascii?Q?Q6dljfeOXTIZswmNkCr0fWOyAwvwpRKcWJZgBaaocl+I7mwPE9vRFLIv41IU?=
 =?us-ascii?Q?qpHD8F8w6EL0+aHYms7vvA0NDnEo32wVCi714nYF0HSNI12FQ2LgPqTUUKYh?=
 =?us-ascii?Q?xXkDs4rVuSTxQugRNgsZ71F2TXhp3QFmb8ScIPje8NfBeTrdzAlBYoqG4T7/?=
 =?us-ascii?Q?WOl6EbOpAyp4Gwxq1X/V1Dwwsd+Y6Rqp84Y8MfxTi4arBy88tJocQ0/niqQ0?=
 =?us-ascii?Q?BqiA7TWhVcu46BAc33OE/PEN9usgCgnFQwlNOGYgYns5FNvEIhJ/sqq88zK0?=
 =?us-ascii?Q?1COBUOC5IcAQTJ+dmJkysAfqScT+QKcX4oho+S4BcV7PgwVFYs9dpSYB/G+n?=
 =?us-ascii?Q?i4YY2Ar8z02tHqktNyBQT+aGeOCGEIJ4iQgultCWTI4XXAF1RWCAsuYPjx+H?=
 =?us-ascii?Q?vokSje8dkVZ8xVGuVCt/5Hn75tkbjZk9SSa14qUfiKsl0d0e9AHZ7VphISlT?=
 =?us-ascii?Q?EBgPCr2qjsys9W1C1+qLsBPJxuEpWwvL6ViKScotW9tOjN1hRE7+UVO0nAdd?=
 =?us-ascii?Q?AjYgTZEmRwOYvq53GsLjgnhklI8P/80FSZkJq3EnMO6f/MMoLum2zaJdw6Hk?=
 =?us-ascii?Q?ljBBrqTFZOiJ2GwqM1HcUblkVrpdP0YhgFIDW57vj84kdpyYGrteW/VCYUfB?=
 =?us-ascii?Q?D0DzDrPaVFO2Cxke/QfNq2kB9SBnPSxU3SmOOkGx1aYkGK019+JJQES07qMk?=
 =?us-ascii?Q?R4WrVwyNfesQ+0TtFzRrKVJ2+ANUS7d7/hpAdPkqmB4fa2Wu9JxRDoBtbr33?=
 =?us-ascii?Q?HbfFHqbow9kubihZh5nnmw47YPsVZ3dk9HC7BKpiliBs+aG63JLEt6ISeQuo?=
 =?us-ascii?Q?w2gm7FwRmIvIbIHm9RcWBmPTxVXwKzC++xIQ3vFelI+kxUNfEK3kKseqr3Vg?=
 =?us-ascii?Q?iOjucBmTmyumPosi5J25TmQHafUBbrAME+5+wBsqnaICpeGAzh0u1t8Cj+wW?=
 =?us-ascii?Q?xMhsNeML5zrWIcg/5eoUAq3WptIlRXUjXJhvEIuBJfphbBEN+HBAbB1d0VYG?=
 =?us-ascii?Q?AZZsD34raShYlpjm5CW0EncO8UnJkRAhp+uR99+W/49+Uu8M2xxYoGM0l8g+?=
 =?us-ascii?Q?7E1+iCyvjdCTSDonaq9qQrvDGzCQfN7sx6+3xTQ3KjRgoIRA4qUTP3RV3IAW?=
 =?us-ascii?Q?nKIkBLQMgeXs4I5ZAZILquMfNnA+568gqaFF807Ga902jWMpkVSbZZnNHcRz?=
 =?us-ascii?Q?cuXeD9GL/gcEnEBQNMgY2Aalm9qH/iQ/1H0z9JhJoGxQ/+FBnXhzYbyusLqt?=
 =?us-ascii?Q?6tYf0oh9ud8N2AxKO2v043SRKH7BGjnwYIzXvssu+4qqW0ICQneLDbMulV69?=
 =?us-ascii?Q?d4f3RI5ANlmZNkJAYlCLxoeBNCPsJV+pqqh+YZmb3iNjCS/QGsD6NPCMb+aY?=
 =?us-ascii?Q?gcJWteuDukW87/rXUXuBuNdijIVTwieAA7bRsR3Hl3oZ1fMYCxi8uQXD0g?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f65024-20bd-4c30-1eee-08db456c139e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 09:04:29.0667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpYdylZI6nRXoHM6fmXrk3bTr56ZOzlMtXkV090O16SDXhHjzCFfxmM92xbDNF4AsDZ3qrsrnuMQj0oU0r4i3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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
Cc: "Yao, Longlong" <Longlong.Yao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Zhang, Horatio" <Hongkun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I guess it's more simple if updating the subject to "drm/amdgpu: drop gfx_v=
11_0_cp_ecc_error_irq_funcs"

With this improved, the series are:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: Horatio Zhang <Hongkun.Zhang@amd.com>
> Sent: Tuesday, April 25, 2023 2:39 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Xu, Feifei
> <Feifei.Xu@amd.com>; Yao, Longlong <Longlong.Yao@amd.com>; Zhang,
> Horatio <Hongkun.Zhang@amd.com>
> Subject: [PATCH v2 1/3] drm/amdgpu: gfx_v11_0_cp_ecc_error_irq_funcs is
> not needed any more
>=20
> The gfx.cp_ecc_error_irq is retired in gfx11. In gfx_v11_0_hw_fini still =
use
> amdgpu_irq_put to disable this interrupt, which caused the call trace in =
this
> function.
>=20
> [  102.873958] Call Trace:
> [  102.873959]  <TASK>
> [  102.873961]  gfx_v11_0_hw_fini+0x23/0x1e0 [amdgpu] [  102.874019]
> gfx_v11_0_suspend+0xe/0x20 [amdgpu] [  102.874072]
> amdgpu_device_ip_suspend_phase2+0x240/0x460 [amdgpu] [  102.874122]
> amdgpu_device_ip_suspend+0x3d/0x80 [amdgpu] [  102.874172]
> amdgpu_device_pre_asic_reset+0xd9/0x490 [amdgpu] [  102.874223]
> amdgpu_device_gpu_recover.cold+0x548/0xce6 [amdgpu] [  102.874321]
> amdgpu_debugfs_reset_work+0x4c/0x70 [amdgpu] [  102.874375]
> process_one_work+0x21f/0x3f0 [  102.874377]  worker_thread+0x200/0x3e0
> [  102.874378]  ? process_one_work+0x3f0/0x3f0 [  102.874379]
> kthread+0xfd/0x130 [  102.874380]  ?
> kthread_complete_and_exit+0x20/0x20
> [  102.874381]  ret_from_fork+0x22/0x30
>=20
> Signed-off-by: Horatio Zhang <Hongkun.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 --------------------------
>  1 file changed, 38 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8a4c4769e607..e9491aec3cae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1355,13 +1355,6 @@ static int gfx_v11_0_sw_init(void *handle)
>  	if (r)
>  		return r;
>=20
> -	/* ECC error */
> -	r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
> -				  GFX_11_0_0__SRCID__CP_ECC_ERROR,
> -				  &adev->gfx.cp_ecc_error_irq);
> -	if (r)
> -		return r;
> -
>  	/* FED error */
>  	r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GFX,
>=20
> GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT,
> @@ -4483,7 +4476,6 @@ static int gfx_v11_0_hw_fini(void *handle)
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>  	int r;
>=20
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>=20
> @@ -5970,28 +5962,6 @@ static void
> gfx_v11_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev
>  		WREG32_SOC15_IP(GC, reg_addr, tmp); \
>  	} while (0)
>=20
> -static int gfx_v11_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
> -							struct
> amdgpu_irq_src *source,
> -							unsigned type,
> -							enum
> amdgpu_interrupt_state state)
> -{
> -	uint32_t ecc_irq_state =3D 0;
> -	uint32_t pipe0_int_cntl_addr =3D 0;
> -	int i =3D 0;
> -
> -	ecc_irq_state =3D (state =3D=3D AMDGPU_IRQ_STATE_ENABLE) ? 1 : 0;
> -
> -	pipe0_int_cntl_addr =3D SOC15_REG_OFFSET(GC, 0,
> regCP_ME1_PIPE0_INT_CNTL);
> -
> -	WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
> CP_ECC_ERROR_INT_ENABLE, ecc_irq_state);
> -
> -	for (i =3D 0; i < adev->gfx.mec.num_pipe_per_mec; i++)
> -		SET_ECC_ME_PIPE_STATE(pipe0_int_cntl_addr + i *
> CP_ME1_PIPE_INST_ADDR_INTERVAL,
> -					ecc_irq_state);
> -
> -	return 0;
> -}
> -
>  static int gfx_v11_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>  					    struct amdgpu_irq_src *src,
>  					    unsigned type,
> @@ -6408,11 +6378,6 @@ static const struct amdgpu_irq_src_funcs
> gfx_v11_0_priv_inst_irq_funcs =3D {
>  	.process =3D gfx_v11_0_priv_inst_irq,
>  };
>=20
> -static const struct amdgpu_irq_src_funcs gfx_v11_0_cp_ecc_error_irq_func=
s
> =3D {
> -	.set =3D gfx_v11_0_set_cp_ecc_error_state,
> -	.process =3D amdgpu_gfx_cp_ecc_error_irq,
> -};
> -
>  static const struct amdgpu_irq_src_funcs gfx_v11_0_rlc_gc_fed_irq_funcs =
=3D {
>  	.process =3D gfx_v11_0_rlc_gc_fed_irq,
>  };
> @@ -6428,9 +6393,6 @@ static void gfx_v11_0_set_irq_funcs(struct
> amdgpu_device *adev)
>  	adev->gfx.priv_inst_irq.num_types =3D 1;
>  	adev->gfx.priv_inst_irq.funcs =3D &gfx_v11_0_priv_inst_irq_funcs;
>=20
> -	adev->gfx.cp_ecc_error_irq.num_types =3D 1; /* CP ECC error */
> -	adev->gfx.cp_ecc_error_irq.funcs =3D
> &gfx_v11_0_cp_ecc_error_irq_funcs;
> -
>  	adev->gfx.rlc_gc_fed_irq.num_types =3D 1; /* 0x80 FED error */
>  	adev->gfx.rlc_gc_fed_irq.funcs =3D &gfx_v11_0_rlc_gc_fed_irq_funcs;
>=20
> --
> 2.34.1

