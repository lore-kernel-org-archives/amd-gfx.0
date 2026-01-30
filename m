Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB76D73E86
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E2A10E8DA;
	Fri, 30 Jan 2026 02:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0M8Eh5fY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9F610E355
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL8gMbCJ9aWG+Vx8uPSlJsGt++in4UYre/i9kIgoC2WyV9V37FoPVcDTkK4nN/MnO85UvQQkCRLO8+PNwsruvxHnMM8OS8GAoGxbOC7jkl40PxrOpkPOKpAmY6gJIs9Ua1G0dnHiXhMw4p/qzUVS8zvdz3+PaOSOIFrd0qObqH/lRSTB84Eg4BH8dzUfwJGi7dIBQW8NXOT2IEq+HTIYCsacF9uYr+lezs43HwbFQq+K3tdxzuHpsfJbD6pZWcxUJ05QSURfEIjRPzeQ9kIqlvVjP/rRQAyOMFdFId60WnkcrT872q2xHhUP5Mc8+HPO/iu/skUGyZFIZXMELbGViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2uwOMIh8Tf1yfjzZqV4kzSCoItnDo5mfD84ofoucZY=;
 b=bQOFVgl+O6Htbnim+/LikybNiiY1TEKX/c7pZsxuVIno1KNUY6VtFraKe05fb+l/1OUCibid2SgzxipqGZxTWKy4OYdYPqoZSw88/wCP0JYO6N9izGSwHWY9Bnwjj87N911y8FcpA2+1x72uUkRiis2ZADW9bSb/aQXLt33D66xWuZQMBrNWUX4nUK6MglnLhDvVZMXt36K79S458Q3IzNObYpK0fdh/f3Sl9gp1KO1eyBgyP33CZsolpmxg3EZsOTiTLbD7RDJ7MGGSkIoFnznY6Xj5eCq/OAB0nP3XqN8E+pWlC1kVe/aygnKHObEuMVdmOFDQDQddr4qK+0KCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2uwOMIh8Tf1yfjzZqV4kzSCoItnDo5mfD84ofoucZY=;
 b=0M8Eh5fY475wvjXnQU0I0i97zPCh+X1KLr7ifkuEreeCqtO1GXYIPW7uws8Q+i9EhTFDt8rRzq73SpDCTN+M83bqnha438sUXdMi948WmzAux4BRLIOXlm3wIHMUka+5bMKeK01ZAHi+oZ9JrrmlX8mEit84IIPLyBARpkMzQjE=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 02:30:44 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::27) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 02:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:43 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:41 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 12/14] drm/amd/ras: add initialization func for pmfw eeprom
Date: Fri, 30 Jan 2026 10:29:48 +0800
Message-ID: <20260130022950.1160058-12-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef6d4e6-7a7c-4e08-5fb9-08de5fa79143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SubR3Buvo7EuASVkybauDqwzmwRRXRz3ovskxXvwBIS1OR2yi1oUApRBbZ8/?=
 =?us-ascii?Q?Ptstz6yPspbZP/tXzRe+7vB72OFlVjxWUjVGnVxDtqS9JI/qrXaGBP+iryHg?=
 =?us-ascii?Q?Jztmd+WZNwx6BepFAYyHMB5XR0C/DI8wdcHwp2bGGmjVxWtmlhVf4snzuXpe?=
 =?us-ascii?Q?9b15CgybNtNQjhhaPtHi/5fMQcjehIx9o6mvpNL/O/rXOL7vmpXppJ+lRu6A?=
 =?us-ascii?Q?73uszCMtckYU+OxBMR8OPQQmuCGogWVX/PjSRzqCiKl5MYJrQJYdxD1jNQ5h?=
 =?us-ascii?Q?pwiQ2FjiMZwRhbpyY437nb8qbqxgQzPlY8KGA6bPf5CbpVZYxKZPuQXttdem?=
 =?us-ascii?Q?eBKnB4flwuEugNbRSuxjnSWoQzCw8yeX9+VdFKTzo1L3l1dBgzn1SHW8t427?=
 =?us-ascii?Q?N2vraHVqCExLiTJKs2eZTrWmWVZ1+eo/WlWAoVdActhUVwM7pztzH5bwBkHk?=
 =?us-ascii?Q?naq+W5ZOqBTwFgW15R49LPZsP6JUagI9zHCA0kGWXtMxZDKVR80xQvKd3TBv?=
 =?us-ascii?Q?Yz2pteZ4wdT93zGckYJiTZrp2egmkwmhyVRVW2qukrt0eIgLNuyWaXq/pLgl?=
 =?us-ascii?Q?jc8rNhYf6CruBPaR2Qe5BGTlKM/vfbTuMadMt2rIIz3AUaxMo3fnfsQKnRqd?=
 =?us-ascii?Q?Wsc7tJsmgXflPHe1ZjtRqJgSH3VEBd+lj/21rbJ/+c/qeAh4SpzEpRKW79zA?=
 =?us-ascii?Q?PW6F8Hw6sAVSMxMPHv2M34lNGgXn3Y3U+ICO34FD2Arb8p1X4HTKqWcdtDat?=
 =?us-ascii?Q?PV41XMRGOzUuaopvBSq/F6jNSdt1qAIOaGNXlDoLiNgC5pF2BV+ZYuLXyap6?=
 =?us-ascii?Q?3/zjoxScnSC7xt1FqUhqanKisr8kuQmW0851dVg1I6XPydBgkkK6Lp7rWrFf?=
 =?us-ascii?Q?b91HUKZYg2yUz8xYbeDmuesxvfF7eTPSQyDSnOGOiJhNwYh82aeMCc25IkGJ?=
 =?us-ascii?Q?pnSpKEJhEpY7BkdEW8dGFwACJQrzy+DvltOcYAYQ763D0I63O9+797+azd6U?=
 =?us-ascii?Q?aFN/+8HU1i8shDxRLYA9/Wk9I73APynkoCV2CRADH+erXX7G5AgDpdv5+aXD?=
 =?us-ascii?Q?Hc1IEF8UjmkHqCC8pEkZcmK4GcQqHSj326uOZfhW1OchTCGbuntKluZXyt+x?=
 =?us-ascii?Q?5TTAm5478q6fKRq3IOX5FTEe5RMno5uzj6E6DFtEuqUxMkSqR3pb2/2a3rVV?=
 =?us-ascii?Q?MZJy0bS0yY3cykRQw0C7svYKz9UrqMsYnrli+HiNn17QAGtSTs3XCSIpgW0j?=
 =?us-ascii?Q?2DPr8ZccS2nfZkZ5FoEBuCm1QE+2NOOEf8zYj6EDcerFNAmgcCtjewam86C3?=
 =?us-ascii?Q?VFtpoBwhCNnIUoz3mbmYxkx3TY+M6LCCaHBezXrZrAzcejIp78N+aRh9Gz30?=
 =?us-ascii?Q?YVNX0+0RkkvCl0TW/Kg1LJyuhPvXy+rD13vpaA1K0QzZIktRtj4/aPVXhqJ/?=
 =?us-ascii?Q?YRMSp2CVLCIEZIidWoVxoYxPKV7m4BBD7Iz2vuOaPywQqelGY6OFp86wvK+Z?=
 =?us-ascii?Q?3b6Gg390BtKasAeVYHLdBFZOH7+mYKGj6t1Jf1z7/KWE8wg/POigvxKWO2cB?=
 =?us-ascii?Q?hZd8UO9Nwn3/sC7wPEsk2Z+805TLf4vTXBT9xWFXC7Y2sV+GcKVWhMBX/6bG?=
 =?us-ascii?Q?eCmpfto/AjavljhK6YDsCn0hRybohS3rWbRaLV1b4js8h0N23bNMtzY7KrXL?=
 =?us-ascii?Q?WnoApQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sOCsi/TUoMqYC9aBZ3eplSHu8BvJPY39y8be/Uk8faPciMPcLLaXF3qBFHQjOb6e5XnoUFfoVOZwVtmWOWeSOW+2oWi+xrxBqx+bY7KJtpQuybfzJCZL9NNA5NcwJO/9l4REKK9dJCxgZZUmw4Fsmvwm3V9wVBw/3d2FrcQUYpqJo5d4z16z0CskfsAvUk3SjnEW16WyFy0Vd0Dig+gDa91KgREmUES0mx/j2ZM0tQfnNeT9Xz7tGDjWpHLxSZu3gJ8VqSq6YSz+GmO9V3XqGwLfi2aQDBW+KQWNeu0OdV8c1cGZXm8W+d7GRBInc8Gde+o+OvQSfNdY1eWyFBdoZaMwqX6rlg7T8+Vkk6s3XizFoSL1BoytJF/sS7nfThtKceGWFUp+s5pb88zXUIyNa8c5Yt3+GQVmwvqRRGmcTFAQjQOodMu9LWUuQosezR74
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:43.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef6d4e6-7a7c-4e08-5fb9-08de5fa79143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
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

add initialization func for pmfw eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c    | 15 +++-
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 84 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 3 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index fe188a5304d9..1eba279a020b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -387,7 +387,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 
 	ras_fw_init_feature_flags(ras_core);
 
-	ret = ras_eeprom_hw_init(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ret = ras_fw_eeprom_hw_init(ras_core);
+	else
+		ret = ras_eeprom_hw_init(ras_core);
 	if (ret)
 		goto init_err6;
 
@@ -411,7 +414,10 @@ int ras_core_hw_init(struct ras_core_context *ras_core)
 	return 0;
 
 init_err7:
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 init_err6:
 	ras_gfx_hw_fini(ras_core);
 init_err5:
@@ -432,7 +438,10 @@ int ras_core_hw_fini(struct ras_core_context *ras_core)
 	ras_core->is_initialized = false;
 
 	ras_process_fini(ras_core);
-	ras_eeprom_hw_fini(ras_core);
+	if (ras_fw_eeprom_supported(ras_core))
+		ras_fw_eeprom_hw_fini(ras_core);
+	else
+		ras_eeprom_hw_fini(ras_core);
 	ras_gfx_hw_fini(ras_core);
 	ras_nbio_hw_fini(ras_core);
 	ras_umc_hw_fini(ras_core);
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 4a1b966d22fa..4362b8a0f3c4 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -369,3 +369,87 @@ int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 
 	return ret;
 }
+
+static int __check_ras_fw_table_status(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	uint64_t local_time;
+	int res;
+
+	mutex_init(&control->ras_tbl_mutex);
+
+	res = ras_fw_get_table_version(ras_core, &(control->version));
+	if (res)
+		return res;
+
+	res = ras_fw_get_badpage_count(ras_core, &(control->ras_num_recs), 100);
+	if (res)
+		return res;
+
+	local_time = (uint64_t)ktime_get_real_seconds();
+	res = ras_fw_set_timestamp(ras_core, local_time);
+	if (res)
+		return res;
+
+	control->ras_max_record_count = 4000;
+
+
+	if (control->ras_num_recs > control->ras_max_record_count) {
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS header invalid, records in header: %u max allowed :%u",
+			control->ras_num_recs, control->ras_max_record_count);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+	struct ras_eeprom_config *eeprom_cfg;
+	struct ras_mp1 *mp1;
+	const struct ras_mp1_sys_func *sys_func;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	mp1 = &ras_core->ras_mp1;
+	sys_func = mp1->sys_func;
+
+	if (!sys_func || !sys_func->mp1_send_eeprom_msg)
+		return -EINVAL;
+
+	ras_core->is_rma = false;
+
+	control = &ras_core->ras_fw_eeprom;
+
+	memset(control, 0, sizeof(*control));
+
+	eeprom_cfg = &ras_core->config->eeprom_cfg;
+	control->record_threshold_config =
+		eeprom_cfg->eeprom_record_threshold_config;
+
+	control->record_threshold_count = 4000;
+	if (eeprom_cfg->eeprom_record_threshold_count <
+		control->record_threshold_count)
+		control->record_threshold_count =
+			eeprom_cfg->eeprom_record_threshold_count;
+
+	control->update_channel_flag = false;
+
+	return __check_ras_fw_table_status(ras_core);
+}
+
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_fw_eeprom_control *control;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	control = &ras_core->ras_fw_eeprom;
+	mutex_destroy(&control->ras_tbl_mutex);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 18d6548e2151..cb92e6a63cf5 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -77,5 +77,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
 int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
 				struct ras_bank_ecc *ras_ecc);
+int ras_fw_eeprom_hw_init(struct ras_core_context *ras_core);
+int ras_fw_eeprom_hw_fini(struct ras_core_context *ras_core);
 
 #endif
-- 
2.34.1

