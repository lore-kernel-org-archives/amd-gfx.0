Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEFFCD98E5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABCC10E775;
	Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pm1+v73O";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E815410E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKxwN5/ehx9Tnp0XsyF6sAseRxjYdB1asAyVfGv8gl1dI8w63LWWora+47JjP3RwkKwupTD0ZITmhGi1SNuPSxZgYfq8tak+SzwFUbjEksK4DZXHQAYllW23IFkWq1DgVHOtlFgzZpMl7uKLVSWnXBtA1TMW4i8TlQ2E+/cGhQIX2MdFNY+ahkd7+6blOmVDMzr78PQWI0T6gcPSAH7+XM3E5Rr4N71isngrdvlJjXjYSlNVSGviqRTsKofJU7RUCkC68gDoF+yLZWyOtoAi4HPhPnjTLn3o3bK4KMwxgJ023keaFXtkWnv3pS+5Ri0z4oEwVgc6NgVsI00+9ba2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ompcf7yCti5a3G4ZcKnVfhMeBlfuYhqHFUY9BCWtkU=;
 b=uIR6L9OayTu8T+JVRxLbyGNVQg61PdUZUVhQhucodxrQSIqmkfjsnvr2SQGV1Z9E+lgcAo6F8uhaA8G6nfCApBl5MnZxcJGtyQA7sDeRAyvMkpFutCbANCqyMnkOdwfuVVbjMK0ZA2/ZLXV91c/7TaP+vIFn60eBoJm/EyGYRuV7uACi97ExNMz0afwUQE98MJ5VpVR2itJwVMxwM+McMLuwzuKAiNvCKhnzhRNygkaoPfvqdMN733b8KLoKn8XH6eO1ChuKfKCB/yYO0jqcI0vtLiUgpDQwDlscijBQH0flONq5tzP2CKPvi377AbKCiFJ3QJb6jcf/W5T0YE5hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ompcf7yCti5a3G4ZcKnVfhMeBlfuYhqHFUY9BCWtkU=;
 b=pm1+v73Oc1N7WVz+WOlzgCAS12YaDX11+JYunYMihSX9f1Xp7xRJEaqiYoIAB+zRC/5Tp7oG6737Jb/TOKPWKWgKmBE/N72ovrwRM810Sd5nAu/EcDFH94+0MHk+Q7ydCAtD2Gn9kugTtn+GktCJ7Bfc6fA57mRB71Nmv3sFZro=
Received: from SA0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:130::11)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:06 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::8a) by SA0PR13CA0006.outlook.office365.com
 (2603:10b6:806:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 23:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/43] drm/amdgpu/gmc6: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:27 -0400
Message-ID: <20260615235645.737189-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da34d35-5b21-486c-0fc5-08decb39ce01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 2eN+38pi5CqyDC1uuQzAZFTnF/q3+fq0kWuEzDW53CbKHXEfJo1+FvKFGWGZGVoHZmemxYm93j0NOQi8pniXPVaDw4MKUM8V1Fa6rS0a7jFo/L331sWymGPQPE2AwVgyjvc97w3KxHrILtOMeb9O0aIHOlEBhWHp3k7l0ldJW7Yj0HFdTvmuJTUvLmY/aBjHfrdWSjGb0rQL5EMF5ozx1Ml2T5NpNt24WGsw/jkOCNPt1coxD/A2dnYrZbGMSQDFFvokTJWYIMCktyA9g3imwk2Iz1hujBotVS0zLFKnmu8zQvVD2HVsq7/PZyRR09NgFJqANb9m/tPLEekUfoEfD2CHBxs1Q0r6cB/dqqjnE0Db2IJf7gvokaDCUr137ucfp6seAUDFGgW5f+Aas40Cn44hXfRmJm+YQ6DZVjuXdpaeACWnlCRCQ6fw+u7EkxltyRuVtWzbGrN2nviDBp1xC7z6hj8QralaMZn33vm4sZT5eghW1SfM4B2elVf4xiO9IB/GifwOUz6YeEIyLG0bA96AhWi2IDXbkIeMqafVFZ1XP3mBk+KRiNH8+1FB+/vYfdDkNyPibtAuthhc0npfpmF18k98l149h2VULzkqdT9wjGWTEBRtLiSO/Onvrrj4OLseF7dOWfNgCIdvNUMA0Ywi5qE0Cobhrd8zxkMqpGz6BbmqwCB0jkrCl2DoWgkyAEpDzRg002yd8v0kBv4SMwZm2m7UxYdZD/C0btbm9iw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tbPqQ+zRfX5zOXUOar0cVsRumgIwZHroCSPfHUt89pZhI99rMw87ugYkgiSnUDpesNyZ8hxMuhPjyeABxv67iT4a+8kdy2OSsvyPG9eIf8H/4UvLtFRcm5+L8yY3L9Y8tm5RaD2PpCV+zAryY9yc1oD6k6J04GCvZJHSpwK2VioWoCH29RJcGbjpwxoDMWIZKVhhDUPloyEqOzEjbXkH4yPS02ZrZckA8Crdug3Cl2K1Fa4pAa8CJ1pr3INFGfAtj4PGkw9BRYFkffuuThaDpl36SiOdkUI87gW2HWukzag/zdmNkIWuvjvZHG4LYCnxGWrvPntyuiaw3tbTv0FQxnjtmOIBegGF5MUuSSjF9sTfJOdMq2vaWa5XWbCqV5pFKpRDEjaQYiBgiITi6JP9ClkVzQBcbI3AIVULvUoGVwTPsOaehfP8sXvaWeytU+0U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:06.2308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da34d35-5b21-486c-0fc5-08decb39ce01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a914dd8183b58..b49098931d197 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -124,7 +124,7 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "hainan";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	/* this memory configuration requires special firmware */
-- 
2.54.0

