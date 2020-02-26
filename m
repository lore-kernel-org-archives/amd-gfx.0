Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED9C4BA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 18:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4850624656
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tD+esmaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4850624656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE8F89AEB;
	Wed, 26 Feb 2020 18:23:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B457E89AEB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 18:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6Y8DLu+2+ykJDBkDz36/2/u2/0kGAh3r8AiCTcRaobvcBH/TEJQe1Ea0A5hZVTBNDxo9sXMsW1y4FHmXn+BbW5X4NdbtSiEfjPuYWGp2p4d2NrUuHh+/jWggE7tx40clyDViXa9APcrgjdhGabK8NfTLeP5FbKmXWPR8vbw2shqhQoq3M29f0QGZJHQ5rqcWgfgfPcWCNrT1gncB9BhXziGrwRiLa28vEIp8JryU14ZbXMUMM+RYn77jTe8Ko7A93j/Zga+/q27JX7e5iasz1smJsTkg10JutA6ySLLbUswK7bNzxKd+noVdG4hDDLX1WQH77cPpzYY2dN/BeYVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b0FVgFIbIe3m9eYOg9/vZC6XxLlwRd4OXUI5FcJfHk=;
 b=d5nn8Xvqp29s3Q87jSU0JygE9WrePC/YM2lF26b0QylyMZw+S1z/0JoMcOrloq8wEw+4RRI+2P2rG3UDqgCczf3RUZ0ICzyqUOB8dEtOFnuE/eAKdqmqHqpV8WTfuhObxLu3zdYNvoq9lL441NFkguQRjZ/OVdXS85az1eTk3sa/NP/Ak3r0YG1KVhGkWlJCGU+MytbxAS+yQWjZrnzwQjjC1jxAohHvMOi1PzPabLld9/+eeWHWh+34CPSHgcZxTYkejwI663rqoK0O9zE6u3okuNkgratdjiK0Ul/r9A9l8/2IhgcDL6L7Z2A4yYGNeTdvJqUnsjoRos/h+JLi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b0FVgFIbIe3m9eYOg9/vZC6XxLlwRd4OXUI5FcJfHk=;
 b=tD+esmaSczJfo+H6LRYdqfIy2BS6BWEDQAOAW0sxv/pHQofjezxBTJxiJCXSnTjqhLMQju1xcT59bPEz6t1DtQQBVEnHk6GIFUjiakga1lrd7qraVnyW6HHO5q9f+OPAx3lcQO1T4ZjrL6Yhnvbqc3j93VH26T6Iz9NGV2AqMZ0=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22)
 by CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 26 Feb
 2020 18:23:39 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::7921:a391:1d1b:5167%5]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 18:23:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Make get_tile_config() generic
Thread-Topic: [PATCH 2/2] drm/amdkfd: Make get_tile_config() generic
Thread-Index: AQHV7M5vbUrSx5u85E2DgCKL92E49KgtygkB
Date: Wed, 26 Feb 2020 18:23:39 +0000
Message-ID: <CH2PR12MB3912D6821CCB1C4D931AA041F7EA0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200226175812.31788-1-Yong.Zhao@amd.com>,
 <20200226175812.31788-2-Yong.Zhao@amd.com>
In-Reply-To: <20200226175812.31788-2-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-26T18:23:39.241Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e762345c-7176-4cdd-9ecb-08d7bae9009d
x-ms-traffictypediagnostic: CH2PR12MB3815:|CH2PR12MB3815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38153898DF53564D4D6C1362F7EA0@CH2PR12MB3815.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(45080400002)(53546011)(26005)(966005)(19627405001)(6506007)(2906002)(110136005)(7696005)(478600001)(86362001)(186003)(316002)(9686003)(8936002)(66556008)(66446008)(66476007)(64756008)(81166006)(81156014)(76116006)(66946007)(55016002)(8676002)(52536014)(30864003)(5660300002)(71200400001)(33656002)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3815;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQxAokJv3ELLGSrbkNnoez3jke+XAoYp3IJMiLMxmmXZHeOcj2KTo+sYGCJfSNDhLeco+M+Hc/E3n7wc1mRrqEqY14Fn8r7sA/Az0pJFkywwYZFvmspXWQLfXTDZONBhQyh07kR2qNZGJFV9O7E0Wqo9Yggojh2Ra9v4E5CPgqZ5DT8388TrJe/P/paJhpcUpECFhWmyCL7HCE54w9cY4TDSaM0NLOdksNJGQ+3EPh4xvvguz6r3uOgraPiYo8lUekBctkw+QgNzxww16WCTbdAznN0nv8jkOKx1zE5Pq+UjXmxQwzjI0tvZUpKMJHxsRs7XrBuCjybVovhjndDr1bnyfhTLbvZodS+Nbc18jBBIvFmwiGyU4ywNZQM4Arq9ypE9FOO8QjBnAKT/3mFSXUDZpz+BIzj615dPMtLRBgzE/ThCUo3x4AfLj91EtRj/u31g2ze11QvsSkeeSShnnkvngNaPdrKEV7mJJwLvlnmU33OjyHK9m9bsFhTynO9XjOHr5D7M0zh0gPbFJqyZDpvzMtlWfykiNkzze/FPTf/ItLe/WoWokJ6pTglbNpd1
x-ms-exchange-antispam-messagedata: r5eSakTQT73ogPa9Zwfdbx5tk8Qz/51EmBlF5EZHNGdBIt461iUFUrQVeUVg3O56vl2woEFZglCXgL7m0Eg4PRvAnEbHTMNqyMD3rjh9v7eh2LswvYPvquQZONd+oXpNalTkeL/adoPW7w+0BPdO6A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e762345c-7176-4cdd-9ecb-08d7bae9009d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 18:23:39.5261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXquQFcM4Zj6EkUIMuAC26RCYDWLa1AnIeLfKNl+7650DNqc/Gl1xkCt6G/cPSus2MvOkyGtk32zuUjuwbe6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
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
Content-Type: multipart/mixed; boundary="===============1912102988=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1912102988==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912D6821CCB1C4D931AA041F7EA0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912D6821CCB1C4D931AA041F7EA0CH2PR12MB3912namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Wednesday, February 26, 2020 12:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Make get_tile_config() generic

Given we can query all the asic specific information from amdgpu_gfx_config=
,
we can make get_tile_config() generic.

Change-Id: I1080fec4d50c51bc84bb49b0145f8fec50081fce
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 33 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 26 ---------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 26 ---------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 23 -------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 --
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  4 ---
 10 files changed, 26 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index b0ad3be0b03f..13feb313e9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -242,6 +242,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *k=
gd,
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);

+int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+                               struct tile_config *config);
+
 /* KGD2KFD callbacks */
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 4bcc175a149d..d6549e5ea7e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -319,7 +319,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
         .address_watch_get_offset =3D kgd_gfx_v9_address_watch_get_offset,
         .get_atc_vmid_pasid_mapping_info =3D
                         kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
-       .get_tile_config =3D kgd_gfx_v9_get_tile_config,
         .set_vm_context_page_table_base =3D kgd_set_vm_context_page_table_=
base,
         .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index ca91fffb8a36..4ec6d0c03201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -42,38 +42,6 @@ enum hqd_dequeue_request_type {
         SAVE_WAVES
 };

-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
-               struct tile_config *config)
-{
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
-
-       config->gb_addr_config =3D adev->gfx.config.gb_addr_config;
-#if 0
-/* TODO - confirm REG_GET_FIELD x2, should be OK as is... but
- * MC_ARB_RAMCFG register doesn't exist on Vega10 - initial amdgpu
- * changes commented out related code, doing the same here for now but
- * need to sync with Ken et al
- */
-       config->num_banks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFBANK);
-       config->num_ranks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFRANKS);
-#endif
-
-       config->tile_config_ptr =3D adev->gfx.config.tile_mode_array;
-       config->num_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-       config->macro_tile_config_ptr =3D
-                       adev->gfx.config.macrotile_mode_array;
-       config->num_macro_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-       return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
         return (struct amdgpu_device *)kgd;
@@ -805,7 +773,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {
         .address_watch_get_offset =3D kgd_address_watch_get_offset,
         .get_atc_vmid_pasid_mapping_info =3D
                         get_atc_vmid_pasid_mapping_info,
-       .get_tile_config =3D amdgpu_amdkfd_get_tile_config,
         .set_vm_context_page_table_base =3D set_vm_context_page_table_base=
,
         .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
         .get_unique_id =3D amdgpu_amdkfd_get_unique_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 8f052e98a3c6..0b7e78748540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -84,31 +84,6 @@ union TCP_WATCH_CNTL_BITS {
         float f32All;
 };

-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int get_tile_config(struct kgd_dev *kgd,
-               struct tile_config *config)
-{
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
-
-       config->gb_addr_config =3D adev->gfx.config.gb_addr_config;
-       config->num_banks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFBANK);
-       config->num_ranks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFRANKS);
-
-       config->tile_config_ptr =3D adev->gfx.config.tile_mode_array;
-       config->num_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-       config->macro_tile_config_ptr =3D
-                       adev->gfx.config.macrotile_mode_array;
-       config->num_macro_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-       return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
         return (struct amdgpu_device *)kgd;
@@ -730,7 +705,6 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {
         .address_watch_get_offset =3D kgd_address_watch_get_offset,
         .get_atc_vmid_pasid_mapping_info =3D get_atc_vmid_pasid_mapping_in=
fo,
         .set_scratch_backing_va =3D set_scratch_backing_va,
-       .get_tile_config =3D get_tile_config,
         .set_vm_context_page_table_base =3D set_vm_context_page_table_base=
,
         .read_vmid_from_vmfault_reg =3D read_vmid_from_vmfault_reg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 19a10db93d68..ccd635b812b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -41,31 +41,6 @@ enum hqd_dequeue_request_type {
         RESET_WAVES
 };

-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int get_tile_config(struct kgd_dev *kgd,
-               struct tile_config *config)
-{
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
-
-       config->gb_addr_config =3D adev->gfx.config.gb_addr_config;
-       config->num_banks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFBANK);
-       config->num_ranks =3D REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-                               MC_ARB_RAMCFG, NOOFRANKS);
-
-       config->tile_config_ptr =3D adev->gfx.config.tile_mode_array;
-       config->num_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-       config->macro_tile_config_ptr =3D
-                       adev->gfx.config.macrotile_mode_array;
-       config->num_macro_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-       return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
         return (struct amdgpu_device *)kgd;
@@ -676,6 +651,5 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {
         .get_atc_vmid_pasid_mapping_info =3D
                         get_atc_vmid_pasid_mapping_info,
         .set_scratch_backing_va =3D set_scratch_backing_va,
-       .get_tile_config =3D get_tile_config,
         .set_vm_context_page_table_base =3D set_vm_context_page_table_base=
,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 7f91feff7c4f..df841c2ac5e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -48,28 +48,6 @@ enum hqd_dequeue_request_type {
         RESET_WAVES
 };

-
-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
-               struct tile_config *config)
-{
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
-
-       config->gb_addr_config =3D adev->gfx.config.gb_addr_config;
-
-       config->tile_config_ptr =3D adev->gfx.config.tile_mode_array;
-       config->num_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-       config->macro_tile_config_ptr =3D
-                       adev->gfx.config.macrotile_mode_array;
-       config->num_macro_tile_configs =3D
-                       ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-       return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
         return (struct amdgpu_device *)kgd;
@@ -736,7 +714,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {
         .address_watch_get_offset =3D kgd_gfx_v9_address_watch_get_offset,
         .get_atc_vmid_pasid_mapping_info =3D
                         kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
-       .get_tile_config =3D kgd_gfx_v9_get_tile_config,
         .set_vm_context_page_table_base =3D kgd_gfx_v9_set_vm_context_page=
_table_base,
         .get_hive_id =3D amdgpu_amdkfd_get_hive_id,
         .get_unique_id =3D amdgpu_amdkfd_get_unique_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 63d3e6683dfe..aedf67d57449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -60,5 +60,3 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_d=
ev *kgd,

 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
                                         uint8_t vmid, uint16_t *p_pasid);
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
-               struct tile_config *config);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e1d1eed7a25f..e4481caed648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2242,3 +2242,25 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info=
, void *mem)
         kfree(mem);
         return 0;
 }
+
+/* Returns GPU-specific tiling mode information */
+int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+                               struct tile_config *config)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+
+       config->gb_addr_config =3D adev->gfx.config.gb_addr_config;
+       config->tile_config_ptr =3D adev->gfx.config.tile_mode_array;
+       config->num_tile_configs =3D
+                       ARRAY_SIZE(adev->gfx.config.tile_mode_array);
+       config->macro_tile_config_ptr =3D
+                       adev->gfx.config.macrotile_mode_array;
+       config->num_macro_tile_configs =3D
+                       ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
+
+       /* Those values are not set from GFX9 onwards */
+       config->num_banks =3D adev->gfx.config.num_banks;
+       config->num_ranks =3D adev->gfx.config.num_ranks;
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 675735b8243a..f8fa03a12add 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1169,7 +1169,7 @@ static int kfd_ioctl_get_tile_config(struct file *fil=
ep,
         if (!dev)
                 return -EINVAL;

-       dev->kfd2kgd->get_tile_config(dev->kgd, &config);
+       amdgpu_amdkfd_get_tile_config(dev->kgd, &config);

         args->gb_addr_config =3D config.gb_addr_config;
         args->num_banks =3D config.num_banks;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h
index abc0eb4ac493..0cee79d56075 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -223,8 +223,6 @@ struct tile_config {
  * @set_scratch_backing_va: Sets VA for scratch backing memory of a VMID.
  * Only used for no cp scheduling mode
  *
- * @get_tile_config: Returns GPU-specific tiling mode information
- *
  * @set_vm_context_page_table_base: Program page table base for a VMID
  *
  * @invalidate_tlbs: Invalidate TLBs for a specific PASID
@@ -310,8 +308,6 @@ struct kfd2kgd_calls {
         void (*set_scratch_backing_va)(struct kgd_dev *kgd,
                                 uint64_t va, uint32_t vmid);

-       int (*get_tile_config)(struct kgd_dev *kgd, struct tile_config *con=
fig);
-
         void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
                         uint32_t vmid, uint64_t page_table_base);
         uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C8f3b7599907940152a9908d7bae57d15%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637183367446481070&amp;sdata=3D8SNAbkJvgXicyXsv%2B=
0jUbnLgvWM5M%2FR9uEChJrwHrxY%3D&amp;reserved=3D0

--_000_CH2PR12MB3912D6821CCB1C4D931AA041F7EA0CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, February 26, 2020 12:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdkfd: Make get_tile_config() generic</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Given we can query all the asic specific informati=
on from amdgpu_gfx_config,<br>
we can make get_tile_config() generic.<br>
<br>
Change-Id: I1080fec4d50c51bc84bb49b0145f8fec50081fce<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;<br>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp; |&nbsp; 1 -<b=
r>
&nbsp;.../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp;&nbsp;&nbsp; | 33 ---=
----------------<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 26 ---------------<br=
>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 26 ---------------<br=
>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 23 -------------<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |&nbsp; 2 --<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 22 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 2 &#43;-<br>
&nbsp;.../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; |&nbsp; 4 ---=
<br>
&nbsp;10 files changed, 26 insertions(&#43;), 116 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index b0ad3be0b03f..13feb313e9b3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -242,6 &#43;242,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_de=
v *kgd,<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void);<br>
&nbsp;void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);<br>
&nbsp;<br>
&#43;int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config);<br>
&#43;<br>
&nbsp;/* KGD2KFD callbacks */<br>
&nbsp;int kgd2kfd_init(void);<br>
&nbsp;void kgd2kfd_exit(void);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
index 4bcc175a149d..d6549e5ea7e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
@@ -319,7 &#43;319,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd =3D {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .address_watch_get_offset =
=3D kgd_gfx_v9_address_watch_get_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_g=
fx_v9_get_atc_vmid_pasid_mapping_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_tile_config =3D kgd_gfx_v9_get_t=
ile_config,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D kgd_set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_am=
dkfd_get_hive_id,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
index ca91fffb8a36..4ec6d0c03201 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
@@ -42,38 &#43;42,6 @@ enum hqd_dequeue_request_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SAVE_WAVES<br>
&nbsp;};<br>
&nbsp;<br>
-/* Because of REG_GET_FIELD() being used, we put this function in the<br>
- * asic specific file.<br>
- */<br>
-static int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct tile_config *config)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;gb_addr_config =3D adev-&g=
t;gfx.config.gb_addr_config;<br>
-#if 0<br>
-/* TODO - confirm REG_GET_FIELD x2, should be OK as is... but<br>
- * MC_ARB_RAMCFG register doesn't exist on Vega10 - initial amdgpu<br>
- * changes commented out related code, doing the same here for now but<br>
- * need to sync with Ken et al<br>
- */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_banks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFBANK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_ranks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFRANKS);<br>
-#endif<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;tile_config_ptr =3D adev-&=
gt;gfx.config.tile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_tile_configs =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.tile_mode_array);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;macro_tile_config_ptr =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.macrotile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_macro_tile_configs =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.macrotile_mode_array);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev =
*kgd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct amdgpu_devi=
ce *)kgd;<br>
@@ -805,7 &#43;773,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .address_watch_get_offset =
=3D kgd_address_watch_get_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_a=
tc_vmid_pasid_mapping_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_tile_config =3D amdgpu_amdkfd_ge=
t_tile_config,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_am=
dkfd_get_hive_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_unique_id =3D amdgpu_=
amdkfd_get_unique_id,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
index 8f052e98a3c6..0b7e78748540 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
@@ -84,31 &#43;84,6 @@ union TCP_WATCH_CNTL_BITS {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; float f32All;<br>
&nbsp;};<br>
&nbsp;<br>
-/* Because of REG_GET_FIELD() being used, we put this function in the<br>
- * asic specific file.<br>
- */<br>
-static int get_tile_config(struct kgd_dev *kgd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct tile_config *config)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;gb_addr_config =3D adev-&g=
t;gfx.config.gb_addr_config;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_banks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFBANK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_ranks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFRANKS);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;tile_config_ptr =3D adev-&=
gt;gfx.config.tile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_tile_configs =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.tile_mode_array);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;macro_tile_config_ptr =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.macrotile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_macro_tile_configs =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.macrotile_mode_array);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev =
*kgd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct amdgpu_devi=
ce *)kgd;<br>
@@ -730,7 &#43;705,6 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .address_watch_get_offset =
=3D kgd_address_watch_get_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D get_atc_vmid_pasid_mapping_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_scratch_backing_va =
=3D set_scratch_backing_va,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_tile_config =3D get_tile_config,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_vmid_from_vmfault_re=
g =3D read_vmid_from_vmfault_reg,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
index 19a10db93d68..ccd635b812b5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
@@ -41,31 &#43;41,6 @@ enum hqd_dequeue_request_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESET_WAVES<br>
&nbsp;};<br>
&nbsp;<br>
-/* Because of REG_GET_FIELD() being used, we put this function in the<br>
- * asic specific file.<br>
- */<br>
-static int get_tile_config(struct kgd_dev *kgd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct tile_config *config)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;gb_addr_config =3D adev-&g=
t;gfx.config.gb_addr_config;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_banks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFBANK);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_ranks =3D REG_GET_FIEL=
D(adev-&gt;gfx.config.mc_arb_ramcfg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_ARB_RAMCFG, NOOFRANKS);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;tile_config_ptr =3D adev-&=
gt;gfx.config.tile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_tile_configs =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.tile_mode_array);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;macro_tile_config_ptr =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.macrotile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_macro_tile_configs =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.macrotile_mode_array);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev =
*kgd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct amdgpu_devi=
ce *)kgd;<br>
@@ -676,6 &#43;651,5 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_a=
tc_vmid_pasid_mapping_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_scratch_backing_va =
=3D set_scratch_backing_va,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_tile_config =3D get_tile_config,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D set_vm_context_page_table_base,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
index 7f91feff7c4f..df841c2ac5e7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
@@ -48,28 &#43;48,6 @@ enum hqd_dequeue_request_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESET_WAVES<br>
&nbsp;};<br>
&nbsp;<br>
-<br>
-/* Because of REG_GET_FIELD() being used, we put this function in the<br>
- * asic specific file.<br>
- */<br>
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct tile_config *config)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)kgd;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;gb_addr_config =3D adev-&g=
t;gfx.config.gb_addr_config;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;tile_config_ptr =3D adev-&=
gt;gfx.config.tile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_tile_configs =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.tile_mode_array);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;macro_tile_config_ptr =3D<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.con=
fig.macrotile_mode_array;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_macro_tile_configs =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(adev-=
&gt;gfx.config.macrotile_mode_array);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev =
*kgd)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct amdgpu_devi=
ce *)kgd;<br>
@@ -736,7 &#43;714,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .address_watch_get_offset =
=3D kgd_gfx_v9_address_watch_get_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_atc_vmid_pasid_mappin=
g_info =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd_g=
fx_v9_get_atc_vmid_pasid_mapping_info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_tile_config =3D kgd_gfx_v9_get_t=
ile_config,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vm_context_page_table=
_base =3D kgd_gfx_v9_set_vm_context_page_table_base,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hive_id =3D amdgpu_am=
dkfd_get_hive_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_unique_id =3D amdgpu_=
amdkfd_get_unique_id,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
index 63d3e6683dfe..aedf67d57449 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h<br>
@@ -60,5 &#43;60,3 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct k=
gd_dev *kgd,<br>
&nbsp;<br>
&nbsp;bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint8_t vmid, uint16_t *p_pasid);<br>
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct tile_config *config);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index e1d1eed7a25f..e4481caed648 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -2242,3 &#43;2242,25 @@ int amdgpu_amdkfd_remove_gws_from_process(void *=
info, void *mem)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&#43;<br>
&#43;/* Returns GPU-specific tiling mode information */<br>
&#43;int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (s=
truct amdgpu_device *)kgd;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;gb_addr_config =3D ade=
v-&gt;gfx.config.gb_addr_config;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;tile_config_ptr =3D ad=
ev-&gt;gfx.config.tile_mode_array;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_tile_configs =3D<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(a=
dev-&gt;gfx.config.tile_mode_array);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;macro_tile_config_ptr =
=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.config.macrotile_mode_array;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_macro_tile_configs=
 =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(a=
dev-&gt;gfx.config.macrotile_mode_array);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Those values are not set from =
GFX9 onwards */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_banks =3D adev-&gt=
;gfx.config.num_banks;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config-&gt;num_ranks =3D adev-&gt=
;gfx.config.num_ranks;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 675735b8243a..f8fa03a12add 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -1169,7 &#43;1169,7 @@ static int kfd_ioctl_get_tile_config(struct file =
*filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;kfd2kgd-&gt;get_tile_config(d=
ev-&gt;kgd, &amp;config);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_get_tile_config(dev=
-&gt;kgd, &amp;config);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;gb_addr_config =
=3D config.gb_addr_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;num_banks =3D con=
fig.num_banks;<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/=
drm/amd/include/kgd_kfd_interface.h<br>
index abc0eb4ac493..0cee79d56075 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
@@ -223,8 &#43;223,6 @@ struct tile_config {<br>
&nbsp; * @set_scratch_backing_va: Sets VA for scratch backing memory of a V=
MID.<br>
&nbsp; * Only used for no cp scheduling mode<br>
&nbsp; *<br>
- * @get_tile_config: Returns GPU-specific tiling mode information<br>
- *<br>
&nbsp; * @set_vm_context_page_table_base: Program page table base for a VMI=
D<br>
&nbsp; *<br>
&nbsp; * @invalidate_tlbs: Invalidate TLBs for a specific PASID<br>
@@ -310,8 &#43;308,6 @@ struct kfd2kgd_calls {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_scratch_backing=
_va)(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t va, uint32_t vmid);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_tile_config)(struct kgd_dev=
 *kgd, struct tile_config *config);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_vm_context_page=
_table_base)(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t vmid, uint64_t page_table_base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*read_vmid_from_=
vmfault_reg)(struct kgd_dev *kgd);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C8f3b7599907940152a9908d7bae57d15%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183367446481070&amp;amp;sdata=3D=
8SNAbkJvgXicyXsv%2B0jUbnLgvWM5M%2FR9uEChJrwHrxY%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C8f3b7599907940152a9908d7bae57d15%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637183367446481070&amp;amp;sdata=3D8SNAbkJvgXicy=
Xsv%2B0jUbnLgvWM5M%2FR9uEChJrwHrxY%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912D6821CCB1C4D931AA041F7EA0CH2PR12MB3912namp_--

--===============1912102988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1912102988==--
