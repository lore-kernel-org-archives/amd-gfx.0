Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA954C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 09:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4840810EF4B;
	Tue, 30 Apr 2024 09:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Tx0iimV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7739410EF4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 09:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0bi+ZD+6Z2QUG47P5YNqKcuB59GPfAgTJj1WlInyGpHc7Q+p9qNpUpK71i9KwiiJBWVgl46VAAwSAGvNwBqasCAN5GHtcTPXFxEqGGfQUhMjYhiOb2VxkPSJoHqiX1IWkBPDyScy9pyJCt3KknP+IIzCgN13EFv6VHN5vNPaOjOTap27QARfRaUCzH7sOpiSTO6nOcKAU3xc5zMT80yhM9S7Zty3Q2IvdAnANbGeqtk5cQ3l0eVY/1SKyuxFf2niI53UMnNRCD1Zy6JXIWRC3WIf02W7dkpDoy7e6+yL61U6B2p8VcIT5HEEQq2P+pCliSh3wqmyOmYpVc+YceeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KHqnfBZpIyI5TSe5A9RjxX+BWilClVzaUe/7vmigDs=;
 b=blxba4vLqkUFMvLYF8rqXj+zw7JGSJC4G5MFklhEYg+mf6ZSn6k91PRgrU7wEcbU4j8NhdWvr0DLJNfKNCFTAVDTJHG3CE/X5QU2nloFdyW8uE49vaEQC4hnTwVeKuoecz9lu5kQTT6HlwOaNckJGvZlCipfOGiSLIvBzLGCm8hO+ZDTg7AkJ9/24XoTp9eSORfa4KJUeKzkZH3rN+PeG0F58oQS1bXpP6AFlAiLFT99HIozN4uGbqZPAcjboZNakR+FtdwuO+KbfEeEgF934wRRU7lbmsV2pVsQdodSda68vsgF4bPHEn/LQj2niGkKZ7rPjTCAC9M2LuMiEQg/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KHqnfBZpIyI5TSe5A9RjxX+BWilClVzaUe/7vmigDs=;
 b=4Tx0iimVM06DIR+IUGTdT7q0mQ7lzLCdmRilTDMLsDkHkUtul/TIHUvjclkJoCqJqdLYF8kfuCkMHDcMDGAPzbzWzyJBS3IroNb11K4HYaJquPp55lMfbRe/YAItQYAlq/LLjNM04a7peAlcykeDs4RJaBw9DT1BfY0Ejr4WS9A=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 09:19:46 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:19:46 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lee, Peyton" <Peyton.Lee@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, HaoPing (Alan)"
 <HaoPing.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vpe: fix vpe dpm clk ratio setup failed
Thread-Topic: [PATCH] drm/amdgpu/vpe: fix vpe dpm clk ratio setup failed
Thread-Index: AQHamgFFlVcVRVw1UUCSGELux6LJz7GAittw
Date: Tue, 30 Apr 2024 09:19:45 +0000
Message-ID: <MW6PR12MB8898965D383E420614DC530FFB1A2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20240429065245.166647-1-peytolee@amd.com>
In-Reply-To: <20240429065245.166647-1-peytolee@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=60c6bc77-c5bc-465c-b6e9-7a4888c41569;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-30T09:19:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|SN7PR12MB8769:EE_
x-ms-office365-filtering-correlation-id: 02296f96-9ec9-4efc-c626-08dc68f6ad58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Of9p6yt0bDWmXslRz2e1OYTkyn8SVbuio99fTWtAzAPV0wr932pSMueTn2/I?=
 =?us-ascii?Q?bePoM3IvPlu3ShXnXC/A9oaAS7FSJz4nHvKVWU8L8/hHVGfJoLEy5CgKHPfg?=
 =?us-ascii?Q?oEfNAsswT/4syjOg6OOGt5LJKtSV5vJBfoGfN0bipv2uaoNvKf5TXP/XyrRb?=
 =?us-ascii?Q?vbisSdi4njnP/vBSPXDwMYNFx7sD+PQZuzCqM2JOJdRocWQXmJlRqeZORjFI?=
 =?us-ascii?Q?oayIWix7tKGQISn8W2DZKh3qcIDhtunI2aVCdd2cs1tTxE4Uv16x7HCe5fH3?=
 =?us-ascii?Q?ElXnOD5wCvuvhPyuTk/LD4rztc7SDSEhokPcG0BEEbry1SzxY2F9were+2Za?=
 =?us-ascii?Q?gFSTmc731Jcx9r5TBBaXXwl5Aw+MqaofomR8DiwYT+ubORyK4e07ecQ8kCK8?=
 =?us-ascii?Q?AeNmxnca0ou+7fElEv4GFMkZhuctRVf+emtpLHOwbGbIk11UBX5ph2vSWHow?=
 =?us-ascii?Q?1M1xmlhtNuAViAh/oan/N0nghMcI3/YJgk0xPz6KCyZwGqvj/Bs0Zn0iPmR1?=
 =?us-ascii?Q?kZuzaZ1hkwJEmDbl3ax3bkpwx9KyqGUABlkG+Ol+D1yeYhc0+UoCJ87tv1Eq?=
 =?us-ascii?Q?qTB1goqPQwf2fKtx5sgn97Gh9P+BGkKlgDx3NFkmu1ZPpDySDOA+vkSsbGsa?=
 =?us-ascii?Q?oRXhHDlG3f6viNc/3zFTfgzpyQwuLVOoFrbhBM1fSkOs7uy6fWfsElk6EBjT?=
 =?us-ascii?Q?NlLE41HfrfEmvtHGIq8/JwnleVEMwAJcId6iaPpnJtxq7885IO5P46C8sOCP?=
 =?us-ascii?Q?WDaTnpUW13Cxp51IWZhMcnxtVqcYjyD1sTz+/uia35qd13VAZpHe3tFWHiO+?=
 =?us-ascii?Q?QBmr8see80yTn0CJV10sYok4yvb6iMVl4dLpCW6lPK8xzJBfYMZU4Y6zS2r+?=
 =?us-ascii?Q?zYHQDMrd8JmEkVBMyybVS1GgCC2cYpAxCQlX5G1NANNQsMLEAY/X08fqhoTZ?=
 =?us-ascii?Q?jAVIp7zGKJ2XZA1XeFGgcMd8xUw2wl7jSr1ixY7+vI4mpP4AfzC2z3bbMzfZ?=
 =?us-ascii?Q?2uVQX72QtYI/FMDBLMAUlivduvosEKhTsiPF6Mp51b4M3r3B/z0sH4ytXqM5?=
 =?us-ascii?Q?2RjYMEx8R0VcpM2Y95eCI/N38PBUtXusOzZaRK8UxsB6Xo7A+Ly8Lb9DT+BX?=
 =?us-ascii?Q?rwwu4X4ik4bAH1kzIjESrLc21TtpYHFCJ82lUdpEXc5F89eSgejHar9iuW4S?=
 =?us-ascii?Q?NleoGrhKUsTy+tNCxWLVeK2ayn62xlPfM7aF/6PEonkdsadcNeVOZdNT7FGC?=
 =?us-ascii?Q?v3FiMpxqy22I7HHowB5uEnEJIjyEScE7iPNkoD4nZkcaCBg6EVLbIVKU71jQ?=
 =?us-ascii?Q?1vc+vhpLJLXW9K77UReyUY0ABv7yoew/xP/13Er4qiW+eQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mTs8SFFzjaI9IGY2PPJ7VVWd9u3MuXZM1dQNguWQef+To3xV7aR71pP+GiDq?=
 =?us-ascii?Q?yuLyJjfKtlO4gtDwmSWP4KusMMeni87RJ83dh5XAklE1M+sKb3nheR3Dlo9t?=
 =?us-ascii?Q?NTrbnCnJyzjX2eIqP7+54sj2YAj1OPPB4uWrC5BsPRvBslHokLTWbtPG5WFp?=
 =?us-ascii?Q?XG+Npoqv6tG+WphFuZpTPMP/g94SswkYGJTwP+IXQFimGRjiAM+K1dDTB4Jh?=
 =?us-ascii?Q?FHx/Rqs5D4TqMXRi0pslBX9XrX4GP8lMvaKUpcDzMYkIAKRwPj2Yl9tBZKc9?=
 =?us-ascii?Q?nyW28a+O45UMSHrzPVti4Tcf7hFOA9QijFC1kM5Xwy7PtniG/u2D9OPWPSyS?=
 =?us-ascii?Q?ppVGOBfz1JVVZwSlYlWFFKsAFcawejDTxuFPwrbiphBDo99OREBB4wcqy+N0?=
 =?us-ascii?Q?e91klqQ98o2FtbzTQSNFb6U3u9BdrGvIHtyiODo6FvuWgJNo8edXAlFxHTFn?=
 =?us-ascii?Q?j7b0WwnXjdS2S4FNK85cSVqlXd/BFTjYidW/yOWsy8GikiKe2C3zAdae6gbv?=
 =?us-ascii?Q?8FRUnZXet0+vqFssJ6/IPq6SIlFVNJtTzsA5TEZgTspZ9I7VUDXFV3x5TZmo?=
 =?us-ascii?Q?IJtzY/lyzbUftT4XQ2/5cfboiAYz2yXw2SvpRn4fN/t21RwmVwx2vJoN1KJ7?=
 =?us-ascii?Q?cmW+3TF0HUQgesvWRTzLbuEd7BSD05TVVz2HRCoV54GSq4ymqYqqEnKZ8piH?=
 =?us-ascii?Q?R+lIG55/jnxwN6AwrLisM6DHAkc20rGVUTpWxd2esLK9j4CBZAaY8p/CTPoV?=
 =?us-ascii?Q?GNJObfPxadD0oLiu/eBcemjTESFSyFJCifTk+HMYKx+14Mw0T1RyrlOitiHI?=
 =?us-ascii?Q?AksZ8UgYXZMzs1Y7UY89w7aN0yJa9jxqjlEKbE2iD+MEIkG8TnJaEfPfGG+Q?=
 =?us-ascii?Q?MRHsU15Ex24a8+VQ0CVL3Q+CoZ1O1zDv+47bZk1BgkHwxb/oenfIWX9V+TGa?=
 =?us-ascii?Q?6SY/QkjbPQfAvWHoNRvih0HBAM1rufzA4a7JC+UQlf1J8o/5OUBqOwR/JbWp?=
 =?us-ascii?Q?Hjva4aeV+F9hzRucYKlbdBpX8CD4o8AcNa50N4idiPIdBDsIuOYvEIRlqqLp?=
 =?us-ascii?Q?so3Nsc6gAKJ7HQn7PRy4+uXW1WFMtbVi34/xuCmClYw7y/xnXPaL70jfL4HH?=
 =?us-ascii?Q?oE/isxEhhwbM7hVAJM0/Lo1AyDr//3P4jlfE5sGG3Nzezotx4AtxHmTumfzW?=
 =?us-ascii?Q?XuAd0VjSxRqP2RduVkEKrkBF6eXaRmB1FxtK1LjrOOwFRFWquCKMSgq4Cahj?=
 =?us-ascii?Q?UNMTRuXPXfiNxGrHeZAKgoXSyRfm/fFmgLhrJSV13RSYcwqZcpysm+qARwm0?=
 =?us-ascii?Q?kmSPKbd8wzLcn+QwEJnXYfG1urB89D320LEdpIc6ZqLA59m8FuFC/8g+4RJq?=
 =?us-ascii?Q?nWkNDV3PA1MGperVFu29DWzIyqJIKfRa7DXsixGP7xTgvqVvPL/IHHHrB+Lv?=
 =?us-ascii?Q?uF1bwC+cS4N5uTJEpFck7429bXbkcsJLUqAoamRP8FXdh7LChBCu2rnHUWSa?=
 =?us-ascii?Q?orBfb85MwTpqlHLbI3xThF+/CrDcNdGAWTcXRI97GBNIHCzg7Kx4+fQB8SPF?=
 =?us-ascii?Q?eQc/lpAfInjiEtPfuYk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02296f96-9ec9-4efc-c626-08dc68f6ad58
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:19:45.8846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bup8a2aRBUAEtYyJPV0JKj/V/vyQMvskwFMr1pUZhgnVRYtQ8klRPsEZkl3FLmeHlhwjfb8h1TXY+8Npk8xzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

Reviewed-by: Lang Yu <lang.yu@amd.com>

>-----Original Message-----
>From: Lee, Peyton <Peyton.Lee@amd.com>
>Sent: Monday, April 29, 2024 2:53 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; Lee, Peyton
><Peyton.Lee@amd.com>
>Subject: [PATCH] drm/amdgpu/vpe: fix vpe dpm clk ratio setup failed
>
>Some version of BIOS does not enable all clock levels, resulting in high l=
evel clock
>frequency of 0.
>The number of valid CLKs must be confirmed in advance.
>
>Signed-off-by: Peyton Lee <peytolee@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>index c23d97d34b7e..49881073ff58 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>@@ -128,6 +128,7 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
>               struct dpm_clock *VPEClks;
>               struct dpm_clock *SOCClks;
>               uint32_t idx;
>+              uint32_t vpeclk_enalbled_num =3D 0;
>               uint32_t pratio_vmax_vnorm =3D 0, pratio_vnorm_vmid =3D 0,
>pratio_vmid_vmin =3D 0;
>               uint16_t pratio_vmin_freq =3D 0, pratio_vmid_freq =3D 0,
>pratio_vnorm_freq =3D 0, pratio_vmax_freq =3D 0;
>
>@@ -144,6 +145,14 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe
>*vpe)
>               SOCClks =3D clock_table.SocClocks;
>               VPEClks =3D clock_table.VPEClocks;
>
>+              /* Comfirm enabled vpe clk num
>+               * Enabled VPE clocks are ordered from low to high in VPECl=
ks
>+               * The highest valid clock index+1 is the number of VPEClks
>+               */
>+              for (idx =3D PP_SMU_NUM_VPECLK_DPM_LEVELS; idx
>&& !vpeclk_enalbled_num; idx--)
>+                      if (VPEClks[idx-1].Freq)
>+                              vpeclk_enalbled_num =3D idx;
>+
>               /* vpe dpm only cares 4 levels. */
>               for (idx =3D 0; idx < VPE_MAX_DPM_LEVEL; idx++) {
>                       uint32_t soc_dpm_level;
>@@ -155,8 +164,8 @@ int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
>                               soc_dpm_level =3D (idx * 2) + 1;
>
>                       /* clamp the max level */
>-                      if (soc_dpm_level >
>PP_SMU_NUM_VPECLK_DPM_LEVELS - 1)
>-                              soc_dpm_level =3D
>PP_SMU_NUM_VPECLK_DPM_LEVELS - 1;
>+                      if (soc_dpm_level > vpeclk_enalbled_num - 1)
>+                              soc_dpm_level =3D vpeclk_enalbled_num - 1;
>
>                       min_freq =3D (SOCClks[soc_dpm_level].Freq <
>VPEClks[soc_dpm_level].Freq) ?
>                                  SOCClks[soc_dpm_level].Freq :
>VPEClks[soc_dpm_level].Freq;
>--
>2.34.1

