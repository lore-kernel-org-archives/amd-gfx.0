Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E79C8303C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 20:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73F410E6D6;
	Tue,  8 Jul 2025 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pBWNukPH";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC5010E6CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 20:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EExoKM6q6EBE32jiCynLFpY5E+S3/KarL2AdlrrduVtIidO9gRqoQvsXVIqm6apXfXTFRg3R52UBFNiGae8jI3oBRbbkNOk29ANDxPKcXElVCCyMcGPwMQQc/Zlz7imsRHzJeiYQzu5EPIgSXWlYIJlMPZUsDpFx4pCbKRf2L07Z0bm/OS9otlPGCaF6yTcw6EoIf4+q0Vz7+mqf2iYF84CHUrKwbvNYC5d7GJiAU3Yntdnvlq3d+KUayVPEPMf+5xhdO0SDP9WSCJsvxj7RZHYeQQcixFRkWjMrJRfOnmD6ItNp+/bKm6sv9Vr78IfzuLHIhLg44garlaznqqE6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vg1u6monczdO+4GK5+O0ibDzMqCMedqiu5/JvQNBqQY=;
 b=ZBzLE1Q/VJj186cC749uW45iff1M+qkLkQE833dlZdMpVZtWL1FFyPg9LznxvKPckg2ISmscWmuftJX6TjClBi9NyrnrFMK9lZ9iM5pfn0Nyc2nS1U1w62sIY+iKibI2R9sON/mcYVZCSCdIhg71Y3XnPOvQtBpkOlFQTAEqLRsQAYa3+msmzRT8pOYRhJNK4SRhT6CrMTcHM4bIVGottpKsMMcca9dLKbyKC01MDnIns7d0f+FaXidVu7xAtpwzTUdab/1DYuUior7id1YUZiHVapy5a4ZpG4YZIOSt3TGTn8ZOvkZDsJ1xWdI4u+ITbfiODac3AUnq+0iQWG020A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg1u6monczdO+4GK5+O0ibDzMqCMedqiu5/JvQNBqQY=;
 b=pBWNukPH1y5W/ZlB2udYZI0OGqWD82V6GfBfkdXbbuCX3DEUuH975iDN5cZ22Wcztofv+Ewt7kSbmR0wpHXHkMJ0hvtFdLmy6k7yub4BkTqaZRD2ARoykDy0cqYpE3XNUXDWJUB/lI3UwR2bRrvM1ih3RxWa9aDcC2mab3i9jcY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 8 Jul
 2025 20:19:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 20:19:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use cached partition mode, if valid
Thread-Topic: [PATCH] drm/amdgpu: Use cached partition mode, if valid
Thread-Index: AQHb7WTIw6oiv5TlckK5BVTGn4NWkbQosGIw
Date: Tue, 8 Jul 2025 20:19:50 +0000
Message-ID: <BL1PR12MB51441EA556A2242C6EA0DF29F74EA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250705042435.1359695-1-lijo.lazar@amd.com>
In-Reply-To: <20250705042435.1359695-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-08T20:19:29.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB7949:EE_
x-ms-office365-filtering-correlation-id: 642dbf05-87f3-4012-8333-08ddbe5cca95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zTtS1ReQkm5S2ReHY1HAZtR9ozac1PN5x2qbfAn/RPbvlIwr9jWjIjRNo6vc?=
 =?us-ascii?Q?Xxyzg3/rOZMMUoeOjwVuDyZjc+sSgCPiS4WCQA55swBWGhIJ2fG/74v1jjq1?=
 =?us-ascii?Q?iWy5MHz/kVwQQxyc4o4nqDN0D2uebDbYdQMlhTuByGXO4tXoyPkD2MTcca2s?=
 =?us-ascii?Q?3iSlb4Z8y4I1rngxyfgyeN6IGD9HkroP9c2B7uSVVcFCvsi4P1dGZXupwMzj?=
 =?us-ascii?Q?tVV1abfWcDuuMOSZ4iOuoC8d4PU9sXiUDwRPPpPPQT9kjrtpQpbbp/YQM8fD?=
 =?us-ascii?Q?VQHp6ffIYo4e6bx95uOSO661qcWQ2I+wH9e+FECXp0pb1ukbj4VNUNNLSdYJ?=
 =?us-ascii?Q?GIkTjf3h0v7X26H1xSmnGTQhJsG2S/Hwbse+DbXiegqQUSwkklf4aNFelRtn?=
 =?us-ascii?Q?1H+WKAKro91z7fHZRO1InATzjdmXHVk05TK8seMl5POPzXOrE4ymzmdSO9qj?=
 =?us-ascii?Q?tVeY1SQrJK7N9ovE0yL3diDZWDOTa+6gMwnVp7aE7e9xx/ci+836k7UvCQTv?=
 =?us-ascii?Q?W0W5CDlwatzcUTVyIRXvkhFrW8c/hHxhbRIY/Z1gh0bjmykjoPaSWdKaU6k+?=
 =?us-ascii?Q?zttw4EuT7cFeoO/y2mcAhoY+ZoN4uSNL/USSOJWb9sOaUDeT73VaqajwNBQL?=
 =?us-ascii?Q?8yf1p/+gbyIFcGOvV4G+14XXfc6rguxQhNJoaL7jt2szl4uLZ1XSvVW1IyTF?=
 =?us-ascii?Q?mqFzYRFbCFlC++v05wPpvykR3jZKHrxgLE/XzAZ7THchDOwf3aBBJFWq5JlP?=
 =?us-ascii?Q?mqm2xNHNdtilh2P43bTZR+SMsU5C3UG6sLvQaLTFMzkOQ/C2g+D8UTLiJv/H?=
 =?us-ascii?Q?zXtlQXKLUUiLo5PAbjLzpHXFNjzjZ6VDmTP0pSM2vvgtp2L/r/nx0fUMMNVd?=
 =?us-ascii?Q?HNdATG/0uGtePG1/7rqYU+V6KBRwJGT1hiWP2AJLQHezHY3Qj6Lsef1lmBiH?=
 =?us-ascii?Q?jBJOoIoTPAUc6VOt0wgvoHtp5khFmaW0SWIDFV051it219eBvFVcxr/RHguq?=
 =?us-ascii?Q?C24XAuvIkCc/4gd+PGJdA4PdAP+fzbJgDp8mzZhreQ39SsD/a9Uz/shc4eAx?=
 =?us-ascii?Q?gylt4pRAS0q2NxERM4LLuWr4pR7oTC5NKs/zBAMpoXkZ9/PeHcADzaL7Je6R?=
 =?us-ascii?Q?5TuHFKxBpdKTaaMgsCtA9HVxGTZ5pVxJSIEzxGw7I4OIA4DFjhvkgUKGPy8W?=
 =?us-ascii?Q?hiehq1F+oXeAT/TjNDo1P4nF6h27sgMOqR5yqyWB8Fsr2RR8V9orMyXoe5Tx?=
 =?us-ascii?Q?Rtso1jELeruphwpwCQelRPJUBAfc5Z5rxYXvjPnRZT0x6tl2HoibImBPgmtY?=
 =?us-ascii?Q?7D9i5smaQyAZJ5FhmLYGKDKuQNQfdza/n69hhECm8LBvWZrUoqJVMwnK+avq?=
 =?us-ascii?Q?qESwayIO8zgWMeSEcxb/siLaLFK7/ebnCx+dLgsEAu1qKsbqw9u06LEUkH9N?=
 =?us-ascii?Q?eS9+NVVatgcC1P/kekX1k5cFLADCjHg2/3gZ/7c2Zcv7leSLBZm+6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uz54SRAIZWyq9JyjhrTJIajzDkhKsSiJeFRECuKeHy6qXbfIErjChNrqJwdL?=
 =?us-ascii?Q?2v3WWsOoSW5nZUt0Tv6Q2khprcqAKnAmJk4VK5J7A/+cvTQfVySIEHryhWt/?=
 =?us-ascii?Q?wL4p4kICtUHL3JSoHzOSB5LMQIFQneRjU8imCWM8Ml4ZuGung+RGzaIvPzcw?=
 =?us-ascii?Q?Tdqi+w+PhBzcD86VcTkkbd2P2Zw++4TSRxff261aDhm5q+dT6gl+GqR/11ew?=
 =?us-ascii?Q?fA6iU3Mg9YLfSQ6cTgvLof6k52jwYSSd8Yx7qU/Silww9PedQePn4HFgUanj?=
 =?us-ascii?Q?9BuKQzUlJRHoifV5hQT84QD4JXqMZ79tKFHIT+4xeYOAe4wMRhHC3agZy9gk?=
 =?us-ascii?Q?qHOdCStdoeTVzdHysS/jIwjhiyRsPzaLlVYYYyMRd1sEeldLSTcCHqVFpEfk?=
 =?us-ascii?Q?F0zf1y+GGOpHsjEIXVLi/Aw5BEUO30qdls5Gn86uq/kqLUKkV7LH5BgGPLqs?=
 =?us-ascii?Q?syWLjr/Y3QS0ETTJWxXAyA6KePyzZq6zP6Eul0DG2OLqtSvLREst6/KXOxP8?=
 =?us-ascii?Q?AA6yQckIWFNvJIYZkbC72HjZWiWUXEBdFivMucrhtlfczzJ89+BugtMcfiJ8?=
 =?us-ascii?Q?Ps3rn+0KqbHvY05fxe0JfYvRENrRd+AbaA+QgGTq0QHA7nnbVQk84Y4KUIFz?=
 =?us-ascii?Q?da8UfIXlAq+HYBMgbKO1rd0XPJheD6MSNtr5ERWlx88bUpoEwJ4xxHT81TQO?=
 =?us-ascii?Q?hzxODwsWjUTEBZaMPqRKahkmB9dfNOJzjzaXTQOWfviU2XklqZuHZj7bAkcf?=
 =?us-ascii?Q?zTUECuhl+AvSP8aIYgLEhPWSQcfk4X1/tqK/vXlA0ej/87a4vF2d+Sm4HBDz?=
 =?us-ascii?Q?h43DARnTnlfPDqz+7Fr6/Y0tWl6gRRnk3XsHCYMREtvxUcplBMR8mOGB5qkd?=
 =?us-ascii?Q?X5XISrbfJLkSVN9e0wnQ5w5cNGynnnlwK9vzNqALK+0dlzFcT99DdGsAZBHD?=
 =?us-ascii?Q?whzOjlTgJ1XfsBzd28d9JPW4FUzJip5gXXOni2YrvAZI04Cea0snGsNFCsii?=
 =?us-ascii?Q?mNrBgsAI99YbjDwtHgoOTHcLz1W0xYiMjM6Xj52YDi/vmAX/Z+dyD5/eB9lZ?=
 =?us-ascii?Q?2yXa1p4U3EaMKtz9Vt6n5spER56hOUFJx7GJ51ftaraNNAU2Wf5pyECGyNqD?=
 =?us-ascii?Q?8V69imYYNT5s9WezTfN6PxAZXhvEiTP8eADcoMue4eTE0f8QM3fxBLqZURGu?=
 =?us-ascii?Q?OG3KyQ5dJi9MmarANAvJU4gAQxG/+XPrz+dfkp2CUWlUgePqEBdVnXPVs1G+?=
 =?us-ascii?Q?CUFyrA55KhhS9fY3O7AceJWXcdRm70mk5X2DJIF+JtsfOE2snaQ0nc3Mmamo?=
 =?us-ascii?Q?dVOQLv+/C4x0S3tyEw7nsnBm/PeRq4e7cHz7lW6rptVxECaY+HN+tpD7asjY?=
 =?us-ascii?Q?tHEGITFc4s/fNJ1wjpBFczhRv+oEatyNtoQg1DiJ29AP3hQFjmcpmfXNuVkb?=
 =?us-ascii?Q?al9SKaZPujkJN06L6CkpsPjh9OWloIiZhhIJs7Dv6vWo38dWaVrB4V7FnN48?=
 =?us-ascii?Q?PZ9B8DRfxeZ1ctp30Ggev5ERXpfDaiTpRMe1F5AtNU4tJUTsGuG9b9msmECA?=
 =?us-ascii?Q?4j4zfN63PE6TuMx6eCM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642dbf05-87f3-4012-8333-08ddbe5cca95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 20:19:50.1493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTiTVQxoiaMvmumHhm9JlJqoklXPizfxPdqUF7VVt4ovs9dERnwf42IYUPSKSBPENZ9bhmZpSBjldToKnZ6mXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Saturday, July 5, 2025 12:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Use cached partition mode, if valid
>
> For current partition mode queries, return the mode cached in partition m=
anager
> whenever it's valid.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>


Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index c8fcafeb6864..c417f8689220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -218,15 +218,27 @@ int amdgpu_xcp_restore_partition_mode(struct
> amdgpu_xcp_mgr *xcp_mgr)
>       return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode); =
 }
>
> -int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32
> flags)
> +static bool __amdgpu_xcp_is_cached_mode_valid(struct amdgpu_xcp_mgr
> +*xcp_mgr)
>  {
> -     int mode;
> +     if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
> +             return true;
>
>       if (!amdgpu_sriov_vf(xcp_mgr->adev) &&
>           xcp_mgr->mode =3D=3D AMDGPU_XCP_MODE_NONE)
> -             return xcp_mgr->mode;
> +             return true;
>
> -     if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
> +     if (xcp_mgr->mode !=3D AMDGPU_XCP_MODE_NONE &&
> +         xcp_mgr->mode !=3D AMDGPU_XCP_MODE_TRANS)
> +             return true;
> +
> +     return false;
> +}
> +
> +int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32
> +flags) {
> +     int mode;
> +
> +     if (__amdgpu_xcp_is_cached_mode_valid(xcp_mgr))
>               return xcp_mgr->mode;
>
>       if (!(flags & AMDGPU_XCP_FL_LOCKED))
> --
> 2.49.0

