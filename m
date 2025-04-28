Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A7C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B0710E4EF;
	Mon, 28 Apr 2025 13:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mIINtkmO";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A95B10E4EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3UE6mOHqWZhC+UfKQ5KMEhwrvkELw4lYPJTdnFG+1AjxAWzUKBJ9zXf8MFncTT2JriKV/H7WuHlQ6wyxhjeTkuH2J/1hxm19ECiyjG2HENCXNSypKak9lDaq6SzLn1YeqI2ePI4yJ15GnREKrg2XArhQcTYDW8NYRCrNZAHpmlEGDYKj+yfu+b4XKuYVJFIaHcIgcI7baoaN3Uwhh5qptBvhhT8R9R6e03FJiZDGTXAm4A5XtLRpJ+tpSypj06jr9OY/CVWPxZuFgUWeknNbrvMl8C7B/p1pq1JSuXvtjH2cYcKa9ZSfAHYheNZXxRfibuMm8TFreFkx9P1m/b75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ/RdHhnGaHU0+qkI6nqnunNbZC1sQD/m/Ou8I6c5Jg=;
 b=e1tOQLrmrnjoRCs4FgKh4DdoasIlMqCaLCvUTBecq445mZCClq17Jxy2ppv2Bxhw27ClNIlDajnWWwkCHYNWL3YyTRzqpU954ARYEOCsjXNWRNr+q88YZQox+NuZQYQJt/WyE40mN/Xt55FiY3PyD01LRFwY48x8WEsJjl2lqBSydaWE3/xr9+rDAJXw9kb9S8YZNkFgIWwAQovXc3Hc5fPIoxjPGWx5nX5xzky2YnjOrDWldYM7O+BTu+tjTspPy61n1sFaQARqPLS9o8Ph7OhN7tsOtDKBo9pOCuEnxKBFlrCeaiMZZ1aBTvLAhNh8FOtMiXXJdefnMDgnYlhg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ/RdHhnGaHU0+qkI6nqnunNbZC1sQD/m/Ou8I6c5Jg=;
 b=mIINtkmOsDVZ7RHSGn8bUfN/lc0rAYxa7OfNFSsg/vQ/2jDczFqVTszVU7sxB7+XTuQZn9Pcawf0l5iXoQbhFAD+A80Sm6ZEj1AhkFatJJRTu+JLtvETyNUjMywlQdWBPbNd2I4z0V3gkLjvomSMYgWJWoSeRA8viYxdZ6IAe+8=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:38:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 13:38:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
Thread-Topic: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
Thread-Index: AQHbthG59EHLOPmNkkuSJjIjleDISbO5Fjow
Date: Mon, 28 Apr 2025 13:38:06 +0000
Message-ID: <DS7PR12MB6005E321909AC190237A3C42FB812@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250425184125.166270-1-alexander.deucher@amd.com>
 <20250425184125.166270-8-alexander.deucher@amd.com>
In-Reply-To: <20250425184125.166270-8-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a1be4ebd-e0ac-44fe-81d9-81d634e3eac3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-28T13:30:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8312:EE_
x-ms-office365-filtering-correlation-id: f7cb26ef-68ca-4915-ae77-08dd8659e81d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A00dQqcHcycFb19KpNuJJJ69iplgS6AY1BUyvMQlu/rYvQkCGfqwAQdKsdJk?=
 =?us-ascii?Q?yfRhhc1P7EJe1VYv1YNNtzVq4Cw1cqklpr6TGj1KKxqJsoubryoq1KlZG+w3?=
 =?us-ascii?Q?teE3Dbsnuo1vVeeQTknFemx9aLq7/CekVzbuCogRwnVU8ovCcgKIntDtaOXS?=
 =?us-ascii?Q?dFoJx4EkSft5oZWtQ6BNGIyV5qcxhf/KPGhngubqjChoBAg0jMNflvIozR6j?=
 =?us-ascii?Q?R0GBntoX5NloeZe+oJQxpARaJXtIZyYk1J0Y/eqa1IUaRNILQRAasn67WUAN?=
 =?us-ascii?Q?6ll+qs1grvztDVP55EKHRPiNqWNTW2EwSKz4Srkp5sgI4iRiO1Cpi2Xgopf2?=
 =?us-ascii?Q?wHgRi4h6SGq0/1lTSHfxksfe2jTfbucGaJ0GkAchkZmtP7PsVNqeeqMsx0Td?=
 =?us-ascii?Q?6i+T6v7xla8G9T7k7WQDzMr2+3u33hXVyXowqI4hF5/cJXTmi1OgV2pnULxv?=
 =?us-ascii?Q?G2E03vSOlV/ou7x5aGun80Wh4Bo27XzLlIN5jyf5oEzfK8arlKh1y7dq2gKR?=
 =?us-ascii?Q?xUnVx5aKcsEcM0wUdZyyyNgfSH30btzKu9OVMH0WNJnhCz0aV0SRCi0+9IE1?=
 =?us-ascii?Q?Md7kzih5aMaPzySOHS0GuoF6RbMKO1SsD9YykORsi11TyigEJJn22TQ35ZOx?=
 =?us-ascii?Q?IdiDzwiHxuQU9Ub7cxA4vrjNyaA39iMOhAdvm2tS9CcWVfoISEtGiPYW3jPe?=
 =?us-ascii?Q?WwQptRDeuL9BqdpPnzWgcjeEFpq7qWvQq42BgQxSpZQ7+4KeSkBf5jx8pPgb?=
 =?us-ascii?Q?1O/vD2CklWKwCJdm9uC/67+NC/dOfPZ0sLZtR7mlhpC7zAkVnJC5mJYwMlRw?=
 =?us-ascii?Q?UpcJxhospx7fcwkhLzNJs/GV0XccybQkT2jDltCmXBFC8F0O9K6rGfuiCd4X?=
 =?us-ascii?Q?BGgTDTflm1GBPPssWvC9Gito6ny9g/XR5vd1DqxhFALxtaS8t6mYuU3/xFqu?=
 =?us-ascii?Q?Guqk64s5D6j39hxc+ceDTb78RgZfCzINdbtlBEM/Pj/8B6t82x4GEj9MqUUN?=
 =?us-ascii?Q?MyoZvW0jZf4A3n/qtfqIcY3JxV4N0749DWOfuq3RKA8c+8AIsM4mmWQ6QTXx?=
 =?us-ascii?Q?8MDDDoQZx2/JExKEH4bwNkMN4LMlXkxOpKGP78pQplvO88lRRJyq74usXFAl?=
 =?us-ascii?Q?wCvL4hcqo+eVEFYykOLqno8ADSueWQyUBDq1NObdvZ3GdoYAQYNPsSknRMJq?=
 =?us-ascii?Q?7td5qvzoR6zMA15ptL4yI2/5FbxXcZEJtS0xc0k1U8FRMlR+/EwhhZynod72?=
 =?us-ascii?Q?A8j/D44R7ar6b6eGJeAAnnIAsOc176nqGvZ9SRzcLga7ApgMUn0gwx9ejXgK?=
 =?us-ascii?Q?/eYpicLUcMIJPWRwXJG9hzo7sP6epeHEOyFekRGAoCvvOUCnWLSsWacyOGAl?=
 =?us-ascii?Q?OBlycLW1eF0lPKZA1uZj+X6S7rTNQDJBNXWwkyV1DYDhoeG8XCLoSgz62ell?=
 =?us-ascii?Q?HGVPHcmeTvxNnLtxMfO7BqusigDF9sTiuoXIN/oI0G+PQ31eBuIxbw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8d841HUZFt07dpxLoaYWhyaxTi74/0pik376onjsKjK8NPPaXV+7ZLlgCwmi?=
 =?us-ascii?Q?2P8MEtoZlR0O7f9/tGrQPUbVku+A1UC8/Xi09zhq0uIxhd97kqTY2cA95XTK?=
 =?us-ascii?Q?wapS4KImp0H7yDQGrOmjKfM3Fk4BLkGKrOyW3VSwbLDmg1zrTE1ije9RM0i2?=
 =?us-ascii?Q?zvxxGkQAA2vWB2Q2eS+zIv6v1RAvA9/LprC9k+Z3IIxzbAIXQWoR7L1sny2p?=
 =?us-ascii?Q?U8O8e/O0oKa4OGJQ5gb89cfo3V+mPOy2Oph9TjbyJYYPvpg+HFqiuE2f6LGA?=
 =?us-ascii?Q?PtQAqlCl6/9eN6yEaQX/exTuPIsbIhqTLFLHakdR3fu4j60vVsP+pyogTu3e?=
 =?us-ascii?Q?xHY9djaHJ0psTwkB4jj+DCZoakHOZVlqVaoqZbX6wH9BcqCNA9ncmN1zwnD3?=
 =?us-ascii?Q?V6JEgOiuxftLwJEMDWI6YDa7XURgvya/g2S4zXMGIEwLFCH8CXXyVzM2YjYz?=
 =?us-ascii?Q?IEnoGQ6G+v5BS8TOLTUWIyuhn+kbCn34DALtWeQRWjP34zMI3btUls6YVmJj?=
 =?us-ascii?Q?j9aynbU3YykyIa4wCpAI1WmukVu24sxxqgNzQm3RTQEgdn9SL+7tcUx7qypM?=
 =?us-ascii?Q?nBgkgvG4b1LMSSS9po5AJ/LRSeY3LBk0SuEktHe2uSgKYSsHZSLoqq+uD5Qj?=
 =?us-ascii?Q?IAvsN6vlIYd+3gi6LE1HMqgd4/RLQMxnAuagvHOJmeOlG3vaQThHtclgV/+a?=
 =?us-ascii?Q?WmFKufzdgeaH06VbC+esyseHmuJSkEPX8uWs4Ol2rsNhUeLjxkar3LHYza1S?=
 =?us-ascii?Q?+ap6CyVUr4HGZrnda40Vw9Xkt0Mis5QB69VJvUFgsGlKB/WYhiWvkI/j/Sep?=
 =?us-ascii?Q?h5efWDrX4PkQR4DyCZdraqOceD0NaIj0S1FRy0RwXLwV771UyECosfkxnHgz?=
 =?us-ascii?Q?s+EwvZJdAnmkBL/uW29huT7C2eb3+05zA0P+QDDV4lQ/2Vj74IJ45WFMRE6a?=
 =?us-ascii?Q?EpaXf0J6lSP7s0koHSsrlyZqNc84JmxNqQWzHRWiMuXWDkO8M7SiQrZuHRx/?=
 =?us-ascii?Q?R2CxCA2ZKujqZjdiBQ4aHzPsT2l2Fs2cJxnHuZZkUvyEFsrJLqgOY2cVqIrD?=
 =?us-ascii?Q?02JCUs+ky3RKa9hq0NzOMHUR5n41r1vF/go1vuRc8EBmWxHP7Q+EvcT2zIby?=
 =?us-ascii?Q?jclnE4f0vSJIi52KAsbsJhqdBt1d2rbLuuQqvqPDv+i1NevfwUr6pDOzslTi?=
 =?us-ascii?Q?1yIZ3FPxNMWg3rsYoqzeAKBczxmXNIvKD+Qj8tLmm8JvaVfX5aa6+VoodyFY?=
 =?us-ascii?Q?nbkCxj9YgLsgiIWgIYBkWELpbBBTKdoNSFy6Ocy2zBgY4mdzoRJLQcAE6tgm?=
 =?us-ascii?Q?mNUnVW1qMtqoT5wFVFjzlm9kCNmZR0tZ9a705MyQoQbJ7LIpBgwUHrS7ectE?=
 =?us-ascii?Q?enzFR0QioSG1wYEdoYK7nbKfvLDrLTA+hz0JfNm9f7ATpcQ8uS2Pngmk27z/?=
 =?us-ascii?Q?D7t00WIIb8zC3ibCC15YCFUGHf0w44kpKmEnt7GEQBH8dKXt0cs019HveqCu?=
 =?us-ascii?Q?tx2vmGTK3t33N6B760xU6fs9cz2mt6wLbVYlgZIhPT0JFjjvPk9gQC7VtX6A?=
 =?us-ascii?Q?xNaFWEOg+LWpE4OgI3A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cb26ef-68ca-4915-ae77-08dd8659e81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 13:38:06.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDTeinpt85WmU+tBupAyx9fHNb3NJBNp6uGoeTP9KHxIoaeEYsmGQDQMS0lQpiw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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

Except for the patch4, 5, and the other patches set is Reviewed-by: Prike L=
iang <Prike.Liang@amd.com>
Question:
1) I don't find the user queue gang submission code in the mesa, could you =
point out where is the flight mesa counterpart code for supporting user que=
ue gang submission?
2) Do we plan to support user queue gang priority set and change support in=
 the further?

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Saturday, April 26, 2025 2:41 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 8/8] drm/amdgpu/userq: enable support for creating gangs
>
> Gangs are sets of userqs that schedule together.  You specify the primary=
 and
> secondary queues and the scheduler will make sure they always run at the =
same
> time.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 52
> +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e56fae10400db..95e1495d9a24c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -561,6 +561,51 @@ amdgpu_userq_query_status(struct drm_file *filp, uni=
on
> drm_amdgpu_userq *args)
>       return 0;
>  }
>
> +static int
> +amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq
> +*args) {
> +     struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
> +     struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +     struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +     const struct amdgpu_userq_funcs *userq_funcs;
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     int primary_queue_id =3D args->in_cg.primary_queue_id;
> +     int secondary_queue_id =3D args->in_cg.secondary_queue_id;
> +     int r;
> +
> +     mutex_lock(&uq_mgr->userq_mutex);
> +     primary_queue =3D amdgpu_userq_find(uq_mgr, primary_queue_id);
> +     if (!primary_queue) {
> +             dev_err(adev->dev, "Invalid gang primary queue id\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +     if ((primary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> +         (primary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)) {
> +             dev_err(adev->dev, "Invalid gang primary queue type\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +     secondary_queue =3D amdgpu_userq_find(uq_mgr, secondary_queue_id);
> +     if (!secondary_queue) {
> +             dev_err(adev->dev, "Invalid gang secondary queue id\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +     if ((secondary_queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
> +         (secondary_queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)) {
> +             dev_err(adev->dev, "Invalid gang secondary queue type\n");
> +             mutex_unlock(&uq_mgr->userq_mutex);
> +             return -EINVAL;
> +     }
> +
> +     userq_funcs =3D adev->userq_funcs[primary_queue->queue_type];
> +     r =3D userq_funcs->set_gang(uq_mgr, primary_queue, secondary_queue)=
;
> +     mutex_unlock(&uq_mgr->userq_mutex);
> +
> +     return r;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                      struct drm_file *filp)
>  {
> @@ -611,6 +656,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void
> *data,
>               if (r)
>                       DRM_ERROR("Failed to query usermode queue status\n"=
);
>               break;
> +     case AMDGPU_USERQ_OP_CREATE_GANG:
> +             if (args->in_cg.pad)
> +                     return -EINVAL;
> +             r =3D amdgpu_userq_create_gang(filp, args);
> +             if (r)
> +                     DRM_ERROR("Failed to create usermode queue gang\n")=
;
> +             break;
>       default:
>               DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n",
> args->in.op);
>               return -EINVAL;
> --
> 2.49.0

