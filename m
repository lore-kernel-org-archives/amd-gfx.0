Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BC606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kEXrZcL+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F21010E00A;
	Tue, 10 Nov 2026 02:07:35 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EB810E00A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 02:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKHb6QOlC8PkBiRLz5K8y9ylw7qM5gU/frCLacZ72GdZLHOtJOVem32/SmrC+9EP5GOvb5gIOaCIgy+8zPzDP+saykSWRf5ONfjd6rijopQz/G+Ak8fIYH1Ws7UcOnMh2PcCS5cGjD+ot5b6ciNNn82HStN1002GR/LD6Jj5Dq2POf5db/V1X0j4gd+YuSqlOjEoDQ2WsIw/pmhwk1fNDWwhl4iounYHQURewYXZuVc4Dy25UTJVMmPKSw4JFbuIjimpXk2LuWVgUxVPwYpWL3lSCVEhzePCrlzKGpOZSxWq5BaP1HAIIp4PMrr6yZC8SHtEgzXrGqPZ7/CtYr+HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePW1PelP0+u5qYXeED+rpy1qwBcuYL25TsIIzqCzunk=;
 b=fil6hXe4P4lsbcA3z2dEOBLAYk2gC8He6yHk+rOzE7H37fFZv+Uat6DDAlxyjhrh2rt1TwLMTpJiliHP/3clIsXN+MnLDdGoTr0BPk8zpAyuilF1MiqKmRtWI8Fm2c240NJGCXRSw57Ur9D73yTF5oWlzklR/S6yLyl/PunzZtcvgK3HJJa5ON+szr6AHpu4IT9IP7Y999bzi682daZwYrrJKoGFjvayCMgpjCyXT2QpH4A1qI12iWHJRVJbzT3KJzONo0RruxCQrTPVgmnOAJrK6axVSrvz+w9+PeBjZi1pKEjJ7JVbrT+KzhAlqJPe8mDT2hpiM77WxkUmNQtkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePW1PelP0+u5qYXeED+rpy1qwBcuYL25TsIIzqCzunk=;
 b=kEXrZcL+9UrnXbBqgA9gsLIZet4p8KlkXYU1S3ZtCG8Wl98m9Sgd4pjHxkQI5iLppbKzuQQafhGQ8imgDc5QJhH1foDJanmhv4g6SHQDe/mozWynVOrASlo5s3itQ0L90MmQ58fQim8ef0nVlHTHBiG6fLrbgeJznTnadZ7bR1I=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 02:06:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 02:06:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>, "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Zhu,
 Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Topic: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Index: AQHdbNKg8WRA1iiOA0C/E7rRJbyB/7cmlkMw
Date: Tue, 10 Nov 2026 02:06:34 +0000
Message-ID: <DM4PR12MB5152D1EC2A42EFEA5D53D0A6E3722@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-10T02:05:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB6653:EE_
x-ms-office365-filtering-correlation-id: dd0e0312-8167-4c9f-0d8d-08df3ecf3f2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|261026140227099003|261028144727099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: EURBRuGVEi+HrjopttJo74uOF7w+TtgHNbLd1IFovhIpehYTjK1ZFDIiWVnfb5jKWagU0b48sfqJpWSsodoLlAco/n4gGe/slSeN1OmvTN9pC2CBU85RcaJlXfs1l3rIV+LhC0HT6d5wR9/DKPnHnrS3q0dY4rnCai59wr1TBJdXP49AKALFKxUKlCkkvtIU9HYMkyeUss0U0oqY72oOSnFtoa1y8icMkeFhdD+rzoSIt0IzNi1ro07MdCk1V642m72mP6ZcD+BqQhuYfw1CUwCTcYwXUHavLOGU2qOwobHKrX1SBZiYSKk6rmLQZqB7IA5MW8lVejwpnHYrvrTKXcyaH0JHqubV4jIBdLt0GGMbasJbj1oevakB14OQZ5YJZjc5nmCOJZBThWk6R8HYJ9XmgDTJymuqIiMIdQW5RgBf6A+LrIa2Pig7pvxs0wU/rBqaovIWGMEDnzRvT/nVdcuzkdD3px996YLJO+yi6okwA4uRrLLA29FcGrSKno90wDHBiDO7tb76MFGAvFNcPmzLR7y15MUUiHexYyN5wSR85tF14DOgLAeg2v0AOgtX/omsRJo57lC222RcIzitFtdK1qKhoNz6rZ4hKIHYcvdlB/wlhTDGT/X7JNbeXOCQZru5XRkHFjCo/VG9gcClwgrZwMZtIGGUjwkL9WEDB6Uk74hmIzxsouACSL6OGlrQER/xfymhPwlxWAFb9dmV9Zsqeu73H8364Bh/EoSuCnQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4bHnKv2DpkS0yA6290l0x/xgr5VqxI2dNeZciQtUlKaqnny04aLu1L1MCyPc?=
 =?us-ascii?Q?tspu20c8Etn/dhfkdEbGu77xNW+ECH2sKCFWMiMnBG03AaHwcuMA9IvSTlVn?=
 =?us-ascii?Q?qaw9HM9x5U553lHQ2q88Yth1TBQgJ2QQgfdwjNfSN3Way4r7wz3zyVThqhxF?=
 =?us-ascii?Q?3+q6AUCbqZ0Hs93ry+7MSejtBLrPjfi4l0/MSvOf3SOWYw2Qazl+JlhHPB76?=
 =?us-ascii?Q?VsejXrdJC7VfRS8tPynR0qLdb06zv+MnJmFI6p4nO9avdtlQh9U3Vsc3um4U?=
 =?us-ascii?Q?yjdnzK2r6j85x/VavMFgfs/bn4/dr8VNFqrJ69dgEYxAiX8DrnP73S/VySXw?=
 =?us-ascii?Q?ipk6yQqMKaPXc1xRUD3GrRmpNr639x0kGLOP5xowhSxpACsb5wlCYgZ72S4F?=
 =?us-ascii?Q?Ly+6iQlPLvcB4ApStv1wxD7V9988JxZuRcNKhf7ZlB23ZX2niKABMuiuKpQ/?=
 =?us-ascii?Q?M8duZlnAyUhRjn5NHT5WGpEcXyowC0s/BPZRNBOQlMYzUzgnnwQJN9E9Mmp3?=
 =?us-ascii?Q?DJ28MEXtpI/nwrlP8IY++ib7X7sweJUDyg0oLkBmpJvLbhry6+1KlJ/pgkKO?=
 =?us-ascii?Q?jRSeajMbcLxUlKDOwCGBEQlNBVPf3gcDIdzX4DfZ8iaFAasSiKk47L7dn3EP?=
 =?us-ascii?Q?suUM84CeTvjhVIUEvB1rT2Ovjvdd/5h+zJ2Sr6mlYsjUrvTowQN72190/q7/?=
 =?us-ascii?Q?4YI9ejbYnsHs3I3k0669cdDXXfPfmid6qG8SLJXL9yXafuUhMUsgi+ltVBWq?=
 =?us-ascii?Q?2O7NElOviS0Zuc+csSdDAfHx2S8XBR+tMq6CjSxpjIfkelj5DEUdpPRDDnQU?=
 =?us-ascii?Q?4vyyo38MpHMgAhnFY0jP3vY//5zD9T3NoozSd0L/BDhbyHN4bMCCMxX8hzKb?=
 =?us-ascii?Q?acKvCyPahmAG5bafaEaljTbU4ubHNtK2tWds2oSkM9mynpaYLX3VIceSeKcl?=
 =?us-ascii?Q?myIwfGuIp8ZMnqksIlcxK7BqEQOMVNbSVSKI9fi9krYw6vLjHheelt/8xqvR?=
 =?us-ascii?Q?rN2C1wipREC7ABWR4vkiWcidJdBIBXpxtSz3GdLSFVR5GsIVTiSr+oViRIV7?=
 =?us-ascii?Q?7RGu4UElunQY0sdnwCyMUDvOOew6FfBclYao/sLfUp+Q3igDDZTO9TjbaD6i?=
 =?us-ascii?Q?c+5FPaPFbjPx7t5nqRWERSH3occDjAPEGrYa8QGPeqKx69ekY/2SRsjNa6rm?=
 =?us-ascii?Q?+ILK4/FqX8KPhdwhK+Et4+M654x+Lc7rZGhkNFGQ+k2c/7pZsUE8+ma5hAws?=
 =?us-ascii?Q?0G1Ts8wTfqVymVKQl0/t4IaoKm7UTouYA/TkXGycciBS+w2t4Y54f+X/wQc2?=
 =?us-ascii?Q?HgW/zvRw5a1cY64vlVXszAKavyK4Jg1k8tjWhwLSvTg+eAYdOuo3nCuVqZqb?=
 =?us-ascii?Q?qtuT7aev2yEJFgP4cZfiX3+xvhrAqBr1ylp2GJjb8/zJgx1wrk0KT2ZQQJ+x?=
 =?us-ascii?Q?677BjcVH4M0pikGL/9+DDuZKwD0ysDwHjJecQ9cWsdGRe225O0+MjPWCUic4?=
 =?us-ascii?Q?4Mva9GMFurZyR6WttIjL1ZxTWdBRCDrHDDnCti4B6h1kvqhYRwIx6Zg29XKk?=
 =?us-ascii?Q?oEaVWsJJ8N7fJzJfeBuQ40SFJoCQ3CeLyK1ayviYnqEyJYw4o+xENkZU2+fL?=
 =?us-ascii?Q?mDtNmTbQBu/EAqRIyFXSh6fXHa/X7JIPz13bdAtFsx9YPKzjppM+9szwaAKl?=
 =?us-ascii?Q?WiJtmPUPcrgmQRhCiPP8gjw0xIWZ0ZhHeKAcM+smFmR5MOXw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e0312-8167-4c9f-0d8d-08df3ecf3f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 02:06:34.8150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoeNrKA+D8W0lLZg1bwLGpxNMvDmJ3XUJgnsdd9iDI5+ShcIkmCJFGyLa7+JcSinGtjXFsxS3hIx1hdz0nswmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Ping on the series

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Thursday, November 5, 2026 11:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> timur.kristof@gmail.com; Mario Sopena-Novales
> <Mario.Novales@amd.com>; Rastogi, Manu <Manu.Rastogi@amd.com>;
> Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH v4 01/13] drm/amdgpu: pass the device to the multi ring
> reset helpers
>
> amdgpu_multi_ring_reset_helper_begin() and _end() take the device from th=
e
> guilty ring. A reset triggered by a hung user queue has no guilty kernel =
ring, so
> pass the device explicitly and allow a NULL guilty ring.
>
> No functional change.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++--
>  3 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 734f2a0bc79a..d0b0d3eaffc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
>       ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
>
>       amdgpu_device_lock_reset_domain(adev->reset_domain);
> -     amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring,
> guilty_fence);
> +     amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask,
> +guilty_ring, guilty_fence);
>
>       r =3D ip_block->version->funcs->soft_reset(ip_block);
>
> -     r =3D amdgpu_multi_ring_reset_helper_end(ring_type_mask,
> guilty_ring, r);
> +     r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> +guilty_ring, r);
>       amdgpu_device_unlock_reset_domain(adev->reset_domain);
>
>       if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b67e8cecca2..edae764eb0c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -919,8 +919,9 @@ int amdgpu_ring_reset_helper_end(struct
> amdgpu_ring *ring,
>  /**
>   * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a
> reset.
>   *
> + * @adev: amdgpu device
>   * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
>   * @guilty_fence: The fence which didn't signal on the guilty ring.
>   *
>   * Useful when performing a GPU reset method that affects @@ -938,11
> +939,11 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>   * After the reset is complete, the caller should then call
>   * amdgpu_multi_ring_reset_helper_end() to restore the rings.
>   */
> -void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> +                                       const u32 ring_type_mask,
>                                         struct amdgpu_ring *guilty_ring,
>                                         struct amdgpu_fence *guilty_fence=
)
> {
> -     struct amdgpu_device *adev =3D guilty_ring->adev;
>       struct amdgpu_fence *ring_guilty_fence;
>       struct amdgpu_ring *ring;
>       bool rings_busy;
> @@ -1034,8 +1035,9 @@ void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>  /**
>   * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a r=
eset.
>   *
> + * @adev: amdgpu device
>   * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
>   * @ret: Return code from the reset function.
>   *
>   * After calling amdgpu_multi_ring_reset_helper_begin()
> @@ -1046,10 +1048,10 @@ void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>   * be called to restore preemption state, but it won't attempt to
>   * fully restore the ring contents.
>   */
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +                                    const u32 ring_type_mask,
>                                      struct amdgpu_ring *guilty_ring, int=
 ret)  {
> -     struct amdgpu_device *adev =3D guilty_ring->adev;
>       struct amdgpu_ring *ring;
>       int i, r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b2040f80b7f2..7e6ed43771f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -637,10 +637,12 @@ void amdgpu_ring_reset_helper_begin(struct
> amdgpu_ring *ring,
>                                   struct amdgpu_fence *guilty_fence);  in=
t
> amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>                                struct amdgpu_fence *guilty_fence); -void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> +                                       const u32 ring_type_mask,
>                                         struct amdgpu_ring *guilty_ring,
>                                         struct amdgpu_fence *guilty_fence=
);
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +                                    const u32 ring_type_mask,
>                                      struct amdgpu_ring *guilty_ring, int=
 ret);
> bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
>                                        u32 reset_type);
> --
> 2.50.1

