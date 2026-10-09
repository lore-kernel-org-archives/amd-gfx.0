Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF7ACA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 09:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89DE610E4D6;
	Fri,  9 Oct 2026 09:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3N5rBai";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7821D10E4D6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 09:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XU8l8BfcZoMwWlEWwjHmnxG1P2oeHcA/Es7q+lKdz0cGFOI3CS87PRcRiPtjKhn/f8NRn9O2tgY8fJEGMNP1vte/Crott4Dv9Fr8gagKjsbHRgVF9pUHlTJfqOsiwDQ97tTZo78XCVFQaHCJrc7IROC++uu8+n5S13vg8PYf3+SoYY9W/vvYmuvmS4MUUPExprRVGxVklxxAqBlk2U3Q3NuRsfOzWLe2zpRoJmwBCW/+mVSY44c8oxArbiFtEwrairgkStzAPhhVjXEhsXFQdGrfw8OOz/JpmUwqJc7tLCZLmQtA+4K1m2GKw5vjAR9pHZvQu73coqfI2RCUu4+9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pmQOt5SuY5rH/EdA/cKGuNCvUgPJcbtOZesULPK89A=;
 b=YlzGRcNjUCCQ8WEk0MY1aIKZ/EUHrQYGMPKWFB8arHIFNUEfRwLDNQzPUyeGT/Jruktjyc4dilQt/GjkFlrWuJMRbWNFmWlzYlCbRKn7FF0goCTx2z0DnA3GjL/ir1rZ4y00r25WWXsd1haiBT6vW/WWWXJTnaUxZm2UzaB9l3OJlm7GZ9k5juf+tvnu+P3Bd6pxdC5BGhpWKe7nPv1qb0G2lqGYWkBNZnZsXigP4wY+J+AeMmYQAnyfSktXmK85WL1EgDcRg7nVbAQF5MxNKbhq6sQNiO6XUn7meIRcBmZqZ1NlqfUjoYKhYZzyaPwPUZnSMhHg1lS5A+55jJOn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pmQOt5SuY5rH/EdA/cKGuNCvUgPJcbtOZesULPK89A=;
 b=O3N5rBaiag13x4ra9qRv8QEtSqnfDjLOkdsmG1joBj6GOIcQEWMs5aY3dWhwYKByMt8Xx+HHcdE1wfeNgDyqT/njMOXpSZeYZHsPdy7BHp2ELjR0NHXBWhXBtdSbOw3UhB5TyIiPEb9uu0DMHtE5rdOLoVM0ANjcuUXDrSPrB6I=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:54:22 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Fri, 9 Oct 2026
 09:54:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: init reserved vram size before RAS core
 sw init
Thread-Topic: [PATCH 3/3] drm/amd/ras: init reserved vram size before RAS core
 sw init
Thread-Index: AQHdUApxCox7qVBEGki4i3NNxaWU8bb1B+8Q
Date: Fri, 9 Oct 2026 09:54:21 +0000
Message-ID: <CYYPR12MB872987C6C914048FE3297803B0922@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260929120216.1230237-1-xiang.liu@amd.com>
 <20260929120216.1230237-3-xiang.liu@amd.com>
In-Reply-To: <20260929120216.1230237-3-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-09T09:53:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|SA0PR12MB7479:EE_
x-ms-office365-filtering-correlation-id: 6bc8e766-fdbf-454a-9215-08df25eb4b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: 9JH/JXZlp757eyK5WNOBxA1v5ZxSbxqtSRIx0JaH2BtbhGdnCBHR7YBYoIT4Ojho99ZtJuq91+4kzcN5dZdIHbMJuaUhWRjEstPyTSd5VxGGEe+AfBupdfwkvMgOK9TvAqKqqDzh7hSxB0+zNUrNGp+wU3wrVr+eBcOV5UHpJbwhVlTFBBlJhnccx4qC4rGYFWjAthxYOsHWhpY9o+W83xoQsARo73E7i65K2yh1Gxt+Lu0XealzH5laGWRT0ucmfE6peyrEmqpY3zpORmyaDp/vH+OBl9rY6Ep4KfrAktj3z12HjvYT2891lHp3jwBOC3KKo0BiZHxHvpc94bAX/YbWbK+rNGKn5f0fygTf6TRc7OsVwbR9YXpPa+guhJdLDeVa3tVLOI2Z2P7jweQEHptqY72tQG3lrQQEYogkYt+MRumFF/y5gTQ2ugIYAE+N5841YPe9/YFXErsrSdqRVk6xo/Z5MCdpw5pri9I751c73NKI0A619lWQBbuWtj2g+RwNVroxt/seF4XVLUdXz8rx+HHG8UDgcTygEw6zM5zYS8Pt6s+jsn37eByWEzdayQP7XBNrM6Ri6oWgHeZZzAR8oO9zEaxVDJJBqA6u1wYQTulbM/nyq8mHowvnTFf/52+qvgoXdcm5yUwDVh2W0XW+Q2yFF6YIAJeR6X4Bp/MjD9b0GmE8WkBYoNmdsfUb5BtVmT52lwVwpZjLF7+ge7U05wJn4ir6jNKAJfkrxdk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mHXnhLyGt1xqmdNpEuGhM4xIesf6IafSZX6O+Gw9t9ZQ20bEAml4W1CGnU/x?=
 =?us-ascii?Q?PUWHIDvwG4liwn/zzBKgIzZ+viD/S6VpaT2gdI4D01ZV9D9xlEgslmGktwr7?=
 =?us-ascii?Q?wdc11ImP6PvbePDp3kwkMQY9yluPczDkAYs9pDSOHU6W8OMzGKS4EFt/57wl?=
 =?us-ascii?Q?hH60WHs1z4a+KwlrYIwy/gZEbTUFcqc1b9S4bmWgkQKFrvw2x9h56YXIZzm0?=
 =?us-ascii?Q?WObrxLjyuR52RDufL0PzNYbai3gnCsbNJyWFfx6hnOINUKGjV5tMvvE6Ry5z?=
 =?us-ascii?Q?bhs2A9b1ppkyvwh7JlsuwIXmP7ZdpqIjWk0DYxYNtOJmYTbY1cWDgRTV5qUt?=
 =?us-ascii?Q?jgx/j9szoUWNkbits2l4W4oYs2PI4mvnjpwE/f34HEUpvdLTtnWQ+Gdt24E5?=
 =?us-ascii?Q?5RIsqEbrAVoI4ZL1gLKk+VSbFZiSfko7AONYHkZpanmOUGod3IcCWFipPpYN?=
 =?us-ascii?Q?4vXdhXyW13mxY4lKNjM4KquMsmObJLbRSWPTdQbF4ueCR2amua+mWcoxfUJJ?=
 =?us-ascii?Q?+TZAnVlijhOHxc8fVXEEHamd7YyJHATvSDxHwg5fQlXmLXWzGFUrMqv2Rh6t?=
 =?us-ascii?Q?kU/HOBmCiSbXmJNi7TLgW8wnQBgPbu1JI8aE6B+a/m0mplobbdQUX/czQVyO?=
 =?us-ascii?Q?v44twoFCZFU3nnf/tVKKrjhi023dFZhBL8FekOVfSV9TfXyN0ByyYr27xaJx?=
 =?us-ascii?Q?JkmppkwG6oREhpvYqyocUJVieJEmlFWgndeBluH8piQ9AkBpHO6TxtNpMma0?=
 =?us-ascii?Q?2zXgwLu5ofARG19G37vUtWaE4xu+ZrFmTyv/tuiJV0zcU9ivFUdqPzZrx4sj?=
 =?us-ascii?Q?q8lqb1po9g+J28befXHig1Eo7bYS9pTi30AbQ5kGWK0KYFG/gYXwTBilJqUL?=
 =?us-ascii?Q?SWiJ7VFhiVl+cApOpuynASzjLcvpcxMfg2F1EsFWAiK8QyodsHTbGewUGSjK?=
 =?us-ascii?Q?my9lUIHcIY/0fUITSOF9hniISifoPPtfncvhuom9mdp38fjPlyoRCGLeRt5P?=
 =?us-ascii?Q?UE8V87ZCbpC29ir0EvcXWpILLNklz4/UCUDQCgLOemXUoTfqi/Q+flAbOxsF?=
 =?us-ascii?Q?bMrVn3WJ3PFFloVGIrG9BVfZbPrh+42rI2ebc19WmGCiz6R5xw35mLV3QNun?=
 =?us-ascii?Q?viA9OaGuwimBgw/WJgbn8peSGT6DHl6+8x98yNqLl7vckAKGtE6iu+apQAhE?=
 =?us-ascii?Q?X9lTXCjKYAxJc7936xOwBeWXk6udn5JpLjwg3feNCDiCjyeMUCdk8mxZldWV?=
 =?us-ascii?Q?1gkDbYN+ysFR7jXcsCBLOHM8BRQeI3hg7PK8rux8PLAfMqWCIFCv1FOl6jvJ?=
 =?us-ascii?Q?Zns9PsMHIUsQCv2798pndb1qqZB9DxIPqXpov5lo+Is77rImW5AUEk871pp5?=
 =?us-ascii?Q?X42/bUNhs6jIbGHNrYfdHXdBxthq7bAyceiLb82swpdIlJNSXQx5/FWnhY8P?=
 =?us-ascii?Q?EaN2L40DmNiQ69wRoxki/8NMxfksthiRnnFoeYKPV4+Di/OrjGCf+V0rHMWQ?=
 =?us-ascii?Q?ph2YfWBswPCntig4gqtMiOuQCQDuaz1Ipt+4hGGwbBpa90mQ9k1Qj1rhW7t2?=
 =?us-ascii?Q?7qDrKBAcNJpZN9xx5NIGcb8pQT5aDlEwMDo6K7akccvxfBOSXt1//dORzxfn?=
 =?us-ascii?Q?3guTfcKNk5+F7AIGn4IuecM+yfyoswWoEiAJ594E1RhqTYg6R9Z5IqSF2E+o?=
 =?us-ascii?Q?/aHlqPCDqJZ4SIorxFaqXKIs8tmtiHUJoASIZ++8HAhG177z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc8e766-fdbf-454a-9215-08df25eb4b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 09:54:21.8621 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dux93yCUqBablrPypGbeJeiX32mJa4DHb/YhQwh5THkLrbMgwBs0xOBQbePaqBKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Better to let Thomas take a look at it.

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Tuesday, September 29, 2026 8:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 3/3] drm/amd/ras: init reserved vram size before RAS core=
 sw init
>
> The RAS core derives the bad page threshold from
> con->reserved_pages_in_bytes when amdgpu_ras_mgr_sw_init() builds the
> EEPROM configuration. That field is still zero at this point, so the thre=
shold falls back
> to the 16MB default and ends up at 128 pages on ASICs that reserve 32MB.
>
> Set the reserved vram size before RAS core sw init so the threshold is co=
mputed
> from the per-ASIC value.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index becad704113c..0d39b1872b4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3628,6 +3628,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>
>       amdgpu_ras_check_supported(adev);
>
> +     /* The RAS core derives the bad page threshold from this value. */
> +     amdgpu_ras_init_reserved_vram_size(adev);
> +
>       param.ras_feature_enable =3D amdgpu_ras_enable;
>       param.ras_feature_mask =3D amdgpu_ras_mask;
>       param.ras_bad_page_threshold =3D amdgpu_bad_page_threshold; @@ -
> 3725,8 +3728,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>       /* Get RAS schema for particular SOC */
>       con->schema =3D amdgpu_get_ras_schema(adev);
>
> -     amdgpu_ras_init_reserved_vram_size(adev);
> -
>       if (amdgpu_ras_fs_init(adev)) {
>               r =3D -EINVAL;
>               goto release_con;
> --
> 2.34.1

