Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390AEC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 18:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D1510E9C8;
	Thu, 20 Feb 2025 18:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pLthjDU+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B8D10E9C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 18:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Db4BYlb/NrxKCgvOJxv6QTiFFozZ9epHvupYlOQTF7QDvWb8WztgCKIDWUPca1iTLEQ4KXEkVZFMa9mO3qXfMooKetMo7D3rANBCklkCNVE+JhgQS+puFM/BhccxFhngX0hB+NGuHEZgG1uClA2Ni602JalKQVUQnfHlem9LqBZA+3XGKi9kkE6hyZLCKk5Q/xSN/bdvngMAX8+gjNT4Y7elSWjoNeOelj/zkk/Bof9P7zc/PlvIYiqAPaMejr37Z86fGT3s4aVdpaIQSuZ2bGi8ktt9qL0/QfAKktwS+dxP0r4fuCwhGHqHHHVCCxDcTUmD6SH7kmLLE2nxR96Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFEbfcE6nI5XxjfXJF82ahoi2u/DXzCL0G6O50KsU5g=;
 b=CoTBxIq+mX94yqgzwRmXeWfnd0CGeSnn11UdZJ08Kq7GuoJa1ki/ehxXQxFqzAvGwTGNCbM8Api2UrnnTfDEOLh3dA5KjLG4hhVq7CbN/oiVX4ZlgBwbFE+oaz9iZwgo6qg9+W6oWLmX/TjUD+iwH33D+wg3MVjI3gUdOfLIzyIEUa+m1T6ZpHktQhoaDwfjXbdRQRZeLAMI15k8JX9nMuF8f3QDA9iOhhsjmwEoyMvqnsyVnnhLXVAbCscjj25AUpilkD9HbGcBZI54kb+CZ5Ha6xN4fvhWWGVAukDnOh/GagSsnljodUVo81am+WqBNBvw2XQ5SOWYcMekbIZsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFEbfcE6nI5XxjfXJF82ahoi2u/DXzCL0G6O50KsU5g=;
 b=pLthjDU+M0wkttRmKtt1xGKtOO/7xsuTJdKqxHKjlPiQiRTeQ8auCfV4QmRo92OrbfAYC7SyxDhsj4tdLWj54SIcsLYoe+si8h6BeOKEtYsuVjLUgWtkBttSr/NiZ17K+2v9S4CeZRo37O53vLEA8D3517lDPD1zGJ2ojt5Jcq0=
Received: from BYAPR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:74::37)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:37:44 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::a3) by BYAPR05CA0060.outlook.office365.com
 (2603:10b6:a03:74::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 18:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 18:37:43 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Feb 2025 12:37:41 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add core reset registers for JPEG5_0_1
Date: Fri, 21 Feb 2025 00:06:52 +0530
Message-ID: <20250220183653.3000793-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
References: <20250220183653.3000793-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e4ad6b-989c-4a89-4b08-08dd51dda994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aS8wMm42bGVTVWVJRnVkUlo3bFpvc2oxVE1ES2pEVHFUQXM4SzdpY1BPQzhR?=
 =?utf-8?B?cnc5MVFuanBoOVJCdDJKUGRPNHk1VGdNRjAxNHNMYTRzNzNNRGRRdjg5ZkJu?=
 =?utf-8?B?aGhwc1hqdkVHMHpVY3QyNUlWMnFuOGFCVzl6QWc2WkFqUlBUeVdjK2lvc1Yy?=
 =?utf-8?B?MmZkTkFxZEdMRGY4MXlnZngwN0ZMVmxqbVRPWUNVMGJpckF3SDRLWW01Sm1o?=
 =?utf-8?B?RFF5WEVDKzRmUllTTGRoN29iWW52T0pNV1I1eXNYUVltMDZjekNjQVpjNW52?=
 =?utf-8?B?Y0tvQ1RmRVFXeHp1MUF6bDFXaTNSSldZek5TNmVRUmVwUHcxNVZUcytzZjZn?=
 =?utf-8?B?TjBWNDd0T0tjcmt4SGd3bmdaN1JwK0d0bzFXTlhQRVZLTHJHaDRHRExlU3Mz?=
 =?utf-8?B?dFZqQWVQZEV3MmFIMzdWY2Y5VzgrSE9iQlF2dDZIODZ1VTZRRkZybU1sbURI?=
 =?utf-8?B?eUU1Mm50K0IrS3dadTU2SDcyVS9WbnF4enozWHpVSzZ1WXZTd2kwYlhzSmZL?=
 =?utf-8?B?NW1tTGIrS2wzblpWM211UFNTczJROFhLc2FQdllNbTlMczRRSWgwNUlIVm1W?=
 =?utf-8?B?dWJHYjFuTDkrTExXREQ4N05sVjYvZStEb0hBYkEzcmt4L240blR2Wk45b1Z4?=
 =?utf-8?B?ZHAxNmJVWUFXOEp2eXVEcHBBVURxcVE4Rkh0VFBXZ2FuTUNieEd5TEFULy9O?=
 =?utf-8?B?SmFhZDAyby9FdUVqYUYrTlRBcC96WEVVcUg0ZXJnNlRwU3J6VC8wVzlDcndm?=
 =?utf-8?B?QVBLS1dEY3JOSWI1ejRUV2VYcUMvcUdaZytlWlNhYlMvTnZNRGVncXBycmww?=
 =?utf-8?B?UEFuOHFnMVRWSUZ6L1ZIMU5JQjdjbTVJR3ZZaWcvOHFBZEtzakFSdStSTHF3?=
 =?utf-8?B?Nm5uaU81TDdMT1Z6amVidCtSb3Q1bTZXR1dnWG5IaE82K0VtMHdjZDRuYm5U?=
 =?utf-8?B?bmRyUVJZUERHblFaVVpWK0RXblg2d25rQnNPTnNWaFZ6dytoQWJ2T29HODcy?=
 =?utf-8?B?cWhRL2ZvcVE3aHYxQmRuZFBTTG1ZMnVOTzN4K1AvNnExOS9JM0VJbll0d1VE?=
 =?utf-8?B?MUdLMmdkZWU5aE9CNzBkWCtCeGNCK1VyQ3JWaXd1dElZNFJDbEdnWGhaVmpQ?=
 =?utf-8?B?ajdiVzB3VUNwTUNMdnRkR0NJbyttdDFNNkZ0RlFwcUZDODZ2UFhhcE1STEV1?=
 =?utf-8?B?V0Q5YnZVcHJiQ3N5Q3g5NVJ6VlhSZFBjVmhqeHNNTVFhNEdOamhydi9WbjV6?=
 =?utf-8?B?NlBJQ2VTZkR6U0NKbVQ3ZEJGcHJaQmczdUFHYmVvSm9kNi9obnpZcUhFNEh5?=
 =?utf-8?B?eGZoYVdxRXd5RzEzcWYxRHo2NTA5TkdsTHBxZjVZZ0RjK3dadFRkYlU1ZTB0?=
 =?utf-8?B?UTI3c1ErUkNxc0tQL1dkVldVMC84STRSaHBmRkMxVzlqWS9wbUxGclJDOElB?=
 =?utf-8?B?ODdBcjR4bmU0cTZYcG9tTGJUWmJHUERwc0JWczhTVHd4K1huTSsrL0UzaFFX?=
 =?utf-8?B?djM1VlJHTFd5eU1Lc0hMNlN1VWg5K1IxQWhYT1dSN3ZPclJ5aklwK1JpZ3h3?=
 =?utf-8?B?TEYxNDBRSE90bW84aEpOcVpyd0V6a09xQ3VqektxZjBabUtOaHJadHkraFNJ?=
 =?utf-8?B?ZHRBOXc0bzRaTWhlckNLdGZRZkNlTUwrZHE1TDFlem45L0FoVzJqTFdaejIw?=
 =?utf-8?B?WlgvdXZOZlU5WjFkL0I2a3BwTHlWSC8wVDE4cnFhV01VMFJLMWc5cmxJNWs1?=
 =?utf-8?B?QzdMTEhBSk1LNmxkb3RLdTJjQzF2YTZiWlMveW9XU2M2cEhBRktyKzZ2MHhL?=
 =?utf-8?B?eFk2SE02WUF1OEpTM2VHOUlyQm10TWtYSk1FT082Q1g2V3BzL3lMaTZwRjBp?=
 =?utf-8?B?bU1oT2dsOUg0ckVqTnNXS2Qva0wvOHV0VFVpY0NkVXZiT2xXdmF3U3NaSGdH?=
 =?utf-8?B?T3dTelByQlV2RUpSR2tQMlliZFBWalBRNzRUQW5NcHgrdGY3MG5mRzNKd3NB?=
 =?utf-8?Q?dufVS4a7PUEAthf92BgqCZOMH2bar4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:37:43.0231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e4ad6b-989c-4a89-4b08-08dd51dda994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
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

Add core reset control register definitions and align
all prior register definitions to end at 100 column
length for uniformity.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 128 ++++++++++++-----------
 1 file changed, 68 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 9de3272ef47f..d5c63d8074ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -26,65 +26,73 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 
-#define regUVD_JRBC0_UVD_JRBC_RB_WPTR             0x0640
-#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX    1
-#define regUVD_JRBC0_UVD_JRBC_STATUS              0x0649
-#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX     1
-#define regUVD_JRBC0_UVD_JRBC_RB_RPTR             0x064a
-#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX    1
-#define regUVD_JRBC1_UVD_JRBC_RB_WPTR             0x0000
-#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC1_UVD_JRBC_STATUS              0x0009
-#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC1_UVD_JRBC_RB_RPTR             0x000a
-#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC2_UVD_JRBC_RB_WPTR             0x0040
-#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC2_UVD_JRBC_STATUS              0x0049
-#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC2_UVD_JRBC_RB_RPTR             0x004a
-#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC3_UVD_JRBC_RB_WPTR             0x0080
-#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC3_UVD_JRBC_STATUS              0x0089
-#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC3_UVD_JRBC_RB_RPTR             0x008a
-#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC4_UVD_JRBC_RB_WPTR             0x00c0
-#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC4_UVD_JRBC_STATUS              0x00c9
-#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC4_UVD_JRBC_RB_RPTR             0x00ca
-#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC5_UVD_JRBC_RB_WPTR             0x0100
-#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC5_UVD_JRBC_STATUS              0x0109
-#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC5_UVD_JRBC_RB_RPTR             0x010a
-#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC6_UVD_JRBC_RB_WPTR             0x0140
-#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC6_UVD_JRBC_STATUS              0x0149
-#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC6_UVD_JRBC_RB_RPTR             0x014a
-#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC7_UVD_JRBC_RB_WPTR             0x0180
-#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC7_UVD_JRBC_STATUS              0x0189
-#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC7_UVD_JRBC_RB_RPTR             0x018a
-#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC8_UVD_JRBC_RB_WPTR             0x01c0
-#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX    0
-#define regUVD_JRBC8_UVD_JRBC_STATUS              0x01c9
-#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX     0
-#define regUVD_JRBC8_UVD_JRBC_RB_RPTR             0x01ca
-#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX    0
-#define regUVD_JRBC9_UVD_JRBC_RB_WPTR             0x0440
-#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX    1
-#define regUVD_JRBC9_UVD_JRBC_STATUS              0x0449
-#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX     1
-#define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
-#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR                                                         0x0640
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX                                                1
+#define regUVD_JRBC0_UVD_JRBC_STATUS                                                          0x0649
+#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX                                                 1
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR                                                         0x064a
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX                                                1
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR                                                         0x0000
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC1_UVD_JRBC_STATUS                                                          0x0009
+#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR                                                         0x000a
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR                                                         0x0040
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC2_UVD_JRBC_STATUS                                                          0x0049
+#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR                                                         0x004a
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR                                                         0x0080
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC3_UVD_JRBC_STATUS                                                          0x0089
+#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR                                                         0x008a
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR                                                         0x00c0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC4_UVD_JRBC_STATUS                                                          0x00c9
+#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR                                                         0x00ca
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR                                                         0x0100
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC5_UVD_JRBC_STATUS                                                          0x0109
+#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR                                                         0x010a
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR                                                         0x0140
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC6_UVD_JRBC_STATUS                                                          0x0149
+#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR                                                         0x014a
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR                                                         0x0180
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC7_UVD_JRBC_STATUS                                                          0x0189
+#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR                                                         0x018a
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR                                                         0x01c0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX                                                0
+#define regUVD_JRBC8_UVD_JRBC_STATUS                                                          0x01c9
+#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX                                                 0
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR                                                         0x01ca
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX                                                0
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR                                                         0x0440
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX                                                1
+#define regUVD_JRBC9_UVD_JRBC_STATUS                                                          0x0449
+#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX                                                 1
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR                                                         0x044a
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX                                                1
+#define regUVD_JMI0_JPEG_LMI_DROP                                                             0x0663
+#define regUVD_JMI0_JPEG_LMI_DROP_BASE_IDX                                                    1
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL                                                      0x067a
+#define regUVD_JMI0_UVD_JMI_CLIENT_STALL_BASE_IDX                                             1
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS                                               0x067b
+#define regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS_BASE_IDX                                      1
+#define regJPEG_CORE_RST_CTRL                                                                 0x072e
+#define regJPEG_CORE_RST_CTRL_BASE_IDX                                                        1
 
 #endif /* __JPEG_V5_0_0_H__ */
-- 
2.25.1

