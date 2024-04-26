Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59678C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 01:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC0A10F907;
	Fri, 26 Apr 2024 01:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJpYIFnl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4827410F907
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 01:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4EBwZltFqiCsIpuJRuBd0gZ3BT9Fsr+5uPdJt1TmW+nVqDCOUhEQBhASMNavJKGiqEZT0x+2A1oIRCERoyBVCnRA+uALZ6rQGe6mGG0H5OvWfPA9nqBjArbAixs2+FQQ2sK0v7p66kLdPUy/JV5ByJnhLQ/zVhiyNC0NtFsR0gPR2w4DMMApU0JyYW7TLh456aeybICUUTxgsv2yjElSg/r7EDrUVCxlwqzEkALCDewE8qzP8B4ldIKcXMHcqszsNgwFsOSf7b+NCawYltgWuYZJMbJIeosNWk5orbNA2Xkht6swe20YNlti9n7aI4KaIGgKVMGnylHZWuCqofUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3zDADy558DC/PEYMNr4hnujDs5QVCOJ2q5NN5FDRa8=;
 b=W8X9AKimJ+H2Gb420kwKRa1RIk6YwEW8tRmVulbOUC5YiHGy5JFLrmNkTWOGUmCitGFmsivJinm8h3cla/s3+KsqB1BSzju6WQQC/61Yc414SoykEJ2e4fxUrKKKrINNpTxnDvwoCQtIrLzZGZnK1rA9SYoK3hXfVhg2yE+sfnP+4LJW1IwItmp241SGj0AKFP/S+9s1eyXq05tiGptOdkeOY4FdBDQ2fNiw9WyMqHlTgS0u/kz3khtKetGBqBS3VYBmSDRJr0yFO6qwMtxGcBP8XOCZ+TF9tacbbd97w8gwEyifBywDrmVn1FUYr71qCBhkw/1xgcOwNC+7Ra1QRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3zDADy558DC/PEYMNr4hnujDs5QVCOJ2q5NN5FDRa8=;
 b=eJpYIFnlFusJ16zo7gq3E4TlrtMK+QPa1UMLiLCWs6NQixRyOo94Z+Ia5jKVbpdEVHHSDMV+Jzkjjt+Slh8mI3VUXXAltF+4zAfUAiPwKB3Ju2k8wso6+7+szP+NvbDH5JkCJbSmL4fsvoxGcudqYad+8ObyJZ0Zxm1Q2nj/tto=
Received: from DM5PR07CA0050.namprd07.prod.outlook.com (2603:10b6:4:ad::15) by
 CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 01:19:11 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::39) by DM5PR07CA0050.outlook.office365.com
 (2603:10b6:4:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 01:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 01:19:10 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 20:19:06 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix uninitialized scalar variable warning
Date: Fri, 26 Apr 2024 09:14:26 +0800
Message-ID: <20240426011426.1340586-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d54de79-8fda-42e9-2b5c-08dc658ee0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sACfucKei4Yzw6UiXX4aD+w42sF03x+YqJdPis0NJXvC9ZJmYzeu0P3mkHDa?=
 =?us-ascii?Q?IQnfQc63eiYJBbhi/x15YE9s+F3pu/88NsdfzkD7FpAu/MdpeC49ivh0qpK+?=
 =?us-ascii?Q?LyQ/XF+Wk8EF3gfgl0k1guGaBtgvW9R10fNjKvcueYvpXx3G6W8H/ftPOH5k?=
 =?us-ascii?Q?DFn3rPjE0dXojJnwAclt8nNmiaBisHV1o+/Osm+XD3SsP5Gao7GyOdNfwazz?=
 =?us-ascii?Q?lwt0JmOv9QsfACssKMGMmN+0MciQFzpUimAZq2uV7SFTtPLGHpdTUtCjsYkx?=
 =?us-ascii?Q?TIW4lNQXk2TExRyscFK7HxqyV7S/SymFyJJEnlhpJ5mHp1c3VfmmAFJkozEc?=
 =?us-ascii?Q?NUnOnP7HTpB9CsKdH0ZknfCFALE967V8daCquK0goT0vBiJqjjAArxAKnrcw?=
 =?us-ascii?Q?uPgkVCT8O62KhTBCHoXWIqHs+Z1yoMtVNRAwL6qsBqKt2N8Resd7HyTq7jvP?=
 =?us-ascii?Q?X+Pm3uyuQmPYq5zYet6nH3+mjYNKjVugH3SWfz7LgiKgw2ygpyx3U/0EVpYo?=
 =?us-ascii?Q?Qmor9zmJx4EbR6lYJJ4deooD87ZXLiQGfPnYFGL17Yi++9LcheGyvcWBZ8kL?=
 =?us-ascii?Q?DIZZnot5ymcY9zEHOwoMDClZRkLRm4fPuuS2J7uJ2kmruZYtXkJtlnaPBQWH?=
 =?us-ascii?Q?lGfQhV4vetk0Bnb0E76CXVZkyz45dVIDqv5t+u/YItXSzl30VmeKT8oUojAX?=
 =?us-ascii?Q?NcxIzOO72ByziA9HtYhYGX2LNFFHWJQpulKpmc9zc8Fxty2HelPVMgvwANEV?=
 =?us-ascii?Q?tu9RlSQhd/+789TaCDT8UvIoBjO/7vtgCD7P8iupZh17KMVgaxOdbdr0ez2o?=
 =?us-ascii?Q?BN+6ylRXQ8fdZUefXHrNfK23pLm99J3Acf/FvFdP1D82DuhmCQ/JeSmQVlvO?=
 =?us-ascii?Q?Zt4yicBKTs6SLTn3GiIgMnU43mb0tx+0J32p1dEmqs718M1kbumprinLMAtD?=
 =?us-ascii?Q?P2Vhg8WDkL53tOXPOPvhpmQGu0LJWZ6VontFOf7W6DRxK3Kv6U0lDkDaFyMC?=
 =?us-ascii?Q?Y27Umy0srQzcg3FJ1zsn021KpDtvs5AFsI3zEm8nZDnijL5oatEs2CYVmdzx?=
 =?us-ascii?Q?GndTdhFupfckpoh1VjFwnTKt8zZOE8UGagKQWn6ebrq5GPwYCoDmCbxogMFZ?=
 =?us-ascii?Q?WTESiXRmJcJf+vfK/awEC6O/JIIZk0DEiQgJ1uhZcwRJj9yHtoUSsodqXLYD?=
 =?us-ascii?Q?zmzJhgAIcL+P0CC4AVGZkBKEsZIFblctBBIS4uCitbaU0WPCIyHO9WNPZh9N?=
 =?us-ascii?Q?8SBRiXiSV3zzV8EUp+ltdMVtW9SgGSKOJskZ1VN9O1SCTBidZbHBCCoHsTtH?=
 =?us-ascii?Q?ijIeQPNlpj/zhIanBc+wmFpHDUPr+5SN/83eHmLzQiXBCjCE1V276ERy6wt1?=
 =?us-ascii?Q?QTZxJgZbiW2uO2oAWZnGY65WPH/u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 01:19:10.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d54de79-8fda-42e9-2b5c-08dc658ee0b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170
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

Clear warning that field bp is uninitialized when
calling amdgpu_virt_ras_add_bps.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada7..a2f15edfe812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -395,6 +395,8 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
 	else
 		vram_usage_va = adev->mman.drv_vram_usage_va;
 
+	memset(&bp, 0, sizeof(struct eeprom_table_record));
+
 	if (bp_block_size) {
 		bp_cnt = bp_block_size / sizeof(uint64_t);
 		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
-- 
2.39.2

