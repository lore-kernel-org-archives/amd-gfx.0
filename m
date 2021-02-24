Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F94C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC97564F0A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC97564F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ECC6E0AF;
	Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0344789DD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvKQnU0AiI0s15WsoGtOGX9QpCQxCQQ080q5WZQJPZwvBfKWljdWJ5ABa/YRewvr05VYYhBRikjsepUCrivftbSb2DcmBtOeTHvvJD+LoEvLl9ApbGwdT4cfZncIYWzBylZ/UbLQ/6niMA93L2BFyZQ9QIMqCT9NE71TW0/DvEvZlyRNkqAcC0PrDHn/fPrqS/gHOGjMHFYrnaPFGKPYdQme5XkR5FxYjkTLrLgQfxzZCEwW3uvKvIdP8mSLGTefx6Rqs9doDlZTCzwCL0GtDtMvFNf4PjntexQso2wToLlTib7elRMdvJkqcJk/IbDugzD7XZ7WvbYqHYR7+IS+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvGnPifpA/0Rd+f1DCFiikHIOJQffaqILnVIn7FvVM=;
 b=b69052SGfyxFUS2WriBBpohk0TvTbio+FU53nKZJ5X8KsX7gND4D0NZNbO3dKptpCCXuzn/cHrx0+BRGdpwt9TZr/VIkh+RD9DojQMHu6wEL89gwKL1oRz0xehD6atZCBPioj+nGzco1YfOibshWx45uZKhAo4uqNPz9Ogz4rO4ijZCmNfPWSSeIIa3Kp3yL3jbvY3B4Dg/vBrxRX5byMjeoUZcpjLmhJdb/kUNKveMCJ9f9eyrEaegFdQDn31boIYME0+utC0NfqDPaNRoRfZ2kavxAy8pJ4PjlovVY6dKgQPFt+CBY5uZIuQysqNY8gxg+XcQ3ysG14k7/Ducrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvGnPifpA/0Rd+f1DCFiikHIOJQffaqILnVIn7FvVM=;
 b=EjWh7OH1xTCD+2mb2lPRz0hHTNKz6I+WXCChkgThM6LDvKFWuHvnlpM9pdU0jWnE2PhPrdZCOt2/Tqn8Q/Apfrt9gqDOh1B7uP4bC3b2T7+TwWRLkF2dYbA5XDmHE6c7y0vqzpeUqT7YXzmitXRY6BeU6xN4EYY66PRJCrWBcHM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:19:45 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:45 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 037/159] drm/amdgpu: implement smuio v13_0 callbacks
Date: Wed, 24 Feb 2021 17:16:57 -0500
Message-Id: <20210224221859.3068810-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6d2d9de-b8c0-4718-07b1-08d8d9124a35
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4865847A42D5D74159C9F408F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPjDhh7xEAEiRT3IiT0G0w/iapnmPGEAnKGEYhENjHRVfIJOnv+dgs/E8E5ESr8isN9VYBwOObtXsXwNuY+c/DlvyPbym9mtboCPw9zwCFgPQOe0jj7yzINjKJ9fq5wTtspbiuPFqAT0MfLQMLNh+OlQW3vIiXUxTCFtQiqtasfdINV9wpgPUmYZnLsXNwxmmxNqQgliPsu36BIi3Gv8DyZ3cPnerpt2EbzpLyp23Ink4xJGvleli/Ypf12DzK2ZdCyZb0/q8mkxuHeubAWLf9q9+aLbgPQnI/w986s/WhoQQdMk+Yk30ZcWD+hEInBBxBDJifTpCuDjqWbCuUd+Rsdnxtxx4NoLlQY5oO2G57AC0Q7YDqjZSNZsmuCOtveMGG6t9i7LWlEGBXuY5xDXVQ+hLcXXntxw2xNOvZnXWv6OCQhuAIgUOzRduqE+12/CZ4BABdwS08OejqF4sa7d7Nft7HyFl2ZVzdyqARCh+2pp1kIDtPr88TDbpJewXPeZFW0Ms5n1zV3LgSYba7AbJfTDRE0mEYwNk/mNtuEYRARaOtFQxoSJjN2ndmztBSoEMwFbPVpY9UQptTzkyr3GOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?itMF0STUUEihTAQz3dQ0n+2+7GvVpz5FcBA2XNdx5IsGg326tCO5wUlnazvv?=
 =?us-ascii?Q?LVpZxognVrrNKvYzowEns4LJHelH9OSaUFzFwSpCTbNkc2lPEUX382tFlp5I?=
 =?us-ascii?Q?KXZhJpOBwvsyacTwtbnzBIoWCRiTar/f0sTloGql/TjbNneYUTlMlJgGy9Dz?=
 =?us-ascii?Q?mh3x0bQcGh74RczrFck69ervm3MtKDSZKS3ztAceyaZ7C+5WVqVXUkBjenah?=
 =?us-ascii?Q?4fiKJo61thwHICqw/yr6AQZ3B+R37i5YZ18zvHcRs3BTfb8QQFu5KDot4z2v?=
 =?us-ascii?Q?EIFXiz++ZYNsy09k7u2eibKNL5eKj15DiuQswy9Lm1sXi10c00zYrwz1tg0O?=
 =?us-ascii?Q?exyHMhcED2uj6PHAdPsvzkMMfGnadNWJ6bdLcWHmhi5uoPRh1+qCZnKoJFc8?=
 =?us-ascii?Q?Brml3HwroDr0BKGCN2uFiDiXbJ7KGKLnB3nClAHmd4Wnc6REHkI3Af6JBaBs?=
 =?us-ascii?Q?N4rr7hmMYkRS6TNM+w+ZtfCliDcgrV8dAIeJiAA6yV3A1IKkBy71Sg8cXBTp?=
 =?us-ascii?Q?MJjMUTUKvXIT7FzZuhwrsBfYba0RKFcoI8jWAIJz8UHJnDnO0QEjuJmWafQX?=
 =?us-ascii?Q?1xfOAmb/oGNJhbhO93q0pB0kV4LnGb4U3Cx6oq5WCMrLelfUxbBp1yTx7z7d?=
 =?us-ascii?Q?VicItBTarYYGyp80aj3m/lKLy9+ycRwabkPqnqFsDQYasMfQY7NeuBou+0e3?=
 =?us-ascii?Q?1dlRd5PPxooa/acgcyo9NEyGsdndnpbp3mN1+iSQ5IQfsDFhkRys6030ZCCK?=
 =?us-ascii?Q?dKbcW9JabAyjdg3SsoownzaMLxpImwqGmVLPqOq9g419QRWAHYhigmKwsH3S?=
 =?us-ascii?Q?zBAAG9JeikjqJLzzhrWbB7o/bLs4FpCMgIwekmTjiBoDYEjXNSAE3vLFhNWN?=
 =?us-ascii?Q?WupYNv46cgK8NhhWKvUiUABgrEhh/GlLBt9W3HuxM+x27XWX11brXrvQVDrt?=
 =?us-ascii?Q?qvdoZwtp+MVKZ3ossdyHbNXFZRs5VGc/yslFRJmBh7ENbuyhsJNXqnzR8x/d?=
 =?us-ascii?Q?P4itNGY3vyXNHEl1EfBLyARHH+oElbuqmegCD3oNCBf5Er04B9zBcmbCeG6b?=
 =?us-ascii?Q?i2M5eXBR6eipst5yaDE1lAp0FdS99m9C0Kb6focUQKWy3d0aDeYhfc16G/TN?=
 =?us-ascii?Q?FNtWX/SeuDKyeNg9TN4pA+5/va0TwUEL7QEsEurV51L38GTnirakKFw+pIm1?=
 =?us-ascii?Q?Eid4D0n9NaCD2PMAT+kJ3Xux4e+nN+QmcLeIVhpgaOg0dGXnoFnH4lJEV6OM?=
 =?us-ascii?Q?kVhf+zyxxmvY01iql8wdsRbyrlI0SJpsEmO/aEp5oM9vSz0KX/mKSuPG24bp?=
 =?us-ascii?Q?7o8/UN0DOp4quT+vaUebJPW4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d2d9de-b8c0-4718-07b1-08d8d9124a35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:45.2614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVYRZCMySLaQGI79yoXI3ggHjcDLTxavAEFW3JunA28/wneweQL/UP0m43RCX9KFKi//+Jw58agd1+7doQ++ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Aldebaran will use smuio v13_0 callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c | 121 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h |  30 ++++++
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5c9279b15ada..82a99dd2df4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -174,7 +174,8 @@ amdgpu-y += \
 amdgpu-y += \
 	smuio_v9_0.o \
 	smuio_v11_0.o \
-	smuio_v11_0_6.o
+	smuio_v11_0_6.o \
+	smuio_v13_0.o
 
 # add amdkfd interfaces
 amdgpu-y += amdgpu_amdkfd.o
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
new file mode 100644
index 000000000000..31817b604e28
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "smuio_v13_0.h"
+#include "smuio/smuio_13_0_2_offset.h"
+#include "smuio/smuio_13_0_2_sh_mask.h"
+
+#define SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK	0x00000001L
+
+static u32 smuio_v13_0_get_rom_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_INDEX);
+}
+
+static u32 smuio_v13_0_get_rom_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(SMUIO, 0, regROM_DATA);
+}
+
+void smuio_v13_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+{
+	u32 def, data;
+
+	/* enable/disable ROM CG is not supported on APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	def = data = RREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0);
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG))
+		data &= ~(CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
+			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK);
+	else
+		data |= CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK |
+			CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE1_MASK;
+
+	if (def != data)
+		WREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0, data);
+}
+
+void smuio_v13_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+{
+	u32 data;
+
+	/* CGTT_ROM_CLK_CTRL0 is not available for APU */
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	data = RREG32_SOC15(SMUIO, 0, regCGTT_ROM_CLK_CTRL0);
+	if (!(data & CGTT_ROM_CLK_CTRL0__SOFT_OVERRIDE0_MASK))
+		*flags |= AMD_CG_SUPPORT_ROM_MGCG;
+}
+
+/**
+ * smuio_v13_0_get_die_id - query die id from FCH.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns die id
+ */
+static u32 smuio_v13_0_get_die_id(struct amdgpu_device *adev)
+{
+	u32 data, die_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	die_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, DIE_ID);
+
+	return die_id;
+}
+
+/**
+ * smuio_v13_0_supports_host_gpu_xgmi - detect xgmi interface between cpu and gpu/s.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns true on success or false otherwise.
+ */
+static bool smuio_v13_0_is_host_gpu_xgmi_supported(struct amdgpu_device *adev)
+{
+	u32 data;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	data = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, TOPOLOGY_ID);
+	/* data[4:0]
+	 * bit 0 == 0 host-gpu interface is PCIE
+	 * bit 0 == 1 host-gpu interface is Alternate Protocal
+	 * for AMD, this is XGMI
+	 */
+	data &= SMUIO_MCM_CONFIG__HOST_GPU_XGMI_MASK;
+
+	return data ? true : false;
+}
+
+const struct amdgpu_smuio_funcs smuio_v13_0_funcs = {
+	.get_rom_index_offset = smuio_v13_0_get_rom_index_offset,
+	.get_rom_data_offset = smuio_v13_0_get_rom_data_offset,
+	.get_die_id = smuio_v13_0_get_die_id,
+	.is_host_gpu_xgmi_supported = smuio_v13_0_is_host_gpu_xgmi_supported,
+	.update_rom_clock_gating = smuio_v13_0_update_rom_clock_gating,
+	.get_clock_gating_state = smuio_v13_0_get_clock_gating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h
new file mode 100644
index 000000000000..a3bfe3e4fb46
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __SMUIO_V13_0_H__
+#define __SMUIO_V13_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v13_0_funcs;
+
+#endif /* __SMUIO_V13_0_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
