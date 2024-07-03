Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211EFC2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 08:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D0C10E76B;
	Wed,  3 Jul 2024 08:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qMeI6Bin";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8849010E76B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 08:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4gd+TnCh/ZDsKOzIbm5jqKRKHhsqWeFn8aWMPUqxNHskYV3WfmzmxUfWCrrBK99JmlJknrrczcROHPY8zLLR2oOkbFDHx/qXCaix7zp5KG2iWZeYT00oz6qDOVt7ELz2loFfSGlRTHctf6DQ8SfWg5IN5QDPPb0mpt4QnBET6/B6ahwraV4gh5jk1SnFHm7iZeqQBInH8+C9KRcFW0LIF0QZ5HJ01u59Tc0yZdIqUu5jdOf5MiPfdL35KU9/1Vr3jcTBn9QZP/T1vlwHt/8tJXJTL6qrUuq0PoP1JuONvFjpmtgJvE7MYfKADhB0GvTuH9kmf2j7I6z+1IEb0OEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HVsi1K+xjETTb68zyq8fvIitxvoQVKAER0iaPm+5MM=;
 b=QDt+LpRtmsxqxDg2l6oEBRS9aiPSm/znW+B3BARHHiLL0V+2lG8/EyI9oP85C/6T7Nen+46Hot9lNQ/0coZuSJvnyAzpyuBypY+AqVw5qCdvfwl+P1K3HoS6BG1Ljkpbl8spyrUIoCot7FdVmxfNNOCiKyklU+0o80UGd78KmtGtArhpzdn9Z2Wda2cyPkjUhQQ0uY2bB71RJhhSgM5lL28lkaL2In+oPx8KAAIJFYEUtz3ZA5PrxN8RDla/14KKNBpWC42VZOhXuIiPRZkwUHcSFTalXsyP0xFsYm2o79y9MA9mueTI/8cAJ8i34k03TOiy74zn1+b/5WC5Vv8F+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HVsi1K+xjETTb68zyq8fvIitxvoQVKAER0iaPm+5MM=;
 b=qMeI6Bin0LreaPEYPHIacaJnMM0C/56gQWBF3DPJNHzNxGqV+0cqnh6FI/kqqVsoCNztFjdeODdt7JgtzWmi7KE2HVJlVv9PkzaKdVqT2FDtiTGZxhGNmrxekDEeyAY15s9WesjGwoDpRBK/cDmCmzKVyAlrIcWPIFtwLQOIRuE=
Received: from MN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:530::33)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 08:42:31 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::56) by MN0PR02CA0011.outlook.office365.com
 (2603:10b6:208:530::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Wed, 3 Jul 2024 08:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.1 via Frontend Transport; Wed, 3 Jul 2024 08:42:31 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 03:42:27 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: flush all cached ras bad pages to eeprom
Date: Wed, 3 Jul 2024 16:41:26 +0800
Message-ID: <20240703084127.478058-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 281be5fc-3c06-46f5-09ca-08dc9b3c1405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pBOC39bhVnWnyIuDEN3L2BszXU+7b2i7TWXT4a2m+xx6jzV1oZtDZFWmm8X7?=
 =?us-ascii?Q?GvpoVRbO3KRJSxNyzl/OJf67ztQ/fX5ltFE3/dNzUZi4vHQrY6rgHCt3aqRe?=
 =?us-ascii?Q?cH7JOgOuUNiy4LCNaSJgnlYwasGZnR8vodQtHnRmrbIWUiyw/rv5+0M8uAYz?=
 =?us-ascii?Q?STgsLk67od+FGb5gT0QiyYMHQ2h1faMVo4osqwaOxWw7P62cYT5Rt6S4mNWy?=
 =?us-ascii?Q?vLim70YblnIJJPFZV+7KVC5QO3FfrTt8bhxxYgFbacu0ojA/bSiO/BellsqY?=
 =?us-ascii?Q?wg6wxke0AlQa3clk37iGe8xD2zrk+irk2FL5ozM/Xd73/ml9tqztJjlJPrdw?=
 =?us-ascii?Q?OTMz5D0NOsE966e+3lSAe69LQyYe1lu0QD5n8ehmAuztNfddxVWnObTESq3s?=
 =?us-ascii?Q?l7Z2KlmbEenn2Eq240EH9ZWrorq3ncgGIIZqlyLiYh87xEiC1zYW6RzjHmNC?=
 =?us-ascii?Q?VhRjyst/G4hPCziWmC+NqxxApyg1tV/U8w41+JrDLpEK8JLA6QWuOeqNrPej?=
 =?us-ascii?Q?W4eCStR+KeKoiNo8BGRtbEwoFO8qNdEJGF9oYOrOoZXna0TZNnO/Ip1d4b40?=
 =?us-ascii?Q?9FDbpWpXS04QpA6/Qv+VFV6DWX8olLutRxBmlgSCgKmrskwjrQsnMOQxss4I?=
 =?us-ascii?Q?S95xCSJERn9FfBLawpiiw1PlTruOKvtijQIvsYO7KxJeAed1I7nmzbQU/m2G?=
 =?us-ascii?Q?nlqymYWuzCV3YQ8NwZuOrRJXgQgnOYLMsGwVkYKu7qiBOSo/sFe5nCGYUUmA?=
 =?us-ascii?Q?lCanYkExJFrL9rvehUXfvAObfbZ3PrLZ1VcSIuhLXq2LGWHbDaTU071Ch5ax?=
 =?us-ascii?Q?bsLDnUabNCw72WP5pdN31nyZjj4uawGbc8veB/Nzy0Av61pEvgv9+8+/uOD7?=
 =?us-ascii?Q?SiHxVc3DdhefRf/25dCnd3eYTqAkVIZjINhV4L3OOlTqROSWNbRa8xxJCokp?=
 =?us-ascii?Q?r5PdeMzHEigZ6JR4G2zhTHze3dm9vThSY0eZfKeQ1mwO7POTTzBXCOKR+47L?=
 =?us-ascii?Q?UcoyoXxb+A0F9w5QutjgzJAZBSmQCGYYey9U7vLyxWeGRtMCGBQMSU3mIJL5?=
 =?us-ascii?Q?Ei9w/1fzBnwJt4AlSRWWWAhKzOZY4FKFNQgMkKK9mnorr89m297RmB0NC8kc?=
 =?us-ascii?Q?PruDtk4nmKWK6TXfCEJL4HAPKUub9Iu1R8rVq3d06eNOnPcYaUSTqJ/7dKcb?=
 =?us-ascii?Q?LCK9/UO+6PhTgAxnI9N/KjP1fRWjf/e2WMzBPYOkw/Xu3FCCgVQD1A4/BTwO?=
 =?us-ascii?Q?DMBy0ORS7WmONHCs6G9XqqxmP4LZgyrqaBBZj1h4W3ZA4UVI6VWMtoeX98BH?=
 =?us-ascii?Q?dqnvNlnKVIH6+WaQeylNkqH14xWL4NtgiEU8zT6h+eMDYo4azHg0bfIbXPBJ?=
 =?us-ascii?Q?vCuUZYQLrKQz5dnpNxynaDtR16IOd+1UXUN+zBYg4yiQl6qv0XlsM7gKJoh3?=
 =?us-ascii?Q?QvAE5IxKGqUQD+pz7c/tYzggbWW6SDZg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 08:42:31.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281be5fc-3c06-46f5-09ca-08dc9b3c1405
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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

Before uninstalling gpu driver, flush all cached ras
bad pages to eeprom.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 26098b03447b..1b6f5b26957b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
+#define MAX_FLUSH_RETIRE_DWORK_TIMES  200
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -3176,11 +3178,26 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data = con->eh_data;
+	int max_flush_timeout = MAX_FLUSH_RETIRE_DWORK_TIMES;
+	int ret;
 
 	/* recovery_init failed to init it, fini is useless */
 	if (!data)
 		return 0;
 
+	/* Save all cached bad pages to eeprom */
+	do {
+		flush_delayed_work(&con->page_retirement_dwork);
+
+		mutex_lock(&con->umc_ecc_log.lock);
+		ret = radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
+				UMC_ECC_NEW_DETECTED_TAG);
+		mutex_unlock(&con->umc_ecc_log.lock);
+
+		if (ret)
+			schedule_delayed_work(&con->page_retirement_dwork, 0);
+	} while (ret && max_flush_timeout--);
+
 	if (con->page_retirement_thread)
 		kthread_stop(con->page_retirement_thread);
 
-- 
2.34.1

