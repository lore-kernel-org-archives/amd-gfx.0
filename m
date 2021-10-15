Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 08:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E5A61090
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 08:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44E5A61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C846E245;
	Fri, 15 Oct 2021 08:48:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6DF6E245
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 08:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USdezl9/eBYkdeoi4Qf5x00OrKiGeKhsTkBZ5Y0qT7QSb2seZtlVJQOH5HdYMXFaxP0xQNnVuFjf87dtHy5/5Iz8Xj/VXwlPDVFsJdUce6uxUh5rFheqW+3u5qnGoPo+GmEHk/OtitB5N6Qvmk/JQ0D+wicy/bqkhVov1D3QMzSn27O0Ql8iu6+gNGQlfF8TilPHTS0RvajcENq0fiZdTL68bZFKaocrULyZEzIPh78/AyRh7kuoxYnpxaYRd58wLhe+unIcF0m5pB6sX/gvznl1n/quz1q1ygNfTgeV95THNtekWgpG5OqT83bmbH/lJSg4dHB2UexuMvvIea/MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=topnrQ5S5HmOQsCbzqjZ+fBwkxnorv6jFxcC9htultk=;
 b=JfSkFgE6Q8F5jfBtHjSpXGzlpBmEKB6Yab5TelCsD6rDV2Ml1k/urcIktaJfmf+8OdUDGybVqYx+/yy0ZT4xnh3IiNKBlnYdD7CjQoC/O32xZ62hJnyCiTEXZ5+CMZobeSHk05z1l8JdOyaOKwcmCgfKtn4m8fuFLQNzMiWSN8c85KMMaqyo0NmITzF3GOSaTKnpj1FOd0TJFj3xavRrtgughZQC4Q8ud8VkEzYbNl3JhaGhmyVsymz5GwfnAcDE/3GiC3JvGPt4dY0kh0+LsDumOTTDlzTRrgiaAkUOWeTdXC18VQexlvE9fnURTS2ksPqkGBkfZcm+9CxXhM3Pjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=topnrQ5S5HmOQsCbzqjZ+fBwkxnorv6jFxcC9htultk=;
 b=Hi/8KdQWNnrPOHXJ91FTo5fLpy5Tzh4Mm4xBJYYH4j5m65AI0grdKJcDwiUB3vngYeTiAMTs6UFnAtmMlsSlhbQdCc5cAmwXSa/Bse1v7+23sSd9ziiuxbFDIqCzonhG80+GWFEue0ZVA9B1F8bxlmHGl9ggEjqmpvGcF0CR6go=
Received: from DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9) by
 DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 08:48:35 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c9) by DS7PR03CA0310.outlook.office365.com
 (2603:10b6:8:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 08:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 08:48:35 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 03:48:31 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>, Lang Yu
 <lang.yu@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Add an optional argument into update queue
 operation
Date: Fri, 15 Oct 2021 16:48:06 +0800
Message-ID: <20211015084807.2062053-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac235e83-2160-474c-e80e-08d98fb8931d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11296814EB02B044305B4133FBB99@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d89iQOHjT2HwBy1QT0Jcbo0OLA3PHf4OkWtlN1gX2aA9ujJB6kaA0kFHm4z70LyPykPZwZqLHAwHlDuuD2leVVOFhuq4kGbHGWphp7CDcvMOcOppIEKUJW83jc08/L2QhAScluGXNqprLCv/UInqT3W1Y28hjP8ElOMMPnJzewyxH1DS5tavCP/M4SYYSGaTdmr22c8HqVDGckEeKGzmczYK/dfycLa/mx54xD8DklVqH/8NlUNaYfwgWcy1KPpOwbh/vycBgbm5TMgb8cAxP8mYSm8xTIy/Iftl6k5S+ouWBnR7KO3a8JpYaa5AxZZV5Mgx73KBLAUrtymtyUQvMlQAjFhin1P2P9z408gSMgrRR0MdJdOHjU0xy4+YGpK2utGgOkvDjrlnwxXHwKnycskd8I2LP+GcaUCSd1KwwtLM98EivBau3BdU1OAA/LhpC52Hq5e86eRZznjNVmZjGRAxP4wwOeroiBVNQyg+4ti9Epw03O0Y3apjzU7Y2U8JPV+ja7n5nQ8iTcB/2lHQENfgQtHjAzLR7tdvcnHEk3+p5KqsBBr/Qe/ayaRGnYBS9NziPWKqBRyUNBZ2rVw3J2HZWIbro8VlgLrPnWE/dZlmZNZQDy4ZZYmIaGONXOV6+6Uir6vWn6TXD3dZaPbHSVdPYzZv/kO9klIuE8S0ZP9U9+Mb/uQJGokFBacymK2dfAx3Nek0flY+zFWPFTJpkLN/F4DePsfLddaaIc3KVFo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(16526019)(82310400003)(8936002)(7696005)(30864003)(2616005)(44832011)(186003)(36860700001)(1076003)(508600001)(4326008)(81166007)(86362001)(2906002)(8676002)(70586007)(15650500001)(356005)(70206006)(26005)(5660300002)(316002)(83380400001)(426003)(47076005)(54906003)(336012)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 08:48:35.3851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac235e83-2160-474c-e80e-08d98fb8931d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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

Currently, queue is updated with data stored in queue_properties.
And all allocated resource in queue_properties will not be freed
until the queue is destroyed.

But some properties(e.g., cu mask) bring some memory management
headaches(e.g., memory leak) and make code complex. Actually they
don't have to persist in queue_properties.

So add an argument into update queue to pass such properties and
remove them from queue_properties.

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  4 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 18 +++++++--------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  8 +++----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 +++----
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 22 +++++++++----------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  6 ++---
 8 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f8fce9d05f50..7f6f4937eedb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -557,7 +557,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int update_queue(struct device_queue_manager *dqm, struct queue *q)
+static int update_queue(struct device_queue_manager *dqm, struct queue *q, void *args)
 {
 	int retval = 0;
 	struct mqd_manager *mqd_mgr;
@@ -605,7 +605,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 		}
 	}
 
-	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties);
+	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, args);
 
 	/*
 	 * check active state vs. the previous state and modify
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index c8719682c4da..08cfc2a2fdbb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -93,7 +93,7 @@ struct device_queue_manager_ops {
 				struct queue *q);
 
 	int	(*update_queue)(struct device_queue_manager *dqm,
-				struct queue *q);
+				struct queue *q, void *args);
 
 	int	(*register_process)(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 6e6918ccedfd..6ddf93629b8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -80,7 +80,7 @@ struct mqd_manager {
 				struct mm_struct *mms);
 
 	void	(*update_mqd)(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q);
+				struct queue_properties *q, void *args);
 
 	int	(*destroy_mqd)(struct mqd_manager *mm, void *mqd,
 				enum kfd_preempt_type type,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 064914e1e8d6..8bb2fd4cba41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -135,7 +135,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -152,7 +152,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static void free_mqd(struct mqd_manager *mm, void *mqd,
@@ -185,7 +185,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q, unsigned int atc_bit)
+			struct queue_properties *q, void *args, unsigned int atc_bit)
 {
 	struct cik_mqd *m;
 
@@ -221,9 +221,9 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q, void *args)
 {
-	__update_mqd(mm, mqd, q, 1);
+	__update_mqd(mm, mqd, q, args, 1);
 }
 
 static uint32_t read_doorbell_id(void *mqd)
@@ -234,13 +234,13 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static void update_mqd_hawaii(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q, void *args)
 {
-	__update_mqd(mm, mqd, q, 0);
+	__update_mqd(mm, mqd, q, args, 0);
 }
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q)
+				struct queue_properties *q, void *args)
 {
 	struct cik_sdma_rlc_registers *m;
 
@@ -318,7 +318,7 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 }
 
 static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
-				struct queue_properties *q)
+				struct queue_properties *q, void *args)
 {
 	struct cik_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index c7fb59ca597f..6d468b6c8d7d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -136,7 +136,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -162,7 +162,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-		      struct queue_properties *q)
+		      struct queue_properties *q, void *args)
 {
 	struct v10_compute_mqd *m;
 
@@ -311,7 +311,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -326,7 +326,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+		struct queue_properties *q, void *args)
 {
 	struct v10_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 7f4e102ff4bd..f6c10b1b5f8b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -188,7 +188,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -212,7 +212,7 @@ static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-		      struct queue_properties *q)
+		      struct queue_properties *q, void *args)
 {
 	struct v9_mqd *m;
 
@@ -366,7 +366,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -381,7 +381,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 #define SDMA_RLC_DUMMY_DEFAULT 0xf
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+		struct queue_properties *q, void *args)
 {
 	struct v9_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 33dbd22d290f..bddd6d8fdf32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -150,7 +150,7 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd(struct mqd_manager *mm, void *mqd,
@@ -167,8 +167,8 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 static void __update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q, unsigned int mtype,
-			unsigned int atc_bit)
+			struct queue_properties *q, void *args,
+			unsigned int mtype, unsigned int atc_bit)
 {
 	struct vi_mqd *m;
 
@@ -238,9 +238,9 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
 
 
 static void update_mqd(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q, void *args)
 {
-	__update_mqd(mm, mqd, q, MTYPE_CC, 1);
+	__update_mqd(mm, mqd, q, args, MTYPE_CC, 1);
 }
 
 static uint32_t read_doorbell_id(void *mqd)
@@ -251,9 +251,9 @@ static uint32_t read_doorbell_id(void *mqd)
 }
 
 static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q, void *args)
 {
-	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
+	__update_mqd(mm, mqd, q, args, MTYPE_UC, 0);
 }
 
 static int destroy_mqd(struct mqd_manager *mm, void *mqd,
@@ -317,9 +317,9 @@ static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 }
 
 static void update_mqd_hiq(struct mqd_manager *mm, void *mqd,
-			struct queue_properties *q)
+			struct queue_properties *q, void *args)
 {
-	__update_mqd(mm, mqd, q, MTYPE_UC, 0);
+	__update_mqd(mm, mqd, q, args, MTYPE_UC, 0);
 }
 
 static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
@@ -336,7 +336,7 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
 	if (gart_addr)
 		*gart_addr = mqd_mem_obj->gpu_addr;
 
-	mm->update_mqd(mm, m, q);
+	mm->update_mqd(mm, m, q, NULL);
 }
 
 static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
@@ -349,7 +349,7 @@ static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
 }
 
 static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
-		struct queue_properties *q)
+		struct queue_properties *q, void *args)
 {
 	struct vi_sdma_mqd *m;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..37529592457d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -121,7 +121,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->kgd) : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 }
 
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
@@ -429,7 +429,7 @@ int pqm_update_queue(struct process_queue_manager *pqm, unsigned int qid,
 	pqn->q->properties.priority = p->priority;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 	if (retval != 0)
 		return retval;
 
@@ -457,7 +457,7 @@ int pqm_set_cu_mask(struct process_queue_manager *pqm, unsigned int qid,
 	pqn->q->properties.cu_mask = p->cu_mask;
 
 	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q);
+							pqn->q, NULL);
 	if (retval != 0)
 		return retval;
 
-- 
2.25.1

