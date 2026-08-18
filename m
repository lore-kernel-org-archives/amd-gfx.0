Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93FBC5DF88
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A1110ECA6;
	Tue, 18 Aug 2026 20:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PX8gqrlg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF21B10ECA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC0BGIYyfXxKmC1sLe1m2zYeQWuXUk6qNIaAUsUxhno2x8Mo4o6JdmaHl3zow4mpa9yksEIKdcZDZuWLfpUDBEv8JqCfVyQoSRQJPQEewIzlCGmVzetuOfRoA60fdvNKpObjObeZNX0GON1KJFT99BYSNmCNSqabRbSJyEVuN0HzMZawJSKWGD7sDn+loU/2T+Fhch97ShGNOjXBCsStawGIReWd53CiGvlwpmRW9kGdURfNMG4tq1r9obQI6BZ4VvCa7QE3fhRUd8Ozpe847IlWZKgSazbyz8t0Je4C5t6gzecKkQceFsnITNlBbcPGw15VUO+xJJbAvqod0CXqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V22QdZ8PHGrgxoAYA1M1MKBlCDskriiZIJrGJEQr/m4=;
 b=Z1ng56IIzX51DVewXIvfeA5ZgKJuMZ1vZ7EBemNCRZ+nfkUY+2/Sm5wSkrHlyAImCOFIayUGlP/Ci/yclkXgACs5X6yOUGcsITmMXwhWueobFHGT3QW87em4NzmlF6FuV8D1Y3I9d0wS4G2A4zrQdmdCAOh/40/hAppfZrDskcJdDLX7NLUfi8TlOkojlSJtKFkHruq3KhlWm2or2uI+lDOgubd+o9tjBT/IKCLcZBznTp6KzrKeYkAyrjBvolTWB9/nSwkw73Evf5OhQ/WzBEPpeSghhqLeE7p80RM/DESp8eoAxbkawewWVGuRZrbT712t/QKjHAoVUQbQfmk/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V22QdZ8PHGrgxoAYA1M1MKBlCDskriiZIJrGJEQr/m4=;
 b=PX8gqrlgFJco+3sRh9Zn8Jgs+OjLaArqCgaViKhNS9lTRsZV319rF8C/7PAL5N9XJ6D4XJ4lgT1vKk8gazQ489umEUntvAs5vw7O8EwQlc7Ish4/YWlq1PqiZCKCi8059XLR+pQWAFrGHjncX/Y5A5NGOOGorr2jBP5HWtcYopQ=
Received: from IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::9)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 20:22:33 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::3f) by IA1P220CA0003.outlook.office365.com
 (2603:10b6:208:461::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:06 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:06 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 18/82] drm/amd/display: Test execute_synaptics_rc_command
 failures
Date: Tue, 18 Aug 2026 16:15:10 -0400
Message-ID: <20260818202139.4172592-19-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: b002dcac-6024-41c3-f1f0-08defd666ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: daGWuu+vrS0v3KZvzkCOn60tughIpZ4gBGK4byqqZYtw9i/fQ7e5FBd0Q9WeoKhMYTXFSd3U5/tImKGQ7q7ikLzPY90sgWwM+RYdAy0tsA+KJ0eMw+3bgv1fTXA6WE2p7b/RwCgv2yfn1pWCTGatSDK07ZHpBT1lsHzkD47H4xPoVepPOHeKoDuYMQMXmADNUeONNT8agOd01SZLrKA+ymbJGlb0tXmKagLJG/hlJu9D1/p1taG2Zg9EI5IU5j84PWUUHtj3A/dsteuoMhp5J4C577Ifb/w6bmbvgtm3eaBxN0mmTstOU+l3OsfccDvsuc2uxU2rJxAOAeG2tXvDgNKe2bKtUdZccEVN9n98iPeDoSlzXS/IOHaAnfLLjdANt1sdBWmBNYm4E1hzOKHumwzuRT1ZiqRbS1F3btsiryrKG3O9wLrhvW4T5zIkQv52NzVAZKjz79aIqFLbMmfQhzBaFFrRkxmXqKxtHgKQ/fzxxC31Nt77ffavElyaHN5tza3rntOa7uV0qQU4GKtD1DWiwq4Daddk7y8DE7INs5qxxRKhBGQEwrmqHKT36Q+77+TrlhKOWeE16rsojNTOYH/wi/UISVuSJBggGkKt7lOV3PEYEnjqFqHEApqmhQIYuQmtwCgw2vOj0Pm+mEGkAx5lzI715Z6MsyTe2PCayJLnO3nuDKso7wxLqLdm72KaHJklkjZXqcxCUL2idPx76Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eEqgn7yYV5bAixKcuYpmN5vH/uw5ltjT/3yJewTwo9cgsR8+OmibtG3SjKZFa8t+Zd4JPPe6x64cD0YsDpYThVPg+Ect1PR9C22BaaMvqhJeQ1GpRwre8OYfjyGfpNWJR04tj0M0Ku8h1Lm39UU+GqZjXHNor4qjXOcRgVKGybBwKifLE7AepgUU0rKbpmG+LvH+fYFsAANk3BEsjMEYySZhH0ODhV2/HCYn6ZBSLkm/h/Ma9ro3oNPOI5FKbs4DpZ0Did/m6UQjJtYRqsUy2zXdr0yUjGoleImGvVw6obRnulKLE6zITn25WuSFuJvMLyQTcGU5dCcisJMvrUjveenilLNUmZ8bbfVU9lnvK83DobWMTZgINPjv6KRyaI6f/fSb5AlieixxzpIXlcejcMQJr0Z7vXNiWnQsAEP3ttjNF+yeEVV2FOj7ULkfWzUZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:31.7872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b002dcac-6024-41c3-f1f0-08defd666ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for execute_synaptics_rc_command() covering the three
AUX write failures that were untested (data, offset and command), plus
the poll loop that waits for the command to go inactive.

The Synaptics AUX fake gains a busy read counter so it can report the
command as still active for the first reads.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 87 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 89ce10d84f035..bc8b607b6c83b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -1396,6 +1396,8 @@ struct dm_test_synaptics_aux {
 	unsigned int downspread_reads;
 	unsigned int downspread_writes;
 	unsigned int dsc_enable_writes;
+	/* number of RC command reads that report the command still active */
+	unsigned int command_busy_reads;
 };
 
 static ssize_t dm_test_synaptics_aux_transfer(struct drm_dp_aux *aux,
@@ -1464,8 +1466,14 @@ static ssize_t dm_test_synaptics_aux_transfer(struct drm_dp_aux *aux,
 			fixture->downspread_reads++;
 			break;
 		case SYNAPTICS_RC_COMMAND:
-			if (msg->size)
-				buffer[0] = fixture->last_rc_command & 0x7f;
+			if (msg->size) {
+				if (fixture->command_busy_reads) {
+					fixture->command_busy_reads--;
+					buffer[0] = fixture->last_rc_command;
+				} else {
+					buffer[0] = fixture->last_rc_command & 0x7f;
+				}
+			}
 			fixture->rc_command_reads++;
 			break;
 		case SYNAPTICS_RC_RESULT:
@@ -1612,6 +1620,77 @@ static void dm_test_execute_synaptics_rc_command_write_fail(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fixture->rc_command_count, 0U);
 }
 
+/**
+ * dm_test_execute_synaptics_rc_command_data_fail - Test RC data write failure
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_data_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data = 0;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->fail_address = SYNAPTICS_RC_DATA;
+
+	KUNIT_EXPECT_FALSE(test, execute_synaptics_rc_command(&fixture->aux, true,
+							      0x01, sizeof(data), 0, &data));
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_offset, 0U);
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_offset_fail - Test RC offset write failure
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_offset_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data = 0;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->fail_address = SYNAPTICS_RC_OFFSET;
+
+	KUNIT_EXPECT_FALSE(test, execute_synaptics_rc_command(&fixture->aux, false,
+							      0x31, sizeof(data), 0, &data));
+	KUNIT_EXPECT_EQ(test, fixture->last_rc_length, 0U);
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_command_fail - Test RC command write failure
+ * @test: The KUnit test context
+ */
+static void dm_test_execute_synaptics_rc_command_command_fail(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data = 0;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->fail_address = SYNAPTICS_RC_COMMAND;
+
+	KUNIT_EXPECT_FALSE(test, execute_synaptics_rc_command(&fixture->aux, false,
+							      0x31, sizeof(data), 0, &data));
+	KUNIT_EXPECT_EQ(test, fixture->rc_result_reads, 0U);
+}
+
+/**
+ * dm_test_execute_synaptics_rc_command_busy_poll - Test the RC command poll loop
+ * @test: The KUnit test context
+ *
+ * The command stays marked active for the first reads, so the helper sleeps and
+ * polls again before reading the result.
+ */
+static void dm_test_execute_synaptics_rc_command_busy_poll(struct kunit *test)
+{
+	struct dm_test_synaptics_aux *fixture;
+	u8 data = 0;
+
+	fixture = dm_test_alloc_synaptics_aux(test);
+	fixture->command_busy_reads = 2;
+
+	KUNIT_EXPECT_TRUE(test, execute_synaptics_rc_command(&fixture->aux, false,
+							     0x31, sizeof(data), 0, &data));
+	KUNIT_EXPECT_EQ(test, fixture->rc_command_reads, 3U);
+}
+
 /**
  * dm_test_apply_synaptics_fifo_reset_wa_full - Test full FIFO reset sequence
  * @test: The KUnit test context
@@ -3857,6 +3936,10 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_execute_synaptics_rc_command_write_success),
 	KUNIT_CASE(dm_test_execute_synaptics_rc_command_read_success),
 	KUNIT_CASE(dm_test_execute_synaptics_rc_command_write_fail),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_data_fail),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_offset_fail),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_command_fail),
+	KUNIT_CASE(dm_test_execute_synaptics_rc_command_busy_poll),
 	KUNIT_CASE(dm_test_apply_synaptics_fifo_reset_wa_full),
 	KUNIT_CASE(dm_test_apply_synaptics_fifo_reset_wa_first_fail),
 	KUNIT_CASE(dm_test_write_dsc_enable_synaptics_enable_inactive),
-- 
2.43.0

