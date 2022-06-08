Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D9C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 11:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52BA10F43A;
	Wed,  8 Jun 2022 11:51:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5427C10F43A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 11:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK8xDyhnYknYHg0iOZoaQcHOBMs2V9FbqIDI5f26Wu/qHgt5qONjyB+itT14s82NzsGgaPdaznDxiHfd0/Koc7GZIp6jFe1R39pLihvddqYYUqSScSjdp7RSqi97Q/9Thh4t1rCg9eENfkmsvitDkLUAXkiJmo/QO+dBpXQ2O4Gr+2EdLtjX/g+iDavs4ZEMKNEPyoRQ7rIn2laOdRHW0/Yc4Q+oOHe6Bk15tkAyWF3hpkBo5gn1nua1nTeUfWX4XcACDVYRPO4Lez76UUA5SfBkw1N/r6t1Dboah3/ZUn1eJBkq7B87DXrAPByxbPQYvu6I8cFSyjCiNiPOBXGFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF/ROjiehNovLMUHSxN/Q6zVokokA89jdNzoBxN+1ow=;
 b=j63SsG3tOT19fiSahX+BN7rm2S9z4BJZ8Fo8kC73SfsNtPV+MWxBEQMEHCxHb6ItcTZwRIOlwznV22xcaaV5ZtSOIBvxXGAd9qSmcb6o9RETO4asfyo4uBQBQrCCF/gFIFSeh3IjN4/uWyPgkbR8kCu7GkAI7jJShwEcXqjSSvgv5rTBiEPAsEaJDJ6RkvBMxsaTkAY3QVLnblBokf88/t/8YiDieu0TjUlz9YKQs/pK+63ow9RYPTe7Wh6QxyUwmPbiseht7FXwrXG0vwT0c+QGHy26RPfbdfgQuTAwU11KlXoHUUyVsrWJ4kDUTlPUXGHZhd9LAGfbinIFnAJJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF/ROjiehNovLMUHSxN/Q6zVokokA89jdNzoBxN+1ow=;
 b=jqIoIyBj31RCx6U5gzl9S3qfk7OhPHr9GbRM5MsDszLtiS/jp5ZG7VlawyDqh31ZIdys38ObSn7qArcYac+5X78Zd2pjXfeDsM74Gdwd3laoVMxItjm/3WaSq+FRfNGaeaHZt2F5eTneR3dnsYf5BScctZdToNAG+g/NBhJrY8s=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 11:51:44 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::85) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 8 Jun 2022 11:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 8 Jun 2022 11:51:43 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 06:51:42 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove field io_link_count from struct
 kfd_topology_device
Date: Wed, 8 Jun 2022 06:51:33 -0500
Message-ID: <20220608115133.1807445-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb95013-f295-4914-6c45-08da4945421b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1661D7302E60E0096F6B3939E3A49@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRHrzg3bQJs50gohfpx2RG8BU7H/J1DQRNwhh6Rk/WJMu9inA5/5z0PSOIlTXbHo/BJTZnSnh0FGYtsKjZbh1xqzQjJbNVaqoReNG2R5BRG0S5Jfp7cRVm2mERcncV61RI+UpTtEcHsknmVkQKqeCufT/aqg5xgg36/FvgS4QRZWIdas4dkQL+5g9tCT09d68k7ijMZjl6GLUdXgoKkLkZJuq/JJdvy43qupt+YBeYRX5Tq6FDMkDDBzZEp6FfFz+SaiIpJhIuDhCu/Z5tRHCSzKRJdjDR3TmpTr0VjdAORJLfetfODyULq1sI9iuhY3SI1jjohbyNYbwyLQxk3LhlSE/G0+0sk9xzPIXgxo5hsTMJsVzWzl+SHhYeCljAP95IG+w4o8ZIuz+SmbEXGbnOF2zjdSaxd+Kk8MrVkN6w6Pa9hSWy3IJHMS9RSeO0r6IsJr4U2cfI4dugnntQjsgOP3JxSQeQ04M512nDdmlyhDnyYiVBziQeMR7KovSt8vtBH8G553SGgk3KDTXHv4iXcIlaAPJOiPO/6uMHW5jbZmSaOxSX74OWVJ0LChI1jAlBQNFQVAGMtldBofzek98pa50iogX0obPnD/abrbxLfsqBvUcrF/wH9xAAuSz9BE2J5/fRM0GDtI2WhgaNfY69k1YMytnTdH44pncHddDP5D1/wRpKgnL7GCfqourY6SJmmUARac1fLdpVEedBMWAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(16526019)(36756003)(70206006)(70586007)(5660300002)(8676002)(40460700003)(7696005)(6666004)(82310400005)(2616005)(47076005)(36860700001)(4326008)(86362001)(356005)(186003)(508600001)(1076003)(83380400001)(6916009)(426003)(26005)(316002)(81166007)(336012)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 11:51:43.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb95013-f295-4914-6c45-08da4945421b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The field is redundant and does not serve any functional role

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cbfb32b3d235..a5409531a2fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1040,7 +1040,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 			props->rec_transfer_size =
 					iolink->recommended_transfer_size;
 
-			dev->io_link_count++;
 			dev->node_props.io_links_count++;
 			list_add_tail(&props->list, &dev->io_link_props);
 			break;
@@ -1067,7 +1066,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 		props2->node_from = id_to;
 		props2->node_to = id_from;
 		props2->kobj = NULL;
-		to_dev->io_link_count++;
 		to_dev->node_props.io_links_count++;
 		list_add_tail(&props2->list, &to_dev->io_link_props);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3e240b22ec91..304322ac39e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1819,7 +1819,6 @@ static void kfd_topology_update_io_links(int proximity_domain)
 			 */
 			if (iolink->node_to == proximity_domain) {
 				list_del(&iolink->list);
-				dev->io_link_count--;
 				dev->node_props.io_links_count--;
 			} else {
 				if (iolink->node_from > proximity_domain)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 2fb5664e1041..9f6c949186c1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -130,7 +130,6 @@ struct kfd_topology_device {
 	struct list_head		mem_props;
 	uint32_t			cache_count;
 	struct list_head		cache_props;
-	uint32_t			io_link_count;
 	struct list_head		io_link_props;
 	struct list_head		p2p_link_props;
 	struct list_head		perf_props;
-- 
2.35.1

