Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B0C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 05:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBC16101D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 05:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBC16101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2176E947;
	Wed, 21 Apr 2021 05:50:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C596E947
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 05:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lh8dwgcYnyAtJ0atczd2Yjn5uhtXm3GxiKfHe7nNZnxifkP5aNsCwBUgyOmnBW48NxaSGbzmUWiOWueMzRAr3g0obLPtEsfZbVCiqoL9pl1T2bKUFRVB8L/ZkpMyrBJ720JJ4lQV6ru2TRivH0HzHDYjSLKO6QTXeU5C/9IPSD2+8MKgTSlmlsYKzUQhVJ1mfC7QQwE4ZrKnBeRJKq7uOqoivqFDaDsPPo0y2uWRyr0EReBftIa4z6STKeet7VKMR1Ws/VYC9ZKF3ZZrNYQoRKZEigh2fDqdDvVG1FDh1OMAmshLpu5O108Y6IMuP2vxEKfXcoc4WziDwNDN/eWvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaDEM7FHLcJXsR774ZdaOAvomxW72cZosh781DfeBLw=;
 b=LPLZUbqxOvq57kLAH3ouvdD68x7ecp3bG6moc7YfgryjqGMI6l8+VbZV9xzqB8Tjir3CtGGctbfyQbzQ2TJaGsnY/RX0Sb+Ilp70MFvOuv9QxI5gTSm8KqOCviSu2YkZhGQBrtgDLHbfglLq6cKLYA1kX8mZW3HSPKd/ueOXaL+o/nOMT/DG8xlkxhbr8PJ3veuY7jQx3cZgB8VtqBClAJNlrE3WOZqBs4VN4zVBr0KR3Xjh4bEgvlIrEsBxnWle3KYr+GZ082WDHgeIzuhvZ1X83nq9qflplezCIPT4Ej1M4QRX5OztuMHZHnGu3itisFZex8C5yXIqghCMhWXa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaDEM7FHLcJXsR774ZdaOAvomxW72cZosh781DfeBLw=;
 b=vKrZuMAZIYFdf6Sz13bonw+NJPK7SanBP/eMwylCc1iLN+j8UNgs802uznQxYVtAnDPDaRZHwe8yTpK1gBcbEoANmTJzh3Jpjg/oEYu4JBh4LH6w2yFbfSTRjo2+cb1RQmlitLMzKVGbVU54Hof/Qol8riqB6zkUjG03JfEw6Xw=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 05:50:50 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::18) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 05:50:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 05:50:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 00:50:49 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Apr 2021 00:50:47 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: refine gprs init shaders to check coverage
Date: Wed, 21 Apr 2021 13:50:37 +0800
Message-ID: <20210421055037.17849-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf33c85-90ca-4a3c-77df-08d904896ad5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:
X-Microsoft-Antispam-PRVS: <DM6PR12MB487908FA9CF0A18744C584F6ED479@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRmeVK++WszoAAKJ0Qb1eHBQcrMXC1qdw1MZvDRv/FiRUWqquD+/uIX7x7jqBmXeT20mP0kqFVXrsqTiUypJHygP28O5wQsvC/JMFFnDktHCUlYETXR1oca3gW4m9Pwb3UW29g16vMEsrRNmSvDUjbwbA9ABlAldjAp8j/EilU6mwDF3prJh69n7Mp03W7wm5cfzAobQBE0DIb5Ik/IFvtYTcP8rX2JBcMMZI7WzRzURNVLyL2b2KRN+mAAZjHl4RhfKT0lu9vC9tRUn5WtsCApm/HtqegcxXY1R7aTwGocUmLcEIezVbMIVVP9MvcRpS3dwF8z0LHE+t23Z/W2MoZDce8u2d+V/tBle1iwkGjIsFgRxP3uREfvW6c+8cE+2JI0Vojw798e3t9OCvAGpVXOmaDLr8pEgPauXtTxQIVBgq0fQ05oQrSKCXGEI0aBEr1PrrPLXleV8zC0kj7Y9gN3oVdK3lhneuFPg/7z85ADgQp3r3quGx9ZSLLJ5uj8SnF5g6KESYTfs+m3Utv/yYpOv08zWTvyi4ST1+SG1MnVmooKEKCgXxRWzugJAnmxGXA7hBh4W3dFsMNvVUnqTfT2zL3KJr6Y1FdplSin+ACVX/Z+wkeZdz+27gCR0A6FeeHbYT+3da3jFQBLUcDnANckSbiB4Y5KqVYD7dx1rxUHBP4gomgGM3y2h5Yok5uAErt9UyJoQQWbtMAb5yGPFbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(356005)(478600001)(6636002)(26005)(86362001)(426003)(2906002)(2616005)(316002)(70206006)(186003)(83380400001)(81166007)(36756003)(6666004)(110136005)(8676002)(82310400003)(82740400003)(1076003)(4326008)(7696005)(336012)(36860700001)(70586007)(8936002)(47076005)(30864003)(5660300002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 05:50:49.8611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf33c85-90ca-4a3c-77df-08d904896ad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add codes to check whether all SIMDs are covered, make sure that all
GPRs are initialized.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9889bd495ba5..9e629f239288 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4656,8 +4656,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!ring->sched.ready)
 		return 0;
 
-	if (adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN) {
+	if (adev->asic_type == CHIP_ARCTURUS) {
 		vgpr_init_shader_ptr = vgpr_init_compute_shader_arcturus;
 		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader_arcturus);
 		vgpr_init_regs_ptr = vgpr_init_regs_arcturus;
@@ -4924,7 +4923,11 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	}
 
 	/* requires IBs so do in late init after IB pool is initialized */
-	r = gfx_v9_0_do_edc_gpr_workarounds(adev);
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		r = gfx_v9_4_2_do_edc_gpr_workarounds(adev);
+	else
+		r = gfx_v9_0_do_edc_gpr_workarounds(adev);
+
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 9ca76a3ac38c..798c0e178201 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "soc15.h"
+#include "soc15d.h"
 
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
@@ -79,6 +80,377 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCI_CNTL_3, 0xff, 0x20),
 };
 
+static const u32 vgpr_init_compute_shader_aldebaran[] = {
+	0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,
+	0x81070407, 0x8e078207, 0xbe88008f, 0xc0410200, 0x00000007, 0xd3d94000,
+	0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,
+	0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,
+	0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,
+	0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,
+	0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,
+	0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,
+	0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,
+	0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,
+	0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,
+	0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,
+	0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,
+	0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,
+	0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,
+	0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,
+	0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,
+	0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,
+	0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,
+	0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,
+	0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,
+	0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,
+	0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,
+	0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,
+	0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,
+	0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,
+	0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,
+	0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,
+	0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,
+	0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,
+	0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,
+	0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,
+	0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,
+	0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,
+	0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,
+	0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,
+	0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,
+	0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,
+	0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,
+	0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,
+	0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,
+	0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,
+	0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,
+	0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,
+	0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,
+	0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,
+	0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,
+	0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,
+	0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,
+	0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,
+	0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,
+	0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,
+	0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,
+	0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,
+	0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,
+	0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,
+	0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,
+	0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,
+	0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,
+	0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,
+	0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,
+	0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,
+	0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,
+	0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,
+	0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,
+	0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,
+	0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,
+	0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,
+	0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,
+	0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,
+	0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,
+	0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,
+	0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,
+	0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,
+	0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,
+	0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,
+	0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,
+	0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,
+	0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,
+	0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,
+	0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,
+	0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,
+	0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,
+	0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,
+	0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,
+	0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,
+	0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,
+	0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,
+	0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,
+	0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,
+	0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xb88b0904, 0xb78b4000,
+	0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,
+	0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,
+	0xbf810000,
+};
+
+const struct soc15_reg_entry vgpr_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 4 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xbf },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400004 },  /* 64KB LDS */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
+};
+
+static const u32 sgpr_init_compute_shader_aldebaran[] = {
+	0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,
+	0x81070407, 0x8e078207, 0xbefc0006, 0xbf800000, 0xbf900001, 0xbe88008f,
+	0xc0410200, 0x00000007, 0xb07c0000, 0xbe8000ff, 0x0000005f, 0xbee50080,
+	0xbe812c65, 0xbe822c65, 0xbe832c65, 0xbe842c65, 0xbe852c65, 0xb77c0005,
+	0x80808500, 0xbf84fff8, 0xbe800080, 0xbf810000,
+};
+
+static const struct soc15_reg_entry sgpr1_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS): SGPRS[9:6] VGPRS[5:0] */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x000000ff },
+};
+
+static const struct soc15_reg_entry sgpr2_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS) */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0x0000ff00 },
+};
+
+static int gfx_v9_4_2_check_gprs_init_coverage(struct amdgpu_device *adev,
+					       uint32_t *wb)
+{
+	uint32_t se_id, cu_id, simd_id;
+	uint32_t simd_cnt = 0;
+	uint32_t se_offset, cu_offset, data;
+
+	for (se_id = 0; se_id < adev->gfx.config.max_shader_engines; se_id++) {
+		se_offset = se_id * 16 * 4;
+		for (cu_id = 0; cu_id < 16; cu_id++) {
+			cu_offset = cu_id * 4;
+			for (simd_id = 0; simd_id < 4; simd_id++) {
+				data = wb[se_offset + cu_offset + simd_id];
+				if (data == 0xF)
+					simd_cnt++;
+			}
+		}
+	}
+
+	if (adev->gfx.cu_info.number * 4 == simd_cnt)
+		return 0;
+
+	dev_warn(adev->dev, "SIMD Count: %d, %d\n",
+		 adev->gfx.cu_info.number * 4, simd_cnt);
+
+	for (se_id = 0; se_id < adev->gfx.config.max_shader_engines; se_id++) {
+		se_offset = se_id * 16 * 4;
+		for (cu_id = 0; cu_id < 16; cu_id++) {
+			cu_offset = cu_id * 4;
+			for (simd_id = 0; simd_id < 4; simd_id++) {
+				data = wb[se_offset + cu_offset + simd_id];
+				if (data != 0xF)
+					dev_warn(adev->dev, "SE[%d]CU[%d]SIMD[%d]: isn't inited\n",
+						se_id, cu_id, simd_id);
+			}
+		}
+	}
+
+	return -EFAULT;
+}
+
+static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
+				 const uint32_t *shader_ptr, uint32_t shader_size,
+				 const struct soc15_reg_entry *init_regs, uint32_t regs_size,
+				 uint32_t compute_dim_x, u64 wb_gpu_addr)
+{
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+	struct amdgpu_ib ib;
+	struct dma_fence *f = NULL;
+	int r, i;
+	uint32_t total_size, shader_offset;
+	u64 gpu_addr;
+
+	total_size = (regs_size * 3 + 4 + 4 + 5 + 2) * 4;
+	total_size = ALIGN(total_size, 256);
+	shader_offset = total_size;
+	total_size += ALIGN(shader_size, 256);
+
+	/* allocate an indirect buffer to put the commands in */
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, total_size,
+					AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r) {
+		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		return r;
+	}
+
+	/* load the compute shaders */
+	for (i = 0; i < shader_size/sizeof(u32); i++)
+		ib.ptr[i + (shader_offset / 4)] = shader_ptr[i];
+
+	/* init the ib length to 0 */
+	ib.length_dw = 0;
+
+	/* write the register state for the compute dispatch */
+	for (i = 0; i < regs_size; i++) {
+		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(init_regs[i])
+								- PACKET3_SET_SH_REG_START;
+		ib.ptr[ib.length_dw++] = init_regs[i].reg_value;
+	}
+
+	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
+	gpu_addr = (ib.gpu_addr + (u64)shader_offset) >> 8;
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)
+							- PACKET3_SET_SH_REG_START;
+	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
+	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+
+	/* write the wb buffer address */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0)
+							- PACKET3_SET_SH_REG_START;
+	ib.ptr[ib.length_dw++] = lower_32_bits(wb_gpu_addr);
+	ib.ptr[ib.length_dw++] = upper_32_bits(wb_gpu_addr);
+
+	/* write dispatch packet */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib.ptr[ib.length_dw++] = compute_dim_x; /* x */
+	ib.ptr[ib.length_dw++] = 1; /* y */
+	ib.ptr[ib.length_dw++] = 1; /* z */
+	ib.ptr[ib.length_dw++] =
+		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+
+	/* write CS partial flush packet */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+
+	/* shedule the ib on the ring */
+	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	if (r) {
+		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		goto fail;
+	}
+
+	/* wait for the GPU to finish processing the IB */
+	r = dma_fence_wait(f, false);
+	if (r) {
+		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		goto fail;
+	}
+fail:
+	amdgpu_ib_free(adev, &ib, NULL);
+	dma_fence_put(f);
+
+	return r;
+}
+
+int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+	int r;
+	int compute_dim_x = adev->gfx.config.max_shader_engines *
+			    adev->gfx.config.max_cu_per_sh *
+			    adev->gfx.config.max_sh_per_se;
+	int sgpr_work_group_size = 5;
+	/* CU_ID: 0~15, SIMD_ID: 0~3 */
+	int wb_size = adev->gfx.config.max_shader_engines * 16 * 4;
+	struct amdgpu_ib ib;
+
+	/* only support when RAS is enabled */
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return 0;
+
+	/* bail if the compute ring is not ready */
+	if (!ring->sched.ready)
+		return 0;
+
+	/* allocate an indirect buffer to put the commands in */
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, wb_size * sizeof(uint32_t),
+			  AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r) {
+		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		return r;
+	}
+
+	memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
+	r = gfx_v9_4_2_run_shader(adev, vgpr_init_compute_shader_aldebaran,
+				  sizeof(vgpr_init_compute_shader_aldebaran),
+				  vgpr_init_regs_aldebaran,
+				  ARRAY_SIZE(vgpr_init_regs_aldebaran),
+				  compute_dim_x * 2, ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init VGPRS: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
+	if (r) {
+		dev_err(adev->dev, "Init VGPRS: failed to cover all CUs\n");
+		goto failed;
+	} else {
+		dev_info(adev->dev, "Init VGPRS Successfully\n");
+	}
+
+	memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
+	r = gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,
+				  sizeof(sgpr_init_compute_shader_aldebaran),
+				  sgpr1_init_regs_aldebaran,
+				  ARRAY_SIZE(sgpr1_init_regs_aldebaran),
+				  compute_dim_x / 2 * sgpr_work_group_size,
+				  ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init SGPRS Part1: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,
+				  sizeof(sgpr_init_compute_shader_aldebaran),
+				  sgpr2_init_regs_aldebaran,
+				  ARRAY_SIZE(sgpr2_init_regs_aldebaran),
+				  compute_dim_x / 2 * sgpr_work_group_size,
+				  ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init SGPRS Part2: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
+	if (r)
+		dev_err(adev->dev,
+			"Init SGPRS Part2: failed to cover all CUs\n");
+	else
+		dev_info(adev->dev, "Init SGPRS Successfully\n");
+
+failed:
+	amdgpu_ib_free(adev, &ib, NULL);
+	return r;
+}
+
 static void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev);
 static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev);
 
@@ -808,8 +1180,9 @@ static struct gfx_v9_4_2_utc_block gfx_v9_4_2_utc_blocks[] = {
 	  REG_SET_FIELD(0, ATC_L2_CACHE_4K_DSM_CNTL, WRITE_COUNTERS, 1) },
 };
 
-static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs =
-	{ SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
+static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs = {
+	SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16
+};
 
 static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
 					  const struct soc15_reg_entry *reg,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 81c5833b6b9f..6db1f88509af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -29,6 +29,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,
 void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
+int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
 extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
