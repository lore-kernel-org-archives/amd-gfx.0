Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05375C27C53
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 02:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3371510E957;
	Thu, 13 Jun 2024 02:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pZ2WAHgQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DB910E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 02:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx9SBvBZFRVWT4iTjuRg4M8nUZ3gVP+xVdZ+dYW3YCl5tkfkyfuFxseGHq2GdEV4plX5q2nnMmlBqRFJNtUXKQCXxw8viGUC+tnUltiSbxndUqHseMK46R0L58Hlep9r3dyMFnmT9+22wD50fZYMsMwQly02SbhNyhCy7AK/QHy+bHuTJi/K+mHPxt/KnyGQI3vbLoSMWV73bqalzLQcnWbe41uw0x2FAVTjQKuAeNNRfKfzWetT195qihY6ZehJp/AFEoBuLqwxF6wUgFfXYuAaEOQR0h+3V6bj/kwIvroxRI+MvLMzBicDgoHW++GAcD7F19IwNWUjWATtIneUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLSSY0w3onRBFmQmMdJ5ZJYc+qi2Y/nj1v/XuABfL2M=;
 b=gFCFjN02W/7aepKp/NcfHhIThioXlFtN82dx6bJ6yeJNsAJTjll2+34l9TU7ngwq54nGK2DP51T5nck7azcsQo7HP9dFWDXg15f8t4mBK2gWQMRP3qKstxlkqS6+GO+Goykv3KxngJetXVSVtjQowlC9efY6+kMweE6Q4dkpjNnr8xfZbwIYao6H1dqv1+xLDzXv9YzEogppwjtq4D9TJD/zzgwPairS381kEJhodGsuwP2P4KzllXGmUD9GkHmnBjVleBoFI9a20DjIiwcdzeEojNS0ePuOCCbTy3CE1ASamU2Flg88nLLiegVI7XYyF3YfXosuZYngdPlpALfVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLSSY0w3onRBFmQmMdJ5ZJYc+qi2Y/nj1v/XuABfL2M=;
 b=pZ2WAHgQI0hJ2CJNbbW9bhnypKTx7sbTyecwPNbxJwS8Yl5ULC4M+pGUoyKlx20yQvp2EmlMq7FJY2PrrSJTCjXODg36McazPj2zc+CFCNwMOL68B4yY2QhM3kMqOuB9TLOUixvSYkOJBtfuxeQOQeh5pkp4+VD2Ah0gXLoG1sw=
Received: from CY5P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::13) by
 SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 02:27:01 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::55) by CY5P221CA0021.outlook.office365.com
 (2603:10b6:930:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 02:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 02:27:01 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 21:26:57 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add threshold to interrupt waiting for DE
 data to be ready
Date: Thu, 13 Jun 2024 10:25:01 +0800
Message-ID: <20240613022504.81787-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613022504.81787-1-YiPeng.Chai@amd.com>
References: <20240613022504.81787-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 69211c84-de8d-4e45-7a08-08dc8b504ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gda2KMfAlHMn3kGqJGMHKoVBqamxL9pVN9YMkB8FUmGrmMXLHzF5xTxeoW3x?=
 =?us-ascii?Q?fctQcponN39wRdpCLrPW7YT7aqnlNG1hi1/VaAkc5n152KHlMid8QvNwe/k2?=
 =?us-ascii?Q?Q/Bo6/H731B75xOzSOmXXWhcRxdBPZWPXEtVHxxYAhGsaCD/SLPcPob9rGb1?=
 =?us-ascii?Q?hx+I5XualRVFM3BPZj10b7VuL1sAp4uDDAaL+C99e/OXEkO8xgvmfFXF+OgX?=
 =?us-ascii?Q?uEQBc/Rt95OPaivL0K3Ak2QUssJ58Zc1zb/0awZy4lopWk2zxKA/GBaz4jwU?=
 =?us-ascii?Q?Y122HC2HeBNuuAm3hFSkjgLo5HbzA8rjOmIVXnEoEpV3j+Vict0CdEpEKcrm?=
 =?us-ascii?Q?6fGiqb4g4g8INjKvfj5hnO4gE0WvSVYDZQk292sG1Iwxg9yljfC/8m5yJIYC?=
 =?us-ascii?Q?l/qVBWlR9/gJnb7ezHeLYnFYGH/AB0hDUygX07oK/MUXmWnr5k3bZM1PHCsl?=
 =?us-ascii?Q?/k6IwCSi4hUimhOKmsO1YGDqDF48SeH4DXwnSL1RqpBDg9Ml3jjweo9Cwhe4?=
 =?us-ascii?Q?aCiZr9moArbXpaAn//0zE/2TShz36PB2EI+KV1EcVp569tfxZU7UBDZINd0/?=
 =?us-ascii?Q?5OTeE8nPKa3H3rmAjI8aJ8SYQgqOXXFLJ4qMvVLoiIBkDQyGcqJ5n7mZYEk8?=
 =?us-ascii?Q?sJnHVNMsl7foVf31sKTs+mlxd8N2MPvHMTfCAR5ku+NYrlUeOLYw+2p/mMHC?=
 =?us-ascii?Q?HcIR57/O6u8LbgnsOdgbNxDDeh8NB6KA4ewed8AZ6LLGeaKRPhGhxrAtp7rw?=
 =?us-ascii?Q?vLOCrdvY6HuQbwRhk4S9kNZzNrT8YutAI/wKMAUcReW0aMQweYZ0PjzBpzeN?=
 =?us-ascii?Q?2AD2InIqL4kQKZsycuJZPUpYFQWc/aces9uuxseifRQZZElpV63rmz2SAdRa?=
 =?us-ascii?Q?lUChQRERuMgEWC7rpMcwUvxRY4OQ4/grM25MO2v3rSKNHeXwDVtUEnReWqx3?=
 =?us-ascii?Q?a7KCrE2UcKKgwMofI6rJq3UGLb9dAomoZtMGX9Crt0xoonllZRYfL6xTcjEX?=
 =?us-ascii?Q?3QcCIR9uKlPnmuXY3NRKIaBTFUXfz27YTOIkpeZeuK8vMec2fg4HvoxjZkS+?=
 =?us-ascii?Q?WvvGJyHjEjJdqixfCh8cSkfy/mhAHpIB/p62kbQ0WEX7/eeclCZmNEKE2XpH?=
 =?us-ascii?Q?5yRUHTHOnHFL8yTosp2jS6pGDbeIuxOFvKGofykXp55qMAQ5uji2jpnghhAv?=
 =?us-ascii?Q?HcVfh1EzsdiZ8oXEFOv/GNxEwf8EiVyfsM1watvS0z9ZSwq9QjvZdQYB9Mfc?=
 =?us-ascii?Q?cZ69Z7rWg+yZCQbUiGr50jP9L0Rc0tJTxWC3mbYMe1UoUO6imzQiPzqBQqpl?=
 =?us-ascii?Q?trFwyrp78UJp1hZ2rtlPB2BPdpKJpONbXBudeik/qJr/kRnWjtdXGTyK243v?=
 =?us-ascii?Q?6EVcFj6qSHG73YJQLRWup0QpYnBWkc9wpRO7NTIYdEfHxe8AVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 02:27:01.4891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69211c84-de8d-4e45-7a08-08dc8b504ef1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

If the number of messages to be processed in the fifo exceeds
the threshold, it will not continue to wait for the DE data
to be ready.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 +++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ed260966363f..1e6e06009577 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -124,6 +124,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
+#define RAS_POISON_FIFO_MSG_PENDING_THRESHOLD  (AMDGPU_RAS_POISON_FIFO_SIZE/4)
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -2832,6 +2834,7 @@ static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	struct ras_query_if info;
 	uint32_t timeout = timeout_ms;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	bool trigger_threshold = false;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
@@ -2845,6 +2848,12 @@ static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 			return;
 		}
 
+		if (atomic_read(&ras->page_retirement_req_cnt) >
+				RAS_POISON_FIFO_MSG_PENDING_THRESHOLD) {
+			trigger_threshold = true;
+			break;
+		}
+
 		if (timeout && !ecc_log->de_updated) {
 			msleep(1);
 			timeout--;
@@ -2856,6 +2865,10 @@ static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 		return;
 	}
 
+	if (trigger_threshold)
+		dev_dbg(adev->dev, "Waiting for deferred data %d ms, pending msg:%d\n",
+			timeout_ms - timeout, atomic_read(&ras->page_retirement_req_cnt));
+
 	if (!ret)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e70c45712ddb..103436bb650e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -36,6 +36,8 @@
 
 struct amdgpu_iv_entry;
 
+#define AMDGPU_RAS_POISON_FIFO_SIZE  128
+
 #define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)		AMDGPU_GET_REG_FIELD(x, 0, 0)
 #define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)			AMDGPU_GET_REG_FIELD(x, 1, 1)
 #define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)	AMDGPU_GET_REG_FIELD(x, 2, 2)
@@ -532,7 +534,7 @@ struct amdgpu_ras {
 	struct mutex page_retirement_lock;
 	atomic_t page_retirement_req_cnt;
 	struct mutex page_rsv_lock;
-	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
+	DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, AMDGPU_RAS_POISON_FIFO_SIZE);
 	struct ras_ecc_log_info  umc_ecc_log;
 	struct delayed_work page_retirement_dwork;
 
-- 
2.34.1

