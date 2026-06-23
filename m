Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B381CCDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 11:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5175210EAB0;
	Tue, 23 Jun 2026 11:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bW7fzcjd";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2AF10EAB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 11:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHQi3kgF0SRQ80ry2W2adbcFivu7qSJsafngFAdy4inDTp78qjeHv/dVLH9JKyy2p5VHkJUOMPz9k38cc8SMIuhKy0onA/ii1qN8H9Lz+Efmnfnevs6+FRmTTMDb7GPXQp0dfIWBIH5ixEQu30aE9C4NcfYD9IrA2/B+ast/M7Zw2AFbzcwfIaOx5Xs5ITvVULZJJ8aKGVrLfzJ3DC6QfcCn7gRkVsn5ngrGuile4+Z63p1gF5ihDRHe9YmbK70/rijdNimuP0KvJiehrxKJb0LWTSnAhBeiWT2PMzwP0nwz0yytC4e2kN/DR2dIqqsAZP0VvyhpY08HiF1D2XpvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYxAzN75LIBDRFfO0MELvgrflY6GfZ/RnKWlymNUUmg=;
 b=Cf1sqr2wnK3h/jGar/r6sEggFqb/dTBkdgJ730+Z0w40ZkwQLC6AeOOqSORE9fBlG+RYlmSfMx/QcJLpZHxgyclMpDqS69foqUQuzuPxPyC7aPyTfCau5deoQsOVY/Iedpsbz5r3px4LZ4/JW8450wOkAa0ZceI1wrqU0LcZcspN2lffXNVPe03p/2uFBeUjgiysdovwRfuBZ71KXpzG7+I2+GVVz3O91164QLP6tjKyYcACMPb83OImmnL6HR65W85a2pT2sbnuIYy/YvXIQTpnsT2k2YjybTW0oFmJ1okxoUSKfx2b68piFIjj5pooDBZNSXYw6rQpMR2JClGagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYxAzN75LIBDRFfO0MELvgrflY6GfZ/RnKWlymNUUmg=;
 b=bW7fzcjdSPFekTzNIQzSngyMf9T2CT6a7LS3nFawPe5NG075cfhl3jUKdrzpoTQA+8BBCta8USF7NQDFLFdObS+qYAwnDIRvC99Yc4dcZ8AYmi/N2JWoEf2JVURkoaisjTsxDDHzgvej54CD6sTrojN7wUkJ+qtPH2hU0PqJTGk=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 11:32:10 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:32:10 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Thread-Topic: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Thread-Index: AQHdAvpkMe1QTJMOv0eWSx4MykzyfrZMAYKg
Date: Tue, 23 Jun 2026 11:32:10 +0000
Message-ID: <DM4PR12MB5038A6A427727B37C3E860208EEE2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260623102319.413960-1-kevinyang.wang@amd.com>
In-Reply-To: <20260623102319.413960-1-kevinyang.wang@amd.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|DM4PR12MB6277:EE_
x-ms-office365-filtering-correlation-id: 36cfde1c-899b-4c5c-97b5-08ded11b1050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|3023799007|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: 0YBn1+JS3+kVEYrzhf2ktX+HwFtvFc26Bmfda4I+gh2YALOQcswmzWbNR569MoiBesmHG/iSbfiq0f2NejamJ/4toAiGh4QCq2s+5ZNi+9Cr9QU6nExFUkU4yil37JvCy0IdxcFzaeUX4a4vrag8RD4th1Yvhft69mVUoprc5o8/ufPT8zQim0BFmxGX5WBQQy86Vp/z3XfXBBHT0oNVcSSDWlVA8L2Y/FtKMkhXLgNixQhIwdXfuKvyLgv36RVcKKBDbq6lK6iPUhDERd6qfXafDyQ4P7cFgrkjwpTzlbZLIKGlIRdKbR8bjFLwJq6pnZW2u39i50bx/skPzcnVQDhHNOk+ausjGw1JDjmboyzTdglBzYntyr1bjXKV1Jz7iVo0ZYPXvrT/qC2qlWLWtHsxuJGaNvtQnU/V0D3hnALqwRFtgWhz4rjjRLpRORyDS1RUzsc79ycrThbAw7zg08HpcHon1/FeEOQC1wywt6iFqbKZzFTo03sTRtWiWE646r2OeJvtHd80hmQr5SmCSoeiFLnanIMWUUm6KFLqJ+KRTpBu6NtuoT1Yh2/lYvkXHwzgZR6oVDY+IfU9Bue7EEmwyyoWLPqdHRvtU3+jkiucRE6jQt9hjUexuRszqHqc5ZxjxFx2JTj8w2HhNYIQdConmj7exKYRjsELzlys4hOTLnbbopx2Ot8vBzpwWbkC72q+4Aqc13Fzlx1bwhL64Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hXms0BLm5JRiC3/ag5DaJR+CEzNMOXjRiV5yGlD/xJFNU8GE2ndz7wdlQvOY?=
 =?us-ascii?Q?Bh7+2oAGXhl5SgAiWYqzYR8cQr3eqpcuayVcU/pWi4fOObgNsauf05mP4ecS?=
 =?us-ascii?Q?hNxwxGCM+2vmfxuBi+UgY8kleNmppkd9kIsJ5tF208ByHKnMXO5M4FZqqCor?=
 =?us-ascii?Q?YgIu5qWQGYIuJ6qTp7pY/WioGghx6QWGYVGeSDqMMaIOKorgptE0eADKMq6e?=
 =?us-ascii?Q?7SQqMWqprfzC9dgsAsA7pU3ShtzCgzsdk6P04u/CkSd+nsI4TC3ATaSoMDwR?=
 =?us-ascii?Q?OzoYYgWruJm0U/IReZpItrBF2ytKQIWtJozTmoYPc83SR+6n31vV4f+4ZYWP?=
 =?us-ascii?Q?XYeU1ei0lkylEhtKo4o5rzQeLUPHNyKnmrWPzORI7V9GWvSxNSBT8Eij+DFy?=
 =?us-ascii?Q?Wh/QRlHCoQnhvCl///XxReNIQ2jVr02ouyE9fG06fwjSkUbbg2UQeN0UJK39?=
 =?us-ascii?Q?+ERe8lTjT5OUjL0hDmSDSScPqsssmhbhUlvy23ZZE6YZz6oFZ4I6phgjqgmg?=
 =?us-ascii?Q?MOCUQW4QP3s4gDwB7NzruzujubDlS1fj0gU/i8YgHjE/QsnMD8mtOHISCk3K?=
 =?us-ascii?Q?3Keg3LTBQT/mQOhmt06k0N0ShTH5bv9Y34ZUDJnbu68kIP0x5cGkkCMZ6Uk8?=
 =?us-ascii?Q?HlIdkQLRAQfC8rPVE5oiqGsI2M98EsLvB/ic5eYWxw2A1/og/pjeQcO3I9yx?=
 =?us-ascii?Q?VyV7VT50NhoNWDZp4IGkxotjRTO8JdAh9FBAfPafs152rV7XIsUs1FLD8HkK?=
 =?us-ascii?Q?WxZHfOnuu6BbIupFht6eebwXHQWe5PkLjOe/9XJg/O3tnVAQjE+Lwll56uSl?=
 =?us-ascii?Q?8zK69CZkyWhY2uh4dpCcZCcOwBleHt2dqsXolqeJndo2RAHtHYA7Z68qg0Zk?=
 =?us-ascii?Q?unjEIc1+iLAoYjn9Zh7NWFaY8KDv6ctOpCAYudBrK+v0Q5OR/POBWKX3X4o9?=
 =?us-ascii?Q?LS4CIW5h+O8ooL0yZ3mYO4Jxt3zjGCRcFzoceg7/JKRegKjDbC4HY6JCpaBU?=
 =?us-ascii?Q?/Mx51/LOSLp8bk66W/eNSDrWrTLqyexmUPEcs8PUHVC4hmqnR9LsSqz8t1rB?=
 =?us-ascii?Q?76Q4YShAmijzxpt8VZmsTPFWVVR5BXPRoxYWHBJJBLhKi4p27Nc4PK9aEuaF?=
 =?us-ascii?Q?Uyg+n3VAht/HLIqshk6D3UULz8FEyjrBvi975MIGTmUGl1WSJgSVJBCwImgZ?=
 =?us-ascii?Q?qGrpdzwoNPuvXTxc18pSV681MPilNdNar7U3XWpausYMenpPgGqvYiX9EHpX?=
 =?us-ascii?Q?CScnbbWvjHAq6lZ+GNZZze9asubzSLhxtXBSBiq+XHTRjaOjR1aCCHOHxauK?=
 =?us-ascii?Q?2MHoHbYH2az99O+aKxK0Yt98A/f4M48/k20S0WYFy/sWO1ICHjKMsvR9wSVf?=
 =?us-ascii?Q?jbqyML/Y9n39u0LasJvXjYSDhbWVHk//eSeLpRkRSHu0qMMRPKcY2UKgAamE?=
 =?us-ascii?Q?vi/KZZhpoRDqLxQjPp6ivUMSqPd11XVKV8gLAQ6kAYnJjclGKaYza4gwOAAJ?=
 =?us-ascii?Q?2J4Eou4i8oxkFfNOdKmyCVlyHkwd0Dwi+frp5U0VDAVgI2ZXZQn6M6Qkxv7U?=
 =?us-ascii?Q?D7c5gl4dorSW75+kdNDNQM+C/qEWLl9MgGPYZyu7Bbr5yqi30AF/ChChKTjJ?=
 =?us-ascii?Q?OwO5E3+3QbmGBX9xM9MFMlP3dkOXpnA0QnS9a+65bRcSqP43iykbZwqJwwfp?=
 =?us-ascii?Q?rqz79uhbyuuPn3wKdfIzaSe4E8W7KdZuCtaLdirRmemFEjXn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cfde1c-899b-4c5c-97b5-08ded11b1050
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 11:32:10.0793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poLbUT6Y4dTi+WHfJD70ZjZUxlhF9XPsVYoEy38rAtAL1Zc3y2F+yuEktubUiF9/g0IpZmqw6xBmEzq0UZrEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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
Subject: [PATCH 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds

Vega10 PPTable parsing uses VBIOS-provided offsets, revision fields and ent=
ry counts to locate subtables. Malformed data can otherwise drive out-of-bo=
unds reads from soft_pp_table_size, and voltage lookup tables can overrun t=
heir fixed-size destination arrays.

Add shared bounds helpers and validate fixed-size subtables, dynamic entry =
arrays and revision-specific layouts before consuming thermal, fan, power-t=
une, clock dependency, PCIE, hard-limit and voltage lookup data.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 564 ++++++++++++++----
 1 file changed, 459 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.=
c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 64cff9f4850a..5dc6cd2b0c54 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
@@ -63,6 +63,46 @@ static const void *get_powerplay_table(struct pp_hwmgr *=
hwmgr)
        return table_address;
 }

+static bool vega10_pp_table_has_space(struct pp_hwmgr *hwmgr, size_t offse=
t,
+                                     size_t size)
+{
+       size_t table_size =3D hwmgr->soft_pp_table_size;
+
+       return offset <=3D table_size && size <=3D table_size - offset; }
+
+static int get_vega10_subtable(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               u16 table_offset, size_t table_size, const void **table) {
+       PP_ASSERT_WITH_CODE((table_offset !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *table =3D (const void *)(((unsigned long)powerplay_table) +
+table_offset);
+
+       return 0;
+}
+
+static int validate_vega10_table_entries(struct pp_hwmgr *hwmgr,
+               u16 table_offset, size_t entries_offset,
+               u8 num_entries, size_t entry_size)
+{
+       size_t table_size;
+
+       PP_ASSERT_WITH_CODE((num_entries !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table_size =3D entries_offset + num_entries * entry_size;
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       return 0;
+}
+
 static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
        const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
        const ATOM_Vega10_State_Array **state_array) @@ -102,6 +142,293 @@ =
static int get_vega10_state_array(struct pp_hwmgr *hwmgr,
        return 0;
 }

+static int get_vega10_gfxclk_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Vega10_GFXCLK_Dependency_Table **gfxclk_dep_tabl=
e) {
+       const ATOM_Vega10_GFXCLK_Dependency_Table *table;
+       u16 table_offset;
+       size_t table_size;
+       size_t entry_size;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usGfxclkDependencyTab=
leOffset);
+       if (!table_offset)
+               return -EINVAL;
+
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      sizeof(*table))),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table =3D (const ATOM_Vega10_GFXCLK_Dependency_Table *)
+               (((unsigned long)powerplay_table) + table_offset);
+       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0),
+                           "Invalid PowerPlay Table!", return -1);
+
+       if (table->ucRevId =3D=3D 0)
+               entry_size =3D sizeof(ATOM_Vega10_GFXCLK_Dependency_Record)=
;
+       else if (table->ucRevId =3D=3D 1)
+               entry_size =3D sizeof(ATOM_Vega10_GFXCLK_Dependency_Record_=
V2);
+       else
+               PP_ASSERT_WITH_CODE(false,
+                       "Unsupported GFXClockDependencyTable Revision!",
+                       return -EINVAL);
+
+       table_size =3D offsetof(ATOM_Vega10_GFXCLK_Dependency_Table, entrie=
s) +
+               table->ucNumEntries * entry_size;
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *gfxclk_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_vega10_clk_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               u16 table_offset,
+               const ATOM_Vega10_SOCCLK_Dependency_Table **clk_dep_table) =
{
+       const ATOM_Vega10_SOCCLK_Dependency_Table *table;
+       int ret;
+
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
+                                           offsetof(ATOM_Vega10_SOCCLK_Dep=
endency_Table,
+                                                    entries),
+                                           table->ucNumEntries,
+                                           sizeof(ATOM_Vega10_CLK_Dependen=
cy_Record));
+       if (ret)
+               return ret;
+
+       *clk_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_vega10_mclk_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Vega10_MCLK_Dependency_Table **mclk_dep_table) {
+       const ATOM_Vega10_MCLK_Dependency_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usMclkDependencyTable=
Offset);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
+                                           offsetof(ATOM_Vega10_MCLK_Depen=
dency_Table,
+                                                    entries),
+                                           table->ucNumEntries,
+                                           sizeof(ATOM_Vega10_MCLK_Depende=
ncy_Record));
+       if (ret)
+               return ret;
+
+       *mclk_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_vega10_mm_dependency_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Vega10_MM_Dependency_Table **mm_dep_table) {
+       const ATOM_Vega10_MM_Dependency_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usMMDependencyTableOf=
fset);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
+                                           offsetof(ATOM_Vega10_MM_Depende=
ncy_Table,
+                                                    entries),
+                                           table->ucNumEntries,
+                                           sizeof(ATOM_Vega10_MM_Dependenc=
y_Record));
+       if (ret)
+               return ret;
+
+       *mm_dep_table =3D table;
+
+       return 0;
+}
+
+static int get_vega10_pcie_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const Vega10_PPTable_Generic_SubTable_Header **pcie_table) =
{
+       const ATOM_Vega10_PCIE_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usPCIETableOffset);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       if (!table->ucNumEntries) {
+               *pcie_table =3D (const Vega10_PPTable_Generic_SubTable_Head=
er *)table;
+               return 0;
+       }
+
+       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
+                                           offsetof(ATOM_Vega10_PCIE_Table=
,
+                                                    entries),
+                                           table->ucNumEntries,
+                                           sizeof(ATOM_Vega10_PCIE_Record)=
);
+       if (ret)
+               return ret;
+
+       *pcie_table =3D (const Vega10_PPTable_Generic_SubTable_Header *)tab=
le;
+
+       return 0;
+}
+
+static int get_vega10_hard_limit_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Vega10_Hard_Limit_Table **hard_limit_table) {
+       const ATOM_Vega10_Hard_Limit_Table *table;
+       u16 table_offset;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usHardLimitTableOffse=
t);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       ret =3D validate_vega10_table_entries(hwmgr, table_offset,
+                                           offsetof(ATOM_Vega10_Hard_Limit=
_Table,
+                                                    entries),
+                                           table->ucNumEntries,
+                                           sizeof(ATOM_Vega10_Hard_Limit_R=
ecord));
+       if (ret)
+               return ret;
+
+       *hard_limit_table =3D table;
+
+       return 0;
+}
+
+static int get_vega10_thermal_controller_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const ATOM_Vega10_Thermal_Controller **thermal_controller) =
{
+       u16 table_offset;
+
+       table_offset =3D
+le16_to_cpu(powerplay_table->usThermalControllerOffset);
+
+       return get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                  sizeof(**thermal_controller),
+                                  (const void **)thermal_controller); }
+
+static int get_vega10_fan_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const Vega10_PPTable_Generic_SubTable_Header **fan_table) {
+       const Vega10_PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t table_size;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usFanTableOffset);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId =3D=3D 10)
+               table_size =3D sizeof(ATOM_Vega10_Fan_Table);
+       else if (header->ucRevId =3D=3D 0xb)
+               table_size =3D sizeof(ATOM_Vega10_Fan_Table_V2);
+       else if (header->ucRevId > 0xb)
+               table_size =3D sizeof(ATOM_Vega10_Fan_Table_V3);
+       else
+               return -EINVAL;

AK: May be this may lead to regression earlier code was silent fall through=
 for ucRevId < 10
+
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *fan_table =3D header;
+
+       return 0;
+}
+
+static int get_vega10_power_tune_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               const Vega10_PPTable_Generic_SubTable_Header **power_tune_t=
able) {
+       const Vega10_PPTable_Generic_SubTable_Header *header;
+       u16 table_offset;
+       size_t table_size;
+       int ret;
+
+       table_offset =3D le16_to_cpu(powerplay_table->usPowerTuneTableOffse=
t);
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*header), (const void **)&header);
+       if (ret)
+               return ret;
+
+       if (header->ucRevId =3D=3D 5)
+               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table);
+       else if (header->ucRevId =3D=3D 6)
+               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table_V2);
+       else
+               table_size =3D sizeof(ATOM_Vega10_PowerTune_Table_V3);
+
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *power_tune_table =3D header;
+
+       return 0;
+}
+
+static int get_vega10_voltage_lookup_table(struct pp_hwmgr *hwmgr,
+               const ATOM_Vega10_POWERPLAYTABLE *powerplay_table,
+               u16 table_offset, uint32_t max_levels,
+               const ATOM_Vega10_Voltage_Lookup_Table **lookup_table) {
+       const ATOM_Vega10_Voltage_Lookup_Table *table;
+       size_t table_size;
+       int ret;
+
+       ret =3D get_vega10_subtable(hwmgr, powerplay_table, table_offset,
+                                 sizeof(*table), (const void **)&table);
+       if (ret)
+               return ret;
+
+       PP_ASSERT_WITH_CODE((table->ucNumEntries !=3D 0 &&
+                            table->ucNumEntries <=3D max_levels),
+                           "Invalid PowerPlay Table!", return -1);
+
+       table_size =3D offsetof(ATOM_Vega10_Voltage_Lookup_Table, entries) =
+
+               table->ucNumEntries * sizeof(ATOM_Vega10_Voltage_Lookup_Rec=
ord);
+       PP_ASSERT_WITH_CODE((vega10_pp_table_has_space(hwmgr, table_offset,
+                                                      table_size)),
+                           "Invalid PowerPlay Table!", return -1);
+
+       *lookup_table =3D table;
+
+       return 0;
+}
+
 static int check_powerplay_tables(struct pp_hwmgr *hwmgr,
        const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)  { @@ -149,14 +4=
76,16 @@ static int init_thermal_controller(
        const ATOM_Vega10_Fan_Table *fan_table_v1;
        const ATOM_Vega10_Fan_Table_V2 *fan_table_v2;
        const ATOM_Vega10_Fan_Table_V3 *fan_table_v3;
-
-       thermal_controller =3D (ATOM_Vega10_Thermal_Controller *)
-                       (((unsigned long)powerplay_table) +
-                       le16_to_cpu(powerplay_table->usThermalControllerOff=
set));
+       int ret;

        PP_ASSERT_WITH_CODE((powerplay_table->usThermalControllerOffset !=
=3D 0),
                        "Thermal controller table not set!", return -EINVAL=
);

+       ret =3D get_vega10_thermal_controller_table(hwmgr, powerplay_table,
+                                                 &thermal_controller);
+       if (ret)
+               return ret;
+
        hwmgr->thermal_controller.ucType =3D thermal_controller->ucType;
        hwmgr->thermal_controller.ucI2cLine =3D thermal_controller->ucI2cLi=
ne;
        hwmgr->thermal_controller.ucI2cAddress =3D thermal_controller->ucI2=
cAddress; @@ -185,9 +514,9 @@ static int init_thermal_controller(
        if (!powerplay_table->usFanTableOffset)
                return 0;

-       header =3D (const Vega10_PPTable_Generic_SubTable_Header *)
-                       (((unsigned long)powerplay_table) +
-                       le16_to_cpu(powerplay_table->usFanTableOffset));
+       ret =3D get_vega10_fan_table(hwmgr, powerplay_table, &header);
+       if (ret)
+               return ret;

        if (header->ucRevId =3D=3D 10) {
                fan_table_v1 =3D (ATOM_Vega10_Fan_Table *)header; @@ -332,1=
2 +661,15 @@ static int init_over_drive_limits(
                struct pp_hwmgr *hwmgr,
                const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)  {
-       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =3D
-                       (const ATOM_Vega10_GFXCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usGfxclkDependencyTabl=
eOffset));
+       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
        bool is_acg_enabled =3D false;
        ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
+       int ret;
+
+       ret =3D get_vega10_gfxclk_dependency_table(hwmgr, powerplay_table,
+                                                &gfxclk_dep_table);
+       if (ret)
+               return ret;

        if (gfxclk_dep_table->ucRevId =3D=3D 1) {
                patom_record_v2 =3D
@@ -900,51 +1232,13 @@ static int init_powerplay_extended_tables(
        int result =3D 0;
        struct phm_ppt_v2_information *pp_table_info =3D
                (struct phm_ppt_v2_information *)(hwmgr->pptable);
-
-       const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table =3D
-                       (const ATOM_Vega10_MM_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usMMDependencyTableOff=
set));
-       const Vega10_PPTable_Generic_SubTable_Header *power_tune_table =3D
-                       (const Vega10_PPTable_Generic_SubTable_Header *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usPowerTuneTableOffset=
));
-       const ATOM_Vega10_SOCCLK_Dependency_Table *socclk_dep_table =3D
-                       (const ATOM_Vega10_SOCCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usSocclkDependencyTabl=
eOffset));
-       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =3D
-                       (const ATOM_Vega10_GFXCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usGfxclkDependencyTabl=
eOffset));
-       const ATOM_Vega10_DCEFCLK_Dependency_Table *dcefclk_dep_table =3D
-                       (const ATOM_Vega10_DCEFCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usDcefclkDependencyTab=
leOffset));
-       const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table =3D
-                       (const ATOM_Vega10_MCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usMclkDependencyTableO=
ffset));
-       const ATOM_Vega10_Hard_Limit_Table *hard_limits =3D
-                       (const ATOM_Vega10_Hard_Limit_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usHardLimitTableOffset=
));
-       const Vega10_PPTable_Generic_SubTable_Header *pcie_table =3D
-                       (const Vega10_PPTable_Generic_SubTable_Header *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usPCIETableOffset));
-       const ATOM_Vega10_PIXCLK_Dependency_Table *pixclk_dep_table =3D
-                       (const ATOM_Vega10_PIXCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usPixclkDependencyTabl=
eOffset));
-       const ATOM_Vega10_PHYCLK_Dependency_Table *phyclk_dep_table =3D
-                       (const ATOM_Vega10_PHYCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usPhyClkDependencyTabl=
eOffset));
-       const ATOM_Vega10_DISPCLK_Dependency_Table *dispclk_dep_table =3D
-                       (const ATOM_Vega10_DISPCLK_Dependency_Table *)
-                       (((unsigned long) powerplay_table) +
-                       le16_to_cpu(powerplay_table->usDispClkDependencyTab=
leOffset));
+       const ATOM_Vega10_MM_Dependency_Table *mm_dependency_table;
+       const Vega10_PPTable_Generic_SubTable_Header *power_tune_table;
+       const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table;
+       const ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table;
+       const ATOM_Vega10_Hard_Limit_Table *hard_limits;
+       const Vega10_PPTable_Generic_SubTable_Header *pcie_table;
+       const ATOM_Vega10_SOCCLK_Dependency_Table *clk_dep_table;

        pp_table_info->vdd_dep_on_socclk =3D NULL;
        pp_table_info->vdd_dep_on_sclk =3D NULL; @@ -956,63 +1250,114 @@ st=
atic int init_powerplay_extended_tables(
        pp_table_info->vdd_dep_on_phyclk =3D NULL;
        pp_table_info->vdd_dep_on_dispclk =3D NULL;

-       if (powerplay_table->usMMDependencyTableOffset)
-               result =3D get_mm_clock_voltage_table(hwmgr,
+       if (powerplay_table->usMMDependencyTableOffset) {
+               result =3D get_vega10_mm_dependency_table(hwmgr, powerplay_=
table,
+                                                       &mm_dependency_tabl=
e);
+               if (!result)
+                       result =3D get_mm_clock_voltage_table(hwmgr,
                                &pp_table_info->mm_dep_table,
                                mm_dependency_table);
+       }

-       if (!result && powerplay_table->usPowerTuneTableOffset)
-               result =3D get_tdp_table(hwmgr,
+       if (!result && powerplay_table->usPowerTuneTableOffset) {
+               result =3D get_vega10_power_tune_table(hwmgr, powerplay_tab=
le,
+                                                    &power_tune_table);
+               if (!result)
+                       result =3D get_tdp_table(hwmgr,
                                &pp_table_info->tdp_table,
                                power_tune_table);
+       }

-       if (!result && powerplay_table->usSocclkDependencyTableOffset)
-               result =3D get_socclk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usSocclkDependencyTableOffset) {
+               result =3D get_vega10_clk_dependency_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usSocclkDepend=
encyTableOffset),
+                               &clk_dep_table);
+               if (!result)
+                       result =3D get_socclk_voltage_dependency_table(hwmg=
r,
                                &pp_table_info->vdd_dep_on_socclk,
-                               socclk_dep_table);
+                               (const ATOM_Vega10_SOCCLK_Dependency_Table =
*)
+                               clk_dep_table);
+       }

-       if (!result && powerplay_table->usGfxclkDependencyTableOffset)
-               result =3D get_gfxclk_voltage_dependency_table(hwmgr,
-                               &pp_table_info->vdd_dep_on_sclk,
-                               gfxclk_dep_table);
+       if (!result && powerplay_table->usGfxclkDependencyTableOffset) {
+               result =3D get_vega10_gfxclk_dependency_table(hwmgr,
+                       powerplay_table, &gfxclk_dep_table);
+               if (!result)
+                       result =3D get_gfxclk_voltage_dependency_table(hwmg=
r,
+                                       &pp_table_info->vdd_dep_on_sclk,
+                                       gfxclk_dep_table);
+       }

-       if (!result && powerplay_table->usPixclkDependencyTableOffset)
-               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usPixclkDependencyTableOffset) {
+               result =3D get_vega10_clk_dependency_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usPixclkDepend=
encyTableOffset),
+                               &clk_dep_table);
+               if (!result)
+                       result =3D get_pix_clk_voltage_dependency_table(hwm=
gr,
                                &pp_table_info->vdd_dep_on_pixclk,
                                (const ATOM_Vega10_PIXCLK_Dependency_Table =
*)
-                               pixclk_dep_table);
+                               clk_dep_table);
+       }

-       if (!result && powerplay_table->usPhyClkDependencyTableOffset)
-               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usPhyClkDependencyTableOffset) {
+               result =3D get_vega10_clk_dependency_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usPhyClkDepend=
encyTableOffset),
+                               &clk_dep_table);
+               if (!result)
+                       result =3D get_pix_clk_voltage_dependency_table(hwm=
gr,
                                &pp_table_info->vdd_dep_on_phyclk,
                                (const ATOM_Vega10_PIXCLK_Dependency_Table =
*)
-                               phyclk_dep_table);
+                               clk_dep_table);
+       }

-       if (!result && powerplay_table->usDispClkDependencyTableOffset)
-               result =3D get_pix_clk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usDispClkDependencyTableOffset) {
+               result =3D get_vega10_clk_dependency_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usDispClkDepen=
dencyTableOffset),
+                               &clk_dep_table);
+               if (!result)
+                       result =3D get_pix_clk_voltage_dependency_table(hwm=
gr,
                                &pp_table_info->vdd_dep_on_dispclk,
                                (const ATOM_Vega10_PIXCLK_Dependency_Table =
*)
-                               dispclk_dep_table);
+                               clk_dep_table);
+       }

-       if (!result && powerplay_table->usDcefclkDependencyTableOffset)
-               result =3D get_dcefclk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usDcefclkDependencyTableOffset) {
+               result =3D get_vega10_clk_dependency_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usDcefclkDepen=
dencyTableOffset),
+                               &clk_dep_table);
+               if (!result)
+                       result =3D get_dcefclk_voltage_dependency_table(hwm=
gr,
                                &pp_table_info->vdd_dep_on_dcefclk,
-                               dcefclk_dep_table);
+                               (const ATOM_Vega10_DCEFCLK_Dependency_Table=
 *)
+                               clk_dep_table);
+       }

-       if (!result && powerplay_table->usMclkDependencyTableOffset)
-               result =3D get_mclk_voltage_dependency_table(hwmgr,
+       if (!result && powerplay_table->usMclkDependencyTableOffset) {
+               result =3D get_vega10_mclk_dependency_table(hwmgr, powerpla=
y_table,
+                                                         &mclk_dep_table);
+               if (!result)
+                       result =3D get_mclk_voltage_dependency_table(hwmgr,
                                &pp_table_info->vdd_dep_on_mclk,
                                mclk_dep_table);
+       }

-       if (!result && powerplay_table->usPCIETableOffset)
-               result =3D get_pcie_table(hwmgr,
+       if (!result && powerplay_table->usPCIETableOffset) {
+               result =3D get_vega10_pcie_table(hwmgr, powerplay_table,
+                                              &pcie_table);
+               if (!result)
+                       result =3D get_pcie_table(hwmgr,
                                &pp_table_info->pcie_table,
                                pcie_table);
+       }

-       if (!result && powerplay_table->usHardLimitTableOffset)
-               result =3D get_hard_limits(hwmgr,
+       if (!result && powerplay_table->usHardLimitTableOffset) {
+               result =3D get_vega10_hard_limit_table(hwmgr, powerplay_tab=
le,
+                                                    &hard_limits);
+               if (!result)
+                       result =3D get_hard_limits(hwmgr,
                                &pp_table_info->max_clock_voltage_on_dc,
                                hard_limits);
+       }

        hwmgr->dyn_state.max_clock_voltage_on_dc.sclk =3D
                        pp_table_info->max_clock_voltage_on_dc.sclk;
@@ -1140,30 +1485,39 @@ static int init_dpm_2_parameters(
        }

        if (powerplay_table->usVddcLookupTableOffset) {
-               const ATOM_Vega10_Voltage_Lookup_Table *vddc_table =3D
-                               (ATOM_Vega10_Voltage_Lookup_Table *)
-                               (((unsigned long)powerplay_table) +
-                               le16_to_cpu(powerplay_table->usVddcLookupTa=
bleOffset));
-               result =3D get_vddc_lookup_table(hwmgr,
-                               &pp_table_info->vddc_lookup_table, vddc_tab=
le, 8);
+               const ATOM_Vega10_Voltage_Lookup_Table *vddc_table;
+
+               result =3D get_vega10_voltage_lookup_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usVddcLookupTa=
bleOffset),
+                               8, &vddc_table);
+               if (!result)
+                       result =3D get_vddc_lookup_table(hwmgr,
+                                       &pp_table_info->vddc_lookup_table,
+                                       vddc_table, 8);
        }

-       if (powerplay_table->usVddmemLookupTableOffset) {
-               const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table =3D
-                               (ATOM_Vega10_Voltage_Lookup_Table *)
-                               (((unsigned long)powerplay_table) +
-                               le16_to_cpu(powerplay_table->usVddmemLookup=
TableOffset));
-               result =3D get_vddc_lookup_table(hwmgr,
-                               &pp_table_info->vddmem_lookup_table, vdd_me=
m_table, 4);
+       if (!result && powerplay_table->usVddmemLookupTableOffset) {
+               const ATOM_Vega10_Voltage_Lookup_Table *vdd_mem_table;
+
+               result =3D get_vega10_voltage_lookup_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usVddmemLookup=
TableOffset),
+                               4, &vdd_mem_table);
+               if (!result)
+                       result =3D get_vddc_lookup_table(hwmgr,
+                                       &pp_table_info->vddmem_lookup_table=
,
+                                       vdd_mem_table, 4);
        }

-       if (powerplay_table->usVddciLookupTableOffset) {
-               const ATOM_Vega10_Voltage_Lookup_Table *vddci_table =3D
-                               (ATOM_Vega10_Voltage_Lookup_Table *)
-                               (((unsigned long)powerplay_table) +
-                               le16_to_cpu(powerplay_table->usVddciLookupT=
ableOffset));
-               result =3D get_vddc_lookup_table(hwmgr,
-                               &pp_table_info->vddci_lookup_table, vddci_t=
able, 4);
+       if (!result && powerplay_table->usVddciLookupTableOffset) {
+               const ATOM_Vega10_Voltage_Lookup_Table *vddci_table;
+
+               result =3D get_vega10_voltage_lookup_table(hwmgr, powerplay=
_table,
+                               le16_to_cpu(powerplay_table->usVddciLookupT=
ableOffset),
+                               4, &vddci_table);
+               if (!result)
+                       result =3D get_vddc_lookup_table(hwmgr,
+                                       &pp_table_info->vddci_lookup_table,
+                                       vddci_table, 4);
        }

        return result;
--
2.47.3

