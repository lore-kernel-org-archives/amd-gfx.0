Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9C0CA1010
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 04:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6DB10EB18;
	Fri,  5 Sep 2025 04:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZc+V9E0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A293410E2BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 04:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaCVwiu1J/s9a/ZdCR2d9vbscOGXgCDTjLBOL0oRu4itlSGRxgqK9T15i8Wgy7K8bK5eGHcEK6L8hmZjN36z+lGg7kW7pd/xQ6EFnjXVQeYvl+Fezc1pPXmlcWTSebWCa78bKb2uWeYIzWLl45OPefKo2U3+zndcf7ryWr/tgjTOOz3minsE63/Q+p5MLLqZuuvGcxU1JKzxHwrEHd1c29yT7aE9UKZ4yefwt/tm4JNINOci/M4TER7BOKwLGyHedvLwAo/EU2a/C75KtLHyJnv0arIjPrCGxrHtdi147aBLdUL2bKDckltLqf3azF6y6hUrG6U8Ftk/gtEqW2rNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4QMzIgaYschVOrwFZoXeMvJvuu9/Vs/ZP5QILyOeiY=;
 b=MbMnQvsAv2LmYUbNL2foliWcPVFU0+/RrJWt2hMfSvgdbnARSg3zXIrUQ59x8KDCgDjO+nIOgCl0H4pbE5/ajkgr1fQiwnjBaB4pnIXuQqlfLQUNBRgyL4GCj5CJHd0y49D5AujiB/SVKsrn+rAxiWjXxrdBlf0v/SjOZVLz5eFjDGJ4ix5DSBoRwnvjLtW0l4HrIQSc7oP5X2/FhvPlMRsuTjGq/jeQPko4w3hUO0FaAHeqSATD+KDc8W60/dgfxKzZljOTYf5kvJJ6snnTjyummrF525kJSVJX1UDLUG08htrSfFmBl6EhJeXZIZ18Jl14C9/hMw9acNa4c3WpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4QMzIgaYschVOrwFZoXeMvJvuu9/Vs/ZP5QILyOeiY=;
 b=SZc+V9E0uwDid+Yu6UNzXnw+1bsin0MXP8m3udtyAqWzy7SbPw2kKUfWv/sf9YTrk0QagjSlglQGI8mdxYGk+ofl2BX8DPYN4pY4JR3WMghBRetB+QI+YfPMl7wtu2DhfmhheUmxc3Rf1s/VPoBc/UzKhFK5F8fZq4GZYmDqL0E=
Received: from BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 04:43:24 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::eb) by BYAPR08CA0030.outlook.office365.com
 (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 04:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 04:43:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 23:43:23 -0500
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 21:43:20 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add virtual device capabilities
Date: Fri, 5 Sep 2025 12:42:40 +0800
Message-ID: <20250905044301.1947978-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250905044301.1947978-1-asad.kamal@amd.com>
References: <20250905044301.1947978-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: e83cec07-022a-4757-d837-08ddec36bf52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7rfo0dAG0M/nKinXqEetZxWKHTjw9t5aXLDoU47KtMqNaHstLIosgmq9CYJ?=
 =?us-ascii?Q?mWEEhs43pywoj+RlFTPMWT+zkD4UfUfkDiwPYA3X/+bqKvm7f4+gDfAVX0Gj?=
 =?us-ascii?Q?+jbf+V4RIOC3wZCU31o1rjokKVmQr2LPw/NYb7+XuHNVEO2AKGIHeH0Urzcu?=
 =?us-ascii?Q?1NzN1MiSW+pmmKNy/lDwuM9ilstYgFalNqjwcpWSMaSBlgwB49FW6/S5USMH?=
 =?us-ascii?Q?urQw5xNt9os58G1vaTlXlfVQnF02YKeIWSX0SMjmwgawg0g3zSDidO4jEIgn?=
 =?us-ascii?Q?tBw7HYMqRD01eD6v4wkdRcErhgIwnaLxljle/yoIGK6ttnJTmjzjzSLaUzHC?=
 =?us-ascii?Q?LUsQEDBPMkz5YzDcTobxgzPF+Vprnq9vQjp0Bj6h/M34UxqYqCPHpngumx2x?=
 =?us-ascii?Q?iTP74Cu+uyEqPCX2yH0BR7p1bmaKWfP30hP2S9JNGz+7LxwH2ed0tCAnZHSl?=
 =?us-ascii?Q?OgeuG2WKN1G8fIp2VZjxIJn0WXTVYP4nlYI2M8rl1hl3JoRzhHNfDC+uPjo4?=
 =?us-ascii?Q?vCCrvk2TS73c5jfTCuxzMaUsyOr2yNYY94rus+iiI2JdZQhF0glsMqay3ry0?=
 =?us-ascii?Q?6GB1OfB+SNGenDhH9+QgZQnCoWjhgIUOaHfGtaFLrexklLMaz2zZZXwleybw?=
 =?us-ascii?Q?ALHZBke2F6TLH/w1v1XT7bfILRcn/P2KH9UBX5AjqmPGaGRh7Kh2ZCVfSoR2?=
 =?us-ascii?Q?PgrQloNW11OYvO9QB/hDMgEWt67Cb31vWq9Yg6TQGClr/MUGMg4q9mEaNNX/?=
 =?us-ascii?Q?Ap5IHUrOdH4a5y5nG51U/jJEO9btglGb8nQvqDhNM2/UszWTIX6cW5Ts/AoE?=
 =?us-ascii?Q?xZN1g7125x9ziBLAb1eVU0LEewmq3HLXpTTIt2HUga6rBtbA0hufXMJ4Eb6j?=
 =?us-ascii?Q?Us+wbIZ0wJFlJMphhjU2xudgDrOwQkyhAVpo6HGr8GvQEVZNXlsX4DlEo0TL?=
 =?us-ascii?Q?PiK5kWbDrKgFtADfvp1dv5JpK/Cq1gj+qaSxn+81hws/gvZ3fPELghmSIgXl?=
 =?us-ascii?Q?5+TBMa9onsImgPP/znTXmuEB2HWSQpwIxlZfmjC9IMAbG3uNOFydfNLXMmAw?=
 =?us-ascii?Q?NfrA15ORz3qgdtkv0SCCVxu1EISAwNNPpFMRYfuazJCdhqRv86/9LoonwFmf?=
 =?us-ascii?Q?YQZfgCyG7oi8+i8fCWGyh6PR6zZyfSs5bL1XvZ9YHcvdikWEM7M+zGhhWORW?=
 =?us-ascii?Q?uX6mXU3YIcaNgblDpmWx/EUssUgbCdg6PA0vVqI8yT4HH1rLlx4QpPoGSs0J?=
 =?us-ascii?Q?zn8TXG03oynsQz11MJw6eWu9buWsme4aMMRGir9k5oIOf3XxBt886yRSOU6I?=
 =?us-ascii?Q?VrL5N7prw87nDqTfWki0SDYcSPnPiDSXTuKQxm5igMYcaLvUjpF5+Ts9V98M?=
 =?us-ascii?Q?1+NBeJYMtRrSQpBHQNxS8+1Jg4w8gWJ18BUxStP7RXyhfoelP8YuubzQI/8n?=
 =?us-ascii?Q?6vrmT8WNaiFRsaXDYuZqsHpuzjjZ1ntyLcNfQ01nNkd9vumdYd5Dn1iv/9pO?=
 =?us-ascii?Q?tD+gyhuQHtGTtrSDncHWYzrDbBuhEHRIJI0Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 04:43:23.7395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e83cec07-022a-4757-d837-08ddec36bf52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add a member to define the capabilities of virtual device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 58accf2259b3..3afbdf7b487a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -256,6 +256,10 @@ struct amdgpu_virt_ras {
 	uint64_t cper_rptr;
 };
 
+#define AMDGPU_VIRT_CAPS_LIST(X) X(AMDGPU_VIRT_CAP_POWER_LIMIT)
+
+DECLARE_ATTR_CAP_CLASS(amdgpu_virt, AMDGPU_VIRT_CAPS_LIST);
+
 /* GPU virtualization */
 struct amdgpu_virt {
 	uint32_t			caps;
@@ -274,6 +278,7 @@ struct amdgpu_virt {
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
 	struct amdgpu_virt_fw_reserve	fw_reserve;
+	struct amdgpu_virt_caps virt_caps;
 	uint32_t gim_feature;
 	uint32_t reg_access_mode;
 	int req_init_data_ver;
-- 
2.46.0

