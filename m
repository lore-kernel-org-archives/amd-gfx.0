Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A8CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 11:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853A10EACC;
	Tue, 23 Jun 2026 11:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAKRb+TA";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF3A10EACC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 11:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVNz7yHorLmlFb0dpQvEJ6gRmPZV8xR7DOCPuiGa+1pTm7K2dtMYXzmHyjtaQmoRS4SZZe2Ak/hWqMv6GKPmAFh+wHL7H01YJJkzOjP0L+ZZGTD/NEdieKocG6G6+IVtax2Qly057X65jrtCIFhBXyXOuzJu3N0aMlnfFSkfoaJT2KgipuMiN/qSFCMrbrQwym/xqIat07t8E78yK1+iFVAymZG1QC7dHLLxjIcucF9rCDcMARHXilW0fTCELhxrB0ghTdCWcK7tj3xal4FITnkiMzKefdOGdVcuD9gz10GKLoeOZxFvMsc5McG1ulBTMvpxGWwoUIwD6qrXv05PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crLAZdreQke6/QSk8bp/JUnmKLMyKJiFq4ejF0nu6uk=;
 b=gAemiZK6ry2TH8G6op+P93fdbexzS84wvs2+e+bMP2rMd9RqV4b9kUDdrMukNxLVje4TvnwQ7T3vZNUT4glY0wCOgqbxM74nRtRAxbUy6MOAGzdX1mtOwLhRNPx2U6nYYyaBR2FCF3TnoOp7H8qyFDQovcllYazmT8mdJ1JsHnZVKqFCv7RHnRnIBnPBqVs9/YuU+Sd+Aml/CDcq+5Q/mf8VN2Y2yXq/B72bn38XBn6fpWJM7QQajXEOJyyn6hi6biLUbnwx4zmKYfPuNm5xG/XizT73S6RIxyxiEZoxhhFgFE/BeLlVzuMhrOVI44QdNkJN0MhxvZW5bxQxtJqI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crLAZdreQke6/QSk8bp/JUnmKLMyKJiFq4ejF0nu6uk=;
 b=QAKRb+TAaRCvNgvehUAEaSeTgOGRPcZUW9ae2UMm2MxV1WcXOv2vq0+EcJ6u17seLvZXhMGrSLYpLy8Glmlt/CkHBDzbvYPTbAQtqJYnu5IxocHembYwNrr53m6VWXv8UV+bjwhd/nAUDPaNokwAuzsm0qVh6rt5ZFRMWOWHXck=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 11:44:57 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:44:56 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Thread-Topic: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds
Thread-Index: AQHdAvpkWyvawSe+1U6BAtzZ2H8xPrZMBJNQ
Date: Tue, 23 Jun 2026 11:44:56 +0000
Message-ID: <DM4PR12MB5038B755AF672E57D7E0B7968EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
 <20260623102319.413960-2-kevinyang.wang@amd.com>
In-Reply-To: <20260623102319.413960-2-kevinyang.wang@amd.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|MN0PR12MB6077:EE_
x-ms-office365-filtering-correlation-id: 9cfeaebb-358f-482b-adad-08ded11cd8fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|3023799007|11063799006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: sbUCjP9P4fZwA6lEo1xcNBXJ4vQmr1Kls/QWwoctfgpq5GqL3reMoTUCfnc+qO0ZdEWMjuDOcrJyvy6WG/UbgRr0ifU4VnVQi74mtELFPTjhaIcYCEMA4DdhouYdNAi4weaF3+cJMMr2Dz7zCYzVvNKc8X3+5gZCJWHjThgSAEwXr/6GYiLLRVvRl0vOiJQ2XJlzRhStAQ0RT7hCIrOe7NFUfjV+fwCS0fq3YosfpRP6+ulkBPGPg5Z9HOlKswSfcrfH988AODq4AKjskHRHMpBFgAicGj8Zd0ec5FY1GrgcsnJtYFmZUBV0MvxRT3UHf8PIdr1FCw4/J4WTAUksyjQldndQtNL63Pqpu93AKoKKRVuK8unchjDqg4Uc93PZTMUV1otdbw04VQDE4V7eoILJpfOPzzTZ/PlewMyVuPg3WIQTT5LmSVNc30JvW77L6zRik/0NtfKichBWlTCBxjDJjMuuH0IOq3W66+krZPGChUy5HwJFic+X9eAfospBg4Wnk1uTL6aeE5Lfh4CT9r0aLlQWD3WpWIh0BL4Sgr7okMxWD/VibFCDW5utOYlzQidDrjkBahJKvubMfHBwt1mOUe3tOfMZWmx/aGE3y/r4j120kfwtC6cDPLIsv15ESgBvz0ZBIC9AxS6HIAyCPX2fp5MXd3RDhaGYa5IyMS/cMcAisu/w8X1kVylUX/0BBZkFHVd1hNor0XLmmyWAXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(3023799007)(11063799006)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tfLRm5KmKYil6DhYu2Npy48/8DgNRjWMQk98KAJbPe9RGp1CpobRmerrVqcp?=
 =?us-ascii?Q?QNMw9UqJtyINjChCtNOoIpBTsOvYr6oz8r4L0oNQYlztiiGChgp5vOPNdEvk?=
 =?us-ascii?Q?OJQ5MM5zeX24vJdllocp7c+Kpncz9QBRgKNVGVu0P3Cdge9mEgTEhIS6EM2r?=
 =?us-ascii?Q?/x3ohJkuvdoBcZ86afZbJlGU4qXc7KRnuVnmh/RM6O3xXxvOH3Y73YF4+gSs?=
 =?us-ascii?Q?Lvz2V930acQ1me3CnNcPHYy/p9AnUo3SGizuxlQHdu54jRfOK3uxe/MCN21y?=
 =?us-ascii?Q?LWhRiM5qeAwCAD/4CJLh4m6jrLTUoR+NryK0d0Gda3iNQQFNpsWI3TO8As+M?=
 =?us-ascii?Q?T7gFjDXLKbeFHifiIXAl/do5RIdTA6bvrpRgYLmDfHzp7QTc5GK2nvQmu+oZ?=
 =?us-ascii?Q?YLLJgvT5Si9I3UKLEtOmbuVbaxxVVLtPCFiC0DoVY0xiV9m6ftGIyJ2fcQRu?=
 =?us-ascii?Q?Bw5WQM1FephAfQvkKJ0Angq9+ojoL4+Kp17CsekRlaePvK/raqH4NRf5oB9m?=
 =?us-ascii?Q?VTEeTvvkbHb9XBUg66XfBNs3y1eJ/M7948RanzTjAMDiCFJvbfeUJoyfg4on?=
 =?us-ascii?Q?Oe3CufHM5IvNCJ8Zj7CSUed1YvjAHa3SL73H6SlSlh1Wq4YF5P7jW+58BmQ6?=
 =?us-ascii?Q?CA7AFU2PMdusHg9E3CjiUf8XjgA2PP47TP251YVubk30aZd3W4QH+oP9iv5j?=
 =?us-ascii?Q?Tsip4+b+S9EsZcOJ5nnik6tFFocDaKC+kNN3jCDE7CbK1AUF2VKJvZMkv5oP?=
 =?us-ascii?Q?VNOwPGT1L81yKbULVAF9AsCXJxQ7Uhtc6zop1En+jbVviMAV8RaozYNLwn8A?=
 =?us-ascii?Q?buQ8V4oyfHHfy4ipA8tTQMAOT3x6RP4z4lPpIXP4W7ch6424idiROTPQqpUF?=
 =?us-ascii?Q?iZwaSxIYZYnIlGrY4sWv/mR+1lj0EZ4ZcbRwy5ESJCMhWL45AjezGsAnTuTF?=
 =?us-ascii?Q?AJJawJ9GbrxaofRwSPvGbhHGjq0Sp/8/Ew7tuvT+4VusBODDlUaKbFS8cFT7?=
 =?us-ascii?Q?rY31qNrkSn85gb8Xra3wQATBiUqMRYyKdtLNarCa9c5ZZf0wyLs3MNfkwXMZ?=
 =?us-ascii?Q?3aj+5dgMkTrFazlzCKO4L2LNpXmKvzAFggN0kwkpdQUlcifw9QhtiMwN0z1G?=
 =?us-ascii?Q?YEmvVAfa5LgfTEKJ1jiwFZbWLfaqzTGGcm3oXEukOyu+g7FNvqQdAl2QBsIJ?=
 =?us-ascii?Q?gk3TgBhSPBXk9TfJa+DM8WcgPHVVbfOai8zVfsg7iFBSpoBgdcddBx6e3THx?=
 =?us-ascii?Q?FggGiN6HcQirQSbo9Thlve6VjX1eZYqYbDcCoF+xs8ys8b8pOfk+sy3XYcd/?=
 =?us-ascii?Q?5Eh0Ou8VcECnnH+lhmXA/cTO43hcdk4oe1lTPrl/7HiZHJl0FCiivUvzQ8rf?=
 =?us-ascii?Q?77+dREETNC7/QD6inRIXDPUENqkA7giNaF/1M2VB0R0yX+PPFaR8u1vpV6d4?=
 =?us-ascii?Q?8tQVMmG4eE+ZuywluipAkkE+fOTXCQkJEHoqbH16vlnf/Os/BRQBnOrDGUi1?=
 =?us-ascii?Q?KTMNg7EqnrwV/hDgWvcZx44NeT6U3Xrsc52VcEy64nsfuvcaceJ+tTmh9kxp?=
 =?us-ascii?Q?FHjXrQ5Yj3cdi3ZRagfzne0vdh+uWkkzxg13KYN2hyLUrftASnJ7EOrdd/cS?=
 =?us-ascii?Q?fucoPBAsfOpP+37yZF/e+KhAsISjk53GYTXFM0KAxCkdfZqW8hgsBAYLaQAx?=
 =?us-ascii?Q?DXoCQP+lQrI6txpKKayVf7IfTRXuh/t2ym4j4t5EOsESz5L/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfeaebb-358f-482b-adad-08ded11cd8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 11:44:56.2934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHETX0ui+Ezn4mb4T9iqDAvbtVrCjYT52V9lUmxQgQ2930korAHmHBJ+8OI42SwaHGVSxfgI3XrmmGnUn8pJBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, June 23, 2026 3:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Validate Tonga PPTable subtable bounds

Tonga PPTable parsing also relies on VBIOS offsets, revision fields and ent=
ry counts for several subtables. Malformed data can cause out-of-bounds rea=
ds, while voltage lookup tables can overrun their fixed-size destination ar=
rays.

Add common bounds helpers and validate fixed subtables, dynamic entry array=
s and revision-specific layouts before consuming voltage lookup, dependency=
, PCIE, power-tune, hard-limit, thermal, fan, GPIO, PPM and VCE state data.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 604 +++++++++++++++---
 1 file changed, 519 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c=
 b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index 94c1e2c10370..831f5e240105 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -150,6 +150,368 @@ static const void *get_powerplay_table(struct pp_hwmg=
r *hwmgr)
        return table_address;
 }

+static bool tonga_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offset=
,
+                                    size_t size)
+{
+       size_t table_size =3D hwmgr->soft_pp_table_size;
+
+       return offset <=3D table_size && size <=3D table_size - offset; }
+
+static int get_tonga_subtable(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               u16 table_offset, size_t table_size, const void **table) {
+       PP_ASSERT_WITH_CODE((table_offset !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+                                                     table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *table =3D (const void *)(((unsigned long)powerplay_table) +
+table_offset);
+
+       return 0;
+}
+
+static int validate_tonga_table_entries(struct pp_hwmgr *hwmgr,
+               u16 table_offset, size_t entries_offset,
+               u8 num_entries, size_t entry_size)
+{
+       size_t table_size;
+
+       PP_ASSERT_WITH_CODE((num_entries !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table_size =3D entries_offset + num_entries * entry_size;
+       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+                                                     table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       return 0;
+}
+
+static int get_tonga_voltage_lookup_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               u16 table_offset, uint32_t max_levels,
+               const ATOM_Tonga_Voltage_Lookup_Table **lookup_table) {
+       const ATOM_Tonga_Voltage_Lookup_Table *table;
+       size_t table_size;
+       int ret;
+
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0 &&
+                            table->ucNumEntries <=3D max_levels),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table_size =3D offsetof(ATOM_Tonga_Voltage_Lookup_Table, entries) +
+               table->ucNumEntries * sizeof(ATOM_Tonga_Voltage_Lookup_Reco=
rd);
+       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+                                                     table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *lookup_table =3D table;
+
+       return 0;
+}
+
+static int get_tonga_mclk_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_MCLK_Dependency_Table **mclk_dep_table) {
+       const ATOM_Tonga_MCLK_Dependency_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usMclkDependencyTable=
Offset);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_Tonga_MCLK_Depende=
ncy_Table,
+                                                   entries),
+                                          table->ucNumEntries,
+                                          sizeof(ATOM_Tonga_MCLK_Dependenc=
y_Record));
+       if (ret)
+               return ret;
+
+       *mclk_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_tonga_mm_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_MM_Dependency_Table **mm_dep_table) {
+       const ATOM_Tonga_MM_Dependency_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usMMDependencyTableOf=
fset);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_Tonga_MM_Dependenc=
y_Table,
+                                                   entries),
+                                          table->ucNumEntries,
+                                          sizeof(ATOM_Tonga_MM_Dependency_=
Record));
+       if (ret)
+               return ret;
+
+       *mm_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_tonga_sclk_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const PPTable_Generic_SubTable_Header **sclk_dep_table) {
+       const PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t entries_offset;
+       size_t entry_size;
+       u8 num_entries;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usSclkDependencyTable=
Offset);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId < 1) {
+               const ATOM_Tonga_SCLK_Dependency_Table *table =3D
+                       (const ATOM_Tonga_SCLK_Dependency_Table *)header;
+
+               entries_offset =3D offsetof(ATOM_Tonga_SCLK_Dependency_Tabl=
e, entries);
+               entry_size =3D sizeof(ATOM_Tonga_SCLK_Dependency_Record);
+               num_entries =3D table->ucNumEntries;
+       } else {
+               const ATOM_Polaris_SCLK_Dependency_Table *table =3D
+                       (const ATOM_Polaris_SCLK_Dependency_Table *)header;
+
+               entries_offset =3D offsetof(ATOM_Polaris_SCLK_Dependency_Ta=
ble, entries);
+               entry_size =3D sizeof(ATOM_Polaris_SCLK_Dependency_Record);
+               num_entries =3D table->ucNumEntries;
+       }
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset, entries_o=
ffset,
+                                          num_entries, entry_size);
+       if (ret)
+               return ret;
+
+       *sclk_dep_table =3D header;
+
+       return 0;
+}
+
+static int get_tonga_pcie_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const PPTable_Generic_SubTable_Header **pcie_table) {
+       const PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t entries_offset;
+       size_t entry_size;
+       u8 num_entries;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usPCIETableOffset);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId < 1) {
+               const ATOM_Tonga_PCIE_Table *table =3D
+                       (const ATOM_Tonga_PCIE_Table *)header;
+
+               entries_offset =3D offsetof(ATOM_Tonga_PCIE_Table, entries)=
;
+               entry_size =3D sizeof(ATOM_Tonga_PCIE_Record);
+               num_entries =3D table->ucNumEntries;
+       } else {
+               const ATOM_Polaris10_PCIE_Table *table =3D
+                       (const ATOM_Polaris10_PCIE_Table *)header;
+
+               entries_offset =3D offsetof(ATOM_Polaris10_PCIE_Table, entr=
ies);
+               entry_size =3D sizeof(ATOM_Polaris10_PCIE_Record);
+               num_entries =3D table->ucNumEntries;
+       }
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset, entries_o=
ffset,
+                                          num_entries, entry_size);
+       if (ret)
+               return ret;
+
+       *pcie_table =3D header;
+
+       return 0;
+}
+
+static int get_tonga_hard_limit_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_Hard_Limit_Table **hard_limit_table) {
+       const ATOM_Tonga_Hard_Limit_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usHardLimitTableOffse=
t);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_Tonga_Hard_Limit_T=
able,
+                                                   entries),
+                                          table->ucNumEntries,
+                                          sizeof(ATOM_Tonga_Hard_Limit_Rec=
ord));
+       if (ret)
+               return ret;
+
+       *hard_limit_table =3D table;
+
+       return 0;
+}
+
+static int get_tonga_thermal_controller_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_Thermal_Controller **thermal_controller) {
+       u16 table_offset;
+
+       table_offset =3D
+le16_to_cpu(powerplay_table->usThermalControllerOffset);
+
+       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(**thermal_controller),
+                                 (const void **)thermal_controller); }
+
+static int get_tonga_fan_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const PPTable_Generic_SubTable_Header **fan_table) {
+       const PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t table_size;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usFanTableOffset);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId < 8)
+               table_size =3D sizeof(ATOM_Tonga_Fan_Table);
+       else if (header->ucRevId =3D=3D 8)
+               table_size =3D sizeof(ATOM_Fiji_Fan_Table);
+       else
+               table_size =3D sizeof(ATOM_Polaris_Fan_Table);
+
+       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+                                                     table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *fan_table =3D header;
+
+       return 0;
+}
+
+static int get_tonga_power_tune_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const PPTable_Generic_SubTable_Header **power_tune_table) {
+       const PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t table_size;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usPowerTuneTableOffse=
t);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId < 3)
+               table_size =3D sizeof(ATOM_Tonga_PowerTune_Table);
+       else if (header->ucRevId < 4)
+               table_size =3D sizeof(ATOM_Fiji_PowerTune_Table);
+       else
+               table_size =3D sizeof(ATOM_Polaris_PowerTune_Table);
+
+       PP_ASSERT_WITH_CODE((tonga_pp_table_has_space(hwmgr, table_offset,
+                                                     table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *power_tune_table =3D header;
+
+       return 0;
+}
+
+static int get_tonga_ppm_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_PPM_Table **ppm_table) {
+       u16 table_offset;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usPPMTableOffset);
+
+       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(**ppm_table), (const void **)ppm_t=
able); }
+
+static int get_tonga_gpio_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_GPIO_Table **gpio_table) {
+       u16 table_offset;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usGPIOTableOffset);
+
+       return get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(**gpio_table), (const void **)gpio=
_table); }
+
+static int get_tonga_vce_state_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Tonga_VCE_State_Table **vce_state_table) {
+       const ATOM_Tonga_VCE_State_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usVCEStateTableOffset=
);
+       ret =3D get_tonga_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_tonga_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_Tonga_VCE_State_Ta=
ble,
+                                                   entries),
+                                          table->ucNumEntries,
+                                          sizeof(ATOM_Tonga_VCE_State_Reco=
rd));
+       if (ret)
+               return ret;
+
+       *vce_state_table =3D table;
+
+       return 0;
+}
+
 static int get_vddc_lookup_table(
                struct pp_hwmgr *hwmgr,
                phm_ppt_v1_voltage_lookup_table **lookup_table,
@@ -198,7 +560,7 @@ static int get_vddc_lookup_table(
  */
 static int get_platform_power_management_table(
                struct pp_hwmgr *hwmgr,
-               ATOM_Tonga_PPM_Table *atom_ppm_table)
+               const ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
        struct phm_ppm_table *ptr =3D kzalloc(sizeof(*ptr), GFP_KERNEL);
        struct phm_ppt_v1_information *pp_table_information =3D @@ -246,7 +=
608,7 @@ static int init_dpm_2_parameters(  {
        int result =3D 0;
        struct phm_ppt_v1_information *pp_table_information =3D (struct phm=
_ppt_v1_information *)(hwmgr->pptable);
-       ATOM_Tonga_PPM_Table *atom_ppm_table;
+       const ATOM_Tonga_PPM_Table *atom_ppm_table;
        uint32_t disable_ppm =3D 0;
        uint32_t disable_power_control =3D 0;

@@ -275,30 +637,37 @@ static int init_dpm_2_parameters(
        }

        if (0 !=3D powerplay_table->usVddcLookupTableOffset) {
-               const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable =3D
-                       (ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned long=
)powerplay_table) +
-                       le16_to_cpu(powerplay_table->usVddcLookupTableOffse=
t));
-
-               result =3D get_vddc_lookup_table(hwmgr,
-                       &pp_table_information->vddc_lookup_table, pVddcCACT=
able, 16);
+               const ATOM_Tonga_Voltage_Lookup_Table *pVddcCACTable;
+
+               result =3D get_tonga_voltage_lookup_table(hwmgr, powerplay_=
table,
+                               le16_to_cpu(powerplay_table->usVddcLookupTa=
bleOffset),
+                               16, &pVddcCACTable);
+               if (!result)
+                       result =3D get_vddc_lookup_table(hwmgr,
+                               &pp_table_information->vddc_lookup_table,
+                               pVddcCACTable, 16);
        }

-       if (0 !=3D powerplay_table->usVddgfxLookupTableOffset) {
-               const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable =3D
-                       (ATOM_Tonga_Voltage_Lookup_Table *)(((unsigned long=
)powerplay_table) +
-                       le16_to_cpu(powerplay_table->usVddgfxLookupTableOff=
set));
+       if (!result && 0 !=3D powerplay_table->usVddgfxLookupTableOffset) {
+               const ATOM_Tonga_Voltage_Lookup_Table *pVddgfxCACTable;

-               result =3D get_vddc_lookup_table(hwmgr,
-                       &pp_table_information->vddgfx_lookup_table, pVddgfx=
CACTable, 16);
+               result =3D get_tonga_voltage_lookup_table(hwmgr, powerplay_=
table,
+                               le16_to_cpu(powerplay_table->usVddgfxLookup=
TableOffset),
+                               16, &pVddgfxCACTable);
+               if (!result)
+                       result =3D get_vddc_lookup_table(hwmgr,
+                               &pp_table_information->vddgfx_lookup_table,
+                               pVddgfxCACTable, 16);
        }

        disable_ppm =3D 0;
        if (0 =3D=3D disable_ppm) {
-               atom_ppm_table =3D (ATOM_Tonga_PPM_Table *)
-                       (((unsigned long)powerplay_table) + le16_to_cpu(pow=
erplay_table->usPPMTableOffset));
-
                if (0 !=3D powerplay_table->usPPMTableOffset) {
-                       if (get_platform_power_management_table(hwmgr, atom=
_ppm_table) =3D=3D 0) {
+                       result =3D get_tonga_ppm_table(hwmgr, powerplay_tab=
le,
+                                                    &atom_ppm_table);
Will this not cause regression, earlier result was not touched, now if PPM =
table fails bounds validation, result is set to -1 which may cause pp_table=
s_v1_0_initialize() to bail out entirely
+                       if (!result &&
+                           get_platform_power_management_table(hwmgr,
+                                                              atom_ppm_tab=
le) =3D=3D 0) {
                                phm_cap_set(hwmgr->platform_descriptor.plat=
formCaps,
                                        PHM_PlatformCaps_EnablePlatformPowe=
rManagement);
                        }
@@ -792,28 +1161,13 @@ static int init_clock_voltage_dependency(
        int result =3D 0;
        struct phm_ppt_v1_information *pp_table_information =3D
                (struct phm_ppt_v1_information *)(hwmgr->pptable);
-
-       const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table =3D
-               (const ATOM_Tonga_MM_Dependency_Table *)(((unsigned long) p=
owerplay_table) +
-               le16_to_cpu(powerplay_table->usMMDependencyTableOffset));
-       const PPTable_Generic_SubTable_Header *pPowerTuneTable =3D
-               (const PPTable_Generic_SubTable_Header *)(((unsigned long) =
powerplay_table) +
-               le16_to_cpu(powerplay_table->usPowerTuneTableOffset));
-       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =3D
-               (const ATOM_Tonga_MCLK_Dependency_Table *)(((unsigned long)=
 powerplay_table) +
-               le16_to_cpu(powerplay_table->usMclkDependencyTableOffset));
-       const PPTable_Generic_SubTable_Header *sclk_dep_table =3D
-               (const PPTable_Generic_SubTable_Header *)(((unsigned long) =
powerplay_table) +
-               le16_to_cpu(powerplay_table->usSclkDependencyTableOffset));
-       const ATOM_Tonga_Hard_Limit_Table *pHardLimits =3D
-               (const ATOM_Tonga_Hard_Limit_Table *)(((unsigned long) powe=
rplay_table) +
-               le16_to_cpu(powerplay_table->usHardLimitTableOffset));
-       const PPTable_Generic_SubTable_Header *pcie_table =3D
-               (const PPTable_Generic_SubTable_Header *)(((unsigned long) =
powerplay_table) +
-               le16_to_cpu(powerplay_table->usPCIETableOffset));
-       const ATOM_Tonga_GPIO_Table *gpio_table =3D
-               (const ATOM_Tonga_GPIO_Table *)(((unsigned long) powerplay_=
table) +
-               le16_to_cpu(powerplay_table->usGPIOTableOffset));
+       const ATOM_Tonga_MM_Dependency_Table *mm_dependency_table;
+       const PPTable_Generic_SubTable_Header *pPowerTuneTable;
+       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
+       const PPTable_Generic_SubTable_Header *sclk_dep_table;
+       const ATOM_Tonga_Hard_Limit_Table *pHardLimits;
+       const PPTable_Generic_SubTable_Header *pcie_table;
+       const ATOM_Tonga_GPIO_Table *gpio_table;

        pp_table_information->vdd_dep_on_sclk =3D NULL;
        pp_table_information->vdd_dep_on_mclk =3D NULL; @@ -821,29 +1175,58=
 @@ static int init_clock_voltage_dependency(
        pp_table_information->pcie_table =3D NULL;
        pp_table_information->gpio_table =3D NULL;

-       if (powerplay_table->usMMDependencyTableOffset !=3D 0)
-               result =3D get_mm_clock_voltage_table(hwmgr,
-               &pp_table_information->mm_dep_table, mm_dependency_table);
+       if (powerplay_table->usMMDependencyTableOffset !=3D 0) {
+               result =3D get_tonga_mm_dependency_table(hwmgr, powerplay_t=
able,
+                                                      &mm_dependency_table=
);
+               if (!result)
+                       result =3D get_mm_clock_voltage_table(hwmgr,
+                               &pp_table_information->mm_dep_table,
+                               mm_dependency_table);
+       }

-       if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=3D=
 0)
-               result =3D get_cac_tdp_table(hwmgr,
-               &pp_table_information->cac_dtp_table, pPowerTuneTable);
+       if (result =3D=3D 0 && powerplay_table->usPowerTuneTableOffset !=3D=
 0) {
+               result =3D get_tonga_power_tune_table(hwmgr, powerplay_tabl=
e,
+                                                   &pPowerTuneTable);
+               if (!result)
+                       result =3D get_cac_tdp_table(hwmgr,
+                               &pp_table_information->cac_dtp_table,
+                               pPowerTuneTable);
+       }

-       if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffset=
 !=3D 0)
-               result =3D get_sclk_voltage_dependency_table(hwmgr,
-               &pp_table_information->vdd_dep_on_sclk, sclk_dep_table);
+       if (result =3D=3D 0 && powerplay_table->usSclkDependencyTableOffset=
 !=3D 0) {
+               result =3D get_tonga_sclk_dependency_table(hwmgr, powerplay=
_table,
+                                                        &sclk_dep_table);
+               if (!result)
+                       result =3D get_sclk_voltage_dependency_table(hwmgr,
+                               &pp_table_information->vdd_dep_on_sclk,
+                               sclk_dep_table);
+       }

-       if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffset=
 !=3D 0)
-               result =3D get_mclk_voltage_dependency_table(hwmgr,
-               &pp_table_information->vdd_dep_on_mclk, mclk_dep_table);
+       if (result =3D=3D 0 && powerplay_table->usMclkDependencyTableOffset=
 !=3D 0) {
+               result =3D get_tonga_mclk_dependency_table(hwmgr, powerplay=
_table,
+                                                        &mclk_dep_table);
+               if (!result)
+                       result =3D get_mclk_voltage_dependency_table(hwmgr,
+                               &pp_table_information->vdd_dep_on_mclk,
+                               mclk_dep_table);
+       }

-       if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0)
-               result =3D get_pcie_table(hwmgr,
-               &pp_table_information->pcie_table, pcie_table);
+       if (result =3D=3D 0 && powerplay_table->usPCIETableOffset !=3D 0) {
+               result =3D get_tonga_pcie_table(hwmgr, powerplay_table,
+                                             &pcie_table);
+               if (!result)
+                       result =3D get_pcie_table(hwmgr,
+                               &pp_table_information->pcie_table, pcie_tab=
le);
+       }

-       if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=3D=
 0)
-               result =3D get_hard_limits(hwmgr,
-               &pp_table_information->max_clock_voltage_on_dc, pHardLimits=
);
+       if (result =3D=3D 0 && powerplay_table->usHardLimitTableOffset !=3D=
 0) {
+               result =3D get_tonga_hard_limit_table(hwmgr, powerplay_tabl=
e,
+                                                   &pHardLimits);
+               if (!result)
+                       result =3D get_hard_limits(hwmgr,
+                               &pp_table_information->max_clock_voltage_on=
_dc,
+                               pHardLimits);
+       }

        hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =3D
                pp_table_information->max_clock_voltage_on_dc.sclk;
@@ -864,9 +1247,13 @@ static int init_clock_voltage_dependency(
                result =3D get_valid_clk(hwmgr, &pp_table_information->vali=
d_sclk_values,
                pp_table_information->vdd_dep_on_sclk);

-       if (!result && gpio_table)
-               result =3D get_gpio_table(hwmgr, &pp_table_information->gpi=
o_table,
-                               gpio_table);
+       if (!result && powerplay_table->usGPIOTableOffset) {
+               result =3D get_tonga_gpio_table(hwmgr, powerplay_table,
+                                             &gpio_table);
+               if (!result)
+                       result =3D get_gpio_table(hwmgr,
+                               &pp_table_information->gpio_table, gpio_tab=
le);
+       }

        return result;
 }
@@ -911,14 +1298,17 @@ static int init_thermal_controller(
                )
 {
        const PPTable_Generic_SubTable_Header *fan_table;
-       ATOM_Tonga_Thermal_Controller *thermal_controller;
+       const ATOM_Tonga_Thermal_Controller *thermal_controller;
+       int ret;

-       thermal_controller =3D (ATOM_Tonga_Thermal_Controller *)
-               (((unsigned long)powerplay_table) +
-               le16_to_cpu(powerplay_table->usThermalControllerOffset));
        PP_ASSERT_WITH_CODE((0 !=3D powerplay_table->usThermalControllerOff=
set),
                "Thermal controller table not set!", return -1);

+       ret =3D get_tonga_thermal_controller_table(hwmgr, powerplay_table,
+                                                &thermal_controller);
+       if (ret)
+               return ret;
+
        hwmgr->thermal_controller.ucType =3D thermal_controller->ucType;
        hwmgr->thermal_controller.ucI2cLine =3D thermal_controller->ucI2cLi=
ne;
        hwmgr->thermal_controller.ucI2cAddress =3D thermal_controller->ucI2=
cAddress; @@ -946,12 +1336,13 @@ static int init_thermal_controller(
                return 0;
        }

-       fan_table =3D (const PPTable_Generic_SubTable_Header *)
-               (((unsigned long)powerplay_table) +
-               le16_to_cpu(powerplay_table->usFanTableOffset));
-
        PP_ASSERT_WITH_CODE((0 !=3D powerplay_table->usFanTableOffset),
                "Fan table not set!", return -1);
+
+       ret =3D get_tonga_fan_table(hwmgr, powerplay_table, &fan_table);
+       if (ret)
+               return ret;
+
        PP_ASSERT_WITH_CODE((0 < fan_table->ucRevId),
                "Unsupported fan table format!", return -1);

@@ -1313,13 +1704,15 @@ static int ppt_get_num_of_vce_state_table_entries_v=
1_0(struct pp_hwmgr *hwmgr)  {
        const ATOM_Tonga_POWERPLAYTABLE *pp_table =3D get_powerplay_table(h=
wmgr);
        const ATOM_Tonga_VCE_State_Table *vce_state_table;
+       int ret;


        if (pp_table =3D=3D NULL)
                return 0;

-       vce_state_table =3D (void *)pp_table +
-                       le16_to_cpu(pp_table->usVCEStateTableOffset);
+       ret =3D get_tonga_vce_state_table(hwmgr, pp_table, &vce_state_table=
);
+       if (ret)
+               return 0;

        return vce_state_table->ucNumEntries;
 }
@@ -1328,18 +1721,39 @@ static int ppt_get_vce_state_table_entry_v1_0(struc=
t pp_hwmgr *hwmgr, uint32_t i
                struct amd_vce_state *vce_state, void **clock_info, uint32_=
t *flag)  {
        const ATOM_Tonga_VCE_State_Record *vce_state_record;
-       ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record;
+       ATOM_Tonga_SCLK_Dependency_Record *sclk_dep_record =3D NULL;
+       ATOM_Polaris_SCLK_Dependency_Record *polaris_sclk_dep_record =3D NU=
LL;
        ATOM_Tonga_MCLK_Dependency_Record *mclk_dep_record;
        ATOM_Tonga_MM_Dependency_Record *mm_dep_record;
        const ATOM_Tonga_POWERPLAYTABLE *pptable =3D get_powerplay_table(hw=
mgr);
-       const ATOM_Tonga_VCE_State_Table *vce_state_table =3D (ATOM_Tonga_V=
CE_State_Table *)(((unsigned long)pptable)
-                                                         + le16_to_cpu(ppt=
able->usVCEStateTableOffset));
-       const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table =3D (ATOM_To=
nga_SCLK_Dependency_Table *)(((unsigned long)pptable)
-                                                         + le16_to_cpu(ppt=
able->usSclkDependencyTableOffset));
-       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table =3D (ATOM_To=
nga_MCLK_Dependency_Table *)(((unsigned long)pptable)
-                                                         + le16_to_cpu(ppt=
able->usMclkDependencyTableOffset));
-       const ATOM_Tonga_MM_Dependency_Table *mm_dep_table =3D (ATOM_Tonga_=
MM_Dependency_Table *)(((unsigned long)pptable)
-                                                         + le16_to_cpu(ppt=
able->usMMDependencyTableOffset));
+       const ATOM_Tonga_VCE_State_Table *vce_state_table;
+       const PPTable_Generic_SubTable_Header *sclk_dep_table_header;
+       const ATOM_Tonga_SCLK_Dependency_Table *sclk_dep_table;
+       const ATOM_Tonga_MCLK_Dependency_Table *mclk_dep_table;
+       const ATOM_Tonga_MM_Dependency_Table *mm_dep_table;
+       int ret;
+
+       if (!pptable)
+               return -EINVAL;
+
+       ret =3D get_tonga_vce_state_table(hwmgr, pptable, &vce_state_table)=
;
+       if (ret)
+               return ret;
+
+       ret =3D get_tonga_sclk_dependency_table(hwmgr, pptable,
+                                             &sclk_dep_table_header);
+       if (ret)
+               return ret;
+       sclk_dep_table =3D (const ATOM_Tonga_SCLK_Dependency_Table *)
+               sclk_dep_table_header;
+
+       ret =3D get_tonga_mclk_dependency_table(hwmgr, pptable, &mclk_dep_t=
able);
+       if (ret)
+               return ret;
+
+       ret =3D get_tonga_mm_dependency_table(hwmgr, pptable, &mm_dep_table=
);
+       if (ret)
+               return ret;

        PP_ASSERT_WITH_CODE((i < vce_state_table->ucNumEntries),
                         "Requested state entry ID is out of range!", @@ -1=
348,10 +1762,27 @@ static int ppt_get_vce_state_table_entry_v1_0(struct pp_=
hwmgr *hwmgr, uint32_t i
        vce_state_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
                                        ATOM_Tonga_VCE_State_Record,
                                        entries, vce_state_table, i);
-       sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
-                                       ATOM_Tonga_SCLK_Dependency_Record,
-                                       entries, sclk_dep_table,
-                                       vce_state_record->ucSCLKIndex);
+       PP_ASSERT_WITH_CODE((vce_state_record->ucSCLKIndex <
+                            sclk_dep_table->ucNumEntries),
+                           "Invalid PowerPlay Table!", return -EINVAL);
+       PP_ASSERT_WITH_CODE((vce_state_record->ucVCEClockIndex <
+                            mm_dep_table->ucNumEntries),
+                           "Invalid PowerPlay Table!", return -EINVAL);
+       PP_ASSERT_WITH_CODE((mclk_dep_table->ucNumEntries !=3D 0),
+                           "Invalid PowerPlay Table!", return -EINVAL);
+
+       if (sclk_dep_table_header->ucRevId < 1)
+               sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
+                                               ATOM_Tonga_SCLK_Dependency_=
Record,
+                                               entries, sclk_dep_table,
+                                               vce_state_record->ucSCLKInd=
ex);
+       else
+               polaris_sclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
+                                               ATOM_Polaris_SCLK_Dependenc=
y_Record,
+                                               entries,
+                                               (ATOM_Polaris_SCLK_Dependen=
cy_Table *)
+                                               sclk_dep_table_header,
+                                               vce_state_record->ucSCLKInd=
ex);
        mm_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
                                        ATOM_Tonga_MM_Dependency_Record,
                                        entries, mm_dep_table,
@@ -1360,7 +1791,10 @@ static int ppt_get_vce_state_table_entry_v1_0(struct=
 pp_hwmgr *hwmgr, uint32_t i

        vce_state->evclk =3D le32_to_cpu(mm_dep_record->ulEClk);
        vce_state->ecclk =3D le32_to_cpu(mm_dep_record->ulEClk);
-       vce_state->sclk =3D le32_to_cpu(sclk_dep_record->ulSclk);
+       if (sclk_dep_record)
+               vce_state->sclk =3D le32_to_cpu(sclk_dep_record->ulSclk);
+       else
+               vce_state->sclk =3D le32_to_cpu(polaris_sclk_dep_record->ul=
Sclk);

        if (vce_state_record->ucMCLKIndex >=3D mclk_dep_table->ucNumEntries=
)
                mclk_dep_record =3D GET_FLEXIBLE_ARRAY_MEMBER_ADDR(
--
2.47.3

