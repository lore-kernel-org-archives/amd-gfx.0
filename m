Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CEDC636D3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132C910E2ED;
	Sun, 12 Feb 2023 17:00:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B413810E2EE
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeJxhgGkYBxhqikm7COdWang0wWx0CAwGfcMXUt+ziQK/56laMJwYPxoMEKlXM/6olunn/e00tmZ3tPvB8AqZgcB2BZ0VJXoNx3fvOVKtIcA195V13bSTRWe3bJI9e2280n+l6yPwuVcV8j9U2JAHbaiPige5S6vVmvrsdStU073uDz9c08xpEdAaxlUT0qZhfLDJEAXPSuOuWA7T4vhw3W78gQ6PSruDoFaSRu7CLd3vSKTqaA0lYtZu+Cpb1M6/tDPCrtVvBKXhSv7iOPTVwngA92y6Y6vs2YsM317t4JnLKOPoDiB2I13Q9T5bB9oYzjAqKzn4DcSaFCvL83fAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiO2FeLlPMf/wT1aH6FCjYLgzQwTfE/tUbRZX/zj3ZI=;
 b=WQT92O+GGMkfMgeVUhdrr8dOxqn288eq0bQq5kgEWAzQLfQdqHOWYbygvluXLSvKu4OaW7BCVFM+A0lRir8+IHhON32Ko75gzVYStnBTqTriS6BTeZCIwsRx5+nNvtK124qRrnyqFHWWMEsIJtuW1Y41D3Vi1I8scwGVxyHHcUTq0PruohksYSoq3RWR0lOX8AudtTkf4JmGp3Sg4IKcjNFS4fDJvYELUWIBIz7NQbSf0kL7GlsTQOczB0wLWPf1SQoo0W1GLlra3+0crB6RLUgabBggS4vQ3EPY2x91Psi6s6P3j8e2G3PRfOtTtILRl3OWxmInXD14ohICQUFPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiO2FeLlPMf/wT1aH6FCjYLgzQwTfE/tUbRZX/zj3ZI=;
 b=UrBMEH/t0h2dN0koOHjtm6rET9yqfKce+gBtAIS7bt1BzxESPQhXrp3/4+nDEvyk67VK6M10TEPSsREQ5L0m/M0n7IvqMWRmYWiowBoY+UZF3E88cWBZD5m+qa68PLVZsHKr9Vvey1d3YKuhZo4981pSFT+1bf7xgewfiR5YHGc=
Received: from DM6PR02CA0099.namprd02.prod.outlook.com (2603:10b6:5:1f4::40)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 17:00:52 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::ce) by DM6PR02CA0099.outlook.office365.com
 (2603:10b6:5:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:51 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:50 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: Promote DAL to 3.2.223
Date: Sun, 12 Feb 2023 11:59:55 -0500
Message-ID: <20230212165955.1993601-23-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: f0de3b33-7509-4010-a8ba-08db0d1ab2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+siW9ssc+wQYLWt1QmfioucKwe9cp54OIUqp0S5iKAI1Sy+oekkVjLoM6kMrfDWoGJroK7wMFnRnRPOREUwiZMoI35SD5GyPjjPBZHG9ScGRkhSlzD1FtphrIogWXeXvH4HesLKaYI4E7I/LiU4ACKD0LOKtYNpulItJhR6B/o1Jjsuk9YrY6B7QnYdYJ/DHnyf9Sm2egiiJ3y+pUJ1AVqwnThXII0/AigCHkaLrjYwu1Eq8+jhg+uYWqCVf06oWtrGKZvlrIxhcUyWVcdgt8ZMLvrQ9E92S8wPctQoy+RUNVS3xW43QFRkbGDvZkVbhA8RyCo00lsGneWMifrYcl2L6wnsePX9sUVGFOQ0qfFMv5tB33BrHtKi4n4y32xNzAMttZYvCAXx3nyLjZ5JgkQlW6UOBO9rKRagqpP7VZMctuIeI+xqZnDLQ78qIAopslREvh0peZZ+ATAjJUXdC2YIjYSDnNrZ3MfwvB+CBNq3DznUQ+Hk9+yeIBFdRrUznWAQdxaek+4eJx8sH87mT6ULQiUl1FbG3ybWw2xLc+/ml7Ac5lW3lKUzwT4Jw73KudNFsDwV6mmyD5mn7WtdE4nSNdLD6j6Er9GB8gD5oSjR/Z5GPSJnmsryi747a6oKTF0B0SDU18hUaJYuu5MYwbVNEB/e9ZKonGcXqRFn9h35iwU44qrvmX8syjer8HGs6KXcBRLvudctKXo6NHKT37AE8ZJ6L7JzwvNKq+HaDLA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(6916009)(2616005)(41300700001)(1076003)(82310400005)(336012)(186003)(86362001)(26005)(16526019)(47076005)(426003)(54906003)(316002)(8676002)(70206006)(4326008)(70586007)(356005)(82740400003)(36756003)(81166007)(40460700003)(83380400001)(8936002)(36860700001)(44832011)(4744005)(2906002)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:52.4703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0de3b33-7509-4010-a8ba-08db0d1ab2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Move domain power control to DMCUB for DCN314
- Enable P-state validation check for DCN314
- Add support for multiple overlay planes
- Fixes in prefetch, k1 k2 divider programming and more
- Code cleanup

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6d140b7c25a9..2bf0a467d45f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.222"
+#define DC_VER "3.2.223"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

