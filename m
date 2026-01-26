Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1ADC88E48
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F149A10E39A;
	Mon, 26 Jan 2026 03:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qkNQc7Wv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2510610E39A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1yFrhNB3JVCbzYIM/kFu0Wk9+mIF0kgQsLd9rQIRCIG5509+Jt6uFGF/jzIwChB/xwdssNkOtRBoOBZfVjxBLEUMMVckhcxYcSt+k8TZYQP5dyI7Q4LuA8XjgcbcO9hLfxmiK4jIQqFkW1dMUz+uBVN7yXmKjjc5QoZM4UvdJYYPSa2gy0aS7bmop353/AwvMOfjVhTh3Ss4oCbT3dtRi+r7rQqnKI7b3MvGgA572FeZ+FDe/jYRmqsQDjHlKoYRB9W+nNNH9isgTWiQ/alTDmzkzp/LWlOoUn1Hwc6TeX81rr29pPJHfGMLhNWnRzfdChdC5FRXvkqFX8Vb6WUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQYquHyDB4QVGN0EZzdyNQjC/RAiTJvnGruvG28Z3Rg=;
 b=bt9z01vLBt1PctLdgpWMHhYkwDpRU7cv92sZyf8E4sI2HlD5YeLNbg1cpC1mI1r4T3ff6klqJTt9K2ayiJ7zBNm8w3Ra2j1nlytw0UZobxXCdxBTsECDay1H1Dsz+r+HO+UjlTq28BvtZK+1kakYw+EdeBbMIN9gOnnGfc9cbE5vEuIzihxk5VDMnHwz0bfQp6a7jqETcgPimMGgwiddqkui9PiGMvX0aZglv3IhsQ2DafsA+bpiH+uECw37OfPRfAFacAlKts5aAHie5cdOhgJZVXkKnm9zY35yVDK6VzIcLnCiPNbIPeOD3EVV0T8fxy1ipDn7nWW3Vv7TaEQvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQYquHyDB4QVGN0EZzdyNQjC/RAiTJvnGruvG28Z3Rg=;
 b=qkNQc7Wv6rg+U7Kd0RmVIA0XWuN5bamzKl6MQf12IQ/ZWN3Cwl4g5bQgw0eoGvETuv5D2H1EnnWqLNMz6WwTl8I7ndj4QNDhoCWk5PCYwIpGCsvo/6Epv5QgtITkmRP7k37wCZphd+9i1TgDGR7rceq+YbOdVFL2c80V0Kz4nvw=
Received: from CH5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:1f1::27)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:56:12 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::53) by CH5PR03CA0019.outlook.office365.com
 (2603:10b6:610:1f1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 03:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:56:12 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:56:10 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 13/14] drm/amd/ras: add check func for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:26 +0800
Message-ID: <20260126035527.1108488-13-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126035527.1108488-1-ganglxie@amd.com>
References: <20260126035527.1108488-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8345449c-04e6-4cba-f262-08de5c8ed8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gi7QZl1SQ720K4O/vdpdjyqT46E9UEYeVqieSHJjGFRjh3u36c2Z5PUzS7nC?=
 =?us-ascii?Q?R6Zm4eccWZ5T+TyFsPbnnq94UNZeR8UypPn/+9fgqutQdWilDLv4wXktJedA?=
 =?us-ascii?Q?UMPNYyDIe8h1+zzxvxBKOP2Dpvrd0c1QrbwcmpUEKPUVujgouH7hM3iFlwQD?=
 =?us-ascii?Q?1FfZ7ud6HNdk87kCOVPY1Hx2bvvQ/y3Pq5BrGbA8VFaQVYuWcJl95hL7taug?=
 =?us-ascii?Q?mvcGKOErZviIgkAea/m/TjmGIa4bvkYsfZFuRivL22ed+F7tT2WFwdX0eqpR?=
 =?us-ascii?Q?3jHJPMdpXV0lO2+u/yBxWEzA8If4yr8WEgAx9/P2n2A++A/lsi9Pi4+KjpJi?=
 =?us-ascii?Q?Ii7yuHq5v06gq3v7Yyjb2z5xuJsk73GWCiCHuSLdDgf8gRFvU6uIocwl2jjT?=
 =?us-ascii?Q?k41jsqAXK3QaOvAGU3crg7y4IneZZy+qip1l0wuITbfJw6f0ZoGdLk7BeMaV?=
 =?us-ascii?Q?mmuIQqdcoj1DHqgrxxlLKJG9qaAIKA99MJTf6jTtXe6vZ/BW83fScV/0kz6R?=
 =?us-ascii?Q?/f5HE7iyGpc7m5YaV7Asrq/srBNPGbfFdpJiiV5XkV3y6RWPgPotjRJ2Mh/d?=
 =?us-ascii?Q?oEZPw4fgQS4YLfh5W7Yfj3vvZ55VqB5SZCnUQGnBzs4WeNZ6sc5xOeeqUVdR?=
 =?us-ascii?Q?FiSSzKNkstNVB1lTDy0v+5o1Wf8uexW6wETHGFTQkpVy+voa8va4VqoeeA1v?=
 =?us-ascii?Q?cEVJRZLnnKxlceYd2KUcpFKVGQz7VBqxu0IQfpyddDFXwDRTUvk6ulAySOrf?=
 =?us-ascii?Q?HnU1DyJuL/fRIr99Boe1ksszVT+N/cT4tIRPDPPxCekBPGzYT+8q76YTlciP?=
 =?us-ascii?Q?BCOjFAfVUbqwF8L/ZyLgrqqaM0cLjBdFhJdhOqK/8+FErsBun9VVqB9MjUFl?=
 =?us-ascii?Q?5OP/bqFuV7UReEuNs48c3yWta5OQ5TQgJGmueZH/6DVk179jvh9ukJWyo1Un?=
 =?us-ascii?Q?aUvLvWZRV8nR9beIE+4HAzqNXQY0v8XYH31JRZnuByVbhu4rasK0x+9vyS3h?=
 =?us-ascii?Q?ngyUQykKQxTj822k+ibYrEkBe8xp/sw3ixxgkf/7xNEAaRE+ZuHWhJkwDA/a?=
 =?us-ascii?Q?NmGgV8YlpqsKISSm9Cr/ZJxbi1++aIqD8nr5FWpfImN24SDr7kqeAhLnMqgE?=
 =?us-ascii?Q?APCQ7iVNG795oIMnZJavqMs4D6G43cVbR/1FgAwsF6S57uJKxgyHUybENX7W?=
 =?us-ascii?Q?LZvGn8TzSbGuigqS4rFWLLSPtq1oRy7M9yTniBOzkiintHkMcad4r79tbRDg?=
 =?us-ascii?Q?k5+NLk3+SbSjV6RFL+u/zsHt2EBwOuyAUohd5P0vBngeqGomgXvmuTsMuZdQ?=
 =?us-ascii?Q?+ZoHndjvGSjRjO8LDG+h9XxXnK20E+CNQX4fWWS4kvnfZbByIuOg/9ON02Wj?=
 =?us-ascii?Q?gmx3VHkCsWBVIrUyB7lTFotQRRG9KB/Uavnjy/wGm1M05vmfathg/ky9C8cb?=
 =?us-ascii?Q?v2JwP2WgB/avnLgKG2u3/rIfa7jEL43qPFlmxI8NDXXvhKfGHN0IJWisgTBT?=
 =?us-ascii?Q?LP/AHPQoQn5qQDDXTrGMojVWxL/LP4CR7/igBjcYe2AqUT1Qvi2m35e5rHvI?=
 =?us-ascii?Q?1zTTMwXdBo1wR5rhvPyKN1+GY0QzsIo7DNfclUcH3wdxdtH1TtbQS3ia/TsQ?=
 =?us-ascii?Q?KfjNF3UxN27DdJ4yHZx2IRUq8JZOUrDNzwIX70CqIjHsaU89gCoJTTEOC7Xx?=
 =?us-ascii?Q?kWrvPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:56:12.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8345449c-04e6-4cba-f262-08de5c8ed8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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
index 138d223a1256..f7a71ea797df 100644
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
index 5966955cd847..a0301e228863 100644
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

