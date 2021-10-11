Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6089C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C06F60EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C06F60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475BF89193;
	Mon, 11 Oct 2021 15:02:37 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588EA89193
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 15:02:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob1rHsIrqo1gVMUfFnH2u9X4va905SS//T+jgmuMsV2/dqzKaMctQlRB2fnCSfJM90upOHkCLOw6Mq1rZNGw96cUN33Ennq9GI+0oWfZ3iCGd+YJB7paP1y7IE7V9y0eeu7KSN2F7k5z6TEsdNPBsx5tLtmLkkBx3vU8Oxz2Zv3rrb5Kna+Ms7VLfAwuP8Wu/nepwC23zxFHHzUhwUBtCfod2VyDzQVmcxgLK9tdGXtTh+axyUUcVgmd9oZv7VLlN419il2ZunK84MnBkGuSLV7KntsGlyYi/SWQik3hmXr6vehuqg3gtYpauwt0RNnGjXl8Xu8UyfpAv09CuiP8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra1piNRkCYUbyxmTuHMH8Yz5zF0pllA9zQE8NoqCKTs=;
 b=WcL28JbzcUPgjl5G/tYtws/VbZN9J+yaZtVqxBTp3rrc5fEJ6rTtzo2thEeDq0WVWnuVXSxPr3LC7hV6oYWmOPYIKs+1FhYa5hXhLSvPeZOCVyfYVLfBtVQi/jn+MFnGbaAOInilvJurJD2Ph3puTiJ7Z5IdxTT2Nv7VSS2Vs+dRKmTpVQxZbPTapLtdLZYOerDtNPqU41mniCAoJF9HdJH57gMGgBVUNQuZnU7azrq96Xd1GGwrbti4Fr2jCzarLKjWA4BU84sWThdlMQwuBEwHpIj3cA+ixrqXK0CJ3hAVSx12JRxtxvgtTxdycXvJOCmRH124HD9LEvBOW/TRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra1piNRkCYUbyxmTuHMH8Yz5zF0pllA9zQE8NoqCKTs=;
 b=lO/JcEHLz6C2RoU9gGj5vp1ZpH2EmGvahpJbcBoZB0SgL4qPj82oVwxggdraxh8KDs/17Hk7Rr4xpM3Ust/JY7fDSS/kxJ7Gmb4TRcPmG7Nx6/5ByKnuQ84UWEhid+2q0r6C1itotR/xH3DyZtXrI+6cSXhGON3ncg8EBHME3lc=
Received: from CO2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:102:2::17)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 15:02:34 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::4f) by CO2PR05CA0007.outlook.office365.com
 (2603:10b6:102:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Mon, 11 Oct 2021 15:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 15:02:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 10:02:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdkfd: protect hawaii_device_info with
 CONFIG_DRM_AMDGPU_CIK
Date: Mon, 11 Oct 2021 11:02:13 -0400
Message-ID: <20211011150217.165699-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc05fa90-3237-4136-c8a3-08d98cc82786
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:
X-Microsoft-Antispam-PRVS: <DM6PR12MB412104B81540F142FD96D76AF7B59@DM6PR12MB4121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1icYKNi2V6orL/mVt+Qduuxg3ljMWMjYfLt1jSc2RRFSWno9PCoETFq1VYpqIRq67kfu7qvFtx4yFl9pgF2jtobT8npASCw84sHg0dOkQKCAjzJsSUS9ILqsa7W1MetT39gq6G5QTbCtW2GumZsbfLV43PosHIRBI6nsVSXjaB/ycgQ1gqh+bFwMO1OjrGbp77bttiMqeFvpAR5Aj7CVGk5PwfzFMQBxlEzUF7CIgqHg9oMd+lGR/2M4EtJlEOaWcv5ah1RmbLUxAoRtUoce3h3h4GC43NtsNONztxXzeoGl76hVGMJPMK+f+LGXPSkzqVH4jPkOxMj9ymbSYzaSc1CgtU4juPzBRaF8U0NL0sBn/Ju9/YJRWYUFKs9+HxCfoqDTIV+/2HSzXBT1q3Ye/foHZS1KjZ6rcXqeb8td7OjIADTAX3yx4cLJnpSz+fZRu8velq7ejkpvJeGE1rPvJuCXzpsEd+HonOpyyEE46TRAJKzHVp0IHeHwJ1vxNXPfqZ6qYpv64zIQJ2fNlkFN9KXwP8BImnZ9+ISSJDwwUr6Io2tod+rDLlN8maU6xUCfzoFVtDuLHd6q17JJ9dcxq2q6tS3IQnIM9TehgJMCDkwfkqoyfmaVgcn9Bzgh3jO4/X/JbWHGmz5+Ml2+hm4xPYQRVlKxYxuu2TFuSqyHVgI0d2w2czAu2DQze7hzVUB+j+gm0hvDP/lT5wIqwr0qLAmXTDgmZbVcI4KTVQ0C7U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(2906002)(316002)(356005)(81166007)(47076005)(6916009)(336012)(4744005)(82310400003)(4326008)(508600001)(426003)(2616005)(6666004)(36756003)(36860700001)(26005)(16526019)(186003)(70586007)(8936002)(1076003)(8676002)(86362001)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 15:02:33.2699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc05fa90-3237-4136-c8a3-08d98cc82786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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

hawaii_device_info is not used when CONFIG_DRM_AMDGPU_CIK is not
set.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 064d42acd54e..31e255ba15ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -114,6 +114,7 @@ static const struct kfd_device_info raven_device_info = {
 	.num_sdma_queues_per_engine = 2,
 };
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
 static const struct kfd_device_info hawaii_device_info = {
 	.asic_family = CHIP_HAWAII,
 	.asic_name = "hawaii",
@@ -133,6 +134,7 @@ static const struct kfd_device_info hawaii_device_info = {
 	.num_xgmi_sdma_engines = 0,
 	.num_sdma_queues_per_engine = 2,
 };
+#endif
 
 static const struct kfd_device_info tonga_device_info = {
 	.asic_family = CHIP_TONGA,
-- 
2.31.1

