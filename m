Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBACCD116F8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6015A10E366;
	Mon,  1 Dec 2025 10:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSp9LdZk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD1C10E365
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz9XjeS2HTTQdGvkv2oSKmPwttTdLJmePr978vimGcnIVCReCxps6tJu13kR/XiMLMExrPau/Iv83orcZe4PdHHE+XoWICHB13XOvmfBwBf7+iuuump5Pjmnq4FKhwGwXaEo48KxQw1d7cIgKoZYxyW9ZoRRj5Qsoegbin+oMqd/e9y16O4Hhu5/0H0zlNB0SJ2c4MxLA3k1m4V93LvjrqEjzgjlguBXMnr2Edcu3Zc4LOyKEBdLhn+EbLRFgxbDoq+rLfgDTcQH97TsuNZldWrHzQQmEAC4hhSwPu3dqxJvcZ6p0L9NI2yPybgacOJAM5NLU4dYasVfaSmlfY8JSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23/idteWaZt7Y+8d2v+pzUHMOI5/m5hIdm3PTxK+u3k=;
 b=BXfMbktgAYs6pG+cqu+69oq0uT2ELnuwZneBXb8PzoNbTjXHKggqwdS3751yoVcDFvuJN5ANifblHdJiC5lfzpD3fZOvpYkex4NTBgzDbtYspnNzML/uMPT1yZaBmD56oO/5aMcCNcXtV6fyvsXuGzt+XEYwToBaJ4Ye+XjHzfxHiK5uZGBDeplQgczfyECFThtTB8R+wkvB0ujD+JT6EYbsuQj4+QXbHpdO1d0APnjfhfdl49fX+KO8n3QrzqhL6aiEfLFcVb7uXUQur6mVAyx3+Ja/HpIzueZUEjf+tHIc1qj2GVtRpeEsl336Xt8iCxwWJJf1gZ3dztdAZG1q6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23/idteWaZt7Y+8d2v+pzUHMOI5/m5hIdm3PTxK+u3k=;
 b=pSp9LdZk56wakH35GScW3Xk0A07SfU5qxqG8gEtSNGOSc6cCuva2oURypKDyV1LKKSrAL1qyPBq8dyx054hFBxmFg0m3sHZeyhh/eQ/vsBlT+0Xip8/QRqLOIOLYRgt+NDlH5QkelA76iiiNT+J/zv8m+YRd+MYpnBpIBCMhhxw=
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:16 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::25) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:12 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 01/17] drm/amd/pm: Add clock table structure
Date: Mon, 1 Dec 2025 15:33:14 +0530
Message-ID: <20251201101331.101584-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: 298b8cfa-9e67-42ea-18ad-08de30c2613f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1VCDvcSXhiOZySjPXd9XIz+xeYUOegjPZvQhHkABS6/khrBLsS7mteltLGI6?=
 =?us-ascii?Q?OSRWmJD06bJtQuRgNk+liIOZOoto7lQvCbR69ccepXo3RofnE3VBY28JW1h0?=
 =?us-ascii?Q?kDKFm6D6sdsnb+Hzj3pZ27NxNnDt25C1vLIu6eDbFelb2SoLC0voMRjqy3Zz?=
 =?us-ascii?Q?FJHBtAneV9U5lRUW/a9Pbk6dI01f47r6O9TAiPPu8CDszjtpfvu+1psXhEKy?=
 =?us-ascii?Q?EiZGHFXR5LjOttEPSwMZBrZmZkO43klbK57pjwAfzQ9oD1Ef+eVuoZIbe3OM?=
 =?us-ascii?Q?d8pm6hoXtC68ydyYFft/GzkD53r7iX0AvlI88EDEWIBuZ3cXByN27JeWNtNv?=
 =?us-ascii?Q?/86gg4bBgxKuBUcXLyC44mYqdyXB6s7uEIobfF6s9FHBI/gTTDLTOteWfJiR?=
 =?us-ascii?Q?SRZs2XbFWMF54Yk9356CdszDv8064hxcUkx/xsGxnDrfV3rUfL7H4OKBe6Wf?=
 =?us-ascii?Q?d52zcPbJGBD+HqtoMwHsuS6XGRFwbDAbdmLPbgxNUxO0jG5Olwe987jy1+zi?=
 =?us-ascii?Q?mNNzL8Bo92u+fAauZWjwXGA8HRhnuChGHF/IFLRWUufvXlNxaWINQnk6j9LZ?=
 =?us-ascii?Q?/t6ZBmBuC7p/fAUamlur/bRBz8llFIwuPjhqonx9YMQqCy6jBZQ0cHvovThP?=
 =?us-ascii?Q?kTtBBfpxRXhdOW7GARt4yk6k0R8d5dh4RwVTXXHIgJflRNLO7FNR5VXMdhr0?=
 =?us-ascii?Q?JR3OiT+tpj3iqfy/hzJhOv7IP4NOzYWX98emKVIz/etJrFdGGBZD7S3Y0MJW?=
 =?us-ascii?Q?dPuKku3FwC0lKQz5rhOTBJi3GqPA3tAz1f5RIR1ppyCJezPJpfGBKbXXasJL?=
 =?us-ascii?Q?g8vpZ8mbitHjjCHiGs5FSOauCxsT4Xfc/n/LLmhkHDaUa2D9i9EsQgY/Iar8?=
 =?us-ascii?Q?DtwgpfFexS53LG8ejkJjhsAk2RWj9CQ9xci2TjpubIJrsXmgA9HkxqSzTM/Q?=
 =?us-ascii?Q?1GcXqLTD7RTSHbyhhE9bj0sHHlp5yuLe2MIFi6PsEX7GhWm4kqOl+6FwW1gJ?=
 =?us-ascii?Q?uQ/et2F3ggyXfPkNvmrSUgJTuqA9b3Eux5rQjZlqRMpBBbf49J0fxStMRhTr?=
 =?us-ascii?Q?bVmgYA4CHWsVAm2OsqaEC/JYLWjeshPPDnz8TMLk3pLeFjcZzi6BaXFY6ftt?=
 =?us-ascii?Q?b+3F8BQZIG+Hc8u6RTjWelDgO5QQUCjblz13oAOJsjl/iLRT5t+FT55Y3NQD?=
 =?us-ascii?Q?6PPtz+ylW91UfVDwg4XV8hkP14lFIXfjsUEsl4M6L9Cs44BIDn56Bjdqwzr0?=
 =?us-ascii?Q?2kCmyVeCRC8Otg1LkolhFAqIw7LLdOZ7GjicRu9oBlrpUqnNrL8qtrmu2uXt?=
 =?us-ascii?Q?ZVokTucDX1zAotX4RL9GtsEJYaeie2KO4df7ArW9bN7OxkcLcCbZRHha1VD1?=
 =?us-ascii?Q?GaN//f5bFstTRDDTapFncGHizq0JDTpLfapPn2889XSXj5393f+eOoZZMSDy?=
 =?us-ascii?Q?euuT0vMsWrkrEvbVshS1ZzQYlg8i5ARwwVSL81lHjMQ3pPCeHqUnOP12WPM6?=
 =?us-ascii?Q?9QdU9NuRaSO8se9Qv+wvDuWNmTskBV+B6K4qb4nj369UcgY6/6XQixU/HG2f?=
 =?us-ascii?Q?pSePqHR8urJrtnhhZjw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:14.5951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298b8cfa-9e67-42ea-18ad-08de30c2613f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

Add a common clock table structure to represent dpm levels for different
clocks.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8815fc70b63b..3d67d948eaff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -292,6 +292,28 @@ struct smu_clock_info {
 	uint32_t max_bus_bandwidth;
 };
 
+#define SMU_MAX_DPM_LEVELS 16
+
+struct smu_dpm_clk_level {
+	bool		enabled;
+	uint32_t	value;
+};
+
+#define SMU_DPM_TABLE_FINE_GRAINED	BIT(0)
+
+struct smu_dpm_table {
+	enum smu_clk_type	clk_type;
+	uint32_t		count;
+	uint32_t		flags;
+	struct smu_dpm_clk_level dpm_levels[SMU_MAX_DPM_LEVELS];
+};
+
+#define SMU_DPM_TABLE_MIN(table) \
+	((table)->count > 0 ? (table)->dpm_levels[0].value : 0)
+
+#define SMU_DPM_TABLE_MAX(table) \
+	((table)->count > 0 ? (table)->dpm_levels[(table)->count - 1].value : 0)
+
 struct smu_bios_boot_up_values {
 	uint32_t			revision;
 	uint32_t			gfxclk;
-- 
2.49.0

