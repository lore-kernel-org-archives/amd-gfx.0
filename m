Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B2EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 04:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C2F10EDD8;
	Thu, 16 Dec 2021 04:17:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E38E10EDD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 04:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKIeNi8rk91icPpxZcYNTw6wRwpPoLJmUzvMiPnc/cO+Gdsal7guCstd73j+Yol6jPslvfOPl5UreuFf/4/O0qbdsxTxZfABBZGW0E3HxuMCtqJo3rsbityqHmPD1cmAFnYCT6LrL5iWnD7OE55ZtleyglGsWmf5WwVrBdhUVbzbvHd5X6QIN+Pj1ytG446j6YEuey5e6HSdTwftZyz4XsdZViQf/3q8KKcLiyrF+697kpBFxeUQY/Yr4h4RMRSwr/xjKMFbJBarNUTJdsCLhDrvnkR1XQR0uuycKp10E0YUlJFNqPPiHe6tzrbTFaMnD0B5dSChjJVao/CM909OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+iWqF/2dI+qKqMFGxFiw9/NIEWKgW6xoeXQm7dVT0Q=;
 b=nGzn4Yqzwe3g4oJah/W8QumLtonsqc6/qUApLUp13PUg2/po/1syAudo/f8Fvrqh6kRwunEaZ4Nhy2xGnPfFF5yRTUJyJCCykeqZetEsaAkpEBYl0hfO91ddRLZ56orfOw+qXhwroa8CZk7yBJuRl4oZo7JhnY08dSsFFeA0NvT6vCgIGjk/8JWqhgaBnUMhUkH7B4hmk/U90CkWGdYob8WYaDZ2Ep3Obi/O2G8tqjNFnOsIqgKOsywYNTUQy9FxfHZxINN7uKwEAar6Bz5k7mpxXpZqrUUv7zvdAY6OpTCOs79SoTcSkOyuZxLNmbBfoPLOqVWTckfoX6HerwwSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+iWqF/2dI+qKqMFGxFiw9/NIEWKgW6xoeXQm7dVT0Q=;
 b=mcHd2N3d9s4kNYz1C/3lj++jnIew1TgFDhTNddROaV3Vxg7pzscTQ4QmO/vQGUtJSgSs1sMUoNfadDtDeXbHGqAJZcGgV1UH9u0ysnkSXRE8dkfCgJrUn4g1t+w5ks9J0vNfkmBzXEznXAo30VK2URYlc/R5OPHKO2JI5UBk+XM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 04:17:20 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 04:17:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V5 00/16] Unified entry point for other blocks to interact
 with power
Thread-Topic: [PATCH V5 00/16] Unified entry point for other blocks to
 interact with power
Thread-Index: AQHX79Ti7kfbNp5dQEmuSG2Ny2nQn6w0hc8Q
Date: Thu, 16 Dec 2021 04:17:20 +0000
Message-ID: <DM6PR12MB2619110E8CD278DF53A25D69E4779@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T04:17:17Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bac45364-fdb5-4dca-ba4c-df2b6ca43484;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 023ad25a-3dfe-4204-fa48-08d9c04af43b
x-ms-traffictypediagnostic: DM5PR12MB1771:EE_
x-microsoft-antispam-prvs: <DM5PR12MB177183FB636422AD2814AF59E4779@DM5PR12MB1771.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpMB/lLU7rIjJmn3xrkZnHq27W0nL6TUzDWeidm6r9OxgyXH931v6BM4O5We3JDTKUV0xOlKENM9KSPSNvjye90wN5FcZqqkLJB1ppv/DUyfK0yKtcJwkLGLDtah9Ua0yZuMx/ISzAx4syJIPU8hrvwwVckR9Jovcp+G0o/XtiUK7HKKUPLlq+d8EqTNCQhMMoN3Ny7rsNkCvw28Nh9AgypF60QxDIHfzlJOan0DfhmrjyV7DIWPQgz+27b/V3+U0nnXPQ2GSdzW1JSwj0XK0RfisMEbL2P1eSLcvLk2aYa2prNGw7wmvI9FQGkxlwPgX0NXn9TyChh9Csdp2XosiE3EZcnHi3bsD13xODu/+JzibkhHSYs/ynQm/80+ARG49N4qL6BAYqDn7p6+3ERCxbrsS50/etdEXt2tYsn4/9nYFqUvg+FFQrVEIgRJI4KNsfT4JRmKgldo/TUBgC+ROs1wlHk7Luk5kp1hCbEiyY3TbIjN+nM4YsFqbHwS9/nMqiy5YtugUYn/0buJ9Ak0BgOjbdLnn0mtrCg/5U5d4XJKkv4/e6nyQZdNv/8Y4rC/COUlZaunob7f+QjYXT3hCXYjf0ey01tc5GNEfuaSptr2N58FljtKfPHyoUMHo2154V5o4TKrSjzXz/nIJwQD1Z0C94yl9oA7xU0BK/MRERqPsi0VQzoDAW9+jJZ07ZXgKepvnvstqLUvDZwLrz4TlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(122000001)(316002)(5660300002)(86362001)(52536014)(71200400001)(6506007)(55016003)(7696005)(2906002)(6916009)(54906003)(33656002)(53546011)(4326008)(8936002)(76116006)(30864003)(66946007)(38100700002)(38070700005)(508600001)(66556008)(83380400001)(64756008)(66446008)(26005)(66476007)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnydPOkU1tygHKaRyBb0T8p/7h+lLgyY8qfE27BZg+QRbOfCYO70yTvgxmry?=
 =?us-ascii?Q?t4KDKbbkN1F2yzon7bND3RCK8AuhMe8855WG4A11FxOMl9eY5E+LW5eCWHpJ?=
 =?us-ascii?Q?lDx2vBWviaqkkUEm4nWsI1DECz4pX4qdcIF4+Um3KaLgTnaSMxt42WPXEU8c?=
 =?us-ascii?Q?W579nQmHn4acvVrRas8csEQJjD/50q7/go5eMrRV/RRnB60iNMKt6HC2XPEf?=
 =?us-ascii?Q?m80MJ4CpR4erRQmJ3BxPVz/4+tiz6bCw+PXewtFANsN+CLNi163PPFa2gG4I?=
 =?us-ascii?Q?7J2wNEnCNP6za5b+HyouJwFSRYm4ejdHD/6YcT75SfPp1Sc5FGSqCnvzbVF2?=
 =?us-ascii?Q?mU56/ojy1ISfkNuMY8rwniVwlrlQd3COp1n/DGQFXZ4k1JlDJcrWlHAHSN4C?=
 =?us-ascii?Q?YuM6JdUO+LOLxOXGOkiwxOceuW/t3711s4pYI9tc1vv8weOPbUcacyA6RHN6?=
 =?us-ascii?Q?6T1qVEI2wTXjMGLio3PeyXyK1NLePRidS7/pmLXdYK0CsrmCbvVtkClL3ktC?=
 =?us-ascii?Q?Wwu58pOV8BSXoSMpIkbZxblfqhrrHCThq1eklpaiPavSbnTpX+cXtihVbU/e?=
 =?us-ascii?Q?6DURdWFmyFrxCY8gzty9PtPTfgpuq3H3zfrfJcfYRUZJ3xwHGjS+oH1EylZN?=
 =?us-ascii?Q?fCsMddYoEglO1oRrp/SkOTY7okWU5Y3gnbkkTLvlhWviX8XR/iEulZP91v8T?=
 =?us-ascii?Q?PjH2IkywMgcpHZIfAJkOkBPTulEL2OFEXqTSP7b2iHAtrsGahLgW9af3UW3z?=
 =?us-ascii?Q?24/vltM0wl0+ocw38azdXGO7pYQt4y209Pe+m2FefXyENYii+75auM3L4MgT?=
 =?us-ascii?Q?giexEFokAja9p6H7prdWUPyE1Zyzyxjd/V/EaMD4X1Vtd7L6MVXAQagji6yY?=
 =?us-ascii?Q?wC/M/Na0VPU/WydqUk63TdMgMqAP0WGdZfE68bCxzRMnQ3Nic5ggNXv5dJGp?=
 =?us-ascii?Q?oMM2TwAw/O11jbPx1+0qQM784IYEn+1zPXfRixIE2OgSsB1Ke1AXbqqWOexc?=
 =?us-ascii?Q?T4n2fkbiqAKQYYTwmjaH/8CIum8+wPkbHq9WBHUoJi6bVhbHKgYMJWwf4lxQ?=
 =?us-ascii?Q?/KtKI6pwqJbLP9E8NPydKxnfOKPx0y19i0AXCBVvWb9y844aj5SsPtb9lPng?=
 =?us-ascii?Q?EkvcC1YtY9EsZGMaK6mWCknkKtORYoPpIhl+leCqNfhtlEf0/fhOfQfl5C4f?=
 =?us-ascii?Q?tURhrtG3gloW1OanYqqIiGTeUw59yiJTNtDK4rIGD3rXORkUXOisXP7Yu1p4?=
 =?us-ascii?Q?VLW3HRmw+EAQkifS5q65ecUGv9Ms8oTAGeV0kKLbr7RfIhktUxzNvvUa1ZUq?=
 =?us-ascii?Q?tZF923eRCDDBZWFREyH+bvjpNJSo7G0clYCwGktnaChGe1eTu2CH8oSQO6qU?=
 =?us-ascii?Q?s0cIp/thwoRydzJkeSwKysD7rHY43WYOaoZYm4b696gb3nqCVpgJ2vPhm0h0?=
 =?us-ascii?Q?00um/ZHRFCNXqbl4xQ5uppENSUrqLOKEftccMKE1R+KAIxL0ezu6t4ZA3he7?=
 =?us-ascii?Q?/75jm7NJzvFE5RDWz5KtXlatf6NmZPcHq2GCybCL8vkwYSHLXmW73rxMr5ey?=
 =?us-ascii?Q?qEpLdwj6HytDlYH6K3Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ad25a-3dfe-4204-fa48-08d9c04af43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 04:17:20.6140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esBuUjwcklKc7OP1+MM8JnmZCjZXFL2HUglbHI6w0M+anfUVgrXr2d/tXbpxE0N+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Lijo,

Please check the latest series. All your comments were addressed except tho=
se about return value(EOPNOTSUPP) on api unimplemented.
That I would like to handle separately(with follow-up patches).

BR
Evan
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Monday, December 13, 2021 11:52 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH V5 00/16] Unified entry point for other blocks to interac=
t
> with power
>=20
> There are several problems with current power implementations:
> 1. Too many internal details are exposed to other blocks. Thus to interac=
t
> with
>    power, they need to know which power framework is used(powerplay vs
> swsmu)
>    or even whether some API is implemented.
> 2. A lot of cross callings exist which make it hard to get a whole pictur=
e of
>    the code hierarchy. And that makes any code change/increment error-
> prone.
> 3. Many different types of lock are used. It is calculated there is total=
ly
>    13 different locks are used within power. Some of them are even design=
ed
> for
>    the same purpose.
>=20
> To ease the problems above, this patch series try to
> 1. provide unified entry point for other blocks to interact with power.
> 2. relocate some source code piece/headers to avoid cross callings.
> 3. enforce a unified lock protection on those entry point APIs above.
>    That makes the future optimization for unnecessary power locks possibl=
e.
>=20
> Evan Quan (16):
>   drm/amd/pm: do not expose implementation details to other blocks out
>     of power
>   drm/amd/pm: do not expose power implementation details to
> amdgpu_pm.c
>   drm/amd/pm: do not expose power implementation details to display
>   drm/amd/pm: do not expose those APIs used internally only in
>     amdgpu_dpm.c
>   drm/amd/pm: do not expose those APIs used internally only in si_dpm.c
>   drm/amd/pm: do not expose the API used internally only in kv_dpm.c
>   drm/amd/pm: create a new holder for those APIs used only by legacy
>     ASICs(si/kv)
>   drm/amd/pm: move pp_force_state_enabled member to amdgpu_pm
> structure
>   drm/amd/pm: optimize the amdgpu_pm_compute_clocks()
> implementations
>   drm/amd/pm: move those code piece used by Stoney only to
> smu8_hwmgr.c
>   drm/amd/pm: drop redundant or unused APIs and data structures
>   drm/amd/pm: do not expose the smu_context structure used internally in
>     power
>   drm/amd/pm: relocate the power related headers
>   drm/amd/pm: drop unnecessary gfxoff controls
>   drm/amd/pm: revise the performance level setting APIs
>   drm/amd/pm: unified lock protections in amdgpu_dpm.c
>=20
>  drivers/gpu/drm/amd/amdgpu/aldebaran.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    7 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   25 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   18 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    7 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |    5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    5 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |    2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  248 +-
>  drivers/gpu/drm/amd/include/amd_shared.h      |    2 -
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |    8 +
>  drivers/gpu/drm/amd/pm/Makefile               |   14 +-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 2467 ++++++++---------
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |   94 +
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  552 ++--
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  341 +--
>  .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |   32 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    |   32 +
>  .../pm/{powerplay =3D> legacy-dpm}/cik_dpm.h    |    0
>  .../amd/pm/{powerplay =3D> legacy-dpm}/kv_dpm.c |   47 +-
>  .../amd/pm/{powerplay =3D> legacy-dpm}/kv_dpm.h |    0
>  .../amd/pm/{powerplay =3D> legacy-dpm}/kv_smc.c |    0
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 1081 ++++++++
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |   38 +
>  .../amd/pm/{powerplay =3D> legacy-dpm}/ppsmc.h  |    0
>  .../pm/{powerplay =3D> legacy-dpm}/r600_dpm.h   |    0
>  .../amd/pm/{powerplay =3D> legacy-dpm}/si_dpm.c |  163 +-
>  .../amd/pm/{powerplay =3D> legacy-dpm}/si_dpm.h |   15 +-
>  .../amd/pm/{powerplay =3D> legacy-dpm}/si_smc.c |    0
>  .../{powerplay =3D> legacy-dpm}/sislands_smc.h  |    0
>  drivers/gpu/drm/amd/pm/powerplay/Makefile     |    4 -
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   51 +-
>  .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   10 +-
>  .../pm/{ =3D> powerplay}/inc/amd_powerplay.h    |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/cz_ppsmc.h |    0
>  .../amd/pm/{ =3D> powerplay}/inc/fiji_ppsmc.h   |    0
>  .../pm/{ =3D> powerplay}/inc/hardwaremanager.h  |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/hwmgr.h    |    3 -
>  .../{ =3D> powerplay}/inc/polaris10_pwrvirus.h  |    0
>  .../amd/pm/{ =3D> powerplay}/inc/power_state.h  |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/pp_debug.h |    0
>  .../amd/pm/{ =3D> powerplay}/inc/pp_endian.h    |    0
>  .../amd/pm/{ =3D> powerplay}/inc/pp_thermal.h   |    0
>  .../amd/pm/{ =3D> powerplay}/inc/ppinterrupt.h  |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/rv_ppsmc.h |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu10.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu10_driver_if.h  |    0
>  .../pm/{ =3D> powerplay}/inc/smu11_driver_if.h  |    0
>  .../gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7.h |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu71.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu71_discrete.h   |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu72.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu72_discrete.h   |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu73.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu73_discrete.h   |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu74.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu74_discrete.h   |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smu75.h    |    0
>  .../pm/{ =3D> powerplay}/inc/smu75_discrete.h   |    0
>  .../amd/pm/{ =3D> powerplay}/inc/smu7_common.h  |    0
>  .../pm/{ =3D> powerplay}/inc/smu7_discrete.h    |    0
>  .../amd/pm/{ =3D> powerplay}/inc/smu7_fusion.h  |    0
>  .../amd/pm/{ =3D> powerplay}/inc/smu7_ppsmc.h   |    0
>  .../gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu8.h |    0
>  .../amd/pm/{ =3D> powerplay}/inc/smu8_fusion.h  |    0
>  .../gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu9.h |    0
>  .../pm/{ =3D> powerplay}/inc/smu9_driver_if.h   |    0
>  .../{ =3D> powerplay}/inc/smu_ucode_xfer_cz.h   |    0
>  .../{ =3D> powerplay}/inc/smu_ucode_xfer_vi.h   |    0
>  .../drm/amd/pm/{ =3D> powerplay}/inc/smumgr.h   |    0
>  .../amd/pm/{ =3D> powerplay}/inc/tonga_ppsmc.h  |    0
>  .../amd/pm/{ =3D> powerplay}/inc/vega10_ppsmc.h |    0
>  .../inc/vega12/smu9_driver_if.h               |    0
>  .../amd/pm/{ =3D> powerplay}/inc/vega12_ppsmc.h |    0
>  .../amd/pm/{ =3D> powerplay}/inc/vega20_ppsmc.h |    0
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   94 +-
>  .../drm/amd/pm/{ =3D> swsmu}/inc/amdgpu_smu.h   |   16 +-
>  .../inc/interface}/smu11_driver_if_arcturus.h |    0
>  .../smu11_driver_if_cyan_skillfish.h          |    0
>  .../inc/interface}/smu11_driver_if_navi10.h   |    0
>  .../smu11_driver_if_sienna_cichlid.h          |    0
>  .../inc/interface}/smu11_driver_if_vangogh.h  |    0
>  .../inc/interface}/smu12_driver_if.h          |    0
>  .../interface}/smu13_driver_if_aldebaran.h    |    0
>  .../interface}/smu13_driver_if_yellow_carp.h  |    0
>  .../inc/interface}/smu_v11_5_pmfw.h           |    0
>  .../inc/interface}/smu_v11_8_pmfw.h           |    0
>  .../inc/interface}/smu_v13_0_1_pmfw.h         |    0
>  .../inc/message}/aldebaran_ppsmc.h            |    0
>  .../inc/message}/arcturus_ppsmc.h             |    0
>  .../inc/message}/smu_v11_0_7_ppsmc.h          |    0
>  .../inc/message}/smu_v11_0_ppsmc.h            |    0
>  .../inc/message}/smu_v11_5_ppsmc.h            |    0
>  .../inc/message}/smu_v11_8_ppsmc.h            |    0
>  .../inc/message}/smu_v12_0_ppsmc.h            |    0
>  .../inc/message}/smu_v13_0_1_ppsmc.h          |    0
>  .../pm/{ =3D> swsmu}/inc/smu_11_0_cdr_table.h   |    0
>  .../drm/amd/pm/{ =3D> swsmu}/inc/smu_types.h    |    0
>  .../drm/amd/pm/{ =3D> swsmu}/inc/smu_v11_0.h    |    0
>  .../pm/{ =3D> swsmu}/inc/smu_v11_0_7_pptable.h  |    0
>  .../pm/{ =3D> swsmu}/inc/smu_v11_0_pptable.h    |    0
>  .../drm/amd/pm/{ =3D> swsmu}/inc/smu_v12_0.h    |    0
>  .../drm/amd/pm/{ =3D> swsmu}/inc/smu_v13_0.h    |    0
>  .../pm/{ =3D> swsmu}/inc/smu_v13_0_pptable.h    |    0
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   10 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    9 +-
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   34 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   11 +-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   10 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   15 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |    4 +
>  117 files changed, 3232 insertions(+), 2264 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
>  create mode 100644
> drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
>  create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/cik_dpm.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/kv_dpm.c
> (99%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/kv_dpm.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/kv_smc.c
> (100%)
>  create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>  create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/r600_dpm.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/si_dpm.c
> (98%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/si_dpm.h
> (99%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-dpm}/si_smc.c
> (100%)
>  rename drivers/gpu/drm/amd/pm/{powerplay =3D> legacy-
> dpm}/sislands_smc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/amd_powerplay.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/cz_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/fiji_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> powerplay}/inc/hardwaremanager.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/hwmgr.h (99%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> powerplay}/inc/polaris10_pwrvirus.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/power_state.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/pp_debug.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/pp_endian.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/pp_thermal.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/ppinterrupt.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/rv_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu10.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu10_driver_if.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu11_driver_if.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu71.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu71_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu72.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu72_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu73.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu73_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu74.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu74_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu75.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu75_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7_common.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7_discrete.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7_fusion.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu7_ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu8.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu8_fusion.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu9.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smu9_driver_if.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/smumgr.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/tonga_ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/vega10_ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> powerplay}/inc/vega12/smu9_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/vega12_ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> powerplay}/inc/vega20_ppsmc.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/amdgpu_smu.h (98%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu11_driver_if_arcturus.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu11_driver_if_cyan_skillfish.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu11_driver_if_navi10.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu11_driver_if_sienna_cichlid.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu11_driver_if_vangogh.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu12_driver_if.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu13_driver_if_aldebaran.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu13_driver_if_yellow_carp.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu_v11_5_pmfw.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu_v11_8_pmfw.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/interface}/smu_v13_0_1_pmfw.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/aldebaran_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/arcturus_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v11_0_7_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v11_0_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v11_5_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v11_8_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v12_0_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{inc =3D>
> swsmu/inc/message}/smu_v13_0_1_ppsmc.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_11_0_cdr_table.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_types.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v11_0.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D>
> swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v11_0_pptable.h
> (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v12_0.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v13_0.h (100%)
>  rename drivers/gpu/drm/amd/pm/{ =3D> swsmu}/inc/smu_v13_0_pptable.h
> (100%)
>=20
> --
> 2.29.0
