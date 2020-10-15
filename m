Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA8C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 03:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F742222E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 03:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vHk8RNni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F742222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B42B6EC13;
	Thu, 15 Oct 2020 03:25:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78696EC13
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 03:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NruYfUrHfPOdWrLrXSDUb1QTNxXB/jVqV53jjMI96Bwgldgk27FnZdj2xWrZgnKUHMbgoqJ4EK9cJV6IpOQ7KsoxTrIbPP42yO4AJ0r08DJ7S4oysWu2Tme/a8JDfeyV2EpqftKyUMC9NxMmag9UjBUnIxiiAbxiLxEYNkhArvtLQpv62NOzjr72d3UZuj0l/eXPKJbn0JU7lUQi0NK/6NR6YMR0hciOZHXpO/EsznOAjWnToGvry0wS+7yJ++r3glYrQH9Cu6Rr2Seq3UEGXHFPmTLsQclxoBsMuyAVNRxd/8/+qvhkXj4VV6pfCCAvgze9fOggQGeRdNpgXgqSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2rSm9zrc0D0fVbGQOKihu5Tc0ZrIlIh6fPGeKNSMrw=;
 b=ZbmBmAfBfuJcTDoUNuWko7Dt+4V3cYv92T26j02hxRjQa4IT1pQUGkyHK56Xx1odR1ZxDUGrmfo2QeNKdJUaNSmJxWXVb4QpHdhmwW/I/XEup7q2be+y7zVUXlSQH4xkGNLmmoiC2vLA31g7pAL77hniC9V2Fl82WHtUfRKfXoRqak18/fdR/D+MfpZbcihsjTnCbZysUCH2j7dICBrpd1Y+F8BJpCjVJ0rZd2+CYiRbmW3UFGS1wpWwDeDxb88zyb3TU9RpzhrRFSIoTPMknHuXWkaIDk6Ajf7nSvgNA4OOu35+ekUjb6R8pxyeOVw/NchC/g7jiHvTpYqRMXc5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2rSm9zrc0D0fVbGQOKihu5Tc0ZrIlIh6fPGeKNSMrw=;
 b=vHk8RNniByD4iip9qtLxoVNQU+OVuobw7snR6u7yL50+7wo5w0rFPYCRAe2hSqHZN7voyhFT9XVYSRQmWJiogxOWs/3ZDeB4ALHHcBW1SMJJhVIwhojsJ9EQPTol3FV5U0tpaUEKH/y8tNrh0v3ina9CsPPeaBBA7GfinMfIpn8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3167.namprd12.prod.outlook.com (2603:10b6:208:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 03:25:32 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3477.023; Thu, 15 Oct 2020
 03:25:32 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove gfxhub_v1_1_funcs set
Date: Thu, 15 Oct 2020 11:25:09 +0800
Message-Id: <20201015032509.28605-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:c8::19) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HKAPR03CA0014.apcprd03.prod.outlook.com (2603:1096:203:c8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Thu, 15 Oct 2020 03:25:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdc934bf-4c0e-4dd0-2c01-08d870b9f8f8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3167:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3167F15BF7CF02B8C319A666A2020@MN2PR12MB3167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2f2Ow+UC4ERSb/ytFa45eKlch3WmQ0kPyYxNWIJtAEfBVrrASGaJWjhu1GKssunczJ8OQ39wmMH8hlzD+TRqF0k8p1ptC4IhDr2Gp9BMIPbCi4YGbHXwfu+Qk6jZvaDQPdLyWJPY7qtoinHXtjV1FT8Z2rUIviYHnS9oR8UUEQvqkiL8vwsH3XPyFRIfbocEBBAQ6xq1nr4+jd4Tk80OSm+AuwE+HZeYTHG3TTGtmlMKLpcWKmN8dbgZoVJNqBZhgijT/4Pp4A1gIGcyKN8ECMDTrA5GC6JVm8R8H4b2pu16hD4SBXprbJ0RmYN4D2BNr0AwFjX7AJ99tzRiw63OUHul97ZAP5cwhnbbYOThNsR5lUQxVXjsiKV4RI8ovOH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(26005)(186003)(6666004)(52116002)(83380400001)(66556008)(66476007)(66946007)(16526019)(7696005)(5660300002)(1076003)(8936002)(8676002)(86362001)(36756003)(6916009)(478600001)(2616005)(956004)(316002)(6486002)(4326008)(2906002)(34490700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: g2zNsaRu0pklZc9Fb57wXkQ1RivFSIycgrKMpJljfq8hGyNpX1Y+T86fCp5QqWr31Vr/FMBlVSjO15syQgR05unP6bM3WFHXRDSv3SlGQOkqk/nJeQTjbEpXiM05oA/sUEsrwa1Pr2m+u6EpLD48quOuxjTC3i8fQh3vxc6GwFz6P48GitLyOR4HbCcveUo+NKcO6i8/FvqfaSXnxT/JWt2qg8sB/ZoUzTSwg5xgAAKoT4pdelDsS95Dk4BVtHheoRQ76ECYZtbK4URkOYCO+S7ESjQPyNJIqKmnqS+xMoLB22UG5JTTOq4GSY0gM/ENzDx5oCpNxWPcyFr8PV8BL7w8uCq6/tGmGhbV+U4oltrKUiaXyXdJ4O5cxti9qNUAw7vB37IrXVoTnhRBC2EIKULWa6CG8oruC2XXJmzXysjrQc0qFA+9qBIZPaZefWUd6mt+bDMxOZUAELtRS3eHMSjjW0xxaKqFF9L3N+NUSCH1Xgu8NeoxITDYGpwspZQYPAaxYma9qFlG4+r/Gl3GTuUpJ+E8eXboMl+epPVjLhxnSt+Dd6uTnOK01yzkjxrPe12IpNaURKtEZkeiSnDVtBtdWiG09XrLovgxP2QVUccDWZwOCVMO6hd7KuEUhjx37H4jE4i/rYOZwtrjCqujlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc934bf-4c0e-4dd0-2c01-08d870b9f8f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 03:25:32.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnZV5Klu3cY4FdwaXOV5MamR9FQ2iwYYSpKuRnn1BBN9LbopoAk7TOAmgnlhvQ1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3167
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
Cc: Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

remove duplicate gfxhub v1.1 function set.
put function of gfxhub_v1_1_get_xgmi_info to gfxhub v1_0 function set.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c | 13 +------------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +---------
 4 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index fad887a66886..d83577b77a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "gfxhub_v1_0.h"
+#include "gfxhub_v1_1.h"
 
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
@@ -412,4 +413,5 @@ const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
 	.gart_disable = gfxhub_v1_0_gart_disable,
 	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
 	.init = gfxhub_v1_0_init,
+	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
index 1e24b6d51e41..c0ab71df0d90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c
@@ -21,7 +21,6 @@
  *
  */
 #include "amdgpu.h"
-#include "gfxhub_v1_0.h"
 #include "gfxhub_v1_1.h"
 
 #include "gc/gc_9_2_1_offset.h"
@@ -29,7 +28,7 @@
 
 #include "soc15_common.h"
 
-static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
+int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 {
 	u32 xgmi_lfb_cntl = RREG32_SOC15(GC, 0, mmMC_VM_XGMI_LFB_CNTL);
 	u32 max_region =
@@ -67,13 +66,3 @@ static int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev)
 
 	return 0;
 }
-
-const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs = {
-	.get_mc_fb_offset = gfxhub_v1_0_get_mc_fb_offset,
-	.setup_vm_pt_regs = gfxhub_v1_0_setup_vm_pt_regs,
-	.gart_enable = gfxhub_v1_0_gart_enable,
-	.gart_disable = gfxhub_v1_0_gart_disable,
-	.set_fault_enable_default = gfxhub_v1_0_set_fault_enable_default,
-	.init = gfxhub_v1_0_init,
-	.get_xgmi_info = gfxhub_v1_1_get_xgmi_info,
-};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
index ae5759ffbee3..d753cf28a0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.h
@@ -24,6 +24,6 @@
 #ifndef __GFXHUB_V1_1_H__
 #define __GFXHUB_V1_1_H__
 
-extern const struct amdgpu_gfxhub_funcs gfxhub_v1_1_funcs;
+int gfxhub_v1_1_get_xgmi_info(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6e9de02d5455..33c34cae9f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1166,15 +1166,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
 
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-	case CHIP_VEGA20:
-		adev->gfxhub.funcs = &gfxhub_v1_1_funcs;
-		break;
-	default:
-		adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
-		break;
-	}
+	adev->gfxhub.funcs = &gfxhub_v1_0_funcs;
 }
 
 static int gmc_v9_0_early_init(void *handle)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
