Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF521CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5710E750;
	Tue, 16 Jun 2026 09:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzYI9JKt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A5010E750
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwJ/AczZaRtO5xK96uHzMHcLFCHtkxjUpex9BEAcisWnGcBsXstG36kMAm8GdtIZVk4thjv3utuOwM9oZnuOWCgueyOB+og3EpPSKac3GUtL8q2yBGeishGWT5S7YwyAF83/6kNwxvYQRGD2/x4ZECbhwtJajdpY+U6KDVAZI0/v5CWxFkkkw05wk/1MLGRr/O2RHOFP/CTnTi5ruHlL3OuaBurERrzp+fai3yg5Lu/YI6aCxTZoKq+XHA8n0YwAFwxP8vxLi9+GUC3On5QWWnK2gfRKpAhPh4NLa9d3i7eZgKR2E1rajzaQ+5Dg5kFDuzFDzs4NfWKxKCW1NK2ZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohDeUO5mxBTD1zwr/j0la3FNqWa0HeAUzSn1HtHv+ek=;
 b=R0CTBsBLeS9mXtaA/LbxgfStJNJLOYahyfy1qQlpG3tujFbLa2A7E/HAfnorHQgGpV8Ph4h4zbB+QU+ab8kKz4jBDwKlzo0hz5pTgIS9Uhdez+MvAAh8rjz4GgdSmhhiBXxw7mDbKaQPRKe3S8u6fNuv3nOnufP2S11sYuOan2jit1BugujNIV6C+swZerdJ0tz7+t4hz3XSvYtYgDQ+3Qoz/MI2d7RDHL/bufTUX1U4BdM21BUaRONSwZztIIqhhXg1qZtzbeSYj1xtgUsD76MRmAEpwfzt4Qmh/g0wYNMYbZ1xM51hnO8XZQe/gJq9SaNvhTnMma99Z3OKZvVNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohDeUO5mxBTD1zwr/j0la3FNqWa0HeAUzSn1HtHv+ek=;
 b=wzYI9JKtT/qQSQxir8marPGR39moAhBn2phvdM8TWjNcS3LcWDVa/wl1KeAWVao5Snyr11tpo5ZH2jtqqJ7f/u0j3YkZKrTnhHIdRZuk2pCsGYRgc5Can18zZMQMABZJF/bjud2PqBGrHi1ch4l0zPchptW2zzNWYP3OJ52vWgU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 16 Jun
 2026 09:37:10 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:37:10 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify
 guilty user queue
Thread-Topic: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify
 guilty user queue
Thread-Index: AQHc+VaA0JYEmBBv+UCvud7zrqxHPLZA9BSQ
Date: Tue, 16 Jun 2026 09:37:10 +0000
Message-ID: <DM4PR12MB51526ED3F2FA7AF14E9CF420E3E52@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T09:34:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM6PR12MB4092:EE_
x-ms-office365-filtering-correlation-id: 726efeef-77f8-4f86-5f60-08decb8ad6cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: yV/0kg0QHe5cprWdT7kvJABJPnnEWJQ5WKK5n+uG/+Zxqm/E7LCal6FNEAOLwZlMq+XRK7AObWgFItWzquVHMUFjAGa4Bqpj8LXSvYR8rbCCtTH3BXbHuCWUBPwKpOhU173strzpB2ORvsDuuZ4aK9gOvIJJc+wvyeHsNotCf0FRKmjD66z0DAQB0//dJ6Fksyobvkjldk1R+c3RGJ10n81+zA6V/y9xjTPAkwsDKWO2EFo51u95sktZDkbF6jbUCgajrH5hVJyA/ZNBAPeTWA4f3XfTtPODyQEE8SaE+XMgfyDOUM7TMBH+znyrTjD7qe1lrYpshIjG/OoGoVNQojosnLuMPZxh7A2Bi7k0OJuAvxyZ2/Coy5qXhhvH5WtJZ6sIbP4cg5LJ/WEEdQNj72jhKlwdBKGbBM+ZJczmCHif4ETOae/2Sw3PnCM3G+j9EfQWhxRMO9n4miSKNHccQWo/C0eN/H8gZ4ojQlvU0/E8HhCdvglxmNdn+/tnKi/060nan1/sbfs4qajfkHS757ksrZGbTLDGaVWQUuRS5zVQc4xXgZW3AYNT3h8QB05wOKO3lPZ3CLg82iSd6l8A2P1xidfRVZdVsGtL4DfnbOaRI2r21Uy0awn3VfFDJw+/cJyPw1EGYYlSwqbtZGXKI/WEPKchHRAYoWyUsqaMVWgSNiLy8wZ3Eiv8gkkmIjdowgNYp89uDAjvXnCGiiFT66ytmmr1SNWckzNpatHMZWbLTOvSvZBJEZWyedZyg1o5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGm2YstJw+irNhaYjK079AD6W8EdJttc+/86EJ/hFUHcntcibQeBumgD84+S?=
 =?us-ascii?Q?+FX9cZWZwktKws95nQ/lgM65HuSOguWWIFuzlvGuimVRXpUsslXWD47aUsUc?=
 =?us-ascii?Q?giskUjnPh6BpWa8vL9G1u/QzJ0Js++j7oF8CBht2CEKRJ+xK56Ec9MuLuq6z?=
 =?us-ascii?Q?3c/+TQRqsGhoIxZ/JiFu4VWJmDphtsNoWNRf07srlCQOBydm9O5zus1SugRe?=
 =?us-ascii?Q?RU3SjAh9XR6KhIw5+Dak1sMGtU+tmdD9oL+WHtzZ0SDZ1HlYffWk0m0DHmvj?=
 =?us-ascii?Q?hRlmpMVLHITt9j8qqVsWH/XolDC6+AhSrv5vyRrrYRAm6pguqlToWR9tEucu?=
 =?us-ascii?Q?eljWH5hc5TC8aK/JzPcWTuNmah2OJQSRXXf6a7aPn7GD6+hpxrrIoXNKFXV7?=
 =?us-ascii?Q?3EQcluwH5uuxFFl306x+WvYF9novVLVI3Vw0H9V6POZLToVsZkediNHY3e5i?=
 =?us-ascii?Q?ytNvD9g0xdFotQOydjgig/NzwpUEEmEsHmEAYeA0pnEGSM+q3JLJIe8peeaM?=
 =?us-ascii?Q?sMFAUzVGkNdnH+awvoQ13uOP6T1rgfsewoxAMi6CrwzWZQREm406nbhiYu6M?=
 =?us-ascii?Q?0Mti9hFtLk3klTH40IWM6xfpMA07MXuPn+CjStFplQhI7LJWj3QXms9Xd4N8?=
 =?us-ascii?Q?ZQVlGjEcGltQ3n49Ufj2d4XssXv+sLEp2jDx+U+aSvkI3li4WtyaXVONa+Ak?=
 =?us-ascii?Q?PH4ErYDicWifGeZE58/PGvwnPp8/Fs7c+8rwH6xq6DYX4aMu7gPmuCv9nPth?=
 =?us-ascii?Q?dLFNze+H+8PGSuZTdh9dN6RJfXXlIm6XA1uW5G9dgGorugx/nX+1FYknd0Ox?=
 =?us-ascii?Q?MpltaW8m2XpmPlrwix+siM3j70GmbgxevlgAEmVo+23BMlr6R/ML2BRVd3T5?=
 =?us-ascii?Q?paZf8O+HTjdfHlv6XIBCVZQB7nNySu/j31E8h/zSWAD0XgalICwaetqwc2xu?=
 =?us-ascii?Q?6SQV1aue4QzZoq0hGoxEXAF0ZyjuOmt9z1AyC66RkIHcscoDFV4iEY8o/7cr?=
 =?us-ascii?Q?/geMIUGvW01dr9AB/cbvv1T3iwLI/IWTckgwHZ14fiXnAxOtL+KfBsxkBbHA?=
 =?us-ascii?Q?93FPYDLQcvstIPfI5OHb0V9bGdVglv53TgCvK+5JMtZY/FCIMvued4AZDDXN?=
 =?us-ascii?Q?lIal5bqm7n8ed4dydJ3g8MUzK+Sq26gW9/c16cxKzkrU5b6L+J2LRgajP01c?=
 =?us-ascii?Q?5i0IfxpG0V5aZdAlxIRFXMjSKHdIG+0VSYvhVXGNuyI2ODGPhs5aavo90DmN?=
 =?us-ascii?Q?RX2cXKKoJN4HmoQsm1/jDkwFfUiYEflnb6AfHPvhsmsWPk6lLLw/gMyd6UO/?=
 =?us-ascii?Q?TYqLDUAEaZ4Y0zDuvRfiXWlHlLG2LmSmuhfi9raAd3QJL1VlFgNltraefJVx?=
 =?us-ascii?Q?k/r1Ti/BBoxOBYuqRYM4i6JpiIoQo8M7Cr5IgOVvYUBwpE7IOgOcwih1nW2T?=
 =?us-ascii?Q?Wm2AAqO58W0exS/IWWjyKM3X0qg5Qg4i0vwJ6+RkdGzxnQr4wZU9sP1Po9wJ?=
 =?us-ascii?Q?lqq0pggpn6q4fKCkyymVcgIq7VaPjRrlL5taUlzBeve1fK59NTtAbHwD+/pA?=
 =?us-ascii?Q?642iBCSPPmgkuyzX9TW1dSC7CGMZ6KrTzVQQOnvQh0FE2avofZb0rQLnQpdF?=
 =?us-ascii?Q?8HChBg1xBPHd4p/6YNa6zTRVXRcVuznu1hmBwX9BTYPl6+h3Gvw7z/PULUA8?=
 =?us-ascii?Q?HsIveS5T2MFB8IXFHgDDICLd2VZMFtV4ABxqAF1IuRk3Gp+T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726efeef-77f8-4f86-5f60-08decb8ad6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 09:37:10.2646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KTnWTcWEtVjHy5PoQWYK8n/WI2/6D8I3GQfSrurU21b4RvQSFJANpqgSsEACu3G2RTUcEp46EquiXUYbVLXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

Ping ...

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Thursday, June 11, 2026 11:57 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH v2 1/7] drm/amdgpu/userq: add reset helper and identify g=
uilty
> user queue
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> If we get an interrupt for a bad user queue (bad opcode, etc.), add a hel=
per to handle
> the reset for user queues.
>
> v2: squash in fixes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 40 +++++++++++++++++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 12 +++++++
>  2 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index de6848b4fd67..231ffb29fe5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -140,9 +140,14 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>
> AMDGPU_RESET_TYPE_PER_QUEUE)) {
>               int r;
>
> -             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)
> -                     r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL=
,
> NULL, NULL, NULL);
> -             else
> +             if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> +                     struct amdgpu_usermode_queue *guilty_uq;
> +
> +                     /* IRQ-side WRITE_ONCE(guilty,true) hand-off via xc=
hg */
> +                     guilty_uq =3D xchg(&queue->guilty, false) ? queue :=
 NULL;
> +                     r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL=
,
> +                                                      guilty_uq, NULL, N=
ULL);
> +             } else
>                       r =3D userq_funcs->reset(queue);
>               if (r)
>                       gpu_reset =3D true;
> @@ -671,6 +676,7 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       }
>
>       queue->doorbell_index =3D index;
> +     queue->doorbell_offset =3D (u32)args->in.doorbell_offset;
>       r =3D uq_funcs->mqd_create(queue, &args->in);
>       if (r) {
>               drm_file_err(uq_mgr->file, "Failed to create Queue\n"); @@ =
-1111,6
> +1117,34 @@ static void amdgpu_userq_restore_worker(struct work_struct *w=
ork)
>       dma_fence_put(ev_fence);
>  }
>
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                 u32 pasid, u32 doorbell_offset) {
> +     struct xarray *xa =3D &adev->userq_doorbell_xa;
> +     struct amdgpu_usermode_queue *queue;
> +     unsigned long flags, idx;
> +
> +     /*
> +      * CP priv-fault payload is (pasid, src_data[0] & 0x3ff) - the same
> +      * per-process doorbell encoding KFD extracts via
> +      * KFD_CTXID0_DOORBELL_ID_MASK. Find the offending queue by the
> +      * (vm->pasid, doorbell_offset) pair, mark it guilty and fire
> +      * hang_detect immediately (queue_delayed_work() would no-op if the
> +      * work is already armed at submit time).
> +      */
> +     xa_lock_irqsave(xa, flags);
> +     xa_for_each(xa, idx, queue) {
> +             if (queue->vm && queue->vm->pasid =3D=3D pasid &&
> +                 queue->doorbell_offset =3D=3D doorbell_offset) {
> +                     WRITE_ONCE(queue->guilty, true);
> +                     mod_delayed_work(adev->reset_domain->wq,
> +                                      &queue->hang_detect_work, 0);
> +                     break;
> +             }
> +     }
> +     xa_unlock_irqrestore(xa, flags);
> +}
> +
>  static int
>  amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)  { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 9df1b78407f5..a55d57e2c169 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -53,6 +53,7 @@ struct amdgpu_usermode_queue {
>       enum amdgpu_userq_state state;
>       uint64_t                doorbell_handle;
>       uint64_t                doorbell_index;
> +     u32                     doorbell_offset;
>       uint64_t                flags;
>       struct amdgpu_mqd_prop  *userq_prop;
>       struct amdgpu_userq_mgr *userq_mgr;
> @@ -86,6 +87,7 @@ struct amdgpu_usermode_queue {
>        * Delayed work which runs when userq_fences time out.
>        */
>       struct delayed_work     hang_detect_work;
> +     bool                    guilty;
>       struct kref             refcount;
>
>       union {
> @@ -176,6 +178,16 @@ int amdgpu_userq_post_reset(struct amdgpu_device
> *adev, bool vram_lost);  void amdgpu_userq_start_hang_detect_work(struct
> amdgpu_usermode_queue *queue);  void amdgpu_userq_process_fence_irq(struc=
t
> amdgpu_device *adev, u32 doorbell);
>
> +/*
> + * CP packs the per-process doorbell_id of the queue in
> + * CTXID0[9:0] on priv-fault (same encoding KFD uses via
> + * KFD_CTXID0_DOORBELL_ID_MASK)
> + */
> +#define AMDGPU_CTXID0_DOORBELL_ID_MASK       0x3ff
> +
> +void amdgpu_userq_process_reset_irq(struct amdgpu_device *adev,
> +                                 u32 pasid, u32 doorbell_offset);
> +
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>                                  struct amdgpu_usermode_queue *queue,
>                                  u64 addr, u64 expected_size, u64 *va_out=
);
> --
> 2.49.0

