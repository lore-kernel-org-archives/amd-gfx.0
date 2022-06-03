Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A8C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15A81123ED;
	Fri,  3 Jun 2022 20:12:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DAA1123ED
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzzLEeE/6RwxLMNSL9THrkq5h7M0peRxrhd6+p+hRuL0CUCToYXJ3EMd1Bzz2QaRrbpuL8swsPl4u/GeJ8tHmsKzGM6Djr7dk9ctNuWQdJjGjKFuUOAw6z+Gb5GN2V/awY1D0S51jVKw4HDIlt0CceDuvJAXny+zOym9WHf2XmC2b/nRdqnFhWw0tGOglcoPRVEqE2jo/DEiYLrVrRAH5q/J0vv/HNIXj9OydUMotOiICX3pJouDT6/lRWCwfd6oubJm3qyQ5ZAl6853d6Rv5J/5XoFVVtcctPtNa9gs1Z/FIw7zHzlWH/Tb0czRniWiIm9mYLH3Lf7ev18JGdqFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/dcHwzsihRGSlPryABMxKIMi9Ik+xlYtUMvbBpJcJQ=;
 b=ZJtVP09qu6F8mxTSxoQLbYPx0SEscEwXhqIvOpT0SERSlk3p9Bn1PJpIAZChV3xXmDGn9DHc7FQ0F6UsLf24xaGe5s1WDg7h6rT9Bfqn7Wq8LQEfRF8zC1+wTlfCS2xFv+/QFdgc478s7lAT5lWPz72gn872Om1GDERClL6h9ViRmFXFdZ37bMWMtfJ/mYbyYe3YEne3I7U3oJC3zDBuNxzLUmaSQWDFkshka50KUywebENF6A8rAvEpzNZCCovzQLc2hZWFRvaafaC35ZyRYgRbaKs5iC+geWZFVsj6EGQqHpEfaWZAP5CQHcmKluA2Y93uXvmnHgqrXC48O02eBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/dcHwzsihRGSlPryABMxKIMi9Ik+xlYtUMvbBpJcJQ=;
 b=A/5dwtqul3uxWJTRwmFyRwwCJlU0L3HW0O9/A1M16dBWdmAhR6tKkCF8biW3Hl5DY5EPACUYgKjuY8a+7+k/wuyJ/hx9HaOq6A1P/CWVz22MsTyMTb35qs5VKmOg3hV3FmcfRCP92kf/tl+z81EsETA97zXR57uowH+RZ4Cp3KI=
Received: from DS7PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:3b5::24)
 by MWHPR12MB1869.namprd12.prod.outlook.com (2603:10b6:300:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Fri, 3 Jun
 2022 20:12:41 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::db) by DS7PR03CA0049.outlook.office365.com
 (2603:10b6:5:3b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: 3.2.188
Date: Fri, 3 Jun 2022 16:11:41 -0400
Message-ID: <20220603201147.121817-11-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f30246-c30a-4faf-d243-08da459d69ff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1869E210EAB93CE00CA55911F4A19@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wy7l1CBkziNlAcDV3EU73eBEyIuAPyOGPBCJmUgV10Htu2Asa8uAxfQ7gqEhAXX84P1Z9NtT25puZZMSJKTrKpy0zZfvfLiOQnxVRy0TYakUzjtTVpgLoFmv1VipxC0B14ihsvk/sdqbArikIaGMZb/473S2rOVLnjxrefkUkWRHmUjSllT9iLRb5jVnVh54BNGSwK2qYJcZ6WCd5g/jd2vrX11sdt+fz5MLuJA7gOyyORK+e15bqP2dmFkc/+lfBNlZtrC8M3cKpp3a/S3k+MXA8egLAra1UktIFzFebkw5yXVpEYkXOYdYLbqb5HF3wqRJDOwCqL4TlL3eXHZqQVCJ/ujWJn6Q8GKnsXJND0eM0NYxgA1KywMmH96Dc9PaIwPZmNN9yzpErSEFU0cjR46yqfxkxGhPfa7uHlksjEEuH9+o2twS85W9cEIdb+xwth5vqXbbYntbtaYRokvsazb7Hu3O7YzJLNbkbsQv5Z74LS1bctBbRNLIvA9ak/Z6P/bJ4r/GXYjBPXk0OTmcHubOQq4Jp+VlUqRQZjmIxhI2zGyyFPL+DHbVMt9UlJVX17ynuNoGB/nsrU6HogelUVJiKx+q9ESX+b3C4oWAF1902NX6LFzqwBXeCTqXnuG7n9yYkSlt8a42CvMopOIf/kAYwX9J6d76GvE3cbtUnXu63pKl5Du/ZNeUcwKA9+Xk5bNlRVSQmArGkn8D6NcjVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(16526019)(2616005)(47076005)(5660300002)(44832011)(8936002)(26005)(36860700001)(40460700003)(81166007)(70206006)(83380400001)(1076003)(2906002)(4744005)(356005)(82310400005)(336012)(86362001)(70586007)(4326008)(8676002)(316002)(36756003)(54906003)(508600001)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:41.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f30246-c30a-4faf-d243-08da459d69ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Optimized blank calculations
- More robust DP MST hotplug support
- eDP bug fix relating to ODM
- Revert a patch that caused a regression with DP
- min comp buffer size fix
- Make DP easier to debug
- Calculate the maximum OLED brightness correctly
- 3 plane MPO.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d08550337a09..df03fef1fff7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.187"
+#define DC_VER "3.2.188"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.36.1

