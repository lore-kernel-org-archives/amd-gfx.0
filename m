Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54394606A325
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5SEmfTuO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE4C10E8C0;
	Mon,  9 Nov 2026 18:47:12 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C459710E7CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnQ1GmIpvLuSRGoP9WB5dAcr7K1JBxcJVe4U0JpesoWnRiXSuyFfL0aUciWu+NQgmpMS58v04vWuj172zr3TI2D5QsxisGSRcrt2MNVfoU3TjL10kyGh4Tnsw961sI9wqfJv2j5tA63ZDv399l2sg7OVHsV+53fOi0mhq0XcjFJD87UkkiiJR6Yu+nO5n0PPMTwWTrL/OY6jvRfdeMRgaFAvsmgTdScfXP/BDfGd/ufhoW8h0Kv3ER15OQS3XWkA7Q7wWilKizOF8qY0haY4HH3pP+sdFv0kTWPZ52YYfq6VhlVN0n0dkESf+hazOjI0hCBpm+C0Mgy4jy5/ir4ZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzscsaDUhSgLOtapEK83mIZeLPW7tq8B53n4beP5IBI=;
 b=hPif4ucXwlSBt2SnF6771x8n1rZqbvmDBrZbAS+xUWcRmcBrfSc6jPHyKo7CHG2YTSJ/KjafibixDLaIBPQ/V6zH2Kh2kBGXBRJH1NePaYD5yMg05DqfHMsAFH9aBAkNQGioQQLxzpwbF1U7mF936Z+di3QfCZqqQiV6RtXemdpePjroH7QQM51OsQmCWWjl1SRD0mVy7ACSy5LPl0JZiYd8Yq//6yqxNdBQiNkxVlFun8p2OwxIjdKyZIiVXAexJcsR6tuc4PIuc6urvVz6mHFrbL8SmPgTtwUF2++MRvUEQbN55/UsrmjCjdnXblrXuxystoZqDEGUe+xJ9nggzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzscsaDUhSgLOtapEK83mIZeLPW7tq8B53n4beP5IBI=;
 b=5SEmfTuOllKxw6dGPaXtcJEUZT5tBFN4MM/RE6uT+Srpx+uJPCALrGR10gkwvvn0i0sOl+R0QeWWHO2qfT5PGct8W6RLKE5nouZxXHoRxPetaI4lXU+nDfEOU+Gi5dBxDP2455HqPLEPegc86w7zym9auIO3FffQ2dKTE3nse3Y=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:46:50 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::52) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:50 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:50 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdkfd: Add CWSR trap handler for GFX13
Date: Mon, 9 Nov 2026 13:46:36 -0500
Message-ID: <20261109184641.3656885-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: edb0fb63-6b39-4a16-a426-08df3e91d113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|10067099003|261028144727099003|261102123227099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: dlaJ6cwMmj9v47SpsL/bCxGtWOzBfqEYuvy1UKxh66IFEsfpBfoHrkYYRVNt2cP0ZYFpl8SHKJFlMljjfXyKQwUSweszVnx3VCu+OmBZqXpNspczfpISpFFFwQ00MUEcQHXQM8YxWNELG9CdgvzX/d8FH8bp/0tIPav9dmoryouk1xPYb/iIA70ZXOEUb3yxrWlRpwG8RGxjeNdEYPxrqoZg8aSldQKLyyAQMf1sc/ar9J5UQAvsjD4TF342NhRNw7hcMLUJ5HwejCGN9k5fssE+1q5VVh0aWElQXxCMex+fnTV8tPEhRUn2P3js6IKBTUXts8AJV+pp/iOLsW6o+hZuk5BPLuAEBw8ai+xTa+VTJJ1SlTFIogUYTaDgI/p+WYNB8gYUdLbxXK554ux2LwPnLThUEGvU3gQPJt87GTHqAqF5/9uFF69M0s4Ilr0g2gZAxZxbPY3CMz9zQJOnyg0rjS7TgrzmdwA2Sg0pCIYGqfIzpJ5BXs28aazhiGS4YODYdKUeeygFwIftw72bQbie9lxC8eN1Mj75bVeMTC6PLPE974o1BhbFIhHVAlUjnndAnuPZeFgYuT5JPza3TfgXKcAQ8LsMK8RsAjTpOX8tdItf2wSdDyFvFN0yvW7U6irWyTYx07WpZUNF/ADzONKuwasWLYMSFCWssPz1oYM62mhMHOx9zl8LJ7AHpe4dfsZn2mGPdR3j6LeXynskRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(10067099003)(261028144727099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CkfBAhKg1r/87/M3vx22TL0BqABoITu7m1tkQl7JlIzmSLan/zNicus6nenMFssM+LZf57Yz8guVWduyuwMoliMZcg4Oi4rr5RpkaduJeXvfR3KQDV6nTZUdCPz+PjJC3fA9fIwWcgKZCkyLfwbE7uRjGmo4ACS1/qCoOs6S1Mk21sJH8Avb6L6FugY/aVVN12FZNwH4+BiIfI7Wup2sqKvePTS6CdxMUHdVIZixH7D5TaiEIET2852Pu2NHMgCxZWrhfJm+Lr4kaKXfrPe+5AjLFFRYV12MH2tZ1AhgHSWAMdICBKAxP1VKF3mDh/C9jf347MLqJkzQuGyRQ3DygMCsSWezAUCQ+5h0jjUrcffD7uOfeg+LHreTFeko2XyW6T3mM68ZLd0zHNNkZqjihi+0ibI40MmOPQR3fa0D7nQy2O7JL09m19wrRBUUJQWs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:50.7515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb0fb63-6b39-4a16-a426-08df3e91d113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

From: David Belanger <david.belanger@amd.com>

Add initial trap handler.  Implementation provided by Jay Cornwall.

v2: Remove non-GFX13 binary changes
v3: squash in updates

Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
Signed-off-by: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    |  568 ++++++++
 .../amd/amdkfd/cwsr_trap_handler_gfx13.asm    | 1181 +++++++++++++++++
 2 files changed, 1749 insertions(+)
 create mode 100755 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 5d468460f532c..cad6d808335b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -5994,3 +5994,571 @@ static const uint32_t cwsr_trap_gfx12_1_0_rev_1_hex[] = {
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 };
+
+static const uint32_t cwsr_trap_gfx13_hex[] = {
+	0xbf820001, 0xbf82028b,
+	0xb0804014, 0xb978f803,
+	0x8a78ff78, 0x00008c00,
+	0xb97bf811, 0x876eff78,
+	0x00004000, 0xbf840008,
+	0x876eff7b, 0x00000080,
+	0xbf85001c, 0x876ea07b,
+	0xbf850046, 0xbf8e0010,
+	0xb97bf811, 0xbf82fffb,
+	0x876eff7b, 0x00000bd0,
+	0xbf850014, 0xb96ef812,
+	0xbf0d876e, 0xbf840002,
+	0xbeee1b87, 0xbeee1d8a,
+	0x876f8f7b, 0xbf840002,
+	0x886eff6e, 0x00000080,
+	0xb96ff813, 0x876e6e6f,
+	0xbf850008, 0x876eff6d,
+	0xf0000000, 0xbf850005,
+	0x876fff6f, 0x00000200,
+	0xbf850002, 0x876ea07b,
+	0xbf85002c, 0xbefa4d82,
+	0xbfc70000, 0x8ffa887a,
+	0xbf0d8f7b, 0xbf840002,
+	0x887bff7b, 0xffff0000,
+	0xf4601bbd, 0xf8000010,
+	0xbfc70000, 0x8f6e976e,
+	0x8a77ff77, 0x00800000,
+	0x88776e77, 0xf4603bbd,
+	0xf8000000, 0xbfc70000,
+	0xf4603ebd, 0xf8000008,
+	0xbfc70000, 0x87ee6e6e,
+	0xbf840001, 0xbe80206e,
+	0x876eff6d, 0xf0000000,
+	0xbf850009, 0xb96ef811,
+	0x876eff6e, 0x00000080,
+	0xbf850007, 0x8878ff78,
+	0x00004000, 0x80ec886c,
+	0x82ed806d, 0xbf820002,
+	0x806c846c, 0x826d806d,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0x90788978, 0xb9f83243,
+	0xbe80226c, 0xba800151,
+	0x00000000, 0xbefa047e,
+	0xbefe4d84, 0xbfc70000,
+	0xbeee047e, 0xbefe047a,
+	0x93faff6f, 0x0002001a,
+	0x876fff6f, 0x0000ffff,
+	0x876dff6d, 0x0000ffff,
+	0x8f7a9e7a, 0x886d7a6d,
+	0xb97a025b, 0x8f7a9d7a,
+	0x886d7a6d, 0xb97a0742,
+	0x8f7a9c7a, 0x886d7a6d,
+	0xbf0d9d6d, 0xbf840004,
+	0xbf0d9f6d, 0xbf850002,
+	0xbefa0380, 0xbf820008,
+	0xb97a3b05, 0x807a817a,
+	0x8f7a827a, 0xbf0d9c6d,
+	0xbf850002, 0x8f7a877a,
+	0xbf820001, 0x8f7a887a,
+	0x807aff7a, 0x000001c0,
+	0x807a6e7a, 0x827b806f,
+	0xee22007a, 0x380c0000,
+	0x00001000, 0xee22007a,
+	0x388c0000, 0x00001400,
+	0xee22007a, 0x390c0000,
+	0x00001800, 0xee22007a,
+	0x398c0000, 0x00001c00,
+	0xee22007a, 0x3a0c0000,
+	0x00002000, 0xee22007a,
+	0x3a8c0000, 0x00002400,
+	0xee22007a, 0x3b0c0000,
+	0x00002800, 0xee22007a,
+	0x3b8c0000, 0x00002c00,
+	0xee22007a, 0x3c8c0000,
+	0x00003400, 0xbf0d9d6d,
+	0xbf840004, 0xbf0d9f6d,
+	0xbf850002, 0xbefa0380,
+	0xbf820008, 0xb97a3b05,
+	0x807a817a, 0x8f7a827a,
+	0xbf0d9c6d, 0xbf850002,
+	0x8f7a877a, 0xbf820001,
+	0x8f7a887a, 0x807aff7a,
+	0x00000200, 0x80767a6e,
+	0x8277806f, 0xb97af802,
+	0xbf0c8b7a, 0xbf850003,
+	0xbe804fc2, 0xbfabfffe,
+	0xbf840001, 0xbe804ec4,
+	0xbfabfffc, 0xb97af803,
+	0x877aff7a, 0x0060000c,
+	0x8a78ff78, 0x0060000c,
+	0x88787a78, 0xbefa037d,
+	0xee220076, 0x3d0c0000,
+	0x00000000, 0xee220076,
+	0x360c0000, 0x00000400,
+	0x877aff6d, 0x0000ffff,
+	0xee220076, 0x3d0c0000,
+	0x00000800, 0xbefa037e,
+	0xee220076, 0x3d0c0000,
+	0x00000c00, 0xbefa037f,
+	0xee220076, 0x3d0c0000,
+	0x00001000, 0xee220076,
+	0x3c0c0000, 0x00001400,
+	0xb97af811, 0xee220076,
+	0x3d0c0000, 0x00001800,
+	0xbefa0380, 0xee220076,
+	0x3d0c0000, 0x00001c00,
+	0xb97af801, 0xee220076,
+	0x3d0c0000, 0x00002000,
+	0xb97af814, 0xee220076,
+	0x3d0c0000, 0x00002400,
+	0xb97af815, 0xee220076,
+	0x3d0c0000, 0x00002800,
+	0xb97af812, 0xee220076,
+	0x3d0c0000, 0x00002c00,
+	0xb97af813, 0xee220076,
+	0x3d0c0000, 0x00003000,
+	0xb97af802, 0xee220076,
+	0x3d0c0000, 0x00003400,
+	0xbefa50c1, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00003800, 0xbefa4c88,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00003c00,
+	0xb97af82c, 0xee220076,
+	0x3d0c0000, 0x00004000,
+	0xb97af82d, 0xee220076,
+	0x3d0c0000, 0x00004400,
+	0xb97a061c, 0xee220076,
+	0x3d0c0000, 0x00004800,
+	0xbf0d9d6d, 0xbf840022,
+	0xbefa5680, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00004c00, 0xb97af82e,
+	0xee220076, 0x3d0c0000,
+	0x00005000, 0xbefa4c8c,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00005400,
+	0xbefa4c8d, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00005800, 0xbefa4c8e,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00005c00,
+	0xbefa4c8f, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00006000, 0xbefa4c90,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00006400,
+	0xbefa5081, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00008000, 0xbefa5082,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00008400,
+	0xbefa5083, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00008800, 0xbefa5084,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00008c00,
+	0xbefa5085, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00009000, 0xbefa5086,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00009400,
+	0xbefa5087, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x00009800, 0xbefa5088,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x00009c00,
+	0xbefa5089, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000a000, 0xbefa508a,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000a400,
+	0xbefa508b, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000a800, 0xbefa508c,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000ac00,
+	0xbefa508d, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000b000, 0xbefa508e,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000b400,
+	0xbefa508f, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000b800, 0xbefa5090,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000bc00,
+	0xbefa50a1, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000c000, 0xbefa50a2,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000c400,
+	0xbefa50a3, 0xbfc70000,
+	0xee220076, 0x3d0c0000,
+	0x0000c800, 0xbefa50a4,
+	0xbfc70000, 0xee220076,
+	0x3d0c0000, 0x0000cc00,
+	0xbf0d9d6d, 0xbf840004,
+	0xbf0d9f6d, 0xbf850002,
+	0xbefa0380, 0xbf820008,
+	0xb97a3b05, 0x807a817a,
+	0x8f7a827a, 0xbf0d9c6d,
+	0xbf850002, 0x8f7a877a,
+	0xbf820001, 0x8f7a887a,
+	0x80767a6e, 0x8277806f,
+	0xbefd0380, 0x86800100,
+	0x86820102, 0x86840104,
+	0x86860106, 0x86880108,
+	0x868a010a, 0x868c010c,
+	0x868e010e, 0xee220076,
+	0x000c0000, 0x00000000,
+	0xee220076, 0x008c0000,
+	0x00000400, 0xee220076,
+	0x010c0000, 0x00000800,
+	0xee220076, 0x018c0000,
+	0x00000c00, 0xee220076,
+	0x020c0000, 0x00001000,
+	0xee220076, 0x028c0000,
+	0x00001400, 0xee220076,
+	0x030c0000, 0x00001800,
+	0xee220076, 0x038c0000,
+	0x00001c00, 0xee220076,
+	0x040c0000, 0x00002000,
+	0xee220076, 0x048c0000,
+	0x00002400, 0xee220076,
+	0x050c0000, 0x00002800,
+	0xee220076, 0x058c0000,
+	0x00002c00, 0xee220076,
+	0x060c0000, 0x00003000,
+	0xee220076, 0x068c0000,
+	0x00003400, 0xee220076,
+	0x070c0000, 0x00003800,
+	0xee220076, 0x078c0000,
+	0x00003c00, 0x8076c076,
+	0x82778077, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbf85ffc2, 0x86800100,
+	0x86820102, 0x86840104,
+	0x86860106, 0x86880108,
+	0x868a010a, 0xee220076,
+	0x000c0000, 0x00000000,
+	0xee220076, 0x008c0000,
+	0x00000400, 0xee220076,
+	0x010c0000, 0x00000800,
+	0xee220076, 0x018c0000,
+	0x00000c00, 0xee220076,
+	0x020c0000, 0x00001000,
+	0xee220076, 0x028c0000,
+	0x00001400, 0xee220076,
+	0x030c0000, 0x00001800,
+	0xee220076, 0x038c0000,
+	0x00001c00, 0xee220076,
+	0x040c0000, 0x00002000,
+	0xee220076, 0x048c0000,
+	0x00002400, 0xee220076,
+	0x050c0000, 0x00002800,
+	0xee220076, 0x058c0000,
+	0x00002c00, 0xb97af802,
+	0xbf0d987a, 0xbf85007c,
+	0x877aff6d, 0xa0000000,
+	0xbf06ff7a, 0x20000000,
+	0xbf850030, 0xbef6046e,
+	0xb97b3b05, 0x807b817b,
+	0x8f7b827b, 0xbefa0380,
+	0xbefe04c1, 0xbf9c0000,
+	0xbf0d9c6d, 0xbf850014,
+	0xbe806f7a, 0xee05c076,
+	0x000c0000, 0x00000000,
+	0xee05c076, 0x008c0000,
+	0x00008000, 0xee05c076,
+	0x010c0000, 0x00010000,
+	0xee05c076, 0x018c0000,
+	0x00018000, 0x8076ff76,
+	0x00000200, 0x82778077,
+	0x807a847a, 0xbf0a7b7a,
+	0xbf85ffed, 0xbf820013,
+	0xbe806f7a, 0xee05c076,
+	0x000c0000, 0x00000000,
+	0xee05c076, 0x008c0000,
+	0x00010000, 0xee05c076,
+	0x010c0000, 0x00020000,
+	0xee05c076, 0x018c0000,
+	0x00030000, 0x8076ff76,
+	0x00000400, 0x82778077,
+	0x807a847a, 0xbf0a7b7a,
+	0xbf85ffed, 0xb97b4306,
+	0x8f7b8a7b, 0xbf840044,
+	0xbf0d9d6d, 0xbf840002,
+	0xbe804ec2, 0xbfabfffe,
+	0xbf0d9e6d, 0xbf84003e,
+	0xbf0d9d6d, 0xbf840004,
+	0xbf0d9f6d, 0xbf850002,
+	0xbefa0380, 0xbf820008,
+	0xb97a3b05, 0x807a817a,
+	0x8f7a827a, 0xbf0d9c6d,
+	0xbf850002, 0x8f7a877a,
+	0xbf820001, 0x8f7a887a,
+	0x807aff7a, 0x00000400,
+	0x80767a6e, 0x8277806f,
+	0xbefe04c1, 0xbefa0380,
+	0xbf9c0000, 0xbe806f80,
+	0xd7650000, 0x000100c1,
+	0xd7660000, 0x000200c1,
+	0x34000082, 0xbf0d9c6d,
+	0xbf850011, 0xd8d80000,
+	0x01000000, 0xbfc60000,
+	0xee05c076, 0x008c0000,
+	0x00000000, 0x8076ff76,
+	0x00000080, 0x82778077,
+	0xd5250000, 0x0001ff00,
+	0x00000080, 0x807aff7a,
+	0x00000080, 0xbf0a7b7a,
+	0xbf85fff0, 0xbf820010,
+	0xd8d80000, 0x01000000,
+	0xbfc60000, 0xee05c076,
+	0x008c0000, 0x00000000,
+	0x8076ff76, 0x00000100,
+	0x82778077, 0xd5250000,
+	0x0001ff00, 0x00000100,
+	0x807aff7a, 0x00000100,
+	0xbf0a7b7a, 0xbf85fff0,
+	0xb97af802, 0xbf0c8b7a,
+	0xbf850003, 0xbe804fc2,
+	0xbfabfffe, 0xbf840001,
+	0xbe804ec4, 0xbfabfffc,
+	0xbf9b0000, 0xbef4047e,
+	0x93eeff75, 0x0002001a,
+	0x8775ff75, 0x0000ffff,
+	0x8f729e6e, 0xb96e025b,
+	0x8f6e9d6e, 0x88726e72,
+	0xb96e0742, 0x8f6e9c6e,
+	0x88726e72, 0xbf0d9d72,
+	0xbf840004, 0xbf0d9f72,
+	0xbf850002, 0xbeee0380,
+	0xbf820008, 0xb96e3b05,
+	0x806e816e, 0x8f6e826e,
+	0xbf0d9c72, 0xbf850002,
+	0x8f6e876e, 0xbf820001,
+	0x8f6e886e, 0x806eff6e,
+	0x00000200, 0x80766e74,
+	0x82778075, 0xf4601bbb,
+	0xf8000034, 0xbfc70000,
+	0xbf0d986e, 0xbf840002,
+	0xbf900003, 0xbf82007d,
+	0xb96f4306, 0x8f6f8a6f,
+	0xbf840044, 0xbf0d9e72,
+	0xbf84003e, 0xbf0d9d72,
+	0xbf840004, 0xbf0d9f72,
+	0xbf850002, 0xbeee0380,
+	0xbf820008, 0xb96e3b05,
+	0x806e816e, 0x8f6e826e,
+	0xbf0d9c72, 0xbf850002,
+	0x8f6e876e, 0xbf820001,
+	0x8f6e886e, 0x806eff6e,
+	0x00000400, 0x80766e74,
+	0x82778075, 0xbefe04c1,
+	0xbeee0380, 0xd7650000,
+	0x000100c1, 0xd7660000,
+	0x000200c1, 0x34000082,
+	0xbf0d9c72, 0xbf850012,
+	0xee058076, 0x000c0001,
+	0x00000000, 0xbfc00000,
+	0xd8340000, 0x00000100,
+	0x8076ff76, 0x00000080,
+	0x82778077, 0xd5250000,
+	0x0001ff00, 0x00000080,
+	0x806eff6e, 0x00000080,
+	0xbf0a6f6e, 0xbf85fff0,
+	0xbfc60000, 0xbf820011,
+	0xee058076, 0x000c0001,
+	0x00000000, 0xbfc00000,
+	0xd8340000, 0x00000100,
+	0x8076ff76, 0x00000100,
+	0x82778077, 0xd5250000,
+	0x0001ff00, 0x00000100,
+	0x806eff6e, 0x00000100,
+	0xbf0a6f6e, 0xbf85fff0,
+	0xbfc60000, 0xbf0d9d72,
+	0xbf840002, 0xbe804ec2,
+	0xbfabfffe, 0x876eff72,
+	0xa0000000, 0xbf06ff6e,
+	0x20000000, 0xbf850031,
+	0xbef60474, 0xb96f3b05,
+	0x806f816f, 0x8f6f826f,
+	0xbeee0380, 0xbefe04c1,
+	0xbf0d9c72, 0xbf850015,
+	0xbe806f6e, 0xee058076,
+	0x000c0000, 0x00000000,
+	0xee058076, 0x000c0001,
+	0x00008000, 0xee058076,
+	0x000c0002, 0x00010000,
+	0xee058076, 0x000c0003,
+	0x00018000, 0x8076ff76,
+	0x00000200, 0x82778077,
+	0x806e846e, 0xbf0a6f6e,
+	0xbf85ffed, 0xbfc00000,
+	0xbf820014, 0xbe806f6e,
+	0xee058076, 0x000c0000,
+	0x00000000, 0xee058076,
+	0x000c0001, 0x00010000,
+	0xee058076, 0x000c0002,
+	0x00020000, 0xee058076,
+	0x000c0003, 0x00030000,
+	0x8076ff76, 0x00000400,
+	0x82778077, 0x806e846e,
+	0xbf0a6f6e, 0xbf85ffed,
+	0xbfc00000, 0xbf0d9d72,
+	0xbf840004, 0xbf0d9f72,
+	0xbf850002, 0xbeee0380,
+	0xbf820008, 0xb96e3b05,
+	0x806e816e, 0x8f6e826e,
+	0xbf0d9c72, 0xbf850002,
+	0x8f6e876e, 0xbf820001,
+	0x8f6e886e, 0x80766e74,
+	0x82778075, 0xbeee03ff,
+	0x000001a0, 0xf460403b,
+	0xdc000000, 0xbfc70000,
+	0xbefd03ff, 0x00680000,
+	0x86801000, 0x86821002,
+	0x80eea06e, 0xf460603b,
+	0xdc000000, 0xbfc70000,
+	0x80fdff7d, 0x00080000,
+	0x86801000, 0x86821002,
+	0x86841004, 0x86861006,
+	0x80eec06e, 0xf460803b,
+	0xdc000000, 0xbfc70000,
+	0x80fdff7d, 0x00100000,
+	0x86801000, 0x86821002,
+	0x86841004, 0x86861006,
+	0x86881008, 0x868a100a,
+	0x868c100c, 0x868e100e,
+	0xbf06807d, 0xbf84fff0,
+	0xba80f801, 0x00000000,
+	0xbf0d9d72, 0xbf840004,
+	0xbf0d9f72, 0xbf850002,
+	0xbeee0380, 0xbf820008,
+	0xb96e3b05, 0x806e816e,
+	0x8f6e826e, 0xbf0d9c72,
+	0xbf850002, 0x8f6e876e,
+	0xbf820001, 0x8f6e886e,
+	0x806eff6e, 0x00000200,
+	0x80766e74, 0x82778075,
+	0xf4601bfb, 0xf8000000,
+	0xf4601b3b, 0xf8000004,
+	0xf4601b7b, 0xf8000008,
+	0xf4601c3b, 0xf800000c,
+	0xf4601c7b, 0xf8000010,
+	0xf4601ebb, 0xf8000014,
+	0xf4601efb, 0xf8000018,
+	0xf4601e7b, 0xf800001c,
+	0xf4601cfb, 0xf8000020,
+	0xf4601bbb, 0xf8000024,
+	0xbfc70000, 0xb9eef814,
+	0xf4601bbb, 0xf8000028,
+	0xbfc70000, 0xb9eef815,
+	0xf4601bbb, 0xf800002c,
+	0xbfc70000, 0xb9eef812,
+	0xf4601bbb, 0xf8000030,
+	0xbfc70000, 0xb9eef813,
+	0xf4601bbb, 0xf8000040,
+	0xbfc70000, 0xb9eef82c,
+	0xf4601bbb, 0xf8000044,
+	0xbfc70000, 0xb9eef82d,
+	0xf4601bbb, 0xf8000048,
+	0xbfc70000, 0xbf06816e,
+	0xbf840003, 0xbefd0381,
+	0xbefc4c8a, 0xbfc70000,
+	0xb96ef802, 0xbf0c8b6e,
+	0xbf850003, 0xbe804fc2,
+	0xbfabfffe, 0xbf840001,
+	0xbe804ec4, 0xbfabfffc,
+	0xbf0d9e72, 0xbf84001c,
+	0xf4601bbb, 0xf8000038,
+	0xbfc70000, 0xbf0d9f6e,
+	0xbf840017, 0x93eeff6e,
+	0x00080016, 0x876e6e6e,
+	0xbf840003, 0xbe804ec1,
+	0x816ec16e, 0xbf82fffb,
+	0xbef803ff, 0x00000080,
+	0xbefd0381, 0xf4601bbb,
+	0xf0000000, 0xbfc70000,
+	0xbf0c9f6e, 0xbf850008,
+	0x887d6e7d, 0xbe80517d,
+	0x80788478, 0x877dff7d,
+	0x0000007f, 0x807d817d,
+	0xbf08907d, 0xbf84fff3,
+	0xf4601bbb, 0xf800003c,
+	0xbfc70000, 0xbf0d9f6e,
+	0xbf84001d, 0xbf0d9e72,
+	0xbf840002, 0xbf068180,
+	0xbe804fc4, 0xbfabfffc,
+	0xbf840017, 0x93eeff6e,
+	0x00080016, 0x876e6e6e,
+	0xbf840003, 0xbe804ec3,
+	0x816ec16e, 0xbf82fffb,
+	0xbef803ff, 0x000000c0,
+	0xbefd03a1, 0xf4601bbb,
+	0xf0000000, 0xbfc70000,
+	0xbf0c9f6e, 0xbf850008,
+	0x887d6e7d, 0xbe80517d,
+	0x80788478, 0x877dff7d,
+	0x0000007f, 0x807d817d,
+	0xbf08a47d, 0xbf84fff3,
+	0xbf0d9d72, 0xbf840040,
+	0xf4601bbb, 0xf800004c,
+	0xbfc70000, 0xbf06806e,
+	0xbf850005, 0xbefd136e,
+	0xbe80547d, 0xbfc70000,
+	0xbeee1b7d, 0xbf82fff9,
+	0xf4601bbb, 0xf8000050,
+	0xbfc70000, 0xb9eef82e,
+	0xf4601bbb, 0xf8000054,
+	0xbfc70000, 0xbf0d9c6e,
+	0xbf850003, 0xb9eef824,
+	0x807c8080, 0xbf820002,
+	0xb9eef824, 0xbf800000,
+	0xf4601bbb, 0xf8000058,
+	0xbfc70000, 0xbf0d9c6e,
+	0xbf850003, 0xb9eef825,
+	0x807c8080, 0xbf820002,
+	0xb9eef825, 0xbf800000,
+	0xf4601bbb, 0xf800005c,
+	0xbfc70000, 0xbf0d9c6e,
+	0xbf850003, 0xb9eef826,
+	0x807c8080, 0xbf820002,
+	0xb9eef826, 0xbf800000,
+	0xf4601bbb, 0xf8000060,
+	0xbfc70000, 0xbf0d9c6e,
+	0xbf850003, 0xb9eef827,
+	0x807c8080, 0xbf820002,
+	0xb9eef827, 0xbf800000,
+	0xf4601bbb, 0xf8000064,
+	0xbfc70000, 0xbf0d9c6e,
+	0xbf850003, 0xb9eef828,
+	0x807c8080, 0xbf820002,
+	0xb9eef828, 0xbf800000,
+	0xbefd036f, 0xbefe0370,
+	0xbeff0371, 0xb9fb2011,
+	0x907b867b, 0xb9fb0191,
+	0x907b827b, 0xb9fbba11,
+	0xb9f3f801, 0xbf0d9d72,
+	0xbf840004, 0xbf0d9f72,
+	0xbf850002, 0xbeee0380,
+	0xbf820008, 0xb96e3b05,
+	0x806e816e, 0x8f6e826e,
+	0xbf0d9c72, 0xbf850002,
+	0x8f6e876e, 0xbf820001,
+	0x8f6e886e, 0x806eff6e,
+	0x000001c0, 0x806e746e,
+	0x826f8075, 0xf4605c37,
+	0xf8000010, 0xf4605d37,
+	0xf8000020, 0xf4601e77,
+	0xf8000034, 0xbfc70000,
+	0x876dff6d, 0x0000ffff,
+	0x87fe7e7e, 0x87ea6a6a,
+	0xb9faf803, 0xb96ef802,
+	0xbf0c8b6e, 0xbf850003,
+	0xbe804fc2, 0xbfabfffe,
+	0xbf840001, 0xbe804ec4,
+	0xbfabfffc, 0x907a897a,
+	0xb9fa0243, 0xbe80226c,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0x00000000,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
new file mode 100755
index 0000000000000..58908b4fa40a9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx13.asm
@@ -0,0 +1,1181 @@
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/* To compile this assembly code:
+ *
+ * gfx13:
+ *   cpp -DASIC_FAMILY=CHIP_GFX13 cwsr_trap_handler_gfx13.asm -P -o gfx13.sp3
+ *   sp3 gfx13.sp3 -hex gfx13.hex
+ */
+
+#define CHIP_GFX13 39
+
+#define HAVE_XNACK 0
+#define HAVE_57BIT_ADDRESS 0
+#define WAVE32_ONLY 0
+#define NUM_NAMED_BARRIERS 0x10
+#define NUM_NAMED_CLUSTER_BARRIERS 0x4
+#define NUM_SEMAPHORES 0x5
+#define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
+#define SEMA_DONE_RESTORE_WORKAROUND 1
+
+#if HAVE_XNACK && !WAVE32_ONLY
+# error
+#endif
+
+#define ADDRESS_HI32_NUM_BITS ((HAVE_57BIT_ADDRESS ? 57 : 48) - 32)
+#define ADDRESS_HI32_MASK ((1 << ADDRESS_HI32_NUM_BITS) - 1)
+
+var SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK	= 0x60000C
+var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
+var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK		= 0xC00
+var SQ_WAVE_STATE_PRIV_HALT_MASK		= 0x4000
+var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK		= 0x8000
+var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT		= 15
+var SQ_WAVE_STATUS_WAVE64_SHIFT			= 29
+var SQ_WAVE_STATUS_WAVE64_SIZE			= 1
+var SQ_WAVE_STATUS_NO_VGPRS_SHIFT		= 24
+var SQ_WAVE_STATUS_IN_WG_SHIFT			= 11
+var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK	= SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_ERR_MASK
+var S_RETURN_PC_HI_TRAP_ID_MASK			= 0xF0000000
+
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT		= 12
+var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE		= 9
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE		= 8
+var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT		= 12
+var SQ_WAVE_LDS_ALLOC_GRANULARITY		= 10
+
+var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK	= 0xF
+var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK	= 0x10
+var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT	= 5
+var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK	= 0x20
+var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	= 0x40
+var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT	= 6
+var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK	= 0x80
+var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT	= 7
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	= 0x100
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT	= 8
+var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK	= 0x200
+var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK	= 0x800
+var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK		= 0x80
+var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK	= 0x200
+var SQ_WAVE_TRAP_CTRL_ALU_CONSUME_NAN_SHIFT	= 10
+var SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT= 7
+
+var SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK= SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK	|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK		|\
+						  SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE	= SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT	= SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
+var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE	= 32 - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
+
+var BARRIER_STATE_SIGNAL_OFFSET			= 22
+var BARRIER_STATE_SIGNAL_SIZE			= 8
+var BARRIER_STATE_MEMBER_OFFSET			= 12
+var BARRIER_STATE_MEMBER_SIZE			= 8
+var BARRIER_STATE_VALID_OFFSET			= 31
+var BARRIER_STATE_ID_MASK			= 0x7F
+
+var NAMED_BARRIERS_SR_OFFSET_FROM_HWREG		= 0x80
+var NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG	= (NAMED_BARRIERS_SR_OFFSET_FROM_HWREG + NUM_NAMED_BARRIERS * 0x4)
+var S_BARRIER_INIT_MEMBERCNT_MASK		= 0x7F0000
+var S_BARRIER_INIT_MEMBERCNT_SHIFT		= 0x10
+
+var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT	= 18
+var SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE	= 1
+var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT	= 16
+var SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE	= 1
+var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT	= 0
+var SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE		= 7
+
+var SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT	= 9
+
+var SQ_WAVE_IB_STS_SWC_CNT_SHIFT		= 12
+var SQ_WAVE_IB_STS_SWC_CNT_SIZE			= 2
+
+var SQ_WAVE_IB_STS2_NO_IC_HASH_SHIFT		= 24
+
+var SQ_WAVE_SEMA_STATE_DONE_SHIFT		= 28
+
+var TTMP11_DEBUG_TRAP_ENABLED_SHIFT		= 23
+var TTMP11_DEBUG_TRAP_ENABLED_MASK		= 0x800000
+var TTMP11_FIRST_REPLAY_SHIFT			= 22
+var TTMP11_FIRST_REPLAY_MASK			= 0x400000
+var TTMP11_REPLAY_W64H_SHIFT			= 21
+var TTMP11_REPLAY_W64H_MASK			= 0x200000
+var TTMP11_FXPTR_SHIFT				= 14
+var TTMP11_FXPTR_MASK				= 0x1FC000
+
+var S_EXEC_LAST_FIRST_WAVE_SHIFT		= 26
+var S_EXEC_LAST_FIRST_WAVE_SIZE			= 2
+
+var S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT	= 31
+var S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK		= (1 << S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT)
+var S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT	= 30
+var S_FLAGS_IN_WAVEGROUP_SHIFT			= 29
+var S_FLAGS_IN_WAVEGROUP_MASK			= (1 << S_FLAGS_IN_WAVEGROUP_SHIFT)
+#if ! WAVE32_ONLY
+var S_FLAGS_WAVE64_SHIFT			= 28
+#endif
+
+var s_return_pc_lo				= ttmp0
+var s_return_pc_hi				= ttmp1
+
+var s_save_flags				= s_return_pc_hi
+var s_save_base_addr_lo				= ttmp2
+var s_save_base_addr_hi				= ttmp3
+var s_save_addr_lo				= ttmp10
+var s_save_addr_hi				= ttmp11
+var s_save_state_priv				= ttmp12
+var s_save_tmp					= ttmp14
+var s_save_ttmps_lo				= ttmp14
+var s_save_exec_lo				= ttmp14
+var s_save_excp_flag_priv			= ttmp15
+var s_save_alloc_size				= ttmp15
+var s_save_ttmps_hi				= ttmp15
+var s_save_exec_hi				= ttmp15
+var s_save_xnack_mask				= exec_hi
+
+var s_restore_tmp				= ttmp2
+var s_restore_ttmps_lo				= ttmp2
+var s_restore_alloc_size			= ttmp3
+var s_restore_ttmps_hi				= ttmp3
+var s_restore_m0				= ttmp3
+var s_restore_exec_lo				= ttmp4
+var s_restore_exec_hi				= ttmp5
+var s_restore_flags				= ttmp6
+var s_restore_mode				= ttmp7
+var s_restore_base_addr_lo			= ttmp8
+var s_restore_base_addr_hi			= ttmp9
+var s_restore_addr_lo				= ttmp10
+var s_restore_addr_hi				= ttmp11
+var s_restore_mem_offset			= ttmp12
+var s_restore_xnack_mask			= ttmp13
+var s_restore_state_priv			= ttmp14
+var s_restore_excp_flag_priv			= ttmp15
+
+var TTMP_SR_OFFSET_FROM_HWREG			= -0x40
+
+shader main
+	asic(DEFAULT)
+	type(CS)
+	wave_size(32)
+
+	s_branch	L_SKIP_RESTORE						//NOT restore. might be a regular trap or save
+
+L_JUMP_TO_RESTORE:
+	s_branch	L_RESTORE
+
+L_SKIP_RESTORE:
+	s_getreg_b32	s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)	//save STATUS since we will change SCC
+
+	// Clear SPI_PRIO: do not save with elevated priority.
+	// Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if setreg'd.
+	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
+
+	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+
+	s_and_b32       ttmp2, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
+	s_cbranch_scc0	L_NOT_HALTED
+
+L_HALTED:
+	// Host trap may occur while wave is halted.
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+L_CHECK_SAVE:
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
+	s_cbranch_scc1	L_SAVE
+
+	// Wave is halted but neither host trap nor SAVECTX is raised.
+	// Caused by instruction fetch memory violation.
+	// Spin wait until context saved to prevent interrupt storm.
+	s_sleep		0x10
+	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	s_branch	L_CHECK_SAVE
+
+L_NOT_HALTED:
+	// Let second-level handle non-SAVECTX exception or trap.
+	// Any concurrent SAVECTX will be handled upon re-entry once halted.
+
+	// Check non-maskable exceptions. memory_violation, illegal_instruction
+	// and xnack_error exceptions always cause the wave to enter the trap
+	// handler.
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+	// Check for maskable exceptions in trapsts.excp and trapsts.excp_hi.
+	// Maskable exceptions only cause the wave to enter the trap handler if
+	// their respective bit in mode.excp_en is set.
+
+	// Align bits from EXCP_FLAG_USER/EXCP_FLAG_PRIV with TRAP_CTRL.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	s_bitcmp1_b32	ttmp2, SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT
+	s_cbranch_scc0	L_NOT_ALU_CONSUME_NAN
+	s_bitset0_b32	ttmp2, SQ_WAVE_EXCP_FLAG_USER_ALU_CONSUME_NAN_SHIFT
+	s_bitset1_b32	ttmp2, SQ_WAVE_TRAP_CTRL_ALU_CONSUME_NAN_SHIFT
+
+L_NOT_ALU_CONSUME_NAN:
+	s_and_b32	ttmp3, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
+	s_cbranch_scc0	L_NOT_ADDR_WATCH
+	s_or_b32	ttmp2, ttmp2, SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
+
+L_NOT_ADDR_WATCH:
+	s_getreg_b32	ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	s_and_b32	ttmp2, ttmp3, ttmp2
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+L_CHECK_TRAP_ID:
+	// Check trap_id != 0
+	s_and_b32	ttmp2, s_return_pc_hi, S_RETURN_PC_HI_TRAP_ID_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+
+#if SINGLE_STEP_MISSED_WORKAROUND
+	// Prioritize single step exception over context save.
+	// Second-level trap will halt wave and RFE, re-entering for SAVECTX.
+	// WAVE_TRAP_CTRL is already in ttmp3.
+	s_and_b32	ttmp3, ttmp3, SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
+	s_cbranch_scc1	L_FETCH_2ND_TRAP
+#endif
+
+	s_and_b32	ttmp2, s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
+	s_cbranch_scc1	L_SAVE
+
+L_FETCH_2ND_TRAP:
+#if HAVE_XNACK
+	save_and_clear_xnack_state_priv(ttmp14)
+#endif
+
+	// Read second-level TBA/TMA from first-level TMA and jump if available.
+	// ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized debug data)
+	// ttmp12 holds SQ_WAVE_STATUS
+	s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
+	s_wait_kmcnt	0
+	s_lshl_b64	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
+
+	s_bitcmp1_b32	ttmp15, (ADDRESS_HI32_NUM_BITS - 1)
+	s_cbranch_scc0	L_NO_SIGN_EXTEND_TMA
+	s_or_b32	ttmp15, ttmp15, ~ADDRESS_HI32_MASK
+L_NO_SIGN_EXTEND_TMA:
+
+	s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS		// debug trap enabled flag
+	s_wait_kmcnt	0
+	s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
+	s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
+	s_or_b32        ttmp11, ttmp11, ttmp2
+
+	s_load_dwordx2	[ttmp2, ttmp3], [ttmp14, ttmp15], 0x0 scope:SCOPE_SYS	// second-level TBA
+	s_wait_kmcnt	0
+	s_load_dwordx2	[ttmp14, ttmp15], [ttmp14, ttmp15], 0x8 scope:SCOPE_SYS	// second-level TMA
+	s_wait_kmcnt	0
+
+	s_and_b64	[ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
+	s_cbranch_scc0	L_NO_NEXT_TRAP						// second-level trap handler not been set
+	s_setpc_b64	[ttmp2, ttmp3]						// jump to second-level trap handler
+
+L_NO_NEXT_TRAP:
+	// If not caused by trap then halt wave to prevent re-entry.
+	s_and_b32	ttmp2, s_return_pc_hi, S_RETURN_PC_HI_TRAP_ID_MASK
+	s_cbranch_scc1	L_TRAP_CASE
+
+	// Host trap will not cause trap re-entry.
+	s_getreg_b32	ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	s_and_b32	ttmp2, ttmp2, SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
+	s_cbranch_scc1	L_EXIT_TRAP
+	s_or_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_HALT_MASK
+
+	// If the PC points to S_ENDPGM then context save will fail if STATE_PRIV.HALT is set.
+	// Rewind the PC to prevent this from occurring.
+	s_sub_u32	ttmp0, ttmp0, 0x8
+	s_subb_u32	ttmp1, ttmp1, 0x0
+
+	s_branch	L_EXIT_TRAP
+
+L_TRAP_CASE:
+	// Advance past trap instruction to prevent re-entry.
+	s_add_u32	ttmp0, ttmp0, 0x4
+	s_addc_u32	ttmp1, ttmp1, 0x0
+
+L_EXIT_TRAP:
+	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
+
+	// Restore SQ_WAVE_STATUS.
+	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
+	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
+
+	// STATE_PRIV.*BARRIER_COMPLETE may have changed since we read it.
+	// Only restore fields which the trap handler changes.
+	s_lshr_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
+		SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT - SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
+
+	s_rfe_b64	[ttmp0, ttmp1]
+
+L_SAVE:
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), 0
+
+	// Get save address { 4’b0, lastWaveOfWavegroup, firstWaveOfWorkgroup, 1’b0, memAddr[56:0] }
+	s_mov_b64	[s_save_exec_lo, s_save_exec_hi], exec
+	s_sendmsg_rtn_b64	exec, sendmsg(MSG_RTN_SAVE_WAVE)
+	s_wait_kmcnt	0
+	s_mov_b64	[s_save_base_addr_lo, s_save_base_addr_hi], exec
+	s_mov_b64	exec, [s_save_exec_lo, s_save_exec_hi]
+
+	// Save last_wave_in_wavegroup / first_wave_in_workgroup flags so we can clear high bits of save address.
+	s_bfe_u32	s_save_tmp, s_save_base_addr_hi, (S_EXEC_LAST_FIRST_WAVE_SHIFT | (S_EXEC_LAST_FIRST_WAVE_SIZE << 0x10))
+	s_and_b32	s_save_base_addr_hi, s_save_base_addr_hi, ADDRESS_HI32_MASK
+	s_and_b32	s_save_flags, s_save_flags, ADDRESS_HI32_MASK
+	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
+
+	// Save in_wavegroup and wave64 flags for later use.
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GROUP_INFO, SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT, 1)
+	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
+
+#if ! WAVE32_ONLY
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS, SQ_WAVE_STATUS_WAVE64_SHIFT, 1)
+	s_lshl_b32	s_save_tmp, s_save_tmp, S_FLAGS_WAVE64_SHIFT
+	s_or_b32	s_save_flags, s_save_flags, s_save_tmp
+#endif
+
+#if HAVE_XNACK
+	save_and_clear_xnack_state_priv(s_save_tmp)
+	s_getreg_b32	s_save_xnack_mask, hwreg(HW_REG_WAVE_XNACK_MASK)
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_MASK), 0
+#endif
+
+	// Save trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
+	// ttmp SR memory offset: size(VGPR)+size(SGPR)-0x40
+	get_vgpr_size_bytes(s_save_ttmps_lo, s_save_flags)
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
+	s_add_u32	s_save_ttmps_lo, s_save_ttmps_lo, s_save_base_addr_lo
+	s_addc_u32	s_save_ttmps_hi, s_save_base_addr_hi, 0
+
+	global_store_sgpr_b32	ttmp4, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x10
+	global_store_sgpr_b32	ttmp5, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x14
+	global_store_sgpr_b32	ttmp6, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x18
+	global_store_sgpr_b32	ttmp7, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x1C
+	global_store_sgpr_b32	ttmp8, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x20
+	global_store_sgpr_b32	ttmp9, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x24
+	global_store_sgpr_b32	ttmp10, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x28
+	global_store_sgpr_b32	ttmp11, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x2C
+	global_store_sgpr_b32	ttmp13, [s_save_ttmps_lo, s_save_ttmps_hi] scope:SCOPE_SYS offset:0x34
+
+L_SAVE_HWREG:
+	// HWREG SR memory offset : size(VGPR)+size(SGPR)
+	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
+	s_add_u32	s_save_tmp, s_save_tmp, get_sgpr_size_bytes()
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
+
+	// Ensure no further changes to barrier or LDS state.
+	// STATE_PRIV.*BARRIER_COMPLETE may change up to this point.
+	wait_trap_barriers(s_save_tmp)
+
+	// Re-read final state of *BARRIER_COMPLETE fields for save.
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
+	s_and_b32	s_save_tmp, s_save_tmp, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
+	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_ALL_BARRIER_COMPLETE_MASK
+	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
+
+	s_mov_b32	s_save_tmp, m0
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x0
+
+	global_store_sgpr_b32	s_return_pc_lo, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x4
+
+	s_and_b32	s_save_tmp, s_return_pc_hi, ADDRESS_HI32_MASK
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x8
+
+	s_mov_b32	s_save_tmp, exec_lo
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0xC
+
+#if WAVE32_ONLY
+	s_mov_b32	s_save_tmp, 0
+#else
+	s_mov_b32	s_save_tmp, exec_hi
+#endif
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x10
+
+	global_store_sgpr_b32	s_save_state_priv, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x14
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x18
+
+#if HAVE_XNACK
+	s_mov_b32	s_save_tmp, s_save_xnack_mask
+#else
+	s_mov_b32	s_save_tmp, 0
+#endif
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x1C
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x20
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x24
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x28
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x2C
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x30
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x34
+
+	s_get_barrier_state s_save_tmp, -1
+	s_wait_kmcnt	0
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x38
+
+	s_sendmsg_rtn_b32	s_save_tmp, sendmsg(MSG_RTN_GET_CLUSTER_BARRIER_STATE)
+	s_wait_kmcnt	0
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x3C
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GPR_MSB_IDX0)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x40
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_GPR_IDX123)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x44
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_IB_STS2, SQ_WAVE_IB_STS2_NO_IC_HASH_SHIFT, 1)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x48
+
+	// Locks and semaphores are only supported in wavegroups.
+	s_bitcmp1_b32	s_save_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc0	L_SAVE_SKIP_LOCKS_SEMAPHORES
+
+	s_get_lock_state	s_save_tmp, 0
+	s_wait_kmcnt	0
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x4C
+
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SEMA_MODE)
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:0x50
+
+for var sema_idx = 0; sema_idx < NUM_SEMAPHORES; sema_idx ++
+	s_sendmsg_rtn_b32	s_save_tmp, sendmsg(MSG_RTN_GET_SEMA1 + sema_idx)
+	s_wait_kmcnt	0
+	global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(0x54 + sema_idx * 4)
+end
+
+L_SAVE_SKIP_LOCKS_SEMAPHORES:
+	for var bar_idx = 0; bar_idx < NUM_NAMED_BARRIERS; bar_idx ++
+		s_get_barrier_state s_save_tmp, (bar_idx + 1)
+		s_wait_kmcnt	0
+		global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(NAMED_BARRIERS_SR_OFFSET_FROM_HWREG + bar_idx * 4)
+	end
+
+	for var bar_idx = 0; bar_idx < NUM_NAMED_CLUSTER_BARRIERS; bar_idx ++
+		s_get_barrier_state s_save_tmp, (bar_idx + 0x21)
+		s_wait_kmcnt	0
+		global_store_sgpr_b32	s_save_tmp, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG + bar_idx * 4)
+	end
+
+L_SAVE_SGPRS:
+	// SGPR SR memory offset : size(VGPR)
+	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
+
+	s_mov_b32	m0, 0							//SGPR initial index value =0
+
+	// s[0:15], s[16:31], ... s[80:95]
+L_SAVE_SGPR_LOOP:
+for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx += 2
+	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { src_idx_en: 1, src_idx: MOV_INDEXED_M0 }	//s[N] = s[N+m0], s[N+1] = s[N+1+m0]
+end
+
+for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx ++
+	global_store_sgpr_b32	s[sgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(sgpr_idx * 4)
+end
+
+	s_add_u32	s_save_addr_lo, s_save_addr_lo, 0x40
+	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
+	s_add_u32	m0, m0, 0x10						//next sgpr index
+	s_cmp_lt_u32	m0, 0x60						//scc = (m0 < first 96 SGPR) ? 1 : 0
+	s_cbranch_scc1	L_SAVE_SGPR_LOOP					//first 96 SGPR save is complete?
+
+	// s[96:107]
+for var sgpr_idx = 0; sgpr_idx < 0xC; sgpr_idx += 2
+	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { src_idx_en: 1, src_idx: MOV_INDEXED_M0 }	//s[N] = s[N+m0], s[N+1] = s[N+1+m0]
+end
+
+for var sgpr_idx = 0; sgpr_idx < 0xC; sgpr_idx ++
+	global_store_sgpr_b32	s[sgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(sgpr_idx * 4)
+end
+
+	// If VGPRs have been deallocated then there is no more state to save.
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp1_b32	s_save_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
+	s_cbranch_scc1	L_SAVE_DONE
+
+	// In a wavegroup only the last wave saves VGPRs.
+	s_and_b32	s_save_tmp, s_save_flags, (S_FLAGS_IN_WAVEGROUP_MASK | S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK)
+	s_cmp_eq_u32	s_save_tmp, S_FLAGS_IN_WAVEGROUP_MASK
+	s_cbranch_scc1	L_SAVE_LDS
+
+L_SAVE_VGPRS:
+	// VGPR SR memory offset: 0
+	s_mov_b64	[s_save_addr_lo, s_save_addr_hi], [s_save_base_addr_lo, s_save_base_addr_hi]
+
+	get_vgpr_num(s_save_alloc_size)
+	s_mov_b32	s_save_tmp, 0
+	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
+	s_set_vgpr_frames	0
+
+#if ! WAVE32_ONLY
+	s_bitcmp1_b32	s_save_flags, S_FLAGS_WAVE64_SHIFT
+	s_cbranch_scc1	L_SAVE_VGPRS_WAVE64
+#endif
+
+	save_vgprs(0x80)
+
+#if ! WAVE32_ONLY
+	s_branch	L_SAVE_LDS
+
+L_SAVE_VGPRS_WAVE64:
+	save_vgprs(0x100)
+#endif
+
+L_SAVE_LDS:
+	// If no LDS is allocated then skip save.
+	s_getreg_b32	s_save_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
+	s_lshl_b32	s_save_alloc_size, s_save_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
+	s_cbranch_scc0	L_SAVE_DONE
+
+	// Wavegroups wait for a barrier to ensure shared VGPRs have been saved.
+	s_bitcmp1_b32	s_save_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc0	L_SAVE_SKIP_WAVEGROUP_VGPR_BARRIER
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+
+L_SAVE_SKIP_WAVEGROUP_VGPR_BARRIER:
+	// Only the first wave in a group saves LDS.
+	s_bitcmp1_b32	s_save_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+	s_cbranch_scc0	L_SAVE_DONE
+
+	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
+	get_vgpr_size_bytes(s_save_tmp, s_save_flags)
+	s_add_u32	s_save_tmp, s_save_tmp, (get_sgpr_size_bytes() + get_hwreg_size_bytes())
+	s_add_u32	s_save_addr_lo, s_save_base_addr_lo, s_save_tmp
+	s_addc_u32	s_save_addr_hi, s_save_base_addr_hi, 0
+
+	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
+	s_mov_b32	s_save_tmp, 0
+	s_set_vgpr_frames	0
+	s_set_gpr_idx_u32	dst_idx0, 0
+
+	// v0 = [0x0, 0x4, 0x8, 0xC, ... 0x7C (wave32) or 0xFC (wave64)]
+	v_mbcnt_lo_u32_b32	v0, -1, 0
+#if ! WAVE32_ONLY
+	v_mbcnt_hi_u32_b32	v0, -1, v0
+#endif
+	v_lshlrev_b32	v0, 2, v0
+
+#if ! WAVE32_ONLY
+	s_bitcmp1_b32	s_save_flags, S_FLAGS_WAVE64_SHIFT
+	s_cbranch_scc1	L_SAVE_LDS_WAVE64
+#endif
+
+	save_lds(0x80)
+
+#if ! WAVE32_ONLY
+	s_branch	L_SAVE_DONE
+
+L_SAVE_LDS_WAVE64:
+	save_lds(0x100)
+#endif
+
+L_SAVE_DONE:
+	// Make sure that no wave of the group/cluster can exit the trap handler
+	// before the group/cluster barrier state is saved.
+	wait_trap_barriers(s_save_tmp)
+
+	s_endpgm_saved
+
+L_RESTORE:
+	// Get restore address { 4’b0, lastWaveOfWavegroup, firstWaveOfWorkgroup, 1’b0, memAddr[56:0] }
+	s_mov_b64	[s_restore_base_addr_lo, s_restore_base_addr_hi], exec
+
+	// Save last_wave_in_wavegroup / first_wave_in_workgroup flags so we can clear high bits of restore address.
+	s_bfe_u32	s_restore_tmp, s_restore_base_addr_hi, (S_EXEC_LAST_FIRST_WAVE_SHIFT | (S_EXEC_LAST_FIRST_WAVE_SIZE << 0x10))
+	s_and_b32	s_restore_base_addr_hi, s_restore_base_addr_hi, ADDRESS_HI32_MASK
+	s_lshl_b32	s_restore_flags, s_restore_tmp, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+
+	// Save in_wavegroup and wave64 flags for later use.
+	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_WAVE_GROUP_INFO, SQ_WAVE_GROUP_INFO_IN_WAVEGROUP_SHIFT, 1)
+	s_lshl_b32	s_restore_tmp, s_restore_tmp, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_or_b32	s_restore_flags, s_restore_flags, s_restore_tmp
+
+#if ! WAVE32_ONLY
+	s_getreg_b32	s_restore_tmp, hwreg(HW_REG_WAVE_STATUS, SQ_WAVE_STATUS_WAVE64_SHIFT, 1)
+	s_lshl_b32	s_restore_tmp, s_restore_tmp, S_FLAGS_WAVE64_SHIFT
+	s_or_b32	s_restore_flags, s_restore_flags, s_restore_tmp
+#endif
+
+	// HWREG SR memory offset : size(VGPR)+size(SGPR)
+	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
+	s_add_u32	s_restore_tmp, s_restore_tmp, get_sgpr_size_bytes()
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
+
+	// Deallocate VGPRs if needed and skip LDS/VGPR restore.
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x34
+	s_wait_kmcnt	0
+	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_STATUS_NO_VGPRS_SHIFT
+	s_cbranch_scc0	L_RESTORE_LDS
+	s_sendmsg	sendmsg(MSG_DEALLOC_VGPRS)
+	s_branch	L_RESTORE_SGPRS
+
+L_RESTORE_LDS:
+	// If no LDS is allocated then skip restore.
+	s_getreg_b32	s_restore_alloc_size, hwreg(HW_REG_WAVE_LDS_ALLOC, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT, SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
+	s_lshl_b32	s_restore_alloc_size, s_restore_alloc_size, SQ_WAVE_LDS_ALLOC_GRANULARITY
+	s_cbranch_scc0	L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER
+
+	// Only the first wave in a group restores LDS.
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+	s_cbranch_scc0	L_RESTORE_VGPRS
+
+	// LDS at offset: size(VGPR)+SIZE(SGPR)+SIZE(HWREG)
+	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
+	s_add_u32	s_restore_tmp, s_restore_tmp, (get_sgpr_size_bytes() + get_hwreg_size_bytes())
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
+
+	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
+	s_mov_b32	s_restore_tmp, 0
+
+	// v0 = [0x0, 0x4, 0x8, 0xC, ... 0x7C (wave32) or 0xFC (wave64)]
+	v_mbcnt_lo_u32_b32	v0, -1, 0
+#if ! WAVE32_ONLY
+	v_mbcnt_hi_u32_b32	v0, -1, v0
+#endif
+	v_lshlrev_b32	v0, 2, v0
+
+#if ! WAVE32_ONLY
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_WAVE64_SHIFT
+	s_cbranch_scc1	L_RESTORE_LDS_WAVE64
+#endif
+
+	restore_lds(0x80)
+
+#if ! WAVE32_ONLY
+	s_branch	L_RESTORE_VGPRS
+
+L_RESTORE_LDS_WAVE64:
+	restore_lds(0x100)
+#endif
+
+L_RESTORE_VGPRS:
+	// Wavegroups wait for a barrier to ensure shared VGPRs are no longer in use.
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc0	L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER
+	s_barrier_signal	-2
+	s_barrier_wait	-2
+
+L_RESTORE_SKIP_WAVEGROUP_VGPR_BARRIER:
+	// In a wavegroup only the last wave restores VGPRs.
+	s_and_b32	s_restore_tmp, s_restore_flags, (S_FLAGS_IN_WAVEGROUP_MASK | S_FLAGS_LAST_WAVE_IN_WAVEGROUP_MASK)
+	s_cmp_eq_u32	s_restore_tmp, S_FLAGS_IN_WAVEGROUP_MASK
+	s_cbranch_scc1	L_RESTORE_SGPRS
+
+	// VGPR SR memory offset : 0
+	s_mov_b64	[s_restore_addr_lo, s_restore_addr_hi], [s_restore_base_addr_lo, s_restore_base_addr_hi]
+
+	get_vgpr_num(s_restore_alloc_size)
+	s_mov_b32	s_restore_tmp, 0
+	s_mov_b64	exec, 0xFFFFFFFFFFFFFFFF
+
+#if ! WAVE32_ONLY
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_WAVE64_SHIFT
+	s_cbranch_scc1	L_RESTORE_VGPRS_WAVE64
+#endif
+
+	restore_vgprs(0x80)
+
+#if ! WAVE32_ONLY
+	s_branch	L_RESTORE_SGPRS
+
+L_RESTORE_VGPRS_WAVE64:
+	restore_vgprs(0x100)
+#endif
+
+L_RESTORE_SGPRS:
+	// SGPR SR memory offset : size(VGPR)
+	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0
+
+	// s[104:107]
+	s_mov_b32	s_restore_tmp, (0x68 * 4)
+	s_load_b128	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+	s_mov_b32	m0, (0x68 << 0x10)
+for var sgpr_idx = 0; sgpr_idx < 4; sgpr_idx += 2
+	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
+end
+
+	// s[96:103]
+	s_sub_u32	s_restore_tmp, s_restore_tmp, 0x20
+	s_load_b256	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+	s_sub_u32	m0, m0, (0x8 << 0x10)
+for var sgpr_idx = 0; sgpr_idx < 8; sgpr_idx += 2
+	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
+end
+
+	// s[80:95], s[64:79], ... s[0:15]
+ L_RESTORE_SGPR_LOOP:
+	s_sub_u32	s_restore_tmp, s_restore_tmp, 0x40
+	s_load_b512	s0, [s_restore_addr_lo, s_restore_addr_hi], s_restore_tmp scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+	s_sub_u32	m0, m0, (0x10 << 0x10)
+for var sgpr_idx = 0; sgpr_idx < 0x10; sgpr_idx += 2
+	s_mov_indexed_b64	s[sgpr_idx], s[sgpr_idx], { dst_idx_en: 1, dst_idx: MOV_INDEXED_M0 }	//s[N+m0] = s[N], s[N+1+m0] = s[N+1]
+end
+
+	s_cmp_eq_u32	m0, 0
+	s_cbranch_scc0	L_RESTORE_SGPR_LOOP
+
+	// s_barrier with STATE_PRIV.TRAP_AFTER_INST=1, STATUS.PRIV=1 incorrectly asserts debug exception.
+	// Clear DEBUG_EN before and restore MODE after the barrier.
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_MODE), 0
+
+L_RESTORE_HWREG:
+	// HWREG SR memory offset : size(VGPR)+size(SGPR)
+	get_vgpr_size_bytes(s_restore_tmp, s_restore_flags)
+	s_add_u32	s_restore_tmp, s_restore_tmp, get_sgpr_size_bytes()
+	s_add_u32	s_restore_addr_lo, s_restore_base_addr_lo, s_restore_tmp
+	s_addc_u32	s_restore_addr_hi, s_restore_base_addr_hi, 0x0
+
+	s_load_b32	s_restore_m0, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS
+	s_load_b32	s_return_pc_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x4
+	s_load_b32	s_return_pc_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x8
+	s_load_b32	s_restore_exec_lo, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0xC
+	s_load_b32	s_restore_exec_hi, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x10
+	s_load_b32	s_restore_state_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x14
+	s_load_b32	s_restore_excp_flag_priv, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x18
+	s_load_b32	s_restore_xnack_mask, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x1C
+	s_load_b32	s_restore_mode, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x20
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x24
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_LO), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x28
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_SCRATCH_BASE_HI), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x2C
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_USER), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x30
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x40
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_GPR_MSB_IDX0), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x44
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_GPR_IDX123), s_restore_tmp
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x48
+	s_wait_kmcnt	0
+	s_cmp_eq_u32	s_restore_tmp, 1
+	s_cbranch_scc0	L_RESTORE_NO_IC_HASH_DISABLE
+	s_mov_b32	m0, 1
+	s_sendmsg_rtn_b32	null, sendmsg(MSG_RTN_SET_CACHE_MODE)
+	s_wait_kmcnt	0
+
+L_RESTORE_NO_IC_HASH_DISABLE:
+	// Ensure all waves of the group/cluster are created before restoring barrier state.
+	wait_trap_barriers(s_restore_tmp)
+
+	// Only the first wave needs to restore group barriers.
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+	s_cbranch_scc0	L_RESTORE_SKIP_GROUP_BARRIER
+
+	// Skip group barriers if wave is not part of a group.
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x38
+	s_wait_kmcnt	0
+	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc0	L_RESTORE_SKIP_GROUP_BARRIER
+
+	// Restore workgroup barrier signal count.
+	restore_barrier_signal_count(-1)
+
+	s_mov_b32	s_restore_mem_offset, NAMED_BARRIERS_SR_OFFSET_FROM_HWREG
+	s_mov_b32	m0, 1
+
+L_RESTORE_NAMED_BARRIER_LOOP:
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], s_restore_mem_offset scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+	s_bitcmp0_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc1	L_RESTORE_SKIP_GROUP_BARRIER
+
+	s_or_b32	m0, m0, s_restore_tmp
+	s_barrier_init	m0
+
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 4
+	s_and_b32	m0, m0, BARRIER_STATE_ID_MASK
+	s_add_u32	m0, m0, 1
+	s_cmp_gt_u32	m0, NUM_NAMED_BARRIERS
+	s_cbranch_scc0	L_RESTORE_NAMED_BARRIER_LOOP
+
+L_RESTORE_SKIP_GROUP_BARRIER:
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x3C
+	s_wait_kmcnt	0
+
+	// Skip cluster barrier restore if wave is not part of a cluster.
+	s_bitcmp1_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc0	L_RESTORE_SKIP_CLUSTER_BARRIER
+
+	// Only the first wave in the group signals the trap cluster barrier.
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_FIRST_WAVE_IN_WORKGROUP_SHIFT
+	s_cbranch_scc0	L_RESTORE_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
+
+	// Clear SCC: s_barrier_signal_isfirst -4 writes SCC=>1 but not SCC=>0.
+	s_cmp_eq_u32	0, 1
+	s_barrier_signal_isfirst	-4
+
+L_RESTORE_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_wait	-4
+
+	// Only the first wave in the cluster restores the barrier.
+	s_cbranch_scc0	L_RESTORE_SKIP_CLUSTER_BARRIER
+
+	// Restore cluster barrier signal count.
+	restore_barrier_signal_count(-3)
+
+	s_mov_b32	s_restore_mem_offset, NAMED_CLUSTER_BARRIERS_SR_OFFSET_FROM_HWREG
+	s_mov_b32	m0, 0x21
+
+L_RESTORE_NAMED_CLUSTER_BARRIER_LOOP:
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], s_restore_mem_offset scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+	s_bitcmp0_b32	s_restore_tmp, BARRIER_STATE_VALID_OFFSET
+	s_cbranch_scc1	L_RESTORE_SKIP_CLUSTER_BARRIER
+
+	s_or_b32	m0, m0, s_restore_tmp
+	s_barrier_init	m0
+
+	s_add_u32	s_restore_mem_offset, s_restore_mem_offset, 0x4
+	s_and_b32	m0, m0, BARRIER_STATE_ID_MASK
+	s_add_u32	m0, m0, 1
+	s_cmp_gt_u32	m0, (0x20 + NUM_NAMED_CLUSTER_BARRIERS)
+	s_cbranch_scc0	L_RESTORE_NAMED_CLUSTER_BARRIER_LOOP
+
+L_RESTORE_SKIP_CLUSTER_BARRIER:
+	// Locks and semaphores are only supported in wavegroups.
+	s_bitcmp1_b32	s_restore_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc0	L_RESTORE_SKIP_LOCKS_SEMAPHORES
+
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x4C
+	s_wait_kmcnt	0
+
+L_RESTORE_LOCK_LOOP:
+	s_cmp_eq_u32	s_restore_tmp, 0
+	s_cbranch_scc1	L_RESTORE_LOCKS_DONE
+
+	s_ctz_i32_b32	m0, s_restore_tmp
+	s_try_lock	m0
+	s_wait_kmcnt	0
+
+	s_bitset0_b32	s_restore_tmp, m0
+	s_branch	L_RESTORE_LOCK_LOOP
+
+L_RESTORE_LOCKS_DONE:
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:0x50
+	s_wait_kmcnt	0
+	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA_MODE), s_restore_tmp
+
+#if SEMA_DONE_RESTORE_WORKAROUND
+	label L_RESTORE_SEMA_IS_DONE[NUM_SEMAPHORES]
+	label L_RESTORE_SEMA_NEXT[NUM_SEMAPHORES]
+#endif
+
+for var sema_idx = 0; sema_idx < NUM_SEMAPHORES; sema_idx ++
+	s_load_b32	s_restore_tmp, [s_restore_addr_lo, s_restore_addr_hi], null scope:SCOPE_SYS offset:(0x54 + sema_idx * 4)
+	s_wait_kmcnt	0
+
+#if SEMA_DONE_RESTORE_WORKAROUND
+	s_bitcmp1_b32	s_restore_tmp, SQ_WAVE_SEMA_STATE_DONE_SHIFT
+	s_cbranch_scc1	L_RESTORE_SEMA_IS_DONE[sema_idx]
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
+	s_add_u32	null, 0, 0
+	s_branch	L_RESTORE_SEMA_NEXT[sema_idx]
+
+L_RESTORE_SEMA_IS_DONE[sema_idx]:
+	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
+	s_nop		0
+
+L_RESTORE_SEMA_NEXT[sema_idx]:
+#else
+	s_setreg_b32	hwreg(HW_REG_WAVE_SEMA1_STATE + sema_idx), s_restore_tmp
+#endif
+
+end
+
+L_RESTORE_SKIP_LOCKS_SEMAPHORES:
+	s_mov_b32	m0, s_restore_m0
+	s_mov_b32	exec_lo, s_restore_exec_lo
+	s_mov_b32	exec_hi, s_restore_exec_hi
+
+#if HAVE_XNACK
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_MASK), s_restore_xnack_mask
+#endif
+
+	// EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
+	// Only restore the other fields to avoid clobbering them.
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, 0, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE), s_restore_excp_flag_priv
+	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE), s_restore_excp_flag_priv
+	s_lshr_b32	s_restore_excp_flag_priv, s_restore_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT, SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE), s_restore_excp_flag_priv
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_MODE), s_restore_mode
+
+	// Restore trap temporaries 4-11, 13 initialized by SPI debug dispatch logic
+	// ttmp SR memory offset :
+	// - gfx12:   size(VGPR)+size(SGPR)+0x40
+	// - gfx12.5: size(VGPR)+size(SGPR)-0x40
+	get_vgpr_size_bytes(s_restore_ttmps_lo, s_restore_flags)
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, (get_sgpr_size_bytes() + TTMP_SR_OFFSET_FROM_HWREG)
+	s_add_u32	s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_base_addr_lo
+	s_addc_u32	s_restore_ttmps_hi, s_restore_base_addr_hi, 0x0
+	s_load_dwordx4	[ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x10 scope:SCOPE_SYS
+	s_load_dwordx4	[ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x20 scope:SCOPE_SYS
+	s_load_dword	ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0x34 scope:SCOPE_SYS
+	s_wait_kmcnt	0
+
+#if HAVE_XNACK
+	restore_xnack_state_priv(s_restore_tmp)
+#endif
+
+	s_and_b32	s_return_pc_hi, s_return_pc_hi, ADDRESS_HI32_MASK	//Do it here in order not to affect STATUS
+	s_and_b64	exec, exec, exec					// Restore STATUS.EXECZ, not writable by s_setreg_b32
+	s_and_b64	vcc, vcc, vcc						// Restore STATUS.VCCZ, not writable by s_setreg_b32
+
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv	// SCC is included, which is changed by previous salu
+
+	// Make barrier and LDS state visible to all waves in the group/cluster.
+	// STATE_PRIV.*BARRIER_COMPLETE may change after this point.
+	wait_trap_barriers(s_restore_tmp)
+
+	// SCC is changed by wait_trap_barriers, restore it separately.
+	s_lshr_b32	s_restore_state_priv, s_restore_state_priv, SQ_WAVE_STATE_PRIV_SCC_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_STATE_PRIV, SQ_WAVE_STATE_PRIV_SCC_SHIFT, 1), s_restore_state_priv
+
+	s_rfe_b64	s_return_pc_lo						//Return to the main shader program and resume execution
+end
+
+function get_vgpr_num(s_vgpr_num)
+	s_getreg_b32	s_vgpr_num, hwreg(HW_REG_WAVE_GPR_ALLOC, SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT, SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
+	s_add_u32	s_vgpr_num, s_vgpr_num, 1
+	s_lshl_b32	s_vgpr_num, s_vgpr_num, 2				//Number of VGPRs = (vgpr_size + 1) * 4
+end
+
+function get_vgpr_size_bytes(s_vgpr_size_byte, s_flags)
+	s_bitcmp1_b32	s_flags, S_FLAGS_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc0	L_HAVE_VGPR_SAVE_AREA
+	s_bitcmp1_b32	s_flags, S_FLAGS_LAST_WAVE_IN_WAVEGROUP_SHIFT
+	s_cbranch_scc1	L_HAVE_VGPR_SAVE_AREA
+
+	s_mov_b32	s_vgpr_size_byte, 0
+	s_branch	L_VGPR_SIZE_DONE
+
+L_HAVE_VGPR_SAVE_AREA:
+	get_vgpr_num(s_vgpr_size_byte)
+	s_bitcmp1_b32	s_flags, S_FLAGS_WAVE64_SHIFT
+	s_cbranch_scc1	L_HAVE_VGPR64
+	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, 7			//Size of VGPRs = (vgpr_size + 1) * 4 * 32 * 4
+	s_branch	L_VGPR_SIZE_DONE
+
+L_HAVE_VGPR64:
+	s_lshl_b32	s_vgpr_size_byte, s_vgpr_size_byte, 8			//Size of VGPRs = (vgpr_size + 1) * 4 * 64 * 4
+
+L_VGPR_SIZE_DONE:
+end
+
+function get_sgpr_size_bytes
+	return 512
+end
+
+function get_hwreg_size_bytes
+	return 512
+end
+
+#if HAVE_XNACK
+function save_and_clear_xnack_state_priv(s_tmp)
+	// Preserve and clear XNACK state before issuing further translations.
+	// Save XNACK_STATE_PRIV.{FIRST_REPLAY, REPLAY_W64H, FXPTR} into ttmp11[22:14].
+	s_andn2_b32	ttmp11, ttmp11, (TTMP11_FIRST_REPLAY_MASK | TTMP11_REPLAY_W64H_MASK | TTMP11_FXPTR_MASK)
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_FIRST_REPLAY_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_REPLAY_W64H_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE)
+	s_lshl_b32	s_tmp, s_tmp, TTMP11_FXPTR_SHIFT
+	s_or_b32	ttmp11, ttmp11, s_tmp
+
+	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV), 0
+end
+
+function restore_xnack_state_priv(s_tmp)
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_FIRST_REPLAY_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FIRST_REPLAY_SIZE), s_tmp
+
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_REPLAY_W64H_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_REPLAY_W64H_SIZE), s_tmp
+
+	s_lshr_b32	s_tmp, ttmp11, TTMP11_FXPTR_SHIFT
+	s_setreg_b32	hwreg(HW_REG_WAVE_XNACK_STATE_PRIV, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SHIFT, SQ_WAVE_XNACK_STATE_PRIV_FXPTR_SIZE), s_tmp
+end
+#endif
+
+function wait_trap_barriers(s_tmp)
+	// If not in a WG then wave cannot use s_barrier_signal_isfirst.
+	s_getreg_b32	s_tmp, hwreg(HW_REG_WAVE_STATUS)
+	s_bitcmp0_b32	s_tmp, SQ_WAVE_STATUS_IN_WG_SHIFT
+	s_cbranch_scc1	L_TRAP_CLUSTER_BARRIER_SIGNAL
+
+	s_barrier_signal_isfirst	-2
+	s_barrier_wait	-2
+
+	// Only the first wave in the group signals the trap cluster barrier.
+	s_cbranch_scc0	L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL
+
+L_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_signal	-4
+
+L_SKIP_TRAP_CLUSTER_BARRIER_SIGNAL:
+	s_barrier_wait	-4
+end
+
+function restore_barrier_signal_count(barrier_id)
+	// extract the saved signal count from s_restore_tmp
+	s_bfe_u32	s_restore_tmp, s_restore_tmp, (BARRIER_STATE_SIGNAL_OFFSET | (BARRIER_STATE_SIGNAL_SIZE << 0x10))
+
+	// We need to call s_barrier_signal repeatedly to restore the signal count
+	// of the group/cluster barrier. The member count is already initialized.
+L_BARRIER_RESTORE_LOOP:
+	s_and_b32	s_restore_tmp, s_restore_tmp, s_restore_tmp
+	s_cbranch_scc0	L_BARRIER_RESTORE_DONE
+	s_barrier_signal	barrier_id
+	s_add_i32	s_restore_tmp, s_restore_tmp, -1
+	s_branch	L_BARRIER_RESTORE_LOOP
+
+L_BARRIER_RESTORE_DONE:
+end
+
+function save_vgprs(vgpr_size)
+L_SAVE_VGPR_LOOP:
+	// Index groups of VGPRs v[0,1,2,3], v[4,5,6,7], ...
+	s_set_gpr_idx_u32	dst_idx0, s_save_tmp
+
+for var vgpr_idx = 0; vgpr_idx < 4; vgpr_idx ++
+	global_store_addtid_b32	v[vgpr_idx], [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS offset:(vgpr_idx * vgpr_size)
+end
+
+	s_add_u32	s_save_addr_lo, s_save_addr_lo, vgpr_size * 4
+	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
+
+	s_add_u32	s_save_tmp, s_save_tmp, 4
+	s_cmp_lt_u32	s_save_tmp, s_save_alloc_size
+	s_cbranch_scc1	L_SAVE_VGPR_LOOP
+end
+
+function save_lds(vgpr_size)
+L_SAVE_LDS_LOOP:
+	// Copy LDS to save area in VGPR-sized blocks.
+	ds_read_b32	v1, v0
+	s_wait_dscnt	0
+	global_store_addtid_b32	v1, [s_save_addr_lo, s_save_addr_hi] scope:SCOPE_SYS
+
+	s_add_u32	s_save_addr_lo, s_save_addr_lo, vgpr_size
+	s_addc_u32	s_save_addr_hi, s_save_addr_hi, 0
+	v_add_nc_u32	v0, v0, vgpr_size
+
+	s_add_u32	s_save_tmp, s_save_tmp, vgpr_size
+	s_cmp_lt_u32	s_save_tmp, s_save_alloc_size
+	s_cbranch_scc1	L_SAVE_LDS_LOOP
+end
+
+function restore_vgprs(vgpr_size)
+L_RESTORE_VGPR_LOOP:
+	// Index groups of VGPRs v[0,1,2,3], v[4,5,6,7], ...
+	s_set_gpr_idx_u32	dst_idx0, s_restore_tmp
+
+for var vgpr_idx = 0; vgpr_idx < 4; vgpr_idx ++
+	global_load_addtid_b32	v[vgpr_idx], [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS offset:(vgpr_idx * vgpr_size)
+end
+
+	s_add_u32	s_restore_addr_lo, s_restore_addr_lo, vgpr_size * 4
+	s_addc_u32	s_restore_addr_hi, s_restore_addr_hi, 0
+
+	s_add_u32	s_restore_tmp, s_restore_tmp, 4
+	s_cmp_lt_u32	s_restore_tmp, s_restore_alloc_size
+	s_cbranch_scc1	L_RESTORE_VGPR_LOOP
+
+	s_wait_loadcnt	0
+end
+
+function restore_lds(vgpr_size)
+L_RESTORE_LDS_LOOP:
+	// Copy LDS from restore area in VGPR-sized blocks.
+	global_load_addtid_b32	v1, [s_restore_addr_lo, s_restore_addr_hi] scope:SCOPE_SYS
+	s_wait_loadcnt	0
+	ds_store_b32	v0, v1
+
+	s_add_u32	s_restore_addr_lo, s_restore_addr_lo, vgpr_size
+	s_addc_u32	s_restore_addr_hi, s_restore_addr_hi, 0
+	v_add_nc_u32	v0, v0, vgpr_size
+
+	s_add_u32	s_restore_tmp, s_restore_tmp, vgpr_size
+	s_cmp_lt_u32	s_restore_tmp, s_restore_alloc_size
+	s_cbranch_scc1	L_RESTORE_LDS_LOOP
+
+	s_wait_dscnt	0
+end
-- 
2.56.0

