Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C889C27C6E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59EBC10EAD3;
	Thu,  6 Jun 2024 21:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ATiwxgN0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95EB10EAD3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtBhwLS0GD89sBztJ1qOyo0pd7GijqQ9dPOiGeECCwvZzw8sijDVmmZVznMrqR3InN0mX3j7qeTLDilWJwv2xRJxvpB+c8I4tzmoCuRNP/v0xMQ4ve//IaLvRgE0zWs90bVzRHEqI9DIJ2XJ4dd153MeQgQKzMUV1U9Nt5GBbGkSAUdd78ul9RMgvu58lZ8Iy9yHkWl97X3ZmnDUkKSag1SPoGgyk86ahfI5BMLgIsrg7o9txZdiBatHmG+c7Q8IOJlZAZWg4SsNnUxtTYux6H4OGsw/PdFog4fBsqjX5ZKTIBHk4CGGhgAuhKRLoGGq5Dao0V4i1SZvAejebkXm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7bLgjPFnL8V9tAG+NIlGQw/hb2xzLkADwhSSyzfpX0=;
 b=WVaRa7fLKS7r38QOvP8nzjnz+W4siQ4DCSyjYqe8XLc5PsX1PFJqZArHMqcQbDnMzD+HsashUvmRO8syjPuv5ApiinWKznZH/fF3wG6M/zcZLOhQs2QCjL1wBJ0sNgylDqNvqjl7c3/DoIlEOSouDAbr9L58nO0EPMgojg+HHd2XyPgWpjKrq0JeyU8IuIiL3nK6OduzJGYckROG4ZJcCyZF7cLe4rlxUQ9O7aRPgxm+a0DjyeutEIzIkVjOxdyx/EdSo1O0OgQoP5vXSBwsxal1Smex/fURIbS4v6wjAi4pwf9GNt48DRUT3Uiw69DUc74eyXGDEVwDcPgEq0sz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7bLgjPFnL8V9tAG+NIlGQw/hb2xzLkADwhSSyzfpX0=;
 b=ATiwxgN0D4HTwWUBR6BebDKbVf513TIkKHx3+OOadd5D7jNZweb3Bu+h50c3s6UDmHUAncZCxeYZHR3tK5ln7KfRc3cguXO7vHkIiZ65Wh74YQ8A/NIhsjt2iMqWHu5yCIpg4Ou01YPdZ2tUN8rMlm4ku/AkHJBgMSTTPr4xtTQ=
Received: from MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Thu, 6 Jun
 2024 21:57:04 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::3f) by MN2PR15CA0037.outlook.office365.com
 (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:01 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ivan Lipski <ivlipski@amd.com>
Subject: [PATCH 10/67] drm/amd/display: Remove redundant ternary operation
Date: Thu, 6 Jun 2024 17:55:35 -0400
Message-ID: <20240606215632.4061204-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd0f8e4-5aad-46b8-8ee0-08dc867399b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Hrjy6hZuStb2TzL/3UclX8gMkwjVrYMqZa0jY/eA8b0MFvf/JlYkLxaHQ5p?=
 =?us-ascii?Q?gEMFWcSYLHLnSPizxG9yNX1YSE06rutzZU4fTu50eiTxf07nmxipNACzIcAz?=
 =?us-ascii?Q?PWsfjiu260ZnRzY0dzdJVmMQ9l1uW896vcQNqiiK079HWbzYJwrg59JY0Qgf?=
 =?us-ascii?Q?fh5BfA8iET2uR3e7IFZvINd3X2bnKlCMxOj1s6XgyyqBGnEx5uuthGk5FfU3?=
 =?us-ascii?Q?0iHtAIUy9mjbQDvfzj3vuuln1oWzY1pgciDMk2FfbAivm3/PijEuExEKt/Ms?=
 =?us-ascii?Q?HaQNjrd5eLs+OI5FrYxJGtNt0KbgE+eZG/5oFXZlb85Xx+HN5DSSpdMdTo33?=
 =?us-ascii?Q?J2RVBk09GdrTnVqMQRWUjBW8gWiXYhUWgqGT8KO68Wn1h00cAREWgzb/xgWX?=
 =?us-ascii?Q?06ernw6ivXplDOWl2z/zA4DyeJBgLvE7bZt8qN/VayQK4e+8XY6uoO/JoU/6?=
 =?us-ascii?Q?1eX1HK4briHW+cNuU4eN8zpzL1pjaShVBAQTY8PW4q3upjfKYKKpeBp300Hs?=
 =?us-ascii?Q?mWRNIxjmEIS2uxoUxb8QjKuhjZ2qnnZFDlSIpxA6EjxHBzD9JkhtozAm785q?=
 =?us-ascii?Q?eUlkYneB91zU7TN0c5zqqUF0y1OxyELMAMxYnoq5uq1GPO8uTd5aNO0FeEi6?=
 =?us-ascii?Q?L+dNed1TMi/e3TOtLNh8qGApO6JR0X6yRvs/5nyBvOiRUWrNt6qo9ovFMntA?=
 =?us-ascii?Q?icNqOw+aSaVvhJtBgvWG26R6AgUP6oYHRgwArH84JpC8tqJcE+uXXjWECxPh?=
 =?us-ascii?Q?SntZVgqSf9wx/LOoDrYYVWKtb4/qq6pS86BRgbkGXJeAxmVrLFPQvPlVNxwg?=
 =?us-ascii?Q?paJvJq+bzqAJ92MxZYBqq/amsMkU6EH9hqF/H0NkA5cy5XO9pl3F7uf8auWr?=
 =?us-ascii?Q?GUn98VWt1SixVMgFw/n0CHAYpSmqvJ5DPb+zg6yhM7YDEviBBrG1ENJLZUZT?=
 =?us-ascii?Q?UpHurF6uyIYpU/ES7B0fJkFsX4gmL02t/ipvQd6A9iS01L+2tV0dKi/qRZSD?=
 =?us-ascii?Q?wiDawd3A+cOMRpIhBkDJE3Tg1AT+JJSvHgoFOsOe5UzQ5+nLCqSKTTv7tzjL?=
 =?us-ascii?Q?OtP+kgFwsIw3de0HxcfXGHRvzFkm8yX/aDSsIgaxp2HPkpq1YcTeEPT37GMQ?=
 =?us-ascii?Q?DhBCAp73kc8gmHH/di8S6Jr6690HPd/ja+gfcWtWfylD8ET428aPXxJkYZzC?=
 =?us-ascii?Q?CIKPT8BngCOZJkjQ8DXrGimmwy8EYFAw58W+AFZItW3VlQlzbgiuFKlExQ/V?=
 =?us-ascii?Q?ayu0ZJ6Eb4HV5GgM/QNNtsvIDwfcZIGD7cClM/5TQvGCdAqlcZi13Q7GmW75?=
 =?us-ascii?Q?N7HOdKCg/vaZ/J7O2OJTAeb45dUKno4+YNPHppdqJmm9ulKfG+bi5snhiU9m?=
 =?us-ascii?Q?S3c9IGVL01vtOOVUQPvxrmyrBf6hnYct4kSfKEj2iwjELFR/iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:03.7094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd0f8e4-5aad-46b8-8ee0-08dc867399b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this ternary operation as
DEADCODE.

Since 'total_y_free_entry' is initialized as 0x200 and
'total_c_free_entry' is initialized as 0x140, and they
never change values before the ternary operator, so
'total_y_free_entry' is always greater 'total_c_free_entry',
'so small_free_entry' is always set to 'total_c_free_entry'.

[HOW]
Replace the ternary operator with the variable declaration.

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index b2d79c908ec2..f93853d434d2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -1612,7 +1612,7 @@ unsigned int dcn20_calc_max_scaled_time(
 	if (time_per_byte == 0)
 		time_per_byte = 1;
 
-	small_free_entry  = (total_y_free_entry > total_c_free_entry) ? total_c_free_entry : total_y_free_entry;
+	small_free_entry  = total_c_free_entry;
 	max_free_entry    = (mode == PACKED_444) ? total_y_free_entry + total_c_free_entry : small_free_entry;
 	buf_lh_capability = max_free_entry*time_per_byte*32/16; /* there is 4bit fraction */
 	max_scaled_time   = buf_lh_capability - urgent_watermark;
-- 
2.34.1

