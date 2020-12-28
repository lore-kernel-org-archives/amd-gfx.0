Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EEC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D44E208BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D44E208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F3A897E9;
	Mon, 28 Dec 2020 10:01:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F21A897E9
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 10:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQepLS2W/bZcVqwxe5n1bwLPc+aLB2iepkr+COqAUwWilVfxWi5PmQW7C3ACxshaXM7v7bzadVSx+4yq5ZJ6CrTEexVHtwSbnN7uViO/tX8Xvgv9vHnU7fVdrz40HeNFfdTp/l0VNskYSeB8xqmorPjLg1TANG9Ck22wbMqotaa5AcBSSDQYEc9+5MDAYpfV6zNxdDvh5DQtE+2dAQTZ/03aXs1AUlQGYd2u+YPq5JSk5sgqh2oZL0H1B7UuYJegFGABIRMF2yyy9mtq7g7c23kEsb/Nl5/9LTara0FkyJwcjinZIEyY577iU824GLhtFn+HgjH6v5PCnljY8wbiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24hQCBR5uAskGrc1w3EPYqThsTGzRP1Lxan87pvhlmQ=;
 b=doSoqKftPNjK1QDOiN45/JyWZ320itneW0+imrvAwqLCI0LYKzS0LEIockk01/DRvf4c0Aal2mTQKdbeLgwTF+aN5u+1RE+ewMw7bE+E0pub6c2OERkKra+aiooB9lSvV88205aI3CeK9MicrXijd/bXXExU2JxIgQaPf6fmeVLq45syP7UKpACe/wvpdFW4CJQtqBPVMY/YrbQ2b5Zen+FAmSjIB8IlVbDFBsUOV8ArwtWFS+RsEK0oUQ1pUL7ScH1eM1Q1k2RjtTWcjtoNqnOcTaQLdQupEZpiy8OgWShS3lUnkaeNBd3Qlg/cev2ywmzkD9frvWYyV/vvQ7wZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24hQCBR5uAskGrc1w3EPYqThsTGzRP1Lxan87pvhlmQ=;
 b=QgG1oJTQHhTYNMix/mbHJqowLPKYSV+rF7V/gCG2IFUq6NnlzxsTODOTeosZBENhzoErGHg7R+sBkutmyt0Tx0n4cMKd/6Qm3kCALg4QYYZOAUmW1h1/j7vHu3HfLflJ98vg8epRzOPbzcN+zubq/BXdN94p5evRrAqP5lptA18=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Mon, 28 Dec
 2020 10:01:17 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 10:01:17 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Topic: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Index: AQHW3Pp7/bShFmZy4Um6ArX77xg9eaoMRpxA
Date: Mon, 28 Dec 2020 10:01:17 +0000
Message-ID: <CY4PR12MB128708C75C72FD7A0A036C2AF1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
In-Reply-To: <20201228091834.3240927-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-28T10:01:09Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=18e99082-cba1-4173-9712-00005be80e27;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-28T10:01:14Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ab513549-8aba-4a60-af72-00002c9aea18
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e0305a6-7bfe-490f-3f6d-08d8ab1784bf
x-ms-traffictypediagnostic: CY4PR1201MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25507AB719A62DBE0E7A86A3F1D90@CY4PR1201MB2550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9xDQJ2M6GpzbJN0g08JSCys6Vhirgzhf6Y9j3orlH5SmsvLO4jYB1nrGhqM6cjP91x60zpJNI/pVkOWaiWMmKYsaXdTum9GWYMXZFzN5OGGmV7WJv9dGPPTTtir3RUI8SoBW9Uhz1Mi9pLK/jOf87S+NvimmHVztX8iRnWkejvrhTiayAY/p0U7/zH5V7cullJeNc5nhbSm9+qdqe2Su07GL5sVhsB4yvolyPgF9Jbo1ouPd1Mni6BJUcpEp0T3mm5TK3jVhyjmxX5BYuO2PSiDu7GJ7nrpAQFFQ30j6nP5sIZr3ojCg/dZmaYLKGJtzSrm+5EyC6J+P/FGuAkKiTfzLTdC/Ncwb4bxgq1IQkTwwWLDh4Ktcj6sjnVPvmls7khe/gVNxpD22QNawRW9Rnn+lOB/WFgJaBCishI8gPDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(54906003)(66446008)(64756008)(52536014)(53546011)(71200400001)(9686003)(76116006)(45080400002)(86362001)(110136005)(55016002)(8936002)(66556008)(5660300002)(8676002)(7696005)(316002)(83380400001)(966005)(186003)(478600001)(66476007)(33656002)(2906002)(66946007)(4326008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yBkfLEXfvg+uWUFwb6wb+lgNIpD1uTZK9RK4hjTrC3yKMGD6iu50Ab4AqDBq?=
 =?us-ascii?Q?dOoQiWfhujQclBoi6tQog4m/rabYQCEHN42TYICwet44Cr60HmnigYGnPYeS?=
 =?us-ascii?Q?2R+oZis47K+qJahBBDHpYa/xEc2wk30aLN3chGnl2NjL4snwwO1AQPF8E90f?=
 =?us-ascii?Q?1qHwWY3tekCxwMAYLkob3KZqjyUkWIkrC9RYf649nNT3S7fu4bI2DYKGwQHm?=
 =?us-ascii?Q?27Bj+mnLDlurjEJvFTHcNhQUvnGEuNXsvNOucIYqNwlqFIrRfHiRCaRIBvpJ?=
 =?us-ascii?Q?iygC0CNtH924GwCWDYpU8PEtrBqMqD/Pe5qABaIxY6KHIXAvAgd51A+AjYrm?=
 =?us-ascii?Q?lPQIz2tDsa2RScsoKoZo/4mGlbVpncXPvn42ShIBi317+TyXz4RwVVADF5rD?=
 =?us-ascii?Q?GPKvoIQohqG7SktyBicfiu8Pl4dPJZscEM+3YT9/X4NTTw5BUibj2Mn5rbQx?=
 =?us-ascii?Q?Ev1Myrze7GKQFpdrpzvmzp0/njNGGAqX1cwV8LVIFHtjfLkXwhjnPtC2O0Sg?=
 =?us-ascii?Q?x5vLnU5UK3bLnhiAmYq/G2IvcB2DK4f1VpnRwxmfqRQNKjZoMcZUCup5HnWW?=
 =?us-ascii?Q?UWIVXAJVcU2JCaVhs6hJlOrpcyel0zaRkG+dSaZ9kvrSieOImLnf71qkcHJV?=
 =?us-ascii?Q?n8IhBn4U7YmLbFDYDizd4h0QVvq0wOrATmDkKmzDVhHEdvVECG5/THDns0lO?=
 =?us-ascii?Q?crt6UUkObaBMUvZqwjDcZMRR8zQX7Bj6oWNUHvd74UlGNXt5YACv5pHDWPaY?=
 =?us-ascii?Q?rtmOXFT6Ru2/ybM3el9iiPq+LVQa5SxlJjxRsHZPefgwoDQOIo0nLMx4RzQc?=
 =?us-ascii?Q?9b4QFEDXUxqKYc09XgDiGQD9+vLFMxIic6GUoxEh5pYJup9sfw+JFxBxIaRI?=
 =?us-ascii?Q?YAeZ9Ek81Pu+pvao60P9Y7Koh4lpJhEsNyObc0KVMsctVhkJjj60sglnY59m?=
 =?us-ascii?Q?GlC0TD8gwuOXSmKDooVu/LGJHShU62qjiXN3tRioywg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0305a6-7bfe-490f-3f6d-08d8ab1784bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 10:01:17.1029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2KSLxfqZR2JI+E6vw+z4ZZJeOOoKokUX5zWPTqRgSRv4aQIOClep644EKJL/YunSXeFBAS7huR1RjZnNAP/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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

Unfiy hdp related function into hdp structure for hdp version 4.

One spelling typo by Unfiy?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Monday, December 28, 2020 5:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions

From: Likun Gao <Likun.Gao@amd.com>

Unfiy hdp related function into hdp structure for hdp version 4.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0462a24f0fae08b3d36c01a8f0df81599377c048
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 150 ++++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h |  31 ++++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h

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
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C3eee4fa9521c40ab6d4c08d8ab119c3d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637447439430266697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xawd6BS2tseGkN3pyY0cyS9PAjy3JQW%2FLHo4SgEyCOE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
