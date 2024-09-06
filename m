Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1832CE7AE6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 08:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDD110E9AF;
	Fri,  6 Sep 2024 08:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HYA+NABz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9542310E9AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 08:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbdhYTzYYFbhRLUylc7bXXVIwKBrw5t1OdQicL+TDO05UIfqeLtKBqzsyxldkJyYfc45mEj+BKbfCt97myhUrY9o7/kbFEuNux1ga93hsPIe9uCMEWDd6H8FOwk+YctSxvswbPWL9Aw4ytHEAy2qLyy9hGEMB1S7jLIWOfibtBFKA8B60nYWzsm4rJr4Zw1ELUmXaj55q4dZX6LzegOQK/ojJliaURJUCMa8xSllrqZ7wz7UG8DPR6IH8pKjK5XNEu7GznJ2apOs2EMXoYe20lBE9yoCeDoBPr4lhAeTJHy7sh2qtDlaSPlpzGfKOBonb6eTU27bRZHwaMymgrhVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0czrZhmm/tmidIUie713CIwJQKwD1/wXY3FE9v3uMM=;
 b=ar3aLnttecNb+LEV3Gi0zEtDa3va5t480MmAB4tuvL5MDmAlVc7pd+imcheRTKW76s2qk0TW6walquzCjoaUWvCyRLe66c1egtBlAXLZhWeGNgXyv4sRMmzeJU+NGJRU3QzSSM++3dVytd1JFp8o4BjVH2zxJrTYrrvAqmyGYDTnHV6UYTr9W/dmw2XqXOswJ34xh/upKYEZUQjGOMXx6TJYVwKwXK2Zf88AsrZv/0+M3B6+6hl75hpOewNKG4s7csV9jhCo8G6LPgGBWKZ3rPXuhJ1IL0MaVPNaRq9e5qWAENBdA7emWCkZy8Pjsbt2phbGlw2uw8hevr510VQrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0czrZhmm/tmidIUie713CIwJQKwD1/wXY3FE9v3uMM=;
 b=HYA+NABzRJIGxM9XKsXuapwG+bcr397CqLhvNIvcoh1BgHqWUGhs9leXYFlW7VsvC4XkRFGAoSGDkR+wPmTwcbSqF1ve77asIYE1WauFWl4GrVEV11JUs09Uf2Yw8r+wtkrzqOzO6/ndyqkC1XnmXRI/4YVRlS9+nRolqVc03Yw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 08:24:33 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 08:24:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Select reset method for poison handling
Thread-Topic: [PATCH] drm/amdkfd: Select reset method for poison handling
Thread-Index: AQHbADSXlJ+Esio+4EmGuBgzRotHWbJKa/Fg
Date: Fri, 6 Sep 2024 08:24:26 +0000
Message-ID: <PH7PR12MB8796D1B2CF672FE834E91FF5B09E2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240906081251.31139-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240906081251.31139-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1fddf656-fd6f-4810-a140-63d414717ba0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-06T08:24:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN2PR12MB4470:EE_
x-ms-office365-filtering-correlation-id: 706f81ac-07ae-4e2a-eeb9-08dcce4d525b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G3ThjFwfC1eEBtBfH4hykM4h19+TrcgO4yhUe8OY82oQKVPyWLHdq8230i5F?=
 =?us-ascii?Q?3IFUR+341FmX/EoyKCXI3CBXFZti4Jppq25T6rJ536cxBFoWlr9dLCjxDagA?=
 =?us-ascii?Q?2+0iYuzuG1BETOzjukNwe/sxRWlZJiBOFt88SvIc1aqCp8+H1EuDVIPsGj9J?=
 =?us-ascii?Q?bAXWZHCWq2JhQBYT5tJ2g+L8mRDxIw4Cj0K7zTmSDWROEtJvdd3ZQSQCqdra?=
 =?us-ascii?Q?cQRSd2KXKCKkX2xsWlP2z51tBdcyD0rm3F8QgZBJMydtkbVg+J7qSI4Yj7/B?=
 =?us-ascii?Q?66qKiczxkcx2ln63yV/d33FqKfrkDksDyBFQl+sM+QTZ7GHPyOh+6fNemFj0?=
 =?us-ascii?Q?jn96304gbNm3xbB8UYeZ+KHs5z6hKT7yrc80ZOU51kWbxAN08sdWOv0x2M2d?=
 =?us-ascii?Q?Ku3IlZL/CiQ1zULX5BbN/VwsJcXSintfON0w1yq3HIyWhNdSRwj5FLT3NIPP?=
 =?us-ascii?Q?ZV2RQ3H7Yw9lqp26vpN1dfEDcbuvaaa695UmllPFQYJBZO7b7+21D9UX6beT?=
 =?us-ascii?Q?VaMUHW359xdPa5YgbfBvErbpb46iOIWYfQCKyIKmStIsqZyr97uum0tUxG2E?=
 =?us-ascii?Q?RDcwa5Sdfl7I9xwnyvAozrcrFqOVbSturumShpsjILlL4aW5VsC3XvEVIsVk?=
 =?us-ascii?Q?5H2ajsesM0OrZyW5y5+R518UbMCUrHvNRJyi67TxZKMOzGY6iISEe3d3vFaR?=
 =?us-ascii?Q?BBSCrcx4KzYLlJPNeXx/A+loiUGPVt8CTYxxe8l+k2AHKKd/UtEZXgbk4ud/?=
 =?us-ascii?Q?iUQayzU0FI2+AQF/lNpz17EunXcHXZDMqDuF6GYj4VHuVofeTKe+NGLAe7fX?=
 =?us-ascii?Q?3SDoSOqUNubgQ99ij+TmPMczelfAM/3eA7cj1ezxUk7I8XP/2jnU5AWXe3gY?=
 =?us-ascii?Q?vho0G5QXtZYottwuvaShCBwppUL5B9g3lBJT3GK/5hCKAYaFQ9I1GbSCu12l?=
 =?us-ascii?Q?steLFy/oydyriZ53ATspsHCOYokaJbdOntx0NkEPkxmnYO9kXVhmQbD9vC0C?=
 =?us-ascii?Q?u7k2q4SHONRnxyNTWhFVUuGgC4DTdNh7U6S+rvHY7sxr/NLyMHDW6W7r1iRA?=
 =?us-ascii?Q?nelptox8V0OF3bDCqXgzQdbk9h/9+aur3nHihVjNZk4ACkjbDItLFNCwakAc?=
 =?us-ascii?Q?mlyNnqshf5a+yh5KAjsgZp4iBjhe+ZC8tu52cnx3ryFaxZrSsX0UZxEB7VdK?=
 =?us-ascii?Q?13QbUkx7qmtYhy56i4OL6J1RLU2yHq+XX5h6LWsivDUKUCFULJr5uaEGJWyH?=
 =?us-ascii?Q?puv96zj2exAe8nx+opPtzkgQUHZKKW+5CNXmQUaHlG39hUewbw76bVyiZoBP?=
 =?us-ascii?Q?CGm/aoOGD20c/JAVo8gij/UlqXlepueHCz2FWawkf2ZJ29EvDG6KKqNl9axP?=
 =?us-ascii?Q?Q9CDIy4PWkm7lMU/AXUWX2gvQsHqDqluAYWk13Y3KlbsE5tTtg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oDvELmvLLRL0da47fTGH0R48iZQLrJ/V1oMcvFzKLmDsPVBHm9Rwu8g+/tvL?=
 =?us-ascii?Q?0Xb1MVj5J2/3elKsUA/NhjPVTZRPpaTv8Yi1M8xgnqP0adLe0qgkdGiX2dN8?=
 =?us-ascii?Q?lTfKSUOJhx/xGoylF9ZCktE296cCVnchfUeeEzzIAMA6s9Y5zbPqaZZxnLLs?=
 =?us-ascii?Q?O6oiuHDVO+sW6FH8GtDrHLYmKBMoVi6siEiPAEf+fPOZGs8fqcQKaIDgFEZ4?=
 =?us-ascii?Q?L+zliGkjAu7heGgfI3gxg8U2LYUw4AF5sRM7vPDBsWhAuAH5ZTk7KfkOleFc?=
 =?us-ascii?Q?SAsna/poY5J4HT7oakV7ITZXli3hz06cxN2NiFnEzJwkeGkBnIMqrQU/EV7A?=
 =?us-ascii?Q?Gay59v68VzdjVkMaV1vT6TMoRXP6n7Fk0r8UNLi4DAO+lXRPQgyPIbUN7SHK?=
 =?us-ascii?Q?+3+G/AcHdqyfKB9gnVvNcgfw0N7/sdbGtZeDOsI59sIETFdITG2MefLHtxbB?=
 =?us-ascii?Q?Rt/ahWGv0vq5k2m9SurjWM012v5KgMzNO0BmjQEjZyp+JjAINT2/Ml56DQmn?=
 =?us-ascii?Q?anYgRrEySuTCDmPNm5j2EuTQ16EY6M31WAgBDiJ7ijKf+Fa5rd8vRtJY6jZ9?=
 =?us-ascii?Q?MjsEvILvboZemHEeK1hsMKcFymNzdXFLsuVIAC8awQGTLzd9LG39war+8Nn2?=
 =?us-ascii?Q?SCJ6BZt4tCWMV0EVDZ6NbRrxCu0aKCOrwmsLBbYCgOyn65ZewfSh9d2E4qw+?=
 =?us-ascii?Q?CDKbFuymqqYvKEnBXpM3sgJoGuhpUaCxOY4MiOQG8uyrkAUwKeWTPhclP277?=
 =?us-ascii?Q?ZhNubdMOCRTi84s0HL9A9bJAA4HHv/vFDyfCmvVz3DhdUMgUqbhO2qE9juwt?=
 =?us-ascii?Q?ujhKaaI3JgmFXAGZxUj4Q6GZpIhLcCXoPP/03k/izSFCQNPc7A+nG/oZsFo7?=
 =?us-ascii?Q?AdmJv3eivDdmEG/I7rv/VhAQD6R5uuEourT9CAYuo1Le/pQ6IRpUasQsoG7r?=
 =?us-ascii?Q?5DodmuZ24J24kU86BRtCqld2Q11x9mWqMo4ldUS5PdZrMkJ2YGznxvm6UaiT?=
 =?us-ascii?Q?mFRC/hn2i7W4ZRsSiZ3Coh3sphMzKAD7VgVsXJIjLUaQfGW2UZQwius+WyMD?=
 =?us-ascii?Q?BrIKRqelwGBKzb3lvMS5Ob2SMeGdi3l7j86jge6ieFpQYjr5hcIq7FRVfSDS?=
 =?us-ascii?Q?11xzNtR/GuDhXxv3tVtjBSg/73CoImUW4ASKqCHcKGkjawQj7n0NJrEJqE89?=
 =?us-ascii?Q?AHgxaqqTCRpIcGxfL4v7+t+u+kWcy1v0iJYkyPqfsGZIeyK4nCDfV5UcUjI8?=
 =?us-ascii?Q?W7nGsfoJs3pd/jyjzPUtLTzTAElGxtvDR1FiGW0WsjXL7z91z9U5pDeActJN?=
 =?us-ascii?Q?GckD/04mabRRG5Pwuf4gcXyqAdH5sGvkTkALvF+pnV+nXiHSWQxUmN6+38jA?=
 =?us-ascii?Q?lrQp1U+LFIiVpLv3HtSbxcbFuRDeHhCAZ09mCYieje9I0Ilvlv8bPJ8Aj7Oq?=
 =?us-ascii?Q?QasRfx01Wl/ahievObGGRF4kwoJ9S4QaM4swdhfpTUXJDrqagnrsnHOn7gIc?=
 =?us-ascii?Q?VeAHEDYLDIgpk5sJNBhWEdHIp4Xa/BHyfHd3oxypFY4Rk2HGhey1X/GyU6tU?=
 =?us-ascii?Q?xYR5QTqpjxIrlRwOqQ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706f81ac-07ae-4e2a-eeb9-08dcce4d525b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:24:26.9058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJZnVZHV14OA5jgvMuGhAwqNwDovLY8Zn5Ypcl0+4FdKfTPwtHgMZQxg+Yfnfesc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Friday, September 6, 2024 4:13 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Select reset method for poison handling
>
> Driver mode-2 is only supported by relative new smc firmware.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 40 +++++++++++++++----
>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index fecdbbab9894..d46a13156ee9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -167,11 +167,23 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3) ||
> -                     amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 4))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3)) {
> +                     /* driver mode-2 for gfx poison is only supported b=
y
> +                      * pmfw 0x00557300 and onwards */
> +                     if (dev->adev->pm.fw_version < 0x00557300)
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +                     else
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             } else if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 4)) {
> +                     /* driver mode-2 for gfx poison is only supported b=
y
> +                      * pmfw 0x05550C00 and onwards */
> +                     if (dev->adev->pm.fw_version < 0x05550C00)
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +                     else
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> @@ -184,11 +196,23 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SDMA3:
>       case SOC15_IH_CLIENTID_SDMA4:
>               block =3D AMDGPU_RAS_BLOCK__SDMA;
> -             if (amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 3) ||
> -                     amdgpu_ip_version(dev->adev, GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 4))
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> -             else
> +             if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) =3D=3D
> IP_VERSION(4, 4, 2)) {
> +                     /* driver mode-2 for gfx poison is only supported b=
y
> +                      * pmfw 0x00557300 and onwards */
> +                     if (dev->adev->pm.fw_version < 0x00557300)
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +                     else
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             } else if (amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) =3D=
=3D
> IP_VERSION(4, 4, 5)) {
> +                     /* driver mode-2 for gfx poison is only supported b=
y
> +                      * pmfw 0x05550C00 and onwards */
> +                     if (dev->adev->pm.fw_version < 0x05550C00)
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +                     else
> +                             reset =3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             } else {
>                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             }
>               break;
>       default:
>               dev_warn(dev->adev->dev,
> --
> 2.17.1

