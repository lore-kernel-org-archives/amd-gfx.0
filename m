Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D98CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A148112F15;
	Mon,  1 Jun 2026 07:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GSU6wR22";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D15F112F14
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 07:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+mHxqpPtWLz02CXAuI+S5haJw1sYzSXfwFijkZdNmjDcFgwG5yge0KyOd1LkBRZlGxYYGnI+fnTkb5ObgRNpHKusP01eyOyGgjKHzhzlh/2xj/oA5mHY1kadIqmnzRSyyjA2fiLVOAVbqNsedg8L7dB5tO5AaDfZ7toLIbqmrc3+dSSzW8ZHqAUc5/Lbw2z1zTtOzCNxh85MiRGMIwZ2+L9j48YZ2F9aQ2k9O/AZPC+1FSFNnN3CN089FCmxGhUZzrzHpR3/PGlvf/XB/OIuyQ5dsj4ejSL11cmAsI5PGG7yvyzy0Y5RzNMK0zj5W4AmLawt145vd9iLY56quAneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baq4IS55MgA8UpplPaz3vNH9eSN6pkyLznwdt2vl1i0=;
 b=VRVbdHZV0PKUZ086sJZ79d8tVjEPGYK92VEFJz96zjky8rJ4VuwMHtx5Hd3eJu1aTvfNZPgPJGuDDMTTt51sG7qxRkuSxgyDtfdG1Golbo7E7gbspKhxAGSEDVc/+BkQ9XeUqU2SD7NiDDeQMAE1EyEXGtwLlL+ufWXF//w1Zxm9bYHNXjYZB0gf6ZIX9L80D/lCudLSCFkhwfvOCCgBr9za7CJDbMqXUf43TiVIqtdvzTYI8VxBtsefrNjQF4VmnTVsnKZQtcD7zYEueS9ChXSZ4kPJPtWAZG1Vpp0yg+nToxZxvxOlNInwZMTttUfI/8l+WpdeVvwYkbsagkv1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baq4IS55MgA8UpplPaz3vNH9eSN6pkyLznwdt2vl1i0=;
 b=GSU6wR22Q2Y2gCoVY0m3Gdj2VJxZYqUiSxAZaC99bijmQpucJRUbH0w/UDMicvDaLSUexNk0Y+7oexeUulLvKVwkQbUgNSMHh4+hSi7PeTRsOnz8as2w2kMsK8+rLcCcbcwyTZeriNmyhLDST0ftmy6wVaMv4WrbYpW11J9wLrc=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 07:45:40 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 07:45:40 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Thread-Topic: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
Thread-Index: AQHc74ODgiK2wpH6uki+rukYIp8+/bYpVHkg
Date: Mon, 1 Jun 2026 07:45:40 +0000
Message-ID: <DM6PR12MB2972E0714BA89B7B178CDB2882152@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260529155425.418803-1-asad.kamal@amd.com>
In-Reply-To: <20260529155425.418803-1-asad.kamal@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T07:39:17.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|DS0PR12MB7678:EE_
x-ms-office365-filtering-correlation-id: 5f574c46-3ff8-4fe1-8074-08debfb1c72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: K9Rj7CM+xQ80qOKb2bjR8KL7/os3ZRiJeHwyBbjV52BQAsanXGFTh+tO6+BjxK9AxagQHnsfasnEQKAqYdES/3zkn3AEbTSNnCe8EzqBr8+kG8bASxQdFGZyfGQaLzt3r8gdx0yPGFtIVAVGGoapRnjusK8W7CLes9l7gt7H3Bz5oWSoP2TTL+zI+b8Rhi3ouqzn5PpYDxbd+9+PWtOrYP+I2jTvVTsLp4LauPaF+1yZbRB8trrPFdqAKW7cDHiyLOU4LIdn11eGNmxtFXfwv2JwpkQNXo1rCNzsFy97HgXLWZQRZp6dw1zAQbvS2bB+7g1pjQWB4jEEtYw8zxbHmo2XcmzfTjVxTAau48hWEvl7vLIYzI/IGmQ5q/GlmWAuqXqD5ZQCLRElz9LApX5FDhHTs25+lTtw87qg++/QHbLRBbdojC8gLb73HPVjplbB+c/N41y50bNkStRnol1Ukzdk/MUMnsxVs97Gfec1sWm9ugNLHaUj2t+kWmI4xiWtfMKcsF9q/FiZ5ZxEb/8ObpnMlKk5+Xx7fDNn26iwZKhC4Utq04joR8CftpufpagJ5nc7HuvO1273pPxjaHtr7n+OWcFyVggY7IGGlGP1PW4hYzCjmD0xMY8c68b5tmMNr5EhJOt3j2mO80PccY9Oge+N6GRTHps+R9xIiuIkbwek1Hcd4rup8Rh+PeBD3XItfRQfhDPReRqtC3d4SeZt85HkpJgT0NYyeA4eEg0NGk2H5l6svZrjhPcm7lq2qnQd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V8N28TYrBFvtBIHAlLlQjLgTlph5CwE5aetuPcaWINRGGM9dhUnD6RKfr40t?=
 =?us-ascii?Q?Bo298Vd7bb5JhmGMfKV4huENPw5T/Db4p1TlX4kFeaDUy03G42MaQwbJQGOp?=
 =?us-ascii?Q?Fd6wuDbykDc2zbp0t0bJYyrDrLBPv0t/LORejEUimEUWqf+F344oJmp5Duoh?=
 =?us-ascii?Q?0m7LTCOpA0VUjqbo1hgpdrR8UY7EfAhy7mhLDoDH1rU75Lm+gRq0hb+PhJoU?=
 =?us-ascii?Q?MKw3wQcJKBLFH0YvN5yhjtqvBjJww95U/iIVhTU123Gyqb9WVVU3zAsVSFB1?=
 =?us-ascii?Q?huBA0qvpFI8qSEmK4VB/7nvB+WXUyxZVgsOATlhrv2qR6qhzdZdRbdoKrvI2?=
 =?us-ascii?Q?5UpvIqdL2hC3Ue/z3gJBak37LUfJubyfjEtlPRb3X5mbkzDrokN3bFf6ypAA?=
 =?us-ascii?Q?5OOh1beIzOzylmYIAQX16tU99Epsz01Nl3EGGhr+R/of2PvncYI6v9tiB7YF?=
 =?us-ascii?Q?6vBw2AuXHHfyU+BqnvlAwvbH+0Sjeey9eJ/iYO973BkKS0WJCR+UbZJEevrB?=
 =?us-ascii?Q?JtTe1w+aqfLOc3Bqmc9UF/6BRmwoXK1FYbSYWKu6D/4H8e2MXI59xhjyM/2U?=
 =?us-ascii?Q?L5NNOnjxzG/SPmdMw6rO1pre9LS4fJ8zDsw5N+kjSZKUb3L/LWuY4jkMtkiL?=
 =?us-ascii?Q?Kk1O+o7o+b3o8C3+hNmzstQr06ODF2DOYtZWvH4O8Ke8qlpg2jZpRXrohBfF?=
 =?us-ascii?Q?YYoUDC4I6LfbQyEa0mlVmd6roSqW2zcQdVpepLBzpjBN2xf7KhDd4nGpPmPa?=
 =?us-ascii?Q?q1WdBX+YBYmwuoqVsJhS1WoeB869cjNIrbR2re5V21kwOT6uAPHI55SCmNnm?=
 =?us-ascii?Q?1MaDfGQRwDua6M7a4UrxdDc76JSYdnLAtZViljonWydIHNK7PV50OcEnvc09?=
 =?us-ascii?Q?qYJpj9RDHLssDPWlrYhkipcn3cmoaDeCcOC4xmRf2E6RCBqSvJKUWRt2WP1T?=
 =?us-ascii?Q?6j402DAfWDYcSXh8fi8hgdkUOGi/R9aBUehpIcR7wpX3bw+18wo1R5YEgvM6?=
 =?us-ascii?Q?oQzrY3+sVIMdg5IBQFn4CvhxkI5Qz4qflhd2b073yVJqkWnbMhUzPBdUUe5h?=
 =?us-ascii?Q?yhLPg/6tqLeNmCCRyRjI3KySTTg9zaF2qgvv4rRNnm5uFJDGPpvxYgQZJUEr?=
 =?us-ascii?Q?R5we4+KuhJ7DXcLBb35PvBjsDzwg+wbKvL0/b2CXx4Mi0CnMNaKHu7SCaNKd?=
 =?us-ascii?Q?pZHwS7MPqxwO741UtAVd/CJ73ggQTndTIASMRHvv0TK5nH+Dd/sljclL7L+T?=
 =?us-ascii?Q?Uh4yxWO0pNPyrHgT/nCwafZXV3e6bp6sdi5/V17In3kGyejbuAVDHYGs3V7t?=
 =?us-ascii?Q?kYIGmb20MRj3ERuLzXLo7vpkkZC9SDgPKSdNzQRFDx23bspzitx8K9mWdJeh?=
 =?us-ascii?Q?6Ox6AyZ6Vjpj4MRTJIHnBbfJ+FWCbAAG5cocQIP+VuG4E60jJC1QAOLUFdR6?=
 =?us-ascii?Q?eN+EejAaxuTMuKz2aIWmp9CbDV+l7AuC0tVk6S7xuXusKH+NJGn7EJ1VKrnq?=
 =?us-ascii?Q?27ls3hCwy/OL/the92uGwqeHlaEP8FMU5z936usGm0RH/ONQAbQ0UiNORCrd?=
 =?us-ascii?Q?y8CaBU5lYr90b/CFunzsCLyFrt4NUS2mwMaD8s7ZLuTM+TCSvw/zkU58elRL?=
 =?us-ascii?Q?4VTlyxowpofKxh1akjPK2rTp8VpXDJLUHbQFhzyRdtvTex9D7iXyS/3KYliD?=
 =?us-ascii?Q?mBKUnVlTatIQp1urD6EhJNg3fKJ1pAuefiYIv5ZNjTNrR5WU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f574c46-3ff8-4fe1-8074-08debfb1c72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 07:45:40.4394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXJEnrUZBk0YkgeX0ptm46X82yeaHDLFPQr8ZA/OAA569r+4ZzOrDFVM5pxW7Vc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

Hi Asad,

Your patch doesn't seem to resolve the issue you're facing; I  think the co=
rrect logic should check the return value and the size variable
What's your opinion?

Here is the pseudocode:
ret =3D amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size=
);
if (ret < 0) {
    continue; // for next clock item.
} else if (ret =3D=3D 0) {
    // Check ret and size/PAGE_SIZE here to meet the requirements
} else {
 // go out to return.
}
Best Regards,
Kevin

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Friday, May 29, 2026 11:54 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH v2] drm/amd/pm: Stop pp_od_clk_voltage emit at PAGE_SIZE
>
> Stop appending OD sections in amdgpu_get_pp_od_clk_voltage() once the
> sysfs page is full, instead of checking every
> sysfs_emit_at() in SMU helpers
>
> v2: Drop the prior series that checked sysfs_emit_at() return values in e=
very
> SMU *_emit_clk_levels() helper and smu_cmn_print_*().
> (Kevin)
>
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 60db9b66d08c..03c95621fe2c 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -866,11 +866,15 @@ static ssize_t
> amdgpu_get_pp_od_clk_voltage(struct device *dev,
>       if (ret)
>               return ret;
>
> -     for (clk_index =3D 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_inde=
x++) {
> +     for (clk_index =3D 0; clk_index < ARRAY_SIZE(od_clocks); clk_index+=
+) {
> +             if (size >=3D PAGE_SIZE)
> +                     break;
>               amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index],
> buf, &size);
>       }
>
> -     if (size =3D=3D 0)
> +     if (size >=3D PAGE_SIZE)
> +             size =3D PAGE_SIZE;
> +     else if (size =3D=3D 0)
>               size =3D sysfs_emit(buf, "\n");
>
>       amdgpu_pm_put_access(adev);
> @@ -3915,12 +3919,17 @@ static int amdgpu_retrieve_od_settings(struct
> amdgpu_device *adev,
>       if (ret)
>               return ret;
>
> +     if (size >=3D PAGE_SIZE)
> +             goto out_pm_put;
> +
>       ret =3D amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
>       if (ret) {
>               size =3D ret;
>               goto out_pm_put;
>       }
> -     if (size =3D=3D 0)
> +     if (size >=3D PAGE_SIZE)
> +             size =3D PAGE_SIZE;
> +     else if (size =3D=3D 0)
>               size =3D sysfs_emit(buf, "\n");
>
>  out_pm_put:
> --
> 2.46.0

