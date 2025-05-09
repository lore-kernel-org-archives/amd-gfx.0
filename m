Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5F8C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 06:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B4810E9B6;
	Fri,  9 May 2025 06:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBgR2os3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0824410E9B6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 06:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEFvWZNir709hHLOQlu23qWG0IMkbwDZxTmpj3kvRMss/XPj5LQ3EpJLeNfiVwEY9uenGx2zjBumNHCHy5WgwswVT6O7rJZK4KSPyHsGzktUPSJ/oMwtuy/RIA8Ah3FeOqeImU1ZsDnfMlLrRkCGQqfiZbj6021r+f8v0quWXyE1oqY6R70CYpVK4KkclNDALiEwUtYvTLWuR3WQmQMtUv2CuRs8F9r+rzd6C9rmEY2+X6I+eSlRnlQvNLsg6J5Xz5WxVYF6Zd3fxdgTFmvd69otOcXKZIO68yN2LLehs50S1NJOCOTH2xVrJVrufM431BjwaT/LOfYHvMEKSq/OtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1d2+bHm3HI6+qra5K5GedpHKIV3qRcVmUSUJVsfgJ8=;
 b=lb6dkE9NDU7BvjcVBUXkzb6ieSZmLzHmgkeA+HD0bgAfnFhbMZUE0T2s8tHAjC3qlF2c34nSZW7E9Xwr9FiEw/3HlH7KDOZWjJsDk0Dfw8dAIM3YAYZ7FFYXhq6HqLSPMOkYq3qu97WJ1RRRlfEomBNiWcuhfkkAxA8c+7ag9g06Cn5y6tR4KLe8t4sFWvsISr74tgq7sxoaGmANsWIfWNzTWx1y+7Y5JsRQ7WtQ9T1i3siRYWbp0408ZaUiJLPGx+LClgFGIsN4XfAo1L+QZyJiMUuwJ6UwWeeeZzMEtQ48au4tc4E7b1/YXcadNrUfgKt5580KB/0DEsFlc+/Tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1d2+bHm3HI6+qra5K5GedpHKIV3qRcVmUSUJVsfgJ8=;
 b=sBgR2os3OXPk7eYcatAF6YMANrnCkDX0f9LgvX9jgW1hGSmvFl35qh02kqFP3jGWUp89S5+KYBoGu9HrR4Fu3/ZqAt9gfbNKLU54LoVkme1vFECC/t9bVwI12sNFL9p4Yb18FtROSyl+trnraErSPP4xjKCqDK7Q4jn8Bc2XaLc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 9 May
 2025 06:19:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Fri, 9 May 2025
 06:19:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbvwppORSPpQjxKUyQ/qedfvajqbPIeo2AgAFbQFA=
Date: Fri, 9 May 2025 06:19:51 +0000
Message-ID: <BN9PR12MB525754FD1CB54E142B15AD05FC8AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250507044159.1006093-1-shiwu.zhang@amd.com>
 <PH0PR12MB8773D3ADD8CD6D40D46D7127F98BA@PH0PR12MB8773.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB8773D3ADD8CD6D40D46D7127F98BA@PH0PR12MB8773.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1edc1c76-3d9b-40da-b3cd-3400b86ebdb6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T09:30:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN7PPFCEE68E7BF:EE_
x-ms-office365-filtering-correlation-id: 651298c9-9dcc-42b0-1d10-08dd8ec181fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rrBRuyXJidnEtQR7GTKqd32aIwTd1guDEIJOxct/UXnMLVQRcYwZC5pE5zqT?=
 =?us-ascii?Q?OnAxiEtasOioIR5iakWAZFkhKocjNDRXnOEpxYIEfkKL/0SyFelxmnPBG2hA?=
 =?us-ascii?Q?IXu3YUDwk75afm972ewsd9oalAJiGmyT/W8zbqJlVMWl4ufgbB0wbMFPOhNl?=
 =?us-ascii?Q?/9H3vT8ZH9sI0Rko/jhUbvJIrqsqSeIUkQI9gkkgIwAfEPUHmwmcNx0W3JOB?=
 =?us-ascii?Q?kZl32CXYx4Z8KrmDnEcYvS/dgKETWnSDOZyzFoQXmdh3q/1czN9fnm4bE/Q3?=
 =?us-ascii?Q?B1EtU+JeV6Nglr2W76wflEp3/l4QfFPJ5/4cSzDqLaLBfR97Sw0bBo0ixHDn?=
 =?us-ascii?Q?yujFwhSH/zDRoJB/eea4EARI2AycnOcyclZoiAgMD4p5v9y/7xdLZtW5Qg0T?=
 =?us-ascii?Q?wvOMluHQIfDXcL6SHoI+iwBm5rjLRzRQKNswOy7RXQRXka6eo+jmgriKV5fG?=
 =?us-ascii?Q?cl6b6ViHFRbLZ7tmyw2XkcfzccbzF5q6ghiNNk4sURQGkam5eQlVLViRlh1g?=
 =?us-ascii?Q?Xu5KtW8oeQHpUKazirmGjSAcAt0ZrdTqK4Pr0LpUy9XYgi49jnLs3I8sAZ/j?=
 =?us-ascii?Q?SD5YXWJ/jjkMKO/qlEkkzMW2hX9PsxNSlOw7V7SaLFVKlzhyfIKFKAlBkUf7?=
 =?us-ascii?Q?BQ3Oh+hYGrYbDnKgNEDPQ0O8x8eX1Z6tz0ld28n2HUt4fMVX6Au0woB13LTy?=
 =?us-ascii?Q?tjs1dYvUqJiFBdNKvgd86WqfEvOVYXRVTTBEu/Y1P6HIg8u4V6mEBZenmMR0?=
 =?us-ascii?Q?wRDwRT85oJhvx+hOHtruAFoP2b54Z1x45cojQ/1Bz5iwEF+JOzh/WWxvvxHp?=
 =?us-ascii?Q?+mz2rI4pVV261QsG95jvoYlfTaFEsXARtlv4i80wctgs3wu6mCq/CnO1yDyj?=
 =?us-ascii?Q?Z6ghlkpwtP5Ne1mvizv9fjzm0rk6IlMjQ7Ak5dbui3K8la2WB2eX62UaD3me?=
 =?us-ascii?Q?AsA9qQoXQGpxrlPQ5xtuxR4hfDhz6fSvG9vyHlpEoMPuHvt/zBECBGJTFkRD?=
 =?us-ascii?Q?L5uprle3q9TKoEiklAZ9QBbAq40OnfecMnSISx9IfqaD3ySQIS/hASkvX03c?=
 =?us-ascii?Q?w75Kt6qTzNaI8fLvVfZkNNN2uBcQdP7yFlHEAfMqAtMFhMKNagCPGV54Rb3R?=
 =?us-ascii?Q?DYzKjE1nEUSLQW83rPLYUfkwr0LyBX/rMOI0RU9B58wI1oSnK5ML8SZelN9a?=
 =?us-ascii?Q?JqIElKG+8Tg+JghSerxF7hexCSIsConEb6qatvM3j+7N5DZd4gje6U/5am17?=
 =?us-ascii?Q?kJ2tVoKbIzJ8b7XlTrRKn5HvKCekzCWXRjHqKjzBXWZh8T6kVcMk+0LRfPS1?=
 =?us-ascii?Q?aexARk4qaPCzfZbnvCm5BMTYm8fOzhOKBsYEL+lJ1zeO66Se2XMJnSobiVZm?=
 =?us-ascii?Q?D/VHaxd7toe73PkcYuDlCCbsT1e8GEgwM9bLADXolIAm8Lf6aUvTFitCQxy+?=
 =?us-ascii?Q?Rq/DmNIGZ1gtW0mPAHsge90zoPBSsqLtgRfNMspIQh1QFt0hYMuIxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ccBXto0O2+2+k0Zq890jmmK+L1V15kajkyGS5c28+qScNWspHMbzB7ua7apt?=
 =?us-ascii?Q?ZvYSOmMX/X91KeZlJosL0GTxuF/t5hBbYk3MsjPwAQmEhoZHw5THLeDBNmjn?=
 =?us-ascii?Q?ZrUX8zU2Pv2zi9n3rxh4VD56TbJ5qYDpAf+dQ2xTj5bO8Z78LrnUveGcNHCF?=
 =?us-ascii?Q?vXpgphcuZDrmJuGy8tH3Ds1qNzvpfHkzJlYGky4QeW0qFmkuVC47e+Yr+X+B?=
 =?us-ascii?Q?Ag4cK1Dz4XoBUJfFDNxzrli7qMyGHS5bPJbZJ4Nn2KcqN3Vui+sQB3/uhWIu?=
 =?us-ascii?Q?fQqpgHhPZz9AqkcAiXsfp0RhPbDLTpNyiF8QG/FgJKPhKIkN3/5wbC5RfsJk?=
 =?us-ascii?Q?Nvx9jeSUBNNBZd/lR49wjceiLZvPWRe+xGm0Tk3HKwNk/GRdTW4asyBrtPet?=
 =?us-ascii?Q?QYAYuWb7bw/EEjTSCz17dBaIW9xvk4lpOZ+N/3Qe3NbEcRtoZ+VcOCduYltz?=
 =?us-ascii?Q?HxqORIHYrDe/jXPvigk0VDpYMWKuyyNOHJwdUNQiRRL3gxEfmyW0cQnZwZ2s?=
 =?us-ascii?Q?GSgjDMlKH6cPGpehGErm4SE2TGZpia0odawF/l0zJtZvqOsXR9B6MAacNdjO?=
 =?us-ascii?Q?eWOSHey7sVoodG+nfjcNvQMxNj3BShOZd3Ak3EATh3HiMVm5WiyouUSROr9m?=
 =?us-ascii?Q?F58yj9ZlG8VBxtV0ssZJ4XoycM51foYy3UgIl77gEHIImV52/f4jiXr2As+u?=
 =?us-ascii?Q?q064E71wzcMWzjDFQ9o1XVuMmjT4GqwgTG04tiPByqlaO2wnS4h6DNpt72h2?=
 =?us-ascii?Q?zZOTKvpifNl1PiROHu0nC8NRV94TD71yfeZsYxL7gGkq359K+9HYF5oUjkHK?=
 =?us-ascii?Q?6UIev8+I1Axlm7mSfJmx9BDkLkuVLNAf8H8qkFIcQHvaWOKGgtpq9ZNYtDZJ?=
 =?us-ascii?Q?mCaC6TnN1NDeqbdh/B3qcBoDq6UbdjWOAz9miABniHJfbwzzBcyk2BZtbhls?=
 =?us-ascii?Q?b3nvZ+tbRzmysfDmlvYrex3UYnm6C0XAqrvnxXL4WGYHpxDrFutz62pLxvED?=
 =?us-ascii?Q?bTHZjV890kbu4hoz167wfkyBv2kg6LtgzFCeVKewcqXbnhfMKC1dHQ248jTB?=
 =?us-ascii?Q?50HLaDdzRVBDOHO6RzvcM/RGlOcKZkOOmpwujwn/G3jNogxy/pAOP7Exg/ok?=
 =?us-ascii?Q?ppi8P5j4ty0dcz5DFNQB8qSdQ4yn7IrhPJoEGsEeLrE+DBb7d1stz+BfSUEZ?=
 =?us-ascii?Q?ytvud7YJUjc4zE9kyKkMTOxj+2bnm7K0t1qryE77AEi4S4/mpFOwJ0MzNWD8?=
 =?us-ascii?Q?sm2GJ7GxcIFVvmLUkVnXTjLB+xXhv9RCydrH2mAGb9tlrvFVV2trUYq0gS3q?=
 =?us-ascii?Q?kbXTwC7mybdiqLwZNQdpsF2yR5xt02ztC05v0aZXJK5XHfhfMDdGPm6rLnKe?=
 =?us-ascii?Q?4NNvIfFifs/+l2kaiei5+/gw23SvWc/FHdrzkm8YBihw3EsnPCz5BUXxmdHy?=
 =?us-ascii?Q?vdLXX0Q/tq1xcVvB8cIDaD2s4qYplLYIBuUGQrT9baRgSANQFC6VVZI7iyGa?=
 =?us-ascii?Q?iYY8Xqj22W+BqjKwJteO8w6fE6e+6rQ9BWty2pXVI7kWzcPocAPxUqyyA/WC?=
 =?us-ascii?Q?UD1lxabKYxYK/V+rRxs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651298c9-9dcc-42b0-1d10-08dd8ec181fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:19:51.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9HQEIBPj+eplrkieY3JnoXg8JP1Vn0qGPbHbP7R/V458TnhUZZBF7bL5fsKdWqJb6BZFQWH/PC6ypuBsi8Ry3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF
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

Hi Morris,

I will review the change later today. At first glance, it seems that some i=
mplementations are not included in the patch. For example, I couldn't find =
the implementation of simple_read_from_buffer. Did I miss something?

+       return simple_read_from_buffer(buf,
+                                      size,
+                                      pos, bo_triplet->cpu_addr,
+                                      AMD_VBIOS_FILE_MAX_SIZE_B * 2); }

Regards,
Hawking
-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com>
Sent: Thursday, May 8, 2025 17:34
To: Zhang, Morris <Shiwu.Zhang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.=
com>; Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump

[AMD Official Use Only - AMD Internal Distribution Only]

Ping. Thanks!

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shiwu Zhang
> Sent: Wednesday, May 7, 2025 12:42 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun
> <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> Expose the debugfs file node for user space to dump the IFWI image on spi=
rom.
>
> For one transaction between PSP and host, it will read out the images
> on both active and inactive partitions so a buffer with two times the
> size of maximum IFWI image (currently 16MByte) is needed.
>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  17 ++++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  40 +++++++-
>  4 files changed, 161 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4835123c99f3..bfa3b1519d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>       amdgpu_rap_debugfs_init(adev);
>       amdgpu_securedisplay_debugfs_init(adev);
>       amdgpu_fw_attestation_debugfs_init(adev);
> +     amdgpu_psp_debugfs_init(adev);
>
>       debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>                           &amdgpu_evict_vram_fops); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6f9bcffda875..210a7bdda332 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4185,6 +4185,110 @@ const struct attribute_group
> amdgpu_flash_attr_group =3D {
>       .is_visible =3D amdgpu_flash_attr_is_visible,  };
>
> +#if defined(CONFIG_DEBUG_FS)
> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct
> +file *filp) {
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet;
> +     int ret;
> +
> +     /* serialize the open() file calling */
> +     if (!mutex_trylock(&adev->psp.mutex))
> +             return -EBUSY;
> +
> +     /*
> +      * make sure only one userpace process is alive for dumping so that
> +      * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is
> consumed.
> +      * let's say the case where one process try opening the file while
> +      * another one has proceeded to read or release. In this way, elimi=
nate
> +      * the use of mutex for read() or release() callback as well.
> +      */
> +     if (adev->psp.spirom_dump_trip) {
> +             mutex_unlock(&adev->psp.mutex);
> +             return -EBUSY;
> +     }
> +
> +     bo_triplet =3D kzalloc(sizeof(struct bo_address_triplet), GFP_KERNE=
L);
> +     if (!bo_triplet) {
> +             mutex_unlock(&adev->psp.mutex);
> +             return -ENOMEM;
> +     }
> +
> +     ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2=
,
> +                                     AMDGPU_GPU_PAGE_SIZE,
> +                                     AMDGPU_GEM_DOMAIN_GTT,
> +                                     &bo_triplet->bo,
> +                                     &bo_triplet->mc_addr,
> +                                     &bo_triplet->cpu_addr);
> +     if (ret)
> +             goto rel_trip;
> +
> +     ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> +     if (ret)
> +             goto rel_bo;
> +
> +     adev->psp.spirom_dump_trip =3D bo_triplet;
> +     mutex_unlock(&adev->psp.mutex);
> +     return 0;
> +rel_bo:
> +     amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +                           &bo_triplet->cpu_addr);
> +rel_trip:
> +     kfree(bo_triplet);
> +     mutex_unlock(&adev->psp.mutex);
> +     dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
> +     return ret;
> +}
> +
> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char
> +__user *buf,
> size_t size,
> +                             loff_t *pos) {
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet =3D
> +adev->psp.spirom_dump_trip;
> +
> +     if (!bo_triplet)
> +             return -EINVAL;
> +
> +     return simple_read_from_buffer(buf,
> +                                    size,
> +                                    pos, bo_triplet->cpu_addr,
> +                                    AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
> +
> +static int psp_read_spirom_debugfs_release(struct inode *inode,
> +struct file *filp) {
> +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> +     struct bo_address_triplet *bo_triplet =3D
> +adev->psp.spirom_dump_trip;
> +
> +     if (bo_triplet) {
> +             amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr=
,
> +                                   &bo_triplet->cpu_addr);
> +             kfree(bo_triplet);
> +     }
> +
> +     adev->psp.spirom_dump_trip =3D NULL;
> +     return 0;
> +}
> +
> +static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
> +     .owner =3D THIS_MODULE,
> +     .open =3D psp_read_spirom_debugfs_open,
> +     .read =3D psp_read_spirom_debugfs_read,
> +     .release =3D psp_read_spirom_debugfs_release,
> +     .llseek =3D default_llseek,
> +};
> +#endif
> +
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
> +defined(CONFIG_DEBUG_FS)
> +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> +
> +     debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_ro=
ot,
> +                             adev, &psp_dump_spirom_debugfs_ops,
> AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +#endif }
> +
>  const struct amd_ip_funcs psp_ip_funcs =3D {
>       .name =3D "psp",
>       .early_init =3D psp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3876ac57ce62..8fc4a7bb865e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -138,6 +138,7 @@ struct psp_funcs {
>       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
>       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>       int (*update_spirom)(struct psp_context *psp, uint64_t
> fw_pri_mc_addr);
> +     int (*dump_spirom)(struct psp_context *psp, uint64_t
> + fw_pri_mc_addr);
>       int (*vbflash_stat)(struct psp_context *psp);
>       int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>       bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6
> +323,14 @@ struct psp_runtime_scpm_entry {
>       enum psp_runtime_scpm_authentication scpm_status;  };
>
> +#if defined(CONFIG_DEBUG_FS)
> +struct bo_address_triplet {
> +     struct amdgpu_bo *bo;
> +     uint64_t mc_addr;
> +     void *cpu_addr;
> +};
> +#endif
> +
>  struct psp_context {
>       struct amdgpu_device            *adev;
>       struct psp_ring                 km_ring;
> @@ -409,6 +418,9 @@ struct psp_context {
>       char                            *vbflash_tmp_buf;
>       size_t                          vbflash_image_size;
>       bool                            vbflash_done;
> +#if defined(CONFIG_DEBUG_FS)
> +     struct bo_address_triplet       *spirom_dump_trip;
> +#endif
>  };
>
>  struct amdgpu_psp_funcs {
> @@ -467,6 +479,10 @@ struct amdgpu_psp_funcs {
>       ((psp)->funcs->update_spirom ? \
>       (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> +     ((psp)->funcs->dump_spirom ? \
> +     (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> +
>  #define psp_vbflash_status(psp) \
>       ((psp)->funcs->vbflash_stat ? \
>       (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +594,7 @@
> int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
> bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);  int
> amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>                                  enum psp_reg_prog_id id);
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 17f1ccd8bd53..78f434f84c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>  #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2  #define
> C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3  #define
> C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
> +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
> +C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US        3000000
> @@ -710,7 +713,8 @@ static int psp_v13_0_exec_spi_cmd(struct
> psp_context *psp, int cmd)
>       /* Ring the doorbell */
>       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>
> -     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> +     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> +         cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>               ret =3D psp_wait_for_spirom_update(psp,
> SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>                                                MBOX_READY_FLAG,
> MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>       else
> @@ -766,6 +770,39 @@ static int psp_v13_0_update_spirom(struct
> psp_context *psp,
>       return 0;
>  }
>
> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> +                                uint64_t fw_pri_mc_addr) {
> +     struct amdgpu_device *adev =3D psp->adev;
> +     int ret;
> +
> +     /* Confirm PSP is ready to start */
> +     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_115),
> +                        MBOX_READY_FLAG, MBOX_READY_MASK, false);
> +     if (ret) {
> +             dev_err(adev->dev, "PSP Not ready to start processing,
> + ret =3D %d",
> ret);
> +             return ret;
> +     }
> +
> +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> +lower_32_bits(fw_pri_mc_addr));
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> +     if (ret)
> +             return ret;
> +
> +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> +upper_32_bits(fw_pri_mc_addr));
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> +     if (ret)
> +             return ret;
> +
> +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
> +     if (ret)
> +             return ret;
> +
> +     return 0;
> +}
> +
>  static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
>       struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +935,7 @@
> static const struct psp_funcs psp_v13_0_funcs =3D {
>       .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
>       .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
>       .update_spirom =3D psp_v13_0_update_spirom,
> +     .dump_spirom =3D psp_v13_0_dump_spirom,
>       .vbflash_stat =3D psp_v13_0_vbflash_status,
>       .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
>       .get_ras_capability =3D psp_v13_0_get_ras_capability,
> --
> 2.34.1


