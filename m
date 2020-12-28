Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98140C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 14:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EF820731
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 14:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EF820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014EC8925F;
	Mon, 28 Dec 2020 14:19:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A84891C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 14:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayZ+wo55rQqqE5p6PcimPwkk0PLYGjfkX3kc0dCyZUgAxCzJyGFMPiTKIC+GGWjvEaRHTFOka5bBw4CpPRZU18AcVWvlRgIFllSic7oAw6+p+hz0ka2H5n1sJKL0qs/YHyf3otsvcs8pXSOI9qj68L2tGFcomqSXPrIV2BBcAHW1asKzPe31CA0v3kdpB680l8dYIYmCN0yRsYIU7Z0AK33mnz78QmkqoDoWGmqHWYhTk6d4lE7g0lXNDC4obyqynJIu0VSGI5g2k5EhdTLSW2Zk2x6cdtCrGhlmpOrf/+0NrofVkapyjhRgT8WJtdbe5oDqgPOSfV8l7qBLGws42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhMNuN5x+zLbqVfUtFi7H7n5dhI/xWnfrl9Ug6gu/0k=;
 b=WFCed9Z952infgCseWsrDL6QQO6P2Lt1tiQl8zUIMA9KGv2I8sIoWge/rLW4yhZLOp7pnGt+7Tu2Ds+cs0zo78+Q91foXZCFwAWCZ4PRTlgoaNr9BeCglVbiEfr26KbUg7313LK0Hf719XAJ54Cnbyp6eKAwNlTJduJiQf0C6zpkZwxp/AUEl0cPjWbFjACxF/QN+wWJlpxV/T4L52pPQj+vi3YJMidsHUHC7kr4qeWL80iOQjJErATVjPi1+axO0eda5eVyMV0yRXJCSGbKMJQNrU53A/250o18pNM3DPSix7uqhfQ0H6zIiHSd9B9NIaNWxToQ0FTAx2SCjaz8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhMNuN5x+zLbqVfUtFi7H7n5dhI/xWnfrl9Ug6gu/0k=;
 b=MytatTXTmLw1XKg9jipuk4hKEIXd2XcJsmzADpL3V/SYmF6HNsWOkgIkntyWdqNR4fV2dM6dm2l20U7vdZPDO0qtvEtiVuzQgXu05OS8nD0N68q7yoXNwLHz++VXZ0HWuX529sp3l4KkA133w8x7Qu9HCdUTXcOvqWnx8/f5fv4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 14:19:45 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 14:19:45 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Topic: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Thread-Index: AQHW3Pp7/bShFmZy4Um6ArX77xg9eaoMRpxAgAABowCAAEaUQA==
Date: Mon, 28 Dec 2020 14:19:45 +0000
Message-ID: <CY4PR12MB1287333E8AB1128847AAA81AF1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
 <CY4PR12MB128708C75C72FD7A0A036C2AF1D90@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MWHPR12MB185440534A14FC28222A98C7EFD90@MWHPR12MB1854.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB185440534A14FC28222A98C7EFD90@MWHPR12MB1854.namprd12.prod.outlook.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-28T14:19:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 55078f76-010e-4cf9-86be-0000aa48c923
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [114.92.157.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7aaf9459-e8af-4e2a-0c53-08d8ab3ba066
x-ms-traffictypediagnostic: CY4PR12MB1414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB14141FD17AE98674080CF4B9F1D90@CY4PR12MB1414.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcvemPFYA0rF0Lc8cG0mN3VZuuah7DJVvcKCcGegqJVjcAu0h7tU7n4WGeEXuJjYCBwb9uRr8XCn2xN7wRlQGuBJLeTbwOPwry8AeoCMjjHuY/9LKnQQ1wNTf+7b/5jaNm0hxh285M5egvHwlTpKJ1Nqbg4+K7J/c39PfCcfloU477sOfS9RzbBHUWGd2PnTnBtqTPphf9HWy2U+0/pgt4ofJe3LvlOSUAWYvsUzkDvfIMCJW54H/gTXYdFT4H9V21YdLxXEVqMvB+aH9cH6QGk7OqSWqKFspY1xZMY9NnVujsjp8Cx7B/l4N5x5JTt4z6lomekvEOi5oGO3wlXtYBs5rd8iNnQBSAy5oAH5mAsGN1mOxN2odySMthTaUPZDRR9P2SeysRTW961e9jncOymScovbxmGyubbbjf7m+Us=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(55016002)(66946007)(110136005)(316002)(66476007)(76116006)(66556008)(6506007)(52536014)(2906002)(66446008)(83380400001)(71200400001)(5660300002)(8936002)(33656002)(64756008)(8676002)(186003)(478600001)(7696005)(966005)(26005)(86362001)(53546011)(9686003)(45080400002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sRZDpVPpzBjDfoR5iqWKaL91n9nbkYP7StvtuGTpNWYGrErzjvf4nkx+jqYG?=
 =?us-ascii?Q?f8ZLIjavyfzzoBAvbnLrcQauaOyWQWxPIFxuM4qWYzsTnN1zHmxl01Opbk3T?=
 =?us-ascii?Q?AG297UdvbPVkw9baDq1VQPJxSc9d1KZumC9gnnXg2xTt3xy9NeF6S5LHFuF5?=
 =?us-ascii?Q?NXLCZxJFs9YhD8sZheJ3o6AiVeE6RDYGgwGshZ1LAM+qOiQ45y2fs0wZVCU3?=
 =?us-ascii?Q?zx8F1+6ERcMNuQ4VEPHKkgpw/ae1B1+6ygH31lxielHRbD3y5Ik1u9T3DZwc?=
 =?us-ascii?Q?929mTusGKzIgIUoRz+exeXhpXp9BX0dfBpA+5+QVLrMt8EY+zY8z6ni3Nj27?=
 =?us-ascii?Q?2m5zhMW9igFDko59O2EIUu11XJ+qmL8m5chHITFDMfinHJBQDx6aqWPXVlTA?=
 =?us-ascii?Q?TIJxQX8MWDusAGxda1LjwVgJnphbLyG+DPalerexZiS/T1JNt8BceyKtWBWJ?=
 =?us-ascii?Q?E27IluoaHlw09AEBP49yKzWwAULHemyQ3loGgovAVDYxE0QiaOMYqQjIi6/P?=
 =?us-ascii?Q?LFov5aHi6WdgOzf8YCq35zBYh+TIPMUb7XL3k6r9DTg9HxCfmw5aIDgXMw0m?=
 =?us-ascii?Q?+zNCM8gIY1SpM2F8Qa3DIb9simpzIj12phol4EQqjpzD84lICYGcnO2kPzYz?=
 =?us-ascii?Q?uJ7nUVsOUBa2wsKUEusKcF5xBKZnDr2N3z3/CContrdgOrBWPTeET7/k2P8b?=
 =?us-ascii?Q?qMZXCzM450cf/UydUf2Zpl9AWqRVaOGtbRWPBbdPRhUA+1SV6B72LyYU6f4D?=
 =?us-ascii?Q?oxqLaUXL27zHivrjlj2R9M6lEgL+vGnLg80zMzvEUOFQ7UPnH3ATCQu4VX2q?=
 =?us-ascii?Q?brIsPDci1z16fUvB7kWo6wBbfOo4fu5AqnTQ00FTZTObU5UmISx+sK+kDcCP?=
 =?us-ascii?Q?9L4H/ZugQjsWIO71kwVCYHsP4u/y+vmZP1O4hoGnysNiajM6t+TSU3YCMRrQ?=
 =?us-ascii?Q?ML5dnIfxHghUIwQEzXvNJKvCV9NBi+/M1FzcbJX4LuY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaf9459-e8af-4e2a-0c53-08d8ab3ba066
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 14:19:45.2858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 139DjVEUkd3u5BeGacoDhBZtVOhzcmkMkoIXn+2tN/Nv6cy+cCmwvub5Yj3/5Kfy+JWonOrXBjHz0LliOkC1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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

With the spelling typos fixed, the series is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, December 28, 2020 6:06 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions

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
