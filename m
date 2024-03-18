Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05ACC54E67
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 03:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A57710F1F6;
	Mon, 18 Mar 2024 03:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Go/nBejU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D05210F1F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ko9/AqXZ/+BPaHqFvFWoSQg6iQcYjfpPhUd72tBUlm5DbRtoA88haC4w3QFln7rBKqDj4s45vMS5esKnzR7S3K0Z1D8gtEQQDavTMqCBTM6ytpjYiKN0URGzllvm5SEg2Kc4zuJ87SkDovgG7T7ZLuMBPvgYPM7Nkcvx3BnsPc6emdO2r0au+xRsDRWIBir+RAfL14RZ+bSCaWFbp1JilcJY6z2zxZW/1O8UT4CBLpjFh4wxhSp0w5++rsHjXOJsePNn+jasp9tbIV6TBAJPNJaz02QAu1Vu0cGUrxU+GqNQ5cey8Kqtk8D4xG4/gunWWEaHYnDLNiy9Qge8i7gOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj2xwV+HWhu9lBnpsw1nHb+M2hdXPLJHR45mkZQQzpc=;
 b=JuLV7jPoi+THr+V/lFJafK0CRcUjczcQE1ucrZqh7zAk9entb0xVeIgljaHIbIPp6ljk2OGW3CHsc4XUmll1lgMtA72D+H/PC8EAPeehin86OHNRqx1OVnr6X+ENv6/vCpA9RvkeNoLEDhQY4WsAL4AMEvnngpL7Y44zYe86wuuThP+wZnQyxiA5fnqAg/DdlWGUI2CCmad37IBOrv2VCLs7a5/Uui73M28cqSRL+hJe8UMHZIlxzgpERvhIjohxamaI9t2SUFnaf7tp5Dvab6lMe2JE4xP5A8sEiS6jMhoQJe7qo7h3TtRen58oYZf1xNgxUov0aYCk7waCy+QW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj2xwV+HWhu9lBnpsw1nHb+M2hdXPLJHR45mkZQQzpc=;
 b=Go/nBejUsLhme8NFDxdVMQyX0RFYvbVSiexGUHwP0Iw0qdxLhkl779XswmTkxsaV2lJlPvwtiv4LKQlhRix2T5PWMQpSk667wip/nTaLGnsWfxHrDhx4EQVwMl00HW5OyyQjhdvH0M9bFxYX2SqXVC+8fiPAlXM8HrbgYfmlVeg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 03:02:56 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 03:02:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ras event id support for ACA
Thread-Topic: [PATCH] drm/amdgpu: add ras event id support for ACA
Thread-Index: AQHaeNur9FMmG3FW8U2OGzxvQdcM8bE8z7aQ
Date: Mon, 18 Mar 2024 03:02:56 +0000
Message-ID: <PH7PR12MB8796B26AA309419768704606B02D2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240318022520.168079-1-kevinyang.wang@amd.com>
In-Reply-To: <20240318022520.168079-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e57b80be-af51-4101-8fc6-533293421298;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T03:02:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB7878:EE_
x-ms-office365-filtering-correlation-id: 2d9fb4ef-2eb0-449f-1126-08dc46f7e950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +AxjFufbvvtGebJGo8XXvPiyId1kc9bEU+0k21IDXrmdnR643ebLJlRxAhm4lvjPNlp7XOcgceJbXUeegczJcOHUlKL/15tnpan7rTqHUY5IuKmMju7YdkhvEr7uEO8w5LZOdzV1SCisolvczgQg9I5mWHb1TXhePl9AWMyXGbDlEpOvyPO1huUEKR13xa12n9dANNYw3BiB8F1j32+JWlEainD1+PPzfwdUZK6Ipg0hvxubZdahohqyfWCx8gBNQjHIrkvTfA999h9kqlfvl9esmZp7jy0RuypmN3SO+V0JeNrjchtIKdV3fHhbwjJITljxlFYnpShRBDyrETjEk5eBilLhLXqDg7cBCuQIbeZeeHDVAANeTMjX9fHh4spPY7U+SPV/m+603Zs8BJwq0qSDuHiQQgPcPT5vIWgC81G6AMytL8kb8u3Y062VN8Io05PeHkcNxVESBjwYg8uDciczrXC0bpT/LBitF/UN/Y2XrDeODd2YVFYGddy6t+Uq+IhHDA4tq4kAT44OHSslyZe5YEe5fFxtnAvHw8munY26Nwd2TeaJFjHneF/6um//TOyYA0AuHu9Exxwxo66d01H5XrexTkSgzuaIigGbCaM5qXdQWcbLzQGvqeWeH4HJ3Urxb2g4Mykk46uA76LKdDkD0IPof2ofJTFbZkC0Cs1T8G/S+QdTVHRJbxrP9MQAqEY3bgeba9z+6O+ohUb63w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y0+xoXlIeFU1fmTEa/Aka4dUFkGpOQEcGnt0AixSeWE3x+JGNC/0W+PHdo/H?=
 =?us-ascii?Q?sMVJd80M4QIcT1dU8swhYpa1fgZ7D86viK2ZYpqs7YghQSiif9RTqvq4i9yB?=
 =?us-ascii?Q?4SkW/f3OkKLSK2JWPSq+UU8/1zSl4KRGmZ/smS7l2V61tK9VY9sLQ1nyyu8a?=
 =?us-ascii?Q?q11IvnJsroUpvyAIkApQYuXI+yaUuRKABnTn8WrWKFd8MLRbtRD5wO6T7akP?=
 =?us-ascii?Q?TP7Nxx4ZwkAcPtp+tUseYbAG9SGAFcKsteJcg24/p0XQHVJf1u1wTsMfouMR?=
 =?us-ascii?Q?CJOS15S0xiUIeLNQyiDzf2fkyeLzOpwQlQK2CGBAz8AoqF87X4hRjLiv4LDT?=
 =?us-ascii?Q?9rERA3HYfeByoro/YXfkv4yUdGZQ4k/7srPOmHXJS5CrMSvvmCgLbEH17Zwf?=
 =?us-ascii?Q?faSB8wfnhbNWHcQEl9a1nOH2X7JfYdg/nqQRybQuJ8Aly/2MXjhQvmZVY1lO?=
 =?us-ascii?Q?BQ0EVvDvEgFmAwqVypXEXd2QBGg5yCk6IRMHWt8gUDSc5+VMWBTU3wQIpOxZ?=
 =?us-ascii?Q?IRdXI9TeXjUtK3b/GD0Uijffk/uGNGmwJuusaPry+Vc4gHd96LzH779acrvQ?=
 =?us-ascii?Q?Obz54+hZ08Ij/34oIUmY0blalc9uuSctzECJKa5lNap32dNbMCiC11EyiHvi?=
 =?us-ascii?Q?TyjIDzwRTWndKqZS6iZE+FG7vfI6qkmhUL2Ut4FxkgqjXLbGO9FXVPeiAphz?=
 =?us-ascii?Q?ZAqXdxDLVf6W63kn8tKPgNEY4yZ9gDk2iFrAVzM8EDUQUyWmzC/Eul4aIDA9?=
 =?us-ascii?Q?/pv2CfHSfngTv4HKGgmGUCW++kFe1Ed7fL/6hFMI19tJ3aquGk2/k7demQu3?=
 =?us-ascii?Q?VZ1JyrXEwH5Hf0rCEBqU63W6gAIbyWRY7uGZA2HyjF5Q9XpaFDAgtnJvRe9S?=
 =?us-ascii?Q?txLip6hn8T9Ensrqq6vgzcMAQhjshhax7PBhfB7c2VMwwS6vpx5mBeBmlPip?=
 =?us-ascii?Q?Ge9JvMFMueCP8ajid8XNoeHDryT2dWczBvvTcwaiRzP07HXrVBfpxQ8tDpnB?=
 =?us-ascii?Q?EY454rvhFD34wEMjeSWnfZSm0bILcJEjCxI2g4YJl1OjBaXSd6FKG5Q66M+L?=
 =?us-ascii?Q?naZ0H+5n4uAzKGx4FWRfdRoFsP6zMQl4+q3AKFYPD1B+9wVIWwkXNEr2N0U7?=
 =?us-ascii?Q?VAE4JHYp5TcP4KkPexJGGP/oG5Z7JKjoqnAIBbcsP8CK50xiLJvZyYWbHclI?=
 =?us-ascii?Q?EzsiQ9KONCui9vANrOml8nYpOofjtCFi/tiJ/xnaca2ehbn+1Cb+qMv4cfCU?=
 =?us-ascii?Q?3oecpioD+EiOq3sPSd1Oy2sQUuL+qMfajtQQU7f8pkfLeaIc0UA3PiwE5C8z?=
 =?us-ascii?Q?ELoa36xidPf8wG2dwoNcrdAWf7OMx0V+9xuItMkKe/jfYkO0kkble28pwme+?=
 =?us-ascii?Q?K6hCZjOGM11d6ixdkZaeYJeotG5jj3VFL2/gews6rQUaatsWTGmNv3YUb9hp?=
 =?us-ascii?Q?W7Cj/FvbQ3bqZi9VuMJzTUuGa7dHFjCsqIBSk2gf6uueKSyYDZPdnjF11d4+?=
 =?us-ascii?Q?I2hHIfkNm3gHZysAaf6Az+cY5gCL20BfiYggXR922MxeUL1wppd2NiYOFu/3?=
 =?us-ascii?Q?bCD7cAXQ8CqG6CqVdVM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9fb4ef-2eb0-449f-1126-08dc46f7e950
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:02:56.4551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9I6fv66F1RhQf0vsVluh1iIezlZzxyumoIuqYbDyK/QY9JcLIqKc3ZJLoiGKsfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Monday, March 18, 2024 10:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH] drm/amdgpu: add ras event id support for ACA
>
> add ras event id support for ACA.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 ++++++++++++++-----------
> drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 +++++-----
>  3 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> index 53ad76f590a1..ddcb68e60a73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -116,20 +116,22 @@ static struct aca_regs_dump {
>       {"CONTROL_MASK",        ACA_REG_IDX_CTL_MASK},
>  };
>
> -static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int t=
otal,
> struct aca_bank *bank)
> +static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int t=
otal,
> struct aca_bank *bank,
> +                           struct ras_query_context *qctx)
>  {
> +     u64 event_id =3D qctx ? qctx->event_id: 0ULL;
>       int i;
>
> -     dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events
> logged\n");
> +     RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check
> Architecture
> +events logged\n");
>       /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
>       for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
> -             dev_info(adev->dev, HW_ERR
> "ACA[%02d/%02d].%s=3D0x%016llx\n",
> -                      idx + 1, total, aca_regs[i].name, bank-
> >regs[aca_regs[i].reg_idx]);
> +             RAS_EVENT_LOG(adev, event_id, HW_ERR
> "ACA[%02d/%02d].%s=3D0x%016llx\n",
> +                           idx + 1, total, aca_regs[i].name,
> +bank->regs[aca_regs[i].reg_idx]);
>  }
>
>  static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum
> aca_smu_type type,
>                                      int start, int count,
> -                                    struct aca_banks *banks)
> +                                    struct aca_banks *banks, struct
> ras_query_context *qctx)
>  {
>       struct amdgpu_aca *aca =3D &adev->aca;
>       const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs; @@ -165,7
> +167,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device
> *adev, enum aca_smu_
>
>               bank.type =3D type;
>
> -             aca_smu_bank_dump(adev, i, count, &bank);
> +             aca_smu_bank_dump(adev, i, count, &bank, qctx);
>
>               ret =3D aca_banks_add_bank(banks, &bank);
>               if (ret)
> @@ -390,7 +392,7 @@ static bool aca_bank_should_update(struct
> amdgpu_device *adev, enum aca_smu_type  }
>
>  static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_typ=
e
> type,
> -                         bank_handler_t handler, void *data)
> +                         bank_handler_t handler, struct ras_query_contex=
t
> *qctx, void
> +*data)
>  {
>       struct amdgpu_aca *aca =3D &adev->aca;
>       struct aca_banks banks;
> @@ -412,7 +414,7 @@ static int aca_banks_update(struct amdgpu_device
> *adev, enum aca_smu_type type,
>
>       aca_banks_init(&banks);
>
> -     ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
> +     ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, q=
ctx);
>       if (ret)
>               goto err_release_banks;
>
> @@ -489,7 +491,7 @@ static int aca_log_aca_error(struct aca_handle *handl=
e,
> enum aca_error_type type  }
>
>  static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_h=
andle
> *handle, enum aca_error_type type,
> -                             struct ras_err_data *err_data)
> +                             struct ras_err_data *err_data, struct
> ras_query_context *qctx)
>  {
>       enum aca_smu_type smu_type;
>       int ret;
> @@ -507,7 +509,7 @@ static int __aca_get_error_data(struct amdgpu_device
> *adev, struct aca_handle *h
>       }
>
>       /* udpate aca bank to aca source error_cache first */
> -     ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
,
> NULL);
> +     ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
,
> +qctx, NULL);
>       if (ret)
>               return ret;
>
> @@ -523,7 +525,7 @@ static bool aca_handle_is_valid(struct aca_handle
> *handle)  }
>
>  int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle
> *handle,
> -                           enum aca_error_type type, void *data)
> +                           enum aca_error_type type, void *data, void *q=
ctx)
>  {
>       struct ras_err_data *err_data =3D (struct ras_err_data *)data;
>
> @@ -536,7 +538,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device
> *adev, struct aca_handle *han
>       if (!(BIT(type) & handle->mask))
>               return  0;
>
> -     return __aca_get_error_data(adev, handle, type, err_data);
> +     return __aca_get_error_data(adev, handle, type, err_data,
> +                                 (struct ras_query_context *)qctx);
>  }
>
>  static void aca_error_init(struct aca_error *aerr, enum aca_error_type t=
ype) @@
> -853,7 +856,7 @@ static int aca_dump_show(struct seq_file *m, enum
> aca_smu_type type)
>               .idx =3D 0,
>       };
>
> -     return aca_banks_update(adev, type, handler_aca_bank_dump, (void
> *)&context);
> +     return aca_banks_update(adev, type, handler_aca_bank_dump, NULL,
> (void
> +*)&context);
>  }
>
>  static int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> index 674a5a9da862..247968d6a925 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
> @@ -198,7 +198,7 @@ int amdgpu_aca_add_handle(struct amdgpu_device
> *adev, struct aca_handle *handle,
>                         const char *name, const struct aca_info *aca_info=
, void
> *data);  void amdgpu_aca_remove_handle(struct aca_handle *handle);  int
> amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle
> *handle,
> -                                  enum aca_error_type type, void *data);
> +                           enum aca_error_type type, void *data, void *q=
ctx);
>  int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
> void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentr=
y
> *root);  int aca_error_cache_log_bank_error(struct aca_handle *handle, st=
ruct
> aca_bank_info *info, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 357349fcfcca..41b9315099a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1269,7 +1269,8 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)  }
>
>  static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enu=
m
> amdgpu_ras_block blk,
> -                                      enum aca_error_type type, struct
> ras_err_data *err_data)
> +                                      enum aca_error_type type, struct
> ras_err_data *err_data,
> +                                      struct ras_query_context *qctx)
>  {
>       struct ras_manager *obj;
>
> @@ -1277,7 +1278,7 @@ static int amdgpu_aca_log_ras_error_data(struct
> amdgpu_device *adev, enum amdgpu
>       if (!obj)
>               return -EINVAL;
>
> -     return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
> err_data);
> +     return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
> +err_data, qctx);
>  }
>
>  ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attr=
ibute
> *attr, @@ -1334,15 +1335,15 @@ static int
> amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
>               }
>       } else {
>               if (amdgpu_aca_is_enabled(adev)) {
> -                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_UE, err_data);
> +                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_UE,
> +err_data, qctx);
>                       if (ret)
>                               return ret;
>
> -                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_CE, err_data);
> +                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_CE,
> +err_data, qctx);
>                       if (ret)
>                               return ret;
>
> -                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> ACA_ERROR_TYPE_DEFERRED, err_data);
> +                     ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
> +ACA_ERROR_TYPE_DEFERRED, err_data, qctx);
>                       if (ret)
>                               return ret;
>               } else {
> --
> 2.34.1

