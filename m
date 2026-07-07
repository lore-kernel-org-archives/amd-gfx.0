Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F79C44502
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166A410EE13;
	Tue,  7 Jul 2026 15:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ssvX/Rdf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0286F10EE24
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coBWFncq87I8qYVxJHf5faOKw3g8pXoDWrgAyxdT8XIJ1aqGnbkdElLKHGwg16LrTshNYOyhEMAQfd2kYgxpf6ZOCSScQGX4yyKbdHbqCr7GjA5wXewKhSMJTQweMV4/pM5GWIsF2x87jUiRa3C3fVwiL14p+QWJqPROCXCN2+a2qR/emOqSQEO6H47po5b02xDj3yY6K6bTgUgcfnztrlGMtYly2mrj/nx1VkD1by1/zVMOhgyah1zKxpixT2fvs1q6sclJ+Xl+Jic2o9eC21ZiA3Jd+o3mtWUpplwgfiY0keU9l1B/LNu2dy5eQfpBBR8fCnWVrkI16DnWbvwRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+Etdx84g4ob4tf7f8tYjpGE/BUo+s25Ts0c30hhJJE=;
 b=oXY1MiKF6LNsO9YjGAPuZELMMogCcr2DisMwv4vNCzXu7/AK4jg8K5aRhSuCy91d1LJ38SGITldwgf8p/U52TkGHReekFC5/ech0B8uaqw/g2Yx6DuZm4cacCSm6RRSAmKQQnC8JeG2qEHba63b4MuSMNuybVmz7ztdi6QRd+/mnb5h63TBY6w0XG6MlFBdQPdPXQZ7WMHDRA4uYOPMYyLKBVZ/FiIX7o2fBMov8WV2i5cGQpxYT7A+cUSw2Nb6axO4xI9p49pOfehKex7Rgz4hd01+Q8TaGiArhPdqEu2xqMyQ2XzBJQi2iXodvGqXbj5aklFGhT71T7cJfPWq1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+Etdx84g4ob4tf7f8tYjpGE/BUo+s25Ts0c30hhJJE=;
 b=ssvX/Rdf6FvZ2r982KyIPiTuRu0ws8O8TyN2v6f5vTQKwR+DtmLudntjEzR1UqPO/Bcr23rT9Ohp+hjJv5bKnKIplKYQHlrwe4lu3Pcy/rjZCH/k+34wRAIjxA7ez85dVJJFQpbIDBehSp1rGwZZz/TC5j5QHZm742qDLHewLZs=
Received: from PH7P220CA0038.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::21)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 15:42:34 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::35) by PH7P220CA0038.outlook.office365.com
 (2603:10b6:510:32b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:26 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/30] drm/amdgpu/psp13: replace BUG() with an error
Date: Tue, 7 Jul 2026 11:41:52 -0400
Message-ID: <20260707154203.2603209-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: d28775e0-7ca6-4d4c-0553-08dedc3e5d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yop6X4xHc1JWE1a9b9gpm+6fv71YWLSkmcm+gO/SoqJHAS8IRiB6LKmL4JFL5b4ApWa9R4jTLvEHx+aewx7/teDHBtlz48cG105l1sI2+BWOJ4usdkQP9JRQwyIHwF6+QRz7NUsg+A2r/e8LSyGV7w5u6pJoudYi5gYuhezofYZyH3Cc9hANUg/qXXCa/RcShGm2958zVJjHpDYCT4ydmC71LIBaDkiH4gZ16/rVQqt9F01WDprAbuWjGWv8CQTZyUZXVFxZ1H5/7zfBVJqMD8Sjjvgt6q8qrkOj4rTlyhq/0lTCJbMdezXdH+f1h70SBLIp6T0LOJNzjP9Bl/UshIQ6mFQbgEyhcOV0nbNwdGEpge4lLAdRsC5jd08wsXTMPjbsxKjceYteK3IcYpq7yHx3AVJ5una1qnH3fgCyb7HkORXhb5ADWKsd94MY6/cSLg4SPStuYWf0w0X5KtQGSKU4uYP2d67EQ4kpdOHvaKtlMUrDhYkUHKuGvvAMmNnKXJoVDXQq0hoSxO/kg+zZH7GTuxpoh77RuZLvfcvQKArCbbpA7FVYzJQbyghTZ7yXXIAnsSqwq8VwsS22UjhHL+RzCUqwSuKQMhvtgd50WOn6Qz0gqdhZAO2dqxs0VBFeZXQ68EMra7o7g4Pue7a7FZ3qhoJOz4LfQZ3cEjV/lqMRMNIFATNNAuo1/15Y3mIgapfjB4Kw6m64RKA2u/qt3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VenDjJhq1xq/pssBgXNQO13lNlpxWGcwGnME+srtngayBXTzU60l6tZHjV0/ikwrZIah5c1QhxHCOVBoYwaMzn0ilqZ07qYWv8NravWPgRSKTGZZ8P1d1PFu5KPP0Lm6ufGtz4+RpdufN7nz6UGN3uww0034aovGoF153DLOMzmaeni07tNQqv+eNbEo9HrX/Vs87HgEbWkIfFvd6JfhU9xT6rTWPg9ZmLv9t47KlkG9iv9caFJ/ejG6ihfcx/lV4IDyeFVP7TTVkI2tVAupTiGgYKAu8fcuwGZt+hu/Oe1pQfOIenKc2CaH+tPy6RQ44DUzti8YYv7CIxEr7Kt/CcuacuPcIC2F1P4sWv5NuEBdTC/uk7rUFV74KabkrsAGAv2k7nXVkhol+hm2ThT7AUo/Km0UIv7Dbqru7UT39r7nPz4N4hvatiXgdyGyOCL+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:33.8914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28775e0-7ca6-4d4c-0553-08dedc3e5d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 00b4a34e6601f..4b0ab1025c2fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -133,7 +133,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 			return err;
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.55.0

