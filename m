Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 16:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB9C10E234;
	Thu, 16 Dec 2021 16:39:08 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D872A10E234
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 16:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy6d4Xi4Li4OARgDFJZklvyxcG5PNYF8EIck8LXEXqCQvvWHRrI74pr30slcFyHtCup4Ecxp0k+S0m2seAu61N1byrD65iTI1cn69m35HkV9lhnLgk/2Eg6nNJSbEVyIyapIIberDv22End6Ahl9lZEz7LL2/hhn6dlW0ni+2acqzF7+mqZgI9nOArajnlGziBzt5IfN6W60EOLXMT6ddaNT5cmeM8OZ2cP79CDnar1Njs4IwmVpc2sxO4yvtmuMZj56HBOh+lwtg7wgaq6AA4XaWf75MGXnO1ErIDqi0akj0EWwkT9daI/TpXkVC6CPSVLfCo0RaQtnv4FBwA3waQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCI8FTMncHPKBRhSxXxmxCBVBb0HD1hpFjb+GIFmzMk=;
 b=nfdLkalKRatPGEUWdk9F9ubegeIur/H3BJ12e4kMDj6TxfsZWzkDkD8R+B7lzE6yWaYrcGv5FHbN4mrwllnroUeeODFm5hO1H49gkRCPfM7xV5wK/lyX8UzvljylvU56e1nCHrAoy8O+RDJJ8upjfnYRTqxx2zBM/XyYYfk0qWYc49daXjpZSvJiYE3gMR0geYKaQ+WvKo1SwGp8/gx2PIjEd/l72Q0LP7HCOxSZBHUqIezy4kMWfFOcqHvfFukB2ZQg1kbkqpOi51G35D77ZCzIjn7Jxf5VGaCCAHz5sruC1Z4QvKNknTcyuZ/LReLBH2ES0/I7nJSN5kgTqCKZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCI8FTMncHPKBRhSxXxmxCBVBb0HD1hpFjb+GIFmzMk=;
 b=Er+JCFSSYT7HFS268D6G+ifIGZ9TFem36U6eujtkpH93ayzVTVFV6m1vU9CqX0uZuhewQ2/EF2V+g1QQ962dGChGDIb+SxNdzW5EmGN5TTIKGrEutCeyw5HLQRy29/tgTcy05KBJGokCvw7zKvkwv+KqdcH+HBjaFesnYb+21XA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 16:39:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%5]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 16:39:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support for IP discovery gc_info table v2
Thread-Topic: [PATCH] drm/amdgpu: add support for IP discovery gc_info table v2
Thread-Index: AQHX8iuUmRScVVC1X0aUY4DDM/QRUKw1Um/Q
Date: Thu, 16 Dec 2021 16:39:04 +0000
Message-ID: <BN9PR12MB5257BE7661BA22784E442433FC779@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211216031758.177296-1-alexander.deucher@amd.com>
In-Reply-To: <20211216031758.177296-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f057b6e9-d053-487f-9723-0e106bdb56a2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T16:38:43Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d80d2381-a374-4a9b-0c5d-08d9c0b292a8
x-ms-traffictypediagnostic: BN9PR12MB5100:EE_
x-microsoft-antispam-prvs: <BN9PR12MB51002D023102167F86DDD895FC779@BN9PR12MB5100.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zF/IhavsPkTGFglhCvAO1HO/ZO4ZKOLWFy09LUifZ6ccMsQYDmR2ct6GUi9SIeHji3+9V2F6ohbMmlyQ6+MNiavfR3sVTrRHzzkJ44bWC8GKvH/4gSrm1km+QJgBd+f20lTUkkVN8XRLB9CX51PE0HxgROZCRARHmA9CveYClZKlvv7C6BCMguzHj2i9xXcZfdhFkL2C/0h7YIWR/ZUPWvtbmwZSwBvniyXw/7Iszus8UhzFDWX2FJkfimBZCmRV97XU+fM+d3CYgPD+Pk/oRNVs+ws+OxPCLhFuU9a79EQuJIGEpuCZKF4cZN+cjPreBDmCl/6jE57sGSgfQAlpnUeTeNC2x6DP87iNGEzWaQtzoRFvkptKm57x9GNnnPoQJYLlGxBaPXoowsGZf1zjhtSxZrPKIDDCdlDEcyPGJRXZWx+VVuq7L378IC5eYGFnCOsQlHofu183fhTjA8WMEBGtMnM4GPJtCHEYmxSpaSThaJ1zN0vqdnbjKAdmo9DuyoNYZCsBG1KocThrn0ydr39nMkJ8tO+hG5EZpuQz2m23b/qu7WxP7UgWNKiqHa67EZAeOkopEeg4kspZA+1DpGYg4ei/2H6/MY/SSlHBmdtPkVA8aF26hjMFXO6/kIVaBM4c2bfImKJ9xNmKtpjmjn8sWL1P384PJ1lZeu2xcFaFNib0yoYakCxY/21BQJwA1ntU0a2jmwVR8oWhJPhynQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(38100700002)(7696005)(53546011)(110136005)(6506007)(5660300002)(316002)(122000001)(83380400001)(38070700005)(8676002)(66446008)(2906002)(26005)(52536014)(66556008)(64756008)(66476007)(33656002)(55016003)(66946007)(8936002)(45080400002)(76116006)(186003)(86362001)(9686003)(71200400001)(966005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xCtwwUNG4QMHrHiklGGNrFaJ6lZj62W7yXNQOhRAQ79ZgH4U0hKCYIAcwtti?=
 =?us-ascii?Q?NI/Nt9ZcuDdWyQkWk8LSIgVdOMCSwd0rW4JVU0wxWC8efy67KL3Y8zPCjzpA?=
 =?us-ascii?Q?PVTiwUZ3FZ+0pKtuCil3pYMSTl008dlTXqCqQ41IW1wLBwylnGL5Gov3KBsp?=
 =?us-ascii?Q?VfXhx7IYSUz6wPlj3qD9R6XOxtbHz4+p/jq/oTmumpEOVmA4m56r7pCCr3fp?=
 =?us-ascii?Q?vC1QTv78Hu0vnukFp3VFkdumnz7UlmHG8XDYFYesNofeIXULfC/LJMUqyiFT?=
 =?us-ascii?Q?mOFdl5sMqcyMp1eYmulvF/cMr93+gozuXLMCHRKVTFmFUUsQtVd2RA9PnESi?=
 =?us-ascii?Q?Lv9p7g8qhGGU0Mf8LVUGfqbKYq+36nOh3MiT4kyckv/5WynXyxWnmRk7WcNs?=
 =?us-ascii?Q?dXF75wKU5gHjIwGtahuvztFLBZXAFSwKq3Mrpmyz/CA5ciHsIosAV9v6XH5T?=
 =?us-ascii?Q?MRljrKrZ8gyfjvTJw732OFtan/DBbbJBiBWY2Qc7LuNKWm1qfbBgogGsZFm6?=
 =?us-ascii?Q?wUFeEkfMWZg9WnAOhJbieR+H7tEbQW5hlU28FEkNnYmJ5IuyJmI+9wZLBpQt?=
 =?us-ascii?Q?aez9hPC6bLE6mVjiIIhLigpOD2SSi+FzA4EwHy5D5M1l8uVuGsyaoKKTsVnC?=
 =?us-ascii?Q?IbB/wIBjgZpZSCYIyBUnnQXcPkZjDhrzw+eWMnIRcn85KYEX2Tf8HSX/68dz?=
 =?us-ascii?Q?5UO1L3XTpsHmUz5YOWWaoeiyDNc/DMYKK0e/J3to9rOS1jCwbB+uMcc+IPoP?=
 =?us-ascii?Q?LHLgyLcfLRMNqpvqCDLsmxZwoVUcUypXCfyGSXXxbp/ssvPs9UOIcgb4uZ7x?=
 =?us-ascii?Q?yMcuMxSM59o6nRnM3QqxYF5ARrZhkCxcSkOpxIeOmz5FAHd69yRiV67oJm7V?=
 =?us-ascii?Q?uOL4S+V60GRlRxSkZ5fyYSpQFECM+9TL6PI5cXKQ4gYibF7m4GxJ6a0iuyBv?=
 =?us-ascii?Q?z3A9pmPcnzvToelzR7jI4Do+8wy6Fpvbgt/OTPc1DVqevWYmUdwwrDgedvz3?=
 =?us-ascii?Q?Ag2Sqs3mHc+zMgTLikN/5nRsCEYkCCzjHkP+5Tl15pwOjsPhWgjC90BI0OMk?=
 =?us-ascii?Q?W/Z4eYC28uz996OVFt+1nx81jzSVRgmZSaM8h5ZvZmzGnbl3T72qFNQGtZyr?=
 =?us-ascii?Q?IF7Oz178YNOqUD3av9hXtc6E/H6VjBh1IAo9IDlsGf9OwZu6B9eI5XEJqvgJ?=
 =?us-ascii?Q?egxjzZPsdZs7O3c+RtFBBeelKX5Lvl+Jabr4UV25o9ZfCZAjDmHKpnaItPac?=
 =?us-ascii?Q?GPu9PNNid2thQU0mOGmqKkY7fXSq/fqzskrWbtftKodffE0oQSoYsia0QoUT?=
 =?us-ascii?Q?4q00sLrU16JOeElPS7Z6NwPepwzlwdgVKz9nlFKSVMzrT8CSJRly44gIbrkF?=
 =?us-ascii?Q?lmFbBnte7kQZBJtrIM3CKUAvOizbBT6v9mZ9TYP+vwTXkctap/Dr9lwCL/gF?=
 =?us-ascii?Q?B5r68dWxGl/18PMJaHYEYYpUw7Eup08kNvdaKzjB2fRSAo0NVCxLqWj5i/CT?=
 =?us-ascii?Q?iJWWXhsosCa1DY+bh9RSY6aPNwb9BaS9F6PJojBI6WH0akw2SnuvrxueH/Ha?=
 =?us-ascii?Q?6V7EzND39yzSuCFhFuurxoD+xIt1vtKZhg6SMti6cVUswQqi5/A0sNP/AcG/?=
 =?us-ascii?Q?wTUyds2vDMwtBRHBqW2LmKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80d2381-a374-4a9b-0c5d-08d9c0b292a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 16:39:04.5272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrXGmalmJpVCb7AmoxX2ZEGsEYb8SofCUl8NBv+MssdIDQMAWUriJeF7//q2IPCDPSixnCTmSKPaZQ8BRjRe/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, December 16, 2021 11:18
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add support for IP discovery gc_info table v2

Used on gfx9 based systems. Fixes incorrect CU counts reported in the kerne=
l log.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1833&amp;data=3D04%7C01%7Ch=
awking.zhang%40amd.com%7Cc4c2b58360d7438212e908d9c042b574%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637752215012895865%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;s=
data=3DkZXixshnxu1G3MhOwQW%2B2tJUiAmRbPjmx3qHGJ4XcNg%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 76 +++++++++++++------
 drivers/gpu/drm/amd/include/discovery.h       | 49 ++++++++++++
 2 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index ea00090b3fb3..bcc9343353b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -526,10 +526,15 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device=
 *adev)
        }
 }

+union gc_info {
+       struct gc_info_v1_0 v1;
+       struct gc_info_v2_0 v2;
+};
+
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)  {
        struct binary_header *bhdr;
-       struct gc_info_v1_0 *gc_info;
+       union gc_info *gc_info;

        if (!adev->mman.discovery_bin) {
                DRM_ERROR("ip discovery uninitialized\n"); @@ -537,28 +542,=
55 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
        }

        bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
-       gc_info =3D (struct gc_info_v1_0 *)(adev->mman.discovery_bin +
+       gc_info =3D (union gc_info *)(adev->mman.discovery_bin +
                        le16_to_cpu(bhdr->table_list[GC].offset));
-
-       adev->gfx.config.max_shader_engines =3D le32_to_cpu(gc_info->gc_num=
_se);
-       adev->gfx.config.max_cu_per_sh =3D 2 * (le32_to_cpu(gc_info->gc_num=
_wgp0_per_sa) +
-                                             le32_to_cpu(gc_info->gc_num_w=
gp1_per_sa));
-       adev->gfx.config.max_sh_per_se =3D le32_to_cpu(gc_info->gc_num_sa_p=
er_se);
-       adev->gfx.config.max_backends_per_se =3D le32_to_cpu(gc_info->gc_nu=
m_rb_per_se);
-       adev->gfx.config.max_texture_channel_caches =3D le32_to_cpu(gc_info=
->gc_num_gl2c);
-       adev->gfx.config.max_gprs =3D le32_to_cpu(gc_info->gc_num_gprs);
-       adev->gfx.config.max_gs_threads =3D le32_to_cpu(gc_info->gc_num_max=
_gs_thds);
-       adev->gfx.config.gs_vgt_table_depth =3D le32_to_cpu(gc_info->gc_gs_=
table_depth);
-       adev->gfx.config.gs_prim_buffer_depth =3D le32_to_cpu(gc_info->gc_g=
sprim_buff_depth);
-       adev->gfx.config.double_offchip_lds_buf =3D le32_to_cpu(gc_info->gc=
_double_offchip_lds_buffer);
-       adev->gfx.cu_info.wave_front_size =3D le32_to_cpu(gc_info->gc_wave_=
size);
-       adev->gfx.cu_info.max_waves_per_simd =3D le32_to_cpu(gc_info->gc_ma=
x_waves_per_simd);
-       adev->gfx.cu_info.max_scratch_slots_per_cu =3D le32_to_cpu(gc_info-=
>gc_max_scratch_slots_per_cu);
-       adev->gfx.cu_info.lds_size =3D le32_to_cpu(gc_info->gc_lds_size);
-       adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->gc_num_sc_p=
er_se) /
-                                        le32_to_cpu(gc_info->gc_num_sa_per=
_se);
-       adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_info->gc_num_=
packer_per_sc);
-
+       switch (gc_info->v1.header.version_major) {
+       case 1:
+               adev->gfx.config.max_shader_engines =3D le32_to_cpu(gc_info=
->v1.gc_num_se);
+               adev->gfx.config.max_cu_per_sh =3D 2 * (le32_to_cpu(gc_info=
->v1.gc_num_wgp0_per_sa) +
+                                                     le32_to_cpu(gc_info->=
v1.gc_num_wgp1_per_sa));
+               adev->gfx.config.max_sh_per_se =3D le32_to_cpu(gc_info->v1.=
gc_num_sa_per_se);
+               adev->gfx.config.max_backends_per_se =3D le32_to_cpu(gc_inf=
o->v1.gc_num_rb_per_se);
+               adev->gfx.config.max_texture_channel_caches =3D le32_to_cpu=
(gc_info->v1.gc_num_gl2c);
+               adev->gfx.config.max_gprs =3D le32_to_cpu(gc_info->v1.gc_nu=
m_gprs);
+               adev->gfx.config.max_gs_threads =3D le32_to_cpu(gc_info->v1=
.gc_num_max_gs_thds);
+               adev->gfx.config.gs_vgt_table_depth =3D le32_to_cpu(gc_info=
->v1.gc_gs_table_depth);
+               adev->gfx.config.gs_prim_buffer_depth =3D le32_to_cpu(gc_in=
fo->v1.gc_gsprim_buff_depth);
+               adev->gfx.config.double_offchip_lds_buf =3D le32_to_cpu(gc_=
info->v1.gc_double_offchip_lds_buffer);
+               adev->gfx.cu_info.wave_front_size =3D le32_to_cpu(gc_info->=
v1.gc_wave_size);
+               adev->gfx.cu_info.max_waves_per_simd =3D le32_to_cpu(gc_inf=
o->v1.gc_max_waves_per_simd);
+               adev->gfx.cu_info.max_scratch_slots_per_cu =3D le32_to_cpu(=
gc_info->v1.gc_max_scratch_slots_per_cu);
+               adev->gfx.cu_info.lds_size =3D le32_to_cpu(gc_info->v1.gc_l=
ds_size);
+               adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v1.=
gc_num_sc_per_se) /
+                       le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
+               adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_info-=
>v1.gc_num_packer_per_sc);
+               break;
+       case 2:
+               adev->gfx.config.max_shader_engines =3D le32_to_cpu(gc_info=
->v2.gc_num_se);
+               adev->gfx.config.max_cu_per_sh =3D le32_to_cpu(gc_info->v2.=
gc_num_cu_per_sh);
+               adev->gfx.config.max_sh_per_se =3D le32_to_cpu(gc_info->v2.=
gc_num_sh_per_se);
+               adev->gfx.config.max_backends_per_se =3D le32_to_cpu(gc_inf=
o->v2.gc_num_rb_per_se);
+               adev->gfx.config.max_texture_channel_caches =3D le32_to_cpu=
(gc_info->v2.gc_num_tccs);
+               adev->gfx.config.max_gprs =3D le32_to_cpu(gc_info->v2.gc_nu=
m_gprs);
+               adev->gfx.config.max_gs_threads =3D le32_to_cpu(gc_info->v2=
.gc_num_max_gs_thds);
+               adev->gfx.config.gs_vgt_table_depth =3D le32_to_cpu(gc_info=
->v2.gc_gs_table_depth);
+               adev->gfx.config.gs_prim_buffer_depth =3D le32_to_cpu(gc_in=
fo->v2.gc_gsprim_buff_depth);
+               adev->gfx.config.double_offchip_lds_buf =3D le32_to_cpu(gc_=
info->v2.gc_double_offchip_lds_buffer);
+               adev->gfx.cu_info.wave_front_size =3D le32_to_cpu(gc_info->=
v2.gc_wave_size);
+               adev->gfx.cu_info.max_waves_per_simd =3D le32_to_cpu(gc_inf=
o->v2.gc_max_waves_per_simd);
+               adev->gfx.cu_info.max_scratch_slots_per_cu =3D le32_to_cpu(=
gc_info->v2.gc_max_scratch_slots_per_cu);
+               adev->gfx.cu_info.lds_size =3D le32_to_cpu(gc_info->v2.gc_l=
ds_size);
+               adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v2.=
gc_num_sc_per_se) /
+                       le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
+               adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_info-=
>v2.gc_num_packer_per_sc);
+               break;
+       default:
+               dev_err(adev->dev,
+                       "Unhandled GC info table %d.%d\n",
+                       gc_info->v1.header.version_major,
+                       gc_info->v1.header.version_minor);
+               return -EINVAL;
+       }
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/=
include/discovery.h
index 7ec4331e67f2..a486769b66c6 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -143,6 +143,55 @@ struct gc_info_v1_0 {
        uint32_t gc_num_gl2a;
 };

+struct gc_info_v1_1 {
+       struct gpu_info_header header;
+
+       uint32_t gc_num_se;
+       uint32_t gc_num_wgp0_per_sa;
+       uint32_t gc_num_wgp1_per_sa;
+       uint32_t gc_num_rb_per_se;
+       uint32_t gc_num_gl2c;
+       uint32_t gc_num_gprs;
+       uint32_t gc_num_max_gs_thds;
+       uint32_t gc_gs_table_depth;
+       uint32_t gc_gsprim_buff_depth;
+       uint32_t gc_parameter_cache_depth;
+       uint32_t gc_double_offchip_lds_buffer;
+       uint32_t gc_wave_size;
+       uint32_t gc_max_waves_per_simd;
+       uint32_t gc_max_scratch_slots_per_cu;
+       uint32_t gc_lds_size;
+       uint32_t gc_num_sc_per_se;
+       uint32_t gc_num_sa_per_se;
+       uint32_t gc_num_packer_per_sc;
+       uint32_t gc_num_gl2a;
+       uint32_t gc_num_tcp_per_sa;
+       uint32_t gc_num_sdp_interface;
+       uint32_t gc_num_tcps;
+};
+
+struct gc_info_v2_0 {
+       struct gpu_info_header header;
+
+       uint32_t gc_num_se;
+       uint32_t gc_num_cu_per_sh;
+       uint32_t gc_num_sh_per_se;
+       uint32_t gc_num_rb_per_se;
+       uint32_t gc_num_tccs;
+       uint32_t gc_num_gprs;
+       uint32_t gc_num_max_gs_thds;
+       uint32_t gc_gs_table_depth;
+       uint32_t gc_gsprim_buff_depth;
+       uint32_t gc_parameter_cache_depth;
+       uint32_t gc_double_offchip_lds_buffer;
+       uint32_t gc_wave_size;
+       uint32_t gc_max_waves_per_simd;
+       uint32_t gc_max_scratch_slots_per_cu;
+       uint32_t gc_lds_size;
+       uint32_t gc_num_sc_per_se;
+       uint32_t gc_num_packer_per_sc;
+};
+
 typedef struct harvest_info_header {
        uint32_t signature; /* Table Signature */
        uint32_t version;   /* Table Version */
--
2.33.1

