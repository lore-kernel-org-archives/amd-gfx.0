Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFB2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9702242A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9702242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BF78970E;
	Mon, 28 Dec 2020 10:09:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46328970E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 10:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN5X9bOyCaKoO8YKK3Xmcyfcv9aDB6GHuPiZCFb5m2A57LKecHoSQGIAh56d+rfgE5SCeGsB1xnUaMNJt6l4IBT+t/qzz1prpbIoa0U0WkZQZAHxoEtpAE2wozQYJAFgL17MSTmwlnvBtmdnMx+LxrVvZrSMXoGA4IByzIz0yCvc4q6x+FM3Oy8Q2EODRzWw5/6nQR3b/GLl86SISZond6S6c7KKjZiajimigLottiu2HwlPt/FhCpBvnZVBdpk+8zF/GB4DeU6nfdnJdZmP3O/JbfKVVg6Bbh5w/zC+tlaP9TMAw9Tbms2uuie4Jjgw2CLSshJQy4QEk+QicG31sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDj2ZgxelOnaDn5mGpE3liZb2yfdFlCJraFIVgQFERs=;
 b=YHLT4S5DiWWf5y+i068j6l3eshjljq1XH/XOMoVb8zJ2FZkInw8Y8ItzWdYQXipJpBRrRWHQgZJJlvHtQ9zz6eu3QG7jSmOmhGp8LbFMOxmMVq73ODCDoOUqaFx/7XRcIbpsaRfI9HHTt7+eiBbsE6SFGwYP1v1/Sc415+LZivxgQYn1dKZvI/4d+Z17RU2glZnhY9rI2EHdJVpwqWePGjNGRUZjv43YOYjRc+bHC5jv5FnL1KmX6PAtSkWhJrmgXOXIhNulhukxbs56o7k/4r+XdvKBDQOMVsr8MkVLZw6hiGccGIaPEPL3Y6KUV9MRrrL6YRQgePCgFj0AACbJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDj2ZgxelOnaDn5mGpE3liZb2yfdFlCJraFIVgQFERs=;
 b=tkCodOPrlFIKlsdW7MJ6/lCJIv16me2ybiGZUf8E6rjR9ARm1lLjAm09WTR+q0swJ6TbHavhT95oRL93XpZuCWZDVCTxbJs8L8+6JEFpHha1eVy2Kz1wUxDh5y4NykjlgyoHU1rdB/NIrK/WdB3Tgb0N4v4/FdCabCxmenuLx2Y=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 10:09:39 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 10:09:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5
Thread-Topic: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5
Thread-Index: AQHW3Pp8ZYwAYIu9u0GS9TC659KVP6oMSE7Q
Date: Mon, 28 Dec 2020 10:09:39 +0000
Message-ID: <CY4PR12MB1287B5EC514961FEA9A90733F1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <20201228091834.3240927-4-likun.gao@amd.com>
In-Reply-To: <20201228091834.3240927-4-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-28T10:07:46Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1ba84e10-3018-4f97-848b-0000e7c0d240;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-28T10:09:37Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 553e9645-af99-4e6f-ac87-0000000de5f9
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8984089-98f0-4fc2-598d-08d8ab18b050
x-ms-traffictypediagnostic: CY4PR1201MB0118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01187B37DB97531FBD193765F1D90@CY4PR1201MB0118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUaIcf4VVcqqPLOrdAQf/GZV4U2CQQjx7wRxPLKr8qs3u6TjbP9QgCXV8QJVSK+dUldBPY0crPZz0e7CoY5DEzCw5yeWf3J/KdmLij18PRdlISR6ToR3bJWiPFSQER8PU/gxTKAe+Y0lAlgiBTcUYOpyboeCo8JbUkg27J/BdpbAm03HZ5g/LwRxAj91asB4pohzkMaM97EdKvNJPP8/06aBF7eL/sdGrgE0GXDgH3O9N3zMvq759uCq9L4KrkNVdyjG85bTALW6QMgwkShfmicBwtcHGr2mx0x2chX6LA3uxPM/2MYX34I7sQpq76IXM0YmRzjy1/ncX2WwnSE14j44yLahad0/0qSInWy4Z2e7HB1V7IUDHnDGAEKUIa3O6nYqSaw+tc4W00lQsd+o0cBO/UfLHWah/12lso28oJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(8676002)(71200400001)(7696005)(9686003)(55016002)(52536014)(478600001)(33656002)(45080400002)(8936002)(83380400001)(5660300002)(316002)(54906003)(110136005)(966005)(186003)(26005)(4326008)(53546011)(6506007)(86362001)(2906002)(76116006)(66556008)(30864003)(64756008)(66476007)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5uNNnrnueCg88w1whutPs95nIwl18BJjIUrn9n/XjFbozPVNrpxe6VzAkbq9?=
 =?us-ascii?Q?Jt+fs0uw2iJGbU7EgusjZa7sAZdBxxIQAREoWCy1sHzWUrv6un1uvFm1WvdY?=
 =?us-ascii?Q?Tjibb5CaoiA5rAqfE156fKhtq4BwMImQdCM7lFDde9LUQCEzk/g6x+EgF3cA?=
 =?us-ascii?Q?WpHoJ3ffTpB3OFErOMGnx9DfabKQ6Rm74W8h66IEv5/sz2PcZwhiEq+Ew5Lu?=
 =?us-ascii?Q?r6A4dk7q6Yo/uvMmJb03O+T8PRP2yN1LBRqtwtrIFXJb/pieGVb74VKvLpqS?=
 =?us-ascii?Q?XXyultHIo3t0/IFSCCT/Daj0fyymVmty09iXyZPotk+vxdk3kH8+IxdYsdms?=
 =?us-ascii?Q?w5WTm6WfXIB/qc3AyX80SlrApd4/KaiYlLBRJFDPdHymDAWkq7cSbVWIEKDh?=
 =?us-ascii?Q?00gdzw5bryniNfDnDpc+U2K6rttRvegQ2ux2FLZyuBSOObLRaTeMiOubi+Iq?=
 =?us-ascii?Q?6AdY0DOJrNctyw6i/O32/qK7fTPeBDWC4GfhCg8JvmN2gVqw6bm8yv3RWAHf?=
 =?us-ascii?Q?m/D+C+WTlKj2+ObNlo+V+yBTqdky8x0ASuVHo2S/7lioapLNGP3oCahUX/nd?=
 =?us-ascii?Q?ZW/XyUTO19hl534ZPLC7/pycVuAc+5HCiKCIZxow/GJS4vsXipOCzSk0ESvM?=
 =?us-ascii?Q?NtJJQ1UUf9IGAOzs5Z5lsAMteqva8TfONwDFm77HCQEaTj4oiNCHce7olqzO?=
 =?us-ascii?Q?kooXykb83YQ+8iUjA1xwQPZS5iHOhIGgQb/cPLFM77Ck7uUCmPMgDGaDg4Lt?=
 =?us-ascii?Q?jgMuvJ/kqIiKy4vhDxKMFu8Qe9J8RFP2h4OxVY9q76cFUrV/OImK3RnEPsHd?=
 =?us-ascii?Q?KitKMssA2svl1fG+M9mOIaYU2FPtDShxSVbceYpsOKGTeGQjE6OMxgSY0aRW?=
 =?us-ascii?Q?eEsLizqfk5v0Qmmrb1HnOTwfEdPVztYthJjEyQjYm2LRLkEgAMXUOpS4Ih68?=
 =?us-ascii?Q?S2c1qMspraRWE/YyoGyCra2fxTJBfNCHRJl/Os+IkaA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8984089-98f0-4fc2-598d-08d8ab18b050
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 10:09:39.7336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kz4eA6mKRtKwN3GQmvxPsn6yhhZtDnaw/uYpQSEUYcMZwzcMdkokm/YPjiBxY6vq86gqenOO7GcenDT8Zg1M5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One question for this patch:

+		adev->hdp.funcs->flush_hdp(adev, NULL);

Shall we add one NULL pointer guard of hdp.funcs->flush_hdp before using it? Or it's not needed at all as hdp.funcs will be initialized for all related ASIC series.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Monday, December 28, 2020 5:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5

From: Likun Gao <Likun.Gao@amd.com>

Switch to use the HDP functions which unfied on hdp structure instead of the scattered hdp callback functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If70683c8cb697a9e7a1ea5a21aa2ed84567e6919
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  14 +--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 160 +------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c |   2 +-
 5 files changed, 13 insertions(+), 174 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d741fee91a37..e74cd443063a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
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
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0); diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
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
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 6bee3677394a..1d785f06c79d 100644
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
@@ -669,22 +669,6 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-static void nv_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring) -{
-	adev->nbio.funcs->hdp_flush(adev, ring);
-}
-
-static void nv_invalidate_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	} else {
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-	}
-}
-
 static bool nv_need_full_reset(struct amdgpu_device *adev)  {
 	return true;
@@ -788,8 +772,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.set_uvd_clocks = &nv_set_uvd_clocks,
 	.set_vce_clocks = &nv_set_vce_clocks,
 	.get_config_memsize = &nv_get_config_memsize,
-	.flush_hdp = &nv_flush_hdp,
-	.invalidate_hdp = &nv_invalidate_hdp,
 	.init_doorbell_index = &nv_init_doorbell_index,
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init, @@ -1080,120 +1062,6 @@ static int nv_common_soft_reset(void *handle)
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
 					   enum amd_clockgating_state state)  { @@ -1213,9 +1081,7 @@ static int nv_common_set_clockgating_state(void *handle,
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
@@ -1234,31 +1100,13 @@ static int nv_common_set_powergating_state(void *handle,  static void nv_common_get_clockgating_state(void *handle, u32 *flags)  {
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
 
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C95696db274534d8bf55108d8ab119da0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637447439447119281%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=se654MRT%2FieoLR9wKve2VuBLWM8u4Yc7PMh%2BoE1a8kQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
