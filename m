Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D897BC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 05:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566F510E030;
	Tue,  2 Jan 2024 05:18:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C5D10E030
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 05:18:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvT3MmStlbRDTMnCmjFJcHZy/tAc7bB/3tZkE9+mrGM6yDcFvtWilUEwMEJLVRSO1DzSZyHWy4JPu6jFtDITbDKtPDQt8AqLQexGyQE8wX9yvRCwIoGhUaNfp4HGIFebwGtpRCQh9KP/qAZZ0AS/TmwEE1i8xPDsiKZ/o4eWu48gxcUIhR+Wp8Y8ImT/w89lX+XWMNclOCyRxbecLsqbCZWy6Cq/xkmPhEAmR4yDBXiHefu6jnI5qFkLa7YrqwF8lKbVJcstbyYJ6mWPhJpePLSPFaShFtS88uNW6AldVnOSIYnHH5hnt+Nh45dZT5eGlMclpB5VAlzfhy9ChJe88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Vs7wdrqoGf7/uM5QZbG2yl0r/lSRGvyU3Wj6RXAlc=;
 b=NJlUOVHS2XLUaLYY+WEoNMgshUNijrch0HbUPcL5Fb5iPq96nIx2kd9CCcMbJvZCvbfxThTXu3+YsAbo0QfUgw94D3M6+s25W7gf1tx+h8PTnoke5YQJqVlvf3MXOlWM0DBYoTe1LGZmIEuBmHzEsgwjBuatS3d0THAWRpHWLqsuFJVI7f0R6QTbbwuFEJzcsFeIXFVkXW9HPdsRpzoYd5QQ4oWHNblfOXWDzWvZKvW1eMeUO0jDwSEMmy1nCeQ5f7rG7m08qqaSPbKyuI0SY62tCM7iLdAdj59N6MbuzXU4hE14PjBPbeNYXdZGl5R8ERlXxUFFWtyRdGkqZ5EeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Vs7wdrqoGf7/uM5QZbG2yl0r/lSRGvyU3Wj6RXAlc=;
 b=GUUmLxdsnBNf281NFuZQpxdR2PZU3TgXQcZT0AVj6ijg1Y8GiW+8WcP55V96un/K1qL99xdRweA9+AZZyiaaj8pbOReCU0ThBfWT+lCw+USoDBABP7aewpGUOBMB902z5Py6fI4Mcn9LAJSIp+QUQk9nb6La4fLUnpQGx7BrjqQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:18:33 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:18:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Topic: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Index: AQHaPS4QPAFxjlgajE+3PnHduDfgA7DF+YcA
Date: Tue, 2 Jan 2024 05:18:32 +0000
Message-ID: <PH7PR12MB599727B1E79936287A6FD4F38261A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
 <20240102034440.16376-3-Hawking.Zhang@amd.com>
In-Reply-To: <20240102034440.16376-3-Hawking.Zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ceb12e59-4c5f-4e48-abfe-0ce66c0726ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T05:10:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB4073:EE_
x-ms-office365-filtering-correlation-id: f41c0431-f265-4dcb-98d0-08dc0b524399
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NG8iX5YxH6xTdN+OAvSg1ruR2/+zl8KX7/E08UB1EuhIf8PK1NyMKEnSEZkgiNWSOOydKTDf/wRYhlfxByv3Y70aN1hynFTwV/+8DRUcjRZTahIrY3SST43G0DBPOJTHWKvJbEacSbB4ByvBj9qiPNXSrst4DTosUjitOYDnVmrCr1G9PEahbGNs7a2VHU4EDzvdrmvxNYNVEMwFuZujQuq9G14YAaBj+VQMdZKmyuRR1RiyXyBwHMz3kcTy3l0SudreSRsQhphVAkcgkwtU4z9FnA2Xzi8V+F+59QASlsgab4Ij9KWMsjLtH8Dt8mvZjMadVqK4t3meAW6ZyKKirNq45nfNTTMi4gS+II/9l7TszVxVn+4QqfDariyebOz8mH4WPF2zyNIKFmuEn0Pu0nLg0qX8p7GYx+C+DUf+fch+1Vo5+tBL21BUsdQVO2Rk/SHHF03HPHJU3knWYwfBDSb7E7Uegt1xQW7Td89UUR67C7+W7tWdBMeDFSpVTPZka6GX/zTuGb2ODVbqC0oKXuYq6z/Rk/4EnTPXx1+JCVqGzLoO9PfMDkj8/SrdeNLeNT/tP76cm47rHaAFsfNSdEuFow5/zdzWoHvZ98kR13gco8XrSf4xBqOxybHBOk5yAtSsEe677RZRkRsflHmslg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(83380400001)(7696005)(6506007)(53546011)(9686003)(76116006)(5660300002)(4326008)(52536014)(41300700001)(478600001)(2906002)(122000001)(316002)(54906003)(66946007)(8676002)(8936002)(6636002)(64756008)(66446008)(66476007)(66556008)(110136005)(86362001)(33656002)(38100700002)(71200400001)(38070700009)(921011)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SWI87pmJKAfAhzCClhzElrZMl98zL/uaJ7oqsPHPmMIRO7yoFqFYeA43rKJc?=
 =?us-ascii?Q?7ebaduAPlkAR34Ex7fpMNJ7DUaumiMaF1PF4gWWmp+zQUBWvSEqs0yb8o5TF?=
 =?us-ascii?Q?nQuDOtbMbs+xCR/kp/IJnoLZxjwwjMDCcbcbugqevP6KXKlMvMRTswaerjgc?=
 =?us-ascii?Q?kwEdpyuNmd/R39pfWTfQ1+FJEAjukO34nQEnD+tAqdHxwKVvtG4SVVB8QQVx?=
 =?us-ascii?Q?G3iVFcDVzPABUCoy/JipuOVZQjRrqWTsAx9hgJTyrdViGWIGpUCi4hkE4aH3?=
 =?us-ascii?Q?FkaGc9V/MONSxJeMXwEbMk4eUYeCIqMfpq1/oeUernVliwOO+u2yeoKKjJ63?=
 =?us-ascii?Q?sdo5NT6rqLrAemp0Md+OV7Y5UNO4z41wvCnqwY6lkg9E/txM7NqWRb3N67GK?=
 =?us-ascii?Q?l9QBRx7UA9Pvq3prL7fAn6TWZ9sm7e9kcXNeNPHZppz2suseRanqZCoQIRP9?=
 =?us-ascii?Q?2wgc2G6lu+/+Xws5GsNgBwxZ3+EblsgIVtcghKrREa7Xh5Cl+JvHLuxGdBb9?=
 =?us-ascii?Q?xLq/UmRW8ILwDgbaXE64ygaQKUTEmBDh5zJg9QgXCLQeSt60aC47uNZBag96?=
 =?us-ascii?Q?EG6Y7ONw1VVNU9kITkbKzk87Hny6hWw1+3a573tFoi8Z44rCeBw4Qi1LxUDr?=
 =?us-ascii?Q?SQWlYqkc+Hgn3LP+HNjCOG7COXhvWbjYJumSytJ5Y/prlSnU2HLSkh6hyY2v?=
 =?us-ascii?Q?UuPoySCzXOLFnATq3ZMvZiriFdOYPxlk/jItqCDjPt+SVmWLcfvrGSVSI4uQ?=
 =?us-ascii?Q?hd2w3d6ARuDY36+UGmIFm7ga5a+aQrFrWRA951hHQQ6v33ZU/2+Z/AquifCR?=
 =?us-ascii?Q?uxHwBBsZbmRZuq3HEahvh7Sz5uHYFmtGpcmJEcEE3sViKwD+eqCYkW/rpnLx?=
 =?us-ascii?Q?832VJU2L3KyLxLMvLvzg3xy4mpwPPaAoNH9HgMMQD+9S29zUm/xjI6I9zzTu?=
 =?us-ascii?Q?zBuIRVxbRZaaK25YkE1j/uAMyNLnGBKtXp9cOG4Ss/Vfkw0NwK1K4Rpf7PL0?=
 =?us-ascii?Q?vMX3eWMoKeRUX9xQeIhw4hFmIDzEwKdKqOozCRgrswcy2QZWmfpa2RrLsCje?=
 =?us-ascii?Q?h45JJV1TtmiPmXjjByPlEZ3B6gCZuFI7JTlvflER7tR7GhmmsyRv83ukjLkL?=
 =?us-ascii?Q?gTZBWZ7F3UsR59/wI84iy/9Zo3Kd/p7RHMkFVYqU3BWHl5lzJoz9leDYeS6T?=
 =?us-ascii?Q?+YM2LRDd/K1IoZIOD+zVnfXyymH+7CZ0J8mQk2kvdFdViki/S+z0/YCf1cpf?=
 =?us-ascii?Q?MKpnCjZxQXf1hdJi/Ckb7YiOmYCwtnm5BZKYHO38Pgre6rdjfHB14Dd5WvUS?=
 =?us-ascii?Q?CDeh/2S3zuwqgKgmTxVXCBi+x4nNXkI4Df8b5y88ONZi+LTHqe04wioMH1zR?=
 =?us-ascii?Q?4uy4mZF+zs82WQ2NKZJBertxqvaol0gRhDEF9JEek2S2z875LeMxKre8z6F6?=
 =?us-ascii?Q?Gz8bHeC3n7/Z5HJfN9OOrdb0r5qwRSl1/mtN9dn3dbJdw5DxqBAAkTh/GmCi?=
 =?us-ascii?Q?WSJYELmecqBPQ0XDTyP4WK4k6D+0DYxDTqPomN5hwzMgmGiMuh9fOAG91JBv?=
 =?us-ascii?Q?4MuuhDfkFzLmFTsGUAQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41c0431-f265-4dcb-98d0-08dc0b524399
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:18:32.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipyOSq1ZxwturM/d8otXmaR026FyuQvA848UskUc4tuXXO4QZVbD1Y2tuhHnfw8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Tuesday, January 2, 2024 11:45 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; C=
hai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp

Instead of traditional atomfirmware interfaces for RAS capability, host dri=
ver can query ras capability from psp starting from psp v13_0_6.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++  drivers/gpu/dr=
m/amd/amdgpu/amdgpu_psp.h |  2 ++  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  =
| 26 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94b536e3cada..8a3847d3041f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2125,6 +2125,19 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_dev=
ice *adev)
        return ret;
 }

+bool amdgpu_psp_get_ras_capability(struct psp_context *psp) {
+       bool ret;
+
+       if (psp->funcs &&
+           psp->funcs->get_ras_capability) {
+               ret =3D psp->funcs->get_ras_capability(psp);
+               return ret;
[kevin]:
This variable 'ret' seems to have no other purpose, can we remove it and re=
turn directly ?

Best Regards,
Kevin
+       } else {
+               return false;
+       }
+}
+
 static int psp_hw_start(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 09d1f8f72a9c..652b0a01854a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,7 @@ struct psp_funcs {
        int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_ad=
dr);
        int (*vbflash_stat)(struct psp_context *psp);
        int (*fatal_error_recovery_quirk)(struct psp_context *psp);
+       bool (*get_ras_capability)(struct psp_context *psp);
 };

 struct ta_funcs {
@@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp, int =
mode);  int is_psp_fw_valid(struct psp_bin_desc bin);

 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
+bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 676bec2cc157..722b6066ce07 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -27,6 +27,7 @@
 #include "amdgpu_ucode.h"
 #include "soc15_common.h"
 #include "psp_v13_0.h"
+#include "amdgpu_ras.h"

 #include "mp/mp_13_0_2_offset.h"
 #include "mp/mp_13_0_2_sh_mask.h"
@@ -770,6 +771,30 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct=
 psp_context *psp)
        return 0;
 }

+static bool psp_v13_0_get_ras_capability(struct psp_context *psp) {
+       struct amdgpu_device *adev =3D psp->adev;
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       u32 reg_data;
+
+       /* query ras cap should be done from host side */
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
+       if (!con)
+               return false;
+
+       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
6)) &&
+           (!(adev->flags & AMD_IS_APU))) {
+               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
+               adev->ras_hw_enabled =3D (reg_data & GENMASK_ULL(23, 0));
+               con->poison_supported =3D ((reg_data & GENMASK_ULL(24, 24))=
 >> 24) ? true : false;
+               return true;
+       } else {
+               return false;
+       }
+}
+
 static const struct psp_funcs psp_v13_0_funcs =3D {
        .init_microcode =3D psp_v13_0_init_microcode,
        .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_state=
,
@@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
        .update_spirom =3D psp_v13_0_update_spirom,
        .vbflash_stat =3D psp_v13_0_vbflash_status,
        .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
+       .get_ras_capability =3D psp_v13_0_get_ras_capability,
 };

 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
--
2.17.1

