Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51FCDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 13:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5A910EB55;
	Tue, 23 Jun 2026 13:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JOO3ZMPx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD8E110EB55
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 13:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlPUsYFJIlix7AG3w2G3uXwxSyPfft1npcHPEf5J4jN83eam5q5BKF6q72mZe0YOvCfG454NP1vay7KK+SddK9caIhl49j8ZzmdAYBcvG/wvt9DKOkW6tmF3qU3Zw++M6i5CDduwZ6oCAB+x/lMxwNQ6IFZ77Py24YDLn9J6wwrKzAYhX3zPYgzPsHye5yZpcJB85rQln0GK4ptSQQjAkDga2jg+pdzPdLh1fMdTI9MQAGHMkb6/5UssuKRbi/slN9bHvmApevY9s0+VLZABLkpTQr7sADmrqhV0PItnlkyuXEeX3H63uQvnTk95i+tC/QAArX8fK8EALKpfxXH2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbbdTR2SAdyAFWBpsYMBdjy9eNy/qGEZGXYYv27Dpww=;
 b=GFqz4G4OYhnUC/la8blqyi5T4Z9L7PBPHsCOz1F0T1zsgbaXHr7cJtSaMflG29mNYg0e5HuLdoPjx58+oRjjtgbPPa4D/ejfqG63cYwle261uOVreQruaxNLs2hxDc13Iz2ILvILRoC68MXyfjXI5cDvqtCcmsiOh1We+b2rqGwBzo2SCRTn/OXb5zvoWq3Qx/rLqBzfDWsNQrkJcJezJnb7tAZ4GplKTZM+Qi/7noloowdMG25BuOYfC/t+sTZAEtewCrX7QSsTr2vrR1Z8ZWH8erlN3uslMhI98bbh5r6xuq5FQYkpSwrMlxi6wEVuD63Wj0GGfvBuKjeWiNWCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbbdTR2SAdyAFWBpsYMBdjy9eNy/qGEZGXYYv27Dpww=;
 b=JOO3ZMPxJOcfefrHUcqo9YR7p71ger69dNYpEgPipLEwrih8k/k57ONq4eqGvVclk+EBbXLRzN6atVzMRcSnVnUbndfOTmN/L+nbj8uvZPrXejpWenfkOT7kAc+g/R+SVKDmS3H/w0iVWTn30NuKF6CmY1YqO1et6PGIp1tMlZU=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 13:27:39 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:27:38 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Thread-Topic: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Thread-Index: AQHdAvpjGtsftAH09kq2KIVt2llA3LZMBXcAgAAb4zA=
Date: Tue, 23 Jun 2026 13:27:38 +0000
Message-ID: <DM6PR12MB2972F563ED22D66554929E6E82EE2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
 <20260623102319.413960-2-kevinyang.wang@amd.com>
 <DM4PR12MB5038B755AF672E57D7E0B7968EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5038B755AF672E57D7E0B7968EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T11:41:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: a61cab0d-3b3a-407d-4a14-08ded12b31f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|3023799007|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: M1wHFdVrGPBuYXa8isjQpUqRCKbD+Bqncg6m5L6GsO6KYPnkDZIDRsXv9SyIEuPgRyMw3PQikvV2NTce9DxrDkjjCg+Paj/850U04mvRBVfpz8K4OjATQcL7mhGWiSUE8P3GGUYokzU4fi6McoKr0s+69HB5wUn5DnOJxdUhjr4l+Hppb7EIvMeLazlIPkSRQDjq2WiE+bhSEIz8qiMvEyYGsL8nxx1n865wpZi3vueC4ohzQ9mVRegZeL9X3niYEfqGzfuB9Z8Qhd+0+9EItF45frAEzGO15OkGa2JI7qMF9XTPFmHTJkvnH+mXDZVju5MH6e+3rV0xm3D2oG66YZB1vh/dgobIp2yz6f6Xc1+ZLPBENvxh0IeY9qI6fqSOV541gk9fSYAXA0qe0KJTFmLJ/oVJuuF+r95C6ACOxoivYsVzu8ddNn3GdOLx3fg+steUFD1YnBlFa0msbFVvvwAyst94AqZIpfiuUb0TFYExO0omDs/idiVD9l8oGpROVjZoULmXiFNtEYV3y0bQr7mgNhbFO2zC7a7Ed1grAHpEqRgsgN9jUY/6RkrxTNx3uvDPp5mI0tIxRDPPDLgE3dBDIaKDV1P+KR3CdVNRM3Bu7vyu0S9OBC54qZCP083L+ls/7d6BNz9MU+b6oRLLhlKcZ/k/dmLs+9s8DyXvtxyjv6YJhzlUSEKsA5bOc3RhXmPhp1J7XVOGkCZJwcY7IxaYX57FFm4J/DUgS0URPac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIX3Cey1Xov8oXJgfpr6usmJuZQTLPgzGsbUsoeQX/mb7LjyEqQWSojL5oGE?=
 =?us-ascii?Q?43Begm7X4YaLE/XuMcp5mLNxiRJ+JTJ7Bnaj4YjqGxwvpy+fXzo7CNc03JLd?=
 =?us-ascii?Q?nnl2j0Ep5LFFWBeZD1GV+jeCACpzfYamkINjVapEVJKMjDTkhuglyouQ5xRP?=
 =?us-ascii?Q?6tnPBfAOAl56LQGsHJ/pFjiZ8lCr6ObaS4rMa2mW3wlYpOAFhkS4BJINWdPd?=
 =?us-ascii?Q?Tn/OP0ZQkSGKolQG/AS2u2NHpGwKY5bh5PMRQYhdxJmO6U0O1o2nlUnc48NW?=
 =?us-ascii?Q?tePva8lKcwda1IoMCXUgg+ZC9TXphV1shLjBvQLU2KOBGVPZoml5moYs/s2r?=
 =?us-ascii?Q?+IOmxacanJwDXbc9Z8u3t1Lq6ZN5WX+PMA/L3wbw3QoQwXqAOB0EHdR9DlUh?=
 =?us-ascii?Q?ZCiX45ZbSY3vWU3Fg+BvbPyJfd8il+TrXPkuJIvn+bnVIB3Su9A8rIXyA8Zo?=
 =?us-ascii?Q?EhsLxwk+qP2HMfS1A2Ad+axwNTd0aVp6Dss8Y3zpHDBiZBmBm6rbq7ej4TFH?=
 =?us-ascii?Q?WdQ0qGaRb8cdMd1hh3YC0GLw1EaDPCzQzTV5bgNacEtxO3hF9is9tFkX5M9E?=
 =?us-ascii?Q?/A7gPk9whva72LJiCG5JNFA7fJ+B8yma7tNtXrraXRdTPgqDKfmCi4ZIoSfq?=
 =?us-ascii?Q?uXJbSiFDwMCY1M1G/OT+Bc3YT3WjQLIpYVQxY6hKVnNCbfZQGoLl5zGNT4hB?=
 =?us-ascii?Q?ekaCDE2keWLsd1U8vNk36xm2d/ZcMqba0ke1uzY3N3uQ3qNnRmpwPArfmWRY?=
 =?us-ascii?Q?Dnw0eLzKodpMrnF6AnQd91EUYdGOO+V97BvFKAaDOZmprdMGtbAWLTelkQr6?=
 =?us-ascii?Q?hrOsJBSB/QGBtQ3aHumPfnytQuoi95mNMc176jkhY4c/ZSGfxtQ8Ki4LpzhG?=
 =?us-ascii?Q?cLsGkzipzlhluP1lfuDsQc6ZaMH026maEctz/PDEjQKKyniE+n5aVpWqT8iy?=
 =?us-ascii?Q?+fgp+egwpyjc6q4AW72dgs+zTBk3DGUb43APE60SWNp3uhWvELo3jXWcW1Nq?=
 =?us-ascii?Q?gXFuGziYofTn47dTArtDQil1DwnBtO+JFC0PzQU1YwXYPQTFlQf21LNwC+9U?=
 =?us-ascii?Q?yJA15wOtg/BxOcSDTEjZc64zhBh0bqv/zy1UKY9GzfbjLLAXJY4w37Kxljod?=
 =?us-ascii?Q?enSw+Xp06JAVwVQ1GMKBWWRxYdzqBdfb7RFZo6XfR1m7y8uj9zxTmAgAxTwS?=
 =?us-ascii?Q?JABRf/r9kgsq9eKsUjK1l9qyKvVCHTX10NYcS1eyDPDOnFgBfgHaPTk4G3ID?=
 =?us-ascii?Q?CAXf6eSZVBpejv8MkgJpN5VgYuZl9i9KtFmeX134kuqIVc1H8VLvN7HeO2Wy?=
 =?us-ascii?Q?SHOOEwarTo3VPVLlpKwQqPz0NemJNV/8+W3CAIx+Y7mD3nxA6C0AERnBxqOr?=
 =?us-ascii?Q?VKx/n4+N6Xzmjw/AkJ/qSB+IlFckane7J6vwNU3dNFigvBNZFqD4D6UBkeK7?=
 =?us-ascii?Q?7OYrg6f3u07Z5BKYkYHwPfItSUoCSBFBta7lachcCU6LDAuvWuD4siWI6YyU?=
 =?us-ascii?Q?OOvv69wVpN63vdoGC0uDMZVb8ybJLk5tqOF91d6qwE1mSbw4SPN/NST4A1A4?=
 =?us-ascii?Q?SHb1aAYkMTOxQJbEYH/dOfdn6IQ61FXomd8+rAvHGOCdhQkosnSrcyYOtDC/?=
 =?us-ascii?Q?FzBRCVop6VeH7K51sb5pgrNayhjotR0QJLwqFuOYW7I/r4nnlyKB4c+79Uv9?=
 =?us-ascii?Q?N1UwBbaPtoRG7hykFovPaCujFPE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61cab0d-3b3a-407d-4a14-08ded12b31f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 13:27:38.4618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMyMprrtHHbfbR/DnzS/+0kDyzHnQpVVwbiR1Cz2Tj6+A8MdAUSBaZtKcd3WcNhx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
> Sent: Tuesday, June 23, 2026 7:45 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: RE: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable
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
> Subject: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
>
> Tonga PPTable parsing also relies on VBIOS offsets, revision fields and e=
ntry
> counts for several subtables. Malformed data can cause out-of-bounds read=
s,
> while voltage lookup tables can overrun their fixed-size destination arra=
ys.
>
> Add common bounds helpers and validate fixed subtables, dynamic entry
> arrays and revision-specific layouts before consuming voltage lookup,
> dependency, PCIE, power-tune, hard-limit, thermal, fan, GPIO, PPM and VCE
> state data.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  .../powerplay/hwmgr/process_pptables_v1_0.c   | 604 +++++++++++++++---
>  1 file changed, 519 insertions(+), 85 deletions(-)
>
> diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 94c1e2c10370..831f5e240105 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -150,6 +150,368 @@ static const void *get_powerplay_table(struct
> pp_hwmgr *hwmgr)
>         return table_address;
>  }
>
> +static bool tonga_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t
> offset,
> +                                    size_t size) {
> +       size_t table_size =3D hwmgr->soft_pp_table_size;
> +
> +       return offset <=3D table_size && size <=3D table_size - offset; }
> +
> +static int get_tonga_subtable(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               u16 table_offset, size_t table_size, const void **table) =
{
> +       PP_ASSERT_WITH_CODE((table_offset !=3D 0),
> +                           "Invalid PowerPlay Table!", return -1);
> +       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr,
> table_offset,
> +                                                     table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *table =3D (const void *)(((unsigned long)powerplay_table) +
> +table_offset);
> +
> +       return 0;
> +}
> +
> +static int validate_tonga_table_entries(struct pp_hwmgr *hwmgr,
> +               u16 table_offset, size_t entries_offset,
> +               u8 num_entries, size_t entry_size) {
> +       size_t table_size;
> +
> +       PP_ASSERT_WITH_CODE((num_entries !=3D 0),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       table_size =3D entries_offset + num_entries * entry_size;
> +       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr,
> table_offset,
> +                                                     table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       return 0;
> +}
> +
> +static int get_tonga_voltage_lookup_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               u16 table_offset, uint32_t max_levels,
> +               const ATOM_Tonga_Voltage_Lookup_Table **lookup_table) {
> +       const ATOM_Tonga_Voltage_Lookup_Table *table;
> +       size_t table_size;
> +       int ret;
> +
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0 &&
> +                            table->ucNumEntries <=3D max_levels),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       table_size =3D offsetof(ATOM_Tonga_Voltage_Lookup_Table, entries)=
 +
> +               table->ucNumEntries *
> sizeof(ATOM_Tonga_Voltage_Lookup_Record);
> +       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr,
> table_offset,
> +                                                     table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *lookup_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_mclk_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_MCLK_Dependency_Table **mclk_dep_table) =
{
> +       const ATOM_Tonga_MCLK_Dependency_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usMclkDependencyTableOffset);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
> +                                          offsetof(ATOM_Tonga_MCLK_Depen=
dency_Table,
> +                                                   entries),
> +                                          table->ucNumEntries,
> +                                          sizeof(ATOM_Tonga_MCLK_Depende=
ncy_Record));
> +       if (ret)
> +               return ret;
> +
> +       *mclk_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_mm_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_MM_Dependency_Table **mm_dep_table) {
> +       const ATOM_Tonga_MM_Dependency_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usMMDependencyTableOffset);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
> +                                          offsetof(ATOM_Tonga_MM_Depende=
ncy_Table,
> +                                                   entries),
> +                                          table->ucNumEntries,
> +                                          sizeof(ATOM_Tonga_MM_Dependenc=
y_Record));
> +       if (ret)
> +               return ret;
> +
> +       *mm_dep_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_sclk_dependency_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const PPTable_Generic_SubTable_Header **sclk_dep_table) {
> +       const PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t entries_offset;
> +       size_t entry_size;
> +       u8 num_entries;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table-
> >usSclkDependencyTableOffset);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*header), (const void **)&header)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId < 1) {
> +               const ATOM_Tonga_SCLK_Dependency_Table *table =3D
> +                       (const ATOM_Tonga_SCLK_Dependency_Table
> + *)header;
> +
> +               entries_offset =3D offsetof(ATOM_Tonga_SCLK_Dependency_Ta=
ble,
> entries);
> +               entry_size =3D sizeof(ATOM_Tonga_SCLK_Dependency_Record);
> +               num_entries =3D table->ucNumEntries;
> +       } else {
> +               const ATOM_Polaris_SCLK_Dependency_Table *table =3D
> +                       (const ATOM_Polaris_SCLK_Dependency_Table
> + *)header;
> +
> +               entries_offset =3D offsetof(ATOM_Polaris_SCLK_Dependency_=
Table,
> entries);
> +               entry_size =3D sizeof(ATOM_Polaris_SCLK_Dependency_Record=
);
> +               num_entries =3D table->ucNumEntries;
> +       }
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset, entries=
_offset,
> +                                          num_entries, entry_size);
> +       if (ret)
> +               return ret;
> +
> +       *sclk_dep_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_pcie_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const PPTable_Generic_SubTable_Header **pcie_table) {
> +       const PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t entries_offset;
> +       size_t entry_size;
> +       u8 num_entries;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usPCIETableOffset);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*header), (const void **)&header)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId < 1) {
> +               const ATOM_Tonga_PCIE_Table *table =3D
> +                       (const ATOM_Tonga_PCIE_Table *)header;
> +
> +               entries_offset =3D offsetof(ATOM_Tonga_PCIE_Table, entrie=
s);
> +               entry_size =3D sizeof(ATOM_Tonga_PCIE_Record);
> +               num_entries =3D table->ucNumEntries;
> +       } else {
> +               const ATOM_Polaris10_PCIE_Table *table =3D
> +                       (const ATOM_Polaris10_PCIE_Table *)header;
> +
> +               entries_offset =3D offsetof(ATOM_Polaris10_PCIE_Table, en=
tries);
> +               entry_size =3D sizeof(ATOM_Polaris10_PCIE_Record);
> +               num_entries =3D table->ucNumEntries;
> +       }
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset, entries=
_offset,
> +                                          num_entries, entry_size);
> +       if (ret)
> +               return ret;
> +
> +       *pcie_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_hard_limit_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_Hard_Limit_Table **hard_limit_table) {
> +       const ATOM_Tonga_Hard_Limit_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usHardLimitTableOff=
set);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
> +                                          offsetof(ATOM_Tonga_Hard_Limit=
_Table,
> +                                                   entries),
> +                                          table->ucNumEntries,
> +                                          sizeof(ATOM_Tonga_Hard_Limit_R=
ecord));
> +       if (ret)
> +               return ret;
> +
> +       *hard_limit_table =3D table;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_thermal_controller_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_Thermal_Controller **thermal_controller)=
 {
> +       u16 table_offset;
> +
> +       table_offset =3D
> +le16_to_cpu(powerplay_table->usThermalControllerOffset);
> +
> +       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(**thermal_controller),
> +                                 (const void **)thermal_controller); }
> +
> +static int get_tonga_fan_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const PPTable_Generic_SubTable_Header **fan_table) {
> +       const PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t table_size;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usFanTableOffset);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*header), (const void **)&header)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId < 8)
> +               table_size =3D sizeof(ATOM_Tonga_Fan_Table);
> +       else if (header->ucRevId =3D=3D 8)
> +               table_size =3D sizeof(ATOM_Fiji_Fan_Table);
> +       else
> +               table_size =3D sizeof(ATOM_Polaris_Fan_Table);
> +
> +       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr,
> table_offset,
> +                                                     table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *fan_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_power_tune_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const PPTable_Generic_SubTable_Header **power_tune_table)=
 {
> +       const PPTable_Generic_SubTable_Header *header;
> +       u16 table_offset;
> +       size_t table_size;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usPowerTuneTableOff=
set);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*header), (const void **)&header)=
;
> +       if (ret)
> +               return ret;
> +
> +       if (header->ucRevId < 3)
> +               table_size =3D sizeof(ATOM_Tonga_PowerTune_Table);
> +       else if (header->ucRevId < 4)
> +               table_size =3D sizeof(ATOM_Fiji_PowerTune_Table);
> +       else
> +               table_size =3D sizeof(ATOM_Polaris_PowerTune_Table);
> +
> +       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr,
> table_offset,
> +                                                     table_size)),
> +                           "Invalid PowerPlay Table!", return -1);
> +
> +       *power_tune_table =3D header;
> +
> +       return 0;
> +}
> +
> +static int get_tonga_ppm_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_PPM_Table **ppm_table) {
> +       u16 table_offset;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usPPMTableOffset);
> +
> +       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(**ppm_table), (const void
> + **)ppm_table); }
> +
> +static int get_tonga_gpio_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_GPIO_Table **gpio_table) {
> +       u16 table_offset;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usGPIOTableOffset);
> +
> +       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                 sizeof(**gpio_table), (const void
> + **)gpio_table); }
> +
> +static int get_tonga_vce_state_table(struct pp_hwmgr *hwmgr,
> +               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> +               const ATOM_Tonga_VCE_State_Table **vce_state_table) {
> +       const ATOM_Tonga_VCE_State_Table *table;
> +       u16 table_offset;
> +       int ret;
> +
> +       table_offset =3D le16_to_cpu(powerplay_table->usVCEStateTableOffs=
et);
> +       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
> +                                sizeof(*table), (const void **)&table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
> +                                          offsetof(ATOM_Tonga_VCE_State_=
Table,
> +                                                   entries),
> +                                          table->ucNumEntries,
> +                                          sizeof(ATOM_Tonga_VCE_State_Re=
cord));
> +       if (ret)
> +               return ret;
> +
> +       *vce_state_table =3D table;
> +
> +       return 0;
> +}
> +
>  static int get_vddc_lookup_table(
>                 struct pp_hwmgr *hwmgr,
>                 phm_ppt_v1_voltage_lookup_table **lookup_table, @@ -198,7
> +560,7 @@ static int get_vddc_lookup_table(
>   */
>  static int get_platform_power_management_table(
>                 struct pp_hwmgr *hwmgr,
> -               ATOM_Tonga_PPM_Table *atom_ppm_table)
> +               const ATOM_Tonga_PPM_Table *atom_ppm_table)
>  {
>         struct phm_ppm_table *ptr =3D kzalloc(sizeof(*ptr), GFP_KERNEL);
>         struct phm_ppt_v1_information *pp_table_information =3D @@ -246,7
> +608,7 @@ static int init_dpm_2_parameters(  {
>         int result =3D 0;
>         struct phm_ppt_v1_information *pp_table_information =3D (struct
> phm_ppt_v1_information *)(hwmgr->pptable);
> -       ATOM_Tonga_PPM_Table *atom_ppm_table;
> +       const ATOM_Tonga_PPM_Table *atom_ppm_table;
>         uint32_t disable_ppm =3D 0;
>         uint32_t disable_power_control =3D 0;
>
> @@ -275,30 +637,37 @@ static int init_dpm_2_parameters(
>         }
>
>         if (0 !=3D powerplay_table->usVddcLookupTableOffset) {
> -               const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable =3D
> -                       (ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned
> long)powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usVddcLookupTableOff=
set));
> -
> -               result =3D get_vddc_lookup_table(hwmgr,
> -                       &pp_table_information->vddc_lookup_table, pVddcCA=
CTable,
> 16);
> +               const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable;
> +
> +               result =3D get_tonga_voltage_lookup_table(hwmgr, powerpla=
y_table,
> +                               le16_to_cpu(powerplay_table->usVddcLookup=
TableOffset),
> +                               16, &pVddcCACTable);
> +               if (!result)
> +                       result =3D get_vddc_lookup_table(hwmgr,
> +                               &pp_table_information->vddc_lookup_table,
> +                               pVddcCACTable, 16);
>         }
>
> -       if (0 !=3D powerplay_table->usVddgfxLookupTableOffset) {
> -               const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable =
=3D
> -                       (ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned
> long)powerplay_table) +
> -                       le16_to_cpu(powerplay_table->usVddgfxLookupTableO=
ffset));
> +       if (!result && 0 !=3D powerplay_table->usVddgfxLookupTableOffset)=
 {
> +               const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable;
>
> -               result =3D get_vddc_lookup_table(hwmgr,
> -                       &pp_table_information->vddgfx_lookup_table,
> pVddgfxCACTable, 16);
> +               result =3D get_tonga_voltage_lookup_table(hwmgr, powerpla=
y_table,
> +                               le16_to_cpu(powerplay_table-
> >usVddgfxLookupTableOffset),
> +                               16, &pVddgfxCACTable);
> +               if (!result)
> +                       result =3D get_vddc_lookup_table(hwmgr,
> +                               &pp_table_information->vddgfx_lookup_tabl=
e,
> +                               pVddgfxCACTable, 16);
>         }
>
>         disable_ppm =3D 0;
>         if (0 =3D=3D disable_ppm) {
> -               atom_ppm_table =3D (ATOM_Tonga_PPM_Table *)
> -                       (((unsigned long)powerplay_table) +
> le16_to_cpu(powerplay_table->usPPMTableOffset));
> -
>                 if (0 !=3D powerplay_table->usPPMTableOffset) {
> -                       if (get_platform_power_management_table(hwmgr,
> atom_ppm_table) =3D=3D 0) {
> +                       result =3D get_tonga_ppm_table(hwmgr, powerplay_t=
able,
> +                                                    &atom_ppm_table);
> Will this not cause regression, earlier result was not touched, now if PP=
M
> table fails bounds validation, result is set to -1 which may cause
> pp_tables_v1_0_initialize() to bail out entirely

Thanks , will update in next version.

Best Regards,
Kevin
> +                       if (!result &&
> +                           get_platform_power_management_table(hwmgr,
> +
> + atom_ppm_table) =3D=3D 0) {
>                                 phm_cap_set(hwmgr->platform_descriptor.pl=
atformCaps,
>
> PHM_PlatformCaps_EnablePlatformPowerManagement);
>                         }
> @@ -792,28 +1161,13 @@ static int init_clock_voltage_dependency(
>         int result =3D 0;
>         struct phm_ppt_v1_information *pp_table_information =3D
>                 (struct phm_ppt_v1_information *)(hwmgr->pptable);
> -
> -       const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table =3D
> -               (const ATOM_Tonga_MM_Dependency_Table *)(((unsigned long)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usMMDependencyTableOffset));
> -       const PPTable_Generic_SubTable_Header *pPowerTuneTable =3D
> -               (const PPTable_Generic_SubTable_Header *)(((unsigned long=
)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usPowerTuneTableOffset));
> -       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =3D
> -               (const ATOM_Tonga_MCLK_Dependency_Table *)(((unsigned lon=
g)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usMclkDependencyTableOffset)=
);
> -       const PPTable_Generic_SubTable_Header *sclk_dep_table =3D
> -               (const PPTable_Generic_SubTable_Header *)(((unsigned long=
)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usSclkDependencyTableOffset)=
);
> -       const ATOM_Tonga_Hard_Limit_Table *pHardLimits =3D
> -               (const ATOM_Tonga_Hard_Limit_Table *)(((unsigned long)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usHardLimitTableOffset));
> -       const PPTable_Generic_SubTable_Header *pcie_table =3D
> -               (const PPTable_Generic_SubTable_Header *)(((unsigned long=
)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usPCIETableOffset));
> -       const ATOM_Tonga_GPIO_Table *gpio_table =3D
> -               (const ATOM_Tonga_GPIO_Table *)(((unsigned long)
> powerplay_table) +
> -               le16_to_cpu(powerplay_table->usGPIOTableOffset));
> +       const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table;
> +       const PPTable_Generic_SubTable_Header *pPowerTuneTable;
> +       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
> +       const PPTable_Generic_SubTable_Header *sclk_dep_table;
> +       const ATOM_Tonga_Hard_Limit_Table *pHardLimits;
> +       const PPTable_Generic_SubTable_Header *pcie_table;
> +       const ATOM_Tonga_GPIO_Table *gpio_table;
>
>         pp_table_information->vdd_dep_on_sclk =3D NULL;
>         pp_table_information->vdd_dep_on_mclk =3D NULL; @@ -821,29 +1175,=
58
> @@ static int init_clock_voltage_dependency(
>         pp_table_information->pcie_table =3D NULL;
>         pp_table_information->gpio_table =3D NULL;
>
> -       if (powerplay_table->usMMDependencyTableOffset !=3D 0)
> -               result =3D get_mm_clock_voltage_table(hwmgr,
> -               &pp_table_information->mm_dep_table, mm_dependency_table)=
;
> +       if (powerplay_table->usMMDependencyTableOffset !=3D 0) {
> +               result =3D get_tonga_mm_dependency_table(hwmgr,
> powerplay_table,
> +                                                      &mm_dependency_tab=
le);
> +               if (!result)
> +                       result =3D get_mm_clock_voltage_table(hwmgr,
> +                               &pp_table_information->mm_dep_table,
> +                               mm_dependency_table);
> +       }
>
> -       if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=
=3D 0)
> -               result =3D get_cac_tdp_table(hwmgr,
> -               &pp_table_information->cac_dtp_table, pPowerTuneTable);
> +       if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=
=3D 0) {
> +               result =3D get_tonga_power_tune_table(hwmgr, powerplay_ta=
ble,
> +                                                   &pPowerTuneTable);
> +               if (!result)
> +                       result =3D get_cac_tdp_table(hwmgr,
> +                               &pp_table_information->cac_dtp_table,
> +                               pPowerTuneTable);
> +       }
>
> -       if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffs=
et !=3D 0)
> -               result =3D get_sclk_voltage_dependency_table(hwmgr,
> -               &pp_table_information->vdd_dep_on_sclk, sclk_dep_table);
> +       if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffs=
et !=3D 0) {
> +               result =3D get_tonga_sclk_dependency_table(hwmgr,
> powerplay_table,
> +                                                        &sclk_dep_table)=
;
> +               if (!result)
> +                       result =3D get_sclk_voltage_dependency_table(hwmg=
r,
> +                               &pp_table_information->vdd_dep_on_sclk,
> +                               sclk_dep_table);
> +       }
>
> -       if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffs=
et !=3D 0)
> -               result =3D get_mclk_voltage_dependency_table(hwmgr,
> -               &pp_table_information->vdd_dep_on_mclk, mclk_dep_table);
> +       if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffs=
et !=3D 0)
> {
> +               result =3D get_tonga_mclk_dependency_table(hwmgr,
> powerplay_table,
> +                                                        &mclk_dep_table)=
;
> +               if (!result)
> +                       result =3D get_mclk_voltage_dependency_table(hwmg=
r,
> +                               &pp_table_information->vdd_dep_on_mclk,
> +                               mclk_dep_table);
> +       }
>
> -       if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0)
> -               result =3D get_pcie_table(hwmgr,
> -               &pp_table_information->pcie_table, pcie_table);
> +       if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0)=
 {
> +               result =3D get_tonga_pcie_table(hwmgr, powerplay_table,
> +                                             &pcie_table);
> +               if (!result)
> +                       result =3D get_pcie_table(hwmgr,
> +                               &pp_table_information->pcie_table, pcie_t=
able);
> +       }
>
> -       if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=
=3D 0)
> -               result =3D get_hard_limits(hwmgr,
> -               &pp_table_information->max_clock_voltage_on_dc, pHardLimi=
ts);
> +       if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=
=3D 0) {
> +               result =3D get_tonga_hard_limit_table(hwmgr, powerplay_ta=
ble,
> +                                                   &pHardLimits);
> +               if (!result)
> +                       result =3D get_hard_limits(hwmgr,
> +                               &pp_table_information->max_clock_voltage_=
on_dc,
> +                               pHardLimits);
> +       }
>
>         hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =3D
>                 pp_table_information->max_clock_voltage_on_dc.sclk;
> @@ -864,9 +1247,13 @@ static int init_clock_voltage_dependency(
>                 result =3D get_valid_clk(hwmgr, &pp_table_information-
> >valid_sclk_values,
>                 pp_table_information->vdd_dep_on_sclk);
>
> -       if (!result && gpio_table)
> -               result =3D get_gpio_table(hwmgr, &pp_table_information->g=
pio_table,
> -                               gpio_table);
> +       if (!result && powerplay_table->usGPIOTableOffset) {
> +               result =3D get_tonga_gpio_table(hwmgr, powerplay_table,
> +                                             &gpio_table);
> +               if (!result)
> +                       result =3D get_gpio_table(hwmgr,
> +                               &pp_table_information->gpio_table, gpio_t=
able);
> +       }
>
>         return result;
>  }
> @@ -911,14 +1298,17 @@ static int init_thermal_controller(
>                 )
>  {
>         const PPTable_Generic_SubTable_Header *fan_table;
> -       ATOM_Tonga_Thermal_Controller *thermal_controller;
> +       const ATOM_Tonga_Thermal_Controller *thermal_controller;
> +       int ret;
>
> -       thermal_controller =3D (ATOM_Tonga_Thermal_Controller *)
> -               (((unsigned long)powerplay_table) +
> -               le16_to_cpu(powerplay_table->usThermalControllerOffset));
>         PP_ASSERT_WITH_CODE((0 !=3D powerplay_table-
> >usThermalControllerOffset),
>                 "Thermal controller table not set!", return -1);
>
> +       ret =3D get_tonga_thermal_controller_table(hwmgr, powerplay_table=
,
> +                                                &thermal_controller);
> +       if (ret)
> +               return ret;
> +
>         hwmgr->thermal_controller.ucType =3D thermal_controller->ucType;
>         hwmgr->thermal_controller.ucI2cLine =3D thermal_controller->ucI2c=
Line;
>         hwmgr->thermal_controller.ucI2cAddress =3D thermal_controller-
> >ucI2cAddress; @@ -946,12 +1336,13 @@ static int init_thermal_controller(
>                 return 0;
>         }
>
> -       fan_table =3D (const PPTable_Generic_SubTable_Header *)
> -               (((unsigned long)powerplay_table) +
> -               le16_to_cpu(powerplay_table->usFanTableOffset));
> -
>         PP_ASSERT_WITH_CODE((0 !=3D powerplay_table->usFanTableOffset),
>                 "Fan table not set!", return -1);
> +
> +       ret =3D get_tonga_fan_table(hwmgr, powerplay_table, &fan_table);
> +       if (ret)
> +               return ret;
> +
>         PP_ASSERT_WITH_CODE((0 < fan_table->ucRevId),
>                 "Unsupported fan table format!", return -1);
>
> @@ -1313,13 +1704,15 @@ static int
> ppt_get_num_of_vce_state_table_entries_v1_0(struct pp_hwmgr *hwmgr)  {
>         const ATOM_Tonga_POWERPLAYTABLE *pp_table =3D
> get_powerplay_table(hwmgr);
>         const ATOM_Tonga_VCE_State_Table *vce_state_table;
> +       int ret;
>
>
>         if (pp_table =3D=3D NULL)
>                 return 0;
>
> -       vce_state_table =3D (void *)pp_table +
> -                       le16_to_cpu(pp_table->usVCEStateTableOffset);
> +       ret =3D get_tonga_vce_state_table(hwmgr, pp_table, &vce_state_tab=
le);
> +       if (ret)
> +               return 0;
>
>         return vce_state_table->ucNumEntries;  } @@ -1328,18 +1721,39 @@
> static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr,
> uint32_t i
>                 struct amd_vce_state *vce_state, void **clock_info, uint3=
2_t *flag)  {
>         const ATOM_Tonga_VCE_State_Record *vce_state_record;
> -       ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record;
> +       ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record =3D NULL;
> +       ATOM_Polaris_SCLK_Dependency_Record *polaris_sclk_dep_record =3D
> + NULL;
>         ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
>         ATOM_Tonga_MM_Dependency_Record *mm_dep_record;
>         const ATOM_Tonga_POWERPLAYTABLE *pptable =3D
> get_powerplay_table(hwmgr);
> -       const ATOM_Tonga_VCE_State_Table *vce_state_table =3D
> (ATOM_Tonga_VCE_State_Table *)(((unsigned long)pptable)
> -                                                         + le16_to_cpu(p=
ptable-
> >usVCEStateTableOffset));
> -       const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table =3D
> (ATOM_Tonga_SCLK_Dependency_Table *)(((unsigned long)pptable)
> -                                                         + le16_to_cpu(p=
ptable-
> >usSclkDependencyTableOffset));
> -       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =3D
> (ATOM_Tonga_MCLK_Dependency_Table *)(((unsigned long)pptable)
> -                                                         + le16_to_cpu(p=
ptable-
> >usMclkDependencyTableOffset));
> -       const ATOM_Tonga_MM_Dependency_Table *mm_dep_table =3D
> (ATOM_Tonga_MM_Dependency_Table *)(((unsigned long)pptable)
> -                                                         + le16_to_cpu(p=
ptable-
> >usMMDependencyTableOffset));
> +       const ATOM_Tonga_VCE_State_Table *vce_state_table;
> +       const PPTable_Generic_SubTable_Header *sclk_dep_table_header;
> +       const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table;
> +       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
> +       const ATOM_Tonga_MM_Dependency_Table *mm_dep_table;
> +       int ret;
> +
> +       if (!pptable)
> +               return -EINVAL;
> +
> +       ret =3D get_tonga_vce_state_table(hwmgr, pptable, &vce_state_tabl=
e);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D get_tonga_sclk_dependency_table(hwmgr, pptable,
> +                                             &sclk_dep_table_header);
> +       if (ret)
> +               return ret;
> +       sclk_dep_table =3D (const ATOM_Tonga_SCLK_Dependency_Table *)
> +               sclk_dep_table_header;
> +
> +       ret =3D get_tonga_mclk_dependency_table(hwmgr, pptable,
> &mclk_dep_table);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D get_tonga_mm_dependency_table(hwmgr, pptable,
> &mm_dep_table);
> +       if (ret)
> +               return ret;
>
>         PP_ASSERT_WITH_CODE((i < vce_state_table->ucNumEntries),
>                          "Requested state entry ID is out of range!", @@ =
-1348,10
> +1762,27 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr
> *hwmgr, uint32_t i
>         vce_state_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
>                                         ATOM_Tonga_VCE_State_Record,
>                                         entries, vce_state_table, i);
> -       sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
> -                                       ATOM_Tonga_SCLK_Dependency_Record=
,
> -                                       entries, sclk_dep_table,
> -                                       vce_state_record->ucSCLKIndex);
> +       PP_ASSERT_WITH_CODE((vce_state_record->ucSCLKIndex <
> +                            sclk_dep_table->ucNumEntries),
> +                           "Invalid PowerPlay Table!", return -EINVAL);
> +       PP_ASSERT_WITH_CODE((vce_state_record->ucVCEClockIndex <
> +                            mm_dep_table->ucNumEntries),
> +                           "Invalid PowerPlay Table!", return -EINVAL);
> +       PP_ASSERT_WITH_CODE((mclk_dep_table->ucNumEntries !=3D 0),
> +                           "Invalid PowerPlay Table!", return -EINVAL);
> +
> +       if (sclk_dep_table_header->ucRevId < 1)
> +               sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
> +                                               ATOM_Tonga_SCLK_Dependenc=
y_Record,
> +                                               entries, sclk_dep_table,
> +                                               vce_state_record->ucSCLKI=
ndex);
> +       else
> +               polaris_sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADD=
R(
> +                                               ATOM_Polaris_SCLK_Depende=
ncy_Record,
> +                                               entries,
> +                                               (ATOM_Polaris_SCLK_Depend=
ency_Table *)
> +                                               sclk_dep_table_header,
> +
> + vce_state_record->ucSCLKIndex);
>         mm_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
>                                         ATOM_Tonga_MM_Dependency_Record,
>                                         entries, mm_dep_table, @@ -1360,7=
 +1791,10 @@
> static int ppt_get_vce_state_table_entry_v1_0(struct pp_hwmgr *hwmgr,
> uint32_t i
>
>         vce_state->evclk =3D le32_to_cpu(mm_dep_record->ulEClk);
>         vce_state->ecclk =3D le32_to_cpu(mm_dep_record->ulEClk);
> -       vce_state->sclk =3D le32_to_cpu(sclk_dep_record->ulSclk);
> +       if (sclk_dep_record)
> +               vce_state->sclk =3D le32_to_cpu(sclk_dep_record->ulSclk);
> +       else
> +               vce_state->sclk =3D
> + le32_to_cpu(polaris_sclk_dep_record->ulSclk);
>
>         if (vce_state_record->ucMCLKIndex >=3D mclk_dep_table->ucNumEntri=
es)
>                 mclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
> --
> 2.47.3
>

