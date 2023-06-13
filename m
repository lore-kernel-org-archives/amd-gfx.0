Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA12C88CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 07:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7511010E343;
	Tue, 13 Jun 2023 07:36:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109BC10E343
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 07:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhCf6YSx6JKlxAs/JSsmLjwNumtrKkHJKwfaI6QX0m2+ykJc13kkCxj6bnzyw5zklvjcaFB0xBcuYeNaALev+jVBJ4kG+uZHU7+hTjRA3U7ig+oNDgaRBsFh22DODbjFRHbNb3wRNa2rafZE49fci0aXj2477AQCkXFDmZB5cCaHeHs0bGB42qt/S1lKeLhqkQwBRBx5rAfxpNCS35yqkie716/pJhaguHd1fQ2QXHEb+EjPl5y0WGN4JXMoysa6uaIgEe+LRta93b2xC9Pg8V3XUjy7eax6LJhMgmpBM0nHDhHqZ2nFOsFygBgaz7M7kpzT2Zz4rrxUI3SWXHd97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llV2wYeRfTCWv/ICaWmcEdzzH2hK/N6zMgy0a+1gENA=;
 b=SuLOEYgq26FoO2QxDBk0EMvQoWvxajXBelyPSpftJquc/eKWJeThiJYqSUTHxCRyAkCEMHFEiIg85r2FBLoinqcQwsOuR7iuoNwvydQSxI5ogYF7kr8P7WgKwPv7wSfNj7iBgBLyO///P0SWZWNgo3Mh7275vPTopWFk+vK1gaC2VwwVloep8f30Il7r7+MFwc7ISexD6ZmrKAMk9QswmJDuZllIfKZKMRNyUC8dTB/LQqr375sb2acsP4OJA+GTGk3teiGMlN6BDgmlIsHpE3JCNxuWn44z27XH5GLe72HPz1IeuXg48q/XCzmfvAdtpbG7KMxPWJSBpS3hNB4exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llV2wYeRfTCWv/ICaWmcEdzzH2hK/N6zMgy0a+1gENA=;
 b=bOeyw2sN3GjwqVgzK9o64SVZTAQ94pwz85IdhDF94sWWygAYSly+viwXtSC/bBk+GFVnzhH9ZgKbYs7hV53T5Cj4myXfy9bY4N6PhtQXxTewGeHvHvzERKHddlribxMjwVrWquMNOhP6ROjdd3UCRov5KWRyUig4U++6tY/uEKs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 07:36:41 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::1a03:f98e:d572:54f0]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::1a03:f98e:d572:54f0%6]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 07:36:41 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add wait_for helper for spirom update
Thread-Topic: [PATCH] drm/amdgpu: add wait_for helper for spirom update
Thread-Index: AQHZncjG7VC2e19lwkCCW0JU/LT0LK+IV5Vg
Date: Tue, 13 Jun 2023 07:36:40 +0000
Message-ID: <DM4PR12MB51818D4B32943D71C8D0D8C3EF55A@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20230613072924.403550-1-likun.gao@amd.com>
In-Reply-To: <20230613072924.403550-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8453970e-a394-4795-8fef-dcec98ab82be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-13T07:35:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DM4PR12MB6328:EE_
x-ms-office365-filtering-correlation-id: 524973a0-2948-43f1-bf47-08db6be0edcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RffKv73hieBTjgDo9pi/EQ9Y+tWHNRPFFGuLM9MBYUsBY5yo0CpTFDUxGDAfOVuJSn68EnSMDlOyYEkqjfqlzHGJK15130JvaWQgXRbYrEPGCgR6sC5j5/UPL1YW1IlWrlGGQTQ6FQOXrZr26jT+SQXp/ZFrVLkLZpMWoh82WDME5f43USEcGOkwQe3d1w6VZhZIVALQYTvelzOs3ApRUuA8rofhCuEyODrbkvey47NvBKuSJw+j0iLzno+KFTkz+PqDydfQuil1OzZk5mCH7J+unyqHWoTR/xKBSsNw3DZ6PXNazHhieaVNmTL6DO4u02VqSbmRJZyQK47BL8w6lHe/p7Cv7X1FEvfIcb7ueWcX+/ztpbtvUylE5MEgGlXdY66xl/6CgYgvKKg8t0dSrJKLsnW4KJn1Z/mCIxI6dOt6H3l9kXMiLCRHpfGU9mHNTyEzR1mmLP5429JrFYUjEn2sC9rhTk+I2AL0kcSBEUQyvQQabBvvpYcOmOxfsbVIrQoTgv4iDQ9rS6t1kfw6kSkqZpuuBZC05g0bQ4Biqe0AXlQpoz8lXalHsPJwGiSX69DLwOP1wMm1Lb2+Whf5TdZK8SZPeEy4BbKcVtl21CaBXXkTgfbWpeR9dbIrgd89
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(86362001)(33656002)(2906002)(38070700005)(15650500001)(55016003)(7696005)(186003)(83380400001)(52536014)(53546011)(9686003)(6506007)(26005)(122000001)(66556008)(71200400001)(66446008)(6916009)(478600001)(66476007)(316002)(38100700002)(64756008)(66946007)(76116006)(41300700001)(5660300002)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gyJSzsHpou4G+/YxpfrcwqUHfMii0z0Agzb6VHXwUxwb5APGEA1OhS+cTcd?=
 =?us-ascii?Q?UVnuLtSp3LbmY/J5ZScNrIq1GNbs41yWhCEcqcysJVKS6tDW7/bdSXZodMG3?=
 =?us-ascii?Q?uooNPFjqt240AQTq3z6TKceBE3+PS6Ey+AR7Adxoi0FvQJ7+sX82rvJTVsXx?=
 =?us-ascii?Q?Hn2zznj2Jv7NJ+OCxKgNB5s8G3vWITndZNd6DbYi1mURZ9o3JI0Llz0TetJJ?=
 =?us-ascii?Q?rjVWIyM5ptKO1xbn7mkPScthiEhjeD/u+42RaPhLbRkEhQIfpzXufaJu6Ih5?=
 =?us-ascii?Q?TuwZH/bkDPLQS3uklSfk+zUiw00qma8f0d+1kj/kyZMLzIPzq2nJAEVwWzXX?=
 =?us-ascii?Q?IZDPc+rpLcnXD0Grxoht+T9sFJ/Sz6DXLv5leh777vZKQ2W8QeVoVRvV9CC4?=
 =?us-ascii?Q?adFcoUxb85i2ne9KnBNhswCH/1Fxhv13Tfw6tlHRvmv3BDuxmxx8XXKiNTeh?=
 =?us-ascii?Q?gumtcRjjkPDyC3/5MKjPjKVZmcReCRMyZIR4vveBsvN35kQAamQn/O1Ng2HX?=
 =?us-ascii?Q?6KySOPkMqsQ6pJOLfMNU9K54E0xJ+sgfQUySLpvlMt5qkiIdECV17C+GCFXp?=
 =?us-ascii?Q?sqVUeD7tKJoJ7gwJemW1w4z/nOIJwiC3fMfopiM8Zd5dKIHbuMrmyq3OVkEs?=
 =?us-ascii?Q?s655epWSkYI5roSx7gAaRTXbmaCFj60oG/UdiRUmiPlqOo2Ff2ks4PF27NJU?=
 =?us-ascii?Q?881eqR/WCQ8nX9rPdAY1/Hu6rqUo0AKGRUR1fbN7C60wFdlfsCwAeKcSAlBE?=
 =?us-ascii?Q?zx+vsr8CMCdtC7oeUtmC5EqSmKdSKb+cAmq8jX1PIhs2zJ8i1Zh0YdufdXPI?=
 =?us-ascii?Q?6/nn8mowA16ZmBOzblzODEfR8VUKGCvpzQZ/g/R8SAUjUcvI021R/555n+74?=
 =?us-ascii?Q?A1kRbR6mhJ3S4Vcqwj8tkLyt+aMrSvsv+DtXYQXg7PdnmOIKQ1EqZlKlz88p?=
 =?us-ascii?Q?ydSBAvb8yOKFIr7TrhYDcwP8Rw8QguBSG1sSP1P9chkhWEWFlbbOUEnsmimL?=
 =?us-ascii?Q?ygvxxXfO0vMqQZhEE71FMZv7qBulBVv3nr/MizoHvDKJGjCR+HHjIMBxQsd2?=
 =?us-ascii?Q?1wrzYf9ltqnpJiA3VEsQNAP3y0jtq8I6Xkt0D6EKSxq+WDxbJRMiCJ9gOpNO?=
 =?us-ascii?Q?y9eSkYkrb32Nrby4ZZOKv+OTj9jyGLZmIOjYlsn3yp4gpFWIPXwinWTrAjd4?=
 =?us-ascii?Q?LMBnJEqsfOxFymU9IjUU5kOfFOL5o4ioPIxBFJJonoEx37zfhYjcQP62gU15?=
 =?us-ascii?Q?5FWJhrn/RGc+ZcoRcbI6wnFGJLvXTQ2lyvGU86tP34vQTAzY4NnT386Tplqv?=
 =?us-ascii?Q?wRiWjmEZHKyTYMWkm7ThlRqzLYQHld1LgKA+5C3o2K2zpzF3djh/Xav2YPF4?=
 =?us-ascii?Q?H0AyQPA/5es5DG3CWwwWnjfctBbGc13OvDe46cJJiLpz61s0UsWBzcZ4p18Q?=
 =?us-ascii?Q?+96Nt0r1uIvTp6d1KH2Lq1+pVnXaUsCRlX+8reUq/SWnN9vg4hqx9HAAT98g?=
 =?us-ascii?Q?vxAA/uNxGDPXm4KxmunNqdAfBSAJU5RJ0ki3+/2ZYM8GBSbmSPhq7Zo3OsJn?=
 =?us-ascii?Q?chp1RNLihiJ7zMBRN14=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524973a0-2948-43f1-bf47-08db6be0edcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:36:40.9650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5WlB79X29ch2bG+wd9whsHghtkip8EOiJpc+pbtHih6qj85dAFKy8AUtOvJID5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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

From: Likun Gao <likun.gao@amd.com>
Sent: Tuesday, June 13, 2023 3:29 PM
To: brahma_sw_dev <brahma_sw_dev@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add wait_for helper for spirom update

From: Likun Gao <Likun.Gao@amd.com>

Spirom update typically requires extremely long duration for command execut=
ion, and special helper function to wait for it's completion.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 20 ++++++++++++++++++++  drivers=
/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++  drivers/gpu/drm/amd/amdgpu/psp_v1=
3_0.c  |  9 +++++----  drivers/gpu/drm/amd/amdgpu/psp_v13_0.h  |  2 ++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a39d4ddf7743..fa06da014473 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -560,6 +560,26 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg=
_index,
        return -ETIME;
 }

+int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_index=
,
+                              uint32_t reg_val, uint32_t mask, uint32_t ms=
ec_timeout) {
+       uint32_t val;
+       int i;
+       struct amdgpu_device *adev =3D psp->adev;
+
+       if (psp->adev->no_hw_access)
+               return 0;
+
+       for (i =3D 0; i < msec_timeout; i++) {
+               val =3D RREG32(reg_index);
+               if ((val & mask) =3D=3D reg_val)
+                       return 0;
+               msleep(1);
+       }
+
+       return -ETIME;
+}
+
 static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)  {
        switch (cmd_id) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index cf4f60c66122..ec3f3fe5efff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -455,6 +455,8 @@ extern const struct amdgpu_ip_block_version psp_v13_0_4=
_ip_block;

 extern int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
                        uint32_t field_val, uint32_t mask, bool check_chang=
ed);
+extern int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t re=
g_index,
+                       uint32_t field_val, uint32_t mask, uint32_t msec_ti=
meout);

 int psp_gpu_reset(struct amdgpu_device *adev);  int psp_update_vcn_sram(st=
ruct amdgpu_device *adev, int inst_idx, diff --git a/drivers/gpu/drm/amd/am=
dgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index caee76ab7110..67e216373585 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -624,10 +624,11 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context =
*psp, int cmd)
        WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);

        if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
-               return 0;
-
-       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_115),
-                               MBOX_READY_FLAG, MBOX_READY_MASK, false);
+               ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0, 0, regMP0_SMN_C2PMSG_115),
+                                                MBOX_READY_FLAG, MBOX_READ=
Y_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
+       else
+               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_S=
MN_C2PMSG_115),
+                                  MBOX_READY_FLAG, MBOX_READY_MASK, false)=
;
        if (ret) {
                dev_err(adev->dev, "SPI cmd %x timed out, ret =3D %d", cmd,=
 ret);
                return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.h
index b2414a729ca1..9eae5e23b2e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
@@ -25,6 +25,8 @@

 #include "amdgpu_psp.h"

+#define PSP_SPIROM_UPDATE_TIMEOUT   60000   /* 60s */
+
 void psp_v13_0_set_psp_funcs(struct psp_context *psp);

 #endif
--
2.34.1

