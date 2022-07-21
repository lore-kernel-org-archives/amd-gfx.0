Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EDDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 17:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D788E18AF04;
	Thu, 21 Jul 2022 17:27:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BE918AB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 17:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQxE6qf0C9oLeoBvCXa6nhzO/cpCAEKbWZb05m3+CSgvuGnIp0PWLxkJhQrryOiDjfkIH43dp4NVCRVky0t0YGF4c1q9+5oq4sqkAyLHk+a2lMbDlXz4c0oRYYsVKksN77NFS6wsZxZYcvngnvgDRSbL4TC7kfeJNsWHOYLhAbg8mLTfzeT3BM1rkxJdM0YvHVVnPYepLhiOtjavSH2XiT9LpCogdZZjkvm8CHQLyiQ1aqZpmoRvZ7Jzq7g/nXVM71+gpU+58eRIGWEEEXzfSkiZTlKVa5rGUSM/c4tjMQtNEboXKZQwnY9STH0ac0rX/UdCAuebFUbYX8/6c3886Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J4zn4y4L8t9ccLGoXV6NpZ67PTsuZ8xKu9X6yusYug=;
 b=I98/EadvXc/ptoF5lM4uKywSfipPzUdzZm9LQjIVt2VK/VH4Noxneray1DPRjQD/B056/sdVZSD0l+B9ySbeV3nLzTwOwdDHGeQgqraRxffw2I1IOBlX9v/XrWDjGjz7RLyp4aLqQPUlhmHzdbfWKV+XdErq9YCybp/0zPkp8AK3D9LrnZvMIgx95DsW6hGDkvh1y8F3rBG1hAy/2RhGimKofrpE0jothHbSvyru2FMoZAoDHk0drX6MzzwR50WyF0qYKJTysqaz0XYSgNd9Y/tibKYguLhFPldLLZwZ5ZH/+JOHOSOpYoB3z+QD/ixnw9rgwfthPqJQf5rWouq+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J4zn4y4L8t9ccLGoXV6NpZ67PTsuZ8xKu9X6yusYug=;
 b=ZDjBoZ9bJ9pJ7BgZvF3R096gw5JnSOnB1jVtFpxnU4T+oezhFlr6WOvA6Ap4FoG17ZfO+oLjCztYydA1Se5b/29ZgX4tcrUMFb8/GtWqejhqcicd6Ni7O1JOLazCfBzMrgjEObIf8zmDT/qjbkS5lfLx7/Oml77Fb7uWI8cqGCw=
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 17:27:47 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::34) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Thu, 21 Jul 2022 17:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:27:47 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 12:27:42 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: add VCN function in NBIO v7.7
Date: Thu, 21 Jul 2022 13:27:09 -0400
Message-ID: <20220721172712.309984-2-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721172712.309984-1-sonny.jiang@amd.com>
References: <20220721172712.309984-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 304f2c31-a25c-401f-a7a0-08da6b3e5448
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEzPp4o98EBW1N2ZVeTWmSOikiUdO+n4Tp8dCU9xbF4Rg3jTwF55/kLAlGAhHXMbWbiQfkEe66dVng9rgNe3QeCx86mEXbTQO251u0eRWk8aP+R+XUmyQiUW8T5q3Hchq6Q1HgW9CZ99FUTw/f1N37KAYMi3PG2Ijw+bCf/M8up4vv7jlFyliELhz5oh3uLv4GdkDvdEcBeqeEH6mLDpFBznwkil8wojvRmp1jzSgKspg66JzsCVyiZUIEKmMRcVOTjx+gS9U2bQRvL1SEaECpsaDvD7LpVRkIAHS0npu9vE2bqCc078vlghZUTDYO2LlIj3GKvTRI56MPozrLQYD+1O0MEuijdHhmdUWEndI9GulENuhh1niAfZMNln3UdmkYSBAkcjGHNl2CLB8bsBuDFjn/Y4r9T0MxWQzVMdqL8bIZvsqGU6jegqec2m8JyG/B4bAaHjY20UEH5P/oBYIxn2oUPrBoGnRmOR3+SdYKvjkB6MYAnI2Rpx9td1I1VJtHRTri5lKk8a7dvdFcZdoV3sFljaoruavrR9bWpenK2fw+nq4CRv+jVDpqMsW4vy4czC/+b5uQYTQaHbA7KNQ/G+DcjscEhhSawLoo7zW0UX7mB/Xhba/T/Je/eZ7otoAyJTazGUPV+xNQ74P4oYB54HIVIC+qTCdvuvF4MR+KoqLkgSQ1tbZ/h38+UZXP5wYq7+jCjtx1G3luDUr+1bmZFfw066jasXnBhV2UzlR6nxjRpMfeI6dKBAW18QOjkLWVILSPpdkAB70Sl+9d26Rzo+oZuAOBRiieowzEIeBShwWgXeR4GTc2YdgUhmYPlBhY+8oBsxv6qoxy6VI8GNbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(36840700001)(40470700004)(46966006)(316002)(82740400003)(36756003)(5660300002)(2906002)(336012)(70586007)(8676002)(4326008)(81166007)(54906003)(82310400005)(6916009)(26005)(40460700003)(83380400001)(86362001)(36860700001)(6666004)(41300700001)(7696005)(478600001)(70206006)(40480700001)(356005)(1076003)(16526019)(8936002)(186003)(426003)(44832011)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:27:47.1757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f2c31-a25c-401f-a7a0-08da6b3e5448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add function to support VCN_4_0_2 doorbell

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index e786b825cea9..01e8288d09a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -83,6 +83,26 @@ static void nbio_v7_7_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 	WREG32_PCIE_PORT(reg, doorbell_range);
 }
 
+static void nbio_v7_7_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
+					int doorbell_index, int instance)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN0_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 8);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
 static void nbio_v7_7_enable_doorbell_aperture(struct amdgpu_device *adev,
 					       bool enable)
 {
@@ -238,6 +258,7 @@ const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.mc_access_enable = nbio_v7_7_mc_access_enable,
 	.get_memsize = nbio_v7_7_get_memsize,
 	.sdma_doorbell_range = nbio_v7_7_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v7_7_vcn_doorbell_range,
 	.enable_doorbell_aperture = nbio_v7_7_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_7_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_7_ih_doorbell_range,
-- 
2.36.1

