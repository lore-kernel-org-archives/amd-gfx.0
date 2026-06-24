Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0311BCDB475
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 04:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919BA10E027;
	Wed, 24 Jun 2026 04:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ii4jAYCN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6B610E027
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 04:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiUigkvvmUKuCAd/WjeCgIAVQ6ak+63ciqM88xxzb6PQKodiuY3fSpaEe26osiM5nRZusg2tY3t1wzBFgNnxyc9o/wPsrNA3GpvWtjRSvlXDoh8vd/OYU1a+jc3oSFIcSgbWkRdqvL5ch+lDCMKjS4XQQi1up/PZ3KFY4JZOUPnRas5MvQweTdHCr98wNLXyixV+2OSrFsiKGuyvJHovm3wiVSA50gOgdmJmjKk51Uolha91Qwtm/+JinF8agwVRE68OA63Osyz4GBRIOUQjE7rXsOWwvQagi1gyEjnOwQQ+evY8zr1NfXTeHs844wajbhTQfo8W7Uk+opJsiBQMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eczCswyh5xUmwa3YihnCqhHMmsoQAV2u7usgsccgAg=;
 b=E3EJm1noUjvWXanwb4r2miu4IBbvu5FATGzGXofoJINnNM1R6WyyTDdB7ZfhvQIse9Rolq4B7QBV/lYNApOVlDt3XQ3G6gVKXRGqRxn21Pfz94fJqqtJdN5Ce9WWPvE3vdn84g9T9c9Zir5rejiofp06/p0OscMmtplwSkoEaq1E1XL3gALUPAZef6+fbC2ju9MTDQnDmsi1HDnJ0MFGITXB6SJQsPocPJWwVmMWh4nfDpMEDN5Iy49+YyisqGAI+zrCObenuiCHY4qSID1PpRvlSm1WAQOuGrkf4QUc/XtBxtBnuyf0l/hJr4Ehgw6E0K+2DZq5ivM/zIMMEDSngA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eczCswyh5xUmwa3YihnCqhHMmsoQAV2u7usgsccgAg=;
 b=ii4jAYCN5Dw06OAX7NwcrxlklCpn4J3ChXskKcaqM12AeqJIftTxh2SRHiTvJp/OREvWnHu3NOCfNO+OcFomNWfnsjF2WuYmOjsrlnGQs+bgSBMEup5B7HpILA2J7HJB2pWOtKj6tuuLopJqaP0KrB1/p4pUXGWgt58UqGxla10=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 04:11:10 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 04:11:10 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH v2 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds
Thread-Topic: [PATCH v2 1/3] drm/amd/pm: Validate Vega10 PPTable subtable
 bounds
Thread-Index: AQHdAxchxY/LTkTx8kiFtiCs2eaVQbZNF4ng
Date: Wed, 24 Jun 2026 04:11:10 +0000
Message-ID: <MW4PR12MB6803E2CBBAF88B950011578D8EED2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260623134917.443011-1-kevinyang.wang@amd.com>
In-Reply-To: <20260623134917.443011-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T04:06:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|IA1PR12MB6043:EE_
x-ms-office365-filtering-correlation-id: eb818f4e-affc-430b-98f5-08ded1a69fbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|3023799007|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: K13UvMcz+UkB8aNLNlneSqoDEK4D4dNzrHEwSym+UWUKwjE7cdLW17DWObjeu3fVjFAmb9GVtggkLkYtFqB3iVSKoz8CRT/R9Hd8km35xBDa9VR1mtNexWlFJVNlDT8R1953r3EVuCNf+oacevrRP6WB+88iYyPVRepDI3WzSiOpQYMUyAScmkMrlI6JWViNTTX27nT2l2JF5D0Etn4nmjQ3wu6sNEEI2ZPWCqKmfyz8b7wS00RLKPVZfselzYe07zoOnrkMOyem3quHnC+Vwk74ClZUln2AQt3fLQv3Ab36ZS93lqNdFBT5DHx6heqd/HAAWbNkD9M9HVyS3jRbfwkQyuD8BD4LK5hXD8+KOVdHSZn6ir5ezE3JYu4dZGWOPhxB41WlBJcBtvgmledWGB1rx56sasGVhdDsj1jdqX8htuOVuZo3AaU6o9ivAZqAvULTKSNYvoqRZ5wghLGEKHTF0nbBWfCqofmTgAjPZxDASy1LGr8wm/mcmQd3oPZHyfKtEtKAyP4wLz2yHBEXjYvfih5v4gXSQMU6d/+owfm3OTWiH52xkurUznF31ilNeo8OdBPd9liYha2QD9xa0CWSfVxkzF7Z0/3BxQfaWzEEx96kr8GgTSpdaIypRSPSuvjwtwVHJOJgDz0ndOEwWtLl5DDHoSd3XOMBSAKvJ0EBnfFcjhZGxgjtF7Vx+IxdwGE3q5Ywa6NJ/zw19eKDtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(3023799007)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZOA16H/1mBr3cixmKytVaJxINWv8VV4CSHxHvbBowkkSi00rlmHO5vVuRmtl?=
 =?us-ascii?Q?0rlEk+oX33SRiT+ErnPui4ROfeUZH1MFa8PLWIJHr2mZqansXvWD8crX/Qku?=
 =?us-ascii?Q?4zpvl6e15LngDr3gt2wjFtOTRsMVgxSFuCTWD3+CVnS7OdXh894VCAoE9T9y?=
 =?us-ascii?Q?chJKkFHe94xuet0sKb0a+ogeoj0VjlkRNnNfIw43hYFcOIQIFKwuf5WayK/b?=
 =?us-ascii?Q?rFV1poDlGbkP4Kj0rQztP9MN5+AAvLif7ug+zAoru6VC/D7XI8l9MbgSzZAP?=
 =?us-ascii?Q?LB4NMAaLYlZMvS1THsCigjP7cKaRdCqZRZfXrqoi/EmTCqPmwYZ3lpMGZ1Mg?=
 =?us-ascii?Q?8ItYvL/NCkkTRQF8HYynnNsWgDSjaOc5x5g4OXHi6lwpqTwTBhoZuEMepPO+?=
 =?us-ascii?Q?TvC2RANSh9cjMI4uOE2CemAIIKNpu0k6+LR/W7hHb1NVzG3QjoyXd6K4U8l3?=
 =?us-ascii?Q?t/oJz5squyRXnvaHUrGwhpAC3WhcU28AdZzObaWMw/GTWR5JA2KFiQw8NYyt?=
 =?us-ascii?Q?2wKrqOfEMljI8rp6YKc9SddXIdxJLbuU7VRPi/rnCx0+AlznLltPXpG1MZkU?=
 =?us-ascii?Q?QS2k5Mv/fYI7gTbDB4dx8kyP0AUoPeWTfZOs1EPKdk+w0QH+yYLfVm9VgaVC?=
 =?us-ascii?Q?ixTOqKoRUIGBrU0kc40FoqaPv45scNS4JC0JK3oy2HXIcYSf9U5wR7zn7BL4?=
 =?us-ascii?Q?ifoZlEXAny6Ei1bDy2HYcdELKhCkOECEmXJ8gqA+NrHQLafz/QfgckeWhJRh?=
 =?us-ascii?Q?71aideHPgBr/5Uc+ZknwRHnsLP7pTlpXyhxsnoESu9oEvTPkjAesUAENKg71?=
 =?us-ascii?Q?T88TEQM0VhWHhZk1nFjhARlC5jkSiqgV0IT7vFRUmF8IxQLZQAdRKGewiWQm?=
 =?us-ascii?Q?d/a9gFYJdxQIzWGCRJwlax2n1Q8zO0bFShWg7+KEshxxvGBl8klKeAdnM+YJ?=
 =?us-ascii?Q?mHP2UCxSYfCTkpTxAR7tLWOBIU9Ph6PBiTzhpzumRUYEIpFJW/WXxeV85B2w?=
 =?us-ascii?Q?xZc9pSNsUKB7WaVqs0N6IUVQHJdmlcLWqpl8Yd7rtmIAgaxWAUic4+mGUtrr?=
 =?us-ascii?Q?PSLjuZuOQtF9wurFyeY5SGQhYJVTb9mvFkrcyw7ySG9jc9pq8gyfC6kMqaA2?=
 =?us-ascii?Q?VTg41zu+/0hjwz/zYj1jdhmOEQbjgNWPYD3vxW+wQggBjJS0sTGNC7cpkRaH?=
 =?us-ascii?Q?qXadFYeWSMYzJjWpRJh2A1qYwDP7V1dhT4udrV+Nlkz72Yn0hBG27Uk1vI0J?=
 =?us-ascii?Q?rNFLZbRn381YLBkHAkmbuGXuRaYnKvjPSAS2p1Wu8k7Hn2ZCFbQp9ipU0LRj?=
 =?us-ascii?Q?vkDuhrF5I9P1ZTxuvdgA4L+ES9TezrjipAiJpt0iVRcQBuq1152YvB4PjCil?=
 =?us-ascii?Q?uIRyj5IKsDegvAFRYwCoCWrQb3Wvv6BNM3cKDuHxGeCgdENH/Qupbo8WxjCe?=
 =?us-ascii?Q?U6PG7iUGyBapDfgEdgqcztiXuLgDaVW2N6RSNdDmB0Xm7ZCcRqbPuQmtjGFg?=
 =?us-ascii?Q?xG/jPL/sKBLIUXHcCIXh0YrcZOx8xxUkbgw53zy6vRI/Vt8Mtcb2CM9ZP7N6?=
 =?us-ascii?Q?NYW/iMDdJN+KAmfn3D62luOLzKbVmfMfzuLlcDVShPZJn1QFOxL6zfrgUSSI?=
 =?us-ascii?Q?rG/KKf0GUAFaufwvRjtaL1b6ajBD3eUYeBevZCeCOSKUV7Gy5XJfsxPjTVcq?=
 =?us-ascii?Q?6tlCKKeAjG368U+VMlmAL/H6KK1LahSPphmA+r/xvb1A64/U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb818f4e-affc-430b-98f5-08ded1a69fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 04:11:10.6575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMLMJ8iS2bVpEU6cD5MSskJ/CRShGXsDdQXCo6JHBFhVW9QYlPG1t0i4Q91GqhV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, June 23, 2026 9:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Kamal, Asad <Asad.Ka=
mal@amd.com>
Subject: [PATCH v2 1/3] drm/amd/pm: Validate Vega10 PPTable subtable bounds

v1:
Vega10 PPTable parsing uses VBIOS-provided offsets, revision fields and ent=
ry counts to locate subtables. Malformed data can otherwise drive out-of-bo=
unds reads from soft_pp_table_size, and voltage lookup tables can overrun t=
heir fixed-size destination arrays.

Add shared bounds helpers and validate fixed-size subtables, dynamic entry =
arrays and revision-specific layouts before consuming thermal, fan, power-t=
une, clock dependency, PCIE, hard-limit and voltage lookup data.

v2:
if ucRevId is not matched, fallback to default table size instead of return=
ing -EINVAL.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 564 ++++++++++++++----
 1 file changed, 459 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.=
c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_processpptables.c
index 64cff9f4850a..63fa6b937d9e 100644
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
+               table_size =3D sizeof(*header);
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

