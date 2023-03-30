Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBF0C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA17910F007;
	Thu, 30 Mar 2023 19:49:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6038410F006
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3YumFuW88RZEJRBy2vKI/abMahbPgwMpMG5d+lckyjDW2eiyA+ZPH8TNGCCCQqhTlzuB0rn+Tm9Z07lJ53t8Zoc38OFjkspJ6IguJSHvsQw34zT7Umi/bVXmoWthC4NKyre4muZHTKTdenHAlmwDNnwWz8EZxSzrzsvDFYD9XotMDUzIhMQQopubJSNTM7vzPj6s6dpWHk/iB6HJLf9ZcNny0HrV8FI8dlNVqvwLAsGkPZdOBHjpJjJnH4yhhhnLWkl5ne7MbRp8ypxmULNvcitf859swZe8GoVNTf6GmWTs24mTelxdn4WKxd8PI+uI5emlw15W5256+bCPPTNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLOpmEyCoBR0ySsy+t6+K4KzuLF9E9lyCkBSXZHLArs=;
 b=hgwtQDx7dabsr7wx6bWyQrUJuVB1b92fHYiL82NTto3LTE5nAFxuREbmcuBlVRpoasU+jk75l6pGX373tsgMlfytDsUI3acXtGl4krRHwiC7NAmJUb2Br488dL9WANcQst1KUICHMTRwfFcYRKl1f/2SqwlJlMj16vBwl5zjK+t7a5iEjKbmH/Tf7SJsNjHwta80BURyKY8NPgy9vISmqAquoHcEsWLaNgha/qJdD3x+Nr1UWAkYUlCgnD8IZdAWB5Xrppw9vFUPiT0m+XKBNd7yeSg6elkL4vcSn1I5yg823mJ6E/UoDbPNKip6ZyxygrzRuBiB2HCRpyP8kKuwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLOpmEyCoBR0ySsy+t6+K4KzuLF9E9lyCkBSXZHLArs=;
 b=M14kTuQ5DEhb6+AqTvB9BqZnvjPEir2IcUHM+rJ/lJ0nQboCVrxY6S4N0lugpnJKdx7kiuP30NOEzB93S0vvy8DlLf1Dj3MjB1v5d7jhsqc+ZsY/P/RaBMc/3xoJaex1VHSI9YGieIsbo6ZPMko0oJsUDAVA4TebKX98OxAMKLU=
Received: from CY5PR15CA0146.namprd15.prod.outlook.com (2603:10b6:930:67::15)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Thu, 30 Mar
 2023 19:48:56 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::60) by CY5PR15CA0146.outlook.office365.com
 (2603:10b6:930:67::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: increase AMDGPU_MAX_HWIP_RINGS
Date: Thu, 30 Mar 2023 15:48:36 -0400
Message-ID: <20230330194843.1136162-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: e1115c5f-bbe8-44e5-7c90-08db3157cc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n48pstIBuKrvMVK874+SYYv6j/C3WbjCqVrlPRCrlglhAlX8+2J+ZPSnm4m3TDNHlaE6mahEUlSPfHn7wGT0sVJ8fgSudDu8mXFZKoggREEBr+0wrC+VfcvxYCpDnDFfLKDDT0MaAjg2B5ZFyOWeGAM7f9Ymr5J0O3MIRwnCI8LJZODia+EOfkEPivhNSmkNquD7t2ChRtX+Qqum3O0qlnNRLipwaHiZmCiH0r/1aGpwjM5fShfzZvKrVrnszpZ1K/Vwfnhe3HQf/mQZib8UNGc2YsjY3Mx2KfLSkwgLMCooqr4FRSgpLXvpIXwlAmRq+Msn2cR/u81UiAPzBGxU0Qe7cHP77yQwi9bAOa0jtY7lOzUKjXGTbM4Q8szHKMhXmOJrme+0spqJ8NbArP/eZ+qUf8guJxvrbp8VJWoo7mqPt50eBpN5BEaZjP9q9GpQsFHBvfnABtymmDbXznZ2IjvetLqjd0fAqJuTsG3Tzim60WWcCHgzvrfi3pEyrIXR3NL7JYGE0Wkh/RCHDqjgDxGyafONooJY1AwIBaMPF8pFFZJ5xvDZL0Yk3lDxjZZzNSfFImCsCRd3YmoDevC013/1smNmhWOC5ag9Gmh+9ELKGXxpMdBupZ7hPmDGwR3jBMVtn+otG9x9utZ7zTse7oTLTucDrcuuW1SykwhZDWNv6OTwbg+iAvmgbiBEf8LFiHAJ89aOEMlnySRCC6fxmnzauoDeu64vgol2Evp+Wno=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(66574015)(5660300002)(478600001)(40460700003)(1076003)(70206006)(4326008)(70586007)(6916009)(316002)(7696005)(36860700001)(26005)(41300700001)(4744005)(82740400003)(16526019)(54906003)(8936002)(186003)(81166007)(83380400001)(2616005)(8676002)(47076005)(6666004)(426003)(336012)(356005)(40480700001)(36756003)(86362001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:56.2099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1115c5f-bbe8-44e5-7c90-08db3157cc56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

[WA] Increase AMDGPU_MAX_HWIP_RINGS to 64 to support more compute
ring resource. Later need redesign with queue/prirority/scheduler
factors to reduce AMDGPU_MAX_HWIP_RINGS.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 1f40c0bfb33f..244562ce735c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -37,7 +37,7 @@ struct amdgpu_vm;
 
 /* max number of rings */
 #define AMDGPU_MAX_RINGS		102
-#define AMDGPU_MAX_HWIP_RINGS		32
+#define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
 #define AMDGPU_MAX_COMPUTE_RINGS	8
-- 
2.39.2

