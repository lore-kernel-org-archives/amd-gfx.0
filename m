Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D90C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7470610E466;
	Sun, 23 Jan 2022 18:21:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB35F10E696
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3i9nsOon7Kzdx/0kG0GTkGRMrj1tLTV8wv+jhr8lGJ2rv+sXy9zpQT2/DXj6csII7U2lH01dWXRwlbVnU+O1LB5W3IbTk+1z3KE3rc16klBkM4ZsUJ4gz/AHQ85baA0/pMb6I9wKjHDycsu7Snj8WjY9XIx98mn/1Y3NF9ZjGucadZcyRb9dSfT1sew8a2Nnbc3bBKNTigPDxXb+XS2PRDCs8LaOzO+kZ2DL2BUnAOG44sSwJABohDg5s/is5I2jRxB8wmdQM517Qc3CvkXaOoKpXkusKMkWDqnIl1xYBPk/wRtVFWs4DiHy8z7++nb6vhQJaf6PQKV84WDwya7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz3Yt65Yg6hGJzgzx5h3mucZrwRIqvR3W1V/vJhTFjE=;
 b=ls3gWc1rSns6nGwp6FD7D+0hwAS9c7sWOt7P7IxHSZtFOJ/STPwUCQGEqDnsbtMlAL5ReT6B/lg36X1K4ZpoOGPmqeyzv+EIlNa52L32kBu9/kDdVXvnBFCn/oxORiscRfeI8rWwxkig9EuI/N0jVAqCHoO9C5IhaDazLixF+CIxB/xrjo88dQCTsEYeGXlEqYZz6mFNOvzDlF+OFqXSjoyd9D1yWcsv02+nSsMXXEIrC1deG/uq2mrhFrJzcT6ZoVJ8Jz/7/dXVfciCI1lkinUCHKFZgg1dpbVoxHzegWCsBIvMvfkBFFcqem1+sSTKJRIKlmAzkgsFlAakz/cOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz3Yt65Yg6hGJzgzx5h3mucZrwRIqvR3W1V/vJhTFjE=;
 b=Vq08rdKQRz+MbhyRbV3AddU2CN6mCp3Q25G80ic2WlqKwCQPvWmZGvIPENx4ludt5hKJitSYYK5Md6oKCGx6D0eqkuGK15NWWXqzXWJfULCXuOYsr8DFQcLoE6ROCqYTFRyFCC3UzO0glMEaxvcEniw05I1CQop3NbxgtgsICL8=
Received: from BN6PR13CA0068.namprd13.prod.outlook.com (2603:10b6:404:11::30)
 by BN6PR12MB1826.namprd12.prod.outlook.com (2603:10b6:404:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:06 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::a1) by BN6PR13CA0068.outlook.office365.com
 (2603:10b6:404:11::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:06 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:04 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/24] drm/amd/display: Support synchronized indirect reg
 access
Date: Sun, 23 Jan 2022 13:20:09 -0500
Message-ID: <20220123182021.4154032-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdeafaf3-9910-4fe9-d0df-08d9de9d1f33
X-MS-TrafficTypeDiagnostic: BN6PR12MB1826:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB182634D019C92D5EAB374208985D9@BN6PR12MB1826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD2olKo6f3L6KnwcB6L0wHWAkk3egWc4YkGkNvJ5KjVxnAjffMuGP5Xd6Hj3N05ViSwPwU4x9lxV+XNLtBMTxTCEXb0F6TCBzbr6fi5pCETtnSVOpiqDe7KUT8arP2Up7+NeAJvH9of5UlfyZh4NyGhETpQhKKQSoXKACC8g711AYpR8EIu2mH2QTqEpUgbOLTP/yiuGwYbabzoiBwAMo369spY3wX69KSFooDvqxyO5lU5AA0ux7OYEDXPMivuC5/PIHngRGfZTKxvNdgHNLAuz+fQ8KTuXq+qTIt8q+UaXrEtm+R5Q5k7M3/v4bm/TlCq9sG/9qE1UW/KAFwrSqbm2ug+fOnSTEdQgWGetQJ3tkYBIpb05Qdx+6vs5Itu/OIGjfzyqBG05bJW+ruvdUBJnyG1m88yg8NfM7XCemPiqp+GLDNeUh6h04RBQ6PZ86OdTmdgZVl3TY7Q36fGymdNQv47U1qv/FRMQuQv/eDSloI6wGW2uzS0BfrMQOkRtIOYHsPY/sMYly3JdwjBIua4hlcp6p8b10RnCmyu0hLt4MGWQA0zcJH2isGopZR3uYyYJH9fHWuks078JQJ2VsepR773jKo/VG2kKIIh8URvsbNJxED198Mg6DP6DmQJVBG24uognPOv6M5u9bTHL+oikiKJNsiY90DWPpDFBqVhmZcaqKAan1P4D1ZPtbdddEkDvOycEXhZP1bS4hzSvZKm08y+W1E6yRgs9i7v6K/E+fuMVfYbiqBCQWpfEuVZvikwQvt977brir1nVP4ZyHgpWkcLwqM5M6F2fCiqm+8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(36756003)(316002)(83380400001)(8676002)(336012)(508600001)(4326008)(2616005)(426003)(2906002)(6916009)(54906003)(356005)(70206006)(8936002)(40460700003)(86362001)(26005)(82310400004)(5660300002)(81166007)(1076003)(186003)(36860700001)(16526019)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:06.3888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeafaf3-9910-4fe9-d0df-08d9de9d1f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1826
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Roy Chan <roy.chan@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roy Chan <roy.chan@amd.com>

[Why]
indirect register index/data pair may be used by multi-threads.  when it
happens, it would cause register access issue that is hard to trace.

[How]
Using cgs service, which provide a sync indirect reg access api.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 60 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   | 34 +++++++++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index a612ba6dc389..05ad9f52b9c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -588,6 +588,66 @@ uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 	return reg_val;
 }
 
+
+uint32_t generic_indirect_reg_update_ex_sync(const struct dc_context *ctx,
+		uint32_t index, uint32_t reg_val, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
+		...)
+{
+	uint32_t shift, mask, field_value;
+	int i = 1;
+
+	va_list ap;
+
+	va_start(ap, field_value1);
+
+	reg_val = set_reg_field_value_ex(reg_val, field_value1, mask1, shift1);
+
+	while (i < n) {
+		shift = va_arg(ap, uint32_t);
+		mask = va_arg(ap, uint32_t);
+		field_value = va_arg(ap, uint32_t);
+
+		reg_val = set_reg_field_value_ex(reg_val, field_value, mask, shift);
+		i++;
+	}
+
+	dm_write_index_reg(ctx, CGS_IND_REG__PCIE, index, reg_val);
+	va_end(ap);
+
+	return reg_val;
+}
+
+uint32_t generic_indirect_reg_get_sync(const struct dc_context *ctx,
+		uint32_t index, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t *field_value1,
+		...)
+{
+	uint32_t shift, mask, *field_value;
+	uint32_t value = 0;
+	int i = 1;
+
+	va_list ap;
+
+	va_start(ap, field_value1);
+
+	value = dm_read_index_reg(ctx, CGS_IND_REG__PCIE, index);
+	*field_value1 = get_reg_field_value_ex(value, mask1, shift1);
+
+	while (i < n) {
+		shift = va_arg(ap, uint32_t);
+		mask = va_arg(ap, uint32_t);
+		field_value = va_arg(ap, uint32_t *);
+
+		*field_value = get_reg_field_value_ex(value, mask, shift);
+		i++;
+	}
+
+	va_end(ap);
+
+	return value;
+}
+
 void reg_sequence_start_gather(const struct dc_context *ctx)
 {
 	/* if reg sequence is supported and enabled, set flag to
diff --git a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
index 2470405e996b..a402df225a76 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
@@ -498,6 +498,40 @@ uint32_t generic_indirect_reg_update_ex(const struct dc_context *ctx,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
 		...);
 
+/* indirect register access
+ * underlying implementation determines which index/data pair to be used
+ * in a synchronous way
+ */
+#define IX_REG_SET_N_SYNC(index, n, initial_val, ...)	\
+		generic_indirect_reg_update_ex_sync(CTX, \
+				IND_REG(index), \
+				initial_val, \
+				n, __VA_ARGS__)
+
+#define IX_REG_SET_2_SYNC(index, init_value, f1, v1, f2, v2)	\
+		IX_REG_SET_N_SYNC(index, 2, init_value, \
+				FN(reg, f1), v1,\
+				FN(reg, f2), v2)
+
+#define IX_REG_GET_N_SYNC(index, n, ...) \
+		generic_indirect_reg_get_sync(CTX, \
+				IND_REG(index), \
+				n, __VA_ARGS__)
+
+#define IX_REG_GET_SYNC(index, field, val) \
+		IX_REG_GET_N_SYNC(index, 1, \
+				FN(data_reg_name, field), val)
+
+uint32_t generic_indirect_reg_get_sync(const struct dc_context *ctx,
+		uint32_t index, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t *field_value1,
+		...);
+
+uint32_t generic_indirect_reg_update_ex_sync(const struct dc_context *ctx,
+		uint32_t index, uint32_t reg_val, int n,
+		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
+		...);
+
 /* register offload macros
  *
  * instead of MMIO to register directly, in some cases we want
-- 
2.25.1

