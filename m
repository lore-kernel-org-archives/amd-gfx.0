Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE8CCCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDF810E6A3;
	Wed,  5 Nov 2025 02:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VG8t2od4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 299F610E6A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNbDSsJSbdhD6cMVUha33RHAyVb8SHnUo0JP6+AZY62eMX3IJsPuTFG0gFCpc/mNq1zJAARXNEiOsMabQlr6k7cutMT925iUGyP62aVUbyVY6loC/qlvg1mc1BR0FCw1YUtg6GtKLMysp+DawgB9n3AvhxiRd8NintcRpHe6Rsb449+D2Qm7eyCPNggjLAtTcrUyTBY8eS7VL2TKiSSgfUWG2lVq1nzCPY/E5eiwHd3gp2VN/BWjiGpFanoVggFIkBK3sRv6EPB5+RZ7sYu8IQbGrsFjqVed4EjGPtBDBmze4u+bgoE28L3Uq3Q8Jywne/mTBrlNnlENNwR4wFjTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2v7IKmYtFLGtQKaPbYdLLOatMl+MV8vi6Q+uARW0w4=;
 b=szRmTzPtONiTIwy68UU+WvepXh6+ucDJTt8wtBCit7elAeHEd7nPuE3eoZPQmElYCD0UudOCYdtCzfFTpI2eK6rqRTpSy23rL9O06TOHBO3b8GTl2rN7npo4Looyy5UQw2qd26UgVaYjFj7VysBiWCr0XxEOId2QUCXvtRaFkwfkNYdL/ENw35sUAbaK9oylhXsZQafPHK5y/TEz0i+IzscpZvVA3RJvmWFK6N0iuXlxOziJ6r8ziHaY6xLn8JqZA1urq+Xo8eaOX+3QNELABWUmXCs6Jrfdt4JuU6baNV8pv4rxrU4/08OjLgRAbr57oKnpiIcNE7JQfDc1LvqMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2v7IKmYtFLGtQKaPbYdLLOatMl+MV8vi6Q+uARW0w4=;
 b=VG8t2od45cGgwlHY2SX4SaSHeJTcREzY6Pop7c4Y1hk+3cGpsiVH/2PswYB8SxZWB3SXRnHkwyiS8k45XewS0bp4e0GF0CUPiUwfIzcUIQ0xxuRuAKN6dqksq/s0dEqKgxikNNmYmNWuZeYtDx7B9rLp4TLCZ2dvgP4RJJXuazI=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 02:36:44 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 02:36:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>
Subject: RE: [PATCH] drm/amd/ras: ras supports i2c eeprom for mp1 v13_0_12
Thread-Topic: [PATCH] drm/amd/ras: ras supports i2c eeprom for mp1 v13_0_12
Thread-Index: AQHcTYSNJaE7kk7EA0G084STompZerTjXvAw
Date: Wed, 5 Nov 2025 02:36:43 +0000
Message-ID: <PH7PR12MB8796D879B0963280AEDA6230B0C5A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251104121333.3655721-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251104121333.3655721-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T02:36:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ1PR12MB6338:EE_
x-ms-office365-filtering-correlation-id: 6e9261ca-952a-466b-f686-08de1c142884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8WQqPr5SNbY1XmJINhKJpmY6agAIKBzSUs4lOAxnfClonGPlQfPin1VKqChg?=
 =?us-ascii?Q?X1Q117D12WNrvCFtw2+7nU1deRxWsez7d4uA+fK7raVehNwpp3VHNM1J+CB1?=
 =?us-ascii?Q?UAwmZBkFp2jjrwC85Xd4lxsK7nye0xKgbjKgNqX2NHV3LsgQktWS8bWXgkhM?=
 =?us-ascii?Q?HRhiC1nWe9XcsZ54ckJTlW9diZj2z6dNuNNPE67vNuEaNlilcB6wqj8Vgrw0?=
 =?us-ascii?Q?v0pumeeVKrQCcDWBWB0/O0ikIBKjqnkTW+q/44im0b2rhR/B8l3Jo914+vnf?=
 =?us-ascii?Q?0IFql9xhphR0Ex+G/DPpv8lS0KsKCmg6NyQRyMPgfbTMgXHjPz8bEfCPfuF0?=
 =?us-ascii?Q?6AYNkDbP6jMOdo1teQyE5Nk+QZQiyG18oZzqxXIMgKaDBN6lT/nuo+ejpvr/?=
 =?us-ascii?Q?LrT2veY75gojWmHcRwqiwCFABuhcAj1SD2R30XvyP5/vw2FjHS1CAne2Ln8O?=
 =?us-ascii?Q?AkcHtlaj+TpCt99lwjDR1N1+AxXSbA6jAKVsdxCUkKVmYV76132KT68ZXxio?=
 =?us-ascii?Q?X9IYfYDhggSLdOokcIecGsSnUA9lMb4BBBALKWfESdHKX9kgVy8opj70hiFf?=
 =?us-ascii?Q?D9MhnIt3Bl4/b9ETIAz6JClvy7Qw+lykrSi9n2Swyzk/tAKFJZ0ziDIGi7Cf?=
 =?us-ascii?Q?LVO2QFiZm6p0iPkZTzlQ/NjuHkgZIafSnrF/HSWd1Pnc9otYuafZpOaLyVIw?=
 =?us-ascii?Q?saUtgDZsSAJVU9xv+JkPGPX3mkPgDzjj2AFTKhQxZVyD+1EeffkTxknFNleG?=
 =?us-ascii?Q?GmZeTOpTLMP9n5Cy7XRGtIAMjzmBpXi6cuhjHXTggSNwYkdIQ46fZFoFuuGo?=
 =?us-ascii?Q?Qnu9YORgbJGiVfa2VyVWpGholD2PvHipSB+QNWhB/qrfsr0p3GWcSRNf9vao?=
 =?us-ascii?Q?LXAJ4YMaEMuBsqMeHFeCOaExNRymRofHnhEg3tEvkLbI4d3kZoLczY4oJ1ku?=
 =?us-ascii?Q?q35UAlZVKgg1wif2zd/6j8bc9zuOTC/8gs3Iknmbhblz8MmrOpmBiYd/3CbN?=
 =?us-ascii?Q?yqmEkz3Xg1vUYQelUpf905+6BnPTWDD+qiJd4pnx3njGizDk5jZJ6lgzLhz4?=
 =?us-ascii?Q?f3FiiTzFsN4DniU/cdy8I/myIA9Bbr1DBSMsTkvuErfdz4VppANoLaNqH6Z+?=
 =?us-ascii?Q?phTYH6JL11mUxAzJ5+vDsMDCPg7CE2K0smnbF7Et6SHhW+xOz6pyv0evJbUJ?=
 =?us-ascii?Q?PXTAo4//xb4HmLHdHSTSq2fMf5oZ5d4rIAQTPwNC4A2CptRyw4N63rDHBifx?=
 =?us-ascii?Q?vo8jUAOI4WGRLTFpg1VY2oJd+y43plsJWUq+DACJkKfAqSWFB8JLcQ0a7Sqk?=
 =?us-ascii?Q?uxT8/TUAW9ij8aEPZdWEp93J6/QBpJioj6aol2ERxaht9fsemFu5vIdi094d?=
 =?us-ascii?Q?V142Y0yZnEuOCag/43MxSuFoFvdS8CRQUZweByYsuUQU154CuOdMRDp/wgCo?=
 =?us-ascii?Q?3LJYs+Czq76d5OrBeTaaXB6ra/XIjDqRrQz5D5PN46rjIAwby6w+HKC0yw9L?=
 =?us-ascii?Q?F5S9w6rRLNqBcbPUlSKt9UtQFykGEjC7abD/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AP+pELY2wQ+x7bbktLHrxoV7K89ymQV7+tpmiu2tfYrPbDXCfAD57GyEFYR7?=
 =?us-ascii?Q?/p+P27s3sfjhoGDyVKXdSruhiNmqX0MlcHIqOP3D3nWtc4vEPURkv/KoHIif?=
 =?us-ascii?Q?RV27kyQIethxqkJCzWjQwSePjfsPHlhlN2T79xhZLUzJut8NKJ7/Zauzdj9X?=
 =?us-ascii?Q?ItDC2RtqzqhBXG4SiiH18uZZJTHgbRy5D+q4V5uAbIdVPg8/klI06ioQriDd?=
 =?us-ascii?Q?Ai1JDMNIKzByeWKT+SM47N0mJBfgPNWsqF8sQxa1t4POM6F/S+bIw212suBo?=
 =?us-ascii?Q?3UjIKDfrRT/tetYQMrEGaSJBYy7fiGjqpsTWL+gywxxZp+nwKW+x4zRwVYzf?=
 =?us-ascii?Q?dwgxD6gRgjKCozdwBfMkR56bzSrVs8cGxewjdnc1TrWsjbXEKCj+0c5+1JAR?=
 =?us-ascii?Q?OQF69ZeiBceQhkPLvN1Gtmb8titaQPnYsc4zyYBzNZRgI9dVDxrs1A4GEFY9?=
 =?us-ascii?Q?E1uCf2p3DmyG7MHCLul1meP5vFHl+p+vEeBBg7ypoUAGsEGqBKSoEfnzJLdj?=
 =?us-ascii?Q?pOG6n/pRLZIG6NjYx3kXMVYBMB2dFpP59Zsw5orPf4mhuhaYcwx03aP8c2hm?=
 =?us-ascii?Q?jkkRKQLxAQYWMsOZ65Ji/kXlCEBNU4DArBfSFgZMz9fp+4kxDaZvmtX1l4mj?=
 =?us-ascii?Q?Z/lTfczkFwPidP+WJmTCogzDpy9kYHhsRGGoE2tyaYtIchlfGd8g1vRvoiKH?=
 =?us-ascii?Q?KBIDKS0ba6etf2EAfVpfFCBeI0RKFaraSlmWEZt/NkLPDSNTijJGg/p+aDn/?=
 =?us-ascii?Q?teSZqeBEWKucTxPtSUAHlwZq5dtxyPGklOYDcfvJC9niw+YH4d6pWExbtcoL?=
 =?us-ascii?Q?2zaSKuldbW1V/WMWQswQdPuwbEOqWofpr05yHetuC0jlIcQBx/KM6RMp/poP?=
 =?us-ascii?Q?t4aSYeB7z9EFUVzDsNYuJGvMcMkv96DiXgL+fgMscQqhxGnCiHa3BHIE7XlY?=
 =?us-ascii?Q?0dDcTe6HvC4PuPlrdcaSJNkYwOxdAWUg6TP2lgaKP1jVpziEDYZYhLvjVcNB?=
 =?us-ascii?Q?sZ3rbIWiP+csqjb/ljBXG/6zexel7xyX4PdHxc+ixk7cmogjgyn2DqBeHX2i?=
 =?us-ascii?Q?MkWarW6UlFszM8sYD9Yt+Axv+3Tle8ezLUfxgPARIRAMABs+uIPKOBF5aDDJ?=
 =?us-ascii?Q?v+cpxZfHvJRTJwm9AoAi3V5/IOUveZ22aphXl6fi7Bc2bIzLB80bFQks1V8Q?=
 =?us-ascii?Q?bUvbPRaRfpNVXb3QL2cFQ3mgsFR/WyogVeUuLacUI50qopYqZrzHfZVTkXPu?=
 =?us-ascii?Q?RzLYbtu36tInpHLswryNC4TCk/os26Q5OSBRyUVplM7i/uVL5wZmVBqslFCs?=
 =?us-ascii?Q?mZQyrRAzF8I+KeB3cyhbAYODlZ6RaVyCTWsj0c2ArVaHylxpH+n1+3QZ1vUo?=
 =?us-ascii?Q?QyDYFacBoMPtdiCf3Si28Tv7p0HIu8N5PfEDYFfH/cxIbUDUaZQthHJ2FOZ3?=
 =?us-ascii?Q?GNmVphJ4gMhgmLH4i9BTu+vmOgOUUEKJDlrk1sYay4YTokqyMcsLbeJ0PEkB?=
 =?us-ascii?Q?+gupOj/7omDT2FzGzWEKwEejggYMbetbi6T/0PdD5ENGg384leBX0cWmIx0N?=
 =?us-ascii?Q?TdjYcXVk+6VyR9fbqlc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9261ca-952a-466b-f686-08de1c142884
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 02:36:43.7326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKOtcg2gF51Cr1An4gcthYsen1aRkwMVYpWmm7hF2INSE+cWkODbHX1Z90jP/E2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Tuesday, November 4, 2025 8:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amd/ras: ras supports i2c eeprom for mp1 v13_0_12
>
> ras supports i2c eeprom for mp1 v13_0_12.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> index 1bb7b7001ec7..3ed3ff42b7e1 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> @@ -85,6 +85,7 @@ static int ras_eeprom_i2c_config(struct ras_core_contex=
t
> *ras_core)
>       case IP_VERSION(13, 0, 5):
>       case IP_VERSION(13, 0, 6):
>       case IP_VERSION(13, 0, 10):
> +     case IP_VERSION(13, 0, 12):
>       case IP_VERSION(13, 0, 14):
>               control->i2c_address =3D EEPROM_I2C_MADDR_4;
>               return 0;
> --
> 2.34.1

