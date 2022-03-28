Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57469C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D860D10E5ED;
	Mon, 28 Mar 2022 06:25:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA3D10E5ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfTP0fR1CEsJqSLoOKMbIVzghmRLjXIXToZaWjMofqMI0Z3r0Y7lCLLTRw2JESEleC5Zd6UvWR2/VA9EAjquTtKFWgWVZRcKDLhnOjnR8+4StoY76NhkmsCVgvG3JIjKyirflVqrB0HSRGai9VBN8FbRh+9+IsmmNq0KFyDXWhB8AH/bANRCym0rMCxxM/aOuFxuFPC57MYEBwDbkx2bGOy3cRI0h9MNXoMnjZITsGmuBYwIqAXE8tqKr1xTK1SQ8qZCrPqVgL+D4ffjYKk38oBBxE+vzB2sybHOiB04700KG8M8GCB+c7SJr5P5HqPS1scO3a8xfaWbhJ/C5qsAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQ0Twue+f0K1KIvKQlEjUlDOwwvZ+CwpHsOFZrTQkPM=;
 b=lBTQzH71xbU+KBO0me0LZh63hSkpiAWHHh4uzY7U6vUE35CzLDEpZ7m+aTUbN2pVrknY7cFNWYd7CgCF3TbLe1XKDkKVkz548jZqz8gJ5f7RFybgOZtD+VOyLRh/v3ZNJaltwNVKVRB6KrRqdpBXL5J69P/EbunV21qNEDetdx0Dvh7BgT7YzLaSkViXekaJfXMdXrd7di0rxM+VzBXOneRVkS1y99EFY7IWeDvPf1UAOn0WollqAOjBpxwU4TgcPI9lVhoVL+C/PDHQIkqYYsXSkawS5e6nqjRzEcMj/fHUiYDUux5ggsmIzGGmJ48xUYIcIeI0n1jsf3IgvkZfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQ0Twue+f0K1KIvKQlEjUlDOwwvZ+CwpHsOFZrTQkPM=;
 b=Ta5pi9NVt56xKpxWfNyAnJP0miyKKUlxcxy2hmFsXHEhiwder4NEWIZl+i3tT0ewQgL2513bdgqLAUZoH0b7mTxbKZ8XO9I783yaIHwOk/N49lwuK7hgmUi+i8xicebIE3I63ICgYj8t3RJ+qe/HHizLFmB+1NbXyGI52DBmjGE=
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 06:25:24 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::ee) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:25:23 +0000
Received: from zafar-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 01:25:20 -0500
From: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 6/6] drm/amdgpu/jpeg: jpeg ras error query support
Date: Mon, 28 Mar 2022 14:24:53 +0800
Message-ID: <20220328062453.4156191-7-Mohammadzafar.ziya@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a56bafe-63f3-4ccd-8019-08da1083bdea
X-MS-TrafficTypeDiagnostic: CY4PR12MB1496:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14963F482E7B521618773258981D9@CY4PR12MB1496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AhhzWFRmEjX4JkaYNeZ3aZSafJnuqvrBt0TWncQyRPSMd6Imr86FFE6hX5hDSYPwL1wXP0my10el5Zcd+U098x9up66Nh5R2yCLFL9cMWDqbuu/HcaEpcpevg3Xohq+Ot3p3ihWlWA6mXDXoXSfKOPKUKw62tuEg4X/gpbuZjdTMqXnKYn8a6H+yFPJdtjEXholl6dOqwN03UnQajUrBlKeEvscWOnOxHU3hBHUq2R9uS07vB4qHS6U11Jxn/1URN4B2cxWJSXcJvHowU67J/Vv5X1u28+59jFBLV7hShUaDTyA+M10MY9NAqL5m+OjJJEyLoWI1LEmQDWrqqR8tgilq8GiZoOLdpRLsXubkvR1WOT81qP58AvEFH7j0jhEFlc5ip9hANMdTcd260SvYWL7NN2MH2HN0EoBgq90+zaGAOu4bmiip/d6X9XwBdgJuStoAGWWIGxrMKX9gXq38EEtStPCB9NO/z60mYCxtJyGJ4bllMm1soowH+YdqRDSU6DAe1JW+XwZb0US+hCBA2jNkQyjQGqG4Y9R/UuWlzEI0+TYCIBXWUJPGsR93UmSlpWDYHqLfji+TDsUwyVkWyo+He+EC+/LL6PamOMzTYv2y5lMcB4+8FmFFHFPhMjHR/qlqf68juTxywCZv4vKy4Y9CzNesxWeSFNt+ZEv0OoknZ+j6u3EUgb8D83R8I53ZpldYX7DfeU3U5XsK3R4VNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(6916009)(8676002)(40460700003)(36860700001)(47076005)(81166007)(316002)(54906003)(7696005)(86362001)(2906002)(356005)(4326008)(82310400004)(2616005)(336012)(426003)(186003)(26005)(1076003)(16526019)(508600001)(5660300002)(8936002)(6666004)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:25:23.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a56bafe-63f3-4ccd-8019-08da1083bdea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1496
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
Cc: Tao.Zhou1@amd.com, lijo.lazar@amd.com,
 Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS error query support addition for JPEG 2.6

V2: removed unused options and corrected comment format.
Moved register definition to header file.

V3: poison query status check added.
Removed the error query support

V4: Return statement refactored.

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 74 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h |  7 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a29c86617fb5..4f2de9c31d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -26,6 +26,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "jpeg_v2_0.h"
+#include "jpeg_v2_5.h"
 
 #include "vcn/vcn_2_5_offset.h"
 #include "vcn/vcn_2_5_sh_mask.h"
@@ -39,6 +40,7 @@ static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_5_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
+static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
 static int amdgpu_ih_clientid_jpeg[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -70,6 +72,7 @@ static int jpeg_v2_5_early_init(void *handle)
 
 	jpeg_v2_5_set_dec_ring_funcs(adev);
 	jpeg_v2_5_set_irq_funcs(adev);
+	jpeg_v2_5_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -730,3 +733,74 @@ const struct amdgpu_ip_block_version jpeg_v2_6_ip_block =
 		.rev = 0,
 		.funcs = &jpeg_v2_6_ip_funcs,
 };
+
+static uint32_t jpeg_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
+		uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_JPEG_V2_6_JPEG0:
+		reg_value = RREG32_SOC15(JPEG, instance, mmUVD_RAS_JPEG0_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG0_STATUS, POISONED_PF);
+		break;
+	case AMDGPU_JPEG_V2_6_JPEG1:
+		reg_value = RREG32_SOC15(JPEG, instance, mmUVD_RAS_JPEG1_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_JPEG1_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in JPEG%d sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool jpeg_v2_6_query_ras_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst = 0, sub = 0, poison_stat = 0;
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; inst++)
+		for (sub = 0; sub < AMDGPU_JPEG_V2_6_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			jpeg_v2_6_query_poison_by_instance(adev, inst, sub);
+
+	return poison_stat ? true : false;
+}
+
+const struct amdgpu_ras_block_hw_ops jpeg_v2_6_ras_hw_ops = {
+	.query_poison_status = jpeg_v2_6_query_ras_poison_status,
+};
+
+static struct amdgpu_jpeg_ras jpeg_v2_6_ras = {
+	.ras_block = {
+		.hw_ops = &jpeg_v2_6_ras_hw_ops,
+	},
+};
+
+static void jpeg_v2_5_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[JPEG_HWIP][0]) {
+	case IP_VERSION(2, 6, 0):
+		adev->jpeg.ras = &jpeg_v2_6_ras;
+		break;
+	default:
+		break;
+	}
+
+	if (adev->jpeg.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->jpeg.ras->ras_block);
+
+		strcpy(adev->jpeg.ras->ras_block.ras_comm.name, "jpeg");
+		adev->jpeg.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__JPEG;
+		adev->jpeg.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+		adev->jpeg.ras_if = &adev->jpeg.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->jpeg.ras->ras_block.ras_late_init)
+			adev->jpeg.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
index 3b0aa29b9879..1e858c6cdf13 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h
@@ -24,6 +24,13 @@
 #ifndef __JPEG_V2_5_H__
 #define __JPEG_V2_5_H__
 
+enum amdgpu_jpeg_v2_6_sub_block {
+	AMDGPU_JPEG_V2_6_JPEG0 = 0,
+	AMDGPU_JPEG_V2_6_JPEG1,
+
+	AMDGPU_JPEG_V2_6_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version jpeg_v2_5_ip_block;
 extern const struct amdgpu_ip_block_version jpeg_v2_6_ip_block;
 
-- 
2.25.1

