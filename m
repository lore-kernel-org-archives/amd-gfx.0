Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE71606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F1idbVxS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363F710F175;
	Mon, 23 Nov 2026 19:25:57 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E558010F175
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 19:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kieahPomoahoydVJeTwlU1mzwaWTtYvEjFZtwSeajGVyHfEdtz29RiFWmS+m5F0WNJZgzImgmGkeQh2bzokVmpsZoc1rkF+CHKPyxFch9XTPS0byWTC+bSKFd6CzqOQzU/rHJArUmrOchpQJfhxEMnUBHRdFESJRQ428HZPZZMa+vujjpBpvM9FPajhrQ2SQ3LTM6mM8vFUd1h7NKnqJ2B6t4A1YE8Lk5NZyjDwVr3jmhKr+Bxomo3SAAkDLHpvZBTO2trt/EciwzQYC0m/4F6LDSt0GywXo0ka02LFJ+snwm0yHTes1pmIi2EnQe5cNAa2cACMcmBwWGgK1dbsl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkl94iAumAPSvx+ymrK2Lje8Jsq00VrpxF3apzvFmww=;
 b=yG5iq/AHlLqG/Zm3Ko4L4BMbE8e3FNHDAQJpKiaqLXcuIYh+DCiwHjhY3sVmiOSga3Efi0GmUdXrPz5IBIH55Yr67rmLSc+GIEi1LR9jKSMsuuw5vltADyMwHCZHFuDdw1YIL5JqpIFlpDbNdlZMxjEbapi5FhXT7N7Sh0yhZ78RtdtE55TrvITG8qycxV3hx4GHoBAlDSDBqh1tHukQLLfgka8azjc/vb8uLEON/afQtdWk2i/lpeWIj0bw2JQc/Ev/roQ29WPhb76Zkc3h1HbUjFCqWwPWFdVIjoycZnLvQBMJcM+c2rH7DORBoM3FZerg1tYd73i8zcugoClQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkl94iAumAPSvx+ymrK2Lje8Jsq00VrpxF3apzvFmww=;
 b=F1idbVxS+cjiYVh0wGyCy/yZ2QaeB/6Z6YYG7VaBK8ujHTPWvLvlEZCXBuYsyS1Vzm/CI0JtQqLLAyuGB8P9KfT4Ww51BV02RamGw8JHbL+LiW4bj+Z0iBBo6wGsPAVqo3mlsJhMt3mUh+fInfHcpLfzqnH7qZvWoUnoOY5Ar7k=
Received: from CYZPR14CA0036.namprd14.prod.outlook.com (2603:10b6:930:a0::10)
 by DS6PR12MB934327.namprd12.prod.outlook.com (2603:10b6:8:4c5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 19:25:48 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::1e) by CYZPR14CA0036.outlook.office365.com
 (2603:10b6:930:a0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 19:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 19:25:47 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 13:25:46 -0600
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>, David Yat Sin
 <david.yatsin@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Correctly handle multi-xcc mqd size in CRIU
 restore
Date: Mon, 23 Nov 2026 14:25:32 -0500
Message-ID: <20261123192532.2062064-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|DS6PR12MB934327:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f25626-7568-49de-c023-08df49979376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261026121527099003|261102123227099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: FMVq6/pQr31Hr8ANCrwYLdZD1qFn+BeHkhzlPk8AiGViIEUI59/o+xmgeyw8teAAeQY0p4ThVB+daCB/QPkhB569kzN5JxIFxxD6YeNE/b28bv6Xulx2P4ETrI1JsCcEW2TkK5mLkB8u4jnwfkNpmDNWOAVy2TVJfDzHWDcoG9dYQBqs3rUHq0KAgz73+QxZMa5/N64I9L0uWWS7t9hTixS2yH1/HrOnk9UBodlIm26WxngsMLiLg5n1wI17apn6oEsJmwI8XwtcRMqu9kjMpWa7ZRCKO+c4hT32CV0mryLZsrVyH3S0jHsSV76OnmyGugt/izlaEk1iNcmfaYMsNVFZZFRdrSbXBjyfTCxHygOOSfrfTBh+JbT6y5VlSSbyOKFa+cWZESmJac/6SUsDMaSjmlwo9bMPBjJeBTxbXhYGbAcVOvO7m/SSsh9QhVftUpbIpJVP6IjaPHnVkQ77sToVwaJMNrxfaHEtQPyKkWJNi9a0rl/ZxqsqBHfCX3aVQTx6i++aYlN+FNZtIp07xQ5857mvyw2Q9LV+BVwoMxRFO8bEhVIOfCerv2KJKEyh7st4K4DFnF5w9xbrRfqYpOBF54V4Q/yKzqMQC+7ZgK1Vd0ucQlDU7v+XFD4xU0UKclpNf2LF6PjC7G7E3JHN2MDlirqLe1dQriAYBxWVctyxZK1i3rLg+ELwnGQsGfly6qnWiKpkQTrnfNlduhOdWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EgZyceAxjUqTvVvDJ8DkXrJvMjVme/UifVyjhzOVTbCm5MNbfJy6oh+ydLfq+dgAnOPL7+jG+gWzzn/U0jSbU7/RxqoLPCDP6mqQB+Cpp5f+5nCsrkjwpLnrPP54noq8o5zgBjP5+2GlbWCkAIvrTJlCEkxjzayen7vClUN3e6GIq8vlwA94HQ2kUnB7PRI7h7fjeYvtvdvYPHr0pKOT7Vcpq8mPjddE5obNH4ypoy5VmPuct/KjGfGWjo3zY82u0SY8n8uSXQ9o2x55Er6AK9x/ELbiEz2NkrGXJwoNOr7ACod9WRgLpzqAiMWwT2M/l8Tn2yP9lYdisFBXLbr2pJEGfkudD79NXSTe3lavizCrZnrTiykDchRpk2OccVnyLWh5sU6PDdhclSncFWfF9eE4W9vo8WIWkw/HXrHZbSfp2wQGpi9rs2PzGaC0h/zi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:25:47.1509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f25626-7568-49de-c023-08df49979376
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB934327
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

kfd_criu_restore_queue validates that a CRIU restore has the
correct mqd size, but doesn't correctly handle that the mqd
will be scaled but the number of xccs.

Change the check to handle multiple xccs correctly.

Cc: David Yat Sin <david.yatsin@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: 47ea05f246be ("drm/amdkfd: Check bounds on CRIU restore queue type and mqd size")
Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6cc0365e9b11..6a9d7d31c8d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1030,7 +1030,8 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		goto exit;
 	}
 
-	if (q_data->mqd_size != mqd_size_from_queue_type(pdd->dev->dqm, q_data->type)) {
+	if (q_data->mqd_size != mqd_size_from_queue_type(pdd->dev->dqm, q_data->type) *
+			NUM_XCC(pdd->dev->xcc_mask)) {
 		ret = -EINVAL;
 		goto exit;
 	}
-- 
2.34.1

