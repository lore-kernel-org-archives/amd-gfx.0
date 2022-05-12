Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F9B10F172;
	Thu, 12 May 2022 03:23:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DE210F045
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDqDkdQXT+BVyugB0y6H+NwWulcOdjnV9WFNPytd4uSX6YaqNAN6RlIKSfY47hwQg90pBlvFqL6NN26oQeokXR8aQ37mR3lJWW3m1ZXMqxZAnG76WnFDuNIS+I6Np31KjFesL8zy162ausKLTBQUjMevskpa0fWGzJLHY3jXR9Mp++NqN/qjNojIO7+5rqAgcT/Uk628RcjR0fYm10TDy9SsazRIYP/yPFE827QxAOsHSh6GDKakNdKon9rN2Hy22MggZH/81PZGH/mNDj9P4nbU35chgjq3HupC9mVi4IyTU47V4w2jrtVVJi+oP806+3bi4WDOvA54k8WuY+bSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZtXUmSvzGcQik6GVlGyxxpJ8BZb0vJ9kTDJT/5F8io=;
 b=EsbfJAHfm8eWuMqaPwpl6PFJK1wkqrFJntBbBQ8PS69cPC1ahQBI6NuMJIZ1bq8K8l4BaEOAFHPM+HHFX7GXiAWJoSz/dxvsXxBp2jt3ptDUVVxyUY3v8+PHFzp3zPV3U/mzwLPatkABb1MpLsE/FqjZQgegE+OEeKNeN2AuAGI8JmHktDy0ja2kjFP18cgWkzR91eqSXc7TQN6ja+WMcu+bUTLfAEGtun3o0/P0FKcdREro1fyCgxM4YwTrkdAuMvdCzsRPomyq5O2gZCg32qR++FSYgFkiX9YNL8djumJouNpPPmtOfRQwMS+Pdj/jPDF7f1r++8CCqGnTU+AE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZtXUmSvzGcQik6GVlGyxxpJ8BZb0vJ9kTDJT/5F8io=;
 b=X3pj3KlhB/c4XtRGwOOJI+nRLVLAQHPjxhQ85hrpx8HEEcHl6lO5MYo8uZ9pzi+Y4rsJxV1WmGDX4C3eK059HAM77iYeZf4mBAd1y7ofJbCpyO+/Fuf2bhOhrlwDUdS+BrQb0N79hvn+7t9ERJdx5juLamqy39llXGq3mQPAdb4=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 03:23:08 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::1c) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 12 May 2022 03:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/8] drm/amdgpu/discovery: add SMU v13.0.4 into the IP
 discovery list
Date: Wed, 11 May 2022 23:22:46 -0400
Message-ID: <20220512032247.528556-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad330d7-45d4-4e91-d0c2-08da33c6bc1e
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6123:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6123518A44BDA0E70107FAA7F7CB9@SJ1PR12MB6123.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEbmvlPDVp4ftDTRvxX9hpNIQOEBfMC5CvMj5L7xJ90TZ61Q9zk6VYf/x0cmjhkxuLuY0LQNyyYSCxPbhynQ+pmYWwUP5e1w+lAz6vwr443xJn5kwAMqgaM+cXWKnZqtGLQdFmPufDztMtO+sy/Sd1aHrkxOhcPia1JalZpncD8Pbai6vr49pd53wWf+/Woqc2vmz7lxdhGNCKJMQ6wubx8xP16aqQsxl7AiOc5JMmQwLnuj1ou7s6kMemBQvP84HyHVbJIDZBrmgZkuYCkCz4BC3VvAG1xujg0kMqFXpzH19EWh9WvKzukLs3PUo7pTkB3yh+nKEFKeziYMZkYgf+he1C9HRlu4bFQJ7IVUYsJJq4J7YYFDUp9lQ1AIsd+w4T/Sp7pRNF6Le8aHcfAzW6AblKw1mabKfJjaXeKN4ltEMqKaKEGdJg5qwmYKVNjZBiBqyNKAlG94AiJrseds+ys48lp/T3jjSOvr2UHYWyOsaMHJT6MhVMmcMFh9o+lCHQ0Oz74REwlqaPr4ft+LxHVV9UWx7NYOucX1R5jtbRpu+pm5MPNJawjxPh4LXHY2axWdAefP71qxftMrUkp2cayhs/0UMidSfYOLl6O/JxsgOKZ/1ujGPnOAyaglijOhYv0lVxf2e+/HQGCy+QRFI4Z7VvUNOy2LT2IDRcCGSytzqhkGMWkAIpVIRI4G8b/N1AgRzLIrS/3z8dJs+xPbMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(316002)(2906002)(356005)(83380400001)(508600001)(40460700003)(186003)(26005)(16526019)(426003)(36860700001)(336012)(5660300002)(4744005)(47076005)(86362001)(2616005)(8936002)(6666004)(1076003)(36756003)(7696005)(82310400005)(8676002)(4326008)(81166007)(6916009)(54906003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:07.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad330d7-45d4-4e91-d0c2-08da33c6bc1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch will add SMU v13.0.4 into the IP discovery list.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d7b0fd1cad62..881570dced41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1656,6 +1656,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
-- 
2.35.3

