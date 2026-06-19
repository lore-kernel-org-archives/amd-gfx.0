Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0EACD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41ECB10E0DA;
	Fri, 19 Jun 2026 17:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uE2eazNx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244710E0DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7g9Pj4o14Zz0lMuq4V1SlxhNMyw4PgLg2RZ5xjHTINqArs5da8DKCwBpor5qV6zT/E/9vVddAoAC7XCbH6QL5XAgB8h90Wf6NZuRz4SZyJIOcSY1vkF/nJZaMwqOQ/OwGZR2CtkNPIFY6Op2Y06CIJRae8ruYmU7WzOSGNtJf0QxlHKucTmM4RElX02YSPSDrDaHj/bcUhPv8Z4ouAzIU+261wr7jqXMN5nONgw4FSvv6mPtTC5rmmB3efD2o/C6Cn8Xe+rmmOjaTh93C3/UvI/WYB/d5J0Kf7el7NGmLVIPlkj0uup4M9RU3uFzvaGB9E7KJfxtLYFh9hVZbhCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVsI6A/NVmFq86qIuI5G7q2QCXKVLlP2hZ6gqyrvwvU=;
 b=dR3ZWlNesYTssY0YJr7d/ktUnLIMULZI2r1HafHEVWsc+RUfP5KtQmh0Uawlvn3Mst/ToIoDQbqPF/rLlAf4gJQUr/4egpz851elol0652CmMMHIxwQYrRcw2Ryn04tHd+TLUA6VVApvrYCOcj8vIWMKCIYbdNLAL0ZD6z8t6Kktjou5YSWlJWMPAwNvWGqyWB4/Bw/C/P+e5SuspGUSzz/1Or9QF4IgGJ8jpIozuWiazOt3sntBfSnfmM6FWmWrsc/dOoVe6lY63UD2d6aUNbwFmiG18TiN/WFWOVkY4mFx4aS09IR2xXdx62Fle4bQByFdnkD5arVbwahY1sT95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVsI6A/NVmFq86qIuI5G7q2QCXKVLlP2hZ6gqyrvwvU=;
 b=uE2eazNxNMlvUE+HLobNq9W01rFwZ1gaGdtX9kSmPVXaeYhXygm/aG6ox0lxZcTJI8A4BlZFQd9EsjJGBwEr/zdWgsD8T02Asbyi6E6qIMvAHlWQOr8je9hNJ3dqjNFn0pPObd03QxULeafGCs6O7j4sv4IDTTUXkwc3FcovZfo=
Received: from SA9P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::26)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 17:30:00 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::88) by SA9P221CA0021.outlook.office365.com
 (2603:10b6:806:25::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Fri,
 19 Jun 2026 17:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 17:29:59 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 12:29:56 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kent.Russell@amd.com>, <alexdeucher@gmail.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: avoid PTL confused warning message
Date: Fri, 19 Jun 2026 13:29:37 -0400
Message-ID: <20260619172937.112275-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: d39c001a-a99c-44aa-0b2f-08dece286328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: vpwwMKt2l/oPkCeyeMSPxq12jnsqX6d447pkH+LxzTAeyxrY1Q57ym6BvHGetzIXBjPIXpjn2MEfJqUm5nx4yzs0NZdbj/wxrioY+Ww/RFBuaLOjDQZYARxftrnnxbtFq9LrNuA/slLmZSDVR0T4h9iwWBR7pgNr0unUkmPd5YNabzAL2VBT5G3pFD8VzGfGDz/5abDFRZbT9lCiu25daJqTS/h45gDUFeiXK/hsTq1ThQN1MacMdjxfpJs82SDNAXtDSV+4bCujBbqh8NyFLv6FIhHR8MdHY5cAWXv0z4U0oJU/0Vk2Muy9PTl09rbF05T7u7Eun8dtb0yvvkhPpURxs/o5TgT6T1vAhlF4cwOdrYhFEpejZc5fr8zpJuAzDmVdhffk68AYBSQ6FHRZ67rbgrcNkfBbm5d3YVtN8AyNHXLhBfrui/FF8cdkwFAkfpXHqjRKyb4sCjCUjts5SdEWNDZ0l6xc7ub4/pTbsqh6JLbAutiPA6wSredifz8qk9bJbYMkvJQU9QCQ4ZLsbBtU4fAJWFQpwth/7NeFdS8GsoANEJsdTICmYzlZPUTwnF6qiPNHfUJwQ0rwt/UBR8Ne/ImUNYXA+ZImMQs5i9KJ09rEaVHGdJbZMedeow23zXESCUJelc5c1U2LQZn45UtjVfFIxn5xoUu5wzZzAEuCCR/PtGxWq6XyuMi3Z1061R02hsYgiuEem/iIMDVkvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R3ethZKmKFcyVewYPJkViMgTPAKYDt+nTeJyNPGNTH2lUakvpcRRQSO5xwhEpKqYdXQFTaIF3jh06qJRqI3urU0PEzAS3ICIfQSB+DzLug6LGgsazELRLKRf0WqPhX0Nq0vbhj/BiLGvcOrCURfpcpruaiFYFEMKwxQS4IH3sukdBpfWp5gO2n+yDn7qjYxDBq4DmrPmqkMOEVLj+6D4JHYrTNlxSnPkbgBxEqXexyur/hdsQlO67u3MQK3uoE0gz6kX00RmQrshwvQ2Pgz/ZCt7yLrc8HsoFCnDH8E4jPP38LztRl/08ZZxpzOXyBHqFEhu4eeNyUZ8S54R3IV4MyQwrcQbX24ErI9cNzQfOXXFvpzKkg8lcKS/zHTgKBVPugyEbHwyadyBJPrw7I6NXf+s60hbGXtTw/rfsiGN4i6hgb3TC/k9ZzV8QVp2cnfz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 17:29:59.0109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39c001a-a99c-44aa-0b2f-08dece286328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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

PTL is a special feature for gfxv9.4.4, but the warning is
always appearing on other ASICs when rocprof is running, it
causes confusion, so move hw_supported check earlier to
avoid it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 575b13b557af..ab9e53dc8deb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1783,9 +1783,6 @@ static int kfd_ptl_control(struct kfd_process_device *pdd, bool enable)
 	uint32_t ptl_state = enable ? 1 : 0;
 	int ret;
 
-	if (!ptl->hw_supported)
-		return -EOPNOTSUPP;
-
 	if (!pdd->dev->kfd2kgd || !pdd->dev->kfd2kgd->ptl_ctrl)
 		return -EOPNOTSUPP;
 
@@ -1804,6 +1801,9 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
+	if (!ptl->hw_supported)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&ptl->mutex);
 
 	if (pdd->ptl_disable_req)
@@ -1833,6 +1833,9 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
 	int ret = 0;
 
+	if (!ptl->hw_supported)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&ptl->mutex);
 
 	if (!pdd->ptl_disable_req)
-- 
2.34.1

