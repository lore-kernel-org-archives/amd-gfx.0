Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF40C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 03:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEC010E4B9;
	Tue, 24 Jun 2025 03:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnY0YhoO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E12E10E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 03:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoXSDTI5agKgU6PPE8InhDQeen1iXHJ648hwKxF4djPj4N/W8y0SOGbNGAu+AW7LMb0mfKIYV6yKKI+CuQhBj9sQNjyMEWjozDxB430FHcfcb7b2Zs8QhT3LNJCeFcb5NMkFEZDqEumHBiBAfpSeAMChD2t1ph7tWjQcEiBAr05RTzcCRBdLd5C+mKzNSW0g++X4szRDYq5dUn5thUDSXB+XNU7uLEPEnNkn3Dgy11vSgoRgY0gFr+HYsIj6v6OVVUEcZ6cvhsRmTf3M/Bha4ToNPwfj9rqWNh9v6fl0ZLtCoOcNMN3lRokHsbE6LnPBB5SWr6nDQUVlLKYe91xH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtORznS96NJ/SOoHToQn3DMWHTRwrKxBpdx4x7wnmlQ=;
 b=M0fUw6XKDaCO5FU5kcVRiFyyf30qATxU4hNt4zpENuTEKAcF+BQ1GgSIlJebc3M68UXxkBAer/YFHIICyXHdOOVQbM0hXaJTOKkM5+g5q9hR1Pzn/CPypngTuCqk3Slyy8ctEjc6fB/U4fS8Kmck53K2xru0fS9zO7Dl1bDcP0vWhE+mtZgPG+ZzQ+F8h1CcGukKombFWfPbYIuTrKLiYxYDtphGKKWpmcCCyORl0KVpM9afXIf52jkUzBjRH5Q4FOVLAi5vwPr1BlQ3eeapKNxS3/d4npqJpbggN27XulHJYXuwJHHHtlOmhvhiaKj3N3woJ7nJH9B017t4RPn/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtORznS96NJ/SOoHToQn3DMWHTRwrKxBpdx4x7wnmlQ=;
 b=BnY0YhoO4pmDT9Twd3Yue+EN9K96KYvEDH8kaNycQkaLLBj/vBGgZSIP7rAUG5Tv5/EePAvqT57GG1P5kodyNIsWXIk7DU3uMBOMAucZmKyLMvcqDoaY+pPVy/2ClV+OHS034dlqdlcE6z4qD1DBkwjuwaBU0gLn3dVu4O5mN6I=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 24 Jun
 2025 03:15:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 03:15:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v3 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
Thread-Topic: [PATCH v3 04/11] drm/amdgpu: validate userq buffer virtual
 address and size
Thread-Index: AQHb5CSCfHFLDH6xsUalluzCqXm4q7QRooZw
Date: Tue, 24 Jun 2025 03:15:01 +0000
Message-ID: <DS7PR12MB600539C9AABCC08CE648E309FB78A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
 <20250623095154.1150830-4-Prike.Liang@amd.com>
In-Reply-To: <20250623095154.1150830-4-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-24T03:09:43.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8223:EE_
x-ms-office365-filtering-correlation-id: 51419705-30ec-47cd-f514-08ddb2cd4ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?i3GLl27U5+kbwMCcTyS87UcHk0LAB8KtTZlo61IBBTpeeTYCGJYbuXm3UyBX?=
 =?us-ascii?Q?MskS6FdDBlmKAJNe3G9Q1DWi3MGOlvlDlvEvUOFcXkRP+rCM3foKi4Hj5UTd?=
 =?us-ascii?Q?p25xuTrgeMSvOlnB6gMA2iTsJrMPib19DXSORypLQZGxRvHiahg5Icq1YZx8?=
 =?us-ascii?Q?ICGxbANMiLoVfOSSokHFwdkUPS5JE67u6+dVJf0oARP1Cn11+ycyciT1I939?=
 =?us-ascii?Q?wT0LdPuerjbNWDo3GGKEveTwNWKmOhOhzUee7wLncasAPDgzrli370K+Fi0u?=
 =?us-ascii?Q?xV1Drz3odC+DRZSbUOO4Ocq0llfkClCbsw49wA5jitZMV1Co9XItUvpUTLzA?=
 =?us-ascii?Q?v8dh9gFg48BGDRUOI8OCxbhDvtp8EBE+/6KvhNgdgHtdTu5g9nn7Lnn1ShwD?=
 =?us-ascii?Q?hN2EXkytfMmuqs/s1VAYKZKnILU7AUU6Bf5nWLEEvgPaTKsqrGvoBzafv63c?=
 =?us-ascii?Q?pkJy5rlmiFXY+8U72MLag3UUY1ycRkIfXcJj3J/P14c1UctmBY72i6f41Csr?=
 =?us-ascii?Q?oiXXtILOEJ2XoMLTMy7LGqIOFwEmfAV+gKHanHZhQr96OFbwAekCFpLay2dJ?=
 =?us-ascii?Q?yVzMCJaDwdEErwhBg1FALoge6DH++/YBXeCJAWyTHoqCEl2Em/t81HpcHXhD?=
 =?us-ascii?Q?b71qsaPdUMLUh5PuAu9OBRTNOKS2H7iNpbel/rIV7KZ5ACwkOZ6K78nIA25p?=
 =?us-ascii?Q?yZYtx6KvorvNFpO0ISWxHKkxUw7Qbfyq5bT8zZg5qz8RhJGUi7XvgJtS8fiZ?=
 =?us-ascii?Q?rrK45UFmT4fGbvEJ7mmO7TY8JeCTZql2B+PHhGwYnzusXO98ZIQWjsA1XrjM?=
 =?us-ascii?Q?GAPlmcHw97UMfc48eINLLV4tQBiV0bzgJ2/NLsmYLVva8tZCO1PQ/vl4ioGs?=
 =?us-ascii?Q?sHb0tnhp54njGKBn8a75MGxhrSw1VU6SNTSBBhsZUkVswLykUp97t3vCdSX0?=
 =?us-ascii?Q?Ttd/Rgwa2Apg0lZL6q+Zwc+lkaCH1MCqWXFdzFn13ppNzi1FzRmLDp/i1sjz?=
 =?us-ascii?Q?3gy6vZguTVZKZuJJ+uTA9icimqjAH4bTowTeUi1sOMNL2ZDARG4ncpNbyOKh?=
 =?us-ascii?Q?tyT9sa07OqVuTvy8ofU8e+v0KD/dlvLvf1nyqi373b3I5fjBprr7IAIhikDI?=
 =?us-ascii?Q?jUXTMmaIFvljEp/Nlrtk/U+FoNhUFHVgT28fd0B9gUb/swUkjOHeK3/A9Nuw?=
 =?us-ascii?Q?e5g+SSU305zxBOCz1T3nfqd7CfPaH9+jlMQ9xMkg4KKhc8Ser5ZRctEWlGCc?=
 =?us-ascii?Q?ZyOJV4c0t9aGE13LvCJflrJUm8PCYPVQUNybH8jmlIwn2jxxdOkJ2iDMYapU?=
 =?us-ascii?Q?HJeya1+96xCy9Kd2vvjZhV1JYOo2oM35obbdDln+6uMJajsKQscCvNQRI/y4?=
 =?us-ascii?Q?itNcF1B5r+lQHdwW4RwbkOTOE9xXc3TQJl8IJyd/wu8uftjTfKdUhpS11Kdr?=
 =?us-ascii?Q?o9DuUHZaTNgDv0ej+X3DdLGz33fkF+tyvWsJh2Im7apXcSunP9Mo+08a1Nbw?=
 =?us-ascii?Q?JbFfdm3rEDvGrOI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qKInNPGDsS35sBPlahNsQKLANftlwcVkTeProdS7YX+b2VXAFCG7eEkTsMHb?=
 =?us-ascii?Q?DunsVkOfJVNb7a3YW/JbpEULZbmh8zlNCErLncGYi1H5KC7I/7We7r1Ha6hl?=
 =?us-ascii?Q?xzHU9hwlaP9AogC23XcqzvydqzkKxHFBUV8V6HTzpt9cx7XOuNTD1TuIUjYq?=
 =?us-ascii?Q?dz1y96puHzvw/0W1Rr8lMrRnndYz2vK7C2ZVFjN6dqi2f0gz2TS51Mpxzwmy?=
 =?us-ascii?Q?MZEVGPgWqPLWttz1WhhAXjWGry1wvtQBeSGeJYQQlSmE4lPtl/Dj1U1GldEH?=
 =?us-ascii?Q?eo01NiBazHzWXdz2aD/Ind2SLMFkWhdL4ZDOk5dvIYjqsscoRCzZ/m+CW9tc?=
 =?us-ascii?Q?SqaHjUpyjEEzNnqbMLGp8q0JC2FZVTF1TcPftjcLhHdKpWovESFg0tHLBDI4?=
 =?us-ascii?Q?Mxf4qgG4ScGzk4RQ9Gq2ddWUbmxNHGFJmp+LdlnfZzpU1DUteDG/yotVHFLF?=
 =?us-ascii?Q?Ud2egaPl1MC0/ucKxpl8t1iiMyHVOfPXxZKHDIe3JKXj2wLKTRKdShKWxp8r?=
 =?us-ascii?Q?W93z3ODjb852kbrz12ipZ8jo3XLH81FRaeMbheXUeUcjBj3u/52jPot3qV/5?=
 =?us-ascii?Q?t7nIrktHwh3St5AAc9EpBPi7U9w7sXFl4GlQ/8jkZJJEgJSkj+7+PrZvHg4T?=
 =?us-ascii?Q?4C5v6e0qOyQCEA/FV8EpNbaSFyuHybG+ya2XpMiejLShVwTxuKzOLyQgUMww?=
 =?us-ascii?Q?4TsHqD3Q2vH42wQD9tUeW/0zR6mEPaiOhMcskJWh45WnPwmQcaNgqnaYjg6M?=
 =?us-ascii?Q?eIUj8VG8NNofUQuSHb1829F823mrl1hppvfq73GZ5Z/vtv8fTtzWcHwex+OC?=
 =?us-ascii?Q?Hhkt+goeYGyg/J+7OMrsni+G7Qs0P2/DUyhsOlPuqPvjaPUvglUyqO1iAB16?=
 =?us-ascii?Q?jbiNEnOxHAjU5FB2Ndq9nQoWh/gjEAHtTp2YW7UuHGZwa8dcnpqgJ14DOhMB?=
 =?us-ascii?Q?BG/KWwxpmcgMzXbPxZv1BAEC2TNUG5JVymIH3U4sarz3XRjWTPlLH6twARAt?=
 =?us-ascii?Q?1Kr7yySCA+l5Qsv9mngZoU0BEFd+P/LstU9wNM+fD2g7RvhcRfGHC/AZCKpq?=
 =?us-ascii?Q?46RgwC0igOOuRseAOjiMT+eLJC73f1OV5SmV9Q8MYf2lYvNWWXWmhs9bob18?=
 =?us-ascii?Q?sOIyhvVV7GUToPqaztSXgG9Rth797C3zpek9HiufKs+PSOK8pzf/ecnxuiEo?=
 =?us-ascii?Q?bzSpdTXrGxZZazaKEqxNE7y9G99rpSQyFTcz3XO9NpBfB/iToAvgcxHi+Hq1?=
 =?us-ascii?Q?CZG/vHoweVzYtvR75mttn+8i8BxYK1Q57f1dvDus08siwODhKLfaPmve3xUe?=
 =?us-ascii?Q?7T4PZOT46FMopxELUgEvQ0jfhZvgfKDYHN2mf5yI0/ASYxTXcxGtFHjkoLs0?=
 =?us-ascii?Q?ddH1v9FPT/pAD0iniHOnLz5lWcJ/QOAsCqWA1+YNtdV3ndQwHHWbm9PrGtmz?=
 =?us-ascii?Q?ik1K5y9IsQWZNVpBs4oybh7weG4vV1HC+BU+0T0+sZUUBb7MTpSkjJIbWwk/?=
 =?us-ascii?Q?TyWotPUqUcNf1rA0qfJXLI11aITkfQWpEkUgJP04WvP4RNeCaMyLbLOfW+XD?=
 =?us-ascii?Q?3MuTiy0JrOR177XRXOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51419705-30ec-47cd-f514-08ddb2cd4ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 03:15:01.9000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnUthMAZ4S+wP6Q98swR48CxB7ObsVfyLOn0ieJj/zFD4Kz00jLAZWcMdzP594rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

[Public]

Please ignore this patch, and I will update it for handling the shadow info=
 properly.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike =
Liang
> Sent: Monday, June 23, 2025 5:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH v3 04/11] drm/amdgpu: validate userq buffer virtual addre=
ss and
> size
>
> It needs to validate the userq object virtual address whether it is valid=
ated in vm
> mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 44 ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 +
> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 26 +++++++++++++
>  3 files changed, 72 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index acaea4416ed2..a20f7ccbe98e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -31,6 +31,8 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
>
> +#define amdgpu_userq_va_align(va) (va & AMDGPU_GMC_HOLE_MASK) >>
> +AMDGPU_GPU_PAGE_SHIFT
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)  {
>       int i;
> @@ -44,6 +46,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct
> amdgpu_device *adev)
>       return userq_ip_mask;
>  }
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                             u64 expected_size)
> +{
> +     struct amdgpu_bo_va_mapping *va_map;
> +     u64 user_addr;
> +     u64 size;
> +     int r;
> +
> +     user_addr =3D amdgpu_userq_va_align(addr);
> +     size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +     r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +     if (r)
> +             return r;
> +
> +     va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +     if (!va_map)
> +             goto out_err;
> +     /* Only validate the userq whether resident in the VM mapping range=
 */
> +     if (user_addr >=3D va_map->start &&
> +         (size !=3D 0 && user_addr + size - 1 <=3D va_map->last)) {
> +             amdgpu_bo_unreserve(vm->root.bo);
> +             return 0;
> +     }
> +
> +out_err:
> +     amdgpu_bo_unreserve(vm->root.bo);
> +     return -EINVAL;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                         struct amdgpu_usermode_queue *queue) @@ -391,6
> +423,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_us=
erq
> *args)
>               r =3D -EINVAL;
>               goto unlock;
>       }
> +     /* Validate the userq virtual address.*/
> +     if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, a=
rgs-
> >in.queue_size) ||
> +         amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va,
> PAGE_SIZE) ||
> +         amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va,
> PAGE_SIZE)) {
> +             drm_file_err(uq_mgr->file, "Usermode queue input virt addre=
ss is
> invalid\n");
> +             r =3D -EINVAL;
> +             goto unlock;
> +     }
>
>       queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL)=
;
>       if (!queue) {
> @@ -500,6 +540,10 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>                       return -EINVAL;
>               }
>
> +             /* As the queue_va and wptr_va etc are the useq cpu access =
address
> and they
> +              * are also come from the user space IOCTL request, so they=
 may
> need a access_ok()
> +              * check before trying accessing them.
> +              */
>               if (args->in.queue_va =3D=3D AMDGPU_BO_INVALID_OFFSET ||
>                   args->in.queue_va =3D=3D 0 ||
>                   args->in.queue_size =3D=3D 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index ec040c2fd6c9..704935ca0c36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -132,4 +132,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct
> amdgpu_device *adev,  int amdgpu_userq_start_sched_for_enforce_isolation(=
struct
> amdgpu_device *adev,
>                                                  u32 idx);
>
> +int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
> +                     u64 expected_size);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index dbacdfcb6f7b..32bb9c2689cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_type=
];
>       struct drm_amdgpu_userq_in *mqd_user =3D args_in;
>       struct amdgpu_mqd_prop *userq_props;
> +     struct amdgpu_gfx_shadow_info *shadow_info;
>       int r;
>
>       /* Structure to initialize MQD for userqueue using generic MQD init=
 function */
> @@ -231,6 +232,9 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       userq_props->doorbell_index =3D queue->doorbell_index;
>       userq_props->fence_address =3D queue->fence_drv->gpu_addr;
>
> +     if (adev->gfx.funcs->get_gfx_shadow_info)
> +             amdgpu_gfx_get_gfx_shadow_info(adev, shadow_info);
> +
>       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>               struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>
> @@ -247,6 +251,13 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>                       goto free_mqd;
>               }
>
> +             if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd-
> >eop_va,
> +                                     max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE))) {
> +                     drm_file_err(uq_mgr->file, "EOP VA is invalid\n");
> +                     r =3D -EINVAL;
> +                     goto free_mqd;
> +             }
> +
>               userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>               userq_props->hqd_pipe_priority =3D
> AMDGPU_GFX_PIPE_PRIO_NORMAL;
>               userq_props->hqd_queue_priority =3D
> AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> @@ -274,6 +285,14 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>               userq_props->tmz_queue =3D
>                       mqd_user->flags &
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +             if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11-
> >shadow_va,
> +                                     shadow_info->shadow_size)) {
> +                     drm_file_err(uq_mgr->file, "shadow VA is invalid\n"=
);
> +                     r =3D -EINVAL;
> +                     goto free_mqd;
> +             }
> +
>               kfree(mqd_gfx_v11);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>               struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11; @@
> -291,6 +310,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr
> *uq_mgr,
>                       goto free_mqd;
>               }
>
> +             if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11-
> >csa_va,
> +                                     shadow_info->csa_size)) {
> +                     drm_file_err(uq_mgr->file, "CSA VA is invalid\n");
> +                     r =3D -EINVAL;
> +                     goto free_mqd;
> +             }
> +
>               userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>               kfree(mqd_sdma_v11);
>       }
> --
> 2.34.1

