Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DBCCD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E561810ED19;
	Tue, 19 May 2026 13:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HBk92wHc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664FA10ED19
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuyYcPEMBSzm00zTPpwVT/Q4Wrde5ECPGYqwBo7RdZgvIFgSOtu7iZIDACE+Jk2qJ5fkvJfCMjNPYYW80snFFaP+4TrAhNQsuqe7Oq804RDV772+LTn07KWT7drD6qyD2mKkK47lN5h6qT2R1c5F+m5AVzcP4aLCcsL+hjoIg6mqTBs/uqRhfiQNFbZeMeyyrUAUruE1fFTevEfPr/gDxy5Hoa+hxxKcKdkgLGqX4dDCMAiFv23UI3w5uj+eEz6KXkWFsjPJEeAxQ5mtNr5XfsJZswM1VMn0SJ803MraxsLefzkmvphQwrUCoBGpgXum+0kzzXiJRmFPBvEcQr2BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4RU9BWFuRXSWndA5MQeHkH/9lAQ/HQuX4LrXgOVvIA=;
 b=lGwx1S8UrkBJmLm2+EYmNHOb1WQCT9QjXNwA03uJxpxE2X9VNgNRNIhcI89extlgYJh2eHcIdtL69g9lJ7waCn/+zQnUhTm8TiojdStsQMk6eUufpghaTY0dBR4a4hWEWPm6YRaOD6auV25FMHurzCD1CSVj7qim4d9QLCdj2uvbhKflnjPTSq9pj33Tl6rlaZkXBaC6RAgrzNIYs8Y2sQVmcmuX7nH3AKmSVJGWXwryl8ZQNZ3CEergqy6b5x8aUW9l4rVy7qY4TKW2o8mhaem4OE/8SFZsOkZtt9jsiiqifWMG2N8dpLPQsICxng3XUJF8nZaA0HhW2jv2Hp4vWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4RU9BWFuRXSWndA5MQeHkH/9lAQ/HQuX4LrXgOVvIA=;
 b=HBk92wHcNo/Zw5xCiIjwSuVk3PXfL3NLJK/Lkqv128zaPPoSZq27W2HBMa1JSQPwqbPWuk+K1GgIEAxNLfvjfsYfUmuF4Hykz7nMqBGOq19+zWCq2qQz6WKu60lxO+vCQCPg4sj8qEor/gSIQp2yi0UNRzOPhTIWi5TsaV6JNko=
Received: from SAWPR12MB999142.namprd12.prod.outlook.com
 (2603:10b6:806:4e1::12) by PH7PR12MB7114.namprd12.prod.outlook.com
 (2603:10b6:510:1ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 13:43:43 +0000
Received: from SAWPR12MB999142.namprd12.prod.outlook.com
 ([fe80::ea70:6206:b9c7:c747]) by SAWPR12MB999142.namprd12.prod.outlook.com
 ([fe80::ea70:6206:b9c7:c747%4]) with mapi id 15.20.9891.008; Tue, 19 May 2026
 13:43:43 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Muthyala, Jeevana" <Jeevana.Muthyala2@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Muthyala, Jeevana" <Jeevana.Muthyala2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified
 ring
Thread-Topic: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified
 ring
Thread-Index: AQHc55GR0ZOiq9vmVUyStun8jEPydLYVW6tg
Date: Tue, 19 May 2026 13:43:43 +0000
Message-ID: <SAWPR12MB999142BBEA63C82BF60F89848AE5002@SAWPR12MB999142.namprd12.prod.outlook.com>
References: <20260519131501.1077205-1-jmuthyal@amd.com>
In-Reply-To: <20260519131501.1077205-1-jmuthyal@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-19T13:42:58.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999142:EE_|PH7PR12MB7114:EE_
x-ms-office365-filtering-correlation-id: 25b7b5d0-c7eb-474d-85db-08deb5aca4cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|18002099003|56012099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: p8K2NmIDohnqmidUhHN81WfjQbJ8eX6OTkBqX/fmaPfayOdu9WQ1xKnNDHFGjb3GJR/Um7SR9fF7aV80z+0fyLa6TST7d8ViBLOeaUrU8H62UkbeRZHpYhAE+mCbbLP/CepusSl2Yohp0N8UzPo50cBHO6toA10h/oEudCib+UDUH2KAFUzF3oG2RkBiT3c91A4LVI+SbkACDJCs6cWORMv3uOpS0XwYdIJaBL3LQkPko6zIW/l4CdHak+Ih9iN/bdeQt90FAanVh3v8v1kl/2vttvHR6PIfsHvikbTMe+AdGtAgWZx/8MarfZV2fX3OxgmjFqnuM9cQEYXcRXixf7vAnWmt/ReWjdFT0SO8GejbY2IC+3vHVvEttU29E+vAXQm8B3oUdQlKqpnAvypMQf0sPM/8NiWIFKvcICZd4Ciga+lKf5ezg1ofrjK8vKG/+D86GzczRz66ykbgDIxLo5lqXeKz+HJ41gyZ6OGuYtTLO0Imvu8cYMygfU6ovu10vMjLnwZmX9n3NQ7s0d/F5b48a3GLr4+KWxjgVaavcE70DauIJ/ykV96HF3672NGTkFQREfjvlrwpaGfy1GrUv2kxeB8rcJ/THYLDtUg3cnPYhGP6h2Ok43C7oIqxR3Xh7fUw0wYUvKu1ChCn09KOihl3RPoEgHySERYo1oxAXtNvOB4bbXGyjdYS7rEnIvxqHg854iRas7k8btOkpgf5irUKcXLKpubC+yOWJRBUJy1m1jfevBl5EJU47zpC8GvY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SAWPR12MB999142.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SD2gFfEoZdlMjBiXrkys6y9AZ77QG52gyR4f7TP3K0+eAYWv01iNE920/maH?=
 =?us-ascii?Q?qK5p+fNmXd9wcBbpGxO1BOSUYvb4xPX1VN74aeWp+2ldVc50/1zlPbA4kQyL?=
 =?us-ascii?Q?dmjzBbGEXGaXsPASjzwb0Mh/85dYqTIgKplWsOvg3q3LHhZGTLP/JznimGUu?=
 =?us-ascii?Q?s1SM2tAD6OLictcrJr7jd7hlazHv/qXx05l6BbwJj2SQPIvcjMCILtjGi1BM?=
 =?us-ascii?Q?499Y4FbrtkiI8oXMf9gPiVgd3pcmivikjocijV0nUW7q2+XCM1wB3hQ1epZ3?=
 =?us-ascii?Q?jRHY1KG5qakw6jwXP6vBdAVBAs5Djg4ZQWgQyH4SUNLjpwuR2FIXhC/3fddF?=
 =?us-ascii?Q?hMSHbg33aq+Dd5Zm0TuiLVLphnCSrZKkz+0aaheXe1qLn1j4u3FmJyCzHrS1?=
 =?us-ascii?Q?CTi38omxwbn92IIEqu10aO4T1gpVBs44d9izcaaVA8Ggyr5MZd18nSU21l5J?=
 =?us-ascii?Q?YmqWrj53FzHDPeaGgBRZPg5LVD6JAHQKb01Bpr3e8wDHPgQ3rQTkTEWW5afQ?=
 =?us-ascii?Q?4Lhy4tX89hOGP8ZAycV3lrLeNbsQ+nVCwB2BgxgsCnnErTf2IOc2+etLLz3V?=
 =?us-ascii?Q?e9QEpuJF3Ihuk74g4V12Nw1GtEs8pu1OHIc4S1sNyhjuV6vcboJX43UeucVv?=
 =?us-ascii?Q?WPt9F8ORvnZQ0RVQIWVTjY6Zl43ad0RrmATU7elvQ0kjuqA6hPdTGq/6Wsiz?=
 =?us-ascii?Q?7us57NaxcUyyWxNPvi2i3cN6ZKco1Dn9cZrShdH/evlVm4qRZ+p4D4z8H346?=
 =?us-ascii?Q?lAgWB483ju3D4RAb2UWTqe++VWSdexRPTg55+r3eggkjsNm+UgmGy3albUpU?=
 =?us-ascii?Q?yDjUCbD3sf7QmomeWQeScvwmr2KMxiZS4RApxIc+Ea6MXshdCpgARn1lQnnX?=
 =?us-ascii?Q?WTFGq1gO+bA5qBl+XqNIbQNMr1/yuzBFUOsmFCBW6kICK5nUaFExFD38XnEY?=
 =?us-ascii?Q?PQaNlBpAWFcoD4nZbcD1EhEbQVXub+v2bNi8mrsCrh4FpVKswz/+qX3kJQ6o?=
 =?us-ascii?Q?phunCwTyAwS7L9STrxEjNds0BpQRHSCXcDvYia/CEHbcx3xLPm0Vt3UYL6tT?=
 =?us-ascii?Q?KvmRiMpA50bx4CWRkS/kfLYUGJQa8kZr6WU/ezRAh1YZZIP3+tPzK/hIB6lG?=
 =?us-ascii?Q?KRYgWlbsdyh2dO6rDdGfAzhZA0xM2UrCjmGXSBnm+N4ovraTiX+1NoQCGAg5?=
 =?us-ascii?Q?Nd0ono6rf8jgAwWLZSF3uTlrCNgwvcNhimdOlNAfGlxgqv4eUVjJCoPwmJrw?=
 =?us-ascii?Q?MbjCVO/akQ73pA2DNzrbJxeL/+nfwlXxhDQox5z9zYis2CRUltGkKca8gJXW?=
 =?us-ascii?Q?ejGsiNSsorn2vZPioYp8ZRbRjaa8CfYuyHvzweHVw2o9zb8936xXBpV0D6JX?=
 =?us-ascii?Q?zBvCNSF3Gs3DcmB7dJzmVq7fnf25a/J7gdH5SY7CUoGUo+zLl05KsXrkhGom?=
 =?us-ascii?Q?EBIrgmdWiPO6IQwjSOe80DkVCUhi9yAEXsrte30lYAEhvckjSL3HG8I0RqFY?=
 =?us-ascii?Q?yq8bYfFxgRN8GQLA2dsplmn/bk0uEeEqt/wtZsMfuCrwnVE3cZD3Vye7z9jk?=
 =?us-ascii?Q?YYgycOB7xpiumtyJ738DWOCvIwIF3PdzU8bq+hrvZ/mY26Iv6Yr7ZVysmaaT?=
 =?us-ascii?Q?TE22dMoZzoa+SVO/Tj3CQcl0/AHQJ+aIVt/r8TcKcmc+Q6Sbzpit+srJEu7z?=
 =?us-ascii?Q?JkJUOzLnywWqBHXBnuXBARlqLEVCcSsw29YQcNkdD9FcQVAl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7b5d0-c7eb-474d-85db-08deb5aca4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 13:43:43.6921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIMuWOhL5EZ770LG4o7ZuTmjK7JRAooqZIsCJi8b4NnXyITJP8jNrUtCbevVdsr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

AMD General

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jeevana Muthyala
> Sent: May 19, 2026 9:15 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Muthyala, Jeevana <Jeevana.Muthyala2@amd.com>; Muthyala, Jeevana
> <Jeevana.Muthyala2@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on
> unified ring
>
> [Some people who received this message don't often get email from
> jmuthyal@amd.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
>
> Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index d5f49fa33bee..cef15d6a4704 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1203,7 +1203,7 @@ static int vcn_v5_0_0_ring_reset(struct
> amdgpu_ring *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> -static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs
> =3D {
> +static struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> @@ -1244,12 +1244,15 @@ static const struct amdgpu_ring_funcs
> vcn_v5_0_0_unified_ring_vm_funcs =3D {
>  static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device
> *adev)
>  {
>         int i;
> +
> +       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(5, 3, =
0))
> +
> vcn_v5_0_0_unified_ring_vm_funcs.secure_submission_supported =3D true;
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               adev->vcn.inst[i].ring_enc[0].funcs =3D
> &vcn_v5_0_0_unified_ring_vm_funcs;
> +               adev->vcn.inst[i].ring_enc[0].funcs =3D (const struct
> amdgpu_ring_funcs *)&vcn_v5_0_0_unified_ring_vm_funcs;
>                 adev->vcn.inst[i].ring_enc[0].me =3D i;
>         }
>  }
> --
> 2.43.0

