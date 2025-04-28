Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AFDC3ABA6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD66C10EA71;
	Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XVFp6w89";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D365C10EA6D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB/1lQo6kV/IOZLnChmxeDHBYgpkkvm8C9lJVMeLu03iJORDVdA98d0I++bWCW+l2w1Bj/CnnwqhEscdQEBvh9JA0j4GGltto6abfqTMJoamwlKmpgq7TxeRqTxr2AYX+aPTqLMwhxhAhS9zk+23Y1l6Y6TcjzKgR7Q8FumFd2xsPijYcarhA05biJ0P9cT9fGIpG5j+KTRO45Cukovg4qaiKWYSX/NaBgU3KmPihd251eSA4fh5y/MxdeQlA+ZCEMkpYCIBXl3FC6QyEMZ55dli/BerR04aeBsiXART2mFMt3MilD0thHScTPKOFEm7j1rroNGgGAj0GN8lHKkPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+N8nmze+4Z7p13kv7l1Zy+h/58ZhmAcuk9xKLOHdA4=;
 b=PJaP4jCgfSXIn98j7Ort70e8jq/5V5K6R3w8qAe73kZjVUgIFn9K72xMn9js84n1ZPu0h0S6peCMV1GJ6bHE2EIt/la/+yuWvfE0vgVBaXuCQLnkAOdLTRSmTboEvSLw30FGKjgMcaxpLKElsCBqb0mEEyiQOZFjE66vNmQB2zbpZRQEVJqudPhGMELx8PrXNO9tISpZl2o0gufU1sdGdJM3wrJzOgNsrGJkDtqlY9a/fJpDLc7l/67vNquZaUZ7ZV2UFRsMwiFapgUaoXzA1jBUqPrQJHpFd5AHA+Qxv/g/qdS28NyKjDUmh8d5/ot0EDE3s9gROiFqCsODTE6TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+N8nmze+4Z7p13kv7l1Zy+h/58ZhmAcuk9xKLOHdA4=;
 b=XVFp6w89NmkObrBfW1dNmJHvVi+ZSR5lvNlFefWLrX8bCuG9nQNbmuoFVJgXz46GkzBwyaZO44YEuVQJt5EKq+qxlFXGTa/gRPOrhX42v8hTYcaIdZTiqkaXAYx1CcQuu1i8b9XWwOj/zVIcO6m7EY0laC/Fz1zFewIzGTIGMvY=
Received: from BYAPR07CA0073.namprd07.prod.outlook.com (2603:10b6:a03:12b::14)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 21:21:09 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::84) by BYAPR07CA0073.outlook.office365.com
 (2603:10b6:a03:12b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/mes11: add API for gang submit
Date: Mon, 28 Apr 2025 17:20:44 -0400
Message-ID: <20250428212050.1098434-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 026ef815-ee64-4859-6ccf-08dd869a9810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0yKpW/x/NDTY7Gne/wDUHlKMkvYlHeHDT+7X0JMSAfiTycN4Q7nkSBhclRDE?=
 =?us-ascii?Q?XHPaTyC3jnsyYYJYzhT4MknGRYVimrzWoJ9f3AwdoGSc+uioxlQmgwmImYOV?=
 =?us-ascii?Q?IeFyQNOZnLjSI+EsAD+WJnsqSVhFdvUYNw8jP8Qh2GFuefMg71Tnj7cr2qJS?=
 =?us-ascii?Q?8HOcLr7n0mo7btM513STS8sxlMw5e3YSZaUYpQTv/mApA6LMgGiEKxodD0lJ?=
 =?us-ascii?Q?3A8eN96aJz1ltjENRrDXW0L5cRb74EbhzQgCn1EuF67m5E+nCZOmJ71d+6TX?=
 =?us-ascii?Q?oDJlpKtAkWR/UJODONeN3WjZQMTlWEgBjwdoj0IDMytGd1Nx9e+wkjf0FB2m?=
 =?us-ascii?Q?Rvtvqz/frATkojJRxf/dnCPjOtRUNf2k6mjoRmYeIna72/276iCxMcmuzGmV?=
 =?us-ascii?Q?ormw6M0q8KwdNh0k+UhUySRN8GJ7oli47Wz8qzBpWKKX4R5a/2vpOsAytMF2?=
 =?us-ascii?Q?1RVMi3vF32Xt1QQt/GotnExUvYfP/mBimSe/4A+zCihQcweFKLrG4Pt6zwnY?=
 =?us-ascii?Q?T5OyI+db7dtov5dATPV2igJbwpHEIZdaF2YVlRJLULgBAv4dcCaI4bjoZMJD?=
 =?us-ascii?Q?UHes++mWBk9mnsHIqJeUEQmLLFtjcdfrMKKvaqfbiYDhINajHNlfQmLoRWwg?=
 =?us-ascii?Q?mFlw2A+TXocRKZDK4ev6Na02T2jmVJkuBY0Mtorv5yA+W4sbSIss0sHkvHR/?=
 =?us-ascii?Q?n1uabN1UGQvg2zVaTd4xTpXU7mGw0Hnnnq/2X5O/HkBh0amEw1Md/F2nJA7b?=
 =?us-ascii?Q?aEnM/jKt1kU+yOSmEJHR2B4hkAACMKkBo4+cmR34DICSKN2obT6pxGbEL57u?=
 =?us-ascii?Q?FHuLxdNhoBco5+ASoi79njXWW/89a6q82ZteKquFlrdfNcxlNs7ZbzKsRrQS?=
 =?us-ascii?Q?wI5YTw3p/DXylRwJmrwPpR+IPBeQ0As4ExGh9BNbkUihVeZQEylpDAWIqL+v?=
 =?us-ascii?Q?7G44fW1UCtDIxQHmHntywgGkXbZ3CbOhTOWp8HyEe6jUX9Cstx3WJMARORtw?=
 =?us-ascii?Q?4jiOWLYzJSpLrpsg9fDBFwnzCwnzd+fxZNnfL3dmx1fv6d+izHAggmHLbY1T?=
 =?us-ascii?Q?u8EI+RkawSLUtkd7DiV+HZAwZP1WNIgEGF5Hoje9teFXRZrmlhQ2uvoCbjhd?=
 =?us-ascii?Q?NW684FBfy0BKCclyhq7aLgSFlPs79SiKkCm885d9h78N/7QMjmUcTaLspt0R?=
 =?us-ascii?Q?egC0CsWkx+IrOe7ShqwSWlCXoI4HLlDTWU9A4EYcYYgqLJg3oguLIeFnHF1E?=
 =?us-ascii?Q?YKZwAcWd+TeeaKFBMM3DkX0bHugmKlY+6xb+PIxop8Cwyjda5GYbyrkikKM3?=
 =?us-ascii?Q?pPWKcNjVnnoaH22Unh2acSBfIGYHtRJiBsuC9fq0zeOz2JP/RWMnArPD5bIL?=
 =?us-ascii?Q?wD66GhQ4aXyChhLPVPSqF3xqUZQcB7yCcBPEf3RRI1NkZ6WtR1LrainCBMMU?=
 =?us-ascii?Q?LvRYXurQZtGRx3v5FhTPObOytdT6aFGUiX20F7aN7FtE0Psz1BGYpjsuntFH?=
 =?us-ascii?Q?2J1tUW+yaXXPjVwD73k1Gc9EEQJGoTAFjZxN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:08.9357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026ef815-ee64-4859-6ccf-08dd869a9810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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

Add API for setting up a gang.  Gangs schedule together.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c9eba537de094..8a31bd81bcb9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -125,7 +125,7 @@ static const char *mes_v11_0_opcodes[] = {
 	"UPDATE_ROOT_PAGE_TABLE",
 	"AMD_LOG",
 	"unused",
-	"unused",
+	"SET_GANG_SUBMIT",
 	"SET_HW_RSRC_1",
 };
 
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f49704..d1933bc3669d7 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -64,6 +64,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_MISC			= 14,
 	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE      = 15,
 	MES_SCH_API_AMD_LOG                     = 16,
+	MES_SCH_API_SET_GANG_SUBMIT             = 18,
 	MES_SCH_API_SET_HW_RSRC_1               = 19,
 	MES_SCH_API_MAX				= 0xFF
 };
@@ -633,6 +634,13 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
 };
 
+struct SET_GANG_SUBMIT {
+	uint64_t gang_context_addr;
+	uint64_t slave_gang_context_addr;
+	uint32_t gang_context_array_index;
+	uint32_t slave_gang_context_array_index;
+};
+
 enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
 	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
@@ -703,5 +711,15 @@ union MESAPI_AMD_LOG {
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+union MESAPI__SET_GANG_SUBMIT {
+	struct {
+		union MES_API_HEADER    header;
+		struct MES_API_STATUS   api_status;
+		struct SET_GANG_SUBMIT  set_gang_submit;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
 #pragma pack(pop)
 #endif
-- 
2.49.0

