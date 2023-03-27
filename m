Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C9C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E2F10E73A;
	Mon, 27 Mar 2023 19:37:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA59110E728
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSYA1DC3DDptPIkFCX+imPG3JWSKmueSGEU8jMFdmiYs/3hxzof2+j87nxlvexQGf/ECnKlQuaAt1o9pWIweogwOZ8W/aRJI0yIz0ekjUFirK1mST66eqPKKTdgpKMLUfdhBxlhFQ7TDgxlWwf/YGmzEfQeHXw9Jdxr1cEVsQQh25CI0Rrke9FCJ3GvERxV7dQKpceEPjo8QFSDS9eUzxn33wNxTJ2z9Y+rTrSvFOtYtujtuB6h4NMWeC/wvuB+3nt5pgjNcqregm4GndHLWudp3tc/ZiGSSlvYJ3O9DLBLgmbvBIKij/FGsZAI4CcS027kj9/jynoVUPS51zgjpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY+2m3Yw4Qdes+kdc4L+gw2m9j3qJeqWd1nNB4cQOiQ=;
 b=JKJPUaF8jNCR3plHbldg4MDVtWqgSkgY0pRFKlzsXr13JXSbvhTbAi2weIVEKNnhBDDmC7yrPdjmbc6lJCrc6QT/0WVPTB7oe9JlvDes1P4vyUj3zG/d6uL72GsSg/iuoS7vie2WWfaNVe5WtDy9kbbUHfGu5WmqAmuM2Dqx/CeB1iq/zjuVc+flYGz+6AM/he8Ee9U3eaJlFVtkRoYjdKkKa7jMDW7c70vxLQwxbhQMbIuS+3bFqu1GnNs3esecCHbXhA+kPugl6T0lf0BN020YUXFt0+mq+bsaw0qt+SjOYlBrjPEpwZsWSOQsbOxMdhu8ZAFth0JBT2UjOk6h5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY+2m3Yw4Qdes+kdc4L+gw2m9j3qJeqWd1nNB4cQOiQ=;
 b=zl9DoWTPyYr4Lmc/c+NexidMggzSdci9O8qKsIpORtP1WRb4QyD3TecQ9ueNpVoM8TB4FYax68ti6W7l6GMAkH2ya719JWlcbKvojq51WkIh8ZFWA5hH5rrYKc7oYWp9SSkolua1WmD/bhGI82YMVXW5x9xhXn+l5EV4QsMwTyw=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:39 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::91) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/28] drm/amdgpu: Use the correct API to read register
Date: Mon, 27 Mar 2023 15:36:01 -0400
Message-ID: <20230327193602.7901-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6a30ed-12b4-49b3-7a3a-08db2efa95db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frOhYy2pCPJaXw8/0tZ47QYxPVK1AWTCVXkQfZEEDo8rOwxNuX9cYCsuyUEzO674zylcZnp1S664ixvukIWNe4ePG9fw5uEIW+s7eb1mdT8DWsnjzKJMQSckuPP09Ipe+ywjkFI3QywtvToM5dYZLbsKCFdXH14GyjvJxLfWRvZsazssGqJLfEc5tXmlXnvn5f6DM7Si+pJA2OujqVuH6HlcOU+W9WmoDCpC4082s39A2MGyig8NVAlH7A81OHGuGOvgxUhgGH8RWk4/yWcmRSe9sEdCGrcnSHQvZZltKwOyslG2qjnF1iodKaBnGEfPsJmx/WowsWsE5naPLy80ZgnzX0VYZoU7sZyFVH6eI1VQcCAp5I/JTG+6NTelNyRPqEYzsHhBkJG2h5l1JdXSF8iTKkCYOQBflItAkzIwsBNXTOvau8JqNualMgmb9mKyIXzPVweLCwHKqOQUqjKo5cK9oG1GVQQPFjpb05xBrYc+uk8XdEwQm2xfhed+cv/OfRfpaVWXzOThndmnigx/QeB1KWFFwWTQ7TwiaoHcAF//jFfTqRoGdH2jh69IdxUqBiKF1FMm0W9AsUHWqWIKTE4Sn18LheQUIWA1QW5AGZo/GnKu5iLtUSi2S+t0vfO7CnXtE1YzLwry+U33s6e+Q/7/3FaR6I3I+rWVC8dJ/Z4DNI9n/3EXGR38NOxTQDdwIzaKReecSEwyfpfOXcEC0bJVNFfoS/TcxMrD04uDGRs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(40460700003)(8676002)(81166007)(70206006)(316002)(4326008)(6916009)(70586007)(36860700001)(8936002)(82740400003)(5660300002)(54906003)(186003)(16526019)(41300700001)(4744005)(47076005)(7696005)(2616005)(426003)(1076003)(336012)(83380400001)(6666004)(478600001)(40480700001)(86362001)(356005)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:39.3478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6a30ed-12b4-49b3-7a3a-08db2efa95db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use SOC15 API so that the register offset is calculated correctly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 048e21d202d4..204b069c587d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1642,7 +1642,7 @@ static int gfx_v9_4_3_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v9_4_3_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32(regCP_HQD_QUANTUM);
+	mqd->cp_hqd_quantum = RREG32_SOC15(GC, 0, regCP_HQD_QUANTUM);
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.39.2

