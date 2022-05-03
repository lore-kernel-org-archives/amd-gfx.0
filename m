Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179ADC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBD6B10F459;
	Tue,  3 May 2022 20:37:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C6C10F41A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNIbElImRyUIXwBdTm6esKxiNrgNt4mHqE3xej7ZAwO5bDYHFSfSpYILiiYx2pb732OFvMwQp73laFEOIijSf45WM1Pg+yTPg+6plT0PLSZclLbdgfguOkGhGBag9cl7b2WujCS/Ok01gtT9f0VGB+iAbxm2OgxR2mFpliKcT5SCZ7XQB6AqMDnJ3y0Ncla+zbAhGWbwTLcmXoDJUqZQtO8yiHx2Rj2nhVAXVSg6yjhIy+zaZPbiI44fxvDpsdRXs9NbV0oScpEC678oviGCFv9kllUfrjrJ4V0oU54o6L+Y/jjbqMhyg6ijR8CtenwpkQuPZfDKe3NYYWe7XVu2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku6URnlmTSP0td2BqIqGSpdVCML3d8IliXVwpam82mA=;
 b=T4dBe/xBZR4+q0EQaz2kSKM8aZu1pnLn2DllGmANZIaEgVZChVJCIRPuMBctPQ38It2mnKUd7snqjphvPO/Gwm8dnuLeyLAX9VWCnMvbUHbIFwboTXk60EqaE8bjHjcaEKbUaDLXGZyZqrnepnqeRCdZMH+WIlStA96GFPCuzJZ4IaOxxYwLcHyb1Y7IIn4aeIW/+X2l8Q5H0XRI0Beot0MMuWNmDOWbvayc/mNxGkshLa08WIbu472FiimM0lBuzSzgKVp0O6ful0okJ6BbVucL75613NoQ8caCIrlNXAOJ0HwFGIs/h685vL+0fmfsNYC7ThrJqFwXa7wrbr8Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku6URnlmTSP0td2BqIqGSpdVCML3d8IliXVwpam82mA=;
 b=Ke1Bb3DWSgxYmhA6wpl2GU0/ynPejU+AUZwcy6C2k+GXn+C54GNxSzG9jvYbiPc3e806Ug/q+LkMQCDa4fRLgBn4eRvalI+vQWxwO1dGdOQ6Dk/Jg1DUE5+IN1QK0zYyNHsKjIFTcgS9Z/B8l4zcC2iYA68/1VWHACF0iihs46A=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:34 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f7) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/26] drm/amd/pm: add features to smu_v13_0_7
Date: Tue, 3 May 2022 16:36:56 -0400
Message-ID: <20220503203716.1230313-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc6be0a-9a0b-4424-84b2-08da2d44c0d4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025620C87DC17ADA88B6CD3EF7C09@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PY1M5N0AM/WzNW0VIFtu4RtYCcDblCDLV0pDGpzojOrHTO8RWSWSd31AsRwqgeQluZpE+xmoKeKZOJLlbkpocK0GBq1jd/soTACHTGfTpPzVcBMW94jaElnF0MogsrH9CL6yTKmORB0Nf0DEJ/e7murG3pStZkTg6WVu3Y/+bpzImv68KSoh79IkIEETjOGb4InTRy9oGZL0RdgMatzhoqrO/N+igaFvm4etZVKLSGJV7lE63jssYNlMiuHbQdwDqgq0b+KR/MlEzvaSwk/fvb6ehnB3dLBDWqCKFQZKXwKap1K1s7WMfOX+FlMF2u95eIzAkN2VtNhG6Gzwikrq6c4+ihZRc0AcitqjIxOGywUujukWM0HnyQs/U17BNhYYooRCay5HVxOh8cxSfmAEFdR9BUxoUCWTRSQgyKL5vxqqxUq69UXVC1yxQYeXuOlVNnCOFNYxfgU7VAm0Eyi28dnUhSI0JoGohwom4U/tOVN5ID+RYeANdUalY/ZcI600E0ngwzgtGEOuhNsQhJ7yIbUZntGZILeunr1pFGVOhWudp7TCrTRGcFesXq5/vAcKTboNFVc7kvRj/wVCh2xsfmznPBhfn6IG81TDPzPXyYnpJN/I6n1gbxZp7BevZLDuZvFTAd8f7vm20tOe77ctGNL68zXbpKnJGAXs76kohYBo8JMEeRdDwP0VQwTY2Ux6Q+Lty4yLu65JUhgSI6Ko4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(86362001)(8676002)(70586007)(4326008)(70206006)(508600001)(316002)(6916009)(54906003)(82310400005)(2906002)(83380400001)(336012)(36756003)(40460700003)(186003)(47076005)(2616005)(16526019)(1076003)(426003)(8936002)(81166007)(6666004)(356005)(5660300002)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:34.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc6be0a-9a0b-4424-84b2-08da2d44c0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

add prefetcher, socclk dpm, fclk dpm, uclk dpm to
smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 335bf396423d..76dd4220d59a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -156,12 +156,20 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 
 	memset(feature_mask, 0, sizeof(uint32_t) * num);
 
-	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DATA_READ_BIT);
 
 	if (adev->pm.pp_feature & PP_SCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_IMU_BIT);
 	}
 
+	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_FCLK_BIT);
+	}
+
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
+
 	return 0;
 }
 
-- 
2.35.1

