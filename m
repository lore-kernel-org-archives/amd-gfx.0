Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3558C27C7A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 05:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219BE10E3F6;
	Thu, 17 Aug 2023 05:50:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7B610E3F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 05:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyAArNMYHozHEEN4CCA5YgHO3mjnV2zxzhIum8/Ik+ZrqwTQBgQgzpf07TbN2LpziM4PcuCnse019SwlCX5UYMEfPDJMYDhWRBK9A+no2TCQ82BrrLhGfhU+e1LkN5s333eUtX3fd5A4bHgkjBd0YxBGN38zcMzaMgMtdklkJis1UsCzfGfh07Si/nieMBbYhTUIktJi8PXyUi11xx186qe8cJ2EmJtBhvbb2FB+0j69q9chTMCq8KuGpSCxaJUYjUUi+ovnr9olTW3nj6F1Bg+OS14QaIsGSg5tbfBTfgBVZ4vLkg+3LN/CL9t47+IQAXZ9mkt9lYjscAzES5S3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds+fyAR1egjT+GwSZlJa9EzFnphulu9K6BQtNctU+VQ=;
 b=EH2wO/mF+6wCf4HCgKj5UMeF7bkfO8XLJ5/4yfJTsTJYge4z2oZXSXhH9f+4yh6O0EY6/50x5YWKpst7xeDZKtH3LGOvKXtcQfgtTqTy9UljIE+0b5iOm297NcdiloaTVXUhj5FIeF4TSta2997a9gEEYH1UCL4v03JjNkbBbFkmm6JHyZcNuNstOyfm02XMaGy3ufaaJKMTmvM+xn+A8zNMMWSub2SJMVUkzpjwrsuLwYO6EnaMpJIOIUIZC5gb9RqWYldFTXagpnEqBf8X8eFXa8mhengCfKLZw6nvWP13dVFGG5RY2c81JKO47LkmMHw51NBHH2TF5xIHJxvEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds+fyAR1egjT+GwSZlJa9EzFnphulu9K6BQtNctU+VQ=;
 b=a1M/ecTO/1QELH+aOoz3PVggaj5XrKWd84xZbLF66fcmVbOeS2t7QTVZnCTkUnjrt/C2A5qEcIRAS95h9i6zsoFNQfIgbOluDh8+2BRgtU99A7YotnK+tcvXub74zBXWxmoF1HhLdxptDsUkvZeXOJSy04wPBHzV/Ui3McxctiI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 05:50:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 05:50:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery
Thread-Topic: [PATCH 2/2] drm/amdgpu: update gc_info v2_1 from discovery
Thread-Index: AQHZ0LuYHrmQHYVxSUyyvqNPZp8Kya/t+7pw
Date: Thu, 17 Aug 2023 05:50:06 +0000
Message-ID: <BN9PR12MB52570F76E121AA34F355BA01FC1AA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230817033254.26780-1-le.ma@amd.com>
 <20230817033254.26780-2-le.ma@amd.com>
In-Reply-To: <20230817033254.26780-2-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d25109ee-c69b-4831-b943-88214b9c57df;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-17T05:49:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6615:EE_
x-ms-office365-filtering-correlation-id: f4f50134-89a4-42f6-4068-08db9ee5cf6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5bziFcTF4FSObIhJfs48+XkD0gFNOur94uYjEPDq96MWejfZmjwfdGUEk/Zc8r/j1Y74AnbwQUOv8M8xmmx8FnaW6xFcdlt3DBwqtTFZATn/InaPa3ggK6qL30z58wwD7I16KjTfur3WxaydrMhFw8dPRU83i18yjmq2UkCQ8V1gCq7GgbZ48bX0ncXCz2e2OFA0VhAEaXTTxS2pp7YuOMgnjD97D6ZNI/7lqHHNQ5ZjFdRN2YCP7gYjd0VZECe2v/KiJXoygkC0PI9v73ETnR23AiWfW03xeb1swfZhpq/sAey0SLjdhbJ/ohlbYKkpxq4zqevU/cjQe7HyNAREp1DEZ1I//TP2v8VZ0QtleXbgY+rDNtC2QTp86SWpagusSHwjF0n8r+CmukfaNFORp6fO8EpLu2q62B2G6wO/UUEI25s4VSRT9bKhN5Ba34vcCG3h89EIB/x6O7k5Tbp4myPW/SZXxYRSupSAKJiNadfMXAJcKM145zKk0bdan7VpE37PNUzzp9vMzHhCnwHJFh4Zpyj3u3uvwdDEpflEuCA5JxVfuWxxu8rSCn5BJjA7GoCcgC5aFGPfL3hBRUsHq3LP22GdTpPm4BrmKcYrs2gupUWsLhJHyQmrAnCakls2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(186009)(451199024)(1800799009)(110136005)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(5660300002)(55016003)(41300700001)(15650500001)(2906002)(316002)(478600001)(8936002)(8676002)(52536014)(4326008)(71200400001)(7696005)(6506007)(9686003)(53546011)(83380400001)(122000001)(38100700002)(38070700005)(86362001)(33656002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NX5IroKxnin5JgKhlByY7UQcC6Q0Ol5+cOlXHb8EHdJ/yLWzHK5QmCqUDBwM?=
 =?us-ascii?Q?9HifHr/FbyYYG46ofaBHEmJA4VpMa/9D0mXPzcvHiFSZkPFHFEltz/JptkFa?=
 =?us-ascii?Q?NCNHIoaCG9v7vtXUtN/N1tuD8GguhL+ZLxXanz6+VoCJXcdqE+cUiH//SizL?=
 =?us-ascii?Q?CbImJ/Kjwy/MzcAhDEediOTi1rL9pCYYO44PiCe3wlrL4kRJWkPfpGKIONWB?=
 =?us-ascii?Q?9gUBI63SKUoGRqaqMqoBU88lmn1jjOj4RP1oTjdXqG2GqicAa/282kozBuSB?=
 =?us-ascii?Q?4gmzwcF71AQjJSZKmXZaO8C5wBeUkQTUPrYbfNpwnhzWdqldSIzWrXgwAXtk?=
 =?us-ascii?Q?3DPOesla1g6+UNnqmMjE249AWm9NsCEVbd9Fw+yO52sF8ZFk+WbU0xsnoObt?=
 =?us-ascii?Q?qtxRg+wJ3aptBHzndbZnAkqaf7xDrH0rDXBMwoKbralonxOtzrfKwJvUZ4qh?=
 =?us-ascii?Q?oDzmsUES1KDC24mPMjbBWk3Gcek8DNAmwH8mrkrwKTZjDsSUOpzp33IJVbac?=
 =?us-ascii?Q?1RfvNP3KB6VkCAgsGsYs1cazma/h8/J9foh9kdD0nQTYZV/o0o6mfLlfIHCg?=
 =?us-ascii?Q?5PmPudwEjneh7Hp4DEUv/SSNBYt9cSp6Lb8p+eoVjzT2RiqRNOoYSGOmuihw?=
 =?us-ascii?Q?6Y+7HvgCjFRftoDhinOVQo6FWKiUBiHgoLixVIphBlNGj4HhapTen0yzauij?=
 =?us-ascii?Q?QaQq/40ij3QLNqclC1EbdyLCG0MRF/+DtUd8QQbakNWfmg/hJZxSe4HbrdBo?=
 =?us-ascii?Q?sKWPznezRUr5E7rVnG1PQ8HCDhpXJMO/sgOsUdhkJPZ0dsFrAAMm5z3BgFnt?=
 =?us-ascii?Q?UhB6w6+/PDmagRFjPDwuu/fmDJI0l40bVWlnJVxL5kog7Z7EVG3pZStMg+7V?=
 =?us-ascii?Q?cU1/9JwuW7KpOBAA3itWJvV9Coc2fnSesWvJYCHuKMvo62qUKC5BmbUnp6RD?=
 =?us-ascii?Q?7HxC+q+AGV3mVnJmMdOzplL50ZXMb8HCPuSWy/9qYmZsQhWOZr0kuXb61AfF?=
 =?us-ascii?Q?Bj0PMN2ifTOAtrM85pz9FoKeBvup2dLQxOv80VgnkARZiWIe62IXiIA1UvrQ?=
 =?us-ascii?Q?YSfEqoWlDcMkDIL5PPbQ81GKRrNW8Gw41cos9vc/Gj7D+EB+RjdFADR5r9DM?=
 =?us-ascii?Q?z0Be08Hs/CP9s+Wipc6VPbwjM2gdMWz0TilwMM/EDDlG0uI4WG1ZI6vVmPSh?=
 =?us-ascii?Q?uRJ5aegpfzZ9NIajX3fiyuLYni+Kn2kFWsXx/suj2t8e5iXgIq0JUGAm7pPb?=
 =?us-ascii?Q?7v5HpGwBSBrRg0bAD82hJfRDzECdEcj9sBLLe4j2iR3BhkVJAjgC0yZT239s?=
 =?us-ascii?Q?Mq+rUqXe6kiy/nalSIjlU3k5gamZd1fYk8Jj+Wyj1BgS9DTzf/6mKPCmniPr?=
 =?us-ascii?Q?otcj/NY680FIaN0J73roeKg+8DaVnxt2f3Q0jalOOnPG2CjsvCD20YN48wN5?=
 =?us-ascii?Q?bj1FNClbgutXP2vr1qjufhhAs35e8Ao3xKiGfIfGiRnAC7yTAWIou3hnrTMz?=
 =?us-ascii?Q?XVjcn/DtihWxQAW7uYpmUyHNcENkr3IuKkmYT2ZgrQMf1to4mO2ALGTzx/1S?=
 =?us-ascii?Q?6WGj4gx02b7704gnLSn5sL1eFEmkWUDzikHykCKs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f50134-89a4-42f6-4068-08db9ee5cf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 05:50:06.7521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYgkaFXL4Wf1RM1i4qTgDw0LStld71eumoE9Q5Dkm8jwsOhjnWnVdtHUVm3h2zgunF5i3dJOnDx29z/zqLyh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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

