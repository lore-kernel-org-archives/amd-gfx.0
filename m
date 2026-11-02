Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33652606A332
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p3mnd5tc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B023310EDD2;
	Mon,  2 Nov 2026 12:54:50 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1890A10EDD2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 12:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/cF67JdR9rKe93P6fa69DQ+7pa/0u2R//O7159tQtgDJL0Yy0DGFvG4KJQB4E/2AOSkre8Rt0++mfB1wjzP9wdc2aNusI9iULvatxuo0Np5Bq64cKDddvfjl3mvvGN17PmHhcsyA/LTWmCmTeJkyaWDQHqrvFj5OcJDxsKgCrxkM2NVFZ9D7MpYeOva8cgtHjsRGjuljCEm5R6N5yLDdT9wQU9subL8W92jilkmHO5rh3ZLP1iKRHOcFZ6ks/sS6glage8WRnlLRiw0Q+zFOP8j7JRqek2jCquI2uEdWlwGI/6AwNfna3/e0YP05kJrccX3mcKDSp8ixT4GPv+1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qSYikCaGcnShzdzSQWJQVgQeclfct8hAcdyW07c0U0=;
 b=k+sF12JpxsLm/qmtniyztBGqBVXkr4UF4OosAENnutfKeTmqhOhyxUM80QtWl7C87CJSz6+ATus/cMJ9iiS2235JWsbMAoidVcLunrcAI7vVOlFkCUTVO1t/WyBR4EtIPzcpmNhcLR097jmuLhGWOOivAxDV8Fzw2JIeRCIWYox3KmUAPNaQNA1/Nm5p3BwnzC+GZlEH5gSe+Zf0g7SXCgxLYH0DbmuOsvRb1rfzdpNkh0ktllnRbqk6haTQsSDlNhSWgh36aI/r5Ys4r2+gQW3mXQFIodNU4o6Q2O79vh6PYR14UiDc1QveYzjdNLkRkTMEzyKXoGxe+/Fijo9rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qSYikCaGcnShzdzSQWJQVgQeclfct8hAcdyW07c0U0=;
 b=p3mnd5tc+ipOKtDgLU+XGlyqoi0eFvskzGzyO7905d9Yl3J2XfoTHD0FErla3XpyXVLiFzk1aJ8S0Jw4jVwHq5YO1fx92b+zrYlRmHL6p4CbWcpJzTqal7K8a/x7PoLhhB/sRsL1dOSd5CjFMUSLzOh1fwIgWQZufBOm8lCbUbI=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:54:38 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:54:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Leo" <Leo.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdaBkfmnB7L1hUuEGxfRbBDPIFt7cawbsA
Date: Mon, 2 Nov 2026 12:54:38 +0000
Message-ID: <PH7PR12MB6000AD338F8B13ADEEAB4F83FB6A2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
 <20261030024747.3083509-3-Prike.Liang@amd.com>
In-Reply-To: <20261030024747.3083509-3-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Leo.Liu@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T12:52:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|IA1PR12MB7734:EE_
x-ms-office365-filtering-correlation-id: 96e92e46-1e7b-4dd6-8db6-08df38e07427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|261021123027099003|261021121427099003|260925021911599003|260925021311599003|260925022911599003|4143699003|11063799006|5023799004|56012099006|261009223027099003|261009220027099003|261009221727099003|261009223327099003|261009221227099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: v72dS2x1i7gvv4sxvPnjbS2iQ0bnGOJbpyU4RABGy/Alvjb1JsgbGmfmMnTQeIkPhJs0pjEmLWb5dM+ZKbg1xMeAdjZeiQrwXIIcNSOE6a4/qNN2QMouln3rdXBkQLAKFyz+wFy2f7kYIVlMON+dDoJpjuBA7LlR4B916PlOvKGF4TZe+Tm3SuhEQ/TmoJHqrzcBH3GTlhQIjDrpWhJau+DAf2HRx8pJVj9mPRt18Dt+UWqb6ErPqgsReyg1mnKDcHSQOyk0D9hG6/ZE/M59BJkaefn+cXCl7yiIHBqUXZ2TWCjprUMoill7C2vhaCKO2goJa/zR2iTYMsSujhUaOcddRZrCsCOMP2nTKl03NcnzwAa4VdS0Eyn5MZxBvh2lDP3mKrm6x5+ZixVedKuKhBhmzi6nzD+xPkP2SetQvTfYhskZu3+HjGBJkaBdQDrfevC2G2XezJ7vfuVi1Ki3NNcqHZ9OkkEau09CzWnfsVBoxlzhU6ni6KMcArN3zQ+UAHyG6TF1bsXXlGrNom9aCkdvNTEGccmwSpLbvcmna4m167sYlXE47ltQKplmb9/crkl5H0VApVR0p9B3HOaq5znfvcFGmjRUqY294AHWvjDViqHzRscR2NDDkW7Eb5/FQhSJk39IQBK1e9NqqRs/GIEn7jJSOTgvhQFOPSh8hiQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(261021123027099003)(261021121427099003)(260925021911599003)(260925021311599003)(260925022911599003)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261009220027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hOjLVpVQ/O+7d0FHX1Lv9B+44mkM8nqcC29wPuSNBnLsFU8AWgIIEdRiCYZK?=
 =?us-ascii?Q?K64THU+ScXvDp9GtDC2dXWUFMZGs7g/gvgDtewZqhiVBDn/mkfEU5o0pVLSy?=
 =?us-ascii?Q?AoMGs8ULFppK3MYUUz4WwZSLk4dVFdrKTbn8HWQ/vE5jDu2BHDHoTyT9w/rR?=
 =?us-ascii?Q?Zg4N8H02AIpPgkmgzIPf75IAZGSDj+u5mmjyLk+ujnOFnIIISwMxJ+owyzNC?=
 =?us-ascii?Q?QmhCopfW65LUNU2LVPDW4aohGFHPQ2kZrSekWoMTWjNLsC+ssIbujjIy3XjS?=
 =?us-ascii?Q?OTynBy8IoSBlZRZyUaFkJUFM+1FGFE8/dAZX13PrMGFE4N9+Y0KXsQKZbHb5?=
 =?us-ascii?Q?Beoi3rLf+QWKPw1M+AGiBwk86GZFefeK+tFI0psG6h1ooYfh0DD+4drsaQ6V?=
 =?us-ascii?Q?4c5E4QfRDNC84B4Fl6MLtBeeB1SFOMHy2vx3+/7y0jbqP7DMhCet/HaL7857?=
 =?us-ascii?Q?g5dQKLisn71L5XHJsargQdIh5NGFmJFPecfc3vcyujxUH45iFQFwhkDN79z0?=
 =?us-ascii?Q?3URdHuSKr8NvAEA97X/Mv1J1uubdnkCaPCyQOPc24F73Mi/2Gxh7Qb1YC3Pg?=
 =?us-ascii?Q?65VmoC6ykZjS0xnSvrpL7dxVe/vKcHugexjTL+Js/O90zaspLjmRIYSU8wXz?=
 =?us-ascii?Q?TQ/rcN8uF+LcDAx/9HA50Yno+uBTwhPBViGP+5RVDGeKHEaABiAC0r90AV72?=
 =?us-ascii?Q?1LGMi0mPPI+npg07UlZYiV6AXJllI/xCtRy/3U1PYVxw9D68I0lRO31llnJF?=
 =?us-ascii?Q?C2L45PA5twRK0bn4NzoxDDFhoTXNWypXFYRDNGGhOBldhEshIH1qkyV4HkPj?=
 =?us-ascii?Q?B9JyoL54d3y0qynvOkRYnrsFXEjr/PkJzi2unqrrBoSqNgdbe1F4NVbzxCWG?=
 =?us-ascii?Q?7myWFmrCBZnWuXdCv9xismA3e0Kc9xYPhhjLsCyRJZSGQcNLj/qJ/I4qr1v2?=
 =?us-ascii?Q?QgfPO9QP2WufH/Kp8Huw+8eC2HCGZtdIXtUMu1fElZpUWVYEk80tHASItxTp?=
 =?us-ascii?Q?iWjNqER9RVYR4Z7r56qIGMEMFkabpgr+BqeWtTv6DMlWxSupqMiYOPUrPqHS?=
 =?us-ascii?Q?noED5nuMf5ZIzwkQwiNcw3VVL5YIblWBsLj1aEryJALKKd1UUf/entosZ4jV?=
 =?us-ascii?Q?uAx0hyAayFuUWHO2kKDIT4PU9n48TzVvH94HpQEQ9ArWjPwkPwtpOKLfsiAQ?=
 =?us-ascii?Q?59VIbdawpTZok9iNFbL/W/m6OnpFLRtChN7xEDh5UCB/tt4+OgjgIXIHf9RY?=
 =?us-ascii?Q?B+OUHfd3L3hmWHPPHSPTIZmbDGc1VuH17Wj7WWobnv5UWM0BUadIfRVE2DIj?=
 =?us-ascii?Q?JAiVg/G6kkxBpjPLdeD1Pnwo5XUDuXXc0tVQzhOOhbBtOn+zNIWgVJI11Ysw?=
 =?us-ascii?Q?FFuop/bMaSWYeem7nb9bvWXF9leuwYc2ERNC8xZQuau6NPpCWLBSJsS2Cffu?=
 =?us-ascii?Q?Ls15xXeYWLm3L5cigSWoDJ0ElePwcc9wMqyp9tyM9p+i1qHSlMFevnTnqGlD?=
 =?us-ascii?Q?5T1y+dlZ/CBeytlXJ7bUpePsplH29DZoAf4z3MjyPgokA1+Twl0wVk6LKPPg?=
 =?us-ascii?Q?inXVOAKIrKU5YNG14RAINcj3mvhIV6LPqHrhnpBdSyFZq4pej27yi8SZ1TEB?=
 =?us-ascii?Q?zJ67c7O3PW7rFJ34v7Ttzdy9ptl8mYgDcqJhalFPIiGMRsEcj4W+J92vERSp?=
 =?us-ascii?Q?heC54MtqdTViw3ZkfGx2awyLZ8uuX01FqIN5eOXKghMLFdME?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e92e46-1e7b-4dd6-8db6-08df38e07427
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 12:54:38.1490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKjC+hEl/mLbXxrCS8eJeaMByV+LKd5/OOadCRu9ic28ABwYrgHP5mbaFKkIakfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi @Liu, Leo

Could you please take a look at patches 2 and 3 when you get a chance?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, October 30, 2026 10:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN =
idle
> work
>
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not =
wait for
> them either, since everything the workers depend on then becomes a depend=
ency of
> GPU recovery.
>
> Make the workers take reset_domain->sem for read, so they wait for a runn=
ing reset
> instead of touching the hardware. hw_fini/suspend, the hw_init error path=
s and
> begin_use, the latter for the IB tests, run from GPU recovery as well, so=
 only skip
> waiting for the idle work when the reset itself calls them. The reset hol=
ds the
> semaphore for write and would otherwise deadlock on a worker blocked on i=
t.
> Outside a reset the cancel stays synchronous as before.
>
> A device can also be torn down while a peer in its XGMI reset domain is b=
eing reset.
> hw_fini then doesn't wait for the worker either, and is skipped entirely =
if the peer's
> reset has already suspended the device.
> Cancel the idle work synchronously in early_fini, which only runs on tear=
down and
> before any hw_fini, so the worker is done before the hardware it touches =
is torn
> down.
>
> Update versions:
> v1: https://lists.freedesktop.org/archives/amd-gfx/2026-October/155441.ht=
ml
> v2: https://lists.freedesktop.org/archives/amd-gfx/2026-October/156119.ht=
ml
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com> Cc; Leo Liu
> <leo.liu@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 30 ++++++++++++++++++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 36 +++++++++++++++++++++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  2 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  5 ++--
> drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 ++--
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  5 ++--
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  5 ++--
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  5 ++--
> drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  5 ++--
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  5 ++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  5 ++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  5 ++--
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  5 ++--
>  24 files changed, 125 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 2b0e658b63b6..87f0ba6a79d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -95,9 +95,30 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>       return 0;
>  }
>
> +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block) {
> +     /* Called on teardown even if sw_init never ran */
> +     if (!ip_block->status.sw)
> +             return 0;
> +
> +     /* hw_fini may not wait while a peer in the reset domain resets */
> +     cancel_delayed_work_sync(&ip_block->adev->jpeg.idle_work);
> +
> +     return 0;
> +}
> +
> +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev) {
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(adev))
> +             cancel_delayed_work(&adev->jpeg.idle_work);
> +     else
> +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +}
> +
>  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)  {
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>
>       return 0;
>  }
> @@ -114,6 +135,9 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>       unsigned int fences =3D 0;
>       unsigned int i, j;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1U << i))
>                       continue;
> @@ -129,6 +153,8 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>       } else
>               schedule_delayed_work(&adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring) @@ -136,7 +162=
,7
> @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>       struct amdgpu_device *adev =3D ring->adev;
>
>       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       mutex_lock(&adev->jpeg.jpeg_pg_lock);
>       amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_JPEG, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 05d58e6bbfab..a473becb5def 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -156,6 +156,7 @@ struct amdgpu_jpeg {
>
>  int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);  int
> amdgpu_jpeg_sw_fini(struct amdgpu_device *adev);
> +int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block);
>  int amdgpu_jpeg_suspend(struct amdgpu_device *adev);  int
> amdgpu_jpeg_resume(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..6c12d8aa3c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -299,6 +299,26 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev,
> int i)
>       mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>  }
>
> +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block) {
> +     struct amdgpu_device *adev =3D ip_block->adev;
> +     int i;
> +
> +     /* Called on teardown even if sw_init never ran */
> +     if (!ip_block->status.sw)
> +             return 0;
> +
> +     /* hw_fini may not wait while a peer in the reset domain resets */
> +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> +             if (adev->vcn.harvest_config & (1 << i))
> +                     continue;
> +
> +             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +     }
> +
> +     return 0;
> +}
> +
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum
> vcn_ring_type type, uint32_t vcn_instance)  {
>       bool ret =3D false;
> @@ -459,6 +479,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device
> *adev)
>       mutex_unlock(&adev->vcn.workload_profile_mutex);
>  }
>
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst) {
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(vcn_inst->adev))
> +             cancel_delayed_work(&vcn_inst->idle_work);
> +     else
> +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)  {
>       struct amdgpu_vcn_inst *vcn_inst =3D
> @@ -470,6 +499,9 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       if (adev->vcn.harvest_config & (1 << i))
>               return;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_en=
c[j]);
>
> @@ -499,6 +531,8 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       } else {
>               schedule_delayed_work(&vcn_inst->idle_work,
> VCN_IDLE_TIMEOUT);
>       }
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring) @@ -507,7 +541,=
7
> @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>       struct amdgpu_vcn_inst *vcn_inst =3D &adev->vcn.inst[ring->me];
>
>       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vcn_inst);
>
>       mutex_lock(&vcn_inst->vcn_pg_lock);
>       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..509c83799a8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -522,10 +522,12 @@ enum vcn_ring_type {  int amdgpu_vcn_early_init(str=
uct
> amdgpu_device *adev, int i);  int amdgpu_vcn_sw_init(struct amdgpu_device=
 *adev,
> int i);  void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
> +int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block);
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);  int
> amdgpu_vcn_resume(struct amdgpu_device *adev, int i);  void
> amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);  void
> amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>                               enum vcn_ring_type type, uint32_t vcn_insta=
nce); diff -
> -git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index f03c1a37c8dd..1b498190954d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -166,7 +166,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -181,7 +181,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) @@ -792,6
> +792,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs =3D {
>       .early_init =3D jpeg_v2_0_early_init,
>       .sw_init =3D jpeg_v2_0_sw_init,
>       .sw_fini =3D jpeg_v2_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_0_hw_init,
>       .hw_fini =3D jpeg_v2_0_hw_fini,
>       .suspend =3D jpeg_v2_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 46293664fd28..80c79aeeb410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -227,7 +227,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -243,7 +243,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i)) @@ -665,6 +665,7 =
@@
> static const struct amd_ip_funcs jpeg_v2_5_ip_funcs =3D {
>       .early_init =3D jpeg_v2_5_early_init,
>       .sw_init =3D jpeg_v2_5_sw_init,
>       .sw_fini =3D jpeg_v2_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_5_hw_init,
>       .hw_fini =3D jpeg_v2_5_hw_fini,
>       .suspend =3D jpeg_v2_5_suspend,
> @@ -681,6 +682,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs =
=3D {
>       .early_init =3D jpeg_v2_5_early_init,
>       .sw_init =3D jpeg_v2_5_sw_init,
>       .sw_fini =3D jpeg_v2_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v2_5_hw_init,
>       .hw_fini =3D jpeg_v2_5_hw_fini,
>       .suspend =3D jpeg_v2_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 361d0f4b4bc7..3411a32d00ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -181,7 +181,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>
>       r =3D amdgpu_ring_test_helper(ring);
>       if (r)
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -196,7 +196,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS)) @@ -564,6
> +564,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs =3D {
>       .early_init =3D jpeg_v3_0_early_init,
>       .sw_init =3D jpeg_v3_0_sw_init,
>       .sw_fini =3D jpeg_v3_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v3_0_hw_init,
>       .hw_fini =3D jpeg_v3_0_hw_fini,
>       .suspend =3D jpeg_v3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 4e8eed2b62db..4a916cc2bd01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -210,7 +210,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -225,7 +225,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) @@ -
> 748,6 +748,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs =3D {
>       .early_init =3D jpeg_v4_0_early_init,
>       .sw_init =3D jpeg_v4_0_sw_init,
>       .sw_fini =3D jpeg_v4_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_hw_init,
>       .hw_fini =3D jpeg_v4_0_hw_fini,
>       .suspend =3D jpeg_v4_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 9f298c4ea8ff..6b62731495ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -443,7 +443,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -459,7 +459,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -1227,6
> +1227,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs =3D {
>       .early_init =3D jpeg_v4_0_3_early_init,
>       .sw_init =3D jpeg_v4_0_3_sw_init,
>       .sw_fini =3D jpeg_v4_0_3_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_3_hw_init,
>       .hw_fini =3D jpeg_v4_0_3_hw_fini,
>       .suspend =3D jpeg_v4_0_3_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index a1496412810c..109237055eba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -238,7 +238,7 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -254,7 +254,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i)) @@ -807,6 +807,7 =
@@
> static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs =3D {
>       .early_init =3D jpeg_v4_0_5_early_init,
>       .sw_init =3D jpeg_v4_0_5_sw_init,
>       .sw_fini =3D jpeg_v4_0_5_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v4_0_5_hw_init,
>       .hw_fini =3D jpeg_v4_0_5_hw_fini,
>       .suspend =3D jpeg_v4_0_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 1a4594d5d952..c0bacaafdf7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -178,7 +178,7 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -193,7 +193,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS)) @@ -683,6
> +683,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs =3D {
>       .early_init =3D jpeg_v5_0_0_early_init,
>       .sw_init =3D jpeg_v5_0_0_sw_init,
>       .sw_fini =3D jpeg_v5_0_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_0_hw_init,
>       .hw_fini =3D jpeg_v5_0_0_hw_fini,
>       .suspend =3D jpeg_v5_0_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index efdc537ec81e..9ae23235d16c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -314,7 +314,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -330,7 +330,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -887,6
> +887,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs =3D {
>       .late_init =3D NULL,
>       .sw_init =3D jpeg_v5_0_1_sw_init,
>       .sw_fini =3D jpeg_v5_0_1_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_1_hw_init,
>       .hw_fini =3D jpeg_v5_0_1_hw_fini,
>       .suspend =3D jpeg_v5_0_1_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index eb3dc9558e0d..0fc58d25abe1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -287,7 +287,7 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -303,7 +303,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE) @@ -871,6
> +871,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs =3D {
>       .late_init =3D NULL,
>       .sw_init =3D jpeg_v5_0_2_sw_init,
>       .sw_fini =3D jpeg_v5_0_2_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_0_2_hw_init,
>       .hw_fini =3D jpeg_v5_0_2_hw_fini,
>       .suspend =3D jpeg_v5_0_2_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 0cbb2b8a7e78..d5bc6820ad8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -161,7 +161,7 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       return r;
>  }
>
> @@ -176,7 +176,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> @@ -671,6 +671,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs=
 =3D {
>       .early_init =3D jpeg_v5_3_0_early_init,
>       .sw_init =3D jpeg_v5_3_0_sw_init,
>       .sw_fini =3D jpeg_v5_3_0_sw_fini,
> +     .early_fini =3D amdgpu_jpeg_early_fini,
>       .hw_init =3D jpeg_v5_3_0_hw_init,
>       .hw_fini =3D jpeg_v5_3_0_hw_fini,
>       .suspend =3D jpeg_v5_3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index b3e63d6e79a8..897310d04f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       if (r)
>               return r;
>
> -     /* Override the work func */
> -     adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_handle=
r;
> +     /* Own lockdep class, this work is still cancelled synchronously */
> +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> +vcn_v1_0_idle_work_handler);
>
>       amdgpu_vcn_setup_ucode(adev, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 12ac20484396..706089744803 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -310,7 +310,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>
>  error:
> -     cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
> +     amdgpu_vcn_cancel_idle_work(adev->vcn.inst);
>       return r;
>  }
>
> @@ -326,7 +326,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
>
> -     cancel_delayed_work_sync(&vinst->idle_work);
> +     amdgpu_vcn_cancel_idle_work(vinst);
>
>       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>           (vinst->cur_state !=3D AMD_PG_STATE_GATE && @@ -2103,6 +2103,7
> @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs =3D {
>       .early_init =3D vcn_v2_0_early_init,
>       .sw_init =3D vcn_v2_0_sw_init,
>       .sw_fini =3D vcn_v2_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v2_0_hw_init,
>       .hw_fini =3D vcn_v2_0_hw_fini,
>       .suspend =3D vcn_v2_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 2b2abe689508..c3f2265f50fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block
> *ip_block)
>               if (r)
>                       return r;
>
> -             /* Override the work func */
> -             adev->vcn.inst[j].idle_work.work.func =3D vcn_v2_5_idle_wor=
k_handler;
> +             /* Own lockdep class, this work is still cancelled synchron=
ously */
> +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> +vcn_v2_5_idle_work_handler);
>
>               amdgpu_vcn_setup_ucode(adev, j);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 6543f21daa1e..8f256d962ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -433,7 +433,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -457,7 +457,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -2366,6 +2366,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs =
=3D {
>       .early_init =3D vcn_v3_0_early_init,
>       .sw_init =3D vcn_v3_0_sw_init,
>       .sw_fini =3D vcn_v3_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v3_0_hw_init,
>       .hw_fini =3D vcn_v3_0_hw_fini,
>       .suspend =3D vcn_v3_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 8b5646297c2e..b68746b37a15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -358,7 +358,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -382,7 +382,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -2287,6 +2287,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs =
=3D {
>       .early_init =3D vcn_v4_0_early_init,
>       .sw_init =3D vcn_v4_0_sw_init,
>       .sw_fini =3D vcn_v4_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_hw_init,
>       .hw_fini =3D vcn_v4_0_hw_fini,
>       .suspend =3D vcn_v4_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 0c58ca25d7b5..a1bfcece38fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -404,7 +404,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -425,7 +425,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE); @@ -
> 2035,6 +2035,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs =
=3D {
>       .late_init =3D vcn_v4_0_3_late_init,
>       .sw_init =3D vcn_v4_0_3_sw_init,
>       .sw_fini =3D vcn_v4_0_3_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_3_hw_init,
>       .hw_fini =3D vcn_v4_0_3_hw_fini,
>       .suspend =3D vcn_v4_0_3_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index a6eaa57ec2ee..fb5336f46ac9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -335,7 +335,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -1690,6 +1690,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_func=
s =3D
> {
>       .early_init =3D vcn_v4_0_5_early_init,
>       .sw_init =3D vcn_v4_0_5_sw_init,
>       .sw_fini =3D vcn_v4_0_5_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v4_0_5_hw_init,
>       .hw_fini =3D vcn_v4_0_5_hw_fini,
>       .suspend =3D vcn_v4_0_5_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 055729a42094..b18c61e6d099 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -299,7 +299,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> @@ -1476,6 +1476,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_func=
s =3D
> {
>       .early_init =3D vcn_v5_0_0_early_init,
>       .sw_init =3D vcn_v5_0_0_sw_init,
>       .sw_fini =3D vcn_v5_0_0_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_0_hw_init,
>       .hw_fini =3D vcn_v5_0_0_hw_fini,
>       .suspend =3D vcn_v5_0_0_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 55a4b2f9463f..a5d3ee06fced 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -351,7 +351,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -372,7 +372,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> @@ -1660,6 +1660,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_func=
s =3D
> {
>       .late_init =3D vcn_v5_0_1_late_init,
>       .sw_init =3D vcn_v5_0_1_sw_init,
>       .sw_fini =3D vcn_v5_0_1_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_1_hw_init,
>       .hw_fini =3D vcn_v5_0_1_hw_fini,
>       .suspend =3D vcn_v5_0_1_suspend,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ea6cdbcb6352..1b7897bb9953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -266,7 +266,7 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block
> *ip_block)
>  error:
>       while (i >=3D 0) {
>               if (!(adev->vcn.harvest_config & (1 << i)))
> -                     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_wo=
rk);
> +                     amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               i--;
>       }
>       return r;
> @@ -287,7 +287,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> @@ -1451,6 +1451,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_func=
s =3D
> {
>       .late_init =3D NULL,
>       .sw_init =3D vcn_v5_0_2_sw_init,
>       .sw_fini =3D vcn_v5_0_2_sw_fini,
> +     .early_fini =3D amdgpu_vcn_early_fini,
>       .hw_init =3D vcn_v5_0_2_hw_init,
>       .hw_fini =3D vcn_v5_0_2_hw_fini,
>       .suspend =3D vcn_v5_0_2_suspend,
> --
> 2.34.1

