Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3278EEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 22:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B46B10E3C6;
	Tue, 18 Jul 2023 22:13:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA5710E3C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 22:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0MSZGFZiqvjfSQtijYcT5DlLB0G1rZA4Coonx64ofO8fVRwh6UbqRfOKwzObPweYjjC5vzPPxflPZtsvlXIFhUVueXB/oqrNgvVQSQRb5edBB32dyEB4c3hK4TX3qsnxaulv4/gCu0Jv3CZzVceNn0BcCz/XftiLlXa4WiN5siTeDjSlxZyeA6nKjO+GClFhmTiEZQgi5mgPOL67C0g4gle04vQMzt4QjIpYiJTk2Xu/d8bcgf4f0be1/IHVMyyu3DKkGjQZDOuhjSnTOiuD9l7bXSF1yxsfcDGCjFbbuknGEIy5WWLmKJqYC6gYoaFdZ8rL8ay++cjnDaUrsrxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcSGShcKI3fUtykd0HAQEMOx1Cyxe7ZdIqaNnwPj9BI=;
 b=lGLKDUGro51yzwFlEJJTyxzze2kgF4DKYZ23s33hBZtIwi7Sb8vAWMrLQzSL0xqgJdKbo8XMBwIWIkrDBakRAkrsv8yvWHeSwhCXSL2vX2HJxYsEnatAPYbEIojnuu1mXSMJDY1y/fbNRd3WSwIeUQYmiIeRPHaB28PWSpZTL+SF4J9/8r+7lFnUJJ8QTbIAKZSMJZO+GSGHRGOQfGcqhVJbbw8LyXBN2nnxMy80R+G1qMOBYHagK/oYq+DTiYoQmnlrGRM8O2ffGqujIgJFJMXAM2mY3eHNhfZ8W9vGu/D7Fj9AdC94zDcNrXEUxmAn+b7nfinE6vABX+fjK/3hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcSGShcKI3fUtykd0HAQEMOx1Cyxe7ZdIqaNnwPj9BI=;
 b=ISSq3E9gJ+Dfd3/6u1Bp50PYHaOzcLpQr9Q3EEHfPXKegdXySNZW5fySejVAwnZFIfuKduxZWtzX5RAKxhWY9IibEKb1y5sJtRzherxf64YfmBTcgi7kigcxuGeStMg4J768Z3XQ1Xvo5L4EVAwNc8mW6sNA8VUWH0gwtNiGoJA=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 22:13:23 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6609.022; Tue, 18 Jul 2023
 22:13:23 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
 debugging
Thread-Topic: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
 debugging
Thread-Index: AQHZtjbqKCyr8x/sekCgf7zBfMN9z6/AHUdg
Date: Tue, 18 Jul 2023 22:13:23 +0000
Message-ID: <CY8PR12MB7435545C23B4B3E5BA2EF8EA8538A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230714093759.3246343-1-jonathan.kim@amd.com>
In-Reply-To: <20230714093759.3246343-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=67e6bc7e-655a-4d1d-8c7c-dea5ce95b55b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-18T22:13:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MN0PR12MB5860:EE_
x-ms-office365-filtering-correlation-id: f02b3ae4-33e6-48b7-6bd4-08db87dc33b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nwV0zyIodSeoJal3fraNv7tskQ+2P5iP5NjIJo3kiUqqof+hn+P/PxecxV6a/RVFiWt1Xn9rYz4afjwKHEiF9Bnr8iYjoQcG96J0a8ZBmtCycrwXFSiw4VeGfD85eCS0mauISNLb4GWwEo5bAJObqFTuEDJ8VRh+4y0g4uIYt/iXlu5Bznqw2L3f5j3Ca0Qp4qc0BQkptNBYbVa8tk7TOS085g/OfjNv0LUFYawy2B7Sv8s6b1xU2uoOxEi3Xvpe1iBk49KmsAzs/9YGAOYimNZQQgCCb8SaApn3HskAt74hAKuzlABiqMq4lt0vZvdxRNzmZ2xapkFNlAZOxmRKkP6KFBWXX1YKz2RFfturOyWrVLs+2C+pgom7jezkIPvc2H4vDqdazauyj6A1/N9+uQCvA7EczaOlQxl0uW/N58Zm2hY8Kaj33CsU/Jx2514z8yAaT0e98gtk5LL+16KiR7uxqVBag+th3HOnrWyzmVVzDXTfTiLX5wieI1xTKebKhtSro7EzES6hVY+vivY2heB0YSDwrxoPZeA6b2D4yDS7bgcAapOn9ssPrgCmLSBj2CpKRdf9EEh1RQiSjc4Vp1x2Lu/dt+j1hSlZ50Gwh+m/ArnQkuxHov1OFLkaUYSZSdtIhmHeyWMf3rPrtFdDjQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(33656002)(86362001)(38070700005)(55016003)(7696005)(478600001)(54906003)(38100700002)(122000001)(71200400001)(83380400001)(186003)(53546011)(9686003)(6506007)(4326008)(52536014)(5660300002)(8676002)(8936002)(2906002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(316002)(41300700001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGFYnV0tlyfNwvlkUTgJBRZFWLpXcsE2IcReP8OX/vKb5oRpOqkd/mPPOo7m?=
 =?us-ascii?Q?Bh70OoLri9ebCRIXP2/k3qld9igEQvVsMujvAeH7Y8APKnD/6M98xIyk4L2v?=
 =?us-ascii?Q?IXRpC4ursZaApR4NtvhHj2tLR5IX6Iddfzd+tD9ua8iH/PpzlqjSH116HXbL?=
 =?us-ascii?Q?EdL8Y7/bjg8X696tyCWdN8LvDILdWJfSlrS/pCoHJ76RvkIT+E43tgdjjG8S?=
 =?us-ascii?Q?U4WiWZntXIkKJre1LBHaYjWi3Wf4vPs+d27FDw4N9YKiTRt8hc8TO+xI44H7?=
 =?us-ascii?Q?nXsKpOIgEdbIaZWxZEoJ6eLNxGtHu3ICI+Yg0/FqbVImENiHdiOL9n0Ir9HC?=
 =?us-ascii?Q?AnhS2aoEtGiyPvXUy58w1nJQfn0X14+VImCW/HJMhiHG59WcrnvJamNh2c98?=
 =?us-ascii?Q?nIANCS27s4JbCyIs6oqZHyl2Pq1esBzdxGItS4jKy0p0M5EGW/jFS7C4evLs?=
 =?us-ascii?Q?qNKulhIdf5tsoP/VNEW/9cyWf7P4TMuBZg7hAToL2Ea3RHajaGAR1dF7pQqc?=
 =?us-ascii?Q?niSZwCcOTW8eVpahZ7Am4El0BhP9lNyJoMZGW8FcKrpLCvYqGgmaZyvaf+vy?=
 =?us-ascii?Q?kDDWtAaM+D3IN4Q2HeuQB0HqHN4Xf+KXDJbDIojf+wVrO1UguYwTe6OuosyI?=
 =?us-ascii?Q?ObsotmBSrVxVCutIVCbqb+bnObzFpub5BePSCVOPg87UjL60H0Re1gkR9gJZ?=
 =?us-ascii?Q?0eTjB0qvJNlXUwWno7TOz1WEyqMKDdUGsVXhUsV46i5cxOJU1EQ/iAiiRzNe?=
 =?us-ascii?Q?tYiaVffY5EZDvNJHzgmde8BFyiPbvhK1QVa0fQh+M6A69wcU/EEnZsFqrNSx?=
 =?us-ascii?Q?zetVG1Q12bWdBLM5mrPIl485r0Q5cicC/mGZqWOxTzl1h6snFLVwTwrO6KTi?=
 =?us-ascii?Q?TItc70Kd++4J20d9ZIPxwqmub8Fy1PhUPJscbU8wDepss1M7KyEhhCh4Smxh?=
 =?us-ascii?Q?wccqnoAYfB9RAh7+jisLDmWC4PPiP4YGng04MxYW1kP57i+2YhzxWItykttC?=
 =?us-ascii?Q?8G6BCp6Mafb/27dI4Gr6IiUUE+jsT86bRRN5vsQa9K3O2nIlMXlgJ3bfUusk?=
 =?us-ascii?Q?WpAybHsZOT58CU8FrRNHcq2j3SmjrJByzdPOzmk7qWQ+CxzXmAhO77AUgaeI?=
 =?us-ascii?Q?zbONG+JsAqbZzctk3CGll5lzYc3dimqpw0DjlTxyiAMTc+Zhsjmnic4PUpKZ?=
 =?us-ascii?Q?O+gFfd6BRV2i3N8DiDBTB9SEZ/yhx0l3dscF/A8fEkEBDJbRTZai1jBqHlhp?=
 =?us-ascii?Q?4LPWIeL+JpHyLj/MstKhwfSEM8o+KOr27QzGQr8Y3EBpo5AH3k+IzOHnXLAh?=
 =?us-ascii?Q?wuNh3Rpfo9qVaINgKwEC9tvpiX0sZWI65PJbCmV1HplDMlFF0Yd7nqQposB4?=
 =?us-ascii?Q?+fjeQB46UlNCn43OdSN7vRV2IA8PvlEDHG0mqq/jos6L3u/XS6LTE0ATZgE3?=
 =?us-ascii?Q?xH0gf0wBPDrd73DZewe0EvckEXhGPnsQ4DVmhNMGbjchZ+IKCznYAhqYvtfL?=
 =?us-ascii?Q?GS72ti/+W6DNPW2LNFWtAu1jNwKKyxiKfYOEJ1JX75t3SJZWf2naFsj6Lt20?=
 =?us-ascii?Q?yzDrlwXYliZm1qO7l8YaAeSEtRKjs7DSjB6EWn20lLzAvQyVHgmC7FBm4Xd/?=
 =?us-ascii?Q?smI19jvPuDCaqSwzbOIt0qg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02b3ae4-33e6-48b7-6bd4-08db87dc33b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 22:13:23.2328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BzjRylvznxUyLScfDNc9uHcgBCVJtx/bYrelsLq7pllCPjEmf9ukfuB561B+uqo+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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
Cc: "Ji, Ruili" <Ruili.Ji@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+ Ruiji Li as this is a follow up to

commit 52223c7e74d124bea47beec467e59fdfc77559fc
Author: Ruili Ji <ruiliji2@amd.com>
Date:   Tue Jun 6 14:06:01 2023 +0800

    drm/amdkfd: To enable traps for GC_11_0_4 and up

    Flag trap_en should be enabled for trap handler.

    Signed-off-by: Ruili Ji <ruiliji2@amd.com>
    Signed-off-by: Aaron Liu <aaron.liu@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

To ensure debugger is consistent with other checks.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, July 14, 2023 5:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
> debugging
>
> Update the list of devices that require the cwsr trap handling
> workaround for debugging use cases.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c                | 5 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.h                | 6 ++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++----
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 190b03efe5ff..ccfc81f085ce 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -302,8 +302,7 @@ static int kfd_dbg_set_queue_workaround(struct
> queue *q, bool enable)
>       if (!q)
>               return 0;
>
> -     if (KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
> -         KFD_GC_VERSION(q->device) >=3D IP_VERSION(12, 0, 0))
> +     if (!kfd_dbg_has_cwsr_workaround(q->device))
>               return 0;
>
>       if (enable && q->properties.is_user_cu_masked)
> @@ -349,7 +348,7 @@ int kfd_dbg_set_mes_debug_mode(struct
> kfd_process_device *pdd)
>  {
>       uint32_t spi_dbg_cntl =3D pdd->spi_dbg_override | pdd-
> >spi_dbg_launch_mode;
>       uint32_t flags =3D pdd->process->dbg_flags;
> -     bool sq_trap_en =3D !!spi_dbg_cntl;
> +     bool sq_trap_en =3D !!spi_dbg_cntl ||
> !kfd_dbg_has_cwsr_workaround(pdd->dev);
>
>       if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>               return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index ba616ed17dee..586d7f886712 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -101,6 +101,12 @@ static inline bool
> kfd_dbg_is_rlc_restore_supported(struct kfd_node *dev)
>                KFD_GC_VERSION(dev) =3D=3D IP_VERSION(10, 1, 1));
>  }
>
> +static inline bool kfd_dbg_has_cwsr_workaround(struct kfd_node *dev)
> +{
> +     return KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0) &&
> +            KFD_GC_VERSION(dev) <=3D IP_VERSION(11, 0, 3);
> +}
> +
>  static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)
>  {
>       if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 0, 1)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 31cac1fd0d58..761963ad6154 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -226,8 +226,7 @@ static int add_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
>       queue_input.paging =3D false;
>       queue_input.tba_addr =3D qpd->tba_addr;
>       queue_input.tma_addr =3D qpd->tma_addr;
> -     queue_input.trap_en =3D KFD_GC_VERSION(q->device) <
> IP_VERSION(11, 0, 0) ||
> -                           KFD_GC_VERSION(q->device) > IP_VERSION(11, 0,
> 3);
> +     queue_input.trap_en =3D !kfd_dbg_has_cwsr_workaround(q->device);
>       queue_input.skip_process_ctx_clear =3D qpd->pqm->process-
> >debug_trap_enabled;
>
>       queue_type =3D convert_to_mes_queue_type(q->properties.type);
> @@ -1827,8 +1826,7 @@ static int create_queue_cpsch(struct
> device_queue_manager *dqm, struct queue *q,
>        */
>       q->properties.is_evicted =3D !!qpd->evicted;
>       q->properties.is_dbg_wa =3D qpd->pqm->process-
> >debug_trap_enabled &&
> -                     KFD_GC_VERSION(q->device) >=3D IP_VERSION(11, 0, 0)
> &&
> -                     KFD_GC_VERSION(q->device) <=3D IP_VERSION(11, 0, 3)=
;
> +                               kfd_dbg_has_cwsr_workaround(q->device);
>
>       if (qd)
>               mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q-
> >mqd_mem_obj, &q->gart_mqd_addr,
> --
> 2.25.1

