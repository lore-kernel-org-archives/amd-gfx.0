Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7061EC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B22B10EFF4;
	Thu, 30 Mar 2023 19:43:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69FD10EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbqiZqRDWg1VpzjvqnrKF0FglAU67uig1ZuFvLRiFLJq6wXdZXvzoo6a6DStDp9w52rDCoEc54kwmJxiVGQ5I2CRxsynE2VjjON1x0Qv6q93NYg4KBtdtvW5ttEaFE0eKO1M8Y9nEhNwWRteXZpgYk9Np0aHA3B0d/3TS9bZl5ZrEhUZwPfRFtS69lXizT/5keiRWpa/5JS+/3/RkQKscKxT6tkLbAOTAOCNCpaJMqFLpJJM7sluJ20LKKRfQDnhonl+BYn8q4pgX8G2N5isJqBcLj8ZeSh9cqMLRHY8ehexAIeCUaurIZw7YIm+4stXhEVBXFcHJveoUwhyYifodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJGoSWvgNuBrr6oObBLdS6hV6friAi4Xr0ETy9l+vos=;
 b=Rn/ZVvycITV86xMSSUftkgp76NpZaMfsbSlZhdS0GFmjN+7ZLZ1cwX4MYJ1XaXUHKgX3RPPW0l8O3qVyZGhM3gf/pdwLizLuJyiV2bdy+o6gJSLUsfuvMx3GI0cbTM8bC4Qdy1LeCBZXdDMfe81WcYd3Q59xxtxya0tu87bqmuL1JdFkNO5xgnMzk+MPDnEr7PyrdL5iAke4khWWO937MHefB1wb4VFo2NZ4NWBcI5tS3+jxjihM+thTaivnEpER/+ciTMzlCeqv2QWoCYAxPow4osmh8r1DiMKiuNGuwyNK01VEgRP+/dyQXc2bgGG6xGFrowcOMkTsS7GwgNWKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJGoSWvgNuBrr6oObBLdS6hV6friAi4Xr0ETy9l+vos=;
 b=ifwee2AL5YU1v4NouEJIUPqss8izZ48HoxrQkSqlH8Ni9KqjukFIfpdNLH6tSCgXbi+khW8PMmRni+dDpEYcX9Btkijmefo4LcvUcj3pbFCxhNh1k+UGLnU54viyRYwWMwsKkuYwDqDwy1PEvBGFmuakuizur9kO6fUx29dGz/A=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:42:55 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::46) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/23] drm/amdgpu: Fix GFX 9.4.3 dma address capability
Date: Thu, 30 Mar 2023 15:42:25 -0400
Message-ID: <20230330194234.1135527-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8382217d-35e4-47e7-950d-08db3156f4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOm2Wuao1YSOHIg1j+NPMKFppWYniMMAxjk1cWlDxXH/EanvBlzNM/e/fEL4I4tRtw9kvMAmJ8xjGlhzN+khtemJmj/G/FRj6rWkI6MMcH7PeiBeXA2EqmI5MYVxKuLvccsR4N6uWN6SdPawW1BgFI5BMuHDdbJS7WZM3kIp9aC8ZNVllzTKFpnl4LJeUJltIX11gla9/kVLUoMKV4kiJK+aQrVTlbH4VUqnE1YAB8Xg81udfjAKO22gHGdRmOUD+WA8Vd/Ub++40XV/R7PnyfR39TM2dhWXbb8YmvpP65/4Fft/Ao1mcAZhS2AeArosn2KhB+XRhUhmPMi/LMpz6id8b3rXPyUKrfq0AXqUEQBhHApnSfYXDpPhjXd2eRm+vWg8VluqdtINVxnh/BNl6foaaI+DDC6iccqkWYEJ1gfd5c65DaoAUw9VH6y7WnQFe1e8rITSd2kuNs0cS59EyorgWp/atVYihl2wGwHlWmJCV8qSCAuURc8f4B0u0Qf40JWdVAoA5Jnfm+/5uV5Aa+uuD8MLPJct59mTC7/VHS0iszpPyH9AQnJQxwTnoWYck5VR8Bgm8jdDTWAOMTf9o/Ge9OQwii98v9cvC3VUZl1IxgZkqRR47i3rQ1NEJ5NKndSXJq+XEKaOFcBPbhL0+UBs2oYQ4UGnRoRPzN04CSIkmT2sVwxj85ccjEPo+6piMVYpauEgL4l2lYN0zDGucy1hy7Jt965mIE7YHnxAdRg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(26005)(81166007)(82740400003)(6666004)(356005)(66574015)(336012)(47076005)(36860700001)(426003)(2616005)(186003)(16526019)(5660300002)(8936002)(40460700003)(2906002)(4744005)(8676002)(36756003)(82310400005)(7696005)(478600001)(54906003)(316002)(41300700001)(6916009)(1076003)(70206006)(86362001)(40480700001)(70586007)(4326008)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:54.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8382217d-35e4-47e7-950d-08db3156f4f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

ASICs with GFX 9.4.3 support 48-bit addressing.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d9ad6aabd48d..c42d6e4e28bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1828,7 +1828,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	dma_addr_bits = adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2) ? 48:44;
+	dma_addr_bits = adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 4, 2) ? 48:44;
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
-- 
2.39.2

