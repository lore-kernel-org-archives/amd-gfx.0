Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F730C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 14:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E05CA112796;
	Wed,  7 Feb 2024 14:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pq6vzLjd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E66112796
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 14:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbQTA8z85PU03vAY+JQ1DlyC964W2qCNHMsiOSdXEt8U2kXfRjOBcS0Zw9qHINPrtKUwPtZcK7i01GxZAuCC+dbLqXK67t/JTJmChce4yMogBmoqIYGONditR8h9ND29o0oK6Xj4aIv4Znm8zdC54qPZ7BlUROW/7+HYdfRiJTGPnkUfz5JYidg511JFaMJw2Y8d02VXLs3HP6VUqAYviKGQcWhRmxWwV1IUUb3x5r22NhnNogrfuIh0q2+c1VUe0oozxUpFHhyzra7/NI7fnpCmDoSK7YhfjgMU8zNa/l5b7WKUu1Mph6ETmDuSQuOUHcfjKd4Eh1eXpdE57hheHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzxEgPsjyLgLQNIdPVpFmNBYZqXEpk2mltGQMoU+Lcg=;
 b=UflNKY7omDfdZ74DLjIYUVz3NxbzKZKFRnCjD/KGBrhZMoz+uiw/4e1YtUzuLpligDgjh0lHKDKCvdoxnUqjmyT3SgQ7Bua8lTCjWVy5G6IlVq4+bFa8AEjQuessnLeqP92atXPQoN6+pHpwWsuT8YTdQj1PKdQPXIXgPc62soPG2CPqRle4zro/2kQAlUxTVVZZhWY505sPgDIY28Ni/iUL4ETF/coTeRCZ036id9cNJplo+93ujVlpTjTtzWTyLQekf0IMOc0h9dCdO72rtj3onyzat7MXSV7cLzoSyXEYjX3tLEHs82ZQM9DvdMsuAm1pDsg97YADaj8WV18vyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzxEgPsjyLgLQNIdPVpFmNBYZqXEpk2mltGQMoU+Lcg=;
 b=pq6vzLjdumNPhbjb7rnTcSrl5XVAil+y7p0nMj8MUmX+aPuZT+rI1caoDAOLmy61WEQlDB6AUYBdjROHlAF1PBiZjh2/943ly4wgcPtSSThf0JNFNDVopg4UMaKwCrwah4kOHIEwPym5OrHzGrQdPncp+XS9mKfYGHjQj/1kszQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 14:00:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 14:00:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu
 v13.0.6
Thread-Topic: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu
 v13.0.6
Thread-Index: AQHaWc1E6omU4T2jfUqJXTLiufgb5bD+59xQ
Date: Wed, 7 Feb 2024 14:00:07 +0000
Message-ID: <BN9PR12MB5257BDED870EF9C892074F5CFC452@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240207135418.693925-1-kevinyang.wang@amd.com>
In-Reply-To: <20240207135418.693925-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6378a690-95bc-4465-aca4-517c889b323c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-07T13:58:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: bfd65a50-9d87-4dee-9570-08dc27e51795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sK/smYRHEosB9UOPMR52PVSYIc/6e6Eatd5vq4GcWUVsn+IgLBuHyB5Qm+GzXZsXr3IwpFvMzTXcl4mOmkYu1qk48ENr6qzOSPR3liwOe9Hm/muRD/K6lCWmozPyF44j3TyJ7PkNzrW8VicW0pea3SXL4JKExyRJMduSm4ZHyx7sMi7BdPKM/GCYLq8ya/u4MziYUVCaIlBBro5vSHRZS0LAXNCREoA3pzO5tfd7o2VPBIJnldXWed2wuF6Asm2t9Mh73m5trSfeRj0NtiqC8h7cVs/kAfttsVB4RGaKK62IaBBTr1KV2s/ycV/d5uqpvyCd1rX6ID24nPtMbRVput0ueVDb7MP3P49Q05AnWWxJ+8X5w5im/oI3HtAKSjFVF0HlEbW9qdDnQUZWWZagXHcmO6Z1NqiBa1er1f06mTP3CqOM83Oxs4i9ne59R0eXY6iKk9W0VeI/hxxExbcKg40UzLLscCOa39GTwpuxmQO8M3EtLvfr8ZpDibejolB1qn/oyGmZBhNsTu7MmMZHtawn/Hi0pgjiuY9KPym+Ga+FjbNAgKVwR6kdNPcU+UWgq5LQkVWjK+xdkmCbdZft9ffdVMmKnXIWwTJ6LpeziGtrLEoHzxcDigvipw14VQIX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(55016003)(54906003)(41300700001)(53546011)(38100700002)(6506007)(38070700009)(66946007)(7696005)(122000001)(478600001)(83380400001)(9686003)(71200400001)(66476007)(66556008)(33656002)(64756008)(76116006)(66446008)(5660300002)(52536014)(86362001)(316002)(110136005)(2906002)(8676002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kFHVdhFkdLwYZc6gRQRia5HCgLLb7gvOOdjFcwY9BMEAI+nh4Fkxyfgxgvww?=
 =?us-ascii?Q?M8oxEkHDZNhiOk5TJS7xEHWyFgpkn51+nWHh4gJCIBpHhotZEcp6gYYuSeeU?=
 =?us-ascii?Q?shOC9ETZO5FozTDI6TuB4gbKvNpTNkVzCGXGntIV8+VtxpJJsF2VNfPW8j4L?=
 =?us-ascii?Q?BzwH5bbGHi7R82FLwdn17AzrdYt45IGzevg1ceAFK60cD9CGjQjykwrsEN3/?=
 =?us-ascii?Q?c9mHv9BZ93u+WXCPZIR2AMteeDXlv4TBNyhjxKKaTZxihjFJttWaUtzGkkLM?=
 =?us-ascii?Q?SVgBvXSFo7BOa3/zP/075MUvhwKL6866Kyg6tMCzASIzRE+mnMyXMQ7xD+Ft?=
 =?us-ascii?Q?YI9Bhh7dd+BsKbXzKnQMCEqFYnpYL5QL+8+JsIxnK5k/jNPhJawn3alCD3dQ?=
 =?us-ascii?Q?l1e1Vf/OWMMIk/1Ze5q+mJJkjPiO3UpeDWSKHbK/hRZ/gG7nUyc3vy1i2HpJ?=
 =?us-ascii?Q?h4SGI/TZex4Nl/SLrBYm29YQn0RUz30zXKftIW1V0Gu8jfJ2HVuPboSiERn2?=
 =?us-ascii?Q?j5WR2IU/IooxrNL6otpC1rs7aBYQ0LP2mF1Tn/EEY3C1M/jxPIf4EIiBvtoS?=
 =?us-ascii?Q?FCkGaU7x49FIUVXG96kCY8Js0rLkp2zO1U+muG6DcJ87Fl8ACngy6lo5mN1r?=
 =?us-ascii?Q?bsfHKLy1fOjrcIMC1/B1ZOAKjoKuQOKhLpmf3q44b4evFNW1BtYUkO85hca8?=
 =?us-ascii?Q?QjczG9BMUO+GAsosRBebn5tBW4HboB8hhwfAxMPQL9OL56k33gSy1HaWX8NX?=
 =?us-ascii?Q?wg0HdRPKIlhx+QE1gZIgzFJR6H5iYMbTOXwMfFL1zrthr4g6jdEJ4pQzD5vg?=
 =?us-ascii?Q?TmbNftcbextKpRI9sXlJDLKXqtVPEAA5g1kSxCypeTfZpod2hZXNGWF5jr2j?=
 =?us-ascii?Q?GNeoObd9ZGFF3AWw4+5X5fDosy3T3cABsnDJYyugjlX2ECkCBKqbSZ6X3Xa7?=
 =?us-ascii?Q?pVfZh7Em54GYP2FxojelpyOSBmca0VY4J1w8xVBVrN6rhFmJRrMbvIS4Q4/u?=
 =?us-ascii?Q?z2tniqZ6kbe3+g/NRLEU0zkSUrd5Paoev4pSY51Sw9L8bOVNn53Ij29dtTNV?=
 =?us-ascii?Q?ehNbYNc5/xG50os4CJu8EE/KjfOOAJVb01/0MkYSf9hMus6O7YMznScUFzF9?=
 =?us-ascii?Q?ryFVg4MEs/5HhVcHPgm5qpONCnxfvSqFiUefJFkhOGlNM5Gj59N4K/uswLb6?=
 =?us-ascii?Q?vqYRrrj3nWkVXc60w4Vme0dnxtNYAjU7XeK+Ng3dt9Y1UTenzXG0XqE5jlfD?=
 =?us-ascii?Q?FlSvHBO/1fwriLNQBKrvV74rHAFMOtoz1LyXz31KC20C8P3nTg03rLMr/wgy?=
 =?us-ascii?Q?cKtBKDBa/lx7HsVxi7pzjbLsDy6n7w17+4Voy8tmZ5iqv6jOM0mzp4USKWGs?=
 =?us-ascii?Q?slahUSDABOk4wctOsHbg7M5fnkgKESNkwmi8S3qEqITPtrjZcjoem6+ladxL?=
 =?us-ascii?Q?THobjT1sHx/ZzXr18Sf70jncfkT13YNRglzpj9FM9m0dGXDB3uFK3XWhkUxC?=
 =?us-ascii?Q?2mLee5YOqHWSICScHEN6Qttjm/hxXRCldCbYu7DT3RHCH9EKKWgVIbZR4Lyl?=
 =?us-ascii?Q?GFrdPuJKTLEci4Y5p1BPNrud2KWy4TiAZQIschRh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd65a50-9d87-4dee-9570-08dc27e51795
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 14:00:07.5973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzlcBwi1y5fyDGlN3ezfu2OAMMDXtalujtgmaJ4X297GgP/HWeBEMS3wQbvUYvzBQ63R/tjzcOmhFj9tsJur+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
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

[AMD Official Use Only - General]

With a nitpick below, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

+       MSG_MAP(BadPageThreshold,                    PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),

Might be better name it to RmaDueToBadPageThreshold/SMU_MSG_ RmaDueToBadPag=
eThreshold

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, February 7, 2024 21:54
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>
Subject: [PATCH v2 1/2] drm/amdgpu: implement smu send rma reason for smu v=
13.0.6

implement smu send rma reason function for smu v13.0.6

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 15 ++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  6 ++++++  .../pm/swsmu/in=
c/pmfw_if/smu_v13_0_6_ppsmc.h  |  3 ++-  drivers/gpu/drm/amd/pm/swsmu/inc/s=
mu_types.h  |  3 ++-  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 20 ++=
+++++++++++++++++
 7 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 6627ee07d52d..f84bfed50681 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -693,6 +693,21 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu=
_device *adev, uint32_t si
        return ret;
 }

+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret;
+
+       if (!is_support_sw_smu(adev))
+               return -EOPNOTSUPP;
+
+       mutex_lock(&adev->pm.mutex);
+       ret =3D smu_send_rma_reason(smu);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
                                  enum pp_clock_type type,
                                  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index 3047ffe7f244..621200e0823f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -450,6 +450,7 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *a=
dev, uint32_t *smu_versio  int amdgpu_dpm_handle_passthrough_sbr(struct amd=
gpu_device *adev, bool enable);  int amdgpu_dpm_send_hbm_bad_pages_num(stru=
ct amdgpu_device *adev, uint32_t size);  int amdgpu_dpm_send_hbm_bad_channe=
l_flag(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_send_rma_reason(struct amdgpu_device *adev);
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
                                       enum pp_clock_type type,
                                       uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 0ad947df777a..138dcb8724b6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3669,3 +3669,13 @@ int smu_send_hbm_bad_channel_flag(struct smu_context=
 *smu, uint32_t size)

        return ret;
 }
+
+int smu_send_rma_reason(struct smu_context *smu) {
+       int ret =3D 0;
+
+       if (smu->ppt_funcs && smu->ppt_funcs->send_rma_reason)
+               ret =3D smu->ppt_funcs->send_rma_reason(smu);
+
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 66e84defd0b6..a870bdd49a4e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1341,6 +1341,11 @@ struct pptable_funcs {
         */
        int (*send_hbm_bad_pages_num)(struct smu_context *smu, uint32_t siz=
e);

+       /**
+        * @send_rma_reason: message rma reason event to SMU.
+        */
+       int (*send_rma_reason)(struct smu_context *smu);
+
        /**
         * @get_ecc_table:  message SMU to get ECC INFO table.
         */
@@ -1588,5 +1593,6 @@ int smu_stb_collect_info(struct smu_context *smu, voi=
d *buff, uint32_t size);  void amdgpu_smu_stb_debug_fs_init(struct amdgpu_d=
evice *adev);  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint=
32_t size);  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uin=
t32_t size);
+int smu_send_rma_reason(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b=
/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 509e3cd483fb..86758051cb93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -91,7 +91,8 @@
 #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
-#define PPSMC_Message_Count                         0x41
+#define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
+#define PPSMC_Message_Count                         0x44

 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 953a767613b1..efd97408b667 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -261,7 +261,8 @@
        __SMU_DUMMY_MAP(SetSoftMaxVpe), \
        __SMU_DUMMY_MAP(SetSoftMinVpe), \
        __SMU_DUMMY_MAP(GetMetricsVersion), \
-       __SMU_DUMMY_MAP(EnableUCLKShadow),
+       __SMU_DUMMY_MAP(EnableUCLKShadow), \
+       __SMU_DUMMY_MAP(BadPageThreshold),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 40ce3f780847..f2311138e8fa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -172,6 +172,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_me=
ssage_map[SMU_MSG_MAX_COU
        MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpD=
W,                   0),
        MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDum=
pDW,                 0),
        MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMo=
de,                  0),
+       MSG_MAP(BadPageThreshold,                    PPSMC_MSG_RmaDueToBadP=
ageThreshold,        0),
 };

 // clang-format on
@@ -2381,6 +2382,24 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(str=
uct smu_context *smu,
        return ret;
 }

+static int smu_v13_0_6_send_rma_reason(struct smu_context *smu) {
+       struct amdgpu_device *adev =3D smu->adev;
+       int ret;
+
+       /* NOTE: the message is only valid on dGPU with pmfw 85.90.0 and ab=
ove */
+       if ((adev->flags & AMD_IS_APU) || smu->smc_fw_version < 0x00555a00)
+               return 0;
+
+       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_BadPageThreshold, NULL);
+       if (ret)
+               dev_err(smu->adev->dev,
+                       "[%s] failed to send BadPageThreshold event to SMU\=
n",
+                       __func__);
+
+       return ret;
+}
+
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)=
  {
        struct smu_context *smu =3D adev->powerplay.pp_handle; @@ -3095,6 +=
3114,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        .i2c_init =3D smu_v13_0_6_i2c_control_init,
        .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
        .send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
+       .send_rma_reason =3D smu_v13_0_6_send_rma_reason,
 };

 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.34.1

