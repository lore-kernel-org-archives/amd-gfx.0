Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E8C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C28113942;
	Thu, 18 Apr 2024 03:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zFO8QPs/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6481E113942
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGcupMQF8KqxR92p7H4nD4VJaBK/oMehoQ0X+tRcqLkOAj+nLlkhMuIWAPnaO8GapR9NQXtTIguj7YZBJ38w7AIKKJXElzl/mF50edBiQB0TlnAV39P5MEeWZLc+F98vLEfBAETgHumRAsiwXcoTRp761lJN6SuIAe5pQ6/0+0MBaq1LP7jzNJxH5y0WwL2eX0VXY2mXhGzWPMIBXh4w9ypwZwUoW6FX5QfQllyralwQmDRPaDMQMlTo/DANJSWFgocseGVn7HWGsC7ZNy3cP6POd/83Vy1QgioCnWSLrF6C4QMvIpk+2gHXmAdKeiKSyHa5YBE7KNzeg8a+lp9GjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwIuVUhchDCQWGWfX3O/Ppr+VZ1Mx0a5UBW8zfNLZR4=;
 b=jhi4g4kJ0LV5xQL8TTmY/2ndd/3hVmk8+SgxVdbK8N44WRUYtfvoAlg1zajqVg5uV/uJM9eWowESUpkb83gykjlIX3N/JT7jaIJmF9VdQM+F7YSx4bwEwX0vwFjpBiB4clxwSmq8miqiTL78jkoDDVKXZVUVkFVYBJWNKIwZfzMdE3HrD/Qo8vhbAes3y90o7/2TDdc6VPgTFwgTDIHOIsFWbg9/QfdwCD1+N99TcdzD6NpbFt5OVGxs0nbDNJC5QEW9Nd15AjyqeaoBG4LGgbSF/GuuF+YeeBPnR5TzWEr5GbZtvqK/xvRKFNu1Z9N9Trekj8E8GMASXgv/W1CfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwIuVUhchDCQWGWfX3O/Ppr+VZ1Mx0a5UBW8zfNLZR4=;
 b=zFO8QPs/iNWVATitg94/c1kRLc/BUEw7mm/XO30GIg3iUx0d7xJNR9k9YjWCMe/A+yjSSOlNu7vZJxDGkEPbzN1IBVzwCgD4vPPfsGGlHOxNwaDGjjxxZoseYWMf/JVCh4uQkU0bp/4fCpGq182Ixb5YPH2Sr2tm/2Z3NwTAfIM=
Received: from MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 03:01:28 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::d) by MN2PR05CA0011.outlook.office365.com
 (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:28 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:25 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 04/15] drm/amdgpu: add poison creation handler
Date: Thu, 18 Apr 2024 10:58:25 +0800
Message-ID: <20240418025836.170106-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418025836.170106-1-YiPeng.Chai@amd.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1d08e0-68a8-4849-fa01-08dc5f53d7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8qK4mY5il8jgz4UadjVjezXwrTXiZC16BCXDf5hIfhdscjY7LE7BYYjTwu5Le3D3wh1q1icupgQYx90dwpKpgBpmJswUadvm3JrOhjk7tAHbCDBqJWzv1WOoWvL75t4g9QJY2HdFR9JbufhA/YJTQsuldFpwP2P1Thk52U8XUuvVO8weMUquCF9q4XrZ7/ysjjkzf/tQ/NALe4AjypUABjpOBZ0NDnZLhjyZ8vUgjLDGO/HCN8YlZPGvNQvFhbSxSV97JKxCkYs2sEIYCIbimN3Y6eS/RdCIK2WoHoA0kI4+8LXfwYiOQoE9Et4XACxpE6HZViVO5xkEGWpAbnOLbMfoTEU3Z6gvynAQklcsBQk+JMY5fZ5YxtTriIKQbU7b303Rf0sqxYWuiTZf1uENzYMZNPWuqrYM/DP+UD5wHfqk0uUpW55i2rd2RpSJiq7jpZRP265XCVYIhEIGtLRe5lVVjmKmOPSnx5txNzan5N+nUv0fQHEHZSsxh4fxC8H5VLrhcw5dCJsI2j+9sqqw04Gcfc1YXrrSJS/RFbnK7tfD7KUEVCPYE9DsgyTumiCb97I4G3ev84sqyVSjd+yTxS9j7zkB4GheKyS4HXeRffD1m0f/pWH+y0zXfr1bhPoVfRscIWk/3ZsnTn1V9HAOCk1vhfj99Xf2DRBpS6iuEW497pddlYRcI2iD1xA3jCJ5A7sQeyLTIgVcfSFNhEnagl7BktuGihKcnlFinFO9+vP/q7skuAbbtrw8Dm/gbtc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:28.7020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1d08e0-68a8-4849-fa01-08dc5f53d7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267
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

Add poison creation handler.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 +++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 64e6e20c6de7..126616eaeec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2080,6 +2080,17 @@ static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manager *obj
 {
 	dev_info(obj->adev->dev,
 		"Poison is created\n");
+
+	if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >= IP_VERSION(12, 0, 0)) {
+		struct amdgpu_ras *con = amdgpu_ras_get_context(obj->adev);
+
+		amdgpu_ras_put_poison_req(obj->adev,
+			AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
+
+		atomic_inc(&con->page_retirement_req_cnt);
+
+		wake_up(&con->page_retirement_wq);
+	}
 }
 
 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
@@ -2754,10 +2765,54 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_destroy(&ecc_log->lock);
 	ecc_log->de_updated = false;
 }
+
+static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
+			enum amdgpu_ras_block ras_block, uint32_t timeout_ms)
+{
+	int ret = 0;
+	struct ras_ecc_log_info *ecc_log;
+	struct ras_query_if info;
+	uint32_t timeout = timeout_ms;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	memset(&info, 0, sizeof(info));
+	info.head.block = ras_block;
+
+	ecc_log = &ras->umc_ecc_log;
+	ecc_log->de_updated = false;
+	do {
+		ret = amdgpu_ras_query_error_status(adev, &info);
+		if (ret) {
+			dev_err(adev->dev, "Failed to query ras error! ret:%d\n", ret);
+			return ret;
+		}
+
+		if (timeout && !ecc_log->de_updated) {
+			msleep(1);
+			timeout--;
+		}
+	} while (timeout && !ecc_log->de_updated);
+
+	if (timeout_ms && !timeout) {
+		dev_warn(adev->dev, "Can't find deferred error\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+					uint32_t timeout)
+{
+	amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC, timeout);
+}
+
 static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_poison_msg poison_msg;
+	enum amdgpu_ras_block ras_block;
 
 	while (!kthread_should_stop()) {
 
@@ -2768,13 +2823,22 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 		if (kthread_should_stop())
 			break;
 
-		dev_info(adev->dev, "Start processing page retirement. request:%d\n",
-			atomic_read(&con->page_retirement_req_cnt));
-
 		atomic_dec(&con->page_retirement_req_cnt);
 
-		amdgpu_umc_bad_page_polling_timeout(adev,
-				0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+		if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
+			continue;
+
+		ras_block = poison_msg.block;
+
+		dev_info(adev->dev, "Start processing ras block %s(%d)\n",
+				ras_block_str(ras_block), ras_block);
+
+		if (ras_block == AMDGPU_RAS_BLOCK__UMC)
+			amdgpu_ras_poison_creation_handler(adev,
+				MAX_UMC_POISON_POLLING_TIME_ASYNC);
+		else
+			amdgpu_umc_bad_page_polling_timeout(adev,
+				false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
 	}
 
 	return 0;
-- 
2.34.1

