Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7AFCD4F49
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 08:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C171E10E06A;
	Mon, 18 May 2026 08:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ar9STGbR";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012006.outbound.protection.outlook.com
 [40.93.195.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B60E10E06A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRQsLiyKml3mOYioGVcDlWwWVVhpeXd2jJ6StyXr9GwKd714x12xBoZDn8H0QtYaDA2Jmjwm7PyFoTA0jNkytzBqfeIO8xuipxRVZFqPt29fBzxs9Kr4biJ1lNma0MB9vDQ7VTVsA4U5KTD0wHle9CQFGq7tuNydwlqDQLJk2TNnoRlnvBuQyzF0hJk7ecXcspsgyifUKJDmVq1y3Pk5dNylFbLai9v1Igx+RrzvyfTIDepWI2ef2mrEzzrZbWR8zaKHHCEZP1USvxTMcGh+IXGVgcvYSmPoKFUyoCx1k1oVe+dYsY5UrXT/mlosyMnI30FFwFFRPKZqZY6ycOMp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2s2x3LPfBm6kbwTUmFbPNeEhebtEC7KYXbMpoZjv8A=;
 b=apgNBtGyjTNl/7vnqHLTvPVZNpwWc98YAaIdI5L/nAMz9LlPh3Cgol4Gf18xH4nCZ+SZiquMUvp1xjDc8LaD/yV9lEaURPTGXnTCzGIPmaagsAV2FYElcvNNsT2SdT2Mq1jcnZcJMDShPHP8onvy6+CuchPp12Q8r49Yhj4eDLQzaR+rGmIf3KvzBNLBAHKB6dMIyFwFJEeUGlrix7ICweV2cGLv9g16C3+IOnkFLgfYqjdJv/FaxJxLCzTrv1lejYm5zgEyTmzxYW4StjT9XwXohMcnT9in+g9Hy4k633Y3IBq8QIZuZolYVg8rIDjfrSdZJQZRETagvUWl2ntsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2s2x3LPfBm6kbwTUmFbPNeEhebtEC7KYXbMpoZjv8A=;
 b=Ar9STGbRQw98+pMfdmN6mVP3cqJjJCYVu050n5H/rADEqlJoXwSaIo87J3h+7lvLmY58lFt6ohkxakc0YkHBSNIEAYSHnl8FH3Ku/cn802xbQM8F26dgwbpZeToUAqSdphC9uUpf1eVpRv5y1cNegHS0inYLEkTc+sKnKcK1xcw=
Received: from BL1PR13CA0220.namprd13.prod.outlook.com (2603:10b6:208:2bf::15)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:26:10 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8e) by BL1PR13CA0220.outlook.office365.com
 (2603:10b6:208:2bf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 08:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:26:10 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 03:26:05 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 1/4] drm/amd/ras: bound CPER record fetch buffer size and count
Date: Mon, 18 May 2026 16:25:43 +0800
Message-ID: <20260518082543.786786-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 99dbca95-5cf2-4446-7655-08deb4b71dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: mGwBdW5SF9XT3e92LhX62ah1ziVfeJgEi4un9KRHWhp2X8RuILBd41uu4nZM77ejKKBclaNG+SdiDEVrwQVCdUCkLIhQTTOxHza8rrb7IlolSlJqrOiWmUh/4hrUrQ5XEBriY+ihC5WOLRiTtNO/uBrpMQ+INLKg26nh+l0RP3c1ts1oJX4KYUQLP3vcixuuBmw83A/EeZYT50xAHUMLyhQQ2mL5XaL+L4gHSzSOKt0mXLHKNy7QRg9tZGKJQf2aePMOwoMD8wYEfQ13rpaPIfo8pQBesodo+4+Z4KZ5CXsSbxPYMukjQrDXESN/vBtGIbmbgGpImEr/Gk4bj1lxCXvxgjfHRJ1Pvwl12xz8XC1EQJucuwxz2uZlXB6xN32uANUzp0MV8WAUEKa4MU1+Nfqq0Mj+q3s7UKx+ryIRa3WLB99715ZEeck63TRssigpsqV5hO1UU48eAF4/jL3/yHQ0nDmTSYoXkKEjwZJSggXb+Lk3qC5Xm1GNqdLGLOH2lIc0iB/Qm+gfbvHRySFEWjv3WbG78VxO+uWOnTjcy4OoVsiZbVG6r7j/VsGR86RY77in7rN/9Fe6C344M/oyviZPaHbjoVchDCD1oTNbEWZFwKfSNcuPXHGw3qm2yeDEZqrYG3w8qIOBkrpEuCLIzP0UPGBPbD3t0loSZr4SZLrrXpd8wQjAcCWYQX+u0AjgSTsLMCtn/9qciHNFk7293SaySHjI4nHUxHpHuXKQ7aM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 45SxwYEZQcc0/QjorPL5HvrUq2Irh6iiJVYYTX15feYqIqHM//vO5R5ScHcBe+eZS383ej7MEjwIlBjRtRjpD75zOoeE974XlVZVGLvifxojy6ZFnsChh6MD0re0MBK3esY8K1aYCm38c79OkKff5kbhnG50qEyJKzyOb3nWIyS9/e86BCZPp7P0jwZ+bLHXqFEdBt6VX/2XCJA4vVDQ34nQkypuXgWKvVU34KsbDW1kQR+Nr+XI6DqMNKV/DEYlzfcFCBP2FedhWHdXOe0vVf6EfZaNp7/k8q/CUaGC5raYGfe1eKqZTc90l9Zs+DPATt3BYPivKK+N+jjiyVBDEoIh3dsdn5SLzBloF7/zx8ErhkXn/gwW1VC04T3CwXf4yN3eRVP+xHxW/M6nGb09MHu9LWPHHj63nXvj/9L8W2kVcHPUgg/6nTHQQF5Rx25p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:26:10.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dbca95-5cf2-4446-7655-08deb4b71dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Limit RAS_CMD__GET_CPER_RECORD so buf_size and cper_num
from userspace cannot force unbounded kzalloc or long loops.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.c             | 4 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h             | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 7ec5287daf7f19..0a721d5d92344d 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -267,6 +267,10 @@ static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
 	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
+	if (req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ ||
+	    req->cper_num > RAS_CMD_MAX_CPER_FETCH_NUM)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
 	trace = kcalloc(MAX_RECORD_PER_BATCH, sizeof(*trace), GFP_KERNEL);
 	if (!trace)
 		return RAS_CMD__ERROR_GENERIC;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
index 4f89810d85a15e..5c812f3d984140 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.c
@@ -217,6 +217,10 @@ static int ras_cmd_get_cper_records(struct ras_core_context *ras_core,
 	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
 		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
 
+	if (req->buf_size > RAS_CMD_MAX_CPER_BUF_SZ ||
+	    req->cper_num > RAS_CMD_MAX_CPER_FETCH_NUM)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
 	buffer = kzalloc(req->buf_size, GFP_KERNEL);
 	if (!buffer)
 		return RAS_CMD__ERROR_GENERIC;
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 7ea35a02898742..a1a73e6452e73d 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -405,6 +405,10 @@ struct batch_ras_trace_info {
 
 #define RAS_CMD_MAX_BATCH_NUM  300
 #define RAS_CMD_MAX_TRACE_NUM  300
+
+/* Upper bounds for RAS_CMD__GET_CPER_RECORD to limit kernel allocations and work. */
+#define RAS_CMD_MAX_CPER_FETCH_NUM	RAS_CMD_MAX_BATCH_NUM
+#define RAS_CMD_MAX_CPER_BUF_SZ	(1024U * 1024U) /* 1 MiB */
 struct ras_cmd_batch_trace_record_rsp {
 	uint32_t version;
 	uint16_t real_batch_num;
-- 
2.25.1

