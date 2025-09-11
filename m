Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB0DCAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2D10E381;
	Thu, 11 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WFLkTrp6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310CB10E36B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjpYC/hcbCV/hrdt3foVM8T9HSuwdagEC/vtp6xaeovjZ8W/rhWpxaWWXNi0KwSlhA/lNWIWGTwHoG5MfGPNHbKsjDq5JbDr/2IM9AeZfHrRjf+Oe63aN5SANK+yPWWyr7iLt1ucgNqbUMYDe2wLB88iVwIV+zN/sCFxIeN1MeLZwuk+xOdLPFoangh4QAk2UICusWleMGTKa9HYtYOZhykehrhi7FdJtts67nW3OAH+ATxTGDt8X8P4Aqcb4KJxcy5vukt3zKZvjuCmEjsKHE3UN8FSeroGaEoNndwqjyzXsCytRSB6xhMOlWY8hMZvEIF37UGO/ZaaHEgoFG3PKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iioykc1LP5m0QL+879kdxDKabbel6Zr/HCajuuif+w8=;
 b=dV2M7rNpEdVZEVktXWVkwt+R6hxnXqnfAzF11vtByzaqrXngJnv+pbiDC3LcsgKggV8Rs3NK1mVB1D/TExsVniEbHLDlUFudw9WVqqubbTEcxqiJzgzvAfjt2o4ont36f3Pr3CuBpD5B9HS6KFA5VllhLbqAQ5LXNwnE/DrGzxAHlWulC4E3hRIYv1gJld2WssYroVj6QI73cOCf7WMHCAaF5mYeIeUuBJy503EsTBLP4x9vD4KVSPTNZKY0xMCVkRPh4EHiMHayrrwtDNINc3ksBLMKHNvuOZlapH6bdvSB99zeUBYAQtnnAsZkVOMo0EJBX9E5fy46NbgiFVWVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iioykc1LP5m0QL+879kdxDKabbel6Zr/HCajuuif+w8=;
 b=WFLkTrp6qD4j5S0LFEubXxjkRFHRuPpp0IzqhzNfm2AfnGyFwqVk9KnscYav/zrxlyr0u089lGleuFSJagkdetnYd8tnoRhjZXmwjHap8gH6vp6XjdbnHWzJr34NoFrZWQ/Ps1IuhU/7ldpuLttNtfHVHMTc+6pYnsT0HdGH4nI=
Received: from BL1P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::24)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:46:27 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::2) by BL1P223CA0019.outlook.office365.com
 (2603:10b6:208:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:46:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 07:46:26 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/sdma4.4: adjust SDMA limits
Date: Thu, 11 Sep 2025 10:46:11 -0400
Message-ID: <20250911144614.3338953-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911144614.3338953-1-alexander.deucher@amd.com>
References: <20250911144614.3338953-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d90c2b-9970-4c8a-5941-08ddf141fccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uEl3mDYblzU0cINTQZtTJb0R8ew6YRMzu202zRAzlR0rLG81Wo2ItbplQiJ7?=
 =?us-ascii?Q?pGD1+DuXGf0RmhlNRfjwAIoShvwZD/AbwCsUpjXQXOYgcl7qgSuZp5Yc/JJb?=
 =?us-ascii?Q?f7lh8TiyRaVdHl96IENJRUFDY5QsWgLYbOCJ2WwOGQdmb3vHgaEi8r43Uviy?=
 =?us-ascii?Q?WOwBHS1auN/XLW/LFMWXNpMT9+tyR5AA8n9Bb+kLXqqmZfdVj+Xn8mKUpZll?=
 =?us-ascii?Q?qwDKv23FnBZx74D04Qf31dZMCM1apgzGmM/1mR4ouJ38ux8o0+4imQNnWT60?=
 =?us-ascii?Q?dw4OKhcQSfyU0T93ZRJQ2didPeAbrpoom/zvtuOlU8zzlbH4MMlzVW04EajF?=
 =?us-ascii?Q?9tUBZf/Rd2mZTsN/byhbEMisFkfdC616+XCjvhWZt2hSQPcFQxsl7CN7obC9?=
 =?us-ascii?Q?xMKlc/+bEB9pOeBMSQom2T6cT7wXISV8n9jts8cK46daWmrFwjnrY9xSXM73?=
 =?us-ascii?Q?oAERJ7CM4u+oTv8RrYSjUr11tkmBrKKbg+bN8p3g5JoMHlZ4OgVBCpgyT4C7?=
 =?us-ascii?Q?gVZVK2/LEAywnOX+FS4NyLGcISaixKAqCiDivMBVaZAJJJhwNCkYIwuA7IAw?=
 =?us-ascii?Q?mVpwF2ZQ7LlvvBO3pVzSkcEzJO173d0VgO210azBis63zjUyO3US1tY0/x9Q?=
 =?us-ascii?Q?W63fl68W3lmQIu+snTmoi+FT3jjVFneLu/acymD6vZXoZrMxbfacxJJw/rVH?=
 =?us-ascii?Q?A9ylKhP7uBr6T8C8e8IyREiyTekSs1mQfPTrndCCV6rb5NOlC297lYBF24Y8?=
 =?us-ascii?Q?CblyRJDiLPjTVYYf/C4gb8T9ds8T9bU0079+NK35uDoWJFoUakethdO5cCgs?=
 =?us-ascii?Q?+UIDmcEinSfcLFOHIciOtfHnP8+Z9mW+VppJY6oNHEnh/JRk2i8uHnFymYIo?=
 =?us-ascii?Q?9ZjT58ukdOcPFdNAhE2ryb2hHGEnmKEqL98S9GyuUcKJzYfwDtsCiwGqTW4+?=
 =?us-ascii?Q?1g09Y1xMemZMRITAEPrrPawcMvHx6TBiyabVlHJlAo3nJRB4VP9D4NSWwAoQ?=
 =?us-ascii?Q?nbOs/ozfWtDBF8J0NBowlOHm09yoFIlCM+jexIbV+7EQz2N1RY+eEkbRdJpI?=
 =?us-ascii?Q?IOSyxBo+lvytjgHCPHn5D8NrRIvBzjYDtYzYBebEVsL2gDnxXhWBumNXTXXT?=
 =?us-ascii?Q?A5b5+2qH5EMzn27avH+FBhZPomKfrlb7AxvmFjCJCYGSuqBZCJkG1QH8eS+w?=
 =?us-ascii?Q?0l3VlgdXj1fmhKipTloYdm6yoG4v05LCYOR6t9T7irgtVkJOamM8gPHGMwTs?=
 =?us-ascii?Q?m+F2srmLFG4xiFgezHQWIgO8ffFeDggC1llPyFXOe3rY/5kohedYhxBlyo9Q?=
 =?us-ascii?Q?ThMSKycW0ZJ50EG6b1hHJ2j+puM6VBz5tLBcxOCCNNa2tStFR8z9KqbV5J9T?=
 =?us-ascii?Q?+jh2C9LRgDcmwlT7IpE2k80CQ7+9i5d9S0ODQEJL/qa0N75d/Akgfx6zfY3s?=
 =?us-ascii?Q?y7I4X6k4186O/8x8ks4GtIQ1LCBdWHC6A7y2RKPJ5ka7DbC+CN7sqDE+UsuA?=
 =?us-ascii?Q?A7pn17Z9TcSe6AxDal2eaN88lvaqmG+7oiWD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:46:27.2404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d90c2b-9970-4c8a-5941-08ddf141fccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

SDMA 4.4.x has increased transfer limits.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 36b1ca73c2ed3..35b8856ba8f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2298,11 +2298,11 @@ static void sdma_v4_4_2_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v4_4_2_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 0x4000000,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v4_4_2_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 0x4000000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v4_4_2_emit_fill_buffer,
 };
-- 
2.51.0

