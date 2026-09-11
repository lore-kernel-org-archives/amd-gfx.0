Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1F9C79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E074D10F4EB;
	Fri, 11 Sep 2026 06:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CA+gFibF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD1A10F4EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7ni+v5yFR9w7iHW6OFq/Xb7chgeLrqYbxpGB3wCZqV3IIynYhbY1zb/arVFizWEuryZtDoAT33NfEJ2l/iqja7k+8XEDe9tXq0PdW4PhJIVYCYv46L+hWP5WQeeKtLwKfd4LQKLJqfuIb2JNFgb9HhEOYabWLcxVYkJXKlgm60fO5lK78S6ZRmAKtpMp5ZpbLXoT3SH7A8UOeQkbPa/Q5HwOw5c0s/4anZSlzbkW/99WLmHwXsCp1qIPVWJmNDm5BsJbuimzT0dq14gCJ55qODi3vDYCTcp49st78CkweP87D0XxNYC4oXzlt4Qvw2j04vV+jRsdYjwR7o+7xplVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LIM8OeIWKJkH/9Ya5UzCmwKmeroWt2MwJYegT3mGWs=;
 b=EvLUlQpcUyLE+5+7judmST//WJhHxSODTauETzBhPyI1OzoUkuQ9lOfi41UnTikDWg0tGgs+3Iqg5yY/f3pgjn6SgxYZQlq68mcu6oU5qy1cnQkx8u1YaWqEqO++/KWeptRIQbr3SXIfTLBT4+2ibqiTYgwY4RcD0TqYg2TzvIVOFa0EBb0e5Od6ACu2sia8V65Y7QMZMhjjRh3CMwA488Pxy/rMOMPGR5Np+MRo6UxpLBsnVKhjLtvC/V7TPuqLyddQxCBGfOl8cMRnrZ35vsKnrjqJb7kIFDi6qYJiS0Ci3G/CLFqzG+WCJuwwop7diuuTQoh7sWM/+sH9Uhgf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LIM8OeIWKJkH/9Ya5UzCmwKmeroWt2MwJYegT3mGWs=;
 b=CA+gFibFugS5t9ZvPvUh+Jpc/6zmsq760+k1sRhuPkTLEPD3NiWX6xSDcwovZH4HpVhyTFEciy8PlQsMgLz+ZWQjAi2f+CTbIjAjVffn3o6Oq+88rx9N/KsVXsw8XGLH2I5/WjU/h9YI4RC13hKZO41Q97WBTIvem2y75lHPFcs=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:46:04 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::97) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 06:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:04 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:02 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 2/6] drm/amd/ras: add pmfw-managed eeprom support for mp1_v13_0
Date: Fri, 11 Sep 2026 14:44:06 +0800
Message-ID: <20260911064410.1693567-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: c15bfc3b-9090-4181-522b-08df0fd059e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|6133799003|3023799007|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: dCZN6TyZy8RvIu/z6kMG4gJRnzmqhvWYAXtT+4VoiMprEuO45ufyAr56j2YQ3126FD8jwgD6f572NM3zwivL8G1t1qxxP067BNH8uWznSMXiZm8qpW0PzV4Kjhmpl3rUWNhzA544cdNVv+n0h0HOv+YyV099nnxGZB8OGh+n8GHFOLY6zP4UsOCyWh3QjbesDBYxRohcoEDxG5vLOPct1/DsmwAxFHFo/o5zCiOeOkrHQ/t6ofsVCib5QWfvc76kBl8YZzBTZd9cMjqgfv1WVfgZS/5XIkdnPC4iyNkCjxtoifGYkWys63crCv1/cP3/e5tdX5FwYB1GpB4B+JwnH0vv6ooruAgFlekBfc3UlSpFUSdBT5HsbSsZGfXfp4o0uxUJdQgjWx/YSmZfCeJ34GIvh4UHbmFdOLBNO2vKW+tIV+bkBojs7xckgGB5K1SQwfNRssHFcXZOKYj6DtC08e/drFVV6xIwiKAAz9PUbOma6gc3TIzwwVQRGmjOljHfK24LXj8VHFcAMSnCp8Q2YYqcf0GhkLEoKamVpa9/IMNZWtmPGiIT169RSFbmyE1rp+rOypqFESn5y7woeg23j+05gygMIKROosqUUmBUl4No4ysCzaCEaP++4ouZhOVJPAAYj1yuFR2WjN2lxceu1Zn2jl7dQ6/C2KwTs6P8hyB0iaKn49dZQXYdx7ToNxTnNvNDboFlqeNDb0ZDiO2kaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7L1VMfYbTwrXNivMBzPD4bZyZlzBsA7yQlaD6YYtNccZIoJbB+7WztH0YgpYOc5MPeKvu7x1QZXPh5gcfqd5GaaEL7Ijs7NAaYOPofDWSr9dirL6VJEKMqBO63zEtVDn1U3qYu5pl+IwRV8jdvgZe2bF7OKoq2nFuSaCecIEvKpElZR71w2OpI1nEilCRtqMDNXSdGNrwmpv9JjjRyX5ozw7EfXSCc9aJ0IM/IdzqhyQvMK3C2ePQiLGCy/zW5fwgWj+zH6hlEkZzBBc4kOCk5k2GKVlO0/l4V0PA4A96HNp86MHJfolpoAyuj+DXM9TKh8Z+egI2oCxcvjz+vDvu+2eX2UO0wkfGkeeJL6U4i121NaWeil1EKks6RBngmntJ21YeP1QDH6p21SPTwY7hwgGWSVfNdk04749K7JdwTSv7/lnTT8yJ2ABDrLKqj93
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:04.5597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15bfc3b-9090-4181-522b-08df0fd059e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

Add pmfw-managed eeprom support for mp1_v13_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1.h       | 26 +++++-
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c | 89 ++++++++++++++++++++
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 81d5f1eed676..410530fb8ada 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -48,9 +48,29 @@ enum ras_mp1_msg_id {
 };
 
 struct eeprom_err_record {
-	u64 timestamp;
-	u64 mca_addr;
-	u64 ipid;
+	union {
+		struct {
+			u32 timestamp_low;
+			u32 timestamp_high;
+		};
+		u64 timestamp;
+	};
+
+	union {
+		struct {
+			u32 mca_addr_low;
+			u32 mca_addr_high;
+		};
+		u64 mca_addr;
+	};
+
+	union {
+		struct {
+			u32 ipid_low;
+			u32 ipid_high;
+		};
+		u64 ipid;
+	};
 };
 
 enum ras_err_type;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
index bdedaadd85b3..a450e79a55ff 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
@@ -37,6 +37,89 @@ static int __send_mp1_msg32(struct ras_core_context *ras_core,
 				msg_id, &input, 1, output, output ? 1 : 0);
 }
 
+static int mp1_v13_0_get_table_version(struct ras_core_context *ras_core,
+				     u32 *table_ver)
+{
+	if (!table_ver)
+		return -EINVAL;
+
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetRasTableVersion,
+			0, table_ver);
+}
+
+static bool mp1_v13_0_rma_detected(struct ras_core_context *ras_core)
+{
+	u32 rma = 0;
+
+	if (__send_mp1_msg32(ras_core, RAS_MP1_MSG_GetRmaStatus, 0, &rma))
+		return false;
+
+	return rma;
+}
+
+static int mp1_v13_0_set_timestamp(struct ras_core_context *ras_core,
+			u64 timestamp)
+{
+	if (!timestamp)
+		return -EINVAL;
+
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_SetTimestamp, (u32)timestamp, NULL);
+}
+
+static int mp1_v13_0_reset_ras_table(struct ras_core_context *ras_core,
+				   u32 *result)
+{
+	if (!result)
+		return -EINVAL;
+
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_EraseRasTable, 0, result);
+}
+
+static int mp1_v13_0_get_record_count(struct ras_core_context *ras_core,
+				u32 *count)
+{
+	if (!count)
+		return -EINVAL;
+
+	*count = 0;
+
+	return __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageCount, 0, count);
+}
+
+static int mp1_v13_0_get_record(struct ras_core_context *ras_core,
+			u32 idx, struct eeprom_err_record *rec)
+{
+	int ret;
+
+	if (!rec || (idx > 0xFFFFU))
+		return -EINVAL;
+
+	ret = __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetTimestamp,
+			idx, &rec->timestamp_low);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
+			MSG_DATA_LOW32(idx), &rec->mca_addr_low);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageMcaAddr,
+			MSG_DATA_HIGH32(idx), &rec->mca_addr_high);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageIpId,
+			MSG_DATA_LOW32(idx), &rec->ipid_low);
+	if (ret)
+		return ret;
+
+	ret = __send_mp1_msg32(ras_core, RAS_MP1_MSG_GetBadPageIpId,
+			MSG_DATA_HIGH32(idx), &rec->ipid_high);
+
+	return ret;
+}
+
 static int __dump_mp1_bank_reg64(struct ras_core_context *ras_core,
 				     u32 msg, u32 idx, u32 reg_idx, u64 *val)
 {
@@ -144,4 +227,10 @@ const struct ras_mp1_ip_func mp1_ras_func_v13_0 = {
 	.get_valid_bank_count = mp1_v13_0_get_bank_count,
 	.dump_valid_bank = mp1_v13_0_dump_bank,
 	.set_debug_mode = mp1_v13_0_set_debug_mode,
+	.get_table_version = mp1_v13_0_get_table_version,
+	.rma_detected = mp1_v13_0_rma_detected,
+	.set_timestamp = mp1_v13_0_set_timestamp,
+	.reset_ras_table = mp1_v13_0_reset_ras_table,
+	.get_record_count = mp1_v13_0_get_record_count,
+	.get_record = mp1_v13_0_get_record,
 };
-- 
2.43.0

