Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDCDC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7043E113949;
	Thu, 18 Apr 2024 03:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bpWmkNK5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E1A113949
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL8Ix8qSoDOCver4YtCSroY9+93G+/zNP/0zAZzx4Q3Q1mus6ltKbjBusZAJRmlFmiiabqV3cCatBL2aNUo9lojWt80u6wU1QoKHFpVs1g9KWqOnLojdAm95OsZcjgDqZ0IY0a0aiM0r89k2U6DAFAC6Aq0aQqiL9VpNIpKbfkwPYSWyZv3kpt7+jZV26ZOfIA/rviHygbCa2lavf24jJo1xWEyhFGSPgk9gb8iEeKfr5WDm8EsIec6K70oEcTZVKtnB76UuLsmiwi2L00N7z9ifCGnNjm3BdfBuHOVENtd/LNzgkPBfwledm5GQQRMbKNil9OT9dBWWZRmBt+Zv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYUNlUVJiZI42ReYgvUcLONLr2mgR8SIdFfOLIKkrDA=;
 b=hjnYL5G7vHIS+v9821a6v5jBo5DOATS4O71WZBNObvuLL9NveZ+Mb1CHxvcT2V2rN4s46qDfaup38c7AJqJwQIze3Fb8BTZClo9Q2agPxgz2orQx5HIGvQ7/7nPFrpP4vv3/0jTtE8zd7atZwOpKfGoYmiixWgGg8K2HqKutHkPivyKDu/kZ8krg4KxeXk8g4yPu9fXPgUpvjn5x+AXc0lpxKT9H26Khc5iKQ+RsXT08DPK6IY1+9s9lRvxVtR4zqW7pvpdlikr+K43uC5KnUqrwzWgFlCcnw3TGMeJLg+ryKM3oF7Dla6tbV3GK/EEyHs04agjf7TKYN8qQnpQlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYUNlUVJiZI42ReYgvUcLONLr2mgR8SIdFfOLIKkrDA=;
 b=bpWmkNK5FOHKlRD25BrEcwXacLo2e8/QTX1K842Gfu97MeExTO8YdROox2S8WpWVuiXZeZXKSxFVb3L1Tj7Vhu9fCnc9whQYubLDgqz1T7ZE4Kz5XhFH86eDWkhtYU/pxl9pWeliCMMTIZoMqUIwBgFrmH30rMepDgnPBn4G/Wg=
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.39; Thu, 18 Apr 2024 03:01:57 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::d8) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:56 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:52 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 09/15] drm/amdgpu: add condition check for
 amdgpu_umc_fill_error_record
Date: Thu, 18 Apr 2024 10:58:30 +0800
Message-ID: <20240418025836.170106-9-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: eb67ade7-7944-41dc-d15c-08dc5f53e888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLHvZaChlEmvQNy35W+PIhYzLIwXgqH3SdpLommghamk7knZrztLTpr4UTI+b3+Y2cGCdHbQJPGxcTCw2z9aweCtGS/OrKZ4Qw2qEwBg6QcLMOrcH4h81lfXd8RK024snyRPH3au1QNvyoYGV3vUQ62ZCtYN5RszwnmliM+sy3M8pC6piknUh9wv279PeMdcCf6WJqyddLq4iNoSi9RoTomvMdPG3xiH73kiueRwv8AVb34h9X4n3pLbQZ/pqhulR0s04JpqPyxoks3jAcGg901aQm13WxcDX5af1bvh72cFIvVbyMtksF0Cp44dmGnQPs0dbNjZFu3ZB6qKfKrEKcdW6Jac232JcEnfB0cujaRibeXXTE/Wif+qcHEqwJ+Wk20oNzu1FXmXH9g7wVoEo6bjglSDTvJNXn0SIu2MttBeqka//AASk97VcL9kYOc6kMQONuRnBP0z+5N1OIBQvXWAXWzdVLl5/qlyzH+jpPoV+mrt4GG7OgbornhR30YyEC/1qGC4bzXyszQDHACiVYG6r7pg7nZPxvkwvPyIiNuoS6qzcNcDohb8kXOq9gcS8hS2Yo3+8cqmQu3v5DkqO88+Ja5oSHKcAndXbjBQ8LDyWuNKrXlW16pd+p1ktIohHVapgTaZ8WPypgvAZi+J3Js4lGso++QWO12mBta14BFcbQco32AP15DG8J9SxlMv/lTVSS4CuiYOx/L4yEkrFLnNhI1qrhp/DQHOoEVd9HnNnP3/MmaQOa9ETPDw5jIp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:56.6097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb67ade7-7944-41dc-d15c-08dc5f53e888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

Add condition check for amdgpu_umc_fill_error_record.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index cb5a0f31d201..c8980d5f6540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -579,6 +579,7 @@ struct ras_err_data {
 	unsigned long de_count;
 	unsigned long err_addr_cnt;
 	struct eeprom_table_record *err_addr;
+	unsigned long err_addr_len;
 	u32 err_list_count;
 	struct list_head err_node_list;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 2bd88218c20e..dcda3d24bee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -66,6 +66,8 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 		goto out_fini_err_data;
 	}
 
+	err_data.err_addr_len = adev->umc.max_ras_err_cnt_per_query;
+
 	/*
 	 * Translate UMC channel address to Physical address
 	 */
@@ -121,6 +123,8 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			if(!err_data->err_addr)
 				dev_warn(adev->dev, "Failed to alloc memory for "
 						"umc error address record!\n");
+			else
+				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
 
 			/* umc query_ras_error_address is also responsible for clearing
 			 * error status
@@ -146,6 +150,8 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			if(!err_data->err_addr)
 				dev_warn(adev->dev, "Failed to alloc memory for "
 						"umc error address record!\n");
+			else
+				err_data->err_addr_len = adev->umc.max_ras_err_cnt_per_query;
 
 			/* umc query_ras_error_address is also responsible for clearing
 			 * error status
@@ -389,14 +395,20 @@ int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
+int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 		uint64_t err_addr,
 		uint64_t retired_page,
 		uint32_t channel_index,
 		uint32_t umc_inst)
 {
-	struct eeprom_table_record *err_rec =
-		&err_data->err_addr[err_data->err_addr_cnt];
+	struct eeprom_table_record *err_rec;
+
+	if (!err_data ||
+	    !err_data->err_addr ||
+	    (err_data->err_addr_cnt >= err_data->err_addr_len))
+		return -EINVAL;
+
+	err_rec = &err_data->err_addr[err_data->err_addr_cnt];
 
 	err_rec->address = err_addr;
 	/* page frame address is saved */
@@ -408,6 +420,8 @@ void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 	err_rec->mcumc_id = umc_inst;
 
 	err_data->err_addr_cnt++;
+
+	return 0;
 }
 
 int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 2d08d076f7c9..9e77e6d48e3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -109,7 +109,7 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
-void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
+int amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 		uint64_t err_addr,
 		uint64_t retired_page,
 		uint32_t channel_index,
-- 
2.34.1

