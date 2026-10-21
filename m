Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0460A2609
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HhuB+9MB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1F810E199;
	Wed, 21 Oct 2026 11:50:10 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F59310E199
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ1EZUdsFvTT/s77LXxYzg/KNhqUMEJPXsDVMwO119TDPPIgZgRhQ3jDdjVQXt2z9CqMdT2Rzu2SCeO0YEQ5gQFhSaJ3WPoQOBNPk51VwzZf5QOpGCdMuZkGe/KzElvdkBKgQXf1OHdYW0FzNIL+caFBhnV+G6mD7LcUvRBi6lxqOffyFy9xUikCjxBJrytwYjNH4xWxb4TwLq4fvAU2TC1XYVWPB5/xNlGpqWvQYbgH7PITSwP3H2AmvTX5cAjKojVzx3rpRhfCm1OMLqz8QUHABZXgpAtmdS9iqd4Vg4h7Bv4njx/W4b9Msl6A0GF+riyLGAtJEZZAU0l18Ta5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW+ziO36v0hdp1rZUdxXSWcLXSrVje8fOjXZo/MtiqQ=;
 b=rUHljGiFeS289UZnj3wBuhAbNwgJtkEphKoz+sc/osrLOpg75CyTRjkbKBHjLujwRrmq5EHiejYYZAUbUTy+sXLgHo79l7JUv88K7TVvDaqqsZtyl+Z+xF73Idsdv69TuK5j3xy2Oms77+aRzGKtB/ol6DlJZiyTV1ONgNLoRHuOdmOJ+uRYiV6XViS/aluXxl5oSJZ8BQYzu7L4mp/ZEMIAVptusF3m1I9zXFnM5+/qMJ/RzHgUshsohll8WgmUBIX0L3+f/eNcDXrGW8hRuCND1aC9ACjU2OIRzKoKrl6r+CnKUdLm2w0tyczK8gpb3Mjj0qnPSBKPPWKaaxOJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW+ziO36v0hdp1rZUdxXSWcLXSrVje8fOjXZo/MtiqQ=;
 b=HhuB+9MBJDtdYWpHfJIiaoTEj9JI6TyshzJy5D+Dw0cBm0BtmB1HZuFD3HIAy6QqKIYh47+iuHCZ03upLHDZeyx03VSBSNCkNg3wRXpM6Q+/y/KLFu1LsFKMqyljh13wBstKZhD2canh4UN+mMgXKO3u1SW4fM4AH1dV5mdW8gA=
Received: from BN9PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:fb::11)
 by IA4PR12MB743615.namprd12.prod.outlook.com (2603:10b6:207:150::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:49:59 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::28) by BN9PR03CA0036.outlook.office365.com
 (2603:10b6:408:fb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 11:49:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:49:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:49:58 -0500
Received: from jenkins-5800x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 06:49:57 -0500
From: Horatio Zhang <hongkun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Horatio Zhang <hongkun.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: demote mem_reserved_info dump to dev_dbg
Date: Wed, 21 Oct 2026 19:49:56 +0800
Message-ID: <20261021114956.362778-1-hongkun.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|IA4PR12MB743615:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a4309e-7229-4111-11c2-08df2f696ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qspBj7SSPvh4kNueHH8nrHSylvFcK2pUbmlY6L5g2Q3u2n25gxaGHW/9ZHARrdEAIoFAjgA8wanlt3gZLgugCE4wAD3qkPPlBBd1hRHQoZGcZ0xRztbakWVP1bdtjlhn3lLLac8AdVmdXE/FGO9sr3A84Eta2kKUpTp2xU8ONeImiv+Yx1pfBZjPxSQsnrMeIBVp0mo2vrTE7bz35NJdqcMGML2CUf7GvpzPSVC8yC9yS6gEY4GIf7HsbO74obNSGjoV5eUhTjaNdRfHR7jXSUnNNFFrCAxvtWjBA70He8Ib9nHFgrFWQKe+vMQlf7V7a5utnu7Ekdh1enakdJnSNcdIkRtG4ue0pVBB43aYVKU4lOd7Z7RdEJvWCQtCT77LpqpdT5TP2IaMRf39XXbpiHNxNXjsH3qiTDyYz1YoFEHhWyPnHMpfsDTqnQIdBRQfo1ZOwgWMBu/LmlbxROlwiVX6pjUMiu/ENn5J3OyLEJBv3doKcQyfLVDO/vlU9GzE300N1SUGoleQzm9i9Nm3SY0IQhkSwcq6tcmEIGh1OWA4m5nGYpWIkRqewnQsQme9IugO4A13uQwe2VvJEg/ltqnX2gTIsvBEYKHbz6E5ayJyxd3QsRxhQHP0pqntdBF3px8wQwuiImckPgyHYsMNYyBFYBTUmkF3uFQmKY8R7HS9KJkHw0S0/HDDebL8RBhrmqOmPUfpMJ/JPyyn6/Tcnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +hPmCZzSImyEd+7pzYPaEKnThObD5gwG7svcLRa/4DrcY7MyKQ5owbaRhsYG6YHO+26xlBZ8xsUcNaP1IO60TvnLmrXzkQFxG8rfaKvZxfRkbXW1TPyy0uZ5onHIk3PU5h2yOodBx+MsDWQKjUOLoMXDM7cbn1418gaZ9k52JRyw/E9bPnQNbfFom/Cm5nQ+dp2YnTuRWzjWqGhkPw+nyX508Z8fpAjglIQPXNykqHPFjkbggfVjHIHeUQoY/sFivDzQAgCvU631+j8t/C1TdYwpaVL7OeGyRHfBlKJhO/ktXEUKhS1yRaQS8n1Hr4JUJ6SyE2MHfi7rUuE3pUdKT0W7YALjBvKHj3XhYFc+NrlhHiJJSyc4JmSqzcTruk02vCgw1F0JQIvDHFK0eh49OvGfrDbjQMFUpzesfjYhltn/Nhoy9ZrOtU2U4+RbYEwX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:49:58.8365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a4309e-7229-4111-11c2-08df2f696ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB743615
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

The MEM_RESERVED_INFO table dump is purely debug information, but it is
printed at info level, so every probe spams the kernel log with one line
per reserved region.

Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 16e3129db6a1..74f82ae8475d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2467,14 +2467,14 @@ static void amdgpu_discovery_dump_mem_reserved_info_table(struct amdgpu_device *
 	u32 list_num = min_t(u32, le32_to_cpu(table->list_num), MAX_MEM_REGION_NUM);
 	u32 id, i;
 
-	dev_info(adev->dev, "MEM_RESERVED_INFO: list_num=%u\n", list_num);
+	dev_dbg(adev->dev, "MEM_RESERVED_INFO: list_num=%u\n", list_num);
 	for (i = 0; i < list_num; i++) {
 		id = le32_to_cpu(table->list[i].reserved_region_id);
-		dev_info(adev->dev, "  [%u] id=%u (%s) size=0x%llx start=0x%llx\n",
-			 i, id,
-			 amdgpu_discovery_mem_reserved_region_name(id),
-			 le64_to_cpu(table->list[i].reserved_region_size),
-			 le64_to_cpu(table->list[i].reserved_region_start));
+		dev_dbg(adev->dev, "  [%u] id=%u (%s) size=0x%llx start=0x%llx\n",
+			i, id,
+			amdgpu_discovery_mem_reserved_region_name(id),
+			le64_to_cpu(table->list[i].reserved_region_size),
+			le64_to_cpu(table->list[i].reserved_region_start));
 	}
 }
 
-- 
2.43.0

