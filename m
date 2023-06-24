Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3DAEB64DA
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jun 2023 04:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBFE10E108;
	Sat, 24 Jun 2023 04:44:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF5C10E108
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jun 2023 04:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4iBhcWIwk2ZJkAu3yVNNMHYVFHmqK8agh8ZaNkiLCj7YkMQveVP7YUvZ47OwQTfmfPfoMsfv+x4X/O6i5C6510KW65jlXfuAMimRamFSHY3+wUfg70oujexFz82kNxXN33PElu79vwlfmjTitXfdc4VmGANZIpBCBlvkPRRgXNO5N6fd+HGP+Vw8QqEwuelcaRO/zTN7WuUkMu8u87CH+ON2vA0Gt75Nmo8v4S6Nb/2Z4FX48bB4k6rgGqJJ8S7y0D8w6mrdIR8hdWtKX/1AmtkmNUf0BLwgSHIlXKLzsxzZznEbC0AGRoBnppqYVTuQYevDT3gPNZactKUgJ3YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tufiQcyhIJDJj8MnDQMfKQHLSaSn7xJaMSNV171xdHA=;
 b=NARI9iKuzaNRvNblrIx5DKYVOTAZuGqwR6yFZb7j67ldhl3LN+6F8fnR5aIWP8BKhSHOwzP0X7MrbXWF/s4O2c4BUcXTk7e/oGr4xd/wMGzGnUVSxoY9XmixXQxiwhppZfU/jwDJHilW/ThCz90X8aHCHoeFyW/kA+FqEzKepHrYDhcw1Z7SloRD7J4YaiduJw8iNQ8VGotZo/3JAnzvj+emCDdiOQOW+tPYvfcuZ1XmhJe15ig0r4nNymGFqkjckEp5RcXnx/IpSJPXHHedbRVQP/T1IV93n7UmH+nkcygnaRxB9p91hkC/Jpd+pcHINxwRHUKReSZbiBswzJ8xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tufiQcyhIJDJj8MnDQMfKQHLSaSn7xJaMSNV171xdHA=;
 b=yVgFwsHFYrqtCsr487SYTtymtgDJDjxGtcck32YC9CzVriiOnPQmSBbDEqqPSLOPqA03VF75S5FaY1M00d3P0/Bwsh2c3TAh4pIUtd6Ny2LiZ7IEqA6SyHFzlfeD/fahudDnnGAJiElrvuf52R/ejHG1WA+778vM6Hsab2gw/WI=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Sat, 24 Jun 2023 04:44:34 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::2d) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.29 via Frontend
 Transport; Sat, 24 Jun 2023 04:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.45 via Frontend Transport; Sat, 24 Jun 2023 04:44:33 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 23:44:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Date: Sat, 24 Jun 2023 10:14:18 +0530
Message-ID: <20230624044418.1233202-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b4c968-d0ba-49df-6945-08db746db4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2lksmsXNwC2Iuzr0sQACH+XH4+ylL+hEjMMdmUOLwnIkNyC7MD5svbRtHnCrKKIz09wq9fTkUBQPwcZZEKBJYFzUcpXn75f0lRpX6+yjRgDceCahSc/apVvT2FsU9V4NcR9fDymIf/BGyEP33YKGD5V71B36FwbCBDJPyEnXsIa0t5plivr4g0KJz00Z8zK0iO+4NsVnZ9vqY8sRnQ5GvyNkgZCkRhYjjbU7qtG+WCKoS6n97Q/8VitYc/bMMAqdtQRtmxrz3PWIB1P8elyuKPoBMN6NxuB6+tgM79QLo1yYKlHnwfdZUqBBSQ0yWf9WzgHssEiutw6UXbGVhchoBl53TnVgW/JANOF6uOUyDgCDfF8d5PtXLgsAJr9NkMFz/7csbWmRrIN7Uom34bvwUJEI/q9Osk9IFyl0Zdpa61z4P6/mPxTjkmwcDaT0IhNxb9RF+sujb4OV/0YBWnllKVew+7W8RC6Qr3+571EMiigHc5jMB8zJgwmZPkzgkqJluKrtNk1iIx/KvDdGDzvyfZwcOBgWAev6Wwj2toI1AtynK1GtXINc472D70t6ua0NvWuTap1UfZ5mrkTslLyuIGUinaWk1Y24mvDaSACv/mu4DIXjRAu+k2ymqTWj+IYY3n3GbEZaK9kfvm1OcpnRWFO1sItRYQNWWv3J+3tQxM/yUsdC3U15PqIs7WA7+VMUlwUC9IoTDBzYSUBDy2HdQL6/kkyn5RnlyviP8LO2ML7mLZ6IpWWDn5mUeG48mMz+vrVXKOp39q2TpfmANkmPuv9ROqibS2cWHUYVVTiuq+06Pt60ojdsPojlqhb0Nat
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(44832011)(6636002)(70206006)(36756003)(316002)(19273905006)(4326008)(70586007)(5660300002)(110136005)(8676002)(40460700003)(8936002)(41300700001)(2906002)(54906003)(40480700001)(47076005)(7696005)(86362001)(36860700001)(6666004)(82310400005)(478600001)(16526019)(356005)(1076003)(186003)(336012)(26005)(966005)(81166007)(426003)(82740400003)(83380400001)(2616005)(562404015)(36900700001)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 04:44:33.9039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b4c968-d0ba-49df-6945-08db746db4fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch complaints:

WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6efb812189f7..12ed5a5800d0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -401,7 +401,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	total = log_ctx->pos + n + 1;
 
 	if (total > log_ctx->size) {
-		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
+		char *buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
 
 		if (buf) {
 			memcpy(buf, log_ctx->buf, log_ctx->pos);
-- 
2.25.1

