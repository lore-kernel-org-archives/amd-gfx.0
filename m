Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808EAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 14:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BBC10E207;
	Wed, 23 Nov 2022 14:00:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6DD610E1FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 14:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D164tfKMmeeUddns5Eg43XokkaVO05bF2ySyXmoR8qVX5UmC4JvH7nawTijfid+XI595q4tEGlrwl5NCNG6jKlU+hZ0HMgJmvIciwj/WkfCp4AJxigOGUOvnIUiGPAhFoKI0LNRCiL6UrWYSzbbqTK9fFU2ay78cMngNHLgfNsrIpqnXPJYxV+yP9QKv3NRFbRIM+gLDmdDeNZCqNktI4FIzDeK4DoNZQFgsW4u+oUyiHxH2ktyNNISemafkgESfnV6yMmbAclxzzVtFMx1iz3oX40plwnoPOBfZSrsAOEnIR4do5F94AhTbfmrFQaRfZG3RXuGdTTDF7z9EdBkVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi7MZCA3e49/UHWVuFV0INnENynOXkc0FhlBaDHocQc=;
 b=TLt5ZUEslz4xBoYiAKiRsuAfc0DUFVNUJpnP2tT9ZzZwLMlh8oiS/6RfrQ5KKaIKvaAC/oRfoFbqZyWjsvWnyxw7tMYfgR5HlhDJ354Hv0q86x1SY68RCXPYC9ZGRNihy2yCLt2fx0hBc4cpC1iOvpgSLD49kVUlfSMHOnRdnp1hRqAAOdXNdKUeXX1knS8ucift3enAhUFTiB7fFVStc6U13qG94Szq/j4Xcrh6dGPYw6ZSZ8Ng79jBLgoMhRZMKbhR0wgfV5Uytqe7tnFl8hZ6l7VfQ13S0cGsBqllfdtl58gz7tWQmP8GGtFj7bwhR1ph4CfLU8FQ6f5tXBJApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi7MZCA3e49/UHWVuFV0INnENynOXkc0FhlBaDHocQc=;
 b=Ea/FXAKU0GjYvN2bshbPED0mRpnghUBFoan+9p1QsltWdeiIFdyXth7a5OyxSKGBwnAwlDAXjbeEnTXwZF+vf+8JSCyY4ZEHleqp8NYD27tHzTVP2STftabKsPMvunpXBDgkbJygljfSB91juTQYj3x0FhT+8Ml49uiC6Nw0f1w=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 14:00:41 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::df) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17 via Frontend
 Transport; Wed, 23 Nov 2022 14:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 23 Nov 2022 14:00:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 08:00:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/psp: always call psp_load_toc()
Date: Wed, 23 Nov 2022 09:00:25 -0500
Message-ID: <20221123140025.239843-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 61912b54-c570-49ab-523c-08dacd5b1ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyKifK7zoQO3YWuBKmYP3cML8voOLVkA8eSBf8L8MCzuqZA7wfFbl+GZOXhrU9i9HwBz8XX1U7T1W6MNcrr5ypcykg0v5okEw5JvkMu3uF5W7RwH3373UoV1rb8slnTTk9xaYlg/t4RASNNvQ27kVHlkIZ3qbjff/3Toi9EPZg3PPLq39lNGYg6C+0IS0lNm4z9YwiYqaxLwDMrvUgkRtGLFoDDBn8SptPpiLgsVKBUvRVwpjsJNu5oYyosYPNUwfEoqhHbyGxUuvwkzqXMvnegdwYJh4SAh5M6Yjk0UMjQ5HAPtC4gcsFI/J+Xp6ViAQEQtGiVgEqQeUk0M7lw53L7HzKGH5GDL1iAbu/APoHOQ70Tl7KDCX8gCEARfAeLAqI2F5m6MTD3g5+wF3Ql8BOHFd7mDy51M18Dwfvk12qzAhoQJRMfMywc76MECkaOEcgcMNwTJ+CX2+Bg7j++h4kx3oeymt7gyNGgMKEn8b+aco5pV8/+1yzmszmAvzVaiuFNkJ4quZ58jmblQt9abl7emE38Cw1tmWFt4tCWvGiqEUrnfZ+cIYhl7/RkgJLTP4yZLNp6FQmLxk86PLQUlRNwPyO3gbxbqDmaMenwzxRzDOw5Xa3iCs9Z9LM16ay8RIqddRizv57KOYtOqXahjOpCMYVeFept+O/FyqyRXvK4ruwuPO1MAVIKun5LLU0z9B10bP9SyUfG5M60S9b/nCTo6A024l4E2NV09EmL13GI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(82310400005)(36756003)(2616005)(1076003)(41300700001)(70586007)(70206006)(5660300002)(6666004)(186003)(8676002)(16526019)(8936002)(26005)(40460700003)(336012)(478600001)(316002)(47076005)(54906003)(6916009)(356005)(83380400001)(7696005)(426003)(82740400003)(81166007)(4326008)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 14:00:41.4840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61912b54-c570-49ab-523c-08dacd5b1ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Skikai Guo <shikai.guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to always call psp_load_toc() regardless of
whether we re-allocate the TMR buffer or not. Fixes
S4.

Fixes: 36238df85ade ("drm/amdgpu/psp: don't free PSP buffers on suspend")
Reported-by: Skikai Guo <shikai.guo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 ++++++++++++-------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 621723f510a9..7978307e1d6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -750,29 +750,29 @@ static int psp_tmr_init(struct psp_context *psp)
 	void *tmr_buf;
 	void **pptr;
 
-	if (!psp->tmr_bo) {
-		/*
-		 * According to HW engineer, they prefer the TMR address be "naturally
-		 * aligned" , e.g. the start address be an integer divide of TMR size.
-		 *
-		 * Note: this memory need be reserved till the driver
-		 * uninitializes.
-		 */
-		tmr_size = PSP_TMR_SIZE(psp->adev);
-
-		/* For ASICs support RLC autoload, psp will parse the toc
-		 * and calculate the total size of TMR needed */
-		if (!amdgpu_sriov_vf(psp->adev) &&
-		    psp->toc.start_addr &&
-		    psp->toc.size_bytes &&
-		    psp->fw_pri_buf) {
-			ret = psp_load_toc(psp, &tmr_size);
-			if (ret) {
-				DRM_ERROR("Failed to load toc\n");
-				return ret;
-			}
+	/*
+	 * According to HW engineer, they prefer the TMR address be "naturally
+	 * aligned" , e.g. the start address be an integer divide of TMR size.
+	 *
+	 * Note: this memory need be reserved till the driver
+	 * uninitializes.
+	 */
+	tmr_size = PSP_TMR_SIZE(psp->adev);
+
+	/* For ASICs support RLC autoload, psp will parse the toc
+	 * and calculate the total size of TMR needed */
+	if (!amdgpu_sriov_vf(psp->adev) &&
+	    psp->toc.start_addr &&
+	    psp->toc.size_bytes &&
+	    psp->fw_pri_buf) {
+		ret = psp_load_toc(psp, &tmr_size);
+		if (ret) {
+			DRM_ERROR("Failed to load toc\n");
+			return ret;
 		}
+	}
 
+	if (!psp->tmr_bo) {
 		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_ALIGNMENT,
 					      AMDGPU_GEM_DOMAIN_VRAM,
-- 
2.38.1

