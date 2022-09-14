Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC6ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10E410E84B;
	Wed, 14 Sep 2022 05:18:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD95D10E84B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRpUNPi8vZcq60zwCK9dU3f7Qb6AwuIH0S0SvesyPlF41kbTyL30BA3c/lBs/rgPpWRk5LTxPh6Z+FG3k1d/AextzMxUDbSR43GjwAnHOtfQFQo3Ye5rua4PBSfB0zc+7NFqqnKkffjvh5ujEcfTW9cNQUuEwsF2GM7f+2NCN7h6aTUjYW7cGvasB9tOZnV/ATFt2/X2DjWo+RBW6hZ4FUzUePoOniYUwXjx8VD+Fby0PsFBcqmCk40ae7xy+0fG3+TXeDbYCFrZGBXlx8FKDylbGaBETVXFPFSvmsrStx+8Sb8p2kjBps/W4XVBKhmJ41AZ7huVYuEGWHIVzAyJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlVNO7namICkGc8uoL8oE/A1vfKwf0Wdd13MZwQm0tM=;
 b=fqiNb6ZNYAuyDzCq9EoYVy/ebp9Z1W6lttuYlz5tqtmveehl957H9ehUByFJU4ea0J27F4waz4vZozqM4rPnJeg/OKUBys7uiHRS1oGgiXVFh155IBHUQRjIZKm8iZjTWChOI90AgGUWRoIv8BlVreIHkYTJWrw2XKmKkwLNOxnXPj4U1XckMj5Nou8ZiCds27yycLU1+9AGShMSkEdDYChgQXv8gsy47n6EKaNeFqcfvu0hfBCakzrR6CXRzzLFtX0TrotcX567ss5UQ3Nyljpgght3hr9dcedUX4BfaxeSEsicb7kyVUcFgGDZtw56KVxcB63JEaYyal+9KD5UTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlVNO7namICkGc8uoL8oE/A1vfKwf0Wdd13MZwQm0tM=;
 b=lWg16gBYW1zdED8CqPm6w9UoqhUoCtdO0EHT9bsew3wYOYuklaKpKX0chlxqOi9A4aRiZdL44Zyy5TM3WNL3Dt66Emv2FdQsfKnTQUlsu1CC5n3Hz6MiwlrOmchz0Xxzhro+kaHWgBTjKyWg6zeMdyQ8ZAuHmVilG42ogMGfAT4=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 05:18:28 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::4b) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:57 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:52 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 35/47] drm/amd/display: Assume connectors are on single slot
Date: Wed, 14 Sep 2022 13:10:34 +0800
Message-ID: <20220914051046.1131186-36-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3ab035-1191-46cf-ab10-08da96108ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLBnPKNVS3jojKGudOb2nB4mp7meZQXfa3woaJz/Mh8M5yBqvsnNIpKP+uDSbTpMbUv4rsQrVOMvdWiZZuYYgPC/4rJnAtnnjjQ2ij8s2dVFg3QaxIhns7/MZLFuFGbblPJfUvJtz7IutzNsik631+gb3nRFnyeg3dQLlrSZjDCXz0J3zbjtKn2V44jdpH1RlYKmGJqnReoUrK2zClO3L2HtJLfA4bMUoJPKHa40CFAnYFdjWR0LXgCDF8s1Rt8Mwc9qP9FH14IOV3t87yH1qjN/6DuD09JAb4jlYVqTjCh7o+eGJiEPUEHOXwIv2imI5Zl56lnjNPshJfRwz4vzm0igmVrPc4+/xP7+5Clh1ISCmflc1lc4U48rG+TrEV6UGN1vGB1ToMdpmOqwzXHgqQgNUhc6O+MmkkZXTXU9T4KFVtSEKn6Lz1bxNTUKBrlnA4pl8b8yyLkXFRpQkO3kmCY/XUWDeHm/CaKSa0GUdNcibN1QWiPkZRLb+Ig9bsPCJLVt84/oHyc/TUTqBJRQOvfATmSVQ8rXP3tF5wAeO0+ZZaSQkLiPkRKHYM5tt2qBi75rptCrzkuJTOj7jkLbJMjqJTUATf7OebABFcr+v6mLj8W9yu09romG47W4R3W0XVdRa+6XfB6qUTbLWVfq37sNao0xqAdoSXR+J9ySd9Kn11fJoPKnZeaRAqOZTsoMHXd+YFYlrwxb6BY2s/8n5vMkpALHLp9SBeh15FzS58hveoSpmnjKYU3c5u/cTntxJeD7jeb+gY10v+SRKJMePT6t87OEtR0o42dK0JKCUtmBcZ14x8kkX0fMzI777GA0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(70586007)(70206006)(4326008)(316002)(8676002)(54906003)(2906002)(82310400005)(6916009)(8936002)(7696005)(478600001)(41300700001)(86362001)(6666004)(40460700003)(1076003)(26005)(186003)(426003)(40480700001)(83380400001)(47076005)(82740400003)(356005)(36860700001)(336012)(5660300002)(2616005)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:28.3957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3ab035-1191-46cf-ab10-08da96108ecd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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
Cc: stylon.wang@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jaehyun Chung <jaehyun.chung@amd.com>

[Why]
v1_5 display object table has no way for connectors to
indicate which slot they are a part of, resulting in additional
empty slots to appear in EDID management UI.

[How]
Assume that all connectors belong to the same slot.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jaehyun Chung <jaehyun.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index acbdb7926375..5d70f9901d13 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3346,6 +3346,7 @@ static enum bp_result bios_get_board_layout_info(
 	struct bios_parser *bp;
 
 	static enum bp_result record_result;
+	unsigned int max_slots;
 
 	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
 		GENERICOBJECT_BRACKET_LAYOUT_ENUM_ID1,
@@ -3362,8 +3363,14 @@ static enum bp_result bios_get_board_layout_info(
 	}
 
 	board_layout_info->num_of_slots = 0;
+	max_slots = MAX_BOARD_SLOTS;
 
-	for (i = 0; i < MAX_BOARD_SLOTS; ++i) {
+	// Assume single slot on v1_5
+	if (bp->object_info_tbl.revision.minor == 5) {
+		max_slots = 1;
+	}
+
+	for (i = 0; i < max_slots; ++i) {
 		record_result = get_bracket_layout_record(dcb,
 			slot_index_to_vbios_id[i],
 			&board_layout_info->slots[i]);
-- 
2.37.3

