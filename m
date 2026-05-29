Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67CDCD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E85E10FF02;
	Fri, 29 May 2026 13:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyeR5Vum";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ECA10FF02
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHXojn+rTauibNIr/AKqlUR8avAxiQJcm1tPzxzxT8mtSUfxMOj2uN1aWMUqgjLd9oJ1R4PB5nt18s4XIPj8edAs3Dg5VMv/Y1A78/c8LkG/OaZNTK5S2/zJpZ7vwyymusEzxk0a8hnOswFSLOAsZX01GskNUrMwzgGxIcCeNFKfhrLsFnLLMAj2m+GYmiefQx1mMtGGzPy2kkg4bXkKS93LsTxjUhoDE3HDCGcybObNvFZJ2ktZeDhHxl8t5JxSkz5jdO5+XLEYk+Dz+VmQit0V1xHMbMF8HHCZvyJzKE/tCvSRHPKE1SB9IVMIjqmig72XLN6ImM4Pjq+HGxA1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vWOVR3XZdB5uN+OTEzvxX3fjDT3fUtTq6Nt7VuG8sk=;
 b=iN8A9GTTESY1BsgKHSDNyzHkvDl47FkHVoYzuyGWIq94LzwTae+UWnYFUQ9sBtM+B8J8Z0FZ8Cjt4sPE4KCV6qSTMPd+l4A3umyleZkKLwWmKrMMTh6tTqzZQSeMEaySqkr8GiT8YvKJvtcv6q+8if0KaVL0ZNg9NMjdYi0JeEv2c5MEv9V3uxBP971rkU93j6dfl6+iaYjCJtLWhKuMCUxRgpoKtGzRYRhPxRsImKFAV+vh17eSzVNdI/pQviwhwP1NQiYexU4FpCYO1MV4kKu+ULdEiB+/meH20anpaC+m7KR7Ei0CTLJb8vIfcC8WMxp1yncDvqBZdByYgUIsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vWOVR3XZdB5uN+OTEzvxX3fjDT3fUtTq6Nt7VuG8sk=;
 b=qyeR5VumCWRfOkL4UyylnOndwHm1GJ+oa3l460kzL/XvM/s0w9h9hmXXiTMXPMYom29sBapoLHVAwZsGU274akb96tqClSzuvBCT1t4MbpYFtD8hdK7FKoIBwfhTn5/QoKGcuXr3BQYht0KkV29Dk4eoiqegwA9hfuanbhKxTM0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:18:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:18:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH 1/5] drm/amd/pm: Add helper functions to fetch pptable
Thread-Topic: [PATCH 1/5] drm/amd/pm: Add helper functions to fetch pptable
Thread-Index: AQHc709a9tFRcZCeNUW1Lx6UXxy4aLYk/AnA
Date: Fri, 29 May 2026 13:18:43 +0000
Message-ID: <BN9PR12MB52570A46177614E9264B3617FC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260529094119.1134923-1-lijo.lazar@amd.com>
In-Reply-To: <20260529094119.1134923-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T13:16:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5833:EE_
x-ms-office365-filtering-correlation-id: 47d7991d-b593-4ffe-4af2-08debd84ceda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|6133799003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: ckjmN5J2/IGb8AlBENvzUBBv8ZbPvdhXGT/8uA7E2bsNhnmTu0ijV6fwMQ1nF6RgCOvusueKR3vbvbrYsnU7f9/A8n70kv02a8CsVxVdKgGIvnovNuIw9x1aZU3CJHGcqYlcMdE9wKGI0bV3mBz5pibnFbeCGukbZov7v+iaLqei2qmQWPv/jo/VhuD1Dp255NIJKr7PWFyD/5kmeSUT1jTOjeOhkXl3Lil0T+pWFNEvlFN2IxNYuxeX1BYWtq+jPDuooFmOlt6nU14E8ZfXQAv8CBgd2cWX3DBI/1i62HGRDqW0soUkDIKXqJak5Xq0AOLsrEqxWQY57MT8Km4Uk8blWPuacP8zn1e6zn80w2LUrC7iwD3yqExMiYbASwI0Bgzc7n2jJ3m4maxU4JjeCpIdUEEg14OgGNWeqgNIBYvpoPRvNs5tPWD1TS6ABYwjWyliPyeJe6M6k+tIxErFJvfczlYwOoZS/6BA3EjA9ZZ60ATerYfEwwPRQvLqZ/6pP3HPvkeo4PeZy5PkZc63Q5OSM1RQdofxqabkEEoX7aTWAcJ23/3snT1Er7lYfny9HMGNEWox/7CfTut5lD/KmKHZhNzZtxV09bx6dFr+gjwxyukKmlGYOV5qfwUR3VguxNK91ugV00XdAPgoh2fxGRZwuHd1bsoemsw19vqDPZqyykgoK/XgW5hVO7fuzLiC7Y7nLCgnxmCrzmDAeLF/DQSKaQHJhixCKMj7C4BH9OYrzKo2AWzV+XL+Ooqp7WEx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DiH7JTyAFxcSa1i7y3GuTlpazGxVGg7LmWCCC6JdjZm8HCzqQM1kLh3RdAEr?=
 =?us-ascii?Q?DJnGyBAO81xS1CmhkjJiy7VF4ZbeI0F0vuHrLzPMQTR4V15OzmweMCg04jjr?=
 =?us-ascii?Q?Mim4rq2o1b+EdnOHZwzZjd6xSTUYl0eMKG8yv0jXMFTUAgRxE+QXRJZd6gqO?=
 =?us-ascii?Q?ikMOUp2/9+U9R0t2DNtw55MySK5InOLfhzCZQnpf8HTA7DU4O2TV7h3Otxl3?=
 =?us-ascii?Q?3fVKSWDeYNAGcU7NWTGEuipa0ZxxNBJ6iZ8apcuffosW+EQYLO4aYukQcEeF?=
 =?us-ascii?Q?KbGxrUEH8xkmdtgalaMoNTdosABCw3OL1tcxUViNH3LVHiEGXuYCa/wapiUr?=
 =?us-ascii?Q?0fPyV0ThE27lvoOJ6fXlr/Dl2UPoohAFG18lVTIqO6Eg0Cm8haSbYob0mgP1?=
 =?us-ascii?Q?MBJXYHe1pf19cWmrQ0wy20uT7CKKNnylHbpJMT0jQSbQeDMedup3XGHxzAXG?=
 =?us-ascii?Q?N7CPm42wWZZbTyU5avdGWk7DDLim5jhQHgFcLEqxCsHvyS8ug0MeHKnxNksS?=
 =?us-ascii?Q?Z5z8l+9NTvs+ktJgXAXB69EgXb+OJOVp1GgUN/SzcW1fRCNbOPXFFk2iy5um?=
 =?us-ascii?Q?HTos5N08HMHg9PIYDztlxuGvVFFg48JZFVfqkASmKNo0nedckSweB/iZz0rm?=
 =?us-ascii?Q?rIRbhtwZp9WwQgXVKG6GyqfUyKLh8yeW5Tgou9xmQonbhLVmkvpTl4KMd7V2?=
 =?us-ascii?Q?QBU+Xag1iKdU4wyDb0bEiJqf/aGlO4K1pB+ivJkF1+c47JJ7JU5VTBSVTCkZ?=
 =?us-ascii?Q?D5O2e3Q2xO5HK+vYPWj8SVwH/TbHP256HR9euFVnRPQSMq3FrLlvXInuWp79?=
 =?us-ascii?Q?JLUtT/hYBB2wq0OeJ00xlto5n2P7oCQKlhb8bYcQK/z+KSJvdf0ypO1hX1Vu?=
 =?us-ascii?Q?0FUslx5uC5hQe163DFvbQi7PGm9UKAlpDUmqMGd9JG4U9pQ4+4l5eL1nTALH?=
 =?us-ascii?Q?VXbDSaUM85JDTGE14afDoEfCz86mQ/Vn488qsf1fne2pn6efeyttzx7O9RBJ?=
 =?us-ascii?Q?W6j9rM8bhwyAiZz2YG+iAHt2icENk6IEmCapFCrVUIyCRZ8efgQOn2C+4DaT?=
 =?us-ascii?Q?WiE3rHnfd+d5CJjSnee/6At2qLHZyKMHUG4t4fhqDV8Ul2uHOgHiD22vALpQ?=
 =?us-ascii?Q?OPzbn+rBqnFJ8a700H+y4gfX+233KcObrfcoF9suiokuYcLIXtTRcRzzy8Yx?=
 =?us-ascii?Q?RmED4y01Sw92kUynk1+whcvq98inOGyHRBs8a0N/jn9cVwXiurLRwxd065MG?=
 =?us-ascii?Q?1jnhxwBFb6XWYF0sb/DGRmH9aEYO3ztnWr4JwOIOguyrlzF6PDoHyXi/Djai?=
 =?us-ascii?Q?eIVOO/JUM6x6rPwE7CB4aZTtfqwUvhoras8nYvQHcq0p0gbhhQBHd2Xp7evO?=
 =?us-ascii?Q?rszhZML3x6DxpbawLfWAf3a7GOcNMXCL8+KPhzjgmkThUEnEAC8DYbuAphty?=
 =?us-ascii?Q?nixSWmGXlyG2mQ6rCAdTNWSmcEpatBqQ9ejigDrr6C2VUJG+SVj28ijSzWzM?=
 =?us-ascii?Q?A4QEkRqrXL/e5zxJcCOlMQqSnzwekanxjG0HryzHfBeSgEB+ilvf5Vv/gtM1?=
 =?us-ascii?Q?z1EbkJNM6IkhxXamL7CJXjwXISg+qq+HgJJ5FYsG3sTeJXn77NSzBVdfJxRr?=
 =?us-ascii?Q?fN+V67aWUyEH8YSWVZ3MxUTvz9pEDzwBGAfRHckogKyjrwNes6lfUZzKQhw8?=
 =?us-ascii?Q?Vw3m9GBhhpttXae5iIW1GWFG4G5gkMHqG7nEKGHKUf1rAQeq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d7991d-b593-4ffe-4af2-08debd84ceda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 13:18:43.6853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f49W5WJBgKhwfFjm2V0OCpo0703FkQvWSAFxqR3eVu1PHs135Y/S3faJxM7wJw0qejFn8k1F/lPZFNyU9xr6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 29, 2026 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Add helper functions to fetch pptable

PPTables could be embedded in firmware binaries with v2.0 or v2.1 format. A=
dd a common helper to get pptable from firmware binaries.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 140 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +
 2 files changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 0a745afa8552..ad1020b8389c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1551,3 +1551,143 @@ int smu_cmn_dpm_pcie_width_idx(int width)

        return ret;
 }
+
+static int smu_cmn_get_pptable_v2_0(struct smu_context *smu, void
+**table, uint32_t *size) {
+       const struct smc_firmware_header_v2_0 *v2;
+       struct amdgpu_device *adev =3D smu->adev;
+       size_t fw_size =3D adev->pm.fw->size;
+       uint32_t ppt_offset_bytes;
+       uint32_t ppt_size_bytes;
+
+       if (fw_size < sizeof(*v2)) {
+               dev_err(adev->dev,
+                       "SMC firmware too small for v2.0 header: %zu < %zu\=
n",
+                       fw_size, sizeof(*v2));
+               return -EINVAL;
+       }
+
+       v2 =3D (const struct smc_firmware_header_v2_0 *)adev->pm.fw->data;
+
+       ppt_offset_bytes =3D le32_to_cpu(v2->ppt_offset_bytes);
+       ppt_size_bytes   =3D le32_to_cpu(v2->ppt_size_bytes);
+
+       if (ppt_offset_bytes > fw_size ||
+           ppt_size_bytes > fw_size - ppt_offset_bytes) {
+               dev_err(adev->dev,
+                       "pptable v2.0 exceeds firmware binary: offset %u + =
size %u > %zu\n",
+                       ppt_offset_bytes, ppt_size_bytes, fw_size);
+               return -EINVAL;
+       }
+
+       *size  =3D ppt_size_bytes;
+       *table =3D (uint8_t *)v2 + ppt_offset_bytes;
+
+       return 0;
+}
+
+static int smu_cmn_get_pptable_v2_1(struct smu_context *smu, void **table,
+                                    uint32_t *size, uint32_t pptable_id) {
+       const struct smc_firmware_header_v2_1 *v2_1;
+       struct amdgpu_device *adev =3D smu->adev;
+       struct smc_soft_pptable_entry *entries;
+       size_t fw_size =3D adev->pm.fw->size;
+       uint32_t pptable_entry_offset;
+       uint32_t ppt_offset_bytes;
+       uint32_t ppt_size_bytes;
+       uint32_t pptable_count;
+       int i;
+
+       if (fw_size < sizeof(*v2_1)) {
+               dev_err(adev->dev,
+                       "SMC firmware too small for v2.1 header: %zu < %zu\=
n",
+                       fw_size, sizeof(*v2_1));
+               return -EINVAL;
+       }
+
+       v2_1 =3D (const struct smc_firmware_header_v2_1 *)adev->pm.fw->data=
;
+
+       pptable_entry_offset =3D le32_to_cpu(v2_1->pptable_entry_offset);
+       pptable_count        =3D le32_to_cpu(v2_1->pptable_count);
+
+       if (pptable_entry_offset > fw_size ||
+           pptable_count > (fw_size - pptable_entry_offset) / sizeof(*entr=
ies)) {
+               dev_err(adev->dev,
+                       "pptable v2.1 entry array exceeds firmware binary: =
offset %u, count %u\n",
+                       pptable_entry_offset, pptable_count);
+               return -EINVAL;
+       }
+
+       entries =3D (struct smc_soft_pptable_entry *)
+               ((uint8_t *)v2_1 + pptable_entry_offset);
+
+       for (i =3D 0; i < pptable_count; i++) {
+               if (le32_to_cpu(entries[i].id) !=3D pptable_id)
+                       continue;
+
+               ppt_offset_bytes =3D le32_to_cpu(entries[i].ppt_offset_byte=
s);
+               ppt_size_bytes   =3D le32_to_cpu(entries[i].ppt_size_bytes)=
;
+
+               if (ppt_offset_bytes > fw_size ||
+                   ppt_size_bytes > fw_size - ppt_offset_bytes) {
+                       dev_err(adev->dev,
+                               "pptable entry %d exceeds firmware binary: =
offset %u + size %u > %zu\n",
+                               i, ppt_offset_bytes, ppt_size_bytes, fw_siz=
e);
+                       return -EINVAL;
+               }
+
+               *table =3D (uint8_t *)v2_1 + ppt_offset_bytes;
+               *size  =3D ppt_size_bytes;
+               return 0;
+       }
+
+       return -EINVAL;
+}
+
+/**
+ * smu_cmn_get_pptable_from_firmware - locate the soft pptable embedded in=
 the
+ *                                     SMC firmware binary.
+ * @smu:        SMU context
+ * @table:      on success, set to the start of the pptable within the fir=
mware
+ *              blob
+ * @size:       on success, set to the pptable size in bytes
+ * @pptable_id: the entry ID to search for (used only for v2.1
+binaries)
+ *
+ * Reads the firmware header version and dispatches to the appropriate
+v2.x
+ * parser.  Only major version 2 is supported; minor version selects
+between
+ * the single-entry (v2.0) and multi-entry directory (v2.1) layouts.
+ *
+ * Return: 0 on success, -EINVAL for an unsupported version or if the
+ *         requested pptable cannot be found or exceeds the binary bounds.
+ */
+int smu_cmn_get_pptable_from_firmware(struct smu_context *smu, void **tabl=
e,
+                                     uint32_t *size, uint32_t pptable_id) =
{
+       const struct smc_firmware_header_v1_0 *hdr;
+       struct amdgpu_device *adev =3D smu->adev;
+       uint16_t version_major, version_minor;
+
+       hdr =3D (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+       if (!hdr)
+               return -EINVAL;
+
+       dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id)=
;
+
+       version_major =3D le16_to_cpu(hdr->header.header_version_major);
+       version_minor =3D le16_to_cpu(hdr->header.header_version_minor);
+       if (version_major !=3D 2) {
+               dev_err(adev->dev, "Unsupported smu firmware version %d.%d\=
n",
+                       version_major, version_minor);
+               return -EINVAL;
+       }
+
+       switch (version_minor) {
+       case 0:
+               return smu_cmn_get_pptable_v2_0(smu, table, size);
+       case 1:
+               return smu_cmn_get_pptable_v2_1(smu, table, size, pptable_i=
d);
+       default:
+               return -EINVAL;
+       }
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 5b7f64b94179..ae6742f5298f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -249,6 +249,9 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);  int smu_cmn_dpm=
_pcie_width_idx(int width);  int smu_cmn_check_fw_version(struct smu_contex=
t *smu);

+int smu_cmn_get_pptable_from_firmware(struct smu_context *smu, void **tabl=
e,
+                                     uint32_t *size, uint32_t pptable_id);
+
 /*SMU gpu metrics */

 /* Attribute ID mapping */
--
2.49.0

