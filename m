Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB00C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A89E10E2E4;
	Thu, 16 Jan 2025 21:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o3cz0qDF";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F82710E2E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoZHzuQ8ihDDMtIrEydnK/XGIGZoKKGbiiW5A6TpdUTmPJGu4iydMH0oExsnK5nFuZvp+w01ufZ0QVJR8pLO4cHETSiO+z2aqO/yLQOmwD9PNyZxp027kuo+0UCwPRtPuIc9M0z8LSgBe+rBYAt2BrjkIcGlfHUFFvhIfaR+R620Ff9LXS54ZWb1PscdKS+kEuy9o1b3+qwPXh0mhJtVPdsXH40Ry2yiOhis8A53iiyd6nlYEO3MVffAJeiWMwenqF4hqCS4NBxbY5Q4PhZVm7OJvIDHWGIEYm5acGh/7o4Tft/RUKX/nfyj4Vkws4tVjsRBSM5Nr7lRknKMSDREgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6igKHAa+R1oGx+mYGxGIKtWngDdALd+FpBGBbgqa/c=;
 b=KEusb8HPLrMl/x/O0V5zlKFLPCAoxp3HK6TzLX5saONvu+p4MH6XcQTAe8pRxoWKf7LI7BJlx+skryJTwynE3bzm19hOITKHuKNjq1CVbRkDtbGJ/ucle4s4GOuhe/v3inSvEprZRga9TeuiYT/gSkZHJRSJpUCUcB1X2eonREcZULjcetnA+9ILEL7U/cHIhUYxidjU2BNgL3t5AmE2p7U0pyMCi/lvCz06HnK8zU8F/n2rYj4Ta56kRl8eqQCx7u8iUfAa2372hlupPC1Nt6ay1wK53S9vsduHKD0G42gdvrJ23EdlR2GXUj+uR3bZX7DyOiGl+24dR4VxRiH4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6igKHAa+R1oGx+mYGxGIKtWngDdALd+FpBGBbgqa/c=;
 b=o3cz0qDFtvZ59p+bZJljYnaygv6wmjaFDQv4oi7PdPDW86Cn8mwJiK37Qjo5vJ9BI9Hn4jMXj3hSkjbQSEraOMRpXvMmO34gMxmXg1Keu1vTyFsX5xW6hSKXZn7MDpJSpCSP1bbBp02IGjVr/PzU1hXJiAecd2VnjQxXkQvNFwI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 21:00:08 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 21:00:07 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Block per-queue reset when halt_if_hws_hang=1
Thread-Topic: [PATCH] drm/amdkfd: Block per-queue reset when halt_if_hws_hang=1
Thread-Index: AQHbaFcDUmqmv8qY90+BrT6nbvSFxbMZ4gpA
Date: Thu, 16 Jan 2025 21:00:07 +0000
Message-ID: <CY8PR12MB74359E59F1AE20F596DE8B2A851A2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250116204059.618389-1-jay.cornwall@amd.com>
In-Reply-To: <20250116204059.618389-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b6776ef0-2aa3-4e05-b4c2-15e4da1aedb0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-16T20:58:26Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB8845:EE_
x-ms-office365-filtering-correlation-id: 26fa7986-fe95-4a9f-d7e9-08dd3670c1d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RmSkE+19HNMVPObU5zuZtxlUQ2Hh16NyHAZi8NZND6W0ApYZ7NjQTWeg06hR?=
 =?us-ascii?Q?a3KVicf24TGK1Weea7QrYA780NzhGYuje3uxpFB4Xu7FrcUyC28AKmLvibKI?=
 =?us-ascii?Q?i6yfcFziV+PVGdaKNdC7/u0Q+iA7Lv7guDvLPbg7b+gdUWxIyyFJ0wCmZqmL?=
 =?us-ascii?Q?7YunnwoxiNloteEjS3TLY18g47qvH3mSP/S7qQTlIKQaZrdMqBi4AxD3l7/t?=
 =?us-ascii?Q?pxDuWjNUb4Kljzxzk5h77GdFwdNCQQEPs+hLVmq1cQyIMkjHj2l6KfW+gkSW?=
 =?us-ascii?Q?k+2MAjsdUpUl0C9VVfVmJkNzzb67xoV25Ouqxf/+n0y6HSyjj/2CspN4ojrK?=
 =?us-ascii?Q?IJD+0jqjRoDov9stYTD52E3YV5a3OwdG37xiML75iVZX/6WZexJv3fqfMwHk?=
 =?us-ascii?Q?kf0TQh20AWQZrPhO4vokG9EmgI1VvqVfKcsgm2rkYoMP6eFcGOiaWFDeWGUc?=
 =?us-ascii?Q?kLWciT/QyApXym4sNay2p+qwBB7JtxzHwH+NmTF3cD8gNt0/TUhIhynw8x12?=
 =?us-ascii?Q?OVZUJKL6aiDxSgFr7azjJvhyxDi6+8kIzLVH+jURSFNexNaSadzvgMWBPNHc?=
 =?us-ascii?Q?WuRjLxhUFbPEe2wtPbaT13sUMklwcFuZU8+QxFV0y5xw87KwGSQp1mK5nrkW?=
 =?us-ascii?Q?4DSCyBRrkyCg1eixD0ETIQj4ild4XJZtiLyRe1aUukIvr8QcITLJlCyt1I1k?=
 =?us-ascii?Q?7sXxdC5Eew8GYtxGFSQuYbTOwyO7lWSav4FzlJvuouR1eG5Bira64FwDP4Zb?=
 =?us-ascii?Q?2r+RmJLMzhJvTMSTBcazYxoorlMNjG+dQ9daLMBihl8+pmoiWwk7YxC0UXiy?=
 =?us-ascii?Q?SAtAOHthUfbPlJ4cdYLuAEk+CLcmjrHtkLXH5GKImr+WFpf3L/9UkuFfiOHJ?=
 =?us-ascii?Q?IZNkKRp5YsvcWqF+W6rdw13nvUh+S6/kyF38NCEdzsVaoLMH8CDlVxSZspzO?=
 =?us-ascii?Q?iw5npCwLjigWmSLX8bGNXci2IMqdpAqXHmL/OLKJGs//YIrc1I6JZMZ7Ju2j?=
 =?us-ascii?Q?mYtwiyyIGkxM+YnZ6KJPA+OFEj7sOQrb+jhHoTkkKsoiJCNZUDvxH3qxfQMm?=
 =?us-ascii?Q?OZ6dy4ISUhkD4OthsM5A0WV7Wxz4487zhxKv/Q6QiIcbx4VWO3moGicq6pee?=
 =?us-ascii?Q?m6I/rpQF0jXDFeYbwVQoLOmA1bqvRHQwnA0N6k0oc82eT3d2Mes2wfUP/eJI?=
 =?us-ascii?Q?wIfN3p5yzV1xPnZczwsy8KiSRWbZl21QHvn85SvJdzgLH4XJFhmKHDvg6g3z?=
 =?us-ascii?Q?D9VA9UG5vRMt/t0GmMa4i03/yt1pQcZkc0h9BKWXN0ekhIlwl9zQ6FKAY1Rb?=
 =?us-ascii?Q?V7jA3y1WZY9Z0lcrFh1lM3wsPG8/3MvKExtA2jBj+tYVOh5Twp1XtkHfSiRE?=
 =?us-ascii?Q?B8lyyKfzNZh4+kG+/VxhicpIJTMeyUklj62RNk4UP54DHAShR4KYHdgESpOa?=
 =?us-ascii?Q?dnRcXhevod5XhGyZ9U3lSNQH9h86oAAo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aZGAgDGqpxlRWcrERj1WxNTpKR3CoTBVRa+4sNu+e5VxrnTi3stLUTUIRyr/?=
 =?us-ascii?Q?QKJ6MyD9SDi9IvRYEyBCYHXtFjnRV0AyQQHO6lo42OHGAk826rD/5LYkJt5Q?=
 =?us-ascii?Q?fMfAfoAkEsOTChs8FTZFpVgq9hL1hmF99MKNi6o8jEsJqyjrkqSD9T5jIVcy?=
 =?us-ascii?Q?gtDLfW1rAejpwaNLyu8eVcBuMyypmH+Xdacsi5cR3K/oGcnY8qXpeAnqBrNE?=
 =?us-ascii?Q?qdBsGT6A0lRdFVJuTUnyZTdeTTidwvOpCCENLm6R7VtYADwI0V7Pty1YEs+5?=
 =?us-ascii?Q?flEAFY8455EIUsjWDWlWijKfmVE345/IJwUpazyxiLiMv7MyaahMeodMj8rh?=
 =?us-ascii?Q?y7TKSxHA/TYQHnURMsmEoy28CzCQxbV3VZMQpFa2G5D7kkAroyKKcmyLhsaH?=
 =?us-ascii?Q?pqAv7VxQ3yH+x6AkEU5xfIKDofLFtp1lEAp51cxNAUgn/490bYOW83ZVvjco?=
 =?us-ascii?Q?PpFOE66VNjQuEcBdhS0Bnm8KBOysMl9mbKpc7+2vIpN0949AYPfoYZvgV0Sh?=
 =?us-ascii?Q?bPQK7oAHU8/yrlPBaLoGBUC4p7YqUGHoJdrmfNvtpBR5qi47DJO1DXuazDaZ?=
 =?us-ascii?Q?rGwhsJoE6WGNr6dVp/WZu76tEhO+k5+ix+sf0WwLc7/FrpVy2l0z2OaLOB5J?=
 =?us-ascii?Q?vaz+E6tMLn4lTK3sOZfqBja9nhFHfDnHj+wxt5Q1RgsVI7o66rlIgylUUqBt?=
 =?us-ascii?Q?//FIwbAnfWhvAP9pP7fijgp9l0ltnfIXnM9agx3hkTxS2P3EdFgMTJKns4le?=
 =?us-ascii?Q?GGp1x89F7iBYK4zhTVOGvK+5tnSAFiLMSfEIruqCP8mErXMXhdYRj3jjT7uk?=
 =?us-ascii?Q?5PJtNIh6PBJzzXAY7gXaEKg96SIQQtoj6U3a9nNpOAAaaJzaWwG2SgTBz/3D?=
 =?us-ascii?Q?l+TFTNdXfXFvwMmYSHK9JZUVeGpHoKX+TP0250M8IaBbQiO5OpYKFk0woZJO?=
 =?us-ascii?Q?faHJktP6jmujB/9009wyk/agerJ1uenF2mBI84ApPcg77EfSk+zNDsvelt6l?=
 =?us-ascii?Q?0n74BzcmoEXh8T6Z+Ry5haRKKse+MfXg4SZQP/WuE6xo+lVYve/gztn+nZXP?=
 =?us-ascii?Q?cCudUM/Ih5GobWa8H1Fz6QjNzRWqHDqrwVn8Le6DMdAW9VLNCCCc4W82BhJn?=
 =?us-ascii?Q?KUYUJTLgcAZo7yzdq4uEii4wNXfFgatE5uOdHLWKAIOStnRMszWZSr6Hxbt9?=
 =?us-ascii?Q?awmkP7NLTlo8yG7+eVgM03j9cOpIEsXD5z+EWJjYMu0wSxf80xNGgT1fShBa?=
 =?us-ascii?Q?Xx0xebzHyKT0dlfEpu4nIZtDJjG/AN2oSVHbLJfTQvc3BtqD9PxxOmWedjs6?=
 =?us-ascii?Q?BlugRMGi+Ad0DTxU1UzyjmuskpPvXBKd6pBzOaBhC/KF+YdYTFPgZVZzZ+VV?=
 =?us-ascii?Q?TbugBobP7DRHTESKHeYyAi7ptgszm6IS4/2rlB0o1mGZk54sfT9Qp5J0003t?=
 =?us-ascii?Q?tr1OGI/T4gwrH3b0E0qumh9FA23Y6n5jD7a3EcZ3UoeEGfd6lt4RxSH4NY/I?=
 =?us-ascii?Q?/d6YyxzKmUZN/JZdvwWGuF8+Gq5eX9wmmy9ga53AHKe7Bn1Dy41ACpvZ2vcW?=
 =?us-ascii?Q?3EF3NcFEHlmyxwMRIAU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa7986-fe95-4a9f-d7e9-08dd3670c1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 21:00:07.2723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWnqetoxs/Cg5ge+twvnWk0sVOC7hyfHLF7TMXj6PzuOy9icMsAeQAQdw/Ock3Cm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: Thursday, January 16, 2025 3:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: Block per-queue reset when halt_if_hws_hang=
=3D1
>
> The purpose of halt_if_hws_hang is to preserve GPU state for driver
> debugging when queue preemption fails. Issuing per-queue reset may
> kill wavefronts which caused the preemption failure.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Jonathan Kim <Jonathan.Kim@amd.com>

Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f157494bfdb1..195085079eb2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2327,9 +2327,9 @@ static int unmap_queues_cpsch(struct
> device_queue_manager *dqm,
>        */
>       mqd_mgr =3D dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>       if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm-
> >packet_mgr.priv_queue->queue->mqd)) {
> +             while (halt_if_hws_hang)
> +                     schedule();
>               if (reset_queues_on_hws_hang(dqm)) {
> -                     while (halt_if_hws_hang)
> -                             schedule();
>                       dqm->is_hws_hang =3D true;
>                       kfd_hws_hang(dqm);
>                       retval =3D -ETIME;
> --
> 2.34.1

