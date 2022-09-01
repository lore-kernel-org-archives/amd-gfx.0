Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD32ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 09:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FAE10E660;
	Thu,  1 Sep 2022 09:12:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3776C10E660
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 09:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+MyvuufVz5MRcufBIufhId4z/xl1BOEygwpW+PW8WT7kpUZLwTHtRZgMQ4yeL0YGXMkr8C+kk8ZN0CTjTS7sSJW41dVHFDgXnGFntBswrGxgF1z7DTZW6LVqrpU47AThrJ/k3va/+8zpfOttDzfp1f4UledRqMxlvaotnKvC+mqjB1iQ0cbAHrVdimiFCwialNJmGi8gR5g19sYTN8CRjdPZDO+2jvZ+hRHkWD8Ih2Axu7wvIriR+G1zpHBgvhPg7jMxePrl3ScyzZAKdEhgGlAotgZvUHoTpQxfKecKPiEqEAUzBprlGwZ2X6UW+p1oC1Dee7KcNOCTstAXaH/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPdYjm33gEInubuhrGoYDrfiv+rgDPT//XRDKrCuw8E=;
 b=J+HfYuDX2ZmQHBc0JpbHFhzDOzZkbLdnAgOUMyTBWfXVjmf1TbO0C36d6tB+x9eAxp5eQgxq7BeYQMAhKXshIeM1MGWJVkr2RnK4O4egGYK2O2oSe6qSalRpXWm+sRa7MTDcuj8HM3rC2YPh+cjAVfyKBtjwzCK5HBOc7Fed71gpiePdbt2WZ9sklDkbraBHPERrH0KKV4zWWxBQaGmDSYZ8Jgdz0Mqzqkc5BwVwRmqKRnMQyByTEjIAElPQOufxPrssL3CyLf1doKr8mjrVre/vwdwiofrO6CT9YaGrkv78FqzG20qso9QlyC25gwIJ5VtDnbWvT8fadO3RQXbUcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPdYjm33gEInubuhrGoYDrfiv+rgDPT//XRDKrCuw8E=;
 b=f4j7IBuHagsxQ7nZSJrPDhHXw3KJWoKIEqC2UcMiq4XFyb5smZzaFUHBzB0e+PRAl9IoEVniW+TOBl95xiV0l6IxCbuquqjYV1IO74o369qv1BHV6IUR1Ao81aUK7szQ14wWXsVjVC7kpdDsnWuVwt4zS7Nf8eEP1YnUxMFlQ1A=
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:12:42 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::f0) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 09:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 09:12:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 04:12:36 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alvin.lee2@amd.com>, <jun.lei@amd.com>, 
 <Guchun.Chen@amd.com>
Subject: [PATCH] drm/display: guard if clause
Date: Thu, 1 Sep 2022 17:11:08 +0800
Message-ID: <20220901091108.108103-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f0120f4-4b06-4b49-5656-08da8bfa2017
X-MS-TrafficTypeDiagnostic: MW4PR12MB6899:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+ZyexcqGpv8uoWURdGsbIIY+tttPcZh4HYLRbQpTzN0UsutMPNgRlSijn+8rD+DJOc2ZZ3l87EAT8PBpwWu45IVSN/ySnlaKh/PurHB9U+sI37N3di285rqyAzPe/hFteKl9nh4tsp8v/zwtMLSFjDi1q+60fsNmEjzJkBuXn+HjwFbYrxbKscqujIPFD8MEXMFIKkl79HeuXTjpi4ZZssxfsuEAsJ6Qml3hKYU3pv3ulvQUQ1fpTTARU8H5/AKh+cUnHoNzJVH1dlx/sZkIQ8LZKvVps8SB1JR3sNjtxyubHPnGiVogwjsUKr9jfR6MdzVHNsjxewzcfVjnbgir8r/unf2YJCgjUOd0VGWdu1r7UBjpGfhDgjmB1K1rmlXlFB2L8Qwnyfj4yzVQ2M33AFU8xocFRX3f6gQ00rQ1ys/D2D3YdCGjYdqNgUljcK2vI+EjFr+lIlKmQdiQnoL5Ih7lFH1Utd0520rJNWEQKXIDOJdGfsAIGJZ2hrfvV59NLR8GErbBkFMMCJLSRr0ZJ46nVLE54TM8ns9pc6XE4+ojVzJuYdjH67uEWtY0Y2MMwSKM4KD36wROYaD9ocftJs6Yym7JWgknY/gAWNvVu/DOMT6t3b19dwbKNJR42HY4XKjSuYv5NOpsHlC1l1N4Bt+u86p3kT8q1lE+M1wE9vyncddYenTruIohIblpPUUAHK1aFvX8wOoPhIe+3IK6WEttR8fTEYUtEejh8QcUiJLZw2o+YBDdwnOpADWuziCQrFL/jRfS5uhKl6eDhiSDWEGDYWqf3QsmtiLj8cHnrQuLGDvIskFjbTWHkFtVZVC3dpi5YhZBUTavIe7LQ7TPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(40470700004)(8676002)(478600001)(70206006)(6636002)(316002)(4326008)(82310400005)(40480700001)(110136005)(40460700003)(8936002)(2906002)(5660300002)(70586007)(81166007)(356005)(82740400003)(86362001)(16526019)(36756003)(336012)(1076003)(186003)(47076005)(426003)(26005)(6666004)(41300700001)(2616005)(36860700001)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 09:12:42.1894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0120f4-4b06-4b49-5656-08da8bfa2017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To eliminate the following compiling error, guard if clause.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'commit_planes_for_stream':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3521:2: error: this 'if' clause does not guard... [-Werror=misleading-indentation]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3523:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
if (update_type != UPDATE_TYPE_FAST)
^~

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b49237390cce..66072ac1bb4f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3505,11 +3505,12 @@ static void commit_planes_for_stream(struct dc *dc,
 					top_pipe_to_program->stream_res.tg);
 		}
 
-	if (update_type != UPDATE_TYPE_FAST)
+	if (update_type != UPDATE_TYPE_FAST){
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		if (update_type != UPDATE_TYPE_FAST)
 			if (dc->hwss.commit_subvp_config)
 				dc->hwss.commit_subvp_config(dc, context);
+	}
 
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
 	 * move the SubVP lock to after the phantom pipes have been setup
-- 
2.25.1

