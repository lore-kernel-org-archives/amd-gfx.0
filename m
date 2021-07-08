Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC6C07E95
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC5361CD7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 03:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC5361CD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C586E20C;
	Thu,  8 Jul 2021 03:28:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B556E20C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 03:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvzWVhqElRXrrDisuT9zce/oXmMBeykP+WReQE3Z4qFlQukubYYhdaivFi22bJC660+Jbnq876JcXGpCswXlsPynoKMq7gsW8L6Sal/iPbjip2q5dGSl7HUJLt/akdcc87Cw8+M9L9kWUZryAhVwzNeOuFc1Aw6Hm5STZglio9NDvn4WIumQiH7ZIHctrWitDgXRQ0EgeWyOIBYetDUxWYOffdv618OFMgcVA9hnKop8YU6m6gDpEG5jcOsjQX3c8gJIvpQx/mN3dhi9Lro786kL0IMWJPpBeKIfjcVqtIxaGwR7xXWxHJq5d6gPwBrN53Lw4EzFDm5oC3nH/DwkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBl9eVp9CqlNv132+3RRu6+lK304Ve3s5R8TWI6/uBY=;
 b=N6PTjfIumvNq13B7HcSiGlvA7fod+IVWEaqDItigVLAtdIT8X4V8PjRTrzxSR4ueS6zs+OaymJhFTfe2jY0uqsAiVGSBT2gVS5KWrvJtb+jow4DmR93olwqcWDXz6XWKHpBbgXWvTKwLUKOraYRh9FEDc+F9j4StMN1Mt1Xc7DBNcuAwNgKVrHX5wnSQmRHOjWKPPjvwjJS4i8Ow3jstRSsY1BXUBfBpxskS9bQQGiPkZJ7qr9pKD/ZaczQZm6N4ePEeqIQiq5833RtVuiXff8PdWXz7Zt8YsysudgeUXAa3vm1AbY4hBbzvwGvwz1aHk85O4J9HMLGnbdYN1wKWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBl9eVp9CqlNv132+3RRu6+lK304Ve3s5R8TWI6/uBY=;
 b=ghh10w6x0LHhV/r98Ae/tNwAanieK4hCyuj/pR39tu6Pm/665Yo0gxXQwoSkv4MhPnlfEhdI9Av70K9L/s4gCUYIx3XO/ocEKVOSNTTCPImMJSUL5kzq3O51DD1NgHmha3SGJ8D+65axHNLX0p4zqGnrwRbL6KeZq2y3braWTYg=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Thu, 8 Jul
 2021 03:28:31 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::85) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend
 Transport; Thu, 8 Jul 2021 03:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 03:28:30 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 22:28:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 20:28:30 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 7 Jul 2021 22:28:23 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: initialize umc ras function
Date: Thu, 8 Jul 2021 11:28:21 +0800
Message-ID: <20210708032821.23553-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7629e71-8b46-41e8-0fc0-08d941c07578
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42899B650870FB19769AD4E99A199@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gX+suXRVJsT2CwuGssw5YlEg14gpCRIGBV0x5kGDwCS/DshFAIoALVex0227hAKLbv33329c8SiLG3TR0J4Gfim9ktg0KtmYRHAcQ2U4AITqVcp0jk91SFSCuustoLbY4doWavcQ8zHdhLh41YywBIIVUl3Xbtke2VAZjoLEVbszoPhnNKlfoorjdtVZLHZpNP8+ZKbymNyMuYQH6XjOmb6YZJo4k8yXclCHE4TYb0edMiiBPlT4Gy0rBo+M6hki8aiey2jLVAGYJSJbCw6BZEB3lQEYV404KSriZMeyuaaIIqynVvWRVcV7Hf4cl95nsGdzNGsQsrJfsU4YOhp0X0H46mFUFpwDd3yP+W/cZszNRW9CktXDRyRirYmtlDQQq8rX7slP3XR/VdlGYuZErCItGBxfV/D7R8Qhp87JTau/aGc/D4DJinmr8JRRJHyyWOSN6zGkVg+NfxYSymI7Ly9FMPbOo7xeNoHFatMGmJLv1RL+rPk/QD7oroqeeVTSMm9LO5yvp3X4VBVXs0BaD/0DbAtFteJtPYw5f6JmpYKLDucIjuk6e1z8ClcXSDcZh1dJui9x1EhmpdWW8ZwBUsNnGd4aBq7ldb7TN8Me58xVqOjcGyZtaLmTzV1NW8gP1ybcjfGWY+Dt3h2N8fUqKOg7MLHuHOUwNp+BnOcegsUFNu8GS18q8nZVGaMzp2Ghzv5hGCaBBnO+6Cy6miaIsXsqI7e+I27guUU69iw6Vxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966006)(36840700001)(4326008)(83380400001)(1076003)(82740400003)(36860700001)(478600001)(26005)(81166007)(356005)(7696005)(36756003)(336012)(2906002)(54906003)(2616005)(5660300002)(186003)(86362001)(316002)(47076005)(6916009)(70206006)(70586007)(8676002)(82310400003)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 03:28:30.9435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7629e71-8b46-41e8-0fc0-08d941c07578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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
Cc: Alexander.Deucher@amd.com, "Stanley .
 Yang" <Stanley.Yang@amd.com>, John Clements <john.clements@amd.com>,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

support umc ras function initialization for aldebaran

Change-Id: I84155d4d3eaae86a8c1bd2331b1964946c47f6da
Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3332c9e0a4e2..42d7244573b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -53,6 +53,7 @@
 #include "mmhub_v1_7.h"
 #include "umc_v6_1.h"
 #include "umc_v6_0.h"
+#include "umc_v6_7.h"
 #include "hdp_v4_0.h"
 
 #include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
@@ -1163,6 +1164,18 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.channel_idx_tbl = &umc_v6_1_channel_idx_tbl[0][0];
 		adev->umc.ras_funcs = &umc_v6_1_ras_funcs;
 		break;
+	case CHIP_ALDEBARAN:
+		adev->umc.max_ras_err_cnt_per_query = UMC_V6_7_TOTAL_CHANNEL_NUM;
+		adev->umc.channel_inst_num = UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V6_7_UMC_INSTANCE_NUM;
+		adev->umc.channel_offs = UMC_V6_7_PER_CHANNEL_OFFSET;
+		if (!adev->gmc.xgmi.connected_to_cpu)
+			adev->umc.ras_funcs = &umc_v6_7_ras_funcs;
+		if (1 & adev->smuio.funcs->get_die_id(adev))
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_first[0][0];
+		else
+			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 3a8f787374c0..7da12110425c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -28,6 +28,21 @@
 #include "umc/umc_6_7_0_offset.h"
 #include "umc/umc_6_7_0_sh_mask.h"
 
+const uint32_t
+	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{28, 12, 6, 22},	{19, 3, 9, 25},
+		{20, 4, 30, 14},	{11, 27, 1, 17},
+		{24, 8, 2, 18},		{15, 31, 5, 21},
+		{16, 0, 26, 10},	{7, 23, 29, 13}
+};
+const uint32_t
+	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM] = {
+		{19, 3, 9, 25},		{28, 12, 6, 22},
+		{11, 27, 1, 17},	{20, 4, 30, 14},
+		{15, 31, 5, 21},	{24, 8, 2, 18},
+		{7, 23, 29, 13},	{16, 0, 26, 10}
+};
+
 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 					      uint32_t umc_inst,
 					      uint32_t ch_inst)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
index 4eb85f247e96..aa282687e0e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -32,6 +32,18 @@
 
 #define UMC_V6_7_INST_DIST	0x40000
 
+/* number of umc channel instance with memory map register access */
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+/* number of umc instance with memory map register access */
+#define UMC_V6_7_UMC_INSTANCE_NUM		8
+/* total channel instances in one umc block */
+#define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6_7_UMC_INSTANCE_NUM)
+/* UMC regiser per channel offset */
+#define UMC_V6_7_PER_CHANNEL_OFFSET		0x400
 extern const struct amdgpu_umc_ras_funcs umc_v6_7_ras_funcs;
+extern const uint32_t
+	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
+extern const uint32_t
+	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNEL_INSTANCE_NUM];
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
