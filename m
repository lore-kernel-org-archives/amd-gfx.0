Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF9EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B75E11372D;
	Fri, 22 Jul 2022 20:41:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735D812AA81
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5Jrjhr2LAs5k15AHqoeKRG5nu0kP6YWfs/HXqKHlMeNReZhvtxUrBUt/PezCRjUCENdxWvVu6UCKCf2oMqYJ2MldLwYQTU6a6yZ0Hot+D2Sl/I0F+xYyzXXnEb5wnfj8tfRkD9um1EbbPeX3m20oSB28MjNKhygtEI8r8ZP4A33vFXWVU8CtPUjMwdRTbiXUBl5Hnmqi2azpV2+OJF62HLLdLnvp6Lte5QcTqtWNe+Kv984DtgM8Sxzy9AtfzdXvkTvTNa2wtC4YqqjEvHcOO+vrVb612Ji8n2pxq4zJzQEkKcQZi7ZH5rGJaHPszfZLUjmVfmakDU6eJ4O/Lk+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xGUF+e5hXZPNT5FzSvaGVp0FCGoBCQjDdR8we5CF0c=;
 b=aM5wSj5paKEeKUmO2LalPkcCZ5LoYmt3Nl2AvlJ2c+ImB0IzIqgHF0ZOXE/utZ+ud7Noj14Q5Ok63zLdCbHRy6OOsvZSfregoNfndiUSwJiRDstEmUeQy1rHi/PGFS0kPgYBwTaSbvsk0Fzw6OsviGpuuxIcrnnsiKQ54PmV8ARBoM3ulj0dt4il5gsIubWl6HJNk48rXg56C/sW8+cUemB1MAfPvfFzuFYBxna1GBEowyAWeRggLszZbSmU4JRjYzkAZNLJpFa4uPo/KXPwsoDB5C5Si24MTczeLAuzHfbBf5gDLY/iy2pTDm4Y5dyWc37OP5FRAnD8vGJJYJ/PSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xGUF+e5hXZPNT5FzSvaGVp0FCGoBCQjDdR8we5CF0c=;
 b=Viw5mZ5J3xt+v1kcX03EoAt27dSwko43nySSISj4GdTlSZlwg3rrqWYPMxj5IrSJUeU2CUDj6ftE1rL0mNZdKFAHniYE2Py/XXySmrYidEQebZNrD2kpy8fJknHeVTe7C9RHNxglriD4jrZ+gpusa3gixyvjzGnGN/hCT0kQHNk=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 22 Jul
 2022 20:41:41 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::dd) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:41:40 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:41:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/31] drm/amd/display: Use correct clock source constructor
 for DCN314
Date: Fri, 22 Jul 2022 14:31:24 -0600
Message-ID: <20220722203137.4043516-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2d882e8-b165-47f8-a7b6-08da6c2294d9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+/XZL8I31VK0Vf5Gusv4vZxe0J/YDiGmKSMo4rZ9wE6mEMX/Bk0UaJctkk4c5YebG70CeWh7DFIVfq9h7ITk4LT5vGqc0DFQ6uuxKkoiodKqhnFjcMzgvnolxFjDgTmWHAxH6yTc7TClhwIMbpuGjz1B9k2M+CEIJQ/9XAi/kW4KueaoeqSCTGgV5fQ5RpYEJjCi3Br4l4rqx9zg94yOv3+l2dBxEUxfTBlx7CjjbHON+QzH9fwELNjR5frJjeooCu++rvDplEEgQbdlLnhZwmebtd91qXqv0U+4i4wJNb0JW5ashBNm3tbHnKZzrA92NByQ7JLeBDqxBUfiyVhTktzFZGqnshnrjQWvo8br8Xoy98w/jVDsp82cYwRCnAS19HROEwzlrFuOhQa7PSLMKnODfzFQW9ShcccY45syXlcCORAN8yoNqlcANXxRXNbzw/WbI/3LVW2Z6Lg7bw34b8BOi+uMh/zG2ERRvfpbVdN24HN6O/z9bei8XZK/zPSdX+5rbf3a8CCyudn+LHZMP/c7czYDoeYGf5CcD/zTG33AMRr4dhmqekcxrs2QwpMhphv4RfRZcWwYt/H4n448rplctucDypS23eRFfyPKWQoiTcfdg+xr5TVloKQ2z1To+2gAaOlr1qanxjhDh1T7i6HXXIiLSFmGHJpLaahsxoqOriosH3td0ZXFdGj9zhqIw24czZsZb3C+xmkyovSnXZQa6YAoyi1XA2oiPQXYRDSMO76INSucNWiY8DVsUpnTt/ek7hlKdcS3t1lpr8LwXuQIIMSKMcRXaPuqxeziJ4SbLO48tEPlsr3NPc39P5BPbg6M/OXyuVLCJPOfJhp8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(40470700004)(16526019)(86362001)(82310400005)(336012)(186003)(82740400003)(1076003)(81166007)(316002)(5660300002)(40460700003)(36756003)(36860700001)(478600001)(7696005)(2616005)(83380400001)(4744005)(8936002)(47076005)(2906002)(6916009)(8676002)(426003)(70206006)(41300700001)(70586007)(40480700001)(54906003)(44832011)(356005)(4326008)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:41:40.7232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d882e8-b165-47f8-a7b6-08da6c2294d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3535
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Michael Strauss <michael.strauss@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Previously was pointing to DCN3 clock constructor rather than DCN31's

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 56ada096c89d..b5672fb90236 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1782,7 +1782,7 @@ static struct clock_source *dcn31_clock_source_create(
 	if (!clk_src)
 		return NULL;
 
-	if (dcn3_clk_src_construct(clk_src, ctx, bios, id,
+	if (dcn31_clk_src_construct(clk_src, ctx, bios, id,
 			regs, &cs_shift, &cs_mask)) {
 		clk_src->base.dp_clk_src = dp_clk_src;
 		return &clk_src->base;
-- 
2.37.1

