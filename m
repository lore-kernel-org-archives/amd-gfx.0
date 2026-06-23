Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB0CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 13:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7058D10EB4B;
	Tue, 23 Jun 2026 13:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9HNsDr1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7059210EB4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 13:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2ipTHJVuzIXSD7UuNCdB1oR/S6Ma9PvcJYxJkPxzrx/iSDaKQ/ycSug4Ig53ok3rtt9P4PpXOKaDHVs+1duocc2wcNSfLXshhvf1hCwQVMuK40emk1DQ1AdnMUfdi0mjDmX0Wz3bChW21VSNr2K/vQZrUrBVHvi/YQ67LVILHGpjhG2fjlj46giO6kASOKhgOYOXUtVF62Cdl/GTaYuDlmHgv+sZY1uh+mSDDAYELNEbxDBC8Dd/1O5amZ4rVOVOP1DK7U1df1LDHjhTQhKpRGW0fuxGsLysRPOdFCslXVXX4U1G9/u767E/6EXt5H54yF0m4nc0fZHWMlN6grkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enlF7wh08HP+KkM35DtUh8+sjXLZEiu2rFB3E5oajeg=;
 b=S+93m1yhD0CYrFFd35R2CcPkNiz2WwH7tk1nJfTwxYJ1s3pIGDUZKXBXp4GTRG6/JUWfabdhT8ZL7OdsRW3i/aAYcHTC880f6j+E1hS4idLL7hgRWk2TqJmZ1H031cW/LknFXFTr22NYMmBIPu1nT1PpgltqK7iMxIEPvbECGBbs7N5yRAsslSfiPQQdblXpQfsrddxgqzHPWFYkNGeQO/h9Cep4bWHCiqVUVia+FUI8IEDwmO3RNuzjaiVZogxJwtd6mqTQ1rvaOGSP9+YMnlb4WvBz4aCcnzjhVpivcF4j5SPAmNUMoDsE4eh+tdY3rduWMDXRq9oXGN+omB/1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enlF7wh08HP+KkM35DtUh8+sjXLZEiu2rFB3E5oajeg=;
 b=E9HNsDr1tgzyCVuS+IpYmH9/xIOb72Ns63n1MxSSlZJo1vGm1hI0hH/1HkS9vJ2bjI5tbiKb+YLtZCX1wpHGqGeyPTltFA5tAOOKDi8mh9+LwddjNp2L2dBS3fZEgSW0Ycb/jgaJooBShtqete9M34hsumSOvKfxyXPSYQJIca0=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:19:42 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:19:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Thread-Topic: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Thread-Index: AQHdAvpjfCOATBfIIU2AdJb09CJpkLZMAeYAgAAd5mA=
Date: Tue, 23 Jun 2026 13:19:42 +0000
Message-ID: <DM6PR12MB2972588B986DC36400C6E24382EE2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
 <DM4PR12MB5038A6A427727B37C3E860208EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5038A6A427727B37C3E860208EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T11:30:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: c7291c3a-8d35-4fb7-ae09-08ded12a1642
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|3023799007|11063799006|56012099006|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: qUT28gzthPU62Aim6EZkTm5vu4iU0QyFmeTi5LAtsRZjNYPS5BbiRQvARTBT124U/oI1IOOZ+NTS5/SEpc+50SB/dLbYn+7xMwEMts6Jt11xiV4BaDyfP+FQW8Mrqg8y7hDt8KpvceVi/LEqGHXF6+22WAgBNIIOV92nCk5pGtAg2JNFjMlGhm3aOAv1zBtAlp5jZzBuY5TsjiYn/kaLSf1gMH3nNxpCdUSvCFTGqzPwMLs7I7Lx3Yoti1vxG9D5wNVjMOPXNjxADclwUkSaaI0mqDdYiLcswfPodncHgTeY8F7U55SEFMfDlH85OYDUs7av48EUxqaXCxJvzyA2FcqqiSpWZ9WvHoUKI4x8yNV8fbmKCDieZfXcQ207sJ8n8emW9xYRAGpLTdUWWsm27M2/ceZYEq96L1DDTmzKujIdgeW5yQmH8xIG5WNW6kEnB4tNfymYaslGZfP/KUofAPrwlA3QsuNoC/gOl73IVrqYPJ3GjdHHLVKCbtKgAXGa596QkrhwRyesTlS7t3vO5/JC3I5HRN+dGEI0b9UxBESDobyhwrQ/PSqetqlBLpmFeqE04MFbUKif7rDhEsCDEApAkbZCVkNOyHWVzmSTQjqMzqSuAokUNsOy/z/8eolYcx5l42HLPoYOrqKbigIirJslyBeWBqoN+qz7QROXWN0sv7RlqoqnEtdtPPcOuqT7qPprHYCl5ZVg7ihvYgbpNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(3023799007)(11063799006)(56012099006)(18002099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xfg+wGcJixnZo5zdHnzJXjHHi+4TBOKSjQY9VTWHjnqkBC+qcNy3vU+VvY7B?=
 =?us-ascii?Q?4819mQpfM2KuhyoEB4JFL8CPmAUQ4ZIUPwTxqjWQQeskG09d3hLDSwT6GzKI?=
 =?us-ascii?Q?IB5870FNW7C9D20ArdMG1VzbOMs0egXIWekc/J+GYlRdYulWRGdywvHbNjTC?=
 =?us-ascii?Q?+gITl/kayS5uojOt65dwQ7VvIilNDix4Mt5novYkkgVmk0vb2JesrA9I13p+?=
 =?us-ascii?Q?NCdjHtE/64wwxbbjh5LRlOtdiQaUOwr3HJXGLdluCJ/FpY8V+G0+AKb+HfH9?=
 =?us-ascii?Q?Y8vBzsEeMLrscjwh/ghURs99m9neiOUaLaLItVfa8yffKhlAwgY8OOb6hhEO?=
 =?us-ascii?Q?Uz6TtjTZT60/ADdtZeG11JzzPTHPvJhFIeKsrTCiZoYabUcEn/oHQdCcss/k?=
 =?us-ascii?Q?gxwOwihWOOHairkBE+TnrUxkTlEpgBecfGvsQlo7sypa2GvDuDAxl8KfJrn9?=
 =?us-ascii?Q?hAScWYvIQ4K1LtovsQkFE9/dyerVFAHO9q7bum5XVS3xNtr25WQgTy/I/cRW?=
 =?us-ascii?Q?J5z565mfY14gKHaRcL78kZKjak/NxdUPafPgYZXG/wb9jGHzbODN1GwADwmq?=
 =?us-ascii?Q?YcDlkrbWjOgRwvZAiPJ73ava74hQs1VAdzduv4cW35H6zJ5EDf165d0rvi8n?=
 =?us-ascii?Q?UrBRYAy+5sMsHXXGKzpi08XOjel2lvd1dnLYKMUONKNcpzEBcbXeGd+jgJBR?=
 =?us-ascii?Q?a0A7nd88iUD3uFoAQzt0fJOl2I6EgRmQvC2TA6nRyVSDhLGh1qM6BNSLNKwd?=
 =?us-ascii?Q?7fmiRLbMlFeaXQYkJtnriznlocFfDOkhZR7ZQDB4x3+OxC7gKhh3xuhAMsla?=
 =?us-ascii?Q?ncUbvidDwarzlAHGsxrPpmTlTerGHZJ7PDor4kNHd5SuqYiBjfe3/otc9aKy?=
 =?us-ascii?Q?yJaQMjxfzd+DuqT5vMrg6XflGCsjkCH5opgHPw27lH6nDyOxEBvDzXE2gkoh?=
 =?us-ascii?Q?yp4KNOjlR7tIMPICP+Yaq1AEs9D9RX1Rk82aURDWzWFpzLosUQH/nHj0xpMD?=
 =?us-ascii?Q?2FuUwfEeOOdi8e5dZJEAcP8WbMkdldd0mATmYnTxlbqdO00GLzALnK8b9idN?=
 =?us-ascii?Q?EvQbXLZ18CAvcbGR3RzOh0a5QnEOWrUfWCDp0akSx0bZlzuwDmW98G4ZAi2M?=
 =?us-ascii?Q?CrXMe9TO+Xb5kt7cJj5tOCW6FrbjPwM+vypn01RltqGS7XLbZBzimEF/WM9N?=
 =?us-ascii?Q?DgHQtXrmls7Vo1TueEs4IbmdKzDt4z15agMNXFeYvGznql6054ozHWyRzhCP?=
 =?us-ascii?Q?lk/EHrf17VIyrYeshT2c31BfbnGW/8zmPhvboYkjHvfaYl3/4dOh2GA9ubPR?=
 =?us-ascii?Q?YKRecgQw2vfK2nUQrqNj3xpMQBGCRmiM65tRUHW7GR5lkUEJfrJ4cGdC4zp3?=
 =?us-ascii?Q?kPQh9uku2goxCLq0czHSBT02vjaPsbsH3DY4k/lJBzUlsEg0iISz9fQejHV0?=
 =?us-ascii?Q?5rei8qf9G+1Sa93jtvaUbAdnliy6k5ak+nP6lqtdJLB8MHz+PKjZ+OmSSWiG?=
 =?us-ascii?Q?T1y+RZhr0dY/u7uoE2aQuPnw7//S7b2BHC49owPW1VCTykSASYAlxwoGv86y?=
 =?us-ascii?Q?WDuPNjtFvtm9J8DgopbCxQUMDGWKIPZcGz3ESjlfNNR+oS7Sl6FcIy13BdYd?=
 =?us-ascii?Q?LD12z/yaYljvy2Z6kGCi01U0MAHJulzyg6A+2kohXhsalmasytlp4zjsHKw+?=
 =?us-ascii?Q?rwoCfjXBaKMVs46QxjTtiJITY7I0iWbR1mUEvBCKMyTJzSTB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7291c3a-8d35-4fb7-ae09-08ded12a1642
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 13:19:42.5457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0o8l8CUxlA11++yvX9Irn8JIKBDawpOjsjaghhXfY/ToHLj9bJMnh2Wj2WF66vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Tuesday, June 23, 2026 7:32 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: RE: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable
> bounds
>
> AMD General
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang
> Wang
> Sent: Tuesday, June 23, 2026 3:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
>
> Vega10 PPTable parsing uses VBIOS-provided offsets, revision fields and e=
ntry
> counts to locate subtables. Malformed data can otherwise drive out-of-
> bounds reads from soft_pp_table_size, and voltage lookup tables can
> overrun their fixed-size destination arrays.
>
> Add shared bounds helpers and validate fixed-size subtables, dynamic entr=
y
> arrays and revision-specific layouts before consuming thermal, fan, power=
-
> tune, clock dependency, PCIE, hard-limit and voltage lookup data.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  .../powerplay/hwmgr/vega10_processpptables.c  | 564 ++++++++++++++----
>  1 file changed, 459 insertions(+), 105 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> index 64cff9f4850a..5dc6cd2b0c54 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> +++
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
> @@ -63,6 +63,46 @@ static const void *get_powerplay_table(struct
> pp_hwmgr *hwmgr)
>         return table_address;
>  }
>
> +static bool vega10_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t
> offset,
> +                                     size_t size) {
> +       size_t table_size =3D hwmgr->soft_pp_table_size;
> +
> +       return offset <=3D table_size && size <=3D table_size - offset; }
> +
> +static int get_vega10_subtable(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               u16 table_offset, size_t table_size, const void **table) =
{
> +       PP_ASSERT_WITH_CODE((table_offset !=3D 0),
> +                           "Invalid PowerPlay Table!", return -1);
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *table =3D (const void *)(((unsigned long)powerplay_table) +
> +table_offset);
> +
> +       return 0;
> +}
> +
> +static int validate_vega10_table_entries(struct pp_hwmgr *hwmgr,
> +               u16 table_offset, size_t entries_offset,
> +               u8 num_entries, size_t entry_size) {
> +       size_t table_size;
> +
> +       PP_ASSERT_WITH_CODE((num_entries !=3D 0),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       table_size =3D entries_offset + num_entries * entry_size;
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       return 0;
> +}
> +
>  static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
>         const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
>         const ATOM_Vega10_State_Array **state_array) @@ -102,6 +142,293
> @@ static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> +static int get_vega10_gfxclk_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Vega10_GFXCLK_Dependency_Table
> **gfxclk_dep_table) {
> +       const ATOM_Vega10_GFXCLK_Dependency_Table *table;
> +       u16 table_offset;
> +       size_t table_size;
> +       size_t entry_size;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usGfxclkDependencyTableOffset);
> +       if (!table_offset)
> +               return -EINVAL;
> +
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      sizeof(*table))),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       table =3D (const ATOM_Vega10_GFXCLK_Dependency_Table *)
> +               (((unsigned long)powerplay_table) + table_offset);
> +       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       if (table->ucRevId =3D=3D 0)
> +               entry_size =3D sizeof(ATOM_Vega10_GFXCLK_Dependency_Recor=
d);
> +       else if (table->ucRevId =3D=3D 1)
> +               entry_size =3D
> sizeof(ATOM_Vega10_GFXCLK_Dependency_Record_V2);
> +       else
> +               PP_ASSERT_WITH_CODE(false,
> +                       "Unsupported GFXClockDependencyTable Revision!",
> +                       return -EINVAL);
> +
> +       table_size =3D offsetof(ATOM_Vega10_GFXCLK_Dependency_Table,
> entries) +
> +               table->ucNumEntries * entry_size;
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *gfxclk_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_clk_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               u16 table_offset,
> +               const ATOM_Vega10_SOCCLK_Dependency_Table **clk_dep_table=
)
> {
> +       const ATOM_Vega10_SOCCLK_Dependency_Table *table;
> +       int ret;
> +
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
> +                                           offsetof(ATOM_Vega10_SOCCLK_D=
ependency_Table,
> +                                                    entries),
> +                                           table->ucNumEntries,
> +                                           sizeof(ATOM_Vega10_CLK_Depend=
ency_Record));
> +       if (ret)
> +               return ret;
> +
> +       *clk_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_mclk_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Vega10_MCLK_Dependency_Table **mclk_dep_table)
> {
> +       const ATOM_Vega10_MCLK_Dependency_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usMclkDependencyTableOffset);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
> +                                           offsetof(ATOM_Vega10_MCLK_Dep=
endency_Table,
> +                                                    entries),
> +                                           table->ucNumEntries,
> +                                           sizeof(ATOM_Vega10_MCLK_Depen=
dency_Record));
> +       if (ret)
> +               return ret;
> +
> +       *mclk_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_mm_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Vega10_MM_Dependency_Table **mm_dep_table) {
> +       const ATOM_Vega10_MM_Dependency_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usMMDependencyTableOffset);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
> +                                           offsetof(ATOM_Vega10_MM_Depen=
dency_Table,
> +                                                    entries),
> +                                           table->ucNumEntries,
> +                                           sizeof(ATOM_Vega10_MM_Depende=
ncy_Record));
> +       if (ret)
> +               return ret;
> +
> +       *mm_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_pcie_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const Vega10_PPTable_Generic_SubTable_Header **pcie_table=
) {
> +       const ATOM_Vega10_PCIE_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usPCIETableOffset);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       if (!table->ucNumEntries) {
> +               *pcie_table =3D (const Vega10_PPTable_Generic_SubTable_He=
ader
> *)table;
> +               return 0;
> +       }
> +
> +       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
> +                                           offsetof(ATOM_Vega10_PCIE_Tab=
le,
> +                                                    entries),
> +                                           table->ucNumEntries,
> +                                           sizeof(ATOM_Vega10_PCIE_Recor=
d));
> +       if (ret)
> +               return ret;
> +
> +       *pcie_table =3D (const Vega10_PPTable_Generic_SubTable_Header
> + *)table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_hard_limit_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Vega10_Hard_Limit_Table **hard_limit_table) {
> +       const ATOM_Vega10_Hard_Limit_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usHardLimitTableOff=
set);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
> +                                           offsetof(ATOM_Vega10_Hard_Lim=
it_Table,
> +                                                    entries),
> +                                           table->ucNumEntries,
> +                                           sizeof(ATOM_Vega10_Hard_Limit=
_Record));
> +       if (ret)
> +               return ret;
> +
> +       *hard_limit_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_thermal_controller_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Vega10_Thermal_Controller **thermal_controller=
) {
> +       u16 table_offset;
> +
> +       table_offset =3D
> +le16_to_cpu(powerplay_table->usThermalControllerOffset);
> +
> +       return get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                  sizeof(**thermal_controller),
> +                                  (const void **)thermal_controller); }
> +
> +static int get_vega10_fan_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const Vega10_PPTable_Generic_SubTable_Header **fan_table)=
 {
> +       const Vega10_PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t table_size;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usFanTableOffset);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*header), (const void **)&header=
);
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId =3D=3D 10)
> +               table_size =3D sizeof(ATOM_Vega10_Fan_Table);
> +       else if (header->ucRevId =3D=3D 0xb)
> +               table_size =3D sizeof(ATOM_Vega10_Fan_Table_V2);
> +       else if (header->ucRevId > 0xb)
> +               table_size =3D sizeof(ATOM_Vega10_Fan_Table_V3);
> +       else
> +               return -EINVAL;
>
> AK: May be this may lead to regression earlier code was silent fall throu=
gh for
> ucRevId < 10

Thanks, will update in V2.

Best Regards,
Kevin
> +
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *fan_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_power_tune_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               const Vega10_PPTable_Generic_SubTable_Header
> **power_tune_table) {
> +       const Vega10_PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t table_size;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usPowerTuneTableOff=
set);
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*header), (const void **)&header=
);
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId =3D=3D 5)
> +               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table);
> +       else if (header->ucRevId =3D=3D 6)
> +               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table_V2);
> +       else
> +               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table_V3);
> +
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *power_tune_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_vega10_voltage_lookup_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
> +               u16 table_offset, uint32_t max_levels,
> +               const ATOM_Vega10_Voltage_Lookup_Table **lookup_table) {
> +       const ATOM_Vega10_Voltage_Lookup_Table *table;
> +       size_t table_size;
> +       int ret;
> +
> +       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0 &&
> +                            table->ucNumEntries <=3D max_levels),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       table_size =3D offsetof(ATOM_Vega10_Voltage_Lookup_Table, entries=
) +
> +               table->ucNumEntries *
> sizeof(ATOM_Vega10_Voltage_Lookup_Record);
> +       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr,
> table_offset,
> +                                                      table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *lookup_table =3D table;
> +
> +       return 0;
> +}
> +
>  static int check_powerplay_tables(struct pp_hwmgr *hwmgr,
>         const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)  { @@ -
> 149,14 +476,16 @@ static int init_thermal_controller(
>         const ATOM_Vega10_Fan_Table *fan_table_v1;
>         const ATOM_Vega10_Fan_Table_V2 *fan_table_v2;
>         const ATOM_Vega10_Fan_Table_V3 *fan_table_v3;
> -
> -       thermal_controller =3D (ATOM_Vega10_Thermal_Controller *)
> -                       (((unsigned long)powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usThermalControllerO=
ffset));
> +       int ret;
>
>         PP_ASSERT_WITH_CODE((powerplay_table-
> >usThermalControllerOffset !=3D 0),
>                         "Thermal controller table not set!", return -EINV=
AL);
>
> +       ret =3D get_vega10_thermal_controller_table(hwmgr, powerplay_tabl=
e,
> +                                                 &thermal_controller);
> +       if (ret)
> +               return ret;
> +
>         hwmgr->thermal_controller.ucType =3D thermal_controller->ucType;
>         hwmgr->thermal_controller.ucI2cLine =3D thermal_controller->ucI2c=
Line;
>         hwmgr->thermal_controller.ucI2cAddress =3D thermal_controller-
> >ucI2cAddress; @@ -185,9 +514,9 @@ static int init_thermal_controller(
>         if (!powerplay_table->usFanTableOffset)
>                 return 0;
>
> -       header =3D (const Vega10_PPTable_Generic_SubTable_Header *)
> -                       (((unsigned long)powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usFanTableOffset));
> +       ret =3D get_vega10_fan_table(hwmgr, powerplay_table, &header);
> +       if (ret)
> +               return ret;
>
>         if (header->ucRevId =3D=3D 10) {
>                 fan_table_v1 =3D (ATOM_Vega10_Fan_Table *)header; @@ -332=
,12
> +661,15 @@ static int init_over_drive_limits(
>                 struct pp_hwmgr *hwmgr,
>                 const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)  {
> -       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =3D
> -                       (const ATOM_Vega10_GFXCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usGfxclkDependencyTableOffset));
> +       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
>         bool is_acg_enabled =3D false;
>         ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
> +       int ret;
> +
> +       ret =3D get_vega10_gfxclk_dependency_table(hwmgr, powerplay_table=
,
> +                                                &gfxclk_dep_table);
> +       if (ret)
> +               return ret;
>
>         if (gfxclk_dep_table->ucRevId =3D=3D 1) {
>                 patom_record_v2 =3D
> @@ -900,51 +1232,13 @@ static int init_powerplay_extended_tables(
>         int result =3D 0;
>         struct phm_ppt_v2_information *pp_table_info =3D
>                 (struct phm_ppt_v2_information *)(hwmgr->pptable);
> -
> -       const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table
> =3D
> -                       (const ATOM_Vega10_MM_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usMMDependencyTableOffset));
> -       const Vega10_PPTable_Generic_SubTable_Header *power_tune_table =
=3D
> -                       (const Vega10_PPTable_Generic_SubTable_Header *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usPowerTuneTableOffs=
et));
> -       const ATOM_Vega10_SOCCLK_Dependency_Table *socclk_dep_table =3D
> -                       (const ATOM_Vega10_SOCCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usSocclkDependencyTableOffset));
> -       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =3D
> -                       (const ATOM_Vega10_GFXCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usGfxclkDependencyTableOffset));
> -       const ATOM_Vega10_DCEFCLK_Dependency_Table *dcefclk_dep_table =3D
> -                       (const ATOM_Vega10_DCEFCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usDcefclkDependencyTableOffset));
> -       const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table =3D
> -                       (const ATOM_Vega10_MCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usMclkDependencyTableOffset));
> -       const ATOM_Vega10_Hard_Limit_Table *hard_limits =3D
> -                       (const ATOM_Vega10_Hard_Limit_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usHardLimitTableOffs=
et));
> -       const Vega10_PPTable_Generic_SubTable_Header *pcie_table =3D
> -                       (const Vega10_PPTable_Generic_SubTable_Header *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usPCIETableOffset));
> -       const ATOM_Vega10_PIXCLK_Dependency_Table *pixclk_dep_table =3D
> -                       (const ATOM_Vega10_PIXCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usPixclkDependencyTableOffset));
> -       const ATOM_Vega10_PHYCLK_Dependency_Table *phyclk_dep_table =3D
> -                       (const ATOM_Vega10_PHYCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usPhyClkDependencyTableOffset));
> -       const ATOM_Vega10_DISPCLK_Dependency_Table *dispclk_dep_table =3D
> -                       (const ATOM_Vega10_DISPCLK_Dependency_Table *)
> -                       (((unsigned long) powerplay_table) +
> -                       le16_to_cpu(powerplay_table-
> >usDispClkDependencyTableOffset));
> +       const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table;
> +       const Vega10_PPTable_Generic_SubTable_Header *power_tune_table;
> +       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
> +       const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table;
> +       const ATOM_Vega10_Hard_Limit_Table *hard_limits;
> +       const Vega10_PPTable_Generic_SubTable_Header *pcie_table;
> +       const ATOM_Vega10_SOCCLK_Dependency_Table *clk_dep_table;
>
>         pp_table_info->vdd_dep_on_socclk =3D NULL;
>         pp_table_info->vdd_dep_on_sclk =3D NULL; @@ -956,63 +1250,114 @@
> static int init_powerplay_extended_tables(
>         pp_table_info->vdd_dep_on_phyclk =3D NULL;
>         pp_table_info->vdd_dep_on_dispclk =3D NULL;
>
> -       if (powerplay_table->usMMDependencyTableOffset)
> -               result =3D get_mm_clock_voltage_table(hwmgr,
> +       if (powerplay_table->usMMDependencyTableOffset) {
> +               result =3D get_vega10_mm_dependency_table(hwmgr,
> powerplay_table,
> +                                                       &mm_dependency_ta=
ble);
> +               if (!result)
> +                       result =3D get_mm_clock_voltage_table(hwmgr,
>                                 &pp_table_info->mm_dep_table,
>                                 mm_dependency_table);
> +       }
>
> -       if (!result && powerplay_table->usPowerTuneTableOffset)
> -               result =3D get_tdp_table(hwmgr,
> +       if (!result && powerplay_table->usPowerTuneTableOffset) {
> +               result =3D get_vega10_power_tune_table(hwmgr, powerplay_t=
able,
> +                                                    &power_tune_table);
> +               if (!result)
> +                       result =3D get_tdp_table(hwmgr,
>                                 &pp_table_info->tdp_table,
>                                 power_tune_table);
> +       }
>
> -       if (!result && powerplay_table->usSocclkDependencyTableOffset)
> -               result =3D get_socclk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usSocclkDependencyTableOffset) {
> +               result =3D get_vega10_clk_dependency_table(hwmgr,
> powerplay_table,
> +                               le16_to_cpu(powerplay_table-
> >usSocclkDependencyTableOffset),
> +                               &clk_dep_table);
> +               if (!result)
> +                       result =3D
> + get_socclk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_socclk,
> -                               socclk_dep_table);
> +                               (const ATOM_Vega10_SOCCLK_Dependency_Tabl=
e *)
> +                               clk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usGfxclkDependencyTableOffset)
> -               result =3D get_gfxclk_voltage_dependency_table(hwmgr,
> -                               &pp_table_info->vdd_dep_on_sclk,
> -                               gfxclk_dep_table);
> +       if (!result && powerplay_table->usGfxclkDependencyTableOffset) {
> +               result =3D get_vega10_gfxclk_dependency_table(hwmgr,
> +                       powerplay_table, &gfxclk_dep_table);
> +               if (!result)
> +                       result =3D get_gfxclk_voltage_dependency_table(hw=
mgr,
> +                                       &pp_table_info->vdd_dep_on_sclk,
> +                                       gfxclk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usPixclkDependencyTableOffset)
> -               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usPixclkDependencyTableOffset) {
> +               result =3D get_vega10_clk_dependency_table(hwmgr,
> powerplay_table,
> +                               le16_to_cpu(powerplay_table-
> >usPixclkDependencyTableOffset),
> +                               &clk_dep_table);
> +               if (!result)
> +                       result =3D
> + get_pix_clk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_pixclk,
>                                 (const ATOM_Vega10_PIXCLK_Dependency_Tabl=
e *)
> -                               pixclk_dep_table);
> +                               clk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usPhyClkDependencyTableOffset)
> -               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usPhyClkDependencyTableOffset) {
> +               result =3D get_vega10_clk_dependency_table(hwmgr,
> powerplay_table,
> +                               le16_to_cpu(powerplay_table-
> >usPhyClkDependencyTableOffset),
> +                               &clk_dep_table);
> +               if (!result)
> +                       result =3D
> + get_pix_clk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_phyclk,
>                                 (const ATOM_Vega10_PIXCLK_Dependency_Tabl=
e *)
> -                               phyclk_dep_table);
> +                               clk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usDispClkDependencyTableOffset)
> -               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usDispClkDependencyTableOffset) {
> +               result =3D get_vega10_clk_dependency_table(hwmgr,
> powerplay_table,
> +                               le16_to_cpu(powerplay_table-
> >usDispClkDependencyTableOffset),
> +                               &clk_dep_table);
> +               if (!result)
> +                       result =3D
> + get_pix_clk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_dispclk,
>                                 (const ATOM_Vega10_PIXCLK_Dependency_Tabl=
e *)
> -                               dispclk_dep_table);
> +                               clk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usDcefclkDependencyTableOffset)
> -               result =3D get_dcefclk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usDcefclkDependencyTableOffset) {
> +               result =3D get_vega10_clk_dependency_table(hwmgr,
> powerplay_table,
> +                               le16_to_cpu(powerplay_table-
> >usDcefclkDependencyTableOffset),
> +                               &clk_dep_table);
> +               if (!result)
> +                       result =3D
> + get_dcefclk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_dcefclk,
> -                               dcefclk_dep_table);
> +                               (const ATOM_Vega10_DCEFCLK_Dependency_Tab=
le *)
> +                               clk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usMclkDependencyTableOffset)
> -               result =3D get_mclk_voltage_dependency_table(hwmgr,
> +       if (!result && powerplay_table->usMclkDependencyTableOffset) {
> +               result =3D get_vega10_mclk_dependency_table(hwmgr,
> powerplay_table,
> +                                                         &mclk_dep_table=
);
> +               if (!result)
> +                       result =3D
> + get_mclk_voltage_dependency_table(hwmgr,
>                                 &pp_table_info->vdd_dep_on_mclk,
>                                 mclk_dep_table);
> +       }
>
> -       if (!result && powerplay_table->usPCIETableOffset)
> -               result =3D get_pcie_table(hwmgr,
> +       if (!result && powerplay_table->usPCIETableOffset) {
> +               result =3D get_vega10_pcie_table(hwmgr, powerplay_table,
> +                                              &pcie_table);
> +               if (!result)
> +                       result =3D get_pcie_table(hwmgr,
>                                 &pp_table_info->pcie_table,
>                                 pcie_table);
> +       }
>
> -       if (!result && powerplay_table->usHardLimitTableOffset)
> -               result =3D get_hard_limits(hwmgr,
> +       if (!result && powerplay_table->usHardLimitTableOffset) {
> +               result =3D get_vega10_hard_limit_table(hwmgr, powerplay_t=
able,
> +                                                    &hard_limits);
> +               if (!result)
> +                       result =3D get_hard_limits(hwmgr,
>                                 &pp_table_info->max_clock_voltage_on_dc,
>                                 hard_limits);
> +       }
>
>         hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =3D
>                         pp_table_info->max_clock_voltage_on_dc.sclk;
> @@ -1140,30 +1485,39 @@ static int init_dpm_2_parameters(
>         }
>
>         if (powerplay_table->usVddcLookupTableOffset) {
> -               const ATOM_Vega10_Voltage_Lookup_Table *vddc_table =3D
> -                               (ATOM_Vega10_Voltage_Lookup_Table *)
> -                               (((unsigned long)powerplay_table) +
> -                               le16_to_cpu(powerplay_table-
> >usVddcLookupTableOffset));
> -               result =3D get_vddc_lookup_table(hwmgr,
> -                               &pp_table_info->vddc_lookup_table, vddc_t=
able, 8);
> +               const ATOM_Vega10_Voltage_Lookup_Table *vddc_table;
> +
> +               result =3D get_vega10_voltage_lookup_table(hwmgr, powerpl=
ay_table,
> +                               le16_to_cpu(powerplay_table->usVddcLookup=
TableOffset),
> +                               8, &vddc_table);
> +               if (!result)
> +                       result =3D get_vddc_lookup_table(hwmgr,
> +                                       &pp_table_info->vddc_lookup_table=
,
> +                                       vddc_table, 8);
>         }
>
> -       if (powerplay_table->usVddmemLookupTableOffset) {
> -               const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table =3D
> -                               (ATOM_Vega10_Voltage_Lookup_Table *)
> -                               (((unsigned long)powerplay_table) +
> -                               le16_to_cpu(powerplay_table-
> >usVddmemLookupTableOffset));
> -               result =3D get_vddc_lookup_table(hwmgr,
> -                               &pp_table_info->vddmem_lookup_table, vdd_=
mem_table,
> 4);
> +       if (!result && powerplay_table->usVddmemLookupTableOffset) {
> +               const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table;
> +
> +               result =3D get_vega10_voltage_lookup_table(hwmgr, powerpl=
ay_table,
> +                               le16_to_cpu(powerplay_table-
> >usVddmemLookupTableOffset),
> +                               4, &vdd_mem_table);
> +               if (!result)
> +                       result =3D get_vddc_lookup_table(hwmgr,
> +                                       &pp_table_info->vddmem_lookup_tab=
le,
> +                                       vdd_mem_table, 4);
>         }
>
> -       if (powerplay_table->usVddciLookupTableOffset) {
> -               const ATOM_Vega10_Voltage_Lookup_Table *vddci_table =3D
> -                               (ATOM_Vega10_Voltage_Lookup_Table *)
> -                               (((unsigned long)powerplay_table) +
> -                               le16_to_cpu(powerplay_table-
> >usVddciLookupTableOffset));
> -               result =3D get_vddc_lookup_table(hwmgr,
> -                               &pp_table_info->vddci_lookup_table, vddci=
_table, 4);
> +       if (!result && powerplay_table->usVddciLookupTableOffset) {
> +               const ATOM_Vega10_Voltage_Lookup_Table *vddci_table;
> +
> +               result =3D get_vega10_voltage_lookup_table(hwmgr, powerpl=
ay_table,
> +                               le16_to_cpu(powerplay_table-
> >usVddciLookupTableOffset),
> +                               4, &vddci_table);
> +               if (!result)
> +                       result =3D get_vddc_lookup_table(hwmgr,
> +                                       &pp_table_info->vddci_lookup_tabl=
e,
> +                                       vddci_table, 4);
>         }
>
>         return result;
> --
> 2.47.3
>

