Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2449CA0ED1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 04:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A79810EA5C;
	Fri, 15 Aug 2025 04:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ld91t9f9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DBF10EA62
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 04:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egk3VR61aU6Coz1BAYSbjo+WVsW1qgyC0BsFDCwEjZ7bC3y0HurqmNxNc+c2SRmSbRyojSg6awwoR9sWS1cey6Wjunjyj5T/x/duCQdtKk7MqhBBFElh1rtdiRYxChY5Nzl4Euki3+XI23hhuwPbxFV1AZ2Ik63XSPGUQg0hz5Al/qd1QgmpuhT6Bp8kcOsaBmRwjUWHUBT97tgW4mJTI6P97Ejd4pRDdMPZwJ/myU9DFE0dUlJgrGiwEmjDGHBI1uBXwhojTgzGvpKioWWWeasDGnNdiWzj1DCXCQu7qJY/SmRHwt+unVUnyygu5mb/sPGspP56kHmCSv4YjZZ3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHVjq4pj+Plzr9DGtXaB2PhuouGbmn52wVyWzpm/AgU=;
 b=q5WdjSt9WqCQGC6liBXbq1imknaa85zBMuvw2XrWETWaiv2BbDnpYI/IRpsmudQJ+ckx7eiJ7Jp5B1bxAL67+rrxblLglpmdvvZMtPchlYZEPpzKzeMUjZqWkcHu45oqgGRzazMPaXkbidU9ZGryZQVrSbXAVDi7YnUhKuP7TJ+tsAKmy70Jic4BUqekK9fVlMm+BzwCkJiRIezdw5AjOS621MPxxSpfNzoPGy2dPHokNyIj/gh8vvvcXU1B8auLLz9lBQZhccryWJHRDl6yE9+XcYAhQXi53g88sNZ/XFwh67MEu3bwnSlxO2Z/VFk5N1bYq0txPcI375UIvl4F2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHVjq4pj+Plzr9DGtXaB2PhuouGbmn52wVyWzpm/AgU=;
 b=Ld91t9f9Y+IbPOLizQaKJ5BKPjgx0ow/xE/b/P/R1EReiPE1WL6i0XRZtQ40RCziai3WUJnIZNUjBrrOms0kECcYpFdJerqFM9gFJeoVCa2TKla1QxxgdXehYQJDvN3y1trtXBaLr9SY4wYgMpgW8MOb7xUkowsbsZZOxdBXfTw=
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 04:12:16 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::a8) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 04:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 04:12:15 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 23:12:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 4/4 v3] drm/amdgpu: Correct the loss of aca bank reg info
Date: Fri, 15 Aug 2025 12:11:58 +0800
Message-ID: <20250815041158.301031-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: be7348af-abea-48f3-4310-08dddbb1eb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKkxUAVHom9RjUuf4ram/YG5Qbp+n5hPkhsR2DzquCz+8tOSlXhmksxBXYRg?=
 =?us-ascii?Q?njdqO0YlZP7fEZj9oX+E9EJVLYWzdc7znixgzM4GV/hfuiuvNP1bpQncDTMM?=
 =?us-ascii?Q?0hPsYYjtxkRb9s1TVPcko6s5KsZPzgIoxKagk7WuLMDALjls0VodIuhUvZre?=
 =?us-ascii?Q?HnUW8nsccybvijht8CljjhB3SqrkTmCV/Rx5b6tOShRpE6Up/EX4InP4HY5u?=
 =?us-ascii?Q?GTgEqBOiCPn/39sAVNPdsJTI3wwZE90VFBDgdpY2XHcUc5kvTs03m4lHq01d?=
 =?us-ascii?Q?XssRMiHxl1T8nPoQSAWKnpH2bWr7CIYxwJAAzsdgeyuKDKs5DkHslHl1Gd/P?=
 =?us-ascii?Q?e1VgYfX1dgsNEsc1ePR70pycJMzbgoPGRTMaHssz6M8Ii3gSlPWy13t2qMX1?=
 =?us-ascii?Q?NmTSFCVO8Y//9rK24Ct1dmx57kzqsMFYwaKpist2mpIugNWJUwAmLoTAKbiu?=
 =?us-ascii?Q?D/AYLNjwMOXcV5mgX3erGqT4EtMtMjDDKkidyMtBHNM6AXS4KzvF4KytPy8R?=
 =?us-ascii?Q?x5iBWFD4RhkxCUGOffPP0CIw/uldziahQeRFcRSCUMghdNUuhn9eAJgc6/0B?=
 =?us-ascii?Q?4QAyXrGjRI7IZzAH1Lfkpv2GPH0khwNeg4G3pFIst5qLOS9Qde3IZKttq0Pj?=
 =?us-ascii?Q?6pB/HI2ejycVMfrIvTnz/MGCkOW75hl4IaUAIEQS0bKb+YhPCi5MSCieqMT4?=
 =?us-ascii?Q?t88aM+SsKKSzfFX5CjSbFqmVE8Vsy01Dj7QS/m/5cor7CwnrLvTgvseUR5hO?=
 =?us-ascii?Q?CoU7Vn62CLN3thCsvvQEw6NpqWF0m3toTr/KjsSWEogrzEaGudvwdVUMbyWg?=
 =?us-ascii?Q?TduCrRjoe9HT/w+/5RDYaQraGgFbu83VmSOBck7Hsom6SQ3u++a+9zunjd/y?=
 =?us-ascii?Q?Zb4/5Yxu4XQT3S4wbMmb/XM33wtmwBQLRIHLf7j9vLzShWyty++ZIAssZCkr?=
 =?us-ascii?Q?s49VI6iAVABMUYIWoGN0WOOVK1eKunGrBXHZBnBawvcG/N5E4L34Ukx5cwY/?=
 =?us-ascii?Q?Kvp5YJO48rb69zYGli8Mrkj74UqIHIPGAskoEEndABuRyhWSAdT09SCiMzDo?=
 =?us-ascii?Q?kc3fgZ05SNQBe/tWpgmrsEGlvkxryWnAAN5G7teMZhmDSIYIqQyH6O8r3UiV?=
 =?us-ascii?Q?rM5zxe5lpDvD0f9edmiIGuBECferkZ18i6oCIVOyXRblgU+6H4rUk3Xaj2B6?=
 =?us-ascii?Q?C5jCxh7pSo1ArN7FcXsEPwDla3CIuOTa+gTaRKa3dW79uJCrrR+8n8d41Q3t?=
 =?us-ascii?Q?EWtgb7Hh8EwVdy2roCcYv2vL6CaKPJ5aUmATf7vsT0+EHVFryJuFQgcSUF/q?=
 =?us-ascii?Q?MadgWG/7rehsXDsGQgoTRNSPx7g0gnQ+Hb3M0QxnRXGpsdzH4dc94BEJsqzy?=
 =?us-ascii?Q?2mI2dflITvSbn4tls4JPCvW5LCHZ9Yw2UG5r34Uf+Md7Yfvi5fSqY9isRBJK?=
 =?us-ascii?Q?wgqkW88ZHx4Q7IDWL7JZTlG3xZEfdGt1ZSwJl/1iQE8vH8DTHf6o96OMrsbY?=
 =?us-ascii?Q?E2tjSpzFrouMU/0Xy+SaIWlvgAzeZQebozjx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:12:15.4420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7348af-abea-48f3-4310-08dddbb1eb57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

By polling, poll ACA bank count to ensure that valid
ACA bank reg info can be obtained

v2: add corresponding delay before send msg to SMU to query mca bank info.
(Stanley)

v3: the loop cannot exit. (Thomas)

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 65 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 12 +++--
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31850a47a41f..9ccc1fbca14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)
 
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50
 
 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
 
@@ -131,6 +131,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1
 
+#define MAX_BANK_COUNT 12
+
 enum amdgpu_ras_retire_page_reservation {
 	AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 	AMDGPU_RAS_RETIRE_PAGE_PENDING,
@@ -3306,8 +3308,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)
 	mutex_init(&ecc_log->lock);
 
 	INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
+	ecc_log->consumption_de_count = 0;
+	ecc_log->creation_de_count = 0;
 }
 
 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
@@ -3326,8 +3328,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)
 	mutex_unlock(&ecc_log->lock);
 
 	mutex_destroy(&ecc_log->lock);
-	ecc_log->de_queried_count = 0;
-	ecc_log->prev_de_queried_count = 0;
+	ecc_log->consumption_de_count = 0;
+	ecc_log->creation_de_count = 0;
 }
 #endif
 
@@ -3381,49 +3383,48 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 				uint32_t poison_creation_count)
 {
 	int ret = 0;
-	struct ras_ecc_log_info *ecc_log;
 	struct ras_query_if info;
-	uint32_t timeout = 0;
+	struct ras_ecc_log_info *ecc_log;
+	uint32_t timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-	uint64_t de_queried_count;
-	uint32_t new_detect_count, total_detect_count;
-	uint32_t need_query_count = poison_creation_count;
+	uint64_t creation_de_count = 0;
+	uint64_t consumption_de_count = 0;
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CREATION;
+	uint64_t bank_count = 0;
+	uint64_t total_bank_count = 0;
 
 	memset(&info, 0, sizeof(info));
 	info.head.block = AMDGPU_RAS_BLOCK__UMC;
-
 	ecc_log = &ras->umc_ecc_log;
-	total_detect_count = 0;
+
 	do {
 		ret = amdgpu_ras_query_error_status_with_event(adev, &info, type);
 		if (ret)
 			return ret;
-
-		de_queried_count = ecc_log->de_queried_count;
-		if (de_queried_count > ecc_log->prev_de_queried_count) {
-			new_detect_count = de_queried_count - ecc_log->prev_de_queried_count;
-			ecc_log->prev_de_queried_count = de_queried_count;
-			timeout = 0;
+		creation_de_count = ecc_log->creation_de_count;
+		consumption_de_count = ecc_log->consumption_de_count;
+
+		bank_count = amdgpu_aca_get_bank_count(adev);
+		if (bank_count) {
+			total_bank_count += bank_count;
+			amdgpu_aca_clear_bank_count(adev);
+			timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
 		} else {
-			new_detect_count = 0;
+			--timeout;
+			msleep(20);
 		}
 
-		if (new_detect_count) {
-			total_detect_count += new_detect_count;
-		} else {
-			if (!timeout && need_query_count)
-				timeout = MAX_UMC_POISON_POLLING_TIME_ASYNC;
+		if (creation_de_count && consumption_de_count)
+			break;
 
-			if (timeout) {
-				if (!--timeout)
-					break;
-				msleep(1);
-			}
-		}
-	} while (total_detect_count < need_query_count);
+		if (total_bank_count >= MAX_BANK_COUNT)
+			break;
+	} while (timeout);
+
+	ecc_log->creation_de_count = 0;
+	ecc_log->consumption_de_count = 0;
 
-	if (total_detect_count)
+	if (consumption_de_count)
 		schedule_delayed_work(&ras->page_retirement_dwork, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6265dac0e1c0..b4eb427409ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,8 @@ struct ras_ecc_err {
 struct ras_ecc_log_info {
 	struct mutex lock;
 	struct radix_tree_root de_page_tree;
-	uint64_t	de_queried_count;
-	uint64_t	prev_de_queried_count;
+	uint64_t consumption_de_count;
+	uint64_t creation_de_count;
 };
 
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index e590cbdd8de9..11b99095efd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -536,8 +536,14 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
 	mcatype = REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
 
-	if ((hwid != MCA_UMC_HWID_V12_0) || (mcatype != MCA_UMC_MCATYPE_V12_0))
+	/* only creation/consumption defer error can access here.
+	 * MCA_UMC_HWID_V12_0/MCA_UMC_MCATYPE_V12_0.
+	 * It is the hwid/mactype of the consumption defer error
+	 * */
+	if ((hwid != MCA_UMC_HWID_V12_0) || (mcatype != MCA_UMC_MCATYPE_V12_0)) {
+		con->umc_ecc_log.creation_de_count++;
 		return 0;
+	}
 
 	if (!status)
 		return 0;
@@ -582,7 +588,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
 		if (ret == -EEXIST)
-			con->umc_ecc_log.de_queried_count++;
+			con->umc_ecc_log.consumption_de_count++;
 		else
 			dev_err(adev->dev, "Fail to log ecc error! ret:%d\n", ret);
 
@@ -590,7 +596,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	con->umc_ecc_log.de_queried_count++;
+	con->umc_ecc_log.consumption_de_count++;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
 	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
-- 
2.34.1

