Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E24606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ph5jlALs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB5310F956;
	Wed, 21 Oct 2026 06:27:20 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFB710F956
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxhSAG3EqZzqmBg95VsNZjgnd+LuBkAtOTLxwCk0h5Vr5L41yeV1hDb7LAxfD4OebBaXYtm8CTI9eKRwBOMmXyj6+lnIu4VOaRHZ1tZ7L2Ike/iPdmO4qbvTiZBCvoIU6+WiWiDQxVhJ5XvaOk6UlIdpumgA1L8jnOT0FC1diHYsZp5Mf3P6vbdYUZEl8KrR7D5yN6sGVJaEP0TPjTt4qUE/Wi5aUOQx5NYisUzOSt+2zsL0OuBq//GBZ2eodUdAytugTMX+xoqZ3TrSPSusoDT0xRNRcpR4yp1/nKonjCF6fwzH64U/2XN2dcWXEnhsPuQsH/rh1vNxPrvYo3Gc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aigS9gYegeDFGjHYHzNae+bAjMR9IHWAjUFsUOpb9hY=;
 b=GEqwYWxTLuBMW4wEnDH4eezbo80OBZin3mU/JG8TgR7GrewYycCWzt1B39+pcqpHYzwcZY0i+LH/1uuIz9GwCq1BpfNpgTO4Pf4/krNdhaCyoIRePJSf1hYMJLdsc4os2m3fosTkUZEhswYYSMvO8++isvBmu8WyDQh3hbsmdRA+uJRVOn8P/hsZlRZ/v0VtNyVQYhqgTOwUQKq6ZaGKuPuGXw8bJ261NrqfcBhZXAvLrxhFr36bWNhjrwbbbe5ffg/+/KEUhk4ffcF/HcBoEuUZ7vYEYnDDrHw5LnllHIbARp6hqaaFb2IQrzQCAHoVqP4hA/CjTLQZtG7lv6eX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aigS9gYegeDFGjHYHzNae+bAjMR9IHWAjUFsUOpb9hY=;
 b=Ph5jlALsw9HxydmHbeSyy93MTFA38XoXazvKcy2xUDw7oZC1u0vNp7aVCeMC/zYYT08307YCws+Gj9uP0pR0uptfX/M16kfAy6Cx027aszKp6w+EVkB/ANVfAWWBzIuJxZ0wwBgXjuXNl8XKcOiQEb/wrTs7gNF5gHHr3ctvd0M=
Received: from SJ0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:a03:3a0::29)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 21 Oct
 2026 06:27:11 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::15) by SJ0PR03CA0264.outlook.office365.com
 (2603:10b6:a03:3a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:27:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:10 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:07 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 29/49] drm/amd/display: Expose Generic Function That Can Be
 Reused
Date: Wed, 21 Oct 2026 14:22:35 +0800
Message-ID: <20261021062519.674697-30-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 26019c46-1079-4f68-f342-08df2f3c5714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|10067099003|22082099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: HoboJr+wNR+ohbOAWLLF0d4HQ6rETuSgMHcsljWyHrffvz7pOZ3Um1r/K6KlNOGtqCVro0IaC0+V2jSbocmLoEsz7MS6j+lQcx9OhClbmNT51x5FwAl444q6hkXHDcG242dld80J3sV09kY5kKK5gayWbsDEmERxohtSoilJyUDm1u/KVZNX+0QrJvfEMr87XBNH0Q4Ar6JKeaSFImhBZty7is+OymUqZbbKSjQ92myWO2BntPEL+ifmOEouzpo8mhDs4BcbfjMwxnz6JDfWphCH93lPTlwMpeeG73kCCylVRBSVe0m/grJBtdyYWuLbZzni40tC5h53cjoeXIsUumb+047i0ae4PE9Ii00gs19dyPW8uOaY7r+sMeyfUmWE8pmOuUn9dQQx3k3PfJRs8gREPMtBbuE5aBWgaTnN+xlW85yP144NbER37hNEeVR8Yel8aW3uZJVdbL8L9I+mbZi/67bnA47t2/4rzxExdDbOIH7SPeMUioOR/SPrBSUSubXXITGQHTQs+6G5DdwkjCjdR/7ukrFzjfhQBn66EBZ8pbLx7npWqXGOfzBrjOCAp4w9e/TinYHXwDQFeAuy/tzndsyxz1O7/o53LPgIIQk+ECVhEYmbDdd6ViC2scg11VLRZBNFuhaYSbTB6jKWbzR9rtGGaH/yqTbkMQ6pD/t3UzdKeNKx/zJqQLemT2QXKt1zFzA2JB5v8H7OkTU6MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SYa61EMbMu8aAgvOPnQrqxj5jGx4P/jpiTWtZ9uM3VO6B8IFULjQu2yafDHV/9ZXPTJxJqjF67OuOjnvS7xqluTQDGU9ibf9NBppXZiR2BJErMy60NeERYOZb5Z0GDNFD8O05NBdBqiJT/B6JUg96d2sOY5o3ZmcvfETmrYnNucz06ATaouf2WlDAwVXwgc0XCks4GX6T8m6tqz+GMjXVr3O4dkiyF+qlOq2BPdVbjfYb73/nqcJ1Gsn91MftwtVdVe17DzIo6yik7oHPYrgr5tf02u6M54Vywv966msvP+GoXPwCr1HVhCyGWDF1IeLP/WrH5UXw86AOTpSS1cEYR3c7eJZGWGIwa+3PQa1oXJTVmipsaLuFsPA5x14Yb7EfFCXetQbf4F3TnpccolSXgmlpMn2FAi4cProkIEr0z3Pb1U8Au77Wd93VpV1G+VO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:11.4169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26019c46-1079-4f68-f342-08df2f3c5714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Expose function so it can be reused in the future

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c    | 2 +-
 .../amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
index 0bdf0d902aa0..23bd073f1889 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c
@@ -145,7 +145,7 @@ static const struct dml2_pmo_pstate_strategy base_pstate_strategy_list_4_display
 
 static const int base_pstate_strategy_list_4_display_size = sizeof(base_pstate_strategy_list_4_display) / sizeof(struct dml2_pmo_pstate_strategy);
 
-static void dml2_pmo_dcn6_assign_pstate_strategies(struct dml2_pmo_instance *pmo)
+void dml2_pmo_dcn6_assign_pstate_strategies(struct dml2_pmo_instance *pmo)
 {
 	int i = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
index dd7d9f855988..b3b297aca47a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h
@@ -6,6 +6,7 @@
 #define __DML2_PMO_DCN6_H__
 #include "dml2_internal_shared_types.h"
 
+void dml2_pmo_dcn6_assign_pstate_strategies(struct dml2_pmo_instance *pmo);
 bool dml2_pmo_dcn6a_initialize(struct dml2_pmo_initialize_in_out *in_out);
 int dml2_pmo_dcn6a_get_ordered_mandatory_stage_optimizers(struct dml2_pmo_instance *pmo,
 		struct dml2_pmo_stage_optimizer **optimers);
-- 
2.43.0

