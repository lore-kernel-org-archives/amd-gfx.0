Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6ABC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 03:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177C010E3A6;
	Tue,  1 Mar 2022 03:04:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFD010E3A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 03:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDqa9+KcCHp5uyQplFz+9nbHDxtMJeYxJKzSUIyRMcYvFpOvc3W64rMYnlJn19yjS2A+iB58cxLe/uPYD8I3Rb+IZ8PilCUdVq9f9E5mUXUbVZl0m7ppKxqLhXmrS+vznUTP46lzQY5qTW6tm9jcrT6KY0oyqMvwyT/AgVSLR0aC9ABOn0WMoeRu1Wztnn4VGTnegbn0GHo1PIIANsS6EX6fGPzpuC8T+YUmsP2p0asHGqPkSocJq3pwlDL5ZjRweXqzzP0Byb0yETXsB4MwlvQL69mE/IIxD+yJLky1kd4A3A0c6CqnyoiVt+5j2QGqgf8sAHdtlC7IY5Yk5yInPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCOOUbR9g9GkQAXcMNrX2kJq9erBEipMlETQa+mwES8=;
 b=SqQ8VJHHCtX5GXW6afRT3rL3aStf9ZbBKKojMTOdD0E24TFp8RPCcoCR8cYIBBCzKfRS1IgfNmikORf43kjGBzA0H9KQcIxChoEfkEC4iHUHQqlSIUqcuwp/lXv+a4CuF07FZa/bJxLLjA3HqjzLYHmhQ9pgSPjf0JKQsJaUdiSjux3slHOARaRm4FSU+Zxwbi7k4gQPYrrSomcOekF2JF6dVnkwnqUewnnV2SSdVDfC48KElXbULu/R63vxDIigjKpAcsLuUp5ZFIJ5VC1RuGHLzdcnEJI9zsIBZpT6k8ZiTYpgMwDNXHmk/4ghjnomNnpyR9v51JaXsQH8HnYzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCOOUbR9g9GkQAXcMNrX2kJq9erBEipMlETQa+mwES8=;
 b=WOCSNEJidcVajccKSNtB2kUHUiFk3t92GQL3X7Fy/gbbs1HtoYvsP3CRy1mCVGcpyc5g27IETKMcl+3NORh0+9pOZfNT0ZjxTikAzzWKigJ9faRIIxDHE2dEr2tKYK4lOQTHhL740iJGsy8dkUdzQc3QoarQV6Lz1+hqTwCCRt0=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 03:04:00 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::83) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 1 Mar 2022 03:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 03:03:59 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 21:03:57 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable gfx clock gating control for GC 10.3.7
Date: Tue, 1 Mar 2022 11:01:27 +0800
Message-ID: <1646103687-11492-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5d6449-35cc-44e3-a225-08d9fb302237
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43682BBEC64495547C192DE3FB029@SA0PR12MB4368.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF/fWLea4j4pmvaPB5lCOazODa65rHzpctv14cTswTipdQGnYUm8ZVhf8EFQyIQMq54bB1mFyZs8Kd79RhbL526VkPjQYdcmiGyyFZbzaDOcz63Q9YEucYLgC4IeXJsBHmCMuGhbNApVmyClJozAESJJEW69G2koG1fCUxv36dQH6eSi9gmSQWDe0rGkXESvsaxkCBcAURZRXYBLWEAyHlYankZpmYKp3xRqiJ4ItPFNG+A/u9/3S/uhoGe5KWf/jJdoXmLLhkYs2DKR+i3ItvEed0hW8GrjaiiewzcWmrUiGG5mJZSCjoGHx7CJTfYH6Imz1qhmOvTEdJmwr1vICc1cE2Hxd/t9QvXNGy8YWcMbZEnG1gKQVXxA9zLdP7GdELvmJsnHoAGcxiVCPsvjj0VEwLFAG5Y5UJwTDLuqcyfTUHaDLITHYF74Yw3wyvHp+BsxD7stKejnHt6fbS8EKR5KDPH5jxJXEqNhWlIZclBGzikwGBTARdmccSSstBq+Wzh27rNpDAhyGf4nb47Vr1t/Gbg/3vfmq5zdzP2riJ+6NxJ0JG3fuPFDk7yUw8lUedWFdQMTpYcvOe75sVSeM8r52n7iAU8EtmFQ1fSuHI4A71NcdQ88bX6EMAaCKKUc9ZrukgkDdIgAg5Xv6M5DXs4eZqtwTImx1IsTvlyiq3sw2hYPwyi7+jCL3OjFtG3LkbUsviGQQn5mrqloh/pErA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(47076005)(186003)(83380400001)(36860700001)(36756003)(336012)(16526019)(81166007)(86362001)(40460700003)(356005)(82310400004)(26005)(508600001)(2906002)(4326008)(70206006)(70586007)(8676002)(316002)(54906003)(6916009)(7696005)(4744005)(5660300002)(8936002)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 03:03:59.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5d6449-35cc-44e3-a225-08d9fb302237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx cg gate/ungate control for GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 90158289cd30..fd7ded7799e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8445,6 +8445,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		gfx_v10_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
-- 
2.17.1

