Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94F606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=211Mic7Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788B110E1B8;
	Wed, 21 Oct 2026 11:09:35 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E715310FD34
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 11:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvLUQqml+wmw4TOflEISd7jVFjeaHzwXfrhKMgWURAG29XgkKwxypB8vOJmKSjA9lsNIXaxm76NhjBeo33QgLq7JUWS304RPrUrxCDiJnunf+HtzHSsSrKYPyLUghrEzOmA7HDj1GZ95OqH8pduonqswLrXmdrwy317L70fUmLepASamOJmysS1QwI8CPAJQhvpCfZpPcsGzueLYbN9Lp+Zt4TJCHT0oAbtmdQSvShsW2QMK5oT67olT4SnBi21oDp4Dc2FD1Bh9PrD0yGLX2lk9RmnvBracJ36GJ4rasoPF+0QFs9RKtP/GiW4jzCXlvByHciODNV+nh/9v4Uo01Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pCrZKovD09n5vXiXF6Nt+N3VrviXBLPMn5mMxUK+T4=;
 b=QVmfMMfDtIPlnKRCTSwBdIkoNNs1if490GsM/HgU0nwyYc2G1zkR66b5EYgJbwYi7IiaBUVuop1htzB/2EGn/p5wUfuEjZObU8tYMzD5YPzeVjQTLgGhUjBiGt9o2HW+SzYahkjDdVoTy3wSXHrYqdU2adKWkg+cFcBUhSp63JwkN1LymoL+Z5xtCHXa1QvQSYYpB+i9YH5T6+FhL69A2dIHBZJVGkgenAV5755wcy5HHo2selx2irqlAZo4LFp4MX0kEi3qc6yGVDsFQ3zHyETNl3zaRqqUKyRe1AElc+QgBWn78n6hd1kdRyolWWDgVer6kzOUe4TmejSzJJR66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pCrZKovD09n5vXiXF6Nt+N3VrviXBLPMn5mMxUK+T4=;
 b=211Mic7Q1NFdfAxZ/hxG9jIkT10/OEuYdr7AbmkEmAB1l1D8KnnhcocGVdWoQTQIeaCcHhmTd8k3ITjiC9WtmqY7U5ActSUe+Qxzzcty1Igp0L5JKddZkFgL8XzfDeEnWLN2FlQ5/OGnp7j+tfzrOX0Mb7KbmYHkeigYVS5XiqQ=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 11:09:24 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::4e) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 11:09:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 11:09:24 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 06:09:22 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Benjamin.Welton@amd.com>, <Ray.Huang@amd.com>,
 <amd-gfx@lists.freedesktop.org>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: [PATCH 01/12] drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
Date: Wed, 21 Oct 2026 19:09:52 +0800
Message-ID: <20261021111003.3371005-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021111003.3371005-1-lingshan.zhu@amd.com>
References: <20261021111003.3371005-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fdf3de-3258-489c-b865-08df2f63c3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RulbLuaftxgl35wy1SAHT9dY8lEINnX8dfyaMRN1TaoRQgpDq4H/hKP2nHP8McsHoNViWs2e9BuIae0yDOnIav+9wdDo1vd5P5sjRR1mrhUBlUbcJHh0CWfawNkwrp4CM6Y/Gk2HEPHqxY9nBqh6QnE8lUA46z66Oer8/wQqfmm8ZweNfWPWMSGFSIoLjH/e9HcO5gnaeHPVY3yZigSTQ76k2viVI50cJhX95hTSP1Kl0cmcfYvVvNQNYRBnTYzvgz/lDWkjbH76DDiQ8PYLW6pWeafBMv5hN7ZG66q7CVl63pXLOfeoz5yUT9IDgkyedkLrsI0lxsJLZ5FuTWjOZJnCcezkC+dS6KAXfQ22LPmydTCFJAlaR49HLCjf+OhV4vrgwnsBejqJ1DT1tAa98tF3QB/vjN+DBoLEaNzNRWEUWorhWP3Jbzvy0QPH3mki54X2ItsI8/hsekgSUzJGIONq3ZZmn5TsfGMJlxXog0f464PXBtvBlX6R5YspdCJQqlQpHAbjImoZQh0pLkd88W7PzxEcP9MW5CE31Cr0hdMsNhZdhiymTLRUgpnqFKykmxZTpDUTcEFPjv24CxkkKrPTIEXo/DlyzPltJedj0Tgc3GM6gBQw6vc2ZDb234o0tj/YRIIB8DzJy1PrhLPnc/I/BxGwipYV/DIVpJEfp02Tc16nNSt7A8KRpafacxUvT67HI9i3vWFmhx7kNvXVOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RUyfUnYS7WCoyj27XZuXpMgwm7izXsDpT6pL323aqRSVqy/htizbFCauz2uBQnx0x7OU43S0YiTh3EUz8MeOxLc1VJaDQgDhNpi5VXtsZz41cTmH18Gp4i9ddE1tcVfnnpwg8rMGMHND98jJPKVQUMk7B6ypoRSS7An+TOB+7GbcEFUwaAcpSKOQgmkKcpVakolKPGmEK3liq5sUcaSV5mAdoaukwqgPm0twPbN7vupxEBV22K/hJnDWKRsGQxItglyjClR8qF80CCA8+0jNg54yqEhk0ND9SYotfV/TH9HDz08qyzKsQyai+l4VaAHB6mv61+Tx0KN/PJsqAOsqz7FTlx3UVjVdKHn4g/xHD7rd/ONiGj/qqpaP4R5Iy1CwKM2eE8wXoHksV9ja6S1gwfddMnI9XzW3sC+lv//Xa3Na/BD1I9J0vdaWTBDjGXys
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:09:24.4544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fdf3de-3258-489c-b865-08df2f63c3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

This commit introduces a new helper
amdgpu_lookup_queue_by_doorbell which helps
look up a user queue with the given doorbell id
in a xarray.

This function takes a kref of the user space queue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..f592aa9b50c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -617,6 +617,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
 	return queue;
 }
 
+/**
+ * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
+ * @xa: user queue XArray indexed by doorbell
+ * @doorbell: doorbell index
+ *
+ * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
+ *
+ * This function increases kref of the queue, the caller
+ * must release the reference with amdgpu_userq_put().
+ */
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (!queue)
+		goto out_unlock;
+
+	if (!kref_get_unless_zero(&queue->refcount))
+		queue = NULL;
+
+out_unlock:
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3e19bc6103a0..828421ff51d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -152,6 +152,8 @@ struct amdgpu_db_info {
 };
 
 struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
+struct amdgpu_usermode_queue *
+amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.53.0

