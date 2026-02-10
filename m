Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F86BEA3F2A
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 09:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B641510E52F;
	Tue, 10 Feb 2026 09:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZkrlxLBb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0A910E52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 09:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbzQo6958anUYvsgjSDbd+0/W7Om7EKX8nGzfvmWAcMkKNjfoc29Sod6Pcs+S5Yd8CLGwghM77vpNHPyVPpVdTj8YoHu61y9faDTOAurMFHfX+iA2WqlQ3nhRnIUbw5vXYvpEpBOBDTfI3tvp/9phFimxVrybcAto7gJ/iyWBsZkQfWWtjLKcKIBfrUBYuCh8Jf5TDhb2IpZiJfJTrp0V7mvxXSmSoJ+k+IJ1jbsG7bfnhoLNpWRuFdrS4ptWw1Cc9n1DIrypAsQnoA4nFgBJAlPjmJthyq1aWarfq1/7VDitVYPgTQfLX0by8CHAiG/G1EttUsWSwOKk6JqGVht/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXRyIsnJYBE6irm/WXA54+DkCT4ezZMzVHhgcaAfhXc=;
 b=QfPC5OfYfP18M9AQSaHmAS7FsC/ubp7nqh+ooG1BqcW16QLlgJbyWsK5xNFJssCalhLO8OOONe31Uo5IgyxOKQ2SqG3u9KfymMUC6chVQqLJDbm4LzpUWbS74QtL4pLYb6HLiqZb2kAtCrP1Hjk9Sl4MWYDieFryy3T7PX9JdnmyTeRY2jfpzwvbL7fx97Vp8tHAsNm6XQOhh17h6yHLzwXtGHSVViqpjJ8629rKTOA8XOrdx5vvJfLFBvzLwl6Kuzlj/qn8RHVRjnLZQNHiHkvqx9CCpV3SXY0Oy0PAF+qn0A+VS3yySLKPQSUHrFzEP3Xl3VuBYwIF77xuvTIehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXRyIsnJYBE6irm/WXA54+DkCT4ezZMzVHhgcaAfhXc=;
 b=ZkrlxLBbqPAljU4zVsogA3+QPkJetlrw091m/ppVHqcLaSyDuZHV6kW3hngp/sKfX1W3wpwn2olLAI/oS1GaijWKgetnxDQHaJYTcFEZqmDFJE5a+fWSCN2QmAIEgt7ajdd7AFsxnbhcg1dhsFWTMym+e+fAJ534A/pwWJ2Qchg=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Tue, 10 Feb
 2026 09:52:54 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::e) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 09:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:52:54 +0000
Received: from jenkins-joe.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 03:52:52 -0600
From: Jinzhou Su <jinzhou.su@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <tao.zhou1@amd.com>, Jinzhou Su <jinzhou.su@amd.com>
Subject: [PATCH 2/5] drm/amd/ras: Add convert retired address structure
Date: Tue, 10 Feb 2026 17:52:30 +0800
Message-ID: <20260210095233.3078476-2-jinzhou.su@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210095233.3078476-1-jinzhou.su@amd.com>
References: <20260210095233.3078476-1-jinzhou.su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: a621c9f8-f519-4ff6-eb07-08de688a2949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pNd8KfoTC1nZ2xbSn2/sTT6gQx6S1WEs6Clu1tlJBCGEMWSaJF2pje/1TaFY?=
 =?us-ascii?Q?oHn/Cywv5gDj84YUD6w7hvVpwVHVdqcWlt5drfkZN0vzOX/iOTA7J6K/DZFD?=
 =?us-ascii?Q?pNIaSHqB+/f2xaUWjRlIB89TUMOicXhaS7mswkWJagNYI3rKOuBno17HRaBf?=
 =?us-ascii?Q?XPG8TQl4hrXjU41Re0Srp1M3X61H7UrAjI/fVlSrbXj/0sJx2/MAeO1wQNs6?=
 =?us-ascii?Q?OTunTTZhub74QgV5RuqrtH2rVy2bl9dWsl2b7Q3eUmr8AvUin10SS/yomjOh?=
 =?us-ascii?Q?+dzIGTR+TZcHHXtsuVMf5FdU4Cp/zBznyRRdobUoUsLp1IaujT73w+ssxt3k?=
 =?us-ascii?Q?mqXXOrEtbCt6Kdpwi2sD3QSK2sSDahQ4h8GG46PF+bnX6tds8xoOkb4H3XMB?=
 =?us-ascii?Q?7Eu6XfeNTzlfcLE/8Day9+YZJh3W4HvntbzfUlrMO8k/OfO68crqRgPEraVK?=
 =?us-ascii?Q?oZGr2y1wjnXPSB7/gzn2LpOISdkPByQ5DVdpJ2UDiFE084nGaYL/VMP3dxOW?=
 =?us-ascii?Q?zcTJC3Bv4mRpHpUwNA0I2/djLStsjV9spUf041pZ0QDiqxRtLqQDd+JT2crZ?=
 =?us-ascii?Q?ZNtsRkCvNAQykTNDZnLnXJNG2xtfIt3snO73NyfcFNMGuadz/c3w7sC5LVFT?=
 =?us-ascii?Q?rvVGICuYsWFv/3NkA2+fWdo7j+yiWUZN5lmBA9u/T9hMSuAMS/+axauQ6HaT?=
 =?us-ascii?Q?L/XmY+TrZlM7a5xciKl4vxMBP4KndNh5XW2ONT4ydVe+WVo6TCUgcDtVBbit?=
 =?us-ascii?Q?/bh8m6KNUMKF6CcjkmwSSqfb2wQUPoSYhgtct7nhcPlSHTyq3GLOt/Jm5Vog?=
 =?us-ascii?Q?3y93pDrAKuT9BwA/dppAkmd2iqYPn6e4980Xij+3gb+Enl4Ag9DwD0v/KmYn?=
 =?us-ascii?Q?POosu/ZoI9IcqHzmiIEsDtLnhSn/BB3/5soIu2c9mh0rn8Tt/eXwsYrMARpn?=
 =?us-ascii?Q?CWtr2TRpDbm29HKCLuRd70QxImPgrHXkwiZ3o7hTuVmiul+yfHrdKu0LGQxQ?=
 =?us-ascii?Q?3BT1AJifV79h8WTELMGtpb0Mz7wWwDRkVtxEujuvQBvUOM4GH3p+cwi5q34d?=
 =?us-ascii?Q?FAObHcb16vfWcB3hdCzyt/ufREBQATLJNJVlwvh8qCDArWrewO9bG5JOM6Vc?=
 =?us-ascii?Q?7MGWcyIunLxdeoq/nCOm1qBQR7vklY1IzpeNixGyc0MS/zfa6sTXQhvnVHQN?=
 =?us-ascii?Q?Da5vKVPHh+N8+BGmn7hDwBImoWxox4wG4s9L2rG0YFvOwkKcfOl/xx1oS97o?=
 =?us-ascii?Q?+6TO7ygD0lDMUlITdnvgVyQP1MeWCnuGZVqaKEpWxQShECObC5kz72wbA8o/?=
 =?us-ascii?Q?v0FO2HUolFQAAzC0E7V9DnD/ComH9W3fdSAApOhykezr3bbaKTgiXdhDLdMe?=
 =?us-ascii?Q?hG/JNSinlEcepQGCcflsvaK7DhVNMevnRX41MJm9xW6cHqWJpxHvnLU9b/9I?=
 =?us-ascii?Q?fcSf8kVSGNPdOhEOlvV6UndZgnWYwu22usHhq5f1gmPg3c/b/L3v3TE+yP6F?=
 =?us-ascii?Q?fS8GhOiaO12iU8yLtHJxPcsqVVQOaFOwMbjDcZiJB8cDQMgQdi05q1FO2znk?=
 =?us-ascii?Q?DcsYGmzp/KIveSC1fhl5bTDFgBW5jbpy8MiBGJrIB/OydvIQreOev7YUg+rd?=
 =?us-ascii?Q?+BngsLE2oQmcx0i3VThvbnEH4elG1CtrMXD6lxA+yI7+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fi19bddOAruz09kUJNx2JFRmm1cdl75fVZcva8zJzmuXR8BXF0Wyqb29Hbo8hBPb8AMA2bqvnuOWCaaSmfSNek7huFumxwC8jmaHRs3vG7TQn5ma4TCxFfUzqSzPFO+aVyGhCz5szLqVxU/5BXq4x0Zv5a7/PiF2w8jrQGr6B3i3AzAgBjmoexHjnqQ3U27Au8IQIVUHlkIqrDtUQl1/6LppCrl1Gyw82gunqVrCMmU7gcZmJ2qPzbo7uPYc2o3SkzzIcc2UYS/kX7fGye7YLJazMZqpFrIjblJklYzac6Xeh+HueaK2XD/NnumDQPgfde+tmePg2RZo173+aiVNvB835GeIwJbSsqfUTOZT5+ZBaWgxPJBb9n21L8y3clDWSTvHk2niFvW9YqgTWUhMX9hUUsmUtLqyzowtrCkTGTAc2e3CmrKw0iuwm+p19MdP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:52:54.0263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a621c9f8-f519-4ff6-eb07-08de688a2949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

Add convert retired address command and structure
for uniras.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_cmd.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
index 32b48023fdbc..7ea35a028987 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_cmd.h
@@ -78,6 +78,7 @@ enum ras_cmd_id {
 	RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
 	RAS_CMD__SET_CMD_AUTO_UPDATE,
 	RAS_CMD__CHECK_ADDRESS_VALIDITY,
+	RAS_CMD__CONVERT_RETIRED_ADDRESS,
 	RAS_CMD__SUPPORTED_MAX = RAS_CMD_ID_COMMON_END,
 };
 
@@ -442,6 +443,19 @@ struct ras_cmd_address_check_rsp {
 	uint32_t reserved[6];
 };
 
+struct ras_cmd_convert_retired_address_req {
+	struct ras_cmd_dev_handle dev;
+	uint64_t address;
+	uint32_t reserved[6];
+};
+
+#define RAS_CMD_MAX_RETIRED_ADDR_COUNT  32
+struct ras_cmd_convert_retired_address_rsp {
+	uint32_t version;
+	uint32_t retired_count;
+	uint64_t retired_addr[RAS_CMD_MAX_RETIRED_ADDR_COUNT];
+};
+
 struct ras_cmd_blocks_ecc_req {
 	struct ras_cmd_dev_handle dev;
 };
-- 
2.43.0

