Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DADC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 08:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C532210E10E;
	Thu, 17 Apr 2025 08:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xsFWpM1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D2F10E10E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 08:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwCvlkyBJIHK/rRbQ5J3FStbwMd3Po/7w7UTjsDF5Fu2AQJ/8Di/s6Wze9I7Yy/8eoN7Rnnwig/Hnt6WOhs2JF0KSFeg7rsmQtjpk9BtmJMe6/I4NqMOp9mETqpsNUrm7yCYMjvLfH4ZUBKrsdZptRmOQZxaW71vpMJa+FwwoAgEIGZST5ML/ZWllankIarYzatbU4RjJiYkKgJ9VYVKmQ/L4MEIg1yzuz+rflC1HaCf7TLO3IPz6kuYBDFN9KPhorRXkg2vShfRjOikunAhEkBVDANiV6CzLMlwQNJ6u1eGMVUnNbrrC8CB/Zq52ZFLZ1wc0qE5cTwsvwIxbYJPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXdYWYMMO5Vh0US+ZgbwGtbxOPkFrlyr63Ty6IloU7o=;
 b=sP7w/LNakz1rBFslwrz5g6C9mD61NDKBH80zw1oLWeuYXZREVlH7ppMPw97QUzqIQtsICpymyj3aPLvMVxFGntzpTDC5amXz2NiTtVsrp5ZdOn96twrQv0VmCmSwRxxxrOy4VomEendzy8gn/KkD1dW303FMVRIcaEa5UrlXZFR8BYRsLucX8D+ZqbRmMlU3bVXHdyBICcP+HSgnk18eI5Z9AGKRGK6/hXlg6Yb8XaijeFZKXGk8o8lfn+E/JAnCl7SqxFUpui7AZyIgFkkIsj7B67f+URKMvWTwREuZFEWmo2TO19SlISiVCxmDU/rdui6g9qV1cIXUsU47oOM8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXdYWYMMO5Vh0US+ZgbwGtbxOPkFrlyr63Ty6IloU7o=;
 b=2xsFWpM11ckL2yuyMdEZZiYYEUpo3+V6N2knfUREGAI4GuB2wFT8ZPRoEe7kfs/5eD+lHgJlhxirRMoUotHYaPApXXFyA6TB38Yv7CJabg0YWgON0kIcffwLUoDisvMqrw5M+ATGL5eFA12dneqg4qyopzIIHfHL4kYyJkOymPk=
Received: from CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::9)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 08:58:45 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3b) by CH5P223CA0020.outlook.office365.com
 (2603:10b6:610:1f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 08:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 08:58:45 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 03:58:42 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: adjust high bits for RAS retired page
Date: Thu, 17 Apr 2025 16:58:28 +0800
Message-ID: <20250417085832.36455-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417085832.36455-1-tao.zhou1@amd.com>
References: <20250417085832.36455-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5148dcfb-9df1-49e0-4e3b-08dd7d8e0f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G6j+/zt5D23FQlsf34SXBj1ioDHpyby5FIqeBVaooXYg3uU2/LdmxGqdrHon?=
 =?us-ascii?Q?BitrSvbhAlJVYtBtud+0OSph/1Az4RNsMSFhfXNFEGFcfnQloFz1JJ4t1cep?=
 =?us-ascii?Q?FnK1Q0HvcyGWQcFdcrcYd2mlsZT3C9XDCjeLd2QIfZM3Qe6ARbf3Zkyf305T?=
 =?us-ascii?Q?Jc8WAhsLmrMNOVL6CU+s4HMLhhrif1aSTXD15HTj8I2fWUpSwWUtIV9KRg+V?=
 =?us-ascii?Q?G7eFSMm5+zt4evBcePf1ZplWLrl1Fo2zXfLN5eTeEC3nUNrYpCGQnu4LThf9?=
 =?us-ascii?Q?AJ9MUpX8g3Ufw9oXqHCv+mrvPcubOneijZ+f/utjq0U2raP1Oyr/UZFxD4UW?=
 =?us-ascii?Q?3UgPZ3TxjHnwfkka4hr6W1808ks3EcdKY6eXgM4b0kvXV5a2voPAEIhRpy2n?=
 =?us-ascii?Q?ZVgmEh01WrQW+QuakAKku4J9AvT38zHEjVr4SUgNzn269lme3wty2bHOAfqZ?=
 =?us-ascii?Q?RB37su1gdHOTG5d3e3HH6shgjxOHMOmStRau5MHCDA7Y0yVCS9KhKEDO3BfY?=
 =?us-ascii?Q?E90BREFvZMAXRUQJ/7mD/23b8qvCfbFp6AFgzpyYXsTLJw0kt+SVtpOWbfLF?=
 =?us-ascii?Q?sg5JI6ji0mNI8taW6q2dViN1SCKl2ZmiJFbF2CgbPjPig8FmfTDStuT2J/1S?=
 =?us-ascii?Q?J6NVn3zKWKuG3rqOfMLK5EJ5axSEvJLaF0AAU2F4V60WF12hThfd/LDO+lL2?=
 =?us-ascii?Q?LKSPN+dEPoZTJK+GQNO82B57Ijapgq18RucqaidPACosQRWWJiXdbQ3r+kOa?=
 =?us-ascii?Q?0di25vp8n4YdxQFA7HHatINFTpdnydafawpP1rEm0GZQrPDOX0gGqkyPGcRB?=
 =?us-ascii?Q?QU8WtP7u5xu2/AfXVgkyMS1jfoSHxnBPr0SIfdS2wLBPMrLthKgGJ1krqKtf?=
 =?us-ascii?Q?aooPzQ+8g5TL6YSaWqhBZw8MyYbFfEOFBpzV8/VKJuBsDrvc+lVknwmHIRCI?=
 =?us-ascii?Q?7dZfMduRuywaj8OppxEps37YDG0hki20uTeoizfLUOGZkE+PkNNNAJ5z/EW7?=
 =?us-ascii?Q?B92qnOWAgNq2WbjeHTkoyL3tMkliIuxogdeZOYQg1/TcczJHEi3oNWFCZLq8?=
 =?us-ascii?Q?tSgLpiIJSNWXHK60ccVlPwiC6tv52ZuT13v/9xgRloRkvjcRH0ctaASUSSoE?=
 =?us-ascii?Q?zCrX3Fj3zZ3OlrdUIGJapyfBQT0MrUBKEB+dGjoGbDVMThFp4kQOjRUl54K7?=
 =?us-ascii?Q?QPVg73oudDyxeQQQsBz9wgbqPJ/yP2dkH33Ass6rmWNXuDnidoQFzfwbQ54+?=
 =?us-ascii?Q?g94XdUELIgzFOeEUVjp9WBnbk6WzJHQvdUEEaru39TEYvgejuNMWSf7hLOVI?=
 =?us-ascii?Q?cBTCOJbg9IJvZ4L7COJvMtra1gLv79cmksL/d8ply5qSx1DHAo7/zei9uHq2?=
 =?us-ascii?Q?YOyJ8WKJocuN+f2Eppg2/EptE1iVwYcvme3MVI+u65bHrjr6D2mwVnHtHTWP?=
 =?us-ascii?Q?Gj2L2YY76XH3dinro028QomTq7AFTjkjocPaEikvFcBUdkrm1k67Six2f2ZR?=
 =?us-ascii?Q?kWXgwAKlGXwUNH/0cHHQfdsq/n0KSYxqp2dW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:58:45.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5148dcfb-9df1-49e0-4e3b-08dd7d8e0f83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

Per UMC address conversion algorithm, the high row bits of UMC MCA
address are changed when they're converted into normalized address
on specific ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index da00d6b3b6a3..d715cfde6aec 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -180,7 +180,7 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 					struct ta_ras_query_address_output *addr_out,
 					bool dump_addr)
 {
-	uint32_t col, col_lower, row, row_lower, bank;
+	uint32_t col, col_lower, row, row_lower, row_high, bank;
 	uint32_t channel_index = 0, umc_inst = 0;
 	uint32_t i, loop_bits[UMC_V12_0_RETIRE_LOOP_BITS];
 	uint64_t soc_pa, column, err_addr;
@@ -243,9 +243,18 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	paddr_out->pa.pa = soc_pa;
 	/* get column bit 0 and 1 in mca address */
 	col_lower = (err_addr >> 1) & 0x3ULL;
-	/* MA_R13_BIT will be handled later */
+	/* extra row bit will be handled later */
 	row_lower = (err_addr >> UMC_V12_0_MA_R0_BIT) & 0x1fffULL;
 
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)) {
+		row_high = (soc_pa >> UMC_V12_0_PA_R13_BIT) & 0x3ULL;
+		/* it's 2.25GB in each channel, from MCA address to PA
+		 * [R14 R13] is converted if the two bits value are 0x3,
+		 * get them from PA instead of MCA address.
+		 */
+		row_lower |= (row_high << 13);
+	}
+
 	if (!err_data && !dump_addr)
 		goto out;
 
-- 
2.34.1

