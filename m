Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D66C02182
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2025 15:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D13A10E84D;
	Thu, 23 Jan 2025 15:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZ/YoAvp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248D10E84D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2025 15:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAp3/IZYob27DjGjarLki21D/zev3f9MasH6GX2xERO6WTfqicQ7QL/OQUj2cbIKDReMS+h269leCryVVEsPMOzGGg/fqTe38+iBMuFN+eebFgvxvMniRZWpi9rgEDfr5ka2NSjK7Zuk9DSreFrJHqjEGOLrTGRcw7dzjxTwgGQx5w97cPXmW5sjTh/FHUZJ56/y3oixOU23c1Boekup6T6zaPmrcyn3wkPAY3uTSkpsLS8VWfdQCOaV5gRtttauQITgwc7NRST98AeKd1MlzZmneu7/KtoZHHDe6hqDjW6AsOWcCe/PN3IQpWtZymi7KuD4Woc7O4Rf+h+FVbh0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIsrl2CAPqf/CtosryO4JTYvmvU49I7bqXiTUS1u0IY=;
 b=u0Cmp9MZ0WSJTyBWyg7BuVA31eHynVRdHQmC6v6S5RnAn36NMRjx6HzCQMdMx8SrVpvCDyx7Zq3B94QSjTZhGDR5lmRSYMXRh6669cKUFJIFHlNHqpIusc5o571dw9A7XTif151lP5xxODXBspNmO6bNT6OjTKdSXhH13ZnnFGcVGtsMkznCKKrvDbVTiImtt63+SVnwlxAYEz9y2m98RLIPtIL5qQW+dPNbKe/wqtSP5HbSXA1n6Ouroo0Pn3jJfHp+XaK2q89RCHayoIsqkrGwzqKsyDczID96XkIrc9Zn7vsqXtMaH0++mxNvH4/J3+nQNNdsThCppNrK8fi7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIsrl2CAPqf/CtosryO4JTYvmvU49I7bqXiTUS1u0IY=;
 b=wZ/YoAvp2rxDCtHHrLVMNS/xP6QCr1UaZsFj27IawHl2tf7pyxQp3qU9KWraW+OulbJqD1zGkaIS3aBZtxDtiA76Kim+UWghmUwtlczc8+xB3qq5fR50NaBB0KoTmJpGtitev6GWC//pBV+F3EXJKlE7+wFMMjgl/hS1daAtLyc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:22:30 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:22:30 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: only flush the validate MES contex
Thread-Topic: [PATCH] drm/amdkfd: only flush the validate MES contex
Thread-Index: AQHbbK+wNAF3Ku2geUeLYrZjn5u7FrMkegVg
Date: Thu, 23 Jan 2025 15:22:30 +0000
Message-ID: <CY8PR12MB743595D4CDB9D1F3634455E085E02@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250122092559.3317767-1-Prike.Liang@amd.com>
In-Reply-To: <20250122092559.3317767-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a73a489b-d0a5-4a11-bd3d-cda76c888c8d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-23T15:16:01Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SA1PR12MB9470:EE_
x-ms-office365-filtering-correlation-id: 5fd37ceb-3d15-4beb-e487-08dd3bc1c0ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GryEqkaZXasF8Y+3Z36AYIHf3NyBNsuezDGRIH6nvYpB+aedS+Ejw/X6eZfX?=
 =?us-ascii?Q?dbnJ+3qtaeKZdSaJ/VkkfY+NIcfMpKOKQEps0KQqjVKTRHCIwx1pZnF4J+/o?=
 =?us-ascii?Q?t48qxaulaEwksUy6K/7xTSKtrd4/3Vu2ApQrZ8YPVqJUfhH3Fm9RWF7Xgslv?=
 =?us-ascii?Q?+ayfBNV3fepsTz1tHYekAp+laRD2xqnm8hWrdTDaVsZDYLvq9Vlo4FqeNh/k?=
 =?us-ascii?Q?OJ7kAN+cXgzsq2ExzOThQW+kBWigh6311r9zSs1waXOnZ9sig1lrCckbmR7T?=
 =?us-ascii?Q?QhVKOWXLsNmEyFUaClvFH+i8r0xVU8S9JmyzVikMgxCLLYI9DD8seKfTGbzv?=
 =?us-ascii?Q?nCcIHxdbFDJi+hu7bKOwRuXiB03w0NzavQMzHj/uQazRPB1x16hnbO8sdmhV?=
 =?us-ascii?Q?L1I/JkzOQHnmtXfYmloMTyDgdiXwTIQDn6NCojPTrAD1Tcm/6fMsn4GsBAog?=
 =?us-ascii?Q?2Zo0eSm7AbbxiKPD4Eoz0n0wfWK2xHIFh3y4b0fsxOC/Z0W4sCFpdn9JPteQ?=
 =?us-ascii?Q?tvtDpqSnMSRe9ksHULv4Q5JojG8d+Dz6B7Sxv2eDgpcQS9QRyPLaX0bU0p+/?=
 =?us-ascii?Q?GmvEagmRqiuA6A+q8GB5zzSWo4qhOt+vVoVJu48Wjqs7Ex9uVQUPKS4uUYxe?=
 =?us-ascii?Q?+QJQd1Mw9IcDUKxZ4gQBoHD5gZVqaiBm6++1Uwa7iuWsP3uuto4hcNYS8A08?=
 =?us-ascii?Q?tTTY4zbGIlVJ2DTGO9zhNOkqiCIadzs+DWFsAcsLaJ5cFYJDd60E8MFp+Ak1?=
 =?us-ascii?Q?Jheup4+45CgiGgOYt1TTo7yv8cnhDTGxHJdYOu9cHdPboPIqT6S0oVbjtt4o?=
 =?us-ascii?Q?xUbNfQp+Pl0lXIhiGyW2c5yTjfbFhbbj35MyaJhlEAiHJW/XvORcyjPNrjB9?=
 =?us-ascii?Q?/p0kCr9abVzusLGqTcUUKQwoXN+tKNgz8ztbQqIkzdnFN2WGDD+KUz+LhRbV?=
 =?us-ascii?Q?3+kje4T4yJ5BiBbweGDoyYsw5LmBJlSVp5Hk1cpjZhPYVKXTE1PFwMbsKRTU?=
 =?us-ascii?Q?x2b9Q8KM5Yz7StfM4sUyvXEfo2P76bhJyvtQ6MoJZsATU41EL4w3RM5dsohL?=
 =?us-ascii?Q?44ztTRkxJa9J8ZO99Omjgq/vPP9vmzjJA35JqCkhlKhZJ6PLszbbOg33Xtij?=
 =?us-ascii?Q?V/KyUcJHiV5WurafoG27MscrUi/gt9u33pYYeHdcNyIAS07PC0UNnGYDvIZD?=
 =?us-ascii?Q?3OI42zqt1FFZeO6xn4HGXlCP1Y/KOKJzSm2Y4v9An2EjJnBkfaiC1whRXdlm?=
 =?us-ascii?Q?cSJ2jjWbE0m9bu00vs8ITQ1lYmHunFp+Dcf9oret7ZHNI6WuzuIE47o1Y0BV?=
 =?us-ascii?Q?3hlAaoLY9eyqU7oloD1KwhVCm6cJ20C+D4+DrjhTZcNEypD4LRG6ifKhYmvI?=
 =?us-ascii?Q?u4hmXNTU7qm0HpwsDm4l/FIv0i0P0Az18C3VbUEb0LsOzEblDu3qgOYOqVov?=
 =?us-ascii?Q?sWD69GKNK2QEtwpPB4GO7kccPaRsINdr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eRsXdUUAd8DJpMv2ZhyJlTxa3o84Xaol+fTxs5LdNa7S72/lyG7l+QXG/Faq?=
 =?us-ascii?Q?lhQ4KcgcaLpo5U6e0ihHCN5ZhGOsINA9M7jGSWzu125/07VV0z0i7HhEvaua?=
 =?us-ascii?Q?yFtSfFlfPmOSFLkS1CX/312ipz8GJmZ2POk+KkelrJO0QViSRvVfUpiyKelM?=
 =?us-ascii?Q?LYtmSYRTwq0LwCc+Be7bgdWnY0WQ2H/uR28a0W4zcITO1E3UGNWMEajo9n/P?=
 =?us-ascii?Q?cb7uIg8OzSCjautdvb4+0hPJA/0n5CcBslJVIyyjx6ZWrBfOPKJS5vNGwe56?=
 =?us-ascii?Q?PMxoqjZm+0htx/UareIbkMwM+NtcF5gsQ8jw5LiDH7rMZMTpCbv6FP1X4Brb?=
 =?us-ascii?Q?b0t12ium4dfXFojjLsZ1mVeAYp7K1l2WMTShfeuaGaaauDM/7JsiZbRMIcx2?=
 =?us-ascii?Q?XraABcpUfgeZ+dzXeJDx5W5yf6h4XxjllaZ4UrpFUDC0nmd32JynnGGFGU2P?=
 =?us-ascii?Q?a+/uD+Kh7z15WS3+5wSaF3LmHXlzL9W5CvkxJ6UjU4guKhiU5WBWvjs+nMpd?=
 =?us-ascii?Q?l2VcsLgosQ7k1xkmVCW86C1L2B8MgvYrFWIh0O5ut72mi0UjEwVk6I6SKCFu?=
 =?us-ascii?Q?eY4e7EUm0h0YCdZ+YlC18YZsK1vIFzAZ/EReqBbzPVvGv8GsTL/nyhVsX/hh?=
 =?us-ascii?Q?CJPiB9EFghOPE1cBWHcScEtrXx5LLKaHlenPayxWKHpanJsSEdp5/ZiwDTMe?=
 =?us-ascii?Q?P45j38VDAuc32BV3K/I+ibVnzPw6ua0IUhQrosCb2qI53E90I91uYIveeD1i?=
 =?us-ascii?Q?+XeQy2OBnc77VabtowAa+HVeHbLxEY5Wh/mDwPca0DSldXuo0ZuFcOFfjnwY?=
 =?us-ascii?Q?yOL0/v1Z56pFGcYVrkC6ROl4wuT5Nr5ac/0mFwtD/aVH2CqkbAoTPKE/ALOH?=
 =?us-ascii?Q?BET5ECsmKFJVvYv+xQyPKTAqtawpw2OTdGZowMqHJmCefCFnrBVeM7Rq2YFU?=
 =?us-ascii?Q?ZJWKh6WspXVqau7P2m+SjjD2LvOJnnwsSWy6cETblfmsdhic426darkzj6Sm?=
 =?us-ascii?Q?emRZcbfZqjbAD+iGsj3QJW9GgBKGIfFysI3qHiReMEO7Aok+HOR9v9SfZHj3?=
 =?us-ascii?Q?UuHuNQtvXdSjiwi6LrtkRF7+a3EKLw2JNsSlTE5vSLWjrePDtCXZOEjrSTQt?=
 =?us-ascii?Q?KU4Jveflk0oWwSdl4HqDwj0Yhr9PjMSxjGpoQ6DYnoVsMbh7hBf0gYiqTSsm?=
 =?us-ascii?Q?kjrg8bojZ53Z+VZ/+lObLNgREhAzT8kM6VxxRTtckyY3stJTdye4t7rrNbhn?=
 =?us-ascii?Q?P5lvU193aM7iedJbBV7eO0dxP4Y+gKgouk2drIalksRJKnHXX2B03KO16IB3?=
 =?us-ascii?Q?RK6cviovBwp2DkbFV/y2p5VQH9VB9DijmEFM5/DyKTy1n4YYCZvDlLJjSGKt?=
 =?us-ascii?Q?zMyCeQ7CRWBgEL6T8eEYjNwKRj4aRz5pwBYGhhy9ge4WUgqRoERAPx4xjXp4?=
 =?us-ascii?Q?w8ZqgZHwpnsaYKPdBLYtRLlyu0MfIWbMuKtn1Erucgj0suoh6h7rz0CtcjuW?=
 =?us-ascii?Q?pZ9kVvGRoACEeBg5D/zV2738d5d93w3/j24f2bxOMUJQMcNNaRxfmwMc1oBk?=
 =?us-ascii?Q?ZWfXYBR9zzZ3tIJA7+Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd37ceb-3d15-4beb-e487-08dd3bc1c0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 15:22:30.7912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxQpqAcSE2ZNfmOFe46ihDLru4azMJawx0cuRLAG8TESSh2uUNKE0dVOju8Msorf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470
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
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, January 22, 2025 4:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdkfd: only flush the validate MES contex
>
> The following page fault was observed duringthe KFD process release.
> In this particular error case, the HIP test (./MemcpyPerformance -h)
> does not require the queue. As a result, the process_context_addr was
> not assigned when the KFD process was released, ultimately leading to
> this page fault during the execution of kfd_process_dequeue_from_all_devi=
ces().
>
> [345962.294891] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:=
0
> ring:153 vmid:0 pasid:0)
> [345962.295333] amdgpu 0000:03:00.0: amdgpu:   in page starting at addres=
s
> 0x0000000000000000 from client 10
> [345962.295775] amdgpu 0000:03:00.0: amdgpu:
> GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
> [345962.296097] amdgpu 0000:03:00.0: amdgpu:     Faulty UTCL2 client ID: =
CPC
> (0x5)
> [345962.296394] amdgpu 0000:03:00.0: amdgpu:     MORE_FAULTS: 0x1
> [345962.296633] amdgpu 0000:03:00.0: amdgpu:     WALKER_ERROR: 0x1
> [345962.296876] amdgpu 0000:03:00.0: amdgpu:     PERMISSION_FAULTS: 0x3
> [345962.297135] amdgpu 0000:03:00.0: amdgpu:     MAPPING_ERROR: 0x1
> [345962.297377] amdgpu 0000:03:00.0: amdgpu:     RW: 0x0
> [345962.297682] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:=
0
> ring:169 vmid:0 pasid:0)
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9c2d8393cd4c..c39cdff58418 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -86,9 +86,13 @@ void kfd_process_dequeue_from_device(struct
> kfd_process_device *pdd)
>
>       if (pdd->already_dequeued)
>               return;
> -
> +     /* The MES context flush needs to filter out the case which the
> +      * KFD process is created without setting up the MES context and
> +      * queue for creating a compute queue.
> +      */
>       dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
>       if (dev->kfd->shared_resources.enable_mes &&
> +                     !!pdd->proc_ctx_gpu_addr &&


You can probably combine this check in the line above since doing that woul=
d not exceed the recommended line limit of 100 characters.
Otherwise, align the indentation of the new check under the previous line's=
 check for legibility.

With that fixed:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

>           down_read_trylock(&dev->adev->reset_domain->sem)) {
>               amdgpu_mes_flush_shader_debugger(dev->adev,
>                                                pdd->proc_ctx_gpu_addr);
> --
> 2.34.1

