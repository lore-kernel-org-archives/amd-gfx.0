Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2825FC6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 21:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCA1110E55F;
	Fri, 24 Mar 2023 21:51:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D0310E55F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 21:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWsyFxthkFBfL3rbdTzWSKRJ4HP7ZoIsUPXg0QR2YJQpn7ptW5zjrgUNew4GQ7OCarWWvuC34m8PMGTt4SicbB+LyJEFbzGoVhgEYi2hZ45A1Iq/4q2xhy/8BiNT0/hG73Ko1rb6VNtZ7m1M0azUFXJRLj1ebMs7W8oXV8sDl6P54xPMpEKdu1hxZKllCayClZLPKD0t+4dbqD+TFOUzLz1tJzUp++2zmzAg4Upp5yOV9qHRYeTBSsYBW8SbDrCGV9UoijAQIOfq7y6HBsihtKEGLGd0egru78dmdkZO/8petMicUR/zV9TmLue4Xj8tOERxHn8JkQdsVVo+SyQgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ymi12iVguSz/a/4TtmNbBqS5znnpv8kE5f1AWGZN+0=;
 b=gQFy779V2V11NexzqtAVWMppiynK9F03ZJyHVPPgeGGF2YbdRC65HFDGi1uKt9IWv7wUw/+Ggscl2oLZ268oSD7agCTE1/EuFmfYctrTqSRhetykiSg+hA/LClNYmEkt7njcOtzdqhyY6MhO2fOkhMvBt1HvDGKkpPpq9U8DbsZWyNl4RXQSJGxzOhQbrQnnZYTk2Zi/E3rRKfmA7uImGL9JQpH5/UBTEGhTnxwao5gr5h/YAUXOcMCav2J1Ryyz7TxoZ5OvN48iKKWkb4jyl6xH1eG6qKZses4u1rLDeATbDi0pCb1iYG+mrGR8EE2xuTrT1z95llqnc+Vhzt1d8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ymi12iVguSz/a/4TtmNbBqS5znnpv8kE5f1AWGZN+0=;
 b=zxLbsZxKOnf758tzxkjGnAGiIwPwa6NduIm3QVliVxuZ4Ijn8q7T0Cq2B6VkaevVr4P5S1ayos5SbSkh0zNMHfkllZo1KxK1V1DeNnu4CcYFmTCtfPTfSkM4rhBYBNetwYY2U38XWLnND72rQFWdL3FZZwy04+W4HFxnSrnIFU4=
Received: from MWH0EPF00056D0A.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:a) by DM4PR12MB5231.namprd12.prod.outlook.com
 (2603:10b6:5:39b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 21:51:52 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by MWH0EPF00056D0A.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9 via Frontend
 Transport; Fri, 24 Mar 2023 21:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 21:51:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:51:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: init nbio v7_9 callbacks
Date: Fri, 24 Mar 2023 17:51:13 -0400
Message-ID: <20230324215113.2560000-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215113.2560000-1-alexander.deucher@amd.com>
References: <20230324215113.2560000-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be761a7-9384-4478-7b6d-08db2cb1fa45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmiQeknnwr9NWXZonB+S5sq8fiocFIiFd1pXpwhYzw8VZxR5NOmLc8VOmWJLMlNf6XAb+D+EsBlPEPHIIn+/FnH/VN/PcmlzeO5ekRIF6ar9ePL6KVqW9qlUSaP5ytSSOFDkOMsOPqkgUVcGueqqR6Xtzb/HWxVd65/Am1pwVuQ6AxSQ1cQtKgylY8E8vKqCJ0EoWM/XrLT24KWCXeQqQtN98bEEa5rQ26HAxFZiPHSXY9HMveildDW5U3+TqfOnQyQozeTcyMbPh5n5vM8I7+CmGWu8ZpYme8ZxWupqj6qtkYvwXCqEU6pRspPgbTPkyKjYgOkWlyN61pB9SX2sB/I7R3P/NkUbHJ9akqxW+AsfVGKQn1qedLYuUbk9C3TnUUaxiQFkDKeiB9BJN76La1Z/G/ooxeQQmSdNnRVNCzzVUzGoymixlqbrloZkDBbSiuFhxTNNOoVEqmfAdqgVKyA3lOjt5XpyLjaUQz+2T+K15rkWi7YbOSefHeB1VMWoJXfvaCsRhGN5bJXBc6yhjYFMR9IblMQfLa+WoNLE51SnBjvpPZJJ8ER2paVngafTE+Pn0btvP8aZag+DYzi5ToN0iRMOllLMJsXLQFbYUXSM/Anz0D1MDtxJIA1rdMYDg5gZOk+XLMEjPO/K5t3XYmZoAPXX9sKNgh+9byO859jA6G6+q7GBMPeEGWWezpU0eEhGp6BReb7rNq7nLqla9Xrd4HHDoO0Tpo30X72EO54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(54906003)(356005)(81166007)(86362001)(83380400001)(6916009)(7696005)(40460700003)(1076003)(36756003)(6666004)(36860700001)(82740400003)(4326008)(26005)(47076005)(70206006)(40480700001)(82310400005)(5660300002)(8676002)(41300700001)(2616005)(16526019)(8936002)(186003)(426003)(336012)(316002)(478600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:51:52.1185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be761a7-9384-4478-7b6d-08db2cb1fa45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

switch to the new nbio generation for NBIO 7.9.0.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6edaa43ab5a1..738ac5d902a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -37,6 +37,7 @@
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
+#include "nbio_v7_9.h"
 #include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
@@ -2264,6 +2265,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v7_4_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 9, 0):
+		adev->nbio.funcs = &nbio_v7_9_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_9_hdp_flush_reg;
+		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 3, 0):
-- 
2.39.2

