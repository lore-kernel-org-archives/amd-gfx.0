Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01348C05023
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D3D113940;
	Thu, 18 Apr 2024 03:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpfnK58b";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF170113940
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWAqXYfwANDWUBfqJu78aUC6HIwbMt5boLqQlcTx53dNUbSJr9EV1jHKvC/jC9Bn/seNhwWRRmm6fN+50zT/rX/b+QSe1Yp2Me/f9u4y/ye0Zo4aiIqP1wOhDCGFqiSKpDmj7GNLZh5vBzvU+WbuReNoyBBvC2DVBgViTY9ZmKmMeRKkxgv83oFI7DyoCbSRgkKOnxBxBn/sVPIy7UXgZL1pmkawLdp1UZaAGIOIjnkHWehcSzN+p7kOohUp3FCI8d6YZV6aEjbeL30OM+vPENWxaOmmaJcyc7mxRFn+6Leo3RKHaFFEU4/E9b7JuZLIJ3QzqnkJ1d8g2mLyGHxRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSgLkkIqoUsA3frXDXdHtWdgIALPdn6jgcEfhkrNa8U=;
 b=DKj4l825eOMRDDQCqZhAMct00MI6gC9qZRTqJFbgSqa7k/aDNgMED6yD+WS8Kc1i9bDtudNqrSeGHQnZxKAwhKs159EwNZcvwsnZT4ntn6a86133tVV0D20FY3UZEhTdmU4PmQjOBqu3cz+IBBNfWWDV8Tw3daN6tehiDHXjMbwi9c+p9bQ/ogmuBjze+/coM2pfowEPDZsqtVyYpT4VPcm5eAfZuINTqnSwOa+vSciWsuRMlL89lhnWurwe2ozrUAZjKBbsVlDIBjaTj7mBUZbgoVKQwxFTeY7gq62Kq+MiAXmEbgq5r/fzs1BKBX18t8/PSU6ZF0YHfPjJTp/xzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSgLkkIqoUsA3frXDXdHtWdgIALPdn6jgcEfhkrNa8U=;
 b=XpfnK58by6wnkx9EjJmrNAVj7n2i34rgI5zWQz1GNp9pBohpfjM1CnbSJy9hlHa9PDn9LaSgzB3o6G2r/BMOO5EtpIzw+tVZKZOaPNBEgib4YlMbX7h9WdeKG/zsCySLZUEWuVyS/ig5mWliUA3D1/3PQV6mOx6ItxP0zlbZiHg=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Thu, 18 Apr 2024 03:01:26 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::e4) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 03:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 03:01:26 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:01:23 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 03/15] drm/amdgpu: prepare for logging ecc errors
Date: Thu, 18 Apr 2024 10:58:24 +0800
Message-ID: <20240418025836.170106-3-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4023df-6449-43ef-0f99-08dc5f53d660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VY55zXTJSYl8qyFZagiB7lyzDN5pkDWg90skx9ASkSQb1Nw9pggK+Bo2zMnmfMHiv9RFXiVdw3IHpdJEs2kdjAsH6xe4UrIxayCIwuGkxBKj6DfAiwIFlVy8AmjNV0scYwNA8WiFaWP2Tk1OXmFqaWyn+PisHslu7pD6Ge5x0sfej8O/eGW3ozFSpHiWuGsB/AXBqen+IIpIG/uCCzPf/i7E1iL0WG3OQJ3yO6jdu3dRKouxkw6rVg65Wtt1CSjISo84u0kkTNUJdewJKt4Ng/On/U3kktkHziTODbdfQxlHk4gfo5De/XCxrAOfFhgapolsRnSGYoL3ipfnefDcgT/SHsCMJTGCSX9C+7H/iCGGITTMhl9djIkkrwQnVKu1Gh8YL8U9LRCFcvszpVjTD5pppvZsJxkqOlsX9JrgQ4QcKBs7fA2a2JVsAabBTFoQ/KJiNockeAt/MEn+ItlIc7cZ6sifwqORGu1wifcGzLRfKJNq/SmUaXKhTVSEi04ZNJeeZnJ04lkTkHgMJpK7gQIKIzqyHvPDIbVC/HrNr71C/RkpvK33V0HdnyCJ1t4Ro4jjoKkEXgr6JGtJuL7DLfViktzNkj2mVFgVVeIX05tAtWB3gHxg17HvE5A/obgoKycn3LmzwYNX83LlJlJeRqv5/gWj+tJA+vCoePMilkACpZnemEeLNYMq31AjHRFfZw5QuRgMl22qtl+kDlHjDe5jT3FtX2m1VpM8TRYFw00LP6KnPUsB/6wDvgAQyO1B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:01:26.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4023df-6449-43ef-0f99-08dc5f53d660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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

Prepare for logging ecc errors.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 23 +++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0de5a22e7126..64e6e20c6de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2724,6 +2724,36 @@ static int amdgpu_ras_get_poison_req(struct amdgpu_device *adev,
 
 	return kfifo_get(&con->poison_fifo, poison_msg);
 }
+
+static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
+{
+	mutex_init(&ecc_log->lock);
+
+	/* Set any value as siphash key */
+	memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));
+
+	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
+	ecc_log->de_updated = false;
+}
+
+static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
+{
+	struct radix_tree_iter iter;
+	void __rcu **slot;
+	struct ras_ecc_err *ecc_err;
+
+	mutex_lock(&ecc_log->lock);
+	radix_tree_for_each_slot(slot, &ecc_log->de_page_tree, &iter, 0) {
+		ecc_err = radix_tree_deref_slot(slot);
+		kfree(ecc_err->err_pages.pfn);
+		kfree(ecc_err);
+		radix_tree_iter_delete(&ecc_log->de_page_tree, &iter, slot);
+	}
+	mutex_unlock(&ecc_log->lock);
+
+	mutex_destroy(&ecc_log->lock);
+	ecc_log->de_updated = false;
+}
 static int amdgpu_ras_page_retirement_thread(void *param)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)param;
@@ -2825,6 +2855,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "Failed to create umc_page_retirement thread!!!\n");
 	}
 
+	amdgpu_ras_ecc_log_init(&con->umc_ecc_log);
 #ifdef CONFIG_X86_MCE_AMD
 #ifdef HAVE_SMCA_UMC_V2
 	if ((adev->asic_type == CHIP_ALDEBARAN) &&
@@ -2872,6 +2903,8 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 	cancel_work_sync(&con->recovery_work);
 
+	amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);
+
 	mutex_lock(&con->recovery_lock);
 	con->eh_data = NULL;
 	kfree(data->bps);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 2b15996f1ede..634654cf2634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -27,6 +27,8 @@
 #include <linux/debugfs.h>
 #include <linux/list.h>
 #include <linux/kfifo.h>
+#include <linux/radix-tree.h>
+#include <linux/siphash.h>
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
 #include "amdgpu_smuio.h"
@@ -454,6 +456,26 @@ struct ras_poison_msg {
 	void *data;
 };
 
+struct ras_err_pages {
+	uint32_t count;
+	uint64_t *pfn;
+};
+
+struct ras_ecc_err {
+	u64 hash_index;
+	uint64_t status;
+	uint64_t ipid;
+	uint64_t addr;
+	struct ras_err_pages err_pages;
+};
+
+struct ras_ecc_log_info {
+	struct mutex lock;
+	siphash_key_t ecc_key;
+	struct radix_tree_root de_page_tree;
+	bool	de_updated;
+};
+
 struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
@@ -514,6 +536,7 @@ struct amdgpu_ras {
 	atomic_t page_retirement_req_cnt;
 	struct mutex page_rsv_lock;
 	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
+	struct ras_ecc_log_info  umc_ecc_log;
 
 	/* Fatal error detected flag */
 	atomic_t fed;
-- 
2.34.1

