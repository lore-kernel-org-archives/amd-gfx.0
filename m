Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C966AC982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 15:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6306210E239;
	Fri, 18 Sep 2026 15:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eIoz/AMr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0494A10E239
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 15:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ98GfRHEg4yBgO4TyCe9iBGBjbemYeadi/wYN0bmwoZ9XKqnhKgkCxNTyHApgxjk549LfVy3l5se66zNvXY96Drh8G0tJLQYWJYL78a2I3tq1+Jg+bw7u/xmF2lxRzbtqTz9icX/jrOsUB7Nt1dLlwYoL1q2a8D3/ImAsh47oS9XciRNa7XWnLITg9vslrY16unTb3RIcHdAv6nlTkY+jmIt5yfV1lVlcyiSGVbiP43IRNEF/uMVLYf11z1YaESAzG6W6BKxryixU4u6SIsJDXrBSCrL1PB45XeI66oVhdxYtO+BbU2ToKRWYBizd8rpR5g5tdqvLsat9933VwzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A0yUGgDuI/CjHfvTkA2JllsC0uCXttOffgOjRVAIIs=;
 b=ec3QRysLEJduVqW0KDR+ODLuMUMmUaEkfFG9MQqdO+DF6MfeHqwTiREkMN1YYGGa1U1W7XzvGY89sOX5xVDUpcXvi01vSOIlnVsgqtzGBFU31WbW0g3Xf2+WJrCDrhY+Hr47Zg07R+i6nB2LTchHTzS1AbZkt2XeLHxS0/2Bklc+YIHqpZ+AaI0212A0uEvLa8P4yBzZOEVnAIhTCOVtK42IZKcafy5W6En7w30NXP/OBM9/pReZ8vdSOao7SMeociG0FfWUmgWvhKtJmc/eUbdUUx/22B3+eG/hWldSJFkWgbnDG1vjsROcDnRb0Q2sZe4z3bgNC8Lq8xR+PZSsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A0yUGgDuI/CjHfvTkA2JllsC0uCXttOffgOjRVAIIs=;
 b=eIoz/AMrC4scOpaIb99peX57ljgtk0CFymQ7G+IVFHHoWSQtxdX1CwDXCuq0Jsj8b/4bp/adCT5HSsbztyKXD52KZsL+sEaaubQ6scy7spbWpcXOCcd4K++ZxEmJHrchDfHfEsECjDnVPJo1COyIxbY4RUZ1HjGsRHjjuT281zY=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:15:04 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:15:04 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Topic: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioctl
Thread-Index: AQHdNlZEasFrRSCtJUKk2Fe8DhMNAbbDLZMAgBFmeus=
Date: Fri, 18 Sep 2026 15:15:04 +0000
Message-ID: <SA1PR12MB81444B3C0F81C0EEBF9F8614EF872@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260827185935.89623-1-David.Francis@amd.com>
 <20260827185935.89623-2-David.Francis@amd.com>
 <83884774-9ff7-41e9-8ea5-ea06675b6fe2@igalia.com>
In-Reply-To: <83884774-9ff7-41e9-8ea5-ea06675b6fe2@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-18T15:15:03.337Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|CH3PR12MB8307:EE_
x-ms-office365-filtering-correlation-id: fe13e69d-4386-47b7-47cb-08df15979dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003|38070700021|3023799007;
x-microsoft-antispam-message-info: tcSN2EMl/G8Mc09SSuTYexRuG9/5xsq/QG6hZKw9g16OqKmECrlYg9kd+Qt2dE8hmcqZ3j/xbZvwglmJa1AF1dS2nbbxZG8lia0yEKRmWkAo/rho6JBSduCU1PNAInr8XFtoxt2p5Fhj9qOuNyCMoHjz6NewiJgwXSqM2gkHe98FiQMlVHYxPUvRBYoVG6k0TJFSh8H0pD03VXIaiI/8nD6nM731Jma2k3zXw+RmtKKFDwN7NiI/GZOogCsmWupjO3Tjgws7SIVxJ9Pd58HLteaX46J04FHrO0ENmXWP2d1QqcAPd3r7dz4UDCA/hWKke+lInfaJOMtiDpsmd6H63dLbhp/RahDB42xZ2pLlR5UetC+e4M9fcmQWxYzaNAfKLej+tgLsTnbUln2hPR7hZAMnFAZWcXY3RCOxhMMc1PDQCWKp8sP7aWmgvb1jxRfxZP0DbEIAW6ELw8Hu9k1j5dxJJKgOCAAtasg4C8QA+NMVsx0kef4fNJtMqtw1+19iLng4KEr6V5gUMz6uk+OUMJzHWMTcYQPxws1P1ddxxBhyRVqBIOzqbTmf6UYgAYXYvaw9vWPuEQr0HIIP7rdQ2UwR7+aT9CnpioDpT346XXijjlu51dRl7SN4mFn9395owaw6wviiWBmdpFCbmyr4GlvT6gcce6qyMkQyI0vjaq1HLXdT0f2pR7c6P/e0Gp6ypZO2WJTDMnevQQ4FQqJB3pKS56WNi/qF9BiI4YjfnOQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2F9RNVXt9fj9i04Snk00rIpwRvJ2+4I0mT5qehEM+/3FX3hVm+nM/rXw+Uzc?=
 =?us-ascii?Q?KP/4U0KslD7uhtioAdn4jrBFvlLEBtaooMPTC0QafD9Z891KA+EG1bwk5+Fp?=
 =?us-ascii?Q?50zV4JPMp6gL1pdtJmnHduTXtcwh+qhZ65lTH+WCvY8YSt4TTIjbd+6i8wqv?=
 =?us-ascii?Q?K9wPxlJYHzclfs+MCjqbRtkVHAWpvNxkDBQztORrW3Cn85OqgzZSFGmq9Kro?=
 =?us-ascii?Q?l3yKmEGiLK9JAY7pgeAC//1ZhQvXo20MU11fBGDyv8JMCkfJNSacrvPgW7Mr?=
 =?us-ascii?Q?0sQVIJqnLgb44caDd1ZWkYTfAcp6/R5+o2KKB0cVoCnrvrD/Vc7Dr44hL1sU?=
 =?us-ascii?Q?BRtEi9AoFAtD3eSQO489pYBbsbGdCSIsHSHiRAa1u+e5wPVVyNcZiuPvLAvR?=
 =?us-ascii?Q?QMwUBOedGLDWMHh+/3Rjg4r6uac3nKTqpJ6mRRfprBq9zYe7l044FvmQ+Ak0?=
 =?us-ascii?Q?o/Xh17mBK/WUE3eY6Y3w9cWUPdfG+3vj7QxqMgPmDJCEAep7yoVzVqBCi87/?=
 =?us-ascii?Q?UoMx8Zg29ktjQNzdPQ9msdEWlpRmCenRGMsoz+SZYbaNFZPYkk4OezGPVhVh?=
 =?us-ascii?Q?VxYDGlJAqqUhBIOvDtBg7jxjvPomxcJ9Rm1QT7qBZWhGUd+MbE0UeTpEKwtZ?=
 =?us-ascii?Q?n79b2UHrK51Nqbny82dQ3xKfhWJfbnIxGeHOkGAbmwvvLQLQXX6OGtmk8Qxd?=
 =?us-ascii?Q?orQScKyAVe1uKuAmCCBrUsdPQ93hK+Hap/bXrRemqB/W5WY10VhsjmAlh5UO?=
 =?us-ascii?Q?ojxjL6WFmj+hJEcaRryfGZK2oUlPQ9fgvZKpeQyMzsedkx2bTj1Es1CKsr3X?=
 =?us-ascii?Q?IzmixLuwhhlOq2ZUYsVppbbc6QrjdK4ampT+97TVnXZz+Zt28uRYezdJurfs?=
 =?us-ascii?Q?Gy1Z+1Mc3PL0hdHSVVewTGc3VN3FvsSotX1udvnlOy7IwZujaOajLpLKFn9B?=
 =?us-ascii?Q?dPRfNYnPggEzZB4MmjcsnhJbGKJ8DoOi5YmxkeI60dZE1umjNTLnMOM57ysF?=
 =?us-ascii?Q?FI4neq9g8rmS4Owp+RhSh32fLMimP8Aj+v2n1r7gKW2wbi4pf9Rk25fykjzi?=
 =?us-ascii?Q?YVubni/dc0ABXE/pL/gkj0OKBA3t/K9c7HWKLY2Qonkpw1BMy8HtT0A0Eq6J?=
 =?us-ascii?Q?V5Oyp0uDTQ7QygwlZofdWe4yf4blDXSZ/SBtWDIRb+o0t0BFiPa8VI7d19nN?=
 =?us-ascii?Q?XcPUKZLl7PL3baDCKN0J9mpT5PKsDt9g3Aae867bqG2XcuDLANztwA6YySQt?=
 =?us-ascii?Q?HNLc3sbWARvfSpOT1oUDErKaZi8iCmKsHEMcSMimXwrRhFMDeOe/bb9pmm0r?=
 =?us-ascii?Q?snwgfx6ZMxcs9LWIjz1en2vLc8mHPhu+FdE5WkHzrtozqHPwEoU0GpQjDlkr?=
 =?us-ascii?Q?LZ8N4Lz7mJVVXUabYzxQ2lpiCeW5nWkIz5VlWi/A3ExWBTC0uILU8TxVgOiw?=
 =?us-ascii?Q?ZkFfXXZBX53TJg6p7cbJ8whJ49uXUOoH37xGOW6U6yMt6fD9fSdGFpWaokc+?=
 =?us-ascii?Q?3Gd7jr5F5MH/LvTJDpCWAqoi3ViY1FAjcVg0yPsSRFOa+CydKDXNYF+dTCJM?=
 =?us-ascii?Q?6w2xnfUZWPPPu9CKiW4xO5qpEVGseUl4xjWEDOU4giKJGSZzX3LVR7Y1iPAs?=
 =?us-ascii?Q?nAr33ckvUUEhz0NLPhhd/KzTf1SJ9o9wvFqFfBMjq9A2GE5mgxjqKOfDJ5KK?=
 =?us-ascii?Q?frKF9vlX6JKbq8CYErtNC/PS50n7YSdVX5yw02Pl7VNOH/1b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe13e69d-4386-47b7-47cb-08df15979dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:15:04.0240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWLKd6xHUkbpgjmSM7u9p/CWtZ5qg/EZwtiQ0bma+YE2v6PgrcTFpV6VFYHNsPZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

>
> Looks complicated. Have you looked at how I've done the rename with no
> external lock?

I may have entirely missed the xas_ interface. That does make things much e=
asier.

You have to admit the poison queue thing is clever though.

Will revise and simplify in next version

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Monday, September 7, 2026 9:31 AM
To: Francis, David; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] drm/amdgpu: Add CHANGE_ID option for USERQ ioct=
l


On 27/08/2026 19:59, David Francis wrote:
> Add a new option to the USERQ ioctl, which is called with
> the queue_id of an existing user queue and an unused queue_id,
> and changes that queue's id to the new value.
>
> Calling with an invalid new handle will fail. Calling with new_handle
> =3D handle will succeed if that queue exists but not do anything.
>
> A poison queue object is inserted at the old handle during the
> rekey to prevent concurrent FREE from destroying the queue or the
> old id being reused mid-operation.

Looks complicated. Have you looked at how I've done the rename with no
external lock?

https://lore.kernel.org/amd-gfx/20260806134712.91816-7-tvrtko.ursulin@igali=
a.com/

I'll have a read through your approach but I can't say I am a fan.

> Performing this operation on a queue with signals or waits
> outstanding is fine, as those hold not the queue_id but a
> direct reference to the queue object.
>
> v3: Poison queue and misc fixes
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 60 +++++++++++++++++++++++
>   include/uapi/drm/amdgpu_drm.h             | 17 +++++--
>   2 files changed, 74 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 32d1787aa7e2..699838042bda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -35,6 +35,8 @@
>   #include "amdgpu_userq_fence.h"
>   #include "amdgpu_trace.h"
>
> +struct amdgpu_usermode_queue poison_queue;
> +
>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>   {
>       int i;
> @@ -852,6 +854,11 @@ static int amdgpu_userq_input_args_validate(struct d=
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
> @@ -1010,6 +1017,51 @@ amdgpu_userq_list(struct drm_file *filp, union drm=
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
> +     if (args->change_in.new_queue_id =3D=3D args->change_in.queue_id) {
> +             if (xa_load(&uq_mgr->userq_xa, args->change_in.queue_id))
> +                     return 0;
> +             return -ENOENT;

Why is is important to allow users to query for existence of an id like
this ie. why wouldn't be be EINVAL if new =3D=3D old?

> +     }
> +
> +     /* Poison the old handle so it doesn't get freed or reused. */
> +     queue =3D xa_store(&uq_mgr->userq_xa, args->change_in.queue_id, &po=
ison_queue, GFP_KERNEL);

What if userspace is silly and looks up this handle from a racing
thread? It gets the poison queue and things explode?

> +     if (!queue) {
> +             xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +             return -ENOENT;
> +     }
> +     if (queue =3D=3D &poison_queue)
> +             return -EINVAL;

Why is this EINVAL? Userspace races with itself I get it, but I think it
shows the weakness of the poison entry multi-stage approach.

> +
> +     ret =3D xa_insert(&uq_mgr->userq_xa, args->change_in.new_queue_id, =
queue, GFP_KERNEL);
> +     if (ret =3D=3D -EBUSY) {
> +             queue =3D xa_store(&uq_mgr->userq_xa, args->change_in.queue=
_id, queue, GFP_KERNEL);
> +             if (queue !=3D &poison_queue) {
> +                     drm_err_once(adev_to_drm(uq_mgr->adev),
> +                                  "Expected poison queue to remain untou=
ched during userqueue change id");

Do you expect drm_err to be reachable by silly userspace or just
unexpected internal error?

> +                     return -EINVAL;
> +             }
> +     }
> +     if (ret =3D=3D -ENOMEM)
> +             return -ENOMEM;

Is there another possibily from xa_insert other than EBUSY and ENOMEM?

> +
> +     /* remove the poison */
> +     queue =3D xa_erase(&uq_mgr->userq_xa, args->change_in.queue_id);
> +     if (queue !=3D &poison_queue) {
> +             drm_err_once(adev_to_drm(uq_mgr->adev),
> +                          "Expected poison queue to remain untouched dur=
ing userqueue change id");

Same question as the previous drm_err_once.

Sorry I don't like this at all. I would much rather you try to punch a
hole in my approach or confirm it works fine.

I adapted that from some existing driver.. can't remember which now
after more than a month. But the approach sounds sane to me - do the
rename atomically under the lock using GFP_NOWAIT first and if that
fails drop the lock to pre-allocate space and retry.

Regards,

Tvrtko

> +             return -EINVAL;
> +     }
> +
> +     return 0;
> +}
> +
>   bool amdgpu_userq_enabled(struct drm_device *dev)
>   {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
> @@ -1046,6 +1098,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d *data,
>
>       case AMDGPU_USERQ_OP_FREE:
>               xa_lock(&fpriv->userq_mgr.userq_xa);
> +             queue =3D xa_load(&fpriv->userq_mgr.userq_xa, args->in.queu=
e_id);
> +             if (queue =3D=3D &poison_queue) {
> +                     xa_unlock(&fpriv->userq_mgr.userq_xa);
> +                     return -EINVAL;
> +             }
>               queue =3D __xa_erase(&fpriv->userq_mgr.userq_xa, args->in.q=
ueue_id);
>               xa_unlock(&fpriv->userq_mgr.userq_xa);
>               if (!queue)
> @@ -1056,6 +1113,9 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void=
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
> index 92738d630eea..37d0efd1eda4 100644
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
> @@ -464,10 +465,20 @@ struct drm_amdgpu_userq_list_in_out {
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

