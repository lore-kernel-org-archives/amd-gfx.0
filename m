Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612D606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kW4xutqI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6DC11264E;
	Fri, 30 Oct 2026 06:31:25 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC9210E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR8ZtVfRwAYVfX6TgkjMmWaMm4toLkjtPD+IrvUHTPvcVAljNBsX0ZBauK3to1L18+RmtymQWhGct8LDRSTtZVPXhu+ipaD2MAnRiRlgzYoEbWulxO/uFXvebU6L5cw+eq7+D2PnAnCwxWvu1AmSjDHIH0058nWE5XsaZg98M7IV8Q/5FKlbaV3pPKMW29Vou2EqyNCxHXaRX1itlTSPIsGAaUfVFAWXfU0YBkvCMEU3Xq6sLZhwwsqp5olBsWWsrOU1jcu0EzCa+oDwVxLgTPjF9I/P0myq0GxwCpZBE3Qctz1WEaOZ6P2C7p/5WTW3zXGUHflSDANQzIzOoak0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCc4zT0yuZz+W/CBjPFSv8rwqwwcfn3xVx+zFICddRc=;
 b=w+VC985ZDAWfGrWdKriEjDs8d2zR7pmLEZ0HV3l7ZJ12QDfQtHPasr+EJz02QK1PH7vYNw96UsQUrXzHGpLPcGPm5O110HLFcdk+uj7HOo1lo2pHbWNuve86PKRjQCRAlmMEawgjzywug6yz2O5tyLTEFU0GbLs4mnELtuoUD78Wz+zzYo/q16coklM4iCaPtvSqTTM4D4xOm7CsFKX8DO4jnfO+Rqc4Byb3k1MMA5YVD9bpIPEk0nBN/SqfqGFDQZpgTzFjmkrDfR7d59K72TFqdkt4EMcKWztSm8ObJgYWOGll+NyTc48sHU8kTmnuDZr6gJrzSwBpzh84ZJ/ZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCc4zT0yuZz+W/CBjPFSv8rwqwwcfn3xVx+zFICddRc=;
 b=kW4xutqIAin8QBd/LY3jrIgkvHmrkfkqgMEjNinqwcvBgwBwUVHk3FEMLuiyD+cpN4+OGQPbRopqxjQZsJBL7yt/H7OwqYWWOtNtEEb9+Wxtv441II4S12AwQM4y87YXEi0JOLwtRgCt+2MZryEHRoN+F7hTRt3bzt8jswPJthQ=
Received: from CY5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:930:15::24)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 06:31:13 +0000
Received: from MWH0EPF000D8953.namprd05.prod.outlook.com
 (2603:10b6:930:15:cafe::38) by CY5PR19CA0028.outlook.office365.com
 (2603:10b6:930:15::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 06:31:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8953.mail.protection.outlook.com (10.167.249.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:13 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:11 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 06/13] drm/amdgpu/gfx11: set mqd->perfcount from
 mqd_prop
Date: Fri, 30 Oct 2026 14:31:34 +0800
Message-ID: <20261030063141.2773032-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8953:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b866124-4f8b-488d-702a-08df364f651c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wuQSWOYTfNxWwl4jUsmVY2A0FVqILpFJAMSSL86CAQSNU3hXqMuKaIqs3jwR83tgzkcsYUXlriHGMYaI8iMfFGtbmeXIjsbtiQTz1m9iximKtY/nxcRYGhNNcMbG5OPvF/HlFDoQpSDD9gr1O2XcwVkklO9G0RBYgo23/YZk7zJVdzkNctmS9/wIS+ZHI5FoCsBIakm+nayBYH1qZH/U85ug68q+r1s5AvyVH9w8I0MAR6C29KIYIAKm4WlY+xnxtLtVT8K/0tI0dCFJnsQM4HXH0vI6iYhhzGqX2zQcvixx49kREknomlxEllaXoB8K2LS4zR1iYV4sNJ7RQQmde/rcbqxyns8rELHCyyWiCj4BmNClBUIjzLZy7MyvhtcnkX82RdxhLuOfOiV+x6U0Aswat1BVWJpz0DZmWS52bA36ezI3lWKe+VdjTIs8GWfRbN9MBQ0gWgdUCiWzXlAD6F8wWtxV4udvHZN30xdMMSQypPnr7hMkit0+iVIbZH4VRMVNRo6L4eQdkLVTYMFO3s19y7iMB7RhwqXegGB/Pm3HozQQGX2D7/EpoS6Rgm0b3c6LJZF4BV7xGolGKYq+giM07cKcaWoMi4N2SmXgPodVgPaMGilfUsmJ5+b4Ue/EmYhK2wWc3GLYQbpbAhiKMAjk7681umUniEG4dqABxZRSBkhZRuqm4AwKYKoshrFV8J97S8VSn7bjD89L4/EQ4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MmUcvy4zd6gLDg8rfg+FohyV6bRVv6/+AC4P/E9YrPhscA1KAVNY1nMFc0R66ZVY8nMRJYXzl7suWO5hoDGxwulfnaVtX5F4nkK3hxlwp8F+ur/lDZ5fFtlxGyHkTATDu+VfgjYKq3Ty8v6VYcZXE7DC0PNy5q/ApLjjJB8HjGtqkxH8TY3puRxUsIurbM46YiwbbHR/UPm/2KtyOla7TJqm4U/3hR4QCH06Xfu4D0VBf/tClNZNSbtWbLs/owwx5on4Ohcx0isVIhpYokftqsWJYjd4rFnAg9MjHAy8CN9MwUhjawIYjzRGZAsdYYnlKGs8oh5WynycoUmvxSpK1QuYuWre2E40WTqV3ZZinpM+Zs/ZIPBnUqgcUiTLgCIeAIT+r14zDoApgPF49IO1kffa6dJNkLnoN/zb/qVxTmu55E+wGHUMc7uvulKCeHy3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:13.5247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b866124-4f8b-488d-702a-08df364f651c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D8953.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
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

This commit sets GFX11 mqd->compute_perfcount_enable
from a given amdgpu_mqd_prop

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 373c52b7022d..823ec6ed2ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -480,6 +480,8 @@ struct amdgpu_mqd_prop {
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
 	bool modify;
+	/* PMC compute_perfcount_enable that programmed into this queue's MQD */
+	bool perfcount_enable;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4b5faecf13b9..e5ff9005d204 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4326,6 +4326,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
-- 
2.53.0

