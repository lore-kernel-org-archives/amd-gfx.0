Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D34C43617
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D247861440
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D247861440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C3C6EDA4;
	Thu, 29 Apr 2021 08:14:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCF86EDA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib23Zd+cESxPRJk1DkLdAeSJd6GOAxuBanMovyMeKOOBWtxIJhU+X5km/h9aYgrgX/xjjM3CqfFx1TZuKL4WE8d7SpFuwz16mw0orRFVfBXA45xSPs3W0ejYQ84xHfW1z7mIH3bcRD4Mw9ml2mjvipSU+A9mW2SZwrBhVB7MniD/+hQ5C8qLx8+YLOQQPqd4SlYzvJXtvYYNSXMZt0NRmCClkZJ3Ui0iEBygUI5tdumL4oMvVr8w47I5/gLPeDszERxAeq9X36HOSD6OdCIIWvXZ63AyqodaX8PjqG07X2gz76ysnHflpQoX4SngC/eMdYF8ZrU7a0QQi6geKDmQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NboTB2n/kf3tfGjYS7ld57XMzTOP2BS26mPUBdn47E=;
 b=QdxKaJs9GdT8n5UF0pwJRD414bKyE9ydm2PMUrK7E9/oeMzSxqJNPzPkkaxyuppMxmjY85BBg+kBMG1CqfVOWHT3ljVzc0FRKb2K4qePguykBmG4XDFBFozTOqo7GAjvz4ykunYiZ7SiNT7bK0b1BiZ7wOK4YiskuPOH1hykgTuDoEgZr/hBAuMkj7UdPATmtaQt64I40UWeUTdNkR93cHk576WTV2b9zp+sroHa3uwwrpRHFoxHDIsAO5X55pimOMKWiZs3f55NGJOePSAIqpjq53hOrMjRlgzO6XNgofHobGSjqPfn42N74rYNep75XMVFovfPFl7fmVmaPl4ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NboTB2n/kf3tfGjYS7ld57XMzTOP2BS26mPUBdn47E=;
 b=vcug0IZe3KxNuOeF8IE5V4f/VMR0+HGhqvn8Er560rO1W+WEVFvCt/SKt5AeNINGDeVxk907cUttc+2Z+agl7qJ0R2TgJZdkN/RaE0KYXJRbHM7KiAcyc9RiiAoJqd92PhscYEpmS3QhjF5gmi7NgYjElE7KT7vK+fYKGxdydF4=
Received: from DS7PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:3bb::12)
 by MWHPR1201MB0173.namprd12.prod.outlook.com (2603:10b6:301:56::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 08:14:20 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::4c) by DS7PR03CA0067.outlook.office365.com
 (2603:10b6:5:3bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Thu, 29 Apr 2021 08:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 08:14:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 03:14:20 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 29 Apr 2021 03:14:19 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu: Skip the program of GRBM_CAM* in SRIOV
Date: Thu, 29 Apr 2021 16:13:44 +0800
Message-ID: <20210429081345.24217-11-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429081345.24217-1-PengJu.Zhou@amd.com>
References: <20210429081345.24217-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5318e5e0-040e-4a86-8fc5-08d90ae6caa7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0173:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01735224546EC3EED6F6EE6CF85F9@MWHPR1201MB0173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY31qupNgQMMal+VFfEvEJlbeloelXvVnCo3s6bXK0RTwBG6CHGvUpgX/zLnSmKJFPnm+iPMx2gBpxBH9Tol0IWJrMS9MDvPcSWp939GRJf0/G/OXjhnz5vYhs+oyIsP7O7P2po6CYlYz0Bf6me/5iNX8mken3hfVeAJ8r4kuRvzixLiZSWkgQ5Z/gJLQsHwM8Z7vITM3hUNUcQWXHQ5S5YMJyBDakKCOXTCSMiNxBWrYVQlaOCCzfA5fjaUyFfLxnb2DxoebnVMtGLYEJhRhgy1eLkdxxAtey8HBzByTbJIQj9LVPpgOTsyF+eYFxHIlHeqf0vrbt5IJKG+H5bCbU31DdWUl1SwsZnzUE3AwvceEiAge0iqmnPxUi15+MNw+WT3/Fpqoejcru9FJTxAVf7Lk6qLvTdokmiXh9Mp7g5s8S5PlfWk8JqBPqDHkeHHeF5Di8bd7GwCVCFd7spD46af5YxsFd192X/KN0twMaDe6t1FikL4+K0E92dtf4QFJFiUmeBGAkpW3MRtEOnnX3IcUcloWdzItgXfWkQAKLjiUbmgRGXT75vJHycyWa2FZPSfh+l8/vBYcGlRlil4RtJ1DT4h/WzR+BIQ90FHwkTB8gveAgovNRL+WDTUvZMZQTtTBLwmgPx1vg+0JcE9bYyk9fz/3CjZlY6FspDhhZzF7bZQqADPPXHMSTzTltuF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(186003)(36756003)(70586007)(478600001)(2616005)(70206006)(7696005)(26005)(1076003)(86362001)(6666004)(336012)(8676002)(8936002)(47076005)(4326008)(5660300002)(4744005)(2906002)(81166007)(356005)(6916009)(426003)(82310400003)(36860700001)(82740400003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 08:14:20.7381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318e5e0-040e-4a86-8fc5-08d90ae6caa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0173
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KMD should not the program these registers,
so skip them in the SRIOV environment.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2ec9701544c3..f16c9bbdee2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7090,6 +7090,9 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* initialize cam_index to 0
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
