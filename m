Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E30E60527
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 14:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E30E60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A916E092;
	Thu, 23 Sep 2021 14:18:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3099A6E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 14:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMBa6zWEujJ5dtE9b+340ODvGCSXCoLxBljgNRCwKuNDXugXspPoSaI5e+isEC7//5uT1YUGLXwwwz5Qc9qXg+6C2S2GKvdwCrqRiQCC5eDx8Agu+1QcBOPUwNfz7vnq9tDpUJhVKgCLH3PFydv4uLQJvvOuny68jS+OHYCdOhu/iUjD6wDwu7/yogac5w61cE1O6HzoR2K4p3o04f7wo+eiqQPvTOk/0zdpOJ+Ol3fUFV2muPrGSmvopa9zqfNliLLdKVo6l3Rhfi6qSo1ZIBD0Pu9ZOeEPUkWdrQ6/xeUkLoEVjOry64lEAbIKEOlpZpWedtHgUbb7nX2vgxKV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BlC+m63AJw9jE4w2Hh/ri7dW6Z0j8NQEoGYZ5k3vEKY=;
 b=TSuXsiah4Qjc0ZPeQvVvy+CQ8UOb3Wk1z3coKrOHt55ZMGB9oxYOlg7kKYCvyFHGctj638FohFLllPEB8wh/gkS7zS//VEbBk0CpZ7TqMlznDJyhTjdH147nL/YKLW/M2XcYCwrqTihMGWR48F0LIb0zFCgIYAErGXH3TvzM48nWlRDw4GQOsUFw/+5hHk9ZcqWIgGIPcv7VJbjhyynN5/DGNnxxQQ9UipCphPIyJqKhU8TuHeEM8Xip2rI4mbAS6OpXc1giJOs5Ld0cM/hT8b9q0vmZ7iHljspIck8MlrqLnTor5NT6W46hPTLX+Mc5H5eSBxcqQF8WrA6EAk93Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlC+m63AJw9jE4w2Hh/ri7dW6Z0j8NQEoGYZ5k3vEKY=;
 b=D+oWuGb/Kw6e3hB3RnqM7m4HlrHHbb5A5xmGCvCfr85OA3VAWyk6a0jdxhs4FD/VP7a5wJ/1pEi4LEOGd4wfCP1n0SmSxka5zs37JSdVjlHQOKwRN25qVE+fqtL+Cgki+tk++e7k5OoCWJ9Y/Rn9+X8rhLJTz8YQ1RgMZdj5Wjk=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 14:18:53 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 14:18:53 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
Thread-Topic: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
Thread-Index: AQHXsGKWsDZ2Q44nA0qs7ivz/+lt86uxpyhg
Date: Thu, 23 Sep 2021 14:18:52 +0000
Message-ID: <DM4PR12MB52634039157E168108B39F2CEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210923100529.10807-1-tao.zhou1@amd.com>
In-Reply-To: <20210923100529.10807-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T14:18:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d11e38a9-3b57-4ad1-9665-6d2e640512ec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45f7dc9b-ea7e-47b9-3e72-08d97e9d123e
x-ms-traffictypediagnostic: DM4PR12MB5118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB51189246A2395784CC1BD765EEA39@DM4PR12MB5118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /o7BHqz2vf2H5kngELfvtbJmEI4/MySPcDsAfiVyUlOqlXy2uFkryd/0NJ8wJypVYepN0aL8+DdaT4WEq5EQ962ymEIjCsRopiziaYR5Mmsv3N6myYyRUfhxRChbQ6JIw7croTJnUSteUyUqLNdXcDG3izZLeQ+K6Bnk7QP5IkZupfCDumwGBtbceNehqvmd1kOHUI1a30cz41fTJv9LhHiZEkIOCU19Jv3FroC9IaEXIgnl5ye/tbXB0ErAofwsGOHlZMqMDTENhsMEyRd5imzlcZq8e+pzeALbUEoGL/b/T9eqNIRx8A/szzQv1HZbjeE84NiRN6oHIjWaVaIR7+fZDhngoyf8Sucw7R8jVYkFfHp5SFcA+ujScSL4x5aBCZwNSj6fe9jjweItGuvfBUUCipa18pbyNsY2UFfe998vEevzS2VFCz2WdKCA2pV9+6KO1TJ6UpLIFaZaemOVnZTzAB4kkn+aNkVe4PlHoI/mHr9n1U5pUHWZiJVwWnh5GIroATX2FLkgmopFDKPlzAtRReQ9q52/t065CVyef08jQ36SwIyiMQsiz9sFOCT1uIKuem/I75Y2k1hl2TevfLTWESbsCDhu6lbClztUP+sxvDj9iv5wwdy1Li7+UHD+5nS6sqTGC15vpFbBC9plhGlWem1FYHL+HC41IhTCOGxy+W+zyetNxa9C/GhX+RLSVhmnPKDSGWpwV9Ytcl1ZPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5263.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(2906002)(4326008)(186003)(53546011)(55016002)(76116006)(7696005)(110136005)(8676002)(26005)(5660300002)(8936002)(9686003)(52536014)(6506007)(508600001)(86362001)(38100700002)(66556008)(38070700005)(64756008)(66446008)(66476007)(6636002)(66946007)(316002)(83380400001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oiWik3U3OP66G/cixfRjSzwpZEB9myTDQZOKikoBo94YWboJEyRhN4Axjoa0?=
 =?us-ascii?Q?QfGcMUj5Oo3r3yiil92kokPOXvo/lgn4UouXa88gLvAW5SmrOt/tc2D0wV3+?=
 =?us-ascii?Q?KTkJAIyZY/0Nosj78S3wzu0QQhWnntvIcMXvRwwRqeWsl3ZU8f5Vc+YGPtGJ?=
 =?us-ascii?Q?gJ8t+998kjZ01Iwkxy8KBKeMZinB+lj5V4t5qrq0tlf4CLBSXclNnUuvu9g8?=
 =?us-ascii?Q?GBV7HupWB/qQIfXZnJWLTbQ8HMbHGyOPIA1pDswijF+LTHP4Wjl4h2UKYod1?=
 =?us-ascii?Q?5euRqRWqTmL+gRKXG+QYkzBwW9PiBnUeMJupynFUnt+X9RM37zmwn1TdIS75?=
 =?us-ascii?Q?75JpWCxz8qE+yZ/LzHZzuy0CyvkEudh/ZypBoLmZhsNepcNu/pV/WTUT4CtF?=
 =?us-ascii?Q?zwEVO2SS3BCrN+sbq5TlfQdvzyBuFXOZBCAr68vI3lq7ozpJ/TFqWFLyxMs8?=
 =?us-ascii?Q?dTlkLfu87v1Hab2mbkwKLQ4Yy9MGq3kNHPhDB8jGwX7lIHCrs9Io9AhCmb69?=
 =?us-ascii?Q?G5qhKwpySuoytUTdp7fDnd+S4HTGrJ7LOtPzOXth6mJPbe1B//P82K2zQwkY?=
 =?us-ascii?Q?RTCrJeiiwEGkNQ2d8Nr0Wyo+GX4bjxaZjYd9s9QxXZtDwYN2umZaJH7rG+E0?=
 =?us-ascii?Q?1E8x/JkUT2Ok33HQ1YUWR2OVOhM1BQHokePG8ecHTc+ea/up2owc03wD+FiD?=
 =?us-ascii?Q?NlQDaO5klx0W7hk3Z37onQciPYpr/cmVH+GLqctR6KOEtph70EqcQXOg/SMa?=
 =?us-ascii?Q?ArNtC2kHzpTQWBttAdNvze5SxySrb3ZQsWI2xFwn/RMAelMJxdNYdvKVoxe3?=
 =?us-ascii?Q?zMKItHB3JmswDJecQjuRgme+B1SK+QdTVRw+/fH99KniGjSoMrJoS41OKAAb?=
 =?us-ascii?Q?tzC4hF77NsgETKI5jedyvsLbDUlgemXz16NKcaK78x3dRGfIQ1ATFH8ujLKW?=
 =?us-ascii?Q?dVWSghzsspwODzgzNNqRuIzvGOFw4mdpP3jKBb2oehlC2Nd5qalxMlACzqaL?=
 =?us-ascii?Q?xeURMi2l/EC7794HkiUXrd83JYICosiej+/e4yPpqisSbw5WjvjAALTGjcqJ?=
 =?us-ascii?Q?PxIFr2B/AcqyiFF/SVxSDxwWL2r0664E3AeC1PuUB2XoWsBz6DBD9borbLGB?=
 =?us-ascii?Q?YB8Xgz6EHePK4rzOYLtNmgdpQjZq8ExabJtG2ITgz5SC4Sdp7j6f/kKmmO9M?=
 =?us-ascii?Q?7DR1n6cymeAWhjpfPwcDoPAsKtYIi9GaPxsZCqspZfZKzLZdpn2GUGFnMjLL?=
 =?us-ascii?Q?VZ5NFQHrD8voGjPK6s/TGdrbieZpzxHON0Vk5Fes38NGkF1xojzFPuZ67Zuq?=
 =?us-ascii?Q?7qM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f7dc9b-ea7e-47b9-3e72-08d97e9d123e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 14:18:52.9136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2ZOILak06RIYR/sw8KvCbY5bXZwX4rF2zg9LxWFvwNelAFXpxpDlWhSVNay47EayhJl/CeBPeKtfO9N7HyRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Thursday, September 23, 2021 6:05 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] amd/amdkfd: add ras page retirement handling for sq/sdma
>=20
> [CAUTION: External Email]
>=20
> In ras poison mode, page retirement will be handled by the irq handler of=
 the
> module which consumes corrupted data.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c    | 17 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  6 ++++--
> drivers/gpu/drm/amd/include/kgd_kfd_interface.h |  2 ++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 46cd4ee6bafb..27fc4e52aba9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -23,6 +23,20 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_amdkfd_arcturus.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "amdgpu_ras.h"
> +#include "amdgpu_umc.h"
> +
> +int kgd_aldebaran_ras_process_cb(struct kgd_dev *kgd) {
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
> +       struct ras_err_data err_data =3D {0, 0, 0, NULL};
> +
> +       /* cpu mca will handle it if connected_to_cpu is 1 */
> +       if (!adev->gmc.xgmi.connected_to_cpu)
> +               return amdgpu_umc_process_ras_data_cb(adev, &err_data, NU=
LL);
> +       else
> +               return 0;
> +}
>=20
>  const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>         .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
> @@ -44,5 +58,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>         .get_atc_vmid_pasid_mapping_info =3D
>                                 kgd_gfx_v9_get_atc_vmid_pasid_mapping_inf=
o,
>         .set_vm_context_page_table_base =3D
> kgd_gfx_v9_set_vm_context_page_table_base,
> -       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings
> +       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
> +       .ras_process_cb =3D kgd_aldebaran_ras_process_cb
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 12d91e53556c..4a48b78f918e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -231,7 +231,8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev=
,
>                                 if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_T=
YPE_ILLEGAL_INST
> &&
>                                         sq_intr_err !=3D SQ_INTERRUPT_ERR=
OR_TYPE_MEMVIOL) {
>                                         kfd_signal_poison_consumed_event(=
dev, pasid);
> -                                       amdgpu_amdkfd_gpu_reset(dev->kgd)=
;
> +                                       if (dev->kfd2kgd->ras_process_cb)
> +
> + dev->kfd2kgd->ras_process_cb(dev->kgd);

Firstly, removing the call, amdgpu_amdkfd_gpu_reset(), will prevent the GPU=
 from mode-2 reset when an application consumes a poison in GFX/SDMA.
That is not correct.

Secondly, page retirement and poison consumption are independent events. Yo=
u can have page retirement without the application consuming a poison.
So, we should not calling page retirement everytime application consumes a =
poison.

>                                         return;
>                                 }
>                                 break;
> @@ -253,7 +254,8 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev=
,
>                         kfd_signal_event_interrupt(pasid, context_id0 & 0=
xfffffff, 28);
>                 } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
>                         kfd_signal_poison_consumed_event(dev, pasid);
> -                       amdgpu_amdkfd_gpu_reset(dev->kgd);
> +                       if (dev->kfd2kgd->ras_process_cb)
> +                               dev->kfd2kgd->ras_process_cb(dev->kgd);

The same comment as before.

Regards,
Mukul

>                         return;
>                 }
>         } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC || diff --git
> a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index c84bd7b2cf59..828131415901 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -301,6 +301,8 @@ struct kfd2kgd_calls {
>                         int *max_waves_per_cu);
>         void (*program_trap_handler_settings)(struct kgd_dev *kgd,
>                         uint32_t vmid, uint64_t tba_addr, uint64_t tma_ad=
dr);
> +
> +       int (*ras_process_cb)(struct kgd_dev *kgd);
>  };
>=20
>  #endif /* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.17.1
