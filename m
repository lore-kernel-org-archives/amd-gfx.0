Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AA66102A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 62AA66102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1DD6EB55;
	Fri, 12 Nov 2021 16:25:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64426EB54
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 16:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbN7kHpxGs32CZU5CTo2e7YKs0RMtCEyoUeJ9JgH8VfFZqoyWDbKcxcEaaLGh+QRH7LmbS3KwZOLquA9NDKaqFLRuc5b9U4L+kgO5unBjqAIiES9NaSuMzuHWzvFT7B5rsu529VR7XxC1LGFZ/PkKfmimKdZOnP2p0JPYbhkgslRqOWBgQ20hDvB5z2IANQGlt9LN1iyugaoIMCHD7tW23cQB1LDwg/0tESwHPVxC6VQ7qWathqrekfP3GwmiueIcY/iGQm1VmHoFXOotljErXlHOFLpqF1WdzYWEHhHPPmFNgeFMiSfk//5BW8vPIItwz4UNjH0IzXZimc/8HmWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGM4wqMiMWmeLBox0j5SZ9huVYO5K+BQjiOCKrG+cIQ=;
 b=H2hQ+LI0Shrv93K4jGvwsXDj4vVz2YHwxo9LrTgtfbAvImok0b3FDghl+RzTLDdSWv8Q1mTtXsZg14OdQH+0HO4EiTvnrF3y5R5uNxaTehdnbOiFrjhcxKHu7FFrPk0MVCmQvFYFYO4DDrHTOPGKAIxW65hlWNfNIgrp+QlNEtl+U8au5FIPPx2oTWnHziNab7p4fdsteac7C/ZBplBXgAG5TMSIAgmRLhjaJ5zHS4JjxYE+QRiTZrmTyXcS5KG+dDnuSlXz9tvwvOOwV/RUck1xNPhTU+zQ/Q3DQ5lK16U3oQz9g5F73bAYvzsDczppWjOW6iqE3LYgTnjNVmjWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGM4wqMiMWmeLBox0j5SZ9huVYO5K+BQjiOCKrG+cIQ=;
 b=YyYQmP4iYahDn1jVeGo5aagxjCc88Fk960apyTJ+n+tmkvJ0hVs969alxPUX5Zb3/bolEm5VQX+93fFuOkRAqEkyph4KvceoWAo3Q1hSrTyrY828rFnMBXQdv/E8dlAALqO+ZjxfJQ2+U8CIQxkaV5XCxoqMtGOsyMrg3sn+b7I=
Received: from BN9PR03CA0296.namprd03.prod.outlook.com (2603:10b6:408:f5::31)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 16:25:42 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::48) by BN9PR03CA0296.outlook.office365.com
 (2603:10b6:408:f5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Fri, 12 Nov 2021 16:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 16:25:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 10:25:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: always reset the asic in suspend (v2)
Date: Fri, 12 Nov 2021 11:25:30 -0500
Message-ID: <20211112162530.149709-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f71d3ae-44b1-4c0f-c8a8-08d9a5f91297
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44860AD8DABF8BFE9485CECAF7959@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xin5Qo7yOFYKK33ooURz78b9LBci2HFYzss/xjhluOV/uTzMWJJMSMu7oFIuHmOdK3mnY+Ah+p7wop2OyayGQ3bxdOCP67KTEeLOFjkM0617UbqCiJjFyzYSY/CTM7E1aJp544IiaMCXwlncIh5I43c/+grMzu7ZZzs4qFKpzhhN9ZmEniFVCcPhO+iC32ryr53H+pR6YZ6q/k3CgOCtPx6v9XRgWxl3PzRZ/YtvueGsjvxSMBEnoQDY6XPixgMt9zAr2tLd45ddEC34iCGGdk/51AgSmF3jah40GLMUwle6iXqJ9WhTPYRqcIUOeb9eoUS6a8UMlwWejLtSAJdP4P+3gxIfoPmeVSVhB7FSw5kLa6xlRRqXw5Wn/Y41Rw+iJeD8v4JSue8fi9UbJJy7Ybi/l7GM4U3d8r0CJf9mVQDnRDIpEwwsnLXzsEyAsjHYyjWHehFq2V4ili+hYVqT2v7r35Z4+/jtGrM4tCRnzjUS+RuRTUk8+G8YKTiuDtmR4KhtgLe8904R/EGqKR1g6qClIg6DcAc3o8FUvn3sWir5FIg6diLcFTSrePA4kwyj+KK1+KDVjMlOQKtIy2eSPi2t5SezEITcGeJHZDsi8Q0sEtyxJIs6zQjxKlcJeyret2KuTwLfHSnJXOotF+m2bo0XT34lowy9cJqx+y771M+kyAP04A7bvt5LApjEDeMG9V2MtKA6cJ6rTtfuhztCbSwMZx3aKIwM4rCqUU+rAyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(15650500001)(2616005)(336012)(186003)(5660300002)(83380400001)(356005)(47076005)(7696005)(426003)(81166007)(8676002)(26005)(8936002)(4326008)(70586007)(1076003)(36756003)(6666004)(82310400003)(2906002)(316002)(36860700001)(6916009)(4744005)(16526019)(70206006)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 16:25:42.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f71d3ae-44b1-4c0f-c8a8-08d9a5f91297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the platform suspend happens to fail and the power rail
is not turned off, the GPU will be in an unknown state on
resume, so reset the asic so that it will be in a known
good state on resume even if the platform suspend failed.

v2: handle s0ix

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1db76429a673..b4591f6e82dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2165,7 +2165,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
 	adev->in_s3 = false;
-
+	if (r)
+		return r;
+	if (!adev->in_s0ix)
+		r = amdgpu_asic_reset(adev);
 	return r;
 }
 
-- 
2.31.1

