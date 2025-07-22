Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1A7C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 09:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF6010E635;
	Tue, 22 Jul 2025 09:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KS2HpoRN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E49910E635
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 09:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgGggxyIIlW8GnWjE+3igUu4TQkI3nwIL0kKKEJIjM7azn2ermgNARP8vXZ2z3HVclgpE8LQYitsj4NU/ySGIQgzUcFN35OgqG/uT9jTcAUiveMWqi+hnnuPggmxoODsWdeedE0NgvLeyjzo5jYU8fug4AOFaxbaVO3apQyZDw5m7qIDycExJaCiwgb+thhqU07M4V49seOAecsTreWpC3BOrpEPGL94sdiV2OY0ChzhAwAe5i+NIXYodGLPkCd4qEuyKIRHuAvc21D9H4JAB2eRSb9inqsWnU2EH+ZvOwazmARZUW+6WpIhi1TVChlGz4r1TmTXcou1U8B/wIb/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RydUXYvksbdaHBjSzBhlf9wQH+qSqWMoQ8kYMYQX7xs=;
 b=LcZbZAGoVRFTLn7D2L087KUr1PC29iVuyDmGLiWIMzWLNEtW3Go/TBpGOQfECCQFxen5onj88J8pJB8wnK1pCRKPMVC69WjSebgTN8NWEW2IPEvKtLiW6pyPpHF9cm87PJpWvKERUHEW9RbjxOeGy1sSCDb84ujctoRnkZBxVco958YSjbmJewfMNikOWOVGMttIRUXdWGK0vhKLZkVVJOsqdAccF7sCV/i0rbpLlExBuE73IudE1wBrXPgrqDi5WffJ07H7CsnILQAIBYwWE4aMQ8j8IkH+Cwlc5qT54F9QLvRxsAf3d0x9CZtBn4sg1TV6gI3aMu+imGzSchOc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RydUXYvksbdaHBjSzBhlf9wQH+qSqWMoQ8kYMYQX7xs=;
 b=KS2HpoRNabm9wq7ad3kSDUjQZ4qLt3J3UsKsh+O6/W48QXogX5tLYjN9VAM6+3az1iULDCknazH+p91MjE1CLJwvF3X84aQbX3GN7npWgIC8CnlovdpP/7b+DVPoN0v1O5OpcxAsxcI2cp+5bjDD0KCD6oBnniYpkRn5Y+845p0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 09:05:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 09:05:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 07/14] drm/amdgpu: validate userq buffer virtual
 address and size
Thread-Topic: [PATCH v7 07/14] drm/amdgpu: validate userq buffer virtual
 address and size
Thread-Index: AQHb+tzJ9sdbZqGPA0ChEAiyw85x57Q92XWA
Date: Tue, 22 Jul 2025 09:05:01 +0000
Message-ID: <DS7PR12MB6005BFF4E8FD343127CB1C4BFB5CA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
 <20250722074623.1464666-7-Prike.Liang@amd.com>
In-Reply-To: <20250722074623.1464666-7-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-22T09:04:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8783:EE_
x-ms-office365-filtering-correlation-id: 0a375597-af33-41af-e509-08ddc8fed784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bQdMvx8KI5YcJPZOFlZ//UQAD1mvn6hdEdM1VQkLa52Dak9EjVH+OO7/j1Of?=
 =?us-ascii?Q?/kik40YPT1w4Suie4x8Y49lmCTQKjI/eXPm2hcvjZ/J2pVYN434OrnCmraVx?=
 =?us-ascii?Q?iakwHvVHrRJWbCPatmw3D333nIPck1sTVciXcLvMP1fp7GN4HX6cbCsGTxjz?=
 =?us-ascii?Q?NnDB6lwdV4J0mezH3sVDvaAZUdrtQiMWJQDFoC7vDTlqTRowIaAmBWqqJv8w?=
 =?us-ascii?Q?oP33Vf7Rrh6YD/jCZHu3SVySVU1pFl4tGxmrM33/CmjiuizSR51ZZvOYixPY?=
 =?us-ascii?Q?FnCOB6GN84UStaCTGkHNzOpN9FiOkMmPzss7ycwm2qjadyITWwbUya5sdt67?=
 =?us-ascii?Q?2I2nXUtMDApke9q+7nImz3xNGjDsc6T7NaS8v0D2QCDiw4BkTSINeDaJ9HQw?=
 =?us-ascii?Q?niaD86BEoN479++9eqDQ1qq/yMJlnoTLhuBaj/j6/lilKH08eQ6kwhfUkAZJ?=
 =?us-ascii?Q?rU6TrGNpxdVAcNNUm8C2Iv/1+lVqZDIYTuiYyDANDMCkyMFF0Ihr2ieIvjl4?=
 =?us-ascii?Q?5G0d1balP74tV5gHZyihWg7n6ROjl0gzNBsiYX0lSFoeSU7BhbxRB+f8pKYE?=
 =?us-ascii?Q?/Nb0sVdxjFHJ1pwzNVd09VAUCpVNQDNYiAjfEXQ7z+9lHmJ5W14VIdy4lSKS?=
 =?us-ascii?Q?EQvKZUPBh5szH61eG7JXjkJy0TbL+MQCamzLFIwnscagQf9wI41m5CM8JkKn?=
 =?us-ascii?Q?jL6duV8Lef2ArtttEzKwsBmutc+oDrzewoxoyVUKs3LoQJWP8zOfFN3bhpky?=
 =?us-ascii?Q?WzgWdifB3oxzJSbyRSo+oEA1ANjOtd66vHNcgAEgkwqOI5APyYRCXTtWqTgo?=
 =?us-ascii?Q?W4Sb98JbYp6ZC0Z5eaW/A+5kggcWmwZjOo0ul8o0gquUCqHM4hdoP/rBFRc6?=
 =?us-ascii?Q?OH/wytf1WtACuth81kHn1PVJND1OO1eNOALrjoBQDSshK2TL8XqkFGY3ygiT?=
 =?us-ascii?Q?k2Fcnd5xaY6rQ0uW4HhmE+gDG2dF+OYFw/V9N/L9QvximHGsKzo8mSNRTSzJ?=
 =?us-ascii?Q?JsrlfLgRLiy2hZ0gGv9yLc1M0w6XKSHUB/o+s9zc0JjwWieUxGP/oZV+j/zc?=
 =?us-ascii?Q?ZgVgXZlUs+8zZDW4uLg0R4rzo2LkW1Y7KyY1+vxrHSYCByZ3UCEfnh6E/GxQ?=
 =?us-ascii?Q?2GBRMhtrmDpLes/YvXEy7dja1n4hddnUAA2oxYkDLkj4oy+ds3SoNoFamR12?=
 =?us-ascii?Q?D7Eg/fF3xFUMGb9ksa8XGsk3IdgAEOx5fVXSqhE1el9w2SV+Fbq/ZEcavEeW?=
 =?us-ascii?Q?BqNAi6ByNKfSFbzVJ4+jYzyjNGa0BpOuQyRV6vNs1aOxsqZs0nT/ymnXbYik?=
 =?us-ascii?Q?Q7ZRJEp3JcqOenAwQZFBkYiTRr384KVOOQlhkbPkf4OcDRXMqIh9+y+kWdFA?=
 =?us-ascii?Q?qNFZQ1BC+URd1zKZxUu50NfwN+u9+zHUudWlcupDs87s6bS1Kyog9ClFFp/8?=
 =?us-ascii?Q?A4mZdpFtqgprRoJCMjRw3+jT+QOngaz5nT+/DFQYDxSh14y1+pLF5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bjbYQKMWWC2kuWxLgOq+8gjb/IbdiXszOPlp7cIP8fQmolCRoF8cD4vyvIVt?=
 =?us-ascii?Q?2N8YLdyRi2+YmSOXQfIFLN+GuU+0ktVte35s6yjkgUAtYwh9WbQ4JqpZbf+y?=
 =?us-ascii?Q?WtCBbUul+KMLoPYR1siuLyjuHEWD++FVUlYm+fxbzE4s5HDQMh2oF7jlEBdv?=
 =?us-ascii?Q?J7ewh621Yj/BE+Jw0Xe2WmvYRxwSP4XQG2fd8kV22i4Ql6U53kmQ+ob6MHBi?=
 =?us-ascii?Q?OXMfT8EpYYaQKtIxfphKdSDSNd9uOq3crGlFvwgJjIyBNpmfR8PgB1GFHgKL?=
 =?us-ascii?Q?iUvDlTTwbvlb5xWqabbuTSRl9MJ9v+Yl8ZBPT+i3cOwm7kwPDVgPCOSL8S4Z?=
 =?us-ascii?Q?hTZfQZVTVl73G3kQBbpOhT8xmuPHNxtGX/6iGTxF6o1hrRC3RhdQPm/fMpL7?=
 =?us-ascii?Q?txE8rSN/ItOPT0IFnPALxQGxoyhs6I/L5J0XQ22/o9Szto6QxKP3fq2tooXk?=
 =?us-ascii?Q?5r4KvD1GsxlyiX9CYH29D/BH/+UczFiAgebmmz00IlVnOtQlRscRGuyYJxsz?=
 =?us-ascii?Q?R7Fkold7oJW5sQah4RraKf3H0tuHt64dotHzz4WFuA3P5p0mU9RNkLwpsIUg?=
 =?us-ascii?Q?d/XOezSy5Cdy7vjLTewLlcCezMe/cN5apYZvM+qc5Lh1WsqKrnR6G34Zw2f8?=
 =?us-ascii?Q?TiWGj9pvcZ2loDk+Ob4IkRFc0aizSUKozCxxD/gg+pWF1YuVzVv3UtfeZukX?=
 =?us-ascii?Q?Vo9UYQT/jt9JTCQwE81mA+EaOo5mB+iKV6QJ6oIHaKhi74YfcuBTaE5LZVQQ?=
 =?us-ascii?Q?/ra52NhNDNcNxAvvgRAIBWWZaY8KerdngxYZ3ajNljDjodaG1vmFH9iSMFuz?=
 =?us-ascii?Q?U3r+JA8GEwiv6RQe85yZPS1f+2psSS5FeWR24x3YuKAjiuV0YsGtzyhKV+pi?=
 =?us-ascii?Q?HPRqUT/S3hZDsLiVCzbkOWznEtmHQBRaBIADdvsnyx5YqEd21GyTsJwBZx3G?=
 =?us-ascii?Q?uchzfYfMqZjeyAqkILpVwJj4f7FS4N+36VZo9uQ3VpHAZ0sARLJHmLoJiAK4?=
 =?us-ascii?Q?TYfiqEeW6ugmuzWrb0Kvy7OuadLdxzhS8HqBp1bWRfhrYdGkXsuZmceQR92v?=
 =?us-ascii?Q?ZHbI0hMPDS1iwXjMNGwCsTAO23j87Xqm8ipZRflcA9jfCo2Oa4+zyYuYB4zH?=
 =?us-ascii?Q?ulLtretz3I3jw1QPqhlXiQYKRRufP8fU/b/5v/DpoY9u4y+GD+hOcSHf2r/g?=
 =?us-ascii?Q?Btuyk46SInjnS14yFGrc5DvDBvWHA65+2heB80P0CC0Thhn+joj9BZ0sN+N2?=
 =?us-ascii?Q?T4S/NUMZv25O+48zwJXDIMAP2vlMfOM2fpeSpP5gHkB7xg0/ZiFzdptKbQbb?=
 =?us-ascii?Q?FDAF4WGUfVTkhOyZluWrEeOcRWjikiVK0y18iQ6X2d+g1Dshuif/piROVfIn?=
 =?us-ascii?Q?KI+gDB5yofFJlHWTLNQ6zyLtWvY8VAzhucP1RhTGMz52JYNnu3BpirLHlc2y?=
 =?us-ascii?Q?7+05vBbcBXUwWGEawZ5caGGvjqMPT3FJqHutGiQIoNq2UgTKLXPL3YBBr9SW?=
 =?us-ascii?Q?HCsD825JJpzjUXpCyl9TXY4A1rz+8dCIdShedP8ZUBqsBG29QoRAEsOj65bI?=
 =?us-ascii?Q?BT9KONnTKPpljuCiR9I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a375597-af33-41af-e509-08ddc8fed784
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 09:05:01.9241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af1dKVRNPtesZBo00TtvQgWMsP7c6P4IR4cGy8f7dFqpG1wiFsr/BFJDPcMS8s1i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

This patch will be updated in the next version.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, July 22, 2025 3:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v7 07/14] drm/amdgpu: validate userq buffer virtual addre=
ss and
> size
>
> It needs to validate the userq object virtual address to determin whether=
 it is
> residented in a valid vm mapping.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 39 ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  2 ++
> drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 ++++++++++++
>  3 files changed, 63 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index b670ca8111f3..52dc64384bdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -44,6 +44,36 @@ u32 amdgpu_userq_get_supported_ip_mask(struct
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
> +     int r =3D 0;
> +
> +     user_addr =3D (addr & AMDGPU_GMC_HOLE_MASK) >>
> AMDGPU_GPU_PAGE_SHIFT;
> +     size =3D expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +     r =3D amdgpu_bo_reserve(vm->root.bo, false);
> +     if (r)
> +             return r;
> +
> +     va_map =3D amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +     if (!va_map) {
> +             r =3D -EINVAL;
> +             goto out_err;
> +     }
> +     /* Only validate the userq whether resident in the VM mapping range=
 */
> +     if (user_addr >=3D va_map->last ||
> +                     va_map->last - user_addr + 1 > size)
> +             r =3D -EINVAL;
> +
> +out_err:
> +     amdgpu_bo_unreserve(vm->root.bo);
> +     return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                         struct amdgpu_usermode_queue *queue) @@ -399,6
> +429,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_us=
erq
> *args)
>               r =3D -ENOMEM;
>               goto unlock;
>       }
> +
> +     /* Validate the userq virtual address.*/
> +     if (amdgpu_userq_input_va_validate(&fpriv->vm, args->in.queue_va, a=
rgs-
> >in.queue_size) ||
> +         amdgpu_userq_input_va_validate(&fpriv->vm, args->in.rptr_va,
> PAGE_SIZE) ||
> +         amdgpu_userq_input_va_validate(&fpriv->vm, args->in.wptr_va,
> PAGE_SIZE)) {
> +             queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> +             kfree(queue);
> +             goto unlock;
> +     }
>       queue->doorbell_handle =3D args->in.doorbell_handle;
>       queue->queue_type =3D args->in.ip_type;
>       queue->vm =3D &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 694f850d102e..0eb2a9c2e340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -135,4 +135,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
> index 1457fb49a794..6e29e85bbf9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -206,6 +206,7 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_type=
];
>       struct drm_amdgpu_userq_in *mqd_user =3D args_in;
>       struct amdgpu_mqd_prop *userq_props;
> +     struct amdgpu_gfx_shadow_info shadow_info;
>       int r;
>
>       /* Structure to initialize MQD for userqueue using generic MQD init=
 function */
> @@ -231,6 +232,8 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>       userq_props->doorbell_index =3D queue->doorbell_index;
>       userq_props->fence_address =3D queue->fence_drv->gpu_addr;
>
> +     if (adev->gfx.funcs->get_gfx_shadow_info)
> +             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, tr=
ue);
>       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>               struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
>
> @@ -247,6 +250,12 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>                       goto free_mqd;
>               }
>
> +             if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd-
> >eop_va,
> +                                     max_t(u32, PAGE_SIZE,
> AMDGPU_GPU_PAGE_SIZE))) {
> +                     queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> +                     goto free_mqd;
> +             }
> +
>               userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
>               userq_props->hqd_pipe_priority =3D
> AMDGPU_GFX_PIPE_PRIO_NORMAL;
>               userq_props->hqd_queue_priority =3D
> AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> @@ -274,6 +283,13 @@ static int mes_userq_mqd_create(struct
> amdgpu_userq_mgr *uq_mgr,
>               userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
>               userq_props->tmz_queue =3D
>                       mqd_user->flags &
> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +             if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11-
> >shadow_va,
> +                                     shadow_info.shadow_size)) {
> +                     queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> +                     goto free_mqd;
> +             }
> +
>               kfree(mqd_gfx_v11);
>       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) {
>               struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11; @@
> -291,6 +307,12 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr
> *uq_mgr,
>                       goto free_mqd;
>               }
>
> +             if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11-
> >csa_va,
> +                                     shadow_info.csa_size)) {
> +                     queue->state =3D AMDGPU_USERQ_STATE_INVALID_ARG;
> +                     goto free_mqd;
> +             }
> +
>               userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
>               kfree(mqd_sdma_v11);
>       }
> --
> 2.34.1

