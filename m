Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D25C54FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C27D10E280;
	Thu, 16 Nov 2023 12:40:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5175610E280
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 12:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx+sOVwAJFa4B0NPtkUMywDrG7Pj58c0hX0g23iwgmCBiezvvlbOX6ATAYMZAMatDBpA6BaDryhg8f9xCxn2IsTDwbRGp84Ov13DVhU6+Za4pWjByaSE9OyGk8358aetlZod8d9tjEAwyAW1kKehHQQ6i9nK7a3H/ShTv0b1fVFS2m3CcS8fI7xdNipL5GTNKvRk41HA0GdoRQKB0hX9hdWANvDINdRfn9VD9pzYe8P5j2wGnsNhzAAEgUDzc/h3JFkKIByTLe3YNs+qpshJcspXPdaWZnJfWtl21U8HBmo2c3RzXd+/HW5AQGNRKoTyUlSl17KTj1pnrXl4tnU/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdAt1fhMiMwQ5cmCFlDydQPoHHtEtXmLcN5IdRWoA50=;
 b=YWRbrfKoRbXalT6I+P7B7ynH85h0G3iDxJxe/KGUUm+hBKUslfl2s07Z4rZudAmhM/E/t4LEwSbfAlVmHSnkhQoRMDpmOJELgWdCuHOkYcLYrNMvu/XsPRsKt5GdWbbWdI/qCRHOkvP8V4PwVUkuy61d2cXARb7U8UCvRgrm7Rx4/u9XS/5WkKsQZ/sbaGdvTXjkTpjz82+cyb+IfQelTwfKaOe4w3aDDTRUhk4tioL51MYssAhM9CXYxVBBh8YXhmhmXZXzGeG1RwpxY/4r/inN8nYPp6vUZRF8OLeSt+vdSYiIeykgYT4myaCSuZbaYM2vpXiQBA+Xu2Ap6ODtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdAt1fhMiMwQ5cmCFlDydQPoHHtEtXmLcN5IdRWoA50=;
 b=VIPmTUFMqP9Gs+CNC6+bM/XjuzKBp8u1eI5dbWtDbZmEjEHSghOQcZubAFqZQDaGI4RHH7v+WNL+uBI22/PLn13s9tSE0vKq2hpGxSAz+Ahpv2bvtUFFWB1/BDuVldttXzJENHDE1cKK4IEr94aj14C3umI/qenrBy1BA6BANR0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 12:40:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 12:40:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Move mca debug mode decision to ras
Thread-Topic: [PATCH v3] drm/amdgpu: Move mca debug mode decision to ras
Thread-Index: AQHaE6tbYGx1OxBX2EG5ptZrk5/YZbB87LOg
Date: Thu, 16 Nov 2023 12:40:26 +0000
Message-ID: <BN9PR12MB52579377E777E17712720A26FCB0A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231110075547.565860-1-lijo.lazar@amd.com>
In-Reply-To: <20231110075547.565860-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c28ba4b-16fd-4cd1-b0ec-ef8db9a63185;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-16T12:40:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7421:EE_
x-ms-office365-filtering-correlation-id: c31ec243-b720-40d9-7a2d-08dbe6a1357c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2SykKZZfU5KkQFgL66+K4LJJOoB0VCtHyghmEyPOnPKwUnvo3DfgPrJeeSk1AKJnS32MCYdScp5v37VTnSTyoFKavHjLeQexaNoq13P/mLWovbraue8Fr7Wz/LFs0a07LAbdFDX7Bl6ABtMIsu7Tqkm6/xYkt3ViVPA1SW18Ad1JV5Oj3oR4oH1J6iPuJTkl66wogThwj27M1S4UxvNjkN9xgpr4w4GDgCt0g4lA4gqWZeH5gRTfClEzk/fEnkrKf0X+v0Z608nv0KQdRVtnQyIhLQ+Acur9usUcaEUJbaTIwPkuJ/Bgd87ax7PDj/6/TBecw1dx36EpYH31ChRaYoVtYC7cxr+Uow7QfBIW2RBr9q2CqISLhJdCWQx5lyOye08d25Rij+rOFPUtWFN7Tn8/LZqZKee2rkvDgD8vFrmPfB0lbBpyhnxiz+tZzZEz+P2q4YK8ok5Obq3caBkjPDy4V9awWxMJW4fnsueZ7pI7f8vCmcG0T5oFroz3NF9NWXOB45/S9WuliohAe0wU6zvIKq1MVUWsfpyCR55n2n5jRotD5XKIe64p/XuQGqt+8qgkn4r9F4mstt5BxqpvVIJ469xDKd/Xk20eHftgvla386Nokk772oaTghz3q3qByIaWIccg0p1Vkqs+2CinhI3tlAh53nq6Jvuhs9bOfA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799009)(7696005)(86362001)(6506007)(8676002)(52536014)(66556008)(8936002)(4326008)(38070700009)(53546011)(71200400001)(478600001)(26005)(2906002)(55016003)(38100700002)(66446008)(54906003)(66476007)(64756008)(9686003)(66946007)(316002)(76116006)(5660300002)(110136005)(33656002)(41300700001)(83380400001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SldkodMjf8H3X/YcriUKLqJlJLya/RGOEbR/Hks/XmnmdEzz8Jd8bTxCO+82?=
 =?us-ascii?Q?Nq4pZSq+J4aT+l19jIoVereAqLyde3fMyW5uPfz66ZzPEbnKQ34zie3pgHLe?=
 =?us-ascii?Q?JaR6ZduAU5/w/KEdCrK+sJ2OgoTwPjIHg4+eAKk/DSBXMBsizF88GcsaCvUK?=
 =?us-ascii?Q?sfGbZNMjWESS5NYFa44qw7s/7wLoRkH+7harBhCrpcJxxODEB2MaxCy8Tm7v?=
 =?us-ascii?Q?Hxv0wp/t556a2rP2dwYHuCV2h1lx1LfgKUG5BQ8GnW0OjCMjLLGXZsXL1L1L?=
 =?us-ascii?Q?zazGWTQdL8sjiF1ivXwJcCG+J0j194AM6IZTfzywNeHLwtLZyPvMhMaAAwsk?=
 =?us-ascii?Q?/d5+3yBPLzNkGVwrElBheSMaf6vhof+IkNZKDgf+R0Df9F3noSlL6meGdrkh?=
 =?us-ascii?Q?gBlAaDAUwRmLmENieiCWxt6+hbB6kJkZVtsjCLhLZiFLls6amZA+pHKHjem2?=
 =?us-ascii?Q?wpMkcwvFHqaQACRUCCXn9ezS16YymRLGG4gqD5NTcot4rbU1aZxh1AFk1twQ?=
 =?us-ascii?Q?qCbRk0Pdnofy66+6uOIKxwbuMonT8peSMIdFu2M6CbwLiKI648o9u5Yt+ZYY?=
 =?us-ascii?Q?hddGZOIiKT7T8zQwhoHSt3+BBVq79TnakqTid5r9AnicBAiFk2GdfJIYdR+H?=
 =?us-ascii?Q?mABlgTevEtB1zi1ufiKiLGRvCCTuuyooEjYZho+97aUSQTn4h5rSXPp7IO2x?=
 =?us-ascii?Q?vSafaDw0Au66fQaKgckKGya15+H/H6ahu0l9OiZFG9toAPXYWNl7/N2ImsT1?=
 =?us-ascii?Q?JNs52n/PQFQXZ5Wpb6lxKEewlSDG8bwZm0kNOzaRSdnlC8bB8vS2sZvkBRLf?=
 =?us-ascii?Q?RcFJ0loZ0eAYG4daWjgItQPybD17BzHYVeu99gWbnhpL+QJzXIyD3xdzTV8s?=
 =?us-ascii?Q?Blnrx9B59abyUVlXyH43xgILT+PKJn9L7gO7MRjYL2bzobmp/IgLKzEoWKxI?=
 =?us-ascii?Q?ysRq14t3OI9xlOTP/bEIgFCN2eimGZgo4twQvDiioKqDZtQM6YmW/+tiVZ5E?=
 =?us-ascii?Q?jGkM5IBH5AzCE7EI3mAAFDfFm0HEXPl7rFd2qlbYuwJ30Cvw7W+bkIAaahzN?=
 =?us-ascii?Q?LiCSZR9eqvv4M/ESFqO/KuIa37e7YPXCFiyY6XLO4Ewq9nYLvtJSAk/22fpz?=
 =?us-ascii?Q?B0lmMrlacdHm0Jl+R8xNTDA6kPKynJ0NQDGyE/p7boU1tHMTwRhsmdQFsUzA?=
 =?us-ascii?Q?Hbn0vjjTDjm35VS4uyDsBOHijiU2Gm873f96KN7LJpLzI0lHQEihm2BLhYnJ?=
 =?us-ascii?Q?yXYydeDeRb6PoUU+W1XdeEvs7add+BP1Algi3cAkTS1pfJikRd7UraQscK7w?=
 =?us-ascii?Q?sFnFtZgS6afO+HluXbhRsdcMu66FSZCsIcUXLTpGIV0elHaQ0TLYPCAgTcdg?=
 =?us-ascii?Q?FS9SqNaIKhBX/m0YL+NPX6JHofri8vTeZg91jRowQWjgih7h8kY2KpjhTzH8?=
 =?us-ascii?Q?NG60Bpq+AHyDA+zFwKu1qTsRbsY4M/nw4zppYBlxDMgbIBMhkauMgut6y4DS?=
 =?us-ascii?Q?b99N5XAgyUTqNUoKPvX8cWySkLibMtaNKjq07Gbtu4B5b0fSLzxVNUc7XIYN?=
 =?us-ascii?Q?9TJHoI7/v2mmjgowNOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31ec243-b720-40d9-7a2d-08dbe6a1357c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 12:40:26.4262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGQitCfu8WYyJWS1GodaLLYTnAUC/3dgGpF7Pzj/1ydxl38bMy9Zc3d1rgp/F1YudSJpD9uKAZMk9FNRP/43ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, November 10, 2023 15:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v3] drm/amdgpu: Move mca debug mode decision to ras

Refactor code such that ras block decides the default mca debug mode, and n=
ot swsmu block.

By default mca debug mode is set to false.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v3: Default mca debug mode is set to false

v2: Set mca debug mode early before ras block late init as ras query is ini=
tiated during late init of ras blocks (KevinYang)

 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 14 +++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 12 ------------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mca.c
index cf33eb219e25..54f2f346579e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -377,7 +377,7 @@ static int amdgpu_mca_smu_debug_mode_set(void *data, u6=
4 val)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
        int ret;

-       ret =3D amdgpu_mca_smu_set_debug_mode(adev, val ? true : false);
+       ret =3D amdgpu_ras_set_mca_debug_mode(adev, val ? true : false);
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 84e5987b14e0..6747fbe4feab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3132,6 +3132,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev))
                return 0;

+       amdgpu_ras_set_mca_debug_mode(adev, false);
+
        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                if (!node->ras_obj) {
                        dev_warn(adev->dev, "Warning: abnormal ras list nod=
e.\n"); @@ -3405,12 +3407,18 @@ int amdgpu_ras_reset_gpu(struct amdgpu_devi=
ce *adev)
        return 0;
 }

-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable=
)
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool
+enable)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       int ret;

-       if (con)
-               con->is_mca_debug_mode =3D enable;
+       if (con) {
+               ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
+               if (!ret)
+                       con->is_mca_debug_mode =3D enable;
+       }
+
+       return ret;
 }

 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev) diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_ras.h
index 19161916ac46..6a941eb8fb8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -773,7 +773,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu=
_device *adev);

 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *=
ras_con);

-void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable=
);
+int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool
+enable);
 bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);  bool amdg=
pu_ras_get_error_query_mode(struct amdgpu_device *adev,
                                     unsigned int *mode);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6cbfb25a05de..f09f56efbdc3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1516,7 +1516,6 @@ static int smu_v13_0_6_mca_set_debug_mode(struct smu_=
context *smu, bool enable)
        if (smu->smc_fw_version < 0x554800)
                return 0;

-       amdgpu_ras_set_mca_debug_mode(smu->adev, enable);
        return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
                                               enable ? 0 : ClearMcaOnRead_=
UE_FLAG_MASK | ClearMcaOnRead_CE_POLL_MASK,
                                               NULL);
@@ -2338,16 +2337,6 @@ static int smu_v13_0_6_smu_send_hbm_bad_page_num(str=
uct smu_context *smu,
        return ret;
 }

-static int smu_v13_0_6_post_init(struct smu_context *smu) -{
-       struct amdgpu_device *adev =3D smu->adev;
-
-       if (!amdgpu_sriov_vf(adev) && adev->ras_enabled)
-               return smu_v13_0_6_mca_set_debug_mode(smu, false);
-
-       return 0;
-}
-
 static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)=
  {
        struct smu_context *smu =3D adev->powerplay.pp_handle; @@ -2904,7 +=
2893,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        .i2c_init =3D smu_v13_0_6_i2c_control_init,
        .i2c_fini =3D smu_v13_0_6_i2c_control_fini,
        .send_hbm_bad_pages_num =3D smu_v13_0_6_smu_send_hbm_bad_page_num,
-       .post_init =3D smu_v13_0_6_post_init,
 };

 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
--
2.25.1

