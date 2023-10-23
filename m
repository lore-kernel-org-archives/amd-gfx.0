Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B2BC25B47
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 18:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466A110E199;
	Mon, 23 Oct 2023 18:43:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6028410E199
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 18:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2+Ff6QJvDwEroPGhMmntc++MFXK4q4/bfXheVR8Wgux45lSvRp81T5+8gHuiDDD87HdChMwdU2vk5lSm65Bw7DWVI00Mk+1GwxkvxDLUN0nj89xUNe38fsuVnnOcsmS6jY5jtBS7vFufx5aOMD7FhA5wU8aHgwvkxMDTO58QKDd/PdEGX+xccQ4DC0P5qLl1YFi5zsDQedVYUFhZdqY4f2+DHUcOhVCoymwU7eaDhIN0jtzpajsjhFlgSwPItQyKeNmr4iJDl2vBs8y1WzsMy1zYv5wvhzDQvmSlwgYLfiLstIbR1d2kZ/6eCsXzSD09kkGRLx353qhdzXevGsOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v02J31yshSR3iZ2ufbfv8dUqxV5Je+7DkrBHOemlFOc=;
 b=KZvxUei4vs8nUjXkOlW1Cik2zmR5reOLDwZnp5crLkgD0ZKHeo0uVrl05WGLdHV/3JAyKCnU84LsIgSKvbM1IUpXsth9ZO4RQGzEFF+90X0unt8a1m5YuuYMpVkhS1Noqhnig/16sWYwGeiRSuYvM7TN3aOD7xrov/hYmXtt6k2/fDJLWbjZcmOwB3jrS165ZnPo5d6f/PXGoKVwXZkk+VfjjqSGU2gSS9G1lXFosnqlUcxloJYkUGVCgwewNaxCGz3UN9QyNlz8USYxJFUaORECwpEicA4fUs+R/sCX3OaHBiSvwTJtnAJID1P9Q/en+jPSJ//2aUjeZTnzStbvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v02J31yshSR3iZ2ufbfv8dUqxV5Je+7DkrBHOemlFOc=;
 b=NTEvTxOxS6EHXJOsK7L6ScnuX86RvyyglvEdFkaNJs4WSw4i0G4YX6WJwkEJ1/EwjKxMVvT97t0evn9CMxMLviVWlClaIkkut9LITNiTRkmhDaKz5JkNCqFZogeoeTsjICRaDHeMww8leQZAOED61BcRAEZNYVSWLLO/pundqPQ=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 23 Oct
 2023 18:43:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 18:43:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
Thread-Topic: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects
Thread-Index: AQHaA2gaRLpu+vlsK0y61G8TLR8IvbBXuoQz
Date: Mon, 23 Oct 2023 18:43:01 +0000
Message-ID: <BYAPR12MB461474F7B4D09C21EF63EE9897D8A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20231020151422.349394-1-lijo.lazar@amd.com>
In-Reply-To: <20231020151422.349394-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-23T18:42:25.2551108Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SN7PR12MB8602:EE_
x-ms-office365-filtering-correlation-id: ba0370b1-1a79-45fd-0115-08dbd3f7e2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9dYW03GZ2cY+5vrqiaeHQrTWfRaqogFmH8wgCj3doXfWNzOZXj4AQBRpHhOJABwPqqCMY5tWJI1l60GLjTqfUP92r7ZumYL34UUs+AbiDA7dF/fw6X8U3LwxQGCUV5wgtWoTzwPHvbCch9ayar3HSa7UWfli008A7G2AFnntlJjEWUul3v1cn2C96p0BIjE+y3dOaAvYyTZZuXfByRRbTIzFfGLdYZgRonDaFzowUJWCztb6WbopCLHXXC31SBFcS/AQHDixIKdHaJSRg/B2tLJeWfMfQwvx4e2LhgQHD8rcGdgISgeHvse/DECrRwyJPFvm9O59sKAOQ7V5nvuBal0Hd+7pbKhgmhEXV5QV5m80duppetv0ZsjCMV4ZedmVZc25xn1ADbeS/JRR+NsBeupqFH48JVY2ofy1ldS3koqtbVkayNtk5G3v+tCFhDWapT4Er9G5lj5wTF2eQdaXz+2KuYKUFxElTEMUJP1ZMb0pRhVWX33Pd+hlu0KwIeoSrKkGTKMEY7pFBXkiozx2587JLuyxNc922jMSL14y+fR63vRWkFQqdqN70Yb4Z8vYXmIywNWcvah64kOW56btks1ZpXFMXYhctpAkCZHxxkAs9bRDPYXFp3IihxnFJBm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(38070700009)(2906002)(55016003)(9686003)(6506007)(7696005)(53546011)(478600001)(71200400001)(83380400001)(33656002)(38100700002)(86362001)(122000001)(66556008)(6916009)(54906003)(26005)(76116006)(41300700001)(52536014)(8936002)(64756008)(5660300002)(4326008)(316002)(8676002)(66446008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0Vit9/gXzcp6fswFMBJlKcGrhZWpde9l4hP8esUd+NwE+lP5iXI2Ljd9KR4?=
 =?us-ascii?Q?cbF4hg++cQsRw4H/Szc6ygujPsZ0Wip9ZRllJGy7F+j249Hp6NI+eUYqmBs6?=
 =?us-ascii?Q?R5NdtgEIlchKFAOp2MeaKdeiv5B0U+rhTPrppfT1TmtwBAKQ1A2Z0m/Zrdk3?=
 =?us-ascii?Q?SrgSh8fimYMh6pVNnhDM2WN+SsGNJ8nB6kIS2ggwSRnquU0gIvzgRYmbtCSu?=
 =?us-ascii?Q?160mu3nfzGdZey4GEKRpVflN3nsNNcpM9sujTxqSjtY84JGAZ1HHXkt/Hv+w?=
 =?us-ascii?Q?Mow3NORl6ZKt+hxu9X+R9IoCU/hwrlcbrOB/olV7bZoK5D8RNKAakemrCgEk?=
 =?us-ascii?Q?CH/fylW/AbwmKreRz1+6CDhpFY1LiudASbJm9N3b1renljEOCvqHs8nprPR5?=
 =?us-ascii?Q?TmUQ/+wxD3hgrrYqmr+WYIMBJW6DF7soBJLfsj97YuGuyRAl7R+R9p3v3nb+?=
 =?us-ascii?Q?O0QsE6Yshkh6abmKbThw2/7X/VdaRu9EM9TaBAfsSqcl/MZKom98B/qBzcfN?=
 =?us-ascii?Q?S2dNLohxMq+B+wa/IJi7yTDbhX+NW+q9+U6vUz98U9qBWRMGBbVQYbzNca6J?=
 =?us-ascii?Q?nW9Up5sPvrCOC4pP7YOwB37AESJ8t4SgZj8Q6WijDRoUXB8o/RtXpNVJELKO?=
 =?us-ascii?Q?77fg0+yMBnI8JVPSV0hkFjLcSGDg+J3U9ADA3hFUbwfIHTcWXBseS3cnO6pu?=
 =?us-ascii?Q?9BUc5rqTlqkSY17AmyG4RZI1N1T7/8Irr0mBkRHeCnwoagg1tVru43fT9U5t?=
 =?us-ascii?Q?vy8HeLYvaKZODtUCR/DM2WVk+WnRMH07siDtn90qMDItRC/sUjrWv+G8SZ5N?=
 =?us-ascii?Q?wEYeBm6+83/xiTbugU9AAd/EZyMN0cah7mhXb5A/4CE4x1jogL3Rj8hVm1GM?=
 =?us-ascii?Q?2sO3RaeO2Fk4OwyFz+P+8zAhxSL7d0Vi4UVf1RZBw3/rSduDvQDhiW1Jr02w?=
 =?us-ascii?Q?RuXC/cy2CE+5RAmObbxJ/lUCnlQqP3S5Sx0Va+xYsS7qs4AOoSjCHqdTo3dy?=
 =?us-ascii?Q?UyRWn8DkGqmi5hCIxvVLoOqlM//o2DM7VPiJtGv/mdJAUs7oy7IwXufV+buw?=
 =?us-ascii?Q?YwHKt39rinMTZrm2goXw5PyImqbJ1ADZ1ouVf3N6/O5gFV6D6CRrhQ3H7laV?=
 =?us-ascii?Q?tVomjzDbwd5IzmvSUJIfwy2towSzMUbBLj9Y8thuiNWWbnWAfEj5LmN4faTI?=
 =?us-ascii?Q?6asTxtIuPei2Mh7XDA7bV1R3BVwQAXso5yJcoetU2xkuXTdZkmLaBbaOb2Pf?=
 =?us-ascii?Q?bFRyXHl6i4k7V90nOqysUHnkAuGlgbr1L/HQxnd+P9N43WgalZa9YJb/BLS4?=
 =?us-ascii?Q?+An8bmfXPIWx2FPnVOLPlzx9UMAaGd3IYS7fM9w6Xj/hJCgCKeY30gUcpSK/?=
 =?us-ascii?Q?Hp8gLhoOEdtlaqnn+GjsgIBmx4Csqf16nTKwgH71Ubp3UNxRASz5MlbplLVh?=
 =?us-ascii?Q?aZJou86b69dYskRUyo3I/eIzTWhEXiGA0A3phjjyjmyBioV9iZk+J0pz9yiJ?=
 =?us-ascii?Q?/m1cCl+cEkVQryap4DgBZC6TJUt7vexHuNAWWDwlCP83qbd3IsSjs0ZhVVu8?=
 =?us-ascii?Q?h/Qqk8MeNXhMRmzjH0qHH5qFmdHcRtG4veBJGcLg?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461474F7B4D09C21EF63EE9897D8ABYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0370b1-1a79-45fd-0115-08dbd3f7e2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 18:43:01.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3GpOsarmMa9AFQfZFaYbGAN5f4cSrrPOq89f8LCylOrGM/viLoC8m0Ej2amgQuy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461474F7B4D09C21EF63EE9897D8ABYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, October 20, 2023 8:44:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kasiviswanathan, Harish=
 <Harish.Kasiviswanathan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects

PCI domain/segment information of xccs is available through ACPI DSM
methods. Consider that also while looking for devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index 2bca37044ad0..d62e49758635 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {
 struct amdgpu_acpi_dev_info {
         struct list_head list;
         struct list_head xcc_list;
-       uint16_t bdf;
+       uint32_t sbdf;
         uint16_t supp_xcp_mode;
         uint16_t xcp_mode;
         uint16_t mem_mode;
@@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handle =
handle,
 #endif
 }

-static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)
 {
         struct amdgpu_acpi_dev_info *acpi_dev;

@@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_d=
ev(u16 bdf)
                 return NULL;

         list_for_each_entry(acpi_dev, &amdgpu_acpi_dev_list, list)
-               if (acpi_dev->bdf =3D=3D bdf)
+               if (acpi_dev->sbdf =3D=3D sbdf)
                         return acpi_dev;

         return NULL;
 }

 static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_info,
-                               struct amdgpu_acpi_xcc_info *xcc_info, u16 =
bdf)
+                               struct amdgpu_acpi_xcc_info *xcc_info, u32 =
sbdf)
 {
         struct amdgpu_acpi_dev_info *tmp;
         union acpi_object *obj;
@@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_=
info **dev_info,

         INIT_LIST_HEAD(&tmp->xcc_list);
         INIT_LIST_HEAD(&tmp->list);
-       tmp->bdf =3D bdf;
+       tmp->sbdf =3D sbdf;

         obj =3D acpi_evaluate_dsm_typed(xcc_info->handle, &amd_xcc_dsm_gui=
d, 0,
                                       AMD_XCC_DSM_GET_SUPP_MODE, NULL,
@@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,

         DRM_DEBUG_DRIVER(
                 "New dev(%x): Supported xcp mode: %x curr xcp_mode : %x me=
m mode : %x, tmr base: %llx tmr size: %llx  ",
-               tmp->bdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode,
+               tmp->sbdf, tmp->supp_xcp_mode, tmp->xcp_mode, tmp->mem_mode=
,
                 tmp->tmr_base, tmp->tmr_size);
         list_add_tail(&tmp->list, &amdgpu_acpi_dev_list);
         *dev_info =3D tmp;
@@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,
 }

 static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_info,
-                                   u16 *bdf)
+                                   u32 *sbdf)
 {
         union acpi_object *obj;
         acpi_status status;
@@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_ac=
pi_xcc_info *xcc_info,
         xcc_info->phy_id =3D (obj->integer.value >> 32) & 0xFF;
         /* xcp node of this xcc [47:40] */
         xcc_info->xcp_node =3D (obj->integer.value >> 40) & 0xFF;
+       /* PF domain of this xcc [31:16] */
+       *sbdf =3D (obj->integer.value) & 0xFFFF0000;
         /* PF bus/dev/fn of this xcc [63:48] */
-       *bdf =3D (obj->integer.value >> 48) & 0xFFFF;
+       *sbdf |=3D (obj->integer.value >> 48) & 0xFFFF;
         ACPI_FREE(obj);
         obj =3D NULL;

@@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
         struct acpi_device *acpi_dev;
         char hid[ACPI_ID_LEN];
         int ret, id;
-       u16 bdf;
+       u32 sbdf;

         INIT_LIST_HEAD(&amdgpu_acpi_dev_list);
         xa_init(&numa_info_xa);
@@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)
                 xcc_info->handle =3D acpi_device_handle(acpi_dev);
                 acpi_dev_put(acpi_dev);

-               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &bdf);
+               ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &sbdf);
                 if (ret) {
                         kfree(xcc_info);
                         continue;
                 }

-               dev_info =3D amdgpu_acpi_get_dev(bdf);
+               dev_info =3D amdgpu_acpi_get_dev(sbdf);

                 if (!dev_info)
-                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info, b=
df);
+                       ret =3D amdgpu_acpi_dev_init(&dev_info, xcc_info, s=
bdf);

                 if (ret =3D=3D -ENOMEM)
                         return ret;
@@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *=
adev, u64 *tmr_offset,
                              u64 *tmr_size)
 {
         struct amdgpu_acpi_dev_info *dev_info;
-       u16 bdf;
+       u32 sbdf;

         if (!tmr_offset || !tmr_size)
                 return -EINVAL;

-       bdf =3D pci_dev_id(adev->pdev);
-       dev_info =3D amdgpu_acpi_get_dev(bdf);
+       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
+       sbdf |=3D pci_dev_id(adev->pdev);
+       dev_info =3D amdgpu_acpi_get_dev(sbdf);
         if (!dev_info)
                 return -ENOENT;

@@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *=
adev, int xcc_id,
 {
         struct amdgpu_acpi_dev_info *dev_info;
         struct amdgpu_acpi_xcc_info *xcc_info;
-       u16 bdf;
+       u32 sbdf;

         if (!numa_info)
                 return -EINVAL;

-       bdf =3D pci_dev_id(adev->pdev);
-       dev_info =3D amdgpu_acpi_get_dev(bdf);
+       sbdf =3D (pci_domain_nr(adev->pdev->bus) << 16);
+       sbdf |=3D pci_dev_id(adev->pdev);
+       dev_info =3D amdgpu_acpi_get_dev(sbdf);
         if (!dev_info)
                 return -ENOENT;

--
2.25.1


--_000_BYAPR12MB461474F7B4D09C21EF63EE9897D8ABYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div dir=3D"auto">&lt;ping&gt;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Friday, October 20, 2023 8:44:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kasiviswan=
athan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Use pcie domain of xcc acpi objects</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">PCI domain/segment information of xccs is availabl=
e through ACPI DSM<br>
methods. Consider that also while looking for devices.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++----------=
-<br>
&nbsp;1 file changed, 22 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index 2bca37044ad0..d62e49758635 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -68,7 +68,7 @@ struct amdgpu_acpi_xcc_info {<br>
&nbsp;struct amdgpu_acpi_dev_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head list;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head xcc_list;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sbdf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t supp_xcp_mode;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t xcp_mode;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t mem_mode;<br>
@@ -927,7 +927,7 @@ static acpi_status amdgpu_acpi_get_node_id(acpi_handle =
handle,<br>
&nbsp;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u16 bdf)<br>
+static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_dev(u32 sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *acpi_dev;<br>
&nbsp;<br>
@@ -935,14 +935,14 @@ static struct amdgpu_acpi_dev_info *amdgpu_acpi_get_d=
ev(u16 bdf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(acpi_d=
ev, &amp;amdgpu_acpi_dev_list, list)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (acpi_dev-&gt;bdf =3D=3D bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (acpi_dev-&gt;sbdf =3D=3D sbdf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n acpi_dev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_info **dev_inf=
o,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_info *xcc_info, u16 =
bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_info *xcc_info, u32 =
sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union acpi_object *obj;<br=
>
@@ -955,7 +955,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_dev_=
info **dev_info,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;tmp-&g=
t;xcc_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;tmp-&g=
t;list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;bdf =3D bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp-&gt;sbdf =3D sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D acpi_evaluate_dsm_=
typed(xcc_info-&gt;handle, &amp;amd_xcc_dsm_guid, 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMD_XCC_DSM_GET_SUPP_MODE, NULL,<br>
@@ -1007,7 +1007,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;New dev(%x): Supported xcp mode: %x curr xcp_mo=
de : %x mem mode : %x, tmr base: %llx tmr size: %llx&nbsp; &quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp-&gt;bdf, tmp-&gt;supp_xcp_mode, tmp-&gt;xcp_mode, tmp-&gt;me=
m_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp-&gt;sbdf, tmp-&gt;supp_xcp_mode, tmp-&gt;xcp_mode, tmp-&gt;m=
em_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp-&gt;tmr_base, tmp-&gt;tmr_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;tmp-&gt=
;list, &amp;amdgpu_acpi_dev_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dev_info =3D tmp;<br>
@@ -1023,7 +1023,7 @@ static int amdgpu_acpi_dev_init(struct amdgpu_acpi_de=
v_info **dev_info,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int amdgpu_acpi_get_xcc_info(struct amdgpu_acpi_xcc_info *xcc_=
info,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 *bdf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *sbdf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union acpi_object *obj;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; acpi_status status;<br>
@@ -1054,8 +1054,10 @@ static int amdgpu_acpi_get_xcc_info(struct amdgpu_ac=
pi_xcc_info *xcc_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;phy_id =3D (o=
bj-&gt;integer.value &gt;&gt; 32) &amp; 0xFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* xcp node of this xcc [4=
7:40] */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;xcp_node =3D =
(obj-&gt;integer.value &gt;&gt; 40) &amp; 0xFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PF domain of this xcc [31:16] */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sbdf =3D (obj-&gt;integer.value) &am=
p; 0xFFFF0000;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PF bus/dev/fn of this x=
cc [63:48] */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *bdf =3D (obj-&gt;integer.value &gt;&=
gt; 48) &amp; 0xFFFF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sbdf |=3D (obj-&gt;integer.value &gt=
;&gt; 48) &amp; 0xFFFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACPI_FREE(obj);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D NULL;<br>
&nbsp;<br>
@@ -1079,7 +1081,7 @@ static int amdgpu_acpi_enumerate_xcc(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct acpi_device *acpi_d=
ev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char hid[ACPI_ID_LEN];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;amdgpu=
_acpi_dev_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xa_init(&amp;numa_info_xa)=
;<br>
@@ -1107,16 +1109,16 @@ static int amdgpu_acpi_enumerate_xcc(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xcc_info-&gt;handle =3D acpi_device_handle(acpi_dev);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; acpi_dev_put(acpi_dev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &amp;bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D amdgpu_acpi_get_xcc_info(xcc_info, &amp;sbdf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree=
(xcc_info);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_a=
cpi_dev_init(&amp;dev_info, xcc_info, bdf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_a=
cpi_dev_init(&amp;dev_info, xcc_info, sbdf);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D -ENOMEM)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -1136,13 +1138,14 @@ int amdgpu_acpi_get_tmr_info(struct amdgpu_device *=
adev, u64 *tmr_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; u64 *tmr_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *dev_info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!tmr_offset || !tmr_si=
ze)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf =3D pci_dev_id(adev-&gt;pdev);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf =3D (pci_domain_nr(adev-&gt;pdev=
-&gt;bus) &lt;&lt; 16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf |=3D pci_dev_id(adev-&gt;pdev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
@@ -1157,13 +1160,14 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *=
adev, int xcc_id,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_dev_inf=
o *dev_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_acpi_xcc_inf=
o *xcc_info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 bdf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sbdf;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!numa_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdf =3D pci_dev_id(adev-&gt;pdev);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(bdf)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf =3D (pci_domain_nr(adev-&gt;pdev=
-&gt;bus) &lt;&lt; 16);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sbdf |=3D pci_dev_id(adev-&gt;pdev);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info =3D amdgpu_acpi_get_dev(sbdf=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB461474F7B4D09C21EF63EE9897D8ABYAPR12MB4614namp_--
