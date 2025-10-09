Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078E1CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 13:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A620610E229;
	Thu,  9 Oct 2025 13:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WafrY4mJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E1D10E229
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 13:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBji8N8T4cta6zI0LoUqkQbgJy8qhJXBqnMpWMK2vWXDhgTH31NQaGhM2qbn2KCRhSju6OXuUND7p+XO6XZHI7ETRDr/LfYe2M14pS+pSucm4UySb8kBEpEa/EczWdwI38MEV4IIj7GrKXaZGa89QF35oQji1VCMtcbjblVjLS6gQwlyrs6EnzCl22OBQPDa6hrhXmRjI7caT2fi0rs7+DrXMO1N/uXjzkShKU8cMoWAYG8PjTWbRDE4IZd+OMDVEcMYfhWl8bWQ91DVVhc6t8Fp5VB59AQ75/nAbZrNTslQcRR2ePlFNp4OVPOxDivXX60clhYijM7m9VPeoUUKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFuwFIAGMuvl1zyyHGMwzoRSwO3XznREPCEiQEq1WG0=;
 b=RjSRBTlUm+Cjx1LKn8S+jYFxVDYwJPNh410h2USgS+gDM2RmkYQDXueIea72/kD+11MlmXBDZg1OmFF6MsEB0Mr6Sgqs9xNiWchf4JncmBtuWZgHn5oNBYEnvuPS8DBjZd5lingDlT5VttXC5CgdoEruOn3c5OTuiZeuIKdRaCt8hZk5VroaRyWqvvCzoDVWriX2Vte4gCnTNS56n6+8/3OWpvx8aKi3MffCvV1SsCkyd+sDGMpEF/jFv7+nS1O/OZ9yIlJnfu0MowA9sr7heJvXguWhO4KLGmioD9lntsKXOwTUiMBxOxIvloOiuxJpdRKrwaX2ktUuLuGaPvsliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFuwFIAGMuvl1zyyHGMwzoRSwO3XznREPCEiQEq1WG0=;
 b=WafrY4mJreErpyy0wyWKzGi4Zn38M4r2q4N4Ek52vy992DSmXx3GYWx0Ardo5cLJatUxr+iAJmHKDMZ6G49aZZfveV6FN3bOgopkT17p/lE1KK/3yaKawn5l23nGTMYn6WVuRodbmGf1w8uXNxeyQ5DJxedwtf8bDilIWJloEM0=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Thu, 9 Oct 2025 13:59:51 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 13:59:51 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gande, Shravan kumar"
 <Shravankumar.Gande@amd.com>, "Pan, Ellen" <Yunru.Pan@amd.com>
Subject: RE: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
 critical region in SRIOV
Thread-Index: AQHcOM0snOWIfnsXZEi7+QBe+PKPi7S51fJg
Date: Thu, 9 Oct 2025 13:59:50 +0000
Message-ID: <DS0PR12MB78040707ECA3CD3B1D3C6CD597EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251009033047.25004-1-yunru.pan@amd.com>
In-Reply-To: <20251009033047.25004-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-09T13:51:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY5PR12MB6081:EE_
x-ms-office365-filtering-correlation-id: bb619055-ece8-4b5a-c04a-08de073c1d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aRkkvoNmoMiywKGv3G/1joAbRlAQq+LiYHbqhIQOBxTLsqp9hgSTA1ibO+DX?=
 =?us-ascii?Q?/2FkHK/zBuuVFSyx+gqsRv3WNPgL6YSX2yjAU06bbyr+wcRNMf2OuIISkUvc?=
 =?us-ascii?Q?3WmvVgwkUL3PuDO4Cy6Ib2zyv6NYmu1KOhApriAfFofyIQ5X5iG6nbsLwq5M?=
 =?us-ascii?Q?LhpY/+nhVWSpv5ITHZf7+3pmUEjdgm9lt2NyUntWd3AhXCgrDOU5MqOCP758?=
 =?us-ascii?Q?NHw/3gpeRPOZ5awwIZeLrXvwtfxrWl1kjHw5lYGLhT4V3hgiRqtobxc3C4az?=
 =?us-ascii?Q?/MIUaEC+l73+clB38So1vfD6W1qUAztjDZ7guIv4lHb0PPGqV+pfyt3sGnrw?=
 =?us-ascii?Q?d96qjLrGZxbrrI5P+xayywSyL8u0fEKY5oLymfq8O6bgg2I6N3Njl1xx0eRa?=
 =?us-ascii?Q?PshO8sLzvcU4LyMnyLppfqVVxY3M6rY2oB6za4p6f0lXCXsFWqnZjaD+BEHr?=
 =?us-ascii?Q?oPs7Ya4Y5chCEXxAYkSe2Wq59hdt83B7RYSBvIvj04plWUNiZtbDIJlGSCyY?=
 =?us-ascii?Q?/9qOQ5XDk3OnCNIla6DddPV879FcLd420kOaGNTe3CuPIipZeIHm5p5bwL2j?=
 =?us-ascii?Q?Wl5/KKKOTx+J9tRxfMOv75wL10bLpclC9u9PipFt2a6dEIJgiMjlTjhI9Kmw?=
 =?us-ascii?Q?ouPUTw5ZVwYvYTkNRatYpQpsjixQMdVLAdqpwnOMxNbNriD5swGM0lVw3Ubq?=
 =?us-ascii?Q?Yui+49CQ6EaKfsCyhCiG13230RXOQJXSXO/6qQT85e2rTfZfaFpVhImOGjo2?=
 =?us-ascii?Q?vn1S1KGlxwjZxrgjC+0gWO7WQ8/Jn320F9WQg7gOTiqdQtq8Pwc+C4WpQJSx?=
 =?us-ascii?Q?40QSdwP4a4M0QkRmOdpTzBGqoWh2UtnsMMLHD6vTh7weB+cHvxePoVh4Drje?=
 =?us-ascii?Q?D+Hd/RoYSlp0n0aB3MqbO9wk9Z87iZevnKWUNgzNC4OLdNq946dQu4jQvIsK?=
 =?us-ascii?Q?PxMikSteWd1MPdWuLHOYWbFb8v7qlLFkpgdaxAYXN8Fp9Wx9yjQNfmIRf0AF?=
 =?us-ascii?Q?CrJXgLfpC1te1PnjxIcS/oOBwsqEnXlymSPGK6BEv1y7op+wFKFSdfWQG84q?=
 =?us-ascii?Q?dueQWu6DAehzWY5IcA8yAZQkOUKlq8/4OlKfnHeUiCzhqbo5koXYb9yhznz/?=
 =?us-ascii?Q?ZSAvz+OO5CIKkRjbxn877MnS4T2mJxKX9aLjtTpu9tmNG+nJFMZHp9L13G78?=
 =?us-ascii?Q?1N/kOQMtWvZWDBjB8GUtcTJLbaNCXBSIJjKo2Wa/OgnnibGtDoJ8ZQ9aW3xx?=
 =?us-ascii?Q?nrz1y11nmiz6gqg9CgVRY/DXvHkuymmM5CwxP7RCR0wdW7UOQHOKJsQqPqYV?=
 =?us-ascii?Q?q9IA8pnqfkkYz+FpWFC4of/hXzkSVlJDDj3oq8RGX+h9YbL8FV74vyaxHI2V?=
 =?us-ascii?Q?gfTIssP/UABmd6D3kQfrW5dLNfCJXrB6bJj47k64lMFWv/GODsOcMsjWEcny?=
 =?us-ascii?Q?a+ai4rxe/XIPOVSmZ5YB+A00TyJua5rdXUTWWxmggEDzCp41jRs1LSFho3/R?=
 =?us-ascii?Q?hGdO/CbUC3jBNxCbu+MOiIAhyKhrO2rgDxIx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVA8p6JnusvyrxvQRPdWc1ltVGa9tUili9GIpWYLINf2eDTWl3fJA5GEY+SB?=
 =?us-ascii?Q?MkXqc6LnXaUaBXUD5g35qzTimXZr8zPzkd7sulVXc+MBiHawBlRlr4Uyv4p0?=
 =?us-ascii?Q?sNDc+UBOMp7pQVjc7KUBK7zL4cyQRAa53e7N75ubGhyv4lIN6y9n082R9yGe?=
 =?us-ascii?Q?S4gJ9U5Al8LSDg9HAcev/VQXB1qS6HRiKY9IqZ5Mr5l2AS3bIjjy0gUcBhVS?=
 =?us-ascii?Q?Z8Dtd3extjpYAscngx7rBzedjK0YXQ1js+4L9pzKckKimF4ufAIUeVuoEA0F?=
 =?us-ascii?Q?TiUYvxaWgyqhRZWz1ILFWT2X4uAwyqFhqh4ezLfSaRfO4wswJQ7agEfW/+RW?=
 =?us-ascii?Q?/3XypbJBRwxnW34L8tld3yAhSYDBS5fh1CxvZ23V5Iq4AJFiRRq/AD8IzN8b?=
 =?us-ascii?Q?Rbh+HRdCLcNCv5av4/Nl8umu+K6OciuzOccPsnNFbHrg94ZGrsFkO2oLgZtq?=
 =?us-ascii?Q?QwZWghfzhQOM6P67IWsIyaHzyUgxYOtcp9DHgyLC6yQHNE1+wFNGLJ8RKCuy?=
 =?us-ascii?Q?95O8Nq3R9sJA4YiqC/yNMmXScsu/wDRQfV+wXwlhE4lW3E7zuFx+sv4aXICY?=
 =?us-ascii?Q?dJ5OnfHKHhqGVFsmCIMjORc1kgDlo6xMF8GG+ibYREa/KH4HJiA1O9lTwyp9?=
 =?us-ascii?Q?x+40mlqPyGyBR+eCTbUPAgCgamKE/CtrdESUjnih9SutpA18fHvSgNmQ3Tt1?=
 =?us-ascii?Q?jWWBqh3ebsUMaEuIU/CoR5vTBwAr9EowmyX8E7ojeSOzr7fQTAOhehdibwzj?=
 =?us-ascii?Q?3ek1vb0IjBMlXzYV+ZDhjJFWdqQHW+5I+wwb2/Uq9OXs2Bawz8oTjp6vFE6W?=
 =?us-ascii?Q?TmJGT2iPRODDQs/XECQqeVCxTufNBaG/Qy7q//jSzHxlxCLGVRAxqQRd1YoY?=
 =?us-ascii?Q?8G2c9DOM08rJj9MUVPgmnysy/EVv8IzPR+PEQ1GWVPCAITlY+J+Y3M3X1e0R?=
 =?us-ascii?Q?dv1wqq/nxeFoNo0EzbzchbmYFOV65epNl20FSO/rKVWFZdZStuQykgkm2pLO?=
 =?us-ascii?Q?FXSqwlXjzpvgijesjr1Tm8eRg+L+7QXjhAqFVWauTAQY/SZktUaILJiz0pIX?=
 =?us-ascii?Q?ttjryXTDUFxA+B6ZK3FKNMj8enwgfhBIRRL4glmeHKnVImNZDk2wBjdl6EPw?=
 =?us-ascii?Q?AN739sWIjkSywmK5r1CbcsR3wCmj6aiA4vk27SaA6cBwYESORTkWkZm4Xhos?=
 =?us-ascii?Q?eXqaSh5yaevBL+e78J3IvnbWs0vGM5nvQa5/8lzm+DWYMe3YNz0jp/nUiuS1?=
 =?us-ascii?Q?11vVAlHIpcXKfsjKO7us3exPJ1672EYH3gR4jAotmsDJsR5E8Ask0BRaHQfD?=
 =?us-ascii?Q?8EkKm9Xb+eYZLexxIK2Fh360cH6nYXkegi1SgJWSxiD3+KAk2l6UfQJ+oi1U?=
 =?us-ascii?Q?kYp9aJZgax0FXnsZj9Frdm6u5c/3SaLlDx6LREBvJpQc3/mexs6u4P8kHioS?=
 =?us-ascii?Q?+uVsUnFixmlRZWZveTFjjhJtQFvAHFrp3ynQBClQIOMaGgZKhqxQ04z/DyIb?=
 =?us-ascii?Q?b5d8shKAPBqHcWYIqAntrqKMwxckPqR6Io6Z07ERk/cE799y5+2cvdJjmYeu?=
 =?us-ascii?Q?8hScjq/jhPhk+8PGxQ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb619055-ece8-4b5a-c04a-08de073c1d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 13:59:50.9141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwsbHz1g+kiRpwUHwn3jY8ltEV28DhfCIkb1zFSIcZ31JS46Z0eeA9TjhiSUNc0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
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

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ellen
>Pan
>Sent: Thursday, October 9, 2025 9:01 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Gande, Shravan kumar
><Shravankumar.Gande@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH 4/6] drm/amdgpu: Reuse fw_vram_usage_* for dynamic
>critical region in SRIOV
>
>- During guest driver init, asa VFs receive PF msg to
>       init dynamic critical region(v2), VFs reuse fw_vram_usage_*
>        from ttm to store critical region tables in a 5MB chunk.
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 33 +++++++++++++----------
>-  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++++++
> 2 files changed, 26 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>index 96bd0185f936..4ba34ba74671 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>@@ -1943,23 +1943,26 @@ int amdgpu_ttm_init(struct amdgpu_device
>*adev)
>       if (r)
>               return r;
>
>-      /*
>-       *The reserved vram for driver must be pinned to the specified
>-       *place on the VRAM, so reserve it early.
>-       */
>-      r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>-      if (r)
>-              return r;
>-
>-      /*
>-       * only NAVI10 and onwards ASIC support for IP discovery.
>-       * If IP discovery enabled, a block of memory should be
>-       * reserved for IP discovey.
>-       */
>-      if (adev->mman.discovery_bin) {
>-              r =3D amdgpu_ttm_reserve_tmr(adev);
>+      /* VFs using dynamic critical regions(v2) won't need to reserve for
>below memory */
>+      if (!amdgpu_sriov_vf(adev) || (adev->virt.req_init_data_ver !=3D
>GPU_CRIT_REGION_V2)) {
>+              /*
>+               *The reserved vram for driver must be pinned to the specif=
ied
>+               *place on the VRAM, so reserve it early.
>+               */
>+              r =3D amdgpu_ttm_drv_reserve_vram_init(adev);
>               if (r)
>                       return r;
>+
>+              /*
>+               * only NAVI10 and onwards ASIC support for IP discovery.
>+               * If IP discovery enabled, a block of memory should be
>+               * reserved for IP discovey.
>+               */
>+              if (adev->mman.discovery_bin) {
>+                      r =3D amdgpu_ttm_reserve_tmr(adev);
>+                      if (r)
>+                              return r;
>+              }
>       }
>
>       /* allocate memory as required for VGA diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 46c19e96086a..e9dbab53cb06 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -931,6 +931,14 @@ int amdgpu_virt_init_critical_region(struct
>amdgpu_device *adev)
>               adev-
>>virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =3D
>                       init_data_hdr->bad_page_size_in_kb;
>
>+              /* reserved memory starts from crit region base offset with=
 the
>size of 5MB */
>+              adev->mman.fw_vram_usage_start_offset =3D adev-
>>virt.crit_region_base_offset;
>+              adev->mman.fw_vram_usage_size =3D adev-
>>virt.crit_region_size_in_kb << 10;
>+              DRM_INFO("critical region v%d requested to reserve memory
>start at %08x with %d KB.\n",
>+                        init_data_hdr->version,
>+                        adev->mman.fw_vram_usage_start_offset,
>+                        adev->mman.fw_vram_usage_size >> 10);
>+

[lijo]
There is another place where this gets set - amdgpu_atomfirmware_allocate_f=
b_v2_2. Is the assumption that vbios table no longer will have the flags se=
t?

Thanks,
Lijo

>               adev->virt.init_data_done =3D true;
>               break;
>       default:
>--
>2.34.1

