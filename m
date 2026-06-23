Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1340CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C6510E93A;
	Tue, 23 Jun 2026 04:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDI2gQjF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1101110E93A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+q9jcIrQNo7sdfeZyHO/2zQZv03a7h1HYfGAYpPGX3oxU6x1vO8YkpzOb1laN5iqFaGMEo9liWzfAlRXik8k3+RhZe2iiKrA0TQ5YjtxQdYcgcqY9y64EswLc2y3u15FHiVZICCAvjCK8DK/jVGiwEBvk7jXhmVkxZtOAc+Kf2/qFyX5Qn/mqOH7XZ+3VMd2qo5n7nphecgarob6n4Th4RbTPESiSd3iGduqvQLaM5Ppxxo43ztSmoOBG1kzdtXZDCvZR4X2EBPsaG7HZsD98NlvWVGP6jXiw14sHXTJ2cHu0wRJyCNJ3Rj2syoJ+gIO2UFYfHxySVKbuGJO4yCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TI34puRN78AIIHJY6obJhJHEjPk/lzm+QsF6oUmGEc=;
 b=YX+xzYTR197xxSbn9dSnpeYBFHKttxwZ+56cRFXgkENys9V9zCXqJlNIH5j9xZ3pfdomXQ+xaOmful5c0tJAfPUeKYSL3utmKciHa3pgx5Vr+IS8iqyGlk/WLFCAJZjUDPAoDe9U3QFFCNyvMKYe57KmWwk6YQxv39fuqxZFf5EmmWJCOlAPaDdpxd/IqcJfG+QJStHjSXuCzvagkZFstmFlfmJXhyopnu+IYdkI5bFl9JYANY3ArV6dbRdTobjM5cIhbBeRidcDBjYV4dIzdpKorWNESAoEzKCUCJNy05bWnGBDnut65M9eeeyPKnmmNIfkL5BKW321U5M3R1Jqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TI34puRN78AIIHJY6obJhJHEjPk/lzm+QsF6oUmGEc=;
 b=NDI2gQjFluq2/tGu+oMi5/VXEn10dI0mCoar4fchICh7k+e6niuBOMEfflVTp5Smvbn0rQ8Yb5FCuKaKz3ZW5b8Bl5R6Ffv1iTWmFprm5xt/1LN2qfzMwpT6TG8CJWlzqRxFj1x/N1ns5e3gBeepy+CBHY9nDeOugkwkxukpaAw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:59:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 04:59:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Guard VBIOS AC timing table walk
Thread-Topic: [PATCH] drm/amd/pm: Guard VBIOS AC timing table walk
Thread-Index: AQHdAsh25QsYooaLVkqDu7RjUwmSm7ZLlGSw
Date: Tue, 23 Jun 2026 04:59:10 +0000
Message-ID: <BN9PR12MB5257FB21EB64009380FBE8D6FCEE2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260623042601.562748-1-xiang.liu@amd.com>
In-Reply-To: <20260623042601.562748-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T04:58:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4354:EE_
x-ms-office365-filtering-correlation-id: 5d17f8aa-39e6-4c11-57c5-08ded0e42996
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: n5TCXzi1+4Uf8XghBm0Cp3Ygmpnf1DAuiYEMRvrRJiI2J3rgd8HXdoa46T5mottYH5J361ZVDYa7Forvq50o8apy9TwVUzCBKSjCU3WzmCVHkrkMcZdhI0LjNSloHcd8jI96E9ioMp2atdDTSb0qs6EV0X1RoJwqistNHvjluvUpW9KNTURbpU6DezzfLW5nEOXLSfOenvpqpTSFPfZkQCgshVnhk3kmC++Er90M96pe+kr6ljE2nz1VLOaXszP71/8T75T8qHRjLfUJUokyF4+PTvxkbIWmlEL8Tq1eSP2OFwhdE9B6blr/aa3EAZ/C+PQU6ilMFAtlRVQzw34KgwhjlMWcl5BW89oYd/crzX0EaKZu/ZDWm1OaeUYGoM+GMV5gQNg/9SGXg59GJM+1OfhZ7oyhq+cKMN0CoerXvyTNz1Dk9zxxRv6erOvg0OmUO43y7zFJ4oxer7FP5T8h2TVsmfr7B5S/Os5xpjG93o9BIr32eL+kYJrcAl0YGj6JIJx0Y0R0VnBxK5yyPDZR2go502gC+SsdL1u6b1owMxnaIty0Bm17cK9awdP8ccNCRrPAKwqwLpXCQNxcVJt/fD1XU9b54RX/k1b7eybVtKGQj+hUwMzrkCuq6NbJRCd7Kd+w1isAVX1gH7LUjNG9BKaYCYyS0Z9dmIf9ksqn0+JlcsGACUdE2gr8k55AH2lxmD/NSHMn0kwDq2t5QEE5/QwxRXBygdO78bCeBtdXn6Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/1XGwfb72RS0+qWOMAx8SA+2aEDemzs+OH6KZWV7A5WnhYTEbInqcgGgq7lz?=
 =?us-ascii?Q?P4MAMZOlkCGcCzrOHqRWbDmsG0rXK/j9+Qbf71QEHtIKVQtY7HgncwLxc6o5?=
 =?us-ascii?Q?DizjThXmjpJwx3pSglkxnnR2VJBY0w+nPeKb7Tufi0AmFAz+lk4gItLdr3YA?=
 =?us-ascii?Q?Vg2vj8ApK2tPfR1NDk+Wye9L5pgTiqJv6mwmDFFNsLoNQ/mWfWpqJ1wG6kff?=
 =?us-ascii?Q?q5kkG8lg2R3U8/XJ2bXzglYv7gZTv/jDfCvXYC/Wx65pvxVVsB/Y3jNE9Km1?=
 =?us-ascii?Q?xuEPrVnB8lTlt2SqaFToEafKROU9aCP0HLQVp0Uf/1oK99/GQMPEVpYDgRI/?=
 =?us-ascii?Q?Ab+oxNpEAJs29wDQwNjoipC0W0NJUPNCFwd1mJMPqPJzV4ElI2cm0MWt5ZyQ?=
 =?us-ascii?Q?p6xHa8nL1R4XjndvfRNlRgm6jAtsHGB8Nxyez/PyXW5IxziQz7eBM8JMsldc?=
 =?us-ascii?Q?ZWEzv+nZDqF+jTolC/73MHg9vhb/Sf1A5uORq+gki9VZKLJcnzpI55yVq5ut?=
 =?us-ascii?Q?1A+gF1CA8PIPgsGJQS1D7krQm6oa4ASEkL+jpZfpmHyFhEROJ6rrrPF9oM94?=
 =?us-ascii?Q?zIqfj+h9W0tQTAXvjyNKBLnW3I8Hka2Nfqdct+12p0luP9MJWQaq16lfH0t2?=
 =?us-ascii?Q?XyG23/OfZxq2IbeHc3znHrU755aG9dOSSTc86L4a01Dlidl5NgMESTIxN+8q?=
 =?us-ascii?Q?dINDcndGF4u2pLRbXXAkFbSVZdOA3heCxxMeqpPYpvQ4WPK4ISQqybzBH6bA?=
 =?us-ascii?Q?vjB9kZwQe4gvk5BQVbounFcMXi7TYwoGj5EZ0Q6YMnQuDa4/zhuzl4TrA2Lp?=
 =?us-ascii?Q?k6+J/HgER40J1o+FMCNlYIIfzZhXp9IEobRSYXCEnWJ7CoKakNzgiUZwjOXj?=
 =?us-ascii?Q?W2BkCD0G3Mskdcdh055v4gHVAVjjAsBxhmEGVGUTV9dujn5CbVu8dUT0TRWR?=
 =?us-ascii?Q?CXYu0rR8ppHQeQfrNS9/6rr3FkbpNxx4KPosxoPa58LpvIMYIRWbiqlRgPvB?=
 =?us-ascii?Q?pNBBAVM1RGdcuO1P5RzD7xB34RAWNHBc4fgy190NjXASocbGvZWQOh0hXNVW?=
 =?us-ascii?Q?JSHcB/CBmp5WdAjnoDpPcRTOYWv8wa+HNbeXy0oFkJeFTDq5Pkfe4tuYyDZj?=
 =?us-ascii?Q?JQEtS+z/cq64zJrJzh5hXBJpBmOuFJ4AinxM84NivhfNX1+i4B3qrQWrExGO?=
 =?us-ascii?Q?dGa8okU5QXGtHwU/rgxwQ6NjCzGXV9WaQ2VRSpYLHODUPfX626ipui7aSMof?=
 =?us-ascii?Q?40rE4TFTnEKG1PPc3ilZmPY16dgHLBsWsep5hlgnQUtBNr/1J8T8/yn1d53S?=
 =?us-ascii?Q?GMxWnSo8pbPduyc+MQBCwdUpRydZP8p1u2QaiZlaIVFxiCvGoAEN0og3wZDZ?=
 =?us-ascii?Q?5gMSRjiYiRjNWq1rXLafRxAdzkylco/cxnxruVi+Jr7KiJMrWwuBtHJXF/XN?=
 =?us-ascii?Q?WS3pGoe8/swyBCMdmBK3kahkg6zRtZBFQBtOczQbDwo510v296E8hkl5N4j7?=
 =?us-ascii?Q?dA/gStU8zZfNrvhyMqV0sxUDKbrriXZsqxtd4ejnWj3YIQj4AL39OFYoEazG?=
 =?us-ascii?Q?JqE7zQuQRmMGRwxol5OL8U+0M3doxrgK8FGps5PFiToeIlL1beD0Z392joiZ?=
 =?us-ascii?Q?+rWaLWiiUDPzY2LxwxqvtMncWdrlcC9fZ/zFllKyBSFRVx0WW5B0zxCbTQ9Q?=
 =?us-ascii?Q?TYdIQ2l+EWRDveUWDCgVU0dMxn1QYOySOD1Te/WTuRuTKCa7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17f8aa-39e6-4c11-57c5-08ded0e42996
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 04:59:10.1646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8PRs3mC+UNBXcaCnMyAfVI0x91HcXog6WMtWZ4INk6122XtNT9q46Ruts6MOArrJFswC4w1bnEnEwGcW8czdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, June 23, 2026 12:26
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/pm: Guard VBIOS AC timing table walk

Reject AC timing blocks with a stride smaller than a dword before walking V=
BIOS data. A zero stride can otherwise keep reg_data pinned on a nonmatchin=
g MEM_ID forever.

Also bound the data-block and END marker reads by the returned VRAM_Info ta=
ble size so malformed index/data sizes do not push the timing walk past the=
 table.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index ce166a7f8e420..85bf1527c6f44 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -46,16 +46,22 @@ union voltage_object_info {  static int atomctrl_retrie=
ve_ac_timing(
                uint8_t index,
                ATOM_INIT_REG_BLOCK *reg_block,
+               u8 *table_end,
                pp_atomctrl_mc_reg_table *table)
 {
        uint32_t i, j;
+       u16 stride =3D le16_to_cpu(reg_block->usRegDataBlkSize);
        uint8_t tmem_id;
        ATOM_MEMORY_SETTING_DATA_BLOCK *reg_data =3D (ATOM_MEMORY_SETTING_D=
ATA_BLOCK *)
                ((uint8_t *)reg_block + (2 * sizeof(uint16_t)) + le16_to_cp=
u(reg_block->usRegIndexTblSize));

        uint8_t num_ranges =3D 0;

-       while (*(uint32_t *)reg_data !=3D END_OF_REG_DATA_BLOCK &&
+       if (stride < sizeof(uint32_t))
+               return -EINVAL;
+
+       while ((uint8_t *)reg_data + sizeof(uint32_t) <=3D table_end &&
+              *(uint32_t *)reg_data !=3D END_OF_REG_DATA_BLOCK &&
                        num_ranges < VBIOS_MAX_AC_TIMING_ENTRIES) {
                tmem_id =3D (uint8_t)((*(uint32_t *)reg_data & MEM_ID_MASK)=
 >> MEM_ID_SHIFT);

@@ -67,6 +73,10 @@ static int atomctrl_retrieve_ac_timing(
                        for (i =3D 0, j =3D 1; i < table->last; i++) {
                                if ((table->mc_reg_address[i].uc_pre_reg_da=
ta &
                                                        LOW_NIBBLE_MASK) =
=3D=3D DATA_FROM_TABLE) {
+                                       if ((uint8_t *)reg_data +
+                                           (j + 1) * sizeof(uint32_t) > ta=
ble_end)
+                                               return -EINVAL;
+
                                        table->mc_reg_table_entry[num_range=
s].mc_data[i] =3D
                                                (uint32_t)*((uint32_t *)reg=
_data + j);
                                        j++;
@@ -81,11 +91,13 @@ static int atomctrl_retrieve_ac_timing(
                }

                reg_data =3D (ATOM_MEMORY_SETTING_DATA_BLOCK *)
-                       ((uint8_t *)reg_data + le16_to_cpu(reg_block->usReg=
DataBlkSize)) ;
+                       ((uint8_t *)reg_data + stride);
        }

-       PP_ASSERT_WITH_CODE((*(uint32_t *)reg_data =3D=3D END_OF_REG_DATA_B=
LOCK),
-                       "Invalid VramInfo table.", return -1);
+       if ((uint8_t *)reg_data + sizeof(uint32_t) > table_end ||
+           *(uint32_t *)reg_data !=3D END_OF_REG_DATA_BLOCK)
+               return -EINVAL;
+
        table->num_entries =3D num_ranges;

        return 0;
@@ -136,6 +148,7 @@ int atomctrl_initialize_mc_reg_table(  {
        ATOM_VRAM_INFO_HEADER_V2_1 *vram_info;
        ATOM_INIT_REG_BLOCK *reg_block;
+       u8 *table_end;
        int result =3D 0;
        u8 frev, crev;
        u16 size;
@@ -157,6 +170,7 @@ int atomctrl_initialize_mc_reg_table(
        }

        if (0 =3D=3D result) {
+               table_end =3D (uint8_t *)vram_info + size;
                reg_block =3D (ATOM_INIT_REG_BLOCK *)
                        ((uint8_t *)vram_info + le16_to_cpu(vram_info->usMe=
mClkPatchTblOffset));
                result =3D atomctrl_set_mc_reg_address_table(reg_block, tab=
le); @@ -164,7 +178,7 @@ int atomctrl_initialize_mc_reg_table(

        if (0 =3D=3D result) {
                result =3D atomctrl_retrieve_ac_timing(module_index,
-                                       reg_block, table);
+                                       reg_block, table_end, table);
        }

        return result;
@@ -177,6 +191,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
 {
        ATOM_VRAM_INFO_HEADER_V2_2 *vram_info;
        ATOM_INIT_REG_BLOCK *reg_block;
+       u8 *table_end;
        int result =3D 0;
        u8 frev, crev;
        u16 size;
@@ -198,6 +213,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(
        }

        if (0 =3D=3D result) {
+               table_end =3D (uint8_t *)vram_info + size;
                reg_block =3D (ATOM_INIT_REG_BLOCK *)
                        ((uint8_t *)vram_info + le16_to_cpu(vram_info->usMe=
mClkPatchTblOffset));
                result =3D atomctrl_set_mc_reg_address_table(reg_block, tab=
le); @@ -205,7 +221,7 @@ int atomctrl_initialize_mc_reg_table_v2_2(

        if (0 =3D=3D result) {
                result =3D atomctrl_retrieve_ac_timing(module_index,
-                                       reg_block, table);
+                                       reg_block, table_end, table);
        }

        return result;
--
2.34.1

