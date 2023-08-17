Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68160C2FC04
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 05:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4AF10E3F1;
	Thu, 17 Aug 2023 05:23:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D9C10E3F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 05:23:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+QvD+Ea8x/fsM0Z0g8mdl0xw+5rSF3Ak3uPe2sbb8Nw/zGt2+36MSnENJlsyUpFHX1yIn/oPErdG2XwV1A43t4q2ro6IZa9ahRx1HJU0JgUfV2PRhodr4zmWmAYa7OVTSNDH3f9rLRl1dIWPiznkHb5ghh6LG7ry7pyGZCRVHtmq1fdHHXkC1mNygiTnZCdnJt/t3ADpj09HBlBmpRYnU7sjUb5MD696WHpasjerroWXnmgwMEoBcC8l16dh3E3uVGy0EFUKyXqdh/ZUI+lwU9Y8Qsd0I9tBifCTJiFzUeBiDSB8LSblMNicwNNtgM/Y0QinY/ZiTzx+6yg5CU9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds+fyAR1egjT+GwSZlJa9EzFnphulu9K6BQtNctU+VQ=;
 b=MHSedO1PGkflsKITiJ0r1q8/LajM7foinTjufIUD4PYNfEj9Y5Ly9PloUt1tjMKGew4Ivl/K8qSrHGeRPymIhhg/m33svE0vnbZSoyq1KWS1W4zLLlxaVrk2r18WA0Sg9ZsLwnHrwhNzurNbnoiDB+ze+FSyAuLXYsg8Dk/+4pgt8SR8u7OSAh8+I6Q7BurkVqtpTacCkHkM3+UNEP08XV87QnDHi5Iyp5mmGTHjwOsDtfd9csoQkyxTVI34HxXBLt2Rzhhpzjw3fuHKfGR2bRTVWsfPMFcfmT1OJXVhdZkUDXcPO1aqljuJjU2NJLCXkd/oJKV9LbPALSiEdwhzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds+fyAR1egjT+GwSZlJa9EzFnphulu9K6BQtNctU+VQ=;
 b=CHjJtMMTmQxxdTPwqvLlD95bNRr3xqJy+gG4jZyLQlMZkukMItSS0S++XAEFYFaOYDutOoBqpqWkF4x+Z6FaZvNfGHp63TES0W1YAQ+ksss/1nanRhKF7IoqYMWL56Y6RFp8WRH5NcTq0ah4ht2mVtsZKvHjPrxDF3sKwPNaluQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 05:23:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 05:23:52 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery
Thread-Topic: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery
Thread-Index: AQHZ0LuYHrmQHYVxSUyyvqNPZp8Kya/t9Guw
Date: Thu, 17 Aug 2023 05:23:52 +0000
Message-ID: <BN9PR12MB5257C8C61F32DAFD3642DC3CFC1AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230817033254.26780-1-le.ma@amd.com>
 <20230817033254.26780-2-le.ma@amd.com>
In-Reply-To: <20230817033254.26780-2-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4c21c404-c1e4-4b36-8158-e33b195c4574;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-17T05:23:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CO6PR12MB5458:EE_
x-ms-office365-filtering-correlation-id: 9e860d76-de8e-451a-f956-08db9ee22520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDBRnABFfq6XwznmklMTGsPlWuCxk0Tpi2nJ3wI6tKP7pMuXYSotaG/Axl5Vuzk0sJueCwxt9e40I5BjWM9sIanlItW84W6zgdXJ0K79z9e9DpHxc5XoBFnxSfkinTJtgMoIQioqt9Mfjqrp2jP3czVhKTN4YnQnCLMjXQClQOwEVlANU8P+xySlJHJ+jucvjKR+TzUqZRWfMseHBfecVyLpacaG5W6WOXjAwu9dl1QcFMGxq07xPIVmLa9c9tNcvZ4Cevmj2PyNA4whNcvuQWI3D2vrrVgblzkCCnMjMXwJPFaV4KJwf0tZA3mWG+mhBjJ4/Ds5boH5InEDlCb3xLU7SLBKaCCuYg3vInE8UwRYQtv4HFry0h1300ESAT+uYWnpHOFjjY6HudCaymhx8sIPLF3+ga1eKdbI7L5vocbj8rEmtB5M+zBP7xsSrdRO9Q1qw2hD2DrzhDPpUvXtv7T5LSxuZ2J+Rsup8836tPN3eA8GvDGEFyskpQ1F69MB4hgpQZuFzRe7mvIdrJuWFL6Rgh9cNjbFY87V/jMWJOdssIcWaZutBMYb4lrk4JWPpudyxnNEpfbYyvqgq3hABbc+LCEZM9hBQT57ec1sfP/p+70sWblpZMNiAr1IHlry
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(1800799009)(186009)(451199024)(55016003)(83380400001)(2906002)(15650500001)(478600001)(110136005)(76116006)(66946007)(66556008)(66476007)(66446008)(71200400001)(6506007)(7696005)(53546011)(64756008)(316002)(52536014)(5660300002)(26005)(9686003)(41300700001)(4326008)(8936002)(8676002)(33656002)(86362001)(38070700005)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ek8Ur2aOjetxoTaaJIUao+5QEJOLCqcJfdG9H36NPBmxBR8mxuOeLRIkbsfe?=
 =?us-ascii?Q?VV4DaiNBnEa+Djphb8HrEnIEujhgom4uYIgq1AreWu7AtcMwrF9RNcBceOZX?=
 =?us-ascii?Q?mj5DkxBtk03krTrRaslm6VFZeL6vmA/uu7EYaHP1ndc1DDBMYKebaMYGMcuR?=
 =?us-ascii?Q?/Tyf5oJlCKJZ2ZaPYOmqRAsUFhqDl+FaJwM7dxTdm817Lx3ojwFtYlUwov/1?=
 =?us-ascii?Q?7PM3L5A9yCTRmqjgdIAFj1VYYHWwvAztJhzKowtZ85hwS2wutevAVD+LWIWO?=
 =?us-ascii?Q?i6odOvAcXOWPK2wsIwh7xfhVzehWjevcFU+kbMzRszy9pwIoI2tD7k+4L7hV?=
 =?us-ascii?Q?hlUBMii2lxSOVWxSaSkWfb9XeByRfiilamUkO59808I291u0/9Q4Ju4IhKuv?=
 =?us-ascii?Q?f/Lr6zD+lAEUmGaXJjfbK/9bneADVKDUD46qDdyEUIV4L9FBO/veXbhgicPB?=
 =?us-ascii?Q?ROnpFiXlYGEZFYKWWp5K1uUL0KzAIx2bpXSo9PRYYKAo4+c/mCFMSdqsDqQm?=
 =?us-ascii?Q?O5FIpEAGOfuQbmnZAEHAfyDefMfCJbLl4Kod6KFcN+WjifQ0dsTdK5ui9t+9?=
 =?us-ascii?Q?3n/ML4NvwORl1TOg8KHlS7b67YikE76EgnDTfKYE6nzT+PTU5eenZRc90L5M?=
 =?us-ascii?Q?6xhPcHCpI2o9/YE/7iuNU6A6zPcBg4wOahjEcB4+/6pVM4+P/GxIfwINutH8?=
 =?us-ascii?Q?790CY4UNnnRVBZZUhofwSOMYcg+ZbDgT6yRgVC523Hw1SR8FwqQ43IeqM8Vu?=
 =?us-ascii?Q?yujlZRm2Jcqy+jDEW0A+8ZPjedQHNEDtziF/8q2qU8zlZZwrQrzTALlL/g9m?=
 =?us-ascii?Q?gto0ssYHBg2bwq6anxtLeU9tdQAdfNm+lnlRc53Yn2ZRjSVy8a9N1ev1HqKD?=
 =?us-ascii?Q?rqlumtSPMPFXEWuT4S7THHWjSHzOWLE1N/zOulFeAly1VuVxK/ZBgTZt2/yH?=
 =?us-ascii?Q?DgvEkna7LSDt6WdFyIpavepVrCNpeCl5EUhMZj7+fFkyQFdenVWBWG+Nec0M?=
 =?us-ascii?Q?5rV1+xWngaObR7CVAlI9TbfIHtG4cgRTtEOjB9iQ5lmODwmgOGqcGlI94ADA?=
 =?us-ascii?Q?JSFg6OMgvonIR6Ed88BF5BSAqNjVhl4o8JHZTpkcyqBKTiNBUTACS5pUwp6C?=
 =?us-ascii?Q?MY+XJH+dN7Gh8jJGBHmgIINxnaXzxpNm1dhtXP3cqPT+GS7W7STrHZdEM9Te?=
 =?us-ascii?Q?Td6MpwFkYLf3o0TweMZRvRRPLwykDhmcBx3NuqE5WzRx4cW6AhY07jmel7Ag?=
 =?us-ascii?Q?gw/qGtWgAqdSTtGlTsHE92UgmOMe5fOV0QUcmI6llNWtBLEj9Xk9YN9zgG72?=
 =?us-ascii?Q?QhM0eo8CUxtUUtxwcfgDstbyr0NIC+Pwuet3YULUeQvPRM116DT9q7NaBPRY?=
 =?us-ascii?Q?jLfIl8bhyJKvK+GRMr/47x28zi+1xEOdkIp6atHhsM40Jrg9J0XuPyfqwA3Y?=
 =?us-ascii?Q?usT4EdrW/IB22TqLIGUCRJ6ahtNIlvZ5ZDoVKEFz6SB5crrXXZ+HarO6XWMg?=
 =?us-ascii?Q?QVoL8xyEyvDksxSZ5Hkjx3lF+++LwKIqmSZ1dN7b+BJpuTuAAQAsrGiAGF12?=
 =?us-ascii?Q?E03/MaJIK1fSpJcrptkqXAqzyucR47TSsXcjx3sy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e860d76-de8e-451a-f956-08db9ee22520
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 05:23:52.5454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RM8pGhLoqLxKfS7e88WFNbYMV0x9wSCu9Tw5xjDk/04bTuKokVqbxOQ+Wqfnffc4cFXB2XE+Bm517gMKlleLcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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
Cc: "Zhang, Morris" <Shiwu.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Le Ma
Sent: Thursday, August 17, 2023 11:33
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Morris <Shiwu.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery

Several new fields are exposed in gc_info v2_1

Change-Id: Ib320e8ca70de8960634e1a22aaf2611ba7ebbaeb
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 ++
 drivers/gpu/drm/amd/include/discovery.h       | 30 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f4cd43ce251b..6ffdfc5a7c0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1390,6 +1390,7 @@ union gc_info {
        struct gc_info_v1_1 v1_1;
        struct gc_info_v1_2 v1_2;
        struct gc_info_v2_0 v2;
+       struct gc_info_v2_1 v2_1;
 };

 static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev) @@ -1=
465,6 +1466,15 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_de=
vice *adev)
                adev->gfx.config.num_sc_per_sh =3D le32_to_cpu(gc_info->v2.=
gc_num_sc_per_se) /
                        le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
                adev->gfx.config.num_packer_per_sc =3D le32_to_cpu(gc_info-=
>v2.gc_num_packer_per_sc);
+               if (gc_info->v2.header.version_minor =3D=3D 1) {
+                       adev->gfx.config.gc_num_tcp_per_sa =3D le32_to_cpu(=
gc_info->v2_1.gc_num_tcp_per_sh);
+                       adev->gfx.config.gc_tcp_size_per_cu =3D le32_to_cpu=
(gc_info->v2_1.gc_tcp_size_per_cu);
+                       adev->gfx.config.gc_num_sdp_interface =3D le32_to_c=
pu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
+                       adev->gfx.config.gc_num_cu_per_sqc =3D le32_to_cpu(=
gc_info->v2_1.gc_num_cu_per_sqc);
+                       adev->gfx.config.gc_l1_instruction_cache_size_per_s=
qc =3D le32_to_cpu(gc_info->v2_1.gc_instruction_cache_size_per_sqc);
+                       adev->gfx.config.gc_l1_data_cache_size_per_sqc =3D =
le32_to_cpu(gc_info->v2_1.gc_scalar_data_cache_size_per_sqc);
+                       adev->gfx.config.gc_tcc_size =3D le32_to_cpu(gc_inf=
o->v2_1.gc_tcc_size); /* per XCD */
+               }
                break;
        default:
                dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index a4ff515ce896..395c1768b9fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -241,6 +241,9 @@ struct amdgpu_gfx_config {
        uint32_t gc_gl1c_per_sa;
        uint32_t gc_gl1c_size_per_instance;
        uint32_t gc_gl2c_per_gpu;
+       uint32_t gc_tcp_size_per_cu;
+       uint32_t gc_num_cu_per_sqc;
+       uint32_t gc_tcc_size;
 };

 struct amdgpu_cu_info {
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/=
include/discovery.h
index b9884e576f98..7a9d473d0917 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -280,6 +280,36 @@ struct gc_info_v2_0 {
        uint32_t gc_num_packer_per_sc;
 };

+struct gc_info_v2_1 {
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
+       /* new for v2_1 */
+       uint32_t gc_num_tcp_per_sh;
+       uint32_t gc_tcp_size_per_cu;
+       uint32_t gc_num_sdp_interface;
+       uint32_t gc_num_cu_per_sqc;
+       uint32_t gc_instruction_cache_size_per_sqc;
+       uint32_t gc_scalar_data_cache_size_per_sqc;
+       uint32_t gc_tcc_size;
+};
+
 typedef struct harvest_info_header {
        uint32_t signature; /* Table Signature */
        uint32_t version;   /* Table Version */
--
2.38.1

