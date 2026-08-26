Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B1C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 18:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3525D10E9B0;
	Wed, 26 Aug 2026 18:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n2b0yhn5";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFAF10E9B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFUeBQ9qDdyIMbLVBTOptP+/SH2M23Wo9eeGKYHWJTxDCQJwM1vHLHtXFIPekRMGhmDezUJMeJkcqxzs7TIzo0Z/GqG2Ldq/UIQqLxnCrIJnhi34eHc45UWU6sGluhTjXhVnJr4DROI5LlsFKaEfRjCFA59M4f9PL8OAz2yWrTQgiJD2DZNfJvTqTvGK9byrDhc4BF1GTt4x8B3ooYw2k9E7BLNLH5y36ZETakT4OFUu6P/SYjTDsGH7JdoByVAnQ+CXsgMsKYppEdawhLnLAosIYpIL+Pc8ApkS59IojmYNGpFhbZbEZCuS4DCDYMuTM20OO9vaNlTBxPrkiOMCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F08N+/h5YdHkrT3uNxJhsKvFxzhe5Pq61vZ0yzQ41aU=;
 b=cS+HsrVLTrRKgfQUkzfDXSiisfJBaHmglEnqrT8qs4vaUzxJo1e+m53kuoJTL/kuztm/c1UJaxVEZYca6jWfAhEwWrn4Llptdn63/6SajAvWrvH+kZIOCWM8BkIyWliAn/Ynedg6HbXoEs5zrYYTGIN+WaqWW3pDtUABodBNMlmVI1O1bLMT7DE9yE86bNLn8zKNe7lyDLZlqF0f7p1kf9EWv7L75jgReQBJJIW47YfItPhqEs7RnU661eqSgVmaz8JDnZd+SfJqAPfdkRZzo6T+Q6AM7Qy2yFMlOSbNqz7fS+3T/2WRYP5/0T+0wiDENpG9Gs6RJJi1bwy/JVQ9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F08N+/h5YdHkrT3uNxJhsKvFxzhe5Pq61vZ0yzQ41aU=;
 b=n2b0yhn51dsTHLgQbzL4JGseC/Q9N/i1ND6y2KJi1oF+mgU1ML+M0bB8OJTg7go59hMig9W9Ap3tM28eHmUyveZqVNjAWS+U1WMB+6O7y81OhqtmG63Q1bjvHNLnriUI0RvziRjurYNSZkYUNRN3DEKVBKLW5SHgPTHgFOaORzI=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 18:04:14 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:04:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
Thread-Topic: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
Thread-Index: AQHdNYSQlgOwOE9SWEyXBnkKV5T1L7awno7Q
Date: Wed, 26 Aug 2026 18:04:14 +0000
Message-ID: <BN9PR12MB5146CB372B4E0F11B496BCCCF7AE2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260826175841.559992-1-sunil.khatri@amd.com>
In-Reply-To: <20260826175841.559992-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-26T18:00:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS2PR12MB9640:EE_
x-ms-office365-filtering-correlation-id: a5794155-1a67-4471-d5e3-08df039c7060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: cALul4OKB5GbCLuRA7ww3nqHnq2m9coEotg0ZDC/soaXssizp4WKuJ39uexWWzFM7su677o8/+pQgIPfi+pEO816285lqTgi9hE/19zOAo1RtN57LT6Z5RAnDkf8CKOl5qROwq6mAsUl1XV6ykyhmkcFxkbEEMYGcj3PxqhNc0vqOBa8uJqxiqCnpJdm+P+KP9Np8rEDEXjUHsv3KAkyNM/qq1xa5keLsqZlnrJwyEPmBi4JeUDwmdoKURRckYbvGMQTTqOm4Fyrtz4yFSz7JzVgDbev79jmqtUQgsL1Ur9gDWo99kwEUNKSUjyCgvCr4pyukaGJ1Hxr570r2SBr/qQvaMO3eHj+OHR66pp5sr5NXEjLk8kJxDPHrgcQVHqXj+Z3Sbc6XfwYYEd0awQHrbUElooY5bwbVp/cFxK7nW135IPQGIf65/B0ZKnHnKdmqXi2SIVanioUJvFc+iEH0Z3xBH/GaEY4So4Cgh7jZZVwlgpxgtxl3I9CMagUXsqHmrMc8ywwP6jRL4Ld9GvRPn4D5d19294u+5ntM0KL6Tx5jshNnn0Q0rXl+mODAGnoz60qQsYkMRbyCVOob3pKfTO8ECEW0CXm5pJoM+lcsqwlcpCvn+2sNbQOOlMT0RW9jXUYstcfYAwak+2vM80IDShqq8w8U1xLUQ3OUGI4RSrY6bFodsBuYfv14+MBsTH5HpE6/y2CEDx29uBJuxWbWiElvkuOyMe2u9KGC/E3994=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yBud11v3NuHWDRj4jda+PQg2ujC4x8MDCdTt43F7cLr/olyJEnv3w0diYNlt?=
 =?us-ascii?Q?AQ35k9o4B4bl8t9YwWPFJB3mnVtWEbifZsG4zShldogqedRY8j9PbU3kWhHa?=
 =?us-ascii?Q?OIhHAVnagcQfSkiMTkhRM3DTHjnxDWYJp87X6x3Qie4gOiAQJoQXtFoKpUmm?=
 =?us-ascii?Q?5Ye8KiWK+Oz4rGGpJ1FVGIA3Sn6FHqVoMyObj0b+PYkxoi4Cd0CzE9Le+Arc?=
 =?us-ascii?Q?lN0dWUPOFGtz35Dd4vcvg+XQQxvVAgQaecS4HT8cx/BBgxCkx2Gqq/F1DPTo?=
 =?us-ascii?Q?wtuyXuGThVrUV6CfrG0SBnMFk7tLCvUXhVQM1HU3yXpyEimxN5a+Z72jKGVZ?=
 =?us-ascii?Q?j8ZmQNlaXGycx6FlkRxKyMVR5adOhp6f9gvGVgb3y+YBes88ZidAX3jq2BV+?=
 =?us-ascii?Q?dliS7Fs6PVIfdsRYQRiAl6UqJpIjoQPez9OoV5clxPQOegxTFtGclfJPnbou?=
 =?us-ascii?Q?ra2W9/9LN/j22p9diRKcXXfGaTJjOKzfitaoEY1Xb4NjZ61a7Z66InkRXOf5?=
 =?us-ascii?Q?+bg7VdsG58LTZ1OT1+r/pWkmUK2wHs/rJURZkpjxq0OgTE5OmbGKVtZTO/0v?=
 =?us-ascii?Q?shttfuKCfxjdUcrjRq0fzjTms7m6btFs2JtzYjRzJMZewdeILuI51cKDo5wX?=
 =?us-ascii?Q?qqzeMSuHFVwzoCc6ho1uddYGA+OFawc8HLs8TGHY1bK1+zI5wPJPneS36VnC?=
 =?us-ascii?Q?lqAca9fnuQD+KtcA+GHc/mebTEKw3RPLhlVVg4RQzsPWzHqYbiiniThHYQ33?=
 =?us-ascii?Q?MZqfGnkfN5UTDC8oAsnX4wup1JOLSRBk/xPJCbKU+LP0uzwaDxMTn6iI0j4G?=
 =?us-ascii?Q?q13dbnN0bcL1OJeRjWONxgBrFMJD6Pwq9xsulWE5EPK7r9vaTdGRki7LDbl/?=
 =?us-ascii?Q?lQun9Ttg0vTX8KYqxWI/QzfxLYKXmDGSkrImbg2A8BnFnmiyryu3TrzhdiQq?=
 =?us-ascii?Q?JeHK0b1zZkkqeAFza4iVF8R31M6yW535y9eA2ScdetKdBEuDJNmaycVJttFn?=
 =?us-ascii?Q?+PtbPCJ1juSt7Z0GsUPGd63WZFS6OXl67J7Wr6iSPqc9FJFOBWwqIEclrSRD?=
 =?us-ascii?Q?719CR1xNGMEMMTQg3AEed4O0D+nwtc3HxfymsjX537Z5fOa0t9vsJYS2DcW4?=
 =?us-ascii?Q?/lfsGGkkgz8P3361A6jNIQE2f94IjnsgIQNxwt8dKBwd7jKBA56a94i+NJSr?=
 =?us-ascii?Q?PLBc8KjkwJsU3S8SnGBV0SSDlyuPMFoQ6+AzneCCgWvUmQPC/8ZSafEEe+5S?=
 =?us-ascii?Q?waJBE6/VoxrtMvLM9CjkR7gWalXUgOW0YiKOoMUMXkTbxS4B8M0sRDlkpr0G?=
 =?us-ascii?Q?MtMrRhS5iqOf4O3ct7DMf/ArVtxzL/tU7cYD9G79NWltLDA1X3AjZScTmk7Y?=
 =?us-ascii?Q?/bVN6l2jqvNyVStyu0hbQtq9tL1/cjrS6z9l9oJvkA/4f6EbN9ndkSWTifgT?=
 =?us-ascii?Q?2G6bgQVB8jEaTScPJcY8QO4fLRuj0/SGEzHZm8K1a1YLzFqcSN/QmHa6qo/w?=
 =?us-ascii?Q?dIvZgzD4F0vT+z0BEjNh9auPwxEe3izq3NJ8Bqh6s6J3Yyl0fVbvilflVn/5?=
 =?us-ascii?Q?TUGyFckpnpHjooAdsKcO/MsLX4y9yE/qqRN3c/mHu+IAHYDBowvf15aepgkZ?=
 =?us-ascii?Q?EmEHfldiMT7x7lgBSWkRUcpx+gqI/dS6qOpgrVWBP5wZjP1F91nUH8cozYy3?=
 =?us-ascii?Q?oY47DBfPlvm2Xajml5K0VqMpdC16T5qGFNa57ZgzNNTbRbdf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5794155-1a67-4471-d5e3-08df039c7060
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 18:04:14.5058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/rPk4HZYFkrhAV2sXZG1Ew4FzPtLTHDMbbdIbBWdDKwdvsJIUw2LaZ3y3ihIi0gW/3Q+nntxw6U7VXr4hJHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640
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

AMD General

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Wednesday, August 26, 2026 1:59 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH v2 1/2] drm/amdgpu/userq: use fence_val instead or rptr
>
> rptr is a confusing variable name as it is a fence value written by the c=
p in the
> fence address and no where related to the rptr.

For a little history, the fence value is the actually wptr written by the a=
pplication when it submits the protected fence packet.  The firmware writes=
 the rptr that is aligned to that wptr as the fence value.  But in this cas=
e, I agree that it is confusing, especially for someone without the history=
.  Patches are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 09e2079cfdbd..e862b65f5366 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -148,13 +148,13 @@ amdgpu_userq_fence_driver_process(struct
> amdgpu_userq_fence_driver *fence_drv)
>       LIST_HEAD(to_be_signaled);
>       struct dma_fence *fence;
>       unsigned long flags;
> -     u64 rptr;
> +     u64 fence_val;
>
>       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -     rptr =3D amdgpu_userq_fence_read(fence_drv);
> +     fence_val =3D amdgpu_userq_fence_read(fence_drv);
>
>       list_for_each_entry(userq_fence, &fence_drv->fences, link) {
> -             if (rptr < userq_fence->base.seqno)
> +             if (fence_val < userq_fence->base.seqno)
>                       break;
>       }
>
> --
> 2.34.1

