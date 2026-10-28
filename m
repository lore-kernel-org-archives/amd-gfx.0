Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794F606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YwjHMDTL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C53310FD93;
	Wed, 28 Oct 2026 17:05:49 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623FA10E6C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 17:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOXLNxMHOxIPuB5ARxD37IFG+dsL6iU2B7DUS/NJbHFvHV8QhH5fIXLSkDjrkjzbK99zbTSogsqy75UG87UsxUDs7StI86QFrZwnSzmUwNx9qA5ed76sQEv/fjZkGoO+Yw/PMhtsb267GWpyNRt6KKB1i7EodlooKnwCTeIF8fWH1WI6KXemI+Xu1Av0WCyXXB4EC4IM2zjDZrNgfYUx5C+7Ny1uyzvt6Qx1FThPjsSB2rMZVPjnLfF3vHncrqun++0+a6zxHXlicoHjMO1WSUXlv9LXN1XSQtrfWDYdyOwHvkTXHT0Oby4KD3ygA7maandxvrWBZgrnjNW3klZxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLS9oEI6/iVAmKM1FCZRbwkDMkxaLqKENn7afQCoWzM=;
 b=MP9Rfxh5aXRDXtz4zXrE3B3TUJ77OF9s5PhI3j6C9C2gsLyY30/HlaFibKaZWnvx04UO/23A8wQgTOZyJaR6DD0yH5FR0gkpxyvFRLjLie56r25MlRggBWKp4j1PSMqY+leRjimx+Y73dftsPUEAcDQIrmJPX2etaUH+Yhr88xsH9SfvUbt+yOYDwQPNZyVe25ZB54u5lsmte++H9D0mdLITb7YrThGwx7XU9hJAiGzlUW/+t8F9Dclvh/nuTa4VlPLXAihz5JePM2oikyYtRuy/HegG+9XRQajV+2fypeRLFe9XqYOLfmXwFygasCPL/Z3nvPN9M2+Ao8KW/WPUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLS9oEI6/iVAmKM1FCZRbwkDMkxaLqKENn7afQCoWzM=;
 b=YwjHMDTLU2KTnz7dHo1SGWysagmTHuM9aV6OBcVs0GeAXyFHaF19Ige2trHjo8U2BlO6udMeZTfTFe1XsaZyjpAS/j9pjvp4ODuFDtHsj8+sp1ZYTwgsu0g02dj1c+wuSmqODIowIzXUEvH2lRKC+T54ylq0sh18favDgnR9Oj8=
Received: from PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::10)
 by SAVPR12MB999169.namprd12.prod.outlook.com (2603:10b6:806:4e5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:05:25 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:510:34b:cafe::aa) by PH5P222CA0008.outlook.office365.com
 (2603:10b6:510:34b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:05:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:05:25 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 28 Oct 2026 12:05:24 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add per-XCC mes_dbgext state
Date: Wed, 28 Oct 2026 13:05:13 -0400
Message-ID: <20261028170513.462977-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|SAVPR12MB999169:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c3bb51-d392-4a22-5ece-08df3515a8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|261026140227099003|5023799004|261022075727099003|11063799006|56012099006|261022105027099003|261009223027099003|261021123027099003|261021121427099003|10067099003|261026121527099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Vq/G1MVl1NrD6o2uBCJrUjYid44M6AQpzsJfzEtpTy969O6Zup2kCdtChIJJVfYvyNBHnoBSd53mZ/MqRjEEGd64g790yqORmLu1fZ5tWsAuAC7JuStQH2Af5riXFnkmrJTLmOVhmlmw13BI3Wzw7qsLEQP0FqO44eQR6Q9btqXoy/K5I84+TK+iIjD7v1KvVviIbe5YZ2MzNO1Z+NNoErOZLDI3aWDnQTlYYmQvqLh480AuuYn4LIIimS84p37IxvvWwxavgyQivLv3rFU5a+B28am+YzFjv1LLQdOPXLwEMIAOWmXLVHdkAwJA6hYMH2fxi34BSBrgjNBIUM1TFY3fuuiFf7XmYIFZ7etvwdNWULi40I0Rw+6DXpeYtXDnw084XN2oysCylzrs0OA+0xTii2XnAjxCcWbSkTvZM1kfPUfqiR6uQyTdOGP3ReRStV1bJbj1PccojJrkZHshLQYVpf7lYx28q/wxxYR9OmJv9O387ZKW6wOv6RIy+GrjUrrGreAJP52QSONUyyLgIEMX7BRZ/naxoY6nSf+VLu+cFDN9tL8/YaAH2/C/6SmgXrwhnuI0+C8LgjWV1iEqhphaAgSMO/ADShoxu5c0w4cw2F7SqwZyJoMFTGJO/MviyUNhawGuN40mv2AK9fmShrT0ya8rFyv7HWGQbkFliWD3J/sbJ8o0SeB0BwDYeyZkw2Nhbj751F0XXlqlbg72PA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(261026140227099003)(5023799004)(261022075727099003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261026121527099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OWaL2jIQDeghJFO3ypKE92Bf5Bey3J49V1MweASKHSACUZAqk95sYCo0WjnI8bz7RGenk8tlaRJh9FUL66TkXo3PMoCW23KbKp7uChrWJy+irh/fUPxmSQkDZ23Xry8ftNXHo1M5PJjS1M1psPJgPiDTwtU9+v5+vfcXNNjSI5J+9+S3zEtrr8nxTq1G/KsEpk/GadMNDeV7tAEEr2m/ddunCZbYt4lcP3yQ9ti3bGe8zUKeCi/Z1e46GXC2KACE4v6zenGc86fYeOAJFf6Lew9XUqbWf9WQw/uzOpRoWo3PRxXEQDGxwIQzA9McvHfmqmcJ+ZtOGyqShBsBh66s7AT43PLBszazqmooMTLQFmusKgX/6yIqxuZ9SoRKnUuscy2VT5AQeZ1EfztagHAtgJDgs7AuHnWpXxQABmEEI1B3LQKMCC9oRzMZ8/jj4EtC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:05:25.0821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c3bb51-d392-4a22-5ece-08df3515a8c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999169
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

Track armed dbgext regions independently so selected XCCs
can be drained and disarmed without stopping the device-wide
reader or disturbing other XCCs. Add helpers to reseed and
reattach those regions after their MES instances restart.
Serialize notification, draining, and region initialization
while preserving the existing whole-device start and stop callbacks.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 217 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  28 +++
 2 files changed, 220 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 2e51bf882574f..9e60e78925756 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/workqueue.h>
 #include <drm/drm_exec.h>
 
@@ -125,6 +126,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->mes.queue_id_lock);
 	mutex_init(&adev->mes.mutex_hidden);
 	mutex_init(&adev->mes.dbgext_lock);
+	mutex_init(&adev->mes.dbgext_drain_lock);
+	spin_lock_init(&adev->mes.dbgext_notify_lock);
 
 	for (i = 0; i < AMDGPU_MAX_MES_PIPES * num_xcc; i++)
 		spin_lock_init(&adev->mes.ring_lock[i]);
@@ -320,6 +323,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
 	ida_destroy(&adev->mes.doorbell_ida);
 	mutex_destroy(&adev->mes.mutex_hidden);
 	mutex_destroy(&adev->mes.dbgext_lock);
+	mutex_destroy(&adev->mes.dbgext_drain_lock);
 }
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
@@ -1573,6 +1577,12 @@ static u32 mes_dbgext_num_regions(struct amdgpu_mes *mes)
 	       mes_dbgext_num_pipes(mes);
 }
 
+static u32 mes_dbgext_region(struct amdgpu_mes *mes, unsigned long xcc,
+			     u32 pipe)
+{
+	return xcc * mes_dbgext_num_pipes(mes) + pipe;
+}
+
 static void mes_dbgext_process_all(struct amdgpu_device *adev)
 {
 	struct amdgpu_mes *mes = &adev->mes;
@@ -1585,12 +1595,18 @@ static void mes_dbgext_process_all(struct amdgpu_device *adev)
 		return;
 
 	/*
-	 * Every armed (xcc, pipe) raises the same host interrupt, so drain all
-	 * regions; each is a no-op when it has no new data.
+	 * Every armed (xcc, pipe) raises the same host interrupt, so drain
+	 * every region that is still attached.  Regions cleared while an XCC's
+	 * MES is restarting are skipped until that XCC is rearmed.  Caller
+	 * holds dbgext_drain_lock.
 	 */
-	for (i = 0; i < num_regions; i++)
+	for (i = 0; i < num_regions; i++) {
+		if (!test_bit(i, mes->dbgext_armed_regions))
+			continue;
+
 		mes_dbgext_process_region(adev, buf + i * mes->dbgext_log_size,
 					  i / num_pipes, i % num_pipes);
+	}
 }
 
 static int amdgpu_mes_dbgext_reader(void *param)
@@ -1598,7 +1614,9 @@ static int amdgpu_mes_dbgext_reader(void *param)
 	struct amdgpu_device *adev = param;
 
 	while (!kthread_should_stop()) {
+		mutex_lock(&adev->mes.dbgext_drain_lock);
 		mes_dbgext_process_all(adev);
+		mutex_unlock(&adev->mes.dbgext_drain_lock);
 		msleep_interruptible(MES_DBGEXT_POLL_INTERVAL_MS);
 	}
 	return 0;
@@ -1612,7 +1630,9 @@ static void amdgpu_mes_dbgext_work_fn(struct work_struct *work)
 	struct amdgpu_device *adev =
 		container_of(mes, struct amdgpu_device, mes);
 
+	mutex_lock(&mes->dbgext_drain_lock);
 	mes_dbgext_process_all(adev);
+	mutex_unlock(&mes->dbgext_drain_lock);
 }
 
 /*
@@ -1623,6 +1643,7 @@ static void amdgpu_mes_dbgext_work_fn(struct work_struct *work)
 void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data)
 {
 	struct amdgpu_mes *mes = &adev->mes;
+	unsigned long flags;
 
 	/*
 	 * Caller has already matched MES_DBGMSG (type 7 in bits 31:26 of the
@@ -1634,12 +1655,13 @@ void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data)
 	 * Only the interrupt path may schedule the drain work.  In polling mode
 	 * the kthread owns rptr; honoring a stale/spurious interrupt here would
 	 * let the work item and the kthread drain concurrently and race on rptr.
+	 * The flag is published under dbgext_notify_lock so stop can pair this
+	 * check with cancel_work_sync and not lose a late schedule.
 	 */
-	if (!READ_ONCE(mes->dbgext_use_irq))
-		return;
-
-	if (READ_ONCE(mes->dbgext_log_cpu_addr))
+	spin_lock_irqsave(&mes->dbgext_notify_lock, flags);
+	if (mes->dbgext_use_irq && mes->dbgext_log_cpu_addr)
 		schedule_work(&mes->dbgext_work);
+	spin_unlock_irqrestore(&mes->dbgext_notify_lock, flags);
 }
 
 static int amdgpu_mes_dbgext_setup_fw(struct amdgpu_device *adev, u32 xcc_id,
@@ -1675,6 +1697,7 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 	u32 size;
 	u32 req_kb;
 	u32 num_xcc, num_pipes, num_regions, i;
+	unsigned long flags;
 	int r;
 
 	/*
@@ -1784,7 +1807,9 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 		  mes->funcs->enable_dbgext_irq;
 	if (!use_irq)
 		mes->dbgext_log_options &= ~MES_DBGEXT_OPT_TRIGGER_INT_PER_MSG;
+	spin_lock_irqsave(&mes->dbgext_notify_lock, flags);
 	mes->dbgext_use_irq = use_irq;
+	spin_unlock_irqrestore(&mes->dbgext_notify_lock, flags);
 
 	/*
 	 * Translate the options to the mes_aux firmware layout: enable logging
@@ -1828,6 +1853,11 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 		}
 	}
 
+	mutex_lock(&mes->dbgext_drain_lock);
+	for (i = 0; i < num_regions; i++)
+		set_bit(i, mes->dbgext_armed_regions);
+	mutex_unlock(&mes->dbgext_drain_lock);
+
 	if (!use_irq) {
 		/*
 		 * Never leak a reader: if one is somehow still around (a missed
@@ -1873,10 +1903,15 @@ static int amdgpu_mes_dbgext_start_locked(struct amdgpu_device *adev)
 					   0, 0);
 err_disable:
 	/* Undo the early arming done before setup_fw(). */
+	spin_lock_irqsave(&mes->dbgext_notify_lock, flags);
 	mes->dbgext_active = false;
+	mes->dbgext_use_irq = false;
+	spin_unlock_irqrestore(&mes->dbgext_notify_lock, flags);
+	mutex_lock(&mes->dbgext_drain_lock);
+	bitmap_zero(mes->dbgext_armed_regions, AMDGPU_MAX_MES_INST_PIPES);
+	mutex_unlock(&mes->dbgext_drain_lock);
 	if (use_irq)
 		mes->funcs->enable_dbgext_irq(mes, false);
-	mes->dbgext_use_irq = false;
 	/* Never free a kernel BO while suspended; keep it for the next start. */
 	if (!adev->in_suspend) {
 		amdgpu_bo_free_kernel(&mes->dbgext_log_gpu_obj,
@@ -1901,27 +1936,40 @@ int amdgpu_mes_dbgext_start(struct amdgpu_device *adev)
 static void amdgpu_mes_dbgext_stop_locked(struct amdgpu_device *adev)
 {
 	struct amdgpu_mes *mes = &adev->mes;
+	bool use_irq = mes->dbgext_use_irq;
+	unsigned long flags;
 
+	/*
+	 * Publish "off" before cancelling the reader and work item.  notify()
+	 * checks these flags under the same lock, so a late interrupt cannot
+	 * schedule another drain after cancel_work_sync returns.
+	 */
+	spin_lock_irqsave(&mes->dbgext_notify_lock, flags);
 	mes->dbgext_active = false;
+	mes->dbgext_use_irq = false;
+	spin_unlock_irqrestore(&mes->dbgext_notify_lock, flags);
+
+	if (use_irq)
+		mes->funcs->enable_dbgext_irq(mes, false);
 
 	/*
-	 * Tear down the reader kthread and the host interrupt first, and do so
-	 * independently of the buffer state.  The kthread runs code that lives
-	 * in this module, so it must never be left alive past module unload -
-	 * otherwise it faults on an instruction fetch once the module text is
-	 * freed.  A second stop() in a teardown/reset sequence, or one reached
-	 * after the buffer was already freed on an error path, must still be
-	 * able to reap a stale reader; hence this runs before the buffer guard.
+	 * Tear down the reader kthread independently of the buffer state.  The
+	 * kthread runs code that lives in this module, so it must never be
+	 * left alive past module unload.  It takes dbgext_drain_lock only
+	 * around one drain, so stopping it here does not invert that lock
+	 * with dbgext_lock.
 	 */
 	if (mes->dbgext_reader) {
 		kthread_stop(mes->dbgext_reader);
 		mes->dbgext_reader = NULL;
 	}
 
-	if (mes->dbgext_use_irq) {
-		mes->funcs->enable_dbgext_irq(mes, false);
-		mes->dbgext_use_irq = false;
-	}
+	cancel_work_sync(&mes->dbgext_work);
+
+	mutex_lock(&mes->dbgext_drain_lock);
+	mes_dbgext_process_all(adev);
+	bitmap_zero(mes->dbgext_armed_regions, AMDGPU_MAX_MES_INST_PIPES);
+	mutex_unlock(&mes->dbgext_drain_lock);
 
 	if (!mes->dbgext_log_gpu_obj)
 		return;
@@ -1942,12 +1990,6 @@ static void amdgpu_mes_dbgext_stop_locked(struct amdgpu_device *adev)
 						   i % num_pipes, 0, 0);
 	}
 
-	/* Make sure no drain work is still touching the buffer. */
-	cancel_work_sync(&mes->dbgext_work);
-
-	/* Drain anything the firmware wrote before we stopped. */
-	mes_dbgext_process_all(adev);
-
 	/*
 	 * Keep the buffer allocated across a suspend/resume cycle (freeing a
 	 * kernel BO while suspended is not allowed - it trips a WARN in
@@ -1969,6 +2011,131 @@ void amdgpu_mes_dbgext_stop(struct amdgpu_device *adev)
 	mutex_unlock(&adev->mes.dbgext_lock);
 }
 
+void amdgpu_mes_dbgext_disarm_xcc(struct amdgpu_device *adev, u32 xcc_id)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	u32 num_pipes, pipe, index;
+
+	mutex_lock(&mes->dbgext_lock);
+	if (!mes->dbgext_active || !mes->dbgext_log_gpu_obj ||
+	    xcc_id >= mes->dbgext_num_xcc) {
+		mutex_unlock(&mes->dbgext_lock);
+		return;
+	}
+
+	/*
+	 * Drain this XCC's regions, then stop draining them, before its MES is
+	 * reset.  The bits are cleared under the drain lock, so an in-flight
+	 * reader finishes its current pass before the headers can be rebuilt
+	 * on rearm.  Rearm zeroes the region, so this is the last chance to
+	 * print what the firmware already wrote.
+	 */
+	num_pipes = mes_dbgext_num_pipes(mes);
+	mutex_lock(&mes->dbgext_drain_lock);
+	for (pipe = 0; pipe < num_pipes; pipe++) {
+		index = mes_dbgext_region(mes, xcc_id, pipe);
+		if (index >= AMDGPU_MAX_MES_INST_PIPES ||
+		    !test_bit(index, mes->dbgext_armed_regions))
+			continue;
+
+		if (mes->dbgext_log_cpu_addr && mes->dbgext_log_size)
+			mes_dbgext_process_region(adev,
+				(u8 *)mes->dbgext_log_cpu_addr +
+				index * mes->dbgext_log_size,
+				xcc_id, pipe);
+		clear_bit(index, mes->dbgext_armed_regions);
+	}
+	mutex_unlock(&mes->dbgext_drain_lock);
+
+	if (mes->dbgext_use_irq && mes->funcs &&
+	    mes->funcs->enable_dbgext_irq_xcc)
+		mes->funcs->enable_dbgext_irq_xcc(mes, false, xcc_id);
+
+	mutex_unlock(&mes->dbgext_lock);
+}
+
+int amdgpu_mes_dbgext_rearm_xcc(struct amdgpu_device *adev, u32 xcc_id)
+{
+	struct amdgpu_mes *mes = &adev->mes;
+	u32 num_pipes, pipe, index;
+	u64 fw_options;
+	bool xcc_ok = true;
+	int ret = 0;
+	int r;
+
+	mutex_lock(&mes->dbgext_lock);
+	if (!mes->dbgext_active || !mes->dbgext_log_cpu_addr ||
+	    !mes->dbgext_log_size || xcc_id >= mes->dbgext_num_xcc) {
+		mutex_unlock(&mes->dbgext_lock);
+		return 0;
+	}
+
+	fw_options = MES_DBGEXT_AUX_OPT_ENABLE_MES_LOG;
+	if (!mes->dbgext_use_irq)
+		fw_options |= MES_DBGEXT_AUX_OPT_HOST_POLL;
+
+	num_pipes = mes_dbgext_num_pipes(mes);
+	for (pipe = 0; pipe < num_pipes; pipe++) {
+		u8 *base;
+
+		index = mes_dbgext_region(mes, xcc_id, pipe);
+		if (index >= AMDGPU_MAX_MES_INST_PIPES) {
+			xcc_ok = false;
+			continue;
+		}
+
+		/*
+		 * Reseed only while the region is unarmed and the
+		 * drain lock is held, so the reader cannot parse a
+		 * half-rebuilt zone header.  Drop the lock before
+		 * submitting the MES packet: that waits for firmware
+		 * and must not block behind, or deadlock with, the
+		 * drain work.
+		 */
+		mutex_lock(&mes->dbgext_drain_lock);
+		clear_bit(index, mes->dbgext_armed_regions);
+		base = (u8 *)mes->dbgext_log_cpu_addr +
+		       index * mes->dbgext_log_size;
+		memset(base, 0, mes->dbgext_log_size);
+		*(u32 *)base = mes->dbgext_log_size;
+		mutex_unlock(&mes->dbgext_drain_lock);
+
+		r = amdgpu_mes_dbgext_setup_fw(adev, xcc_id, pipe,
+				mes->dbgext_log_gpu_addr +
+				index * mes->dbgext_log_size,
+				fw_options);
+		if (r) {
+			dev_err(adev->dev,
+				"failed to rearm mes_dbgext on xcc%u %s pipe (%d)\n",
+				xcc_id, mes_dbgext_pipe_name(pipe), r);
+			ret = r;
+			xcc_ok = false;
+			continue;
+		}
+
+		mutex_lock(&mes->dbgext_drain_lock);
+		set_bit(index, mes->dbgext_armed_regions);
+		mutex_unlock(&mes->dbgext_drain_lock);
+	}
+
+	/*
+	 * Disarm left this XCC's interrupt disabled.  Enable it only
+	 * after every pipe has attached, so a failed SETUP cannot
+	 * leave TIME_STAMP_INT_ENABLE set with the region unarmed.
+	 * The notify below collects the messages firmware wrote
+	 * during setup.
+	 */
+	if (xcc_ok && mes->dbgext_use_irq && mes->funcs &&
+	    mes->funcs->enable_dbgext_irq_xcc)
+		mes->funcs->enable_dbgext_irq_xcc(mes, true, xcc_id);
+
+	if (mes->dbgext_use_irq)
+		amdgpu_mes_dbgext_notify(adev, 0);
+
+	mutex_unlock(&mes->dbgext_lock);
+	return ret;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 0f368fbd2c80e..652cd09504538 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -170,12 +170,24 @@ struct amdgpu_mes {
 	uint32_t			dbgext_num_xcc;
 	uint32_t			dbgext_num_pipes;
 
+	/*
+	 * One bit per (xcc, pipe) region, at xcc * dbgext_num_pipes + pipe.
+	 * Cleared while that XCC's MES is reset so the drain skips a region
+	 * whose zone header is being rebuilt.  dbgext_active stays set for
+	 * the whole device while selected XCCs restart.
+	 */
+	DECLARE_BITMAP(dbgext_armed_regions, AMDGPU_MAX_MES_INST_PIPES);
+
 	/* armed: FW attached + reader/irq running */
 	bool					dbgext_active;
 
 	struct work_struct		dbgext_work;
 	struct task_struct		*dbgext_reader;		/* polling fallback */
 	struct mutex			dbgext_lock;		/* serializes runtime start/stop */
+	/* serializes region drain vs reseed */
+	struct mutex			dbgext_drain_lock;
+	/* publishes use_irq to the IH path */
+	spinlock_t			dbgext_notify_lock;
 
 	/* runtime-requested size (KB); 0 = follow module param */
 	uint32_t			dbgext_runtime_kb;
@@ -492,6 +504,13 @@ struct amdgpu_mes_funcs {
 	 */
 	int (*enable_dbgext_irq)(struct amdgpu_mes *mes, bool enable);
 
+	/*
+	 * Per-XCC variant used when one MES instance restarts.
+	 * xcc_id is the logical XCC.
+	 */
+	int (*enable_dbgext_irq_xcc)(struct amdgpu_mes *mes, bool enable,
+				     u32 xcc_id);
+
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
 
@@ -563,6 +582,15 @@ int amdgpu_mes_dbgext_start(struct amdgpu_device *adev);
 void amdgpu_mes_dbgext_stop(struct amdgpu_device *adev);
 void amdgpu_mes_dbgext_notify(struct amdgpu_device *adev, u32 context_data);
 
+/*
+ * Drop or restore dbgext for one logical XCC without tearing down the
+ * device-wide reader or the other XCCs' regions.  Disarm before that XCC's
+ * MES is reset; rearm after both MES pipes on the XCC can accept API packets
+ * again.
+ */
+void amdgpu_mes_dbgext_disarm_xcc(struct amdgpu_device *adev, u32 xcc_id);
+int amdgpu_mes_dbgext_rearm_xcc(struct amdgpu_device *adev, u32 xcc_id);
+
 /*
  * MES host-interrupt context dword (IH src_data[0]), same overlay as KMD
  * IRQMGR_INTERRUPT_CONTEXTDATA_MES and firmware MES_INT_CONTEXT_DATA:
-- 
2.43.0

