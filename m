Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FE6CA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 14:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D13D10E41B;
	Tue, 12 Sep 2023 14:40:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815A910E231
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 14:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogfbQNBDLEETIuhCucvOt8ALSIGaBSO5JRzd+iPGlRmOW9CUP83QV2sjj8QKP7GFsKAVKjibQlJ5YpsFORsqbxESS6B6hrYn3lattd3sAJsm4JCF+E4fabYlnaZ2iSpWduN0lgLRNskhIRebcdc0XYtJGUokrsrGaEiPwY6nFhbzmkppc/chRcNSCNiefs86GMyS4KSxm5fKufANYMPzCl/QK3lXBB/X1cDCuTeIuJwV6fDTjIKQcG8QRi/cXIgHwyfGe5N4PiPjF5eg6Na+Tvodo3wU3B5UzryZueloR6nNN7z9/uvWFN/86iFpbYXFFmqyEPJkxKzyjjo+Hl1fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy5ViyiILe3+W0s3gcgYOs5Hy5lt7j4ROGhyrJpFmVo=;
 b=DXNXd3h1yeN0frrTxKypk1LaIm8KfcNOyRuo/rgEvpvuI/40yX3NxldUa3qKJJv6+vXtUHusTsAuRkHHWYKqDZ3DOIM61EvTbhQLEiS0E898HHaiEG2rkqqLtUc9ZONJSCV3bRLo93haAodTTNJVvyO1mC+gaxvcC5ObK0fbL0KDlgm4q6HQq40BnAhO2NTDgpwhouoZSizVEaqSCJeQpYWTngzGYGPzAE0KGhhgJ3DoK45TTm0cYV2kQXVTvGtJiBOmdGgJBbheSQJa1QVn13rvy/5Awoclr/K3T/l2oSB+drFr+6+uFvkp1SjmJXr9kPghe4GJ4BePNQi2WVlshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy5ViyiILe3+W0s3gcgYOs5Hy5lt7j4ROGhyrJpFmVo=;
 b=zYYOdi18vOolcaOVb8RHVg6ljOvj5pfgs4NacPn0TxPEqLNeYa5fCaMcHcWpMqfKtchXUU7Vzt3004/Z+Zq0URcFAsXQHBuPurTewS4LnVRPODU17U4kxkCzdQrsoX7RpeopbN2uwCZGOENvSzfVsxyB0a9uOQKuVjamL0VTnDI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 14:17:37 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::629e:e981:228d:3822%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:17:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use function for IP version check
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use function for IP version check
Thread-Index: AQHZ5KV2zyqUiJkyFk+CkHu6yiapT7AXPl9W
Date: Tue, 12 Sep 2023 14:17:37 +0000
Message-ID: <BL1PR12MB5144F20A5BD6A69093463C63F7F1A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230911114503.1124617-1-lijo.lazar@amd.com>
In-Reply-To: <20230911114503.1124617-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-12T14:17:35.908Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8258:EE_
x-ms-office365-filtering-correlation-id: 4ba70438-7725-4be7-8a9b-08dbb39b0416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXzX25yvGIVVM4zUVza9sH1mD5g1D5et969a/tzWx4zm7WGXmQAocvn6NP9pkcYkYxvBygBIb2borHjIgjmJiIjcWtC21URz8TUBPF2yrlIGS7N6tlGkTKj5osVLN7bFeA3ziWX9YksytWZ1tJD0mVYxTe+b3LVYtylIZ27OZlptbwfYjN+BlH3NKHx/d7rNzwGf0TqNQcLiOq0eu8bMYv6Ji2nC745tkWuyzoVh8zTOqb/qJyRimmRehbEaK65wDVqF7dYu27tpNow9RV/YJOF++PGU5TExAB8DVXdHPw91vKnx4PDXC/Ht6ihxppQdQNG71LeT4XBKl4Q8UJdshcOsYZNR6ZjOk7tSuOSwvrKnzyZ9lDsNUcLO0NGIQKxvrSRxPs+E0/nkUd5ZB8lVt0L7qqgk4gssKtCr1ZzJWYMBnVrmgJC6g4zla4IowI9yN7/g+QHwpgqMy9jJOdPXcYgLTaPyMoZZvej3cDS9YYWEHSdUdhzJ9Rm/WxfMpbaSxg3lsMzB+R4h7S+VdKVI1tkd8cjiVCSruHwwYZNpnzlT3oHAebm1j695stvlu8m4RVGo1ceFEfzZGN30ToyuAWXvcL7FTErumARPGK3eRFm4nSUXDDdCU9zWlADGFlAoc0SkPHjBU9MieDdtdoGUAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(122000001)(38100700002)(55016003)(38070700005)(33656002)(86362001)(478600001)(2906002)(64756008)(110136005)(9686003)(71200400001)(53546011)(6506007)(8676002)(7696005)(8936002)(4326008)(52536014)(26005)(5660300002)(30864003)(66446008)(66556008)(66476007)(41300700001)(66946007)(76116006)(316002)(19627405001)(83380400001)(21314003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lNa5R5jab+qzOpgCyPPqoKEwR4HS8xbGWiPx2EKMjpYVRa/Rev8twehvOsI1?=
 =?us-ascii?Q?OskPJaFqclAyIznNqi2S+cbj6qI/CNYanqQf6XaP/FcnWDFsZz8VViFY84Wx?=
 =?us-ascii?Q?rtdO20Eybdc7NUteqzZAmtRg5A2XldSELqPEz83N6HkNPBND/2JBaTsjSN4d?=
 =?us-ascii?Q?mH4XkM7LZFAR4bJsnCRykQafO/mvFRdh1MpYuEd7Hc3ANm9hNMhVxNA3hHiN?=
 =?us-ascii?Q?mLFxMBk4Nl2SRP3L1/cVX6uSTTT8JLZNTELA+yJ/J/W/3CsTk40N4QYlijbl?=
 =?us-ascii?Q?3D3yQMcdtW0Dn96UsuKx09sQBJbmIdjmIPPzz3Oe4JGat0R+4192GoZU0oUj?=
 =?us-ascii?Q?4Wo0IoqKRHQdPjQgVaBaQJwEZV+n3RI5dWBH/Nyd6E4KFDYb6Tw1LvbG2rPy?=
 =?us-ascii?Q?QJwVDGNMwEz0JpzzNWRUVM/6c3AIKMm88JCy0iPV+pWmA5SvHZxJCWM7J3Ew?=
 =?us-ascii?Q?1m8xl+uFfil7l06bUXIaEQkMTJ0iN/+9oomKPWIC168+gPyhDuo9SIJIuivV?=
 =?us-ascii?Q?coUQ6ynQJhEd+NhXWdT8+p+A3JQfWCNeNkrYNZ6YbI0rzCBn3WIx1Iqo82Mc?=
 =?us-ascii?Q?4DNI7fNgwIJRPPxqb2Rklcst5pIxajFpBhtKiimfpPzMC4cEvXoATdNwEpdA?=
 =?us-ascii?Q?ebPPNcgkbDxjdUGxQr+fhIe5fnf4bF7MKaVWtK8c7zd+fN+jbkYOLpCmYPJu?=
 =?us-ascii?Q?SajDJGdf+AzxUXaoAO3h0WWj+WWRpkpDsGVTnlg6/D7kJRb9VKlvbzZWymbw?=
 =?us-ascii?Q?67ALFPSN87P4xWPUWYmUihyp13tVLwnrIRkqKD+Hel1X0kpy38CG9x8uEMC2?=
 =?us-ascii?Q?ebf8Xd+6vliCxyQbLoqD2Yv9nUGf17PbdgBEl3VAzayKIgwnE08cgNFze9d6?=
 =?us-ascii?Q?YqGsFPKALW9JmibsZyPw0pTyR3ounZo9vvJSR83iP6hA01/yIKNYZUg3iNhD?=
 =?us-ascii?Q?X5okYSMphP3TS/1a4dD3rtpYOlF9PZyb2Z3Bq+WHQPLWfR7PEF52OudxdZYm?=
 =?us-ascii?Q?Os0M7EhGkRfSJ0niZ7KFyIEtjSieuC275fJ52/fwf8vCqBHD40J+NfdHwU0k?=
 =?us-ascii?Q?s23GtnNFu4qweYYFTXFTqTHFpgNLkaKIOTyhcMyCaFcOkIMZii7LMhlEwOGF?=
 =?us-ascii?Q?py+W0cb4HvFKvfqAM1fyuWYCHn+i90bJaM5qikFcqnUvEbP1SnwxKqUFeKFe?=
 =?us-ascii?Q?OdcTGNbD4Xdp5Rj8GwhlICiReztZoFzR0/mfyAJ8b9mEDLoYzBaI9auj0kOq?=
 =?us-ascii?Q?NRvDMjjvMdoekxwaXB+IpK+kez1cgSyk0PSa/UvZ8bGyk711rkqhxeJbwBnw?=
 =?us-ascii?Q?zVIipwgHO6dt3LDLrRbysUh4o63VYmxOJ9HNijy/f75fv1QI0ldhVMuu1XnS?=
 =?us-ascii?Q?t6aubuDctrlmfDYVo+V1OA4mPOLE2GP8x95Q2Wek9N9uroomxAOipNcH+F7O?=
 =?us-ascii?Q?YP9rpVBadyg/vBNRudtoFZYGIgCk93xmjOmBdtvL1SGPL4AbLc/GNOIDo4S9?=
 =?us-ascii?Q?q3ZTGF3mBp2g6KI6vBzDdiRPu5WxWWEIOofoav7/Zy9O5D3NG5FKvMXzpKf7?=
 =?us-ascii?Q?PaGSmZ0IDZECNst+Few=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144F20A5BD6A69093463C63F7F1ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba70438-7725-4be7-8a9b-08dbb39b0416
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 14:17:37.2442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylV4KDf8j6/WMJBDxQHeMySbLm9/j+vIfQu0efKJN8/7jb0NRV4TxMuuNiWBt+DAOKSB9wSHESoKI5r1pYgTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
X-Mailman-Approved-At: Tue, 12 Sep 2023 14:40:08 +0000
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144F20A5BD6A69093463C63F7F1ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, September 11, 2023 7:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Use function for IP version check

Use an inline function for version check. Gives more flexibility to
handle any format changes.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 29 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 92 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 28 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 12 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 48 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 38 ++++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 15 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v1_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 98 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 27 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 83 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c      | 13 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 28 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 96 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c         | 18 ++--
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        | 10 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       | 12 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        | 10 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  7 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 48 +++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  7 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  9 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  3 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 27 +++--
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 12 +--
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 14 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  7 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 14 +--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 12 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 10 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 12 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 46 +++++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 63 +++++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 32 +++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  8 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 18 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  8 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 18 ++--
 94 files changed, 714 insertions(+), 593 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index 5d2516210a3a..02f4c6f9d4f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -35,7 +35,7 @@ static bool aldebaran_is_mode2_default(struct amdgpu_rese=
t_control *reset_ctl)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->=
handle;

-       if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
2) &&
              adev->gmc.xgmi.connected_to_cpu))
                 return true;

@@ -154,7 +154,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
         if (reset_device_list =3D=3D NULL)
                 return -EINVAL;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2=
) &&
             reset_context->hive =3D=3D NULL) {
                 /* Wrong context, return error */
                 return -EINVAL;
@@ -335,7 +335,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,
         if (reset_device_list =3D=3D NULL)
                 return -EINVAL;

-       if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] =3D=3D
+       if (amdgpu_ip_version(reset_context->reset_req_dev, MP1_HWIP, 0) =
=3D=3D
                     IP_VERSION(13, 0, 2) &&
             reset_context->hive =3D=3D NULL) {
                 /* Wrong context, return error */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3a86d11d1605..927c049e6132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1101,6 +1101,12 @@ struct amdgpu_device {
         uint32_t                        aid_mask;
 };

+static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
+                                        uint8_t ip, uint8_t inst)
+{
+       return adev->ip_versions[ip][inst];
+}
+
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
 {
         return container_of(ddev, struct amdgpu_device, ddev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 26ff5f8d9795..38b5457baded 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -707,7 +707,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_devic=
e *adev, bool idle)
         /* Temporary workaround to fix issues observed in some
          * compute applications when GFXOFF is enabled on GFX11.
          */
-       if (IP_VERSION_MAJ(adev->ip_versions[GC_HWIP][0]) =3D=3D 11) {
+       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11) =
{
                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
                 amdgpu_gfx_off_ctrl(adev, idle);
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index d67d003bada2..b61a32d6af4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -658,7 +658,7 @@ static int kgd_gfx_v11_validate_trap_override_request(s=
truct amdgpu_device *adev
                                 KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
                                 KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION;

-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 4))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 4))
                 *trap_mask_supported |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_S=
TART |
                                         KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END=
;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 04b8c7dacd30..51011e8ee90d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -677,7 +677,7 @@ void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_dev=
ice *adev,
         int i;
         uint32_t data =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_C=
NTL));

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1))
                 data =3D REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STALL_VMI=
D,
                                                         stall ? 1 << vmid =
: 0);
         else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 3d540b0cf0e1..ca56b5a543b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1003,8 +1003,8 @@ static int amdgpu_device_asic_init(struct amdgpu_devi=
ce *adev)

         amdgpu_asic_pre_asic_init(adev);

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3) ||
-           adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)) =
{
                 amdgpu_psp_wait_for_bootloader(adev);
                 ret =3D amdgpu_atomfirmware_asic_init(adev, true);
                 return ret;
@@ -2845,7 +2845,7 @@ static void amdgpu_device_smu_fini_early(struct amdgp=
u_device *adev)
 {
         int i, r;

-       if (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0))
                 return;

         for (i =3D 0; i < adev->num_ip_blocks; i++) {
@@ -3098,8 +3098,10 @@ static int amdgpu_device_ip_suspend_phase2(struct am=
dgpu_device *adev)

                 /* SDMA 5.x+ is part of GFX power domain so it's covered b=
y GFXOFF */
                 if (adev->in_s0ix &&
-                   (adev->ip_versions[SDMA0_HWIP][0] >=3D IP_VERSION(5, 0,=
 0)) &&
-                   (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_SDMA))
+                   (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >=3D
+                    IP_VERSION(5, 0, 0)) &&
+                   (adev->ip_blocks[i].version->type =3D=3D
+                    AMD_IP_BLOCK_TYPE_SDMA))
                         continue;

                 /* Once swPSP provides the IMU, RLC FW binaries to TOS dur=
ing cold-boot.
@@ -3590,8 +3592,8 @@ static void amdgpu_device_set_mcbp(struct amdgpu_devi=
ce *adev)
                 adev->gfx.mcbp =3D true;
         else if (amdgpu_mcbp =3D=3D 0)
                 adev->gfx.mcbp =3D false;
-       else if ((adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 0, 0)) &=
&
-                (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
+       else if ((amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 0,=
 0)) &&
+                (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 0, 0=
)) &&
                  adev->gfx.num_gfx_rings)
                 adev->gfx.mcbp =3D true;

@@ -3811,7 +3813,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
          * internal path natively support atomics, set have_atomics_suppor=
t to true.
          */
         } else if ((adev->flags & AMD_IS_APU) &&
-                  (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))) {
+                  (amdgpu_ip_version(adev, GC_HWIP, 0) >
+                   IP_VERSION(9, 0, 0))) {
                 adev->have_atomics_support =3D true;
         } else {
                 adev->have_atomics_support =3D
@@ -5444,8 +5447,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                         adev->asic_reset_res =3D r;

                 /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need =
resume ras during reset */
-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2=
) ||
-                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, =
3))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(9, 4, 2) ||
+                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
1, 0, 3))
                         amdgpu_ras_resume(adev);
         } else {
                 r =3D amdgpu_do_asic_reset(device_list_handle, reset_conte=
xt);
@@ -5470,7 +5474,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                         drm_sched_start(&ring->sched, true);
                 }

-               if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] !=3D =
IP_VERSION(11, 0, 3))
+               if (adev->enable_mes &&
+                   amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(11,=
 0, 3))
                         amdgpu_mes_self_test(tmp_adev);

                 if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) &&=
 !job_signaled)
@@ -6147,7 +6152,7 @@ bool amdgpu_device_has_display_hardware(struct amdgpu=
_device *adev)
                 return true;
         default:
                 /* IP discovery */
-               if (!adev->ip_versions[DCE_HWIP][0] ||
+               if (!amdgpu_ip_version(adev, DCE_HWIP, 0) ||
                     (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
                         return false;
                 return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 9ab33b0bbbad..430ee7f64a97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -311,8 +311,8 @@ static void amdgpu_discovery_harvest_config_quirk(struc=
t amdgpu_device *adev)
          * So far, apply this quirk only on those Navy Flounder boards whi=
ch
          * have a bad harvest table of VCN config.
          */
-       if ((adev->ip_versions[UVD_HWIP][1] =3D=3D IP_VERSION(3, 0, 1)) &&
-               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2))=
) {
+       if ((amdgpu_ip_version(adev, UVD_HWIP, 1) =3D=3D IP_VERSION(3, 0, 1=
)) &&
+           (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 2=
))) {
                 switch (adev->pdev->revision) {
                 case 0xC1:
                 case 0xC2:
@@ -1363,8 +1363,8 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu=
_device *adev)
          * so read harvest bit per IP data structure to set
          * harvest configuration.
          */
-       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0) &&
-           adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 3)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 2, 0) &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 3)) {
                 if ((adev->pdev->device =3D=3D 0x731E &&
                         (adev->pdev->revision =3D=3D 0xC6 ||
                          adev->pdev->revision =3D=3D 0xC7)) ||
@@ -1607,7 +1607,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgp=
u_device *adev)
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *ade=
v)
 {
         /* what IP to use for this? */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 1):
@@ -1645,7 +1645,7 @@ static int amdgpu_discovery_set_common_ip_blocks(stru=
ct amdgpu_device *adev)
         default:
                 dev_err(adev->dev,
                         "Failed to add common ip block(GC_HWIP:0x%x)\n",
-                       adev->ip_versions[GC_HWIP][0]);
+                       amdgpu_ip_version(adev, GC_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1654,7 +1654,7 @@ static int amdgpu_discovery_set_common_ip_blocks(stru=
ct amdgpu_device *adev)
 static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 {
         /* use GC or MMHUB IP version */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 1):
@@ -1690,9 +1690,8 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct =
amdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
                 break;
         default:
-               dev_err(adev->dev,
-                       "Failed to add gmc ip block(GC_HWIP:0x%x)\n",
-                       adev->ip_versions[GC_HWIP][0]);
+               dev_err(adev->dev, "Failed to add gmc ip block(GC_HWIP:0x%x=
)\n",
+                       amdgpu_ip_version(adev, GC_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1700,7 +1699,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct =
amdgpu_device *adev)

 static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[OSSSYS_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, OSSSYS_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
         case IP_VERSION(4, 0, 1):
         case IP_VERSION(4, 1, 0):
@@ -1733,7 +1732,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct a=
mdgpu_device *adev)
         default:
                 dev_err(adev->dev,
                         "Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
-                       adev->ip_versions[OSSSYS_HWIP][0]);
+                       amdgpu_ip_version(adev, OSSSYS_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1741,7 +1740,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct a=
mdgpu_device *adev)

 static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
                 amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
                 break;
@@ -1787,7 +1786,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct =
amdgpu_device *adev)
         default:
                 dev_err(adev->dev,
                         "Failed to add psp ip block(MP0_HWIP:0x%x)\n",
-                       adev->ip_versions[MP0_HWIP][0]);
+                       amdgpu_ip_version(adev, MP0_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1795,7 +1794,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct =
amdgpu_device *adev)

 static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
         case IP_VERSION(10, 0, 0):
         case IP_VERSION(10, 0, 1):
@@ -1836,7 +1835,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct =
amdgpu_device *adev)
         default:
                 dev_err(adev->dev,
                         "Failed to add smu ip block(MP1_HWIP:0x%x)\n",
-                       adev->ip_versions[MP1_HWIP][0]);
+                       amdgpu_ip_version(adev, MP1_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1861,8 +1860,8 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)
                 return 0;

 #if defined(CONFIG_DRM_AMD_DC)
-       if (adev->ip_versions[DCE_HWIP][0]) {
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+       if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                 case IP_VERSION(2, 0, 2):
@@ -1888,11 +1887,11 @@ static int amdgpu_discovery_set_display_ip_blocks(s=
truct amdgpu_device *adev)
                 default:
                         dev_err(adev->dev,
                                 "Failed to add dm ip block(DCE_HWIP:0x%x)\=
n",
-                               adev->ip_versions[DCE_HWIP][0]);
+                               amdgpu_ip_version(adev, DCE_HWIP, 0));
                         return -EINVAL;
                 }
-       } else if (adev->ip_versions[DCI_HWIP][0]) {
-               switch (adev->ip_versions[DCI_HWIP][0]) {
+       } else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
+               switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
                 case IP_VERSION(12, 0, 0):
                 case IP_VERSION(12, 0, 1):
                 case IP_VERSION(12, 1, 0):
@@ -1904,7 +1903,7 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)
                 default:
                         dev_err(adev->dev,
                                 "Failed to add dm ip block(DCI_HWIP:0x%x)\=
n",
-                               adev->ip_versions[DCI_HWIP][0]);
+                               amdgpu_ip_version(adev, DCI_HWIP, 0));
                         return -EINVAL;
                 }
         }
@@ -1914,7 +1913,7 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)

 static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 1):
@@ -1952,9 +1951,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
                 break;
         default:
-               dev_err(adev->dev,
-                       "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
-                       adev->ip_versions[GC_HWIP][0]);
+               dev_err(adev->dev, "Failed to add gfx ip block(GC_HWIP:0x%x=
)\n",
+                       amdgpu_ip_version(adev, GC_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -1962,7 +1960,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)

 static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
         case IP_VERSION(4, 0, 1):
         case IP_VERSION(4, 1, 0):
@@ -2002,7 +2000,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct=
 amdgpu_device *adev)
         default:
                 dev_err(adev->dev,
                         "Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
-                       adev->ip_versions[SDMA0_HWIP][0]);
+                       amdgpu_ip_version(adev, SDMA0_HWIP, 0));
                 return -EINVAL;
         }
         return 0;
@@ -2010,8 +2008,8 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct=
 amdgpu_device *adev)

 static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 {
-       if (adev->ip_versions[VCE_HWIP][0]) {
-               switch (adev->ip_versions[UVD_HWIP][0]) {
+       if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
+               switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
                 case IP_VERSION(7, 0, 0):
                 case IP_VERSION(7, 2, 0):
                         /* UVD is not supported on vega20 SR-IOV */
@@ -2021,10 +2019,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
                 default:
                         dev_err(adev->dev,
                                 "Failed to add uvd v7 ip block(UVD_HWIP:0x=
%x)\n",
-                               adev->ip_versions[UVD_HWIP][0]);
+                               amdgpu_ip_version(adev, UVD_HWIP, 0));
                         return -EINVAL;
                 }
-               switch (adev->ip_versions[VCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
                 case IP_VERSION(4, 0, 0):
                 case IP_VERSION(4, 1, 0):
                         /* VCE is not supported on vega20 SR-IOV */
@@ -2034,11 +2032,11 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
                 default:
                         dev_err(adev->dev,
                                 "Failed to add VCE v4 ip block(VCE_HWIP:0x=
%x)\n",
-                               adev->ip_versions[VCE_HWIP][0]);
+                               amdgpu_ip_version(adev, VCE_HWIP, 0));
                         return -EINVAL;
                 }
         } else {
-               switch (adev->ip_versions[UVD_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                         amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_bloc=
k);
@@ -2089,7 +2087,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)
                 default:
                         dev_err(adev->dev,
                                 "Failed to add vcn/jpeg ip block(UVD_HWIP:=
0x%x)\n",
-                               adev->ip_versions[UVD_HWIP][0]);
+                               amdgpu_ip_version(adev, UVD_HWIP, 0));
                         return -EINVAL;
                 }
         }
@@ -2098,7 +2096,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)

 static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -2136,7 +2134,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)

 static void amdgpu_discovery_init_soc_config(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 3):
                 aqua_vanjaram_init_soc_config(adev);
                 break;
@@ -2147,7 +2145,7 @@ static void amdgpu_discovery_init_soc_config(struct a=
mdgpu_device *adev)

 static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[VPE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
         case IP_VERSION(6, 1, 0):
                 amdgpu_device_ip_block_add(adev, &vpe_v6_1_ip_block);
                 break;
@@ -2160,7 +2158,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct =
amdgpu_device *adev)

 static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *a=
dev)
 {
-       switch (adev->ip_versions[VCN_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
                 if (amdgpu_umsch_mm & 0x1) {
                         amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip=
_block);
@@ -2354,7 +2352,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
         amdgpu_discovery_init_soc_config(adev);
         amdgpu_discovery_sysfs_init(adev);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -2408,7 +2406,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                 return -EINVAL;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 3, 0):
@@ -2427,11 +2425,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
                 break;
         }

-       if (adev->ip_versions[XGMI_HWIP][0] =3D=3D IP_VERSION(4, 8, 0))
+       if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0=
))
                 adev->gmc.xgmi.supported =3D true;

         /* set NBIO version */
-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(6, 1, 0):
         case IP_VERSION(6, 2, 0):
                 adev->nbio.funcs =3D &nbio_v6_1_funcs;
@@ -2493,7 +2491,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                 break;
         }

-       switch (adev->ip_versions[HDP_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, HDP_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
         case IP_VERSION(4, 0, 1):
         case IP_VERSION(4, 1, 0):
@@ -2525,7 +2523,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                 break;
         }

-       switch (adev->ip_versions[DF_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DF_HWIP, 0)) {
         case IP_VERSION(3, 6, 0):
         case IP_VERSION(3, 6, 1):
         case IP_VERSION(3, 6, 2):
@@ -2545,7 +2543,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                 break;
         }

-       switch (adev->ip_versions[SMUIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SMUIO_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(10, 0, 0):
@@ -2588,7 +2586,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                 break;
         }

-       switch (adev->ip_versions[LSDMA_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
         case IP_VERSION(6, 0, 0):
         case IP_VERSION(6, 0, 1):
         case IP_VERSION(6, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 363e6a2cad8c..0cacd0b9f8be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -766,11 +766,13 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)
                         return -EINVAL;
                 }

-               if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)=
)
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11,=
 0, 0))
                         version =3D AMD_FMT_MOD_TILE_VER_GFX11;
-               else if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, =
3, 0))
+               else if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
+                        IP_VERSION(10, 3, 0))
                         version =3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-               else if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, =
0, 0))
+               else if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
+                        IP_VERSION(10, 0, 0))
                         version =3D AMD_FMT_MOD_TILE_VER_GFX10;
                 else
                         version =3D AMD_FMT_MOD_TILE_VER_GFX9;
@@ -779,13 +781,15 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)
                 case 0: /* Z microtiling */
                         return -EINVAL;
                 case 1: /* S microtiling */
-                       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, =
0, 0)) {
+                       if (amdgpu_ip_version(adev, GC_HWIP, 0) <
+                           IP_VERSION(11, 0, 0)) {
                                 if (!has_xor)
                                         version =3D AMD_FMT_MOD_TILE_VER_G=
FX9;
                         }
                         break;
                 case 2:
-                       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, =
0, 0)) {
+                       if (amdgpu_ip_version(adev, GC_HWIP, 0) <
+                           IP_VERSION(11, 0, 0)) {
                                 if (!has_xor && afb->base.format->cpp[0] !=
=3D 4)
                                         version =3D AMD_FMT_MOD_TILE_VER_G=
FX9;
                         }
@@ -838,10 +842,12 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)
                         u64 render_dcc_offset;

                         /* Enable constant encode on RAVEN2 and later. */
-                       bool dcc_constant_encode =3D (adev->asic_type > CHI=
P_RAVEN ||
-                                                  (adev->asic_type =3D=3D =
CHIP_RAVEN &&
-                                                   adev->external_rev_id >=
=3D 0x81)) &&
-                                                   adev->ip_versions[GC_HW=
IP][0] < IP_VERSION(11, 0, 0);
+                       bool dcc_constant_encode =3D
+                               (adev->asic_type > CHIP_RAVEN ||
+                                (adev->asic_type =3D=3D CHIP_RAVEN &&
+                                 adev->external_rev_id >=3D 0x81)) &&
+                               amdgpu_ip_version(adev, GC_HWIP, 0) <
+                                       IP_VERSION(11, 0, 0);

                         int max_cblock_size =3D dcc_i64b ? AMD_FMT_MOD_DCC=
_BLOCK_64B :
                                               dcc_i128b ? AMD_FMT_MOD_DCC_=
BLOCK_128B :
@@ -878,7 +884,9 @@ static int convert_tiling_flags_to_modifier(struct amdg=
pu_framebuffer *afb)
                                 if (adev->family >=3D AMDGPU_FAMILY_NV) {
                                         int extra_pipe =3D 0;

-                                       if ((adev->ip_versions[GC_HWIP][0] =
>=3D IP_VERSION(10, 3, 0)) &&
+                                       if ((amdgpu_ip_version(adev, GC_HWI=
P,
+                                                              0) >=3D
+                                            IP_VERSION(10, 3, 0)) &&
                                             pipes =3D=3D packers && pipes =
> 1)
                                                 extra_pipe =3D 1;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index ef713806dd60..6686b911fb4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2251,7 +2251,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
                 pm_runtime_forbid(dev->dev);
         }

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2=
) &&
             !amdgpu_sriov_vf(adev)) {
                 bool need_to_reset_gpu =3D false;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index e163cb0bacd8..709a2c1b9d63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -570,7 +570,8 @@ static bool amdgpu_fence_need_ring_interrupt_restore(st=
ruct amdgpu_ring *ring)
         switch (ring->funcs->type) {
         case AMDGPU_RING_TYPE_SDMA:
         /* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF=
 */
-               if (adev->ip_versions[SDMA0_HWIP][0] >=3D IP_VERSION(5, 0, =
0))
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >=3D
+                   IP_VERSION(5, 0, 0))
                         is_gfx_power_domain =3D true;
                 break;
         case AMDGPU_RING_TYPE_GFX:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 2382921710ec..9a158018ae16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -158,7 +158,7 @@ static bool amdgpu_gfx_is_compute_multipipe_capable(str=
uct amdgpu_device *adev)
                 return amdgpu_compute_multipipe =3D=3D 1;
         }

-       if (adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0))
                 return true;

         /* FIXME: spreading the queues across pipes causes perf regression=
s
@@ -385,7 +385,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
         u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;

         /* Only enable on gfx10 and 11 for now to avoid changing behavior =
on older chips */
-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 0, 0))
                 domain |=3D AMDGPU_GEM_DOMAIN_VRAM;

         /* create MQD for KIQ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 5f7641d9f346..de7b379a9cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -588,7 +588,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device=
 *adev)
  */
 void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         /* RAVEN */
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 1, 0):
@@ -652,7 +652,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 {
         struct amdgpu_gmc *gmc =3D &adev->gmc;
-       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
         bool noretry_default =3D (gc_ver =3D=3D IP_VERSION(9, 0, 1) ||
                                 gc_ver =3D=3D IP_VERSION(9, 3, 0) ||
                                 gc_ver =3D=3D IP_VERSION(9, 4, 0) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index d462b36adf4b..4e32c428c613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -501,18 +501,22 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
         if (adev->asic_type >=3D CHIP_VEGA10) {
                 switch (type) {
                 case AMD_IP_BLOCK_TYPE_GFX:
-                       result->ip_discovery_version =3D adev->ip_versions[=
GC_HWIP][0];
+                       result->ip_discovery_version =3D
+                               amdgpu_ip_version(adev, GC_HWIP, 0);
                         break;
                 case AMD_IP_BLOCK_TYPE_SDMA:
-                       result->ip_discovery_version =3D adev->ip_versions[=
SDMA0_HWIP][0];
+                       result->ip_discovery_version =3D
+                               amdgpu_ip_version(adev, SDMA0_HWIP, 0);
                         break;
                 case AMD_IP_BLOCK_TYPE_UVD:
                 case AMD_IP_BLOCK_TYPE_VCN:
                 case AMD_IP_BLOCK_TYPE_JPEG:
-                       result->ip_discovery_version =3D adev->ip_versions[=
UVD_HWIP][0];
+                       result->ip_discovery_version =3D
+                               amdgpu_ip_version(adev, UVD_HWIP, 0);
                         break;
                 case AMD_IP_BLOCK_TYPE_VCE:
-                       result->ip_discovery_version =3D adev->ip_versions[=
VCE_HWIP][0];
+                       result->ip_discovery_version =3D
+                               amdgpu_ip_version(adev, VCE_HWIP, 0);
                         break;
                 default:
                         result->ip_discovery_version =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 10ce5557bb11..70fe3b39c004 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -131,7 +131,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                 adev->mes.gfx_hqd_mask[i] =3D i ? 0 : 0xfffffffe;

         for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-               if (adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(6, 0, 0))
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
+                   IP_VERSION(6, 0, 0))
                         adev->mes.sdma_hqd_mask[i] =3D i ? 0 : 0x3fc;
                 /* zero sdma_hqd_mask for non-existent engine */
                 else if (adev->sdma.num_instances =3D=3D 1)
@@ -1339,8 +1340,10 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)

         for (i =3D 0; i < ARRAY_SIZE(queue_types); i++) {
                 /* On GFX v10.3, fw hasn't supported to map sdma queue. */
-               if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0)=
 &&
-                   adev->ip_versions[GC_HWIP][0] < IP_VERSION(11, 0, 0) &&
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
+                           IP_VERSION(10, 3, 0) &&
+                   amdgpu_ip_version(adev, GC_HWIP, 0) <
+                           IP_VERSION(11, 0, 0) &&
                     queue_types[i][0] =3D=3D AMDGPU_RING_TYPE_SDMA)
                         continue;

@@ -1401,7 +1404,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *a=
dev, int pipe)

         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
                                        sizeof(ucode_prefix));
-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)) =
{
                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
                          ucode_prefix,
                          pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index ed0955ccd3d7..72ee66db182c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -100,7 +100,7 @@ static void psp_check_pmfw_centralized_cstate_managemen=
t(struct psp_context *psp
                 return;
         }

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 4):
         case IP_VERSION(11, 0, 5):
@@ -128,7 +128,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)

         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
         case IP_VERSION(11, 0, 7):
         case IP_VERSION(11, 0, 9):
@@ -162,7 +162,7 @@ static int psp_early_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct psp_context *psp =3D &adev->psp;

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
                 psp_v3_1_set_psp_funcs(psp);
                 psp->autoload_supported =3D false;
@@ -334,7 +334,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_devi=
ce *adev,
         bool ret =3D false;
         int i;

-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
))
                 return false;

         db_header_pos =3D adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
@@ -413,7 +413,7 @@ static int psp_sw_init(void *handle)

         adev->psp.xgmi_context.supports_extended_data =3D
                 !adev->gmc.xgmi.connected_to_cpu &&
-                       adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13=
, 0, 2);
+               amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, =
0, 2);

         memset(&scpm_entry, 0, sizeof(scpm_entry));
         if ((psp_get_runtime_db_entry(adev,
@@ -773,7 +773,7 @@ static int psp_load_toc(struct psp_context *psp,

 static bool psp_boottime_tmr(struct psp_context *psp)
 {
-       switch (psp->adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
         case IP_VERSION(13, 0, 6):
                 return true;
         default:
@@ -828,7 +828,7 @@ static int psp_tmr_init(struct psp_context *psp)

 static bool psp_skip_tmr(struct psp_context *psp)
 {
-       switch (psp->adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
         case IP_VERSION(11, 0, 9):
         case IP_VERSION(11, 0, 7):
         case IP_VERSION(13, 0, 2):
@@ -1215,8 +1215,8 @@ int psp_xgmi_terminate(struct psp_context *psp)
         struct amdgpu_device *adev =3D psp->adev;

         /* XGMI TA unload currently is not supported on Arcturus/Aldebaran=
 A+A */
-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 4) ||
-           (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0, 4=
) ||
+           (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
2) &&
              adev->gmc.xgmi.connected_to_cpu))
                 return 0;

@@ -1313,9 +1313,11 @@ int psp_xgmi_get_node_id(struct psp_context *psp, ui=
nt64_t *node_id)

 static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 {
-       return (psp->adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0=
, 2) &&
+       return (amdgpu_ip_version(psp->adev, MP0_HWIP, 0) =3D=3D
+                       IP_VERSION(13, 0, 2) &&
                 psp->xgmi_context.context.bin_desc.fw_version >=3D 0x20000=
00b) ||
-               psp->adev->ip_versions[MP0_HWIP][0] >=3D IP_VERSION(13, 0, =
6);
+              amdgpu_ip_version(psp->adev, MP0_HWIP, 0) >=3D
+                      IP_VERSION(13, 0, 6);
 }

 /*
@@ -1424,8 +1426,10 @@ int psp_xgmi_get_topology_info(struct psp_context *p=
sp,
         if (psp_xgmi_peer_link_info_supported(psp)) {
                 struct ta_xgmi_cmd_get_peer_link_info_output *link_info_ou=
tput;
                 bool requires_reflection =3D
-                       (psp->xgmi_context.supports_extended_data && get_ex=
tended_data) ||
-                               psp->adev->ip_versions[MP0_HWIP][0] =3D=3D =
IP_VERSION(13, 0, 6);
+                       (psp->xgmi_context.supports_extended_data &&
+                        get_extended_data) ||
+                       amdgpu_ip_version(psp->adev, MP0_HWIP, 0) =3D=3D
+                               IP_VERSION(13, 0, 6);

                 xgmi_cmd->cmd_id =3D TA_COMMAND_XGMI__GET_PEER_LINKS;

@@ -2517,10 +2521,9 @@ static int psp_load_smu_fw(struct psp_context *psp)
         if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
                 return 0;

-       if ((amdgpu_in_reset(adev) &&
-            ras && adev->ras_enabled &&
-            (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 4) ||
-             adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 2))))=
 {
+       if ((amdgpu_in_reset(adev) && ras && adev->ras_enabled &&
+            (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 4) ||
+             amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 2)))) {
                 ret =3D amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD=
);
                 if (ret)
                         DRM_WARN("Failed to set MP1 state prepare for relo=
ad\n");
@@ -2603,9 +2606,12 @@ static int psp_load_non_psp_fw(struct psp_context *p=
sp)
                         continue;

                 if (psp->autoload_supported &&
-                   (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 7) ||
-                    adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 11) ||
-                    adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 12)) &&
+                   (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
+                            IP_VERSION(11, 0, 7) ||
+                    amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
+                            IP_VERSION(11, 0, 11) ||
+                    amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
+                            IP_VERSION(11, 0, 12)) &&
                     (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA1 ||
                      ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA2 ||
                      ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA3))
@@ -3146,7 +3152,7 @@ static int psp_init_sos_base_fw(struct amdgpu_device =
*adev)
                 le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);

         if (adev->gmc.xgmi.connected_to_cpu ||
-           (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(13, 0, 2))) {
+           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2)=
)) {
                 adev->psp.sos.fw_version =3D le32_to_cpu(sos_hdr->header.u=
code_version);
                 adev->psp.sos.feature_version =3D le32_to_cpu(sos_hdr->sos=
.fw_version);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 632478874f7d..eeb695f9ff1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -201,8 +201,8 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f, =
char __user *buf,
                 return -EINVAL;

         /* Hardware counter will be reset automatically after the query on=
 Vega20 and Arcturus */
-       if (obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &=
&
-           obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) =
{
+       if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 2) &&
+           amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 4)) {
                 if (amdgpu_ras_reset_error_status(obj->adev, info.head.blo=
ck))
                         dev_warn(obj->adev->dev, "Failed to reset error co=
unter and error status");
         }
@@ -611,8 +611,8 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev=
,
         if (amdgpu_ras_query_error_status(obj->adev, &info))
                 return -EINVAL;

-       if (obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &=
&
-           obj->adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) =
{
+       if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 2) &&
+           amdgpu_ip_version(obj->adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0=
, 4)) {
                 if (amdgpu_ras_reset_error_status(obj->adev, info.head.blo=
ck))
                         dev_warn(obj->adev->dev, "Failed to reset error co=
unter and error status");
         }
@@ -1208,8 +1208,8 @@ static int amdgpu_ras_query_error_count_helper(struct=
 amdgpu_device *adev,

         /* some hardware/IP supports read to clear
          * no need to explictly reset the err status after the query call =
*/
-       if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) &&
-           adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0, 2) =
&&
+           amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0, 4))=
 {
                 if (amdgpu_ras_reset_error_status(adev, query_info->head.b=
lock))
                         dev_warn(adev->dev,
                                  "Failed to reset error counter and error =
status\n");
@@ -1905,14 +1905,18 @@ static void amdgpu_ras_log_on_err_counter(struct am=
dgpu_device *adev)
                  * should be removed until smu fix handle ecc_info table.
                  */
                 if ((info.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) &&
-                       (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(1=
3, 0, 2)))
+                   (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                    IP_VERSION(13, 0, 2)))
                         continue;

                 amdgpu_ras_query_error_status(adev, &info);

-               if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2=
) &&
-                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4=
) &&
-                   adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(13, 0, 0=
)) {
+               if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D
+                           IP_VERSION(11, 0, 2) &&
+                   amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D
+                           IP_VERSION(11, 0, 4) &&
+                   amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D
+                           IP_VERSION(13, 0, 0)) {
                         if (amdgpu_ras_reset_error_status(adev, info.head.=
block))
                                 dev_warn(adev->dev, "Failed to reset error=
 counter and error status");
                 }
@@ -2400,7 +2404,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_dev=
ice *adev)
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 {
         if (amdgpu_sriov_vf(adev)) {
-               switch (adev->ip_versions[MP0_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
                 case IP_VERSION(13, 0, 2):
                 case IP_VERSION(13, 0, 6):
                         return true;
@@ -2410,7 +2414,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_d=
evice *adev)
         }

         if (adev->asic_type =3D=3D CHIP_IP_DISCOVERY) {
-               switch (adev->ip_versions[MP0_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
                 case IP_VERSION(13, 0, 0):
                 case IP_VERSION(13, 0, 6):
                 case IP_VERSION(13, 0, 10):
@@ -2484,8 +2488,10 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)
                         /* VCN/JPEG RAS can be supported on both bare meta=
l and
                          * SRIOV environment
                          */
-                       if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSIO=
N(2, 6, 0) ||
-                           adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSIO=
N(4, 0, 0))
+                       if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
+                                   IP_VERSION(2, 6, 0) ||
+                           amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
+                                   IP_VERSION(4, 0, 0))
                                 adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS=
_BLOCK__VCN |
                                                         1 << AMDGPU_RAS_BL=
OCK__JPEG);
                         else
@@ -2519,7 +2525,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_=
device *adev)
          * Disable ras feature for aqua vanjaram
          * by default on apu platform.
          */
-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6) &&
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) &&
             adev->gmc.is_app_apu)
                 adev->ras_enabled =3D amdgpu_ras_enable !=3D 1 ? 0 :
                         adev->ras_hw_enabled & amdgpu_ras_mask;
@@ -2634,7 +2640,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
         /* initialize nbio ras function ahead of any other
          * ras functions so hardware fatal error interrupt
          * can be enabled as early as possible */
-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 4, 0):
         case IP_VERSION(7, 4, 1):
         case IP_VERSION(7, 4, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 595d5e535aca..8ced4be784e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -153,7 +153,7 @@

 static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 2): /* VEGA20 and ARCTURUS */
         case IP_VERSION(11, 0, 7): /* Sienna cichlid */
         case IP_VERSION(13, 0, 0):
@@ -191,7 +191,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device =
*adev,
                 return true;
         }

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 2):
                 /* VEGA20 and ARCTURUS */
                 if (adev->asic_type =3D=3D CHIP_VEGA20)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 02d874799c16..970bfece775c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -30,7 +30,7 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 {
         int ret =3D 0;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 2):
         case IP_VERSION(13, 0, 6):
                 ret =3D aldebaran_reset_init(adev);
@@ -52,7 +52,7 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
 {
         int ret =3D 0;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 2):
         case IP_VERSION(13, 0, 6):
                 ret =3D aldebaran_reset_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 572f861e3f70..e8cbc4142d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -251,8 +251,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *a=
dev,
                                 else {
                                         /* Use a single copy per SDMA firm=
ware type. PSP uses the same instance for all
                                          * groups of SDMAs */
-                                       if (adev->ip_versions[SDMA0_HWIP][0=
] =3D=3D IP_VERSION(4, 4, 2) &&
-                                           adev->firmware.load_type =3D=3D=
 AMDGPU_FW_LOAD_PSP &&
+                                       if (amdgpu_ip_version(adev, SDMA0_H=
WIP,
+                                                             0) =3D=3D
+                                                   IP_VERSION(4, 4, 2) &&
+                                           adev->firmware.load_type =3D=3D
+                                                   AMDGPU_FW_LOAD_PSP &&
                                             adev->sdma.num_inst_per_aid =
=3D=3D i) {
                                                 break;
                                         }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 4e51dce3aab5..05991c5c8ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1727,7 +1727,8 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)
                 reserve_size =3D
                         amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);

-       if (!adev->bios && adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(=
9, 4, 3))
+       if (!adev->bios &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 reserve_size =3D max(reserve_size, (uint32_t)280 << 20);
         else if (!reserve_size)
                 reserve_size =3D DISCOVERY_TMR_OFFSET;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index 5aff383473f2..771ef8017a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1119,7 +1119,7 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, =
int block_type)
 {
         if (block_type =3D=3D MP0_HWIP) {
-               switch (adev->ip_versions[MP0_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
                 case IP_VERSION(9, 0, 0):
                         switch (adev->asic_type) {
                         case CHIP_VEGA10:
@@ -1170,7 +1170,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl
                         return "yellow_carp";
                 }
         } else if (block_type =3D=3D MP1_HWIP) {
-               switch (adev->ip_versions[MP1_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                 case IP_VERSION(9, 0, 0):
                 case IP_VERSION(10, 0, 0):
                 case IP_VERSION(10, 0, 1):
@@ -1196,7 +1196,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl
                         return "aldebaran_smc";
                 }
         } else if (block_type =3D=3D SDMA0_HWIP) {
-               switch (adev->ip_versions[SDMA0_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
                 case IP_VERSION(4, 0, 0):
                         return "vega10_sdma";
                 case IP_VERSION(4, 0, 1):
@@ -1240,7 +1240,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl
                         return "vangogh_sdma";
                 }
         } else if (block_type =3D=3D UVD_HWIP) {
-               switch (adev->ip_versions[UVD_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                         if (adev->apu_flags & AMD_APU_IS_RAVEN2)
@@ -1265,7 +1265,8 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl
                 case IP_VERSION(3, 0, 0):
                 case IP_VERSION(3, 0, 64):
                 case IP_VERSION(3, 0, 192):
-                       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION=
(10, 3, 0))
+                       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(10, 3, 0))
                                 return "sienna_cichlid_vcn";
                         return "navy_flounder_vcn";
                 case IP_VERSION(3, 0, 2):
@@ -1278,7 +1279,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl
                         return "yellow_carp_vcn";
                 }
         } else if (block_type =3D=3D GC_HWIP) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(9, 0, 1):
                         return "vega10";
                 case IP_VERSION(9, 2, 1):
@@ -1331,7 +1332,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_dev=
ice *adev, int block_type,
         int maj, min, rev;
         char *ip_name;
         const char *legacy;
-       uint32_t version =3D adev->ip_versions[block_type][0];
+       uint32_t version =3D amdgpu_ip_version(adev, block_type, 0);

         legacy =3D amdgpu_ucode_legacy_naming(adev, block_type);
         if (legacy) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index db0d94ca4ffc..24fcc9a2e422 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -28,7 +28,7 @@ static int amdgpu_umc_convert_error_address(struct amdgpu=
_device *adev,
                                     struct ras_err_data *err_data, uint64_=
t err_addr,
                                     uint32_t ch_inst, uint32_t umc_inst)
 {
-       switch (adev->ip_versions[UMC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
         case IP_VERSION(6, 7, 0):
                 umc_v6_7_convert_error_address(adev,
                                 err_data, err_addr, ch_inst, umc_inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c
index 9da80b54d63e..aeff9926412f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -581,7 +581,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_=
mm *umsch)
         const char *fw_name =3D NULL;
         int r;

-       switch (adev->ip_versions[VCN_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
                 fw_name =3D "amdgpu/umsch_mm_4_0_0.bin";
                 break;
@@ -758,7 +758,7 @@ static int umsch_mm_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       switch (adev->ip_versions[VCN_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 5):
                 umsch_mm_v4_0_set_funcs(&adev->umsch_mm);
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 80bcbe744e58..c93f3a4c0e31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -126,7 +126,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
          * Hence, check for these versions here - notice this is
          * restricted to Vangogh (Deck's APU).
          */
-       if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 0, 2)) {
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(3, 0, 2)=
) {
                 const char *bios_ver =3D dmi_get_system_info(DMI_BIOS_VERS=
ION);

                 if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
@@ -171,7 +171,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
                 bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_=
size_bytes) + 8);

-       if (adev->ip_versions[UVD_HWIP][0] >=3D IP_VERSION(4, 0, 0)) {
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0, 0)) =
{
                 fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amd=
gpu_vcn4_fw_shared));
                 log_offset =3D offsetof(struct amdgpu_vcn4_fw_shared, fw_l=
og);
         } else {
@@ -267,7 +267,7 @@ static bool amdgpu_vcn_using_unified_queue(struct amdgp=
u_ring *ring)
         struct amdgpu_device *adev =3D ring->adev;
         bool ret =3D false;

-       if (adev->ip_versions[UVD_HWIP][0] >=3D IP_VERSION(4, 0, 0))
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0, 0))
                 ret =3D true;

         return ret;
@@ -998,7 +998,7 @@ int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring =
*ring, long timeout)
         struct amdgpu_device *adev =3D ring->adev;
         long r;

-       if (adev->ip_versions[UVD_HWIP][0] !=3D IP_VERSION(4, 0, 3)) {
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D IP_VERSION(4, 0, 3)) =
{
                 r =3D amdgpu_vcn_enc_ring_test_ib(ring, timeout);
                 if (r)
                         goto error;
@@ -1048,7 +1048,8 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *ade=
v)
                         adev->firmware.fw_size +=3D
                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes), =
PAGE_SIZE);

-                       if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSIO=
N(4, 0, 3))
+                       if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
+                           IP_VERSION(4, 0, 3))
                                 break;
                 }
                 dev_info(adev->dev, "Will use PSP to load VCN firmware\n")=
;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 96857ae7fb5b..a0aa624f5a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -837,7 +837,7 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode=
(struct amdgpu_device *ad

 void amdgpu_virt_post_reset(struct amdgpu_device *adev)
 {
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
) {
                 /* force set to GFXOFF state after reset,
                  * to avoid some invalid operation before GC enable
                  */
@@ -847,7 +847,7 @@ void amdgpu_virt_post_reset(struct amdgpu_device *adev)

 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t u=
code_id)
 {
-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(13, 0, 0):
                 /* no vf autoload, white list */
                 if (ucode_id =3D=3D AMDGPU_UCODE_ID_VCN1 ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index edaebabc8e60..a874aed2ab52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -802,12 +802,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
          * heavy-weight flush TLB unconditionally.
          */
         flush_tlb |=3D adev->gmc.xgmi.num_physical_nodes &&
-                    adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, =
0);
+                    amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(=
9, 4, 0);

         /*
          * On GFX8 and older any 8 PTE block with a valid bit set enters t=
he TLB
          */
-       flush_tlb |=3D adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 0);
+       flush_tlb |=3D amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, =
0, 0);

         memset(&params, 0, sizeof(params));
         params.adev =3D adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c
index ae070072705a..a68354d03a49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -123,7 +123,7 @@ static int vpe_early_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct amdgpu_vpe *vpe =3D &adev->vpe;

-       switch (adev->ip_versions[VPE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
         case IP_VERSION(6, 1, 0):
                 vpe_v6_1_set_funcs(vpe);
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 7e91b24784e5..061534e845a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -948,7 +948,8 @@ static int amdgpu_xgmi_query_pcs_error_status(struct am=
dgpu_device *adev,
         uint32_t field_array_size =3D 0;

         if (is_xgmi_pcs) {
-               if (adev->ip_versions[XGMI_HWIP][0] =3D=3D IP_VERSION(6, 1,=
 0)) {
+               if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D
+                   IP_VERSION(6, 1, 0)) {
                         pcs_ras_fields =3D &xgmi3x16_pcs_ras_fields[0];
                         field_array_size =3D ARRAY_SIZE(xgmi3x16_pcs_ras_f=
ields);
                 } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v1_0.c
index a13c443ea10f..42f4e163e251 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
@@ -68,7 +68,7 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev=
,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v2_0.c
index a9521c98e7f7..5a122f50a6e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c
@@ -77,7 +77,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev=
,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(1, 3, 1):
         case IP_VERSION(2, 0, 0):
         case IP_VERSION(2, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v2_1.c
index 78508ae6a670..e143fcc46148 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -70,7 +70,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev=
,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
         case IP_VERSION(2, 1, 1):
         case IP_VERSION(2, 1, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v3_0.c
index f0e235f98afb..5a318bc03d23 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c
@@ -36,7 +36,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_devi=
ce *adev)
 {
         uint32_t data;

-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 1):
                 data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1)=
;
                 break;
@@ -49,7 +49,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_devi=
ce *adev)

 static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32_t da=
ta)
 {
-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 1):
                 WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, data);
                 break;
@@ -99,7 +99,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev=
,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[ATHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, ATHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 0):
         case IP_VERSION(3, 0, 1):
         case IP_VERSION(3, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 62329a822022..35357364b5b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3627,7 +3627,7 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu=
_device *adev)

 static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device *adev=
)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_gc_rlc_spm=
_10_0_nv10,
@@ -3650,7 +3650,7 @@ static void gfx_v10_0_init_spm_golden_registers(struc=
t amdgpu_device *adev)

 static void gfx_v10_0_init_golden_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_gc_10_1,
@@ -3891,7 +3891,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)
 {
         adev->gfx.cp_fw_write_wait =3D false;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 2):
         case IP_VERSION(10, 1, 1):
@@ -3942,7 +3942,7 @@ static bool gfx_v10_0_navi10_gfxoff_should_enable(str=
uct amdgpu_device *adev)

 static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
                 if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
                         adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;
@@ -3964,8 +3964,8 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)

         DRM_DEBUG("\n");

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1) &&
-          (!(adev->pdev->device =3D=3D 0x7340 && adev->pdev->revision !=3D=
 0x00)))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 1)=
 &&
+           (!(adev->pdev->device =3D=3D 0x7340 && adev->pdev->revision !=
=3D 0x00)))
                 wks =3D "_wks";
         amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof=
(ucode_prefix));

@@ -4144,7 +4144,7 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struc=
t amdgpu_device *adev)
         reg_access_ctrl->scratch_reg3 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATC=
H_REG3);
         reg_access_ctrl->grbm_cntl =3D SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_=
CNTL);
         reg_access_ctrl->grbm_idx =3D SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_I=
NDEX);
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 reg_access_ctrl->spare_int =3D
                         SOC15_REG_OFFSET(GC, 0, mmRLC_SPARE_INT_0_Sienna_C=
ichlid);
@@ -4358,7 +4358,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)
 {
         u32 gb_addr_config;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -4491,7 +4491,7 @@ static int gfx_v10_0_sw_init(void *handle)
         struct amdgpu_kiq *kiq;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -4749,9 +4749,12 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device =
*adev)
         for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
                 for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
                         bitmap =3D i * adev->gfx.config.max_sh_per_se + j;
-                       if (((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSI=
ON(10, 3, 0)) ||
-                               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VE=
RSION(10, 3, 3)) ||
-                               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VE=
RSION(10, 3, 6))) &&
+                       if (((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 0)) ||
+                            (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 3)) ||
+                            (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 6))) &&
                             ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) &=
 1))
                                 continue;
                         gfx_v10_0_select_se_sh(adev, i, j, 0xffffffff, 0);
@@ -4779,7 +4782,7 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_overrid=
e(struct amdgpu_device *ade
         /* for ASICs that integrates GFX v10.3
          * pa_sc_tile_steering_override should be set to 0
          */
-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0))
                 return 0;

         /* init num_sc */
@@ -4960,7 +4963,7 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_devi=
ce *adev)
         /* TCCs are global (not instanced). */
         uint32_t tcc_disable;

-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0)) =
{
                 tcc_disable =3D RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE_gc_=
10_3) |
                               RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE_=
gc_10_3);
         } else {
@@ -5037,7 +5040,7 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *a=
dev)
         adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);

         /* csib */
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 2)=
) {
                 WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,
                                 adev->gfx.rlc.clear_state_gpu_addr >> 32);
                 WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,
@@ -5666,7 +5669,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_devi=
ce *adev, bool enable)
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);
         tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT, enable ? 0 : 1);

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 2)=
)
                 WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
         else
                 WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);
@@ -6057,7 +6060,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdg=
pu_device *adev,
                 }
                 WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
         }
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -6190,7 +6193,7 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_devi=
ce *adev)
 static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool e=
nable)
 {
         if (enable) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(10, 3, 0):
                 case IP_VERSION(10, 3, 2):
                 case IP_VERSION(10, 3, 1):
@@ -6206,7 +6209,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu=
_device *adev, bool enable)
                         break;
                 }
         } else {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(10, 3, 0):
                 case IP_VERSION(10, 3, 2):
                 case IP_VERSION(10, 3, 1):
@@ -6306,7 +6309,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring =
*ring)
         struct amdgpu_device *adev =3D ring->adev;

         /* tell RLC which is KIQ queue */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -6917,7 +6920,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct=
 amdgpu_device *adev)
          * check if mmVGT_ESGS_RING_SIZE_UMD
          * has been remapped to mmVGT_ESGS_RING_SIZE
          */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 4):
@@ -6966,7 +6969,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct=
 amdgpu_device *adev)
          */
         WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -7139,19 +7142,19 @@ static int gfx_v10_0_hw_init(void *handle)
          * init golden registers and rlc resume may override some register=
s,
          * reconfig them here
          */
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 10) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 10=
) ||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 1)=
 ||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 2)=
)
                 gfx_v10_0_tcp_harvest(adev);

         r =3D gfx_v10_0_cp_resume(adev);
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 0)=
)
                 gfx_v10_3_program_pbb_mode(adev);

-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0))
                 gfx_v10_3_set_power_brake_sequence(adev);

         return r;
@@ -7255,7 +7258,7 @@ static int gfx_v10_0_soft_reset(void *handle)

         /* GRBM_STATUS2 */
         tmp =3D RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -7312,7 +7315,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev)
 {
         uint64_t clock, clock_lo, clock_hi, hi_check;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 3):
         case IP_VERSION(10, 3, 7):
@@ -7399,7 +7402,7 @@ static int gfx_v10_0_early_init(void *handle)

         adev->gfx.funcs =3D &gfx_v10_0_gfx_funcs;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -7470,7 +7473,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id)
         data =3D RLC_SAFE_MODE__CMD_MASK;
         data |=3D (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -7508,7 +7511,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_d=
evice *adev, int xcc_id)
         uint32_t data;

         data =3D RLC_SAFE_MODE__CMD_MASK;
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -7819,7 +7822,7 @@ static void gfx_v10_0_apply_medium_grain_clock_gating=
_workaround(struct amdgpu_d
                 mmCGTS_SA1_QUAD1_SM_CTRL_REG
         };

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 2)=
) {
                 for (i =3D 0; i < ARRAY_SIZE(tcp_ctrl_regs_nv12); i++) {
                         reg_idx =3D adev->reg_offset[GC_HWIP][0][mmCGTS_SA=
0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
                                   tcp_ctrl_regs_nv12[i];
@@ -7864,9 +7867,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct =
amdgpu_device *adev,
                 /* =3D=3D=3D  CGCG + CGLS =3D=3D=3D */
                 gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);

-               if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1,=
 10)) ||
-                   (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1,=
 1)) ||
-                   (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1,=
 2)))
+               if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                    IP_VERSION(10, 1, 10)) ||
+                   (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                    IP_VERSION(10, 1, 1)) ||
+                   (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                    IP_VERSION(10, 1, 2)))
                         gfx_v10_0_apply_medium_grain_clock_gating_workarou=
nd(adev);
         } else {
                 /* CGCG/CGLS should be disabled before MGCG/MGLS
@@ -7966,7 +7972,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_d=
evice *adev, bool enable)
          * Power/performance team will optimize it and might give a new va=
lue later.
          */
         if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(10, 3, 1):
                 case IP_VERSION(10, 3, 3):
                 case IP_VERSION(10, 3, 6):
@@ -8027,7 +8033,7 @@ static int gfx_v10_0_set_powergating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -8064,7 +8070,7 @@ static int gfx_v10_0_set_clockgating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -9311,7 +9317,7 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)

 static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 3):
@@ -9428,10 +9434,14 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_devi=
ce *adev,
         for (i =3D 0; i < adev->gfx.config.max_shader_engines; i++) {
                 for (j =3D 0; j < adev->gfx.config.max_sh_per_se; j++) {
                         bitmap =3D i * adev->gfx.config.max_sh_per_se + j;
-                       if (((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSI=
ON(10, 3, 0)) ||
-                            (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSI=
ON(10, 3, 3)) ||
-                            (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSI=
ON(10, 3, 6)) ||
-                            (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSI=
ON(10, 3, 7))) &&
+                       if (((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 0)) ||
+                            (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 3)) ||
+                            (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 6)) ||
+                            (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                             IP_VERSION(10, 3, 7))) &&
                             ((gfx_v10_3_get_disabled_sa(adev) >> bitmap) &=
 1))
                                 continue;
                         mask =3D 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 39c434ca0dad..42fc0cc13fdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -288,7 +288,7 @@ static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_d=
evice *adev)

 static void gfx_v11_0_init_golden_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 1):
         case IP_VERSION(11, 0, 4):
                 soc15_program_register_sequence(adev,
@@ -493,7 +493,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_d=
evice *adev, const char *

 static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 2):
         case IP_VERSION(11, 0, 3):
@@ -884,8 +884,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_func=
s =3D {

 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 {
-
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 2):
                 adev->gfx.config.max_hw_contexts =3D 8;
@@ -1332,7 +1331,7 @@ static int gfx_v11_0_sw_init(void *handle)

         adev->gfxhub.funcs->init(adev);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 2):
         case IP_VERSION(11, 0, 3):
@@ -1364,8 +1363,8 @@ static int gfx_v11_0_sw_init(void *handle)
         }

         /* Enable CG flag in one VF mode for enabling RLC safe mode enter/=
exit */
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 3) &&
-               amdgpu_sriov_is_pp_one_vf(adev))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
 &&
+           amdgpu_sriov_is_pp_one_vf(adev))
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG;

         /* EOP Event */
@@ -2592,9 +2591,11 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(=
struct amdgpu_device *adev)
         for (i =3D 0; i < adev->usec_timeout; i++) {
                 cp_status =3D RREG32_SOC15(GC, 0, regCP_STAT);

-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, =
1) ||
-                               adev->ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(11, 0, 4) ||
-                               adev->ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(11, 5, 0))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(11, 0, 1) ||
+                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(11, 0, 4) ||
+                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
1, 5, 0))
                         bootload_status =3D RREG32_SOC15(GC, 0,
                                         regRLC_RLCS_BOOTLOAD_STATUS_gc_11_=
0_1);
                 else
@@ -5025,7 +5026,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_d=
evice *adev, bool enable)

         // Program RLC_PG_DELAY3 for CGPG hysteresis
         if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(11, 0, 1):
                 case IP_VERSION(11, 0, 4):
                         WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELA=
Y_3_DEFAULT_GC_11_0_1);
@@ -5054,7 +5055,7 @@ static int gfx_v11_0_set_powergating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 2):
         case IP_VERSION(11, 0, 3):
@@ -5086,7 +5087,7 @@ static int gfx_v11_0_set_clockgating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 1):
         case IP_VERSION(11, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index f99a3a6bfd91..e3ff6e46f3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -895,7 +895,7 @@ static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_de=
vice *adev)

 static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_gc_9_0,
@@ -951,8 +951,8 @@ static void gfx_v9_0_init_golden_registers(struct amdgp=
u_device *adev)
                 break;
         }

-       if ((adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 1)) &&
-           (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 2)))
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 1)) =
&&
+           (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 2)))
                 soc15_program_register_sequence(adev, golden_settings_gc_9=
_x_common,
                                                 (const u32)ARRAY_SIZE(gold=
en_settings_gc_9_x_common));
 }
@@ -1095,14 +1095,14 @@ static void gfx_v9_0_check_fw_write_wait(struct amd=
gpu_device *adev)
         adev->gfx.me_fw_write_wait =3D false;
         adev->gfx.mec_fw_write_wait =3D false;

-       if ((adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 1)) &&
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 1)) =
&&
             ((adev->gfx.mec_fw_version < 0x000001a5) ||
-           (adev->gfx.mec_feature_version < 46) ||
-           (adev->gfx.pfp_fw_version < 0x000000b7) ||
-           (adev->gfx.pfp_feature_version < 46)))
+            (adev->gfx.mec_feature_version < 46) ||
+            (adev->gfx.pfp_fw_version < 0x000000b7) ||
+            (adev->gfx.pfp_feature_version < 46)))
                 DRM_WARN_ONCE("CP firmware version too old, please update!=
");

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
                 if ((adev->gfx.me_fw_version >=3D 0x0000009c) &&
                     (adev->gfx.me_feature_version >=3D 42) &&
@@ -1202,7 +1202,7 @@ static bool is_raven_kicker(struct amdgpu_device *ade=
v)

 static bool check_if_enlarge_doorbell_range(struct amdgpu_device *adev)
 {
-       if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 3, 0)) &&
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 3, 0)=
) &&
             (adev->gfx.me_fw_version >=3D 0x000000a5) &&
             (adev->gfx.me_feature_version >=3D 52))
                 return true;
@@ -1215,7 +1215,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdg=
pu_device *adev)
         if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
                 adev->pm.pp_feature &=3D ~PP_GFXOFF_MASK;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -1326,9 +1326,9 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_=
device *adev,

 static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *adev)
 {
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 3, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 3, 0))
                 return false;

         return true;
@@ -1485,7 +1485,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct am=
dgpu_device *adev)

         if (adev->flags & AMD_IS_APU)
                 always_on_cu_num =3D 4;
-       else if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 2, 1))
+       else if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 2=
, 1))
                 always_on_cu_num =3D 8;
         else
                 always_on_cu_num =3D 12;
@@ -1836,7 +1836,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_devi=
ce *adev)
         u32 gb_addr_config;
         int err;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
                 adev->gfx.config.max_hw_contexts =3D 8;
                 adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
@@ -2002,7 +2002,7 @@ static int gfx_v9_0_sw_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         unsigned int hw_prio;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -2363,7 +2363,7 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_dev=
ice *adev)
 {
         uint32_t tmp;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 1):
                 tmp =3D RREG32_SOC15(GC, 0, mmSQ_CONFIG);
                 tmp =3D REG_SET_FIELD(tmp, SQ_CONFIG, DISABLE_BARRIER_WAIT=
CNT,
@@ -2700,7 +2700,7 @@ static void gfx_v9_0_init_gfx_power_gating(struct amd=
gpu_device *adev)
                 /* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0 */
                 data |=3D (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_I=
DLE_THRESHOLD__SHIFT);
                 WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), data);
-               if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 3, 0))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, =
3, 0))
                         pwr_10_0_gfxip_control_over_cgpg(adev, true);
         }
 }
@@ -2812,7 +2812,8 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *ad=
ev)
          * And it's needed by gfxoff feature.
          */
         if (adev->gfx.rlc.is_rlc_v2_1) {
-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 2, 1=
) ||
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(9, 2, 1) ||
                     (adev->apu_flags & AMD_APU_IS_RAVEN2))
                         gfx_v9_1_init_rlc_save_restore_list(adev);
                 gfx_v9_0_enable_save_restore_machine(adev);
@@ -2925,7 +2926,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *=
adev)
                         return r;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 1, 0):
                 gfx_v9_0_init_lbpw(adev);
@@ -3713,8 +3714,8 @@ static void gfx_v9_0_init_tcp_config(struct amdgpu_de=
vice *adev)
 {
         u32 tmp;

-       if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 1) &&
-           adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 1) &&
+           amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 2))
                 return;

         tmp =3D RREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG);
@@ -3754,7 +3755,7 @@ static int gfx_v9_0_hw_init(void *handle)
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                 gfx_v9_4_2_set_power_brake_sequence(adev);

         return r;
@@ -3802,7 +3803,7 @@ static int gfx_v9_0_hw_fini(void *handle)

         /* Skip stopping RLC with A+A reset or when RLC controls GFX clock=
 */
         if ((adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev)) ||
-           (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 4, 2))) {
+           (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2)))=
 {
                 dev_dbg(adev->dev, "Skipping RLC halt\n");
                 return 0;
         }
@@ -3986,7 +3987,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct=
 amdgpu_device *adev)
 {
         uint64_t clock, clock_lo, clock_hi, hi_check;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 3, 0):
                 preempt_disable();
                 clock_hi =3D RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_CO=
UNT_UPPER_Renoir);
@@ -4005,7 +4006,9 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct=
 amdgpu_device *adev)
         default:
                 amdgpu_gfx_off_ctrl(adev, false);
                 mutex_lock(&adev->gfx.gpu_clock_mutex);
-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 0, 1=
) && amdgpu_sriov_runtime(adev)) {
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(9, 0, 1) &&
+                   amdgpu_sriov_runtime(adev)) {
                         clock =3D gfx_v9_0_kiq_read_clock(adev);
                 } else {
                         WREG32_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT,=
 1);
@@ -4357,7 +4360,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amd=
gpu_device *adev)
         if (!ring->sched.ready)
                 return 0;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1))=
 {
                 vgpr_init_shader_ptr =3D vgpr_init_compute_shader_arcturus=
;
                 vgpr_init_shader_size =3D sizeof(vgpr_init_compute_shader_=
arcturus);
                 vgpr_init_regs_ptr =3D vgpr_init_regs_arcturus;
@@ -4509,8 +4512,8 @@ static int gfx_v9_0_early_init(void *handle)

         adev->gfx.funcs =3D &gfx_v9_0_gfx_funcs;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                 adev->gfx.num_gfx_rings =3D 0;
         else
                 adev->gfx.num_gfx_rings =3D GFX9_NUM_GFX_RINGS;
@@ -4548,7 +4551,7 @@ static int gfx_v9_0_ecc_late_init(void *handle)
         }

         /* requires IBs so do in late init after IB pool is initialized */
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                 r =3D gfx_v9_4_2_do_edc_gpr_workarounds(adev);
         else
                 r =3D gfx_v9_0_do_edc_gpr_workarounds(adev);
@@ -4580,7 +4583,7 @@ static int gfx_v9_0_late_init(void *handle)
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))
                 gfx_v9_4_2_debug_trap_config_init(adev,
                         adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
         else
@@ -4676,7 +4679,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating=
(struct amdgpu_device *adev
                 /* 1 - RLC_CGTT_MGCG_OVERRIDE */
                 def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERR=
IDE);

-               if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 2, 1))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, =
2, 1))
                         data &=3D ~RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_O=
VERRIDE_MASK;

                 data &=3D ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRID=
E_MASK |
@@ -4710,7 +4713,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating=
(struct amdgpu_device *adev
                 /* 1 - MGCG_OVERRIDE */
                 def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERR=
IDE);

-               if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 2, 1))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, =
2, 1))
                         data |=3D RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_OV=
ERRIDE_MASK;

                 data |=3D (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_=
MASK |
@@ -4816,7 +4819,7 @@ static void gfx_v9_0_update_coarse_grain_clock_gating=
(struct amdgpu_device *adev
                 /* enable cgcg FSM(0x0000363F) */
                 def =3D RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);

-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1=
))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 1))
                         data =3D (0x2000 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_I=
DLE_THRESHOLD__SHIFT) |
                                 RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
                 else
@@ -4951,7 +4954,7 @@ static int gfx_v9_0_set_powergating_state(void *handl=
e,
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         bool enable =3D (state =3D=3D AMD_PG_STATE_GATE);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 2, 2):
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 3, 0):
@@ -4998,7 +5001,7 @@ static int gfx_v9_0_set_clockgating_state(void *handl=
e,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -5048,7 +5051,7 @@ static void gfx_v9_0_get_clockgating_state(void *hand=
le, u64 *flags)
         if (data & CP_MEM_SLP_CNTL__CP_MEM_LS_EN_MASK)
                 *flags |=3D AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT_GFX_=
MGLS;

-       if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 1)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 1)) {
                 /* AMD_CG_SUPPORT_GFX_3D_CGCG */
                 data =3D RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGCG_CGL=
S_CTRL_3D));
                 if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
@@ -7087,7 +7090,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)

 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -7106,7 +7109,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_devi=
ce *adev)
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)
 {
         /* init asci gds info */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 2, 1):
         case IP_VERSION(9, 4, 0):
@@ -7128,7 +7131,7 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_devic=
e *adev)
                 break;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
         case IP_VERSION(9, 4, 0):
                 adev->gds.gds_compute_max_wave_id =3D 0x7ff;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 32a740104868..fbfe0a1c4b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -682,7 +682,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_devi=
ce *adev)
         adev->gfx.funcs =3D &gfx_v9_4_3_gfx_funcs;
         adev->gfx.ras =3D &gfx_v9_4_3_ras;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 3):
                 adev->gfx.config.max_hw_contexts =3D 8;
                 adev->gfx.config.sc_prim_fifo_size_frontend =3D 0x20;
@@ -2430,7 +2430,7 @@ static int gfx_v9_4_3_set_clockgating_state(void *han=
dle,
                 return 0;

         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 3):
                 for (i =3D 0; i < num_xcc; i++)
                         gfx_v9_4_3_xcc_update_gfx_clock_gating(
@@ -4231,7 +4231,7 @@ static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_de=
vice *adev)
 static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 {
         /* init asci gds info */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 3):
                 /* 9.4.3 removed all the GDS internal memory,
                  * only support GWS opcode in kernel, like barrier
@@ -4243,7 +4243,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_dev=
ice *adev)
                 break;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 3):
                 /* deprecated for 9.4.3, no usage at all */
                 adev->gds.gds_compute_max_wave_id =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 0834af771549..ff60670b8464 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -356,11 +356,14 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct =
amdgpu_device *adev,
                          * the SQ per-process.
                          * Retry faults need to be enabled for that to wor=
k.
                          */
-                       tmp =3D REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
-                                           RETRY_PERMISSION_OR_INVALID_PAG=
E_FAULT,
-                                           !adev->gmc.noretry ||
-                                           adev->ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2) ||
-                                           adev->ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3));
+                       tmp =3D REG_SET_FIELD(
+                               tmp, VM_CONTEXT1_CNTL,
+                               RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
+                               !adev->gmc.noretry ||
+                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
+                                               IP_VERSION(9, 4, 2) ||
+                                       amdgpu_ip_version(adev, GC_HWIP, 0)=
 =3D=3D
+                                               IP_VERSION(9, 4, 3));
                         WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CON=
TEXT1_CNTL,
                                             i * hub->ctx_distance, tmp);
                         WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c
index 7708d5ded7b8..f829c441640a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -510,7 +510,7 @@ static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_devi=
ce *adev)
         u32 max_num_physical_nodes   =3D 0;
         u32 max_physical_node_id     =3D 0;

-       switch (adev->ip_versions[XGMI_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
         case IP_VERSION(4, 8, 0):
                 max_num_physical_nodes   =3D 4;
                 max_physical_node_id     =3D 3;
@@ -548,7 +548,7 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_dev=
ice *adev)
                 adev->gfx.config.max_sh_per_se *
                 adev->gfx.config.max_shader_engines);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 1):
         case IP_VERSION(10, 3, 3):
                 /* Get SA disabled bitmap from eFuse setting */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index fa87a85e1017..d3da13f4c80e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -145,7 +145,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_de=
vice *adev,
                  * the new fast GRBM interface.
                  */
                 if ((entry->vmid_src =3D=3D AMDGPU_GFXHUB(0)) &&
-                   (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
+                   (amdgpu_ip_version(adev, GC_HWIP, 0) <
+                    IP_VERSION(10, 3, 0)))
                         RREG32(hub->vm_l2_pro_fault_status);

                 status =3D RREG32(hub->vm_l2_pro_fault_status);
@@ -278,7 +279,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device=
 *adev, uint32_t vmid,
          * to avoid a false ACK due to the new fast GRBM interface.
          */
         if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
-           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
+           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)))
                 RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
                                   hub->eng_distance * eng, hub_ip);

@@ -680,7 +681,7 @@ static void gmc_v10_0_set_gmc_funcs(struct amdgpu_devic=
e *adev)

 static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[UMC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
         case IP_VERSION(8, 7, 0):
                 adev->umc.max_ras_err_cnt_per_query =3D UMC_V8_7_TOTAL_CHA=
NNEL_NUM;
                 adev->umc.channel_inst_num =3D UMC_V8_7_CHANNEL_INSTANCE_N=
UM;
@@ -697,7 +698,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_devic=
e *adev)

 static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 3, 0):
         case IP_VERSION(2, 4, 0):
         case IP_VERSION(2, 4, 1):
@@ -711,7 +712,7 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_dev=
ice *adev)

 static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
@@ -825,7 +826,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev=
)

         /* set the gart size */
         if (amdgpu_gart_size =3D=3D -1) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 default:
                         adev->gmc.gart_size =3D 512ULL << 20;
                         break;
@@ -892,7 +893,7 @@ static int gmc_v10_0_sw_init(void *handle)
                 adev->gmc.vram_vendor =3D vram_vendor;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 adev->gmc.mall_size =3D 128 * 1024 * 1024;
                 break;
@@ -910,7 +911,7 @@ static int gmc_v10_0_sw_init(void *handle)
                 break;
         }

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
         case IP_VERSION(10, 1, 1):
         case IP_VERSION(10, 1, 2):
@@ -1195,7 +1196,8 @@ static int gmc_v10_0_set_clockgating_state(void *hand=
le,
          * is a new problem observed at DF 3.0.3, however with the same su=
spend sequence not
          * seen any issue on the DF 3.0.2 series platform.
          */
-       if (adev->in_s0ix && adev->ip_versions[DF_HWIP][0] > IP_VERSION(3, =
0, 2)) {
+       if (adev->in_s0ix &&
+           amdgpu_ip_version(adev, DF_HWIP, 0) > IP_VERSION(3, 0, 2)) {
                 dev_dbg(adev->dev, "keep mmhub clock gating being enabled =
for s0ix\n");
                 return 0;
         }
@@ -1204,7 +1206,7 @@ static int gmc_v10_0_set_clockgating_state(void *hand=
le,
         if (r)
                 return r;

-       if (adev->ip_versions[ATHUB_HWIP][0] >=3D IP_VERSION(2, 1, 0))
+       if (amdgpu_ip_version(adev, ATHUB_HWIP, 0) >=3D IP_VERSION(2, 1, 0)=
)
                 return athub_v2_1_set_clockgating(adev, state);
         else
                 return athub_v2_0_set_clockgating(adev, state);
@@ -1214,13 +1216,13 @@ static void gmc_v10_0_get_clockgating_state(void *h=
andle, u64 *flags)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 3) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 3)=
 ||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 4)=
)
                 return;

         adev->mmhub.funcs->get_clockgating(adev, flags);

-       if (adev->ip_versions[ATHUB_HWIP][0] >=3D IP_VERSION(2, 1, 0))
+       if (amdgpu_ip_version(adev, ATHUB_HWIP, 0) >=3D IP_VERSION(2, 1, 0)=
)
                 athub_v2_1_get_clockgating(adev, flags);
         else
                 athub_v2_0_get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 671e288c7575..e1f47f9c1881 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -588,7 +588,7 @@ static void gmc_v11_0_set_gmc_funcs(struct amdgpu_devic=
e *adev)

 static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[UMC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
         case IP_VERSION(8, 10, 0):
                 adev->umc.channel_inst_num =3D UMC_V8_10_CHANNEL_INSTANCE_=
NUM;
                 adev->umc.umc_inst_num =3D UMC_V8_10_UMC_INSTANCE_NUM;
@@ -611,7 +611,7 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_devic=
e *adev)

 static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 1):
                 adev->mmhub.funcs =3D &mmhub_v3_0_1_funcs;
                 break;
@@ -629,7 +629,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_dev=
ice *adev)

 static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 3):
                 adev->gfxhub.funcs =3D &gfxhub_v3_0_3_funcs;
                 break;
@@ -782,7 +782,7 @@ static int gmc_v11_0_sw_init(void *handle)
         adev->gmc.vram_type =3D vram_type;
         adev->gmc.vram_vendor =3D vram_vendor;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 1):
         case IP_VERSION(11, 0, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 3d13d0bba7b1..268ee533e7c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -640,7 +640,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,
                 addr, entry->client_id,
                 soc15_ih_clientid_name[entry->client_id]);

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 dev_err(adev->dev, "  cookie node_id %d fault from die %s%=
d%s\n",
                         node_id, node_id % 4 =3D=3D 3 ? "RSV" : "AID", nod=
e_id / 4,
                         node_id % 4 =3D=3D 1 ? ".XCD0" : node_id % 4 =3D=
=3D 2 ? ".XCD1" : "");
@@ -654,7 +654,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,
          * the new fast GRBM interface.
          */
         if ((entry->vmid_src =3D=3D AMDGPU_GFXHUB(0)) &&
-           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+           (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
                 RREG32(hub->vm_l2_pro_fault_status);

         status =3D RREG32(hub->vm_l2_pro_fault_status);
@@ -671,7 +671,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,
                         gfxhub_client_ids[cid],
                         cid);
         } else {
-               switch (adev->ip_versions[MMHUB_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
                 case IP_VERSION(9, 0, 0):
                         mmhub_cid =3D mmhub_client_ids_vega10[cid][rw];
                         break;
@@ -772,8 +772,8 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned in=
t vmid,
 static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
                                        uint32_t vmhub)
 {
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 return false;

         return ((vmhub =3D=3D AMDGPU_MMHUB0(0) ||
@@ -824,7 +824,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,

         hub =3D &adev->vmhub[vmhub];
         if (adev->gmc.xgmi.num_physical_nodes &&
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0)) {
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 0))=
 {
                 /* Vega20+XGMI caches PTEs in TC and TLB. Add a
                  * heavy-weight TLB flush (type 2), which flushes
                  * both. Due to a race condition with concurrent
@@ -834,7 +834,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                 inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 2);
                 inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type)=
;
         } else if (flush_type =3D=3D 2 &&
-                  adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)=
 &&
+                  amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) &&
                    adev->rev_id =3D=3D 0) {
                 inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 0);
                 inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type)=
;
@@ -896,7 +896,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,
                  * GRBM interface.
                  */
                 if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
-                   (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+                   (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4,=
 2)))
                         RREG32_NO_KIQ(hub->vm_inv_eng0_req +
                                       hub->eng_distance * eng);

@@ -969,7 +969,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,
                  * still need a second TLB flush after this.
                  */
                 bool vega20_xgmi_wa =3D (adev->gmc.xgmi.num_physical_nodes=
 &&
-                                      adev->ip_versions[GC_HWIP][0] =3D=3D=
 IP_VERSION(9, 4, 0));
+                                      amdgpu_ip_version(adev, GC_HWIP, 0) =
=3D=3D
+                                              IP_VERSION(9, 4, 0));
                 /* 2 dwords flush + 8 dwords fence */
                 unsigned int ndw =3D kiq->pmf->invalidate_tlbs_size + 8;

@@ -984,7 +985,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,
                                                       pasid, 2, all_hub);

                 if (flush_type =3D=3D 2 &&
-                   adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3=
) &&
+                   amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
+                           IP_VERSION(9, 4, 3) &&
                     adev->rev_id =3D=3D 0)
                         kiq->pmf->kiq_invalidate_tlbs(ring,
                                                 pasid, 0, all_hub);
@@ -1192,7 +1194,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgp=
u_device *adev,
         bool snoop =3D false;
         bool is_local;

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 1):
         case IP_VERSION(9, 4, 2):
                 if (is_vram) {
@@ -1206,8 +1208,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdg=
pu_device *adev,
                                 /* FIXME: is this still needed? Or does
                                  * amdgpu_ttm_tt_pde_flags already handle =
this?
                                  */
-                               if ((adev->ip_versions[GC_HWIP][0] =3D=3D I=
P_VERSION(9, 4, 2) ||
-                                    adev->ip_versions[GC_HWIP][0] =3D=3D I=
P_VERSION(9, 4, 3)) &&
+                               if ((amdgpu_ip_version(adev, GC_HWIP, 0) =
=3D=3D
+                                            IP_VERSION(9, 4, 2) ||
+                                    amdgpu_ip_version(adev, GC_HWIP, 0) =
=3D=3D
+                                            IP_VERSION(9, 4, 3)) &&
                                     adev->gmc.xgmi.connected_to_cpu)
                                         snoop =3D true;
                         } else {
@@ -1316,7 +1320,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amd=
gpu_device *adev,
         /* Only GFX 9.4.3 APUs associate GPUs with NUMA nodes. Local syste=
m
          * memory can use more efficient MTYPEs.
          */
-       if (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 3))
                 return;

         /* Only direct-mapped memory allows us to determine the NUMA node =
from
@@ -1385,7 +1389,7 @@ static unsigned int gmc_v9_0_get_vbios_fb_size(struct=
 amdgpu_device *adev)
         } else {
                 u32 viewport;

-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                         viewport =3D RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_P=
RI_VIEWPORT_DIMENSION);
@@ -1456,7 +1460,7 @@ static void gmc_v9_0_set_gmc_funcs(struct amdgpu_devi=
ce *adev)

 static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[UMC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
         case IP_VERSION(6, 0, 0):
                 adev->umc.funcs =3D &umc_v6_0_funcs;
                 break;
@@ -1510,7 +1514,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)

 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(9, 4, 1):
                 adev->mmhub.funcs =3D &mmhub_v9_4_funcs;
                 break;
@@ -1528,7 +1532,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_de=
vice *adev)

 static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(9, 4, 0):
                 adev->mmhub.ras =3D &mmhub_v1_0_ras;
                 break;
@@ -1549,7 +1553,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgp=
u_device *adev)

 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 adev->gfxhub.funcs =3D &gfxhub_v1_2_funcs;
         else
                 adev->gfxhub.funcs =3D &gfxhub_v1_0_funcs;
@@ -1565,7 +1569,7 @@ static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_=
device *adev)
         struct amdgpu_mca *mca =3D &adev->mca;

         /* is UMC the right IP to check for MCA?  Maybe DF? */
-       switch (adev->ip_versions[UMC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
         case IP_VERSION(6, 7, 0):
                 if (!adev->gmc.xgmi.connected_to_cpu) {
                         mca->mp0.ras =3D &mca_v3_0_mp0_ras;
@@ -1592,18 +1596,18 @@ static int gmc_v9_0_early_init(void *handle)
          * 9.4.0, 9.4.1 and 9.4.3 don't have XGMI defined
          * in their IP discovery tables
          */
-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||
-           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 0) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) =
||
+           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 adev->gmc.xgmi.supported =3D true;

-       if (adev->ip_versions[XGMI_HWIP][0] =3D=3D IP_VERSION(6, 1, 0)) {
+       if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(6, 1, 0=
)) {
                 adev->gmc.xgmi.supported =3D true;
                 adev->gmc.xgmi.connected_to_cpu =3D
                         adev->smuio.funcs->is_host_gpu_xgmi_supported(adev=
);
         }

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))=
 {
                 enum amdgpu_pkg_type pkg_type =3D
                         adev->smuio.funcs->get_pkg_type(adev);
                 /* On GFXIP 9.4.3. APU, there is no physical VRAM domain p=
resent
@@ -1652,7 +1656,7 @@ static int gmc_v9_0_late_init(void *handle)
          * writes, while disables HBM ECC for vega10.
          */
         if (!amdgpu_sriov_vf(adev) &&
-           (adev->ip_versions[UMC_HWIP][0] =3D=3D IP_VERSION(6, 0, 0))) {
+           (amdgpu_ip_version(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(6, 0, 0=
))) {
                 if (!(adev->ras_enabled & (1 << AMDGPU_RAS_BLOCK__UMC))) {
                         if (adev->df.funcs &&
                             adev->df.funcs->enable_ecc_force_par_wr_rmw)
@@ -1760,7 +1764,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *ade=
v)

         /* set the gart size */
         if (amdgpu_gart_size =3D=3D -1) {
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 case IP_VERSION(9, 0, 1):  /* all engines support GPUVM */
                 case IP_VERSION(9, 2, 1):  /* all engines support GPUVM */
                 case IP_VERSION(9, 4, 0):
@@ -1839,8 +1843,8 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *a=
dev)
  */
 static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 {
-       if ((adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 0)) ||
-           (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1)))
+       if ((amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 0=
)) ||
+           (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1=
)))
                 adev->gmc.sdpif_register =3D RREG32_SOC15(DCE, 0, mmDCHUBB=
UB_SDPIF_MMIO_CNTRL_0);
 }

@@ -2035,7 +2039,7 @@ static int gmc_v9_0_sw_init(void *handle)

         spin_lock_init(&adev->gmc.invalidate_lock);

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))=
 {
                 gmc_v9_4_3_init_vram_info(adev);
         } else if (!adev->bios) {
                 if (adev->flags & AMD_IS_APU) {
@@ -2075,7 +2079,7 @@ static int gmc_v9_0_sw_init(void *handle)
                 adev->gmc.vram_type =3D vram_type;
                 adev->gmc.vram_vendor =3D vram_vendor;
         }
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 1, 0):
         case IP_VERSION(9, 2, 2):
                 set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
@@ -2108,7 +2112,7 @@ static int gmc_v9_0_sw_init(void *handle)
                         amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
                 else
                         amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2=
))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4, 2))
                         adev->gmc.translate_further =3D adev->vm_manager.n=
um_level > 1;
                 break;
         case IP_VERSION(9, 4, 1):
@@ -2140,7 +2144,7 @@ static int gmc_v9_0_sw_init(void *handle)
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1))=
 {
                 r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VMC1, VMC_=
1_0__SRCID__VM_FAULT,
                                         &adev->gmc.vm_fault);
                 if (r)
@@ -2169,7 +2173,10 @@ static int gmc_v9_0_sw_init(void *handle)
          */
         adev->gmc.mc_mask =3D 0xffffffffffffULL; /* 48 bit MC */

-       dma_addr_bits =3D adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, =
4, 2) ? 48:44;
+       dma_addr_bits =3D amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
+                                       IP_VERSION(9, 4, 2) ?
+                               48 :
+                               44;
         r =3D dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_b=
its));
         if (r) {
                 dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n"=
);
@@ -2183,7 +2190,7 @@ static int gmc_v9_0_sw_init(void *handle)

         amdgpu_gmc_get_vbios_allocations(adev);

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) {
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))=
 {
                 r =3D gmc_v9_0_init_mem_ranges(adev);
                 if (r)
                         return r;
@@ -2209,9 +2216,11 @@ static int gmc_v9_0_sw_init(void *handle)
          * for video processing.
          */
         adev->vm_manager.first_kfd_vmid =3D
-               (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) |=
|
-                adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2) |=
|
-                adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) =
? 3 : 8;
+               (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 1) ||
+                amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 2) ||
+                amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 3)) ?
+                       3 :
+                       8;

         amdgpu_vm_manager_init(adev);

@@ -2221,7 +2230,7 @@ static int gmc_v9_0_sw_init(void *handle)
         if (r)
                 return r;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 amdgpu_gmc_sysfs_init(adev);

         return 0;
@@ -2231,7 +2240,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))
                 amdgpu_gmc_sysfs_fini(adev);
         adev->gmc.num_mem_partitions =3D 0;
         kfree(adev->gmc.mem_partitions);
@@ -2253,8 +2262,7 @@ static int gmc_v9_0_sw_fini(void *handle)

 static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
 {
-
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
                 if (amdgpu_sriov_vf(adev))
                         break;
@@ -2288,8 +2296,8 @@ static void gmc_v9_0_init_golden_registers(struct amd=
gpu_device *adev)
  */
 void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
 {
-       if ((adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 0)) ||
-           (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1))) {
+       if ((amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 0=
)) ||
+           (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1=
))) {
                 WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->=
gmc.sdpif_register);
                 WARN_ON(adev->gmc.sdpif_register !=3D
                         RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0=
));
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c
index 71d1a2e3bac9..3f3a6445c006 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -49,8 +49,8 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev=
,
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
                                     struct amdgpu_ring *ring)
 {
-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 4, 0) ||
-           adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0)=
 ||
+           amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 2)=
)
                 return;

         if (!ring || !ring->funcs->emit_wreg)
@@ -80,7 +80,7 @@ static void hdp_v4_0_reset_ras_error_count(struct amdgpu_=
device *adev)
         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
                 return;

-       if (adev->ip_versions[HDP_HWIP][0] >=3D IP_VERSION(4, 4, 0))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) >=3D IP_VERSION(4, 4, 0))
                 WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);
         else
                 /*read back hdp ras counter to reset it to 0 */
@@ -92,10 +92,10 @@ static void hdp_v4_0_update_clock_gating(struct amdgpu_=
device *adev,
 {
         uint32_t def, data;

-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 0, 0) ||
-           adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 0, 1) ||
-           adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 1, 1) ||
-           adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 1, 0)) {
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 0, 0)=
 ||
+           amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1)=
 ||
+           amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 1, 1)=
 ||
+           amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 1, 0)=
) {
                 def =3D data =3D RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM=
_POWER_LS));

                 if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
@@ -137,7 +137,7 @@ static void hdp_v4_0_get_clockgating_state(struct amdgp=
u_device *adev,

 static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[HDP_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, HDP_HWIP, 0)) {
         case IP_VERSION(4, 2, 1):
                 WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
                 break;
@@ -147,7 +147,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)

         WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);

-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0)=
)
                 WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMAR=
K, 2);

         WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start =
>> 8));
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v6_0.c
index 6f20f9889a78..ab06c2b4b20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -51,7 +51,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_de=
vice *adev,
                                 AMD_CG_SUPPORT_HDP_SD)))
                 return;

-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(6, 1, 0))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(6, 1, 0)=
)
                 hdp_clk_cntl =3D RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1=
);
         else
                 hdp_clk_cntl =3D RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
@@ -61,7 +61,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_de=
vice *adev,
          * forced on IPH & RC clock */
         hdp_clk_cntl =3D REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
                                      RC_MEM_CLK_SOFT_OVERRIDE, 1);
-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(6, 1, 0))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(6, 1, 0)=
)
                 WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cntl);
         else
                 WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
@@ -126,7 +126,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_=
device *adev,
         /* disable IPH & RC clock override after clock/power mode changing=
 */
         hdp_clk_cntl =3D REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
                                      RC_MEM_CLK_SOFT_OVERRIDE, 0);
-       if (adev->ip_versions[HDP_HWIP][0] =3D=3D IP_VERSION(6, 1, 0))
+       if (amdgpu_ip_version(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(6, 1, 0)=
)
                 WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cntl);
         else
                 WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v11_0.c
index 0a8bc6c94fa9..875fb5ac70b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -353,7 +353,7 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_dev=
ice *adev)

         WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);

-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
                 program_imu_rlc_ram(adev, imu_rlc_ram_golden_11,
                                 (const u32)ARRAY_SIZE(imu_rlc_ram_golden_1=
1));
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c
index aadb74de52bc..e67a337457ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -128,7 +128,7 @@ static int jpeg_v2_5_sw_init(void *handle)

                 ring =3D adev->jpeg.inst[i].ring_dec;
                 ring->use_doorbell =3D true;
-               if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(2, 5, =
0))
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(=
2, 5, 0))
                         ring->vm_hub =3D AMDGPU_MMHUB1(0);
                 else
                         ring->vm_hub =3D AMDGPU_MMHUB0(0);
@@ -822,7 +822,7 @@ static struct amdgpu_jpeg_ras jpeg_v2_6_ras =3D {

 static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[JPEG_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, JPEG_HWIP, 0)) {
         case IP_VERSION(2, 6, 0):
                 adev->jpeg.ras =3D &jpeg_v2_6_ras;
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c
index df4440c21bbf..a92481da60cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -52,7 +52,7 @@ static int jpeg_v3_0_early_init(void *handle)

         u32 harvest;

-       switch (adev->ip_versions[UVD_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
         case IP_VERSION(3, 1, 1):
         case IP_VERSION(3, 1, 2):
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index 3eb3dcd56b57..98ed49b16e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -831,7 +831,7 @@ static struct amdgpu_jpeg_ras jpeg_v4_0_ras =3D {

 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[JPEG_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, JPEG_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
                 adev->jpeg.ras =3D &jpeg_v4_0_ras;
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v10_1.c
index eb06d749876f..1e5ad1e08d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -558,7 +558,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,
         WREG32_SOC15(GC, 0, mmCP_MES_MDBOUND_LO, 0x3FFFF);

         /* invalidate ICACHE */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Ci=
chlid);
                 break;
@@ -568,7 +568,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,
         }
         data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
         data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, =
1);
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, da=
ta);
                 break;
@@ -578,7 +578,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,
         }

         /* prime the ICACHE. */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Ci=
chlid);
                 break;
@@ -587,7 +587,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,
                 break;
         }
         data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
                 WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, da=
ta);
                 break;
@@ -995,7 +995,7 @@ static void mes_v10_1_kiq_setting(struct amdgpu_ring *r=
ing)
         struct amdgpu_device *adev =3D ring->adev;

         /* tell RLC which is KIQ queue */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 3, 0):
         case IP_VERSION(10, 3, 2):
         case IP_VERSION(10, 3, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 3fa5bc3ddf92..4a3020b5b30f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1316,7 +1316,7 @@ static int mes_v11_0_late_init(void *handle)

         /* it's only intended for use in mes_self_test case, not for s0ix =
and reset */
         if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend =
&&
-           (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(11, 0, 3)))
+           (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(11, 0, 3))=
)
                 amdgpu_mes_self_test(adev);

         return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 8f76c6ecf50a..37458f906980 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -151,7 +151,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdg=
pu_device *adev,
         dev_err(adev->dev,
                 "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
                 status);
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 0, 0):
         case IP_VERSION(2, 0, 2):
                 mmhub_cid =3D mmhub_client_ids_navi1x[cid][rw];
@@ -568,7 +568,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating=
(struct amdgpu_device *ad
         if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_MGCG))
                 return;

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
         case IP_VERSION(2, 1, 1):
         case IP_VERSION(2, 1, 2):
@@ -601,7 +601,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating=
(struct amdgpu_device *ad
                           DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);
         }

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
         case IP_VERSION(2, 1, 1):
         case IP_VERSION(2, 1, 2):
@@ -625,7 +625,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(=
struct amdgpu_device *ade
         if (!(adev->cg_flags & AMD_CG_SUPPORT_MC_LS))
                 return;

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
         case IP_VERSION(2, 1, 1):
         case IP_VERSION(2, 1, 2):
@@ -651,7 +651,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_dev=
ice *adev,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 0, 0):
         case IP_VERSION(2, 0, 2):
         case IP_VERSION(2, 1, 0):
@@ -676,7 +676,7 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u64 *flags)
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
         case IP_VERSION(2, 1, 1):
         case IP_VERSION(2, 1, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c
index 1dce053a4c4d..4ddd9448e2bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -90,7 +90,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu=
_device *adev,
         dev_err(adev->dev,
                 "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
                 status);
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(2, 3, 0):
         case IP_VERSION(2, 4, 0):
         case IP_VERSION(2, 4, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c
index 7c9ab5491067..9627df8b194b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -107,7 +107,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdg=
pu_device *adev,
         dev_err(adev->dev,
                 "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
                 status);
-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 0):
         case IP_VERSION(3, 0, 1):
                 mmhub_cid =3D mmhub_client_ids_v3_0_0[cid][rw];
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_1.c
index db79e6f92441..77bff803b452 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -108,7 +108,7 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct am=
dgpu_device *adev,
                 "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
                 status);

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(3, 0, 1):
                 mmhub_cid =3D mmhub_client_ids_v3_0_1[cid][rw];
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_3.c
index 8194ee2b96c4..3d80a184ce6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -96,7 +96,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu=
_device *adev,
                 "MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
                 status);

-       switch (adev->ip_versions[MMHUB_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
         case IP_VERSION(3, 3, 0):
                 mmhub_cid =3D mmhub_client_ids_v3_3[cid][rw];
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c
index b6a8478dabf4..bb1873363d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -107,7 +107,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *ad=
ev,
 {
         u32 ih_cntl, ih_rb_cntl;

-       if (adev->ip_versions[OSSSYS_HWIP][0] < IP_VERSION(5, 0, 3))
+       if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) < IP_VERSION(5, 0, 3))
                 return;

         ih_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_CNTL2);
@@ -330,7 +330,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *ade=
v)

         if (unlikely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT=
)) {
                 if (ih[0]->use_bus_addr) {
-                       switch (adev->ip_versions[OSSSYS_HWIP][0]) {
+                       switch (amdgpu_ip_version(adev, OSSSYS_HWIP, 0)) {
                         case IP_VERSION(5, 0, 3):
                         case IP_VERSION(5, 2, 0):
                         case IP_VERSION(5, 2, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v2_3.c
index 4038455d7998..e523627cfe25 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -536,7 +536,7 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct a=
mdgpu_device *adev)
 {
         uint32_t reg, reg_data;

-       if (adev->ip_versions[NBIO_HWIP][0] !=3D IP_VERSION(3, 3, 0))
+       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) !=3D IP_VERSION(3, 3, 0))
                 return;

         reg =3D RREG32_SOC15(NBIO, 0, mmBIF_RB_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c
index e5b5b0f4940f..a3622897e3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -338,7 +338,7 @@ const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg=
 =3D {

 static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
 {
-       if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(4, 3, 0)) {
+       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(4, 3, 0=
)) {
                 uint32_t data;

                 data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
@@ -392,8 +392,8 @@ static void nbio_v4_3_program_aspm(struct amdgpu_device=
 *adev)
 #ifdef CONFIG_PCIEASPM
         uint32_t def, data;

-       if (!(adev->ip_versions[PCIE_HWIP][0] =3D=3D IP_VERSION(7, 4, 0)) &=
&
-             !(adev->ip_versions[PCIE_HWIP][0] =3D=3D IP_VERSION(7, 6, 0))=
)
+       if (!(amdgpu_ip_version(adev, PCIE_HWIP, 0) =3D=3D IP_VERSION(7, 4,=
 0)) &&
+           !(amdgpu_ip_version(adev, PCIE_HWIP, 0) =3D=3D IP_VERSION(7, 6,=
 0)))
                 return;

         def =3D data =3D RREG32_SOC15(NBIO, 0, regPCIE_LC_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c
index 4ef1fa4603c8..e962821ae6a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -59,7 +59,7 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *ade=
v)
 {
         u32 tmp;

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 2, 1):
         case IP_VERSION(7, 3, 0):
         case IP_VERSION(7, 5, 0):
@@ -78,7 +78,7 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *ade=
v)

 static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool en=
able)
 {
-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 2, 1):
         case IP_VERSION(7, 3, 0):
         case IP_VERSION(7, 5, 0):
@@ -262,7 +262,7 @@ static void nbio_v7_2_update_medium_grain_light_sleep(s=
truct amdgpu_device *adev
 {
         uint32_t def, data;

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 2, 1):
         case IP_VERSION(7, 3, 0):
         case IP_VERSION(7, 5, 0):
@@ -369,7 +369,7 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg=
 =3D {
 static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 {
         uint32_t def, data;
-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 2, 1):
         case IP_VERSION(7, 3, 0):
         case IP_VERSION(7, 5, 0):
@@ -394,7 +394,7 @@ static void nbio_v7_2_init_registers(struct amdgpu_devi=
ce *adev)
                 break;
         }

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(7, 3, 0):
         case IP_VERSION(7, 5, 1):
                 data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP2);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 685abf57ffdd..7d6d7734dbec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -347,7 +347,7 @@ static void nbio_v7_4_init_registers(struct amdgpu_devi=
ce *adev)
                 adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
                         mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNT=
L) << 2;

-       if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(7, 4, 4) &&
+       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 4, 4=
) &&
             !amdgpu_sriov_vf(adev)) {
                 baco_cntl =3D RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
                 if (baco_cntl &
@@ -702,7 +702,7 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device=
 *adev)
 #ifdef CONFIG_PCIEASPM
         uint32_t def, data;

-       if (adev->ip_versions[NBIO_HWIP][0] =3D=3D IP_VERSION(7, 4, 4))
+       if (amdgpu_ip_version(adev, NBIO_HWIP, 0) =3D=3D IP_VERSION(7, 4, 4=
))
                 return;

         def =3D data =3D RREG32_PCIE(smnPCIE_LC_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 13aca808ecab..0535cabe3b16 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -214,7 +214,7 @@ static int nv_query_video_codecs(struct amdgpu_device *=
adev, bool encode,
         if (adev->vcn.num_vcn_inst =3D=3D hweight8(adev->vcn.harvest_confi=
g))
                 return -EINVAL;

-       switch (adev->ip_versions[UVD_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
         case IP_VERSION(3, 0, 0):
         case IP_VERSION(3, 0, 64):
         case IP_VERSION(3, 0, 192):
@@ -453,7 +453,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 5, 0):
         case IP_VERSION(13, 0, 1):
         case IP_VERSION(13, 0, 3):
@@ -669,7 +669,7 @@ static int nv_common_early_init(void *handle)
         /* TODO: split the GC and PG flags based on the relevant IP versio=
n for which
          * they are relevant.
          */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(10, 1, 10):
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
                         AMD_CG_SUPPORT_GFX_CGCG |
@@ -1073,7 +1073,7 @@ static int nv_common_set_clockgating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(2, 3, 0):
         case IP_VERSION(2, 3, 1):
         case IP_VERSION(2, 3, 2):
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 5f10883da6a2..145186a1e48f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -58,9 +58,10 @@ static int psp_v10_0_init_microcode(struct psp_context *=
psp)
                 return err;

         err =3D psp_init_ta_microcode(psp, ucode_prefix);
-       if ((adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 1, 0)) &&
-               (adev->pdev->revision =3D=3D 0xa1) &&
-               (psp->securedisplay_context.context.bin_desc.fw_version >=
=3D 0x27000008)) {
+       if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 1, 0)=
) &&
+           (adev->pdev->revision =3D=3D 0xa1) &&
+           (psp->securedisplay_context.context.bin_desc.fw_version >=3D
+            0x27000008)) {
                 adev->psp.securedisplay_context.context.bin_desc.size_byte=
s =3D 0;
         }
         return err;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 8f84fe40abbb..efa37e3b7931 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -95,7 +95,7 @@ static int psp_v11_0_init_microcode(struct psp_context *p=
sp)

         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(11, 0, 2):
         case IP_VERSION(11, 0, 4):
                 err =3D psp_init_sos_microcode(psp, ucode_prefix);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 469eed084976..54008a8991fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -79,7 +79,7 @@ static int psp_v13_0_init_microcode(struct psp_context *p=
sp)

         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(13, 0, 2):
                 err =3D psp_init_sos_microcode(psp, ucode_prefix);
                 if (err)
@@ -181,7 +181,7 @@ static int psp_v13_0_wait_for_bootloader_steady_state(s=
truct psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;

-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 6)) {
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
)) {
                 psp_v13_0_wait_for_vmbx_ready(psp);

                 return psp_v13_0_wait_for_bootloader(psp);
@@ -728,7 +728,7 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct =
psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;

-       if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) {
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
0)) {
                 uint32_t  reg_data;
                 /* MP1 fatal error: trigger PSP dram read to unhalt PSP
                  * during MP1 triggered sync flood.
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0_4.c
index d5ba58eba3e2..eaa5512a21da 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -40,7 +40,7 @@ static int psp_v13_0_4_init_microcode(struct psp_context =
*psp)

         amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));

-       switch (adev->ip_versions[MP0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
         case IP_VERSION(13, 0, 4):
                 err =3D psp_init_toc_microcode(psp, ucode_prefix);
                 if (err)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index cd37f45e01a1..8562ac7f7ff0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -469,7 +469,7 @@ static int sdma_v4_0_irq_id_to_seq(unsigned client_id)

 static void sdma_v4_0_init_golden_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_sdma_4,
@@ -539,7 +539,7 @@ static void sdma_v4_0_setup_ulv(struct amdgpu_device *a=
dev)
          * The only chips with SDMAv4 and ULV are VG10 and VG20.
          * Server SKUs take a different hysteresis setting from other SKUs=
.
          */
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
                 if (adev->pdev->device =3D=3D 0x6860)
                         break;
@@ -578,8 +578,10 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devi=
ce *adev)
         int ret, i;

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2=
, 2) ||
-                    adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, =
4, 0)) {
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                           IP_VERSION(4, 2, 2) ||
+                   amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                           IP_VERSION(4, 4, 0)) {
                         /* Acturus & Aldebaran will leverage the same FW m=
emory
                            for every SDMA instance */
                         ret =3D amdgpu_sdma_init_microcode(adev, 0, true);
@@ -978,7 +980,8 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_d=
evice *adev, bool enable)
                  * Arcturus for the moment and firmware version 14
                  * and above.
                  */
-               if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2=
, 2) &&
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                           IP_VERSION(4, 2, 2) &&
                     adev->sdma.instance[i].fw_version >=3D 14)
                         WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
                 /* Extend page fault timeout to avoid interrupt storm */
@@ -1255,7 +1258,7 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *a=
dev)
         if (!(adev->pg_flags & AMD_PG_SUPPORT_SDMA))
                 return;

-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 1, 0):
         case IP_VERSION(4, 1, 1):
         case IP_VERSION(4, 1, 2):
@@ -1698,7 +1701,7 @@ static bool sdma_v4_0_fw_support_paging_queue(struct =
amdgpu_device *adev)
 {
         uint fw_version =3D adev->sdma.instance[0].fw_version;

-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
                 return fw_version >=3D 430;
         case IP_VERSION(4, 0, 1):
@@ -1723,7 +1726,7 @@ static int sdma_v4_0_early_init(void *handle)
         }

         /* TODO: Page queue breaks driver reload under SRIOV */
-       if ((adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 0, 0)) &=
&
+       if ((amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSION(4, 0,=
 0)) &&
             amdgpu_sriov_vf((adev)))
                 adev->sdma.has_page_queue =3D false;
         else if (sdma_v4_0_fw_support_paging_queue(adev))
@@ -1823,7 +1826,9 @@ static int sdma_v4_0_sw_init(void *handle)
                  * On Arcturus, SDMA instance 5~7 has a different vmhub
                  * type(AMDGPU_MMHUB1).
                  */
-               if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2=
, 2) && i >=3D 5)
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                           IP_VERSION(4, 2, 2) &&
+                   i >=3D 5)
                         ring->vm_hub =3D AMDGPU_MMHUB1(0);
                 else
                         ring->vm_hub =3D AMDGPU_MMHUB0(0);
@@ -1843,8 +1848,10 @@ static int sdma_v4_0_sw_init(void *handle)
                         /* paging queue use same doorbell index/routing as=
 gfx queue
                          * with 0x400 (4096 dwords) offset on second doorb=
ell page
                          */
-                       if (adev->ip_versions[SDMA0_HWIP][0] >=3D IP_VERSIO=
N(4, 0, 0) &&
-                           adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(4=
, 2, 0)) {
+                       if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >=3D
+                                   IP_VERSION(4, 0, 0) &&
+                           amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
+                                   IP_VERSION(4, 2, 0)) {
                                 ring->doorbell_index =3D
                                         adev->doorbell_index.sdma_engine[i=
] << 1;
                                 ring->doorbell_index +=3D 0x400;
@@ -1856,7 +1863,9 @@ static int sdma_v4_0_sw_init(void *handle)
                                         (adev->doorbell_index.sdma_engine[=
i] + 1) << 1;
                         }

-                       if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERS=
ION(4, 2, 2) && i >=3D 5)
+                       if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                                   IP_VERSION(4, 2, 2) &&
+                           i >=3D 5)
                                 ring->vm_hub =3D AMDGPU_MMHUB1(0);
                         else
                                 ring->vm_hub =3D AMDGPU_MMHUB0(0);
@@ -1890,8 +1899,8 @@ static int sdma_v4_0_sw_fini(void *handle)
                         amdgpu_ring_fini(&adev->sdma.instance[i].page);
         }

-       if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) ||
-            adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))
+       if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
2) ||
+           amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSION(4, 4, =
0))
                 amdgpu_sdma_destroy_inst_ctx(adev, true);
         else
                 amdgpu_sdma_destroy_inst_ctx(adev, false);
@@ -2036,14 +2045,16 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu=
_device *adev,
                 amdgpu_fence_process(&adev->sdma.instance[instance].ring);
                 break;
         case 1:
-               if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2=
, 0))
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                   IP_VERSION(4, 2, 0))
                         amdgpu_fence_process(&adev->sdma.instance[instance=
].page);
                 break;
         case 2:
                 /* XXX compute */
                 break;
         case 3:
-               if (adev->ip_versions[SDMA0_HWIP][0] !=3D IP_VERSION(4, 2, =
0))
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) !=3D
+                   IP_VERSION(4, 2, 0))
                         amdgpu_fence_process(&adev->sdma.instance[instance=
].page);
                 break;
         }
@@ -2259,7 +2270,7 @@ static int sdma_v4_0_set_powergating_state(void *hand=
le,
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 1, 0):
         case IP_VERSION(4, 1, 1):
         case IP_VERSION(4, 1, 2):
@@ -2622,7 +2633,7 @@ static struct amdgpu_sdma_ras sdma_v4_0_ras =3D {

 static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 2, 0):
         case IP_VERSION(4, 2, 2):
                 adev->sdma.ras =3D &sdma_v4_0_ras;
@@ -2633,7 +2644,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_dev=
ice *adev)
         default:
                 break;
         }
-
 }

 const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 267c1b7b8dcd..1cadd3cb26a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -132,7 +132,8 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_dev=
ice *adev)
         int ret, i;

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
-               if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4=
, 2)) {
+               if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                   IP_VERSION(4, 4, 2)) {
                         ret =3D amdgpu_sdma_init_microcode(adev, 0, true);
                         break;
                 } else {
@@ -1231,7 +1232,7 @@ static void sdma_v4_4_2_ring_emit_reg_wait(struct amd=
gpu_ring *ring, uint32_t re

 static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev=
)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(4, 4, 2):
                 return false;
         default:
@@ -1401,7 +1402,7 @@ static int sdma_v4_4_2_sw_fini(void *handle)
                         amdgpu_ring_fini(&adev->sdma.instance[i].page);
         }

-       if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))
+       if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSION(4, 4, =
2))
                 amdgpu_sdma_destroy_inst_ctx(adev, true);
         else
                 amdgpu_sdma_destroy_inst_ctx(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 1cc34efb455b..e0527e5ed7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -184,7 +184,7 @@ static u32 sdma_v5_0_get_reg_offset(struct amdgpu_devic=
e *adev, u32 instance, u3

 static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(5, 0, 0):
                 soc15_program_register_sequence(adev,
                                                 golden_settings_sdma_5,
@@ -1697,7 +1697,7 @@ static int sdma_v5_0_set_clockgating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(5, 0, 0):
         case IP_VERSION(5, 0, 2):
         case IP_VERSION(5, 0, 5):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 2b3ebebc4299..0ccb7523bc55 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1510,7 +1510,7 @@ static int sdma_v5_2_process_illegal_inst_irq(struct =
amdgpu_device *adev,
 static bool sdma_v5_2_firmware_mgcg_support(struct amdgpu_device *adev,
                                                      int i)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(5, 2, 1):
                 if (adev->sdma.instance[i].fw_version < 70)
                         return false;
@@ -1575,8 +1575,9 @@ static void sdma_v5_2_update_medium_grain_light_sleep=
(struct amdgpu_device *adev
         int i;

         for (i =3D 0; i < adev->sdma.num_instances; i++) {
-
-               if (adev->sdma.instance[i].fw_version < 70 && adev->ip_vers=
ions[SDMA0_HWIP][0] =3D=3D IP_VERSION(5, 2, 1))
+               if (adev->sdma.instance[i].fw_version < 70 &&
+                   amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D
+                           IP_VERSION(5, 2, 1))
                         adev->cg_flags &=3D ~AMD_CG_SUPPORT_SDMA_LS;

                 if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
@@ -1605,7 +1606,7 @@ static int sdma_v5_2_set_clockgating_state(void *hand=
le,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(5, 2, 0):
         case IP_VERSION(5, 2, 2):
         case IP_VERSION(5, 2, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 0e25b6fb1340..4d6de77d289e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1246,14 +1246,13 @@ static struct amdgpu_sdma_ras sdma_v6_0_3_ras =3D {

 static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[SDMA0_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
         case IP_VERSION(6, 0, 3):
                 adev->sdma.ras =3D &sdma_v6_0_3_ras;
                 break;
         default:
                 break;
         }
-
 }

 static int sdma_v6_0_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/=
amd/amdgpu/sienna_cichlid.c
index 07ded70f4df9..93f6772d1b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -36,7 +36,7 @@ static bool sienna_cichlid_is_mode2_default(struct amdgpu=
_reset_control *reset_c
 #if 0
         struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->=
handle;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7) &&
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 7=
) &&
             adev->pm.fw_version >=3D 0x3a5500 && !amdgpu_sriov_vf(adev))
                 return true;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 9c72add6f93d..66ed28136bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -174,8 +174,8 @@ static const struct amdgpu_video_codecs vcn_4_0_3_video=
_codecs_encode =3D {
 static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encod=
e,
                                     const struct amdgpu_video_codecs **cod=
ecs)
 {
-       if (adev->ip_versions[VCE_HWIP][0]) {
-               switch (adev->ip_versions[VCE_HWIP][0]) {
+       if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
+               switch (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
                 case IP_VERSION(4, 0, 0):
                 case IP_VERSION(4, 1, 0):
                         if (encode)
@@ -187,7 +187,7 @@ static int soc15_query_video_codecs(struct amdgpu_devic=
e *adev, bool encode,
                         return -EINVAL;
                 }
         } else {
-               switch (adev->ip_versions[UVD_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                         if (encode)
@@ -324,12 +324,12 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
         u32 reference_clock =3D adev->clock.spll.reference_freq;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(12, 0, 0=
) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(12, 0, 1=
) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
))
                 return 10000;
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(10, 0, 0=
) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(10, 0, 1=
))
                 return reference_clock / 4;

         return reference_clock;
@@ -523,7 +523,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(10, 0, 0):
         case IP_VERSION(10, 0, 1):
         case IP_VERSION(12, 0, 0):
@@ -599,7 +599,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)

 static bool soc15_supports_baco(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(9, 0, 0):
         case IP_VERSION(11, 0, 2):
                 if (adev->asic_type =3D=3D CHIP_VEGA20) {
@@ -938,7 +938,7 @@ static int soc15_common_early_init(void *handle)
         /* TODO: split the GC and PG flags based on the relevant IP versio=
n for which
          * they are relevant.
          */
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 0, 1):
                 adev->asic_funcs =3D &soc15_asic_funcs;
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |
@@ -1367,7 +1367,7 @@ static int soc15_common_set_clockgating_state(void *h=
andle,
         if (amdgpu_sriov_vf(adev))
                 return 0;

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(6, 1, 0):
         case IP_VERSION(6, 2, 0):
         case IP_VERSION(7, 4, 0):
@@ -1423,8 +1423,7 @@ static void soc15_common_get_clockgating_state(void *=
handle, u64 *flags)

         adev->hdp.funcs->get_clock_gating_state(adev, flags);

-       if (adev->ip_versions[MP0_HWIP][0] !=3D IP_VERSION(13, 0, 2)) {
-
+       if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2))=
 {
                 /* AMD_CG_SUPPORT_DRM_MGCG */
                 data =3D RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_C=
TRL0));
                 if (!(data & 0x01000000))
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 2ecc8c9a078b..92a80780ab72 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -153,7 +153,7 @@ static int soc21_query_video_codecs(struct amdgpu_devic=
e *adev, bool encode,
         if (adev->vcn.num_vcn_inst =3D=3D hweight8(adev->vcn.harvest_confi=
g))
                 return -EINVAL;

-       switch (adev->ip_versions[UVD_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
         case IP_VERSION(4, 0, 2):
         case IP_VERSION(4, 0, 4):
@@ -374,7 +374,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
                 dev_warn(adev->dev, "Specified reset method:%d isn't suppo=
rted, using AUTO instead.\n",
                                   amdgpu_reset_method);

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 0):
         case IP_VERSION(13, 0, 7):
         case IP_VERSION(13, 0, 10):
@@ -448,7 +448,7 @@ const struct amdgpu_ip_block_version soc21_common_ip_bl=
ock =3D {

 static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
                 return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC=
);
         case IP_VERSION(11, 0, 2):
@@ -577,7 +577,7 @@ static int soc21_common_early_init(void *handle)

         adev->rev_id =3D amdgpu_device_get_rev_id(adev);
         adev->external_rev_id =3D 0xff;
-       switch (adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
                 adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
                         AMD_CG_SUPPORT_GFX_CGLS |
@@ -843,7 +843,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       switch (adev->ip_versions[NBIO_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
         case IP_VERSION(4, 3, 0):
         case IP_VERSION(4, 3, 1):
         case IP_VERSION(7, 7, 0):
@@ -865,7 +865,7 @@ static int soc21_common_set_powergating_state(void *han=
dle,
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

-       switch (adev->ip_versions[LSDMA_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, LSDMA_HWIP, 0)) {
         case IP_VERSION(6, 0, 0):
         case IP_VERSION(6, 0, 2):
                 adev->lsdma.funcs->update_memory_power_gating(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c
index 67164991f541..99713949b61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -273,14 +273,15 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdg=
pu_umsch_mm *umsch)

         memcpy(set_hw_resources.mmhub_base, adev->reg_offset[MMHUB_HWIP][0=
],
                sizeof(uint32_t) * 5);
-       set_hw_resources.mmhub_version =3D adev->ip_versions[MMHUB_HWIP][0]=
;
+       set_hw_resources.mmhub_version =3D amdgpu_ip_version(adev, MMHUB_HW=
IP, 0);

         memcpy(set_hw_resources.osssys_base, adev->reg_offset[OSSSYS_HWIP]=
[0],
                sizeof(uint32_t) * 5);
-       set_hw_resources.osssys_version =3D adev->ip_versions[OSSSYS_HWIP][=
0];
+       set_hw_resources.osssys_version =3D
+               amdgpu_ip_version(adev, OSSSYS_HWIP, 0);

-       set_hw_resources.vcn_version =3D adev->ip_versions[VCN_HWIP][0];
-       set_hw_resources.vpe_version =3D adev->ip_versions[VPE_HWIP][0];
+       set_hw_resources.vcn_version =3D amdgpu_ip_version(adev, VCN_HWIP, =
0);
+       set_hw_resources.vpe_version =3D amdgpu_ip_version(adev, VPE_HWIP, =
0);

         set_hw_resources.api_status.api_completion_fence_addr =3D umsch->r=
ing.fence_drv.gpu_addr;
         set_hw_resources.api_status.api_completion_fence_value =3D ++umsch=
->ring.fence_drv.sync_seq;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c
index 6fbea38f4d3e..aba403d71806 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -187,7 +187,7 @@ static int vcn_v2_5_sw_init(void *handle)
                 ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_rin=
g0_1 << 1) +
                                 (amdgpu_sriov_vf(adev) ? 2*j : 8*j);

-               if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(2, 5, =
0))
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(=
2, 5, 0))
                         ring->vm_hub =3D AMDGPU_MMHUB1(0);
                 else
                         ring->vm_hub =3D AMDGPU_MMHUB0(0);
@@ -207,7 +207,8 @@ static int vcn_v2_5_sw_init(void *handle)
                         ring->doorbell_index =3D (adev->doorbell_index.vcn=
.vcn_ring0_1 << 1) +
                                         (amdgpu_sriov_vf(adev) ? (1 + i + =
2*j) : (2 + i + 8*j));

-                       if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSIO=
N(2, 5, 0))
+                       if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
+                           IP_VERSION(2, 5, 0))
                                 ring->vm_hub =3D AMDGPU_MMHUB1(0);
                         else
                                 ring->vm_hub =3D AMDGPU_MMHUB0(0);
@@ -794,7 +795,7 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *a=
dev, int inst_idx,
 {
         uint32_t tmp;

-       if (adev->ip_versions[UVD_HWIP][0] !=3D IP_VERSION(2, 6, 0))
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D IP_VERSION(2, 6, 0))
                 return;

         tmp =3D VCN_RAS_CNTL__VCPU_VCODEC_REARM_MASK |
@@ -1985,7 +1986,7 @@ static struct amdgpu_vcn_ras vcn_v2_6_ras =3D {

 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[VCN_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(2, 6, 0):
                 adev->vcn.ras =3D &vcn_v2_6_ras;
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index a61ecefdafc5..e02af4de521c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -100,7 +100,8 @@ static int vcn_v3_0_early_init(void *handle)
                         /* both instances are harvested, disable the block=
 */
                         return -ENOENT;

-               if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 0, =
33))
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
+                   IP_VERSION(3, 0, 33))
                         adev->vcn.num_enc_rings =3D 0;
                 else
                         adev->vcn.num_enc_rings =3D 2;
@@ -227,9 +228,10 @@ static int vcn_v3_0_sw_init(void *handle)
                                              cpu_to_le32(AMDGPU_VCN_FW_SHA=
RED_FLAG_0_RB);
                 fw_shared->sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING_=
ENABLED);
                 fw_shared->present_flag_0 |=3D AMDGPU_VCN_SMU_VERSION_INFO=
_FLAG;
-               if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 1, =
2))
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(=
3, 1, 2))
                         fw_shared->smu_interface_info.smu_interface_type =
=3D 2;
-               else if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3=
, 1, 1))
+               else if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
+                        IP_VERSION(3, 1, 1))
                         fw_shared->smu_interface_info.smu_interface_type =
=3D 1;

                 if (amdgpu_vcnfw_log)
@@ -1255,7 +1257,8 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
                 fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
                 fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(=
~FW_QUEUE_RING_RESET);

-               if (adev->ip_versions[UVD_HWIP][0] !=3D IP_VERSION(3, 0, 33=
)) {
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D
+                   IP_VERSION(3, 0, 33)) {
                         fw_shared->multi_queue.encode_generalpurpose_queue=
_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);
                         ring =3D &adev->vcn.inst[i].ring_enc[0];
                         WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(=
ring->wptr));
@@ -1628,7 +1631,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_devi=
ce *adev,
                                         UVD_POWER_STATUS__STALL_DPG_POWER_=
UP_MASK,
                                         ~UVD_POWER_STATUS__STALL_DPG_POWER=
_UP_MASK);

-                               if (adev->ip_versions[UVD_HWIP][0] !=3D IP_=
VERSION(3, 0, 33)) {
+                               if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
=3D
+                                   IP_VERSION(3, 0, 33)) {
                                         /* Restore */
                                         fw_shared =3D adev->vcn.inst[inst_=
idx].fw_shared.cpu_addr;
                                         fw_shared->multi_queue.encode_gene=
ralpurpose_queue_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index ae8db12d8832..96831f931423 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -169,7 +169,8 @@ static int vcn_v4_0_sw_init(void *handle)
                 fw_shared->smu_dpm_interface.smu_interface_type =3D (adev-=
>flags & AMD_IS_APU) ?
                         AMDGPU_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_=
DPM_INTERFACE_DGPU;

-               if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, =
2)) {
+               if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D
+                   IP_VERSION(4, 0, 2)) {
                         fw_shared->present_flag_0 |=3D AMDGPU_FW_SHARED_FL=
AG_0_DRM_KEY_INJECT;
                         fw_shared->drm_key_wa.method =3D
                                 AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD=
_HANDSHAKING;
@@ -1852,7 +1853,7 @@ static void vcn_v4_0_set_unified_ring_funcs(struct am=
dgpu_device *adev)
                 if (adev->vcn.harvest_config & (1 << i))
                         continue;

-               if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, =
2))
+               if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(=
4, 0, 2))
                         vcn_v4_0_unified_ring_vm_funcs.secure_submission_s=
upported =3D true;

                 adev->vcn.inst[i].ring_enc[0].funcs =3D
@@ -2159,7 +2160,7 @@ static struct amdgpu_vcn_ras vcn_v4_0_ras =3D {

 static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[VCN_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
         case IP_VERSION(4, 0, 0):
                 adev->vcn.ras =3D &vcn_v4_0_ras;
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega20_ih.c
index dbc99536440f..ddfc6941f9d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -291,7 +291,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)

         adev->nbio.funcs->ih_control(adev);

-       if ((adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 2, 1)) =
&&
+       if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 2=
, 1)) &&
             adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
                 ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
                 if (adev->irq.ih.use_bus_addr) {
@@ -304,8 +304,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)
         /* psp firmware won't program IH_CHICKEN for aldebaran
          * driver needs to program it properly according to
          * MC_SPACE type in IH_RB_CNTL */
-       if ((adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 0)) =
||
-           (adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2)))=
 {
+       if ((amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4=
, 0)) ||
+           (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4=
, 2))) {
                 ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBA=
RAN);
                 if (adev->irq.ih.use_bus_addr) {
                         ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICKE=
N,
@@ -334,8 +334,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)
                 vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_i=
ndex));

         /* Enable IH Retry CAM */
-       if (adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 0) ||
-           adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))
+       if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4,=
 0) ||
+           amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4,=
 2))
                 WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
                                ENABLE, 1);
         else
@@ -537,7 +537,7 @@ static int vega20_ih_sw_init(void *handle)
                 return r;

         if ((adev->flags & AMD_IS_APU) &&
-           (adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2)))
+           (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4=
, 2)))
                 use_bus_addr =3D false;

         r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_b=
us_addr);
@@ -554,7 +554,7 @@ static int vega20_ih_sw_init(void *handle)
         adev->irq.ih1.use_doorbell =3D true;
         adev->irq.ih1.doorbell_index =3D (adev->doorbell_index.ih + 1) << =
1;

-       if (adev->ip_versions[OSSSYS_HWIP][0] !=3D IP_VERSION(4, 4, 2)) {
+       if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) !=3D IP_VERSION(4, 4, 2=
)) {
                 r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE,=
 true);
                 if (r)
                         return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index ab4a63bb3e3e..0a9cf9dfc224 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -65,7 +65,7 @@ static int kfd_resume(struct kfd_node *kfd);

 static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 {
-       uint32_t sdma_version =3D kfd->adev->ip_versions[SDMA0_HWIP][0];
+       uint32_t sdma_version =3D amdgpu_ip_version(kfd->adev, SDMA0_HWIP, =
0);

         switch (sdma_version) {
         case IP_VERSION(4, 0, 0):/* VEGA10 */
@@ -282,7 +282,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)
                         f2g =3D &gfx_v8_kfd2kgd;
                 break;
         default:
-               switch (adev->ip_versions[GC_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
                 /* Vega 10 */
                 case IP_VERSION(9, 0, 1):
                         gfx_target_version =3D 90000;
@@ -427,9 +427,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ad=
ev, bool vf)
         }

         if (!f2g) {
-               if (adev->ip_versions[GC_HWIP][0])
-                       dev_err(kfd_device, "GC IP %06x %s not supported in=
 kfd\n",
-                               adev->ip_versions[GC_HWIP][0], vf ? "VF" : =
"");
+               if (amdgpu_ip_version(adev, GC_HWIP, 0))
+                       dev_err(kfd_device,
+                               "GC IP %06x %s not supported in kfd\n",
+                               amdgpu_ip_version(adev, GC_HWIP, 0),
+                               vf ? "VF" : "");
                 else
                         dev_err(kfd_device, "%s %s not supported in kfd\n"=
,
                                 amdgpu_asic_name[adev->asic_type], vf ? "V=
F" : "");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index 7d82c7da223a..192b0d106413 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1001,7 +1001,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *ad=
ev)
         void *r;

         /* Page migration works on gfx9 or newer */
-       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 0, 1))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 1))
                 return -EINVAL;

         if (adev->gmc.is_app_apu)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 1a03173e2313..8ee2bedd301a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -205,7 +205,8 @@ static int pm_set_resources_v9(struct packet_manager *p=
m, uint32_t *buffer,

 static inline bool pm_use_ext_eng(struct kfd_dev *dev)
 {
-       return dev->adev->ip_versions[SDMA0_HWIP][0] >=3D IP_VERSION(5, 2, =
0);
+       return amdgpu_ip_version(dev->adev, SDMA0_HWIP, 0) >=3D
+              IP_VERSION(5, 2, 0);
 }

 static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index b315311dfe2a..ae8e6ce9436d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -202,7 +202,7 @@ enum cache_policy {
         cache_policy_noncoherent
 };

-#define KFD_GC_VERSION(dev) ((dev)->adev->ip_versions[GC_HWIP][0])
+#define KFD_GC_VERSION(dev) (amdgpu_ip_version((dev)->adev, GC_HWIP, 0))
 #define KFD_IS_SOC15(dev)   ((KFD_GC_VERSION(dev)) >=3D (IP_VERSION(9, 0, =
1)))
 #define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\
         ((KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 2)) ||        \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 841ba6102bbb..c8abe7118907 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1194,7 +1194,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
         if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN)
                 bo_node =3D prange->svm_bo->node;

-       switch (node->adev->ip_versions[GC_HWIP][0]) {
+       switch (amdgpu_ip_version(node->adev, GC_HWIP, 0)) {
         case IP_VERSION(9, 4, 1):
                 if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
                         if (bo_node =3D=3D node) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5efebc06296b..933c9b5d5252 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1173,7 +1173,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev=
)
         for (i =3D 0; i < fb_info->num_fb; ++i)
                 hw_params.fb[i] =3D &fb_info->fb[i];

-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(3, 1, 3):
         case IP_VERSION(3, 1, 4):
         case IP_VERSION(3, 5, 0):
@@ -1606,7 +1606,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)

         init_data.dce_environment =3D DCE_ENV_PRODUCTION_DRV;

-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
                 switch (adev->dm.dmcub_fw_version) {
                 case 0: /* development */
@@ -1631,7 +1631,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
                 init_data.flags.gpu_vm_support =3D true;
                 break;
         default:
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                         /* enable S/G on PCO and RV2 */
@@ -2015,7 +2015,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
                         return 0;
                 break;
         default:
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(2, 0, 2):
                 case IP_VERSION(2, 0, 3):
                 case IP_VERSION(2, 0, 0):
@@ -2105,7 +2105,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)
         enum dmub_status status;
         int r;

-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
                 dmub_asic =3D DMUB_ASIC_DCN21;
                 break;
@@ -2477,7 +2477,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struc=
t amdgpu_device *adev)
          * therefore, this function apply to navi10/12/14 but not Renoir
          * *
          */
-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(2, 0, 2):
         case IP_VERSION(2, 0, 0):
                 break;
@@ -4429,7 +4429,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
                 }

         /* Use Outbox interrupt */
-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(3, 0, 0):
         case IP_VERSION(3, 1, 2):
         case IP_VERSION(3, 1, 3):
@@ -4447,12 +4447,12 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
                 break;
         default:
                 DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X=
\n",
-                             adev->ip_versions[DCE_HWIP][0]);
+                             amdgpu_ip_version(adev, DCE_HWIP, 0));
         }

         /* Determine whether to enable PSR support by default. */
         if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(3, 1, 2):
                 case IP_VERSION(3, 1, 3):
                 case IP_VERSION(3, 1, 4):
@@ -4470,7 +4470,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
         }

         if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(3, 1, 4):
                 case IP_VERSION(3, 1, 5):
                 case IP_VERSION(3, 1, 6):
@@ -4589,7 +4589,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
                 }
                 break;
         default:
-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(1, 0, 0):
                 case IP_VERSION(1, 0, 1):
                 case IP_VERSION(2, 0, 2):
@@ -4615,7 +4615,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)
                         break;
                 default:
                         DRM_ERROR("Unsupported DCE IP versions: 0x%X\n",
-                                       adev->ip_versions[DCE_HWIP][0]);
+                                       amdgpu_ip_version(adev, DCE_HWIP, 0=
));
                         goto fail;
                 }
                 break;
@@ -4698,14 +4698,14 @@ static int dm_init_microcode(struct amdgpu_device *=
adev)
         char *fw_name_dmub;
         int r;

-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(2, 1, 0):
                 fw_name_dmub =3D FIRMWARE_RENOIR_DMUB;
                 if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
                         fw_name_dmub =3D FIRMWARE_GREEN_SARDINE_DMUB;
                 break;
         case IP_VERSION(3, 0, 0):
-               if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, =
0))
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
0, 3, 0))
                         fw_name_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;
                 else
                         fw_name_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;
@@ -4835,7 +4835,7 @@ static int dm_early_init(void *handle)
                 break;
         default:

-               switch (adev->ip_versions[DCE_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
                 case IP_VERSION(2, 0, 2):
                 case IP_VERSION(3, 0, 0):
                         adev->mode_info.num_crtc =3D 6;
@@ -4872,7 +4872,7 @@ static int dm_early_init(void *handle)
                         break;
                 default:
                         DRM_ERROR("Unsupported DCE IP versions: 0x%x\n",
-                                       adev->ip_versions[DCE_HWIP][0]);
+                                       amdgpu_ip_version(adev, DCE_HWIP, 0=
));
                         return -EINVAL;
                 }
                 break;
@@ -11006,7 +11006,7 @@ int amdgpu_dm_process_dmub_set_config_sync(
  */
 bool check_seamless_boot_capability(struct amdgpu_device *adev)
 {
-       switch (adev->ip_versions[DCE_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
         case IP_VERSION(3, 0, 1):
                 if (!adev->mman.keep_stolen_vga_memory)
                         return true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b97cbc4e5477..8038fe3d193e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -226,7 +226,7 @@ static void fill_gfx9_tiling_info_from_device(const str=
uct amdgpu_device *adev,
         tiling_info->gfx9.num_rb_per_se =3D
                 adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
         tiling_info->gfx9.shaderEnable =3D 1;
-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0))
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10, 3, 0))
                 tiling_info->gfx9.num_pkrs =3D adev->gfx.config.gb_addr_co=
nfig_fields.num_pkrs;
 }

@@ -669,7 +669,7 @@ static int get_plane_modifiers(struct amdgpu_device *ad=
ev, unsigned int plane_ty
         case AMDGPU_FAMILY_YC:
         case AMDGPU_FAMILY_GC_10_3_6:
         case AMDGPU_FAMILY_GC_10_3_7:
-               if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0)=
)
+               if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(10,=
 3, 0))
                         add_gfx10_3_modifiers(adev, mods, &size, &capacity=
);
                 else
                         add_gfx10_1_modifiers(adev, mods, &size, &capacity=
);
@@ -1069,8 +1069,8 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgp=
u_device *adev,
          * is to gesture the YouTube Android app into full screen
          * on ChromeOS.
          */
-       if (((adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 0)) ||
-           (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1))) &&
+       if (((amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, =
0)) ||
+           (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1=
))) &&
             (state->fb && state->fb->format->format =3D=3D DRM_FORMAT_NV12=
 &&
             (scaling_info->src_rect.x !=3D 0 || scaling_info->src_rect.y !=
=3D 0)))
                 return -EINVAL;
@@ -1509,7 +1509,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manage=
r *dm,
                 drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_=
0,
                                                    supported_rotations);

-       if (dm->adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 1) &&
+       if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) > IP_VERSION(3, 0, 1) =
&&
             plane->type !=3D DRM_PLANE_TYPE_CURSOR)
                 drm_plane_enable_fb_damage_clips(plane);

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 84e1af6a6ce7..e789a48089ad 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2024,8 +2024,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                                uint32_t mask, enum amdgpu_device_attr_stat=
es *states)
 {
         struct device_attribute *dev_attr =3D &attr->dev_attr;
-       uint32_t mp1_ver =3D adev->ip_versions[MP1_HWIP][0];
-       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
+       uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
         const char *attr_name =3D dev_attr->attr.name;

         if (!(attr->flags & mask)) {
@@ -2917,7 +2917,7 @@ static ssize_t amdgpu_hwmon_show_power_label(struct d=
evice *dev,
                                          char *buf)
 {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
-       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);

         if (gc_ver =3D=3D IP_VERSION(10, 3, 1))
                 return sysfs_emit(buf, "%s\n",
@@ -3205,7 +3205,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
         struct device *dev =3D kobj_to_dev(kobj);
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         umode_t effective_mode =3D attr->mode;
-       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
         uint32_t tmp;

         /* under multi-vf mode, the hwmon attributes are all not supported=
 */
@@ -4158,8 +4158,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq=
_file *m,

 static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_dev=
ice *adev)
 {
-       uint32_t mp1_ver =3D adev->ip_versions[MP1_HWIP][0];
-       uint32_t gc_ver =3D adev->ip_versions[GC_HWIP][0];
+       uint32_t mp1_ver =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
+       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
         uint32_t value;
         uint64_t value64 =3D 0;
         uint32_t query =3D 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ed23d7de3f28..e6f1620acdd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -485,7 +485,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
         if (adev->asic_type =3D=3D CHIP_VEGA20)
                 return false;

-       if (adev->ip_versions[MP1_HWIP][0] >=3D IP_VERSION(11, 0, 0))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0, 0))
                 return true;

         return false;
@@ -603,7 +603,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
         if (adev->pm.pp_feature & PP_OVERDRIVE_MASK)
                 smu->od_enabled =3D true;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 5):
         case IP_VERSION(11, 0, 9):
@@ -775,8 +775,8 @@ static int smu_late_init(void *handle)
                 }
         }

-       if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 1)) ||
-           (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 3)))
+       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
1)) ||
+           (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
3)))
                 return 0;

         if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
@@ -1259,7 +1259,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
         uint64_t features_supported;
         int ret =3D 0;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 7):
         case IP_VERSION(11, 0, 11):
         case IP_VERSION(11, 5, 0):
@@ -1449,7 +1449,7 @@ static int smu_start_smc_engine(struct smu_context *s=
mu)
         int ret =3D 0;

         if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
-               if (adev->ip_versions[MP1_HWIP][0] < IP_VERSION(11, 0, 0)) =
{
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) < IP_VERSION(11, 0=
, 0)) {
                         if (smu->ppt_funcs->load_microcode) {
                                 ret =3D smu->ppt_funcs->load_microcode(smu=
);
                                 if (ret)
@@ -1549,7 +1549,7 @@ static int smu_disable_dpms(struct smu_context *smu)
          * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(di=
sablement or others)
          * properly on suspend/reset/unload. Driver involvement may cause =
some unexpected issues.
          */
-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 0):
         case IP_VERSION(13, 0, 7):
         case IP_VERSION(13, 0, 10):
@@ -1570,7 +1570,7 @@ static int smu_disable_dpms(struct smu_context *smu)
          *     properly.
          */
         if (smu->uploading_custom_pp_table) {
-               switch (adev->ip_versions[MP1_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                 case IP_VERSION(11, 0, 0):
                 case IP_VERSION(11, 0, 5):
                 case IP_VERSION(11, 0, 9):
@@ -1590,7 +1590,7 @@ static int smu_disable_dpms(struct smu_context *smu)
          * on BACO in. Driver involvement is unnecessary.
          */
         if (use_baco) {
-               switch (adev->ip_versions[MP1_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                 case IP_VERSION(11, 0, 7):
                 case IP_VERSION(11, 0, 0):
                 case IP_VERSION(11, 0, 5):
@@ -1607,7 +1607,7 @@ static int smu_disable_dpms(struct smu_context *smu)
          * for gpu reset and S0i3 cases. Driver involvement is unnecessary=
.
          */
         if (amdgpu_in_reset(adev) || adev->in_s0ix) {
-               switch (adev->ip_versions[MP1_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                 case IP_VERSION(13, 0, 4):
                 case IP_VERSION(13, 0, 11):
                         return 0;
@@ -1634,7 +1634,7 @@ static int smu_disable_dpms(struct smu_context *smu)
                 }
         }

-       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(9, 4, 2) &&
+       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2) &&
             !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
                 adev->gfx.rlc.funcs->stop(adev);

@@ -2391,7 +2391,7 @@ int smu_get_power_limit(void *handle,
         } else {
                 switch (limit_level) {
                 case SMU_PPT_LIMIT_CURRENT:
-                       switch (adev->ip_versions[MP1_HWIP][0]) {
+                       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                         case IP_VERSION(13, 0, 2):
                         case IP_VERSION(11, 0, 7):
                         case IP_VERSION(11, 0, 11):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 18487ae10bcf..650482cedd1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -345,8 +345,8 @@ navi10_get_allowed_feature_mask(struct smu_context *smu=
,

         /* DPM UCLK enablement should be skipped for navi10 A0 secure boar=
d */
         if (!(is_asic_secure(smu) &&
-            (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0)) &=
&
-            (adev->rev_id =3D=3D 0)) &&
+             (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 0)) &&
+             (adev->rev_id =3D=3D 0)) &&
             (adev->pm.pp_feature & PP_MCLK_DPM_MASK))
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_DPM_UC=
LK_BIT)
                                 | FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_B=
IT)
@@ -354,7 +354,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu=
,

         /* DS SOCCLK enablement should be skipped for navi10 A0 secure boa=
rd */
         if (is_asic_secure(smu) &&
-           (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0)) &&
+           (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, =
0)) &&
             (adev->rev_id =3D=3D 0))
                 *(uint64_t *)feature_mask &=3D
                                 ~FEATURE_MASK(FEATURE_DS_SOCCLK_BIT);
@@ -916,7 +916,7 @@ static int navi1x_get_smu_metrics_data(struct smu_conte=
xt *smu,
                 return ret;
         }

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 9):
                 if (smu_version > 0x00341C00)
                         ret =3D navi12_get_smu_metrics_data(smu, member, v=
alue);
@@ -926,8 +926,12 @@ static int navi1x_get_smu_metrics_data(struct smu_cont=
ext *smu,
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 5):
         default:
-               if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, =
0, 5)) && smu_version > 0x00351F00) ||
-                     ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11=
, 0, 0)) && smu_version > 0x002A3B00))
+               if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(11, 0, 5)) &&
+                    smu_version > 0x00351F00) ||
+                   ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(11, 0, 0)) &&
+                    smu_version > 0x002A3B00))
                         ret =3D navi10_get_smu_metrics_data(smu, member, v=
alue);
                 else
                         ret =3D navi10_get_legacy_smu_metrics_data(smu, me=
mber, value);
@@ -1712,7 +1716,7 @@ static int navi10_populate_umd_state_clk(struct smu_c=
ontext *smu)
         uint32_t sclk_freq;

         pstate_table->gfxclk_pstate.min =3D gfx_table->min;
-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
                 switch (adev->pdev->revision) {
                 case 0xf0: /* XTX */
@@ -2754,8 +2758,8 @@ static bool navi10_need_umc_cdr_workaround(struct smu=
_context *smu)
         if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT))
                 return false;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 5))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 0=
) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 5=
))
                 return true;

         return false;
@@ -2863,8 +2867,10 @@ static int navi10_run_umc_cdr_workaround(struct smu_=
context *smu)
          * - PPSMC_MSG_SetDriverDummyTableDramAddrLow
          * - PPSMC_MSG_GetUMCFWWA
          */
-       if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0)) &=
& (pmfw_version >=3D 0x2a3500)) ||
-           ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 5)) &=
& (pmfw_version >=3D 0x351D00))) {
+       if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 0)) &&
+            (pmfw_version >=3D 0x2a3500)) ||
+           ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 5)) &&
+            (pmfw_version >=3D 0x351D00))) {
                 ret =3D smu_cmn_send_smc_msg_with_param(smu,
                                                       SMU_MSG_GET_UMC_FW_W=
A,
                                                       0,
@@ -2883,13 +2889,15 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)
                         return 0;

                 if (umc_fw_disable_cdr) {
-                       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSIO=
N(11, 0, 0))
+                       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                           IP_VERSION(11, 0, 0))
                                 return navi10_umc_hybrid_cdr_workaround(sm=
u);
                 } else {
                         return navi10_set_dummy_pstates_table_location(smu=
);
                 }
         } else {
-               if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,=
 0))
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                   IP_VERSION(11, 0, 0))
                         return navi10_umc_hybrid_cdr_workaround(smu);
         }

@@ -3356,7 +3364,7 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_cont=
ext *smu,
                 return ret;
         }

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 9):
                 if (smu_version > 0x00341C00)
                         ret =3D navi12_get_gpu_metrics(smu, table);
@@ -3366,8 +3374,12 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_con=
text *smu,
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 5):
         default:
-               if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, =
0, 5)) && smu_version > 0x00351F00) ||
-                     ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11=
, 0, 0)) && smu_version > 0x002A3B00))
+               if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(11, 0, 5)) &&
+                    smu_version > 0x00351F00) ||
+                   ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(11, 0, 0)) &&
+                    smu_version > 0x002A3B00))
                         ret =3D navi10_get_gpu_metrics(smu, table);
                 else
                         ret =3D navi10_get_legacy_gpu_metrics(smu, table);
@@ -3385,7 +3397,7 @@ static int navi10_enable_mgpu_fan_boost(struct smu_co=
ntext *smu)
         uint32_t param =3D 0;

         /* Navi12 does not support this */
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 9))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 9=
))
                 return 0;

         /*
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 4bb289f9b4b8..164c2264027d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -73,12 +73,16 @@

 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15

-#define GET_PPTABLE_MEMBER(field, member) do {\
-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))\
-               (*member) =3D (smu->smu_table.driver_pptable + offsetof(PPT=
able_beige_goby_t, field));\
-       else\
-               (*member) =3D (smu->smu_table.driver_pptable + offsetof(PPT=
able_t, field));\
-} while(0)
+#define GET_PPTABLE_MEMBER(field, member)                                 =
   \
+       do {                                                               =
  \
+               if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D       =
      \
+                   IP_VERSION(11, 0, 13))                                 =
  \
+                       (*member) =3D (smu->smu_table.driver_pptable +     =
    \
+                                    offsetof(PPTable_beige_goby_t, field))=
; \
+               else                                                       =
  \
+                       (*member) =3D (smu->smu_table.driver_pptable +     =
    \
+                                    offsetof(PPTable_t, field));          =
  \
+       } while (0)

 /* STB FIFO depth is in 64bit units */
 #define SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES 8
@@ -91,7 +95,7 @@

 static int get_table_size(struct smu_context *smu)
 {
-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11,=
 0, 13))
                 return sizeof(PPTable_beige_goby_t);
         else
                 return sizeof(PPTable_t);
@@ -309,7 +313,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_cont=
ext *smu,
         }

         if ((adev->pm.pp_feature & PP_GFX_DCS_MASK) &&
-           (adev->ip_versions[MP1_HWIP][0] > IP_VERSION(11, 0, 7)) &&
+           (amdgpu_ip_version(adev, MP1_HWIP, 0) > IP_VERSION(11, 0, 7)) &=
&
             !(adev->flags & AMD_IS_APU))
                 *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_GFX_DC=
S_BIT);

@@ -434,7 +438,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)
         PPTable_beige_goby_t *ppt_beige_goby;
         PPTable_t *ppt;

-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11,=
 0, 13))
                 ppt_beige_goby =3D smu->smu_table.driver_pptable;
         else
                 ppt =3D smu->smu_table.driver_pptable;
@@ -447,7 +451,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)
         if (ret)
                 return ret;

-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11,=
 0, 13))
                 smu_memcpy_trailing(ppt_beige_goby, I2cControllers, BoardR=
eserved,
                                     smc_dpm_table, I2cControllers);
         else
@@ -725,7 +729,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,
         uint32_t apu_percent =3D 0;
         uint32_t dgpu_percent =3D 0;

-       switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 7):
                 if (smu->smc_fw_version >=3D 0x3A4900)
                         use_metrics_v3 =3D true;
@@ -1385,8 +1389,9 @@ static int sienna_cichlid_print_clk_levels(struct smu=
_context *smu,
                  * and onwards SMU firmwares.
                  */
                 smu_cmn_get_smc_version(smu, NULL, &smu_version);
-               if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 7)) &&
-                    (smu_version < 0x003a2900))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                    IP_VERSION(11, 0, 7)) &&
+                   (smu_version < 0x003a2900))
                         break;

                 size +=3D sysfs_emit_at(buf, size, "OD_VDDGFX_OFFSET:\n");
@@ -1494,7 +1499,7 @@ static int sienna_cichlid_populate_umd_state_clk(stru=
ct smu_context *smu)
         pstate_table->socclk_pstate.min =3D soc_table->min;
         pstate_table->socclk_pstate.peak =3D soc_table->max;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 7):
         case IP_VERSION(11, 0, 11):
                 pstate_table->gfxclk_pstate.standard =3D SIENNA_CICHLID_UM=
D_PSTATE_PROFILING_GFXCLK;
@@ -1945,7 +1950,8 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,
                 *size =3D 4;
                 break;
         case AMDGPU_PP_SENSOR_SS_APU_SHARE:
-               if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7=
)) {
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D
+                   IP_VERSION(11, 0, 7)) {
                         ret =3D sienna_cichlid_get_smu_metrics_data(smu,
                                                 METRICS_SS_APU_SHARE, (uin=
t32_t *)data);
                         *size =3D 4;
@@ -1954,7 +1960,8 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,
                 }
                 break;
         case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
-               if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7=
)) {
+               if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D
+                   IP_VERSION(11, 0, 7)) {
                         ret =3D sienna_cichlid_get_smu_metrics_data(smu,
                                                 METRICS_SS_DGPU_SHARE, (ui=
nt32_t *)data);
                         *size =3D 4;
@@ -1978,7 +1985,7 @@ static void sienna_cichlid_get_unique_id(struct smu_c=
ontext *smu)

         /* Only supported as of version 0.58.83.0 and only on Sienna Cichl=
id */
         if (smu->smc_fw_version < 0x3A5300 ||
-           smu->adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))
+           amdgpu_ip_version(smu->adev, MP1_HWIP, 0) !=3D IP_VERSION(11, 0=
, 7))
                 return;

         if (sienna_cichlid_get_smu_metrics_data(smu, METRICS_UNIQUE_ID_UPP=
ER32, &upper32))
@@ -2148,8 +2155,8 @@ static void sienna_cichlid_dump_od_table(struct smu_c=
ontext *smu,
                                                         od_table->UclkFmax=
);

         smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (!((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) =
&&
-              (smu_version < 0x003a2900)))
+       if (!((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0=
, 7)) &&
+             (smu_version < 0x003a2900)))
                 dev_dbg(smu->adev->dev, "OD: VddGfxOffset: %d\n", od_table=
->VddGfxOffset);
 }

@@ -2381,8 +2388,9 @@ static int sienna_cichlid_od_edit_dpm_table(struct sm=
u_context *smu,
                  * and onwards SMU firmwares.
                  */
                 smu_cmn_get_smc_version(smu, NULL, &smu_version);
-               if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0=
, 7)) &&
-                    (smu_version < 0x003a2900)) {
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                    IP_VERSION(11, 0, 7)) &&
+                   (smu_version < 0x003a2900)) {
                         dev_err(smu->adev->dev, "OD GFX Voltage offset fun=
ctionality is supported "
                                                 "only by 58.41.0 and onwar=
ds SMU firmwares!\n");
                         return -EOPNOTSUPP;
@@ -3105,7 +3113,8 @@ static void sienna_cichlid_dump_pptable(struct smu_co=
ntext *smu)
         PPTable_t *pptable =3D table_context->driver_pptable;
         int i;

-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13=
)) {
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D
+           IP_VERSION(11, 0, 13)) {
                 beige_goby_dump_pptable(smu);
                 return;
         }
@@ -3910,7 +3919,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,
         uint16_t average_gfx_activity;
         int ret =3D 0;

-       switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 7):
                 if (smu->smc_fw_version >=3D 0x3A4900)
                         use_metrics_v3 =3D true;
@@ -4026,8 +4035,10 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct=
 smu_context *smu,
         gpu_metrics->current_fan_speed =3D use_metrics_v3 ? metrics_v3->Cu=
rrFanSpeed :
                 use_metrics_v2 ? metrics_v2->CurrFanSpeed : metrics->CurrF=
anSpeed;

-       if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) &=
& smu->smc_fw_version > 0x003A1E00) ||
-             ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 11)=
) && smu->smc_fw_version > 0x00410400)) {
+       if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 7)) &&
+            smu->smc_fw_version > 0x003A1E00) ||
+           ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 11)) &&
+            smu->smc_fw_version > 0x00410400)) {
                 gpu_metrics->pcie_link_width =3D use_metrics_v3 ? metrics_=
v3->PcieWidth :
                         use_metrics_v2 ? metrics_v2->PcieWidth : metrics->=
PcieWidth;
                 gpu_metrics->pcie_link_speed =3D link_speed[use_metrics_v3=
 ? metrics_v3->PcieRate :
@@ -4253,7 +4264,7 @@ static int sienna_cichlid_get_default_config_table_se=
ttings(struct smu_context *
         table->gfx_activity_average_tau =3D 10;
         table->mem_activity_average_tau =3D 10;
         table->socket_power_average_tau =3D 100;
-       if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(11, 0, 7))
                 table->apu_socket_power_average_tau =3D 100;

         return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index aa4a5498a12f..ece43b41141c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -101,8 +101,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
         struct amdgpu_firmware_info *ucode =3D NULL;

         if (amdgpu_sriov_vf(adev) &&
-           ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 9)) |=
|
-            (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))))
+           ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 9)) ||
+            (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0,=
 7))))
                 return 0;

         amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
@@ -213,7 +213,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
         if (smu->is_apu)
                 adev->pm.fw_version =3D smu_version;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
                 smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV1=
0;
                 break;
@@ -246,7 +246,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
                 break;
         default:
                 dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.=
\n",
-                       adev->ip_versions[MP1_HWIP][0]);
+                       amdgpu_ip_version(adev, MP1_HWIP, 0));
                 smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_INV=
;
                 break;
         }
@@ -474,9 +474,10 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
         struct smu_power_context *smu_power =3D &smu->smu_power;
-       size_t size =3D adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11=
, 5, 0) ?
-                       sizeof(struct smu_11_5_power_context) :
-                       sizeof(struct smu_11_0_power_context);
+       size_t size =3D amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                                     IP_VERSION(11, 5, 0) ?
+                             sizeof(struct smu_11_5_power_context) :
+                             sizeof(struct smu_11_0_power_context);

         smu_power->power_context =3D kzalloc(size, GFP_KERNEL);
         if (!smu_power->power_context)
@@ -731,10 +732,10 @@ int smu_v11_0_init_display_count(struct smu_context *=
smu, uint32_t count)
         /* Navy_Flounder/Dimgrey_Cavefish do not support to change
          * display num currently
          */
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 11) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 5, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 12) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 1=
1) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 5, 0=
) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 1=
2) ||
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 1=
3))
                 return 0;

         return smu_cmn_send_smc_msg_with_param(smu,
@@ -1103,7 +1104,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu=
, bool enable)
         int ret =3D 0;
         struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(11, 0, 0):
         case IP_VERSION(11, 0, 5):
         case IP_VERSION(11, 0, 9):
@@ -1591,7 +1592,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu,=
 enum smu_baco_state state)
                 return 0;

         if (state =3D=3D SMU_BACO_STATE_ENTER) {
-               switch (adev->ip_versions[MP1_HWIP][0]) {
+               switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
                 case IP_VERSION(11, 0, 7):
                 case IP_VERSION(11, 0, 11):
                 case IP_VERSION(11, 0, 12):
@@ -1610,7 +1611,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu,=
 enum smu_baco_state state)
                 default:
                         if (!ras || !adev->ras_enabled ||
                             adev->gmc.xgmi.pending_reset) {
-                               if (adev->ip_versions[MP1_HWIP][0] =3D=3D I=
P_VERSION(11, 0, 2)) {
+                               if (amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D
+                                   IP_VERSION(11, 0, 2)) {
                                         data =3D RREG32_SOC15(THM, 0, mmTH=
M_BACO_CNTL_ARCT);
                                         data |=3D 0x80000000;
                                         WREG32_SOC15(THM, 0, mmTHM_BACO_CN=
TL_ARCT, data);
@@ -1894,7 +1896,7 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,
          * Separate MCLK and SOCCLK soft min/max settings are not allowed
          * on Arcturus.
          */
-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 2)) {
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 2=
)) {
                 mclk_min =3D mclk_max =3D 0;
                 socclk_min =3D socclk_max =3D 0;
         }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c8119491c516..8908bbb3ff1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1198,8 +1198,12 @@ static int renoir_get_smu_metrics_data(struct smu_co=
ntext *smu,
                 *value =3D metrics->AverageUvdActivity / 100;
                 break;
         case METRICS_CURR_SOCKETPOWER:
-               if (((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, =
0, 1)) && (adev->pm.fw_version >=3D 0x40000f)) ||
-               ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0=
)) && (adev->pm.fw_version >=3D 0x373200)))
+               if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(12, 0, 1)) &&
+                    (adev->pm.fw_version >=3D 0x40000f)) ||
+                   ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D
+                     IP_VERSION(12, 0, 0)) &&
+                    (adev->pm.fw_version >=3D 0x373200)))
                         *value =3D metrics->CurrentSocketPower << 8;
                 else
                         *value =3D (metrics->CurrentSocketPower << 8) / 10=
00;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index fd1798fd716e..d86499ac8931 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -196,9 +196,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)
         if (!adev->scpm_enabled)
                 return 0;

-       if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 7)) ||
-           (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 0)) ||
-           (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)))
+       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
7)) ||
+           (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
0)) ||
+           (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
10)))
                 return 0;

         /* override pptable_id from driver parameter */
@@ -234,7 +234,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
         struct amdgpu_device *adev =3D smu->adev;
         uint32_t mp1_fw_flags;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 4):
         case IP_VERSION(13, 0, 11):
                 mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
@@ -269,7 +269,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         smu_minor =3D (smu_version >> 8) & 0xff;
         smu_debug =3D (smu_version >> 0) & 0xff;
         if (smu->is_apu ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
+           amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
))
                 adev->pm.fw_version =3D smu_version;

         /* only for dGPU w/ SMU13*/
@@ -802,7 +802,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)
         int ret =3D 0;
         struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 0):
         case IP_VERSION(13, 0, 1):
         case IP_VERSION(13, 0, 3):
@@ -1779,7 +1779,7 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
          * Unset those settings for SMU 13.0.2. As soft limits settings
          * for those clock domains are not supported.
          */
-       if (smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)=
) {
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 2)) {
                 mclk_min =3D mclk_max =3D 0;
                 socclk_min =3D socclk_max =3D 0;
                 vclk_min =3D vclk_max =3D 0;
@@ -1926,7 +1926,7 @@ static int smu_v13_0_get_dpm_level_count(struct smu_c=
ontext *smu,

         ret =3D smu_v13_0_get_dpm_freq_by_index(smu, clk_type, 0xff, value=
);
         /* SMU v13.0.2 FW returns 0 based max level, increment by one for =
it */
-       if ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2=
)) && (!ret && value))
+       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 2)) && (!ret && value))
                 ++(*value);

         return ret;
@@ -1986,7 +1986,7 @@ int smu_v13_0_set_single_dpm_table(struct smu_context=
 *smu,
                 return ret;
         }

-       if (smu->adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, 2)) =
{
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0=
, 2)) {
                 ret =3D smu_v13_0_get_fine_grained_status(smu,
                                                         clk_type,
                                                         &single_dpm_table-=
>is_fine_grained);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 093962a37688..a3cbe15c3123 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2754,7 +2754,7 @@ static int smu_v13_0_0_mode1_reset(struct smu_context=
 *smu)
         uint32_t param;
         struct amdgpu_device *adev =3D smu->adev;

-       switch (adev->ip_versions[MP1_HWIP][0]) {
+       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
         case IP_VERSION(13, 0, 0):
                 /* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.=
77 */
                 smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param)=
;
@@ -2787,7 +2787,7 @@ static int smu_v13_0_0_mode2_reset(struct smu_context=
 *smu)
         int ret;
         struct amdgpu_device *adev =3D smu->adev;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
0))
                 ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode2Reset, NULL=
);
         else
                 return -EOPNOTSUPP;
@@ -2799,7 +2799,7 @@ static int smu_v13_0_0_enable_gfx_features(struct smu=
_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
0))
                 return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_Enable=
AllSmuFeatures,
                                                                           =
         FEATURE_PWR_GFX, NULL);
         else
@@ -2863,7 +2863,7 @@ static int smu_v13_0_0_check_ecc_table_support(struct=
 smu_context *smu)
         if (ret)
                 return -EOPNOTSUPP;

-       if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)) &=
&
+       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
10)) &&
                 (smu_version >=3D SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
                 return ret;
         else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 626591f54bc4..bb98156b2fa1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1144,7 +1144,7 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *sm=
u)
         smu->smc_driver_if_version =3D SMU13_0_4_DRIVER_IF_VERSION;
         smu->is_apu =3D true;

-       if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 4))
+       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 4=
))
                 smu_v13_0_4_set_smu_mailbox_registers(smu);
         else
                 smu_v13_0_set_smu_mailbox_registers(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 2e74d749efdd..2d1736234b4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1024,24 +1024,24 @@ static uint32_t yellow_carp_get_umd_pstate_clk_defa=
ult(struct smu_context *smu,
         switch (clk_type) {
         case SMU_GFXCLK:
         case SMU_SCLK:
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 8))
                         clk_limit =3D SMU_13_0_8_UMD_PSTATE_GFXCLK;
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
-                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 1) ||
+                       (amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VE=
RSION(13, 0, 3))
                         clk_limit =3D SMU_13_0_1_UMD_PSTATE_GFXCLK;
                 break;
         case SMU_SOCCLK:
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 8))
                         clk_limit =3D SMU_13_0_8_UMD_PSTATE_SOCCLK;
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
-                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 1) ||
+                       (amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VE=
RSION(13, 0, 3))
                         clk_limit =3D SMU_13_0_1_UMD_PSTATE_SOCCLK;
                 break;
         case SMU_FCLK:
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 8))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 8))
                         clk_limit =3D SMU_13_0_8_UMD_PSTATE_FCLK;
-               if ((adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, =
0, 1) ||
-                       (adev->ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(=
13, 0, 3))
+               if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSIO=
N(13, 0, 1) ||
+                       (amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VE=
RSION(13, 0, 3))
                         clk_limit =3D SMU_13_0_1_UMD_PSTATE_FCLK;
                 break;
         default:
--
2.25.1


--_000_BL1PR12MB5144F20A5BD6A69093463C63F7F1ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, September 11, 2023 7:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Use function for IP version check</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use an inline function for version check. Gives mo=
re flexibility to<br>
handle any format changes.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp; |&nbsp; =
2 +-<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c&nbsp;&nbsp;&nbsp; |&nbsp; =
2 +-<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 29 +++=
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 92 +++++++++--------<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c&nbsp;&nbsp; | 28 ++++--<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 12 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 11 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 48 +++++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 38 ++++---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 7 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c&nbsp;&nbsp;&nbsp;&nbsp; | 1=
5 +--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 11 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/athub_v1_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/athub_v2_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/athub_v2_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/athub_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 98 ++++++++++---------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 27 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 83 ++++++++--------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 8 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 13 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 28 +++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 8 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 96 +++++++++---------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 18 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/imu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v10_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 10 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 12 +--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/navi10_ih.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 10 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 7 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 48 +++++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 7 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 9 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c&nbsp;&nbsp; |&nbsp; 2 +-<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 27 +++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 +--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
9 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 9 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 14 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 7 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega20_ih.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 14 +--<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 12 ++-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_migrate.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 +-<br>
&nbsp;.../drm/amd/amdkfd/kfd_packet_manager_v9.c&nbsp;&nbsp;&nbsp; |&nbsp; =
3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 34 +++----<br>
&nbsp;.../amd/display/amdgpu_dm/amdgpu_dm_plane.c&nbsp;&nbsp; | 10 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 +--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 2=
4 ++---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp; | 46 +++++---=
-<br>
&nbsp;.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp; | 63 +++++++-=
----<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp; | 32 +++=
---<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c&nbsp;&nbsp; |&nbsp; 8 +-<=
br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; | 18 ++-=
-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c&nbsp; |&nbsp; 8 +-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c&nbsp; |&nbsp; 2 +-<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; | 18 ++--<br>
&nbsp;94 files changed, 714 insertions(+), 593 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c<br>
index 5d2516210a3a..02f4c6f9d4f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<br>
@@ -35,7 +35,7 @@ static bool aldebaran_is_mode2_default(struct amdgpu_rese=
t_control *reset_ctl)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)reset_ctl-&gt;handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0=
] =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP=
, 0) =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.xgmi.connected_to_cpu))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
@@ -154,7 +154,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_device_list =3D=
=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
set_context-&gt;hive =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Wrong context, return error */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -335,7 +335,7 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_c=
ontrol *reset_ctl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_device_list =3D=
=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;reset_req_dev-&=
gt;ip_versions[MP1_HWIP][0] =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(reset_context-&=
gt;reset_req_dev, MP1_HWIP, 0) =3D=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0, 2) &amp;&am=
p;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
set_context-&gt;hive =3D=3D NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Wrong context, return error */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3a86d11d1605..927c049e6132 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1101,6 +1101,12 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid_mask;<br>
&nbsp;};<br>
&nbsp;<br>
+static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t ip, uint8_t inst)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;ip_versions[ip][inst]=
;<br>
+}<br>
+<br>
&nbsp;static inline struct amdgpu_device *drm_to_adev(struct drm_device *dd=
ev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return container_of(ddev, =
struct amdgpu_device, ddev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c<br>
index 26ff5f8d9795..38b5457baded 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
@@ -707,7 +707,7 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_devic=
e *adev, bool idle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Temporary workaround to=
 fix issues observed in some<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * compute applicatio=
ns when GFXOFF is enabled on GFX11.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IP_VERSION_MAJ(adev-&gt;ip_versio=
ns[GC_HWIP][0]) =3D=3D 11) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IP_VERSION_MAJ(amdgpu_ip_version(=
adev, GC_HWIP, 0)) =3D=3D 11) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;GFXOFF is %s\n&quot;, idle ? &quot;ena=
bled&quot; : &quot;disabled&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, idle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
index d67d003bada2..b61a32d6af4b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c<br>
@@ -658,7 +658,7 @@ static int kgd_gfx_v11_validate_trap_override_request(s=
truct amdgpu_device *adev<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_ADDRESS_WA=
TCH |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_DBG_MEMORY_VIO=
LATION;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(11, 0, 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(11, 0, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *trap_mask_supported |=3D KFD_DBG_TRAP_MASK_TRAP_ON_W=
AVE_START |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 04b8c7dacd30..51011e8ee90d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -677,7 +677,7 @@ void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D RREG32(S=
OC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, SPI_GDBG_WAVE_CNTL, STAL=
L_VMID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stall ? 1 &lt;&lt; vmid : 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 3d540b0cf0e1..ca56b5a543b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1003,8 +1003,8 @@ static int amdgpu_device_asic_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_pre_asic_init(=
adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] &gt;=3D IP_VERSION(11, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) &gt;=3D IP_VERSION(11, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_psp_wait_for_bootloader(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_atomfirmware_asic_init(adev, true);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -2845,7 +2845,7 @@ static void amdgpu_device_smu_fini_early(struct amdgp=
u_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt; IP_VERSION(9, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt; IP_VERSION(9, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i++) {<br>
@@ -3098,8 +3098,10 @@ static int amdgpu_device_ip_suspend_phase2(struct am=
dgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* SDMA 5.x+ is part of GFX power domain so it's cove=
red by GFXOFF */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[SDMA0_HWIP][0] &gt=
;=3D IP_VERSION(5, 0, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-&gt;type =
=3D=3D AMD_IP_BLOCK_TYPE_SDMA))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =
&gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(5, 0, 0)) &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_blocks[i].version-&gt;type =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Once swPSP provides the IMU, RLC FW binaries to TO=
S during cold-boot.<br>
@@ -3590,8 +3592,8 @@ static void amdgpu_device_set_mcbp(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_mcbp =3D=
=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if ((adev-&gt;ip_versions[GC_HWI=
P][0] &gt;=3D IP_VERSION(9, 0, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &lt; IP_VERSION(10, 0, 0=
)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if ((amdgpu_ip_version(adev, GC_=
HWIP, 0) &gt;=3D IP_VERSION(9, 0, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) &lt; IP_VERSION(10, 0=
, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mcbp =3D true;<br>
&nbsp;<br>
@@ -3811,7 +3813,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * internal path nati=
vely support atomics, set have_atomics_support to true.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if ((adev-&gt;flags=
 &amp; AMD_IS_APU) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &gt; IP_VERS=
ION(9, 0, 0))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 0, 0))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;have_atomics_support =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;have_atomics_support =3D<br>
@@ -5444,8 +5447,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;asic_reset_res =3D r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so =
need resume ras during reset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2) =
||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(11, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(11, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_ras_resume(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_do_asic_reset(device_list_handle, reset_=
context);<br>
@@ -5470,7 +5474,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_s=
ched_start(&amp;ring-&gt;sched, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;enable_mes &amp;&amp; adev-&gt;ip_versions[GC_HWIP]=
[0] !=3D IP_VERSION(11, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;enable_mes &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) !=3D=
 IP_VERSION(11, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_mes_self_test(tmp_adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev=
)) &amp;&amp; !job_signaled)<br>
@@ -6147,7 +6152,7 @@ bool amdgpu_device_has_display_hardware(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* IP discovery */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;ip_versions[DCE_HWIP][0] ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_ip_version(adev, DCE_HWIP, 0) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;harvest_ip_mask &am=
p; AMD_HARVEST_IP_DMU_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 9ab33b0bbbad..430ee7f64a97 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -311,8 +311,8 @@ static void amdgpu_discovery_harvest_config_quirk(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * So far, apply this=
 quirk only on those Navy Flounder boards which<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * have a bad harvest=
 table of VCN config.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[UVD_HWIP][1=
] =3D=3D IP_VERSION(3, 0, 1)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2))) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, UVD_HWIP=
, 1) =3D=3D IP_VERSION(3, 0, 1)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3, 2))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;pdev-&gt;revision) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0xC1:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0xC2:<br>
@@ -1363,8 +1363,8 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so read harvest bi=
t per IP data structure to set<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * harvest configurat=
ion.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&lt; IP_VERSION(10, 2, 0) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &lt; IP_VERSION(10, 2, 0) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pdev-&gt;device =3D=3D 0x731E &amp;&amp=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev=
-&gt;pdev-&gt;revision =3D=3D 0xC6 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;pdev-&gt;revision =3D=3D 0xC7)) ||<br>
@@ -1607,7 +1607,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgp=
u_device *adev)<br>
&nbsp;static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device=
 *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* what IP to use for this=
? */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
@@ -1645,7 +1645,7 @@ static int amdgpu_discovery_set_common_ip_blocks(stru=
ct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to add common ip block(GC_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[GC_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, GC_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1654,7 +1654,7 @@ static int amdgpu_discovery_set_common_ip_blocks(stru=
ct amdgpu_device *adev)<br>
&nbsp;static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use GC or MMHUB IP vers=
ion */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
@@ -1690,9 +1690,8 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gmc_v11_0_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
add gmc ip block(GC_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[GC_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to add gmc ip block(GC_HWIP:0=
x%x)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, GC_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1700,7 +1699,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[OSSSYS_H=
WIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, OSSSY=
S_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<=
br>
@@ -1733,7 +1732,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[OSSSYS_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, OSSSYS_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1741,7 +1740,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v3_1_ip_blo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1787,7 +1786,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to add psp ip block(MP0_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[MP0_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, MP0_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1795,7 +1794,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 1):=
<br>
@@ -1836,7 +1835,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to add smu ip block(MP1_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[MP1_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, MP1_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1861,8 +1860,8 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[DCE_HWIP][0]=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, DCE_HWIP,=
 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
@@ -1888,11 +1887,11 @@ static int amdgpu_discovery_set_display_ip_blocks(s=
truct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to add dm ip block(=
DCE_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[DCE_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, DCE_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;ip_versions[DCI_H=
WIP][0]) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCI_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (amdgpu_ip_version(adev, DC=
I_HWIP, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 1, 0):<br>
@@ -1904,7 +1903,7 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to add dm ip block(=
DCI_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[DCI_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, DCI_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1914,7 +1913,7 @@ static int amdgpu_discovery_set_display_ip_blocks(str=
uct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
@@ -1952,9 +1951,8 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gfx_v11_0_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to =
add gfx ip block(GC_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[GC_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to add gfx ip block(GC_HWIP:0=
x%x)\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, GC_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -1962,7 +1960,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *=
adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<=
br>
@@ -2002,7 +2000,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[SDMA0_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, SDMA0_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2010,8 +2008,8 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[VCE_HWIP][0]=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCE_HWIP,=
 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 2, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UV=
D is not supported on vega20 SR-IOV */<br>
@@ -2021,10 +2019,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to add uvd v7 ip bl=
ock(UVD_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[UVD_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, UVD_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[VCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, VCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VC=
E is not supported on vega20 SR-IOV */<br>
@@ -2034,11 +2032,11 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to add VCE v4 ip bl=
ock(VCE_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[VCE_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, VCE_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;vcn_v1_0_ip_block);<br>
@@ -2089,7 +2087,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to add vcn/jpeg ip =
block(UVD_HWIP:0x%x)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[UVD_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, UVD_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2098,7 +2096,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -2136,7 +2134,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static void amdgpu_discovery_init_soc_config(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; aqua_vanjaram_init_soc_config(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -2147,7 +2145,7 @@ static void amdgpu_discovery_init_soc_config(struct a=
mdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VPE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VPE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vpe_v6_1_ip_blo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -2160,7 +2158,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct =
amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VCN_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VCN_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_umsch_mm &amp; 0x1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;umsch_mm_v4_0_ip_block);<br>
@@ -2354,7 +2352,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_init_soc_=
config(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_sysfs_ini=
t(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -2408,7 +2406,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
@@ -2427,11 +2425,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[XGMI_HWIP][0=
] =3D=3D IP_VERSION(4, 8, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, XGMI_HWIP=
, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set NBIO version */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 2, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs =3D &amp;nbio_v6_1_funcs;<br>
@@ -2493,7 +2491,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[HDP_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, HDP_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<=
br>
@@ -2525,7 +2523,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DF_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DF_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 6, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 6, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 6, 2):<=
br>
@@ -2545,7 +2543,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SMUIO_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SMUIO=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 0):=
<br>
@@ -2588,7 +2586,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[LSDMA_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, LSDMA=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 363e6a2cad8c..0cacd0b9f8be 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -766,11 +766,13 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(11, 0, 0=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D IP_VERSION(11, 0=
, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versi=
on =3D AMD_FMT_MOD_TILE_VER_GFX11;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10,=
 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION=
(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versi=
on =3D AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10,=
 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION=
(10, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versi=
on =3D AMD_FMT_MOD_TILE_VER_GFX10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versi=
on =3D AMD_FMT_MOD_TILE_VER_GFX9;<br>
@@ -779,13 +781,15 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0: /* Z microtiling */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 1: /* S microtiling */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[GC_HWIP][0] &lt; IP_VERSION(11, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) &lt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_xor)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; version =3D AMD_FMT_MOD_TILE_VER_GFX9;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[GC_HWIP][0] &lt; IP_VERSION(11, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) &lt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_xor &amp;&amp; afb-&gt;=
base.format-&gt;cpp[0] !=3D 4)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; version =3D AMD_FMT_MOD_TILE_VER_GFX9;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -838,10 +842,12 @@ static int convert_tiling_flags_to_modifier(struct am=
dgpu_framebuffer *afb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 r=
ender_dcc_offset;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* En=
able constant encode on RAVEN2 and later. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dcc_constan=
t_encode =3D (adev-&gt;asic_type &gt; CHIP_RAVEN ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ade=
v-&gt;asic_type =3D=3D CHIP_RAVEN &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;external_rev_id &gt;=3D 0x81)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; adev-&gt;ip_versions[GC_HWIP][0] &lt; IP_VERSION(11, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dcc_constan=
t_encode =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type &gt; CHIP_RAVEN ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_RAVEN=
 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id &gt;=
=3D 0x81)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) &lt;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; IP_VERSION(11, 0, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int m=
ax_cblock_size =3D dcc_i64b ? AMD_FMT_MOD_DCC_BLOCK_64B :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcc_i128b ? AMD_FMT_MOD=
_DCC_BLOCK_128B :<br>
@@ -878,7 +884,9 @@ static int convert_tiling_flags_to_modifier(struct amdg=
pu_framebuffer *afb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;family &gt;=3D AMDG=
PU_FAMILY_NV) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int extra_pipe =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if ((adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 3, 0)) &a=
mp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if ((amdgpu_ip_version(adev, GC_HWIP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0) &gt;=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipes =3D=3D packers &amp;&amp; pip=
es &gt; 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extra_pipe =
=3D 1;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index ef713806dd60..6686b911fb4a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2251,7 +2251,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_forbid(dev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !a=
mdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool need_to_reset_gpu =3D false;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c<br>
index e163cb0bacd8..709a2c1b9d63 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
@@ -570,7 +570,8 @@ static bool amdgpu_fence_need_ring_interrupt_restore(st=
ruct amdgpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ring-&gt;funcs-&gt=
;type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RING_TYPE_SDMA=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SDMA 5.x+ is part of GF=
X power domain so it's covered by GFXOFF */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] &gt;=3D IP_VERSION(5, 0,=
 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(5, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_gf=
x_power_domain =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RING_TYPE_GFX:=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 2382921710ec..9a158018ae16 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -158,7 +158,7 @@ static bool amdgpu_gfx_is_compute_multipipe_capable(str=
uct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_compute_multipipe =3D=3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt; IP_VERSION(9, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt; IP_VERSION(9, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIXME: spreading the qu=
eues across pipes causes perf regressions<br>
@@ -385,7 +385,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 domain =3D AMDGPU_GEM_=
DOMAIN_GTT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only enable on gfx10 an=
d 11 for now to avoid changing behavior on older chips */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(10, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(10, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; domain |=3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* create MQD for KIQ */<b=
r>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 5f7641d9f346..de7b379a9cc8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -588,7 +588,7 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device=
 *adev)<br>
&nbsp; */<br>
&nbsp;void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RAVEN */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
@@ -652,7 +652,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)<br>
&nbsp;void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc =3D=
 &amp;adev-&gt;gmc;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D amdgpu_ip_version=
(adev, GC_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool noretry_default =3D (=
gc_ver =3D=3D IP_VERSION(9, 0, 1) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(9, 3, 0=
) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gc_ver =3D=3D IP_VERSION(9, 4, 0=
) ||<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index d462b36adf4b..4e32c428c613 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -501,18 +501,22 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt=
;=3D CHIP_VEGA10) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_GFX:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D adev-&gt;ip_versions[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_SDMA:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D adev-&gt;ip_versions[SDMA0_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, SDMA0_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_UVD:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_JPEG:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D adev-&gt;ip_versions[UVD_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, UVD_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case AMD_IP_BLOCK_TYPE_VCE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D adev-&gt;ip_versions[VCE_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result-&gt;ip_di=
scovery_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, VCE_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resul=
t-&gt;ip_discovery_version =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 10ce5557bb11..70fe3b39c004 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -131,7 +131,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.gfx_hqd_mask[i] =3D i ? 0 : 0xfffffffe;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGP=
U_MES_MAX_SDMA_PIPES; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] &lt; IP_VERSION(6, 0, 0)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) &lt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(6, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;mes.sdma_hqd_mask[i] =3D i ? 0 : 0x3fc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* zero sdma_hqd_mask for non-existent engine */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;sdma.num_instances =3D=3D 1)<br>
@@ -1339,8 +1340,10 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY=
_SIZE(queue_types); i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* On GFX v10.3, fw hasn't supported to map sdma queu=
e. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 3, 0=
) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] &lt; IP=
_VERSION(11, 0, 0) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(10, 3, 0) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) &lt;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 0) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_types[i][0] =3D=3D AMDG=
PU_RING_TYPE_SDMA)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
@@ -1401,7 +1404,7 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *a=
dev, int pipe)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, GC_HWIP, ucode_prefix,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; sizeof(ucode_prefix));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(11, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(11, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_me=
s%s.bin&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ucode_prefix,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? &quot;_2&quot; : &quot;1&quot;);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index ed0955ccd3d7..72ee66db182c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -100,7 +100,7 @@ static void psp_check_pmfw_centralized_cstate_managemen=
t(struct psp_context *psp<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):=
<br>
@@ -128,7 +128,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
@@ -162,7 +162,7 @@ static int psp_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context *psp =
=3D &amp;adev-&gt;psp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_v3_1_set_psp_funcs(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;autoload_supported =3D false;<br>
@@ -334,7 +334,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 6))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 6))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; db_header_pos =3D adev-&gt=
;gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;<br>
@@ -413,7 +413,7 @@ static int psp_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.xgmi_context.=
supports_extended_data =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;scpm_entry, 0,=
 sizeof(scpm_entry));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((psp_get_runtime_db_en=
try(adev,<br>
@@ -773,7 +773,7 @@ static int psp_load_toc(struct psp_context *psp,<br>
&nbsp;<br>
&nbsp;static bool psp_boottime_tmr(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (psp-&gt;adev-&gt;ip_versions[=
MP0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(psp-&gt;ade=
v, MP0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -828,7 +828,7 @@ static int psp_tmr_init(struct psp_context *psp)<br>
&nbsp;<br>
&nbsp;static bool psp_skip_tmr(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (psp-&gt;adev-&gt;ip_versions[=
MP0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(psp-&gt;ade=
v, MP0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
@@ -1215,8 +1215,8 @@ int psp_xgmi_terminate(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XGMI TA unload currentl=
y is not supported on Arcturus/Aldebaran A+A */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 4) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 4) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gmc.xgmi.connected_to_cpu))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
@@ -1313,9 +1313,11 @@ int psp_xgmi_get_node_id(struct psp_context *psp, ui=
nt64_t *node_id)<br>
&nbsp;<br>
&nbsp;static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (psp-&gt;adev-&gt;ip_versions[=
MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (amdgpu_ip_version(psp-&gt;ade=
v, MP0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0=
, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;xgmi_context.context.bin_desc.fw_version &gt;=
=3D 0x2000000b) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;adev-&gt;ip_versions[MP0_HWIP][0] &gt;=3D IP_VERSION(13,=
 0, 6);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(psp-&gt;adev, MP0_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0, 6);<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -1424,8 +1426,10 @@ int psp_xgmi_get_topology_info(struct psp_context *p=
sp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_xgmi_peer_link_inf=
o_supported(psp)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct ta_xgmi_cmd_get_peer_link_info_output *link_in=
fo_output;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool requires_reflection =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;xgmi_co=
ntext.supports_extended_data &amp;&amp; get_extended_data) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;adev-&gt;ip_versions[MP0_HWIP][0] =
=3D=3D IP_VERSION(13, 0, 6);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;xgmi_co=
ntext.supports_extended_data &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_extend=
ed_data) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(psp-&gt;adev, MP0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0, 6);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgmi_cmd-&gt;cmd_id =3D TA_COMMAND_XGMI__GET_PEER_LIN=
KS;<br>
&nbsp;<br>
@@ -2517,10 +2521,9 @@ static int psp_load_smu_fw(struct psp_context *psp)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ucode-&gt;fw || amdgp=
u_sriov_vf(psp-&gt;adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_in_reset(adev) &amp;&amp;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras &am=
p;&amp; adev-&gt;ras_enabled &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 4) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 2)))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_in_reset(adev) &amp;&amp;=
 ras &amp;&amp; adev-&gt;ras_enabled &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu=
_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0, 4) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(11, 0, 2)))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_U=
NLOAD);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_W=
ARN(&quot;Failed to set MP1 state prepare for reload\n&quot;);<br>
@@ -2603,9 +2606,12 @@ static int psp_load_non_psp_fw(struct psp_context *p=
sp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (psp-&gt;autoload_supported &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[MP0_HWIP][0] =3D=
=3D IP_VERSION(11, 0, 7) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 11) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 12)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, MP0_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; IP_VERSION(11, 0, 7) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, MP0_HWIP, =
0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; IP_VERSION(11, 0, 11) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, MP0_HWIP, =
0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; IP_VERSION(11, 0, 12)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (ucode-&gt;ucode_id =3D=3D AM=
DGPU_UCODE_ID_SDMA1 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_SDMA2 ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_SDMA3))<br>
@@ -3146,7 +3152,7 @@ static int psp_init_sos_base_fw(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; le32_to_cpu(sos_hdr-&gt;header.ucode_array_offset_byt=
es);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.conn=
ected_to_cpu ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP0_HWIP][0] !=3D IP_VERSION(13, 0, 2))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.sos.fw_version =3D le32_to_cpu(sos_hdr-&=
gt;header.ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.sos.feature_version =3D le32_to_cpu(sos_=
hdr-&gt;sos.fw_version);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 632478874f7d..eeb695f9ff1c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -201,8 +201,8 @@ static ssize_t amdgpu_ras_debugfs_read(struct file *f, =
char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Hardware counter will b=
e reset automatically after the query on Vega20 and Arcturus */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj-&gt;adev-&gt;ip_versions[MP0_=
HWIP][0] !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;adev-=
&gt;ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(obj-&gt;adev, M=
P0_HWIP, 0) !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(obj-&gt;adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0, 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_reset_error_status(obj-&gt;adev, info.=
head.block))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_w=
arn(obj-&gt;adev-&gt;dev, &quot;Failed to reset error counter and error sta=
tus&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -611,8 +611,8 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_query_error=
_status(obj-&gt;adev, &amp;info))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj-&gt;adev-&gt;ip_versions[MP0_=
HWIP][0] !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;adev-=
&gt;ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(obj-&gt;adev, M=
P0_HWIP, 0) !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(obj-&gt;adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0, 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_reset_error_status(obj-&gt;adev, info.=
head.block))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_w=
arn(obj-&gt;adev-&gt;dev, &quot;Failed to reset error counter and error sta=
tus&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1208,8 +1208,8 @@ static int amdgpu_ras_query_error_count_helper(struct=
 amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* some hardware/IP suppor=
ts read to clear<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * no need to explict=
ly reset the err status after the query call */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 4)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) !=3D IP_VERSION(11, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP0_HWIP, 0) !=3D IP_VERSION(11, 0, 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_reset_error_status(adev, query_info-&g=
t;head.block))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_w=
arn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to reset erro=
r counter and error status\n&quot;);<br>
@@ -1905,14 +1905,18 @@ static void amdgpu_ras_log_on_err_counter(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * should be removed until smu fix handle ecc_in=
fo table.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((info.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) &a=
mp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(13, 0, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_query_error_status(adev, &amp;info);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0] !=3D IP_VERSION(11, 0, 2) =
&amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] !=3D I=
P_VERSION(11, 0, 4) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[MP0_HWIP][0] !=3D I=
P_VERSION(13, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, MP0_HWIP, 0) !=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 4) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, MP0_HWIP, 0) !=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(13, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
mdgpu_ras_reset_error_status(adev, info.head.block))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Fai=
led to reset error counter and error status&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2400,7 +2404,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_dev=
ice *adev)<br>
&nbsp;static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
@@ -2410,7 +2414,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_IP_DISCOVERY) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10):<br>
@@ -2484,8 +2488,10 @@ static void amdgpu_ras_check_supported(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VC=
N/JPEG RAS can be supported on both bare metal and<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * SRIOV environment<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[VCN_HWIP][0] =3D=3D IP_VERSION(2, 6, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, VCN_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(2, 6, 0)=
 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 0, 0)=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_hw_enabled |=3D (1 =
&lt;&lt; AMDGPU_RAS_BLOCK__VCN |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; AMDGPU_RAS_BLOCK__JPEG);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<=
br>
@@ -2519,7 +2525,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable ras featur=
e for aqua vanjaram<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * by default on apu =
platform.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 6) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 6) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gmc.is_app_apu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ras_enabled =3D amdgpu_ras_enable !=3D 1 ? 0=
 :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;ras_hw_enabled &amp; amdgpu_ras_mask;<br>
@@ -2634,7 +2640,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* initialize nbio ras fun=
ction ahead of any other<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ras functions so h=
ardware fatal error interrupt<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can be enabled as =
early as possible */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 4, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 4, 4):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 595d5e535aca..8ced4be784e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -153,7 +153,7 @@<br>
&nbsp;<br>
&nbsp;static bool __is_ras_eeprom_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
 /* VEGA20 and ARCTURUS */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
 /* Sienna cichlid */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
@@ -191,7 +191,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* VEGA20 and ARCTURUS */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA20)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c<br>
index 02d874799c16..970bfece775c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<br>
@@ -30,7 +30,7 @@ int amdgpu_reset_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_reset_init(adev);<br>
@@ -52,7 +52,7 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_reset_fini(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c<br>
index 572f861e3f70..e8cbc4142d80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
@@ -251,8 +251,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Use a single copy per SDMA firmware type. PSP uses the s=
ame instance for all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * groups of SDMAs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 2) &am=
p;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_L=
OAD_PSP &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (amdgpu_ip_version(adev, SDMA0_HWIP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; IP_VERSION(4, 4, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.load_type =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMDGPU_FW_LOAD_PSP &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.num_inst_per_aid =3D=
=3D i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 4e51dce3aab5..05991c5c8ddb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1727,7 +1727,8 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reserve_size =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_atomfirmware_get_fw_reserved_fb_size(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;bios &amp;&amp; adev-&g=
t;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;bios &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reserve_size =3D max(reserve_size, (uint32_t)280 &lt;=
&lt; 20);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (!reserve_size)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reserve_size =3D DISCOVERY_TMR_OFFSET;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c<br>
index 5aff383473f2..771ef8017a98 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c<br>
@@ -1119,7 +1119,7 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)<=
br>
&nbsp;static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *a=
dev, int block_type)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (block_type =3D=3D MP0_=
HWIP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switc=
h (adev-&gt;asic_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
CHIP_VEGA10:<br>
@@ -1170,7 +1170,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;yellow_carp&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (block_type =3D=
=3D MP1_HWIP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 1):<br>
@@ -1196,7 +1196,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;aldebaran_smc&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (block_type =3D=
=3D SDMA0_HWIP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;vega10_sdma&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):<br>
@@ -1240,7 +1240,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;vangogh_sdma&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (block_type =3D=
=3D UVD_HWIP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
dev-&gt;apu_flags &amp; AMD_APU_IS_RAVEN2)<br>
@@ -1265,7 +1265,8 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 64):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 192):<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;sienna_cichlid_vcn&=
quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;navy_flounder_vcn&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 2):<br>
@@ -1278,7 +1279,7 @@ static const char *amdgpu_ucode_legacy_naming(struct =
amdgpu_device *adev, int bl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;yellow_carp_vcn&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (block_type =3D=
=3D GC_HWIP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n &quot;vega10&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<br>
@@ -1331,7 +1332,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_dev=
ice *adev, int block_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int maj, min, rev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *ip_name;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *legacy;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version =3D adev-&gt;ip_vers=
ions[block_type][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t version =3D amdgpu_ip_versio=
n(adev, block_type, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; legacy =3D amdgpu_ucode_le=
gacy_naming(adev, block_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (legacy) {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c<br>
index db0d94ca4ffc..24fcc9a2e422 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<br>
@@ -28,7 +28,7 @@ static int amdgpu_umc_convert_error_address(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct r=
as_err_data *err_data, uint64_t err_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t=
 ch_inst, uint32_t umc_inst)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UMC_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UMC_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 7, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umc_v6_7_convert_error_address(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data, err_addr, ch_inst, umc=
_inst);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_umsch_mm.c<br>
index 9da80b54d63e..aeff9926412f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c<br>
@@ -581,7 +581,7 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_=
mm *umsch)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *fw_name =3D NU=
LL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VCN_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VCN_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_name =3D &quot;amdgpu/umsch_mm_4_0_0.bin&quot;;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -758,7 +758,7 @@ static int umsch_mm_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VCN_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VCN_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 5):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umsch_mm_v4_0_set_funcs(&amp;adev-&gt;umsch_mm);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 80bcbe744e58..c93f3a4c0e31 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -126,7 +126,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Hence, check for t=
hese versions here - notice this is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * restricted to Vang=
ogh (Deck's APU).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0]=
 =3D=3D IP_VERSION(3, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP,=
 0) =3D=3D IP_VERSION(3, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const char *bios_ver =3D dmi_get_system_info(DMI_BIOS=
_VERSION);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (bios_ver &amp;&amp; (!strncmp(&quot;F7A0113&quot;=
, bios_ver, 7) ||<br>
@@ -171,7 +171,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type !=3D AMDGPU_FW_LOAD_PSP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr-&g=
t;ucode_size_bytes) + 8);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0]=
 &gt;=3D IP_VERSION(4, 0, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP,=
 0) &gt;=3D IP_VERSION(4, 0, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struc=
t amdgpu_vcn4_fw_shared));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; log_offset =3D offsetof(struct amdgpu_vcn4_fw_shared,=
 fw_log);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -267,7 +267,7 @@ static bool amdgpu_vcn_using_unified_queue(struct amdgp=
u_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret =3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0]=
 &gt;=3D IP_VERSION(4, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP,=
 0) &gt;=3D IP_VERSION(4, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -998,7 +998,7 @@ int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring =
*ring, long timeout)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0]=
 !=3D IP_VERSION(4, 0, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP,=
 0) !=3D IP_VERSION(4, 0, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_enc_ring_test_ib(ring, timeout);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error;<br>
@@ -1048,7 +1048,8 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;firmware.fw_size +=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;ucode_=
size_bytes), PAGE_SIZE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[UVD_HWIP][0] =3D=3D IP_VERSION(4, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, UVD_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(4, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN=
 firmware\n&quot;);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 96857ae7fb5b..a0aa624f5a92 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -837,7 +837,7 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode=
(struct amdgpu_device *ad<br>
&nbsp;<br>
&nbsp;void amdgpu_virt_post_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(11, 0, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* force set to GFXOFF state after reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid some invalid operation before GC ena=
ble<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -847,7 +847,7 @@ void amdgpu_virt_post_reset(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint3=
2_t ucode_id)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* no vf autoload, white list */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ucode_id =3D=3D AMDGPU_UCODE_ID_VCN1 ||<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index edaebabc8e60..a874aed2ab52 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -802,12 +802,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * heavy-weight flush=
 TLB unconditionally.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb |=3D adev-&gt;gm=
c.xgmi.num_physical_nodes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0=
) =3D=3D IP_VERSION(9, 4, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * On GFX8 and older =
any 8 PTE block with a valid bit set enters the TLB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb |=3D adev-&gt;ip_versions[G=
C_HWIP][0] &lt; IP_VERSION(9, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb |=3D amdgpu_ip_version(adev=
, GC_HWIP, 0) &lt; IP_VERSION(9, 0, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;params, 0, siz=
eof(params));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; params.adev =3D adev;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c<br>
index ae070072705a..a68354d03a49 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c<br>
@@ -123,7 +123,7 @@ static int vpe_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vpe *vpe =3D=
 &amp;adev-&gt;vpe;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VPE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VPE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vpe_v6_1_set_funcs(vpe);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 7e91b24784e5..061534e845a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -948,7 +948,8 @@ static int amdgpu_xgmi_query_pcs_error_status(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t field_array_size =
=3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_xgmi_pcs) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[XGMI_HWIP][0] =3D=3D IP_VERSION(6, 1, 0=
)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(6, 1, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcs_r=
as_fields =3D &amp;xgmi3x16_pcs_ras_fields[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field=
_array_size =3D ARRAY_SIZE(xgmi3x16_pcs_ras_fields);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v1_0.c<br>
index a13c443ea10f..42f4e163e251 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c<br>
@@ -68,7 +68,7 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 0):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v2_0.c<br>
index a9521c98e7f7..5a122f50a6e7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_0.c<br>
@@ -77,7 +77,7 @@ int athub_v2_0_set_clockgating(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 3, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v2_1.c<br>
index 78508ae6a670..e143fcc46148 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c<br>
@@ -70,7 +70,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/athub_v3_0.c<br>
index f0e235f98afb..5a318bc03d23 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v3_0.c<br>
@@ -36,7 +36,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_devi=
ce *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3=
_0_1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -49,7 +49,7 @@ static uint32_t athub_v3_0_get_cg_cntl(struct amdgpu_devi=
ce *adev)<br>
&nbsp;<br>
&nbsp;static void athub_v3_0_set_cg_cntl(struct amdgpu_device *adev, uint32=
_t data)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(ATHUB, 0, regATHUB_MISC_CNTL_V3_0_1, dat=
a);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -99,7 +99,7 @@ int athub_v3_0_set_clockgating(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[ATHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, ATHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 62329a822022..35357364b5b3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -3627,7 +3627,7 @@ static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu=
_device *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v10_0_init_spm_golden_registers(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_rlc_spm_10_0_nv10,<br>
@@ -3650,7 +3650,7 @@ static void gfx_v10_0_init_spm_golden_registers(struc=
t amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v10_0_init_golden_registers(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_10_1,<br>
@@ -3891,7 +3891,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdg=
pu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.cp_fw_write_w=
ait =3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
@@ -3942,7 +3942,7 @@ static bool gfx_v10_0_navi10_gfxoff_should_enable(str=
uct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)<b=
r>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
@@ -3964,8 +3964,8 @@ static int gfx_v10_0_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!(adev-&gt;pdev-&g=
t;device =3D=3D 0x7340 &amp;&amp; adev-&gt;pdev-&gt;revision !=3D 0x00)))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!(adev-&gt;p=
dev-&gt;device =3D=3D 0x7340 &amp;&amp; adev-&gt;pdev-&gt;revision !=3D 0x0=
0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; wks =3D &quot;_wks&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
&nbsp;<br>
@@ -4144,7 +4144,7 @@ static void gfx_v10_0_init_rlcg_reg_access_ctrl(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_access_ctrl-&gt;scratc=
h_reg3 =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_access_ctrl-&gt;grbm_c=
ntl =3D SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_access_ctrl-&gt;grbm_i=
dx =3D SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reg_access_ctrl-&gt;spare_int =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15=
_REG_OFFSET(GC, 0, mmRLC_SPARE_INT_0_Sienna_Cichlid);<br>
@@ -4358,7 +4358,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_de=
vice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 gb_addr_config;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -4491,7 +4491,7 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -4749,9 +4749,12 @@ static void gfx_v10_0_setup_rb(struct amdgpu_device =
*adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.config.max_shader_engines; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;gfx.config.max_sh_per_s=
e; j++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitma=
p =3D i * adev-&gt;gfx.config.max_sh_per_se + j;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;i=
p_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP=
_VERSION(10, 3, 3)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP=
_VERSION(10, 3, 6))) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 3)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 6))) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ((gfx_v10_3_get_disabled_sa(adev) &gt;&gt; bitmap) &amp;=
 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
10_0_select_se_sh(adev, i, j, 0xffffffff, 0);<br>
@@ -4779,7 +4782,7 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_overrid=
e(struct amdgpu_device *ade<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for ASICs that integrat=
es GFX v10.3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pa_sc_tile_steerin=
g_override should be set to 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(10, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init num_sc */<br>
@@ -4960,7 +4963,7 @@ static void gfx_v10_0_get_tcc_info(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TCCs are global (not in=
stanced). */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tcc_disable;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(10, 3, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(10, 3, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tcc_disable =3D RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABL=
E_gc_10_3) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DISABLE_=
gc_10_3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -5037,7 +5040,7 @@ static int gfx_v10_0_init_csb(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;get_csb_buffer(adev, adev-&gt;gfx.rlc.cs_ptr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* csib */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_HI,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.clear_state_gpu=
_addr &gt;&gt; 32);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmRLC_CSIB_ADDR_LO,<br>
@@ -5666,7 +5669,7 @@ static int gfx_v10_0_cp_gfx_enable(struct amdgpu_devi=
ce *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, PFP_HALT, enable ? 0 : 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp,=
 CP_ME_CNTL, CE_HALT, enable ? 0 : 1);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_ME_CNTL, tmp);<br>
@@ -6057,7 +6060,7 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -6190,7 +6193,7 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_devi=
ce *adev)<br>
&nbsp;static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, b=
ool enable)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):<br>
@@ -6206,7 +6209,7 @@ static void gfx_v10_0_cp_compute_enable(struct amdgpu=
_device *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):<br>
@@ -6306,7 +6309,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring =
*ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* tell RLC which is KIQ q=
ueue */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -6917,7 +6920,7 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * check if mmVGT_ESG=
S_RING_SIZE_UMD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * has been remapped =
to mmVGT_ESGS_RING_SIZE<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 4):=
<br>
@@ -6966,7 +6969,7 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM=
_CAM_INDEX, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -7139,19 +7142,19 @@ static int gfx_v10_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * init golden regist=
ers and rlc resume may override some registers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * reconfig them here=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 10) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 10) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_tcp_harvest(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v10_0_cp_resume(=
adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_3_program_pbb_mode(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(10, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_3_set_power_brake_sequence(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -7255,7 +7258,7 @@ static int gfx_v10_0_soft_reset(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GRBM_STATUS2 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmGRBM_STATUS2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -7312,7 +7315,7 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struc=
t amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t clock, clock_lo, =
clock_hi, hi_check;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7):=
<br>
@@ -7399,7 +7402,7 @@ static int gfx_v10_0_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs =3D &am=
p;gfx_v10_0_gfx_funcs;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -7470,7 +7473,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_dev=
ice *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RLC_SAFE_MODE__CM=
D_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (1 &lt;&lt; RLC_=
SAFE_MODE__MESSAGE__SHIFT);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -7508,7 +7511,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_d=
evice *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RLC_SAFE_MODE__CM=
D_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -7819,7 +7822,7 @@ static void gfx_v10_0_apply_medium_grain_clock_gating=
_workaround(struct amdgpu_d<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmCGTS_SA1_QUAD1_SM_CTRL_REG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ARRAY_SIZE(tcp_ctrl_regs_nv12); =
i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_i=
dx =3D adev-&gt;reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BA=
SE_IDX] +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tcp_ctrl_regs_nv12[i=
];<br>
@@ -7864,9 +7867,12 @@ static int gfx_v10_0_update_gfx_clock_gating(struct =
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* =3D=3D=3D&nbsp; CGCG + CGLS =3D=3D=3D */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v10_0_update_coarse_grain_clock_gating(adev, enab=
le);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1=
0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D=
 IP_VERSION(10, 1, 1)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D=
 IP_VERSION(10, 1, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 1, 10)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 1, 1)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 1, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
10_0_apply_medium_grain_clock_gating_workaround(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* CGCG/CGLS should be disabled before MGCG/MGLS<br>
@@ -7966,7 +7972,7 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_d=
evice *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Power/performance =
team will optimize it and might give a new value later.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (ade=
v-&gt;pg_flags &amp; AMD_PG_SUPPORT_GFX_PG)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):<br>
@@ -8027,7 +8033,7 @@ static int gfx_v10_0_set_powergating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -8064,7 +8070,7 @@ static int gfx_v10_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -9311,7 +9317,7 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 3):=
<br>
@@ -9428,10 +9434,14 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.config.max_shader_engines; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;gfx.config.max_sh_per_s=
e; j++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitma=
p =3D i * adev-&gt;gfx.config.max_sh_per_se + j;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;i=
p_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 3)=
) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 6)=
) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 7)=
)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 3)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 6)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 7))) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; ((gfx_v10_3_get_disabled_sa(adev) &gt;&gt; bitmap) &amp;=
 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask =
=3D 1;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 39c434ca0dad..42fc0cc13fdd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -288,7 +288,7 @@ static void gfx_v11_0_set_kiq_pm4_funcs(struct amdgpu_d=
evice *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_init_golden_registers(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
@@ -493,7 +493,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_d=
evice *adev, const char *<br>
&nbsp;<br>
&nbsp;static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):=
<br>
@@ -884,8 +884,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_func=
s =3D {<br>
&nbsp;<br>
&nbsp;static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_hw_contexts =3D 8;<br>
@@ -1332,7 +1331,7 @@ static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs-&gt;=
init(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):=
<br>
@@ -1364,8 +1363,8 @@ static int gfx_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable CG flag in one V=
F mode for enabling RLC safe mode enter/exit */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(11, 0, 3) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_sriov_is_pp_one_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(11, 0, 3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_=
is_pp_one_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* EOP Event */<br>
@@ -2592,9 +2591,11 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cp_status =3D RREG32_SOC15(GC, 0, regCP_STAT);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(11, 0, 1)=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_=
VERSION(11, 0, 4) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_=
VERSION(11, 5, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 4) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D IP_VERSION(11, 5, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootl=
oad_status =3D RREG32_SOC15(GC, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
@@ -5025,7 +5026,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_d=
evice *adev, bool enable)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Program RLC_PG_DELAY3 f=
or CGPG hysteresis<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (ade=
v-&gt;pg_flags &amp; AMD_PG_SUPPORT_GFX_PG)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);<br>
@@ -5054,7 +5055,7 @@ static int gfx_v11_0_set_powergating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):=
<br>
@@ -5086,7 +5087,7 @@ static int gfx_v11_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index f99a3a6bfd91..e3ff6e46f3f7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -895,7 +895,7 @@ static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_de=
vice *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_gc_9_0,<br>
@@ -951,8 +951,8 @@ static void gfx_v9_0_init_golden_registers(struct amdgp=
u_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0]=
 !=3D IP_VERSION(9, 4, 1)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP,=
 0) !=3D IP_VERSION(9, 4, 1)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev, golden_settings=
_gc_9_x_common,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)=
ARRAY_SIZE(golden_settings_gc_9_x_common));<br>
&nbsp;}<br>
@@ -1095,14 +1095,14 @@ static void gfx_v9_0_check_fw_write_wait(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.me_fw_write_w=
ait =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec_fw_write_=
wait =3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0]=
 !=3D IP_VERSION(9, 4, 1)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP,=
 0) !=3D IP_VERSION(9, 4, 1)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((=
adev-&gt;gfx.mec_fw_version &lt; 0x000001a5) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx=
.mec_feature_version &lt; 46) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx=
.pfp_fw_version &lt; 0x000000b7) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx=
.pfp_feature_version &lt; 46)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;gfx.mec_feature_version &lt; 46) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;gfx.pfp_fw_version &lt; 0x000000b7) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;gfx.pfp_feature_version &lt; 46)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_WARN_ONCE(&quot;CP firmware version too old, plea=
se update!&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;gfx.me_fw_version &gt;=3D 0x0000009c) &=
amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gfx.me_feature_vers=
ion &gt;=3D 42) &amp;&amp;<br>
@@ -1202,7 +1202,7 @@ static bool is_raven_kicker(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;static bool check_if_enlarge_doorbell_range(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0]=
 =3D=3D IP_VERSION(9, 3, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP,=
 0) =3D=3D IP_VERSION(9, 3, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;gfx.me_fw_version &gt;=3D 0x000000a5) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;gfx.me_feature_version &gt;=3D 52))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -1215,7 +1215,7 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdg=
pu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_v9_0_should_disabl=
e_gfxoff(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pp_feature &amp;=3D ~PP_GFXOFF_MASK;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -1326,9 +1326,9 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_=
device *adev,<br>
&nbsp;<br>
&nbsp;static bool gfx_v9_0_load_mec2_fw_bin_support(struct amdgpu_device *a=
dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -1485,7 +1485,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct am=
dgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; A=
MD_IS_APU)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; always_on_cu_num =3D 4;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adev-&gt;ip_versions[GC_HWIP=
][0] =3D=3D IP_VERSION(9, 2, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_ip_version(adev, GC_H=
WIP, 0) =3D=3D IP_VERSION(9, 2, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; always_on_cu_num =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; always_on_cu_num =3D 12;<br>
@@ -1836,7 +1836,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 gb_addr_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_hw_contexts =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_frontend =3D 0x=
20;<br>
@@ -2002,7 +2002,7 @@ static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int hw_prio;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -2363,7 +2363,7 @@ static void gfx_v9_0_init_sq_config(struct amdgpu_dev=
ice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0, mmSQ_CONFIG);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, SQ_CONFIG, DISABLE_BARRIER=
_WAITCNT,<br>
@@ -2700,7 +2700,7 @@ static void gfx_v9_0_init_gfx_power_gating(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0=
 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data |=3D (0x55f0 &lt;&lt; RLC_AUTO_PG_CTRL__GRBM_REG=
_SAVE_GFX_IDLE_THRESHOLD__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), d=
ata);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 3, 0))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 3, 0)=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pwr_1=
0_0_gfxip_control_over_cgpg(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
@@ -2812,7 +2812,8 @@ static void gfx_v9_0_init_pg(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * And it's needed by=
 gfxoff feature.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.is_rl=
c_v2_1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 2, 1) =
||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(9, 2, 1) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;apu_flags &amp; AMD=
_APU_IS_RAVEN2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_1_init_rlc_save_restore_list(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_0_enable_save_restore_machine(adev);<br>
@@ -2925,7 +2926,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_lbpw(adev);<br>
@@ -3713,8 +3714,8 @@ static void gfx_v9_0_init_tcp_config(struct amdgpu_de=
vice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
!=3D IP_VERSION(9, 4, 1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] !=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) !=3D IP_VERSION(9, 4, 1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(GC, 0=
, mmTCP_ADDR_CONFIG);<br>
@@ -3754,7 +3755,7 @@ static int gfx_v9_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2_set_power_brake_sequence(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -3802,7 +3803,7 @@ static int gfx_v9_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Skip stopping RLC with =
A+A reset or when RLC controls GFX clock */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;gmc.xgmi.con=
nected_to_cpu &amp;&amp; amdgpu_in_reset(adev)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[GC_HWIP][0] &gt;=3D IP_VERSION(9, 4, 2))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) &gt;=3D IP_VERSION(9, 4, 2))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Skipping RLC halt\n&quot;=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -3986,7 +3987,7 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct=
 amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t clock, clock_lo, =
clock_hi, hi_check;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; preempt_disable();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; clock_hi =3D RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_T=
SC_COUNT_UPPER_Renoir);<br>
@@ -4005,7 +4006,9 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;gfx.gpu_clock_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 0, 1) =
&amp;&amp; amdgpu_sriov_runtime(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(9, 0, 1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_runtime(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock=
 =3D gfx_v9_0_kiq_read_clock(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15(GC, 0, mmRLC_CAPTURE_GPU_CLOCK_COUNT, 1);<br>
@@ -4357,7 +4360,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;sched.ready)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vgpr_init_shader_ptr =3D vgpr_init_compute_shader_arc=
turus;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vgpr_init_shader_size =3D sizeof(vgpr_init_compute_sh=
ader_arcturus);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vgpr_init_regs_ptr =3D vgpr_init_regs_arcturus;<br>
@@ -4509,8 +4512,8 @@ static int gfx_v9_0_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs =3D &am=
p;gfx_v9_0_gfx_funcs;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GFX9_NUM_GFX_RINGS;<br=
>
@@ -4548,7 +4551,7 @@ static int gfx_v9_0_ecc_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* requires IBs so do in l=
ate init after IB pool is initialized */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_4_2_do_edc_gpr_workarounds(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_do_edc_gpr_workarounds(adev);<br>
@@ -4580,7 +4583,7 @@ static int gfx_v9_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gfx_v9_4_2_debug_trap_config_init(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -4676,7 +4679,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating=
(struct amdgpu_device *adev<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* 1 - RLC_CGTT_MGCG_OVERRIDE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_=
OVERRIDE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 2, 1))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 2, 1)=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
&amp;=3D ~RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_OVERRIDE_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCL=
K_OVERRIDE_MASK |<br>
@@ -4710,7 +4713,7 @@ static void gfx_v9_0_update_medium_grain_clock_gating=
(struct amdgpu_device *adev<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* 1 - MGCG_OVERRIDE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_=
OVERRIDE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] !=3D IP_VERSION(9, 2, 1))<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) !=3D IP_VERSION(9, 2, 1)=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
|=3D RLC_CGTT_MGCG_OVERRIDE__CPF_CGTT_SCLK_OVERRIDE_MASK;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data |=3D (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVER=
RIDE_MASK |<br>
@@ -4816,7 +4819,7 @@ static void gfx_v9_0_update_coarse_grain_clock_gating=
(struct amdgpu_device *adev<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* enable cgcg FSM(0x0000363F) */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D RREG32_SOC15(GC, 0, mmRLC_CGCG_CGLS_CTRL);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1))=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, =
1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D (0x2000 &lt;&lt; RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
@@ -4951,7 +4954,7 @@ static int gfx_v9_0_set_powergating_state(void *handl=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable =3D (state =3D=
=3D AMD_PG_STATE_GATE);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 3, 0):<=
br>
@@ -4998,7 +5001,7 @@ static int gfx_v9_0_set_clockgating_state(void *handl=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -5048,7 +5051,7 @@ static void gfx_v9_0_get_clockgating_state(void *hand=
le, u64 *flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data &amp; CP_MEM_SLP_=
CNTL__CP_MEM_LS_EN_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags |=3D AMD_CG_SUPPORT_GFX_CP_LS | AMD_CG_SUPPORT=
_GFX_MGLS;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
!=3D IP_VERSION(9, 4, 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) !=3D IP_VERSION(9, 4, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* AMD_CG_SUPPORT_GFX_3D_CGCG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_KIQ(SOC15_REG_OFFSET(GC, 0, mmRLC_CGC=
G_CGLS_CTRL_3D));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data &amp; RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)<b=
r>
@@ -7087,7 +7090,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -7106,7 +7109,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init asci gds info */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
@@ -7128,7 +7131,7 @@ static void gfx_v9_0_set_gds_init(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gds_compute_max_wave_id =3D 0x7ff;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index 32a740104868..fbfe0a1c4b19 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -682,7 +682,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs =3D &am=
p;gfx_v9_4_3_gfx_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras =3D &amp;=
gfx_v9_4_3_ras;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_hw_contexts =3D 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.sc_prim_fifo_size_frontend =3D 0x=
20;<br>
@@ -2430,7 +2430,7 @@ static int gfx_v9_4_3_set_clockgating_state(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&=
gt;gfx.xcc_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v=
9_4_3_xcc_update_gfx_clock_gating(<br>
@@ -4231,7 +4231,7 @@ static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_de=
vice *adev)<br>
&nbsp;static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init asci gds info */<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* 9.4.3 removed all the GDS internal memory,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * only support GWS opcode in kernel, like barri=
er<br>
@@ -4243,7 +4243,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* deprecated for 9.4.3, no usage at all */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.gds_compute_max_wave_id =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c<br>
index 0834af771549..ff60670b8464 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<br>
@@ -356,11 +356,14 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct =
amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * the SQ per-process.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * Retry faults need to be enabled for that to work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_=
FIELD(tmp, VM_CONTEXT1_CNTL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.noretry ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(9, 4, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(9, 4, 3));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_=
FIELD(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp, VM_CONTEXT1_CNTL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.noretry ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 4, 2) ||=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 4, 3));<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i * hub-&gt;ctx_distance, tmp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15_OFFSET(GC, GET_INST(GC, j),<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v2_1.c<br>
index 7708d5ded7b8..f829c441640a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c<br>
@@ -510,7 +510,7 @@ static int gfxhub_v2_1_get_xgmi_info(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 max_num_physical_nodes=
&nbsp;&nbsp; =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 max_physical_node_id&n=
bsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[XGMI_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, XGMI_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 8, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; max_num_physical_nodes&nbsp;&nbsp; =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; max_physical_node_id&nbsp;&nbsp;&nbsp;&nbsp; =3D 3;<b=
r>
@@ -548,7 +548,7 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_sh_per_se *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.max_shader_engines);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Get SA disabled bitmap from eFuse setting */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index fa87a85e1017..d3da13f4c80e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -145,7 +145,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * the new fast GRBM interface.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((entry-&gt;vmid_src =3D=3D AMDGPU_GFXHUB(0)) &amp=
;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &lt; I=
P_VERSION(10, 3, 0)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) &lt=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(10, 3, 0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG3=
2(hub-&gt;vm_l2_pro_fault_status);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status =3D RREG32(hub-&gt;vm_l2_pro_fault_status);<br=
>
@@ -278,7 +279,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to avoid a false A=
CK due to the new fast GRBM interface.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((vmhub =3D=3D AMDGPU_G=
FXHUB(0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[GC_HWIP][0] &lt; IP_VERSION(10, 3, 0)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) &lt; IP_VERSION(10, 3, 0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RREG32_RLC_NO_KIQ(hub-&gt;vm_inv_eng0_req +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub-&gt;eng_distance=
 * eng, hub_ip);<br>
&nbsp;<br>
@@ -680,7 +681,7 @@ static void gmc_v10_0_set_gmc_funcs(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v10_0_set_umc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UMC_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UMC_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(8, 7, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.max_ras_err_cnt_per_query =3D UMC_V8_7_T=
OTAL_CHANNEL_NUM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_inst_num =3D UMC_V8_7_CHANNEL_IN=
STANCE_NUM;<br>
@@ -697,7 +698,7 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 4, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 4, 1):<=
br>
@@ -711,7 +712,7 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
@@ -825,7 +826,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the gart size */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gart_size =3D=
=3D -1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gmc.gart_size =3D 512ULL &lt;&lt; 20;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -892,7 +893,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_vendor =3D vram_vendor;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mall_size =3D 128 * 1024 * 1024;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -910,7 +911,7 @@ static int gmc_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 2):=
<br>
@@ -1195,7 +1196,8 @@ static int gmc_v10_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is a new problem o=
bserved at DF 3.0.3, however with the same suspend sequence not<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * seen any issue on =
the DF 3.0.2 series platform.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix &amp;&amp; adev-=
&gt;ip_versions[DF_HWIP][0] &gt; IP_VERSION(3, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_s0ix &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, DF_HWIP, 0) &gt; IP_VERSION(3, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;keep mmhub clock gating b=
eing enabled for s0ix\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1204,7 +1206,7 @@ static int gmc_v10_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[ATHUB_HWIP][=
0] &gt;=3D IP_VERSION(2, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, ATHUB_HWI=
P, 0) &gt;=3D IP_VERSION(2, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return athub_v2_1_set_clockgating(adev, state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return athub_v2_0_set_clockgating(adev, state);<br>
@@ -1214,13 +1216,13 @@ static void gmc_v10_0_get_clockgating_state(void *h=
andle, u64 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(10, 1, 3) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(10, 1, 3) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 1, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs-&gt;g=
et_clockgating(adev, flags);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[ATHUB_HWIP][=
0] &gt;=3D IP_VERSION(2, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, ATHUB_HWI=
P, 0) &gt;=3D IP_VERSION(2, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; athub_v2_1_get_clockgating(adev, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; athub_v2_0_get_clockgating(adev, flags);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c<br>
index 671e288c7575..e1f47f9c1881 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
@@ -588,7 +588,7 @@ static void gmc_v11_0_set_gmc_funcs(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UMC_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UMC_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(8, 10, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.channel_inst_num =3D UMC_V8_10_CHANNEL_I=
NSTANCE_NUM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.umc_inst_num =3D UMC_V8_10_UMC_INSTANCE_=
NUM;<br>
@@ -611,7 +611,7 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs =3D &amp;mmhub_v3_0_1_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -629,7 +629,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 3):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs =3D &amp;gfxhub_v3_0_3_funcs;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -782,7 +782,7 @@ static int gmc_v11_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D=
 vram_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_vendor =
=3D vram_vendor;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index 3d13d0bba7b1..268ee533e7c1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -640,7 +640,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; addr, entry-&gt;client_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_ih_clientid_name[entry-&gt;client_id]);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;&nbsp; cookie node_id %d =
fault from die %s%d%s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_=
id, node_id % 4 =3D=3D 3 ? &quot;RSV&quot; : &quot;AID&quot;, node_id / 4,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node_=
id % 4 =3D=3D 1 ? &quot;.XCD0&quot; : node_id % 4 =3D=3D 2 ? &quot;.XCD1&qu=
ot; : &quot;&quot;);<br>
@@ -654,7 +654,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the new fast GRBM =
interface.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((entry-&gt;vmid_src =
=3D=3D AMDGPU_GFXHUB(0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[GC_HWIP][0] &lt; IP_VERSION(9, 4, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) &lt; IP_VERSION(9, 4, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RREG32(hub-&gt;vm_l2_pro_fault_status);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D RREG32(hub-&gt;=
vm_l2_pro_fault_status);<br>
@@ -671,7 +671,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxhu=
b_client_ids[cid],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cid);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub=
_cid =3D mmhub_client_ids_vega10[cid][rw];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -772,8 +772,8 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned in=
t vmid,<br>
&nbsp;static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; uint32_t vmhub)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ((vmhub =3D=3D AMDG=
PU_MMHUB0(0) ||<br>
@@ -824,7 +824,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hub =3D &amp;adev-&gt;vmhu=
b[vmhub];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_=
physical_nodes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Vega20+XGMI caches PTEs in TC and TLB. Add a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * heavy-weight TLB flush (type 2), which flushe=
s<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * both. Due to a race condition with concurrent=
<br>
@@ -834,7 +834,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_=
type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flush_type =3D=
=3D 2 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VER=
SION(9, 4, 3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_=
VERSION(9, 4, 3) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_=
type);<br>
@@ -896,7 +896,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device=
 *adev, uint32_t vmid,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * GRBM interface.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] &lt; I=
P_VERSION(9, 4, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) &lt=
; IP_VERSION(9, 4, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG3=
2_NO_KIQ(hub-&gt;vm_inv_eng0_req +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hub-&gt;eng_distance * eng);<br>
&nbsp;<br>
@@ -969,7 +969,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * still need a second TLB flush after this.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bool vega20_xgmi_wa =3D (adev-&gt;gmc.xgmi.num_physic=
al_nodes &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 4, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* 2 dwords flush + 8 dwords fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned int ndw =3D kiq-&gt;pmf-&gt;invalidate_tlbs_=
size + 8;<br>
&nbsp;<br>
@@ -984,7 +985,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_d=
evice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; pasid, 2, all_hub);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (flush_type =3D=3D 2 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D =
IP_VERSION(9, 4, 3) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(9, 4, 3) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq-&=
gt;pmf-&gt;kiq_invalidate_tlbs(ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid, 0, a=
ll_hub);<br>
@@ -1192,7 +1194,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool snoop =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_local;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (is_vram) {<br>
@@ -1206,8 +1208,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FIXME: is this still needed? =
Or does<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * amdgpu_ttm_tt_pde_flags =
already handle this?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0] =3D=
=3D IP_VERSION(9, 4, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 4, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(9, 4, 3)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;gmc.xgmi.connected_to_cpu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; snoop =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } els=
e {<br>
@@ -1316,7 +1320,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only GFX 9.4.3 APUs ass=
ociate GPUs with NUMA nodes. Local system<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * memory can use mor=
e efficient MTYPEs.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
!=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) !=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only direct-mapped memo=
ry allows us to determine the NUMA node from<br>
@@ -1385,7 +1389,7 @@ static unsigned int gmc_v9_0_get_vbios_fb_size(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u32 viewport;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; viewp=
ort =3D RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);<br>
@@ -1456,7 +1460,7 @@ static void gmc_v9_0_set_gmc_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UMC_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UMC_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.funcs =3D &amp;umc_v6_0_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1510,7 +1514,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.funcs =3D &amp;mmhub_v9_4_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1528,7 +1532,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_de=
vice *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)<=
br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras =3D &amp;mmhub_v1_0_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -1549,7 +1553,7 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgp=
u_device *adev)<br>
&nbsp;<br>
&nbsp;static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs =3D &amp;gfxhub_v1_2_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs =3D &amp;gfxhub_v1_0_funcs;<br>
@@ -1565,7 +1569,7 @@ static void gmc_v9_0_set_mca_ras_funcs(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mca *mca =3D=
 &amp;adev-&gt;mca;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* is UMC the right IP to =
check for MCA?&nbsp; Maybe DF? */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UMC_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UMC_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 7, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mca-&=
gt;mp0.ras =3D &amp;mca_v3_0_mp0_ras;<br>
@@ -1592,18 +1596,18 @@ static int gmc_v9_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 9.4.0, 9.4.1 and 9=
.4.3 don't have XGMI defined<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in their IP discov=
ery tables<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[XGMI_HWIP][0=
] =3D=3D IP_VERSION(6, 1, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, XGMI_HWIP=
, 0) =3D=3D IP_VERSION(6, 1, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.connected_to_cpu =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;smuio.funcs-&gt;is_host_gpu_xgmi_supported(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum amdgpu_pkg_type pkg_type =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;smuio.funcs-&gt;get_pkg_type(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* On GFXIP 9.4.3. APU, there is no physical VRAM dom=
ain present<br>
@@ -1652,7 +1656,7 @@ static int gmc_v9_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * writes, while disa=
bles HBM ECC for vega10.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[UMC_HWIP][0] =3D=3D IP_VERSION(6, 0, 0))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, UMC_HWIP, 0) =3D=3D IP_VERSION(6, 0, 0))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;ras_enabled &amp; (1 &lt;&lt; AMDGPU_R=
AS_BLOCK__UMC))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
dev-&gt;df.funcs &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;df.funcs-&gt;enable_ecc_force_par_wr_rmw)<br>
@@ -1760,7 +1764,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the gart size */<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gart_size =3D=
=3D -1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):&nbsp; /* all engines suppor=
t GPUVM */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 1):&nbsp; /* all engines suppor=
t GPUVM */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<br>
@@ -1839,8 +1843,8 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *a=
dev)<br>
&nbsp; */<br>
&nbsp;static void gmc_v9_0_save_registers(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[DCE_HWIP][0=
] =3D=3D IP_VERSION(1, 0, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, DCE_HWIP=
, 0) =3D=3D IP_VERSION(1, 0, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.sdpif_register =3D RREG32_SOC15(DCE, 0, =
mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2035,7 +2039,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;adev-&=
gt;gmc.invalidate_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc_v9_4_3_init_vram_info(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!adev-&gt;bios)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU) {<br>
@@ -2075,7 +2079,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_type =3D vram_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_vendor =3D vram_vendor;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_GFXHUB(0), adev-&gt;vmhubs_mask);<br>
@@ -2108,7 +2112,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2))=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, =
2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;gmc.translate_further =3D adev-&gt;vm_manager.num_level &gt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
@@ -2140,7 +2144,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 1)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VMC1,=
 VMC_1_0__SRCID__VM_FAULT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;adev-&gt;gmc.vm_fault);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -2169,7 +2173,10 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.mc_mask =3D 0=
xffffffffffffULL; /* 48 bit MC */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_bits =3D adev-&gt;ip_version=
s[GC_HWIP][0] &gt;=3D IP_VERSION(9, 4, 2) ? 48:44;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_bits =3D amdgpu_ip_version(a=
dev, GC_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; IP_VERSION(9, 4, 2) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48 :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D dma_set_mask_and_coh=
erent(adev-&gt;dev, DMA_BIT_MASK(dma_addr_bits));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;amdgpu: No suitable DMA =
available.\n&quot;);<br>
@@ -2183,7 +2190,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_get_vbios_alloc=
ations(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gmc_v9_0_init_mem_ranges(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
@@ -2209,9 +2216,11 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for video processi=
ng.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.first_=
kfd_vmid =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 1) ||<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 2=
) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 3=
)) ? 3 : 8;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1) =
||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4=
, 3)) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_manager_init(ade=
v);<br>
&nbsp;<br>
@@ -2221,7 +2230,7 @@ static int gmc_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysfs_init(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2231,7 +2240,7 @@ static int gmc_v9_0_sw_fini(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
=3D=3D IP_VERSION(9, 4, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) =3D=3D IP_VERSION(9, 4, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysfs_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.num_mem_parti=
tions =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;gmc.mem_par=
titions);<br>
@@ -2253,8 +2262,7 @@ static int gmc_v9_0_sw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -2288,8 +2296,8 @@ static void gmc_v9_0_init_golden_registers(struct amd=
gpu_device *adev)<br>
&nbsp; */<br>
&nbsp;void gmc_v9_0_restore_registers(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[DCE_HWIP][0=
] =3D=3D IP_VERSION(1, 0, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, DCE_HWIP=
, 0) =3D=3D IP_VERSION(1, 0, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, a=
dev-&gt;gmc.sdpif_register);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WARN_ON(adev-&gt;gmc.sdpif_register !=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG3=
2_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v4_0.c<br>
index 71d1a2e3bac9..3f3a6445c006 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c<br>
@@ -49,8 +49,8 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev=
,<br>
&nbsp;static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_ring *ring)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(4, 4, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(4, 4, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;fun=
cs-&gt;emit_wreg)<br>
@@ -80,7 +80,7 @@ static void hdp_v4_0_reset_ras_error_count(struct amdgpu_=
device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_ras_is_support=
ed(adev, AMDGPU_RAS_BLOCK__HDP))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 &gt;=3D IP_VERSION(4, 4, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) &gt;=3D IP_VERSION(4, 4, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP_EDC_CNT, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*read back hdp ras counter to reset it to 0 */<br>
@@ -92,10 +92,10 @@ static void hdp_v4_0_update_clock_gating(struct amdgpu_=
device *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(4, 0, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 0, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 1, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[HDP_HWIP][0] =3D=3D IP_VERSION(4, 1, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(4, 0, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 1, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, HDP_HWIP, 0) =3D=3D IP_VERSION(4, 1, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32(SOC15_REG_OFFSET(HDP, 0, mmHD=
P_MEM_POWER_LS));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (adev-&gt;cg_flags &amp; AMD_CG=
_SUPPORT_HDP_LS))<br>
@@ -137,7 +137,7 @@ static void hdp_v4_0_get_clockgating_state(struct amdgp=
u_device *adev,<br>
&nbsp;<br>
&nbsp;static void hdp_v4_0_init_registers(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[HDP_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, HDP_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC,=
 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -147,7 +147,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_devic=
e *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP=
_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(4, 4, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(4, 4, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WAT=
ERMARK, 2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, mmHDP=
_NONSURFACE_BASE, (adev-&gt;gmc.vram_start &gt;&gt; 8));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v6_0.c<br>
index 6f20f9889a78..ab06c2b4b20b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c<br>
@@ -51,7 +51,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_HDP_SD)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(6, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(6, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdp_clk_cntl =3D RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL=
_V6_1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hdp_clk_cntl =3D RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL=
);<br>
@@ -61,7 +61,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * forced on IPH &amp=
; RC clock */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdp_clk_cntl =3D REG_SET_F=
IELD(hdp_clk_cntl, HDP_CLK_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RC=
_MEM_CLK_SOFT_OVERRIDE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(6, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(6, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cn=
tl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);<=
br>
@@ -126,7 +126,7 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable IPH &amp; RC cl=
ock override after clock/power mode changing */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdp_clk_cntl =3D REG_SET_F=
IELD(hdp_clk_cntl, HDP_CLK_CNTL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RC=
_MEM_CLK_SOFT_OVERRIDE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[HDP_HWIP][0]=
 =3D=3D IP_VERSION(6, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, HDP_HWIP,=
 0) =3D=3D IP_VERSION(6, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cn=
tl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/imu_v11_0.c<br>
index 0a8bc6c94fa9..875fb5ac70b5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c<br>
@@ -353,7 +353,7 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_dev=
ice *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGFX=
_IMU_RLC_RAM_INDEX, 0x2);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; program_imu_rlc_ram(adev, imu_rlc_ram_golden_11,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const u32)ARRAY_SIZE(imu_rlc_ra=
m_golden_11));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c<br>
index aadb74de52bc..e67a337457ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c<br>
@@ -128,7 +128,7 @@ static int jpeg_v2_5_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring =3D adev-&gt;jpeg.inst[i].ring_dec;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;use_doorbell =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(2, 5, 0)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(2, 5,=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB1(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB0(0);<br>
@@ -822,7 +822,7 @@ static struct amdgpu_jpeg_ras jpeg_v2_6_ras =3D {<br>
&nbsp;<br>
&nbsp;static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[JPEG_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, JPEG_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 6, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;jpeg.ras =3D &amp;jpeg_v2_6_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v3_0.c<br>
index df4440c21bbf..a92481da60cd 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c<br>
@@ -52,7 +52,7 @@ static int jpeg_v3_0_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 harvest;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c<br>
index 3eb3dcd56b57..98ed49b16e62 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c<br>
@@ -831,7 +831,7 @@ static struct amdgpu_jpeg_ras jpeg_v4_0_ras =3D {<br>
&nbsp;<br>
&nbsp;static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[JPEG_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, JPEG_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;jpeg.ras =3D &amp;jpeg_v4_0_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v10_1.c<br>
index eb06d749876f..1e5ad1e08d2a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c<br>
@@ -558,7 +558,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_M=
ES_MDBOUND_LO, 0x3FFFF);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* invalidate ICACHE */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sien=
na_Cichlid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -568,7 +568,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichli=
d, data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -578,7 +578,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* prime the ICACHE. */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sien=
na_Cichlid);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -587,7 +587,7 @@ static int mes_v10_1_load_microcode(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(dat=
a, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichli=
d, data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -995,7 +995,7 @@ static void mes_v10_1_kiq_setting(struct amdgpu_ring *r=
ing)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* tell RLC which is KIQ q=
ueue */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 1):=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 3fa5bc3ddf92..4a3020b5b30f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1316,7 +1316,7 @@ static int mes_v11_0_late_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* it's only intended for =
use in mes_self_test case, not for s0ix and reset */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_in_reset(adev)=
 &amp;&amp; !adev-&gt;in_s0ix &amp;&amp; !adev-&gt;in_suspend &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[GC_HWIP][0] !=3D IP_VERSION(11, 0, 3)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, GC_HWIP, 0) !=3D IP_VERSION(11, 0, 3)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_mes_self_test(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 8f76c6ecf50a..37458f906980 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -151,7 +151,7 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmhub_cid =3D mmhub_client_ids_navi1x[cid][rw];<br>
@@ -568,7 +568,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating=
(struct amdgpu_device *ad<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &a=
mp; AMD_CG_SUPPORT_MC_MGCG))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 2):<=
br>
@@ -601,7 +601,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating=
(struct amdgpu_device *ad<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; DAGB0_CNTL_MISC2__DISABLE_TLBRD_CG_MASK);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 2):<=
br>
@@ -625,7 +625,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(=
struct amdgpu_device *ade<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &a=
mp; AMD_CG_SUPPORT_MC_LS))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 2):<=
br>
@@ -651,7 +651,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
@@ -676,7 +676,7 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u64 *flags)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c<br>
index 1dce053a4c4d..4ddd9448e2bc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
@@ -90,7 +90,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 4, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 4, 1):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c<br>
index 7c9ab5491067..9627df8b194b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c<br>
@@ -107,7 +107,7 @@ mmhub_v3_0_print_l2_protection_fault_status(struct amdg=
pu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmhub_cid =3D mmhub_client_ids_v3_0_0[cid][rw];<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_1.c<br>
index db79e6f92441..77bff803b452 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c<br>
@@ -108,7 +108,7 @@ mmhub_v3_0_1_print_l2_protection_fault_status(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmhub_cid =3D mmhub_client_ids_v3_0_1[cid][rw];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_3.c<br>
index 8194ee2b96c4..3d80a184ce6b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c<br>
@@ -96,7 +96,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MMHUB_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MMHUB=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmhub_cid =3D mmhub_client_ids_v3_3[cid][rw];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c<br>
index b6a8478dabf4..bb1873363d75 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
@@ -107,7 +107,7 @@ force_update_wptr_for_self_int(struct amdgpu_device *ad=
ev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_cntl, ih_rb_cntl;<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[OSSSYS_HWIP]=
[0] &lt; IP_VERSION(5, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, OSSSYS_HW=
IP, 0) &lt; IP_VERSION(5, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_cntl =3D RREG32_SOC15(O=
SSSYS, 0, mmIH_CNTL2);<br>
@@ -330,7 +330,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(adev-&gt;firm=
ware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ih[0]-&gt;use_bus_addr) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt=
;ip_versions[OSSSYS_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_i=
p_version(adev, OSSSYS_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(5, 0, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(5, 2, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(5, 2, 1):<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v2_3.c<br>
index 4038455d7998..e523627cfe25 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
@@ -536,7 +536,7 @@ static void nbio_v2_3_clear_doorbell_interrupt(struct a=
mdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, reg_data;<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[NBIO_HWIP][0=
] !=3D IP_VERSION(3, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, NBIO_HWIP=
, 0) !=3D IP_VERSION(3, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D RREG32_SOC15(NBIO,=
 0, mmBIF_RB_CNTL);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c<br>
index e5b5b0f4940f..a3622897e3fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
@@ -338,7 +338,7 @@ const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg=
 =3D {<br>
&nbsp;<br>
&nbsp;static void nbio_v4_3_init_registers(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[NBIO_HWIP][0=
] =3D=3D IP_VERSION(4, 3, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, NBIO_HWIP=
, 0) =3D=3D IP_VERSION(4, 3, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t data;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP=
2);<br>
@@ -392,8 +392,8 @@ static void nbio_v4_3_program_aspm(struct amdgpu_device=
 *adev)<br>
&nbsp;#ifdef CONFIG_PCIEASPM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;ip_versions[PCIE_HWIP]=
[0] =3D=3D IP_VERSION(7, 4, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !=
(adev-&gt;ip_versions[PCIE_HWIP][0] =3D=3D IP_VERSION(7, 6, 0)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_ip_version(adev, PCIE_HW=
IP, 0) =3D=3D IP_VERSION(7, 4, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(amdgpu_ip_v=
ersion(adev, PCIE_HWIP, 0) =3D=3D IP_VERSION(7, 6, 0)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SO=
C15(NBIO, 0, regPCIE_LC_CNTL);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_2.c<br>
index 4ef1fa4603c8..e962821ae6a1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c<br>
@@ -59,7 +59,7 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 0):<=
br>
@@ -78,7 +78,7 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bo=
ol enable)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 0):<=
br>
@@ -262,7 +262,7 @@ static void nbio_v7_2_update_medium_grain_light_sleep(s=
truct amdgpu_device *adev<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 0):<=
br>
@@ -369,7 +369,7 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg=
 =3D {<br>
&nbsp;static void nbio_v7_2_init_registers(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 0):<=
br>
@@ -394,7 +394,7 @@ static void nbio_v7_2_init_registers(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 5, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(NBIO, 0, regRCC_DEV2_EPF0_STRAP=
2);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 685abf57ffdd..7d6d7734dbec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -347,7 +347,7 @@ static void nbio_v7_4_init_registers(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(=
NBIO, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmBIF=
_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[NBIO_HWIP][0=
] =3D=3D IP_VERSION(7, 4, 4) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, NBIO_HWIP=
, 0) =3D=3D IP_VERSION(7, 4, 4) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !a=
mdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; baco_cntl =3D RREG32_SOC15(NBIO, 0, mmBACO_CNTL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (baco_cntl &amp;<br>
@@ -702,7 +702,7 @@ static void nbio_v7_4_program_aspm(struct amdgpu_device=
 *adev)<br>
&nbsp;#ifdef CONFIG_PCIEASPM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[NBIO_HWIP][0=
] =3D=3D IP_VERSION(7, 4, 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, NBIO_HWIP=
, 0) =3D=3D IP_VERSION(7, 4, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_PC=
IE(smnPCIE_LC_CNTL);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 13aca808ecab..0535cabe3b16 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -214,7 +214,7 @@ static int nv_query_video_codecs(struct amdgpu_device *=
adev, bool encode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.num_vcn_i=
nst =3D=3D hweight8(adev-&gt;vcn.harvest_config))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 64):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 192)=
:<br>
@@ -453,7 +453,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):=
<br>
@@ -669,7 +669,7 @@ static int nv_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: split the GC and =
PG flags based on the relevant IP version for which<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * they are relevant.=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 1, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGCG |<br>
@@ -1073,7 +1073,7 @@ static int nv_common_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 3, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 3, 2):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index 5f10883da6a2..145186a1e48f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -58,9 +58,10 @@ static int psp_v10_0_init_microcode(struct psp_context *=
psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D psp_init_ta_microc=
ode(psp, ucode_prefix);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[GC_HWIP][0]=
 =3D=3D IP_VERSION(9, 1, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;pdev-&gt;revision =3D=3D 0xa1) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (psp-&gt;securedisplay_context.context.bin_desc.fw_version &gt;=
=3D 0x27000008)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, GC_HWIP,=
 0) =3D=3D IP_VERSION(9, 1, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pde=
v-&gt;revision =3D=3D 0xa1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (psp-&gt;secu=
redisplay_context.context.bin_desc.fw_version &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x27000=
008)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.securedisplay_context.context.bin_desc.s=
ize_bytes =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 8f84fe40abbb..efa37e3b7931 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -95,7 +95,7 @@ static int psp_v11_0_init_microcode(struct psp_context *p=
sp)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_sos_microcode(psp, ucode_prefix);<br=
>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index 469eed084976..54008a8991fc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -79,7 +79,7 @@ static int psp_v13_0_init_microcode(struct psp_context *p=
sp)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_sos_microcode(psp, ucode_prefix);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
@@ -181,7 +181,7 @@ static int psp_v13_0_wait_for_bootloader_steady_state(s=
truct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 6)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 6)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_v13_0_wait_for_vmbx_ready(psp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return psp_v13_0_wait_for_bootloader(psp);<br>
@@ -728,7 +728,7 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct =
psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 10)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 10)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; reg_data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* MP1 fatal error: trigger PSP dram read to unhalt P=
SP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * during MP1 triggered sync flood.<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v13_0_4.c<br>
index d5ba58eba3e2..eaa5512a21da 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c<br>
@@ -40,7 +40,7 @@ static int psp_v13_0_4_init_microcode(struct psp_context =
*psp)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP0_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP0_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; err =3D psp_init_toc_microcode(psp, ucode_prefix);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (err)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index cd37f45e01a1..8562ac7f7ff0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -469,7 +469,7 @@ static int sdma_v4_0_irq_id_to_seq(unsigned client_id)<=
br>
&nbsp;<br>
&nbsp;static void sdma_v4_0_init_golden_registers(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_sdma_4,<br>
@@ -539,7 +539,7 @@ static void sdma_v4_0_setup_ulv(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The only chips wit=
h SDMAv4 and ULV are VG10 and VG20.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Server SKUs take a=
 different hysteresis setting from other SKUs.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;device =3D=3D 0x6860)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -578,8 +578,10 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, =
2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[SDMA0_HWIP][0=
] =3D=3D IP_VERSION(4, 4, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(4, 2, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, SDMA0_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(4, 4, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ac=
turus &amp; Aldebaran will leverage the same FW memory<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; for every SDMA instance */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_sdma_init_microcode(adev, 0, true);<br>
@@ -978,7 +980,8 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_d=
evice *adev, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Arcturus for the moment and firmware version =
14<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * and above.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, =
2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(4, 2, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.instance[i].fw_=
version &gt;=3D 14)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Extend page fault timeout to avoid interrupt storm=
 */<br>
@@ -1255,7 +1258,7 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;pg_flags &a=
mp; AMD_PG_SUPPORT_SDMA))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 2):<=
br>
@@ -1698,7 +1701,7 @@ static bool sdma_v4_0_fw_support_paging_queue(struct =
amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint fw_version =3D adev-&=
gt;sdma.instance[0].fw_version;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return fw_version &gt;=3D 430;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 1):<=
br>
@@ -1723,7 +1726,7 @@ static int sdma_v4_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: Page queue breaks=
 driver reload under SRIOV */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[SDMA0_HWIP]=
[0] =3D=3D IP_VERSION(4, 0, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, SDMA0_HW=
IP, 0) =3D=3D IP_VERSION(4, 0, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_sriov_vf((adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.has_page_queue =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (sdma_v4_0_fw_supp=
ort_paging_queue(adev))<br>
@@ -1823,7 +1826,9 @@ static int sdma_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * On Arcturus, SDMA instance 5~7 has a differen=
t vmhub<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * type(AMDGPU_MMHUB1).<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, =
2) &amp;&amp; i &gt;=3D 5)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(4, 2, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &gt;=3D 5)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB1(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB0(0);<br>
@@ -1843,8 +1848,10 @@ static int sdma_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* pa=
ging queue use same doorbell index/routing as gfx queue<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * with 0x400 (4096 dwords) offset on second doorbell page<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[SDMA0_HWIP][0] &gt;=3D IP_VERSION(4, 0, 0) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;ip_versions[SDMA0_HWIP][0] &lt; IP_VERSION(4, 2, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, SDMA0_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 0, 0)=
 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_ip_version(adev, SDMA0_HWIP, 0) &lt;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 2, 0)=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;doorbell_index =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_engine[i] &lt;&lt; 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;doorbell_index +=3D 0x4=
00;<br>
@@ -1856,7 +1863,9 @@ static int sdma_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (adev-&gt;doorbell_index.sdma_engine[i] + 1) &lt;&lt; 1;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) &amp;&amp; i &gt;=3D 5)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 2, 2)=
 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; i &gt;=3D 5)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;vm_hub =3D AMDGPU_MMHUB=
1(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;vm_hub =3D AMDGPU_MMHUB=
0(0);<br>
@@ -1890,8 +1899,8 @@ static int sdma_v4_0_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_ring_fini(&amp;adev-&gt;sdma.instance[i].page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][=
0] =3D=3D IP_VERSION(4, 2, 2) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&g=
t;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWI=
P, 0) =3D=3D IP_VERSION(4, 2, 2) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, SDMA0_HWIP, 0) =3D=3D IP_VERSION(4, 4, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_destroy_inst_ctx(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_destroy_inst_ctx(adev, false);<br>
@@ -2036,14 +2045,16 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_fence_process(&amp;adev-&gt;sdma.instance[inst=
ance].ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, =
0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 2, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_fence_process(&amp;adev-&gt;sdma.instance[instance].page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* XXX compute */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] !=3D IP_VERSION(4, 2, 0)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 2, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_fence_process(&amp;adev-&gt;sdma.instance[instance].page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2259,7 +2270,7 @@ static int sdma_v4_0_set_powergating_state(void *hand=
le,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 2):<=
br>
@@ -2622,7 +2633,7 @@ static struct amdgpu_sdma_ras sdma_v4_0_ras =3D {<br>
&nbsp;<br>
&nbsp;static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 2, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras =3D &amp;sdma_v4_0_ras;<br>
@@ -2633,7 +2644,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c<br>
index 267c1b7b8dcd..1cadd3cb26a9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c<br>
@@ -132,7 +132,8 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, =
2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 4, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D amdgpu_sdma_init_microcode(adev, 0, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
@@ -1231,7 +1232,7 @@ static void sdma_v4_4_2_ring_emit_reg_wait(struct amd=
gpu_ring *ring, uint32_t re<br>
&nbsp;<br>
&nbsp;static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device =
*adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 4, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
@@ -1401,7 +1402,7 @@ static int sdma_v4_4_2_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_ring_fini(&amp;adev-&gt;sdma.instance[i].page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[SDMA0_HWIP][=
0] =3D=3D IP_VERSION(4, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, SDMA0_HWI=
P, 0) =3D=3D IP_VERSION(4, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_destroy_inst_ctx(adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_sdma_destroy_inst_ctx(adev, false);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 1cc34efb455b..e0527e5ed7d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -184,7 +184,7 @@ static u32 sdma_v5_0_get_reg_offset(struct amdgpu_devic=
e *adev, u32 instance, u3<br>
&nbsp;<br>
&nbsp;static void sdma_v5_0_init_golden_registers(struct amdgpu_device *ade=
v)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soc15_program_register_sequence(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; golden_sett=
ings_sdma_5,<br>
@@ -1697,7 +1697,7 @@ static int sdma_v5_0_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 0, 5):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 2b3ebebc4299..0ccb7523bc55 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -1510,7 +1510,7 @@ static int sdma_v5_2_process_illegal_inst_irq(struct =
amdgpu_device *adev,<br>
&nbsp;static bool sdma_v5_2_firmware_mgcg_support(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int i)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;sdma.instance[i].fw_version &lt; 70)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
@@ -1575,8 +1575,9 @@ static void sdma_v5_2_update_medium_grain_light_sleep=
(struct amdgpu_device *adev<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;sdma.num_instances; i++) {<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;sdma.instance[i].fw_version &lt; 70 &amp;&amp; adev=
-&gt;ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(5, 2, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;sdma.instance[i].fw_version &lt; 70 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, SDMA0_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(5, 2, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;cg_flags &amp;=3D ~AMD_CG_SUPPORT_SDMA_LS;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; (adev-&gt;cg_flags &amp; AMD_CG=
_SUPPORT_SDMA_LS)) {<br>
@@ -1605,7 +1606,7 @@ static int sdma_v5_2_set_clockgating_state(void *hand=
le,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 1):<=
br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c<br>
index 0e25b6fb1340..4d6de77d289e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
@@ -1246,14 +1246,13 @@ static struct amdgpu_sdma_ras sdma_v6_0_3_ras =3D {=
<br>
&nbsp;<br>
&nbsp;static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[SDMA0_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, SDMA0=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras =3D &amp;sdma_v6_0_3_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int sdma_v6_0_early_init(void *handle)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/=
amd/amdgpu/sienna_cichlid.c<br>
index 07ded70f4df9..93f6772d1b24 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c<br>
@@ -36,7 +36,7 @@ static bool sienna_cichlid_is_mode2_default(struct amdgpu=
_reset_control *reset_c<br>
&nbsp;#if 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)reset_ctl-&gt;handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 7) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 7) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;pm.fw_version &gt;=3D 0x3a5500 &amp;&amp; !amdgpu_sriov_vf(adev))<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 9c72add6f93d..66ed28136bc8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -174,8 +174,8 @@ static const struct amdgpu_video_codecs vcn_4_0_3_video=
_codecs_encode =3D {<br>
&nbsp;static int soc15_query_video_codecs(struct amdgpu_device *adev, bool =
encode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const st=
ruct amdgpu_video_codecs **codecs)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[VCE_HWIP][0]=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[VCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, VCE_HWIP,=
 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, VCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 1, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e=
ncode)<br>
@@ -187,7 +187,7 @@ static int soc15_query_video_codecs(struct amdgpu_devic=
e *adev, bool encode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e=
ncode)<br>
@@ -324,12 +324,12 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reference_clock =3D ad=
ev-&gt;clock.spll.reference_freq;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(12, 0, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(12, 0, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(12, 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 10000;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(10, 0, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(10, 0, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(10, 0, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock;<br=
>
@@ -523,7 +523,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(12, 0, 0):=
<br>
@@ -599,7 +599,7 @@ static int soc15_asic_reset(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;static bool soc15_supports_baco(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_VEGA20) {<br>
@@ -938,7 +938,7 @@ static int soc15_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: split the GC and =
PG flags based on the relevant IP version for which<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * they are relevant.=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_funcs =3D &amp;soc15_asic_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_MGCG |<br>
@@ -1367,7 +1367,7 @@ static int soc15_common_set_clockgating_state(void *h=
andle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 2, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 4, 0):<=
br>
@@ -1423,8 +1423,7 @@ static void soc15_common_get_clockgating_state(void *=
handle, u64 *flags)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.funcs-&gt;get=
_clock_gating_state(adev, flags);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP0_HWIP][0]=
 !=3D IP_VERSION(13, 0, 2)) {<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP0_HWIP,=
 0) !=3D IP_VERSION(13, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* AMD_CG_SUPPORT_DRM_MGCG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_C=
GTT_CTRL0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!(data &amp; 0x01000000))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index 2ecc8c9a078b..92a80780ab72 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -153,7 +153,7 @@ static int soc21_query_video_codecs(struct amdgpu_devic=
e *adev, bool encode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.num_vcn_i=
nst =3D=3D hweight8(adev-&gt;vcn.harvest_config))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[UVD_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, UVD_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 4):<=
br>
@@ -374,7 +374,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Specified reset method:%=
d isn't supported, using AUTO instead.\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_method)=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10)=
:<br>
@@ -448,7 +448,7 @@ const struct amdgpu_ip_block_version soc21_common_ip_bl=
ock =3D {<br>
&nbsp;<br>
&nbsp;static bool soc21_need_full_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK=
__UMC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 2):=
<br>
@@ -577,7 +577,7 @@ static int soc21_common_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;rev_id =3D amdgpu=
_device_get_rev_id(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =
=3D 0xff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP]=
[0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HW=
IP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGLS |<br>
@@ -843,7 +843,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[NBIO_HWI=
P][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, NBIO_=
HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 3, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 3, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 7, 0):<=
br>
@@ -865,7 +865,7 @@ static int soc21_common_set_powergating_state(void *han=
dle,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[LSDMA_HW=
IP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, LSDMA=
_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(6, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;lsdma.funcs-&gt;update_memory_power_gating(a=
dev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c<br>
index 67164991f541..99713949b61f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c<br>
@@ -273,14 +273,15 @@ static int umsch_mm_v4_0_set_hw_resources(struct amdg=
pu_umsch_mm *umsch)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(set_hw_resources.mm=
hub_base, adev-&gt;reg_offset[MMHUB_HWIP][0],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sizeof(uint32_t) * 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.mmhub_version =3D ad=
ev-&gt;ip_versions[MMHUB_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.mmhub_version =3D am=
dgpu_ip_version(adev, MMHUB_HWIP, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(set_hw_resources.os=
ssys_base, adev-&gt;reg_offset[OSSSYS_HWIP][0],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sizeof(uint32_t) * 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.osssys_version =3D a=
dev-&gt;ip_versions[OSSSYS_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.osssys_version =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ip_version(adev, OSSSYS_HWIP, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vcn_version =3D adev=
-&gt;ip_versions[VCN_HWIP][0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vpe_version =3D adev=
-&gt;ip_versions[VPE_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vcn_version =3D amdg=
pu_ip_version(adev, VCN_HWIP, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.vpe_version =3D amdg=
pu_ip_version(adev, VPE_HWIP, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.api_statu=
s.api_completion_fence_addr =3D umsch-&gt;ring.fence_drv.gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_hw_resources.api_statu=
s.api_completion_fence_value =3D ++umsch-&gt;ring.fence_drv.sync_seq;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c<br>
index 6fbea38f4d3e..aba403d71806 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
@@ -187,7 +187,7 @@ static int vcn_v2_5_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;doorbell_index =3D (adev-&gt;doorbell_index.=
vcn.vcn_ring0_1 &lt;&lt; 1) +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_sriov_vf(adev) ? 2*j : 8=
*j);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(2, 5, 0)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(2, 5,=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB1(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;vm_hub =3D AMDGPU_MMHUB0(0);<br>
@@ -207,7 +207,8 @@ static int vcn_v2_5_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-=
&gt;doorbell_index =3D (adev-&gt;doorbell_index.vcn.vcn_ring0_1 &lt;&lt; 1)=
 +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) : (2 + i + 8*j));<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[UVD_HWIP][0] =3D=3D IP_VERSION(2, 5, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, UVD_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(2, 5, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;vm_hub =3D AMDGPU_MMHUB=
1(0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;vm_hub =3D AMDGPU_MMHUB=
0(0);<br>
@@ -794,7 +795,7 @@ static void vcn_v2_6_enable_ras(struct amdgpu_device *a=
dev, int inst_idx,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0]=
 !=3D IP_VERSION(2, 6, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP,=
 0) !=3D IP_VERSION(2, 6, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D VCN_RAS_CNTL__VCPU=
_VCODEC_REARM_MASK |<br>
@@ -1985,7 +1986,7 @@ static struct amdgpu_vcn_ras vcn_v2_6_ras =3D {<br>
&nbsp;<br>
&nbsp;static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VCN_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VCN_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 6, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.ras =3D &amp;vcn_v2_6_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index a61ecefdafc5..e02af4de521c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -100,7 +100,8 @@ static int vcn_v3_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bo=
th instances are harvested, disable the block */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOENT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 0, 33=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(3, 0, 33))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;vcn.num_enc_rings =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;vcn.num_enc_rings =3D 2;<br>
@@ -227,9 +228,10 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_FW_SHA=
RED_FLAG_0_RB);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;sw_ring.is_enabled =3D cpu_to_le32(DEC_=
SW_RING_ENABLED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;present_flag_0 |=3D AMDGPU_VCN_SMU_VERS=
ION_INFO_FLAG;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 1, 2)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(3, 1,=
 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_sh=
ared-&gt;smu_interface_info.smu_interface_type =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, =
1, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION=
(3, 1, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_sh=
ared-&gt;smu_interface_info.smu_interface_type =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_vcnfw_log)<br>
@@ -1255,7 +1257,8 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bits(ring-&gt;wptr=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.decode_queue_mode &amp;=3D =
cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] !=3D IP_VERSION(3, 0, 33))=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(3, 0, 33)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_sh=
ared-&gt;multi_queue.encode_generalpurpose_queue_mode |=3D cpu_to_le32(FW_Q=
UEUE_RING_RESET);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =
=3D &amp;adev-&gt;vcn.inst[i].ring_enc[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));<br>
@@ -1628,7 +1631,8 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[UVD_HWIP][0] !=3D =
IP_VERSION(3, 0, 33)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(3, 0, 33=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Restore */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; fw_shared =3D adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_add=
r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode =
|=3D cpu_to_le32(FW_QUEUE_RING_RESET);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c<br>
index ae8db12d8832..96831f931423 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
@@ -169,7 +169,8 @@ static int vcn_v4_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;smu_dpm_interface.smu_interface_type =
=3D (adev-&gt;flags &amp; AMD_IS_APU) ?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGP=
U_VCN_SMU_DPM_INTERFACE_APU : AMDGPU_VCN_SMU_DPM_INTERFACE_DGPU;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 2)=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(4, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_sh=
ared-&gt;present_flag_0 |=3D AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_sh=
ared-&gt;drm_key_wa.method =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DRM_KEY_INJECT_WORKAROUND=
_VCNFW_ASD_HANDSHAKING;<br>
@@ -1852,7 +1853,7 @@ static void vcn_v4_0_set_unified_ring_funcs(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[VCN_HWIP][0] =3D=3D IP_VERSION(4, 0, 2)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSION(4, 0,=
 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v=
4_0_unified_ring_vm_funcs.secure_submission_supported =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.inst[i].ring_enc[0].funcs =3D<br>
@@ -2159,7 +2160,7 @@ static struct amdgpu_vcn_ras vcn_v4_0_ras =3D {<br>
&nbsp;<br>
&nbsp;static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[VCN_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, VCN_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;vcn.ras =3D &amp;vcn_v4_0_ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega20_ih.c<br>
index dbc99536440f..ddfc6941f9d5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c<br>
@@ -291,7 +291,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;ih=
_control(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[OSSSYS_HWIP=
][0] =3D=3D IP_VERSION(4, 2, 1)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, OSSSYS_H=
WIP, 0) =3D=3D IP_VERSION(4, 2, 1)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih.use_bus_addr) {<br>
@@ -304,8 +304,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* psp firmware won't prog=
ram IH_CHICKEN for aldebaran<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * driver needs to pr=
ogram it properly according to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MC_SPACE type in I=
H_RB_CNTL */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[OSSSYS_HWIP=
][0] =3D=3D IP_VERSION(4, 4, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, OSSSYS_H=
WIP, 0) =3D=3D IP_VERSION(4, 4, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4, 2))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_A=
LDEBARAN);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih.use_bus_addr) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_ch=
icken =3D REG_SET_FIELD(ih_chicken, IH_CHICKEN,<br>
@@ -334,8 +334,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega20_setup_retry_doorbell(adev-&gt;irq.retry_cam_do=
orbell_index));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable IH Retry CAM */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[OSSSYS_HWIP]=
[0] =3D=3D IP_VERSION(4, 4, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, OSSSYS_HW=
IP, 0) =3D=3D IP_VERSION(4, 4, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4, 2))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEB=
ARAN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -537,7 +537,7 @@ static int vega20_ih_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;flags &amp; =
AMD_IS_APU) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 2)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(4, 4, 2)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; use_bus_addr =3D false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ih_ring_init(=
adev, &amp;adev-&gt;irq.ih, IH_RING_SIZE, use_bus_addr);<br>
@@ -554,7 +554,7 @@ static int vega20_ih_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih1.use_doorb=
ell =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih1.doorbell_=
index =3D (adev-&gt;doorbell_index.ih + 1) &lt;&lt; 1;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[OSSSYS_HWIP]=
[0] !=3D IP_VERSION(4, 4, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, OSSSYS_HW=
IP, 0) !=3D IP_VERSION(4, 4, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ih_ring_init(adev, &amp;adev-&gt;irq.ih2=
, PAGE_SIZE, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index ab4a63bb3e3e..0a9cf9dfc224 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -65,7 +65,7 @@ static int kfd_resume(struct kfd_node *kfd);<br>
&nbsp;<br>
&nbsp;static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_version =3D kfd-&gt;ade=
v-&gt;ip_versions[SDMA0_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_version =3D amdgpu_ip_v=
ersion(kfd-&gt;adev, SDMA0_HWIP, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sdma_version) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(4, 0, 0):/=
* VEGA10 */<br>
@@ -282,7 +282,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f2g =
=3D &amp;gfx_v8_kfd2kgd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Vega 10 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_t=
arget_version =3D 90000;<br>
@@ -427,9 +427,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ad=
ev, bool vf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f2g) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0])<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(kfd_devi=
ce, &quot;GC IP %06x %s not supported in kfd\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[GC_HWIP][0], vf ? &quo=
t;VF&quot; : &quot;&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(kfd_devi=
ce,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GC IP %06x %s not supported in kfd\n&=
quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, GC_HWIP, 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vf ? &quot;VF&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(kfd_device, &quot;%s %s not supported in kfd\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_name[adev-&gt;asic_t=
ype], vf ? &quot;VF&quot; : &quot;&quot;);<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c<br>
index 7d82c7da223a..192b0d106413 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
@@ -1001,7 +1001,7 @@ int kgd2kfd_init_zone_device(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Page migration works on=
 gfx9 or newer */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&lt; IP_VERSION(9, 0, 1))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &lt; IP_VERSION(9, 0, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.is_app_ap=
u)<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
index 1a03173e2313..8ee2bedd301a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
@@ -205,7 +205,8 @@ static int pm_set_resources_v9(struct packet_manager *p=
m, uint32_t *buffer,<br>
&nbsp;<br>
&nbsp;static inline bool pm_use_ext_eng(struct kfd_dev *dev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dev-&gt;adev-&gt;ip_versions[S=
DMA0_HWIP][0] &gt;=3D IP_VERSION(5, 2, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ip_version(dev-&gt;adev=
, SDMA0_HWIP, 0) &gt;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; IP_VERSION(5, 2, 0);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buff=
er,<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index b315311dfe2a..ae8e6ce9436d 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -202,7 +202,7 @@ enum cache_policy {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cache_policy_noncoherent<b=
r>
&nbsp;};<br>
&nbsp;<br>
-#define KFD_GC_VERSION(dev) ((dev)-&gt;adev-&gt;ip_versions[GC_HWIP][0])<b=
r>
+#define KFD_GC_VERSION(dev) (amdgpu_ip_version((dev)-&gt;adev, GC_HWIP, 0)=
)<br>
&nbsp;#define KFD_IS_SOC15(dev)&nbsp;&nbsp; ((KFD_GC_VERSION(dev)) &gt;=3D =
(IP_VERSION(9, 0, 1)))<br>
&nbsp;#define KFD_SUPPORT_XNACK_PER_PROCESS(dev)\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((KFD_GC_VERSION(dev) =3D=
=3D IP_VERSION(9, 4, 2)) ||&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 841ba6102bbb..c8abe7118907 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -1194,7 +1194,7 @@ svm_range_get_pte_flags(struct kfd_node *node,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D SVM_RANG=
E_VRAM_DOMAIN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo_node =3D prange-&gt;svm_bo-&gt;node;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (node-&gt;adev-&gt;ip_versions=
[GC_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(node-&gt;ad=
ev, GC_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (b=
o_node =3D=3D node) {<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 5efebc06296b..933c9b5d5252 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1173,7 +1173,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; fb_in=
fo-&gt;num_fb; ++i)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hw_params.fb[i] =3D &amp;fb_info-&gt;fb[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 3):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 5, 0):<=
br>
@@ -1606,7 +1606,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_data.dce_environment =
=3D DCE_ENV_PRODUCTION_DRV;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;dm.dmcub_fw_version) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0: /* development */<br>
@@ -1631,7 +1631,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; init_data.flags.gpu_vm_support =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* en=
able S/G on PCO and RV2 */<br>
@@ -2015,7 +2015,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<br>
@@ -2105,7 +2105,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dmub_status status;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dmub_asic =3D DMUB_ASIC_DCN21;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -2477,7 +2477,7 @@ static int amdgpu_dm_smu_write_watermarks_table(struc=
t amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * therefore, this fu=
nction apply to navi10/12/14 but not Renoir<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -4429,7 +4429,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use Outbox interrupt */=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 2):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 3):<=
br>
@@ -4447,12 +4447,12 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_KMS(&quot;Unsupported DCN IP version for ou=
tbox: 0x%X\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[DCE_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_ip_version(adev, DCE_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine whether to en=
able PSR support by default. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask=
 &amp; DC_DISABLE_PSR)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
@@ -4470,7 +4470,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(amdgpu_dc_debug_mask=
 &amp; DC_DISABLE_REPLAY)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 5):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 1, 6):<br>
@@ -4589,7 +4589,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
@@ -4615,7 +4615,7 @@ static int amdgpu_dm_initialize_drm_device(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Unsupported DCE IP versions: 0x%X\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;ip_versions[DCE_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, DCE_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -4698,14 +4698,14 @@ static int dm_init_microcode(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *fw_name_dmub;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 1, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_name_dmub =3D FIRMWARE_RENOIR_DMUB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ASICREV_IS_GREEN_SARDINE(adev-&gt;external_rev_id=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_na=
me_dmub =3D FIRMWARE_GREEN_SARDINE_DMUB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 0)=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10, 3,=
 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_na=
me_dmub =3D FIRMWARE_SIENNA_CICHLID_DMUB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_na=
me_dmub =3D FIRMWARE_NAVY_FLOUNDER_DMUB;<br>
@@ -4835,7 +4835,7 @@ static int dm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(2, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-=
&gt;mode_info.num_crtc =3D 6;<br>
@@ -4872,7 +4872,7 @@ static int dm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Unsupported DCE IP versions: 0x%x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;ip_versions[DCE_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, DCE_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -11006,7 +11006,7 @@ int amdgpu_dm_process_dmub_set_config_sync(<br>
&nbsp; */<br>
&nbsp;bool check_seamless_boot_capability(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[DCE_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, DCE_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.keep_stolen_vga_memory)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n true;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
index b97cbc4e5477..8038fe3d193e 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c<br>
@@ -226,7 +226,7 @@ static void fill_gfx9_tiling_info_from_device(const str=
uct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.num_r=
b_per_se =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.config.gb_addr_config_fields.num_rb_per_=
se;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.shade=
rEnable =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(10, 3, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tiling_info-&gt;gfx9.num_pkrs =3D adev-&gt;gfx.config=
.gb_addr_config_fields.num_pkrs;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -669,7 +669,7 @@ static int get_plane_modifiers(struct amdgpu_device *ad=
ev, unsigned int plane_ty<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_YC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_GC_10_3=
_6:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_FAMILY_GC_10_3=
_7:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] &gt;=3D IP_VERSION(10, 3, 0=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=3D IP_VERSION(10, 3=
, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_g=
fx10_3_modifiers(adev, mods, &amp;size, &amp;capacity);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_g=
fx10_1_modifiers(adev, mods, &amp;size, &amp;capacity);<br>
@@ -1069,8 +1069,8 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is to gesture the =
YouTube Android app into full screen<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on ChromeOS.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;ip_versions[DCE_HWIP][=
0] =3D=3D IP_VERSION(1, 0, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[DCE_HWIP][0] =3D=3D IP_VERSION(1, 0, 1))) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((amdgpu_ip_version(adev, DCE_HWI=
P, 0) =3D=3D IP_VERSION(1, 0, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(1, 0, 1))) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s=
tate-&gt;fb &amp;&amp; state-&gt;fb-&gt;format-&gt;format =3D=3D DRM_FORMAT=
_NV12 &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s=
caling_info-&gt;src_rect.x !=3D 0 || scaling_info-&gt;src_rect.y !=3D 0)))<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -1509,7 +1509,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manage=
r *dm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_plane_create_rotation_property(plane, DRM_MODE_RO=
TATE_0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; supported_rotations);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dm-&gt;adev-&gt;ip_versions[DCE_H=
WIP][0] &gt; IP_VERSION(3, 0, 1) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(dm-&gt;adev, DC=
E_HWIP, 0) &gt; IP_VERSION(3, 0, 1) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pl=
ane-&gt;type !=3D DRM_PLANE_TYPE_CURSOR)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_plane_enable_fb_damage_clips(plane);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 84e1af6a6ce7..e789a48089ad 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2024,8 +2024,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask, enum amdgpu_device_attr=
_states *states)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *d=
ev_attr =3D &amp;attr-&gt;dev_attr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D adev-&gt;ip_vers=
ions[MP1_HWIP][0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D amdgpu_ip_versio=
n(adev, MP1_HWIP, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D amdgpu_ip_version=
(adev, GC_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *attr_name =3D =
dev_attr-&gt;attr.name;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(attr-&gt;flags &amp;=
 mask)) {<br>
@@ -2917,7 +2917,7 @@ static ssize_t amdgpu_hwmon_show_power_label(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D amdgpu_ip_version=
(adev, GC_HWIP, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver =3D=3D IP_VERSI=
ON(10, 3, 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return sysfs_emit(buf, &quot;%s\n&quot;,<br>
@@ -3205,7 +3205,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev =3D kob=
j_to_dev(kobj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umode_t effective_mode =3D=
 attr-&gt;mode;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D amdgpu_ip_version=
(adev, GC_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* under multi-vf mode, th=
e hwmon attributes are all not supported */<br>
@@ -4158,8 +4158,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq=
_file *m,<br>
&nbsp;<br>
&nbsp;static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgp=
u_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D adev-&gt;ip_vers=
ions[MP1_HWIP][0];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D adev-&gt;ip_versi=
ons[GC_HWIP][0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_ver =3D amdgpu_ip_versio=
n(adev, MP1_HWIP, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gc_ver =3D amdgpu_ip_version=
(adev, GC_HWIP, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t value64 =3D 0;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t query =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index ed23d7de3f28..e6f1620acdd4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -485,7 +485,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=
=3D CHIP_VEGA20)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 &gt;=3D IP_VERSION(11, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) &gt;=3D IP_VERSION(11, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
@@ -603,7 +603,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.pp_feature=
 &amp; PP_OVERDRIVE_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;od_enabled =3D true;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
@@ -775,8 +775,8 @@ static int smu_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0=
] =3D=3D IP_VERSION(13, 0, 1)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 3)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP=
, 0) =3D=3D IP_VERSION(13, 0, 1)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 3)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 || smu-&gt;od_enabled) {<br>
@@ -1259,7 +1259,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_supporte=
d;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 11)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 5, 0):=
<br>
@@ -1449,7 +1449,7 @@ static int smu_start_smc_engine(struct smu_context *s=
mu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type !=3D AMDGPU_FW_LOAD_PSP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] &lt; IP_VERSION(11, 0, 0))=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP, 0) &lt; IP_VERSION(11, 0, =
0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s=
mu-&gt;ppt_funcs-&gt;load_microcode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;lo=
ad_microcode(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1549,7 +1549,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For SMU 13.0.0 and=
 13.0.7, PMFW will handle the DPM features(disablement or others)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * properly on suspen=
d/reset/unload. Driver involvement may cause some unexpected issues.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10)=
:<br>
@@ -1570,7 +1570,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;&nbsp;&=
nbsp; properly.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;uploading_cust=
om_pp_table) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):<br>
@@ -1590,7 +1590,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on BACO in. Driver=
 involvement is unnecessary.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_baco) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):<br>
@@ -1607,7 +1607,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for gpu reset and =
S0i3 cases. Driver involvement is unnecessary.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev) =
|| adev-&gt;in_s0ix) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 11):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
@@ -1634,7 +1634,7 @@ static int smu_disable_dpms(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =
&gt;=3D IP_VERSION(9, 4, 2) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, =
0) &gt;=3D IP_VERSION(9, 4, 2) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !a=
mdgpu_sriov_vf(adev) &amp;&amp; adev-&gt;gfx.rlc.funcs-&gt;stop)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;stop(adev);<br>
&nbsp;<br>
@@ -2391,7 +2391,7 @@ int smu_get_power_limit(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (limit_level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_PPT_LIMIT_CURRENT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt=
;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_i=
p_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(13, 0, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(11, 0, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =
IP_VERSION(11, 0, 11):<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 18487ae10bcf..650482cedd1f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -345,8 +345,8 @@ navi10_get_allowed_feature_mask(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DPM UCLK enablement sho=
uld be skipped for navi10 A0 secure board */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(is_asic_secure(smu) =
&amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;rev_id =3D=3D 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
adev-&gt;rev_id =3D=3D 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;pm.pp_feature &amp; PP_MCLK_DPM_MASK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_D=
PM_UCLK_BIT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | FEATURE_MASK(FEATURE_MEM_VDDCI=
_SCALING_BIT)<br>
@@ -354,7 +354,7 @@ navi10_get_allowed_feature_mask(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DS SOCCLK enablement sh=
ould be skipped for navi10 A0 secure board */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_asic_secure(smu) &a=
mp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (a=
dev-&gt;rev_id =3D=3D 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask &amp;=3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~FEATURE_MASK(FEATURE_DS_SOCCLK_=
BIT);<br>
@@ -916,7 +916,7 @@ static int navi1x_get_smu_metrics_data(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu_version &gt; 0x00341C00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi12_get_smu_metrics_data(smu, member, value);<br>
@@ -926,8 +926,12 @@ static int navi1x_get_smu_metrics_data(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,=
 5)) &amp;&amp; smu_version &gt; 0x00351F00) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;ip_versions[MP1_H=
WIP][0] =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp; smu_version &gt; 0x002A3B00=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 5)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &gt; 0x00351F00) ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 0)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &gt; 0x002A3B00))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi10_get_smu_metrics_data(smu, member, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi10_get_legacy_smu_metrics_data(smu, member, value);<br>
@@ -1712,7 +1716,7 @@ static int navi10_populate_umd_state_clk(struct smu_c=
ontext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_freq;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_ps=
tate.min =3D gfx_table-&gt;min;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;pdev-&gt;revision) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case 0xf0: /* XTX */<br>
@@ -2754,8 +2758,8 @@ static bool navi10_need_umc_cdr_workaround(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_cmn_feature_is_en=
abled(smu, SMU_FEATURE_DPM_UCLK_BIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 5))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 5))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
@@ -2863,8 +2867,10 @@ static int navi10_run_umc_cdr_workaround(struct smu_=
context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - PPSMC_MSG_SetDri=
verDummyTableDramAddrLow<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - PPSMC_MSG_GetUMC=
FWWA<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][=
0] =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp; (pmfw_version &gt;=3D 0x2a3500))=
 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;ip=
_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 5)) &amp;&amp; (pmfw_versio=
n &gt;=3D 0x351D00))) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((amdgpu_ip_version(adev, MP1_HWI=
P, 0) =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pmfw_v=
ersion &gt;=3D 0x2a3500)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_v=
ersion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 5)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (pmfw_v=
ersion &gt;=3D 0x351D00))) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_param(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_GET_UMC_FW_WA,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
@@ -2883,13 +2889,15 @@ static int navi10_run_umc_cdr_workaround(struct smu=
_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (umc_fw_disable_cdr) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_=
versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; IP_VERSION(11, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return navi10_umc_hybrid_cdr_wor=
karound(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n navi10_set_dummy_pstates_table_location(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 0=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n navi10_umc_hybrid_cdr_workaround(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -3356,7 +3364,7 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu_version &gt; 0x00341C00)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi12_get_gpu_metrics(smu, table);<br>
@@ -3366,8 +3374,12 @@ static ssize_t navi1x_get_gpu_metrics(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,=
 5)) &amp;&amp; smu_version &gt; 0x00351F00) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;ip_versions[MP1_H=
WIP][0] =3D=3D IP_VERSION(11, 0, 0)) &amp;&amp; smu_version &gt; 0x002A3B00=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 5)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &gt; 0x00351F00) ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 0)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_version &gt; 0x002A3B00))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi10_get_gpu_metrics(smu, table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D navi10_get_legacy_gpu_metrics(smu, table);<br>
@@ -3385,7 +3397,7 @@ static int navi10_enable_mgpu_fan_boost(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Navi12 does not support=
 this */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 9))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 9))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
index 4bb289f9b4b8..164c2264027d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
@@ -73,12 +73,16 @@<br>
&nbsp;<br>
&nbsp;#define SMU_11_0_7_GFX_BUSY_THRESHOLD 15<br>
&nbsp;<br>
-#define GET_PPTABLE_MEMBER(field, member) do {\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*member) =3D (smu-&gt;smu_table.driver_pptable + offsetof(PPTab=
le_beige_goby_t, field));\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (*member) =3D (smu-&gt;smu_table.driver_pptable + offsetof(PPTab=
le_t, field));\<br>
-} while(0)<br>
+#define GET_PPTABLE_MEMBER(field, member)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, MP1_HWIP, 0) =3D=3D&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 13))&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*member) =3D (s=
mu-&gt;smu_table.driver_pptable +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(PPTa=
ble_beige_goby_t, field)); \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*member) =3D (s=
mu-&gt;smu_table.driver_pptable +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(PPTa=
ble_t, field));&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
&nbsp;/* STB FIFO depth is in 64bit units */<br>
&nbsp;#define SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES 8<br>
@@ -91,7 +95,7 @@<br>
&nbsp;<br>
&nbsp;static int get_table_size(struct smu_context *smu)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 13))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return sizeof(PPTable_beige_goby_t);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return sizeof(PPTable_t);<br>
@@ -309,7 +313,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;pm.pp_featur=
e &amp; PP_GFX_DCS_MASK) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP1_HWIP][0] &gt; IP_VERSION(11, 0, 7)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) &gt; IP_VERSION(11, 0, 7)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(=
adev-&gt;flags &amp; AMD_IS_APU))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint64_t *)feature_mask |=3D FEATURE_MASK(FEATURE_G=
FX_DCS_BIT);<br>
&nbsp;<br>
@@ -434,7 +438,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_beige_goby_t *ppt_=
beige_goby;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *ppt;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 13))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ppt_beige_goby =3D smu-&gt;smu_table.driver_pptable;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ppt =3D smu-&gt;smu_table.driver_pptable;<br>
@@ -447,7 +451,7 @@ static int sienna_cichlid_append_powerplay_table(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 13))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_memcpy_trailing(ppt_beige_goby, I2cControllers, B=
oardReserved,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc_dpm_=
table, I2cControllers);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -725,7 +729,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct s=
mu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t apu_percent =3D 0=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dgpu_percent =3D =
0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;ip_versions[=
MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(smu-&gt;ade=
v, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &gt;=3D 0x3A4900)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_m=
etrics_v3 =3D true;<br>
@@ -1385,8 +1389,9 @@ static int sienna_cichlid_print_clk_levels(struct smu=
_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * and onwards SMU firmwares.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &amp;smu_version);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, =
7)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_version &lt; 0x003a2900))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 7)) &amp;&amp;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_version &lt; 0x003a2900))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, size, &quot;OD_VDDGFX_OF=
FSET:\n&quot;);<br>
@@ -1494,7 +1499,7 @@ static int sienna_cichlid_populate_umd_state_clk(stru=
ct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.min =3D soc_table-&gt;min;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;socclk_ps=
tate.peak =3D soc_table-&gt;max;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 11)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pstate_table-&gt;gfxclk_pstate.standard =3D SIENNA_CI=
CHLID_UMD_PSTATE_PROFILING_GFXCLK;<br>
@@ -1945,7 +1950,8 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_SS_A=
PU_SHARE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 7)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D sienna_cichlid_get_smu_metrics_data(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; METRICS_SS_=
APU_SHARE, (uint32_t *)data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size=
 =3D 4;<br>
@@ -1954,7 +1960,8 @@ static int sienna_cichlid_read_sensor(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_SS_D=
GPU_SHARE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))=
 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 7)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =
=3D sienna_cichlid_get_smu_metrics_data(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; METRICS_SS_=
DGPU_SHARE, (uint32_t *)data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size=
 =3D 4;<br>
@@ -1978,7 +1985,7 @@ static void sienna_cichlid_get_unique_id(struct smu_c=
ontext *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only supported as of ve=
rsion 0.58.83.0 and only on Sienna Cichlid */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version=
 &lt; 0x3A5300 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev-=
&gt;ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(smu-&gt;adev, MP1_HWIP, 0) !=3D IP_VERSION(11, 0, 7))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sienna_cichlid_get_smu=
_metrics_data(smu, METRICS_UNIQUE_ID_UPPER32, &amp;upper32))<br>
@@ -2148,8 +2155,8 @@ static void sienna_cichlid_dump_od_table(struct smu_c=
ontext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;UclkFmax);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(sm=
u, NULL, &amp;smu_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((adev-&gt;ip_versions[MP1_HWIP]=
[0] =3D=3D IP_VERSION(11, 0, 7)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (smu_version &lt; 0x003a2900)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((amdgpu_ip_version(adev, MP1_HW=
IP, 0) =3D=3D IP_VERSION(11, 0, 7)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
smu_version &lt; 0x003a2900)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;adev-&gt;dev, &quot;OD: VddGfxOffset:=
 %d\n&quot;, od_table-&gt;VddGfxOffset);<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2381,8 +2388,9 @@ static int sienna_cichlid_od_edit_dpm_table(struct sm=
u_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * and onwards SMU firmwares.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_cmn_get_smc_version(smu, NULL, &amp;smu_version);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, =
7)) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_version &lt; 0x003a2900)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 7)) &amp;&amp;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu_version &lt; 0x003a2900)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(smu-&gt;adev-&gt;dev, &quot;OD GFX Voltage offset functionality is suppo=
rted &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;only =
by 58.41.0 and onwards SMU firmwares!\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EOPNOTSUPP;<br>
@@ -3105,7 +3113,8 @@ static void sienna_cichlid_dump_pptable(struct smu_co=
ntext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *pptable =3D tab=
le_context-&gt;driver_pptable;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(11, 0, 13)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11=
, 0, 13)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; beige_goby_dump_pptable(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -3910,7 +3919,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct =
smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t average_gfx_activ=
ity;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;ip_versions[=
MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(smu-&gt;ade=
v, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (smu-&gt;smc_fw_version &gt;=3D 0x3A4900)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_m=
etrics_v3 =3D true;<br>
@@ -4026,8 +4035,10 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct=
 smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;current_fa=
n_speed =3D use_metrics_v3 ? metrics_v3-&gt;CurrFanSpeed :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; use_metrics_v2 ? metrics_v2-&gt;CurrFanSpeed : metric=
s-&gt;CurrFanSpeed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][=
0] =3D=3D IP_VERSION(11, 0, 7)) &amp;&amp; smu-&gt;smc_fw_version &gt; 0x00=
3A1E00) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (=
(adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 11)) &amp;&amp;=
 smu-&gt;smc_fw_version &gt; 0x00410400)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((amdgpu_ip_version(adev, MP1_HWI=
P, 0) =3D=3D IP_VERSION(11, 0, 7)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;smc_fw_version &gt; 0x003A1E00) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_v=
ersion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 11)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt=
;smc_fw_version &gt; 0x00410400)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_width =3D use_metrics_v3 ? =
metrics_v3-&gt;PcieWidth :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; use_m=
etrics_v2 ? metrics_v2-&gt;PcieWidth : metrics-&gt;PcieWidth;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gpu_metrics-&gt;pcie_link_speed =3D link_speed[use_me=
trics_v3 ? metrics_v3-&gt;PcieRate :<br>
@@ -4253,7 +4264,7 @@ static int sienna_cichlid_get_default_config_table_se=
ttings(struct smu_context *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;gfx_activity_ave=
rage_tau =3D 10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;mem_activity_ave=
rage_tau =3D 10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table-&gt;socket_power_ave=
rage_tau =3D 100;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 !=3D IP_VERSION(11, 0, 7))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) !=3D IP_VERSION(11, 0, 7))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; table-&gt;apu_socket_power_average_tau =3D 100;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index aa4a5498a12f..ece43b41141c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -101,8 +101,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *ucode =3D NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
&amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;ip=
_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 9)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&=
gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7))))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_v=
ersion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 9)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu=
_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 7))))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_ip_version_de=
code(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));<br>
@@ -213,7 +213,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version =3D smu_version;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU11_DRIVER_IF_VER=
SION_NV10;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -246,7 +246,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;smu unsupported I=
P version: 0x%x.\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_vers=
ions[MP1_HWIP][0]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_versio=
n(adev, MP1_HWIP, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU11_DRIVER_IF_VER=
SION_INV;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -474,9 +474,10 @@ int smu_v11_0_init_power(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_power_context *=
smu_power =3D &amp;smu-&gt;smu_power;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D adev-&gt;ip_versions[=
MP1_HWIP][0] =3D=3D IP_VERSION(11, 5, 0) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct sm=
u_11_5_power_context) :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct sm=
u_11_0_power_context);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D amdgpu_ip_version(ade=
v, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERS=
ION(11, 5, 0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sizeof(struct smu_11_5_power_context) :<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sizeof(struct smu_11_0_power_context);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_power-&gt;power_contex=
t =3D kzalloc(size, GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_power-&gt;power_c=
ontext)<br>
@@ -731,10 +732,10 @@ int smu_v11_0_init_display_count(struct smu_context *=
smu, uint32_t count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Navy_Flounder/Dimgrey_C=
avefish do not support to change<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * display num curren=
tly<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 11) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 5, 0) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 12) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 13))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 11) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 5, 0) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 12) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 13))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_ms=
g_with_param(smu,<br>
@@ -1103,7 +1104,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu=
, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 5):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
@@ -1591,7 +1592,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu,=
 enum smu_baco_state state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D SMU_BACO_=
STATE_ENTER) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 11):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 12):<br>
@@ -1610,7 +1611,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu,=
 enum smu_baco_state state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!=
ras || !adev-&gt;ras_enabled ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.pending_reset) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0] =3D=
=3D IP_VERSION(11, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(11, 0, 2=
)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data =3D RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; data |=3D 0x80000000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT, data);<br>
@@ -1894,7 +1896,7 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Separate MCLK and =
SOCCLK soft min/max settings are not allowed<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * on Arcturus.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(11, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(11, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mclk_min =3D mclk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_min =3D socclk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
index c8119491c516..8908bbb3ff1f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c<br>
@@ -1198,8 +1198,12 @@ static int renoir_get_smu_metrics_data(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *value =3D metrics-&gt;AverageUvdActivity / 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case METRICS_CURR_SOCKETPO=
WER:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0,=
 1)) &amp;&amp; (adev-&gt;pm.fw_version &gt;=3D 0x40000f)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((adev-&gt;ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0))=
 &amp;&amp; (adev-&gt;pm.fw_version &gt;=3D 0x373200)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (((amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(12, 0, 1)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pm.fw_version &gt;=3D 0x=
40000f)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((amdgpu_ip_version(adev, MP1_HWIP, 0) =
=3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IP_VERSION(12, 0, 0)) &amp;&=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pm.fw_version &gt;=3D 0x=
373200)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *valu=
e =3D metrics-&gt;CurrentSocketPower &lt;&lt; 8;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *valu=
e =3D (metrics-&gt;CurrentSocketPower &lt;&lt; 8) / 1000;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index fd1798fd716e..d86499ac8931 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -196,9 +196,9 @@ int smu_v13_0_init_pptable_microcode(struct smu_context=
 *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;scpm_enabled=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0=
] =3D=3D IP_VERSION(13, 0, 7)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 0)) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_=
versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 10)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP=
, 0) =3D=3D IP_VERSION(13, 0, 7)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 0)) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_ve=
rsion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 10)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* override pptable_id fro=
m driver parameter */<br>
@@ -234,7 +234,7 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 4):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 11)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D RREG32_PCIE(MP1_Public |<br>
@@ -269,7 +269,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_minor =3D (smu_version=
 &gt;&gt; 8) &amp; 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_debug =3D (smu_version=
 &gt;&gt; 0) &amp; 0xff;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;is_apu ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_v=
ersions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_ver=
sion(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version =3D smu_version;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only for dGPU w/ SMU13*=
/<br>
@@ -802,7 +802,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 1):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 3):=
<br>
@@ -1779,7 +1779,7 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Unset those settin=
gs for SMU 13.0.2. As soft limits settings<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for those clock do=
mains are not supported.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] =3D=3D IP_VERSION(13, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mclk_min =3D mclk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; socclk_min =3D socclk_max =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vclk_min =3D vclk_max =3D 0;<br>
@@ -1926,7 +1926,7 @@ static int smu_v13_0_get_dpm_level_count(struct smu_c=
ontext *smu,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_get_dpm_=
freq_by_index(smu, clk_type, 0xff, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SMU v13.0.2 FW returns =
0 based max level, increment by one for it */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;adev-&gt;ip_versions[MP1=
_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)) &amp;&amp; (!ret &amp;&amp; value))<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(smu-&gt;adev, =
MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2)) &amp;&amp; (!ret &amp;&amp; value=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ++(*value);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
@@ -1986,7 +1986,7 @@ int smu_v13_0_set_single_dpm_table(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;adev-&gt;ip_versions[MP1_=
HWIP][0] !=3D IP_VERSION(13, 0, 2)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(smu-&gt;adev, M=
P1_HWIP, 0) !=3D IP_VERSION(13, 0, 2)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_get_fine_grained_status(smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;single_dpm_table-&gt;is_fine_grai=
ned);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 093962a37688..a3cbe15c3123 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -2754,7 +2754,7 @@ static int smu_v13_0_0_mode1_reset(struct smu_context=
 *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versions[MP1_HWIP=
][0]) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (amdgpu_ip_version(adev, MP1_H=
WIP, 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* SMU 13_0_0 PMFW supports RAS fatal error reset fro=
m 78.77 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &a=
mp;param);<br>
@@ -2787,7 +2787,7 @@ static int smu_v13_0_0_mode2_reset(struct smu_context=
 *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 10))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 10))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode2Reset,=
 NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
@@ -2799,7 +2799,7 @@ static int smu_v13_0_0_enable_gfx_features(struct smu=
_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 10))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 10))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_E=
nableAllSmuFeatures,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURE_PWR_GFX, NULL);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
@@ -2863,7 +2863,7 @@ static int smu_v13_0_0_check_ecc_table_support(struct=
 smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0=
] =3D=3D IP_VERSION(13, 0, 10)) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP=
, 0) =3D=3D IP_VERSION(13, 0, 10)) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (smu_version &gt;=3D SUPPORT_ECCTABLE_SMU_13_0_10_VER=
SION))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
index 626591f54bc4..bb98156b2fa1 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c<br>
@@ -1144,7 +1144,7 @@ void smu_v13_0_4_set_ppt_funcs(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_vers=
ion =3D SMU13_0_4_DRIVER_IF_VERSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;is_apu =3D true;<b=
r>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[MP1_HWIP][0]=
 =3D=3D IP_VERSION(13, 0, 4))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 4))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_4_set_smu_mailbox_registers(smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu_v13_0_set_smu_mailbox_registers(smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index 2e74d749efdd..2d1736234b4a 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -1024,24 +1024,24 @@ static uint32_t yellow_carp_get_umd_pstate_clk_defa=
ult(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_GFXCLK:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 8))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_8_UMD_PSTATE_GFXCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_versi=
on(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_1_UMD_PSTATE_GFXCLK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_SOCCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 8))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_8_UMD_PSTATE_SOCCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_versi=
on(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_1_UMD_PSTATE_SOCCLK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_FCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 8))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_8_UMD_PSTATE_FCLK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((adev-&gt;ip_versions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0,=
 1) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;ip_ver=
sions[MP1_HWIP][0]) =3D=3D IP_VERSION(13, 0, 3))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((amdgpu_ip_version(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13,=
 0, 1) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_ip_versi=
on(adev, MP1_HWIP, 0)) =3D=3D IP_VERSION(13, 0, 3))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clk_l=
imit =3D SMU_13_0_1_UMD_PSTATE_FCLK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144F20A5BD6A69093463C63F7F1ABL1PR12MB5144namp_--
