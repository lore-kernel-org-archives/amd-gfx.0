Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76DFC47DDF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 11:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A215710EC93;
	Thu,  1 Feb 2024 11:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWpb1Yyg";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 152BF10EC93
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 11:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaBo6eHOSrba6v9q15hLrB4f5uHF86FMJqwfzCVFAieEIpE5CK1MpNkRZyGf5qSDRpu8Jt53ui3xiqWF8bSihpLJaqgD2s2oGX5QxjhIDEotOeOmP5YnK+JgtStR7RlFvN5gWXG+BThpqx/No7zy3ylEb8D9rtqvOo1BiUiL7rtyq6+le5isH713MjQN+Fh2pdLs8HCXLRzEUbKSz9dBQd23SccM5md/d2OyY1/s/mRCeUnAyuptEOGZgVaCwTfuJsqekvWD9xG8xqm/zCwVodls3k/bNAUjU4odEXfHbPmnZgdf0l4zyZSt9Hb+L9jJTCi0VahWwSpmrbglpTqjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osMiDaeUEoGkIlRJcCJxLzj+k8dyjYLOtW9/Zo1l6B4=;
 b=UwG6bLQJ1idhCnMFe+MVRsMYXkbdCKw5r3umfI5lIq9QzAt1v7+iWyP2BuosKpUSSSL4r+u9goIIPESHNLJnFqHaW6GYuyi6SVzw9maNp1+8bjquqj2Xid4dD/fP5cngvPMlMUNQSAfErqn7m+AJYuo8PogxVNIqu5owbseSVbaWTo66Wxq20i9gVZpoohEwMD5mK2dFMg5KD/PAnrflsOfUfJnXkNPXU4NExqm+Iof6PThtsUisOynHd099Pq626nfVndm5FlDteMeAV5YYOw6Le09qi40NLqkt80TR+dJjx64J2vDJdqZSgt4QEP7b1FaT2KLz/5PrXJvcbybvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osMiDaeUEoGkIlRJcCJxLzj+k8dyjYLOtW9/Zo1l6B4=;
 b=cWpb1YygXcP1+ILWU1KXMfLTC/W/2INpym3gFdGNNSLfJRfuadvkrUjgbraGbxcTFNLp8Qp1O6OcKq9VRhDSw/FA1uwHZ3xweEOqSl2hy/xeVvt5IAMZwSffchLP2WbgSyGCQAgo4CYxbCqLnP+dCIpa2jG7osdlm1y//4eaNSQ=
Received: from DS7PR05CA0099.namprd05.prod.outlook.com (2603:10b6:8:56::20) by
 DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Thu, 1 Feb 2024 11:56:09 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::8d) by DS7PR05CA0099.outlook.office365.com
 (2603:10b6:8:56::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Thu, 1 Feb 2024 11:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 11:56:09 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 05:56:07 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.5
 suspend
Date: Thu, 1 Feb 2024 19:54:31 +0800
Message-ID: <20240201115430.4180149-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a37a070-5c66-4bf1-0b2e-08dc231cc7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oW3yO2hTxyvActO4T2QxlhF90/NxecG66fs2pTualW+/i9V7BeBiZ+4kS01C+4gL6lvvMb2YSn8SULhrOAkvLaLk1THABr0MKZwh96OPCpEfjdiuShaG8WzgZgQ1d++hw8zMiIYcC9zdxuJ66Wz1zQO4SxI0EUrOKair3GJ8SGVBwdanexnjNcv+GwFWythfgf4dRYBBxhQ51NrXjmAj79QrEMWhdClWdLa9h3iTLegZAB6IvNxPqvljx5xu2bLJ9LZEIGsBUxCig8Aw3lnW6BKCGqtKUsUScqeEV11wN4Lf3ewcd7vwRFBcs1eIQUCoSIyxBCOFPRq4Wa0XKCu/le7Nmwri21dqpEh9paEySHWLiRQnpXfgke0ytcNesWJI03X0u0pFNJTY9vuMUI2oigLQud786R8eeZnGxh0U1ziXHrhtp0T1GbvPAxq7w3K7EqrtaYfWellnMQiKZ8+rsHbXpviu61O6Hi4EV6YT22TNynhRkpvlxPMf9OmNJ8QDahuVYcMDZArUeOJoNVaPjlcOeVbcGTT09rVJggB/c2wyUfcu/0+/dgguv7Om4JI6z0Wnlt9E6N/DFTnUInDy4+RcTm86wYvicWBOUUyWJEnwhXydLhNcryYvg5phzyX3iDP1I8mbRV00ow7ZMS6zMDafqSsMqeW+iEGwjC5dCcT8rPmwvC5tFNOHmU+WDNWJUd01aqGjmguvd7kHD1xwbOdQY4AbGvQ1i5ZYvJoAZ4NUlgvO71DMYWCFn9q7WAcAU2J5ar2hHHC4pDF7sMiMy5c2XAhYBiLRyerG5+wkZAFzYVk4ivwqUYAGprgSQ1rP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(41300700001)(36756003)(47076005)(40480700001)(54906003)(426003)(70206006)(336012)(70586007)(2906002)(83380400001)(8936002)(40460700003)(7696005)(5660300002)(478600001)(36860700001)(4326008)(8676002)(6666004)(6916009)(1076003)(16526019)(316002)(26005)(2616005)(86362001)(44832011)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 11:56:09.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a37a070-5c66-4bf1-0b2e-08dc231cc7d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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
Cc: Alexander.Deucher@amd.com, veerabadhran.gopalakrishnan@amd.com,
 Li Ma <li.ma@amd.com>, saleemkhan.jamadar@amd.com, yifan1.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A supplement to commit: 45fa6f32276f7ce571227f8368cf17378b804aa1
There is an irq warning of jpeg during resume in s2idle process. No irq enabled in jpeg 4.0.5 resume.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 ---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index bc38b90f8cf8..88ea58d5c4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -674,14 +674,6 @@ static int jpeg_v4_0_set_powergating_state(void *handle,
 	return ret;
 }
 
-static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
-					struct amdgpu_irq_src *source,
-					unsigned type,
-					enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int type,
@@ -765,7 +757,6 @@ static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs = {
-	.set = jpeg_v4_0_set_interrupt_state,
 	.process = jpeg_v4_0_process_interrupt,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 6ede85b28cc8..78b74daf4eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -181,7 +181,6 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
 			jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
 	}
-	amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);
 
 	return 0;
 }
@@ -516,14 +515,6 @@ static int jpeg_v4_0_5_set_powergating_state(void *handle,
 	return ret;
 }
 
-static int jpeg_v4_0_5_set_interrupt_state(struct amdgpu_device *adev,
-					struct amdgpu_irq_src *source,
-					unsigned type,
-					enum amdgpu_interrupt_state state)
-{
-	return 0;
-}
-
 static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
@@ -603,7 +594,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 }
 
 static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs = {
-	.set = jpeg_v4_0_5_set_interrupt_state,
 	.process = jpeg_v4_0_5_process_interrupt,
 };
 
-- 
2.25.1

