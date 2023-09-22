Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B299E6FE41
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 14:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECED10E68D;
	Fri, 22 Sep 2023 14:52:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBE489DFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 14:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nD1/WpPjS1QUdP2JEGW3z/mJeGY43112v6H13CnGQDCv/SyPtGOYcjwh9zZUsc7Pp+l0nLBSZ+R8ub/lcXCO0SIAmo19Ex7vOHGk6s4JqZQQy63gp14txnuHVJI4NLDTXZVvHC0eNIVKJB2vZMiQ0K9oJ8NagkItl0E7CgS63a1ZYT2cZjpApf29Es5O1X+ZXNIGVYezLJH/Nf3za0M9RUC/DJnkjzr171IXEumIR2/cCkCMW4TYuuma6nhC/QApkgiNj908K6oei7qa6Xf5Y/RsLEvmLIjgQwG4fhuRdQLJh9RRHNVge1Fpv3jkQZvhydn1bfjvbVbtz01sxlYkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoKVl7rkwXlnpYHS+cA/bJ/Uilm8Tg53LJOIMDwpmhA=;
 b=Nuz6gp4vGVpN4gpSRX4C/RmOXksD7660wjD60I+p9C900M8fbqNAxgsrQlmYIZuMbKQ9dL8OJUepQwHO6McNMXCzvF2FkICrtRZ0Dl0VVHpH/maRqGJmpiZa/LDeMGK0Aj3/lv/Rilj6yWek4gMcdiL9TNbXuALiIxoT3ZKpgcxOKa0MMBpCVgnpyCO8dof9MYdTlenNr9lvK+zBy8XGinwKDeZA6WNzpc6MTOklX5AWenTNR/3j7ZLhgvUjqmRMr3eEtq4Yc9cix61M+O/q5j+BQHurGY8sb2/9LCEG8bYdK/4qrEapso9fRq11Bn8NloWtjhBvnDsre3ovTpNdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoKVl7rkwXlnpYHS+cA/bJ/Uilm8Tg53LJOIMDwpmhA=;
 b=wEVSNSDtYBoyggAxOkYliOaACosLi8pca4+Q5iQGZ0Z/6yZMqaJDPPa9XXHdcA0KmH4hgH9eR6YeNTWcNWKIrhcOUcSOoXYyE0BbFhjC4T8vcL3oV4MZaHsCkWli2pMzEOzbYoH6Y2xVdiqfCq/kKfpDEwpYMZVJ/P4Ui7KPH4A=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:52:02 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::901b:d130:b9df:f9cd%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:52:02 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vpe: fix truncation warnings
Thread-Topic: [PATCH] drm/amdgpu/vpe: fix truncation warnings
Thread-Index: AQHZ7S0ZCuPNOof4ikauR+s+/5fAybAm7hnw
Date: Fri, 22 Sep 2023 14:52:02 +0000
Message-ID: <CY5PR12MB6369E13A998BFACC7EA5C9FDC1FFA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230922081536.3998673-1-Lang.Yu@amd.com>
In-Reply-To: <20230922081536.3998673-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5951ec41-19d2-42be-8e13-0b23ea39e73c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-22T14:51:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CH3PR12MB8306:EE_
x-ms-office365-filtering-correlation-id: e7e2893d-190a-402d-7ef8-08dbbb7b7b47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CmoMWuhJIrQdupT+66PQLXijr8r/opP0oyKk1sqhd4djiD/5YG2LFHTgOtgYJEv9SoLAkMEfJxfv5PgbGX1T59bIrVS1la/52mrHE8rHVmpu3rjKmvi8WfAgQYmZ+pVYjYk2MyFtKiFeu6ub5/B4xB/fYb5FSPuvoPBXK67NMncBmrATPpfPU1y3fO1vkpegu26B7uK5s/DxRbTeDt6cSOecRKpGZuQoN91VRTyz5a/5A4KKSR7qchGXL7G/4WQPM+qWhxQ+6MBdo1MnXOKjCAUL/fmSmnbNPuyq6K+D9mllVU5979cs9eaQ0TRgonr9FM1FhP8xe+FFIAlZCdxc/8DJPij0kOfUOZbuQZDXMU6KAiSP1D9gDbXckYaP72tYd5x5jgRPCD+iEmdPAiTCHsqLEahPasxHn4CrP09mtodt+exKm6/ojzx2YlxCS1pFa3wPqjfpPoyxu81ZsCXz9vFt9BebLVo0gNPy2ZvMtaAjHDRYoCfXaoFfjiYKVufYO0qRqQXqNF2sRgqOMDRFbDaQd5yw2XMCAcjJclhZE5tQsrSXyPbIj8pluYDVsuGPW3XqnzyU/MGDN5ifUE1v0Njp1YOwDZ+R9yN488zuku0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(6506007)(7696005)(4326008)(53546011)(8676002)(8936002)(316002)(5660300002)(52536014)(71200400001)(54906003)(64756008)(66946007)(2906002)(966005)(66446008)(478600001)(66476007)(66556008)(76116006)(110136005)(9686003)(26005)(41300700001)(83380400001)(122000001)(38100700002)(38070700005)(86362001)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZR+DeOmS5JLLMEXe9HYDOPbv3khkNjcIdGLZ/hlmGe5pHMu+yfIlO1PEPemX?=
 =?us-ascii?Q?qo6NznTiLaeeDKJC2HbUrLaE1lKXiTiDtp/wAXMqSoBcf7o9H94MMI3XfSM1?=
 =?us-ascii?Q?f5k6vg1DrvNQRe/1boB+MEud+Pa+3zt8R9du1dYHRnkIwPZNxApavmtHmSTK?=
 =?us-ascii?Q?gKgIVc+z70qxVFSKkcmB7yCB7Bdonl7hhzV367Ig85keRTqTyv7EkmhwHCS/?=
 =?us-ascii?Q?dumrZlckxH2qS9x5Xxefc2NnNkAYZtSc+uZIMmFY3GUn4JEo1RfMEp4byCwf?=
 =?us-ascii?Q?XVJ7JfazOa+TJW82OxGTLRTBUFB+VkB0JCfswY5dC257fdlYYYLiI3XmoyPA?=
 =?us-ascii?Q?uWpstzP7S52Gcwk6hxuwoyW0w56mKHIeQwpGDiUYo8qTOxQai8sD3BnfrLj0?=
 =?us-ascii?Q?Uy56prfyl+erRbM7bTQOtCxu0yYUeik/BeJYA3PH4uzoveVwKzqFlmejoFj+?=
 =?us-ascii?Q?INV+V32FJ3jniH0DxMZpLfkHr8YztAVndUMNSAEXtAtzPrH8qLiwVrkKwP5V?=
 =?us-ascii?Q?mhmmVtbvKOhIZJw3Kzprx36cmgXIdm6Eai2oOH5dnxGe2kPtvJt6qp9gPb07?=
 =?us-ascii?Q?ih2+EQQmGMO3L1NMUhKeapOxe5MxT7MAwQWdL63n8H87T4w8KDjMH/pVVlqW?=
 =?us-ascii?Q?awKjxPReABE+wbLNbtFclCpHClUld8w4ue7FplmH31tLf4hQrZF43nRkErXq?=
 =?us-ascii?Q?aWT0a2oYF0OWnKEJTSxlIbF7490+Fm80ZF8tUs1vOmIbsY1iyvjX2fw6q9G1?=
 =?us-ascii?Q?4YQpQHGPctseFotM+Akpvj/6aYgQoVBniy1jC9o6EIMi6Rq0GQffDIgSYhFh?=
 =?us-ascii?Q?LI4pRH/pXEnKcEXbmgKkaz3QnfxkPnymb41kfffnI9X3O48QWTA7ewlGi3GM?=
 =?us-ascii?Q?tT7JIPnhslLrxFztwbnOozkm8KWBJUTv5yhi45KdmCC3AUpUCd1SfgZn1YcA?=
 =?us-ascii?Q?Afq/AsmY720KfKdK6fAVLkqwWfvy8TqjQ9kIY26sLmcGTS2x43qzbK7Tr1WD?=
 =?us-ascii?Q?n1wwCb3UqPsrAan2FfYBw35ZOAiDh68ZmagB8Fu2a8aCR1tqbHB8ZDAR/gcL?=
 =?us-ascii?Q?MmIPpKqCJXBE99BFpmQKMONYmeafpBQKyqjcKwxSb9qZXQVErFR7keZmpYXD?=
 =?us-ascii?Q?1of2Kp80XYb54mArxhWt1y4KEcWHAjwOPpJIvj6Vq4fY/7Hryw4kK1lZcChr?=
 =?us-ascii?Q?4LzX/LZxvzZ1Bat1sjJ+loY2bdfhfo7HPmfAFQR0j+8WRmNV9u04L0XN4iIS?=
 =?us-ascii?Q?kaplIm2swyVmc6urj9vxzGTMGGgeGrWLV/vyga/wrULMKAlL8pntlqS/GC9q?=
 =?us-ascii?Q?H9Kmkpkeu64/gdw4CnbPoGa/d13i05Azdrrj3d/90ze7d2Oh5I0wWpzYCd3i?=
 =?us-ascii?Q?97/ZnygpaHt5Mxcj6qrX8ymfO5RYFD3/D6gJ0C/7gDCZgbrYqpcpccyqdiCB?=
 =?us-ascii?Q?81/4wi7GpO/vwjY4TZ/uRlE48Wg2FyG6kXgjU8aeHhcEg4yueP/pwylfaL3C?=
 =?us-ascii?Q?8qFVRm0MalvdlqWxeETgx2iH02OFspmR0ftwjaN27YQ+BOnwyfcXONHzfQ/p?=
 =?us-ascii?Q?JNIgflcx4H74jgPOOps=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e2893d-190a-402d-7ef8-08dbbb7b7b47
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:52:02.6651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GFj1coJSL2WqW3BiSfGvyu3/Hlf7ekR+jJKfgA/Uu2N0rl10hARPIhqlhonFWQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Friday, September 22, 2023 4:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chiu, Solomon <Solomon.=
Chiu@amd.com>; Yu, Lang <Lang.Yu@amd.com>; kernel test robot <lkp@intel.com=
>
Subject: [PATCH] drm/amdgpu/vpe: fix truncation warnings

Fixes: ab041551f4a7 ("drm/amdgpu: add VPE 6.1.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202309200028.aUVuM8os-lkp@intel=
.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vpe.c
index a68354d03a49..81e5600bd545 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -29,8 +29,6 @@
 #include "soc15_common.h"
 #include "vpe_v6_1.h"

-#define VPE_FW_NAME_LEN                64
-
 #define AMDGPU_CSA_VPE_SIZE    64
 /* VPE CSA resides in the 4th page of CSA */
 #define AMDGPU_CSA_VPE_OFFSET  (4096 * 3)
@@ -52,8 +50,7 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)  {
        struct amdgpu_device *adev =3D vpe->ring.adev;
        const struct vpe_firmware_header_v1_0 *vpe_hdr;
-       char fw_name[VPE_FW_NAME_LEN];
-       char fw_prefix[VPE_FW_NAME_LEN];
+       char fw_prefix[32], fw_name[64];
        int ret;

        amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw=
_prefix));
--
2.25.1

