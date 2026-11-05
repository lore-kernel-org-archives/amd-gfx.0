Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB623606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MWYAenho
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D22D10FFC8;
	Thu,  5 Nov 2026 00:05:50 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7308010FFC8
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/zWPf57nPYC+7d8Zh0tGmT6NXuQEr6X2YJHoQouV0w6MXuRcQu7R7AceVFnBZGlKGjAun/KkKmZumn1QvQz/QxWz0nW9Iv2R4Q4pApq2GEueivDZK39SRt2GuYIJ16EJQ/L5rpF4wLelhOkG1P3EGeHdG2ds49KRInp61VBmCYkierOzTyMA1Xei8ztzbeyShDWXZqC1ldP6MVd5+CQrZqTwE/E7YaMK39djQYBD37U4WEgGLz5fG0ZM4GmMzY1BekqRQ67YyOG63U0zqsfjnxdcvnDmvdt7HvC1lX6+ziDXo5Ra+NvNGInw+zNlB4xE+ETTL3ExXIrdOUNOlqbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2V5rv4YwlcUrU6Ee+HsGAM7aJaxtozfxzyN34qTu/E=;
 b=ls8+re/3n4Nd/ZCUkBEBijMkutScy1R8zSFm1W5XTgGfN3E3GqXGKwpEYTkL1V+hNv3Ns6vTiqapNFZScoBDLsEeowUzK83JFTKkpjeKvzyW3dTciQcawuvoIObPCJLFff5PPYzwNHb+i34mLAglVkjbTEyzSshCa8sro8BvY7E8+g3L093GOAd6jxughj1aC981k7pqC5jYBITnT/cr9ljfBzh7DrBgYwvinxLfvGbXPk1p54ZxptvnGTt/aO+XBgXVq0MSqJDnv6+/rotQL+z7dsQnVZ0NO/jezOxExA8gtiQ3waddAJprQac4MmXcoXa+ynm53PZzlqT/N69zZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2V5rv4YwlcUrU6Ee+HsGAM7aJaxtozfxzyN34qTu/E=;
 b=MWYAenhoXGkde38BxV9IMrAtIBpUnRLKY9lHvBuvFjtdTH94IeYTXVykeOE8q/Z4J2Vm/AWRgoxGSvqVuKQV48LxvlvMGtWSaH7lMYOmCpCNolZrvLNmcVtZ709a5l4jypmSmWM9MbQOMeZUYBuQDGTGQUMhup2Cx3LHT5kHS/4=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by DSVPR12MB999261.namprd12.prod.outlook.com (2603:10b6:8:41b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 00:05:38 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1b) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 00:05:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:05:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:05:36 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:05:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update mem rsv table
Date: Wed, 4 Nov 2026 19:05:24 -0500
Message-ID: <20261105000525.3850296-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DSVPR12MB999261:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9edd1b-9a5e-4c01-c29f-08df3ad08530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|18002099003|56012099006|11063799006|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Q7kJEurS39Rb5PIc4+hRupuyD2NwlVxiWaAy+vvEYxsv+EBImCxjtxEhI1U2Q1bphDpt/dVGUfiWf0SRQ8OoT6s0ioLtvGIbatS2Qu3/T+w5cOVZLn7dIcCphAjEPKpRsLN1g1XZOUUm00uHVtkGa9TuGOzSDngnKV6VZZ0CTZW1TGUgcKNszYGLB3X/kZHs4nyfteV78qQBlalPsedNVfqzdPl52MmEP+Rnr50aOEou/+mLdjzoObpy7gcuxOuQ6A7oSFWP4cr/UAp8B8HJfyPEZcspR3Mn8K+pVDoar3hdLBaJjb/E/6OHN6Qcciw8+IQBkWn5+kx7HOPb/oiHLk/e5kBfl9uxKiw4yQu7gQ2qQ09FLb/JWP9GvgNlJjC5LAy9JhCR290FupeJroNuncAGnA5Xasu34sfXkfjmOOluQkR1U2jg4onLOLmJKRanunt2vsm3jSuqrQQhedlLpLcTS7buYUmTaY9tCm7Rr0/pOP9gTNtSKuOLAs1HR0kZJe1ZbRyYFgX5VN6y9PhpOOfX5g7nZ/GdfCME0rYcAFhjQGqnuyelGvBdlHPIAKO2br0DQ2B6vEZo2oLSYOpjzdVqfrYWJyMSuj0cIqLR3UcbpmWkdNLtKr3tGb7LQ7Z2slx7PTQhyxVk/fE+bsRwapba4m/K5qrSSgFkoxwvEvmjQfqXfgaYngwVxEJR3soCMRCJFN4e6kKaVrj6z2uZXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tg/hyEU304ELuJAuTQ7lPA5uow+qqKqqbNrqM/aJh3c8jVLeZBOTSyLHMe4I9F5aXMEwTgaTjVKHlyWMe1nogO1nZxfeohvvc/Oepax5QTP46g4VQMo0hd3mRoxKZ6pFbO1p3msgMYot78z3zBwiCUcT+j9yZdO3zDZA2jm4o4hx3kXBC88poAXg/yayrSSuSmkCmgrbz0SUpmUIk30uM/wjq5oucd7n2nq6iiumwfSH4bzUZ0FqSVC5Ndag0PuDxHCY64p2CTZDy5PGCqQKTiVrnH22I4WonRrn67Px4ZQmrAomlkT5XQxPjxMgSfHDDp8WJT6hMgAzBqzK2kRscLw1xK0HktHcV39U3su0Jy69VHZvaSnb5Gi+QDswNWiyk8jlZXF+sGsPwNZWishWwn9eWTEr35vmjgoJjuDI6AHlGqqavmfT09sBmTuaKIKn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:05:37.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9edd1b-9a5e-4c01-c29f-08df3ad08530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999261
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

1. enlarge table number into 8
2. add table id filed in table info

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/discovery.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index f5629a4ad04a1..0ed270406208b 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -45,8 +45,9 @@ typedef enum {
 	VCN_INFO,
 	MALL_INFO,
 	NPS_INFO,
+	RSV_TABLE,
 	MEM_RESERVED_INFO,
-	TOTAL_TABLES = 7
+	TOTAL_TABLES = 8
 } table;
 
 #pragma pack(1)
-- 
2.56.0

