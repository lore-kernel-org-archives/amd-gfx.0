Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6280EC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A526E10EB22;
	Wed, 29 Mar 2023 15:25:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3AB10EB09
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nALD+yo94U3JlPjduHE9ZV5zhpsXYbvPCMDbtt7I6mzYxk4/yb9e3/4S/qILnc9GlGT54jZ41xaGQJxjvGarF3moPE7RtIJVrZA5ch84amNWEBFi3mzRtmUrgqkzqSxnJZOvRvo0Ly0NPMYYWgcoBiM49RZUmBYhsqqhZ2HYDU0jPuj7pgJFfzpnUJLNzWlybzraswi1SdG5s1f1nfBuxksmwl34wfNGYgGuNN6KWXi19wbWi0bZplp040C0CJR2KJmoFejJxNX3fSvdb1DmtTN/BuuJAL3gA4gTPDhr9DoC10WQzP6FH2AXHmJp044dTjRKfsq4MwNfiH01UYu+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=O+ioK1cKq0urcrwrgR7QEgm6zHM1CiuxBppStX4LaKMPIrjOS9eakDd3U6EMW2iSpH07wycyUmg9gD+6MHCiOd34QbkbQ9+IEAoKwK2jRRY4BuBYO3CiYzkwSQ/GkVrMzrNMiIHrzharljymDfbvK4er6k/SDBIkHDKdmj4tJhlTZk2IVCj55SpQCaXfIgtDznpg6JZpfWUhonerA42IRnYLqAbs53XvsXNz6PbK2QlnZBA87PF2mo9YRb/0BHwBMgi1DNkQWS/Xz3HKij1qXFMs8okzUNsY2NzmQU2uvbHlWJzUxVZr6DLtYkBwNlEa86fnGqliXkpguGweR+mH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWJ5Z/aU+yOnmuaUBP2O0+l7owFFx1x+tDKzLIvxfcE=;
 b=iA4GiTXtxvVYhTUVMikuSPEbAAfSv3EcM91WKiyC6Eognv5nmFwQ39Riz0lu6Ig2JhXjgtAMj6MyE/tcCRhdQkL9xkmF2lbnYhhwGTtkx/XZtQzg//CgCdGdexTZeJwGd+Bc5fNQvEd/Pyk0bJv/hVXyPx3qU4YOkXHh0VWKcHA=
Received: from BL0PR02CA0121.namprd02.prod.outlook.com (2603:10b6:208:35::26)
 by BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:25:35 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:35:cafe::54) by BL0PR02CA0121.outlook.office365.com
 (2603:10b6:208:35::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 15:25:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:25:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/13] drm/amdgpu/gfx11: add FW version check for new CP GFX
 shadow feature
Date: Wed, 29 Mar 2023 11:25:09 -0400
Message-ID: <20230329152521.1980681-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329152521.1980681-1-alexander.deucher@amd.com>
References: <20230329152521.1980681-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a61e9cb-0cd8-4624-9aa2-08db3069d817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TBosxVAnd1EKaYMRWjMBWTcmRxzfeSqM8DiKqIwwdMIv4bHs7BGH9r4fWkScfUjAIrV/w/aTCcK5z/HGTJe0sKo/BcMo1ljKgoNSoctJzvxxs6zyWurui+GUHVzDEy4MWXrOAzqePm6e7hnkoR/k9JrDmZJ5U1kr908waU20G4Cy8XCSTyPx63stWzvquv2KZlZ8Ig+8VTqWOzGyJkqdYhSk9YiDXCM0VD4UTyDdMW3u6tXRn0mjz0ngguHlL8rNFD2WmRL1AP1FG3fJ6bxnFOL9lEEToCE6SzsTG17ho+DMAeKLaEArzJPVGHPY8zXE+M+n87Sq5AlXYOg+JsAGM8eJlZfD/AAtJtAtvmxK0X70sp3iHSnJJqWSURGIim6M2PFeBeK7ftMGeRuie2/iSl4Ujvw/gnNY762FX9w1NLG9yvy39NN3wyz0e68jvzLBFmCDuSKbBjSjlp0pbX9v5aoL3nHPsOwh0h0XN63ua2R8M47oZWoW05xlh4XhY6vXsUbYjX+2rSImOQqqRoEbZZnx64CD9RsEiwaxLxqDix9XGWj6dS479azKFqIsfTqlUpFU9MIYF7drapszAvYv/LcJnAK1GyfJ+2EpcWKeTRNHX1PL3cR6aHBUEVLJwCDZHTzdYmMI5Md+G+MkKxVYn5lmwcZJ558HT7JqoMC0g795Q00WcLE/2b51XxZbtDRhgSCAXWI6+2YowvDNBr3ERMeXVo8yupiPqAbf4Af0GQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(82740400003)(5660300002)(8936002)(356005)(6916009)(4326008)(8676002)(70206006)(70586007)(41300700001)(40460700003)(2906002)(40480700001)(6666004)(26005)(1076003)(7696005)(186003)(47076005)(336012)(36756003)(2616005)(82310400005)(426003)(16526019)(83380400001)(316002)(86362001)(478600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:25:35.7713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a61e9cb-0cd8-4624-9aa2-08db3069d817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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

Use this to determine if we support the new SET_Q_PREEMPTION_MODE
packet.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index de9e7a00bb15..4ad9e225d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -364,6 +364,8 @@ struct amdgpu_gfx {
 
 	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
 	struct amdgpu_ring_mux          muxer;
+
+	bool				cp_gfx_shadow; /* for gfx11 */
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ecf8ceb53311..a0d830dc0d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -463,6 +463,18 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	return err;
 }
 
+static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	default:
+		adev->gfx.cp_gfx_shadow = false;
+		break;
+	}
+}
+
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
 	char fw_name[40];
@@ -539,6 +551,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	/* only one MEC for gfx 11.0.0. */
 	adev->gfx.mec2_fw = NULL;
 
+	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
-- 
2.39.2

