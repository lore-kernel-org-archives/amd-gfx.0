Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10428C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 11:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7812C10E28C;
	Wed,  3 Jan 2024 11:45:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF66F10E28C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 11:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcHOIQAynYTdQJ/r1/u6eAGv7ZVQtPkifNYy19Fa/0HQY8vKqEGpjFtc/xVQNNmye3Jslbk07OllKLbDBHv7kJn40oR2yfwbb9hal7dRsnTVLCPNyVwJx5fWpHGJrbbPpcLJ513twVgSMtbNZBRmX6x8YCV8JS22TuJlwC/Sr9AEp+AKG2N94bmcYEKbO1EbtQ0AeL26lGegUXD23wiKnIsrU1cyPNme0NWt+DQsqXxmBvp25qfbuyvpw7jLfdHLPiU7dKB1u5iDQygzZqbPQfN6uOpwNU8tIy4HWdM4nBgDkVfkJDHYo/zSxp3l0Q02dUcRGlgEmG7NJs7szVkT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWel/OGo1lAF6UbgvrdE2jm0FoaqntsM0zcZ211AC78=;
 b=QohYZ7jfMN0Ck0zmkMGoLpGuLtYhxWcVKiNRcuHmeSnEYlf658uSUL35US+2sQXl1b0/XLOB74tVD4K4+on7HHKRFzV1fWY7KLq/WsGY6vAITSmfcMsfVOF/FVWkgTrSDR2d4SRqNNzZGPYQk3Bk68S809gjXdGbhwsfWm4STo9J1gACWWj5qt7AVgFmZlcadoAw8kIIvgfKzvBrLvBqunGg51AfeyGo1J80pW5u04U0lzdmHjbnIlNUpNGpg4fwM53/7zsXK7hcLIeWz+npLHa8Hshg8ySjEXs930MQHGBW2FRK7e9TeB43x4SZUeBtWKRv18i1LechOA/wBbur0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWel/OGo1lAF6UbgvrdE2jm0FoaqntsM0zcZ211AC78=;
 b=tgNhb7f9dkfSOWGN4BisdVFF88M7MrqllUUucv6B+Xi0W4p+hWiuleUeTK0U140Zq2CMw69Co5VWbYi4P2Hq4ZPUHkG4xi/NeWWTfATkmCQ9j9tjA3c1AOIJVyBzjA6g1W158+1AnJHl3X1KyniAiu6QB0lQLNkNP0SkWc9Vu2M=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.30; Wed, 3 Jan
 2024 11:45:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 11:45:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support
Thread-Topic: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support
Thread-Index: AQHaPhtoF2jVliUNSEahjXsWGgDb9LDH+Byw
Date: Wed, 3 Jan 2024 11:45:04 +0000
Message-ID: <BN9PR12MB52575437DFB9F3DD6228BDEDFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-9-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-9-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a75187f1-d405-4ad2-8cc8-b5374008d690;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:44:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB8775:EE_
x-ms-office365-filtering-correlation-id: 407c75cd-b4e6-4316-3a5b-08dc0c516d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hMlddeXh6o+DlHD9Q2StBkiqRGZeT7FBkxW0pSCan58J4UXW7Ji00GxWhK/BrfB1c+Jb4s8u8k4nmsG59Vjv9by5cfYp/ikvrdOFCx+XfToacT8/+IZ7sy5N0CZ9E4B0mHBQ9OHF0tmMCiVj7o3+znA1M1bwVnHsVtF+2en3TNll8unZJLcbNp7/lUPt64jN8E9CW0r00zR1CazB5hfAJdaDp7L4ut6lxJik8obwKgNieDK3DZGKfQWwX2bsvZUJGoLxIOULnnQpuqlv7Ue+g2VLhlXLhpNfUk7bNs3i/U/b+giMN4MqW5d1Dab6JSR6b1/s9nglo1F0A4GIN4T3yVMP4gG2IbqW3LV61SE8DhdCsMNDqnoRx6o1W019KaE2e0zfyHSm3empx5rmoUGtXFSHOKD57L0YlO9IgqJ/muiRqIvKlT3etItEXUZL70sgPi3qw2BvqwCY5LWJmCk2MBjdpSpC0ioixLvCZ6UVQXz+i1HJDGXyJ2943hJWXSE0XiBKcfr3RzkEaAT7VK42pgT1HFIMa4rh2DUyuX0fg9JFs1+GbpFpzP4vi+8fh5iIcPo/TBb5OL5D5T4OBkC9hhcNl9X9dEwCM2sSwqrw/3mx38pMTrTjqkKm5UgOjDt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(71200400001)(26005)(66946007)(76116006)(7696005)(4326008)(83380400001)(52536014)(5660300002)(41300700001)(66556008)(2906002)(8936002)(110136005)(54906003)(66446008)(64756008)(478600001)(66476007)(8676002)(9686003)(86362001)(38100700002)(6506007)(122000001)(316002)(33656002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WV7DQVDAQGFKO0ep9aIK7lk3wYKvL9Jfp3I0JODJOzORDDb6/rE5nfWNv8Y3?=
 =?us-ascii?Q?QVfqgLF/M+MKDETD3s3OqYvRfnXk3E1+R8o1GnePN9ZoNDD6VNVj++tT7PHU?=
 =?us-ascii?Q?jrFsfa6DaQNNO9477bqYYw+BM4OD4C+Rm23TXkAjGw6QmQ95Te9LIvoX4lxM?=
 =?us-ascii?Q?pkiT1EFbS9qemTz2XAb83IdY2R6o5TlNAM9QWHhBxr/TQmzSShw23sqieSDU?=
 =?us-ascii?Q?it/M2uzRYKm8J1DDZBuFGyyKZR7UjDCiqckYUntMBLpB1v2l5LRrILh8+QU7?=
 =?us-ascii?Q?oo27rWjHXm94itWkawBpKqOfqbUf0LchJsfjZ0KuhdFCH1dPoJBHNIcJsozi?=
 =?us-ascii?Q?VHH1HIw9s34VZDnY6pVB5NXIfTEwe7g90Dm8ppvcjTjWVCuPbshuz5P0ShG5?=
 =?us-ascii?Q?Q0wwcL7pf8QSmudW5fsxCBdlR/ufXxQjr+E1mF7sPZbX2YWmf0THlqfIi1HW?=
 =?us-ascii?Q?2DfX4PRThSP8SH+z5P1klpJXeVJZL7gSRoTnlDcy662Ddz38auCZwuDmqaUU?=
 =?us-ascii?Q?EL8+zOLCK2sBtRjZ4LuA83sitJFF3cLA/8IDpuVqOnPb9mHIp6m7ts4oC3QH?=
 =?us-ascii?Q?avlSwhkWE9NFrgWfdqmNmRB5dHaN8cX2cgxxeryPeD5dn/Qg57OZEpNc2L3X?=
 =?us-ascii?Q?U2e7Zw8tR3YRPAO1IYXywGE1VrAGRcTfv1fr7jkDLzaFgrE8PWfBcUV913/e?=
 =?us-ascii?Q?JI3m9ybcUdOe2Tj+EnX5y4sRyv9N9EwNH+2vTISCcldT4lsxWsctcszAsjBy?=
 =?us-ascii?Q?5hIrOfxvBAB4FxP8kqd9NZ0A8ZJLMVUkGHMx+LQUqILGUMYvft1HF0WL9UdC?=
 =?us-ascii?Q?T6/ql7ASxzUjdM40cIF0YGhf9RInEdNl0gLJZG5BN7NPnYRpGUY3YZIOa/Ek?=
 =?us-ascii?Q?Gd+fG4RNu+dZmkL9WEVr2HG4EIEIad9pmsRDCTzpRvPnjxa2jQDqJO/5Z3SZ?=
 =?us-ascii?Q?wrQVqub+G7DYZcb1Q4EPZnyKI+IRfzFHIjj7/EB7vqU/8Gq12R0sBQzEY6PJ?=
 =?us-ascii?Q?r6k6c/Sv9Ec5tyGvu/mp3vuG1WQOmgcoTs1fB9X3zSiQmjPFBq8S7/Jxwmh/?=
 =?us-ascii?Q?63QuyUuK1SOxQng6YdcBYwMQOpU/YoeTlnZSDhC36YK0ZVSyTpab1IRjcOLW?=
 =?us-ascii?Q?9b6ASXCwUmY7PdMTu+70hkbe4eVfj0SbDj1Wvt1J4AzBs0dKq+m9RgayHs60?=
 =?us-ascii?Q?nGuxmx6Gr2rAnTCEQ/TP5O5zEOIJFs2lheIJxthm5867WOeKWSDeeI4rJ3gF?=
 =?us-ascii?Q?me4Ml/vkkQHf0eC0Pi10RpXlxM128DRTEL+w2cWi+aDYiOXjds9l8fRz10an?=
 =?us-ascii?Q?pb+kaiQAeRTolWNts8F5O1smoMJ8/RW6r5Tugi/6bXrWEHCjBVPcv2p95nmH?=
 =?us-ascii?Q?KdslQliFfp3JIxHoW4O8mppsk294MvKAkznMGVjL/qe/FJkJsHYzVzTxlmuq?=
 =?us-ascii?Q?OLvUGGJfQ5Yo2eJQBDavxPeq6LAOyjG5r7brSKZbdkTiTOMte83xgBwbFd4F?=
 =?us-ascii?Q?EA0+RDKbN/qYiO9dbOc7wCKAQQzT7uQzYq3/V6S6QT4xxNa0myaO2LJDo4HK?=
 =?us-ascii?Q?6sIAe6W1+uiwrCaU5S/Q4Zqh2+dasolC/iKdhD86?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407c75cd-b4e6-4316-3a5b-08dc0c516d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 11:45:04.3109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhwwtLGe8K+38N3BO3g/7zDuEHJNr1WxbrKV9vrqbB/zV7qHoYH1a6icFZ4HJQZBDjCasYjm+M4DVAgIyCH9YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Simiar as patch #9 and #10, let's use macro to define the magic numbers

+       case 0x36430400: /* SMNAID XCD 0 */
+       case 0x38430400: /* SMNAID XCD 1 */
+       case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later=
 */

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support

add gfx v9.4.3 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 85 +++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 131cddbdda0d..18b8e4dbe9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -38,6 +38,7 @@

 #include "gfx_v9_4_3.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_aca.h"

 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
@@ -675,6 +676,67 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_fu=
ncs =3D {
        .ih_node_to_logical_xcc =3D &gfx_v9_4_3_ih_to_xcc_inst,  };

+static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
+                                              struct aca_bank *bank, enum =
aca_error_type type,
+                                              struct aca_bank_report *repo=
rt, void *data) {
+       u64 status, misc0;
+       u32 instlo;
+       int ret;
+
+       status =3D bank->regs[ACA_REG_IDX_STATUS];
+       if ((type =3D=3D ACA_ERROR_TYPE_UE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D ACA_EXTERROR_CODE=
_FAULT) ||
+           (type =3D=3D ACA_ERROR_TYPE_CE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D ACA_EXTERROR_CODE=
_CE)) {
+
+               ret =3D aca_bank_info_decode(bank, &report->info);
+               if (ret)
+                       return ret;
+
+               /* NOTE: overwrite info.die_id with xcd id for gfx */
+               instlo =3D ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_I=
DX_IPID]);
+               instlo &=3D GENMASK(31, 1);
+               report->info.die_id =3D instlo =3D=3D 0x36430400 ? 0 : 1;
+
+               misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+               report->count =3D ACA_REG__MISC0__ERRCNT(misc0);
+               report->type =3D type;
+       }
+
+       return 0;
+}
+
+static bool gfx_v9_4_3_aca_bank_is_valid(struct aca_handle *handle, struct=
 aca_bank *bank,
+                                        enum aca_error_type type, void *da=
ta) {
+       u32 instlo;
+
+       instlo =3D ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]=
);
+       instlo &=3D GENMASK(31, 1);
+       switch (instlo) {
+       case 0x36430400: /* SMNAID XCD 0 */
+       case 0x38430400: /* SMNAID XCD 1 */
+       case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later=
 */
+               return true;
+       default:
+               return false;
+       }
+
+       return false;
+}
+
+static const struct aca_bank_ops gfx_v9_4_3_aca_bank_ops =3D {
+       .aca_bank_generate_report =3D gfx_v9_4_3_aca_bank_generate_report,
+       .aca_bank_is_valid =3D gfx_v9_4_3_aca_bank_is_valid, };
+
+static const struct aca_info gfx_v9_4_3_aca_info =3D {
+       .hwip =3D ACA_HWIP_TYPE_SMU,
+       .mask =3D ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+       .bank_ops =3D &gfx_v9_4_3_aca_bank_ops,
+};
+
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)  {
        u32 gb_addr_config;
@@ -4242,9 +4304,32 @@ struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops =
=3D {
        .reset_ras_error_count =3D &gfx_v9_4_3_reset_ras_error_count,
 };

+static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct
+ras_common_if *ras_block) {
+       int r;
+
+       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       if (r)
+               return r;
+
+       r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
+                               &gfx_v9_4_3_aca_info,
+                               NULL);
+       if (r)
+               goto late_fini;
+
+       return 0;
+
+late_fini:
+       amdgpu_ras_block_late_fini(adev, ras_block);
+
+       return r;
+}
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras =3D {
        .ras_block =3D {
                .hw_ops =3D &gfx_v9_4_3_ras_ops,
+               .ras_late_init =3D &gfx_v9_4_3_ras_late_init,
        },
        .enable_watchdog_timer =3D &gfx_v9_4_3_enable_watchdog_timer,
 };
--
2.34.1

