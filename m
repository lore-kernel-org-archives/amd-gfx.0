Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAAFEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 01:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C1C10E3ED;
	Wed, 19 Jul 2023 01:51:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D3F10E3ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 01:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Urc/yQEfpcUnAAZKe50guNxla1N7tNUNlGLepf3Sns2T1PxeiPp830PeSgIT/2YE6gh1VZa3P2OkfyeWzsxoGoGG/pnnuihAv+VBGEiUDtF8O60y4rj6/tcr/6SwpWyXtLefEMj/6Av4NquPLbFG06BHXcusfYorpqR7DfwvWbyVQ+vSicJV5qUNyZwj8svrNCPhlh1rsLPyDK0IjqTv0eSCVMd4NYhEassnVpYkPGE56NQNOdl/99eobprzuWpeYV/P+siECfu3CKd146H5sz+haGZlosUrBcMZHR6iMctb7LOiSBibpXVM2SkCc+YSB11fBp5fDFa6YYOgb0Xfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdfvqy8/n6HsZcDbuC9F9GTHDGUx2W/jurSo+Kf7WU4=;
 b=d7RMTZI1fyL0j7Rw1rnAyr7cdp25y4IepZVf4/jjQXz7VQUE8pzrGDU7iFYaQ1PRFIQxFfpk8tVBFX4ENCEcLy7sLber3AISLPyyZwMLs2TDQLnylP/ND5x4SFYjJt21E+I7btLfjghv9k9dx61BWT2QuUMWmPc/owbepPVeeQVRFqYODvWev/ul0ipTvGn9vcABreJbgULqjZGFfZU/UT+s7rlIQE0LCXv3uhCD/QjuYSKr5UL2sa/1drunUJxbLhAtwiwIUG4IfGAiFCQrFtCU2hS9XOPa+I092p/ewWMMsM5ti3YDwGIKXc369GsTtInf/bVTntsjy2T6TypvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdfvqy8/n6HsZcDbuC9F9GTHDGUx2W/jurSo+Kf7WU4=;
 b=ofRV1LiyIjkx+zG+7lWL4kzq4G/Th76JWoxehTh6ZGQiBnQZcAiExsdTgV3rM/PWtRRTV6tE7wgT2SYfHlEu6BF5jPpn0dz3cMW7Myea+JmfPOkXxOUDQyWmznz2SuPBDLrSFS0E9mEW/ExJqrjLTsXMN/Nx2fDFj4fzifbcwVM=
Received: from BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 01:51:19 +0000
Received: from BL1PR12MB5993.namprd12.prod.outlook.com
 ([fe80::378:7bca:9cdf:803c]) by BL1PR12MB5993.namprd12.prod.outlook.com
 ([fe80::378:7bca:9cdf:803c%4]) with mapi id 15.20.6565.028; Wed, 19 Jul 2023
 01:51:19 +0000
From: "Ji, Ruili" <Ruili.Ji@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
 debugging
Thread-Topic: [PATCH 1/2] drm/amdkfd: fix trap handling work around for
 debugging
Thread-Index: AQHZtjbqKCyr8x/sekCgf7zBfMN9z6/AHUdggAA8Y6A=
Date: Wed, 19 Jul 2023 01:51:19 +0000
Message-ID: <BL1PR12MB5993D26667923B2E3814EA9F9B39A@BL1PR12MB5993.namprd12.prod.outlook.com>
References: <20230714093759.3246343-1-jonathan.kim@amd.com>
 <CY8PR12MB7435545C23B4B3E5BA2EF8EA8538A@CY8PR12MB7435.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7435545C23B4B3E5BA2EF8EA8538A@CY8PR12MB7435.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL1PR12MB5993:EE_|SJ2PR12MB8874:EE_
x-ms-office365-filtering-correlation-id: c70098be-7ba0-4cf9-ce36-08db87faa59f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OP0U4S3/dsgThk9yV32UHdst2ibOXNhh7PZSOJIu8ZfpWHCm98W7k1z0iuy0HdM9beyauw+vgvIvqzieh8QO23CHairflTpVYkpkF63sHrQBZDhJe2gisv+LWQb7JyCWx4pg5EKUnSYQd8qRi7dL//rVArxMYV6yIfDzHMPouudTW8gpu6TAJhKAZD9eY5tpL6pxbA6nNgH20cwHNJ3WoJFErzq9//2gNkh2Ip288epVaZ2l61C2gko9l8uTDsARC72B/ZD1RXNnk6QKIO90Tv4sybbbW6DR+bwKwnoMgBRIiwQVIhiJffed3OAsQ1japza1iBJaOA4jrMdWXcrMuwDnQOOtynACNZUoOc2AlTm/SkSyC7ht6Sze02S0RcI7MrJ0EQGKW37oXqwHzkZ+DYsVGK11AO3F4kJ42/W9NrudFBOLe3pYTSh9m4OqjuxvUQRR6336movjQBN58V+ReS7erjdivR8g+/iJ5gJlM6q5GOjt+rPMKH8ft+KDSAhLD01BQ4Fa/cUgioeBJlseTofYl1zwdPfnwghYqOn4AKQPXcdfk6tebYJUUGHQlU5jtk2ls9v+pCgxuE9chiskamAzdlvQ1ymjnoJnL4Eo8ViJoJzVE/qQyBZDp+lzxqnfmNrBQK2ftYr4guQ5Ow3d6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(71200400001)(26005)(186003)(6506007)(52536014)(8676002)(5660300002)(8936002)(110136005)(478600001)(66556008)(66476007)(316002)(66946007)(76116006)(7696005)(2906002)(9686003)(66446008)(64756008)(55016003)(41300700001)(38100700002)(122000001)(83380400001)(4326008)(86362001)(33656002)(38070700005)(53546011)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L4MZOmkpVezn5Y2b2AXezE4gflmX9KplCZrjSDW6DfmfNVvyOx9PP7s6dIdu?=
 =?us-ascii?Q?90ONxBh8x5VNYC7xtCi80qY+cxXntwdlTOmji45Iwk9FPlNQeJxnVEAO3t0I?=
 =?us-ascii?Q?eUetHLFDp/+tJC8PJAUg/5f/USe4MMXyEJm9w8ZOz8nKEkw5cTJyFfgnCgMo?=
 =?us-ascii?Q?g5csKyqyZkbdlb0LdnOHh0zBl83xHBbDf5eTgZumSdr5VULR3M8icKq2Nzbs?=
 =?us-ascii?Q?Ix9U4ECdiXKyZQkjADirbve7owb6R5b/Ixd/yN2hRcYMhhrqh9yCz4Yexb3x?=
 =?us-ascii?Q?7JUtwD2JRZxkxK7pvcdXxAw/im0KO2ACRtSm78X8jIGOW1iWaqxTxfP1tR7b?=
 =?us-ascii?Q?jLIDC6AsbwpigacD+pQHT1mftEUbdFme2s0h5OpW1tQyV6FZoIOfghSseYvU?=
 =?us-ascii?Q?Ypgv7PEaWJMWdTine4pHHWDY6fMu1NADFJcaI0xv/hxL3taIR9DzyxlxzFcJ?=
 =?us-ascii?Q?1bmWhQc7lA6w0+hxga/nI88+AeEuzXPejpx1+A3cipimS986K+mlwqf/7/dJ?=
 =?us-ascii?Q?8SUfy6gaOgIH7faO4jesXUlquqQebGcL10H3S/0H5Z4JxLE91sp3ftl80tY1?=
 =?us-ascii?Q?Qd73fUtsKpLpB4k+l0606xwImEDzDLRglFtRd30diKpsyAAHMFHLmSUq202t?=
 =?us-ascii?Q?8J901+gX5S/HObP0ZFHSeNL+kC7dVhSl26W6fDnBfSFEPv1z/ONGL/MCTrYj?=
 =?us-ascii?Q?FiO0/wkUQZBGTZ6UQxNPLYIQ39dYQ8+NvADx/AsvwQcSPyDwawgDicmNK6gT?=
 =?us-ascii?Q?rc1D6gL4asi0yf+92JxupGQhrJ00TLxGgY2oSyn0zJKtIxjNeL+MYhPmtRS9?=
 =?us-ascii?Q?9/Ii6eAf2ZPGb2XKXluAAJEBaRJhvYwc5+kdkHJikoVed4Z2dDLhbu+T1CpS?=
 =?us-ascii?Q?CtpzewfsV54oNlQZKuIX5RmrBgDY5INK6rJexUzv9zzDJGODNKLyntcCJ2kt?=
 =?us-ascii?Q?BnQllwkUyMsvw7mrYeQJmEz8irYTNW1E7gxJX5g1aPtToaFNnNc/MVHp6lFj?=
 =?us-ascii?Q?50WtMQun5Y3/PU+HpaakHPNo9ZSnbKntJCJXZ2nhwJI+XeTExe099Jwj97Om?=
 =?us-ascii?Q?vIwZ6JgKLd/+CCtk36NkuXqtnoSc2xFTe3cRchE9nkX0gqxmK/LPoJ3LurQb?=
 =?us-ascii?Q?CQXDVxDUVQJX5fH6PkQh0La5MixGQnBfJljYmcebNlbrww/EknG/Jzl2ZlVe?=
 =?us-ascii?Q?RH49bq78VnhAcWt/1c3S+HQEtyTRseQxnvX/9/bvsJJj64D4Nfc58+2sfQeC?=
 =?us-ascii?Q?ZTtr2Lip1P1kgGt98r7r1HbGsg8fTtrG6s7UychTbwTKQKKMx12+65UD7HJZ?=
 =?us-ascii?Q?F90iO9+Cw+IepoQowMBqRhbS6JkCnGBsB8ImQMhCmLwhYTCYiDnQo9NhGsYC?=
 =?us-ascii?Q?zVjfnT10Kr9E3Jt2vsHJB6opsWoeyZmnuamdYN+aJCkafDQqhWe5J+pTId52?=
 =?us-ascii?Q?9o0jNPw9tSVVDMzBlysJ1hAmsBlF3RCwAk/7FhXoICKpjT7Bnpo4dBgEcElN?=
 =?us-ascii?Q?b22KDLg9VA0nGGnTHWy+tWsVdzwaVOKennCQ/FUy8UAa1hupUAq7+TegEXKj?=
 =?us-ascii?Q?p7FVeivs3j4QgoxpR5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70098be-7ba0-4cf9-ce36-08db87faa59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 01:51:19.2768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKI0D4T3sEsEZ5DWnwoWJ4PbmUtVrO84/wrK6oM/6qOBZIcjlbCXPBkH/4QDM/a8ZADf2MGGFXwftY7uNzGv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi  Jonathan,

Your change looks fine.
Acknowledged-by: Ji, Ruili <Ruili.Ji@amd.com>

Thanks,
Ruili
-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Wednesday, July 19, 2023 6:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Ji, Ruili <Ruili.Ji@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: fix trap handling work around for debu=
gging

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
>       if (enable && q->properties.is_user_cu_masked) @@ -349,7 +348,7
> @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)  {
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
>                KFD_GC_VERSION(dev) =3D=3D IP_VERSION(10, 1, 1));  }
>
> +static inline bool kfd_dbg_has_cwsr_workaround(struct kfd_node *dev)
> +{
> +     return KFD_GC_VERSION(dev) >=3D IP_VERSION(11, 0, 0) &&
> +            KFD_GC_VERSION(dev) <=3D IP_VERSION(11, 0, 3); }
> +
>  static inline bool kfd_dbg_has_gws_support(struct kfd_node *dev)  {
>       if ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 0, 1) diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
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
> +
> + kfd_dbg_has_cwsr_workaround(q->device);
>
>       if (qd)
>               mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q-
> >mqd_mem_obj, &q->gart_mqd_addr,
> --
> 2.25.1


