Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A0ECA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 12:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBE310E083;
	Mon, 28 Sep 2026 12:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DigSoKP/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2B810E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvYmWhOKJCKDgmYfmcT+Ee4i07vp+ZL2xCWK45hUOTsV1fE0w0tslb9vM+AeOwm3BUUNaXwfQoT3pAaoBz08cNXx1VkLEV4HMwulFSLm3x/EO+Tr66iIWLhFV4nWFeGJZjs23RIn1st0mK1wjLC0SmwRclUbLIhKLnVRfBXPQn1Mucrh6kDVogm7IY6hPuPrOUOeJIgX50bSHT3b+rfoVeyJCY5fd7lD2NQPS/dLJDWPtWtZZnv4bfZGHJyLEBJtS5BSTtvkdieBG9N348JP+eVlohfOoMHWORV6lzE1sH1Vrr201ipMpDKCUDafbYtEn56quEFXcI2MVJ7USIf7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2Qvyysi2mswa8Pjls7ccK1TCiWNLoqJjQr+8+quxlY=;
 b=ssSQlTJc4Zho3L0SXb0apiZ4U49V+3KZpFzwqocX+VChLIV6ce9qfW5thOZ878OQNL/+y6haGJ6E8VFGZm0e4XCr/kANQuxJ7qVS+Br/yAjX0lMr0V0rUyppp4DtY0fWjhmlk9op7H5RjEiAgIsLeHlWfEzVtnyN62L8UFNFtHdO2U20uj9Dxa6PE9mGBlTs1not+J/pGXZMAwhXhl1yIR6GqKvmGsFFd3VhV9icUYK/8hd4Xv//brMvhLCiWeW/+s6AwCswp1+07PLUoZ402wneqYnggBSbfSIRrZMf4qaskma6KOUT31ygCCAS22r6EfBX7faelF1yJ8bM719lAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2Qvyysi2mswa8Pjls7ccK1TCiWNLoqJjQr+8+quxlY=;
 b=DigSoKP/UBBPpfRFcrXbBSfdKNmA0zIvRDG3Jrv7WERUQd3NShFgSkyVGu4XJ/Lu8VDZKEvfLW/cgqrJkbee0jemRp/gnCBNPyGXbVTYoA7GwBgqYvHQzy0JaB07zX6I9GaCGshizE2d6pcnlFwf7kUYgD8f1xTn0qTx16I7dHs=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:35:51 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::48) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon,
 28 Sep 2026 12:35:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 12:35:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 07:35:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add package type mapping for EAM
Date: Mon, 28 Sep 2026 18:05:32 +0530
Message-ID: <20260928123532.2885747-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: a643c669-7c2d-4c0c-622b-08df1d5d07c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|10067099003|260925022911599003|260925021911599003|11063799006|260925021311599003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: MmzkeVnre7eNqwhKLsDhCKiETkgxQ4vudD4NKKv8VtOm9Bz4HhP7KeoeNlmQxmuJeUnmBqRznrNiVZ04AT7X7NSRsw42c420Y7PmRROjdZcmwShb5TQdVKB/bin5kQF6asAoVNsFriOtG4L7HX8sIcs3Lx/t3ADZKTBPP/SE/HWW2bZuGLnTCl98HF6hOlQdB9hNNahSPNOc360aJ9j2kl6YVqHKNg+QCBf3ahP1AAxr6vs/YXk8eDIWyuCgXBZpfJHhhuoUYQx233oWmsQ53Le+ClJfVH01mt71OBEpM8f3A980SS0MwSA0DdTmeSHmNIQFPksY/DNdadDU4FTevMcZP+Ra/pzHISOu6cc1/78jHoD9UqjOl3k1icRQKH2CBhpKP5XjEa4VO8IzHJwwBZ9+2l49voG8NyHR0NuVemX8cmEZC7/OF/rc5eacXEr2RRPu1nrnNx34KjYx086YEgW3Cdfvd5u23TSNZwkWXgEBjqqg9yjUGyANNMcQK2U73v03zG++pzztHsCwTxEH92aF+QqDihBr1LAm9iDnXU8x9CluuXXYDAmXddb3XyHPqL7SBTIK25fpvhxo8Q+PeDuKq29V31hqOY/HYA7IQRDqGu6A5YN56dAcIZL/voNzd1leTKXgNG8JPvApUniA+d34qcaD2QKoW69kEbBRg9W0fOBruwQRrI82/Ic2T0x+5o23ZU1Kd0ObSdlW71Q1RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(10067099003)(260925022911599003)(260925021911599003)(11063799006)(260925021311599003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NWecOgfW1ZG/fFOF+we+LFyTk29twuDUIZsrbUKr74jGf/byNGEuCA/ceTDNN+IUJW4M5/XvGij1x+pljzGQs60pMUUZh40Tahc4wVFYNabH6EPn55W4fUEDsyMEYynTkAPamKMtW9vC5j5c7nHAUFsol3ZvpJYj+8sq/kqhB8b1YJJa1jDG7nFc7o1XnNdw1LwFxva/n3WMCp/G1S1uAka1dlId/+AtQh2jVFUEeMTI6IlQ/sDGSgFzNusZMhLpPULzqnmywrj2msZbEPaVYq5UzjT5+IZjz7rHy5JbJc5c8WMIICvtNOvusejmnJqTBNaq9HhensWA32oSwX7phJLacVR95iI3a6mzMaa6vjLlVS0aJTAa9ERMZ/O76ngUV1p3qSzW+FPMKM+Qs+YtkkvKr+6b5ru0Om761kPTqghxTphH2O3wQPzYyzeA2Rr8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:35:50.8449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a643c669-7c2d-4c0c-622b-08df1d5d07c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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

Package Type BB uses EAM design.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4762944969b0..87829747d7a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -334,6 +334,7 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
  *
  * - "cem"		- PCIE CEM card
  * - "oam"		- Open Compute Accelerator Module
+ * - "eam"		- Enhanced Accelerator Module
  * - "unknown"	- Not known
  *
  */
@@ -357,6 +358,9 @@ static ssize_t amdgpu_device_get_board_info(struct device *dev,
 	case AMDGPU_PKG_TYPE_OAM:
 		pkg = "oam";
 		break;
+	case AMDGPU_PKG_TYPE_BB:
+		pkg = "eam";
+		break;
 	default:
 		pkg = "unknown";
 		break;
-- 
2.49.0

