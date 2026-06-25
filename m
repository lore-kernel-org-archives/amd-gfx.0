Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764CDCDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 03:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1011010E163;
	Thu, 25 Jun 2026 03:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMRf0/hJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2282110E163
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 03:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9TbTsBwH5fDyn+7T/PhEeqQ/yg/AWejcrGt3WgFf8MNs2+YVaGy0wvVWCPecWm0XSWx9umL4IUNapgw9NKLwgz/jagGPwT9cwawnOpLM7kdPsXHKZIrHfBhwsHR3eyJzQSXDbHPmcIgp/Rb1zvTL190W25Kix5lnD9n+TIKX+r1dokgmPpdmlL/Wkr70Gai4VyRdUkFh5DS5WPrNVcFIUx2W7hgi9eQxif8Tyoj3Fj6+FczdU8k/w/O5ucO0rVIOC8fw8FfTm7qH1YEHDE73l3zTktlL3fm7CTBxhfPqZhyguXKjE2JeXznM7CyxwpFYzufZKzZgxFdiJnfKoLZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmhFLtKo6/xdY0/bfdyZRI9wG0een9mx6tyRuksSrxM=;
 b=h7vxMynVupZwjVb4wtw7GHBi2GNRDnNB3xEMJ/gjPfOwHQ2nVDATPFH904DrDg+VjQ2LGuVnuIQQAgmLlIvT7RwtsEX2qtPpzlYK1Br+g+CJ1KIn+JSh9DlCKl4zj8bF/EmnYFbBnbeW6UE7TzlR6kn8wsdM/XfOmET6a2Ur84Q75HUjXL+LCGJvEU+cbQe2c5fGQ50AfAxIGx98Gaeuiy+t6wy8M8U07co1/Y0Px61zbMbGzEW7skjxbKEFYosECwk+UC7v+DSh7nUsEv6DMENZCMCJWv8Q5QE+8GdgvpXRj4wfmNbSQHKX1NLO+EV2y6Fz5eu4GJFVGZJHhgdWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmhFLtKo6/xdY0/bfdyZRI9wG0een9mx6tyRuksSrxM=;
 b=KMRf0/hJPjWcjfbw5xDIsiLGsFljvf1BoPvVrw6VlvUGYaPiin9vo1wOdGujgKbMYQCRtAF8Q3LQi9RadawTAUNG9avwm+xFhHF/GhmRTvhpH+1nc+UBZbqM9GdRN0D4jTyoyVdqCye6+lwLWtX47LxA5Z05pawpVxx34viXHfc=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 03:13:05 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::63) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 03:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 03:13:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 22:13:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Shaoyun.Liu@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/mes11: set doorbell offset for suspending userq
Date: Thu, 25 Jun 2026 11:12:51 +0800
Message-ID: <20260625031252.298647-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625031252.298647-1-Prike.Liang@amd.com>
References: <20260625031252.298647-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac6c321-009c-4cd5-3353-08ded267ac77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aw4yhsNo6MjmxVROM5tu6vC4mc1HidnDf0Kuim2YizR34s6ffJq7QCWGTX1TJ8UED0gIu7yk6QfpSlmCTUh4XDfopYyc4YW55Jn9YyVJJMu4+UuDqlgwjeLHW1skMdRb4t6s0QNWT0tV3iP1jwViN8Ar70sSl+3zm3IutLUaG+CntI/tZA4hya4l8zE585fTzSkmoyQHy2omV9iqh+tNg+3t9bBrYZqsN6cpaQcR2AtvWSP4y+399vP3EDlece+qJOh4tKCKCSjgCBMlueYm9Foh/c222ToQVNaSLl75Qg6ayYK0YtpGbPt7WVQhpZ+DRXwwYT1RKCHZ1Oo9U75hmhEiEVEsDWhdGjYV9Zw8sNcmPtZ8eDGd8lP1SV3ReJRTR99/XMAE063Efljec/9eBjDlhKHv01iMXNIClGjz+Kfjj9c2+AqLp5IVt8j3pPSscRnKb/6IPlcTqa+yWiYVAEVLywc5P0lQkdJm4kuIVFRL5L9NAHkVoNatgfRQAXqk9A+RRbifks2d3Duhl46a4GJBvPa2P4Gk2A2k7bIAFCm6TYfYmmG8b940+gVYhy+eWrABQUeoG5PtiIVXbG0QK6WkpyRRsVse4dNTsRmJiWXMUqzsm6bCQNOEzAWsrsTJRjTrFMSeP7ID6FC15Obp1P6lsdtCIHGIOIXd1cUOkHPklLlJwqtZ+qgI1WPG+959Z4uGSTheyapuvxvYeK9EPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ydpgHeN6XxPgeLynq/WunhOb6jpj4S3jMWz98GxogBsiQCzjEi8sHRFIeo2fkBRTXqpwPkz0yuOzCvogsPrO7wXF7wNTrhqYOdflA5Fdqd5Jzmq65rrBm1fV8Z5OvTDpkucbyEKx7dY7ZMyRYEzv+lU+BkEenm3THHcuPbhop7fTId7nTdPpTPK+OBVy23wDvgjLn5cb5VgI73UAKf5ApCOyG3kHcll/ZtHZ34lsdMBT/7K53+g6rs3WtCVqGLbqzcM63h2Mpj0ii5RJ6Jzfv1GwZmfM0I3Xe+Ejff27XSjepfzXu+hHmkksNlKSULayZwClk83BBXIi8n0ZLrrgAXPsCpaYrT5yi9bE9m8cr+XvNrUBqgXAp1ZkHqru7FDYzF/fegMNslJxJ9ouCeJelgl0vShpzZgXe1ZA57VJNtS+p3hqgItQkfa7rILxna2f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 03:13:04.9425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac6c321-009c-4cd5-3353-08ded267ac77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

Updating the union MESAPI__SUSPEND and union MESAPI__RESUME to
add the doorbell offset for suspending userq.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9e27d01cbfa3..ab0de6d04ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -783,6 +783,7 @@ static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
 	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
 	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
 	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+	mes_suspend_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
@@ -802,6 +803,7 @@ static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
 
 	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
 	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_resume_gang_pkt.doorbell_offset = input->doorbell_offset;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 6644fabeb0b7..b06412ac8583 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -428,6 +428,7 @@ union MESAPI__SUSPEND {
 		uint32_t		suspend_fence_value;
 
 		struct MES_API_STATUS	api_status;
+		uint32_t		doorbell_offset;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -445,6 +446,7 @@ union MESAPI__RESUME {
 		uint64_t		gang_context_addr;
 
 		struct MES_API_STATUS	api_status;
+		uint32_t		doorbell_offset;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.34.1

