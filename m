Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FADFC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB5810F6D6;
	Fri, 14 Aug 2026 17:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVFtNY6r";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 304F810F6D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwmvyh5gsvsJbVh47TnBe+8siwK8inKFkUF3IBJLt/lTwa/2lcn0+qeaU4VT7Koj7jRfv7gS/LXUA2VBeMWkSueIjH3MKgzVBdUJSBP2j5+9xFoGH5dKj+ChVvKhl02n+vWqsuGRsZ8wI/AxxD4PaK0pTJLNGf2IzKmasvBE7QUdQLcl1vWde+xo1aCYAsoUXQpCd/KogGB6kviWSjs3JKUmD2Drm7CHZu3+2xDpjg9WSWFzFX33ITIC3csBVhneF8UdmJoNUTkuJUtZvuuw9Xh9dJv97Cz/WUC6bvZM4JtZPxcRYffvjjjP5i11R0hRcGy7VPbbnlykBsADJ9wbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwLvhEBYhFLwC9go2Ls/LQ7uriLL9I6/wChJ+g2Ama8=;
 b=Qj3UmffnILouShhAZLTB75bHsMIgLzZe6r9+DW6GGyEIaO+J8ORTfiG7i88tAep73FrFUbNsR5Bu4PtpXP1r1hcTbBZ53UhNTvwUn70IMi21DWyk1wq2FNOu6OMbES49amtkfjNTvPf/hZ+NoVQnEbgDXkyaLXaX2qBDixK++um6DgR/UVJu+CPI8jS6w5NFeAOnffcDHO3im/U7d7Fd9bm98yRuSphUT5NHkE8rjQjII9FlzAx4E5NDEyZixKsWlfzbCJa2jTbo6UFxLYNwWRO1nV6nv3RRvQkrGFYFocOAvyCpXIClfuwUNnGBvIRTlgOkityF594GbjlMgtyeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwLvhEBYhFLwC9go2Ls/LQ7uriLL9I6/wChJ+g2Ama8=;
 b=nVFtNY6rcfdWr7FJPrgJGYYdX5sgJtwFqXj/dkOET6kkoD4qfoHFOSiua2jYdDMdPcuR9Whc6oRSLTYixJnjgQoXdRbFXHpGVWSuZQoPlRxNVVKar7mY6E/oYiNkjP2EGo2vsGiFFsN2VyEkcuSimFx80tP5vjYt8F03O5FTlks=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 14 Aug
 2026 17:29:54 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:29:53 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Index: AQHdKZtuwKL0j23ih0iEndBGSlFyNLabrb0AgAIfOx6AAASkRw==
Date: Fri, 14 Aug 2026 17:29:53 +0000
Message-ID: <SA1PR12MB8144218D235CA976EB714EE5EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260811141202.1633727-1-David.Francis@amd.com>
 <20260811141202.1633727-2-David.Francis@amd.com>
 <5ec5f320-d8d5-444e-8ed1-1412818ffd8b@igalia.com>
 <SA1PR12MB8144389F1595B105143C4913EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8144389F1595B105143C4913EFDA2@SA1PR12MB8144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-14T17:29:52.907Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|DM6PR12MB4370:EE_
x-ms-office365-filtering-correlation-id: d0f6f748-eb81-4c07-40c2-08defa29a721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|3023799007|10067099003|4143699003|11063799006|56012099006|18002099003|5023799004|22082099003;
x-microsoft-antispam-message-info: xIETI1iMU+TBKhkGeut6y4wpRaZovag5c3mLfbJSGbNdRRkfcIUHniCykOtlNlJKQW0r2esWmipM8hyrFtLZ0glm2j3CfqUJ9srLfyq/bPGOVo6PtS0MJRliCGJAP0u4e2yH8fqx7vExJbXhnp4tOPE54jvf6shFZrU/OMUzQ0CLbj4TX2wEr5bONzYwcL4UprHSKJAwwI/u470wpqqLx68uHbSwbKLbP/Zz4s+UgPybDvP+zoxNqLx08w3RodNuEs3gsJ87N8LxVgyBvfjEbZ0fmO3vkQ7U2xOZPMK+KngZyvzgOffLIdnDaVYhDXDnPbFU2nsQc1rvJQfNP1VdZ9+7LUyzCzDS0DmKDE6/MMzdes+EUJd7EdEXt8KuENq2hGw+UHm30qCqXAeJ+wla01JkBCtECknbcNIoRzxkzXsknm+C4BkAmn7zMIscPyMfUtv7yF/GBLT6wKYqZRKMwoGtesLoDZxtiHrHM6BcrqVsrvfIlgUwt+wxkj843wq1sRMJ8MujnUFA3DsO52lElyMxqPbBi7O/Yg7DeXyeBKOXpEHP+a7D9xXzj9ULdS+QmuqiF0MeK8SVl6+p87ApH6rGtEYgrQ4hU4XsgckqoGPkO1Hn8es9ARHd92DzaELswcca95yVaS8+SgN58rD4XtE2k0aZkLyj59kFnPQ3tegD6oKFOpVB2lJ4FuA3nGCNFDv2nO/MccQflGQvxTQeu5cti7Ftzy0jY/+F5KrqbyY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(5023799004)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I+bFUXTrSGBtePEeVu4YeiYqpJ04EadsVzC2KOCchGBeuRxW4tedrKj/GtBE?=
 =?us-ascii?Q?01Q9j/QCVEsAFfTPDuvJyfTkGGKE6CvOOpE6pqmY1VjE7epfamyXSq9Khent?=
 =?us-ascii?Q?YiEs1YBkTVDByQj+i3WDq0Sw+jPeMhQAlmjv8vB0ibl84vuRFzA9I7S9I64n?=
 =?us-ascii?Q?YPuRcb8KHn0tqWUpmud4Yx5LmrBEr+xrHP/JExtZzBG4CD7pDp5vHDFsD/4d?=
 =?us-ascii?Q?S947PxmbSrh0wFytKJCBeHGZtJ1m+WRb0IqX1MJZgrdkP8F+g8LT9HTTeztW?=
 =?us-ascii?Q?SkziIKM57C4weMp5PpvVB22AYLY5fJ3GIJ/hVuj91cqif/kyzNP4NpoCQaVn?=
 =?us-ascii?Q?xLOn/4Gcjv7h8cRE1u6nzm7aUm1nWI97O/PQwnHo+d5t0qVW4ic9CaIsx/Oy?=
 =?us-ascii?Q?EnaFSYxGiISxUxzzrOQBe+4qOF3oUJokii++clDjfxJkZdyWZgyuRBjfD2z2?=
 =?us-ascii?Q?5DDS+jIRfOqYZEtcNAXPAfhOHVcQymnUz1yAqDtsZU4pmmXu2qBcOjZk16eO?=
 =?us-ascii?Q?IOXsXNxbWTCajFJSa9Bc0qXyZC67wPX8Cu6m9LWuCGSmKKCeMCkUhGGJRbnq?=
 =?us-ascii?Q?xE/EApdiT1hBgck7hRiZcxqMcf4sG7T52RwvSj6pkQVy8i7W2d8SnCqJ1rtq?=
 =?us-ascii?Q?Z1KQrL1NtD3KVGVrMBeB89f/owTuAbwRHJgFg1bHmX0NBDCHzqh9v28Z/pMQ?=
 =?us-ascii?Q?OF5L4DjzJEpNyXo26p+gBXMnq87c9eTnQnDv01bK+Ciu9gdQXNXDdIXjZ7lr?=
 =?us-ascii?Q?LRf4kijy5B286UHMlSZ5VgjlDF0sCPjYv0NO4P0eqokEGXEenC/E/WrZY0hd?=
 =?us-ascii?Q?+122yDXviC11GX1Hrzvjz6hJf5p7c71Krk+UL6clnq/mDTVu2AI/4R5i2Jm8?=
 =?us-ascii?Q?l89MwnC2WDmnJA0fZfs3fvWgn8hXwR0nv8Cs62GngXo+CdOmT/uWTrVbaTT/?=
 =?us-ascii?Q?qpyv+jfg6ysPScKklADqXKxiQ44y/PJZD06TpBbTwO4r0qrp8QYu766A948K?=
 =?us-ascii?Q?IS8J2dzdaFZR65r04XBBlcxs16ApKjB8mO0LedjEAUrKvgW1NEcoqN/tsdN/?=
 =?us-ascii?Q?MaUd/mWN6JhikOcCwG81/QlJCduI6ri4XUVfo4T3HgZLPeG8DrzTRNQga7PT?=
 =?us-ascii?Q?odnRNbIGThL0XgwJDA7L6PC4zuaAUoi10uUvDWODOzDCsqgnKvtDcvMQxdRM?=
 =?us-ascii?Q?lsewKJfQqRRZMpCsxr++P2eK2fDhEjRXz+cp80/UlT4jup4rjEx142WGDw0l?=
 =?us-ascii?Q?BfkvX2HF+LdNQrGPgnfAiiJU89qqtyIwtkYcHiv5Zcbeso/sXU5eI+/WVYZF?=
 =?us-ascii?Q?2n73xcgHJlhHExtoiXW4TKPvr+4DGRKlnmWRz9tbRmudrmWM3f6G/pNAsnS5?=
 =?us-ascii?Q?pFeyYs9eh68N78A0lcTdpfqcHlH9IfK3rzD0XtX0tAF8vRWsZiQMRsxJvJg0?=
 =?us-ascii?Q?Ua2Wjh8d/izMEXA4X6XIL+VxVFIqNI6llX88Cz9oBnTXFaq4MOdkcdnOizvi?=
 =?us-ascii?Q?xby+NRTLqcK57tBc/4JN8JPaRYiXZQ0j+h3MFBD6lW9OZN6qRHqJ3VwwElMD?=
 =?us-ascii?Q?2GAd3M253J9S7wvuNUx5mAwMzKXTZnGuG/L8WuaaJYNpb4iHEFRyI/E4XjS9?=
 =?us-ascii?Q?ROaV+DcSnZ9vizqS2HLrr/J1g8odXhsxCLzFoqvy02Cd+73+p6GLEw7OlYkh?=
 =?us-ascii?Q?idVj3OjkGSg0H3GvRcUUKZ1Kz0vYrHVl+DtN8flcHpfAJs80?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6f748-eb81-4c07-40c2-08defa29a721
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 17:29:53.7441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJQZeXGum55b5qj6XWRe/aLA652b3xUQfJ2oEoM2FpbGa18Y6TbPYsJcwQ0X5+wR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

Wait, not idr_preload. Is there an xa_preload?

David

________________________________________
From: Francis, David <David.Francis@amd.com>
Sent: Friday, August 14, 2026 1:19 PM
To: Tvrtko Ursulin; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l

Thanks for the comments. Most of these are just mistakes on my part and wil=
l be fixed.

Regarding the locking,

on CHANGE,
> Same as for the list ioctl, GFP_KERNEL under the xa_lock will not work.
>
> You can have a look on how I've done it in "drm/amdgpu: Add context
> handle renaming operation" and see if you can punch some holes in my
> logic there?

I think the solution here is just to use idr_preload.
I'd rather hold the lock the whole time to avoid having to do the
dance from GEM_CHANGE_HANDLE.

in LIST
> GFP_KERNEL under xa_lock will not work.

This one is harder. I can shift around the allocations but the point
remains that if I don't hold the xa_lock the whole time
there's a chance that create / free / other modifications
of a queue's data will happen in the meantime.

I can avoid over-writing the end of the arrays / structs just by
re-checking that the array index never gets past the size of
the array, but that wouldn't protect about returning
corrupted data if LIST races another operation
(such as CHANGE_HANDLE).

I guess in that case it isn't a security risk and you could
say it's the user's fault for creating this race condition, but
I'd prefer that wasn't part of the interface.

Thanks,
David

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Thursday, August 13, 2026 4:48 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l


On 11/08/2026 15:12, David Francis wrote:
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
>
> Calling with an invalid new handle will fail. Calling with new_handle
> =3Dhandle will succeed if that queue exists but not do anything.
>
> This operation holds userq_mutex and the userq_xa xa_lock for its
> entire duration.
>
> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 43 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++++--
>   2 files changed, 57 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 3c930425c1bb..b532ba0f4cef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -852,6 +852,11 @@ static int amdgpu_userq_input_args_validate(struct d=
rm_device *dev,
>               break;
>       case AMDGPU_USERQ_OP_LIST:
>               break;
> +     case AMDGPU_USERQ_OP_CHANGE_ID:
> +             if (!args->change_in.new_queue_id ||
> +                 args->change_in.new_queue_id > AMDGPU_MAX_USERQ_COUNT)
> +                     return -EINVAL;
> +             break;
>       default:
>               return -EINVAL;
>       }
> @@ -1012,6 +1017,41 @@ amdgpu_userq_list(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>       return ret;
>   }
>
> +static int amdgpu_userq_change_id(struct drm_file *filp, union drm_amdgp=
u_userq *args)
> +{
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     struct amdgpu_usermode_queue *queue;
> +     int ret =3D 0;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +     xa_lock(&uq_mgr->userq_xa);
> +
> +     queue =3D xa_load(&uq_mgr->userq_xa, args->change_in.queue_id);
> +     if (!queue) {
> +             ret =3D -ENOENT;
> +             goto unlock;
> +     }
> +
> +     if (args->change_in.new_queue_id =3D=3D args->change_in.queue_id) {

I would move this outside the lock or even consider returning -EINVAL.
Or you have a reason why returning success is handy? Probing what
exists? Why?

> +             ret =3D 0;
> +             goto unlock;
> +     }
> +
> +     ret =3D __xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id=
, queue, GFP_KERNEL);

Same as for the list ioctl, GFP_KERNEL under the xa_lock will not work.

You can have a look on how I've done it in "drm/amdgpu: Add context
handle renaming operation" and see if you can punch some holes in my
logic there?

If that works question will be do you really need both the userq_mutext
and xa_lock or perhaps xa_lock would be enough throughout the series.

Regards,

Tvrtko

> +     if (ret) {
> +             ret =3D -EINVAL;
> +             goto unlock;
> +     }
> +
> +     __xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +
> +unlock:
> +     xa_unlock(&uq_mgr->userq_xa);
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +     return ret;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
> @@ -1058,6 +1098,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
 *data,
>       case AMDGPU_USERQ_OP_LIST:
>               r =3D amdgpu_userq_list(filp, args);
>               break;
> +     case AMDGPU_USERQ_OP_CHANGE_ID:
> +             r =3D amdgpu_userq_change_id(filp, args);
> +             break;
>       default:
>               drm_dbg_driver(dev, "Invalid user queue op specified: %d\n"=
, args->in.op);
>               return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 678f3d531df7..de9ae1296819 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,9 +330,10 @@ union drm_amdgpu_ctx {
>   };
>
>   /* user queue IOCTL operations */
> -#define AMDGPU_USERQ_OP_CREATE       1
> -#define AMDGPU_USERQ_OP_FREE 2
> -#define AMDGPU_USERQ_OP_LIST 3
> +#define AMDGPU_USERQ_OP_CREATE               1
> +#define AMDGPU_USERQ_OP_FREE         2
> +#define AMDGPU_USERQ_OP_LIST         3
> +#define AMDGPU_USERQ_OP_CHANGE_ID    4
>
>   /* queue priority levels */
>   /* low < normal low < normal high < high */
> @@ -463,10 +464,20 @@ struct drm_amdgpu_userq_list_in_out {
>       __u64   entries;
>   };
>
> +struct drm_amdgpu_userq_change_id_in {
> +     /** AMDGPU_USERQ_OP_CHANGE_ID */
> +     __u32   op;
> +     /** Queue id of some queue */
> +     __u32   queue_id;
> +     /** Queue id to change that queue to */
> +     __u32   new_queue_id;
> +};
> +
>   union drm_amdgpu_userq {
>       struct drm_amdgpu_userq_in in;
>       struct drm_amdgpu_userq_out out;
>       struct drm_amdgpu_userq_list_in_out list_in_out;
> +     struct drm_amdgpu_userq_change_id_in change_in;
>   };
>
>   /* GFX V11 IP specific MQD parameters */

