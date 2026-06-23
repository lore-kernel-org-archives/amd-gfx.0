Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668EDCD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 12:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB2710E94E;
	Tue, 23 Jun 2026 12:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y26XnE44";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4784310E94E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 12:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM641el4S2fDd2Xk4BGfpgH4k2t1UHDp2zTtwqI3cMmqFDtB3nEaum1WJzue0u+gose0djav8Kk/nx5jovE04tMA+nbqaChh+7Mk7of/HrwpBYzjc+D+ih3xizwWWIPDseAkHJdgzYDq0c2XG+0wVqDmuqeajnmXMZzqxFi2NzXFmcRgWyZ1mSz+Y22Wy2wqsnlask2xi8era+cSfGJAp9ITO5mfg8yjSvyfahsnmMZeqfI4DukRafHMoyjX09nAxyefB2w7j7PiJYu95XJYot+Jz73yawr6Z4TqWwAvGR23lBuQzEzxXezF6NM4eeQSuKb13858ub8kXghKUV9KnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdYYlmHX/rmjQAk2j/UHtonzG6lEk8F1Kh1Eawunfac=;
 b=RiylWlG4ohysLFMUq3s9UyLs+xyurV59ICtS7rDOd39s6go9PEgn2mWKYvd8/iJ6wDIuTVzVB+3xTymJZdxZV3Qss9PY6dapRerWYQ0mfXvBDgppVnSBBdWHckrRQ0B8Fvp7cAsEhI0P3hhUSjMEatBD1dLFH+JPVT10ocrsDGgCpHOhOizfGOtdkSYc9R1INgF2MCLqIR9jOhlWrOGFfVs6jdGkDJFP73+ElT5v4yFUdn3PBMzWfWzYYxn3Eam76xjR76DVnSQ28YMy8vT9raFbH8PA66RusNcAOLITYgFa+TkgcSBSdIMEP06PJpRUf6PyBazoLEF8RH5X+dFkXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdYYlmHX/rmjQAk2j/UHtonzG6lEk8F1Kh1Eawunfac=;
 b=y26XnE44MH6Z6u8UTaIM2LypneTq6bgBAW2uZlYSwJkWMNtESzy3zLRXFG8ISpXAlJk7V43x5e/uzSlXuEAUDh/eSWoyf0XC9qBMuCVNPFHpjfMBQEQQnq/ZLu0lyxVrNxLmxpuNJj9bKC17KVH+llskuKL75xbC36tbWLXNhJo=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 12:07:33 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 12:07:32 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: Validate remaining legacy PPLIB table
 bounds
Thread-Topic: [PATCH 3/3] drm/amd/pm: Validate remaining legacy PPLIB table
 bounds
Thread-Index: AQHdAvpkHmsvQsPlO06GhpHINm3IibZMCpPg
Date: Tue, 23 Jun 2026 12:07:32 +0000
Message-ID: <DM4PR12MB503855884BCB6FA0F0FF851F8EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
 <20260623102319.413960-3-kevinyang.wang@amd.com>
In-Reply-To: <20260623102319.413960-3-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T12:03:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|SJ0PR12MB5663:EE_
x-ms-office365-filtering-correlation-id: 09d5ba57-76a5-4f79-9c58-08ded120017f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|3023799007|6133799003|56012099006|22082099003|4143699003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: kbudpfyA+DvKSBJUoLqUunWdiSKRh83Aek9OToaXB2qIMBdm8Zn0hYzR5VeeHwQJD1cKhgmzzzCLBjT6VcCq1U5tLL1POv9HOkoBMu3rfgu658MSaFCHYp6dLri8Hp00ymUhQUfpHsf1Kju6A2Cn8jIHDXifuJgkKz6cibXgAueZoDXc+AuH82uuOPfYGUIj+wg81fKuisqRO2YLNYx2HaPtMWrnwM+dCQPYH9r/Sr/ELAcshZucUb4rcCjBABRf7lmn2iLqX8U0q36I89JV7D4Eee1YrrijNbqL6S30VKXrw6FacnJEOcofZMwTy71TUxQjVWOo7YPoxe8ay2yyl8LmxUAZMmOYSqmn6tmMqo2/awKkWTKXDl5HjlKFaLHwSl3hIFxpfmL+b9hADVOp6fABtHI9a2cbSpt41pGeqsmiprJokIu+XTmMxExHnnumWWBxSud3eDuHkDg8bW423+wcTnGy+vIcX78AO75iFdfYhQZIVHepb/nHQZtWvgkMtk5gtf4/mv2MGvN/okqnBkQsuknJEgirOp6D5Mnj7OfpQ8Rod8ZoGyLKPRsHWmYf4VGXvhV6isA7pQtCMf9ctVGptgKCJZQu04yRVHK+dZT0IiiCd8fRbrKfVOTMJvEScYNDGMpMrJj/+3lG2HHqQBIX2A7i/Eh+ftO4lz5pAsK8bzXj+6FjCMzmDFqqY9BKNGkXIxpFI0xQ2m4sa7H5rY+bhxwlpoo0Yp79UtuQCzU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(3023799007)(6133799003)(56012099006)(22082099003)(4143699003)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fYOjnNIwC5iCLK6DPPk86l3Q67vqX2Bz2lYTAFgaI9l6aTme8F3zHpKxSSOv?=
 =?us-ascii?Q?DGvhe+dZrQcUqK347MhDDbRUnp2yKukKl+8vyKTF5qb1bIvDmR1CYzs/PcTf?=
 =?us-ascii?Q?iPoFaLPdRDnX84DpG9X9girqUiOcut0kobQ0U5+Pefy8GfVuf67ipJjTXt32?=
 =?us-ascii?Q?Ng6nL6b+3TB1Ej0fTyXEMenZg292qtotY9UgB6kMvEZrXZDFz5svFIHP8/T8?=
 =?us-ascii?Q?eoELK5xXe2T2MemU24iUS4Eqrkz4zLCF8LqFmLK/OLC13lvarbQA6iGJRk37?=
 =?us-ascii?Q?A1VTJfISG8s7BBXkbsdtNHLPDRd8c+78C5fKtnU9+yLVGcXDe0OelfqvL2oC?=
 =?us-ascii?Q?TX89FmcpNKa2Yy/wP6DGmd7SwcRS/gLEc2fxfZhuEzIv5qcRaJ/YzlyKOYSR?=
 =?us-ascii?Q?pdMhZ7AtFzJdn5EFq53p5AlZC1cbz5PA9FtG3t8AK3X2cafYXi87LaI3zES7?=
 =?us-ascii?Q?bVeh2vEw9yLLDSDSDHSKXdtHUC+LDzTmtNGM1NSNe2kDNZaUFjJs2soVlvRn?=
 =?us-ascii?Q?vM0JkPSG3hNlPso0RaFOiMDlFLiZRpbNioJ8y2+qx5ut+KHHvWR7MxBuJt8g?=
 =?us-ascii?Q?3vRoe2bbrwE0Oni2R8YFbf2K8b4iwjUMwxyyLot1sOhgQZjHarBkhrn+VegX?=
 =?us-ascii?Q?CQu4aLj9RkeieHZxhTunZuIdD4UyM0IyCTS8hzANUqDevQlarosD419zPPm5?=
 =?us-ascii?Q?vAUIDIVjfrsdSdfBhlTd76lrcDnimcVohWoyicKOFqWlJYTGU7pf2bGltrqp?=
 =?us-ascii?Q?pw5Idk6/EIzomop+MP96duDwGXykpr0kRAX88unjfmOnklCqpuy6cCgvGC8Q?=
 =?us-ascii?Q?+X+mIrnimK/FJLh1X31sH4BKhLSchCiOsQ53uXvHRXDZfbcvxC3NyvCqICE3?=
 =?us-ascii?Q?jiDHoSTxhEOT6PWu9rxu3vC+qyfJUzVwlZtH5LDcnp5wrJwIFz/vbI+Olbll?=
 =?us-ascii?Q?84nnhauTe8EWHF3cGBTBRCa5OnPufSwZ2R6N2YPBDq2K6nVKF65SYqDlhWvy?=
 =?us-ascii?Q?IWI3ncQiMOUzDHi5wlu+riYNGDLwy7l614cbPBBzYMzOl8BXyua8DBeyra0O?=
 =?us-ascii?Q?Bdf9HpHIv+AJqR70L7UG8OjqpnUnlAz3zVa51meUjcJuY32eKBlKveSLtavj?=
 =?us-ascii?Q?j+eg/WbdjtJf1uC43IU4RSOXm8+iU5ERY2AjXhWpMHwsEyNaPsZGUVlO2sac?=
 =?us-ascii?Q?pWcsILgoMNwO5bni/FwuborUJsMFWclu7WX1Vl+wbMJdkuMqyruCrz23eSP9?=
 =?us-ascii?Q?mHzF8lolw/rdYDHWvnDPItIhOpu8HMrxWd1FQNrxAQuw4vTW2lc1XfdAd76E?=
 =?us-ascii?Q?B4NYVpSbNEH/abwlha2GdR0r3Y237JbLQp3xkiZ555CukQNONlMZpjxKV58j?=
 =?us-ascii?Q?3xHDDhd9p4pvFiz5SUqrkgorIz9YzPY91lPwJXys86+mWgUUTAD4pz3aL7cn?=
 =?us-ascii?Q?S8YFeQaVrJx7/amnQcpIwi1kJIsB4mj/NrXLmBKRgUxxxoFj7jPrJdTmossF?=
 =?us-ascii?Q?levG+SCVPaPYoZiLKb8zDGaih432M3C7ZPMgaqSu2MJ1R98hvtG4vPouoWso?=
 =?us-ascii?Q?bHIW6nFrzFa7mnyzoqdJQGa4ccuN4xBZHkZVcuKiKNemrf4rWyfYc1s6yL2Z?=
 =?us-ascii?Q?us8btGs9YS4iCr4nE877pntsKIMYYbIkjdJKEnc/GPEo7TI/ogRvJw0A6wQ1?=
 =?us-ascii?Q?C7MC4U+QypOZ6cWyp2M0xNTr8otQX1Neslk4Wcc1e4CtwFtZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d5ba57-76a5-4f79-9c58-08ded120017f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 12:07:32.6414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zPK+tY/efI4zdnmNv2wlKcOYbg+TrnRmmJgRxr1Z1xIoEFoMEGGy6sptvDXGtKpMjyV+7kx5Xbk59QyviWwjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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
Subject: [PATCH 3/3] drm/amd/pm: Validate remaining legacy PPLIB table boun=
ds

The legacy PPLIB parser still had paths that consumed VBIOS offsets, entry =
counts and clock-info indices before proving the referenced data fit within=
 soft_pp_table_size. Malformed tables can trigger out-of-bounds reads while=
 parsing clock-voltage, CAC, fan, PPM and phase-shedding data.

Add shared bounds checks for the remaining fixed and variable-length legacy=
 subtables. Also validate UVD/VCE clock-info indices before indexing their =
clock-info arrays.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 427 ++++++++++++++----
 1 file changed, 338 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/dri=
vers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index b2e1123844ec..678c31abe4c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -55,6 +55,159 @@ static bool pp_table_has_space(struct pp_hwmgr *hwmgr, =
size_t offset,
        return offset <=3D table_size && size <=3D table_size - offset;  }

+static int get_pplib_subtable(struct pp_hwmgr *hwmgr,
+                             const ATOM_PPLIB_POWERPLAYTABLE *powerplay_ta=
ble,
+                             u16 table_offset, size_t table_size,
+                             const void **table)
+{
+       PP_ASSERT_WITH_CODE((table_offset !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+       PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+                                               table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *table =3D (const void *)(((unsigned long)powerplay_table) +
+table_offset);
+
+       return 0;
+}
+
+static int validate_pplib_table_entries(struct pp_hwmgr *hwmgr,
+                                       u16 table_offset, size_t entries_of=
fset,
+                                       u8 num_entries, size_t entry_size) =
{
+       size_t table_size;
+
+       PP_ASSERT_WITH_CODE((num_entries !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table_size =3D entries_offset + num_entries * entry_size;
+       PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+                                               table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       return 0;
+}
+
+static int validate_pplib_optional_table_entries(struct pp_hwmgr *hwmgr,
+                                       u16 table_offset, size_t entries_of=
fset,
+                                       u8 num_entries, size_t entry_size) =
{
+       size_t table_size;
+
+       table_size =3D entries_offset + num_entries * entry_size;
+       PP_ASSERT_WITH_CODE((pp_table_has_space(hwmgr, table_offset,
+                                               table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       return 0;
+}
+
+static int get_pplib_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr=
,
+                       const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+                       u16 table_offset,
+                       const ATOM_PPLIB_Clock_Voltage_Dependency_Table **t=
able) {
+       const ATOM_PPLIB_Clock_Voltage_Dependency_Table *dep_table;
+       int ret;
+
+       ret =3D get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*dep_table), (const void **)&dep_ta=
ble);
+       if (ret)
+               return ret;
+
+       ret =3D validate_pplib_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_PPLIB_Clock_Voltag=
e_Dependency_Table,
+                                                   entries),
+                                          dep_table->ucNumEntries,
+                                          sizeof(ATOM_PPLIB_Clock_Voltage_=
Dependency_Record));
+       if (ret)
+               return ret;
+
+       *table =3D dep_table;
+
+       return 0;
+}
+
+static int get_pplib_clock_voltage_limit_table(struct pp_hwmgr *hwmgr,
+                       const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+                       u16 table_offset,
+                       const ATOM_PPLIB_Clock_Voltage_Limit_Table **table)=
 {
+       const ATOM_PPLIB_Clock_Voltage_Limit_Table *limit_table;
+       int ret;
+
+       ret =3D get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*limit_table),
+                                (const void **)&limit_table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_pplib_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_PPLIB_Clock_Voltag=
e_Limit_Table,
+                                                   entries),
+                                          limit_table->ucNumEntries,
+                                          sizeof(ATOM_PPLIB_Clock_Voltage_=
Limit_Record));
+       if (ret)
+               return ret;
+
+       *table =3D limit_table;
+
+       return 0;
+}
+
+static int get_pplib_cac_leakage_table(struct pp_hwmgr *hwmgr,
+                       const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+                       u16 table_offset,
+                       const ATOM_PPLIB_CAC_Leakage_Table **table) {
+       const ATOM_PPLIB_CAC_Leakage_Table *leakage_table;
+       int ret;
+
+       ret =3D get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*leakage_table),
+                                (const void **)&leakage_table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_pplib_optional_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_PPLIB_CAC_Leakage_=
Table,
+                                                   entries),
+                                          leakage_table->ucNumEntries,
+                                          sizeof(ATOM_PPLIB_CAC_Leakage_Re=
cord));
+       if (ret)
+               return ret;
+
+       *table =3D leakage_table;
+
+       return 0;
+}
+
+static int get_pplib_phase_shedding_table(struct pp_hwmgr *hwmgr,
+                       const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table,
+                       u16 table_offset,
+                       const ATOM_PPLIB_PhaseSheddingLimits_Table **table)=
 {
+       const ATOM_PPLIB_PhaseSheddingLimits_Table *phase_table;
+       int ret;
+
+       ret =3D get_pplib_subtable(hwmgr, powerplay_table, table_offset,
+                                sizeof(*phase_table), (const void **)&phas=
e_table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_pplib_optional_table_entries(hwmgr, table_offset,
+                                          offsetof(ATOM_PPLIB_PhaseSheddin=
gLimits_Table,
+                                                   entries),
+                                          phase_table->ucNumEntries,
+                                          sizeof(ATOM_PPLIB_PhaseSheddingL=
imits_Record));
+       if (ret)
+               return ret;
+
+       *table =3D phase_table;
+
+       return 0;
+}
+
 static const ATOM_PPLIB_EXTENDEDHEADER *  get_extended_header(struct pp_hw=
mgr *hwmgr,
                    const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table, @@ -1=
143,14 +1296,36 @@ static int init_thermal_controller(
         if (powerplay_table->usTableSize >=3D sizeof(ATOM_PPLIB_POWERPLAYT=
ABLE3)) {
                const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =3D
                        (const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table=
;
+               u16 fan_table_offset;

                if (0 =3D=3D le16_to_cpu(powerplay_table3->usFanTableOffset=
)) {
                        hwmgr->thermal_controller.use_hw_fan_control =3D 1;
                        return 0;
                } else {
-                       const ATOM_PPLIB_FANTABLE *fan_table =3D
-                               (const ATOM_PPLIB_FANTABLE *)(((unsigned lo=
ng)powerplay_table) +
-                                                             le16_to_cpu(p=
owerplay_table3->usFanTableOffset));
+                       const ATOM_PPLIB_FANTABLE *fan_table;
+                       size_t fan_table_size;
+
+                       fan_table_offset =3D le16_to_cpu(powerplay_table3->=
usFanTableOffset);
+                       if (!pp_table_has_space(hwmgr, fan_table_offset,
+                                               sizeof(*fan_table)))
+                               return -EINVAL;
+
+                       fan_table =3D (const ATOM_PPLIB_FANTABLE *)
+                               (((unsigned long)powerplay_table) + fan_tab=
le_offset);
+                       if (fan_table->ucFanTableFormat >=3D 7)
+                               fan_table_size =3D sizeof(ATOM_PPLIB_FANTAB=
LE5);
+                       else if (fan_table->ucFanTableFormat >=3D 6)
+                               fan_table_size =3D sizeof(ATOM_PPLIB_FANTAB=
LE4);
+                       else if (fan_table->ucFanTableFormat >=3D 3)
+                               fan_table_size =3D sizeof(ATOM_PPLIB_FANTAB=
LE3);
+                       else if (fan_table->ucFanTableFormat >=3D 2)
+                               fan_table_size =3D sizeof(ATOM_PPLIB_FANTAB=
LE2);
+                       else
+                               fan_table_size =3D sizeof(ATOM_PPLIB_FANTAB=
LE);
+
+                       if (!pp_table_has_space(hwmgr, fan_table_offset,
+                                               fan_table_size))
+                               return -EINVAL;

                        if (1 <=3D fan_table->ucFanTableFormat) {
                                hwmgr->thermal_controller.advanceFanControl=
Parameters.ucTHyst =3D @@ -1176,16 +1351,14 @@ static int init_thermal_cont=
roller(

                        if (2 <=3D fan_table->ucFanTableFormat) {
                                const ATOM_PPLIB_FANTABLE2 *fan_table2 =3D
-                                       (const ATOM_PPLIB_FANTABLE2 *)(((un=
signed long)powerplay_table) +
-                                                                      le16=
_to_cpu(powerplay_table3->usFanTableOffset));
+                                       (const ATOM_PPLIB_FANTABLE2 *)fan_t=
able;
                                hwmgr->thermal_controller.advanceFanControl=
Parameters.usTMax =3D
                                        le16_to_cpu(fan_table2->usTMax);
                        }

                        if (3 <=3D fan_table->ucFanTableFormat) {
                                const ATOM_PPLIB_FANTABLE3 *fan_table3 =3D
-                                       (const ATOM_PPLIB_FANTABLE3 *) (((u=
nsigned long)powerplay_table) +
-                                                                       le1=
6_to_cpu(powerplay_table3->usFanTableOffset));
+                                       (const ATOM_PPLIB_FANTABLE3 *)fan_t=
able;

                                hwmgr->thermal_controller.advanceFanControl=
Parameters.ucFanControlMode =3D
                                        fan_table3->ucFanControlMode;
@@ -1206,8 +1379,7 @@ static int init_thermal_controller(

                        if (6 <=3D fan_table->ucFanTableFormat) {
                                const ATOM_PPLIB_FANTABLE4 *fan_table4 =3D
-                                       (const ATOM_PPLIB_FANTABLE4 *)(((un=
signed long)powerplay_table) +
-                                                                      le16=
_to_cpu(powerplay_table3->usFanTableOffset));
+                                       (const ATOM_PPLIB_FANTABLE4 *)fan_t=
able;

                                phm_cap_set(hwmgr->platform_descriptor.plat=
formCaps,
                                            PHM_PlatformCaps_FanSpeedInTabl=
eIsRPM);
@@ -1218,8 +1390,7 @@ static int init_thermal_controller(

                        if (7 <=3D fan_table->ucFanTableFormat) {
                                const ATOM_PPLIB_FANTABLE5 *fan_table5 =3D
-                                       (const ATOM_PPLIB_FANTABLE5 *)(((un=
signed long)powerplay_table) +
-                                                                      le16=
_to_cpu(powerplay_table3->usFanTableOffset));
+                                       (const ATOM_PPLIB_FANTABLE5 *)fan_t=
able;

                                if (0x67A2 =3D=3D adev->pdev->device ||
                                    0x67A9 =3D=3D adev->pdev->device || @@ =
-1351,8 +1522,14 @@ static int get_uvd_clock_voltage_limit_table(struct pp_=
hwmgr *hwmgr,
        uvd_table->count =3D table->numEntries;

        for (i =3D 0; i < table->numEntries; i++) {
-               const UVDClockInfo *entry =3D
-                       &array->entries[table->entries[i].ucUVDClockInfoInd=
ex];
+               const UVDClockInfo *entry;
+
+               if (table->entries[i].ucUVDClockInfoIndex >=3D array->ucNum=
Entries) {
+                       kfree(uvd_table);
+                       return -EINVAL;
+               }
+
+               entry =3D &array->entries[table->entries[i].ucUVDClockInfoI=
ndex];
                uvd_table->entries[i].v =3D (unsigned long)le16_to_cpu(tabl=
e->entries[i].usVoltage);
                uvd_table->entries[i].vclk =3D ((unsigned long)entry->ucVCl=
kHigh << 16)
                                         | le16_to_cpu(entry->usVClkLow);
@@ -1380,7 +1557,14 @@ static int get_vce_clock_voltage_limit_table(struct =
pp_hwmgr *hwmgr,

        vce_table->count =3D table->numEntries;
        for (i =3D 0; i < table->numEntries; i++) {
-               const VCEClockInfo *entry =3D &array->entries[table->entrie=
s[i].ucVCEClockInfoIndex];
+               const VCEClockInfo *entry;
+
+               if (table->entries[i].ucVCEClockInfoIndex >=3D array->ucNum=
Entries) {
+                       kfree(vce_table);
+                       return -EINVAL;
+               }
+
+               entry =3D &array->entries[table->entries[i].ucVCEClockInfoI=
ndex];

                vce_table->entries[i].v =3D (unsigned long)le16_to_cpu(tabl=
e->entries[i].usVoltage);
                vce_table->entries[i].evclk =3D ((unsigned long)entry->ucEV=
ClkHigh << 16) @@ -1474,12 +1658,20 @@ static int init_clock_voltage_depend=
ency(struct pp_hwmgr *hwmgr,
                const VCEClockInfoArray *array =3D (const VCEClockInfoArray=
 *)
                                (((unsigned long) powerplay_table) +
                                vce_clock_info_array_offset);
-               const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table =3D
-                               (const ATOM_PPLIB_VCE_Clock_Voltage_Limit_T=
able *)
-                               (((unsigned long) powerplay_table) + table_=
offset);
-               result =3D get_vce_clock_voltage_limit_table(hwmgr,
-                               &hwmgr->dyn_state.vce_clock_voltage_depende=
ncy_table,
-                               table, array);
+               const ATOM_PPLIB_VCE_Clock_Voltage_Limit_Table *table;
+
+               result =3D get_pplib_subtable(hwmgr, powerplay_table, table=
_offset,
+                               sizeof(*table), (const void **)&table);
+               if (!result)
+                       result =3D validate_pplib_optional_table_entries(hw=
mgr, table_offset,
+                               offsetof(ATOM_PPLIB_VCE_Clock_Voltage_Limit=
_Table,
+                                        entries),
+                               table->numEntries,
+                               sizeof(ATOM_PPLIB_VCE_Clock_Voltage_Limit_R=
ecord));
+               if (!result)
+                       result =3D get_vce_clock_voltage_limit_table(hwmgr,
+                                       &hwmgr->dyn_state.vce_clock_voltage=
_dependency_table,
+                                       table, array);
        }

        uvd_clock_info_array_offset =3D get_uvd_clock_info_array_offset(hwm=
gr, powerplay_table); @@ -1489,40 +1681,78 @@ static int init_clock_voltage=
_dependency(struct pp_hwmgr *hwmgr,
                const UVDClockInfoArray *array =3D (const UVDClockInfoArray=
 *)
                                (((unsigned long) powerplay_table) +
                                uvd_clock_info_array_offset);
-               const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *ptable =3D
-                               (const ATOM_PPLIB_UVD_Clock_Voltage_Limit_T=
able *)
-                               (((unsigned long) powerplay_table) + table_=
offset);
-               result =3D get_uvd_clock_voltage_limit_table(hwmgr,
-                               &hwmgr->dyn_state.uvd_clock_voltage_depende=
ncy_table, ptable, array);
+               const ATOM_PPLIB_UVD_Clock_Voltage_Limit_Table *ptable;
+
+               result =3D get_pplib_subtable(hwmgr, powerplay_table, table=
_offset,
+                               sizeof(*ptable), (const void **)&ptable);
+               if (!result)
+                       result =3D validate_pplib_optional_table_entries(hw=
mgr, table_offset,
+                               offsetof(ATOM_PPLIB_UVD_Clock_Voltage_Limit=
_Table,
+                                        entries),
+                               ptable->numEntries,
+                               sizeof(ATOM_PPLIB_UVD_Clock_Voltage_Limit_R=
ecord));
+               if (!result)
+                       result =3D get_uvd_clock_voltage_limit_table(hwmgr,
+                                       &hwmgr->dyn_state.uvd_clock_voltage=
_dependency_table,
+                                       ptable, array);
        }

        table_offset =3D get_samu_clock_voltage_limit_table_offset(hwmgr,
                                                            powerplay_table=
);

        if (table_offset > 0) {
-               const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *ptable =3D
-                               (const ATOM_PPLIB_SAMClk_Voltage_Limit_Tabl=
e *)
-                               (((unsigned long) powerplay_table) + table_=
offset);
-               result =3D get_samu_clock_voltage_limit_table(hwmgr,
-                               &hwmgr->dyn_state.samu_clock_voltage_depend=
ency_table, ptable);
+               const ATOM_PPLIB_SAMClk_Voltage_Limit_Table *ptable;
+
+               result =3D get_pplib_subtable(hwmgr, powerplay_table, table=
_offset,
+                               sizeof(*ptable), (const void **)&ptable);
+               if (!result)
+                       result =3D validate_pplib_optional_table_entries(hw=
mgr, table_offset,
+                               offsetof(ATOM_PPLIB_SAMClk_Voltage_Limit_Ta=
ble,
+                                        entries),
+                               ptable->numEntries,
+                               sizeof(ATOM_PPLIB_SAMClk_Voltage_Limit_Reco=
rd));
+               if (!result)
+                       result =3D get_samu_clock_voltage_limit_table(hwmgr=
,
+                                       &hwmgr->dyn_state.samu_clock_voltag=
e_dependency_table,
+                                       ptable);
        }

        table_offset =3D get_acp_clock_voltage_limit_table_offset(hwmgr,
                                                             powerplay_tabl=
e);

        if (table_offset > 0) {
-               const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *ptable =3D
-                               (const ATOM_PPLIB_ACPClk_Voltage_Limit_Tabl=
e *)
-                               (((unsigned long) powerplay_table) + table_=
offset);
-               result =3D get_acp_clock_voltage_limit_table(hwmgr,
-                               &hwmgr->dyn_state.acp_clock_voltage_depende=
ncy_table, ptable);
+               const ATOM_PPLIB_ACPClk_Voltage_Limit_Table *ptable;
+
+               result =3D get_pplib_subtable(hwmgr, powerplay_table, table=
_offset,
+                               sizeof(*ptable), (const void **)&ptable);
+               if (!result)
+                       result =3D validate_pplib_optional_table_entries(hw=
mgr, table_offset,
+                               offsetof(ATOM_PPLIB_ACPClk_Voltage_Limit_Ta=
ble,
+                                        entries),
+                               ptable->numEntries,
+                               sizeof(ATOM_PPLIB_ACPClk_Voltage_Limit_Reco=
rd));
+               if (!result)
+                       result =3D get_acp_clock_voltage_limit_table(hwmgr,
+                                       &hwmgr->dyn_state.acp_clock_voltage=
_dependency_table,
+                                       ptable);
        }

        table_offset =3D get_cacp_tdp_table_offset(hwmgr, powerplay_table);
        if (table_offset > 0) {
-               UCHAR rev_id =3D *(UCHAR *)(((unsigned long)powerplay_table=
) + table_offset);
+               const void *tune_table;
+               UCHAR rev_id;

-               if (rev_id > 0) {
+               if (!pp_table_has_space(hwmgr, table_offset, sizeof(rev_id)=
))
+                       return -EINVAL;
+
+               rev_id =3D *(UCHAR *)(((unsigned long)powerplay_table) + ta=
ble_offset);
+               result =3D get_pplib_subtable(hwmgr, powerplay_table, table=
_offset,
+                               (rev_id > 0) ?
+                               sizeof(ATOM_PPLIB_POWERTUNE_Table_V1) :
+                               sizeof(ATOM_PPLIB_POWERTUNE_Table),
+                               (const void **)&tune_table);
AK: A non zero result will cause SCLK/MCLK/VDDCI/MVDD table to skip. Is it =
Ok? Was it same in earlier code?
+
+               if (!result && rev_id > 0) {
                        const ATOM_PPLIB_POWERTUNE_Table_V1 *tune_table =3D
                                (const ATOM_PPLIB_POWERTUNE_Table_V1 *)
                                (((unsigned long) powerplay_table) + table_=
offset); @@ -1531,7 +1761,7 @@ static int init_clock_voltage_dependency(str=
uct pp_hwmgr *hwmgr,
                                le16_to_cpu(tune_table->usMaximumPowerDeliv=
eryLimit));
                        hwmgr->dyn_state.cac_dtp_table->usDefaultTargetOper=
atingTemp =3D
                                le16_to_cpu(tune_table->usTjMax);
-               } else {
+               } else if (!result) {
                        const ATOM_PPLIB_POWERTUNE_Table *tune_table =3D
                                (const ATOM_PPLIB_POWERTUNE_Table *)
                                (((unsigned long) powerplay_table) + table_=
offset); @@ -1546,35 +1776,44 @@ static int init_clock_voltage_dependency(s=
truct pp_hwmgr *hwmgr,
                const ATOM_PPLIB_POWERPLAYTABLE4 *powerplay_table4 =3D
                                (const ATOM_PPLIB_POWERPLAYTABLE4 *)powerpl=
ay_table;
                if (0 !=3D powerplay_table4->usVddcDependencyOnSCLKOffset) =
{
-                       table =3D (ATOM_PPLIB_Clock_Voltage_Dependency_Tabl=
e *)
-                               (((unsigned long) powerplay_table4) +
-                                le16_to_cpu(powerplay_table4->usVddcDepend=
encyOnSCLKOffset));
-                       result =3D get_clock_voltage_dependency_table(hwmgr=
,
-                               &hwmgr->dyn_state.vddc_dependency_on_sclk, =
table);
+                       result =3D get_pplib_clock_voltage_dependency_table=
(hwmgr,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usVddcDepende=
ncyOnSCLKOffset),
+                               (const ATOM_PPLIB_Clock_Voltage_Dependency_=
Table **)&table);
+                       if (!result)
+                               result =3D get_clock_voltage_dependency_tab=
le(hwmgr,
+                                       &hwmgr->dyn_state.vddc_dependency_o=
n_sclk, table);
                }

                if (result =3D=3D 0 && (0 !=3D powerplay_table4->usVddciDep=
endencyOnMCLKOffset)) {
-                       table =3D (ATOM_PPLIB_Clock_Voltage_Dependency_Tabl=
e *)
-                               (((unsigned long) powerplay_table4) +
-                                le16_to_cpu(powerplay_table4->usVddciDepen=
dencyOnMCLKOffset));
-                       result =3D get_clock_voltage_dependency_table(hwmgr=
,
-                               &hwmgr->dyn_state.vddci_dependency_on_mclk,=
 table);
+                       result =3D get_pplib_clock_voltage_dependency_table=
(hwmgr,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usVddciDepend=
encyOnMCLKOffset),
+                               (const ATOM_PPLIB_Clock_Voltage_Dependency_=
Table **)&table);
+                       if (!result)
+                               result =3D get_clock_voltage_dependency_tab=
le(hwmgr,
+                                       &hwmgr->dyn_state.vddci_dependency_=
on_mclk, table);
                }

                if (result =3D=3D 0 && (0 !=3D powerplay_table4->usVddcDepe=
ndencyOnMCLKOffset)) {
-                       table =3D (ATOM_PPLIB_Clock_Voltage_Dependency_Tabl=
e *)
-                               (((unsigned long) powerplay_table4) +
-                                le16_to_cpu(powerplay_table4->usVddcDepend=
encyOnMCLKOffset));
-                       result =3D get_clock_voltage_dependency_table(hwmgr=
,
-                               &hwmgr->dyn_state.vddc_dependency_on_mclk, =
table);
+                       result =3D get_pplib_clock_voltage_dependency_table=
(hwmgr,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usVddcDepende=
ncyOnMCLKOffset),
+                               (const ATOM_PPLIB_Clock_Voltage_Dependency_=
Table **)&table);
+                       if (!result)
+                               result =3D get_clock_voltage_dependency_tab=
le(hwmgr,
+                                       &hwmgr->dyn_state.vddc_dependency_o=
n_mclk, table);
                }

                if (result =3D=3D 0 && (0 !=3D powerplay_table4->usMaxClock=
VoltageOnDCOffset)) {
-                       limit_table =3D (ATOM_PPLIB_Clock_Voltage_Limit_Tab=
le *)
-                               (((unsigned long) powerplay_table4) +
-                                le16_to_cpu(powerplay_table4->usMaxClockVo=
ltageOnDCOffset));
-                       result =3D get_clock_voltage_limit(hwmgr,
-                               &hwmgr->dyn_state.max_clock_voltage_on_dc, =
limit_table);
+                       result =3D get_pplib_clock_voltage_limit_table(hwmg=
r,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usMaxClockVol=
tageOnDCOffset),
+                               (const ATOM_PPLIB_Clock_Voltage_Limit_Table=
 **)&limit_table);
+                       if (!result)
+                               result =3D get_clock_voltage_limit(hwmgr,
+                                       &hwmgr->dyn_state.max_clock_voltage=
_on_dc,
+                                       limit_table);
                }

                if (result =3D=3D 0 && (NULL !=3D hwmgr->dyn_state.vddc_dep=
endency_on_mclk) && @@ -1589,11 +1828,14 @@ static int init_clock_voltage_d=
ependency(struct pp_hwmgr *hwmgr,
                                hwmgr->dyn_state.vddc_dependency_on_sclk);

                if (result =3D=3D 0 && (0 !=3D powerplay_table4->usMvddDepe=
ndencyOnMCLKOffset)) {
-                       table =3D (ATOM_PPLIB_Clock_Voltage_Dependency_Tabl=
e *)
-                               (((unsigned long) powerplay_table4) +
-                                le16_to_cpu(powerplay_table4->usMvddDepend=
encyOnMCLKOffset));
-                       result =3D get_clock_voltage_dependency_table(hwmgr=
,
-                               &hwmgr->dyn_state.mvdd_dependency_on_mclk, =
table);
+                       result =3D get_pplib_clock_voltage_dependency_table=
(hwmgr,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usMvddDepende=
ncyOnMCLKOffset),
+                               (const ATOM_PPLIB_Clock_Voltage_Dependency_=
Table **)&table);
+                       if (!result)
+                               result =3D get_clock_voltage_dependency_tab=
le(hwmgr,
+                                       &hwmgr->dyn_state.mvdd_dependency_o=
n_mclk,
+                                       table);
                }
        }

@@ -1601,10 +1843,13 @@ static int init_clock_voltage_dependency(struct pp_=
hwmgr *hwmgr,
                                                                powerplay_t=
able);

        if (table_offset > 0) {
-               table =3D (ATOM_PPLIB_Clock_Voltage_Dependency_Table *)
-                       (((unsigned long) powerplay_table) + table_offset);
-               result =3D get_clock_voltage_dependency_table(hwmgr,
-                       &hwmgr->dyn_state.vdd_gfx_dependency_on_sclk, table=
);
+               result =3D get_pplib_clock_voltage_dependency_table(hwmgr,
+                       powerplay_table, table_offset,
+                       (const ATOM_PPLIB_Clock_Voltage_Dependency_Table **=
)&table);
+               if (!result)
+                       result =3D get_clock_voltage_dependency_table(hwmgr=
,
+                               &hwmgr->dyn_state.vdd_gfx_dependency_on_scl=
k,
+                               table);
        }

        return result;
@@ -1676,12 +1921,6 @@ static int init_dpm2_parameters(struct pp_hwmgr *hwm=
gr,
            sizeof(ATOM_PPLIB_POWERPLAYTABLE5)) {
                const  ATOM_PPLIB_POWERPLAYTABLE5 *ptable5 =3D
                                (const ATOM_PPLIB_POWERPLAYTABLE5 *)powerpl=
ay_table;
-               const  ATOM_PPLIB_POWERPLAYTABLE4 *ptable4 =3D
-                               (const ATOM_PPLIB_POWERPLAYTABLE4 *)
-                               (&ptable5->basicTable4);
-               const  ATOM_PPLIB_POWERPLAYTABLE3 *ptable3 =3D
-                               (const ATOM_PPLIB_POWERPLAYTABLE3 *)
-                               (&ptable4->basicTable3);
                const  ATOM_PPLIB_EXTENDEDHEADER  *extended_header;
                uint16_t table_offset;
                ATOM_PPLIB_PPM_Table *atom_ppm_table; @@ -1711,28 +1950,34 =
@@ static int init_dpm2_parameters(struct pp_hwmgr *hwmgr,
                hwmgr->dyn_state.cac_leakage_table =3D NULL;

                if (0 !=3D ptable5->usCACLeakageTableOffset) {
-                       const ATOM_PPLIB_CAC_Leakage_Table *pCAC_leakage_ta=
ble =3D
-                               (ATOM_PPLIB_CAC_Leakage_Table *)(((unsigned=
 long)ptable5) +
-                               le16_to_cpu(ptable5->usCACLeakageTableOffse=
t));
-                       result =3D get_cac_leakage_table(hwmgr,
-                               &hwmgr->dyn_state.cac_leakage_table, pCAC_l=
eakage_table);
+                       const ATOM_PPLIB_CAC_Leakage_Table *pCAC_leakage_ta=
ble;
+
+                       result =3D get_pplib_cac_leakage_table(hwmgr, power=
play_table,
+                               le16_to_cpu(ptable5->usCACLeakageTableOffse=
t),
+                               &pCAC_leakage_table);
+                       if (!result)
+                               result =3D get_cac_leakage_table(hwmgr,
+                                       &hwmgr->dyn_state.cac_leakage_table=
,
+                                       pCAC_leakage_table);
                }

                hwmgr->platform_descriptor.LoadLineSlope =3D le16_to_cpu(pt=
able5->usLoadLineSlope);

                hwmgr->dyn_state.ppm_parameter_table =3D NULL;

-               if (0 !=3D ptable3->usExtendendedHeaderOffset) {
-                       extended_header =3D (const ATOM_PPLIB_EXTENDEDHEADE=
R *)
-                                       (((unsigned long)powerplay_table) +
-                                       le16_to_cpu(ptable3->usExtendendedH=
eaderOffset));
+               extended_header =3D get_extended_header(hwmgr, powerplay_ta=
ble,
+                                                     SIZE_OF_ATOM_PPLIB_EX=
TENDEDHEADER_V5);
+               if (extended_header) {
                        if ((extended_header->usPPMTableOffset > 0) &&
                                le16_to_cpu(extended_header->usSize) >=3D
                                    SIZE_OF_ATOM_PPLIB_EXTENDEDHEADER_V5) {
                                table_offset =3D le16_to_cpu(extended_heade=
r->usPPMTableOffset);
-                               atom_ppm_table =3D (ATOM_PPLIB_PPM_Table *)
-                                       (((unsigned long)powerplay_table) +=
 table_offset);
-                               if (0 =3D=3D get_platform_power_management_=
table(hwmgr, atom_ppm_table))
+                               result =3D get_pplib_subtable(hwmgr, powerp=
lay_table,
+                                       table_offset, sizeof(*atom_ppm_tabl=
e),
+                                       (const void **)&atom_ppm_table);
AK: Same as patch 2 may be causing regression, previous failure was silent =
and does not affected result

Thanks & Regards
Asad
+                               if (!result &&
+                                   !get_platform_power_management_table(hw=
mgr,
+                                                                        at=
om_ppm_table))
                                        phm_cap_set(hwmgr->platform_descrip=
tor.platformCaps,
                                                PHM_PlatformCaps_EnablePlat=
formPowerManagement);
                        }
@@ -1750,13 +1995,17 @@ static int init_phase_shedding_table(struct pp_hwmg=
r *hwmgr,
                                (const ATOM_PPLIB_POWERPLAYTABLE4 *)powerpl=
ay_table;

                if (0 !=3D powerplay_table4->usVddcPhaseShedLimitsTableOffs=
et) {
-                       const ATOM_PPLIB_PhaseSheddingLimits_Table *ptable =
=3D
-                               (ATOM_PPLIB_PhaseSheddingLimits_Table *)
-                               (((unsigned long)powerplay_table4) +
-                               le16_to_cpu(powerplay_table4->usVddcPhaseSh=
edLimitsTableOffset));
+                       const ATOM_PPLIB_PhaseSheddingLimits_Table *ptable;
                        struct phm_phase_shedding_limits_table *table;
                        unsigned long i;
+                       int result;

+                       result =3D get_pplib_phase_shedding_table(hwmgr,
+                               powerplay_table,
+                               le16_to_cpu(powerplay_table4->usVddcPhaseSh=
edLimitsTableOffset),
+                               &ptable);
+                       if (result)
+                               return result;

                        table =3D kzalloc(struct_size(table, entries, ptabl=
e->ucNumEntries),
                                        GFP_KERNEL);
--
2.47.3

