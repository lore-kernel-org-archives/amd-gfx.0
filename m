Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AFEECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC9110E045;
	Fri, 26 Aug 2022 18:46:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1264510E07D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhzMUGNheOUTjJPZOYFLsdWbGC7p3uEdLAKNmWlompkTFQhPJ8wE7Wcuzm6IaBaO1oY9hz+Sq1eYcMKN9mwiGbksYd/f8kZIK2ej9H591NG/MDVWXP3DJjNXxlrCpa/rreIcWnbF5rV5BRgQv1xaJ8U9cFGFDwq5uT59b9QpQT2dzV1hMS52pK8iPHMXl0O4kHx84vVSFm88A1X6bVw0uY1JJ8TfErSLS4KB34zwFDtaQdpzdb/ToIquuTx+1uG7hK8SVps6wyPjzLUx2eC+QgTvbBsJvjhJdYkdjuDr/vBL1a/PB16ZMY1OmcvEEelPR8FU5bzrV6gc1/TBwzTBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We+8BebIv8DSMjwb7rKsVprZzXA3ynVg387t1KJHczE=;
 b=TMO7uLJft7KyKXw+M5VqQU2jbIU0rnhK/CycXZxj1L35yfcwMf6kN7QDv5madN3zrJnqJIRRvonKfXqQZc9H9f1aAMOz8e45/BQM/5trlfkNGu15i1dUi2tgSCozFxzCwlcbv14C/ExqCYw23eNQyqxRy0LGpI7UAPl5AW1hKE6WYYZfB1NrLXDcCMH/V+f35JbOZH+5X7QbxvItrIXMmvI6HbG4B5zyAJ195qxYeIxfPJIxDytW2IgduLF/y8lVrxMNdURlAQnmyALZIPyKW5mSr0AdcT7bKtqBR7n+bEXucliWPxuTdjSr7LFcwyJBOjHjhoChxUQA1zEzFCAu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We+8BebIv8DSMjwb7rKsVprZzXA3ynVg387t1KJHczE=;
 b=24CSYSUEqkL2uq8rT494ZkIhyXm3SZLbh1xBzVA4zu4GCYysiGMb/gQK2fdtF/ZfdZ932RsJU6Y83tbTtKFagK52Ga+RwQw1aLr67OKFAMpkEQSKTe7msKFfzE6W4LEe3sS7oZHsZCTOPwL5kXuM3+wIMAUAg800ZBg1wgfVrR0=
Received: from DS7PR03CA0125.namprd03.prod.outlook.com (2603:10b6:5:3b4::10)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:46:00 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::fc) by DS7PR03CA0125.outlook.office365.com
 (2603:10b6:5:3b4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:45:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:45:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add new ip block for sdma 6.0
Date: Fri, 26 Aug 2022 14:45:42 -0400
Message-ID: <20220826184543.855686-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184543.855686-1-alexander.deucher@amd.com>
References: <20220826184543.855686-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69757ee3-43fb-4fd2-354b-08da8793381a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4102:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ExiovBx6pSa6TcwOHdE4FWsL27x1c9AovQCoDAsVao1dELOvX/oMvPmM14FCblGCnB6oDnf2vT1W4kGq5a6389T8zuN3KbU9tQoWWYk+FFEsDblq8pWborMoT9l+DsjFfkYlipbHYXn2dvHfHdGdRcM9gJoIeNmJYVnh6RNetTq8R1gMQ5+jfJFgszVdTIH+M18R+k/KLQqf9I6juDn6v5S0dz4D16vz9915zkHO9c3Rkko9T9XvQu/VtiS1wtFJbKTOmyC4+n6NViYSI4eGasgH2nnrr2rp7VkfbSbsmWeep3h4EKf7S/BA6Yiy4qXkZlHNyLBuu3lHUXb0iNzTEv8uGzTci3rwJvVIMkEQQt/Lma16BMj9mozyiO2JFwl+1i35biYecjKIyaCgQxt7WRR20mjm0B0u9htt6LGUNv2/vM9eYa2yShI/qDR0cVk0lyLaQC7c7R4zejDzoXWhM1Zxrtc6ylbQKwT6y9BCRMeLXRD+vQ/MSMZJloTVE85KwgsHGhXFIB+1By2NZUxBQjXTa6it6FVPFIOMDsgxZMmeehY0LNgbihDGNMcTmSWK1ND3jKex/vFsiY4OruN6uuahyKs2ay6kgM8gklgvHfmcjwBQr4IdkjATZybZ2Pvx0fs9CwNG3CzAVRU9p3P6B/iZM0gbt++ytQsKGkzYd+ZAMoFrsihV7Go+hFKt+OGyjWP8bPzSsNKCpp7lKmlP6IYXNBmsFpyWArxqkpC8lwT8yFtT/QOnluqNA9L2oIjXKtFMfKsYUtLHrl54YYryNfILWZJKHlPSbbs7zQbOgQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(70206006)(356005)(81166007)(4326008)(8676002)(70586007)(36860700001)(82740400003)(86362001)(36756003)(47076005)(83380400001)(426003)(7696005)(6666004)(478600001)(41300700001)(54906003)(40460700003)(6916009)(40480700001)(316002)(2616005)(2906002)(82310400005)(1076003)(16526019)(336012)(186003)(4744005)(5660300002)(26005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:45:59.5655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69757ee3-43fb-4fd2-354b-08da8793381a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for sdma v6_0_3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 27b0f7facb8d..b5c979494c55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1826,6 +1826,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	default:
-- 
2.37.1

