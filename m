Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C0C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B73110F36A;
	Fri, 21 Aug 2026 16:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vch7Sytc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E590D10F36A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBsNZWEq1epvfid3TOBrKgIih0l/HbQq7U3BXG+s14cgBAlUCob6jmvTGpfDIQ5OXopIoeYwoiHG5C3qJxXAzb6ZyT87cvCKXj/K2dN2RA8dDIBjuD2y6w0bNwlsMvqbQ+pGeYaC/8HFE+fZjNjmaYtqQzZjW3VbcxwkSMKxR4HPUMrBkxTizG9ZTbWU15mKgUF7hHKYjs4t0MwF7G5v6mHl1VUmjDe+TCkORooNATuc315aJ5bplxE3jLM7A0+9UM1ZUW4TiahlaU7uAbx4+aYarwnsrNClm+WTLzGvRLUyyxW/iRJv0NPE+0CXY3/wyHJyyQGHhvLRpNV8IHOjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+HirwFPv66H/IQCkSd5isOfwDO+UFoPic6/bXWRB7s=;
 b=Sa1SwlQngm8veRy3p39y6X/UwRgyL0WTCy0x4R3OKR/0TDcCEfDm29AGEDhDU/u0Cl0RhRJIEVxwcVOH1VJ3h1kfPBIVD7aOXmWexSDzYQkQXeND15nOQTQarRb6d2vr3FFy15GKjhckNBHf7bCMf/H2pQX2pvMBmMDAKK6wuD/R+v0tZCUNZjaEKN4wq2rveneurdVsHKlPewWVHS13rGB6QF8yiqTfZQNKrGhkFUVoohA8VJJ2sl0jjHooyG/PUxTpJxQLNfSFb8FwD9JDnt3HEImR+k5ShF1/u7cEz0J1rX8L3YT6ARzTgrtcyvmzJQoObEo5mIWDbknx9KSskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+HirwFPv66H/IQCkSd5isOfwDO+UFoPic6/bXWRB7s=;
 b=vch7SytcE9kRMwmvgsTe//OK5Ozm38RXpNb5w0aH96KiW8QZsxdwSIIU4SgQHvgPff8Gp+502Ovze+/2Uf39Is7aVD7K10y9N/oY5i3i7opUZO6Nfq2Thhr+JdJ1wa2kmZv/FWJdQ1C58007eWIL1d6M5k6ujnQ4n+w61mm9RXk=
Received: from CY8PR11CA0045.namprd11.prod.outlook.com (2603:10b6:930:4a::28)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:26 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::49) by CY8PR11CA0045.outlook.office365.com
 (2603:10b6:930:4a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Horatio Zhang
 <hongkun.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/13] drm/amdgpu: Report vm fault status HI32 when avaialble
Date: Fri, 21 Aug 2026 12:09:56 -0400
Message-ID: <20260821160958.753063-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: a008a583-6a40-4fdf-ebba-08deff9eb18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sfzkku7ogVFFoJlIUXyqsK+pLBhCktRgyjVFBJUN2CpYn+EcZlObAK/b9f/O0Y81+LiLVoGb3efPrV5NekI4p6tNJ51nDXFOyKEUtXA1hgSnm8RZH9BKlCoY2LzykZ9ZSHgKTp8uo8R1Zzzo0nBL3DbMSHesWD6XaOFdekDe98T0thonoImByZCV/7bwVKNWQsmSxFT+E2gHtJhDmszqHHMzC/HLrehHLmJi/STDVp2NxR0Q9nFFyTD95PVtz4HeQagXR7VEdh/+jlyk9JOLwwA5eqXJpcLTfs4GKIiU7o3uqSM892VAppj6tIua4SyZlKkt0F0pTQyGlHVbWdi9QSSACUKmoyLKHfcOLrufBZU7jFFlREamC0Lp4NEI7QbBl8nG+po4HiyOJy1SDLPho/8YlWlIT5eB8/zX0CwBTNVENqbdJqZhVeKtTQKdkKkY0P+fS9NAGZmgs8qruO60kv8HSrxc8Iysw+j99t7BGEDV0Z9cj3cQY7s+HCMym0l9JhVVnRyL113Ari/jnJ0XAikCVnRHF8IjA86Gta/QArhA52WCsP5DHE3InCm0fa6MaA3s6cHvM5S7MBRZBZRCM3wITzVhFZvvB6OnhvUD+JhWRitZh8AtKqgihlOVDYzVAlcbX4EICEbeLzIk/GlzNJevDdyGYQH5DahdqR/zrETBwEmbJ/Ku6K4RV8NLzpo+MUNgVVUEGyR84LrupMn4jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /VD85gKDgIG5jS6a4AFyoQnqB05B0EjNLayU2K6vpJgir+WGwbWYvTuJjovcJus5AHQMTt+BwtVLetvGUjNT0qFZopaI3sbV8WMNp+xTcOiXBu7NX3shFpWwlu5XSraxqd3VExEkctS5HAOrMbG626bwF4F0f2OZLaqtD4SORle6M95PPoncF8HY1yUsXK4DQZMU3LOB+jqBJhM6TwpzzVLbqkfhD6RqPc0YtpQSx6yUbuLWylDf9tufr8Xda2bdWVq3J2FLdYGQDDUTImds49vXvD1F//UzgMziB5LhLaoFFba2qIdw9iVYRdTtX9VMnBEDx0pDVJdlb7HJiEitvRi/kHHqJ63L24H08BPxPJHhu7X9M8EP0zqxQhN1jNpQ/xgS+6dTMPRM+iwSaDuFj7Rxm1e4aw0IRD083yZVMqiiNFQxu7zItjBTA+FVtE1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:16.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a008a583-6a40-4fdf-ebba-08deff9eb18c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

VM fault status is 64 bits on gfxhub v12_1 and
mmhub v4_2, with fields such as FED located in the
upper status register.

Add an optional HI32 fault status callback to help
identify FED status on gfxhub v12_1 and mmhub v4_2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Horatio Zhang <hongkun.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h   |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c    | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 20 +++++++++++++++++---
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c0884797dd544..cffd5ca3fc66b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -114,6 +114,8 @@ struct amdgpu_gmc_fault {
 struct amdgpu_vmhub_funcs {
 	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
 						 uint32_t status);
+	void (*print_l2_protection_fault_status_hi)(struct amdgpu_device *adev,
+						    uint32_t status);
 	uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
 };
 
@@ -125,6 +127,7 @@ struct amdgpu_vmhub {
 	uint32_t	vm_inv_eng0_ack;
 	uint32_t	vm_context0_cntl;
 	uint32_t	vm_l2_pro_fault_status;
+	uint32_t	vm_l2_pro_fault_status_hi;
 	uint32_t	vm_l2_pro_fault_cntl;
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 0d57c106f9d1c..1f7e57792d4dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -702,8 +702,18 @@ static const char *gfxhub_v12_1_client_ids[] = {
 	"PA"
 };
 
-/*TODO: l2 protection fault status is increased to 64bits.
- * some critical fields like FED are moved to STATUS_HI32 */
+static void
+gfxhub_v12_1_print_l2_protection_fault_status_hi(struct amdgpu_device *adev,
+						 uint32_t status)
+{
+	dev_err(adev->dev,
+		"GCVM_L2_PROTECTION_FAULT_STATUS_HI32:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t FED: 0x%lx\n",
+		REG_GET_FIELD(status,
+			      GCVM_L2_PROTECTION_FAULT_STATUS_HI32, FED));
+}
+
 static void gfxhub_v12_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
 							  uint32_t status)
 {
@@ -736,6 +746,8 @@ static void gfxhub_v12_1_print_l2_protection_fault_status(struct amdgpu_device *
 
 static const struct amdgpu_vmhub_funcs gfxhub_v12_1_vmhub_funcs = {
 	.print_l2_protection_fault_status = gfxhub_v12_1_print_l2_protection_fault_status,
+	.print_l2_protection_fault_status_hi =
+		gfxhub_v12_1_print_l2_protection_fault_status_hi,
 	.get_invalidate_req = gfxhub_v12_1_get_invalidate_req,
 };
 
@@ -765,10 +777,12 @@ static void gfxhub_v12_1_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 		hub->vm_context0_cntl =
 			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regGCVM_CONTEXT0_CNTL);
-		/* TODO: add a new member to accomandate additional fault status/cntl reg */
 		hub->vm_l2_pro_fault_status =
 			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regGCVM_L2_PROTECTION_FAULT_STATUS_LO32);
+		hub->vm_l2_pro_fault_status_hi =
+			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
+					 regGCVM_L2_PROTECTION_FAULT_STATUS_HI32);
 		hub->vm_l2_pro_fault_cntl =
 			SOC15_REG_OFFSET(GC, GET_INST(GC, i),
 				regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index e8e35d1b22765..b0962a14fdb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -128,7 +128,7 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	uint32_t cam_index = 0;
 	const char *hub_name;
 	int ret, xcc_id = 0;
-	uint32_t status = 0;
+	uint32_t status = 0, status_hi = 0;
 	const char *die_name;
 	char die_name_buf[32];
 	u64 addr;
@@ -243,11 +243,14 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 		RREG32(hub->vm_l2_pro_fault_status);
 
 	status = RREG32(hub->vm_l2_pro_fault_status);
+	if (hub->vmhub_funcs &&
+	    hub->vmhub_funcs->print_l2_protection_fault_status_hi)
+		status_hi = RREG32(hub->vm_l2_pro_fault_status_hi);
 
 	/* Only print L2 fault status if the status register could be read and
 	 * contains useful information
 	 */
-	if (!status)
+	if (!status && !status_hi)
 		return 0;
 
 	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
@@ -260,6 +263,9 @@ static int gmc_v12_1_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
+	if (hub->vmhub_funcs->print_l2_protection_fault_status_hi)
+		hub->vmhub_funcs->print_l2_protection_fault_status_hi(adev,
+								     status_hi);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 8bed4addba426..b2a3276750deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -732,8 +732,18 @@ static uint32_t mmhub_v4_2_0_get_invalidate_req(unsigned int vmid,
 	return req;
 }
 
-/*TODO: l2 protection fault status is increased to 64bits.
- * some critical fields like FED are moved to STATUS_HI32 */
+static void
+mmhub_v4_2_0_print_l2_protection_fault_status_hi(struct amdgpu_device *adev,
+						 uint32_t status)
+{
+	dev_err(adev->dev,
+		"MMVM_L2_PROTECTION_FAULT_STATUS_HI32:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t FED: 0x%lx\n",
+		REG_GET_FIELD(status,
+			      MMVM_L2_PROTECTION_FAULT_STATUS_HI32, FED));
+}
+
 static void
 mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 					      uint32_t status)
@@ -770,6 +780,8 @@ mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 static const struct amdgpu_vmhub_funcs mmhub_v4_2_0_vmhub_funcs = {
 	.print_l2_protection_fault_status = mmhub_v4_2_0_print_l2_protection_fault_status,
+	.print_l2_protection_fault_status_hi =
+		mmhub_v4_2_0_print_l2_protection_fault_status_hi,
 	.get_invalidate_req = mmhub_v4_2_0_get_invalidate_req,
 };
 
@@ -800,10 +812,12 @@ static void mmhub_v4_2_0_mid_init(struct amdgpu_device *adev,
 		hub->vm_context0_cntl =
 			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
 					 regMMVM_CONTEXT0_CNTL);
-		/* TODO: add a new member to accomandate additional fault status/cntl reg */
 		hub->vm_l2_pro_fault_status =
 			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
 					 regMMVM_L2_PROTECTION_FAULT_STATUS_LO32);
+		hub->vm_l2_pro_fault_status_hi =
+			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
+					 regMMVM_L2_PROTECTION_FAULT_STATUS_HI32);
 		hub->vm_l2_pro_fault_cntl =
 			SOC15_REG_OFFSET(MMHUB, GET_INST(MMHUB, i),
 					 regMMVM_L2_PROTECTION_FAULT_CNTL_LO32);
-- 
2.55.0

