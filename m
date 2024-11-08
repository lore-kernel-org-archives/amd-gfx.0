Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EBFD5E124
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 03:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEE610E336;
	Fri,  8 Nov 2024 03:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Md/bXUR5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEB510E336
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 03:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruDji2g2K/68nOvLqsmwoE6esls0ai6ECKPhgxErKr5u/YjhfG6lMpJr1tK8dHE79x1eWPTgNAhUNwWpC/DFVycxJop/99SYNPSeVkHgUJMEuqCcrxJ1EjL+bTxCz9T9Rl1CujirfTsxDLDjPlNb0ukLKY7h2w2CjQovKs+kH+R+jZugeiA+ZTiSnG/BZzQyHjeSI6QhkMejd1dmU4QoQd5TcWHxrjv2MrH8xFoQuSnz7zUamH70oIGywM+v+NPTZgDVnQl8k/QF2FDIzjKk3Za6mKj0ddB76r6isKThgIi0Gjg6QjS381mq40gdvx+CQtq5LOmiT1v90l0U6CXnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w3YNiTmLuhLXOfLTu7PMgYOsntxmyFB2bo3oG3WIJA=;
 b=Gna6Jsja7Jym6tZU0aP2NPoYop7beGvqarc4B0hojsknUyDAb5FbF8kErbsUy1809ZTu3QaHissfZRMJ40/mM56n7JnhBdFpRnb5D5SR0EeLm66tNwBE4+aDUAscwCIqRhrelCX8cK9MCwqbaAYyFqx7JA7q2B+T5JfZvRCqHoLHCCzy11KJrYgjrx0wlTauYpIJW/BLpKGzmht6BUUbApmRKQlalvv7lABBEYkQRK5mFybsZzX0dXdxvDKMVH+CISwuxhv7MyHG88FxkBpptNHSNn/tbsHleizQiJ6k6ValkiX/2B2r3kO536ge9zf6bCA/ftxx7OhY2/kZ+vT48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w3YNiTmLuhLXOfLTu7PMgYOsntxmyFB2bo3oG3WIJA=;
 b=Md/bXUR5lGBk7s6wBS2zJNk5prX7MNo9xAA8/0T15rBP3lVzdRfM7Itb7h0JSTZX+MbEHGfxo+nfCVcfLU97USmRABQBjofI4ldR/gensyt6CQaT1Jju5EqSQJ6tGDnJdKPN7tS4KkuLl0BqpVehtIVt34QHFzqa544ichHBcZ8=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 03:32:12 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 03:32:12 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix warning when removing sysfs
Thread-Topic: [PATCH] drm/amdgpu: fix warning when removing sysfs
Thread-Index: AQHbMYU7AY78EaAEik2PfOt+OZgLlrKsrDsQ
Date: Fri, 8 Nov 2024 03:32:12 +0000
Message-ID: <CH3PR12MB8074D04D3808036361059AC6F65D2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241108022148.588761-1-jesse.zhang@amd.com>
In-Reply-To: <20241108022148.588761-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6ecf494e-e8d6-4316-b818-ec0d261db940;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-08T02:40:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|LV8PR12MB9083:EE_
x-ms-office365-filtering-correlation-id: b73a3a7d-935c-405c-b495-08dcffa5ef10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c9Ub3Zlj60p5OSGwsmIcfyLLTDh+zEoZGOb6OcGtsZaIraDyTZ1uuo3bZU?=
 =?iso-8859-1?Q?ZDb34UNlRVLrOH3duvxEvHuNWeI/iPD8XyF3Q3M3MKoUv1ssYqNWB7jMlE?=
 =?iso-8859-1?Q?Ojb3otxbtQq9nCwTbC0nVuNzTsgyOPy3LxaSdUZSEoGgz0vo6onx4q8Nbw?=
 =?iso-8859-1?Q?cM/VzIDbzEQtJMPmgoKwTc82st1HtKzP1rYCOz1pOSTmqcpF1E5FTTJown?=
 =?iso-8859-1?Q?EVH70KzeZzz+1zpRPfssbAHhDIM5/78+Z1RTfn1h3goyXsvB3WI6Stiqw1?=
 =?iso-8859-1?Q?XE9dwMooyczKgn5EU8TWcmtMtI2+udAFkwqLPNuAGnJyMl+4wDrwIJKFrI?=
 =?iso-8859-1?Q?vmyMRFXhLtCTm5P2madJ83ie2Q93bl4xV6XUt/ci7Uy3CMq+NASXCDM6Jw?=
 =?iso-8859-1?Q?CKu2HQWSk03fIvXwPRVe29yO2ad+ZkJqccQLpNSt9539YpzFfI8b59oLCi?=
 =?iso-8859-1?Q?1PJNIOuHWkvtM7lpAC9GV69FyheMZA0kTUFiUvFP5maZxI/oDGabvE8XQ2?=
 =?iso-8859-1?Q?+Etok45YgnFFI0S2/xWhWWkDGH3SZsRpwawU5YowjlaOH3Dr0iXHGkOaBN?=
 =?iso-8859-1?Q?1clCXyjHTzarvJRaEAyIr1faln5kUhQ7vNnaqzloEIcFeQ1uXayLLkweZH?=
 =?iso-8859-1?Q?/b+tMx5G+xclXdpOr0GaD46VuHsnM0ATkuZpq8jbvRdMnX6pEQXt4NzppJ?=
 =?iso-8859-1?Q?bCH8nA9kAuEI1UZN39ZLCer38h/KcBCRDTMAPTxzJJhcZOoepUuCG6fxiL?=
 =?iso-8859-1?Q?Xd3d4907p8T2YD/HgUs/E0qPWZQGbpjwFVayPlQNc/Yi4IsHbGsAuBlcnZ?=
 =?iso-8859-1?Q?FBtLdkDcC50/+Ownon/PLqyWip0yY0btEN0PMGgLLW6lI/hAGt0GJ0tGWk?=
 =?iso-8859-1?Q?ODvgDb3QHvk+4VG3Qz7WgOuljCnsh5P2AWNbxbGUR6Qhw5spX1o4PbnTgb?=
 =?iso-8859-1?Q?zyFNfZPTYfqgVP0juDyXB5JylSPtDNqkISHwT6q8ppxEQGNy4Tj68lS9mq?=
 =?iso-8859-1?Q?ECgF64uYxs3hBwWpDA4M+pBdYvq97R296Oybod6FOxMdF8WZ9T9b0Ha8Jp?=
 =?iso-8859-1?Q?kccR8ADTthGLaIlsKGXZ/bdCcEE76Dc83/+HF8gC/u/Ob5e3c8KMeGxXhd?=
 =?iso-8859-1?Q?luNXbjIete8KH1H1pKF8QEfpKA7BGhkBEfBs1SvyOKnsy3BjvHkzHkI+qm?=
 =?iso-8859-1?Q?3OhCPc4FQP7iv8myTTksBcVBwbsoTu9Cp5Hz9lUbvbucJtmM6CZa/5mXWT?=
 =?iso-8859-1?Q?3if5jwDfvQ8s86rz+7OkSEwF63wdh7JNM3HJyIpc5r2jCzhrJBzajMfFba?=
 =?iso-8859-1?Q?p0jgUI6NCRicokpQUYLpKnDR8nyV97S7MLkoLX5Aq6Pw7FBxOizoauVKLW?=
 =?iso-8859-1?Q?4iafDd549i0X3RepKvjc0BJwqkhQvfx6gJyXM/W4aUUlUBdaLpAnM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KcGAEQ1OMaVbhK9gwsGpaP/8Mv2iBB0FaHvfSUQhUijp3EUoTnH1SUCKxW?=
 =?iso-8859-1?Q?SRwKuk2jn4ibd4S2ZW9JPDFPtm3huf1xFUe9xgb8aNsSKj6KURMm9kPc1j?=
 =?iso-8859-1?Q?6Mhh1TL2OZs6iaJSKxZm324HvSBty8yi5cic91VmAoEKwuFDqZ7veNxirh?=
 =?iso-8859-1?Q?bv3ESDR+0ffcu0OAyPVdsELypGTiHXtBl5Wh5RDA6HZrg9n+UMa3buNcdH?=
 =?iso-8859-1?Q?k4xHSYe+KO1MUeSj9viubpDX1dBRcxVlt9VUnkIBvFyMOIqiqeXK/LVGRI?=
 =?iso-8859-1?Q?chL4aVGeBUgq/77Dwq/MY+7/wAds/w8hfGA+GfzrndV7BJwhUntvQskJRq?=
 =?iso-8859-1?Q?J3bZ1MPhVRcVWJcHRHTEujmThkIhVKIj1oTuCuSehR3CNvK5eq11p3HQdh?=
 =?iso-8859-1?Q?uvL/kciGtT4Skdul+98DjHvV26p9fH7Ckoa3/LOb2cHNMjxgNWlAVa+NXi?=
 =?iso-8859-1?Q?faZeMn3eHIxe5imVp/Gse+meAY+VxFoaxiKTjrUUf8tLvostLeQvSpLmhK?=
 =?iso-8859-1?Q?7LREteCd8pttJf0qGcGzfcH70eoJS/aRE1AL9SjFVytI4zQiLywvYAAkSn?=
 =?iso-8859-1?Q?Xj2JY/yET7hMatLEWfmvp26lpRWHun+tFwGi4/Ht74CYpyr6a568aYBg+M?=
 =?iso-8859-1?Q?Te6B9V8Gy4AS7iPwW9zWpnjPwlpGY9UlOBHEDw+5gmmTZa1k5H7sntl1NL?=
 =?iso-8859-1?Q?54Wf3IJIwcu6akmSZZvKJw0gW6RoR6xBh26ITlFMtEglK13nMNAQGqCW7A?=
 =?iso-8859-1?Q?Li7Sm9H/dMq6jxWNLGy6vLxZhG6hVJATXLgItg1dsX9+8+fZaqco1NqZPg?=
 =?iso-8859-1?Q?/6ULFtInWjYOfpF+YEsDL2CljVyaI6usC321r2v7Rx/QP/I4dNZkBRU0A8?=
 =?iso-8859-1?Q?DNZYgV5yfRjY/04Emb1iC8Fw3aec+crFjg0wfKy1yQqAmMyLNe2Lp9Q5Zm?=
 =?iso-8859-1?Q?EfCa03nfbtsmb08AbeZyfmupdEtCYN+YdCZ5hGYNLxuTnfRK5gDKjEpCK6?=
 =?iso-8859-1?Q?iGdM8v3Q0ElkLsW83bJEeq6mDlEUnCuNtpvOztFAHVCv1kFBs/1LiK/Dum?=
 =?iso-8859-1?Q?PhiCCFAag51T32odmPcjZk0A19+Apa9ffRxAGr+Y1xfDpV2uaW1GKrB5+7?=
 =?iso-8859-1?Q?SRPn55d7T3nLxZ/M5PBoFGK38/iH35fouyyjjHtoKnGPm10bMYt04TvDxq?=
 =?iso-8859-1?Q?t+oXljlxyt0WY+P3jRL8I7jiFa4qzer5JgPqej/3wJAFbogON/EydB/d02?=
 =?iso-8859-1?Q?IncrKThw1xfYubct9ZSuPdGyxlVk0qJQyRtHU3e6l+lcO4w6s3lJr9JNuE?=
 =?iso-8859-1?Q?y9eRIKR4uNVPmTEGGySj/9p3xytz32Lo5tJNZAh7UFiw1HFn/XB+xsFfBG?=
 =?iso-8859-1?Q?07OnQvfFddiiZViGWEt35kFUeBtMy5PKAetcXMtVtRpxi2Fe3AWNHrOmzl?=
 =?iso-8859-1?Q?FRNCxUG7UoUe1xEQVZm65lDn4ZSFecnSfFEOxqdiT8KUpZQ+Bz2aSA2QBf?=
 =?iso-8859-1?Q?n2yqqUmmm9qby2egJ47S4zwyfWMpWfvXA5ZudF/r2Ru+nXxSf+30Q6hdWs?=
 =?iso-8859-1?Q?B0LjpJ6MCfIMVraq2OwmQhoLPIQPbR7+x+btruTp2I3FjgGd7JMeC/smPm?=
 =?iso-8859-1?Q?ea+Z/PwHtbbrY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73a3a7d-935c-405c-b495-08dcffa5ef10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 03:32:12.4840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rUSVy7/ljuuD7ZMaN7PM1+mH/eP6j4Q1nzu6MByVY2tz5se5eqKaq9XxySQMqsqaXb3LdTrfGXG2W/58Wy6+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, November 8, 2024 10:22 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: fix warning when removing sysfs
>
> Fix similar warning when running IGT:
>
> [  155.585721] kernfs: can not remove 'enforce_isolation', no directory
> [  155.592201] WARNING: CPU: 3 PID: 6960 at fs/kernfs/dir.c:1683
> kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.601145] Modules linked in: xt_MASQUERADE xt_comment
> nft_compat veth bridge stp llc overlay nft_fib_inet nft_fib_ipv4 nft_fib_=
ipv6
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nf_tables nfnetlink qrtr intel_rapl_msr amd_atl intel_rapl_common
> amd64_edac edac_mce_amd amdgpu kvm_amd kvm ipmi_ssif amdxcp rapl
> drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper
> drm_ttm_helper ttm pcspkr drm_display_helper acpi_cpufreq
> drm_kms_helper video wmi k10temp i2c_piix4 acpi_ipmi ipmi_si drm zram
> ip_tables loop squashfs dm_multipath crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3
> sp5100_tco ixgbe rfkill ccp dca sunrpc be2iscsi bnx2i cnic uio cxgb4i cxg=
b4 tls
> cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp
> libiscsi_tcp libiscsi scsi_transport_iscsi ipmi_devintf ipmi_msghandler f=
use
> [  155.685224] systemd-journald[1354]: Compressed data object 957 -> 524
> using ZSTD [  155.685687] CPU: 3 PID: 6960 Comm: amd_pci_unplug Not
> tainted 6.10.0-1148853.1.zuul.164395107d6642bdb451071313e9378d #1
> [  155.704149] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T,
> BIOS V1.03.B10 04/01/2019 [  155.712383] RIP:
> 0010:kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.717805] Code: a0 00 48 89 ef e8 37 96 c7 ff 5b b8 fe ff ff ff 5d 4=
1 5c
> 41 5d e9 f7 96 a0 00 0f 0b eb ab 48 c7 c7 48 ba 7e 8f e8 f7 66 bf ff <0f>=
 0b eb
> dc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 [  155.736766] R=
SP:
> 0018:ffffb1685d7a3e20 EFLAGS: 00010296 [  155.742108] RAX:
> 0000000000000038 RBX: ffff929e94c80000 RCX: 0000000000000000
> [  155.749363] RDX: ffff928e1efaf200 RSI: ffff928e1efa18c0 RDI:
> ffff928e1efa18c0 [  155.756612] RBP: 0000000000000008 R08:
> 0000000000000000 R09: 0000000000000003 [  155.763855] R10:
> ffffb1685d7a3cd8 R11: ffffffff8fb3e1c8 R12: ffffffffc1ef5341 [  155.77110=
4]
> R13: ffff929e94cc5530 R14: 0000000000000000 R15: 0000000000000000
> [  155.778357] FS:  00007fd9dd8d9c40(0000) GS:ffff928e1ef80000(0000)
> knlGS:0000000000000000 [  155.786594] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 [  155.792450] CR2: 0000561245ceee38 CR3:
> 0000000113018000 CR4: 00000000003506f0 [  155.799702] Call Trace:
> [  155.802254]  <TASK>
> [  155.804460]  ? __warn+0x80/0x120
> [  155.807798]  ? kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.812617]  ? report_bug+0x164/0x190 [  155.816393]  ?
> handle_bug+0x3c/0x80 [  155.819994]  ? exc_invalid_op+0x17/0x70
> [  155.823939]  ? asm_exc_invalid_op+0x1a/0x20 [  155.828235]  ?
> kernfs_remove_by_name_ns+0xb9/0xc0
> [  155.833058]  amdgpu_gfx_sysfs_fini+0x59/0xd0 [amdgpu]
> [  155.838637]  gfx_v9_0_sw_fini+0x123/0x1c0 [amdgpu] [  155.843887]
> amdgpu_device_fini_sw+0xbc/0x3e0 [amdgpu] [  155.849432]
> amdgpu_driver_release_kms+0x16/0x30 [amdgpu] [  155.855235]
> drm_dev_put.part.0+0x3c/0x60 [drm] [  155.859914]
> drm_release+0x8b/0xc0 [drm] [  155.863978]  __fput+0xf1/0x2c0
> [  155.867141]  __x64_sys_close+0x3c/0x80 [  155.870998]
> do_syscall_64+0x64/0x170
>
> Check if the sysfs directory entry exists before deleting the sysfs file.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 3 +++
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 2 ++
>  7 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f7bf5e43f16e..a9f40b28e030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1773,6 +1773,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device
> *adev)
>
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)  {
> +     if (!adev || !adev->dev->kobj.sd)
> +             return
> +
>       amdgpu_gfx_sysfs_xcp_fini(adev);
>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>       amdgpu_gfx_sysfs_reset_mask_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 642b8c848141..257f4b712f00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,9 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> +     if (!adev || !adev->dev->kobj.sd)
> +             return;
> +
>       if (adev->jpeg.num_jpeg_inst)
>               device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);  =
}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct
> amdgpu_device *adev)
>       if (ret)
>               return;
>
> -     device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +     if (adev->dev->kobj.sd)
> +             device_remove_file(adev->dev,
> &dev_attr_mem_info_preempt_used);
>
>       ttm_resource_manager_cleanup(man);
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT,
> NULL); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..5a595baebb50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,9 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct
> amdgpu_device *adev)
>       if (!amdgpu_gpu_recovery)
>               return;
>
> +     if (!adev || !adev->dev->kobj.sd)
> +             return;
> +
>       if (adev->sdma.num_instances)
>               device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);  =
}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 67264f0be491..2b21b4e5c19c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1320,6 +1320,9 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> +     if (!adev || !adev->dev->kobj.sd)
> +             return;
> +
>       if (adev->vcn.num_vcn_inst)
>               device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..2cd642761a3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,6 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> +     if (!adev || !adev->dev->kobj.sd)
> +             return;
> +
>       if (adev->vpe.num_instances)
>               device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..bc7d380f4b0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,6 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
> *adev)
>
>  static void df_v3_6_sw_fini(struct amdgpu_device *adev)  {
> +     if (!adev || !adev->dev->kobj.sd)
> +             return;
>
>       device_remove_file(adev->dev, &dev_attr_df_cntr_avail);

It works here but It should be better only applying the adev-dev->kobj.sd c=
heck to device_remove_file but not the sw_fini as below:
If (adev && adev-dev->kobj.sd)
        device_remove_file(adev->dev, &dev_attr_df_cntr_avail);

With or without this change,

This patch is,
Reviewed-by: Tim Huang <tim.huang@amd.com>



Best Regards
Tim

>
> --
> 2.25.1

