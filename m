Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D69C48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A341613E1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A341613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED19E6EDA3;
	Thu, 10 Jun 2021 16:29:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F48D6EDA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9N4FvsQkxvgt4iIMl3Mu3Pq3AlB+Savpn/8/aH88rPn5PugaqVUyUoZ6OToGgBz2rwsAx4MptYPgop8u0CClPXu1sODrJGirzDS0QhjYQL8V3H3YFjlvX+a6rcUJrNi6pHKBb9yuy5oC/Bb32aeZ2hRzwOIDiR0TZjlvC7+SSyiFzC4iBInK2Yh17LtxHR4+jyIko8HnfE5cPDch7lG0aAz9L0KLbXuJ5IWC0a5vE5YrGmly9KxT7o+IIYqMxmfDi4cqaxk29x+x4dWphCHLEjjoNKwCPHC+2E4ZEnF8vj42vS4cl2eG4T2RlK/43cSL05Fe4HLsTirqEVOs5Ba/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1Oa67xoqZkmIUtGIZiK/0/KMjsRV89OfJuG1s06iIc=;
 b=YNiPSXPA//CbVwXzLXH3tUXB3+kAQt+inCxxgq7Cvi2hosgzGJFSCwwfZ3wz361kR+syMhuG7ArAEOYrnpRInkaaAG12z+cAlioZzyBz+PZ9WLdhIgsH34bWprL/QSeu2BvaIltWM+NEqZzeDq+nqeXKu67GU/uWFFUpyBS80zm8k8Wrg88y+mowqp3m/3yPiVC7TzjKTylUvDol7cYPWpdIDF/GyXGNEBoHCfS4D0euQrR/5IZRHaN/gaGyeylqrLt4owr40O04doZJx0KhHfQUaQUdz/1Ojycq6KeZ1+YIrElME01JAlp3LtgUidc1IMjWBs3/nPbvaNVWPl+2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1Oa67xoqZkmIUtGIZiK/0/KMjsRV89OfJuG1s06iIc=;
 b=xZH/ahC2j0JLpltVJg7I3c+M9ucrd6E8MB7IwoTwHOQLtT+mYRYGNxiIy3wlYfUML5DDn0KP+8sprmPwBTEpnJU1+iyoAHjc4riJUbIe/fN1bKiLzfFuFMNf+vAaTzlczlB6uneIs82u6iZdlNv8TSUZ43O6rbqvJNBEPh0yoEU=
Received: from MWHPR15CA0056.namprd15.prod.outlook.com (2603:10b6:301:4c::18)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 16:29:42 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::f2) by MWHPR15CA0056.outlook.office365.com
 (2603:10b6:301:4c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:40 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:39 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/24] drm/amd/display: Partition DPCD address space and break
 up transactions
Date: Thu, 10 Jun 2021 12:28:35 -0400
Message-ID: <20210610162838.287723-22-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01574b4c-d330-4b5e-c12d-08d92c2cf305
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114E54AE8E080BFC84B8328EB359@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPrmMvaRX1V7dGZSqmi5ZU/gAK+7X19kb1Bz/gxIFC4WbYw2bVRgh3OIq+pvfEjE78b7brxv85gWU3ETJy/xHFvMJVUCQEwYc1ZsUjXhCUv2X3spWkXAMGRmo8X6HiVyLRX442SmDFhuM2fgR3dk4dvfC9glbbEp1pOAzv2op8k6rPCjyMoRb1WVhdghOBHrc2XyxFHUhSFN0pWK1f4ghHuaUnYo2uDeh6wCISVsvTEFp8b4ypCY9rAA7rvwnqhTjfflGGeLWX9lMt6tcohRbmO+v3uHji1gIIRMmFdgqo9MRCB5znwdvxmmDUHC2jI911HCo1YLrSSrIQmvhXgj1X3kQbRci540OL0B4ZZwDfzLOlaab37YCP/IHA0Sz2bAhvv9INnHoLtEPNa/SKnlf3sVne8onc1Op6VwZXa3vDp7cWuDBQUPvamFqWxgTYZdNdBOD1299Rp0EHlvXUIJw+OWxqt/TBmf6v41TsVMSKlc/O3fDitSYE/jidim49LPQmRjqL40snLpU/ZPXEeSk9q+8SIbPRFBwCZfsF29vYVf6vMfZIEgN2CD1AzPxV4BjqcFbEWItJaccav4Mt4FyUkLNj4U7I+V6dZFqINBbkLwVphzDvUEYk+E6THeoztQFOP0qgDGDC6rP++Q8vwQTBdmUI71AfD6X7s3Gvnj62UIJtgLOLo0fn0Rddfyz8KQa0KKstkGfDmaVhS+NGVa6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966006)(36840700001)(47076005)(316002)(336012)(2906002)(8676002)(82310400003)(1076003)(4326008)(86362001)(54906003)(5660300002)(7696005)(36860700001)(82740400003)(426003)(70586007)(6916009)(478600001)(81166007)(6666004)(70206006)(36756003)(2616005)(356005)(8936002)(26005)(186003)(83380400001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:41.5520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01574b4c-d330-4b5e-c12d-08d92c2cf305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
SCR for DP 2.0 spec says that multiple LTTPRs must not be accessed in a
single AUX transaction.
There may be other places in future where breaking up AUX accesses is
necessary.

[HOW]
Partition the entire DPCD address space into blocks. When an incoming AUX
request spans multiple blocks, break up the request into multiple requests.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 87 ++++++++++++++++++-
 include/drm/drm_dp_helper.h                   | 17 ++++
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index 8957565f87bc..27ec1e6e9c43 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -43,6 +43,60 @@ static enum dc_status internal_link_write_dpcd(
 	return DC_OK;
 }
 
+/*
+ * Partition the entire DPCD address space
+ * XXX: This partitioning must cover the entire DPCD address space,
+ * and must contain no gaps or overlapping address ranges.
+ */
+static const struct dpcd_address_range mandatory_dpcd_partitions[] = {
+	{ 0, DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR1) - 1},
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR1), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR2) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR2), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR3) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR3), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR4) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR4), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR5) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR5), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR6) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR6), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR7) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR7), DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR8) - 1 },
+	{ DP_TRAINING_PATTERN_SET_PHY_REPEATER(DP_PHY_LTTPR8), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR1) - 1 },
+	/*
+	 * The FEC registers are contiguous
+	 */
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR1), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR1) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR2), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR2) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR3), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR3) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR4), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR4) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR5), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR5) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR6), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR6) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR7), DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR7) - 1 },
+	{ DP_FEC_STATUS_PHY_REPEATER(DP_PHY_LTTPR8), DP_LTTPR_MAX_ADD },
+	/* all remaining DPCD addresses */
+	{ DP_LTTPR_MAX_ADD + 1, DP_DPCD_MAX_ADD } };
+
+static inline bool do_addresses_intersect_with_range(
+		const struct dpcd_address_range *range,
+		const uint32_t start_address,
+		const uint32_t end_address)
+{
+	return start_address <= range->end && end_address >= range->start;
+}
+
+static uint32_t dpcd_get_next_partition_size(const uint32_t address, const uint32_t size)
+{
+	const uint32_t end_address = END_ADDRESS(address, size);
+	uint32_t partition_iterator = 0;
+
+	/*
+	 * find current partition
+	 * this loop spins forever if partition map above is not surjective
+	 */
+	while (!do_addresses_intersect_with_range(&mandatory_dpcd_partitions[partition_iterator],
+				address, end_address))
+		partition_iterator++;
+	if (end_address < mandatory_dpcd_partitions[partition_iterator].end)
+		return size;
+	return ADDRESS_RANGE_SIZE(address, mandatory_dpcd_partitions[partition_iterator].end);
+}
+
 /*
  * Ranges of DPCD addresses that must be read in a single transaction
  * XXX: Do not allow any two address ranges in this array to overlap
@@ -115,12 +169,28 @@ enum dc_status core_link_read_dpcd(
 	uint32_t size)
 {
 	uint32_t extended_address;
+	uint32_t partitioned_address;
 	uint8_t *extended_data;
 	uint32_t extended_size;
+	/* size of the remaining partitioned address space */
+	uint32_t size_left_to_read;
 	enum dc_status status;
+	/* size of the next partition to be read from */
+	uint32_t partition_size;
+	uint32_t data_index = 0;
 
 	dpcd_extend_address_range(address, data, size, &extended_address, &extended_data, &extended_size);
-	status = internal_link_read_dpcd(link, extended_address, extended_data, extended_size);
+	partitioned_address = extended_address;
+	size_left_to_read = extended_size;
+	while (size_left_to_read) {
+		partition_size = dpcd_get_next_partition_size(partitioned_address, size_left_to_read);
+		status = internal_link_read_dpcd(link, partitioned_address, &extended_data[data_index], partition_size);
+		if (status != DC_OK)
+			break;
+		partitioned_address += partition_size;
+		data_index += partition_size;
+		size_left_to_read -= partition_size;
+	}
 	dpcd_reduce_address_range(extended_address, extended_data, extended_size, address, data, size);
 	return status;
 }
@@ -131,5 +201,18 @@ enum dc_status core_link_write_dpcd(
 	const uint8_t *data,
 	uint32_t size)
 {
-	return internal_link_write_dpcd(link, address, data, size);
+	uint32_t partition_size;
+	uint32_t data_index = 0;
+	enum dc_status status;
+
+	while (size) {
+		partition_size = dpcd_get_next_partition_size(address, size);
+		status = internal_link_write_dpcd(link, address, &data[data_index], partition_size);
+		if (status != DC_OK)
+			break;
+		address += partition_size;
+		data_index += partition_size;
+		size -= partition_size;
+	}
+	return status;
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index edffd1dcca3e..35ac1f537530 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1369,10 +1369,27 @@ enum drm_dp_phy {
 #define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1	    0xf0037 /* 1.3 */
 #define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1	    0xf0039 /* 1.3 */
 #define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1	    0xf003b /* 1.3 */
+
+#define __DP_FEC1_BASE					    0xf0290 /* 1.4 */
+#define __DP_FEC2_BASE					    0xf0298 /* 1.4 */
+#define DP_FEC_BASE(dp_phy) \
+	(__DP_FEC1_BASE + ((__DP_FEC2_BASE - __DP_FEC1_BASE) * \
+			   ((dp_phy) - DP_PHY_LTTPR1)))
+
+#define DP_FEC_REG(dp_phy, fec1_reg) \
+	(DP_FEC_BASE(dp_phy) - DP_FEC_BASE(DP_PHY_LTTPR1) + fec1_reg)
+
 #define DP_FEC_STATUS_PHY_REPEATER1			    0xf0290 /* 1.4 */
+#define DP_FEC_STATUS_PHY_REPEATER(dp_phy) \
+	DP_FEC_REG(dp_phy, DP_FEC_STATUS_PHY_REPEATER1)
+
 #define DP_FEC_ERROR_COUNT_PHY_REPEATER1                    0xf0291 /* 1.4 */
 #define DP_FEC_CAPABILITY_PHY_REPEATER1                     0xf0294 /* 1.4a */
 
+#define DP_LTTPR_MAX_ADD				    0xf02ff /* 1.4 */
+
+#define DP_DPCD_MAX_ADD					    0xfffff /* 1.4 */
+
 /* Repeater modes */
 #define DP_PHY_REPEATER_MODE_TRANSPARENT		    0x55    /* 1.3 */
 #define DP_PHY_REPEATER_MODE_NON_TRANSPARENT		    0xaa    /* 1.3 */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
