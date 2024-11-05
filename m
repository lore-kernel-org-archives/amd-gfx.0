Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D7D33A28
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 18:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52EFE10E16B;
	Tue,  5 Nov 2024 18:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="smC29w37";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA1A10E16B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 18:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcqz0I+iiwq2KgqjGdbKJLrHMrKw3+pAYjDsfRE7MUXwz9uPfyH6hOe00u3EK6ZmroYChM1zyh2CtxLabemV/sEIY6RF3EodwNK3I5g6X0kWPHFMWD9YIThTSmedv6v6j+zm98uCoWE3NTY+Hyh0j/EQz/7MpEFmHkuY036bOvRVcjiVnyQ3mB0UU9Ia5Z6LcisDYgD/0mmipvvX+srAIp0EDgATV4RpDGUFOmrzsJ0QpqH2xKa7dg7AGJAVRBWkdoz5S6lEbjpOYwqxsWqxM1qImoFrtHLGSKX/3fRa6tXOyoxRPqps8yQv49sPGC4Tf4OkLob+81KZIEEZad1NLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S8i9V/gpC2VAS9p5UbRZpL8NWIhE0rfaijzQLkwDhA=;
 b=YpzC9OSMvKHYNDTnyh3cnV67IYkKea1MqzQ4fCQWDSTbdwzDwmso98b2auISkGWF+OaxQvfdKLndIi2lhHHd68Ii99oAw+MCVBjLgeMhqgTrrm2Se7XuGlkQ08jWnQ/o/+ADa3RahkWaMd//U0Y6zVusdQEF1GC8czMYG5yiV/jSZDT9+NqmbKQMsBQG+k+PC8Z2lNm1c2FID9BF+Ll0qXXB6P6L5hdhhBlpDj8YThAfemnWQK2qb+UcpqjsZKLRQCns9AXdZio2B30RASiCSAi34bV2z7akW+3d/kJlH6tknh4WVN8tvYU6FojMhRYaG22ThiVu1aUSV6aWufVajg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S8i9V/gpC2VAS9p5UbRZpL8NWIhE0rfaijzQLkwDhA=;
 b=smC29w37QpMFjoS+5NbMo348eiiQCuFxS2Z5NO5pfH/OIfRrDro+Ie0/nk4yh3cyl591wPlUzLYwwKmN2FEh1CZqmCkyZxZ0ftewRriVl5i91Xuy9PDvu6GK4R2Fbqbkao2w+Fe7v9ys2yLuFvphFm8G6p+yCt2i/PqdyLEYk2E=
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 18:50:04 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::909f:efdc:6c3:e8d9%3]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 18:50:04 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Thread-Topic: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
Thread-Index: AQHbL7Lzuq2W3dPToU+hJPTgNF0ILLKpBuTg
Date: Tue, 5 Nov 2024 18:50:04 +0000
Message-ID: <CH3PR12MB939570378665A8760939652299522@CH3PR12MB9395.namprd12.prod.outlook.com>
References: <20241105184546.333948-1-jonathan.kim@amd.com>
In-Reply-To: <20241105184546.333948-1-jonathan.kim@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2ef07f84-ac12-46b5-8ea4-645c09bd603f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-05T18:49:50Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9395:EE_|CY8PR12MB7242:EE_
x-ms-office365-filtering-correlation-id: 5116487d-8dc9-4cae-f219-08dcfdcaa929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bPcx7678e0++PhMrNVSsx0ZJegE+zGl4PKAsbcP2zSGUi2gl06WCRtxAEeqQ?=
 =?us-ascii?Q?09/WytNjaVYSaup5Y2MHqxp+8X5bbLTheU3iBINNDdL/NnPIQo4TVaDsb+qI?=
 =?us-ascii?Q?FobJY3474qB9LNK3VLrQR2A2xqZSrF9/b+8htalNZzFK2SoHuLLi7hB0lZzI?=
 =?us-ascii?Q?IhWtMiMtz/E+MS3Q/l3AP5ufZLmPtsETitdyWdObh7hWgitD48jYCP2urNwF?=
 =?us-ascii?Q?wtj7GlbZWbbjFuu9W6PhhycAnfnvTbGTNhEixd2oaLQFIhHtBBGMtrLx6018?=
 =?us-ascii?Q?QGzaeDWMyeAxHfIdfrtz4AVvoTtILKazAg2u8VzY2oPQd+hvlni8JO4+s5+u?=
 =?us-ascii?Q?Nio/2ynNr10Hd7Q89I/vIdmYKLIthP9DvM9rlQHYk9YPDVwNB5YEuhrsjVkX?=
 =?us-ascii?Q?8Sn4fSZsg+YV4F1O2ylwGxj03jbq+dxZMFqkQaewPUHPzjP+tz0vJfJBnUVO?=
 =?us-ascii?Q?x6TCnQ8rg3jmBe98B4xENnDUk98eVNMFdcsnj09VeiowmBXAbSXTeylv4QUy?=
 =?us-ascii?Q?tEelheV4Hpad9sEu1aBT3P65kO2/U+GIDFqAQBfKjFMyEemRzbNqUBY2yuMQ?=
 =?us-ascii?Q?k4OrppHYSo+1sx2fdP81gOyevYs7wYtA9wYeaDXQ7WfTFsC5C4/fbtpvMzfm?=
 =?us-ascii?Q?IWkUbIVwiHaoMFfHworcgOoCBEUmgnO6NgKVuHlhSE9Pf4bu1Iu8GKHVys4t?=
 =?us-ascii?Q?mxLMMLnYPE7PRF5CJ7b2kUlcLqOzRgownjGUkeoAl8uGdP/Fksaqm9FCvJwW?=
 =?us-ascii?Q?tXvKlgD14rvUifsP2uInZ9sFUgPcVL2hqdr45CNM+cSmjjFaGgQBuJFrLM7V?=
 =?us-ascii?Q?G+KNQTu/mZ6XRXWykqFEG6w7AMU2FdAESaw6Ol3jHDGm8I01bO7k6YzpHqA2?=
 =?us-ascii?Q?AI0I6fettsmdUsl36FY+YLloI9Uo0Zcf9CgKJ5m2o1MllgxdsMCLza8uWKFM?=
 =?us-ascii?Q?bfdPR4BpyzF6GUMGNOt05sTfh8z3XK6wmNBSSXqpRLuejrIhE+xpOjLAw89O?=
 =?us-ascii?Q?40OHmAnvDKVIAC5voly0dA3wt8Yp0BoSxJgbBE6dmwMQizCetz+ESStVbWvQ?=
 =?us-ascii?Q?9jsMrb3Ir+7uWfsgs6jMdMm8v6uPpK2cTM5H1V0ctdMsG7zAFzbUvH//T5oq?=
 =?us-ascii?Q?rNKFvsPyVm5XwIj9+sCNueSFziijEQjEyLF4le5XL82Gvrl/TML9GFv5ZwHU?=
 =?us-ascii?Q?Dyc2EaHA5w7sO1ptgW28SECtjfZ200M5+luVfZoQ/Gb1rT7H1IbE291FB21i?=
 =?us-ascii?Q?5NCu2pms3SxHRzkBe+tg49Bza4NpHUUII3i2WpUTWAztWVAULHLSkoXy47BS?=
 =?us-ascii?Q?1GH/IOm7JuESZHsRZynsRa9l7Ku+ayTYluNuw6YUD24/XsbZUT+r+1PXXkBk?=
 =?us-ascii?Q?frzb0go=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xREJarcgEpjLZdkl5JtKifkH1vPGNuVZ2944Yk1G7j0Su0tN6G5bIRPxCBFR?=
 =?us-ascii?Q?JoI8Gp8nmAI8SmeOTGSz6tJ40pdAOycxSAksogE9hfhtVEkP2tCJeoUfYMaf?=
 =?us-ascii?Q?SmdzTw7IjHAK7SEQTW/rU+YxBcGPo0O10FTon+CV9laEb1ZFZUEfGJVn452c?=
 =?us-ascii?Q?0q7ajC8dTbzqoiXrDRp5evKIjY5ZWXTk+Dvwjil+BakkcXEqPcs67MlTredy?=
 =?us-ascii?Q?/z7medIAZ2picvagmUn59VU3kybzEXZERA3ZchPwMIV5qMqgb7Q9dqXQu2gg?=
 =?us-ascii?Q?L5Y1VbD3ifyq/Zdsoj8wZF7c41uICfNrrmqDI4dqVWod1BGe+FC8cgYn+6N6?=
 =?us-ascii?Q?uwFeOPEZvXkKbBHOKbSDI59HKoxFRCqAEoNUPFgID/Grs7obJuLIE9nLIoUZ?=
 =?us-ascii?Q?K3kRcxjuLG23csuzTQ3n7pJzV0SEnyIVcjp7a8yXXa4lWbWQUstqC1yJZC13?=
 =?us-ascii?Q?nBhMjSaU5VJGU1Ov1evD81/vfBSuLTSMQqhLNHJbccXS+R6S0m9TkIfma3zk?=
 =?us-ascii?Q?emn51wj5QE7ev64nO1tJoty/IbtbB7Yo4f/otnaoNjOpGTfKRv6iHdndfNrp?=
 =?us-ascii?Q?kwhAlZa+qgaWmmAVctJW0fZ4fufKEQP5K//tfmA95AOEXq1iQPVfMNIpV93t?=
 =?us-ascii?Q?VdPDrW+C3EMpKVhxIrOLv19DBAII/fmqAwefWTsuOugxYJX2FyUlLYoHPOAB?=
 =?us-ascii?Q?Lsut6hQQdfCF3JQ0jComP5V8x4ITr0jEkOgPMUc0iDrp/dw6SVIGESYesv8P?=
 =?us-ascii?Q?JqMO/auHZb7njnJNBgBMR5rqCGwYzlZyaBctxDRoxtvKI2GeXhf/4bmrN9BV?=
 =?us-ascii?Q?jsWpRLjpNEtA6vhzOGX3r68QQlcL0ucg7z6Eq6aviOrz3+h83rUt9Z679DeN?=
 =?us-ascii?Q?pTgyxwSSI0GUQNJY8ZUqJClCzo6Tzi1+DkY3ofOYBLTNH/h6e+RpRcj1ouBJ?=
 =?us-ascii?Q?cktTCT4u6ZFLAchLhAXlT4PS0qdnK5X+G9faAYQahUp+OE3TtiXdXicPL43D?=
 =?us-ascii?Q?84IzKlGLXAzQPH5G+mwZO6v5OxFKFX1E9dJdKxGo/sotIrn7/jVPCt2WkHIi?=
 =?us-ascii?Q?fIK/0VpmqzTO2jzpWof+rX661rTJkaam2+O+CpGi7Guxu89V9msWQKp9354j?=
 =?us-ascii?Q?aEpW+rFb6g4ISkhZuMgji6AUvvA0fbydTBPKvZI1bBpNSOG0Sh2An9VEgqeg?=
 =?us-ascii?Q?HSVVh4jlRhGC32dpEXPFsEYxi6yi7ijKsIJ6BIc4lFS9pa2DzZYlXURinlg8?=
 =?us-ascii?Q?1YvulJLjiXbAhyPS9chMUwm5kec3EEIOggONUbTxITyO7Whcgoidev99or8h?=
 =?us-ascii?Q?b3Hlg+TUTxdQZUxKSnPFqCSQtA1QjY/7YSFmK8lv9wr2PTmVxuNw5IKekRhU?=
 =?us-ascii?Q?1/xDPPsQ8vgB7z+bR4C5SulEcJf/hkPGDj7LanTcC2NWpsGo+810Ca23uekC?=
 =?us-ascii?Q?sEyV+UYU8LbUfUvGsL/AYV5tUJZSocc2K7RNERB49RpmCbsqmfJiWbmD9Q5Q?=
 =?us-ascii?Q?qhz165+vO9pJyl4tPb109NDdJ94Dy2nAHhEr5eOppQ7sXvI3UBE/KiQOppgL?=
 =?us-ascii?Q?NQOiiKXiY3MYf5QoThM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116487d-8dc9-4cae-f219-08dcfdcaa929
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 18:50:04.2759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xsWTzSmNkJmCs9PrDr7zlkOXjUxsPyV8HXImSry7SKq1/zHp2xTwICkzha4aXNCZJS+TGnbAXl/NcCz+ltEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

[Public]

Reviewed-by: David Belanger <david.belanger@amd.com>

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, November 5, 2024 1:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Belanger, David <David.Belanger@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: remove gfx 12 trap handler page size cap
>
> GFX 12 does not require a page size cap for the trap handler because it d=
oes not
> require a CWSR work around like GFX 11 did.
>
> v2: set default cap
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 348925254bff..956198da7859 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -534,7 +534,8 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
>                       kfd->cwsr_isa =3D cwsr_trap_gfx11_hex;
>                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx11_hex);
>               } else {
> -                     BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> PAGE_SIZE);
> +                     BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex)
> +                                          > KFD_CWSR_TMA_OFFSET);
>                       kfd->cwsr_isa =3D cwsr_trap_gfx12_hex;
>                       kfd->cwsr_isa_size =3D sizeof(cwsr_trap_gfx12_hex);
>               }
> --
> 2.34.1

