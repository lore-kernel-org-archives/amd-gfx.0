Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E37C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 15:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2248710E09B;
	Thu, 20 Mar 2025 15:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v9HKB/fz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7213E10E09B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 15:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyf9kB2uXG507MRaZq+D6kb0k2pYVbDKMmbHxPoB8VqKWumZqjNieoSa9XuYmQRKcTeFt2mqDxaUfgvYBKh98gPges12YgoC4o8u3GYTKEFqyhP0U8iz2G6H0kIZS8T8JdRxtqdlPNOUVm6+gyx3aBpc9G8HUGpVGkO68by3NkJEZ+1YZQfezD/mCrtmyxGhKU3BWrbS5Lay8xyFvWTKIioFtfD8s/9gkXV8WIuFTfQd92mttq/p9WqeUXGBtEo2PuJ9JTjrz4btINBW6kaoXfaSFwiBdEVSzBJqTY0sL+V1ya6wAwKuwJWss1Gc+Y1nxiUO6Gds3rYyeZSAQKREfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP4rBHMd6NN1j6AOG/kwHd2zBYm0Qe8qHxDf9j0r2Rw=;
 b=OqQ91bkIsDrEQdcGWkFeugsGqG0Oc7aJMW300/a06wK7QrlX28Te1poFa06oNzQmCYHPIR2yNdWh7gy7C9mGUbRHeZQXBOolLLNh+rdR32Ot6cpCaiZ2/KhGzVbmVWrWxh3vRN6RLejazcW7aUmh8gZCJmabSrlbY9Q3bc2NxoeyAGa48HITGsBDPI+lKA/VD5ocYMi0rIaFolabiHLIZAHWlancBCoN2Fi4O7W0dyzOKftvL2ozVDeTefHnjyeY5aXAF4nn4Vt3pQn3428iTBqOUICobyVgvc+jV1hVzL1HzOM5rb3Rhz8zNgj8E5GN4c1yg+ezKX+4avxA5GjX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP4rBHMd6NN1j6AOG/kwHd2zBYm0Qe8qHxDf9j0r2Rw=;
 b=v9HKB/fzcHRqWVNLLV5cixhvQL9q+FCKsO50ovyrEV3yKT3c7tC5OT6cyqjwavyBI3SBRolUlzUsxAi3wscu4v6/+LUBspyoqkh4Lmgd34VYoViqjudZ9TrsFaEznbifDyoUpEq1rWFFXqRZqQ9A27IAZcyOP2nrQtjpPTihgtg=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:37:55 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:37:54 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/mes: warn on unexpected pipe numbers
Thread-Topic: [PATCH 3/3] drm/amdgpu/mes: warn on unexpected pipe numbers
Thread-Index: AQHbmaO0l0IsB0/rDU+sZWu+o1FsYrN8KK+A
Date: Thu, 20 Mar 2025 15:37:54 +0000
Message-ID: <CH0PR12MB537218ED621D32F0EE48527CF4D82@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250320142306.1135063-1-alexander.deucher@amd.com>
 <20250320142306.1135063-3-alexander.deucher@amd.com>
In-Reply-To: <20250320142306.1135063-3-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=acd2fe04-66bc-4a41-a49b-3a6a71f1cd7a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T15:37:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CY8PR12MB8194:EE_
x-ms-office365-filtering-correlation-id: 613e855a-dcbd-495b-e506-08dd67c52ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EkkiRZoh0pVJBwIP6AEck/5qIYVeQEQ+1nSfdtHj2GJI2dTGiLBGOw/7alyy?=
 =?us-ascii?Q?DZsJt4m2vFnsR8elCIl7crv4TVN3hc9dxyH5o+LOm7LhUgVdMX5pr73SoZCn?=
 =?us-ascii?Q?puP8cWhlJ1wm/lHOPC2LqflYgrBQOW+FH7j0DtXiX40b1vP1wTUjc7UQOeLF?=
 =?us-ascii?Q?nixNw+IDMHrMGOwPZJmRoyLcFJF11ruQ6ELFmZqkAGXqJA2X/obkH8iMXLYF?=
 =?us-ascii?Q?BLMhyOKpLL7oNpczuDM5mJlPlU5ph7s8j50wMLsVqvn2LK7OFUGZ7YG/oC65?=
 =?us-ascii?Q?+wPvm1xLdWnwwt7XY4gYzUZLtl52LQ+7LrqK26S0nphHjepL4iN08pK74Zj5?=
 =?us-ascii?Q?y6qhZXxupWnMlE40sDvWFJFXjV8eCHju/ceonSsFsiRH/+fyoNhuUpkYVjun?=
 =?us-ascii?Q?NAgD+Yj9SjvcDiWEN3qVVeA7OLFUEdPCxhvUdyTYZQ0+/rpxyNpzf1RMwhrn?=
 =?us-ascii?Q?yUf+ET/IokYN96AedlKFQilkX4kR0X0hitwyg1VKjy6PdAR0zT6EtrUUGtUh?=
 =?us-ascii?Q?nN5z/vwh/EfEZ8wFl9GE4gOxagT1W7GB/RAvHTHgddybrXnVdvnld7rgsWgM?=
 =?us-ascii?Q?D5XKFfXE5OW+LFW8w+TfKPHQIpk7ixBOqvbFLeSmnmzOuu2rgxUsCXsKWoa/?=
 =?us-ascii?Q?VfYL8yhsHpQCnQ8WeHK5uHc5ApDmS8F41xiicqEQD/zR1sU8zDEtms2jtWuu?=
 =?us-ascii?Q?dYo7RO+thJQ1BGK+Seg4t2u0+Q8AGHyM22ekDyZOe+WtSY6xwDeDVCQRzEzr?=
 =?us-ascii?Q?qoMMvgxBZZ0FMx7K1eyUn++zD7aG5vta4QDAZMXPjEgBSo3j2nqojx/AU2fo?=
 =?us-ascii?Q?hhr83NST5RY5MVvuNIRrgHoAe9YMZ1OWtziSON+jwGYOBA7F/At9PPu8pAFf?=
 =?us-ascii?Q?qU5iu1isMQxURW3jkAyjOTvU9l055ZpXY8jWckgR9f3d0PrZGCs5Xi75cHlC?=
 =?us-ascii?Q?8C48rWb7xHAjfKcYib3clYqFx2ySmwdwG9FtMB2OJY6V8ahvUvVUbGdIuvG8?=
 =?us-ascii?Q?o1OTRuxMkc16yl5THUXGUxQXArnmuPxeRXcYQaffHjrNHZDtjfaYgiiO9R03?=
 =?us-ascii?Q?0mu2hw/BGFt4b5kt9qiHcVYCz0mfZTgq3AKNK3sB3g7PE+YtgMBmFTo+De1w?=
 =?us-ascii?Q?4r+egPo8JI7Vb2sYXkhEiaZCXVyUaBRYrioz0tolhzkQtwcfnAIU4D4ln54O?=
 =?us-ascii?Q?sbp/qVuK7vOdroIwuX2bAVvgnU6AUcISVXzbiPQFH78fLs6qkAn05Yua3Uwr?=
 =?us-ascii?Q?PX5Oguuvo3RRF3FsQoq4Xy0Lb23zdodGGs2D/qVJ0JltduSYFLdzBlFu2bnq?=
 =?us-ascii?Q?lqnroYgvMuNwo2PduRTv00rPD97yx+4shhWCCXTmpwGkNEvz6m6uk8hhffDs?=
 =?us-ascii?Q?FlyusejxeOGu6c8DDyFySCWsnI7+90lobfhROD37tIlWbqGljdI15GRwiXCc?=
 =?us-ascii?Q?nrFlpU0eaMGaY82apSncdZ7CzKtCJfqf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZB45wCGOyAC82oTFaP4JJgcFoYtLmeMJTCVD23pwzJ+ZZ33gB91hCvYyJ/du?=
 =?us-ascii?Q?kCTgh4fZHeVOZ+02VdLFGIRUKcPYZUChatPsekSwCLhxv1PsIYFOipowCZ8w?=
 =?us-ascii?Q?Nr+4k+1kBtWb2XWdZhp7CY+ENORt1DMUxLIhDFP+J+nBD5VgVXyr3lz4rI57?=
 =?us-ascii?Q?E09SAHwp6b8iFvT9NdRRguNvUTaB4rw5dUjRW2EnLPYAKQvOemDrKtyspeT1?=
 =?us-ascii?Q?Pcn+5vOXTqCB5ZjGjKtHlPu1MZSVegInEx0ZyfngZJ4CRn3Tw9YGTALMp08u?=
 =?us-ascii?Q?hs6yXVtIEmWJUCjgfE0r9l0HVtNkxvdBSCKUqpzZTJNM2a+aDNue9ev5gVW4?=
 =?us-ascii?Q?hj4lEASkWBXnRFhekYjcPlfyhfWZR0SO+wp/gFLR6u1tq9v3NKB8BuSitLZw?=
 =?us-ascii?Q?A8VnbxPyKwLaSHLA+EMeYiHCmiqfTbC7bYsRjF5A91OYmleaaNmWgz2HKWia?=
 =?us-ascii?Q?PSLZrlLcmw/NktM31eAwdGVZO9l/sD8ros5PinkMVdZ5znHkDE9laFh0j2De?=
 =?us-ascii?Q?zVnOdcqm2ucxqMEWcuZmS2KhY1eBslL1hVfpuWD18WUlBvBATQi0Ki5Lresn?=
 =?us-ascii?Q?iPVZQAFk+774o1iP+RsZxL8KufchjmxWqzV/51HKLPOl501X3UOgFv1ARTl9?=
 =?us-ascii?Q?PLomW+R3MbvNXZk36dr+Bp6wtXZAaIJ0qU0yD+tSWnEvV1aYE5Z1kNdRfbzb?=
 =?us-ascii?Q?MMXaQ6fOdLJXNS3UCVY1bW2+qPeKNRifO3+vRaX9YLbgjdckVH+tJa+ipF9c?=
 =?us-ascii?Q?OElX/hJdrD1vchbCzq9eLaJjzHgUd9CTKrVBCkaxTXe6KNGfMdBk5Mpj9DN5?=
 =?us-ascii?Q?fS3Vs2/GmLncPSrPLfZ2JRRW9kd+GkBbxlabFaq6WgyWPzogETfUgw4b4jZB?=
 =?us-ascii?Q?LNempk/7Kkhv84ObNTAd+V5eLqx+Iv8WOGhfQ/whQp/jEWcdN6icztp9AUpP?=
 =?us-ascii?Q?J+Ql5T8TDzVIgVKPNSQBl894cT8DZAWiwDwLj4CdkHBet8CHzuD2eB2RdQ1K?=
 =?us-ascii?Q?/3WHnelF3R/gxqolK7/hLMf2BinI8eA5VnoYewkYj1dRwhk7iIIJ3hmbZ/UQ?=
 =?us-ascii?Q?ltJMactDXZKxsQGqlr6/DhXeUrtmcX9BOFSD54xwE2GNklJUt4RafwG0t/q6?=
 =?us-ascii?Q?4/x/K9lJ0/ZrwkcV+dMfG7DsEoi8xKgZyyAb5stpxc57rFc0hll9m3+y1f7R?=
 =?us-ascii?Q?zn4Zyqm3/mLA1oqmaLsrlEgx0rPa8LcDeu718r2pSfeSJUUFP8x5QKZBObQR?=
 =?us-ascii?Q?nXeHXSV2Nc8NMrDoN7BA+HMM7RLa9R8z2rJeNsYTLlQW+II4SkpzyIUNaohf?=
 =?us-ascii?Q?CiTi2Hp4xktdayl+r4H40RZPH98pVKdmPn2IDqxd5lZJaiw6XFb7t7Whd7AS?=
 =?us-ascii?Q?FHDdsQdHKiFhuyVSsvjCS1eBr6mCMbbJlrvzMBUXRzzpA5Ag7brYoIzruBiT?=
 =?us-ascii?Q?sJWlPS/pLlUcCC3SPdB9UVvNL0NCEulaXtAnQMXHF1PG9NAxzdq4THAr7rH/?=
 =?us-ascii?Q?zWh56ET2oiyaNtUS/xl/4pDCSX2jqFH59PbjvxQjnDLPP1GpQN7prqYSrkq2?=
 =?us-ascii?Q?Tf4XEYB9+c+kecxxaN4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613e855a-dcbd-495b-e506-08dd67c52ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:37:54.5244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HztwUjzyeF7akdnpDVJYTAwLa6tbzXbWn5oFxxLhCUSNoxphvL/wf7mmqwMgqRD9jehvBr1Y9VB1dEeXRd8wMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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

Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, March 20, 2025 10:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/mes: warn on unexpected pipe numbers

Warn if the number of pipes exceeds what the MES supports.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 016af4e9c35fa..c52071841226f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -90,7 +90,7 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device=
 *adev)

 int amdgpu_mes_init(struct amdgpu_device *adev)  {
-       int i, r;
+       int i, r, num_pipes;

        adev->mes.adev =3D adev;

@@ -108,8 +108,13 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
        adev->mes.vmid_mask_mmhub =3D 0xffffff00;
        adev->mes.vmid_mask_gfxhub =3D 0xffffff00;

+       num_pipes =3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
+       if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
+               dev_warn(adev->dev, "more gfx pipes than supported by MES! =
(%d vs %d)\n",
+                        num_pipes, AMDGPU_MES_MAX_GFX_PIPES);
+
        for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
-               if (i >=3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_=
me)
+               if (i >=3D num_pipes)
                        break;
                if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
                    IP_VERSION(12, 0, 0))
@@ -129,14 +134,24 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                        adev->mes.gfx_hqd_mask[i] =3D 0x2;
        }

+       num_pipes =3D adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_me=
c;
+       if (num_pipes > AMDGPU_MES_MAX_COMPUTE_PIPES)
+               dev_warn(adev->dev, "more compute pipes than supported by M=
ES! (%d vs %d)\n",
+                        num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
+
        for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
-               if (i >=3D (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.=
num_mec))
+               if (i >=3D num_pipes)
                        break;
                adev->mes.compute_hqd_mask[i] =3D 0xc;
        }

+       num_pipes =3D adev->sdma.num_instances;
+       if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
+               dev_warn(adev->dev, "more SDMA pipes than supported by MES!=
 (%d vs %d)\n",
+                        num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
+
        for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-               if (i >=3D adev->sdma.num_instances)
+               if (i >=3D num_pipes)
                        break;
                adev->mes.sdma_hqd_mask[i] =3D 0xfc;
        }
--
2.49.0

