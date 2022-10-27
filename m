Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC43C38A2D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 08:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A9810E37A;
	Thu, 27 Oct 2022 08:15:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E9E10E37A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 08:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyyC1eZ9eQcP2JhgVFWL/NtXclE7bJt/vVPPKvros7Ca8h1EK617UM9VWGNh1BiRr5PRTQ2OobO2vDT9JCGDiQnHIBXfzrCqqKJlr05LvREpXbe/2gdQPsyBwPpeOOVZXM4AeihSW3WUYfEmLsPlut43ALRuUxID8yZY9Fawko0dfthPyibLs6vtMVou2/3lQsZjD/LJ9cAerbsZtDtiwWVciDmwH0f6AZBlY3JcXQXQPeR2a/Gly/iJPNN+WkIS/F/WzIpLhqqo0zD9+DSEZSutxyQ8oJZIRTwCVjV+dH5jF79Z6miyhdXELdiQEUhSe8ww8yq8ezW+h7/V9NX10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsUcgDR72uTsaIZj/cg7IUBcxz5F33927fKBz9hZRQc=;
 b=A+mudT72YfeH2ODkprsUU1OPdKHQjvxmoN9WAKDVbdvSjIoLa5L/sNz62O9EO+820iTwy8cvrBi36MI3kTxsDLQqKGJs1yYY8RKg44LAkbOcKwHP9ZhJoGXU1+sefeR1hrCmbrWgIBFBRilIU92evYMituWunap8Sh20SH24WE7vH8UrEBlg0z6XDjPP1Tymu8h5+4dEGvyyU534YKDJoeHwk6PjUpn5PU5wO2xylPGQzc7GbLwlfsjQuYxQ9RqAlkaSqgil7Gyi2mR9ZmPTD29Mxw23Av3v6BFw/h9Gky+iRqhf9nphtLW42jS+k6M447Q7gWpdVgT8w/QTio5+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsUcgDR72uTsaIZj/cg7IUBcxz5F33927fKBz9hZRQc=;
 b=y4wD5Y/hJdjaS5KwiczfoIKbj8AmoUSkNFpSdtYLLfmhZb0XQFhupN0Ax4RKyrYvAOmdhmSI/3msC+drGYGrfUvjaNHtUcYuKaCeNkSiBc/PDseRZVZXlgN43FNWMOzHrB1JzoJfLWgjE5X5B+tREXmW/EOQOBLXx1u7XVz2eAo=
Received: from BN9PR03CA0399.namprd03.prod.outlook.com (2603:10b6:408:111::14)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Thu, 27 Oct
 2022 08:15:00 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::52) by BN9PR03CA0399.outlook.office365.com
 (2603:10b6:408:111::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 08:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 08:15:00 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 03:14:43 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Remove unused variable
Date: Thu, 27 Oct 2022 16:14:02 +0800
Message-ID: <20221027081402.320626-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027081402.320626-1-Jun.Ma2@amd.com>
References: <20221027081402.320626-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|CH2PR12MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: 200ba590-517c-491d-fd79-08dab7f357f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJiURNCQJwIRP0cydVSI4Ymf3db32TlkLKIxvNdZVfpKX6Pfu48vBsRtbDNJz5o8nqYtL8CNoL4n/X/WFPRU22vWonV5uK4/ZMNKPpuPJIjkhfGhKEJ0nYYQa5nP/K5vzk563E8YAu6vW0tFJFCmypMqJA8N+a4DJUO50S6zjraLUqhr0p9+p5y+XUYr2oowOGRM+Yaqp6qjg20V3col0icY5Apf9J5lUYFQApTh5eIQXoMOj9H6XQJ6BlEAuQ2wijMTzcwcNCT6cm29aKxzQ7VVzBVa0mVc0cHTdeQALk0bob//523ycfPe/xyzwcbkNjkvYVyzAyA11Hhhz4aN3SBDviL9kF2rIrLa1tSkkcjHpp3qMBUYtfHLhJMigNTrNfn0qlEgTXZDIDYQ/9mq+4HeG3RIQGe8dojr7tek6jFCFu4ICieXgpuTusbIsfnpfzQEz44H6l6YxKYrO3DGYEw4/IS8OyIpaAMzfMI2VtKewS+kGkLzopj7GSrGWLiuJsg5Yxhpn/mE6evaC1tRyg3HjVsIe9JW+f6daMXKwofPeIB7fde4m/zqKm/0yCpFO1Bjkw45UAeyXCSS8Su1FUkxmxVqc/nzy7kAzA//zsACs7idHKXGjzjwOiGtEVWkWScyNcHObuyAnjIzJRKtjLRbGKmg2adzgkaYI/Rl4F+Gh1E9EVGJE07f6ujjzJ237CWP+3MX4mdCznIgFqNhJQnaFPOpy/4vrsR6JtFsArqqBv5HUUCrChDb5RIhO3RAt50+QeHIc2x+7eN36xSPUkpVbKyVNvuDb21h85kinntDsDyruuM6Y6HXrUvMho6M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(54906003)(316002)(40460700003)(26005)(70206006)(5660300002)(41300700001)(36756003)(8676002)(70586007)(86362001)(110136005)(6636002)(2906002)(4326008)(8936002)(6666004)(81166007)(478600001)(83380400001)(82310400005)(356005)(426003)(36860700001)(82740400003)(40480700001)(16526019)(336012)(2616005)(186003)(47076005)(7696005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 08:15:00.6487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200ba590-517c-491d-fd79-08dab7f357f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The kfd_topology_device->cache_count is not used by
other fucntions, so remove it.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 8b7e34b45740..72fbbd342c10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1029,7 +1029,6 @@ static int kfd_parse_subtype_cache(struct crat_subtype_cache *cache,
 			if (cache->flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
 				props->cache_type |= HSA_CACHE_TYPE_HSACU;
 
-			dev->cache_count++;
 			dev->node_props.caches_count++;
 			list_add_tail(&props->list, &dev->cache_props);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 3e8ac87f0ac9..912a5e6a24ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -140,7 +140,6 @@ struct kfd_topology_device {
 	uint32_t			proximity_domain;
 	struct kfd_node_properties	node_props;
 	struct list_head		mem_props;
-	uint32_t			cache_count;
 	struct list_head		cache_props;
 	struct list_head		io_link_props;
 	struct list_head		p2p_link_props;
-- 
2.25.1

