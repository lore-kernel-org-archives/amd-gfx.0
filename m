Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE9CCD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E43710E758;
	Mon, 15 Jun 2026 23:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cIhFhZf2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC95410E68E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWI/Nlp6LtAlaVf7sj42ky/EksjeMrYLvYZtH8UiIVvr5qmaXh9aQZGMblQfPHlOf1mDCR3Qu/tgtGhKbHoJS9qvCOjR1YfdoCk3maVAvTV+VnhOwpwa05WANYDvkTPYLUPpdM/qSh62H6hJX6soKrpdUpMnC/bMl2yHvJxt+mzlSL1JYnTn8Y1VgozAQwIsNITBJudkvYY8rWyGn3qBA16iiNENZ7OHIXoZ/ZQoRiH2MtZck83mbj8cpsA0WOItkknmWpNNRqG3rpFk/JVtPE+KpzEEF9EfsJlq6kr1IbYlTLIHKB8p4i0WFWKGxCbyNLBRrcpvArdG86A5VpV/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DUtp4BCzxzIqDtlMTZA3MjKrJbuoDo63f5Jp1XjnB4=;
 b=KNqnZFLYkbe9axNcBJOmN8wdLb89Vo6vjkvf52kXxD/hfi5B4vWJYrMPWFu0CzYRTroq83wyAdcQo0D8rUcU5IbCXU1VwHpdVEr4xU93BcuRa96MUMz0JOknYlO48Xx9aYORoofZAwosrN+u3Yr9SNJErEwy/EBFxiNAHPYLHNKph981KDYIMe71UbBzZz0dax+pPoo7kn4aBu/e8yaz/0MTz5RDtTqt8tAYngZPEzH1tw82EhwBeIGRsYujO37BgYKhQoc4oND0B1LKlcM9t9T9r7uKFFPwvbInA0q0oknKLVDlR4YyMVxvPJyqB2b61K0EoGJmKdWICbqTLp41WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DUtp4BCzxzIqDtlMTZA3MjKrJbuoDo63f5Jp1XjnB4=;
 b=cIhFhZf2EmnN3h8KiBUArIfca0b209x7k2DyJYzavafdzrC4mOXooN40yclxFZ+8ihabN0Rsc2m7Ox0jdcKKV6w8xtSRP//hEGr77ezXyFmz64Z2/lJY1gfFz+oapKTpTEP4GAzIGvtV23mO46JhucdeiDfoNOr4sp3TP915JxM=
Received: from SN6PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:805:106::40) by DS7PR12MB9044.namprd12.prod.outlook.com
 (2603:10b6:8:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:01 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::77) by SN6PR2101CA0030.outlook.office365.com
 (2603:10b6:805:106::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:56:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/43] drm/amdgpu/gfx11: WARN() rather than BUG() for invalid
 SDMA engine
Date: Mon, 15 Jun 2026 19:56:17 -0400
Message-ID: <20260615235645.737189-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 755049e4-d3a7-427b-cf0d-08decb39cb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: bjs7QAPPMnlk3DADGe7gTlcuipaaCRrEfwFhnFVh9ywAsVZ1+BAeRcg5cuH5Y5HVJ/OuhJMemCIXBh/9BgKl06KRVhvKT3w2EE5DdcN1StUaukfCp3yIgZ8g8QlpviOoMsemkR2Bk8M5MLOlJ/qwoY7xyWhR1rUMOzxP/1xumODyo2cgtAB4zssryTEgWYprQYJ7KSbXa/HuESUgz9HJfg0D8vZN5pXgSOiBeeC+znlyyyvt5Roa5f8WZatXxz1uDFj3KXRcUWhCwI0yiPSxeW/n7DhLzO3FjlCqS4oaJkWGkT98StAAmro3cTPkrLa8fCQVJIc+lsUodW8cUFUzqjrk0nWZb3YcTcmnsGmzINECvgHHGB12MUTR6S3cmGrbcX2ehn4NoMoJSteKwB8pPn2HxLPaZ7A5wz8QyhXb1WlIM6nl5eQNgdrB2NH3yCInh4YIsHyeRYOYtbRjs3oRTlDU8xWvDzqee/mCh/an2wqOZGiwWg/JWkGZKI1m6n+E9oGR0G1/Bgn15W5fEqApvij43iBGeFtqKruuiGZcdymwMesX/NjY6qOYcn/m1Mmjz7rH7wcWViUv6dEvae59VWYfHOn+srFQ/odGhoNDW1bgcx57c4VWOuJIPQGJtcoRh8qQ/frdYeirgQEL/XmIVc/tITceEvkcN9xCefSMGfE+yN3W8nj7lMnUU8WM4U/4efeSkz76qTgaCucXXJ+T563l9CSDd8LaebCcM1948gM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: biQWyu6mn5LsYv0IhqHZuVA55GKOdmelgvn+BDSFt3ldXP7AP/Xj3dHI5KguzqTiLfjX5pN78b9Pa+8Xvm0JsstXJPKHyVdFeFEzj1BXidXqMYLvMIo0rc6Ls/LFIwtjIrG1M/MtWh2I7CYZPvA/oLCpcPqcxiEuhibScjulY//xQanLCn2MQdoGHI3EpgFVtbkeVjcDK3GKH09Z9zgzcee/42o1Qd9fLkUsqXhfooNy7HjJSntWfN4Bfh976Lo3OvwXQi5PyoCuo8FZpxvR5L2/SrWbD8DXQVKC8yS4dMdds1qKGcdBd/7PG9860OCh246SD06MKtvrv28pYZ6OwlHzAU5WCVbnJZBmBgER4vadImZ7PY9Cd6Vc3qJiaqOop8o9iHfNPPkblZ5bICgCI25W49XOBsygPnDdWyO8MAkrU5N0wE//IsZzPPzWe1GP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:01.2936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755049e4-d3a7-427b-cf0d-08decb39cb12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index aaccf0b9947d4..d32ea91eeb343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -139,7 +139,8 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				regSDMA1_QUEUE0_RB_CNTL) - regSDMA0_QUEUE0_RB_CNTL;
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid SDMA engine id %d\n", engine_id);
+		break;
 	}
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
-- 
2.54.0

