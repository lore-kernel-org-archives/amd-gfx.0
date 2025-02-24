Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FFCC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 19:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787C510E04B;
	Mon, 24 Feb 2025 19:37:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGZFAFMI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7F710E04B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 19:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVu17EOZgO8fxuI+WZSRlf0fpk7R4I1xWk3rissIfWn2Ww4NCrVAWWD7teR7eGVmvhGh80QImO8vxyx8gbPt00ej5D2dX4uZgwzBIblwfinEPfJsPJ1umghE99Lp4mMmkDHSRrpytq04xUmvja8XzaBiiQtORImHnXJEeKGFcY118MoORC1tVJ91f5+C9S+sGCZ5dt+E9R6h2Fl5J/tz1W5N6gDz+L18gwi750YWNXK/A0lTIuRQ9+N4Tu4G2GiDKSnwGnO6JMbOi5L4MxP1XvdP8rrqIi4U/XCsrhNynn2b/8LceMlRIuuXb4pymPDApDJY9VreqTXfkZK3yiJp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp2BN32H8TvwbbijZ4CsW9SkRLbxlgXY32r9NIV195Y=;
 b=dI3L7Y5CSdiwrODp6dky794TJUIPfaDW7ZWWEy39xabtWGeYTMdjXTWWixm1N4iOxE2tpoxsuENlmzSAH68B1WlfNuIrnmZ1Ns1+CF+2neq+hcol8f+T298iVNapXPZ2GifclpobC0d6V13+fdOjY71UlTtPXgtQrzNcMBC0w5yDA6QksUl1eeJ02MfFD3SWzGPtTUmhuKXf8tRDYVpDGVKOPWIfmkz5HBYA7D1rP3wta+RfBGdqsTsUjQDtSo+ubH1Ri39RqJO+KPXkZQWkQ8dVP69G6UkEZhzQoM9ZJR5t51KldvwWq/iE3+b+mD7Yn0OdbdX8ILljeNvWx+Cimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp2BN32H8TvwbbijZ4CsW9SkRLbxlgXY32r9NIV195Y=;
 b=oGZFAFMI5jtBcn+4/j4XUk3u5Zx8kxVVGYSsA5gI4o6UFO2FBVLlpXI00NHgIAwGoLBg44sMkgCqDopH55z9R6A8DqYE67dtTLWrZe0XMn2PHuwg8KqswkWTuLHx7cfW+4hVWMihqNpUgFM4Z2aHgydzFxgOWj7Knjp/RxIcuOQ=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 19:37:20 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::8989:59a5:1a4a:60b8%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 19:37:20 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
Thread-Topic: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
Thread-Index: AQHbhICIphCEkV15okq2w5ahcQzFbLNW3XtQ
Date: Mon, 24 Feb 2025 19:37:20 +0000
Message-ID: <BL3PR12MB6425EDA1C0F692D744A1767AEEC02@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20250221164901.2731661-1-jonathan.kim@amd.com>
In-Reply-To: <20250221164901.2731661-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8139d3b1-621c-4b8a-b32c-77a4ca874073;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-24T19:36:54Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SN7PR12MB7788:EE_
x-ms-office365-filtering-correlation-id: 4615d6ff-035a-48b1-ac19-08dd550aa7a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4+PZ1ftgwfv4L2KhPKDWnkcH0XfNtg5CQxa6czQec82PJsUAHNE7HaUcSi/D?=
 =?us-ascii?Q?lBfLTOIJAr5v4muCSoD4BqmNThib4yZahAH9B6FkgWA+0HDZcneqEWIgilMS?=
 =?us-ascii?Q?szO5XlJGLH1eZxclPQWwX5OJkxXnBSy3w8IlDD5Y2ElgbnYjoWN8QlZSw067?=
 =?us-ascii?Q?rh5CyNj4MLei1gPyz/Ur73q33ERJnKvUocN589nMzs3Jy5X9h1JlXz4LfkrQ?=
 =?us-ascii?Q?TSUYcBjGVDLSxiZ4l/zPTgtZez7r4Zx3uWHDct+uoqOSXFJTAUXZhQC2DCRj?=
 =?us-ascii?Q?Sc0CEHjkd5jU7t0O8s71MgBP9PxlYUZLoTV7z6TNY1vHZ8DnRNPlaisU8ZeF?=
 =?us-ascii?Q?YxzKrT9xlZN32ZDENzxdv9grw05rlgwZYoA64tuGkwTizDDCNNkykhCiorfx?=
 =?us-ascii?Q?NyBDPfPxcABf2/JG36e8o1ExBAwzq/JWXNeWHd/dIftX9tl83EikDCNK8kmN?=
 =?us-ascii?Q?j9bCgeOhv9nLq4j0z2DwP5o0zuUu+X9gJSszyz4IJu29onmHhEQieggd4yB0?=
 =?us-ascii?Q?0f9aQzj0pZt6ehkDCk1PFHnmyuhriGpDivVxp+vkTTIiQBcAqFchtU8StsfH?=
 =?us-ascii?Q?x6fZnkTRHqRdcAvgx9enFtwoahVye2U5wX+h7bFWfwAyVwm7OQyJMyUmK0W4?=
 =?us-ascii?Q?ZEMSJWG4pJ+D/H5HlzAQPGr0IWDperHVFB3ZtfolqfSnppz5HsVYUMe0AnSC?=
 =?us-ascii?Q?DHJuno3LxLJvsB/ETlLoR9gFMXu+5QiXXE/Yy4/Zg15YSKufS6UOfyvT49Pp?=
 =?us-ascii?Q?3S3prix29Z89VANcic5Qcq+bLbQsHz5YRGxzFeyYsT/eBmbaLM0vvRHPg+If?=
 =?us-ascii?Q?QHnkR96OU49QBiXzycMaDRqaTknih2iEqPasv6BjsfkmEPRHPN2zcMR7zYuy?=
 =?us-ascii?Q?3sHDxc2RRLuSfVj+91f1qk1JHWTkmratctEkvyMcgVMfZS7hnY8Swgiy8v9r?=
 =?us-ascii?Q?o/jGmBjg+Qb1OV0jWTl1v90nTODlGT26lGtVm6mG6ZWm4DqrpMAVdK0q0jYX?=
 =?us-ascii?Q?wOqpfw+V1ObBxPC9rjIYOyVISfTebZGXKwwrf2NkklFUw36jPhDTziaByiwW?=
 =?us-ascii?Q?/9rZ9JjDKm83Zyrvn87nB56olGd6w8hO6zxrT6LgntJQvI0gEMpCq/ShZeuY?=
 =?us-ascii?Q?U0sLt5T4SQzxu9Onq1I+uX7ncMttsb8OhwRnKZ5iAmVIi7Oj3+qxPrVzOT1b?=
 =?us-ascii?Q?qMGMDGeWmN93PHkWeE9as7exwD8HoLJecjoz6pkPI4vXwnFprrDHpXeLi4um?=
 =?us-ascii?Q?cze9+WnaDGVv7gVndwOMMuTK3XfzS7o8g6vn5rGnVeieHMkVs7rfOTZfCERx?=
 =?us-ascii?Q?X9kVrnpTa3jTkfDXytm1gQPgth5G4m//9k9lT69tyr6puwMj0YUakSGlF2ct?=
 =?us-ascii?Q?0DpFvzprsZ/dNqE0qUjy9l2MnNg6dO3abi9OklkIUULn/Yc3p9AfmAYD9N3K?=
 =?us-ascii?Q?+tqfVg4ziKHmag7kKqJjYxuhhXCfd0sX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W45kZJYEW7zEXRFQLIlOx8MQaGchIvux3MIeHthgNJYXJcW7uWmQp6tTFzGO?=
 =?us-ascii?Q?x67ZNhIUn8SLGm7ho/4uU8GER3JmKXe84+vTQOHNIL300es1wbBRhnXlCgWI?=
 =?us-ascii?Q?IZhMMcrboaxUI0oSeIcCp8OhagwLfkb4LteH2du/ULGhy4QR8Rfges9cqaxg?=
 =?us-ascii?Q?atc16eGYl8BO/1+8342KBHoFG4KJLqEe508Zwl4PryCYeSd8sjKmurWLRgHg?=
 =?us-ascii?Q?bnU64PAsB8Z1Q1zl0h5UT4S53gh3ZunQX41CFm4YGL0RMJ3JwYSxAtfr0pD1?=
 =?us-ascii?Q?h9wEoCpAcytMVFg/y+9AXojEXq0fQLpL7aJWfSj82c0s9v8a/PEAZXaqZbAH?=
 =?us-ascii?Q?o1GFofykN3F1/WBXfpPSBSNX2w9Yg00leRJr2WfwxcA0XLseYflkyJivKJFa?=
 =?us-ascii?Q?yJs9HULei33J5b8b39S9dG1kRiO0PklkOONgpTEgG2lUCvT6H6b3JwWxJ4vv?=
 =?us-ascii?Q?IW4osGQTZgQBI+48tNlhyTXQHFsaGQ2sF/5H4t3s9EWB6iYKqy69Q52avLo4?=
 =?us-ascii?Q?m9Yvm9nkLo1vROcUnoKYRYuEvY7qfocwyetdETZuOEi+mlacVZRDoEvp9BY8?=
 =?us-ascii?Q?T/BsqB1Fy2TE+nUaE6QgGcCR8akuRY/0xCcorDuWc0kUaf5Dv/qUTZ13r3Pv?=
 =?us-ascii?Q?kTfoNCxVmwcnLtYZPVpcZ7/H/XBGRAV+LPS6eMGhsjasul8bVd5wgxvjZ+to?=
 =?us-ascii?Q?vOEONnGI0QgsoyMBqrWuFaJGeD81YFZiTjH4l+1enkHcFqmR0jQDmdjGG+ys?=
 =?us-ascii?Q?yvXvu9aI8kkz9T8595PVzhtv2GMOahxBOjcFeiKj5U8CFrbRcbwfqpgUqnfM?=
 =?us-ascii?Q?TAWkWA+1diQDrpY3F9hnulDIrer2H0xtttIPCGlRrjzWL5Z4i9k046lceJy4?=
 =?us-ascii?Q?a1nkp9vzr4pIIa+A15On3u2TMRU3v/AwAbid7cQwWbzMZ3KUqKvm+E0kQizs?=
 =?us-ascii?Q?6ofKqv7M043cSzZx43ZCqpSM2NlDjPtQX8oXBLvCLC3ld4948aim4AeSdfqA?=
 =?us-ascii?Q?Pq06FkugiebxFZ6R6/7aScMEXFFPfUm5hc90VHWYTs8zaQUIAxldY7483ZA2?=
 =?us-ascii?Q?k59T4OfArW6LbIOXfjHpaP0gowTxPU1ttaYujS/Px2qgF/5UJyr0vAduyQKB?=
 =?us-ascii?Q?cLWkvN+oesMPomw1TSpqkB6pMEPcVwXiC4n44JGuHMBgToGiCdRKoY/mKNdN?=
 =?us-ascii?Q?NRWkY7UJSN7U5waZgx9A6aMojobXvSOnB5WGW70Gn/fhBB/MrKd2T5Z3/0ya?=
 =?us-ascii?Q?9RCmRV6vZ89RKkwPVur9pwkE3CPaWp18hqEHqP0Fe7WBLrLM39SPjEpwW+bg?=
 =?us-ascii?Q?nd8gbOo/42IhFX52zVtSuHdD/J0xUm73beGMMq9R/b10gRq7C5DmgvMOBIde?=
 =?us-ascii?Q?JHVgdrk0jd2pQ/o4oFghkn6U6KC5hhMq3dFO7br5JlpjY+1Sd6yItuwOj36b?=
 =?us-ascii?Q?pm1uDvdkJqT66U30Zm9KjqKTfKV6zNU1twVdQbxTJkfYMTiONs61dNO+3jO+?=
 =?us-ascii?Q?JrqHKRLHM/+Jvw79LOu+G0L3IBlyh/YmK9c00puWoQPTtauzkj6lqKPAC/Gr?=
 =?us-ascii?Q?gYz3FAtnHpRMTZWHcyE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4615d6ff-035a-48b1-ac19-08dd550aa7a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 19:37:20.6944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXJm6GsACbDFOQFXZhdgaW789h9A6uZdsb4NVFaC7EUIauD0/B3ohRgHrHnnIz8IDoAtzpC1jfDo91/UjmhbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

Acked-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, February 21, 2025 11:49 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: enable cooperative launch on gfx12
>
> Even though GWS no longer exists, to maintain runtime usage for cooperati=
ve
> launch, SW set legacy GWS size.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9d20e169ec4a..095e73790dc4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -590,9 +590,13 @@ static int kfd_gws_init(struct kfd_node *node)
>                       && kfd->mec2_fw_version >=3D 0x6b) ||
>               (KFD_GC_VERSION(node) >=3D IP_VERSION(11, 0, 0)
>                       && KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
> -                     && mes_rev >=3D 68))))
> +                     && mes_rev >=3D 68) ||
> +             (KFD_GC_VERSION(node) >=3D IP_VERSION(12, 0, 0))))) {
> +             if (KFD_GC_VERSION(node) >=3D IP_VERSION(12, 0, 0))
> +                     node->adev->gds.gws_size =3D 64;
>               ret =3D amdgpu_amdkfd_alloc_gws(node->adev,
>                               node->adev->gds.gws_size, &node->gws);
> +     }
>
>       return ret;
>  }
> --
> 2.34.1

