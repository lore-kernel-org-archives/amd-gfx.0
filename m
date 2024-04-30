Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6102C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 03:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2585A10E0D1;
	Tue, 30 Apr 2024 03:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RvyltnCi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B06E510E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 03:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwxX6/3suBgYP6cLJURzvyHfaqRczRkop70/51eFttjnVoXLWfW/eZA0ZCbXS7MQ+7zyz5yIHPSPxCIxWXw8luwRBVx4+dyVr8UomUYWGxx5AACLkydsBfybzMm6EKn0/j1dF7vTSzyxsG1EhXbnr89y4S7pMI7S5aZyIhBH57nDyii2javJyiBXEitor0nColCsHVQjdH1VrVkoxcVFkNo0aly0yZ+nhsrJbAZrE1vMF6ffptdSXwTdm0VdHl5bvazcur1L3lYtFykUENZzzz0o3XrwZOOQu7UodOibL8+sswH3yaixYuAANDxJcUf116Bup8ZcBsROEDyxkiB72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzAAOXS65XbDIDqAV7VCOc4I8bDmAcKmnvOHPw6WyGA=;
 b=epzjlD0Tap/9XNg/fW/LPwrFxb3kJNRab2r/ziM2EKYUUKlm8HLP17/WFi89K2l5qHhNPdoPUNG96UNkqzHBmeBjcAMww9DHwur3acD/kMOgMrM2HHVeNf2MHlxiNXfacvizeYbzKqCoj8BTtbitQ88QXO0j05Vu0H4pyJvuPU4i8N/pgIqMYNHInKJsc2dcGKNccd48zIROMJECy3fOEtBX2VjiBRcoBeKFV/7HnpmjLqVq0LJ3XdVfwYS9EmVQhja739MTYPytKcjCk0rtdohg8RdDpBbNkQ/0Hv9k+iszByeMop+1owGx9uAsO8uTLX8NrIDmiNSK9fxFGdRRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzAAOXS65XbDIDqAV7VCOc4I8bDmAcKmnvOHPw6WyGA=;
 b=RvyltnCizo/NrmFI/0OcfCVSCqoJMrDqZIjeQjadVNmllup8g+IF7C0TEiZr9VWxGtxq+1o+LjsyMGyB0caU9ieZRu+ppwKGQHstpwoy0fw+YK4A1b9pfxl2xCyinDMs3gkwKRMno5iX+kAnGXHowSybt1NfNlBFo6lLBShhf78=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 03:27:46 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:27:46 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
 vega10_hwmgr
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
 vega10_hwmgr
Thread-Index: AQHamUhzj2KNatyUtEuRrCKIREIMM7GAKZww
Date: Tue, 30 Apr 2024 03:27:46 +0000
Message-ID: <CH3PR12MB80741B48377DF02A3F711D01F61A2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240428084511.1646356-1-Tim.Huang@amd.com>
In-Reply-To: <20240428084511.1646356-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bf89161-ba33-4303-bb75-2dea8d1b162a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T03:25:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA3PR12MB7998:EE_
x-ms-office365-filtering-correlation-id: 6f3aeea5-4545-4d0e-f0a3-08dc68c58145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8MYbjo3ZRKoeH2/3yvTURzhAa9GcgXDemDVOCiq8pT4f4jjPEVb7c8qLtnKd?=
 =?us-ascii?Q?QtLbycptZMOdR3Vsn7hNQYmsbaqGoGeeZmC2+to6EowarPLXWQinHYvtp3qT?=
 =?us-ascii?Q?SASHb5BAd2bemNLEuA6e/jHqmT2JZpXfnyBqOQOboYRvCXstnJHLFzgAIV7Y?=
 =?us-ascii?Q?SWINdKtzyLjgnQLdGsD+D78+QkUZKm1rvGewW7gRFZxu4/JpqZqbNyAKspcQ?=
 =?us-ascii?Q?cqkWvAx8FRkKxiv4SG6GD+G2GGaMhuJ9gGSPMr054AghG+TFSMWhikGNVWkY?=
 =?us-ascii?Q?xXLoFovYLOYk4Ym0JM1atJJoE4MRjKEjV+RsP7Az8U2c5863UozZRK5Q77NG?=
 =?us-ascii?Q?CISStdcfTILNMoomghZGsVkxsom0VOfOJcVHQxPJRxKaEsLVczWyVh7nu0UG?=
 =?us-ascii?Q?kTJ+KhmqJBvLqSJ5P7QA0TPjdAqFPgLtsvFlxOSJDtgzSu3TYMfJGh6MN7Yv?=
 =?us-ascii?Q?H2Vq+bZxALxzeZ4x6SKFE4ugBH5WlLGJvOIy28JlADlibbW+lBctoYQmJMxg?=
 =?us-ascii?Q?MJiLYxx0lEh6YrwFYuqy8tRdyUXYZyZe8lG7VHyDqtJ+vVl3Xt1oL9Uv5uug?=
 =?us-ascii?Q?vFfmyodqHWNZS1D9BfAyVJzAo8jz4aAh3F5Guiz5lRTYJ7iSISC0lkG/dEmF?=
 =?us-ascii?Q?VcNFw8wuU1VGl7k5l4hEn2C/EPhUYRgClYAmGGs3LZiRy+DWhQmerHGndaH3?=
 =?us-ascii?Q?ZVzmvA5bTCiEQcuwNYPXn52xIhd73yIE+e/R3LkBP2rQ4I+w7LZ7Fo+Ax8e3?=
 =?us-ascii?Q?8D/ifbGMFK82wBGebLzEUHfGTiP/YluYBC+FRk59geuyR5ALIZW4TCQecYlc?=
 =?us-ascii?Q?SUBFtUQS1ZnXIPquVjjITsT0ysygIuSYq/NyWmHKLxq3dTzQWAp++eu8G0MW?=
 =?us-ascii?Q?kf37XE3/xtS7uC1fL0GydeGARElH05Ux7zTlZCd9RTkkmvcR65XwH1gqNI0N?=
 =?us-ascii?Q?kMrOMn5xifObvwg/FdE+tY8KtgoIAJqWmsrbv6detAKsMbbREYn/nCrFiLsN?=
 =?us-ascii?Q?yOk7fJJchP1iSgObV+zzvaB74LGG4Yda7htBH1BS2GXuqzEcmTxjjBlP2WC7?=
 =?us-ascii?Q?29mCAf5GY3KP18c0Mr6wQ3j3umyy3Eo3nnnHCZdzhTzJDv4j3wzjwHzbifLO?=
 =?us-ascii?Q?5lJ2jrr+sJC9xErc4BKlc3t/FdQNyTn+RUKEZqmvXxNwMQRuj8ON/PPtFbx5?=
 =?us-ascii?Q?4pq3oMeUcT5fF6S0d351Uw/wLEYIfZaQqnZVEyuIVQb0b2nYqKFI8WXbHEB2?=
 =?us-ascii?Q?rqffVhAC2vkFe7YfmX2wsm6q5t6Gc4iLYrC7DfN9TW8zMXi+dRTl4dk2Of3r?=
 =?us-ascii?Q?e1PfgOPmLy7z0BjnpAo5Cz0vq/fw8FZrhM35wM8etQKySw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UXl0hTJ0dAnjiv1UurzKks1f/3uhiqBlDhXCJ421RsVGX31pgBFg0mwYs1rL?=
 =?us-ascii?Q?TnOlZwFpp+yCwPYMj5eV88x3U+mWUKFryZZcV9H6tBW0CPSHUw7upTfc+u4U?=
 =?us-ascii?Q?6qM40ADEmmezlt0phYxwrt9zFEnp65oxYKvUQ9VF436EeYEp/4RXIy/pH5Fg?=
 =?us-ascii?Q?zPVRDkJf5C8B2HQLJ8pvQ1TCROcMK7BOJYI2UZAAuUejrRgj3dn1jwi3QnbW?=
 =?us-ascii?Q?SHCB8BU8lbzZlsTxJtz9NRVF1FxyFk7IqJZGpdM3b5k9WzmLn5P15AKSGig8?=
 =?us-ascii?Q?F1a2SWKZx9xcKlGa6b+47skMgNkXVFBj3m5xFUxNS203dKWF1qO/8GrqbGM5?=
 =?us-ascii?Q?dkeJRl1Xk38SG7KjG/an0g93wg/PUltzCPq3WYLmtrgzXjg3RX+vEmcHwDAo?=
 =?us-ascii?Q?rJfNeuU8uGFZ6K1KDx3KrieyhYK3AUdjdAbT9nWr7kZuG24ZN8e0j3qgvyPL?=
 =?us-ascii?Q?CMnK/I7aDnVt4+nPawwGeGk4Sd+WZHj+9rZ0QCOwnZzTERTMq2b2fbFoSB17?=
 =?us-ascii?Q?Nch4K/lZw6zCOW5J5vT5LZ2FimVe3moMYrds9nAP9rI/y/SbsmaywtqHEbm+?=
 =?us-ascii?Q?Gy44uwciApZB2EwNCoeg1+Ihs19Qp3ze0xnrFT3UWpWIefh1sOlNe0IB9Wic?=
 =?us-ascii?Q?GZf0zlW8tsIn4EEoEzrFsejcKWRcVlnE2KR0x/htPDUj7Oo26jyAwMcv+7NX?=
 =?us-ascii?Q?DZCDm8MXvYgBaeiR4rxRJaBD69VBFIG0CtRhCzDV9lorZPoxIvpCQFpDVe9J?=
 =?us-ascii?Q?QI9uyKfpTbqMVlfcp2we6ToMIKYeCT36I+ZGPigIHUY1HXjHirz2PFPel4FM?=
 =?us-ascii?Q?yGiHUObogje5U0w9prywNWa9oPYRptFSTthX3kKiVSsqZDnOgM3YF5lm3/2w?=
 =?us-ascii?Q?2YnFaV2gr86YY/PigruhmWfs0gj11dZf0I3gLPRLEBpOW5TlD5b3lIwnMCa+?=
 =?us-ascii?Q?BUzF150vs7Jmc7k/QtfUOCzsP6gaNmaNNCL1EfWlO9no8Z1UMYH1SH3R7c9s?=
 =?us-ascii?Q?dnMiYQD90LN9d/xdQDYHSEwof8MV44CSePZxeznjBPi/EFisFGSA3hycaMvq?=
 =?us-ascii?Q?gipoK5zyPX+gZZig1JwsaOS/JQvDaFapIj8BRKYu/QEsQkTczXx6JgDHaUwt?=
 =?us-ascii?Q?pXPLP829MbHE3RzKGk0oa9d2lldQYoGlEx2ikq81Tdxxiopj7VwsS0U9X1BJ?=
 =?us-ascii?Q?QrPKRyh9O1cbC/MY6Bdg1UXef9HUKcopiph5MCtgDXp81HuIIfVTT2+85jIt?=
 =?us-ascii?Q?6+Zr14aKJK4MUYMceN7Dx3SAEaqvclatLUrAWYU+f5mbU2hqQSgjAULcFSZ0?=
 =?us-ascii?Q?jxL9jBFyvPNAHwi9qeBSYgYoHOlqpL3LRfj/1aD1eF+6n2phpzu4xlGkTi03?=
 =?us-ascii?Q?9hxAxxRzRfmcZ8Ca2tqfZXYJFnHk9q9xJMu3/++cSYU91XClrnAe8hFtInho?=
 =?us-ascii?Q?Mae95snft021H6jDhqbZHiDnNquWFbPH3YK6iAk8fFghVIQkFV8MeECrRy+P?=
 =?us-ascii?Q?8Z78I/Noqj7DcqCdG41tqiijJUx6Qptc6W+stFVyr5lhkg1wVhMIOMzjPXJC?=
 =?us-ascii?Q?8W91OLALbgp/9wzHHnQliGuALWA3hPLI3xEQnWET?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3aeea5-4545-4d0e-f0a3-08dc68c58145
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 03:27:46.6108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7ngorfiAw9rNYoKHpiSL5M4iq4K7kcYXp77DkGN+igeRQfrCK1Pmp1KZMq8Wrp2SuUO7JQcyzqHnl45vkGuYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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

Ping ...

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Sunday, April 28, 2024 4:45 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH 1/2] drm/amd/pm: fix uninitialized variable warnings for
> vega10_hwmgr
>
> Clear warnings that using uninitialized variable when fails to get the va=
lid value
> from SMU.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 46 ++++++++++++++-----
>  .../amd/pm/powerplay/smumgr/vega10_smumgr.c   |  6 ++-
>  2 files changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 9f5bd998c6bf..488ad9de4694 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -354,13 +354,13 @@ static int vega10_odn_initial_default_setting(struc=
t
> pp_hwmgr *hwmgr)
>       return 0;
>  }
>
> -static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
> +static int vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>  {
>       struct vega10_hwmgr *data =3D hwmgr->backend;
> -     int i;
>       uint32_t sub_vendor_id, hw_revision;
>       uint32_t top32, bottom32;
>       struct amdgpu_device *adev =3D hwmgr->adev;
> +     int ret, i;
>
>       vega10_initialize_power_tune_defaults(hwmgr);
>
> @@ -485,9 +485,12 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr
> *hwmgr)
>       if (data->registry_data.vr0hot_enabled)
>               data->smu_features[GNLD_VR0HOT].supported =3D true;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetSmuVersion,
>                       &hwmgr->smu_version);
> +     if (ret)
> +             return ret;
> +
>               /* ACG firmware has major version 5 */
>       if ((hwmgr->smu_version & 0xff000000) =3D=3D 0x5000000)
>               data->smu_features[GNLD_ACG].supported =3D true; @@ -505,10
> +508,16 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>               data->smu_features[GNLD_PCC_LIMIT].supported =3D true;
>
>       /* Get the SN to turn into a Unique ID */
> -     smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32,
> &top32);
> -     smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumTop32, &top32);
> +     if (ret)
> +             return ret;
> +
> +     ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_ReadSerialNumBottom32, &bottom32);
> +     if (ret)
> +             return ret;
>
>       adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;
> +     return 0;
>  }
>
>  #ifdef PPLIB_VEGA10_EVV_SUPPORT
> @@ -882,7 +891,9 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr
> *hwmgr)
>
>       vega10_set_features_platform_caps(hwmgr);
>
> -     vega10_init_dpm_defaults(hwmgr);
> +     result =3D vega10_init_dpm_defaults(hwmgr);
> +     if (result)
> +             return result;
>
>  #ifdef PPLIB_VEGA10_EVV_SUPPORT
>       /* Get leakage voltage based on leakage ID. */ @@ -3900,11 +3911,14
> @@ static int vega10_get_gpu_power(struct pp_hwmgr *hwmgr,
>               uint32_t *query)
>  {
>       uint32_t value;
> +     int ret;
>
>       if (!query)
>               return -EINVAL;
>
> -     smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr,
> &value);
> +     ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr,
> &value);
> +     if (ret)
> +             return ret;
>
>       /* SMC returning actual watts, keep consistent with legacy asics, l=
ow 8
> bit as 8 fractional bits */
>       *query =3D value << 8;
> @@ -4800,14 +4814,16 @@ static int vega10_print_clock_levels(struct
> pp_hwmgr *hwmgr,
>       uint32_t gen_speed, lane_width, current_gen_speed,
> current_lane_width;
>       PPTable_t *pptable =3D &(data->smc_state_table.pp_table);
>
> -     int i, now, size =3D 0, count =3D 0;
> +     int i, ret, now,  size =3D 0, count =3D 0;
>
>       switch (type) {
>       case PP_SCLK:
>               if (data->registry_data.sclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentGfxclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentGfxclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               if (hwmgr->pp_one_vf &&
>                   (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
> @@ -4823,7 +4839,9 @@ static int vega10_print_clock_levels(struct pp_hwmg=
r
> *hwmgr,
>               if (data->registry_data.mclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentUclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < mclk_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n", @@ =
-
> 4834,7 +4852,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>               if (data->registry_data.socclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentSocclkIndex, &now);
> +             ret =3D smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_GetCurrentSocclkIndex, &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < soc_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n", @@ =
-
> 4845,8 +4865,10 @@ static int vega10_print_clock_levels(struct pp_hwmgr
> *hwmgr,
>               if (data->registry_data.dcefclk_dpm_key_disabled)
>                       break;
>
> -             smum_send_msg_to_smc_with_parameter(hwmgr,
> +             ret =3D smum_send_msg_to_smc_with_parameter(hwmgr,
>                               PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK,
> &now);
> +             if (ret)
> +                     break;
>
>               for (i =3D 0; i < dcef_table->count; i++)
>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n", dif=
f --git
> a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> index a70d73896649..f9c0f117725d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -130,13 +130,17 @@ int vega10_get_enabled_smc_features(struct
> pp_hwmgr *hwmgr,
>                           uint64_t *features_enabled)
>  {
>       uint32_t enabled_features;
> +     int ret;
>
>       if (features_enabled =3D=3D NULL)
>               return -EINVAL;
>
> -     smum_send_msg_to_smc(hwmgr,
> +     ret =3D smum_send_msg_to_smc(hwmgr,
>                       PPSMC_MSG_GetEnabledSmuFeatures,
>                       &enabled_features);
> +     if (ret)
> +             return ret;
> +
>       *features_enabled =3D enabled_features;
>
>       return 0;
> --
> 2.39.2

