Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793B0C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E38D910EC1B;
	Fri, 11 Apr 2025 16:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Jgh10nd";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3111110EC1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLljN+ThJmz4nC7sjXcREwdDshwrgtQNrxVTh3bKbbMg7E8GE5w7PsDRe/29cA4mLYXGHffNElb9HyyclyGObTFnM7or4f9E0k1mLspxlEGlF8THI8qfvoG9a1U57gQDUuryKlzAYCMGeXS5HgkLuZpFFePO9aobw1l5EP+mAP4/rglnSsmlClYY0jIwFQN/mQ93XFjFY675IhpJ9zBQVYD97f2ToDDB8M3eqa5tStAlcIZDWEhbty4aCbO4tix1+i1swyZhT3HhknjW98aUXwxmkOIZa6iC4XQKwRPhoFcpSPwL7mGwx8+wef95vbyqzGAgNkj0+twmrIQk60EB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxpwLSQbEs4F5MKK8bw7j/e22GoP7i/0VnUxZIqNjaI=;
 b=RyVbR5fos062SK8O3xHj/xV9n7tV7/FQMVburMufWN19vftE0Vb+GVkWp+sGXvtDy2CEeewsSOiokMFpftI/jneHBs7uA3nn+GZVx63qXxqfYkTKMVPwR6xWnfTctnmsrmH+y/4SH2mEXwHOrttThR6orbtGGaP0K9Ep5m10ZoaqqvinO3UUD+GFy7plc8hZwSR8kIB2KCigwt0AXtjhdr7mAfd2qgHPFs3c9IYuGQ8AmIS7/O8BNc5cTrdnnUv6+HRncS1Pb3WWduOmTzXPy2V6/CtvynkoLI0rhT99ihNktpHd4GknuBEs7WNAV1P8bQLTF4qtxIm2hpBbnkbiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxpwLSQbEs4F5MKK8bw7j/e22GoP7i/0VnUxZIqNjaI=;
 b=1Jgh10ndeGxDoQYGgD0RBo0jNBzw1ZRJWp87+kwWg1SA3MS6NODm6dZSmNAcOjmi8tTZ/a8YCFbFnpFqGFvwMR6Z926vpllZzUyBFl+xxeQDM9P0HJPFrQ1v2Dxg99QjND1IU0zfeTl07DI/Rb07nz59Aotix7fdBfo4Zga5QdE=
Received: from SA9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::10)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 16:20:01 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::7b) by SA9P221CA0005.outlook.office365.com
 (2603:10b6:806:25::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:20:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 11:19:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER_9_0 for
 Cleaner Shader execution
Date: Fri, 11 Apr 2025 21:49:42 +0530
Message-ID: <20250411161943.3323364-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
References: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 43948363-9751-46b1-e96c-08dd7914b599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWZHQWcrbnAzUHNsSzBMRGlTdXo0VHZuU3Z0dlp4MlZGR1FBVm1hSGdhZHVv?=
 =?utf-8?B?TUt5SkFjc0RwbThNM1BoME0xbnA3RmJFRFVFbEd6K1h6WGkrdDhFbGhHT3J5?=
 =?utf-8?B?SlNXejJvSUpveTUveWdNS2J5WE1WUGt6dVdnTjgzaU41dlRTd1lsN2l3UzFC?=
 =?utf-8?B?cDdybE1oaG1ac3JUTWFiVldmanVvRXZwZi9aVlJYMndwT3RabkZoK013SGpQ?=
 =?utf-8?B?TUZkNTRRaHVURTU4UzhCQUx6eFlYb0pFQkd6ZDVNWE1MMlRXVk5RWExlcXJF?=
 =?utf-8?B?MEZuajhBKzF0dG9YMG1VQmZwWTFoTXQzNXJjNi85WUhFTDBUYUg1SW9IdTU4?=
 =?utf-8?B?cC84dmhhck5QL2ZPT3dFeTFnSThJUG9SdGNEc2pLcHpZYWYzUy9sQ0h0bTNE?=
 =?utf-8?B?Y3ptVWhoMS84SlpQeG5sVXB5QzdzSXRIS0Z2b0x6SUJUeTBnekNEUEQ4a1dv?=
 =?utf-8?B?KzA1VE4xMlJtZXBya0x6bnVZblJ3bGJ4SlFHUlZKRnE1QW9sWmpadmlYTDc2?=
 =?utf-8?B?SlJaTi9hUGpEd0xSd3RsVThyQ25yaWhmTGJ6L2lYMk9hMFdRMW5wbHdHUmVq?=
 =?utf-8?B?OHNBYUU1Qnh4bVR5dUxFMERLczZ2Z09LMXBscXZJVFRsNWhzZkxoZDlJOTQ3?=
 =?utf-8?B?akxCRFBneEEybjlIaU9rQk9xMXpIaWM1THdpc2hIbi9lU3FLa1lWWGRVN3A0?=
 =?utf-8?B?eFdZdlk2SVRPUlYwTzBmUHA5U0YwdXZZRUxOdE83OWFNbC9BYm5meDdodDh4?=
 =?utf-8?B?MG9JbnY5SnFDQ3paWjJrM285UVpBQXhVOWdtUU5EbXl1VUMzVTRSdDF1NHR4?=
 =?utf-8?B?S0d1TzB1VTVpR05YVm5zaS9ZWkRJK2xtVGgzMllvTGZlLzFNbkM4WDVLSzd0?=
 =?utf-8?B?TE1vZS82elF3S0UyRDJodHpZMW05dDRaMFV6d3JFcHpQZGl2aW53bG9XYnUr?=
 =?utf-8?B?MEExcndVNFZydElVSXl5SXF6SHFFN2ZEbU9jOFM5dFZOeGF6SkY3cmZsRnh6?=
 =?utf-8?B?WklmbDBCbWV0RUovc2FrcFlhVG1pVGdpeVErNkJKK29MalFkNzZvSDRoUlBl?=
 =?utf-8?B?aHFXV1NwZHBrdksxWGg1c013bHZlbFFKS1JxYXRSOUlwWWdreXU2bmRBSGRQ?=
 =?utf-8?B?SC9ReW5zSmE1OWJtMnN5eUcrcG1pK3lNM1ROYjBaUjFqOWpuUDlMQmU1Rytn?=
 =?utf-8?B?WUdQSjQvdTdDUG5CcHpVajk5N1BUc0xQb2pZYnorS0J0ZWVLSVlxRWJUWTRj?=
 =?utf-8?B?b2ZqZmxUSmgvMWhSbzlaRjVaMFp1b1NxaFJncWFMSlBYcDZ1c3ZZOGNNUGMw?=
 =?utf-8?B?c1J1K294Q0xyVHhuUC9aL3pldFZsT2huM1AzN2RIQVVHeHVnOExyV0lPVDVy?=
 =?utf-8?B?d3FhdU9vdVdoeUpJSm5PSTVscFN6aEQ1NXNwbXgyS09iUWpVVDdsaGs3NklT?=
 =?utf-8?B?Z3hBTEtJM0RrSEZwVjdJM0Q4eWtpeGxZVkZnSDcwdy8veGduWFJ5aWlzdUxm?=
 =?utf-8?B?RkRCV3ZIUjhEZG10Q0taRzhPT2pwKytYbkJOcDVubGhkSGVqSWxyYjhjei9s?=
 =?utf-8?B?anZzQnVvbE9IRXZmRHFaYk9SOXBRVmdWZUJqQTZwbGZsanFxMDNnZkc4Y2wv?=
 =?utf-8?B?RmhTb2hRL1ZwZ3ZLcnhxUk50TTRkTDk5OFR0anhNbFhyRWt0NCtIQzk0VmlD?=
 =?utf-8?B?blRrdURnNWJPL3k2VXVtVWV1TmVZeEs5YVBLWUkvNTljcDNSVmFrcGc0UURs?=
 =?utf-8?B?eWk5NkFBcWUrbDhLMldvclJIc2JCdy9KOEJPNXdydVJDQXhNOGp1VWxQTkFY?=
 =?utf-8?B?TllLTDdDU0Y2bUppNnN5UmoySkpyTG1WNEYrdGFqb1hYdFdneEsrTzl5RnRl?=
 =?utf-8?B?NDhWTTBMYWExcDFzMDNRQ3VTRHFtOEZHNE9WL2txazd0ZWtiRWVpY2VJbUlo?=
 =?utf-8?B?L0RlYXB6M1Q3ZExOMzlKZWxYNlBHZmNSVmdSM01ZZXFHTWpzQjJoNTBPOWRl?=
 =?utf-8?B?YzJMVzZ0OUVxM3hLWnNya2M0REpaYTBLeW44SXVJcmZpMjIyVTltWFJEaTlw?=
 =?utf-8?Q?NlXUia?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:20:00.8766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43948363-9751-46b1-e96c-08dd7914b599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569
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

This commit introduces the PACKET3_RUN_CLEANER_SHADER_9_0 definition,
which is a command packet utilized to instruct the GPU to execute the
cleaner shader for the GFX9.0 graphics architecture.

The cleaner shader is a piece of GPU code that is responsible for
clearing or initializing essential GPU resources, such as Local Data
Share (LDS), Vector General Purpose Registers (VGPRs), and Scalar
General Purpose Registers (SGPRs). Properly clearing these resources  is
vital for ensuring data isolation and security between different
workloads executed on the GPU.

When the GPU receives this packet, it fetches and runs the cleaner
shader instructions from the specified location in the packet.  Thus by
preventing data leaks and ensuring that previous job states do not
interfere with subsequent workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index a5000c171c02..cf93fa477674 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -552,6 +552,11 @@
 #              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
 #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
 
+#define PACKET3_RUN_CLEANER_SHADER_9_0                      0xD7
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
+
 #define PACKET3_RUN_CLEANER_SHADER                      0xD2
 /* 1. header
  * 2. RESERVED [31:0]
-- 
2.34.1

