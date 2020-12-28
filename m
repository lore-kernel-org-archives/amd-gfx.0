Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C2221F0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C2221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E088970E;
	Mon, 28 Dec 2020 10:06:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECFA8970E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 10:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF9GJHM1diKJsayhW1V+ynG38v96MjZckBRj9QWYkukV1WQWxN6QxJY5elMqvKHMU1BZ8A7w8PgeWFVW6TWdME5Skp8f2DEQujnhZUVQD8pYMFe+lbTFEDK98WpiWl2w//jnd5CRhvO/WfPTAp5cBlwJjxaurjglojCpi8w2EsBd9ijIDwhYMUEVOEPf+259B/bDAC+fnZnklp7EfIvzlos7avv00wzToUS0aEnFWucZ5aVXp3WWAghQPzJVTD1/XXQHp4QAZo6945KWAVhzdy6qMEVze57ascohmM3zfLglIaUOUAf6LAo4frkH/UBDiJgKlPS2/OYr8BskA52kRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxcFNqnzPmDeTXdOdCzhZgJHikiV0KCFze2Tr7yWtFA=;
 b=RBAfPW/MWmKfDcuRIBqTtnpFqhXoddpW0KEU/0eEHzW867SILnkcDCEDxOAUv1YDcxzz5PLxUeWurKQaaNPg5oNiL+Zn2tRbTb61olY+bfs7w26xicRVfXhE/V5y1cPAzSwWtvj+2/qUUGTbZn1zXQypKuQRfA8QJ3YkG1mFiLYFLcPjr+OD2bGj3KW96n4CLL+dsuqDx+N37RkCmb74ZGsHA5+7Q7OCh/bnju4HRQUhHIYH8q6fyxLelguScqmmMAcJ4wQEiBhMzIbeErJYG5kKHxDWRx7huC/qXZ/avUj/tL3mJnKojxvhjU6kWSkTAZGH/DHWfTRFvyIYhq+Ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxcFNqnzPmDeTXdOdCzhZgJHikiV0KCFze2Tr7yWtFA=;
 b=aSt3XPOfGZRzgoJYfcxExfo5GzzqiyjBL6mZrKC2vruE+kKusU/muimu7enWl+tD3ao6l3eB1emRppbD5+URcZIocg2fPU1YcESHuHh5i1CJI8RkMcTeSdOz+YAIC+W53zIVl+dTLWcxW7CXR7awAioRkcIgMsWdEiuGslOf/6I=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR1201MB2495.namprd12.prod.outlook.com (2603:10b6:300:df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Mon, 28 Dec
 2020 10:06:26 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 10:06:26 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Topic: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Index: AQHW3Pp0q7TE/8SNs0aC5IqCkm5XT6oMRs+AgAAA//A=
Date: Mon, 28 Dec 2020 10:06:26 +0000
Message-ID: <MWHPR12MB185440534A14FC28222A98C7EFD90@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <CY4PR12MB128708C75C72FD7A0A036C2AF1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB128708C75C72FD7A0A036C2AF1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-28T10:06:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a3d0dbd6-4aad-4e70-8874-0000c0ab22e8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d857e89-c250-4c9d-5910-08d8ab183d21
x-ms-traffictypediagnostic: MWHPR1201MB2495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB249597A26F01795E056382E3EFD90@MWHPR1201MB2495.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7LJ8Yac8C0LxyH5p6Vo4ffmSJnDAJQwQI80tV/83mCZ/rGe6uVDPBFDdUbn/fPBqR3ZbX/kUtfY65n89TaGyDLzqWghXG1h7a19DrB+ZVgAXo5a+AV70g+7ry5hEYqCO1mYZcDgejXgd3UMeGYcLcQRrShSnb6r4sKzQsnO74Qr4MfeMlnhFsdc1UYgL6o23IJdQXnI/TnhfEficQV8VYR0lIZseSLnMpTQOEQrag1OZFNVJ3GGwMajI7fMOtUt/e1/cZ3tQcUZjx98ZQVkVxzBLe4s4h/ZsX7XlPekDAKVRWcWg9vze8YBo3ZFINBAv89GWYFtsdXz3brtYpV9FJprZEePSQQD+Kl6aejYsugvRY+7TunKEnnvxzgPEjtWE6b2BnXjCLsw/ussKNsAk+V0v4a2iQlO7sFvLxBv2Wo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(66476007)(26005)(52536014)(86362001)(2906002)(966005)(5660300002)(8936002)(33656002)(55016002)(71200400001)(83380400001)(76116006)(66446008)(4326008)(7696005)(8676002)(9686003)(64756008)(66556008)(110136005)(66946007)(6506007)(186003)(53546011)(45080400002)(478600001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iL53SWc+dX1+Z9qZbNB73RIydlu1fsItszs4Fpn6RxZ80dY4l80Av940NQVp?=
 =?us-ascii?Q?kTiQU3lOtva5pbWff5DCGm7igaHQaK/JOqsmYudB6GQNimVyjScuSRz3whxw?=
 =?us-ascii?Q?pcMldD/7X7/lirQjFgkOnrDc/sNhqY7Gov/qvxBd9l+8hxsgTA7yMCV1oVru?=
 =?us-ascii?Q?uvfNRpcYlvmGfxXGsJTM9nw1AZ5jr8igxrSOV48WGoMlyT6dazWVU3cUKIUS?=
 =?us-ascii?Q?IC8caj5UoVQvugr6nGGoZkjEE4+wq0zk0Bb5lJzy5Mc7e+q+VA3S7QATNbSG?=
 =?us-ascii?Q?QUzJp5FRW8S2ftEH0jrixl5AINKmg/gn7qP/3gr/6UeyaWVZGHUPlYLnf9rZ?=
 =?us-ascii?Q?0cNEFu0E7GhVDXy437Kp+gtNjIhZjn0R2wzWY/reRQNpXWJbizUrC6kKQImb?=
 =?us-ascii?Q?qyru+LBH98MNBKNrHNeQOoTLE1+Y5RNLICEP16uVIs2nniZSxd+JxN1wuE+S?=
 =?us-ascii?Q?N2PTo+NENpZ2bmQF8IVgbtfKh3zjxa+n2fkgaueYebeYsJtzlA/JY7ifeL6c?=
 =?us-ascii?Q?I1WGSmA3kRpsmodoWRozC+g1tVdVZE/prMoHDknCKYz537ao+bbEZyx+FaBn?=
 =?us-ascii?Q?cOtsrcY9GHovPLZfTjBX+WwSNZT87QWft8lh6rcvk4vLnXph3EouEea1KhS3?=
 =?us-ascii?Q?Xl1BI1NduduDSPDQV0sjKQd4onxGtqMrBmjoH8LO003vnLmh5d0Q/0mc0Sxd?=
 =?us-ascii?Q?fZb5SssShFSUize7izfBLB04Ni3jJTSgFVWxj69XQnqh9LiCgADRjeJiwr6i?=
 =?us-ascii?Q?yhnqiVb16Os3n934RuhfO4oc/VNHBYkasroVN4q6tMLcZWFx72aJz9wfvLoD?=
 =?us-ascii?Q?i0gFKJuOWGI3ZyWjRDjmTGlVjR10RVVGJ6SDEpzP96z3EfKnHJRM72r+hPaT?=
 =?us-ascii?Q?pw3+hc6Y54+olT69GDzlal9vywvM7rdQG2uDERgwltHkc3njB0FOB/DvR9NX?=
 =?us-ascii?Q?FBIeEdgm0/qosPAq30dr1s0H5Pr0KYtDMEW29BG8ua0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d857e89-c250-4c9d-5910-08d8ab183d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 10:06:26.4456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BX+PlrqhAYTMDRVh9+kCfhJXViKfX12UATfXntO/9D8o/FvUMkVcF3BsO+bjaTbJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2495
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Oh, sorry, should be spelling as Unify and unified.

Regards,
Likun

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, December 28, 2020 6:01 PM
To: Gao, Likun <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions

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
