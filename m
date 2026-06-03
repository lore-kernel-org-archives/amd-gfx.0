Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1897CD6E4A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 07:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFF710F9A1;
	Wed,  3 Jun 2026 07:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+N7+4+L";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CBF10F9A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 07:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCg8/7+wub0HXETA2JjzaMAdI2d8JqrIaPlyAPAYPO1JUQT5xkLzuvCs7wi3ALiUPkX3dERutwno38THvDb6SGOapa4fFvaik5gT8LH4wDAxxhsl/b0cfQbSbJ0JNoPAVpPf7qt01Fjr1EQfeoQRL9DfOsuf9RYdI3FhnYGo7Ltx3dbSbTJGB513n2JJ3RP6nyG0L1vnlQcs5/kQAhMo1+9iHB+Osq6Hz4S4n4fOrF4pTbsHyJYUTxQxVb5rsEkwo0uIU6BUPxuB205OYdgRnEbi9O5HmN5AfqWu5iP7kVM4PcPv7HwlISG654LpKOS1CfC+15Dx6Ni4B+ppOcRiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgFObtP0JUM9ubQreMSiGUAvnDHkEzMI3SneTw6e3WM=;
 b=KzPl8QsIHWoX9vPoeVKGT0h4GfKr0j0jf4bNg0EY7H5L27a+bIvX3hRVK2aplvgr3FRvu/5hrDZpx09U25YQ2h2+zf8X8nR4XhFOk5inrhmZfvttJpDEx5v4xOdnX22ZyyRAkXPClszz1gQmCNpqM85FH2F3ZsxvUK4asnZjVO6lje2dGWEh+OZ0SGAhvjcQBsinw0X0iK5PmPw1b4lK5uAu4evNaH1dzi2qh04Pi6Ni34lb4vOEGWDdLkqTtNYXqQn1WXm9Po1SaKGRngu1Hr3AUjoBtkRyZv/deXsLV53ibyf4sH2Q369KQ8jEeS1Th4462XC1rk0NHsTObs/97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgFObtP0JUM9ubQreMSiGUAvnDHkEzMI3SneTw6e3WM=;
 b=A+N7+4+LKfBvxG/5Ov98JiA3Yu1xCJUozatst9qMVrGGaCD7g9kdjDk+XD4lo0QVRfJ6HqDWKzFY+QvmXPgLgvM/xlF7DDfW+bPjUkSZOM0aIWZX96EF5kYVZvY79n9BtDDIlI7/5b41/l4Q7qfQUgjaP+Yvb9rFIbNbF30hzxo=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:15:56 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::50) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:15:55 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 3 Jun 2026 02:15:53 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Lijo.Lazar@amd.com>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] x86/CPU/AMD: Add family 0x1a models 0xd0 through 0xef
Date: Wed, 3 Jun 2026 12:45:01 +0530
Message-ID: <20260603071523.3888047-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dbc890-8bad-402e-2641-08dec13ff429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: f6jbVZrH6idtIGRDbUASKUivlR6WzkUGkgankR2Pt+3IHUVZFdEl6ngrgXW/DbG6ud4vEYKsNqaa8bd3RSH8ej6R9EsrMwCR7vS7LJRVqRD1ztgXRk37WsYTEffEZqDvj7L47/zVYfKaD5DwfB+Todt3vHVfxK4Ca6lE29dojAiZP9ZNVfB0NAzBjZoCbkqHeJ3EdRd5nZedmlzRQDqJO7OWgPGfwprbPUq1dedoCzr+S1M+/1MSuPeR1zdSIuQOBgboO5nbM55GTL0Vz+cNEoEK1f30oLn76pP4kdxo6E0oxlcWj7nyRb8LQWyhShvvaH5+Lu/VeLypefYKTJJzOj8+eTs/QcwTA9cl9V8zm1ZVlNAXb4M8AVvYa6ZFsMewHTFUi1fk63GaUYzKCTYLNNRaHqjBNmzmAN3Yn1kvQImyR8Q4+Cn3Xa4FZSoLzrfk+iZ7PVB08Whut8gtmgJoIc2X1OxEgRdsoHtMqUJ1OZ2OvJjdqSQfXA6JACfProUg5AlhKIpvweRDFJ3W2sqHcTL9m25mLQt26+6ibr+WJtyL5m4xMVMxaS9YE+GIBBZMIjF3k82ioFsFpEcDn3MmXmRzHpHrzMamFBadPZjNoaILUuXiRZ7N/5nLFRZYfnWVS+U33sEIr33w4x4VlKmrgsIH2x9gHm6LEATYVUlen2nC/rrWvtWrYY4mFIVu6/yOX5THvDwrWGa16Hpo0L3CgvgY5lbTdLgOxwY70VZAc9s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HotozSdLQ1ZhwNl2nUY9Evw4piyz3EicEAPl3XctmqzIKbxF8y+HkmErrks6CCDoxaidBUvIPjX71dN9vpQy8AMsvlY26LmUKqCxKQuE8yZ7hdG5RAkSPcLaQmuJ+0vsEsG6tFj+9QArgAADRg7hC4E+eoZIiHGkvLLI/4cS0F1ygfqexb32N+hbvxWUhNzz9y+0xPKZmEJM4sBHiXtRiPolqXBJIdEZj/lTMxw6WCMCoNLy/J6Mo3Bpo1jQYzKr5LTjKqG30HNudve7GgqNxMSVwCetZWetvyKyYxbYPkMvPpYhKHc8zIQHNUpPBtYbNciWnL6d0+u1CLQimBn0MkFnIWXT1WDagTK5AwyAnIVV0hBeW+sC1R+V9Iqoz80b6L7Ht8xv9rXncE2HkMyjG3PlvT3LRHC+zt/9knrcUnOQjitTsARmALadcIfYTLnD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:15:55.5991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dbc890-8bad-402e-2641-08dec13ff429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Family 0x1a model 0xd0, 0xe0 should have X86_FEATURE_ZEN6

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc94ff1e250a..85b5ce71e37b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -517,7 +517,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			break;
 		case 0x50 ... 0x5f:
 		case 0x80 ... 0xaf:
-		case 0xc0 ... 0xcf:
+		case 0xc0 ... 0xef:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;
 		default:
-- 
2.43.0

