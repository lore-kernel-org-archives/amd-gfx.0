Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BBBC98328
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 20:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC79F10FC29;
	Fri, 25 Sep 2026 20:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="REYWtLL9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EC910FC29
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 20:12:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm0KEB5YCADh2Mw8VdOH452e53dTc2SCARTFHZcJtBP8DnJs4qkycJzLn1wWF1Sb9uY13eVkgCzogzmtMM/KGIyNqKEUoFfYzj9eAX4E8763kkKirzUAr4+JqTZqfISkJfR2YldrH2aBczlpBOC69qn6lKwl6PsLrG80PGU1+E94NMnVRzT0bXnZhqamHAMe8R7UrkZpYfCEo7MHQuJ642TbQcDu7Z/vD+WBtb9JNL/hw1JL29cJ27XdByUsREyyVNk8ayfq7xL0CR+4A8+ww8X359asELT7TMVcBOu40/HSGU4IthnqwSYRxhrKcIitvT2FuXHnQMACLmcnyIjMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obXLHnfH7HWShXY4j1GQEJXVRoJQCLlO6+HKVt48RIw=;
 b=C5kw/yEnOiitONhotf2YbaPfoL9rNT0MgRdps0GFihTTOxQan4AtKwagPSwbZJy64D/ibHzW/l0BFZQVKNHp7sHFZ4YwVv0Fu04SpaS0GlkcvcVSBFRiGGOwIcc904ItUMYbwbuzipzWDDDxdJJcM5N2FgbyaolU9PfXeFzYLvJUawdwGbzEese8pToDb5/GgXaH1/r4NyARjqzTEGAqsWf8Gc0luBnqwLUS44ShsBANMwHvR/t+bvS/+fch22DJlNQQ2JqCFoVZyEeU4YkmoLWGQktgVdAx9R3/qOK6NE573Bscitl2Z5UcqvfEoncSVqvHtAyTGTvX+e/26bXnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obXLHnfH7HWShXY4j1GQEJXVRoJQCLlO6+HKVt48RIw=;
 b=REYWtLL9cQTYIlCjdq0SaYvJGuvBa76HjFt7q7QfyxWJFaYvWIIwRdyCdRXjyNSFTRL4MR2VgeOP4AlOU8aec817Ul4zTqrD4wulXcyyeYQl23bZPnjf2+trm7pUd/xNhjDxC6KvMEXI7VPY1xSLlIOGY4iQD5veOl5ED3IgSGs=
Received: from PH7P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::7)
 by SA3PR12MB801393.namprd12.prod.outlook.com (2603:10b6:806:53c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 20:12:37 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:510:33c:cafe::47) by PH7P221CA0038.outlook.office365.com
 (2603:10b6:510:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 20:12:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 20:12:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 15:12:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 15:12:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12.1: properly pass flush_type to
 gmc_v12_1_flush_vm_hub()
Date: Fri, 25 Sep 2026 16:12:25 -0400
Message-ID: <20260925201225.51853-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|SA3PR12MB801393:EE_
X-MS-Office365-Filtering-Correlation-Id: f31d7797-2370-43c1-4188-08df1b4157f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: dAiT0DCY6gByHPVA7tYQxjb4G0m6GktkH9fLmwr4DzLLD0AzJlsSWaa0C743m1lE2BS9LZoIXYg6oTwZjoRrONWKWD7S/CTJSqgOQu0aYU0O3UiwOpJljHXBa0vuo//Me3d70TkGkjH7NiDwtSEsrhP1xGnag4NjC7biCBKCxjEoam6uDLIEIPQG1gNRASIxaWLRgZaUPl7fAsiKUd/pW6po+tSqshd3mjKsBNu/q0Fdzva+69d8WHzG0WJWWiAwdOBzwz/gciGP3h9QFKBNQ9fadhKwvNvmEUv4rmQ0yPdRvri5tRKTXL9MkF0c1L74mF/xSr0HxaCSKxM3UGaVhe7FSFCH6KslC/MZpmclikWf/yH43sPGk45K0rc4jRjbYc1PjnPYKo+QRQbL7fTC1SmauRfiy1QjAu8ytulzRrHc2GlSGiXBf2XgA2o1ZmJgu6mAeWxWfSZVX52nrMlTARJUIHzh7aO8FYjwHNFus++e6pu+y83IgkePaH5FL4lcJwz43VlUc4D/ZZiivanFn04x0W78pYpZ6x/13mhpv3wjLCKXap354AdZwYgRZAivNVl7qeFWye+Qyx0WP75vodNA1DHertezte8JdmsGB833q7Mesi6d4M20pVe514tgGvjpPGF8L5MYfW9O+NGiUSpjsZGM0Loic1gI423JniD0jV5hnEWRRbdSUIt9vWtu9TgM2aUybBeKj00C9QXVcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xFXlr638KnKEMnsRI6SRfHJxe4OQJ3cvpqnoZP8Bi0Wi1mB/jolbTf+c80jlM4YeuW2y+rDIeT/R2g5lax1v1AwfT8yHWVJZcNqemL2UhyjZjf/z7UbQ+fBMFH2Bz/Ag+iNXfpA0nX7/nz08hOHQY1fhWHS+Zmtox0v4/1xbf9U0beTNnkOAJUNgt/IAQfgWiXms1XkVD98sNH+6PBbjNkVL2iazRn2ynTiJ6y0sdjVywOi4QO2S29oIXg0Cs32XApEhnYTe2Jn3Z+rkdGt+Ef8fH5XNkm20FNyNdoYgLb6NSX9uoB3IoBIOCVALKYGt7861Kxe+wi/sM2KR1wZ7FP3VKk2jVCH5Ciy4ZEouzz79razPWNMuEhloP9M2sEHkumRbM4Hc1jZDnD79aHd5c7J2APF4eyDyrLNdMBEgg/KMkJ8Eg2NQCmuQTdRgdqa2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 20:12:37.1337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31d7797-2370-43c1-4188-08df1b4157f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB801393
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

In gmc_v12_1_flush_gpu_tlb(), flush_type was not properly
passed to gmc_v12_1_flush_vm_hub().  This only affected
the MMIO path.  In most cases the flush would go through
MES.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index cfc46f912d475..69f45a32234e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -389,7 +389,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
+	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, flush_type);
 	return;
 }
 
-- 
2.55.0

