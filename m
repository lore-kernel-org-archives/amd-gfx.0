Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9A606A31A
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2026 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=W4Sztw22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BF810E322;
	Sat, 31 Oct 2026 00:03:02 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B36410E322
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 00:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZSSo9n/nVbpR2JrXh+hyS68iL8pF3h7C4wsUsNNTWlOlMf3WLPAt1ZO+lS0741TVLUGcTMnJXrn3uQTiFs3cY4WT2IpB6FWVLzDGEIeP67XTj6v7RiqhBjxM+cRIe206x0f6yiMNGpCE4SvZ9LKiucyQc84/CH12TzFWq8PCRRJy9X6FLSaFV/g006WixQO/FiZoeWcWadx/i9CsvK14vjZmZ3Smd67jf+djWzpPPP6fSRp6bupXraTt+CPtNPV1KqUTaZUa4RurZmFwbehuG8BD+1iSaCZRkbIXZyrFP/JI/+OzuSfJ56c5mVvZfvC7phbNGbawXSOGJhBuGW/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2puLtQfzufcbp/sV80c2iBF6C4MQiiPwJ/WGIPRRqo=;
 b=QVZDN2P+J13x3H192341N2tOc4cQKkIBpB+P90RWvLI4R0+713poDpLxdQUN3VIIv7rX2bQ1RJgg7gr1tZK6hykO095Z0yPmfBaowp0dWgyt3itgSTWvndAFUcHMzLTCy0M48BmiaKTIHPYblSZtyzAObwVDF7502jYXrsA6JgqNwC6zQ8PMd6PwGxnqu0zDiWyyDHQTPPZN9Xtez3GLfxNNHEl5fhSJt5d/pJmsT6APX3gKVKb/ZaXD9G49cXH3JkHW7qZC7t2Mwcb7n7075sBoip0bUiuJRbUdVV68h+lVPOmAp7u7EskkVoW39zCyP0Swc4nXB03LchoJ2cP7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2puLtQfzufcbp/sV80c2iBF6C4MQiiPwJ/WGIPRRqo=;
 b=W4Sztw22hs5w99GGHZ/MprYDgfsn7pKBhDaA/fzVsAPoOwnSp0ZC6XdkBAGATuPHdlDcvve82qAAywVvOgsbKW94tPSR/qVyufTSYsUh03ju1kEC0mJzvDGj78nOQUlwma1tJKOgTpj+YLFViNvJHdPK/2dWuIe7QJVLyvA7nYw=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by PH9PR12MB252631.namprd12.prod.outlook.com (2603:10b6:510:42d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sat, 31 Oct
 2026 00:02:49 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::86) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Sat, 31
 Oct 2026 00:02:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sat, 31 Oct 2026 00:02:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 19:02:48 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 19:02:47 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: unmap mappings before locking reset domain
Date: Fri, 30 Oct 2026 20:02:35 -0400
Message-ID: <20261031000246.106812-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH9PR12MB252631:EE_
X-MS-Office365-Filtering-Correlation-Id: 3034efb6-c345-44fb-8ffb-08df36e24cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|261026121527099003|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|10067099003|261021123027099003|18002099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 3/dxc9gTTz6fToWmQhrRLLYh4ZdpNFWGH4DQuVNfuKzJWJTH2z8iYPlqMGwnRNrDnvYjztWvskTht8EPuj2AEJdkGVxGOFf2ek9nbZ3GvFPzGUZxWrhqPQmLWrEE2FziOVZz9ptQk0P1lu5TxFCRj/Ak2tvFiyFR0eSdBg/ryt17xDx0Oa/WjOUEITAeuBxBPm3LYe2UPIrW1mshKFnpVXaouRPEuRmCR4KN8GbZMZN3RAkMR9NJWhzRpKjpgca/VqkbXlMs0anjAbAbWQshD6hdwxjMPtGOYujqSDczFFzbyqTfIgH1RcBHodtcYkUFjbZkpR2uZdOps3FEDeSOrSPT0PYxSipUTl2p4WoBl4BhhsuWpPsLsM3sVCVxt0pkrW4GLtzmKvA76LdKV5umLxJKdKUZBM3l3S/gdFsv80CkpNoqRpg+sY56GIuOdYU/aWytCr0HS0ClHBHK4ws2hdekoFrg5HsR8UICkMolUoqTN7bSDF3zsawvKLArihE4N36Ivs63ETRMcPrUsY51/ndDwSFUnoUgjZmJAIiJIK2QXnNeIPeh+OP+fYZhkuOk6lA39Zg53YCbgrCOZdg3Kc0KXvegX7lJSeFeVgDZNDdrkxVh9hUoO22Lx41qaLNpxiQSFibjIE7ApeR6pUjMYr5sYf6ik+BlikSeLB2Z1bfOZT0E+VXjOgeYNYrqSJpkFKw56JjnZ/SL+2q6zk8Nhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(261021123027099003)(18002099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ETHtDe7PGBNqh5dntZLKLeosg+CCF4gVUvl1kQ6UWZbdfkkh6NJyBF5kK7cqNmzrKINxhDdssKD/s1kueMcH89PmB/sPrYPqIGDkHLeVXLntV8PvdFiJ5QJbNY1lR1R3G1HptfYmND1Rw6fmHsSP7yTPTDXdwJqXdc8UU2PRiXfkWjUeT64kaaIAtDXK0SAaJM20vHP2/zhPn2/MLhsrwYsDeVR9czDRqh9IkqHjO+PFgEI0q+mRONgtcJUsb74lXEA/zslPQD4Er2YP9Erx/YKYkBxr46VfexctIp2GHRg6gZ5x/szvFEQ3/WWSDE2d8stJpzuWx7BExFKLM7O+ZiWnFbBa5aVZb2gBq6goqwhI0X4iLeMWzxTg2vUhzeBXSD4tNXPXutXMwoa4cEuMJWQ31/lTJUYaqaezBmMmUT0fupZpk3Jt2xad1BpdgClI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 00:02:48.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3034efb6-c345-44fb-8ffb-08df36e24cac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB252631
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

GPU recovery held reset_domain->sem while invalidating DRM and KFD mappings.
unmap_mapping_range() takes mapping->i_mmap_rwsem, creating the reported
lockdep dependency cycle through MMU notifier and dma_fence_map locking.

Invalidate both mapping sets before taking reset_domain->sem. Keep the
semaphore held around the recovery operations that require reset
serialization.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef01d280cd0d..407bf3ff9b4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5789,15 +5789,15 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Cannot be called after locking reset domain */
 	amdgpu_ras_pre_reset(adev, &device_list);
 
-	/* We need to lock reset domain only once both for XGMI and single device */
-	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
-
 	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
 	 * accessing them
 	 */
 	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
 	amdgpu_amdkfd_clear_kfd_mapping(adev);
 
+	/* We need to lock reset domain only once both for XGMI and single device */
+	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
+
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
 	if (need_emergency_restart) {
-- 
2.55.0

