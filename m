Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844E9C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 15:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E3D10E95C;
	Fri,  9 Aug 2024 15:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z23K0Rpf";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A512710E95C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 15:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTAY5W/zByBGZ9LcP57ZUEsOi8tHNqRaGmbY+6TABBH9mAYQp6v2RWxPfRtgTDrzbwbrDw5Mr0bQb/81kU2L3sDYge7CxNHURLQMKWo2VDSP1xVkK3GuKnM1GTzRMIUZAQMCiNh/LASAfEvQAcAnzCxwSszrgm2zHpdKCVlHVS08t0XPTJpnuALiDwb9PGXNtHB7PelavbwlHDOuKel4TeIwLpWUtnxJxlLOCBtnMJj7IpvnJ457YE9XGd02jiOYEoOQBbTA62QPsCLFoD1nmvLYNadyNSBqViGLBF2njudu7Hy9dBmh/CP9e/cPp2WVXZZlzsVG4cwCl3FxSx++oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4r2sM3OwJuQV56th9fK04axz/VNZXQt16lFWUXGcEQ=;
 b=D7WD1xYXr8quB2BPgLLcnZ7GmrgUWpfZIKmL/fRZbT9y6Di3YDLKMj7GyoNX8tzthDExbEHthcIFX/X9X+Ykcp38Rk6oS85IcqeZKf/AMVrXr8n+SwilsyBVQfr5Dz8m0EHJ+ABUSzAbpAOiRbbsYMM9rdOkhcP6lWy8biHmfi6u7JiKL9f8XrEAqTRSvh0Aex9giTG4UoM94fwNlDmMWEmpFAkVHDHyiwXlYRKtqTCXKbXBoklYfBFEnNuXrV60N/07XzZ8BfD/FjOE0S9JjcXTDqdLJSHQJoUSvivZCiLngKKLj9II8oL5/ZPhMRYbh1cn0Hx2r7nyVThMR3Goug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4r2sM3OwJuQV56th9fK04axz/VNZXQt16lFWUXGcEQ=;
 b=z23K0RpfIp2oVJWzoM2HPh87pyzv1qi5uwal5bi1aB2G/wxGQsdmGCjzjjg97AioyzBAm9EgpBFpOZ83MQUNLHXdwf9p7RhYZ/a8EZ8oNiBVhFXYq+bLErVbOKlZmMsgSwaXPitkh6aN8NqY0nbVQ4UV+U0WokperryJca6MMJY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 15:38:50 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 15:38:50 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
Thread-Topic: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
Thread-Index: AQHa5PprKQd9H7GTM0GN7sauDPGH27IfGlNA
Date: Fri, 9 Aug 2024 15:38:50 +0000
Message-ID: <CY8PR12MB7435D854A55303772818DC5485BA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9fce96c9-191b-43b5-a78b-1b69f8773c44;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-09T15:38:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CY8PR12MB7633:EE_
x-ms-office365-filtering-correlation-id: bd04856c-59f3-4754-c33c-08dcb8895e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?okdnh3LsBa4xXFtbBFo0BIRXsAKQbdryISlF75odgztjAKVGfW/9nL5cXWvK?=
 =?us-ascii?Q?dtWdjNABM7qngWctePyfyURANAFYlVFBB35kjoUX65mzgQOCX4jK0r74a9H6?=
 =?us-ascii?Q?ulbZ1WbgdE3QzDklHRLv8le/ci2LaRQK9kvogEg+jPTHIU6VarzxyXXq3fJy?=
 =?us-ascii?Q?hkjeFRHnE9wRcoagqfKbUbbCEWAP94Z4gNqGDOCxyh30HXVJxy/Hjxrri/+0?=
 =?us-ascii?Q?Atg1t/HQqJvwWkWDmyrswVsjUUY+pJ4GE9lRy+s96qGZPz7SUrM6EMBD6W4I?=
 =?us-ascii?Q?bJbjJdzDQ83fKDAuA51au/h7juA2AjajohYOPEbnnuhwHHfIJOYp5aibTB6+?=
 =?us-ascii?Q?dpoOUpisWYUh9bOMQqNSHVcX+pJBcBMmgXu5X/bOA/Ui43L5ZN2vYDzpYije?=
 =?us-ascii?Q?LGTEjht8M9LwlD/GhMN9AsyAVoqp9Xj5/y3RkFNBUWWxUcRMBsKdwhQqvzJY?=
 =?us-ascii?Q?CLFZJT+7QrYjGRR9l0KlAfkHotCyab6dNWwcsX2fDphGJAh5IkVt+t3Xjf0a?=
 =?us-ascii?Q?QVR63M9Ym0ZrSUPqfOUq8A77wmo1Xz9JGpUKTshHTcolGr/ROiA9DKRRWGor?=
 =?us-ascii?Q?0C+OAOHvTcxY6PIFxjmgDYzaKHKgNcfEaqH27Km9sWPr4jvq8fIx6S4A05Bj?=
 =?us-ascii?Q?DI/qnG6lpOLPX1olDHt+XIb1AsP/59OcxscqebSVhkkBgnmWIxfAAV9XOUg9?=
 =?us-ascii?Q?gWowG40PWtkQWKBtXYVxGf0M0NRb4gYtlYrzqyQaGwTXfWg9pQdsab8vNWXV?=
 =?us-ascii?Q?x/t7bSfEiALxykm2a6/Km9mkSfJPqP9AT4xwutA174kbvKXtoctAq2iIX5dE?=
 =?us-ascii?Q?4DZ49pDWWCYVNycXSs7SvmA1FMFyaHiC48/2Dgpd3Km9NhvSG9mVlvIRa+rI?=
 =?us-ascii?Q?cy8eOItA59ofeAURyzJguCJuY89yNEroZHn0Xn9dJ2lPDre3vnlQFVAI+GW7?=
 =?us-ascii?Q?JhxSEomP3RjupobLFy/CxmxjXvClRKFVWeODeHPjC43Dv5gfgS/fgV2G4uC5?=
 =?us-ascii?Q?zbzEUM8C+gzQQNqd0cXUz4JzYd4+WW2aaRNwno7p5wT6no331hIF46kDC//S?=
 =?us-ascii?Q?VcwcvhLgGRqZ8oZjRNHF3RbjR37i4eyMiuSwe3dLTDxsEoijcaMVLKsbfIAq?=
 =?us-ascii?Q?yrCXKkp3fh1wLTfHvIi+vkMmkfVI5FzZZUgBVSpEiC8OIfAO9NuGMu/p+srM?=
 =?us-ascii?Q?2ruQVngfuYGhAGit5J+g094ha82pEzmK3JZTTcloM6pEkGLhgpteR3RI/B2Q?=
 =?us-ascii?Q?aXikgsRX4Vg5Xnk2M5kW8V1SQ7pIpJoUkgDwgTTmfTf6V8WV8shKa3d1wvw2?=
 =?us-ascii?Q?7g1rqADcmOFKAIj5f80PexZsJeex11CZtlAUcSqKgkdKw/vytL853qAzUZ+M?=
 =?us-ascii?Q?jhazu2n/KrE67m5ubMg6fFTdC4lhRqYNM/sB95xWlr5dlyFkFQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CllMKDvocGCLx7cOT5vI5DcJ+jX+FnEu+2w/DRMXnVPf88kjc2SzcPR1Ee2P?=
 =?us-ascii?Q?cu2wI6KPWCG25qWcYgaRbq0xTfxTASQk8w+vXV41h+23tju1Vcn8Ecj4l8DR?=
 =?us-ascii?Q?ACDErJyDzx4elQFn9zcKxMAynX2d9z05T/qBt168JSX26fZSBkeH10rfJ/CT?=
 =?us-ascii?Q?xnkTWSUPudIlT32MOmNuZXvvgkcQb5tA41JSftUdQwsRcKpI8YKD03SFMSij?=
 =?us-ascii?Q?gIXxoiQXfCq8iWGqnLsF84DJdgca2aVP0herIUQnigSSl77Q9U3ozsgoB6qw?=
 =?us-ascii?Q?4fwmO9YkurQQBDa3UCww4FW9CbmdKZNrb96tVRcKEQ4OXq1rNcwGSaXBK0NW?=
 =?us-ascii?Q?Pj44qYQZStt8oDiNBwFP3C52WZTuomglft5tPVBd2dGz8TYPoR8SARaDVA4p?=
 =?us-ascii?Q?nUqiGOu7YvGdQoW5v7HEcHp8o8NUkVlLYJdvobK7mx12/tQ2CxTQiAw4HmwU?=
 =?us-ascii?Q?8OZ14YKiclVc9CWSKObINEsVmDDMtuaQIA3tOHvUoXvQz40qAltCk0m9fv3q?=
 =?us-ascii?Q?EraHjgUXxOge7o7XJkt9xTCVMsV+GK+nVt1W6MSJ493GatZIiqm4gAZUPhMI?=
 =?us-ascii?Q?+B+lKPR8u1EBtWzzSgBy/qGC3YalazheicQj/FWDenzZDTXN0mqcw/pQ0yTY?=
 =?us-ascii?Q?cG1CarIMCSTIHDp4AKlMquBzoYrsstZrkJb71IKBXihYLcH40bl9KTk0iEVd?=
 =?us-ascii?Q?1nUU0KXo6qIe0xKTaEBNYORhJx6tyLhhuztUrNpi7VHUj+SMuhfjbVRBrTFm?=
 =?us-ascii?Q?mqo9WAnbzcldlsYAWKLHeonZhS0NcriU91dUVaCFqGY4fSv5h1sMKSx6a9dn?=
 =?us-ascii?Q?KKlp+EuivKDx3cStMl4aaU83OIpYIhaZelYlFgmbsFLbW91Xuv7cfXplabw7?=
 =?us-ascii?Q?R7YmbBz9uCcKitMFqWhzdIOL/LXgCPnq+jxHlZqStW/hwes2f0q8iSd98vuS?=
 =?us-ascii?Q?p4KA3WvLmE+uyXFiBjIznFGsV95T5kzyLVWFuW5nHEWqaYtyg75mXrRdKSm8?=
 =?us-ascii?Q?2xW946TjP8EO+QFSU3kstpZ1Lf6OOtBA0BQKFGp+VwH8+i4znLbYdvNj37R6?=
 =?us-ascii?Q?qnogrkR018gSkBWHOcbjTi6jlDn7Ui+aAaUAanG/A6o1/uHxcx5u6rcRMhFC?=
 =?us-ascii?Q?IERvnvWOFOCjp2XxRH3QPEC5h6C/KXcfxgVu0Bqb0Vn9HsTH0Lb4yA/vH52n?=
 =?us-ascii?Q?FMg/RuKgfaxD572H3cPXVi3GzaeNK2NFc6Qt7fDFr1aWt37fZAtDZfUL80nZ?=
 =?us-ascii?Q?uvw+o/D4IQaHAYja6xVsqi+tdgEoAAp97xXKaOlsZczc6memGrBG7esV33u7?=
 =?us-ascii?Q?bxf01/94VIJ1KhF1TiGxJwRXsbyKZTIf65XrxpUOw1bxJcWj5kshACvAd/SW?=
 =?us-ascii?Q?ahRpK/h9f+UA+3OfQQSQP+bQAV6G6mbnFkEVS27luItjgjA9KrN7Junsm2Jn?=
 =?us-ascii?Q?N5pzyTb9Dd9D7NAuWeYWIPUnYCsZ6gch85+cdZ6OXre993siw1GIXyOBsmpX?=
 =?us-ascii?Q?P5uEPehI4kND5Y3xBppavFI1eYrKLEvuw0YSKRYc14EyE6DOAuOOazYj+S+P?=
 =?us-ascii?Q?pLyoQo4yPa2iLu5Y5uc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd04856c-59f3-4754-c33c-08dcb8895e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 15:38:50.7551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HY16klcMo7M8eoWL66+wFmpIC+Um3jIPQURDPjejOu37b/7rR9SsK8q4V40VcaD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

Ping on review.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, August 2, 2024 12:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail f=
or
> gfx9
>
> If queue reset fails, tell the CP to reset the pipe.
> Since queues multiplex context per pipe and we've issues a device wide
> preemption prior to the hang, we can assume the hung pipe only has one
> queue to reset on pipe reset.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 46 +++++++++++++-
> -----
>  1 file changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 32f28c12077b..c63528a4e894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1173,12 +1173,30 @@ uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct
> amdgpu_device *adev,
>       return queue_addr;
>  }
>
> +/* assume queue acquired  */
> +static int kgd_gfx_v9_hqd_dequeue_wait(struct amdgpu_device *adev,
> uint32_t inst,
> +                                    unsigned int utimeout)
> +{
> +     unsigned long end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> +
> +     while (true) {
> +             uint32_t temp =3D RREG32_SOC15(GC, GET_INST(GC, inst),
> mmCP_HQD_ACTIVE);
> +
> +             if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> +                     return 0;
> +
> +             if (time_after(jiffies, end_jiffies))
> +                     return -ETIME;
> +
> +             usleep_range(500, 1000);
> +     }
> +}
> +
>  uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
>                             uint32_t pipe_id, uint32_t queue_id,
>                             uint32_t inst, unsigned int utimeout)
>  {
> -     uint32_t low, high, temp;
> -     unsigned long end_jiffies;
> +     uint32_t low, high, pipe_reset_data =3D 0;
>       uint64_t queue_addr =3D 0;
>
>       kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id, inst);
> @@ -1202,25 +1220,23 @@ uint64_t kgd_gfx_v9_hqd_reset(struct
> amdgpu_device *adev,
>       /* assume previous dequeue request issued will take affect after re=
set
> */
>       WREG32_SOC15(GC, GET_INST(GC, inst),
> mmSPI_COMPUTE_QUEUE_RESET, 0x1);
>
> -     end_jiffies =3D (utimeout * HZ / 1000) + jiffies;
> -     while (true) {
> -             temp =3D RREG32_SOC15(GC, GET_INST(GC, inst),
> mmCP_HQD_ACTIVE);
> +     if (!kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> +             goto unlock_out;
>
> -             if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
> -                     break;
> +     pr_debug("Attempting pipe reset on XCC %i pipe id %i\n", inst,
> pipe_id);
>
> -             if (time_after(jiffies, end_jiffies)) {
> -                     queue_addr =3D 0;
> -                     break;
> -             }
> +     pipe_reset_data =3D REG_SET_FIELD(pipe_reset_data, CP_MEC_CNTL,
> MEC_ME1_PIPE0_RESET, 1);
> +     pipe_reset_data =3D pipe_reset_data << pipe_id;
>
> -             usleep_range(500, 1000);
> -     }
> +     WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL,
> pipe_reset_data);
> +     WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_MEC_CNTL, 0);
>
> -     pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> -              inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" :
> "failed!");
> +     if (kgd_gfx_v9_hqd_dequeue_wait(adev, inst, utimeout))
> +             queue_addr =3D 0;
>
>  unlock_out:
> +     pr_debug("queue reset on XCC %i pipe id %i queue id %i %s\n",
> +              inst, pipe_id, queue_id, !!queue_addr ? "succeeded!" :
> "failed!");
>       amdgpu_gfx_rlc_exit_safe_mode(adev, inst);
>       kgd_gfx_v9_release_queue(adev, inst);
>
> --
> 2.34.1

