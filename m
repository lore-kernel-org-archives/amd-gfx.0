Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94681CD6E7D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 16:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24ED510E69B;
	Fri,  5 Jun 2026 16:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrSuRDVF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9D410E69B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 16:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+dX4NVw5plMZCPFOg0eEB1CfQ0aaFIw0DC706xb5Hr07/nYIZi5yGNoHk2byUWdOyJLjti+VIB7HFFYdLOf6iLCs5YGeM8VcUr7CzH+IE5rfbUPUcB+ZJ1szZ6JGREXenlmre63pMGHlBeoWhy5eYa7JMEWZtZ60tO6nC2i5kUd5wrpy2AKkmmAhz5RjZddWtr6I9DqOizCiG0/6hc/4lluh3ZUGQWLMsNSGRRrSHBeWkEBmto6Y2ngavRHK+wYAkEEbOXHWN7JgeBmvldxA2x2ykAQbg6bSqFRovEg7DcIVZrF8YOtmFKpraSdKwae8bnVVozCUO3smDTTuwAAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd2X0hjrpQ/GEXmfLx860XKQPD/ksAX065kk2vHS5qY=;
 b=fLdiEFuVTD4uyKi9CoM1APkkAt9IT+hR9mm15GB+yYwZFhGZpOhL5QlPyZrueNhSRCHmfNQF3BmBb3DA99MYgWKVBvEPx8NKYdCeTOc1a+xgN9AL1nQwMst/s7vppmeceeKFywUvU5HDMCZk3Ne1i1jM2v8iETHh+02Yo3aAvZqLobaOdafrE4nTIg8/I6ppvN/FIP0ebRSY8MRV3sFuWJ0K1Czg0W4drG7aDn1JpI12wPweumj+ZkbYMGzbdCIde3Ubw/1esb4/syTu8yB2WdcxYqBN4oc3db8D87pJ5qmbyEI71DSzo4N6seMdECiDbMN+Fyl91PtWdWYlYhCMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd2X0hjrpQ/GEXmfLx860XKQPD/ksAX065kk2vHS5qY=;
 b=nrSuRDVFG2yl0DZkSjqcOoOu65jG5wIF64nQpPoZHsCdTpJnEokrbPOqpMP+mBGmUJhEkfRZRgF9qr4DwKKAR3WWuUpNYOrsRzBT3zTeSWy9SbKN4e0sffbf33rlmL49r1BdygZOFOPwuPBGS2KgGW5neINsOmsU3etovRtnpyE=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 16:09:24 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:09:23 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Philip" <Philip.Yang@amd.com>, "Yat Sin, David"
 <David.YatSin@amd.com>, "Francis, David" <David.Francis@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Properly acquire queue buffers in CRIU restore
Thread-Topic: [PATCH] drm/amdkfd: Properly acquire queue buffers in CRIU
 restore
Thread-Index: AQHc9FpyS/upLeb/hEmuLpAZp10DkbYwInyw
Date: Fri, 5 Jun 2026 16:09:23 +0000
Message-ID: <BL1PR12MB5898A8F05848537707B1297385112@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260604194314.2981688-1-David.Francis@amd.com>
In-Reply-To: <20260604194314.2981688-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T16:08:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS0PR12MB7771:EE_
x-ms-office365-filtering-correlation-id: 251b7caa-ab3e-4ab5-1c0b-08dec31ccf39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: RO1mZti1n96EHmU7kMv1NucAkLgTTSIkB5EYgJ190wjSvXP4pd7K7Wvu6rlTSwcSwSFhX/yzjZ9E67NJd2sbG9xe20P0JZBqYumGHOyW+cV74lemxWMNpLyXoeBSUbQCSe5krjzvcmF5uM2oEXy8PL1qt4mHd1u+lqkB+jO4ssiZ7B0GI6iYcnqNiBsQMuZXeMUVguY5HH6aY9YcDOcRWgWRvSYITcWGrUqfTUoD1Ey6gGT96+SJVw39oDE2PrYtNy22H8GwOcC2FT5QULvpiTutvlyl2Z5BFQb5qvag/8KNCzA0bh0y2K5Y9OlhQH8vka23foXQ9pLMUMK6KHNqJ2jGwHNb7HVMuVhakzHV3Lca1z2V/SCOCXEkaaqL6XRB0VApPvM8UdfaTwPiuZfrXYL+NJbvZyECgiE7Z5dKrkKn1I4H7UQxpVaE084BzGuQaxNvW3liVKoMups81d7ypcmeN98158yggedtPe784CuMaNH9ohLG92frm1CdEoR3/M1AziGq71aB4dkCUsA14xAfADvKt/6N7EQ3tWI2CpYiaALQDDKUZv3643UjWQVk5RJtoCU4wNAHCi2Pu1WZxxJkp+aTH6oUl0Xr4MTVWv94G5VyKMuycbIiC2ms/woEvM4m0HutV0tg+8qWephwNehuRKbf44bNmnzdSPOO4pNa4TwuLrcj2iN+LgG8GXbIdpIJ9IZHhuFdzEs3KvSzn280pNGq7PaffHJe7H+ZCR5EEldJSrPC/FF4yK7mwJBf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFvPm2btsxma1MtCmZ85iAXa7gd0DE/YxfqgsZ4hfLos79ckIMBpKMMflPYT?=
 =?us-ascii?Q?HDvsQ7pOVq4FJbtRK5CVCRTSkdJ7Skc3doq6i3cYEHTe7XvoreVxQhftwRSC?=
 =?us-ascii?Q?pe1/8uS3Z97CEwgApDKSH6RsZHX7TmD3Z+us25CrjuIank+EvbuOfLE9qnYU?=
 =?us-ascii?Q?LVnA4ZTlriBOcBVh6rwXSWIH1kDVxNJQsOwieAib4O2xehxbEbMZmXws5yMh?=
 =?us-ascii?Q?ytp/oB7bdj55Iq8V8XNXno9o8BkuwUYSsYwz5tQqIm8rLgvb+U9u5+lHbmPF?=
 =?us-ascii?Q?0WhzpYovz5ZDMTATSVXfKUPVGbS39/xnKQHOkCCQi/k76TJ5f70NrM+6/t8L?=
 =?us-ascii?Q?TjVU2r+FCnt9BmGVQLERGOcg7yQeHNl4zUtO2cQXxru7QPyM206JuKmQfit4?=
 =?us-ascii?Q?hNlziJLrGVQHbmU+Bg/mvfNdHcPTOUOfAP46cZbsecjvHJXmyJUh2z9w2Po5?=
 =?us-ascii?Q?My2C8jrbGL1vZOJhm/0/qmolwhFoDMCdkEZXjonAXaO/1gU85ZZFoT5hAge6?=
 =?us-ascii?Q?Z32M1A1dSHneCnfsZ89hmSzpqSdWSlpHsvatQvzmp7vx90lKg4zmZdvBnHy1?=
 =?us-ascii?Q?x2vOVstI4MP9f8DdHZR45nQ6ThaFL6tDnDH5W7skyyE4nnBUq7V9GEc7/H4/?=
 =?us-ascii?Q?tSO91zrlQ7Ulic1vS+E/eq5pq6zJfNw3jLATB2PPp9fpsh6lqTptcjPbV4jm?=
 =?us-ascii?Q?aSe0ZSt5zwErsg5HfpyvvOKGLuiSIJMlaLq+2Md2HUeToaVy5DuTebxzACDB?=
 =?us-ascii?Q?OaTrOB1wxDXfWCmoG0tlI6G8LXsTnHGxWLD5kB3kMekqXYeqAe2REzg10ztX?=
 =?us-ascii?Q?cFP9BBoJFfaOyuSvE3LyqdPVuGyMdMV/x/YYrWc5j1jQHiTO8pNa+2fbu6NM?=
 =?us-ascii?Q?Z03Er9sxmBAzd6C2f1K6L8b3BEerorojGmBketiTZaEYYJwQ9R3e0dsgmvay?=
 =?us-ascii?Q?xMYRGPCS9914DvRd2GjEzQYett3g4QatpFQHnnvZoIWUvXxYTk0Ng3B3XtPh?=
 =?us-ascii?Q?ewv62rfIgGfIJSLR7iZ9Quyxt6QKt1BqiroOdGsuqufgnsDObQyRIVp0AZQy?=
 =?us-ascii?Q?qSj5j/wTxFQOLkUJze9i/n53u9cWiAhZ9xYEcMpHXiiX7mFPm/ZIIIWxzuBQ?=
 =?us-ascii?Q?hOI4SRGzU4WCVb6yy10ljYkUHiUSTGfakVWO7z+NM4s6UZ5nZkmAp5ZQFlfu?=
 =?us-ascii?Q?CLzuh0oCZj17QlUvRKSmRV55toKhYbIdML/UON3a5clsufEJrjg2rHJwRQr1?=
 =?us-ascii?Q?+9Fhg02rQG1vhErUO9u2wkufQEgI8FBsZqQVG+lhB+pQ/BK5O/6cr+7wgzt4?=
 =?us-ascii?Q?b1s0nIJUyoDzH6nQqu/aPMeS22YsLKSWlSFGfdpLVHUFgnEiK6KBGkUfxsDn?=
 =?us-ascii?Q?RqBmQ8uZo4++hKj/KBWNCNkkfO+qgLCKQmgJbNjjEDZDOW7/aShDVsOXjAfE?=
 =?us-ascii?Q?bYRT3bTfDlbINQC9h9oQutx+m9FJxXoOtaiK8cPqGvTy44dJ1dwLfHCMy8Ng?=
 =?us-ascii?Q?xv5kJ1Y6R7D2SKmYaACKqKNUbcQ+kXU3mXiknKLAk6pTjW8DHF7IlnLZ4Mog?=
 =?us-ascii?Q?iNzVRJkypk/8ImO65IN8owQhWCJ0qPNnDNUKFEHpWWJXDnHVDuSdJK3NxibJ?=
 =?us-ascii?Q?NVY/iWp2j8iUN0EHURIKgu4l2IurmeHRd4NhWqzSf0RulZeU1kby72Pa/u7B?=
 =?us-ascii?Q?dWis20SgVYjqqvIolUk/dfTNcAsfl4/biwRVTT+aVFVaPXL4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251b7caa-ab3e-4ab5-1c0b-08dec31ccf39
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 16:09:23.5495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j1A7VGZJqSkOcxLfUUoTk6RvIZwdvcbbzw20HQ66Ik+osqd5FTQdmnpapoqxSNZxhdX9rjk/COrxW38MufR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

Unneeded removed line at the end. Take care of that and it's

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Francis
> Sent: June 4, 2026 3:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>; Yat Sin, David
> <David.YatSin@amd.com>; Francis, David <David.Francis@amd.com>
> Subject: [PATCH] drm/amdkfd: Properly acquire queue buffers in CRIU resto=
re
>
> When kfd_queue_acquire_buffers() was split off from
> set_queue_properties_from_user(), set_queue_properties_from_criu()
> was missed. Thus, set_queue_properties_from_criu() is not
> filling out the buffer fields of queue_properties, which
> can come up when subsequent code expects them to be non-null.
>
> Add the proper call to kfd_queue_acquire_buffers(), and also
> use the right cast types in set_queue_properties_from_criu()
> (which were missed at the same time)
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9295d0f9dce4..67b282dafbe7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -962,8 +962,8 @@ static void set_queue_properties_from_criu(struct
> queue_properties *qp,
>       qp->priority =3D q_data->priority;
>       qp->queue_address =3D q_data->q_address;
>       qp->queue_size =3D q_data->q_size;
> -     qp->read_ptr =3D (uint32_t *) q_data->read_ptr_addr;
> -     qp->write_ptr =3D (uint32_t *) q_data->write_ptr_addr;
> +     qp->read_ptr =3D (void __user *)q_data->read_ptr_addr;
> +     qp->write_ptr =3D (void __user *)q_data->write_ptr_addr;
>       qp->eop_ring_buffer_address =3D q_data->eop_ring_buffer_address;
>       qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>       qp->ctx_save_restore_area_address =3D q_data-
> >ctx_save_restore_area_address;
> @@ -1042,17 +1042,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>       memset(&qp, 0, sizeof(qp));
>       set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev-
> >adev->gfx.xcc_mask));
>
> +     ret =3D kfd_queue_acquire_buffers(pdd, &qp);
> +     if (ret) {
> +             pr_debug("failed to acquire user queue buffers for CRIU\n")=
;
> +             goto exit;
> +     }
> +
>       print_queue_properties(&qp);
>
>       ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data,
> mqd, ctl_stack, NULL);
>       if (ret) {
> +             kfd_queue_unref_bo_vas(pdd, &qp);
> +             kfd_queue_release_buffers(pdd, &qp);
>               pr_err("Failed to create new queue err:%d\n", ret);
>               goto exit;
>       }
>
>       if (q_data->gws)
>               ret =3D pqm_set_gws(&p->pqm, q_data->q_id, pdd->dev->gws);
> -
>  exit:
>       if (ret)
>               pr_err("Failed to restore queue (%d)\n", ret);
> --
> 2.34.1

