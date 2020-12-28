Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7198FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 08:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2338F207B6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 08:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2338F207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E1D89A34;
	Mon, 28 Dec 2020 08:04:24 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760078.outbound.protection.outlook.com [40.107.76.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC3189A08
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 08:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxSOLxf05/qT/6ony5o7GGmsJgVjFduA7lbDFPMfS8q86FMJgo+BdkQYvoOQiVJIzOn2HpTNFm3pnQggBMIZ1nSInNs83rIQd+18VdYOKno4NfAmGE1RbH57ZYaU/aS8CdmjYVfhh8fzwT7uUuekL+CDkBNLlPR2u7N65FDK0fQThIYg5fCMVjP6pU+rSvPpLcfr7T4WIBRXRMyTI/eAawmE0o44RVwzZ4lHJLBjC4jG1rO1o5HjyxCmmcGJw3+JhmFP+t9T7iQ7aeeBSm9GpRP+8Jh9fu2D7TQGJTWqumljSzNyUlagXpDrsrk7QEeGOcYpiqgE2gwOt3sqgnfyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYm6HH3C/yDOTVaV1gtD5XzRC6+zCB2TenYIO135Yl4=;
 b=aoh9e1jtGlFw/KdlOljTdESXJEHrw2xPMOvERzz5v5nbaW+fIN+cJXBAF6CUtDp+ANSGVSETLS0D/zfVwUQi+I/KhJkNuLE0V8emp5dhEpKQt7NI7sifWKsmfG45maulmw8Z5Q0ZrTXloPqIdgHxv7XuR+EWZHmAHDnY3EA0Z/RWi3RnsRSr06y1hfHlgFeH2Gjxz+4ZIVSNws+ic7DUvn5zlWKMjXzrliHU/efYFVeXrTYlCI5v1BElUp7ch8WE4TEzHuryi4tOJNagA+G1sirqv3oBHveH1k+RVDjL3Jsry31L5YFB+Xg3MCQLWOnMUc63agJUN27iyC9Or3eE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYm6HH3C/yDOTVaV1gtD5XzRC6+zCB2TenYIO135Yl4=;
 b=e30s44yx02YGE8xum+20Fd8t5aZ7+ERIi3dHqEA+IiO6DHNAlynA43G5rgLGfd4bFoRz8bI62hxDNjUlScAC6OSVOVueuYw7MNZE2SrfxmkK54XQcMdpjkJBcGxYFbXYQc9PnZ99U7/lgIe9hQDYMXp/Aw6ZbvrcV8n4AbOzx8c=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.28; Mon, 28 Dec 2020 08:04:19 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%9]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 08:04:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: unfiy hdp function into hdp structure
Thread-Topic: [PATCH 2/2] drm/amdgpu: unfiy hdp function into hdp structure
Thread-Index: AQHW3Od/6pHC7dJ96k2V8LaDtZHxoaoMJUbw
Date: Mon, 28 Dec 2020 08:04:19 +0000
Message-ID: <DM6PR12MB40759C17B43E83E69A65D4D6FCD90@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201228070248.2867202-1-likun.gao@amd.com>
 <20201228070248.2867202-2-likun.gao@amd.com>
In-Reply-To: <20201228070248.2867202-2-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-28T08:04:16Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b57ab7b6-e78e-45ba-8b7b-e011fe8aca51;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9ec2976-bc9a-4c85-bd3d-08d8ab072dc6
x-ms-traffictypediagnostic: DM5PR1201MB0027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0027A9BADBD5431D8367BFBDFCD90@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcnFFjS/j3YhCm2vASTrqfABXpozeWdoknZgVyjWgc1ykTCilrQ8+PXtgl5vbhynyQuKxWKR36pSh0JkjlBj5ijdMfbftND1P3E/7yA4N/zjZAf/b2w2qHgyuqwGy7KeBUw/cdhAS0fJqN1/tPjiaDI36udQsaetKEShYwQnDhEYkr39xb9wFl0k/COc5+KJW+1LPbE2uPw8kGSb0hSNhI2UJ3/az3CDYsp1AKiDPbUOoKiwV55h5mJ0wfdJqf9Eu3pc4dCaOThBxj4vvd4jnG0+9x8yNxrz6avHYU2K6ci9OrQNTARqwam1qjbNw+ZwcX0ar7ctlOqCrHECNzn7koC01dXF778A763zzvOxQXzO6OxYG0/3Vd9De1yBAxpJyY2cBrzPSBISPl1pMjvCbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(83380400001)(30864003)(2906002)(186003)(33656002)(8676002)(110136005)(66946007)(7696005)(8936002)(6506007)(76116006)(66446008)(66476007)(55016002)(64756008)(316002)(478600001)(66556008)(53546011)(5660300002)(52536014)(9686003)(26005)(71200400001)(86362001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cXBCvhS1+yoAf7zPgZNiq8yUiiiAZYq4BJ/EE4mXO0SK2zvcYL2Yx905YfRK?=
 =?us-ascii?Q?8d9Hc3XtnUamaBEpE7HU14OYAeTjDL+nTILC5HFMKm3h1bzRTjMho88Ly0sl?=
 =?us-ascii?Q?rZfVX5JJ9Css5upbepSo3CYo8fjr74rd2KAdoYUyNXgasCld3N9hTSQBnURl?=
 =?us-ascii?Q?Nwv1Cv2dpu9o0UfbJEiJBLpwHdDDQDXudWnMMjVrdGFN5c2sUTIHzSOm+nF9?=
 =?us-ascii?Q?j7zRhi6WvHMBQBnqt+2PopASY3NSkfl64wX/mkfhSn3Y53AtSN14F2VUn7tr?=
 =?us-ascii?Q?S9ynRDl+kl2vCf87dA2f6AUH1gUDJOA8ZE86Wc8FbaqEWSU8/FvSrkKw4h0n?=
 =?us-ascii?Q?+uiiMrMYJhkPOzjjvqwwwvN+ISkp20LXuM3sxPYFMWM9WZRavJhHZiFK55f/?=
 =?us-ascii?Q?hM81PkSlfRHbRrvjUzWF51gkYaWSjnF4egoFEqL1qjTHImLfCEIw1fXzxx7a?=
 =?us-ascii?Q?/kqM14oCNkbaQ2eAcfl0hKuOtryQXm+9LJ+Efw8vVsvglWfjR+iZrvB9oLco?=
 =?us-ascii?Q?Dmd6SJic53GNyYQdQWmZ/dAk+UCWH7coX/skM2YweGV0LlzPT76wSDOoNsI9?=
 =?us-ascii?Q?aN9js3cvruLvsaUCpueyAlQ8rxNQo68Fltte9h0Y0G0VN1bJJieeyHzho9Yd?=
 =?us-ascii?Q?6Bh5qi+sf/YdCnDf0sKA8VvZ2mdUl3MQOg3eZNZC873KNTMV6FRsmXFyAHOe?=
 =?us-ascii?Q?ZoEBc/VxtzrjIczsKWZOAalbxsz6qgQF8FdQw+taHM5zD3YadNRapvqTc3Pk?=
 =?us-ascii?Q?IQ+AadJX68FF7c+fkLa110eHM85xVS2wMaThsCV76FFfNMDzHFfsRKXPR6qE?=
 =?us-ascii?Q?Fs5P474/i0ZeXSuNkSMomPOYKZOfIJAlOX0j0dQet0LHseC9Hx/RhZ1vqKw8?=
 =?us-ascii?Q?p8j00PKhcD6bykGK0pZaW15sqY5prC972KIZQpSxn6dXhN97WdafC8nFBeN/?=
 =?us-ascii?Q?r3chUgFIqjd6KMa+21cDLRZ0QLcZLoWyo6ozi1uZi/Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ec2976-bc9a-4c85-bd3d-08d8ab072dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 08:04:19.2691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3/lRUDKQW2Y8iwq3B/Cg1qdZfcr7aJU08LbTdZuGbYt+524m5FwzIeMfWXWzEaRN+AsNUiXtZoybZis8QUEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Can we split this huge change into the following for better code review? You can keep legacy interfaces there until switch to the new callbacks.

1). hdp_v4_0.c/.h
2). hdp_v5_0.c/.h
3). switch to hdp v4_0 callbacks
4). switch to hdp v5_0 callbacks

In addition to that, I didn't see the legacy interface was retired from amdgpu_asic_funcs structure for vg and nv. I might miss the change since it's really huge one.

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, December 28, 2020 15:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: unfiy hdp function into hdp structure

From: Likun Gao <Likun.Gao@amd.com>

Separtate HDP related function into hdp structure.
Remove redundant operation related HDP.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I1549ae2a7860c3b845897e99b3c2351da277bc8c
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  21 +--
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    | 150 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h    |  31 ++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c    | 212 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h    |  31 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c   |  13 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  10 --
 drivers/gpu/drm/amd/amdgpu/nv.c          | 151 +---------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |   1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  71 +-------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |   1 -
 23 files changed, 451 insertions(+), 303 deletions(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c6262689e14e..2b379fd12b44 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v5_0.o hdp_v4_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 92e9d1f1207b..ec91f5e32b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -89,6 +89,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_nbio.h"
+#include "amdgpu_hdp.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_csa.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index e62cc0e1a5ad..4ba0024aedf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -57,7 +57,6 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
 	u32 (*get_rev_id)(struct amdgpu_device *adev);
 	void (*mc_access_enable)(struct amdgpu_device *adev, bool enable);
-	void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	u32 (*get_memsize)(struct amdgpu_device *adev);
 	void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ba1086784525..10aae0abcffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -38,7 +38,6 @@
 #include "smuio/smuio_11_0_0_offset.h"
 #include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
@@ -5691,7 +5690,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0); @@ -5769,7 +5768,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0); @@ -5846,7 +5845,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0); @@ -6215,7 +6214,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5f4805e4d04a..a896e3d0fcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -38,7 +38,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 
 #include "vega10_enum.h"
-#include "hdp/hdp_4_0_offset.h"
 
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5648c48be77f..3b7c6c31fce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -27,8 +27,6 @@
 #include "gmc_v10_0.h"
 #include "umc_v8_7.h"
 
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
@@ -312,7 +310,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	int r;
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead @@ -995,7 +993,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)  {
 	int r;
 	bool value;
-	u32 tmp;
 
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n"); @@ -1014,15 +1011,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
-	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
-	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
+	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e22268f9dba7..7b1f50fa9dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -31,8 +31,6 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_gem.h"
 
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "gc/gc_9_0_sh_mask.h"
 #include "dce/dce_12_0_offset.h"
 #include "dce/dce_12_0_sh_mask.h"
@@ -1571,7 +1569,6 @@ static int gmc_v9_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool value;
 	int r, i;
-	u32 tmp;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
@@ -1590,24 +1587,10 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, true);
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
-
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
new file mode 100644
index 000000000000..58cf0670d8af
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v4_0.h"
+#include "amdgpu_ras.h"
+
+#include "hdp/hdp_4_0_offset.h"
+#include "hdp/hdp_4_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL               0x00f7
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_BASE_IDX      2
+/* for Vega20 register name change */
+#define mmHDP_MEM_POWER_CTRL    0x00d4
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK  0x00000001L
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK    0x00000002L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK   0x00010000L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK             0x00020000L
+#define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
+
+static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	uint32_t reg_addr;
+
+	if (adev->flags & AMD_IS_APU ||
+	    adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS)
+		reg_addr = (adev->rmmio_remap.reg_offset +
+			    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2;
+	else
+		reg_addr = SOC15_REG_OFFSET(NBIO, 0,
+				mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL);
+
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ(reg_addr, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, reg_addr, 0); }
+
+static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	else
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1); }
+
+static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev) 
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+	/*read back hdp ras counter to reset it to 0 */
+	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
+static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
+					 bool enable)
+{
+	uint32_t def, data;
+
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_RENOIR) {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
+		else
+			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
+	} else {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+		else
+			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
+	}
+}
+
+static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_HDP_LS */
+	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+}
+
+static void hdp_v4_0_init_registers(struct amdgpu_device *adev) {
+	switch (adev->asic_type) {
+	case CHIP_ARCTURUS:
+		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start 
+>> 40)); }
+
+const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
+	.flush_hdp = hdp_v4_0_flush_hdp,
+	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
+	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+	.update_clock_gating = hdp_v4_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
+	.init_registers = hdp_v4_0_init_registers, };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
new file mode 100644
index 000000000000..d1e6399e8c46
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HDP_V4_0_H__
+#define __HDP_V4_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
new file mode 100644
index 000000000000..7a15e669b68d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -0,0 +1,212 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v5_0.h"
+
+#include "hdp/hdp_5_0_0_offset.h"
+#include "hdp/hdp_5_0_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + 
+KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0); }
+
+static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	} else {
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	}
+}
+
+static void hdp_v5_0_update_mem_power_gating(struct amdgpu_device *adev,
+					  bool enable)
+{
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* HDP 5.0 doesn't support dynamic power mode switch,
+	 * disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 IPH_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* only one clock gating mode (LS/DS/SD) can be enabled */
+	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_LS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_LS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_DS_EN, enable);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_SD_EN, enable);
+		/* RC should not use shut down mode, fallback to ds */
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+						 HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_DS_EN, enable);
+	}
+
+	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+	 * be set for SRAM LS/DS/SD */
+	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+			      AMD_CG_SUPPORT_HDP_SD)) {
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 IPH_MEM_POWER_CTRL_EN, 1);
+		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+						 RC_MEM_POWER_CTRL_EN, 1);
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* restore IPH & RC clock override after clock/power mode changing */
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1); }
+
+static void hdp_v5_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t hdp_clk_cntl;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+
+	if (enable) {
+		hdp_clk_cntl &=
+			~(uint32_t)
+			(HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
+	} else {
+		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+	}
+
+	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl); }
+
+static void hdp_v5_0_update_clock_gating(struct amdgpu_device *adev,
+					      bool enable)
+{
+	hdp_v5_0_update_mem_power_gating(adev, enable);
+	hdp_v5_0_update_medium_grain_clock_gating(adev, enable); }
+
+static void hdp_v5_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_MGCG */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
+	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+static void hdp_v5_0_init_registers(struct amdgpu_device *adev) {
+	u32 tmp;
+
+	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
+	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
+	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp); }
+
+const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
+	.flush_hdp = hdp_v5_0_flush_hdp,
+	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
+	.update_clock_gating = hdp_v5_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
+	.init_registers = hdp_v5_0_init_registers, };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
new file mode 100644
index 000000000000..2d5ec2b419f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HDP_V5_0_H__
+#define __HDP_V5_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v5_0_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index b5c3db16c2b0..b860f1c7b5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -80,15 +80,6 @@ static void nbio_v2_3_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);  }
 
-static void nbio_v2_3_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v2_3_get_memsize(struct amdgpu_device *adev)  {
 	return RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
@@ -366,7 +357,6 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_pcie_data_offset = nbio_v2_3_get_pcie_data_offset,
 	.get_rev_id = nbio_v2_3_get_rev_id,
 	.mc_access_enable = nbio_v2_3_mc_access_enable,
-	.hdp_flush = nbio_v2_3_hdp_flush,
 	.get_memsize = nbio_v2_3_get_memsize,
 	.sdma_doorbell_range = nbio_v2_3_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v2_3_vcn_doorbell_range, diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index d2f1fe55d388..8427f10712ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -50,18 +50,6 @@ static void nbio_v6_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);  }
 
-static void nbio_v6_1_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(NBIO, 0,
-				    mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL,
-				    0);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			NBIO, 0, mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL), 0);
-}
-
 static u32 nbio_v6_1_get_memsize(struct amdgpu_device *adev)  {
 	return RREG32_SOC15(NBIO, 0, mmRCC_PF_0_0_RCC_CONFIG_MEMSIZE); @@ -266,7 +254,6 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.get_pcie_data_offset = nbio_v6_1_get_pcie_data_offset,
 	.get_rev_id = nbio_v6_1_get_rev_id,
 	.mc_access_enable = nbio_v6_1_mc_access_enable,
-	.hdp_flush = nbio_v6_1_hdp_flush,
 	.get_memsize = nbio_v6_1_get_memsize,
 	.sdma_doorbell_range = nbio_v6_1_sdma_doorbell_range,
 	.enable_doorbell_aperture = nbio_v6_1_enable_doorbell_aperture,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index ae685813c419..3c00666a13e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -60,15 +60,6 @@ static void nbio_v7_0_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);  }
 
-static void nbio_v7_0_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_0_get_memsize(struct amdgpu_device *adev)  {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE); @@ -292,7 +283,6 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
 	.get_pcie_data_offset = nbio_v7_0_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_0_get_rev_id,
 	.mc_access_enable = nbio_v7_0_mc_access_enable,
-	.hdp_flush = nbio_v7_0_hdp_flush,
 	.get_memsize = nbio_v7_0_get_memsize,
 	.sdma_doorbell_range = nbio_v7_0_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_0_vcn_doorbell_range, diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index aa36022670f9..598ce0e93627 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -56,15 +56,6 @@ static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);  }
 
-static void nbio_v7_2_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)  {
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
@@ -325,7 +316,6 @@ const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
 	.get_pcie_port_data_offset = nbio_v7_2_get_pcie_port_data_offset,
 	.get_rev_id = nbio_v7_2_get_rev_id,
 	.mc_access_enable = nbio_v7_2_mc_access_enable,
-	.hdp_flush = nbio_v7_2_hdp_flush,
 	.get_memsize = nbio_v7_2_get_memsize,
 	.sdma_doorbell_range = nbio_v7_2_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_2_vcn_doorbell_range, diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index eadc9526d33f..4bc1d1434065 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -82,15 +82,6 @@ static void nbio_v7_4_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);  }
 
-static void nbio_v7_4_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_4_get_memsize(struct amdgpu_device *adev)  {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE); @@ -541,7 +532,6 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_pcie_data_offset = nbio_v7_4_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_4_get_rev_id,
 	.mc_access_enable = nbio_v7_4_mc_access_enable,
-	.hdp_flush = nbio_v7_4_hdp_flush,
 	.get_memsize = nbio_v7_4_get_memsize,
 	.sdma_doorbell_range = nbio_v7_4_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_4_vcn_doorbell_range, diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 6bee3677394a..a7f7f960af46 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -38,8 +38,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
 #include "mp/mp_11_0_offset.h"
 
@@ -50,6 +48,7 @@
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
 #include "nbio_v7_2.h"
+#include "hdp_v5_0.h"
 #include "nv.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
@@ -514,6 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->gmc.xgmi.supported = true;
@@ -671,18 +671,13 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 
 static void nv_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)  {
-	adev->nbio.funcs->hdp_flush(adev, ring);
+	adev->hdp.funcs->flush_hdp(adev, ring);
 }
 
 static void nv_invalidate_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	} else {
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-	}
+	adev->hdp.funcs->invalidate_hdp(adev, ring);
 }
 
 static bool nv_need_full_reset(struct amdgpu_device *adev) @@ -1080,120 +1075,6 @@ static int nv_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void nv_update_hdp_mem_power_gating(struct amdgpu_device *adev,
-					   bool enable)
-{
-	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
-	uint32_t hdp_mem_pwr_cntl;
-
-	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_HDP_DS |
-				AMD_CG_SUPPORT_HDP_SD)))
-		return;
-
-	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-
-	/* Before doing clock/power mode switch,
-	 * forced on IPH & RC clock */
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-
-	/* HDP 5.0 doesn't support dynamic power mode switch,
-	 * disable clock and power gating before any changing */
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_SD_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_SD_EN, 0);
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* only one clock gating mode (LS/DS/SD) can be enabled */
-	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_LS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_LS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_DS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_SD_EN, enable);
-		/* RC should not use shut down mode, fallback to ds */
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	}
-
-	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
-	 * be set for SRAM LS/DS/SD */
-	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
-							AMD_CG_SUPPORT_HDP_SD)) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						IPH_MEM_POWER_CTRL_EN, 1);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						RC_MEM_POWER_CTRL_EN, 1);
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* restore IPH & RC clock override after clock/power mode changing */
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
-}
-
-static void nv_update_hdp_clock_gating(struct amdgpu_device *adev,
-				       bool enable)
-{
-	uint32_t hdp_clk_cntl;
-
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
-		return;
-
-	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-
-	if (enable) {
-		hdp_clk_cntl &=
-			~(uint32_t)
-			  (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
-	} else {
-		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-}
-
 static int nv_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)  { @@ -1213,9 +1094,7 @@ static int nv_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		nv_update_hdp_mem_power_gating(adev,
-				   state == AMD_CG_STATE_GATE);
-		nv_update_hdp_clock_gating(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1234,31 +1113,13 @@ static int nv_common_set_powergating_state(void *handle,  static void nv_common_get_clockgating_state(void *handle, u32 *flags)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_MGCG */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
-		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
-
-	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_DS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_SD;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	return;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a738a7d7e383..c325d6f53a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -690,7 +690,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 		vfree(buf);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ce56e93c6886..c8c22c1d1e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -46,7 +46,6 @@
 #include "sdma6/sdma6_4_2_2_sh_mask.h"
 #include "sdma7/sdma7_4_2_2_offset.h"
 #include "sdma7/sdma7_4_2_2_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "sdma0/sdma0_4_1_default.h"
 
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b208b81005bb..d345e324837d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -32,7 +32,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/sdma0/irqsrcs_sdma0_5_0.h"
 #include "ivsrcid/sdma1/irqsrcs_sdma1_5_0.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0d3def7269bb..24480896547d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -40,8 +40,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 #include "sdma0/sdma0_4_0_offset.h"
 #include "sdma1/sdma1_4_0_offset.h"
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "nbio/nbio_7_0_default.h"
 #include "nbio/nbio_7_0_offset.h"
 #include "nbio/nbio_7_0_sh_mask.h"
@@ -59,6 +57,7 @@
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
+#include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
 #include "navi10_ih.h"
@@ -84,14 +83,6 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
-/* for Vega20 register name change */
-#define mmHDP_MEM_POWER_CTRL	0x00d4
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK	0x00000001L
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK	0x00000002L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK	0x00010000L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
-#define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
-
 /*
  * Indirect registers accessor
  */
@@ -700,6 +691,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v6_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v4_0_funcs;
 
 	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
 		adev->df.funcs = &df_v3_6_funcs;
@@ -837,17 +829,13 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 
 static void soc15_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)  {
-	adev->nbio.funcs->hdp_flush(adev, ring);
+	adev->hdp.funcs->flush_hdp(adev, ring);
 }
 
 static void soc15_invalidate_hdp(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring)
 {
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+	adev->hdp.funcs->invalidate_hdp(adev, ring);
 }
 
 static bool soc15_need_full_reset(struct amdgpu_device *adev) @@ -858,10 +846,7 @@ static bool soc15_need_full_reset(struct amdgpu_device *adev)
 
 static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)  {
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
-		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+	adev->hdp.funcs->reset_ras_error_count(adev);
 }
 
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0, @@ -1422,41 +1407,6 @@ static int soc15_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev, bool enable) -{
-	uint32_t def, data;
-
-	if (adev->asic_type == CHIP_VEGA20 ||
-		adev->asic_type == CHIP_ARCTURUS ||
-		adev->asic_type == CHIP_RENOIR) {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
-		else
-			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
-	} else {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-		else
-			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
-	}
-}
-
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)  {
 	uint32_t def, data;
@@ -1517,7 +1467,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1534,7 +1484,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1542,7 +1492,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1561,10 +1511,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_LS */
-	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	/* AMD_CG_SUPPORT_DRM_MGCG */
 	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0)); diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 312ecf6d24a0..7cd67cb2ac5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -36,7 +36,6 @@
 #include "vce/vce_4_0_default.h"
 #include "vce/vce_4_0_sh_mask.h"
 #include "nbif/nbif_6_1_offset.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_1_0_offset.h"
 #include "mmhub/mmhub_1_0_sh_mask.h"
 #include "ivsrcid/uvd/irqsrcs_uvd_7_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c734e31a9e65..6117931fa8d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -32,7 +32,6 @@
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_9_1_offset.h"
 #include "mmhub/mmhub_9_1_sh_mask.h"
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
