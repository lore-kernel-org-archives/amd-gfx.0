Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8C0C27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 10:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A11810E345;
	Fri, 31 May 2024 10:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ofm2wdvy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641F110E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 10:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjnTaUFw/agbdwnl0MWN3ykC7Lgpbx1K3yOIKnIWksGwMcCC/EflQSnT5PB1ny7AoEEG60EVZHTM2UZfFAF7pKkES1/9h71Qt+IVNIZfxfsTj8ReB/gSP/45g+55zoY9NHZLCtjMUVSs+wcYQPFUZPyxGG/rMATrl11QCvuvFdDeXobj5TJpxdXeCWiekxo4/Kk7axn4xovPnSZQJtWAuquJQybKjdZOVx97UbPlPIyvq+2OmbNX5Ft2bb9T+wvdSphorBc9SK/ib+3TAIj3CrX1hvour33KhbsqjoZiewy4QpCJE8C2kQENHazyhNJa9lFTg73Dccxmk/kPtpcnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TV9OtM91qksg6HDCm0VjdhZgCxCno4Fi5OEUrEB/vE=;
 b=QZgpOyOUKid8H6QyLiKPPFLorl30fXzu7AKQoPJsBM5JfCWtPXRtj/b2xFPsvdLHHg6liDM59GhpLUdTu3t/pQMvBdqfKZZu++CGbe7AEpO7SRZEyl6JuxJQw7tbqAa6a2rqUynnPaPikLY2hN+Kh7hdlb5K4q+3RqBym7WOJkdXr/XkUfnYOODMJ4oQefJQZDqRZcPW4ctvJGQuS0UROdiqvACJngSVjFgTNbUDUY5kPTHNoPzSLCsQCJHGcMmLDn0fWg2BQzjDPdUWU326P1pZoMLMB/ostDYrIqvMJvTtNFr9prWfJEUqpsQaaujodqm23RriliMg+MtzinrmIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TV9OtM91qksg6HDCm0VjdhZgCxCno4Fi5OEUrEB/vE=;
 b=ofm2wdvyf8zsLfFKs/0hmLfEBP/nQ5nKeMehZLm50wKOlLRItAI5OWHLGy5XXkSX3FudfUeX7WRcs07wHh43CZNH+ySEPQUw7o0lkTahKX/YZHsWVtMQMFyVVQb2Iw1VbpGtEKoG7WyU/cUIo9ovAbEr5EkQYtGogMg+VybOfJI=
Received: from CH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:32::33)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 10:49:27 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::19) by CH0PR07CA0028.outlook.office365.com
 (2603:10b6:610:32::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 10:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 10:49:27 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 05:49:25 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add ras fatal flag to distingush fatal error
 reset
Date: Fri, 31 May 2024 18:49:11 +0800
Message-ID: <20240531104911.14748-5-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531104911.14748-1-tao.zhou1@amd.com>
References: <20240531104911.14748-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9d70b5-653e-4c88-d99c-08dc815f57b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iHx9YmikJw3hd7KXEwvUZ0fx61xqo/EwgrrtTDJzvsQ2ePmIrT1RthcMOw3s?=
 =?us-ascii?Q?v0PWV3iIIa5Doks1we7so40gEFxq9Ggs94GKrlZnEaHiSt2XzV95VIvaEs5+?=
 =?us-ascii?Q?5SekUkKdGxYwxBR0PPi3i+Y4UKskCMbGYerUJGyVSh6IcGNeyVOhrnGFjqK7?=
 =?us-ascii?Q?OXcivIesC82tqNqaW7KjUVugs4AmQoTItqLM5G+8dC8E1kIlLMwYqm8y6bNi?=
 =?us-ascii?Q?imX2fP3UyPaY15jigd5RhuG6SUgJH+jZJ82HUrJ/rxOiHrPUVCORjgui9YYs?=
 =?us-ascii?Q?ZclehXsGLioYlxou8sQyrbf4zJia6AupO0bfzzniGlp5U8BLOjtlj8R7ZL7F?=
 =?us-ascii?Q?/fsHzKj+epEsZ5w4sqT8FSGEP2uadxUiPJNkcW3VY0nUIOXUnTUVAmjlktsI?=
 =?us-ascii?Q?OlVa4M0noJ3/UAlYyNz9u+fGxrIIPO1XJe2OfLhMvmT8rOLXtwJVmOHgECjZ?=
 =?us-ascii?Q?AZlmssxhACGy3q5T9/+HysJ34Nw3ueMZpNc14VhvBiXWpJNfxqx7vCQO9TtY?=
 =?us-ascii?Q?ewkO6rCE7FKhxsBKP0oEoS5cJDjVh9RItGvRKJST3saZDWZCbjwyUueLACrx?=
 =?us-ascii?Q?6ROKLoEjTa5yLDlMcgEnvPgFY8AEG50LIXhfqS23SgBYX3d5m2XqH9U1Wx8Q?=
 =?us-ascii?Q?dY869hHjfneNnfBCZpkRmo6gxaHDLl7PXfB7X8ULPNZw6Bsd112k4dUo4KCt?=
 =?us-ascii?Q?2Gyi4QVopx7k5rnbfBt1YwL1iEm/AvTGlBeHJu1NtdxCIktAHJDmY1TMXlBm?=
 =?us-ascii?Q?M4JBmx7PixRfU0WMpUrUp5/H8CaEEwLuXSSTMZxhqJQ9RZUlSSex6qrPZELu?=
 =?us-ascii?Q?n8sCtgpvW37U9tXsdRB6RkmrShuPM5uRaq3s2E+tEg6M1lE4FzqwSxVY5Ryr?=
 =?us-ascii?Q?P6BGrRq8FiLHKrwpbmRzLqwMkzuUVjGfz8Omp1zpH4CybxFFJsOnCIG/E+o2?=
 =?us-ascii?Q?DONw7MWYCiPmMgb7R2roVUTMfqoRpJy7oy2bK+w6DejOxk8YLzcbDCRYEM1l?=
 =?us-ascii?Q?xXbT+S3YB40OTqvi+qvJNfpjI7PLRHctuMRYXavNrv8M9u6UxgfXa2UHhY8C?=
 =?us-ascii?Q?NI70nUgXGYQgnrxI6Ih26HHzvKpfQ5fTax4USqtGA/jkyF5TEbYVvBhLU1jU?=
 =?us-ascii?Q?8unXtWI/c9mm6GvbT+r882OcK6syzTKTzumgKWOO5yvcNCyaYKFXMk8pmdKP?=
 =?us-ascii?Q?cpaWp3lr/wScOc8OEiAeKI+Uv329HitJlJcps8hz4Za8vcA485QVekvMG8OS?=
 =?us-ascii?Q?6fmXP6gjwHqpjXBZPr4H9HeSRK8nHAMY24C8gGEcni0Qqgxjab5UxuviGisZ?=
 =?us-ascii?Q?k8/eDuM4FXv8Zy/5F5q+BWzsz+LnRg4VZJ1Hm8YzBsGcsu1KAx2S2V9+RGyF?=
 =?us-ascii?Q?7NhlwBS7q9ighccE/Roj1bOkqbGe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:49:27.1823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9d70b5-653e-4c88-d99c-08dc815f57b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

Check it in mode1 reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 32 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |  1 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 2071e30d7e56..97b770ba6424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2451,6 +2451,26 @@ bool amdgpu_ras_in_recovery(struct amdgpu_device *adev)
 	return false;
 }
 
+bool amdgpu_ras_in_fatal(struct amdgpu_device *adev)
+{
+	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int hive_ras_fatal = 0;
+
+	if (!amdgpu_ras_in_recovery(adev))
+		return false;
+
+	if (hive) {
+		hive_ras_fatal = atomic_read(&hive->ras_fatal);
+		amdgpu_put_xgmi_hive(hive);
+	}
+
+	if (ras && (atomic_read(&ras->in_fatal) || hive_ras_fatal))
+		return true;
+
+	return false;
+}
+
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
@@ -2462,6 +2482,8 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 1);
+		if (atomic_read(&ras->in_fatal))
+			atomic_set(&hive->ras_fatal, 1);
 
 		/* If any device which is part of the hive received RAS fatal
 		 * error interrupt, set fatal error status on all. This
@@ -2526,8 +2548,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
 	}
 	atomic_set(&ras->in_recovery, 0);
+	atomic_set(&ras->in_fatal, 0);
 	if (hive) {
 		atomic_set(&hive->ras_recovery, 0);
+		atomic_set(&hive->ras_fatal, 0);
 		amdgpu_put_xgmi_hive(hive);
 	}
 }
@@ -2982,6 +3006,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	mutex_init(&con->recovery_lock);
 	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
+	atomic_set(&con->in_fatal, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
 	max_eeprom_records_count = amdgpu_ras_eeprom_max_record_count(&con->eeprom_control);
@@ -4006,8 +4031,13 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev, bool fatal)
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 	}
 
-	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
+	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0) {
+		if (fatal)
+			atomic_set(&ras->in_fatal, 1);
+
 		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ed5793458a70..444a7fb7fbe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -489,6 +489,7 @@ struct amdgpu_ras {
 	/* gpu recovery */
 	struct work_struct recovery_work;
 	atomic_t in_recovery;
+	atomic_t in_fatal;
 	struct amdgpu_device *adev;
 	/* error handler data */
 	struct ras_err_handler_data *eh_data;
@@ -953,6 +954,7 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
 		pasid_notify pasid_fn, void *data, uint32_t reset);
 
 bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);
+bool amdgpu_ras_in_fatal(struct amdgpu_device *adev);
 
 __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index a3bfc16de6d4..a6d6272a4ec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -44,6 +44,7 @@ struct amdgpu_hive_info {
 
 	struct amdgpu_reset_domain *reset_domain;
 	atomic_t ras_recovery;
+	atomic_t ras_fatal;
 	struct ras_event_manager event_mgr;
 };
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 04533f99f1e3..a850e7b29d9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1876,7 +1876,7 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 		/* fatal error triggered by ras, PMFW supports the flag
 		   from 68.44.0 */
 		if ((smu->smc_fw_version >= 0x00442c00) &&
-		    amdgpu_ras_in_recovery(adev))
+		    amdgpu_ras_in_fatal(adev))
 			fatal_err = 1;
 
 		param |= (fatal_err << 16);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d1766a603bb9..d6c6c9a08e9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2788,7 +2788,7 @@ static void smu_v13_0_0_set_mode1_reset_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 
 	if ((smu->smc_fw_version >= supported_version) &&
-	    amdgpu_ras_in_recovery(adev))
+	    amdgpu_ras_in_fatal(adev))
 		/* Set RAS fatal error reset flag */
 		*param = 1 << 16;
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c1d7528a6dc8..4434872bbe2e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2580,7 +2580,7 @@ static int smu_v13_0_6_mode1_reset(struct smu_context *smu)
 	param = SMU_RESET_MODE_1;
 
 	/* fatal error triggered by ras, PMFW supports the flag */
-	if (amdgpu_ras_in_recovery(adev))
+	if (amdgpu_ras_in_fatal(adev))
 		fatal_err = 1;
 
 	param |= (fatal_err << 16);
-- 
2.34.1

