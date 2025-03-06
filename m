Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C710AC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 07:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7381310E90A;
	Thu,  6 Mar 2025 07:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z8baL+GA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B015410E90A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 07:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NunSlZd+sb0WDCGkXs81ydMu4Aij+Qetwl25xjBr8cBp910QqA/mHP4LdufMrCDPj6K0msDxXSYM38Q9CARZMEK1eh66l2jC9HiAQCZ3y5oHeW5mRWUprYzq3RnLsgIGlmC8Juo6PDrwuO6DZnYFZHD0zon81gIHJzgAw5I8Y8CBNUqVxdgowmY3LDYpWRn/dt1CCQjrXcgxoYhArntXsXTBQvm8ikWd6ixKWM1QsSSFGogW4HCL1YIDc6BA/8xA0eJ4SJJSqMvEqqIkbSOk+CYwauDrLmUN+GtltgAdV+Qq7O/ScPXv9EEznMDQaL0mT882D5HAvYHiJIKQGiKrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBzk39iqqWjRTZjQ86LreclBLm6HwwCP73gWbSwVlzw=;
 b=bREUWwKkhc/PSnGZRsMFYSarN1aD0ji68aHIvyxcHdLRlOgLo9FPqj19t1cpWO+87K8TAKfkSZ01AS3iFJSpG3I9ieNROZPEAOy6PlFcAANbyzywXZJ2qpCFpR0jNCl/G2Awj2oB0LdyKxrjBs75rbG43plbvvnyTE8QiHtt+abJJJsRg7SQjjl6lJg5eLNDe0mO1uXDB/nVcMpJ50qbne/s2NC81thA6QQedhXr/kveyqyy+qCHAdRnkhMZNA6eJaKQXJCanl+841GMGAy5EDt/EJ1sSRchc2DeIMseD38oYrDDBHeTEqpFPbjh4BaD3R9jabBfahh1o4b4ZTMLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBzk39iqqWjRTZjQ86LreclBLm6HwwCP73gWbSwVlzw=;
 b=z8baL+GAZLU6tkgDXrqKnTv3yUlGoF0h3eVVH0+jI5i8Bo2pKaXrVLDdN1201qM+x5aIEdgo2KEObc76LKmJM2Gh/XU2Ds0cety7CqrLV6mVCv5JyUMxbKMjhkBriMwzSECiKM8RTdm6xztXLqNpePEjU//HfD+q3WfHOf+Zp9Y=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 07:37:22 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 07:37:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use unique CPER record id across devices
Thread-Topic: [PATCH] drm/amdgpu: Use unique CPER record id across devices
Thread-Index: AQHbjmjnPNvHrNbttEClR06m1gVaZ7Nlt9XA
Date: Thu, 6 Mar 2025 07:37:21 +0000
Message-ID: <PH7PR12MB8796DE02C5BF29E30B7732E1B0CA2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250306072456.300967-1-xiang.liu@amd.com>
In-Reply-To: <20250306072456.300967-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1479757f-cc31-43b5-838a-09e8af642ab6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-06T07:35:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6780:EE_
x-ms-office365-filtering-correlation-id: 8c8f7f9a-be6a-41fa-a009-08dd5c81bacd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?E7/Nyyq3+S8rlzidy/JaBC9Jki8WkQHEIdFaVTPQlBfWqFiHpDw0shCNft5A?=
 =?us-ascii?Q?HEDG19+ntou/SDc1AI5odY3V5pgogty0I4d8yaB3N1L4tdNCx2phEFeIyqrf?=
 =?us-ascii?Q?wobO076VdXvRUj1XQyvMY38CyEanwm/jzYvxbscYPdb68uJSPSuik0oBy2pZ?=
 =?us-ascii?Q?i/Dpxc/K9EQnaf8os+9z0I9TdvqD6GtOf66IQnhm4N+0X4b1Wc1VRxFKPWZD?=
 =?us-ascii?Q?rMcd9V0uOGhBvbihYkd+5D3X020yxERU/JjIAYTyMO4gsUG4isA7kYyDSACo?=
 =?us-ascii?Q?RNvBoFIn4FfC2TezQGyno0+52owff/5S4jR7ipi5+j9w4/SgLe3uUdVaO2yf?=
 =?us-ascii?Q?uvZDal1fnNMPDrJjuw47bltFUkcCFJxqYNz2N9N0vg6NePOwfXI2af3vinJ3?=
 =?us-ascii?Q?8gofp4Yo3yqrshuZnN7utCcC1nRIqyuuuWBf7aX27Z0l1o9Av5iK/yTlfYbV?=
 =?us-ascii?Q?zg2S78nb/ibZtBInLBOR0Q8n5XOFyGytHjnxDOGFhzHbE51epjZheNfJq6M8?=
 =?us-ascii?Q?8WOxZEeNdfxx3TCwhokEl3wLmiTXuXSKbTuq2pndkkGpx7k0rEJ7co8RB8gC?=
 =?us-ascii?Q?pqkDdWg9pt4mRkL4j78Ulsz9uNzlovgmPu9bWjc7hnmS4H6nz/m3Nz6GU+WB?=
 =?us-ascii?Q?NRbAU+pvLxuCBp5IYXVJlpvNhuMUV1gxqNDyoIOHlpjQEwS8/cZmzJpaMKu9?=
 =?us-ascii?Q?579JKz2KytR2T9DnQ6Xfx6GL22td6fMtTAkypboF3exF9295VgTp6qpaae2f?=
 =?us-ascii?Q?FwACOqy1/sB1ZIytVYbuJ9GTNSr9roq0V2HzKWbxQumvYJM+waYJ+Fk3+koF?=
 =?us-ascii?Q?xB7MR/fqwd5Yp1M0EP6kgmRQ5qUbE3AaVdWAp5mbbWIy8DsrwuT3a6MCsQNo?=
 =?us-ascii?Q?TUuYaBvDCY+L80MRUrv+UXmqz0UGiJPoOqUdGcikbNCt5FxRHN0ndttEktcS?=
 =?us-ascii?Q?kwsdZgRRUVYgltKwyjUWgdShVem/rroG59Jl2iKAFDRPBT3ifgIVPHPWv1GS?=
 =?us-ascii?Q?OgA7Ri8QNzN4QuCA00sO0dpcdK1OXLAi5Fp4k0ZPmeyJmdm6UZ+WA98MdTMv?=
 =?us-ascii?Q?r+zg6Q5F3sxe6qOkHLquyhdvXD2XGxO4gzkQL/Ldul6cCZSojdObw1Qc/ZsP?=
 =?us-ascii?Q?6dUid61YCl7AcORRN8haC6UuJTNfxVWl5jDE+xbuOxzuMhNk/oCImvAZopwa?=
 =?us-ascii?Q?/hOAgv91JEZJfmHlOq4oJcSsJr1Qdlh5QtAGXixtmEjSR1sCCdAqF5Uty5ki?=
 =?us-ascii?Q?pGKZXG2BTpSr/HnCwk3gkN+9ZUCT68Tzmrj1ZYC9Up3LO6HQs0rI4CcGJ3Ng?=
 =?us-ascii?Q?cWlM6j821bukf6pRGbHbUYRPKxDW5KPb8a59f0Wwxkgqsfo8yMs//8dSix4u?=
 =?us-ascii?Q?KevOQ/Hg8sXfTfM8WBgmmHkMeMkOPxD6rJCMIeJsQ6AJqH8UMIHNdsLqTZHb?=
 =?us-ascii?Q?H/oVjebCwY1/OIpJKCKom53Sgr+GIhij?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VVFmmpRsD1N7VzpMtS0ymj2SNZcUHA3pGTqkdDHWtlpCWyrtnNgLVZuHClLM?=
 =?us-ascii?Q?08KiNawOGFak8rFp3vw2w6PrIYGILr12yuPOLHsZDnSGMlF98BiJwJL68k9v?=
 =?us-ascii?Q?wdzpSeZmByAsPuD2TMe3CBBAbs4UIeMeYUWNbUINDltuC9UAGJyAMECNSYIO?=
 =?us-ascii?Q?+PmmI+KDm9eb5EWT6HAsN330mkl5RNo5A0kaxXyN+/pg1wV6yO5xwW6KPaHx?=
 =?us-ascii?Q?toBsfbaWoM7cnvioGiOTGoeUuz91Iwf3o0k+UHtVeMkIe2ND7CREmWKydHJl?=
 =?us-ascii?Q?havCKE3AhrisvovexJM/2dOfDnDKue49j+UaIJDysr8DsVT+4p2Dp7D3ZfSi?=
 =?us-ascii?Q?sIdIa87CYahnxhWsqItUBNrZvTHLE9w5ju7wuCr5CdC2NUrJTnSycBXYeD9e?=
 =?us-ascii?Q?VvEwr/o+jTEEmYgCFXm/CFNwelPpRurucJWSsNGNoHTIdVn34AhtcLtHo2kS?=
 =?us-ascii?Q?7tZ27ETe5wN/FgG9hOVBVq+Ocl1TTOrrmas6WEyh2JQXNVvKKWW7MktwhMv3?=
 =?us-ascii?Q?9sV95bqS/3QBpV+g13pLcelf0i49Xa3W0Iv7QH4SNII4cyGFrRcX7DnCtG6x?=
 =?us-ascii?Q?Mu5hrzKO84l06WZJ9OG3TyB1pdWsqtVr2I3kDRS8ntphfP7i0sRWGNyUjxYl?=
 =?us-ascii?Q?2FBLqNK6yqjr4UQnziAg4gb0vORQlJkbJ++rJEogMGBQiUQA/B0aH4tIZT+b?=
 =?us-ascii?Q?gN0m7WF/0niyVLGuiQ0hcdz5N1HN1NDmQwuXcoSRCWFyYEjD/E1BVA0bZNm3?=
 =?us-ascii?Q?VMf9F8wLHD4AHTkzORWwnXqUhRvf5DzOvpF50KqBcXYUa5E8QDFJ+0akRpEf?=
 =?us-ascii?Q?43FVXBAEc+PY937wdsR+K1d05tqC2ZBcsJ4iKQfaXULp3MFtWdBskIezoOJU?=
 =?us-ascii?Q?aaZNMCJFM1bHKbAegxw5py+nNQheApUFmo7opJc9kN97bxgM1X6yw8mmeCzD?=
 =?us-ascii?Q?lQeBsBzlrG2JAWcAIWuAnOPLezFvFU+Pup6WhgOe6UE9SQX6xvh8/t6q/96a?=
 =?us-ascii?Q?QODs13tHRy0WMQHzy3qr0DO+3sapfPqVKSzcgpXTFd28dr8fzsbtw4pQuzNf?=
 =?us-ascii?Q?NBneTgEwW7CLP309ljrUq7Vweey1X8hS1f2QOK77jJHQuSsrxewMUVBu7efY?=
 =?us-ascii?Q?i+d7KVqhLfTajzb8i5jaZbPuFJI0uajzIumKMRhTUMK4jxdd8OzaLX7kzlAZ?=
 =?us-ascii?Q?OW7IDvlM3xfMT7DT1k4ATEJaLcO9IS9uiC5hXYsubGfRacQDCYSGmQmzdBxB?=
 =?us-ascii?Q?4LJ3nBRT93gbXM1dvVfeEa2GWDxxFUhd+Rv5gp0RX1jR8cMPIRMqVxqVlU2o?=
 =?us-ascii?Q?gJ9IoArmvYAKbxyiPyesOtrwOFX0iRzGkPkThaq5EVFF582/may0G1ZPGmip?=
 =?us-ascii?Q?E/sfTnZb1iAmgAb+ptj+jzTwbwECaas4pqYtdUp88hVCvtkI15Fg7hrmE7gi?=
 =?us-ascii?Q?10pMPCdG2tEeBtCDZcxIhVlb0cZ19ybLAEy6q6B9nl6IMJ60fpJijc+jKXmK?=
 =?us-ascii?Q?J6q6znvuT9KOXQX1/V+ye5D8CxGQs3d0ZKDG9wGXD9OF24Tv8e4QJrW/Sv+j?=
 =?us-ascii?Q?/9SBC1yatwKtS7Y5BLg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8f7f9a-be6a-41fa-a009-08dd5c81bacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 07:37:21.0684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2CmZQKIKvncx03C8dwD3S2uU4VbYxSEPQxiaipEmdkN6pcD23tNCXse1D8nsVue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Thursday, March 6, 2025 3:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Use unique CPER record id across devices
>
> Encode socket id to CPER record id to be unique across devices.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index d77da7ca9a87..6970a489d7c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -57,6 +57,8 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *a=
dev,
>                               enum amdgpu_cper_type type,
>                               enum cper_error_severity sev)
>  {
> +     char record_id[16];
> +
>       hdr->signature[0]               =3D 'C';
>       hdr->signature[1]               =3D 'P';
>       hdr->signature[2]               =3D 'E';
> @@ -71,7 +73,9 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *a=
dev,
>
>       amdgpu_cper_get_timestamp(&hdr->timestamp);
>
> -     snprintf(hdr->record_id, 8, "%d", atomic_inc_return(&adev->cper.uni=
que_id));
> +     snprintf(record_id, 9, "%d:%X", adev->smuio.funcs->get_socket_id(ad=
ev),
> +              atomic_inc_return(&adev->cper.unique_id));

[Tao] please add pointer check for adev->smuio.funcs->get_socket_id before =
use it, and we set the id to 0 if adev->smuio.funcs->get_socket_id is NULL.

> +     memcpy(hdr->record_id, record_id, 8);
>       snprintf(hdr->platform_id, 16, "0x%04X:0x%04X",
>                adev->pdev->vendor, adev->pdev->device);
>       /* pmfw version should be part of creator_id according to CPER spec=
 */
> --
> 2.34.1

