Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E10C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1F910F52E;
	Wed, 27 Apr 2022 15:16:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 031CA10F533
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9MOo8Ntpyn3kdm47cu7KNkGZjs5Taqq80ltuoDGCwI9s9yBXNDmIWgmre/Khx6jm6gE43zOoNy/5Ilkvo2GiNdE8OwMv+ZYLjwRM5Z6cFsQNXNJCrTDktVECMx2lWEUjPjbYg5PJkgd+Pdxebs1nAS8QTL6jsOTb0xBVre2WCaJly6of64/smx4JbFE2ZmDVjhN41VsU/f3zEn2OJvYh5stzEM7Tt3oX1Om4VznjfuFyj4okE58ei8qv5kQS+4yCWAZ3cansSwsjKafYouSi9ll2CpfcD5cC+oEM7hBdE11SUvwSuXzbwkFfgmMmnAQiF6cvZSjIFfIUNk4gesMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfzWMeDc3KPWL1c7jY0Q5/KQ6eo2ov6U6N8PHqVSq6M=;
 b=GdsfhCCNCA0nWXOSPgR5M64c2jeT53rlVoZ9HiJFZh0rFIHnb7IqI3E3wPwmicy9DJxJHpeEepqi1R2iYDClruNSk4U3jwPUhClGd8fOY+np6U3x1Cgss4pohTAhBiddpQ7wo3Cux+lv9gUsFJiZHVGqjXsRPTvff4VkrUkvsY3VKABUFK6GIrD56mPovM0LdXVn60I/3NQw1+ng+05T1y+pikd9kvA1X5ZpLnC1UtFVFjBBhBUlCoGSIRoJEoBy/yOYQfOjwXcAsNX3z041+h4z9PspjvNe03RRUnC7IJ+CxftBNRSDZpWxhxhc0W/VNNXVAuj5ME20xgf2SWCZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfzWMeDc3KPWL1c7jY0Q5/KQ6eo2ov6U6N8PHqVSq6M=;
 b=a2TJxfDkyyYVxl69sg3Cse+HAQsBKqfbtGNGRvl69k6GTwanYaFi76blTyqDysdpnc2ETDRbz10nwSI0e9CMkomGsiZHd9+hOFREMdtBynj95623lPEKAxMVBcwuuw/1/l7pPkT2FNZu5bxzz8uP0kK4tFmRwQdfS2PLokIds1o=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Wed, 27 Apr
 2022 15:16:53 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::81) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 15:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:16:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:16:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add NBIO 4.3 Support
Date: Wed, 27 Apr 2022 11:16:36 -0400
Message-ID: <20220427151636.3104955-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427151636.3104955-1-alexander.deucher@amd.com>
References: <20220427151636.3104955-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b762a5b-92c3-4189-8eff-08da2860f5ba
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2788FBC81BFBDE3FC790DEECF7FA9@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQfkkNOm66RbwYaAUsOzN9WZxHlTMYazEEJfMKJoozqbfK+zNPH2TTXSHhQ+6YO12L+VttMmVX1qWtdEiUGWuylginK1VDnO5FKik2ACW2ckN4anQdbGt3KwvmRTTXEwciGx0bpZ8OZyO/xHRN0VPpE6pB602zTv0t3UJmrNwLg4qlcXIac+utivUebltwQ7twDHDs7ZXZrgL2bgsiz+bZVapI+aKfRT56qa7ox6gJTpDuDP/LFfoVDo9wJNsxLqytYSVhvZknl+zVwZk7Uqx3glJvdgN/1Oh/pPTbHj7lrWr3mp7Bq/l0TRyeeo/8RvyrkH9YKjPSEJHpp46XAJqtkO3i3fZKl7brwf1ELPnTdYco9VImjBcNIXVf4b3zmzi5PoZSuxHqMeMFcrEO1ZtW1pf3zi9OtHpjIRCyReMkBjs9rZyOsSnk6SHQjZ8SuUEmQmSiyJyQYA9U5CjiaTK3YC/+ZgtXnwP95Iic7QWBjU06LnThy+u7OVaFX3sCwaUquvwRxf1Icu76Z8qjFxLvM44boijec24gF7JADRmZL7x74MDXLUBtzW7+FgVZ9HUqtQNXT/dkWAfglUAmVt3WeiQbdKQUohcroNuy/OcSWG6Fu2FyInkBw0QEK0LlV2ZUX/iUNV6bQAh4gJXGj6EdnvizxbUEw4A60Vs2FYmVakKCxkKoS6P56LyuJo5uXF2LuGWogx9q1LqCSlB9UmXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(82310400005)(40460700003)(336012)(5660300002)(356005)(81166007)(7696005)(6666004)(316002)(26005)(54906003)(508600001)(6916009)(426003)(186003)(2906002)(8936002)(2616005)(1076003)(16526019)(47076005)(70206006)(4326008)(8676002)(36756003)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:16:52.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b762a5b-92c3-4189-8eff-08da2860f5ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable NBIO 4.3 on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8a2cc1c36f0d..f11c01982cd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -50,6 +50,7 @@
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
+#include "nbio_v4_3.h"
 #include "nbio_v7_2.h"
 #include "hdp_v5_0.h"
 #include "nv.h"
@@ -2144,6 +2145,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg_sc;
 		break;
+	case IP_VERSION(4, 3, 0):
+		adev->nbio.funcs = &nbio_v4_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v4_3_hdp_flush_reg;
+		break;
 	default:
 		break;
 	}
-- 
2.35.1

