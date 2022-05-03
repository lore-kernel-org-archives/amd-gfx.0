Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39849C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2312310F4BA;
	Tue,  3 May 2022 20:51:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C1510F545
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O09vqgNNOtIDYjPjVcemJD15HwMLKb/BL3YHwnjgq0PDKtwc+DOwrBTLS3jCBBlq9I8doVHfD+uvIhmM6tcq+WTYv82dDG/RBHK+pjMkowFuZRc6u4TGYZaYhhQeoLCPtwIw8cS3rJBw8e3embgoMvM+xnPrw+ZWkiO7Dr+D4zH896A/ySHt9uffnITHXMJQzLV8VidrdJjTnD3Wz1fgwRnL1B7IoAXwean4h3rw/nY+WU3pvzz2x7piDLOjkRuNs5/lTuXvTC2loBgb10GIPDElqSD8AKEQLcOHQOVhPPDe3or6Bl1+6SxfaEcsO1S2po10CeThDJjEbyTS+H9aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChvaYnSq31zn4II/KNxflqvaFm8HXoU0uZPCNosZzCw=;
 b=clBFfZaZGA6ZOF3lmEA0pQ9x7T9L+c9DzHkkunY+wn8CMEpFNTTbkcYhx7NZH9s6qVde+CXdOrEZpIRca0ZuZc3+sG4/0DQbH1+b5oVkDmj9jBxGnQtcQ7V2f8d2D8itOsp5TskVEP6X5mvur8FyVCOm1NNkXb85JcYv7U+hsNIkJuYxjI0Qo8IHo9tdpf1jCRs8qSZLVy4ZsNAJ/h/Cwf3M9MaFMRaObF3rBqyGb0U8uu+FGGfxFMjJu8IEv7i5NwrMX8ILwtkHi5lHRLzJI3JrLFQNCcuUensqKHn2DnPY1PWo0SZowqimZE+uhPGXeTF/v0VymfLE6KCJKKIBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChvaYnSq31zn4II/KNxflqvaFm8HXoU0uZPCNosZzCw=;
 b=o/9gzJH95tcr33TrKKZAsnA97gjm0xnoIaHAjUXSUKr6HL9XOLbitfPLImOpC0j9gWaBPzmZ9sgYUqRaMBXxfjgb91MFyt/5YkF6+RufP5Q93FklTRr+lLBetgx6bABs2csIovzfzIfAEIjB0AQeDtdc8L/gcj5vCye5+wwDh+A=
Received: from DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15)
 by DM5PR1201MB0170.namprd12.prod.outlook.com (2603:10b6:4:59::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:51:34 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::16) by DM6PR08CA0041.outlook.office365.com
 (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable mes support for GC v11.0.1
Date: Tue, 3 May 2022 16:51:12 -0400
Message-ID: <20220503205112.1285958-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f53d19c7-ed80-4aac-fc64-08da2d46b57c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0170:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0170663FBBD7FA341D951DECF7C09@DM5PR1201MB0170.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAjfdJNOpoe3waa4qRAy/9SngAyKQAGxFH7BnElXV8vTE2dVHItASV1qAw0LYF1sTlIvwoweauDQxX9Ecsqtx9+rBatjZIcbaZLV6jOnmv87N8X1Z6xFEkR22Zexr4Jy6ZIr6TFogIp2+m/6PIOiy7jqu/fmLL3OZUqS7imTHkJkd44L8AxZ926GoivdJl0zZds0nUybHVredG1RqYULI8di953G5SEjbm6VjSB3mCKAxQgLrs7HaEv3tP8kvPbLtm2+YoPoMy9fIbZGTvC6M7ocMjSKyt0mv3tKW5+/W0Iiio3FR2+KvlZXcFgxrZYAgozk2kYrJ6u8weDp8XvTSAcQYStIz7s+MIuNeC6X9FKkiKUT/jMPVS8/ov7coMg+UxJ3tl3vbqf6Q69PvpZ2aOVTOWCxGBQYED+q5odA/yStw9kMmcn7C7Q2QO1me22yXjxqv45XYh++++fRPGYLvl3kFjEsk1TsTXGIpov2IbELhC+bkDKgLBHtTYCw9QtQvQ3Kwp5Hns1C5wlQykpDEAAF+L02Wm9yomV4CXvbLw7lblKV0kuVGL9IzxiQdEdZY+U9adcinGyYu00DSJKofF3glD4picV1A0H2VneRIteJqCRQWNhpB2XZhyphqtAhwIz2FpD+eZGUQUrK8LLchYcXFIZF2haT2ex0c9O0+DpRVUpuc7SThT12dc8KXIbNm7DuAtIeO0o+rqs3+HowMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(16526019)(1076003)(426003)(47076005)(40460700003)(186003)(2906002)(83380400001)(336012)(26005)(8936002)(4744005)(5660300002)(7696005)(81166007)(6666004)(356005)(70206006)(508600001)(36860700001)(86362001)(4326008)(8676002)(70586007)(6916009)(54906003)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:34.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53d19c7-ed80-4aac-fc64-08da2d46b57c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0170
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

GC v11.0.1 is using MES v11, so add IP block.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9c44b2250a3c..263fedadbf5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1908,6 +1908,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		}
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
-- 
2.35.1

