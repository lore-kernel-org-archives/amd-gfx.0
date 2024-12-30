Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7651E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 17:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4493910E1E2;
	Mon, 30 Dec 2024 17:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnxde6x/";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9532810E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 17:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1Way5WVyIea9a2oQnOW8WNQ39wCq0SyxH+8x8f3t8td5bXMP0lLU9Exh5BY4WHI+bkCYYv6R494m2ZsuBTWrSjSnHZFxXdIT7IwqQkzsIjUpqXtOzefaRQ93O5+gE1UHZ2ew1XpHHXTU+z5RgJxXDd7Ee8rJpOyUOpJBdcy4SPUbGepIrpmlEphZB5ypr1hLMK7ps8H14qdK3ByiPzmva/lCEtFfaPZAJGWxWIzl89SXNxFNT2myS5flVrNPWcbti3NAwgxEGLS1u+GmGtuRnsObnmoL4I+V2uEe/p3wOMfVqDf+AwbyfoE205+gSJaZMEe0/6bI8ZkIQMZ4Vg3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCpVS0OroZeI5JdKnbYzspybAcXqMlLac5bejSE7Lak=;
 b=nx/YdkFdxgi2e8hrwNpm5xsna2sxkf3qehl9u7gKKxLBtTL1LYxIDgS+jB6UGmYQ1Xf4vYL4KntQPL7l4iVk9TkJ3osOxrZLyMh6NDdjefIOiwz0TcnpwyjaZq8KpuaUsUVDfdT3PWsMfFy7EmtEKRmyqprCl2xtNRsnWLmVD0KTfFfkVdH04jz4Lni1RrN1qDa3ZloSMGSKw4F7vvYS8WoqKiqpxJqffRr7W9qnOf+KtfEq8JLiQGr3VjvLEplweZkfTiggimrCFue93FP8p6clyVxVIOcoNU+X8kToKjpLpP5vE4XTlLkdK4vFza1OAYrFkqPrN8dbP+NFhnIRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCpVS0OroZeI5JdKnbYzspybAcXqMlLac5bejSE7Lak=;
 b=xnxde6x/o96tu1MY7bPPCG1kpCO8FYSSdF4MbXwaugnEy/7J3CLpvkoXq1tIwt6gbt6gcEy59g5VAlewm2zcXoQ3Vz1SJtvAxVnxeZwE0Nw/xcOt5CJlxCG2HYzA3FCFi8/CNXFjEc/th8yjtyNiWAFovvovX/lumyQq0OSdxA8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 17:44:11 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%5]) with mapi id 15.20.8293.020; Mon, 30 Dec 2024
 17:44:11 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Martin, Andrew"
 <Andrew.Martin@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Index: AQHbWtzXVboHpBTF8kmiZt7l2RD/WrL/DKdg
Date: Mon, 30 Dec 2024 17:44:10 +0000
Message-ID: <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20241230170223.574547-1-Andrew.Martin@amd.com>
In-Reply-To: <20241230170223.574547-1-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=875e0fdb-fd47-4e84-b2c6-d64d1f1c1207;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-30T17:35:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 4d7d07d2-b8c1-4960-d84d-08dd28f99182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9C21rSrmMKF4/+8K1773gHfiojqWAFxKWZ42liSLSaiwtO81bl6eoCjUzkh6?=
 =?us-ascii?Q?I+ybRXKC3QfEy8ELCl2PGQHc133mnJ8+NZwZJ2NQmsxQvYW6iSuWbsSQiIyK?=
 =?us-ascii?Q?omr4IKZ5gh6OUq/VendM1F8V8wt1d+ZglA2XURpmdRVLQKY0yi3ny2p2WaLk?=
 =?us-ascii?Q?ozyoI+jTZUUQlDJEpEmsuPZmy6jjyUvasTGYozRrOLSFBlRfM8SULNna8F9W?=
 =?us-ascii?Q?U1zOw2gPv+hQBlHkV0vGmZmRoybjBiyoFkWyAj8A+er1cvHB88N3u8er8QCq?=
 =?us-ascii?Q?TJUJfUl1kuMgRxd70SwATl2+0jcdqpValUG1U+b3PCqKDuR78q8PrxG59HYy?=
 =?us-ascii?Q?yzk5ki9nPxG0/HJeVc5MSguUXHvu3ge3aAY+AoXaJcduq3uv5+jDsE+cT3lj?=
 =?us-ascii?Q?4WX6LITHUMYCucI8M+THB40DXp3nAFhrcBz5Pr2twGAEluU3MrlBpfs6RLN7?=
 =?us-ascii?Q?DVSj8rz3S1OPncGWdm2XqX78T57Ed8OYqVN3ebXoBlgGnhoEYGk8lQKRoZw2?=
 =?us-ascii?Q?fDQ6QMPa1gI/whihntTb+zaitzxQSsM/lDFl6UvW4Uzno/bMtK8iTwpd0U38?=
 =?us-ascii?Q?V5i97C8Hu+UhypS6FxEoGW56WDdmQmOJjls9kxbwpfyPe42lkP6kyJLeC/ah?=
 =?us-ascii?Q?3rwi8R0Clj6piP/z0V3kO9vwZA3ywpJwHubCILkBCTPO+musQaxKtnw9dnHy?=
 =?us-ascii?Q?cfOFhgRA35RdPhW725+aRXyLi6UVcFvwXyzR7SmMW9ZcIHBCdHvVwtzEZItx?=
 =?us-ascii?Q?KhErmY/LpAXgxB+dM3qD0k/hT9GAl01D1pwvVdwAnvzkrqnxtfdQa6l7zzm5?=
 =?us-ascii?Q?OqkwbmMnwM6uTcDNHfSvv4ncxgkrBC5erTXxhP6wTeRYBmZDmwvk4v2EiU9G?=
 =?us-ascii?Q?GA3zJq/f3gM4E274d9gxeWIpz7EF2foYHFT+wHwjh6bSohyST/q360WMn5ws?=
 =?us-ascii?Q?6enfwsBkL/wZ6VmCqwqdoyg9lg1zFhjN0U4jkolCEehTX7Yjr14Aw6DQ5E1i?=
 =?us-ascii?Q?KlAxGlOFStsBkiwNLVbPEF//A9/rBj9y0s7k5NrL4tCbFcVj5ThXTMEELK6c?=
 =?us-ascii?Q?3+UkHGeGtFwVBp4dzYikmkpCzIxoEfDqcYs6YxZgqatcJBq2b1erw38RICdq?=
 =?us-ascii?Q?21gw4jTaQwiNhslC3zcOvLfkuJMdWY60pDErhFfYBbClPZJflBVndnx2RsaF?=
 =?us-ascii?Q?HVGxlfYSx8CvCPcWR8xuo4vJn48S9l5hc9Ds+GCOVr/KDTpFXcTzqrvf58Mk?=
 =?us-ascii?Q?PPkOR7u1P6AcrVBivnLn4/dfvlQyhOZI4fvdF279IOzbhUa15aCEVMeeNBZW?=
 =?us-ascii?Q?bsHiVM+ihesEDmZhS+4QoTMZj0CyHcQFXu/VcVRbsqiGnP6jX/Ak9UdjJL6X?=
 =?us-ascii?Q?YOD125OMBjlk1iezqKB7JuvW22p0a8xUrjaIe4YtGdNbSTg+881ehYu36lXd?=
 =?us-ascii?Q?T+DBFlk7BKcwCExnovxIU3QkHVpRGddQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0uaBYV7uhT0gg2jCDbXXSDHF9fQel3Eu6bzjNePQ3+o5EKn8xgBwI3vXntNB?=
 =?us-ascii?Q?cL962cuPJ3LOTqEaBKbn10xXeCZfFX0rlOGWgYwF7jQUqtFPOJH1KGuj4M2S?=
 =?us-ascii?Q?phNfBMlKNC5ap9hkcVOuwTDKdoRdSpaXsq636xm2gZO5ip8IVbHocO3gPZm+?=
 =?us-ascii?Q?uglO6UxbGyE3TQoWRVmwU6YI8p6+8X/v9j+9hIRrKW9Hqq8N5xkuWgpUOYtK?=
 =?us-ascii?Q?FBHAcKzv0PJHlSBAXevu/nicP8YUD7gO0zmayEvIer0k7RNbOD+7Rid0c0S/?=
 =?us-ascii?Q?K2rr3i/vPWurYRPxPkwT5YQ5HBKxY106JtoPq55+vnJBTAaf/ESIvE0VCNsD?=
 =?us-ascii?Q?qIn35fClQ1f+NA02sXj8ix9VKCHLY+7KkzzgUil8LVjAlah/GX1EoGWspwEw?=
 =?us-ascii?Q?nZVhrkSSeYstYLLIURNx96F+m5w7QE9cmZqs4cEizyDYt+RRfkgqfo9KFu4p?=
 =?us-ascii?Q?FjGTyfphU6dpeSCiXF6/pnKOF+RB1dnGa/IcKqwHAWTwmEh5KCMuSAz+OFFq?=
 =?us-ascii?Q?H02rrVL82FGQqKskY90MritTvuszb6er7b0zQXAoVnrT5r1YsuBG3pyxMLsu?=
 =?us-ascii?Q?q9Kz6aEYzfOgKbWM1499fw1gm3BPKhQ/lIaiFlx8igq2pCf4PHnrVNW7HKXJ?=
 =?us-ascii?Q?KvuzD8JFYC9aHpRSfCp1bnCKYdhn58YOiDIhoxh4R3VluFJcHD7l8cT1UAP9?=
 =?us-ascii?Q?UAecuSMaFVx7SaEZ91AhzuEFfWEHeRnAnxdqxfsbe/QIyjPjUnSH1tfvlhN1?=
 =?us-ascii?Q?Z6QQKX/oahF9G6t4w8iXxtvmjANCG/Nh7+gs4PPN8qq6QhFtZuNDEnOwTu0R?=
 =?us-ascii?Q?+mVh86TRrIkyhb8nHZER6c4C3DbTgWzflgoA7XRIadFZemKenqcp+gyw+Da6?=
 =?us-ascii?Q?R9q/TWmhCNbnp1qJn31tXPCio6DWPFVCTKjbz7O5WvYi5Ylfs8dt68906+AI?=
 =?us-ascii?Q?6F7MwGuFR9Br43pYIpJj/7OOvx7MESYwQYnWZ+hUORJM53ip+/e/1ZKWhDYl?=
 =?us-ascii?Q?cQsIqf20TJsOwYdIgzl1AqEDYnGto2r8Qs9UP/ENwS7i1i6dfjEAsq24kd/y?=
 =?us-ascii?Q?myYZB3VpRHgCFcQGU2xUZAeRoGOAPAupbzK5+6YVdddnoT1VtM5KoAxcmswF?=
 =?us-ascii?Q?9h2kKgZrvBZvKi+1z71n9OfPSLESQTYwZY/FO3IhXLq8ixS1ap1jGU081ShJ?=
 =?us-ascii?Q?dLDA8bh6Cf7mN6q7pgYQNt9wGrZVuP24dUfH+yNce61fo/KSQ62ufVHJ6AEt?=
 =?us-ascii?Q?YEx3j0nrLTou0nKCsaPrw8aTyWYkfBhDmmaaO5VQROmyJdgacXScKBV1+Hfn?=
 =?us-ascii?Q?5TE56vqqzE4M1CvnHv7orrS9EBYxxwBd5EdMlSvcF8JNJ7rMKXyk3DFUFIvK?=
 =?us-ascii?Q?xrwhN3+J13+/I1IR5K9fKokO4Vre3ntUmaLNjZ7NxACAkEDqKum7A3/9DlOJ?=
 =?us-ascii?Q?Crqm7Fm8buAJ/KcaPjgUc0x1XDLrfFc2rXhRTzw1VFOgjWGVuSIAqyfe0nQ+?=
 =?us-ascii?Q?Bpo2KqMSkdbFO6SlZTpKvWtE83dRfVnpsMPQ5i+RBnCUDD+/5mVSSC/NqWOM?=
 =?us-ascii?Q?WtNKF1ry3v6cc0rK+M0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7d07d2-b8c1-4960-d84d-08dd28f99182
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 17:44:10.9599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElRCW3uanH7XiccmPZ8XW5dmDmKJ51QLNFcfO5r/0KGbqjsBiVBRnXiErbxVypURQxrPbchkB5mH8Su0rqcZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
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

Might be worth changing the commit headline to what the patch does, somethi=
ng like
Don't ignore return codes
Or
Various return code cleanup

Otherwise it sounds like your patch is intentionally ignoring return codes,=
 which is the opposite of what you're doing. Also 2 comments below.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew
> Martin
> Sent: Monday, December 30, 2024 12:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>
> Subject: [PATCH v2] drm/amdkfd: Ignored various return code
>
> This patch checks and handles the return code of the called function.
>
> Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 ++++++++++++++-----
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
>  4 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..52a11dc01422 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2864,7 +2864,7 @@ static int runtime_disable(struct kfd_process *p)
>                                       pdd->dev->vm_info.last_vmid_kfd);
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> -                             debug_refresh_runlist(pdd->dev->dqm);
> +                             (void)debug_refresh_runlist(pdd->dev->dqm);
>                       else
>                               kfd_dbg_set_mes_debug_mode(pdd,
>
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 693469c18c60..f335ed9e0b3a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_i=
mage,
>       if (kdev->kfd->hive_id) {
>               for (nid =3D 0; nid < proximity_domain; ++nid) {
>                       peer_dev =3D
> kfd_topology_device_by_proximity_domain_no_lock(nid);
> +                     if (!peer_dev)
> +                             return -ENODEV;
>                       if (!peer_dev->gpu)
>                               continue;
>                       if (peer_dev->gpu->kfd->hive_id !=3D kdev->kfd->hiv=
e_id)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index a8abc3091801..b4db409d90a1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_topology_device *topo_dev =3D
>                               kfd_topology_device_by_id(target->pdds[i]->=
dev->id);
> +             if (!topo_dev)
> +                     return -EINVAL;
> +
>               uint32_t caps =3D topo_dev->node_props.capability;
>
>               if (!(caps &
> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> &&
> @@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>                               continue;
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
> -                             debug_refresh_runlist(pdd->dev->dqm);
> +                             (void)debug_refresh_runlist(pdd->dev->dqm);
>                       else
> -                             kfd_dbg_set_mes_debug_mode(pdd, true);
> +                             (void)kfd_dbg_set_mes_debug_mode(pdd, true)=
;
>               }
>       }
>
> @@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target=
,
> uint32_t *flags)
>   */
>  void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, in=
t
> unwind_count)
>  {
> -     int i;
>
> +     int i, r =3D 0;
>       if (!unwind) {
>               uint32_t flags =3D 0;
>               int resume_count =3D resume_queues(target, 0, NULL);
> @@ -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process *tar=
get,
> bool unwind, int unwind
>                       pr_err("Failed to release debug vmid on [%i]\n", pd=
d->dev-
> >id);
>
>               if (!pdd->dev->kfd->shared_resources.enable_mes)
> -                     debug_refresh_runlist(pdd->dev->dqm);
> +                     r =3D debug_refresh_runlist(pdd->dev->dqm);
>               else
> -                     kfd_dbg_set_mes_debug_mode(pdd,
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +                     r =3D kfd_dbg_set_mes_debug_mode(pdd,
> !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +             if (r)
> +                     break;
>       }
>
>       kfd_dbg_set_workaround(target, false);
> @@ -1071,6 +1076,10 @@ int kfd_dbg_trap_device_snapshot(struct kfd_proces=
s
> *target,
>       for (i =3D 0; i < tmp_num_devices; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>               struct kfd_topology_device *topo_dev =3D
> kfd_topology_device_by_id(pdd->dev->id);
> +             if (!topo_dev) {
> +                     r =3D EINVAL;
> +                     break;
> +             }
>
>               device_info.gpu_id =3D pdd->dev->id;
>               device_info.exception_status =3D pdd->exception_status;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 1405e8affd48..250aa43a39c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1907,16 +1907,18 @@ static int start_cpsch(struct device_queue_manage=
r
> *dqm)
>
>  static int stop_cpsch(struct device_queue_manager *dqm)
>  {
> +     int ret =3D 0;
>       dqm_lock(dqm);
>       if (!dqm->sched_running) {
>               dqm_unlock(dqm);
> -             return 0;
> +             return ret;

I think it's cleaner to just leave the "return 0" . e.g. If the code gets r=
efactored and new stuff gets added above, then this might flow differently.


>       }
>
>       if (!dqm->dev->kfd->shared_resources.enable_mes)
> -             unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> USE_DEFAULT_GRACE_PERIOD, false);
> +             ret =3D unmap_queues_cpsch(dqm,
> KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> +                                      0, USE_DEFAULT_GRACE_PERIOD, false=
);
>       else
> -             remove_all_kfd_queues_mes(dqm);
> +             ret =3D remove_all_kfd_queues_mes(dqm);
>
>       dqm->sched_running =3D false;
>
> @@ -1930,7 +1932,7 @@ static int stop_cpsch(struct device_queue_manager
> *dqm)
>       dqm->detect_hang_info =3D NULL;
>       dqm_unlock(dqm);
>
> -     return 0;
> +     return ret;

Same here

 Kent

>  }
>
>  static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
> @@ -3439,7 +3441,6 @@ int suspend_queues(struct kfd_process *p,
>                                       else
>                                               per_device_suspended++;
>                               } else if (err !=3D -EBUSY) {
> -                                     r =3D err;
>                                       queue_ids[q_idx] |=3D
> KFD_DBG_QUEUE_ERROR_MASK;
>                                       break;
>                               }
> --
> 2.43.0

