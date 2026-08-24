Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D6C5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A3B10E59B;
	Mon, 24 Aug 2026 22:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g3EfngjO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A7510E59E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVYvOvAq/pWjWS6Q3QTJNRDitxsYYD67ec1q2X+h37SsdixjNGdsWBTAM/EXAIbAfSHiJYBou//JpWiCB+t1HR/tmduV5j269D8SiuFydN15S0fDyN6w5x4ZKTQnJbfvYwvBKRc/HFpNmvomQFAaqSUxXheKqGf6ouCVzYqS43yuM5dXVaheNf1lndEStw3J5ShvaGFE3yuyFfV4zNZSFpHDKKUGZNyoOrGL9fIFwDXUPekcV6WZmFRR2mQiX4nnWYkQKR0U/iHTCh6nYczE3F6woA4FqAl4qD8Ckdy+P2sTnszMeKmi9KV9zUTTikqI9iaCn409g96O7tJrILtzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu2Ag9z6peX6eHKAQcwQ8GHwpmfGbJH8HxBYSU+xzNg=;
 b=x8uhJHe26PkX5593xYYkd659rKGKiFQInDXaarVhD9uQVYrem15wsFA680EHb2RO3d5w+DcfsCz8hJKXUoaPCzS4eleef4oqvfXbbwAo52EU9u7u1D6CtCjywPUoPW0oqTFi48aT3vulxjuUaWN98HxneKBZrlPopHs7UtyffVJqMsoOWhDjhZlMGnteKUQZoUHR3GO2dDOM7PKkgKSOS1d9QTPtB1c+0bOAxB8hfb1tonpeLk7VL/dkHDp8dABHhVYGMCkWs6kgHUIbpMZCUiFLw6WuoafVSUsSIB7BdXxvlcenWcJPYs8uvI219Oz2mVCzJGszVhtFZBtS7TmTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu2Ag9z6peX6eHKAQcwQ8GHwpmfGbJH8HxBYSU+xzNg=;
 b=g3EfngjOrMyaCsiWMvkFAJ1nvUVvLXy+pGoRPL0iW+933FkmPFxLZnYzBO8VCprvEYS8KQGzhu5tM0HLBsBQ2CGTAXJ1zoTRhkhoCRBM5yeTawMvYNFpb/8mihM2UKa6asGJag4GbUuwmKbIjjRkFz0nFlrFbD2vsvHCgxpQ4y8=
Received: from DS1PR03CA0020.namprd03.prod.outlook.com (2603:10b6:8:233::9) by
 CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:08 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::47) by DS1PR03CA0020.outlook.office365.com
 (2603:10b6:8:233::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/30] drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
Date: Mon, 24 Aug 2026 18:13:26 -0400
Message-ID: <20260824221352.1793542-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: 568647f0-c3af-47e6-bcbb-08df022d0480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eOnbz0KYrYGHYzSGzKl/N+ifA7zZyKS+i9ScjWEj3oBES8rNBqU5dspC+lVxlkVCxXRfSre8YFWqvtU0vxVom+r+vepIRqSHySVFeZGBOKGtrtycsQVmfWU0H9g3QSJb8fhHuAmPKfr/iCQYDDVnmvk0Q48pkHhwnqaO/Old9Bm8crCPq3zenfS51vGSsiTeuecUBR8yeCpqsunjDg5ZVNSnfcjoyPHeC7BABkQO+EXnYr14czEGCLltu7D6vd7Ts38u+SHccjuhMGKPtcN7+mTRM5sP03+JxHKAjOHLhNG0yxdAEN27B05K9AYj5QemBq+xVzTkIDwpRIKPOghQPv9qLrknqVXLiwVRGXrzH0eNwFi8UUOc3tB1166/RRqrvLxPb77k2S3heGBqh+hC9+f0WNU+3J6E/3ifQJO4mkC+zz50bA1nNgx9CofU45PNnqEV9dJgHahwy0/CT/EJHP0aqEAyfQ7GiEqfk6s4eRQ19t43VozOWyWEG7CqaHUhmxGg3SDkyJMURjcast1DmVpRlh2/G/raHZ0mxNj3h94WQnkbivrqVs1oUfIO0tTvCczOsYIGocrEEj/pBY+IzzcgZ0jKyogczIZGznd3uInYW+qjbVdvXE4p7B6YxVroJVMLbIt3uYwxIHLD9wfnSeO7BXqCvFNEh2e/1RzUboEb8gcYXsdGgdTL6ykiooxx0lRuR8NNhD5xZsDBhxKh/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lO0KKZOHSnHx/d4Nph/1Xieo267utmRjlujZ9DjcUo1QjCIwRMXCkG6ooMckrYLPY48NFEp2ZPii+aCkibiSl0LLVxcJ+sIi11djXHDH6+nLtH9/pTyMdMWz5gbGNvf9HSHXpyiuB4EJ/NoZ4Y5+ohRdO69nY/tQyYvkXzVsJgMu5Vian/BeC7p3hGeB+08rjcQBoXkf0QkOW6mu2vg4E2njJaj1NJ6dbl0L+ZHgjZzSLJeOFv0BUQsQ/96xct6XCmP5iYTRV+4jg7rGNuWB/yj85P/HZQV39auVbWHIkhlyINwLYIWYBI27hyaiwXCdr8I8Eig00mApC15FmJ/YPM0gxpLvtD1qGMp/Qywa7Q3mr/cj8IvUIOtp/5x5bQ8ECYQ+qDzDML1hrTB36OjJE4fJybb9wXaE7kQOFbG+DKbOAIofDgYsb+ok3/AfAtTo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:08.1607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568647f0-c3af-47e6-bcbb-08df022d0480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2c7e3eae7b237..3b7764b94de19 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -327,8 +327,14 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
-	return;
+
+	if (vmhub == AMDGPU_GFXHUB(0))
+		amdgpu_gfx_off_ctrl(adev, true);
 }
 
 /**
-- 
2.55.0

