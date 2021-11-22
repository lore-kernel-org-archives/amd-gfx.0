Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E4BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 09:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE236E113;
	Mon, 22 Nov 2021 09:07:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325F56E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 09:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUsUCXgQ6w3Q98IXwOzw0bLXDHFAN1XAjo3/7mRk5EzOq5jxnFBEFWEuBdeXc5YNk4A34zV/7XznNv4RBc3Oszrp1SprpJiAaJY1wegtV1F0cjeAu1oe0B4ibnI0DLttmNv8/s0dXv3GTc71IJ6Rd0KGynH/hUFX/aokh62KB5g6alYuR5VHfhBSWlbs2fx1g+HRrE79kjeKtO1QFKU+BKPaxMzJvKK4i+La05ob8QgyjT4cwuhD/uKcJ9+snHG1O/q6zrkCfe6FAtVj/Cga1hTR44/LC/vYk0gE06OeJgNwW0EMT4zhXjt6pP+btmWO7m8m4pLCEogX745aw3ZmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwbmnuYFxkGeihmuloUfC+VmBwpmSGYnN2+9FK9k1II=;
 b=cykKWSm+J+96JCjhlalLBJHWSoyjGl98hZ/Engkets6gkHn606aDGshzoVUyfVy1wk7RWJGGoG3UTWeZEQ08z3sjKQMm5AjczfBfL3l1YBza9INjM2NB16DKp8rmjTMQUJQFAFViBPtOWSQojHKRZ+0/xlKHuW8/ujRYLu+4SxKYW77WkIKYmt7WvlMe8G66cdKbvO5TkpZOyN7iusJgobR+RnmfYm5+cHAxPe6BdDlilHJIYyD0XVpyuDe+9TnA7j/5fjv0i6G28VK61ct1+RQpn0T06Np0xsakACLkP/rtamBEUCYSz1406gQoOAAL/1EBnBsc1ZdNbQmaQYeXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwbmnuYFxkGeihmuloUfC+VmBwpmSGYnN2+9FK9k1II=;
 b=fdeOFvaKj+q2Ia2j625DJmz6u1Cb5SyXe2PTXV1+SuDAulGXqZzYr6pbQhy2nN7gmaICdkxZ/EnwFDFVmfaXXlUalw3lEXo/pVnLGa/wDgUIADUyRRk0DIG2WsvYnxbko21xpgfiXgGdM4tTSQgmjJ5uL//afVmESrV98Jwg7xc=
Received: from MWHPR12CA0064.namprd12.prod.outlook.com (2603:10b6:300:103::26)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 09:07:18 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::6f) by MWHPR12CA0064.outlook.office365.com
 (2603:10b6:300:103::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 09:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 09:07:17 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 03:07:15 -0600
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <guchun.chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: check atomic flag to differeniate with legacy
 path
Date: Mon, 22 Nov 2021 17:03:53 +0800
Message-ID: <20211122090353.1399178-2-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122090353.1399178-1-flora.cui@amd.com>
References: <20211122090353.1399178-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d801677-24a4-4f8d-d6b0-08d9ad977ba4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4962AAB5493A7BD94CC19C28FA9F9@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhCtOZsJj4+xlaTGVg//Eq4awO/ZK2rHu+yncSvkAhORleJy47MGopyGsHka1K23iHlxXGHOcUbx9L+yo/CY2R0GADl1eWSOooWqjaH2gHzhYE3LwwdM/iOICjlm4MJqCvXJ6vTEhdPn/CnwFtmap/3h71ZIUOj1yAN1WJtG9tmihvs2FLWhHZPphLa3BR8+w/BRdtK69Sj1lTLkZ8tZwrjLxXBhij+lseLI6y/s1v643Y1oeFUyUAPIlCs82hmGFI15aHOQYIobiWGiL4gm0VMSnLZmoyPrgzmweF1YAndDsJbl7mVKtmiB1jqMCX5rhnWw6BBj98dzcg0xCxOfpmVjISWL5P57odivYDnUirCrTig22DQaU7S0n31z+kR13Z5t1eT/ngxpXGUgBts1WI4rh2S3vUhwNcAqMC5dFu19FAf37bloomKo7mMvsqgIg4KhnJdBo6O5J1LWvaPIagIZTqiZcxFII8av1Wm9FxUgsNXkjJ+lENBjsKzhDMLQJJ+0dx1AkB6HUXYLmXAES3Y9cz8i9ix9gu6TJW+qQ5iC4CyGVqulg3jaduooYPX3+zG0a+31fQzx60Nx0I2vbN8Tb/2rOD/403SVsJSM3OeMsLcdO46fQvdtv6W1AHmhFYiQXsvrdzFmtx80K+0fmFSx5ICXn9dE/CxPbHIlTI3hDXS7dOxe56xsuxJVx5DwkUb5QuZQ86Z5vYhW5vuNDeYpUHtop+uf0I0kEng6Wbg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(36860700001)(356005)(316002)(7696005)(1076003)(44832011)(8936002)(47076005)(508600001)(36756003)(2616005)(5660300002)(110136005)(81166007)(8676002)(83380400001)(2906002)(16526019)(186003)(6636002)(86362001)(26005)(336012)(426003)(4326008)(70206006)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 09:07:17.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d801677-24a4-4f8d-d6b0-08d9ad977ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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
Cc: Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

since vkms support atomic KMS interface

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ec42a6fd88de..87801f2e50f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3830,7 +3830,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	/* disable all interrupts */
 	amdgpu_irq_disable_all(adev);
 	if (adev->mode_info.mode_config_initialized){
-		if (!amdgpu_device_has_dc_support(adev))
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
 			drm_helper_force_disable_all(adev_to_drm(adev));
 		else
 			drm_atomic_helper_shutdown(adev_to_drm(adev));
@@ -5125,7 +5125,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
 		}
 
-		if (!amdgpu_device_has_dc_support(tmp_adev) && !job_signaled) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
 			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
 		}
 
-- 
2.25.1

