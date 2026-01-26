Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC3C88E42
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 03:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E9610E391;
	Mon, 26 Jan 2026 03:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gNKn1VtV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D63C10E390
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 03:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI7AJcVUJboQ5Awx+u7Je2MdfaCHGbfY4mXE8+s2sg0g9H3HUxFh4+xjYsM0nx0CVUh2zja+QF86CV/aS6UQPjPTShtBjgjReOPbyukBe+ahyU7p2C9aULwC68y3/A5MpTrStcFbXp4IQgKN7Rsb8u23qbSPkXlOJykGw7kkRs/1yjDxKcOgtWYTmJqq/kkwwvkwu4I/wAluMz16eSUFjRwciKXTYjJWsBO4foajjN0KiHW4yZkEvC+2jE37T2R+bDXMtWfYVNG2pckeevkbIhZBHH9N0OY2hBhZpCLSuTGIakO8zjULY18HXKLQ9dRXHHlgOR7YakFb4lm0+QTLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fxJiREW6YHJ75ZiQY4VnD7B/S7c5H1QR7qAmchdM4Y=;
 b=X75BfYTVcgxmG05UvMfsHKzeVF9XKBbOftQJNchY/P8noKIBcjZpm0mHhcxTDE64yVgqlsBJRyJseiZ05rRdcWkOzofgFmF/2QQW+q1LwuM6JZ2fcXa1b0xGyQf3sI9AvlhvI5SIEMVRTf+ZUPFMV4WVH5pNrMeOIMSfvSHTa1rQD2boaATbNRsCgsGD0ggqt6ZjpFdlw2GTljgR10QVwGrsX4wV0+BM8Q2DZWrrrwl59fhCPFseXD22WnHuiAl5/xy9LlKeWhVb1beKAAQ0MZmRBPVaKHXMGspdynCo59Ywf5Ovp968sw9aXQPKbhTKOuUgbygAGX1ngw3kwK3jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fxJiREW6YHJ75ZiQY4VnD7B/S7c5H1QR7qAmchdM4Y=;
 b=gNKn1VtVdRR83e1L1XESjYb/C9R87OPLriSlhdb0ZfnyevXBGC/fEDl8Y+ZL1QzgryqVRmctxG9mdqf5nRoH+LHCj/PA8fQ7t894Ocsddh7u0Ckx8cTWm0IDhaiuu6K3l+khd0fuH2TEfLSpHB+QV6vB+6o8YIcLiuAgUCS2Dh0=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 03:55:55 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::cf) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 03:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 03:55:54 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 25 Jan 2026 21:55:53 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 05/14] drm/amd/ras: add wrapper funcs for pmfw eeprom
Date: Mon, 26 Jan 2026 11:55:18 +0800
Message-ID: <20260126035527.1108488-5-ganglxie@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 171c531b-1c24-4b45-21dd-08de5c8ece56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEJV+gUq4ZiSltPdS8qLd2j00JtuS7xzZBHdNKLpbXcyJhZUaCTa0Qx/rFxh?=
 =?us-ascii?Q?3knyawS7tvrZc+YYW8kECInmsBBBkqD/rL/MfmtbU7fF1i20VrTaYgOjlBRT?=
 =?us-ascii?Q?Guu7Xhgpg96GAJY/DfRcMhLVB7eJhNGx4G3Ayfm6sLTz5DEwPgySnxEF9BrA?=
 =?us-ascii?Q?1Gk0ZKszR1LrPXBbC3D9jt0Lf1Wb5nT7crz4kbFeh6lImVQDvAzfGm0LS+cf?=
 =?us-ascii?Q?Dqk1J0v0pBjH89RdlcH4EAe1nYP3kHBzqsOfWeoyExNblCcuRzZR+U/YXKVk?=
 =?us-ascii?Q?KwdhJpjxFjjxIQWE9IZvNRfa8jZfjNNrYZKBI+B7/9n3XTxTxiU/08wzn+98?=
 =?us-ascii?Q?RUsm2RWobEKILg1obnXLl3Ee1to66egThsZR6yV0MkqcPN3RPuUpXaTNHTjW?=
 =?us-ascii?Q?NqZ/207ypDPFjIs6vZlAPYbFxpcqcrWTGMXX0RARjOLx/deL1Hgkh7mDzaX1?=
 =?us-ascii?Q?+j7SG9KzdR/AZHEbUXJ7HzHXfo4VxpxApquDKZynZqCCWLJ1R9YxYp/Lz96j?=
 =?us-ascii?Q?8blie8mEwDdebWvuPKLo/VmQqZXPzSZ62ciBZsSssofG5wNODL1r/Zsjdted?=
 =?us-ascii?Q?UTD51L79hzhiG2u0dPTvhayDGigv8mm1cRNJ5DHw16rL4tLYLvYFW0bFPdIY?=
 =?us-ascii?Q?xynwhIReZhHC3bTosVgh6f8GztCXifliazUNQGq6rq1G/9lBCYaGsXKur30b?=
 =?us-ascii?Q?lhRWnkyFqKxZlHbXtEq2gTWlJgv7Oklake8cSE/sd27Ol9E2ibOSNBK6WcyR?=
 =?us-ascii?Q?ihk5+YHPu9UP9svC3UYchJ+nbnSEuMj8dLCyud2RAVuRukH23OwuQ19M7VW0?=
 =?us-ascii?Q?zt6MRp2HfHTDKLbmvkxNF9cO2pD/ALmVibZAdc1885WQtZzE/YOi6RPU1xqY?=
 =?us-ascii?Q?k7RG6DuEruiedmvn3j02ZCjoPFjiyR2PdOOx2jFGSCEq6QwIj9OG5YpnMmHV?=
 =?us-ascii?Q?Q94NaoglY9DfhhJLfynlu0rH3n7IGH9idhBQDdYkf4xgGh7ojkt+nUe9KQVB?=
 =?us-ascii?Q?CmoGT2iWRxmt1XJVqHo+zN3OtyQWsrUHXTq2Np/PgLEuMLQGtzZklnjvrWu7?=
 =?us-ascii?Q?wf6QFQCa8ahNyp9jEd27MPNjU9mo4sna+Lo4TPxVcerbFV2rYdOzkLdeAQnB?=
 =?us-ascii?Q?TCClrQUXZoRdDJ0BcjfqEzNhmwl647X77UBH+Ln7fdaMbfTWQmtLrvNwVFwT?=
 =?us-ascii?Q?93A5MxNfYLrQqb4NeRfuCMEKtIVWASqDr/Ixe7OtewnVwSVpEBhXYSmHBnOh?=
 =?us-ascii?Q?Usym+Hz+lnQ/fW/WelSzmiOADVUDOFbbKRt2917q3CdJXYW9P7fNlY2E65nT?=
 =?us-ascii?Q?iXTEGcNrLfsTeEMK3z/cbPzVRIvufIv3zz96U5/gB/eLeWcNQhqfq0enEzKU?=
 =?us-ascii?Q?doWDYEcVaeEnudANVZFcEBomOnbFumfszLsIEji+nwIW8MuC/5CgspSD2wT8?=
 =?us-ascii?Q?dLESnUP0w3NiorTPmtybohceHdL/Rw6gJeJo/rgrRvE8Dbt1AF/LmxEsw2y1?=
 =?us-ascii?Q?a8xN+02aJxzGH1sJTQkORCuS1gEulJ2+SYjqjfh9OhS5N0M37g0RPeASmTUi?=
 =?us-ascii?Q?FrypRUA2USKFqrgEtwKyc9cgNNImj23VlzPe13Z2rEewc1TAleZWPZAXPnoT?=
 =?us-ascii?Q?SDzUwF4HMiVnOu7KVFpNnkI4xa1vxUDU9e2817y3NCQ8TKCg96PpDPF3ksPb?=
 =?us-ascii?Q?9QTSFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 03:55:54.9258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171c531b-1c24-4b45-21dd-08de5c8ece56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

add wrapper funcs for pmfw eeprom interface to make them
easier to be called

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 125 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  16 +++
 2 files changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 4a65351569e8..5231dfe8c518 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -36,3 +36,128 @@ void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
 	if (!sys_func->mp1_get_ras_enabled_mask(ras_core, &flags))
 		ras_core->ras_fw_features = flags;
 }
+
+bool ras_fw_eeprom_supported(struct ras_core_context *ras_core)
+{
+	return !!(ras_core->ras_fw_features & RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM);
+}
+
+int ras_fw_get_table_version(struct ras_core_context *ras_core,
+				     uint32_t *table_version)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+				RAS_SMU_GetRASTableVersion, 0, table_version);
+}
+
+int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
+				     uint32_t *count, uint32_t timeout)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint64_t end, now;
+	int ret = 0;
+
+	now = (uint64_t)ktime_to_ms(ktime_get());
+	end = now + timeout;
+
+	do {
+		ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageCount, 0, count);
+		/* eeprom is not ready */
+		if (ret != -EBUSY)
+			return ret;
+
+		mdelay(10);
+		now = (uint64_t)ktime_to_ms(ktime_get());
+	} while (now < end);
+
+	RAS_DEV_ERR(ras_core->dev,
+			"smu get bad page count timeout!\n");
+	return ret;
+}
+
+int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
+					uint16_t index, uint64_t *mca_addr)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
+
+	if (!ret)
+		*mca_addr = (uint64_t)temp_addr_high << 32 | temp_addr_lo;
+
+	return ret;
+}
+
+int ras_fw_set_timestamp(struct ras_core_context *ras_core,
+				 uint64_t timestamp)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_SetTimestamp, (uint32_t)timestamp, 0);
+}
+
+int ras_fw_get_timestamp(struct ras_core_context *ras_core,
+				 uint16_t index, uint64_t *timestamp)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp = 0;
+	int ret;
+
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetTimestamp, 0, &temp);
+	if (!ret)
+		*timestamp = temp;
+
+	return ret;
+}
+
+int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
+				    uint16_t index, uint64_t *ipid)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
+	int ret;
+
+	temp_arg = index | (1 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_lo);
+	if (ret)
+		return ret;
+
+	temp_arg = index | (2 << 16);
+	ret = sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_GetBadPageIpid, temp_arg, &temp_ipid_high);
+	if (!ret)
+		*ipid = (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
+
+	return ret;
+}
+
+int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
+				   uint32_t *result)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+
+	return sys_func->mp1_send_eeprom_msg(ras_core,
+			RAS_SMU_EraseRasTable, 0, result);
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 58472e459470..ad98077d532e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -24,6 +24,22 @@
 #ifndef __RAS_EEPROM_FW_H__
 #define __RAS_EEPROM_FW_H__
 
+
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core);
+bool ras_fw_eeprom_supported(struct ras_core_context *ras_core);
+int ras_fw_get_table_version(struct ras_core_context *ras_core,
+				     uint32_t *table_version);
+int ras_fw_get_badpage_count(struct ras_core_context *ras_core,
+				     uint32_t *count, uint32_t timeout);
+int ras_fw_get_badpage_mca_addr(struct ras_core_context *ras_core,
+					uint16_t index, uint64_t *mca_addr);
+int ras_fw_set_timestamp(struct ras_core_context *ras_core,
+				 uint64_t timestamp);
+int ras_fw_get_timestamp(struct ras_core_context *ras_core,
+				 uint16_t index, uint64_t *timestamp);
+int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
+				    uint16_t index, uint64_t *ipid);
+int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
+				   uint32_t *result);
 
 #endif
-- 
2.34.1

