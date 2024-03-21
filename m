Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810BEC54E68
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 16:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2513110EF23;
	Thu, 21 Mar 2024 16:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z1oWdwTE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2AF10EF23
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 16:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGCin7Q42b5iNQ9ONbUhfS8yynDyYbvZYBLuGQhz3N0AYTHGnrle6v75dWVg1PnU3WzOjIAFEVR9M3CeLzNEgxkxU7yV+fsZy87gJXVGX4YoXh/DvY9CxEgT8WOdVMFeVb/slW5myZwncO3+vXEfZ8bPsWYFEiPzKMNAqiF4LoMLkweZDYppFxXu67mbXg2HLUV6Zg9n/7QCH/tlk9IMf3e3JSFJrIpJEGrfGWntrb5Ozri2ZgBZwnQ6MekIttg3+xtaekSlLZXLi66gOy4K2wKhCTyn7uq8Zhv7i0+Ql/DvwwhK/Y2BNFoHW9F0ZGNuA9sqG8xDq4qdDL5Y/86XXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkVB02ya557WpttTyz3HDalSeUCeErjLTtnX2bK5sTo=;
 b=Ahgl1dJ5qpPvnDaAbP50LPVcNg0mliGqFjzJP0sx1qPsDqxblN+ZS9y95YPqWHGexx/XNpgUSuV6LPO+oEA5BS9OJ4reqEjpPTseOwEJg/qJfRGPRPbftDq1CQMqMTOgdw5zSzwNMkTlplIW2CIW+PCMZzpyezsmh7YwU+B1JSsn+iutYo2JlfBvfyFJ6soLDtDkCZ7qU6u9GrN/cqedy66+CnMG43F9f2ulhj92QhbGWDG/4nGK231x/EAsUi/JPvObiMatCLxtlBBXN3zJvFSREbbwfn6D+zMuW7wEs68wAwmZnwxIWop4lQm/2j5gsxnEiPufscjauNA/QsmHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkVB02ya557WpttTyz3HDalSeUCeErjLTtnX2bK5sTo=;
 b=Z1oWdwTEw4/eMV1ZvmOBbaTf6VX5mfuJQWVigfsF+4+PGgvebdBTInwSvvYkiGNopElDe7FK7orAY57t8QLts7UWHhhRZ46Ueqk6ZqEoTXQIhLAJEauQMv+A/h/aYZfWmxh87jT6Xfqw2tnYuUVdYa3uomdtCmhVrAKtLfaq6P4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 16:21:38 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::e76d:cc32:47ca:b039%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 16:21:38 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: range check cp bad op exception interrupts
Thread-Topic: [PATCH] drm/amdkfd: range check cp bad op exception interrupts
Thread-Index: AQHadVG37oMMqEMAx0ChgH8o71aRCLFCbLgw
Date: Thu, 21 Mar 2024 16:21:38 +0000
Message-ID: <CY8PR12MB7435372EBCB416DBEB3377C785322@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240313142105.3028030-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240313142105.3028030-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a6c33dc7-fd6a-47cb-8b78-b1d52db52b23;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-21T16:20:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BL1PR12MB5924:EE_
x-ms-office365-filtering-correlation-id: ebb04cfb-d4ae-4945-cc12-08dc49c2fc41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0CxG+kRS3LuDMSy/sw8Lv0CZdLdJFwARC0wvG+gUTLXeQwdopN4zjZZJ7sKWkM5tGdVjOfUV+WK44CAxE6cf9QiWpxrh1tgnMMV5OXoetMbW5XBaLo6pHuKTfmq5oB4UDOrvsOFUajT2KQMobCV06mb910g/17d7UfD1gIGJyvcbFYI7jGyxCrBTqwsoTmmsseaXjkSpnCsp64c1zOafDrmx6O9xtlFOgDvvAjua5eertUxsFbe59gVdFfOlLs3/rLGsB/5D/2eM7L2YDdqv8TaaZ8uHjS8Zxm1vCsPe+UlOKP2Ekt4T+bBK0lWW5uWdLWpmCxhxnf+Rz+V2Rpgq7T2WHOFRiQAMJdGjzHrIXdMNhRGUzDsjvvT0EYF2W2ss1IWcvCsvcH7WDmh/TFDLVhTHgzS/uRyWYUcma4k8MZUAD+cTnWgB/qJFxxJohymdZJMYzdw2BYnq8mrX2Tt2CiGbKwV3ty3v6qLpewwHRhBp24evHU9qLOTMJSiNk9uHlqjRDhtgbPTIXTts18rm7oilusNzAJSj2zkn7AWazyTusrDquQ7nScnrDoWKtmLjxPd3gohMjAp78q/GnXcvpwtQg02KASEm7lHXPX0eRRW4+jtrlr/WyuR4YImX/a7OviBvvBlTqunaHc8VLIjHqdxVfJwIxFZEmQ7WGQNV6w0Pc3RQW5fAjCq0pizAQY7oukcgHADr0hJaDKViQuB68x6hbQ9uPqY0Bn0kptxNeE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+hPwhsGulAuA/yehUkYNKHjAM+y18EoXJuzNR4M9HF2/uR9y/7bHoLmyPd5?=
 =?us-ascii?Q?fBSPbiGvUJ/OLeTMtR6yNM+N+MV3ZnQyZ6Y4yOwyqLZHBuM333Sch1vD5r6p?=
 =?us-ascii?Q?Rllc8royGD0e0qJLMePLneyCJOsQbUmIRdoCIiXD9doXcCD0q0viUduh8oHz?=
 =?us-ascii?Q?T3GgPKXs95UHrUx2nCpbUmEJQzUJMmormcXbhk3dO5hmjQOLeKnu7Du1yWpN?=
 =?us-ascii?Q?yven2IOvxFxHRlD2c4/pNAfzdEWBU+NAJLyygvVRXsZl2wzsTy/SL7nxtc8I?=
 =?us-ascii?Q?fkL0LlqSlcn0Bo/jZJYdG3h1o4GgdIvL74Vy4MZGS//8gPdcP8da99BDaaju?=
 =?us-ascii?Q?lJQrOL/igCl5jwF9SWUeA8Etn6OLI/xzwyyLYAoUO83PXOD3hG/sFShEcKUT?=
 =?us-ascii?Q?wFYlG3Ypv2Yz0ARLV32zMAApaTa4kJ+KGuvTm3iFg2zT+Z86QTV2xVcPCt3O?=
 =?us-ascii?Q?hWauV4dMsNHjJRZ9F4dOgDnt+AGgR4zq2IZCkDLMrGH+CtdUBxaCzLcI0+Ga?=
 =?us-ascii?Q?hr/ILtZAlnv3dEfPzrdvP43YRFNafqRaC5Uwb2M0IvtHZybzYNLvBTChYI4z?=
 =?us-ascii?Q?/bWgGFlC40tzL0/wuC1r4k1m/Sewg9VcFcYdkIkKIXVO61i97TwDhqx5F8la?=
 =?us-ascii?Q?3Mo8dszC9jGlDOaM9f1Y7kwUjbO3yhv7BSbDKVBI2zf5TVnjlae9peubFJ2M?=
 =?us-ascii?Q?lMKegNLtDRm824R3mHAF+YTTUoX5vZltu3TqA8rO8JcvDGK8117PqwNfAWJa?=
 =?us-ascii?Q?Dp1AGiIi8/gTvuEjvPcXG2Xl19YGELDYD9ecwKERBFYPfmyLQakgvH++qXPq?=
 =?us-ascii?Q?K4XHYVPhoRBFlaNctRghpzyFS7SEFmHrFzyzO2tWrPEa2tiaxwwW3lsD48tx?=
 =?us-ascii?Q?XAiDBhdje0wFjMtXcTku0B3M/Kh18O6PriLMq1i/qNIRay4A3EqhRTmZ2p5s?=
 =?us-ascii?Q?lhSoKeE5Et45e5zsT56qAIwH0hVAZrs2rqV99fE/u8M41NCqpB3eIgKL5Uqb?=
 =?us-ascii?Q?BHqhNY0ErVDkaaqGcZltw+46TG1MVs2GQdDLpuNJ+fgKc2cVVnoXmHvo203u?=
 =?us-ascii?Q?XmWs2ov2tXxqYrtnnJfKk+/OSY4kmsoISbmrT03Hnhl7EasxM1twDJ7cHexM?=
 =?us-ascii?Q?U4lcTlxfz0zZDsk2zNarCN36WFUkEnBKjDYA8XMvUSNlC5SU+vWP2m5wtxGL?=
 =?us-ascii?Q?yw1Alv9Psnwu51PjCz+B8yVQjw26jhVDezUbKDS8J+clB+CWvgGLAvcS0t8J?=
 =?us-ascii?Q?YDNLL2XXB79mbHmmCiTyFxM8nJAPxY2Dda2EwWOerjC8U594smbl7Md/VJ4/?=
 =?us-ascii?Q?6J35pV43eln69rjv1hQKkk2d68Zc4LkmqmY7ATQ9VDzlKdBWwl4IfU5Fxb2c?=
 =?us-ascii?Q?knLQrAx+q2f6NFISMaaZ4J+tHawW/cfulxMcmUSzVwvThZdKnFjvfAVvzKcr?=
 =?us-ascii?Q?pVzvd6L2cIsFJX3UlplIkUhuDVwLD3X4vBE3beVeVZfdhD2fBvMl6pc7ifRb?=
 =?us-ascii?Q?2v9c1dSEAg+Ug5iBCSesx12xzTMBQsf9rlW47gWSLkzB0cvoW5zX/XVrUA3+?=
 =?us-ascii?Q?mr7W6G1HM3ey5vJLATc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb04cfb-d4ae-4945-cc12-08dc49c2fc41
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 16:21:38.4181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3HvOducpSe8yV6At6fcOQjy91UWd/3ZHmZgIGASRsscwrAllndbnPNoFL8HvYRTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

Ping for review.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, March 13, 2024 10:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, JinHuiEric
> <JinHuiEric.Huang@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: range check cp bad op exception interrupts
>
> Due to a CP interrupt bug, bad packet garbage exception codes are raised.
> Do a range check so that the debugger and runtime do not receive garbage
> codes.
> Update the user api to guard exception code type checking as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Tested-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c    |  3 ++-
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c    |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  3 ++-
>  include/uapi/linux/kfd_ioctl.h                  | 17 ++++++++++++++---
>  4 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index a8e76287dde0..013d0a073b9b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -339,7 +339,8 @@ static void event_interrupt_wq_v10(struct kfd_node
> *dev,
>                               break;
>                       }
>                       kfd_signal_event_interrupt(pasid, context_id0 &
> 0x7fffff, 23);
> -             } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE) {
> +             } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE &&
> +
> KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id
> 0))) {
>                       kfd_set_dbg_ev_from_interrupt(dev, pasid,
>                               KFD_DEBUG_DOORBELL_ID(context_id0),
>
>       KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index 7e2859736a55..fe2ad0c0de95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -328,7 +328,8 @@ static void event_interrupt_wq_v11(struct kfd_node
> *dev,
>               /* CP */
>               if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)
>                       kfd_signal_event_interrupt(pasid, context_id0, 32);
> -             else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE)
> +             else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE &&
> +
> KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id
> 0)))
>                       kfd_set_dbg_ev_from_interrupt(dev, pasid,
>                               KFD_CTXID0_DOORBELL_ID(context_id0),
>
>       KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index ff7392336795..5483211c5d3d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -388,7 +388,8 @@ static void event_interrupt_wq_v9(struct kfd_node
> *dev,
>                               break;
>                       }
>                       kfd_signal_event_interrupt(pasid, sq_int_data, 24);
> -             } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE) {
> +             } else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE &&
> +
> KFD_DBG_EC_TYPE_IS_PACKET(KFD_DEBUG_CP_BAD_OP_ECODE(context_id
> 0))) {
>                       kfd_set_dbg_ev_from_interrupt(dev, pasid,
>                               KFD_DEBUG_DOORBELL_ID(context_id0),
>
>       KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index 9ce46edc62a5..2040a470ddb4 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -913,14 +913,25 @@ enum kfd_dbg_trap_exception_code {
>                                KFD_EC_MASK(EC_DEVICE_NEW))
>  #define KFD_EC_MASK_PROCESS
>       (KFD_EC_MASK(EC_PROCESS_RUNTIME) |      \
>
> KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
> +#define KFD_EC_MASK_PACKET
>       (KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) |
>       \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVA
> LID) |        \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) |  \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_RESERVED) |       \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) |    \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID
> ) |   \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |      \
> +
> KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED))
>
>  /* Checks for exception code types for KFD search */
> +#define KFD_DBG_EC_IS_VALID(ecode) (ecode > EC_NONE && ecode <
> EC_MAX)
>  #define KFD_DBG_EC_TYPE_IS_QUEUE(ecode)
>       \
> -                     (!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
> +                     (KFD_DBG_EC_IS_VALID(ecode)
> && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
>  #define KFD_DBG_EC_TYPE_IS_DEVICE(ecode)                             \
> -                     (!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
> +                     (KFD_DBG_EC_IS_VALID(ecode)
> && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
>  #define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)
>       \
> -                     (!!(KFD_EC_MASK(ecode) &
> KFD_EC_MASK_PROCESS))
> +                     (KFD_DBG_EC_IS_VALID(ecode)
> && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
> +#define KFD_DBG_EC_TYPE_IS_PACKET(ecode)
>       \
> +                     (KFD_DBG_EC_IS_VALID(ecode)
> && !!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PACKET))
>
>
>  /* Runtime enable states */
> --
> 2.34.1

