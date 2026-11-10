Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0406A606A7D1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QeqxborZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF3210F6B7;
	Tue, 10 Nov 2026 13:05:28 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6C110F6B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcxJhXYVh4TRpX7B0+Km39nyV8UDCcOUz09Cr3yWOlZTHgLlEt9kKOr0ST+hdcy3b/vPpnhUiGlLXlK1P6rdfb3I+6x5KzBqPYHxNo9IT+QV+gOAdJ6iQDFmUG6lFuxgwkjWdz3lCGf6JxGYy4TYX+BhMqM1pfhyBbiNXNjv/jtMSYnCWPSCyHsp6S6/rZYy2OBemnsQajrDLK4IYyUOpa/FYE5XUoe0tvrTxj5KkJqyyxaSNcd5dqYgZaM2+AUk1hx2e88sEPs8TsFWjv+Ovvz0KwlsA/7DaYopCZl6Qm+BQm9VV0pbOtNS889c4XWKn7DLw02F4lzJaxtvzn15fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0W3xUS1YZZNMqTplxAeN6h2vQ4qYrKx0X2O0myycwDs=;
 b=ylu5f9Z5DSntMT+jX8xeg+YzNX1rzZtvsN+IxK95q5gxnUeW+x94hogZYSdgfkVoIBebny36IzAwz6n384yGWpQsoalNN0eJwe70HgaJu0p8cK8/f/yv1WIMVjFUxvJ2jLDm1B8kdumdR4Cs8dfjk4j844yPXEIWI+9FjbxJsdfk6LPktwweqj5O882kQJx27dcPI+QRA5Qm4AeNpmwnqUm7vPScGkqaYAIqqnrxtn3+jMZeMHx+++gPDMS+/RGjG58N5vOwoLfmvDI8lcjkMqe8cP/y4UgDRdAdHqTdU1F/W6/SxPO+/oAMgqPG/85ZOCqKo1Nw4HIc/GIYQrg5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0W3xUS1YZZNMqTplxAeN6h2vQ4qYrKx0X2O0myycwDs=;
 b=QeqxborZ85dNUTJ8f58n1ojzOnTILOaIzHr5K/RCsCd3vZYH+kTSbWKGpM1ePC6WTNHewGYc9T1wExaqmFdwrIq2zYBiu03QC1BrHEcmghGwJ1cMxrjpt28X6H4zXQiV5maWYMnBkUY9EpjkIFN91jPJUE/Bj1sxIA+pAeFCQyc=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:05:08 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::67) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:05:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:05:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:05:04 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/mes11: enable MES RS64 process/gang context
 loading again
Date: Tue, 10 Nov 2026 21:04:40 +0800
Message-ID: <20261110130440.474374-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5c48c3-9ddd-4f93-36c1-08df3f2b3e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 3peEbE5S/ssKvoiLMUeST9q9n4GC6K6+ZltrvKNAQqGqBWjcciTLnDPhGNmKOHvGtC7YVgw+9AQYY9uA4df8XBr3PRcxqcNx1S5P+G1kyk18xv2ztlxR1iyfBErTpmdu9Sxgm7rbCbDI1D0qRPqupJShgGUJA4KczJyfMVYmXo5557R9q5BO3Y7DptQreNbOFAMzMR/yVAttf+IiyCJ37aV88ll7WBlyPUU6XdrHFk+ouc/JDjWROmeEVUdkmWwnlhffZOSwPrS0mezvMoIdjVjyiuDUMxiwc6pI5sXh/DvMGwtTtmZctXQ7NPbPuwTT4aDwdWYCK43EmhvkUZD5Hya8iXo+d65rfFkVxElYLOuerJ7MnPHdZ+Eyva+E9MtgU88MUj60cD60caf02YS3gI/UleknF4rH8MTmcBW3UOfVQL4+2MgIeG7XjlDxA55DHnDyRhY6F6tyCYZLR+VVTakBxLQi80FNYqYcrKnUwE3BMwUzQ1ugdjFqdV4g4iNQLuZGjfFpnnzWvmu/MBe2G8JZLqosrZMON3ymE+o2ey53at3aoYi1izyMYBKZW5+gLAguRJ2wvJi3QiNrXQm91y4iivLkaa9BEjJaQvvkupVJACcfI5z2Zs2de9LTBE5wui4Gbe+kfOqx0YrkaeWSMYr5/WzRjN18EIVgcCyc9HpLtLlz2npNYpj8wPpIq5/0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x/vdk9po/8SQW6vKs17MrMqGW4PiqDfnSHIpJzf/ocaQh01M524cpOP1cmyZYgyCMEuu08qefr3JikJyxA6LLjeCJyDFYZ4aKSvS7KDDQCfjsIUcbCZjETIj7bf5slVHaXvAeas256Hf1ixPbzZe2ysE9pbjW/FdmVNGOwVB5xZh+Img8SGUMsCrMzO4dY1YADMBrVuXbnuEdOnpKryzxwwvS3nofO909rnwK73RfvHWLkuIoCO7u7yYABJy75uGcGopibetZoOLFkjVkiw65rv2WmGqR7GJvd7TMHXUmi8LGOwwm38JD0VhxZOk3gI2EgjMWsHw9KkfMmfV2Zj8biOxzlDfofkajFTK85LOKfejMjxRyPf1ZKktK/a5HAwxpnHabrSrRY8/Y5RFG0L8ri+1/LH+3d6GGeNlpvD5/oRieO84Malw3gbQHTSZ8UTC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:05:06.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5c48c3-9ddd-4f93-36c1-08df3f2b3e1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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

Commit c56525193b5a ("drm/amdgpu/mes11: disable MES RS64 process/gang
context loading") turned RS64 context loading off because
KFDIPCTest.BasicTest failed with it on Navi31/32/33: the parent's GPU
accesses to the shared IPC buffer faulted until MES stopped responding.
The previous patches fix the context slot handling that would explain
this.

Load the process and gang contexts from MES local memory again, which
reduces the MES firmware and driver handshake latency.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 2617c2b7f101..254a2ffc2429 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1880,7 +1880,7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int pipe, r, bo_size;
 
-	adev->mes.use_rs64mem = false;
+	adev->mes.use_rs64mem = true;
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
-- 
2.34.1

