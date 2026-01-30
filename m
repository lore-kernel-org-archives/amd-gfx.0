Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2957ED73EB5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B944810E8D3;
	Fri, 30 Jan 2026 02:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="knrGk3cg";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A580010E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRQlvnUh7ePyZEw+aDUtSUPQt66FKvkmzmPdz0dKzFTRiZddZKfvDraGoKYjvx36t6Da/W4yZqkFknk4nGzKI7xso1hm88tSb90XO/G+g/yqg9NSmohzxqIvBXS5kVzSNyPCetjdg2FyvZDdFIXJ1maP2zY0dVXf337Wfb5OYhaeZKhgNkWYVgxXdAlaNdwVgYLHssROHQPh+U0GKcR2KZpz70A0Fy4PKxyrANkNxV5/CtLoEahkrERb/diMZ12gfMT//UYbipzQPkGxFsKrFMu3UHVCN5zm9aXSRtXGrMfdf/6+8VwkjNkF4fx6ltp5KrA5ne4AK3wVmzZXWxsKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rlz4k8+9hl8qcKfK4uN+sXyTJ19b1HfQCf7oGubqM0=;
 b=Vk8aRxB5ZQmwn/sznlypdHh8MXAraxi8XPU7u4uzzWk7ym9E7LfHkfiyT2P+IhQp1NGZpNA4NIyOCYpHZzDsc0Qb4IFaSqsjqi4Ku0vzAGMvEb7cR4Wrx68ee6O74ezdAjwdCXLBS3SRMPNN+Nh4WrPADPL2MM4gwYpbjc8ouUOQDto03r7vXDkJbx7uLVRt8ee87k69IaZuD1HmXMJL05+TdDwCVrc2M08aBvOuAEeRAqhRO4Y0YwhWmsfhgVzX/1nodZCfF4bALEyXux0XL2V7t6v1KJV56L+fRxZQEqzlXkbfZ9DB0Pk8uYOSjf0Gl+IpCJ57Z26k76c9INL8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rlz4k8+9hl8qcKfK4uN+sXyTJ19b1HfQCf7oGubqM0=;
 b=knrGk3cg90pmRB8qeD53bLc2v926Bx46Pt/F03pMewMdx+AAg4FyBgjIak3S8W2NQ/ESL4BC1P7yyYPG8Zy5rlaSNMAUgLQBp+rTONoA/ah6S9pWI8hnqdq4s6CbJqr5B8diDQ2LqtxPOuHIQi5AJZS4VawiWRiU9+7jECZcWyM=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 30 Jan
 2026 02:30:45 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::17) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 02:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:45 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:44 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 13/14] drm/amd/ras: add check func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:49 +0800
Message-ID: <20260130022950.1160058-13-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c587a6a-4e4d-4ca5-3f37-08de5fa792a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gjAnUDDsqhdVF8KEoYk9vDEj/d/WFivjJvtDCG/PxwniNkcv9L9lDpb8OBc9?=
 =?us-ascii?Q?Q36ChAU5N+W1VLY3jBV33XSYouCFLq43o+9ltiLETuBvh/strZxUEalH+HYP?=
 =?us-ascii?Q?44pv7LQrnKVmT2khkyZ9mBw6WedBxvDzoJEr9m408CO6KRCwnqJWktL5vzJQ?=
 =?us-ascii?Q?dCmqUKbMGb+8ocW0UYuG6kwdIk2vRS56aYoc+IoJdMMwRVINtzkJa8ctpSad?=
 =?us-ascii?Q?puTUjd67dBP9a7uqqDZYMRXc9Rb4gKrIBspq+d7L4gwtr+g+VwfQX1iGk9yT?=
 =?us-ascii?Q?VsIIWxQ+OoVXHT6S15lNlyn3byNtEOEw4gI55p4X4GiIf/LVL1ubGVx7+Fw5?=
 =?us-ascii?Q?MqjYo8ZfIlSCRXDFo+j1tK1/eIiHY/XWoOmP4Ex1HWe2RoKjH9s8rd5xJMP7?=
 =?us-ascii?Q?NiiVv4lEiYDuC49TRAV39uIAska6eL+t7g4NvqjGyNUKWYk8AD42h3YTJYcO?=
 =?us-ascii?Q?JYmdKlfVm0tpjXRMEADqpt76KaJnW5IsOpgYQrWvXtp3Ouo2I1ex/kh7vfx0?=
 =?us-ascii?Q?fWXyEMU/RHTBnfXfILBTmk2l7MWBe1uHGnnez5xkiz2fTRhGMMjWJYR75BfV?=
 =?us-ascii?Q?fTEXq936NQWRp9uiSVx3Ccgkqk2uvkmNw5fehoRQu530K2Xca6D2NGFRlOol?=
 =?us-ascii?Q?wK3Biki0QuDRuAAd7h6XFJLq+tT592Uz/gC/6a6ygHjTCKm/2bDedOmn2dVh?=
 =?us-ascii?Q?Smk9EDo0EVlRU+UhKLCv4gY99foIc1wsRLL8OJ3XbZ4QpuYujT9ACRi55zJF?=
 =?us-ascii?Q?OngSVDwmHbXHvLq+gMNofF50aEqD6EPUppXrvhIi+iG60juOxJ6yH84F5+AE?=
 =?us-ascii?Q?NU0Ws0BYfQbzKgwOcNAem78SqBfgIqRsL9SOpw7V1DuhQQGsueJOlck95Ojm?=
 =?us-ascii?Q?3jC79TwgBwi54CGu8OpX7GcbhdR5wo6f8NohDGyhhSvLxP1cZv71Ul7JHFWy?=
 =?us-ascii?Q?dPuQTpXKHsEem/NdoLeWYp+myFpODaHcmpYToaMfcRmb30bnT5Y1nIDCIQAE?=
 =?us-ascii?Q?5tfyU7SsfSFAinrlBE82+4ttLPH3Ex2D1W2Qiu7DdiXFB+wEgYUjPBZeerwn?=
 =?us-ascii?Q?EGmvebV95kjJzGODPjOdvuNypZSeKRkCBKR00+uvS5WgsKOdng+6GRVJs2YT?=
 =?us-ascii?Q?ygA2hwYA+ufTEpy+167W6VYfw0aoc9CTLfp+ksmU6f4wynz5F66y+KSRKYLp?=
 =?us-ascii?Q?/QCGxm9B9Kwi7jpCmwBDsegXjgL7fSnP2HSEc9tsZKWF53vyRmKIri4qGQOr?=
 =?us-ascii?Q?U2TDwiOganbp9OBVnF8qpOoyGsszOlHEysCjr5u3C9L4Dyry7O4+kqUDQCoc?=
 =?us-ascii?Q?iFRVCvmBO68Lz3zuv2epEBTMkiUOSToR9PNzp2UjC+C3UMxAAVGfCN1FHmtY?=
 =?us-ascii?Q?NzXEDoO7pBn3fXG1pMXrqEDqjXzCG0RzA1bTK1Kq9sVCZE7B5Osjk5mYDSCR?=
 =?us-ascii?Q?UWhKAWILhT2dcTCGxtLW71XiNVSgLRMcUvieom/A+5sTl/9EAdHUKuYJXEOX?=
 =?us-ascii?Q?A2lygSHpbVAhZLBt/GJP1RCDYwCZ27awx7w/LOyAhzXxb+UOiOCyfJyr9eI4?=
 =?us-ascii?Q?iJZlWxNfSaInFu/wsmVef7k1F8E3MESuOSSoQFdnSY1K8OsoWVdxEpz6pbMb?=
 =?us-ascii?Q?TBdj15DUmEFDcpnt2B/ACw5BT1jhDlcgJtGbRlNJQUbhO02SpbspAcqjUbDe?=
 =?us-ascii?Q?I0XD0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51OQNVV9l42LAFDQc4yhMpzWW4lUQ3gPfNkphMJiOyRe5ML3QB1BKNnFXhDIIcGJmVJt6f9feDsFU/pUXuB2I3VFLk1HUtEsHY9RiQHSjcyD52NkJHdGxbuDlgVgTkysM1pzQKZnSAOFw2BKEb52qsnkCyarLfxea4EGQaIwsriwtPoGTQHeKIqH0wWqSoGfG7FHIfIdxndCqwB9DYD6NMIAqhFPT99LvzDfykAQTvRfhAe/hG/3TrIwF+oe6OHR4aur4k8hYWZCCaOj4l+d/uWqnn9LgAjQ7G1GShu7eX3/0tK48KxxnNJluZl7cxqdCSm7uS7Ujps3lvV844WwBKjGJTmm0bCesI4P3Fo8shBhsS1aN9i636TfR5gQYaHF+CY5vB4aLUA21lSNzpXTRSP3JoWWlGHOqUW5eZOZRK65ZUUb2rmeOBnGNXxL0XG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:45.6559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c587a6a-4e4d-4ca5-3f37-08de5fa792a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
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

add check func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c  |  3 +-
 drivers/gpu/drm/amd/ras/rascore/ras.h         |  7 +++
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  5 +-
 drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h  |  7 ---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 51 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  3 ++
 6 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
index 45ed8c3b5563..7d728e523604 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
@@ -137,7 +137,8 @@ static int amdgpu_ras_sys_event_notifier(struct ras_core_context *ras_core,
 		break;
 	case RAS_EVENT_ID__DEVICE_RMA:
 		ras_log_ring_add_log_event(ras_core, RAS_LOG_EVENT_RMA, NULL, NULL);
-		ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
+		if (!ras_fw_eeprom_supported(ras_core))
+			ret = amdgpu_dpm_send_rma_reason(ras_core->dev);
 		break;
 	case RAS_EVENT_ID__RESET_GPU:
 		ret = amdgpu_ras_mgr_reset_gpu(ras_core->dev, *(uint32_t *)data);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
index 05c7923e8f0f..c2a56138b2dd 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -50,6 +50,13 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)
 
+enum ras_gpu_health_status {
+	RAS_GPU_HEALTH_NONE = 0,
+	RAS_GPU_HEALTH_USABLE = 1,
+	RAS_GPU_RETIRED__ECC_REACH_THRESHOLD = 2,
+	RAS_GPU_IN_BAD_STATUS = 3,
+};
+
 enum ras_core_fw_feature_flags {
 	RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
 };
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 1eba279a020b..a4e2ad6a159f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -401,7 +401,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 		goto init_err6;
 	}
 
-	ret = ras_eeprom_check_storage_status(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_check_storage_status(ras_core);
+	else
+		ret = ras_eeprom_check_storage_status(ras_core);
 	if (ret)
 		goto init_err6;
 
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
index 2abe566c18b6..f2c001ef64e1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.h
@@ -57,13 +57,6 @@ do { \
 	(RECORD)->retired_row_pfn = tmp; \
 } while (0)
 
-enum ras_gpu_health_status {
-	RAS_GPU_HEALTH_NONE = 0,
-	RAS_GPU_HEALTH_USABLE = 1,
-	RAS_GPU_RETIRED__ECC_REACH_THRESHOLD = 2,
-	RAS_GPU_IN_BAD_STATUS = 3,
-};
-
 enum ras_eeprom_err_type {
 	RAS_EEPROM_ERR_NA,
 	RAS_EEPROM_ERR_RECOVERABLE,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 4362b8a0f3c4..70bbf1334c4f 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -453,3 +453,54 @@ int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
 
 	return 0;
 }
+
+int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int bad_page_count;
+
+	bad_page_count = ras_umc_get_badpage_count(ras_core);
+
+	if ((control->record_threshold_count < bad_page_count) &&
+	    (control->record_threshold_config != 0)) {
+		RAS_DEV_ERR(ras_core->dev, "RAS records:%d exceed threshold:%d",
+				bad_page_count, control->record_threshold_count);
+		if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
+			(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
+			RAS_DEV_WARN(ras_core->dev,
+			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
+		} else {
+			ras_core->is_rma = true;
+			RAS_DEV_ERR(ras_core->dev,
+			"User defined threshold is set, runtime service will be halt when threshold is reached\n");
+		}
+		return 0;
+	}
+
+	RAS_DEV_INFO(ras_core->dev,
+			"Found existing EEPROM table with %d records\n",
+			bad_page_count);
+	/* Warn if we are at 90% of the threshold or above
+	 */
+	if (10 * bad_page_count >= 9 * control->record_threshold_count)
+		RAS_DEV_WARN(ras_core->dev,
+			"RAS records:%u exceeds 90%% of threshold:%d\n",
+			bad_page_count,
+			control->record_threshold_count);
+
+	return 0;
+}
+
+enum ras_gpu_health_status
+	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+
+	if (!control->record_threshold_config)
+		return RAS_GPU_HEALTH_NONE;
+
+	if (ras_core->is_rma)
+		return RAS_GPU_RETIRED__ECC_REACH_THRESHOLD;
+
+	return RAS_GPU_HEALTH_USABLE;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index cb92e6a63cf5..75d8b95c6923 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -79,5 +79,8 @@ int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 				struct ras_bank_ecc *ras_ecc);
 int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
 int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
+int ras_fw_eeprom_check_storage_status(struct ras_core_context *ras_core);
+enum ras_gpu_health_status
+	ras_fw_eeprom_check_gpu_status(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

