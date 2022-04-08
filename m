Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 02:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F4B10E1EF;
	Fri,  8 Apr 2022 02:39:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52C610E1EF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 02:39:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBgJ5DjfGmROZyXJhumGvfAxQXubSF48efVBuz7SEzB9U2vAgUNAZPFec8RElBB4QqZI0MI/IfxMLOiyDPNLnbyK/ZMZ7wl1CUb3idN73Qnj4WP4uoT7/N6LoM0CkpiX+1D4yd9rGWF07BRqI9wACnH6OgaYtYLiMwJoG3tLc0srITJRIufi5+E3sCOlcSxZzpbKAUWk24DW0fESgKavMVyOd/8xCNCyWrdlW12VmvX9609O6GJ3DHzB1Pt1DiPMDnsfyrP55GUN17j5/tMrDLinXAtS9tD0SUoQ55jj1uw8UGwFiqQod4Ngy+M6dbA2EKpJvbPZ/ntwwqQjuSPCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZi1R3e1m9SRuWM1deD614j47cmmJzNWC7LFBZZ6IyM=;
 b=OTaZcCRVvJI/ptDFE6X6BwX9c49kXwIj/I+5lMVEeUS5F9QNnFXOnD+XQ+YWBmuAdKAO0aA53ad/HLJqM9oqab69eyR+GfgftjzrKsUPHSvl/e/PU6IdBzytXY6bYaJSppNuFACokEYMJwyBhXYLo2TliU5anXxEx9NGQft/1GhSLTO8vui8CpTKj5tsYdfCq0Q4gvyYA4g6ELpGUVqed3R/wGom1RTwa8zIkR7Lzx0dRBUMwfqC30eQhr3S6gZ9ewSQQwn8UPix7Kr30Jq9FWQHB36e5Rk1QmbG+4Y2RmC22SSYd9f1h3OCF4siChLlgD0aYr4wk5qHUrJ1FF6eVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZi1R3e1m9SRuWM1deD614j47cmmJzNWC7LFBZZ6IyM=;
 b=drnsaUyH0hFMghZBZeDOzwbn3ZtFBzQ48u6fvPuCTF4pgdfcX+SWnri5JiYOKxH186JTsk8DdEhxjxq7224/lDE1kwtvnkReRe2fdkW5S8veKW8e21viDgxn57Q6ZuGjSOc9MCzqUUHAmb7Jm0fz6Itb2Dk9KtVRumxP3SBs8SE=
Received: from BN6PR13CA0064.namprd13.prod.outlook.com (2603:10b6:404:11::26)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 02:39:23 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::73) by BN6PR13CA0064.outlook.office365.com
 (2603:10b6:404:11::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Fri, 8 Apr 2022 02:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 02:39:23 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 21:39:22 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Asynchronously free events
Date: Thu, 7 Apr 2022 22:39:07 -0400
Message-ID: <20220408023907.320138-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05aafcf0-7f13-4d6f-7e70-08da1908fdb5
X-MS-TrafficTypeDiagnostic: BY5PR12MB4322:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB432255CF2E0AD09F2767A36392E99@BY5PR12MB4322.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBMf285q5vX2QlMj51mleUamxBz7DtrZOz4PAdSwlvaHr/VxHSGQr7lF6D4U/7G4x5O8suivniH6RP1NtfHq5GtCYLc9TkVPQDZ1aNkbR0mcYYKY4XP+zlVLkF05acXKxJajHfTxEF9zerAZb5eTcdPYdfa+WP8TbXrk0TXMdalHgzIJ4Fn6TeOfEqOYPfy8k8lAAXuVhiVZ4BjKrDBkIZ9PEaEGK68g+ANYg3fMk1npRmdSxY/xjr18UGAmJBK58PYt1gdDIaNPJbEOepVi3aw9jG3s2xyNu6/zFCTYxXvcuIUBTo016ex+R0G9mWZdUq7/LQRO6ONpbSS0aq0b9FSc1+yvy5QQxvCFCBKQ0F6KRtVgzy1T3Zw3Y6bcdWCXH3S301Tm9E/fUVdaKv3Qn0rjRoYybj3hog64Osc5AK46i6JbEj2PbdqzSux75KPMI8lEtxMUCvSpTm65aVrML+Wk56OV75ciEfkZdTOg1x2dHvh3u25CAvE3Kqkhe6I3Ghl4r6ubz9Fc8Ys2X9Kr6xueuPe14ik4cxg5F3H9MkdrOXNpYCLkZt70rykZHNV/qvvGI9XHsE6CBday5Q3GHY2L5kaPj8NU/iWDOBGLY9eZkzRPlhXL/va5RYZOnVhXeuRkBAcUQzNbaPsDUBgw+qpAcj61wrnPM9q/x31/xgEuebSlf38N3QNpbbFHIJ0+cO0nua4BwIePPLslr/schw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(26005)(16526019)(186003)(2906002)(36756003)(5660300002)(336012)(86362001)(426003)(7696005)(316002)(40460700003)(2616005)(36860700001)(1076003)(8936002)(8676002)(508600001)(47076005)(6916009)(6666004)(356005)(83380400001)(70206006)(81166007)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 02:39:23.2528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05aafcf0-7f13-4d6f-7e70-08da1908fdb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
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

The synchronize_rcu call in destroy_events can take several ms, which
noticeably slows down applications destroying many events. Use kfree_rcu
to free the event structure asynchronously and eliminate the
synchronize_rcu call in the user thread.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 0fef24b0b915..75847c5d5957 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -262,8 +262,7 @@ static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
 		p->signal_event_count--;
 
 	idr_remove(&p->event_idr, ev->event_id);
-	synchronize_rcu();
-	kfree(ev);
+	kfree_rcu(ev, rcu);
 }
 
 static void destroy_events(struct kfd_process *p)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 55d376f56021..1c62c8dd6460 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -70,6 +70,8 @@ struct kfd_event {
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
 	};
+
+	struct rcu_head rcu; /* for asynchronous kfree_rcu */
 };
 
 #define KFD_EVENT_TIMEOUT_IMMEDIATE 0
-- 
2.32.0

