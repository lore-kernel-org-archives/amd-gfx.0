Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A193CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B52510E6EE;
	Tue, 24 Sep 2024 13:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYA1YAqD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63CD10E6EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc0Hi805F65ObLkyOTch7i2k2LrB8eY+11OPT9rob0AI+GDOkL+ilvJ5xlghUNrO5mBFOmpsw/hcFgOOBn/kzAb466CPDW8rpcgZooKdpl2ZQjAJ4v9krAry4CpfBXGVHqjQBl57wgpxEth+KdqMrUPxYnHBlCKBvp+GFyAp0KW/unMDgVPLjrTegk77A7VAFH15lxslj41IUeu6rxZm/d57HU58hyfl+8iXp+gZxbcoj9xtK8dUxDNKaPJUcRFshBTSduMcdjiUKWij0nLF4O0H4koZQhr/Lj4ZsugEqVGEJm36tqGuM5dsntCalMv762KOfCPkPsYT9t8GbONa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPPfrAjpuQjo+1WXB+BJW5lc1wD2fvaZRHUcWcnRKzg=;
 b=GvciQ76y7q6fJGZvFiOxZBtvHhpTFsJUW4mDqc4WpvGGKtE66yfh+lGRJOzhHYphobAVR4eEynCuzFn8vaJzjP5IM82re27Wwd5ThRjxErga4ci5ncM2r0AjNvJD9qqq7619S1rzYOfzCevQnldygBSnLdvMw1CfmZxg3r8KBJJ7Q7lxVHgokl+X5WnsTHZSNcl7+DtFR0gii4hfry2OyvZIT6Wm5HJZHXFxRBgBJcIQ8mTdeXDN2FUY7LgpJWZxhD5Nfi7qwhByqxJNFJEi7FfGcslbmjIFcSUTGbB7d/bvijwlanLsyo3PgCm2fBGw5heWxgSw3gmD5wKaUDHY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPPfrAjpuQjo+1WXB+BJW5lc1wD2fvaZRHUcWcnRKzg=;
 b=wYA1YAqDvHxJhh0zwfzxIKWaaqzpyX8RBdCbM2UtI3osbGMc8voFHWdiyTntdO8/hE6Ewr5aSkmkbJ1JTU0rtc9XhaO0CmbCfHbEM7sc9F0RAkMPuE3467KCLB9o0RNZO9F9krBpg3VPqzCBJ0iBrX+p47kaVnLFc4OuMq8/G5U=
Received: from DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:39a::20)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 13:51:03 +0000
Received: from DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415]) by DM4PR12MB5055.namprd12.prod.outlook.com
 ([fe80::2c56:65d9:9ce1:c415%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 13:51:03 +0000
From: "Chander, Vignesh" <Vignesh.Chander@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Show current compute partition on VF
Thread-Topic: [PATCH 2/2] drm/amdgpu: Show current compute partition on VF
Thread-Index: AQHbDkd0owTMtC/OgkqgeOp0FLImv7Jm9NMc
Date: Tue, 24 Sep 2024 13:51:03 +0000
Message-ID: <DM4PR12MB5055D49C8290B0F27DE15B9BEC682@DM4PR12MB5055.namprd12.prod.outlook.com>
References: <20240924060250.2678600-1-lijo.lazar@amd.com>
 <20240924060250.2678600-2-lijo.lazar@amd.com>
In-Reply-To: <20240924060250.2678600-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-24T13:50:18.8459720Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_|BL3PR12MB6617:EE_
x-ms-office365-filtering-correlation-id: bd2c02ec-2cec-4bc4-e8a3-08dcdc9fee2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?R3RN+PaRZ1tuZfT/1q48bbucY3DYtsHBDaw+ksvEpEVMgiD07ql6/6iUjc5K?=
 =?us-ascii?Q?HTtsmUbQTjDaU8PmFq2WTz0a45qRHGlVZmCCNL2X6MGvqif6pL7Eyb9xGL7b?=
 =?us-ascii?Q?doLSayj6ujXVvd2xkZ/4ll/4IgPxOpY66CJH0PzH2M/5aIsrrqJ58X4yVTia?=
 =?us-ascii?Q?QCvgE2KDeWTcHUea8XlPp3lPcZEIJkfgcDXhxAWY/j1vDesQjoaSTEtc+1dy?=
 =?us-ascii?Q?ePf8DaAQOg3cTvVBBUMGgiaJjLOj7Y+bo8mPSI0NuPTpQlOlbb0f7l5hpHBW?=
 =?us-ascii?Q?iVDCE1F89o+1z58wX47+zwTZ9hUOX+JlT429DVGhs/H5QAbjlZDlMpUYpqfx?=
 =?us-ascii?Q?eGkw3wNtsm8qBbYTwIcujvxGbK0pOV6/8LXGv9mzw3kze6ZzePjoLpNqOMx2?=
 =?us-ascii?Q?N43dD0hAY/mYYQOZebSU/N2Ygl5WnpGisbydWjyLIY1kgoLpXtu8pW+OH8aG?=
 =?us-ascii?Q?2cVhPUmslOIxiKwjS+/5yjsH+TjFcTNBIhGWPbZqVecPs+yZABbxJ52H4k7g?=
 =?us-ascii?Q?/9BIkt4n/Man+7nELHT66cjHCFManT3SKuXS/+KlXc/Or4/YWfGfx2Tgo6dT?=
 =?us-ascii?Q?iNLpyxlC9oA5gc8XhOATSX7iWWUVFJhGcRaIXN5dtWxablWVoWnimPEJxcEl?=
 =?us-ascii?Q?QBEXsHMCY9cw3Vs+pIgwwjylJLsGk/UpI+S5zTidVc2TeB8eD7f0+tNyqFaV?=
 =?us-ascii?Q?v54fNetAnm7WS9RX3V6xZVMcYIAbBk3vLr2AMXP5Z11ZF2H6eHvg0utqxd2D?=
 =?us-ascii?Q?7C5ML6HgDtMcLfTGi31X5Xg8XuNGNqnJujssw5ByzWyl41PK/o5aPNu0S/IQ?=
 =?us-ascii?Q?jNEMA6Iey34T5TeXhTABhgvB/8ykY3iPptJB+dibO62/vWLf8TLKEEGFQD80?=
 =?us-ascii?Q?fSoHjpPcGtNTCCBK6Nu4GTZYEaFa0YmPYxQZ2JdkhyDNip1I+RwU9a1dfJX/?=
 =?us-ascii?Q?q6iOQBXSnBXuMay2lOgso5x+ZE5s+hG2X2p1YVbJccCfp30zq/AMHAnchWix?=
 =?us-ascii?Q?BbqZ/sNM+0B2zNqK1tvNiOhhfLUO03Bf1LzUQDV3ZttfkzMmmW7vnVwwxAhf?=
 =?us-ascii?Q?U5p8TMy3xF0FsBXwYv36eTiQW8bif2HZItmWgHuXPb4EkbXLcnv+4sJEIAnY?=
 =?us-ascii?Q?GNMqF+zkGLNp5VIXgHQVUwR6z22pW/lAHj1ONUbqoJpgAjfQytWrDhAAwhO/?=
 =?us-ascii?Q?Ewipl1YzcDPa8kBTWKsE5vJ/miAPOCruTjhtdEyOvUa2UU+OyVGZR8IK98O8?=
 =?us-ascii?Q?WDNMbpgtO8k65R5ew7rgorjzUl1ggLmVPgDBshv8b/zKz3GyDMEoQtQQWoh0?=
 =?us-ascii?Q?Pj00HcE6FCIdFA5bfTi5+F0DdxX0LwoX96itqLrNvzuxpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5055.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lNWH5ZQlWkOoE/0OmSMOotEKgKwuekT/hMBIrOOL0QZRarYGAIVf/xlwO5U?=
 =?us-ascii?Q?nJQozxuY2lEiJJfodCwVs4m+6wkz4Faii9S859B00PjSgF4PDEIHrobGNWa7?=
 =?us-ascii?Q?9J2d3pS5nMhVGo4OdbLEdlwTi1z0OidW8Sxf/gwxtzdoULS9FM7sItlmsEtu?=
 =?us-ascii?Q?xloSzLomd6KuL2HbmFY7oIiUZss0AF3VOEZB2QZhJ1MpNchAtQL05ObZ658W?=
 =?us-ascii?Q?g3Na69rAzDtw61g1D8L+zxRyKbRHkxJeXs93vtrrAE9xJclhE9jQ2fEn7pbv?=
 =?us-ascii?Q?bPo1DEaVbaEOfjNok5tW2ZiWlsEWIl1b115scevtuWiupji9onaaM4aCMrjx?=
 =?us-ascii?Q?Rtm2ShKyyb/fAq5rb+/Y+DaCw7JKXEcGMoqgGNKecrkNnVeIvue/Lf+wknuD?=
 =?us-ascii?Q?NUzHmUDUgK0xmP6HCXkMdRyGutBiDpRB5wIBf1oHqERGqwf3MO1C1Qnk3eRE?=
 =?us-ascii?Q?f2sIp+3aqmCcNdTxl2ofgDR5kIDD8eu3EnZYRkJXzvxkpCHM1nI53oxUgX0d?=
 =?us-ascii?Q?ZC4Ygyd9rikQhuYxLsMcicQcE5pyLPtMZK+RuJAtmAnGC7L9s40P9UIquLg+?=
 =?us-ascii?Q?fjEnzBOBYqCFmcH2l3u/E2bb5PUDREsz38IRpWtQy7D5ppSQTa9WGvFK8lch?=
 =?us-ascii?Q?pFrICK2Qch0VwGNnGr73NkqJ8qoLJXkmejCdKVwIVIoWRIflU59ZiDrAYV1Z?=
 =?us-ascii?Q?W30jZ9j1kOU4Q7o+G43egUF+hIiq9XJrCnOUASDOuV6EGEBoXq6US3gPUaaT?=
 =?us-ascii?Q?kUlRCcG0zQvFrrH/9xytLAgtETxgYAPeaSLRC4RqRZLb8BZ/dn/1Rl4wyNMX?=
 =?us-ascii?Q?lO7+ABmzHinWZvssb4K6XPusNfmRi6cI1Gxuxfgw0o5KGS5mWOcNpedmyRuK?=
 =?us-ascii?Q?JZ1Fb0ff4vBXPiKo0GeYwJDG+prxcA05JGeiK8RNwh5KVAeUFyrT36aKq0ag?=
 =?us-ascii?Q?WYJPF7CL9KdCd4njQDYm1lgjdpiYgHm4K4DOvX9nX5qxfCSo0gp4Yi9klMRW?=
 =?us-ascii?Q?n9y+sQ1PlTflVxzPpvJVhGFeP+d6GDE9CDFGZgqA21LmdPTyj0wO6WSGbrNK?=
 =?us-ascii?Q?i1utfk2ms7pwcyJZRNmEQxJbib8DohOagzqe81V5iLJXc+hhLZW/3iITi6+V?=
 =?us-ascii?Q?JUUl3+4Avlpq7yxuYZTyW17TxUN+QuqtN7D+eau7hAoe7pksOhjn5c3IEghw?=
 =?us-ascii?Q?+BPA29zbSDg7sm9Hmwy8nt2V7gLBBAqXgifG4A8n0dQsvpu3Tev0jAVuv8dV?=
 =?us-ascii?Q?lgKNwosVF+npdw6iE4p53vAOK3bgE4RmlW0RL+8Zdl8JiEyyTSPbQAFqzD0S?=
 =?us-ascii?Q?iRWoYoXZ4ilR7gD2WeHpzR5ePjR6RbN3SNRdmYHH4N+Z9LDVhRJ1zDK143dr?=
 =?us-ascii?Q?YB+Pb0zIVipm5HcWIo52cFy8M+viTT5JiBBQRGJvOn/vrsQsoehR5mfSH1s8?=
 =?us-ascii?Q?rOEosWpFmgxzqxXaauejG0EI4/jJicuPvVwntwMvpNCgNOPf/ZGE/TGkdTlW?=
 =?us-ascii?Q?kLw0ZxqEW4L1q5P+eXC14qTSVyV1zsiAr20cRl7gR5pTONFNcmfCFiwCQAly?=
 =?us-ascii?Q?jrX58t87hhBlUsDbLoaM1Q7r4b8NKhZvuKs3oX6G?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5055D49C8290B0F27DE15B9BEC682DM4PR12MB5055namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5055.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2c02ec-2cec-4bc4-e8a3-08dcdc9fee2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 13:51:03.3440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yjiZy3qq1qIDHWIfiheFlzQcl5FquMZyFasYyq6d+Cn1X8yNa6iWF/2dDuDCOIJI7PI6ypBQswgME5A5UqddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

--_000_DM4PR12MB5055D49C8290B0F27DE15B9BEC682DM4PR12MB5055namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Vignesh.Chander@amd.com
Verified-by: Vignesh.Chander@amd.com

________________________________
From: Lijo Lazar <lijo.lazar@amd.com>
Sent: Tuesday, September 24, 2024 2:02:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Chander, Vignesh <Vignesh.Chander@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Show current compute partition on VF

Enable sysfs node for current compute partition mode on VFs also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 299c4461b606..fdc9656efdd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1612,21 +1612,46 @@ static DEVICE_ATTR(available_compute_partition, 044=
4,

 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
+       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
+       bool xcp_switch_supported;
         int r;

+       if (!xcp_mgr)
+               return 0;
+
+       xcp_switch_supported =3D
+               (xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
+
+       if (!xcp_switch_supported)
+               dev_attr_current_compute_partition.attr.mode &=3D
+                       ~(S_IWUSR | S_IWGRP | S_IWOTH);
+
         r =3D device_create_file(adev->dev, &dev_attr_current_compute_part=
ition);
         if (r)
                 return r;

-       r =3D device_create_file(adev->dev, &dev_attr_available_compute_par=
tition);
+       if (xcp_switch_supported)
+               r =3D device_create_file(adev->dev,
+                                      &dev_attr_available_compute_partitio=
n);

         return r;
 }

 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
+       struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
+       bool xcp_switch_supported;
+
+       if (!xcp_mgr)
+               return;
+
+       xcp_switch_supported =3D
+               (xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
         device_remove_file(adev->dev, &dev_attr_current_compute_partition)=
;
-       device_remove_file(adev->dev, &dev_attr_available_compute_partition=
);
+
+       if (xcp_switch_supported)
+               device_remove_file(adev->dev,
+                                  &dev_attr_available_compute_partition);
 }

 int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c100845409f7..52322ca754c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1165,12 +1165,9 @@ static int gfx_v9_4_3_sw_init(void *handle)
         if (r)
                 return r;

-
-       if (!amdgpu_sriov_vf(adev)) {
-               r =3D amdgpu_gfx_sysfs_init(adev);
-               if (r)
-                       return r;
-       }
+       r =3D amdgpu_gfx_sysfs_init(adev);
+       if (r)
+               return r;

         gfx_v9_4_3_alloc_ip_dump(adev);

@@ -1201,8 +1198,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
         gfx_v9_4_3_mec_fini(adev);
         amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
         gfx_v9_4_3_free_microcode(adev);
-       if (!amdgpu_sriov_vf(adev))
-               amdgpu_gfx_sysfs_fini(adev);
+       amdgpu_gfx_sysfs_fini(adev);
         amdgpu_gfx_sysfs_isolation_shader_fini(adev);

         kfree(adev->gfx.ip_dump_core);
--
2.25.1


--_000_DM4PR12MB5055D49C8290B0F27DE15B9BEC682DM4PR12MB5055namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto">Reviewed-by: Vignesh.Chander@amd.com&nbsp;</div>
<div dir=3D"auto">Verified-by: Vignesh.Chander@amd.com&nbsp;</div>
<div><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lijo Lazar &lt;lijo.l=
azar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 24, 2024 2:02:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Chander, Vignesh &lt;Vignesh.Chander@am=
d.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Show current compute partition on V=
F</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable sysfs node for current compute partition mo=
de on VFs also.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++++++++++-=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++------<br>
&nbsp;2 files changed, 31 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 299c4461b606..fdc9656efdd3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -1612,21 +1612,46 @@ static DEVICE_ATTR(available_compute_partition, 044=
4,<br>
&nbsp;<br>
&nbsp;int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xcp_mgr *xcp_mgr =3D ad=
ev-&gt;xcp_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool xcp_switch_supported;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xcp_mgr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_switch_supported =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (xcp_mgr-&gt;funcs &amp;&amp; xcp_mgr-&gt;funcs-&gt;switch_parti=
tion_mode);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xcp_switch_supported)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_attr_current_compute_partition.attr.mode &amp;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~(S_IWUSR | S_IW=
GRP | S_IWOTH);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D device_create_file(a=
dev-&gt;dev, &amp;dev_attr_current_compute_partition);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D device_create_file(adev-&gt;dev=
, &amp;dev_attr_available_compute_partition);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcp_switch_supported)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D device_create_file(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
amp;dev_attr_available_compute_partition);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_xcp_mgr *xcp_mgr =3D ad=
ev-&gt;xcp_mgr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool xcp_switch_supported;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xcp_mgr)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_switch_supported =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (xcp_mgr-&gt;funcs &amp;&amp; xcp_mgr-&gt;funcs-&gt;switch_parti=
tion_mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&g=
t;dev, &amp;dev_attr_current_compute_partition);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp=
;dev_attr_available_compute_partition);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xcp_switch_supported)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_available_c=
ompute_partition);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev=
)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index c100845409f7..52322ca754c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -1165,12 +1165,9 @@ static int gfx_v9_4_3_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_gfx_sysfs_init(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gfx_sysfs_init(adev);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_alloc_ip_dump(a=
dev);<br>
&nbsp;<br>
@@ -1201,8 +1198,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_mec_fini(adev);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;adev-=
&gt;gfx.rlc.clear_state_obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_free_microcode(=
adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_sysfs_fini(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_sysfs_fini(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_sysfs_isolation=
_shader_fini(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;gfx.ip_dump=
_core);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5055D49C8290B0F27DE15B9BEC682DM4PR12MB5055namp_--
