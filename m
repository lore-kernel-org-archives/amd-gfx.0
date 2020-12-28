Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B675C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F54F207CC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F54F207CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348F089A83;
	Mon, 28 Dec 2020 09:18:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA76689A74
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 09:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsWfXXsrq42efa255/Ld4aYguRHZf8a+S9E0rPeOiMVobf6wv1WK3QL8PObPKH1aVVWh329D72hMKz1t84w5Y6PGEUczmVb5gmlr0PvL/9mAbdrBA9cybVkbJRRl87Z39OwtAW3nZx2jXz/eXm7RUF/Iq1plHqc4XRpnaQ6iJkpv3wsXu6UKKbJ/QCFOzL2dCM2L85XByhAQLub5IQ4LcvsZb72IH7RbrGYiiLuBkLL2fiPPGY9a7ERevua1TVBtebImni8rQAoyomx7ATPLuZtO8ieNhIkQg8WiHdEwz7RDhfCNVybapglJHQ7FEHOjxWPIK2J4OM5beAnh3FkwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxfl2+O1hBJCH/OzutUhtK02ts4Xxi8j6uLFWiVso00=;
 b=GXzl04bjbHtYoNw3P9cPH4CW24z94rcHo3u5YQLb9fzIBf8tM6LU3tuTL8EcdB5HGrGnuOM8WJfpg9RKOo1QnA0n4UHRc5jvqekXOKrSm55M6C9NR93i+Bq7lgSDRT7eSE3Pa4xpfZEBwfWPwV1I3Vz4hDVLetx8DjvGsc6cXhPlaayyp29P8PZCxqP7N2AD6kTTR6GdGLiaXOvwZKEWypzlm5hSawD5Jy6zxeT5iBTtGaI/CmBqEjGxOutAYH75TSQIBHbOgq8levvimhkhR7425plhfe1PxM6zuN+s3MSB8sN8auJpvI3yOap/3shj4R2sIgBncWji3n8ui4HqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxfl2+O1hBJCH/OzutUhtK02ts4Xxi8j6uLFWiVso00=;
 b=xaftg8GhHKU+H4exvuM1jh35DeEbTvfZw6Zl7MX5EshH2iukJJXYeWa8PMAMnAi2P14RWNTVQf417Q027Q5vU0o3obpzQGs8wMzzLRIiqfDZyuFdtSHVLVkHxpligZfqPU5xdASEVN7KFCLjQWXBj+oKQOscczcaVBaSrACjd3A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 09:18:54 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 09:18:54 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: switch hdp callback functions for hdp v4
Date: Mon, 28 Dec 2020 17:18:32 +0800
Message-Id: <20201228091834.3240927-3-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228091834.3240927-1-likun.gao@amd.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 09:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c2c201e-0e73-43cf-5088-08d8ab11996a
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB450834DCD9342204604731DAEFD90@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 828RQXND4eDglCwbr/bFAO4SJxP+Ek4PjbWzcU++FAlSWSVvOyfjbiMQHkK3sJRo8n2hD+1rjhztKzgBL7W0zgJ3Ho23BkSfFl8LRIUqnh7FhMCRYXuCSx6TllBzauZMRgXANtu72EsbRLA1MKhIZENOCQlmhDYGof+KVE27dx3WvyFGB5X7Xuj+pekwZzWI4OwFG1+eVXRr1UQqHznt2PR4F0J/0gPnaRWFIbngJC4VRm4bHVAVrC+dK8EVP6VInP88K6dmsTEF//fadtN7djPtuQcH26jv5eUZZrTl8L64xJ7JzpcPszepD7/Ce864YrxD5Or2KV6OUmZufGsMBXmclAxeNgK58pq9Bp1z539Nu4fTC75QWkx7acuX1gq7Z51m5uSpVVPbJAk2NlBUiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(16526019)(66946007)(316002)(2616005)(956004)(478600001)(86362001)(83380400001)(44832011)(4326008)(6666004)(8936002)(8676002)(30864003)(52116002)(36756003)(1076003)(7696005)(6486002)(5660300002)(26005)(54906003)(2906002)(186003)(66556008)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?si2bjPjEwzTDYV8WO0qqt8H46ASU276buHOmiIQt+blQrhqOr8p9c1Igffpl?=
 =?us-ascii?Q?m5SZSHZbkPlhZaLlLZuX84uKJXYoIl9Mp99E5B98XR09TRe6Io1NmIXAb2ZL?=
 =?us-ascii?Q?oNsdlvkftSkkpEDmA1Zw+YjzRUJ9UxXl8nQLx7H38MVcPCAdBlbp8h1dh78m?=
 =?us-ascii?Q?rQf/MKreq4gBNxQKArXyRsgjzeX0XANOe6cQvCh+oiEFflUjx2IjccwPJWmR?=
 =?us-ascii?Q?1QnQ1xLQMxnzRDn8rutWFzI0wnWFrOXJh4OKY6rDkzjqV6RlJ6NwlsGTU7re?=
 =?us-ascii?Q?E9vFJsIIp/W5KlFdzPCgpkn2y93Op9JUDZSF4bhJhRMJRTm21UJwOPt5dzFf?=
 =?us-ascii?Q?HB+kds1IpxRnN2WsFMmALByBIt9JR2N3lsN4SIxQFep1PXw4+hNhDfq87+59?=
 =?us-ascii?Q?HF2gk/mC7u4/q+iicLPlXkRqFVsurzEpsUkdEJBXP3IU9TIaZyKdRTgUbgw0?=
 =?us-ascii?Q?pH2WUkLYpyT4zfXhKWkBAIvVbm9ijMATuWsRkFN48Qz9MPAgJnaOHcDRlKfU?=
 =?us-ascii?Q?D6sUCw1AHvLc6E8l1n/Jbg2TmatR/4F8cH9PBVUzYl8Billip+7wsVYWbGuY?=
 =?us-ascii?Q?zdBsBJ135Qw2b/txDP6epFG+GcZ+SM1ZxmC5EIFQWN+9y0szDxmcyfD0U3GD?=
 =?us-ascii?Q?1UiqMhdRBjACT+nZkkFosajv3uQ0Sh4WD2ZIoKkz9lmwePJuy6wscYIz02o+?=
 =?us-ascii?Q?fa34FVgbBWgE2c1+W0PHoHVFth+bSpQmvIvyClRW6vc8CRUhIBzMHzJM8wQ4?=
 =?us-ascii?Q?IN7+xqgbf4azmzRagPxBUGZpgFyoMYF8ZJKcPOx2qGWF4Bb7BO/RCJlVpLht?=
 =?us-ascii?Q?f7mdkfoTEnYlR8YABVNK2xEMWzDR2FmyaFY+8Mu2h3KFTL5tyFBgNLWY/3xc?=
 =?us-ascii?Q?KR2INS07mYFm42qD9FCxuhUOfNGaAx75KsAhkwEs0rNYl4/INvaGccXkAdei?=
 =?us-ascii?Q?D2qUOXoV/OfFPfa3EhKzeWR/ap5SId3J1qGYT8M0ZwmydTnX1Q24Eh5Fxg4o?=
 =?us-ascii?Q?gdbi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 09:18:54.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2c201e-0e73-43cf-5088-08d8ab11996a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIUf1EqsAcOhkQ+7fEg0MZc27NRhgquV5M5pjiShgv+FOCIx0vOktc5VCu32/KGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Switch to use the HDP functions which unfied on hdp structure instead of
the scattered hdp callback functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I75016df403eca537fa30519e2918207461ec6f28
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 21 +------
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 82 +++------------------------
 4 files changed, 15 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c6262689e14e..d741fee91a37 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 92e9d1f1207b..ae4bcdd630e6 100644
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
@@ -1209,8 +1210,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) (adev)->asic_funcs->flush_hdp((adev), (r))
-#define amdgpu_asic_invalidate_hdp(adev, r) (adev)->asic_funcs->invalidate_hdp((adev), (r))
+#define amdgpu_asic_flush_hdp(adev, r) \
+	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
+#define amdgpu_asic_invalidate_hdp(adev, r) \
+	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : (adev)->hdp.funcs->invalidate_hdp((adev), (r)))
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0d3def7269bb..6426ecd1861b 100644
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
@@ -835,21 +827,6 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void soc15_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
-{
-	adev->nbio.funcs->hdp_flush(adev, ring);
-}
-
-static void soc15_invalidate_hdp(struct amdgpu_device *adev,
-				 struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-}
-
 static bool soc15_need_full_reset(struct amdgpu_device *adev)
 {
 	/* change this when we implement soft reset */
@@ -858,10 +835,7 @@ static bool soc15_need_full_reset(struct amdgpu_device *adev)
 
 static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)
 {
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
-		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+	adev->hdp.funcs->reset_ras_error_count(adev);
 }
 
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
@@ -1012,8 +986,6 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.flush_hdp = &soc15_flush_hdp,
-	.invalidate_hdp = &soc15_invalidate_hdp,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega10_doorbell_index_init,
 	.get_pcie_usage = &soc15_get_pcie_usage,
@@ -1035,8 +1007,6 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.flush_hdp = &soc15_flush_hdp,
-	.invalidate_hdp = &soc15_invalidate_hdp,
 	.reset_hdp_ras_error_count = &vega20_reset_hdp_ras_error_count,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega20_doorbell_index_init,
@@ -1422,41 +1392,6 @@ static int soc15_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev, bool enable)
-{
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
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	uint32_t def, data;
@@ -1517,7 +1452,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1534,7 +1469,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1542,7 +1477,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1561,10 +1496,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_LS */
-	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	/* AMD_CG_SUPPORT_DRM_MGCG */
 	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
