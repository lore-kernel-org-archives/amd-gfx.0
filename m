Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F105DCD6E4A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 12:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B7F10EFFE;
	Tue,  2 Jun 2026 12:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k9IimOFm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E75E10EFFE
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 12:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJFiG5kJoW15Vzf4gaTMPJF8nkIBGMe/tF58wTtkeJ9xX18EGxpQSi8RRVO0NXx1ixi5Fp/MTgpChAeD0VIV+y6t+TwyisHz6QHFBbpnkISfM24H8CRh3z8wG1KjkmekZGRphGRic4bA8AeVDYYffGcNjydjzAeVHEvzs4Dstn0yguV3ahb95yhUOKMV2V+Zn4ZLZmRJuug+FfMkKP2ZQTKiEteOI3iDZMcOHmKzB+beqUZYPiIeIRz04URLj/fUiOG8zXk3XEh+eGK5HV5MlRIy7MzTGeU1jA4xwlIHd591U3EOGEGpEohaw2dgDVwzKaJXetEQIpbKNC+C7Du43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJDuzrp6Q+D7DaO2Xt1tlYpBpyeayjV/j04gQocBehk=;
 b=dT7KSGkWe5BlZDJwkOMl6BhSorApyPcciIChn3EUs4pwBx90X98BLe5IrDy7bbaB1aSGFCUwHYw+zkadncTmA4KG/o0U37UbvHnngtRNzLo+0W3aiUR9UcF71W8m8/fI6V5m6qnlm56mEWTZnxJHHXtJjC94B8Z+unD/nSyeMRjD1+XM4UCa+SFOO3WlNbdM9fMXAm2qjlBReLXzSHr7UM6Pfsepobl2V/5Cnm04Al7cq3S/8JUTEVqY2PCGIVwVQrq7ofh4de3Y8PNLhbNAQq7Q7Xq8uwt/dCsm/RsPv2drxKuynjJ6A4BPGrIzI3LfsFg7L64/xq9nIUkuZMZ6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJDuzrp6Q+D7DaO2Xt1tlYpBpyeayjV/j04gQocBehk=;
 b=k9IimOFmArCPG1Dh9xIqDiWw/RuqtxoprYAgzRaUT9RePm4zEf8WrzLZOhrIjRIhCNpemR3E7KElsIg5IlL51Mm8hCIjyhfKiIPXYosrYfud1dv+nMV8Wul69j2GG+BO3XjWZJyyk12wib5272P4jwrCYBQ+JC7QtY6VZlVkLrU=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:02:02 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 12:02:02 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Validate OD DPM triples before mutating tables
Thread-Topic: [PATCH] drm/amd/pm: Validate OD DPM triples before mutating
 tables
Thread-Index: AQHc7zLVdmuoCqMoUEm+wADCwGxc6bYrMMqA
Date: Tue, 2 Jun 2026 12:02:02 +0000
Message-ID: <DM4PR12MB5038BB338161C3B205AA5B678E122@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260529061710.356706-1-asad.kamal@amd.com>
In-Reply-To: <20260529061710.356706-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T12:01:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|PH7PR12MB7305:EE_
x-ms-office365-filtering-correlation-id: c9bd00ac-83d4-49eb-bfc8-08dec09ec1ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 4L5yttZE2inINi/pC6u00tfCR/DRqV4cRcPb/9UYN3ZQWVOoKgo7bNIqsuVm47kaqDVoya0ci6xNjpOpkc693MJHNvYBSUOAhP/0+HNyXgNkxyVHq+MTJoRVUCoyQ/jr3lev2CCTqxMRDmqMvtn6BvPGgd1DIf0hjVsRTLotrQ0ymDS29i5J4LTdeEbM0hQjhx1LEhpD7rNXweHMAudeL4gZbgYKOWbkJpL2ADrkaY6r9RcMCugU994g+HRWOP4Tz4aER+o9jIb6i0i/KxIVxtMmQVgaySEUJAzXpclN2InOPAiXSFqrTurNMqM28ttxBqxzcEyPFMqTXRLIlxoknxNcLb80UrZh3rnnvaguG3pu/mTotOTE6oe3OyI62W6BU505T6nEHAApQN3c1+ahr/s1oHrrr2NMHQHvi0sRb1Ylu0jxZxXGXQfo8TtCkkO7DUo01hFfr5F4kEPnAgqF9ZzgZRDYZkpMGaRDiR1Ok22FtBFx1KhapI/WlXCyMkjOZLVnnyq0p5L5cFSKOeCFXM/8USB2UjebnN2yom9WoereW+05FasO6RhDrGCuTwDhu/IMGa6jbgf4feijV1gSD0f1OqgIiFtIorKjM2XLtkfIWD+YvmjicUfusBoW0hgzRzrmaZNWs2mqMy1GXiwjRnFjNBjytfpKq6kLNs70RUn+31SglWNAk3paPU04C8V6X7Lmw2V9NG5ZGZhcK6XudTYniMdjDXiuMr5HbAqy+u9URkyYfrUnHo7P/W9C6d3a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qH0my7ioMl8cX6n4V4lif5ILDs3mTlHeUtsH3rPLA7LyM5C61s2l6XnSCqOz?=
 =?us-ascii?Q?o1RRIoSINYtKhrQdZMcsJXCepisHe8Tm3rTMBqcMeihAfNUucWwme0PoJnGH?=
 =?us-ascii?Q?WbbEn4HeBnkv4oQwpcpKqIR1LnWpEYxISuZQ3esCAAUdoFk+p5XV6GL5whTL?=
 =?us-ascii?Q?cWR+eqNhRdb3ypg9WQNdGL6oKyit/011or6YgYskH/dvVeSubuCNQlyfKA5+?=
 =?us-ascii?Q?1RC38EeXVxmE23Vv0VU3DRp/5H/S3osl9xfI1/MlUnWZ9vYPogRYIn/LqID4?=
 =?us-ascii?Q?s5L4KYw/mMK2aE3l11unFcgexbyOBCg9Qruj4DZhFF7ExANA/5tkkngPg9aZ?=
 =?us-ascii?Q?XrjOq6JbezdFnKgQ1ab5/imI/nQ8ESp5QBjpacUo7hPHRMquGSPzSbLaOkL/?=
 =?us-ascii?Q?MPG0ljqMR+PdPRkMD7BRZa1NMqzlQoNV8kmmTzLNvj/GI+2wvd3r2FsycPCg?=
 =?us-ascii?Q?qdAzhz/cNykjijyVE5P/xqj+O+1xIYdEHZWBClmb+y+UsRK7tDbbqwPbjxeK?=
 =?us-ascii?Q?9SNC7J8OO7LaekYHQ7ICEyVogJzrMAu6MI3rDZek2GFKCka8Ocmlbi3S2Xxq?=
 =?us-ascii?Q?/TotTNeFzSaXXqXU8KY2L6qiHpeQTV5zzXcIuRNx3YsO4SQ9ocoRCN+5vv/g?=
 =?us-ascii?Q?WbyVTkzE+ViIJa20Xvwro83EKSN6uAxxA7zK8zV6sP7HGxZSSeNscJgrDTfg?=
 =?us-ascii?Q?OQG3cHkXmItuUf/iUQmhS7Kf5EZj5t619Xe7AMzbhqtuTbJeT8b9M9ry6HYH?=
 =?us-ascii?Q?BDiDZCx+T3i9GeZf0CVVF1LPCSwZrbQoE/3DQ8zj9+CIFY4+pFIUclNCAvl2?=
 =?us-ascii?Q?qgsHfj7EMPs37N+7de0jkY1Ak/L03Rqo7wVWy0dbJkYhvClua+5BqsqlHQS8?=
 =?us-ascii?Q?IEwmh1CC/tik2DqrFle6JbCTPRNCNmic8gAopkL5e+oEURSzGpPEWsdecMVR?=
 =?us-ascii?Q?Mb5BSWN0v3vQCmmZ000tz0cZ8HvDPNdKUuAHPYmcNnDj8E4LfSt3PdcXXpB0?=
 =?us-ascii?Q?11mrqjG7HUIBVOad1s7Vsl4YtoM3mau97p+r4dg2zs1D5gCnFSjVKHW8MHGp?=
 =?us-ascii?Q?Qo4PYvKLTHVYeRLcoC73xB4qoB8hGi+9Vb6HNU8xI97lXc174lMyvgPcjuRd?=
 =?us-ascii?Q?DzYtDBSqr/a7Jy2E+X/BM1QzRztSDy1fMMNq/4ti8D/HEoLFeKmI5tpcUxDs?=
 =?us-ascii?Q?pYD12Oz1FhgdgZtqc9UYVakcxk9YDd3h5UVaIsMr+9YbTCUTASY3Vm2XSnh+?=
 =?us-ascii?Q?kSCyMyDuGSa+YCJPP5lODqgIw1FQVaGMCIe9r/KQY5h1BpnsGrFMJO1j0QFz?=
 =?us-ascii?Q?L6SGBf1TWYAV0zQYLz4DW/ZpmdvMhtbLQdVPKPN4k6e4tApKuSgG8FCOA75B?=
 =?us-ascii?Q?og4wg20JJIam6jV3T28nd/0sxuDbtx1KGE+rCXYPPTQ1L3miancrl1iTfzWx?=
 =?us-ascii?Q?nCNheTyI5Dx2KjkUiXaERxVeoeLd8OjDf8XhFbbqK3vsUkp+xQblecG7oPBJ?=
 =?us-ascii?Q?V7ixh6JPJF7q1gaV/6y+rTLfO6zsRb6LM0Ucd0ME4v5T9PbXaMZn/zQAl5Pl?=
 =?us-ascii?Q?Uw9WgETxgEMhIit2BZf76JXn3nzskMqcLbyRgUNEkHwI5b2lWowiSdC2bwIQ?=
 =?us-ascii?Q?dkMg4ESriQibwmyUaulE033q0uqebVVVAoyuJRnG6xTS58Z5jltTsRyMcJrs?=
 =?us-ascii?Q?flMKpYjIZzTAeeLKruFa234ZnKRDFkK1Ad8Os4KLkMpEjw3N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bd00ac-83d4-49eb-bfc8-08dec09ec1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:02:02.1670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6IGL4Mv4y8BQiJ1ySScSiSgw3qjOkb9MyOscbOeuAJT3hl92jhuLMdTDUprAbrVK6yJgWHic6iDcrQgmA2WF/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305
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

ping

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, May 29, 2026 11:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com=
>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Validate OD DPM triples before mutating tables

vega10_odn_edit_dpm_table() and smu7_odn_edit_dpm_table() could mutate the =
live ODN table for valid triples, then return 0 after detecting a truncated=
 buffer or out-of-range index. Validate all (index, clock,
voltage) triples first and return -EINVAL on any failure, only then apply u=
pdates.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 33 +++++++++++--------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 27 +++++++++------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/=
gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 416b9380a70e..0a74e4f98496 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5648,23 +5648,30 @@ static int smu7_odn_edit_dpm_table(struct pp_hwmgr =
*hwmgr,
        }

        for (i =3D 0; i < size; i +=3D 3) {
-               if (i + 3 > size || input[i] >=3D podn_dpm_table_in_backend=
->num_of_pl) {
+               if (i + 3 > size) {
                        pr_info("invalid clock voltage input \n");
-                       return 0;
+                       return -EINVAL;
                }
-               input_level =3D input[i];
-               input_clk =3D input[i+1] * 100;
-               input_vol =3D input[i+2];
-
-               if (smu7_check_clk_voltage_valid(hwmgr, type, input_clk, in=
put_vol)) {
-                       podn_dpm_table_in_backend->entries[input_level].clo=
ck =3D input_clk;
-                       podn_vdd_dep_in_backend->entries[input_level].clk =
=3D input_clk;
-                       podn_dpm_table_in_backend->entries[input_level].vdd=
c =3D input_vol;
-                       podn_vdd_dep_in_backend->entries[input_level].vddc =
=3D input_vol;
-                       podn_vdd_dep_in_backend->entries[input_level].vddgf=
x =3D input_vol;
-               } else {
+               if (input[i] >=3D podn_dpm_table_in_backend->num_of_pl) {
+                       pr_info("invalid clock voltage input\n");
                        return -EINVAL;
                }
+               input_level =3D input[i];
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               if (!smu7_check_clk_voltage_valid(hwmgr, type, input_clk, i=
nput_vol))
+                       return -EINVAL;
+       }
+
+       for (i =3D 0; i < size; i +=3D 3) {
+               input_level =3D input[i];
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               podn_dpm_table_in_backend->entries[input_level].clock =3D i=
nput_clk;
+               podn_vdd_dep_in_backend->entries[input_level].clk =3D input=
_clk;
+               podn_dpm_table_in_backend->entries[input_level].vddc =3D in=
put_vol;
+               podn_vdd_dep_in_backend->entries[input_level].vddc =3D inpu=
t_vol;
+               podn_vdd_dep_in_backend->entries[input_level].vddgfx =3D in=
put_vol;
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 8b8c4e899878..ad06a2f26d91 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -5477,21 +5477,28 @@ static int vega10_odn_edit_dpm_table(struct pp_hwmg=
r *hwmgr,
        }

        for (i =3D 0; i < size; i +=3D 3) {
-               if (i + 3 > size || input[i] >=3D podn_vdd_dep_table->count=
) {
+               if (i + 3 > size) {
                        pr_info("invalid clock voltage input\n");
-                       return 0;
+                       return -EINVAL;
                }
                input_level =3D input[i];
-               input_clk =3D input[i+1] * 100;
-               input_vol =3D input[i+2];
-
-               if (vega10_check_clk_voltage_valid(hwmgr, type, input_clk, =
input_vol)) {
-                       dpm_table->dpm_levels[input_level].value =3D input_=
clk;
-                       podn_vdd_dep_table->entries[input_level].clk =3D in=
put_clk;
-                       podn_vdd_dep_table->entries[input_level].vddc =3D i=
nput_vol;
-               } else {
+               if (input_level >=3D podn_vdd_dep_table->count) {
+                       pr_info("invalid clock voltage input\n");
                        return -EINVAL;
                }
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               if (!vega10_check_clk_voltage_valid(hwmgr, type, input_clk,=
 input_vol))
+                       return -EINVAL;
+       }
+
+       for (i =3D 0; i < size; i +=3D 3) {
+               input_level =3D input[i];
+               input_clk =3D input[i + 1] * 100;
+               input_vol =3D input[i + 2];
+               dpm_table->dpm_levels[input_level].value =3D input_clk;
+               podn_vdd_dep_table->entries[input_level].clk =3D input_clk;
+               podn_vdd_dep_table->entries[input_level].vddc =3D input_vol=
;
        }
        vega10_odn_update_soc_table(hwmgr, type);
        return 0;
--
2.46.0

