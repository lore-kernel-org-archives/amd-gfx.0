Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E405BC44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 19:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225B210E215;
	Wed, 15 Jul 2026 19:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XmKMnjdu";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF3810E215
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhwnqha2g2si70WMnxp6HiwBNLo63uVEhgbBEviMhBLE3OcYAxF3vcPu0Hds6n2zKMalPZ8DOLbGmEnGRfTFlf2uaDXRIEQFLhuT8bL55mC49UZUhAprKBcgT0HiwWpdNID5ja9XsyLtweBJwotXELsp9wcFI0GPtQYPE2zbUXoK7lpOMhnfGr0Ni55J2Nj7f2RIhG5jfMOfZpW0KAcV6k4F4FDlzEcqRPzgBe4CtK1U/sX9bYXM39K6pzAhro7oZ/rPHJgMyldOCwH92S4KI9zbCkP2LxZtPkNeysOMupJGYqYqlFeb6JR7+9u6hgkUKeqlCOpLXyiwCsNogqjuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG8sYAlr2cipiq5V2x0EmJ6rtdQfK20ZolEVede87rU=;
 b=TKxhUdUUyGeahKBhqhoeoEJTXdAOwwOKFcNOGJUTZjFWDGa8mm3zufBBJognpsZJG6Vsu3RKyvUH60z07wsB9s3x+KdaSz2yAhUHa/4+Y8nyMEyw0CrVyHmcoX6ECEkUuJiWIO9q2RHtJkIugjDtQ2D+i38eJAaIpQGzHrUd+eek/1yCf8itxmvEvcpWVakljBr4M+hY6bHIODjejCaKJXkgZylMPwJBd7FyAbDomboaCByCGKL02HbOwvgb3hWCcQEACeJvSoE36hSJUf0WwuolKNI8qbQwMgkctxnnXiiihhxCRC4v0iAdGbTKWHmv1p5uga5tnNriNdoe1urZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG8sYAlr2cipiq5V2x0EmJ6rtdQfK20ZolEVede87rU=;
 b=XmKMnjdubIj1nDzcktEh2Uf4iNVzcoqRbAnSgUrlYoxXEKjftgxlNMg1SqezpBXN/3s2VAvCzM1IE6kAXLV/xjaJ1j5Z1sNOJ3/zCftcn+yfSxaNr5SAY5onP7tIi2yJ3II2/whwB7/oIg7GwphPKDF248jOikXz6JXEFcuziRI=
Received: from CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 by CH2PR12MB9495.namprd12.prod.outlook.com (2603:10b6:610:27d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 19:18:43 +0000
Received: from CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f]) by CH2PR12MB4055.namprd12.prod.outlook.com
 ([fe80::910c:508e:4578:4d3f%5]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 19:18:42 +0000
From: "Liu, Alysa" <Alysa.Liu@amd.com>
To: "Palacek, William" <William.Palacek@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length
Thread-Topic: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length
Thread-Index: AQHdFF/Lfu2CPgUZpUO2mFZKisQ1fLZu9K3g
Date: Wed, 15 Jul 2026 19:18:42 +0000
Message-ID: <CH2PR12MB4055F2F1046C6C805042AFA1E5F82@CH2PR12MB4055.namprd12.prod.outlook.com>
References: <20260715134004.163459-1-William.Palacek@amd.com>
In-Reply-To: <20260715134004.163459-1-William.Palacek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-15T19:18:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4055:EE_|CH2PR12MB9495:EE_
x-ms-office365-filtering-correlation-id: 4cbdceb8-21d5-49a9-6bfa-08dee2a5e23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: CLMGmswMLLZk0S1ChgJxqPUm7z/LspKfyblh8RDTXyTkEwi60nStUjMQPYdY/ksOwKJo40k2t4/h0UMXSPZZP1ekb6e5JWuDFQtWX48v/x1T6s1au3VA4v8pJMRPHScZCaW8YPdp/yK/mdzGynajgzukG+sCxtZpgukkloBNNEFymxPwP6pHp/SXj9VugTPUZPzpLvtXfLKbXNfOqtw1U52MUP7cxKcDXUAuVtP4sNyKJBen2kG/P9EcQeZye0AJvsK+7T1SZV/5uxZnx++oRNLkxS9Q7a13R3kej9CEGDU1PSH5zOueuniqv02WUiXWBMxr8H/0pk2IHyKrPvzLeoK1608jMzYZJn+5z8ZvRFiM6ZoLuTY96UAjLcKOygeUcmKxUnY/CIDQifwYfyAs/Uq1103cSGQ1+JGMg4trWQs1LTlIMYgfvo431kFHhwSLsPsEUsbtXiQiOow16vklLjFYDMGcPpUb7WAWgx0P2mi/sFpGAiaoH/DkAP2tpN5Ft1XwIia/OB9Pn6Itv4tks7ChNbDVsj/aujFAY6Kxzw6tk2H6LtMlfmeWVzXEem4UlI41QzOa44w4kKVcmaiRZE8UVNZJ2kiL4G4LOyzFJK///KiO+cMi/7UBk3Wzfe3u5QAJU+4Gbu5J+Ah+5/3TV6CLP3d2X7bYyTTtVnpPh3LRrtkG7NS4QM8suT6XvBYjInytMNJvCZY50HdRjiZvMiYTuGUu2neJqx9jwidhyGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pq1sFGqy0RoGd5gVd88dZX3HhN/Hgv643wUddCV6yzCEpsjfcZvoY/Hva8yf?=
 =?us-ascii?Q?+iWCcgPZOpk4gvOz9GcWJLoO1vPAto3NvZpixwEk2CVtJjLHSMzZIsngEv90?=
 =?us-ascii?Q?hyRZ4zagC5Xth2fKElwcj9QAKStkYTzCjJZN9pSAqGZgmfcy1sOydD5g1Cnw?=
 =?us-ascii?Q?lAsCq8TbGVMHS7oAL55D4xYRX7EcksoaQMslr0IedcApno4zvAxSe/yFlSje?=
 =?us-ascii?Q?J/bX5bMLUCLBFK2rdStR4FU/4A2D0ZTA1PFVLPn6TxXeXH72rSJ64KFO1o8c?=
 =?us-ascii?Q?IjE0ERmSblmPx7EcpppXRTIidVHSdwU59CT7kGClRzSAOMNu8mbORFQwJ1Y/?=
 =?us-ascii?Q?CIaFr8fPepEvr8ZcGtpu8LNW2lJgRf4dmzhdfCXh0eZk5DvorLX6vkVZuJ6r?=
 =?us-ascii?Q?DFLJ4Xk71NXVOTDX3dNJ99XFRDP9epSVx6EcMzgcdvrBtk9UbqHRkfHcAfhd?=
 =?us-ascii?Q?6+JXHuo1/MPrdEe57veiBKSsbYjjG0rbkx6iDB54qjgYIDER8v1ajV2qo/j5?=
 =?us-ascii?Q?Mkx/Gxs1QaLqm2+MG1tWrWsentmNwOd/l7WO3Jg6pfk+TggX6TFWjAqHsSkm?=
 =?us-ascii?Q?qdChTglyZnN5dwX4VBNhzdKq0SHjr6gw3jf8lQDJrms1/vL30cIChc9bT356?=
 =?us-ascii?Q?vJSZ1XwQ76doErgnkI8RpLjarjqRiDlB+xhL+YHZpiEW0nGvn9ASZyKzPfkm?=
 =?us-ascii?Q?YRaJzr0rJJLHot9EXxoMML4SlR27RuNy2GFR/9StSfbY/Xb70PbdO165OcWB?=
 =?us-ascii?Q?6TqSXe0yPuTHlKolPQpDq1puKRbt8izzoEuoqrk3dBuvgpoyB7nGkn9wj4KP?=
 =?us-ascii?Q?kBBlqoH5QotRiXwm2Qb6cXxbbibKrQFHDjv3iLehXgiNqmQK7tW69gy4HBNt?=
 =?us-ascii?Q?fRQinpX+UsHYtkDAUsq49t7Vgo57EkkbCur+Lggc7H2gf7JoGmUdyS+tg9q2?=
 =?us-ascii?Q?LT3CardCm03+jTN32tBURK5Ml7GSlc1cru5TIOxhgKMkvb2+V/PWBMR2cTet?=
 =?us-ascii?Q?Id/of7gdOGmlR1VeYxpu16u8tZRXCIbZCy7qeFzgxApL1aXkOp0Ec1u2CTSO?=
 =?us-ascii?Q?VOe0qHeTVkbi4s6DcMWrPa1UVcnbdOcm92XWNjY3WY40TePW4CICIhcirki1?=
 =?us-ascii?Q?Qg9qzT0deQeyoD3L0MELQS22o/pbPXuZQB4cmlw0LroOkXxyrRGroWBD1+0L?=
 =?us-ascii?Q?WWOVPnz5KCCpG3SljT19eD4yHIPk62mcqy9xyfuakkOTX/neSSWvD1ERuChr?=
 =?us-ascii?Q?BR7Px/tsTTwlHWkxN0x753ESKGuRnIlph2N5vscXRUmX0BSrYepFP+/BXiBB?=
 =?us-ascii?Q?4OBgGxvy8wnHjzJhjL49jbMQOZMYuah9vNG/dmnPZIbNsr27AI2t8QFzgDzt?=
 =?us-ascii?Q?dKk40f7mbVAHiQqWll54lCbuwo5PMuwWdv8oj30s6dfeldR5tUXbUiNdBhML?=
 =?us-ascii?Q?h5VByPTtz1NCQrZbS64o/w/ur+gCE0nuvCZ6lvKo1rhlpuKQnaLTm9tZVzuw?=
 =?us-ascii?Q?W3kbceDO0YsOgCxLjYk2RChVuhykfduzSwTAApaTBSOP6ZlV71npDwXhqt++?=
 =?us-ascii?Q?aOIZDim8aBrQFphPWpHXpai4R4hKnHMIQGlShHQqLh7zvQkGQvOvxOQFJq5T?=
 =?us-ascii?Q?PgFKgQULa/V9d5B0GoP/HjhK2veKvSRzRflD0qyVGVAL2ipXOzd7gSCB8hzc?=
 =?us-ascii?Q?2MT4jVRVkbZaVLsOLopCYM0DpItAJHapmYmXxjOhsJTjSCkR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbdceb8-21d5-49a9-6bfa-08dee2a5e23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 19:18:42.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5bXWC4xj9qLYmygzYud6G6mt1JWZm1S6/Y51fyOmgSei30xUKOs392p5g188yHu2ndBYNKWJBm/1tzjBq28LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9495
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

Reviewed-by: Alysa Liu <Alysa.Liu@amd.com>

-----Original Message-----
From: Palacek, William <William.Palacek@amd.com>
Sent: Wednesday, July 15, 2026 9:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>; Palacek, William <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length

The CRAT parser validates that the subtype header fits within the image, bu=
t does not verify that the advertised subtype length fits. A malformed CRAT=
 table with an oversized length field causes out-of-bounds reads when
kfd_parse_subtype() casts the header to specific subtype structures.

Add validation that sub_type_hdr + length does not exceed the image boundar=
y before parsing the subtype contents.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 2a239f45fc24..6e0df685503d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1412,6 +1412,15 @@ int kfd_parse_crat_table(void *crat_image, struct li=
st_head *device_list,
                        break;
                }

+               /* Validate subtype fits within remaining image */
+               if ((char *)sub_type_hdr + sub_type_hdr->length >
+                   (char *)crat_image + image_len) {
+                       pr_warn("CRAT subtype length %u exceeds image bound=
s\n",
+                               sub_type_hdr->length);
+                       ret =3D -EINVAL;
+                       break;
+               }
+
                if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
                        ret =3D kfd_parse_subtype(sub_type_hdr, device_list=
);
                        if (ret)
--
2.34.1

