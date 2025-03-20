Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3CDC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 12:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9940C10E5FF;
	Thu, 20 Mar 2025 12:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bUUFv2/k";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F128A10E5FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 12:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxahCOgOOCGNgm9n55Pc8kTh8IQVxPM3D2G0MCNB1Kq0oC/p4B7DrZXy67k6eCgfK3/E5kQiUs204KQuMdrJJrCYhPYjgw6NTWgqXqcGpvqZssjBf4nK0XpWy3rVMmoBXohJBaASdaqWFDxJD+mSlVIan9LUqbBOVOJ6ZRcGS0nNTB5rEld/glN0KGNpnG9PSGsQICyHrQGlGLr00XI6xIt/YhBuKTg5VmjFyr8xnIdRwDirYJvtiHdr7j/GLeM6CSreR6jskaiNLQIOtp6MCijpUwcX4/sUudmNaHG3eUzhw4mftuNb8NrbfR4Ca5ECePQcrDpQOB8AOpba6rp0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFrcxUkds/YKkGGy/vfniFPSgfPExrqz4929Uc5mRvU=;
 b=VsYOLnGCxAXl3XrJfTmigGU/mSBwsTV4KaPxJn1ilizi29u2S5knC4PSw9ARdIN+pY3Q6x0atx3djrYsceB1V98OGJc3ix32Mx1QlAOFPSflokmPuJzkca5QoQjNh8bhCu5ETPZdA5rbUBs0IiRuuQFTQAZ90324InwFFbpezCMMTpqW6OTauXkTZ3s4x5V0IDcLuxczZCExJuzCeKdE51sQWz/m/eucQ9ysTbs7APs3mwy/kDixBkOJb36S9CDdNK+MqdVKY1WGBMn7NaaA9sRyX5xnerq/YW+3fKoW3kw7prDGwsgt3TNbrOJs54uzNk1iAbj0cbX77TuO1svlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFrcxUkds/YKkGGy/vfniFPSgfPExrqz4929Uc5mRvU=;
 b=bUUFv2/kuwoULVtgZutJaEJk7iS9qh4TM6AOm833gB22UjcPHNByPcGvq1eCRPrzCGcy6iJu1eRtxXJhXjR8FcljxydzJluOFngzXaspyhjCZTCyFiDdF6RsHQNx5FgqwGLkk+/7/Q7o7/oOeko7/HZ39bLEEFub2sMwGMeF5nk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 12:06:01 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:06:01 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu/mes: clean up SDMA HQD loop
Thread-Topic: [PATCH 4/4] drm/amdgpu/mes: clean up SDMA HQD loop
Thread-Index: AQHbmQJrG6M3D0DEa0WYfSfOeSz0+rN77kCg
Date: Thu, 20 Mar 2025 12:06:01 +0000
Message-ID: <DS7PR12MB6005783F8DFC90A8BD41101CFBD82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <20250319190850.3899718-4-alexander.deucher@amd.com>
In-Reply-To: <20250319190850.3899718-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=8ffd71d4-8596-4364-86b8-fb05a99c7299;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-20T12:04:25Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV3PR12MB9143:EE_
x-ms-office365-filtering-correlation-id: 466f5887-a698-432a-da3d-08dd67a7951b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?WcPAQfWuZRXrMPVVwJnVHRv/gNJHfaOYFUcP36VCSStL018fgtBkyygTnPYB?=
 =?us-ascii?Q?G0PTHoW0U0G01SA0Y0cMG9z4xQqfP86ooti4tBHsDal5VZbomuRtk08L9Qyc?=
 =?us-ascii?Q?/o4NR0/BB+YlwT741NtBW9J5+77nOxGV2e2bgOcIQP+WMiBRvKC2XjuOja28?=
 =?us-ascii?Q?hzqRKkFSoMWHVWHtPC23YjoZAmC7shtFCQzzDdtjzuGLjPM/qnpC/qvscN/c?=
 =?us-ascii?Q?IHdCL7jMbsDA2qbBqeIyDwg7GtBMTLzpJ5q0GgcUWHY5PXvepYVX5ZheSCxB?=
 =?us-ascii?Q?MR8A0PQ09gGn/sRyOhUeUwj3mOre1nxZfn72lTRB95+PxqRvWjaGJFLLVR3J?=
 =?us-ascii?Q?pU4lKA5DqY4zMHpFUVYj+nSuX0NnXdptj8/S3noB0e0E2+bbu4+JMVl+h1BS?=
 =?us-ascii?Q?DZOHJ2vhZSkbAX+Nwr/mxn7Btqz8jtvKJS+xSmt1zIp+UTot0abQHhHh/V9c?=
 =?us-ascii?Q?qRQkBp1EHo6q5mkgPZjUwfa44ez784QGy5NSZBsMUpE+rwFEMgY8oQ8HoHRC?=
 =?us-ascii?Q?fbOELb7sUXLrYOUsGAwjj0GJZqIutNfkuZKH6JYto9LlcHym6m7Z65Hst2jy?=
 =?us-ascii?Q?2yT0TR9/WG/Ed90Nvk1K2Aw07dDBP7e0Bd8vG12ABX8nwgargVuEYVduyZJK?=
 =?us-ascii?Q?lmNTyAvWwkuNGqIIvzHjbCRWm66U8AW7Y0lEgsHLddiZRX1bw8ZAHMakmkeC?=
 =?us-ascii?Q?X8yDk8WKBCCcWzKl6+g128zZavAwffXGYdA48ct/JPErQSRDmqWiWIb88B3/?=
 =?us-ascii?Q?KDWQSfiycX0cCJGRnBkD3z2QUn8jq+HSyMDhVqm8spSevgD959JqbgAD7jMl?=
 =?us-ascii?Q?praxFry2FsQNsed2TawNa/1qS8BOtRtkAWCz1qNJ3V9mz1RfvAVdBmpuh37z?=
 =?us-ascii?Q?N+h7Afld1fNd/Su2IyXQ0QntJI9tEm4dQ9Rt3AMZkE9r7g21nQRWAZBWpKB4?=
 =?us-ascii?Q?dQ+/dfLVt8AMJGzJw0jx0XITxLZ/9t0haUvGSmOt894FmecJiA2UA3HoEIhF?=
 =?us-ascii?Q?Ez/paaHLnKhj/fBYwRLAIKI2oV340PJ2+E0nDyft035lYjOXD41N97nzgyqh?=
 =?us-ascii?Q?p/5q2djUEGefqjCs1IUS5ZjaxYs9xa7u3tDPq1+x/iGvwOH7PfptKmEn/LoC?=
 =?us-ascii?Q?u6hh2TNY4VsRWbQLpYqYhr0OM2AKK4kFk5AtEGxOPh2YWCZN2DuCqgEiKzac?=
 =?us-ascii?Q?Cwbh4rK/tlZOb7uaPBJjjYpkliVzdHmB8xr6ncgJrkHBIdXoo2XQIfFCPkUt?=
 =?us-ascii?Q?5q0tTSTrzNMFnzTpZsaqTlnFO4TYtoRhr0oIkb4AnNpDuONlJ/iJFZy3DbiX?=
 =?us-ascii?Q?eAax2CcJw9Auk59x6n/c2X23dz6pJxbjRMPlF71R/xfiHLE/PiRZK/mVE088?=
 =?us-ascii?Q?YxUT4bmqfZz+HslmjFjMaodLkb5I5liZ9PJUquFhGkzCMvZWqc2s0JQ79qJB?=
 =?us-ascii?Q?KPT5mDMlBdbfr3OfuSZ2wIV3vCG7dbMz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2MT8SBlNCACmvlMWr9bozAvEtEu2B0MHkgV6ZC58YxKsbtFpeatTCJfSzk+3?=
 =?us-ascii?Q?dE14TZLL0GaNIdmeFAkceDvcfCYrPTf8pdHY/G85XqeZeuVl+Y0XoQLZKwAi?=
 =?us-ascii?Q?pNf+a19lcIQkv3NTdPbab3pR7l6SFOAnD8Bl6P3eibRemppsTQTBS9x9VY1G?=
 =?us-ascii?Q?vPUGXXZsXujF9uaUu8ZkoTWfzWEQt3LNp1JNz549E7UZ5jsxnbXPVqB+4w78?=
 =?us-ascii?Q?TlejLg83bzamI4zuXWDeeLY0o2w+JlF9igyoZ7enjjSLu/d90VhA6NPkj225?=
 =?us-ascii?Q?GeP6395lVBacQj0ndIpAXB2yO59AkDSEP4+84wi1bVwRNR99vAz0u/MhoN0b?=
 =?us-ascii?Q?uwZqRNZ07SqkqurJ4zfUW3hrtDz6U5i1NTmG5v/tsyxgkU5tdeuPzKIKLISo?=
 =?us-ascii?Q?ONtgnfsAOgtZ82pBiZc8sWr5dmrKUEBnXSLhDi9axWkKuS3TtwTApOyUIUhW?=
 =?us-ascii?Q?2LpW1gF+vVj4LwdLUauxvrPhbUnZWsM8KH4K845Y+W9q+5HyL1qfK7Y8Rpqz?=
 =?us-ascii?Q?bnQV275bU7dBeGeueVOjYhqxTwlSMcmA/oKl6lxztgfjDY8vYuznc0Gs+S3p?=
 =?us-ascii?Q?1zdp5acr3EQMBJmvW9opoEhw8Ka2I+rPrXe7O4decaMBiK/Y6DfpCNo9wGrj?=
 =?us-ascii?Q?+/3qRCRVpHV3jAklUcRrypgYGTdEnPbBM6EfacCGNFAoFMyAuFVg7OeqPSql?=
 =?us-ascii?Q?B3V1PUpy25SzYXolkZUcpu+nz57A4t/D1QzJecuH3SH20QhIOX9E6UPJ4B6e?=
 =?us-ascii?Q?bZiVnJU4u+4ABltqGPdG4VQVh3hnwMew7q4YEnj4J7bED6G4HTA4Ny4DUd31?=
 =?us-ascii?Q?2d6GhRdPlpwLK+GZCzN92Fkeeq0/tQQnYm6ZlPVR9kBU7vZexBegb6i0tB3L?=
 =?us-ascii?Q?547PwJIrsiZ+hB+QxufyBTTDrua1htGPbDGW3/2B+idBrnu1rAYaycNN0M+E?=
 =?us-ascii?Q?guzZS1URIflmVtwjLk0m1djEz0ZQTnxmDPF9Z44EtroAKIQklCtROUUZPvsa?=
 =?us-ascii?Q?mymTlCapVsaRTKT7QnLGWBIxyIbB22zWOJMXnVjUtt909BmF9Vy55eYhKIKV?=
 =?us-ascii?Q?hsnznTmseC0f1M90Cd07rGMb5c8afZlmlsSG72nHtAH937DyLF30WnpuzdRE?=
 =?us-ascii?Q?vn7jOlykBN0GB7fYVBliet/rui3m/b/sTtteKcnEDnOfn5zzSOCxQ9Tp0Bvj?=
 =?us-ascii?Q?IZIeFMCqYQMnBMtB3V9zLwiciXrXxxR3TEMmorrF7G90echksaXOQUjQTqei?=
 =?us-ascii?Q?0Is4lUH1Mppq7XiV5p8t6R/V6yqMlKynA+TMqNhqTplFJndmazN2xEuSuX5n?=
 =?us-ascii?Q?/m0Q7bpOb0lkC0BCr5qw3gM3AtN5SS4JUcSCxNeymOQMk2jfq0xMUyw0FkzP?=
 =?us-ascii?Q?3iZn7Gav1vu71hyetlQxFutCbq3Af0aYf43cF9BHONSSRHchxgPw/7azqq62?=
 =?us-ascii?Q?8qCNeLGslamPRwvXxdVzMjf0poL2XFgFcw3ZqEMT9vSRHLZVj5abVsVUoJOZ?=
 =?us-ascii?Q?ekpSFIj1k6UhipmCkuTXQ+OV92ZL9uteWwmjpJLBDt/jug9PAv0/mcV7mMQ6?=
 =?us-ascii?Q?I2zRxduRAx1ZA3PuyBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 466f5887-a698-432a-da3d-08dd67a7951b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 12:06:01.4686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKymNp5RUe3UOmZNc3i+Mkg8Y685ybxVDhxmgq95N5UaJbJaW1N2gEjoyCK6E4AS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 20, 2025 3:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu/mes: clean up SDMA HQD loop
>
> Follow the same logic as the other IP types.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index fddec5d1f2444..016af4e9c35fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -136,11 +136,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>       }
>
>       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> -             /* zero sdma_hqd_mask for non-existent engine */
> -             if (adev->sdma.num_instances =3D=3D 1)
> -                     adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0xfc;
> -             else
> -                     adev->mes.sdma_hqd_mask[i] =3D 0xfc;
> +             if (i >=3D adev->sdma.num_instances)
> +                     break;
> +             adev->mes.sdma_hqd_mask[i] =3D 0xfc;
>       }
>
>       for (i =3D 0; i < AMDGPU_MAX_MES_PIPES; i++) {
> --
> 2.48.1

