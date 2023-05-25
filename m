Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6B3C7EE2C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 08:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED7110E830;
	Thu, 25 May 2023 08:51:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9DE10E83A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 08:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmTHE8X6VnToGSJNRk1QyOjG6SuBdsNvn//ShA3wHBSA9voPqHm3dwMJC1nIPqEfur+f8EGKucUDmjqxBuoq571IzvEAlYzSSkTZNBJGnGvbdBHmoURuGXOda6x1LsiBdJVUlV6m+DYlbuqKVHHSiM0Y134UoSP3ZStLjGLBWkoTHBQ/OLNqrpECSrkejsB2Em1xm+ODb826+F23ZZOxplDiQzeYRV6pjKKrM9XB7Un3+4lX5M11CiADvGdnlHT7FqQvBr+wz16u2lzaEQxKc8GbdG9SjZWHB/lKSxGkc2Qr0R0ay8co8GroRSci6htE2l/uBk8ZAbjXPaMy9r5jlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSpKrikzULXl/SjZubeq4jsbJReWQarWzoFHiJl3wC8=;
 b=YN3rPXxGddEJXhML+AuxTEkau5MYHtM5ZnG2f3AwsCe/z4ql2szwhJSz4oS+Uqfy7//6WaOj6IKiI57IY/yItidityrVHcmLYj0D2nfzJwTaBczv+VbcxdnLz8C6/ovMe7gejiBUOIG8x24ppNLRTDzl62zIHmPWzuEY7XkuDw0FefXzBs2uQZW5LrWr1tcrBcnPLwlryaubrjahdo08ZiD9ID12m7gUPQpre/dOQWL1eeHyk1EUJ3krGsSiRtwnr7g4+FyR5XVN5Lx04JUHA2j/n4GC7Q6AkoM9lMnyuc5vdfxRlImCmifYPOK2WbBq3zd3d9jCPhox9bDA38rXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSpKrikzULXl/SjZubeq4jsbJReWQarWzoFHiJl3wC8=;
 b=qUW00H5ZgoKoUbYKzGKmivpbM4j8ldKm+kNGMLueu5v9/w8356KGk88UxB4ez4dGFfDn74aRMfNrE4KUMB2bcUllbACg1eZ/59EWMUUzWHRSJiqMC4/9ty1rd48GPGkEebjpFquLmco7knYOoQdykK4w6W04PE40QjMZLzQAk+0=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 08:51:13 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::1b) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16 via Frontend
 Transport; Thu, 25 May 2023 08:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Thu, 25 May 2023 08:51:12 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 03:51:09 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change reserved vram info print
Date: Thu, 25 May 2023 16:50:26 +0800
Message-ID: <20230525085026.1316196-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|SJ0PR12MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8287f1-1f74-40a6-51f1-08db5cfd3195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbSygCV1kRogUKYtGacrsw+yjPDm7MIKwhiwS6Y7QJw9iycvn9+wZX3GiVOCf9d4zEnFK4GJtrD9Y1pOtO/ANLWRfH23SepRk1+JoNVh1dSplM/e2x/ghAbHZZS6OHJ5sEMm0b3z+ZqzERxKHb+4+v7MloP6kop6SK05UAa1A1idxq9IPOeciSEjlSfkP0e30f6Z8nL3MgMDDEQiAahsLj3p49em//JYoqdXQMxxBbZ1TyiPbe+terLBFLrzBQVI/Jn+wMheDs3GDJpv1tW9sdvNrUsmoHxqoJOKLFZbFa6gATvoHJ9ti2pPE2aVBKDQSEm1pKe07HihvCLf0ZYN3lGMFRgWHuVZoye6IbeBmdXIkPGn5WNGd8XNHziGZaQjjzVZkKwRLzUK28JKc5Aq3IwYu5oo07OsK13dsYtxbMt4ATDLK1RzC8Gzvf8WH8Uj34733xLnNEaG8S2ygF17gCF0M2H075ymvpiYekTvTyxwNPY4N6l4LoxojEQLHQlLh+TahOekdOAPlzA32uauKnvezDriXmHsBYNfixerALobSQ/vRONUVxVkRZgyd/OBRbmhYxkrSXwSX1ohN7YDfDmQhs4kiii/ZMuJDKBBOBJsRuUrqUGlgP+i965gFruHHCtEzivBgrjVQeWL863cshSQqft2AcDKEU4/YKGkYwPC2tvpW5uC0K127uHvz9moJMMsT2pBS6uY7awd1QLI2rzV7MtrZoejr3Jv/StEQhxMjiD/oxpuZzQcTtQ/5eqWqqkOnJjggPz6VMFbRTM1Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(8676002)(8936002)(16526019)(1076003)(26005)(47076005)(83380400001)(2906002)(2616005)(36756003)(426003)(336012)(36860700001)(186003)(40480700001)(70206006)(70586007)(6916009)(81166007)(356005)(82740400003)(316002)(4326008)(86362001)(54906003)(478600001)(7696005)(41300700001)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 08:51:12.9845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8287f1-1f74-40a6-51f1-08db5cfd3195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The link object of mgr->reserved_pages is the blocks
variable in struct amdgpu_vram_reservation, not the
link variable in struct drm_buddy_block.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 89d35d194f2c..c7085a747b03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -839,7 +839,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &mgr->mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, "  vis usage:%llu\n",
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -851,8 +851,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, "reserved:\n");
-	list_for_each_entry(block, &mgr->reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
+		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+			rsv->start, rsv->start + rsv->size, rsv->size);
 	mutex_unlock(&mgr->lock);
 }
 
-- 
2.34.1

