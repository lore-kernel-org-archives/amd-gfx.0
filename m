Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4775ECCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 08:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E101510E3ED;
	Mon, 13 Oct 2025 08:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxxq3JCC";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012001.outbound.protection.outlook.com
 [40.107.200.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73A510E3ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 08:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAjMpfARg/GlEtEmMCQqU0N/cKmDqEYwSx/ftNDJMT7gK5Py6GI48PkZjmD2qGXJ0do67yWQVG9kRvWfn/ZCSAbZvUtzUIPDG5JxNtSOx2YYdXy+JrACe+uXO7B3nUynHfG1ufeVvM8czi9iIcFzt292CynoQUM1pud2i81KsfM2ZNt/bmVqKhUhqkfS5y+AuJuHcK8hOWIPdKY1LRcjndmaKmgmvzYIIo94sgVin9QPXHmKaOe0qhS+yF42ycsNHKqNWLAhhK7eDujh8HF/QIjye+3hJBdGd/9I3qN6fVd23LeZrxs/Z+1PEoj8M0p4pnwWeywSIEczLBSjNLLEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCuANsAR0ZeDGiqn4JlQQMnUSfX+lEzo85YuaETxBzM=;
 b=V7uNR8156pIz+B+84q2oGg5kf521uQhKKMCHTOhrGTiHy4vR9EcwAwndH0Q/tsm4sIgwdt4VpXw2a+7huJ0yTzv+wpy2khGSC5kS1MgQIeVd48UQs9hI/S0BAz+DNXqWbsFTorDYGY+BCuO//XbMn2x880lS6a7rP39noGU4z2AVeOC4rraojQ8kiFU6OEOpIkAQzps7NjjMWXWozPnFz8nVQCFIJzFSYyXukx+n/OElvVt/Lw/MZb58h/ArOm0e6o3FOnC3DSSAOOyexKepYx/eeHTS08ZstzcnsolwlXmDx2+dcHu4qIHJBMm4rlY+ZrvBrp6An5fcvq55WSVaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCuANsAR0ZeDGiqn4JlQQMnUSfX+lEzo85YuaETxBzM=;
 b=mxxq3JCC/IycLVEcickcwNuCSZSb/0Y4gUi45Ty28eOb9j8RHZh3kanz8Q3vkAA7TVrUqAqluMZaPGukF0CsisV4L8b1VraGkszs8B2XFOUm0/z/C+hXtz8zSVUcgPOELe5EfDOOR+pulYr7V9bh/VfoucgXxd5RpV9p3dVf+oE=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 08:04:55 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:04:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/7] drm/amdgpu: drop unused structures in amdgpu_drm.h
Thread-Topic: [PATCH 1/7] drm/amdgpu: drop unused structures in amdgpu_drm.h
Thread-Index: AQHcOisRQDFk12FU4EClved9fmlCkbS/u7Ig
Date: Mon, 13 Oct 2025 08:04:55 +0000
Message-ID: <DS7PR12MB6005073D4C8E04C5F403CAAFFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
In-Reply-To: <20251010211510.1528572-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T08:04:46.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: c57b3453-4430-47e9-71f6-08de0a2f320a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rNJZsY0CeljQJ8SQmWWMI0F1UdILsR5pDpqrXZbjmOuDMHlFUptczLvJntvl?=
 =?us-ascii?Q?TQKUALEsPIw+WSCSYIMaXoBRgQdmvD3GTu8+cyRwGJVhLF8siezlt0NICQja?=
 =?us-ascii?Q?fVaRXe8bPphpuK1MMpGeSbxKMDJmJNdaCCK3bvBpoDIPiPQDgFp8FwvuIwRy?=
 =?us-ascii?Q?24eXAVhWEMmxVRrh4UfAcmLj02aUugeFaRVxKcdZ6UYm878kgn+CyGSNuoxI?=
 =?us-ascii?Q?GC/FlhDCQJb4AueoAXe/Ua685Rx+eroVRqcR8PID8LWqWnOEasd2GP8hC8bu?=
 =?us-ascii?Q?B8FFnM1o3X0G6wM8MSTYHxNKTBuJTE9rhbcd7RdljdMK1V7S2JmXgct2VfoB?=
 =?us-ascii?Q?1U3YAM2NC4Rp790+wvIEqYreWM+hDF8wECddLBl3wjr/HI6nngt8lyWn+Sou?=
 =?us-ascii?Q?0BXulMFrxd3lebw+W4ww625N974ioIcUKs6H3XxP/K8w1lEY7KQ3ft4+jreh?=
 =?us-ascii?Q?LSQjwgq4JZbl6KT3vQWLBnyv56c6Y+Tp/AXs0GXXSrC43TOI3xBy4OEP5h4t?=
 =?us-ascii?Q?bGFRIBs7bfet9qTpMr4JlUAOV7mm/BPHgEhXFeuDS9+u5ZndUyePat9GX/8p?=
 =?us-ascii?Q?/vjGZ120EPL19DRbbsL4zG6XXRyKnBNf5nkcCp8iXS4pWddcIufadUY3xJ+0?=
 =?us-ascii?Q?OQHw8/+aj++s1JUsn/nNBUA/u5w7LXdy8bKyex3bjCnlsuTU7EZ0W5H13H85?=
 =?us-ascii?Q?dQfMz4Yni1g7vtlMNcAe3P6oiZQXwXOCzNZO/dohOsJn+sZLUOR5EK3KMzgl?=
 =?us-ascii?Q?BLMEj9wLiBrLM/yzdS8iSrT9TrmIHI4MdJJDxiH65ZrgMPqdM/UbXp76Lpzx?=
 =?us-ascii?Q?gy9Z7gENEVgZ85oREUXPT/PcHiwNrmFyQh2VYyrJR7nFIdRScM7QkJ978nNS?=
 =?us-ascii?Q?5eFYTOs9FJ1bKy5NExeQwdw1bsn/myQjyRucX6PcCSSZDF5vOOgDO/yskODT?=
 =?us-ascii?Q?fTAfzaf1Pbf7obPgbTdtS6UPsh9seDMYmAwFDdkKkpndvUnyvw5XT1eM+HhI?=
 =?us-ascii?Q?OrhDrZPTkzjMXNHXAYLOeKyMKmx+lyOMd2p1Ad3oSSW6LxR8wHBHSAuyod5G?=
 =?us-ascii?Q?8cukH4yr8f0s4YQuY9F7V/bjlQ0TvCzvswnuKDHvkxE8tf/QPSKvVBr9yQQF?=
 =?us-ascii?Q?x0h1RGM1nZKPBPOrCW2VKfPTIAgDn9XBmXinx/roX8jfKuZgSi/vTekF9CIe?=
 =?us-ascii?Q?S/S8LfPQ67Qpum+WVNUgDDoK7GnhOGnJPPaBG1Q+4pkRTUnYYiA3AkOfTb6G?=
 =?us-ascii?Q?F7CZUfO8JG755l9j+WQjnTCRJ5q7bCFoShQQZ2BGkhgerl9RwOEcPp2iMlUD?=
 =?us-ascii?Q?Hpw26OaOzsOmGMiCaUQUxgkZnz35EKoAXg7h0pax3lEm6pg0/zg+3X7b3tp4?=
 =?us-ascii?Q?xkjN4LNy8xnFY0z0or3TfYu1My6NeBsMuzqgkz+j9AYzVxN4Y0kmiMit69Oa?=
 =?us-ascii?Q?WUNtSXnb3dVScKEP625wpE0qEcepKjiFLDEZjFIXfy30n3S6duUyFQtP3NCT?=
 =?us-ascii?Q?/Vz4r2Z+H9Q5dP5yRZVjj7QB6eAOrdtkqzf9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cuvmhD0ZwVlr79DAPBZ0lVL/UGKiUQBFzD3a0jTmkYXnN+fCp1Nb4zfFJFAW?=
 =?us-ascii?Q?owg/VU9sW7WN8JA0IQtn4Tb6IL4HUqNQpKdSRCZ7sBVKXpyDnw100ezOvvkm?=
 =?us-ascii?Q?Dtm5Gosdjiv91C9LVhk9EF2RGZIB5r7HTbrWpOYh7eR/LPA022nkFP874yv0?=
 =?us-ascii?Q?fC5zAefje4DOiwxvuAUS3ICQ9nfcOYBHuCNfOmPFkAGBKyZlPrChyJFOyBio?=
 =?us-ascii?Q?URhCMBfI0ZVn14/K1JXRlRDUfzViSOXKfROWOSsOxdj9aQ5c+MWItooTlP9P?=
 =?us-ascii?Q?jgE8PNdFMNBXkt2pBg42rconYy0uqHBZcuU3qDNCtxwVhLgC40j/sYN2bF92?=
 =?us-ascii?Q?SCBvAWnLxlQgj6FcaepUs5+wAsZyNz6RujRWvQHQkh1VAmvc0HEPDWvNwdvt?=
 =?us-ascii?Q?4WNRjjgibSLKbpDZxuhZgDg7DV/OEmejmsIifJ0aR+DSeYrICGZgj7XOBliM?=
 =?us-ascii?Q?R+6P376RaybENlGP7soc5eZ1jHX9URpljNnykPcDKt01RkActfw5e87H/I0z?=
 =?us-ascii?Q?uwaI8Tf5i5EDUfwHb2IKFiCfB7yQzu3oG5odMPpy8yuu+RXaemx8c/uYlrw4?=
 =?us-ascii?Q?OW61rBgfAsWNMHfyTG/4fOgcVm1bWyFWgYVR+9aWmncQzcx+4zjjqTejFddi?=
 =?us-ascii?Q?hQEHIg3iG37OVbgyA8reAJyCEkshY0pfnQzb3BW2KriOWVAEcM1cH/OjIuO8?=
 =?us-ascii?Q?aG4NPEC4dwhCmr1wqelnFN55M0+7Lb+iih4YzWYiCUKJu1x1sytCLfJQAqCW?=
 =?us-ascii?Q?03YlBf+MHMFUInZUmvTp1sbLJH/uxeAwl98cwVg6zyApRk2ofUa8L98i3woS?=
 =?us-ascii?Q?AVINP0YCOn+pBMCNOECZpfTJZIi5hYdImrvp78f+6Z9wNGLFpu410XWbo0RH?=
 =?us-ascii?Q?f2oWMdsCKTfNr3F6IKVouljw8OojmCiSL1rPn3LffnoKcO9ZowZ2l+xf0i5h?=
 =?us-ascii?Q?BXoGyjuHZh00jmdr9uK2xTmQZF06dZh103fzIuoZBgrwRWGa+75ysyZLTEt2?=
 =?us-ascii?Q?T4I0UrocHCoMeoFRv13Z9OYgJwjMRcBWYi0hvBj2iyNoRWUGoEOoqjI1WGC2?=
 =?us-ascii?Q?e4lJKbsFiGIHPk3TphFgAeg4qpvrzTnWHjKWWScIda5sV0Hbb5D0LGWopNIK?=
 =?us-ascii?Q?IX72AE6hBmEIQesDgaua/TlaXPsVz1WBdJsTIZBV7bkNYzQgMfkLvgWTv5pq?=
 =?us-ascii?Q?2HlClvn8xiqRjqGOFyrmnq8HMVg/uzJQrDL7X1X5Q9I23zsRLin2tsrEZKnF?=
 =?us-ascii?Q?dtSsMg8uSXa682BTIdxVZtcqUQj/QxFWuHqn7Q9zPKntO4k9K3OJZQIU3z6T?=
 =?us-ascii?Q?MHOoufS0EX7WP2mk2CscZYxT7m8x53vXokhI/LHkiL3ngvnxENobfTqMd0Ev?=
 =?us-ascii?Q?WMt0yjbHdaRPONZJwI6zuUfmjWyYJExlI2H8etPXlpLa5nQH6M2D7G+PwAy9?=
 =?us-ascii?Q?JWL0MQVn/s1OXQxHyAJJKYlR5fweXZcAQP8YH4pGUiPDvwsvCCKhrfLHUF/O?=
 =?us-ascii?Q?anPVjBCsVnyoU6Fcrz5574DIfdTNHO8xyHEz8svrYnYDqnrNy8CE2IQcd4a+?=
 =?us-ascii?Q?q1TPh+qBtCxoyprleR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57b3453-4430-47e9-71f6-08de0a2f320a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 08:04:55.2422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 14rC+MENPLkewlm9uISyiiwsohII1IXVt//u0pNPVWkx99ChBdEBU5jeyD7vVTTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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
> Sent: Saturday, October 11, 2025 5:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/7] drm/amdgpu: drop unused structures in amdgpu_drm.h
>
> These were never used and are duplicated with the interface that is used.=
  Maybe
> leftovers from a previous revision of the patch that added them.
>
> Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq
> objects")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h index
> 3cb316ad54b34..e5252bf597b36 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1564,27 +1564,6 @@ struct drm_amdgpu_info_hw_ip {
>       __u32  userq_num_slots;
>  };
>
> -/* GFX metadata BO sizes and alignment info (in bytes) */ -struct
> drm_amdgpu_info_uq_fw_areas_gfx {
> -     /* shadow area size */
> -     __u32 shadow_size;
> -     /* shadow area base virtual mem alignment */
> -     __u32 shadow_alignment;
> -     /* context save area size */
> -     __u32 csa_size;
> -     /* context save area base virtual mem alignment */
> -     __u32 csa_alignment;
> -};
> -
> -/* IP specific fw related information used in the
> - * subquery AMDGPU_INFO_UQ_FW_AREAS
> - */
> -struct drm_amdgpu_info_uq_fw_areas {
> -     union {
> -             struct drm_amdgpu_info_uq_fw_areas_gfx gfx;
> -     };
> -};
> -
>  struct drm_amdgpu_info_num_handles {
>       /** Max handles as supported by firmware for UVD */
>       __u32  uvd_max_handles;
> --
> 2.51.0

