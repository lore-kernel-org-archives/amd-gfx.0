Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66173C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 13:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286AB10EAA6;
	Wed, 17 Jul 2024 13:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u44gri2u";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769F610EAE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 13:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwRF0oNc8RfD8ntLzLxAiqh956JH64/Zep+0QbVKYLCDXP5W77wYvcHGvCjrQb1rmmf43Zg6Ay5li/3mqjk830k3s4r7Ry21ig59yNqVXsHWMmm3koOvEk0tA/36tQfHBUR1T/Jc53Aaxuo83IKuLqMrY4HmtRiB/eoVIFZ5KNRnZfb2nI/tJRzQGChgG9n5D33qxrcQDJUckNtkWA/V9LZ4c20EzHFYiyzJMPmRmlrFiNh3rqHGdxbHuqgfwt+UVkQBPIdjf+me6r25Acc1eoexiD76hI+q+dqcw9DL8AdpnjWu5GVWQUPvVtHtjx7eQoEHIVA+BvC9sI04ZNPVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX8pxFs2i07PGEZp65F3LcdDeqKRSgNmAIfWxZ+GKoM=;
 b=PnS6DjiRK/BYKJYnh2DZJhfSWvinzHhOxV0UIX4cYt4LWSniDcFHG4TqUcgLSh796lr6kVWrm3yRjdne4WoFvWbjVHOiDMUd7vsa0MrAIrS7/Pjq/bmi/3EMA7i7Uj4w23WAHwR8ziCpSaNJzaYsP+V38ICe0nOdL3+FLDbegEU3JDnx4BrpukqMpWg12jhbUTnMRhkUHXdkzek4y1gGDG+Rb9B5M+OZXyG/BiWwcrkl30elBe9awXDm+vm0gqxeM0ohbky4Gxyg2v4dQebSvCdW/OESnD7+1UtSAczJPuwdLkhwWEmNXXDoxkRxJc/vlWwoWFam6KqvOVhhvad99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX8pxFs2i07PGEZp65F3LcdDeqKRSgNmAIfWxZ+GKoM=;
 b=u44gri2uxdSxEHyV/k1mCXwao95rJsVGh41eWEVZJmghniDS7MP3atj2yJWqIzOBHlNs3RzmTg2r5bMOnDIk2bV3N4zJBhYJduZm3X1/X112f/l5b1mgHLJOG4fpvCmuw8k+Qh4L4yEQusNi1POSwun0Qz5JK7oul1BhkFA7gJg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Wed, 17 Jul
 2024 13:00:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 13:00:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Topic: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Index: AQHa2CGXtfOP2G7rpEK7aOaZon3F3LH64P/Q
Date: Wed, 17 Jul 2024 13:00:10 +0000
Message-ID: <BN9PR12MB5257E2AE24DC4B4752F824D2FCA32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240717081547.224193-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=18f224b2-018c-4847-b15c-035a006b5afe;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-17T12:55:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA3PR12MB7832:EE_
x-ms-office365-filtering-correlation-id: 72b9ecbc-c2ce-4965-2bb9-08dca66063d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IeNQsWZ8S88J7ZWkcWOpJRFQZk4DH0C01iTN8s0UzlTtOqxpZnBZEPOlIhsL?=
 =?us-ascii?Q?tZ9x3JvVhsEEQamd0niEJ9oD285rg3y7tEkBRX/Z0HgkxTbuOaEE/ROiQFA6?=
 =?us-ascii?Q?2uFlNeu7/a4bTcZ+5XXawqJ2zbR+o3+KnB4FsRjfcwhDjCz5N4QSmVID6mbM?=
 =?us-ascii?Q?UCLTgm4sUkDsBptqGC4JORsosFdq8skjncfYph26SCGpO+P2BsEUHydPGyhg?=
 =?us-ascii?Q?64dzDj5MjVU3sWUQLj725Gz81+4q78Dp03L8RbG/et15rczvgd954cnftieA?=
 =?us-ascii?Q?aBP22L3wVhvNSpTZ7scqaSqwce7ZrUeIZ42AwBWrmMJjxo+TrZOkKTg7QMCG?=
 =?us-ascii?Q?R09Lf7/ycMXi61pXzJmN6FRWghYfyOUnCIAUiYuznqbf22Cm3oFXtdU5CnQY?=
 =?us-ascii?Q?vUv5kVvZU1D70yKNfheRzPjZitZcS3luxp0CJtXLhStaGoBrDE7250/2dfAI?=
 =?us-ascii?Q?1kfgghRw648uRJawLgWG1AOxPxFn14h0wUm+asDen5d16OBG6n9yj2cYGHdd?=
 =?us-ascii?Q?CwsQklgesdPVeFIzymrISFFuZogTRuelj/SOEgkekADgs0D0cOJWvve0nf0T?=
 =?us-ascii?Q?zABnVQoQ0+AA6r5LOsQWB5/oM0xPtLjdbgjvXOBLXV1KIIWYaRIVRM3yWLKN?=
 =?us-ascii?Q?nEe+4KOcm7kwIoMOjnqPShnvAprSg9EWj4Px5YMph7gV61e6TjvXSXWQ+SAC?=
 =?us-ascii?Q?elU58bghBchyAVOKjcwvIQ2JBxcfe+bzNf58WYc5z4DLfYbiQOFx9XT0AIby?=
 =?us-ascii?Q?F+ywz83DGFlnwr094VO0ir/cDqDDBWrFshW2NIP9ZRm05ts/y9JVCwbBMZsP?=
 =?us-ascii?Q?KSjRvnP+gg+9rP4VI+Jx6IWZSZweSrzn3Al24BXPx+I6dw4AQGu9SD6VAszr?=
 =?us-ascii?Q?cHhNE/nr92auSmF/XN+Mllm9fLxqyGWLfSjTQSIOJ+EqQsuqtsl3cP9dHX0e?=
 =?us-ascii?Q?AtKzTUKPbXZn+3GqomFlKYEYIkesJsIYHZCiEg46Zy5hetHtea34e4sihXsw?=
 =?us-ascii?Q?SyHKkorP432C8z/AAAS03rEXzhUgrxii17jcelUm2RAuxKpmLBlR35OBuqL/?=
 =?us-ascii?Q?XRNQ6u4cPe3RVL6tHWelyJSGJWi010YeVnjCVXwj1RMf8+tuvPiDTffWoh9A?=
 =?us-ascii?Q?55E186i2HCIStNPrIij4j/0JTxqsy22JAuxC8+6el94S9mKlJUT2Qm2c0+/P?=
 =?us-ascii?Q?ftHPFoMsDoE04pEKrwVHz24/MGaG3/f9zPgfJg44mpgEHK9dyzdwkS0eWnBa?=
 =?us-ascii?Q?WPtkOS7IylnjmSBz7WSt+Jk09mLhp7NwBggVa15YEpmdcKg8tgtexwIXPIW6?=
 =?us-ascii?Q?NAQsNdYfx2/Asa6fsLjrzx0LnWhkGV9UjkWxGG12vXVZc1HQEIkTA9iMISfa?=
 =?us-ascii?Q?4ivqUIXBw5jtZT+o6D0XQoFX+11Pw3FF/Cy0io+lSqH/TMviSg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GQaqSnytl3VRStTFHcXqMK/rAkZFMBIfGfLL3d/kTYjKoiMmd+KHq/oAvmFL?=
 =?us-ascii?Q?XIT62pJIlDDi8eEsXrfelyzlDt5LcuiSmys8hi23LKBnBAwYfNqSvKaxI7Uh?=
 =?us-ascii?Q?lSd+KoTuPI8oHGiZS1ymue1kerwdwwk7rZJnMoE3cUwzp/LwjTG7BdIl3WeH?=
 =?us-ascii?Q?nH4okCX9A+4xDllijIOaVbH3HTUrQH7kEY5welsvtAk1UyovCwWUX5c4lZH8?=
 =?us-ascii?Q?W9g2Ncp0ajrNP0MvE8hZtzpJX5oOIydUyyoYmdU4UFA8RumULWlFojwIesS/?=
 =?us-ascii?Q?avMvL8GAvhogeSnNMa3+a7mRO2VDskHEYWRvao61ijtxCxidfsyjXNvUisrz?=
 =?us-ascii?Q?p8D3J6kZeGD2AYcLtW1CCBZxRIwKpK44xd4/6IdFF5pjbDZQh/5qghZBNVd0?=
 =?us-ascii?Q?klZBdcSrpXw9UQP/h9TwYMyO5fCrX+BMM+bb7uJgM+0C7ObYvu7bOeFA15Jo?=
 =?us-ascii?Q?t2BQdIbHnVkqbha7KUmKroiLIu0STEzVqSPzrGylljkpk71QwTc/BYCuJHhQ?=
 =?us-ascii?Q?zJ4CkNgIk0Fx750AQsE0Ie0kbXLO0Jvf/MaMcmwIZHW2VU6a7Y0za3wxJvnk?=
 =?us-ascii?Q?PDWpAJhODi3pZ59jIewYEvfE/0nfBgreZ5Sm8jZbnZQubVOT4cHteBV5gl1Y?=
 =?us-ascii?Q?cTEbaTyldLrFkPVVp9JJh45GufzRmMITcAKv0dub8dQAgXeToDtiX2CdKeNF?=
 =?us-ascii?Q?weCZfUPOgpQcrpT2NkAd3ZzEODAHKa5lcI9SiTANxpjWoxmYGSDAvdeCHYOY?=
 =?us-ascii?Q?uguT8yQkRH4txWLYqwgMjQBcZaBT6jWaSnocwwAo8BGnTDAIqpJUDUR7tNlO?=
 =?us-ascii?Q?TlL2fXY33oQ5b5t+CzZ7fQRa6CYRitnN++jVB+umpH6ZB+Lgng3dHfCQaAFC?=
 =?us-ascii?Q?YkC6fj9MqzcVBz5OMRliL7vkLoMZcVO5v6m/lf8GKRZhnL87A8NOTTkylIce?=
 =?us-ascii?Q?QkyAiRmU6KWVqPvg3Wf3qPZ6tS35pmSEmGyFKp4ToF6O5yZWtsY9XWWyKXDx?=
 =?us-ascii?Q?/b+GCSoHSlPlMzNdchTYkh+ugcVgcW35kqqT4TGGM6+Km+wsYgj3fbQgdz2U?=
 =?us-ascii?Q?rqQE5swbDrcMX3SeCciFwdmkEVcEbY44EDCUBDH4rRxwwPJ0+i5oFNc+FsFY?=
 =?us-ascii?Q?qOK5wWSfQZ4qc5Q3eD1vcYJ0cdu10FhXkmh11H9YYl4eq0TBqPQdwZRHUvlD?=
 =?us-ascii?Q?QQlxaAnGvBafbC5QreENCmMob8PsrJ4OR8DmkEdeAKzCHqNqO0wx+0MTx3SZ?=
 =?us-ascii?Q?ALymBcFxrpRcMS/1jJaPvT5TpjHUrC06w7ZjL2/0ff4Jx5TOYbcsYUEkLtMD?=
 =?us-ascii?Q?tXgtGbZGZRboFjKRnXeZGn73MgXQJCxfg42RF4BwSUiwvGrALP5tbUJ/GbpS?=
 =?us-ascii?Q?wJXXJ0tFUcsFt9EvG4CckbTBd+ekyXnmTbQZhkzjmtLnS6EqbUn2/FRVpeYk?=
 =?us-ascii?Q?ia9Hsr53Y0UBzdQzFLxi7Ag10GurcS0chmNFPM17QeMmLtkvU7o44lySfML3?=
 =?us-ascii?Q?JB+FGZSDu0s2Fi5d1iEbixA/L8FNckmz6RTzYoAJw6/bjMkxEt4m4D1/AjBc?=
 =?us-ascii?Q?RUbHVbd4BDWcXombwPsEiGynRapEu7hGQhJ+pZXw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9ecbc-c2ce-4965-2bb9-08dca66063d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 13:00:10.1540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u024GBP1493/EZs7DOto60hXCpTrn7womPufRIhDPOFbv8pzAuOSGWbfnzHctAE2c0iwpvtQ3uYLLdr+A48ePA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

[AMD Official Use Only - AMD Internal Distribution Only]

+static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device *adev,
+                       uint64_t pa_addr, uint64_t *pfns, int len)

I would call this function as lookup_bad_pages_in_a_row, or something like =
that.

Anyway, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, July 17, 2024 16:16
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion functi=
on

Split into 3 parts:
1. Convert soc physical address via ras ta.
2. Expand bad pages from soc physical address.
3. Dump bad address info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 116 ++++++++++++++++---------
 1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 9dbb13adb661..eca5ac6a0532 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -225,26 +225,16 @@ static void umc_v12_0_convert_error_address(struct am=
dgpu_device *adev,
        }
 }

-static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
-                               struct ta_ras_query_address_input *addr_in,
-                               uint64_t *pfns, int len)
+static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
+                               struct ta_ras_query_address_output *addr_ou=
t,
+                               uint64_t err_addr)
 {
        uint32_t col, row, row_xor, bank, channel_index;
-       uint64_t soc_pa, retired_page, column, err_addr;
-       struct ta_ras_query_address_output addr_out;
-       uint32_t pos =3D 0;
-
-       err_addr =3D addr_in->ma.err_addr;
-       addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
-       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
-               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
-                       err_addr);
-               return 0;
-       }
+       uint64_t soc_pa, retired_page, column;

-       soc_pa =3D addr_out.pa.pa;
-       bank =3D addr_out.pa.bank;
-       channel_index =3D addr_out.pa.channel_idx;
+       soc_pa =3D addr_out->pa.pa;
+       bank =3D addr_out->pa.bank;
+       channel_index =3D addr_out->pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
        row =3D (err_addr >> 10) & 0x3fffULL;
@@ -258,11 +248,6 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_de=
vice *adev,
        for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
-
-               if (pos >=3D len)
-                       return 0;
-               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
                /* include column bit 0 and 1 */
                col &=3D 0x3;
                col |=3D (column << 2);
@@ -270,6 +255,35 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_de=
vice *adev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
                        retired_page, row, col, bank, channel_index);

+               /* shift R13 bit */
+               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row_xor, col, bank, channel_index);
+       }
+}
+
+static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device *adev,
+                       uint64_t pa_addr, uint64_t *pfns, int len) {
+       uint64_t soc_pa, retired_page, column;
+       uint32_t pos =3D 0;
+
+       soc_pa =3D pa_addr;
+       /* clear [C3 C2] in soc physical address */
+       soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+       /* clear [C4] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+       /* loop for all possibilities of [C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+               retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
+               retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
                /* shift R13 bit */
                retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);

@@ -277,14 +291,40 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_d=
evice *adev,
                        return 0;
                pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;

-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
        }

        return pos;
 }

+static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
+                       uint64_t err_addr, uint32_t ch, uint32_t umc,
+                       uint32_t node, uint32_t socket,
+                       uint64_t *addr, bool dump_addr)
+{
+       struct ta_ras_query_address_input addr_in;
+       struct ta_ras_query_address_output addr_out;
+
+       memset(&addr_in, 0, sizeof(addr_in));
+       addr_in.ma.err_addr =3D err_addr;
+       addr_in.ma.ch_inst =3D ch;
+       addr_in.ma.umc_inst =3D umc;
+       addr_in.ma.node_inst =3D node;
+       addr_in.ma.socket_id =3D socket;
+       addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
+       if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
+               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
+                       err_addr);
+               return -EINVAL;
+       }
+
+       if (dump_addr)
+               umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
+
+       *addr =3D addr_out.pa.pa;
+
+       return 0;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
                                        uint32_t node_inst, uint32_t umc_in=
st,
                                        uint32_t ch_inst, void *data)
@@ -483,12 +523,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        uint16_t hwid, mcatype;
-       struct ta_ras_query_address_input addr_in;
        uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-       uint64_t err_addr, hash_val =3D 0;
+       uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
        struct ras_ecc_err *ecc_err;
-       int count;
-       int ret;
+       int count, ret;

        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -514,17 =
+552,17 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *ade=
v,
                MCA_IPID_2_UMC_CH(ipid),
                err_addr);

-       memset(page_pfn, 0, sizeof(page_pfn));
-
-       memset(&addr_in, 0, sizeof(addr_in));
-       addr_in.ma.err_addr =3D err_addr;
-       addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
-       addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
-       addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
-       addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
+       ret =3D umc_v12_0_convert_mca_to_addr(adev,
+                       err_addr, MCA_IPID_2_UMC_CH(ipid),
+                       MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
+                       MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
+       if (ret)
+               return ret;

-       count =3D umc_v12_0_convert_err_addr(adev,
-                               &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+       memset(page_pfn, 0, sizeof(page_pfn));
+       count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
+                               pa_addr,
+                               page_pfn, ARRAY_SIZE(page_pfn));
        if (count <=3D 0) {
                dev_warn(adev->dev, "Fail to convert error address! count:%=
d\n", count);
                return 0;
--
2.34.1

