Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0650AC54F54
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A56B10E9BA;
	Tue, 28 Jul 2026 18:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RBYLZfui";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB4B410E9BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaG4aZPaMbHDJh54nCy2GROG0WySK5H9/g9nWq+gnf03zg5OiylWTqxVTprgJSbbOOTBapc/D6bv+MW+bRl87+z0XPtM7TQnmEjbZ3uGO/9KZCznQ4/ftqj78H4jJZNt8PwH3L/huzkA9dFUheAY2E6rdOn2vykz+bIIk5CFG8pvKjbsRK8hOPlWi2dACTEHR9oULw6sFFVNyhkzZsfLPYHkU56hxYWBH71utcHXO8EXMNMF/aQE+4q1sOrrAUDrEJgr3HmPq2U0tzMMRiAqtMnMkQj9cDd1KTFlQG35TiLeD7pmh3nUmpvplck7wdmeVE950imQ1eAwKlZrBPr1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3leJ6XOhlmCXq+EmPF2ulPuFdEwFOcCZiz9Q9U98P4=;
 b=x0hUB0Il/0gFNqelu1u9/4cNz4MZT/sJSz+mKmaz9gdHBKPKEbaWnZtG8efy+VUrqeZ/vxHALavKMGAcnLmgDXHfwcuuWEd0EQqrK88w6l0dvWtMgCeRRcpRiPjqefGwvbV0Dg+VAjRcVLZrjY9imOFPiVWx2Dv6eFaw5S5UbBKuTZGySXqwZMjmSXez6NlGvppV006SbllwEe0OxE2ebVujYEsCk2xHsM5SuAafX+mOVC9pEXtxZYFotTS9e/glyZSxkPkB5fz1c0KF6fCrbSPWYUYrhS8lVrPVSDcEqWGfakWGnpEQA3Kck8ZT8vWd+/TPK/bzgtADTle3acbtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3leJ6XOhlmCXq+EmPF2ulPuFdEwFOcCZiz9Q9U98P4=;
 b=RBYLZfuizCb/iIfyfU46AA6nqVea+1mT/AFI0zbH7Fr9E9jiMxAlN2QG6AOAy2jVZaYDyBCRy7KKLgsj2C2DQwJNGZiPNKP/PfxXE8ULzzEYisGmlaOGwnPvTL/edQzUFdV5EFu43bnBja/gig9865j0o/rLs3ZkSzx5Kth+HHc=
Received: from SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 18:38:06 +0000
Received: from SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc]) by SA0PR12MB4397.namprd12.prod.outlook.com
 ([fe80::9524:b7ca:358d:4bdc%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 18:38:06 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix signal reset event
Thread-Topic: [PATCH] drm/amdkfd: Fix signal reset event
Thread-Index: AQHdHr6ejiZSj8SNhUWpCeSYgGC0j7aDQr3g
Date: Tue, 28 Jul 2026 18:38:06 +0000
Message-ID: <SA0PR12MB43977490D947580400A7176F95CB2@SA0PR12MB4397.namprd12.prod.outlook.com>
References: <20260728182609.672822-1-amber.lin@amd.com>
In-Reply-To: <20260728182609.672822-1-amber.lin@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T18:37:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4397:EE_|DM4PR12MB5842:EE_
x-ms-office365-filtering-correlation-id: a829b2df-50aa-48c2-fa34-08deecd75d4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Zd7JzfqdcIdI91MoAZQziygYDngdYbDYSSmnlB2DKnLrlSbdZUNIK56RkkyxgeBZG/QDsD0HpPJoiwgFCnJy1b6+lc/S8hEjk2dC7xLS1wfYedrQhY8J+VMSOtp5Mko1pmbztbV4oX+dQHd0npsxFhMBq5RGmCSNGyriSjxIPbWOJfUzIaeNtcQ1j/55QKpzlWknVbMh+PO2VJMRdvWIpdDw1tGUduPy6tiYEzJUJrROABeGA5p7cDcvsMHwSnd2st1DGt1wqEzIjvScTwJqdqnbcJ+25dsJAHOGMxQqUMiobsXX0fGYKcSiDlwzCFXTwpQIUWy/mvl560MiwvRxrWvEZKo+9q2rGUV2mN6OA7Ls7D8ZkBg9IkczB7jPA+z88P64hJVK5BPsSsF2yZaRCr3QYcZ0r/GVUFFRPedn8iDPfQRggBFzOzi+KOYfa3rXYYixWvXrwFvxqvMqxONcmLONettoYf5e/OEwCV5bUIo8Z5VxRmXxyVPdPBAk6BLseyteqOJoXQ6PIP6/ROCtywz+tzGer+7l9v7Ow1CKAvIBGTLDCiUC1j+DL0UY8YNaPp3hVIp2F9ZAKk/vZOdRItRN8DcZ2PKeTOYgcHxYXWdX6T9wjvDg72M34j9GnVa5X0uoNpTIESnN7uxotl0qPwvpxewc4aDourDdaxq+r70lKcNMALj6f9xo5yD9x7DnB+Y60rPC0L8tVYsPYHUtN/tdNvZ7+sLnLfapJEeN21U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4397.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLsN2fwlw1szh1AsULm+ZDl9J1UfBTEwxvm5Udore/XhUirG9581JawMVcbh?=
 =?us-ascii?Q?4ZXnJs43TZux5JdH3B/7YXJy6pRDsds20dSF0NwwxtcQ6zszL7rYCz5IVNIK?=
 =?us-ascii?Q?rqWi7ZprmVSW/eCPJBTWHi3ElpMZixRj0EWprdv5guCcnyM60bi8OcgqJNNV?=
 =?us-ascii?Q?mLmYdBKjl1PQsi4ZiuRHdHZ1Sswst+o3NGgOtNiymLR9I3pxXgz7RYBNlZbK?=
 =?us-ascii?Q?RLh1f4tJi+4h1IrS/IjXMzk1giSOGpXg8hqEoabcnFiVXyULpweXnWRVZV8k?=
 =?us-ascii?Q?Mb4d9yaIOVwCyhuFCacFViEqsm+EGraeXsOMOG8SrLG3n/lM2ODEjg+5pi6T?=
 =?us-ascii?Q?9gTQ4O8ZwsyHRguj/hiA7zMm4O8VsUlDvAovRXRLhOvRJsunSq+JM7+Ft9OK?=
 =?us-ascii?Q?ngR7akAnYqaOUtB4GSYvDL0zTPT9NNvKGsBHqG5m82AOcSImJZX3pP022Ek1?=
 =?us-ascii?Q?yQozmKrjwBUwMfZyFa293t9WM/UU/OQ9n4r6PcIbKxNPuIEzfD5YYKMvAfUi?=
 =?us-ascii?Q?ekzN3Ur6nggh3IM0lVszQh5kjsuAYrY/WLNMd+EI5keFP+cUfTgvATjUJvaL?=
 =?us-ascii?Q?gPAf0kvoxeHmzQ265Y3xT5blG83rNtqkJfWXf+5iDhHMkzy9a3LnG33qGARm?=
 =?us-ascii?Q?iA2Vvz81ZsSxepbgM6+kHpsmW4aPo0DF3mVv5MaH2J/6leFI5TDzZTYI8bH3?=
 =?us-ascii?Q?a/8flpmZYE+z7Oh0EG9V1Jp6Bh6Qz+N+IE8EHLepBLmdC+94WNO3UA5HRJXm?=
 =?us-ascii?Q?cxURdNhfTIGquJtzttLScofNGQBm96bNz+e2gdsePNlF4nCS1UfSIBNfsb8i?=
 =?us-ascii?Q?mPgqIrwBRUApY732ybyZoiHGAc/uvdzm20UmF/luJl3nPhPFTc5p1p5A60Gs?=
 =?us-ascii?Q?RHNC090snZtkJbG0j1PMCpax03H3YW18n2RwnHJhECUbHAADzGYuhz9bFqF6?=
 =?us-ascii?Q?suHnyCMgkjq/Bd1jxOVwPLhFIdkldSX9V/kjMimLJwBhaTFUXzUoHs+QBml/?=
 =?us-ascii?Q?QOj/Nn8vH85zlQwTfG4Pzi3BjWoG14WigtYtzLosKuAAwU1z2eUQ8J5d0T77?=
 =?us-ascii?Q?JAq/VNj5JqGAg3jETn4w7SBmWUjwZc0ng89BNgpXUKjPa/PRJu3Y64GESvJ0?=
 =?us-ascii?Q?FIi5tOmhnd3VIjJUAutTuu5dzMi1vh1azPFWzqqm+BB6Xn9zRw/b67Aa/IYQ?=
 =?us-ascii?Q?fJxMAMMCrqbGfuZ7jZaZMCEb4j7M6MI5KNl+Fzz7sdtgXqCUont+R67Urilj?=
 =?us-ascii?Q?6B4aU+XSBnsgFtnpwaqUcTRRWZuhJ/xoBoLfRHHBrI44P+bkk5HjVXjzu7cY?=
 =?us-ascii?Q?3r4/9Pe3ToM4qID9ea5mpXi5YKKdkEzrQaKNGjt4Vnc909p/S9RBmZWZfQav?=
 =?us-ascii?Q?nEswC/2hYzzUo7ddUsY/hQJ5hXayCIlB6whH/MDkhd8QM1ZnQiZAOeNzBZ9z?=
 =?us-ascii?Q?0LCk2hvtNDUpiDGBAfv7MOJ/yT/WOUCFTfzS4KJ7aUIKRRQ11VdJWXU3tW58?=
 =?us-ascii?Q?cH1tqE8i2ivY3P9XYS/4yfsSVzg4UmYoLyssVPEp3qF3uXTwjWNecqR4V62U?=
 =?us-ascii?Q?c/P8cVMtLZg+TrC9Q4v/0hK5a4kCArCZV/pS0K9luRPxwCkfCeEoIC6pnHOh?=
 =?us-ascii?Q?vtGSS8hy3cPxAdPXsIxXetaNUcjZS3o+7+JnckDbkA0oG5Upsd4cR00o/SvX?=
 =?us-ascii?Q?BuxBp+DVrqCCamdvm1vCmpKzqNxtySONLa3hjaikHjoR/3ca?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4397.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a829b2df-50aa-48c2-fa34-08deecd75d4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 18:38:06.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMTebcffvNTQQyXseHVOElbEHjFk0IB3pjtxAghto/W0v0+BvUGNVNTIyDfB5TwWYOwNie47FAuD5/zZkPYIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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

Reviewed-by: David Yat Sin <david.yatsin@amd.com>

> -----Original Message-----
> From: Lin, Amber <Amber.Lin@amd.com>
> Sent: Tuesday, July 28, 2026 2:26 PM
> To: amd-gfx@lists.freedesktop.org; Yat Sin, David <David.YatSin@amd.com>;
> Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Cc: Lin, Amber <Amber.Lin@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix signal reset event
>
> When a mode reset happens, driver needs to notify the process on that GPU=
 a
> reset event is happening. The existing code assumes the process is using =
the GPU
> that is getting mode reset, which is not always true. For example, on a 8=
G system,
> the process may be only using GPU 0~4 but a mode 2 reset is resetting the=
 all 8
> GPUs connected by XGMI. Trying to find a process on GPU 5~7 will fail, wh=
ich is
> fine and should skip the event signal.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 5fa156e89a73..6e32a892d56f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1164,6 +1164,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>       struct kfd_event *ev;
>       unsigned int temp;
>       uint32_t id, idx;
> +     int user_gpu_id;
> +     struct kfd_process_device *pdd;
>       int reset_cause =3D atomic_read(&dev->sram_ecc_flag) ?
>                       KFD_HW_EXCEPTION_ECC :
>                       KFD_HW_EXCEPTION_GPU_HANG;
> @@ -1179,17 +1181,14 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>
>       idx =3D srcu_read_lock(&kfd_processes_srcu);
>       hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -             int user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id)=
;
> -             struct kfd_process_device *pdd =3D kfd_get_process_device_d=
ata(dev,
> p);
> -
> -             if (unlikely(user_gpu_id =3D=3D -EINVAL)) {
> -                     WARN_ONCE(1, "Could not get user_gpu_id from dev-
> >id:%x\n", dev->id);
> +             pdd =3D kfd_get_process_device_data(dev, p);
> +             if (!pdd)
> +                     /* no process is using this device */
>                       continue;
> -             }
> +             user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
>
> -             if (unlikely(!pdd)) {
> -                     WARN_ONCE(1, "Could not get device data from proces=
s
> pid:%d\n",
> -                               p->lead_thread->pid);
> +             if (unlikely(user_gpu_id =3D=3D -EINVAL)) {
> +                     WARN_ONCE(1, "Could not get user_gpu_id from dev-
> >id:%d\n",
> +dev->id);
>                       continue;
>               }
>
> --
> 2.43.0

