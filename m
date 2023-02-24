Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E684C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 16:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B6E10E1E6;
	Fri, 24 Feb 2023 16:55:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5469C10E1E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 16:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idYqdrNoSFH0IOR6e5SP83wPcC5q85EdZ66bXGtio7GglZSasFmEXMGeUKP5UgXEuWenBD4gxYiLyV1U4Hu11m9lwy4UFR1GPfUAG7rBxglXmHDxPfIuKkh+lfTaMZpe94sN8gIZtfbI7UeMvQIOvYbnK3q17GVwGkZ2OVhPPy1drGxkR3Nf6V4SO3Gmu5tfdMiNeXIoiWevAk7ZK4P4omlwG068pLPbqjtrATffLZKdb6rDCHLtyIDT/jQ6M667pO+CjVOmY8hWnYvGgyBO3ARp32T0KizEkhGu8H6fR7LhCcAu9V7T25UOZy0LVC5KADF0C9cWZSfZ9WTNWDzBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5L1oWHsGPhY/CHIungaXxSyo5EXhJdgNtrhJw1yADM=;
 b=kBc8Uh5FtzNXqGrST7mMQw6V2E3b0aD2+Mv0S9fw5/PCFele0sB0nQd24c8JSr8haEVaqs1spgY0D3pH5dpKWgHYkVL3F+zJjkB4VcUic6veqZ99AzNConDnOAC8KTMSD03wyyqEv1YKtqPf5At4vi8BcVSW9jrX6VQ4gtE58g1mE4bWABOIxlUD2AeXyhd6MZS1eq5rwAhOTlyiB7r8g/EXHweIe2UbZ1ZM3LufbAm6WvjlVXUu8au/qbMhhTiF0bxPtxQQ+yMYybRozdtpvbIVDIGaWvyvluHy2LXMBSsBtqHqo9yK8PTF1MDJndYp+XOhq2WCmUA2WsMB/0AVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5L1oWHsGPhY/CHIungaXxSyo5EXhJdgNtrhJw1yADM=;
 b=Lb+UAlYMmu7Xd7vItmR7nHJUcIq88sIXW3qiMstcQdZnidhzy/5zJgiGZfcWYTWYFh1yAN1brk3MZZBaE6L0KfDzmp/rehsr7a9lb+GUF3ZEdXd5vmbKwTHb7v3OQwRuugHAFQGoAJokBRMwi1/t4w3PrVrGIAIH63zyc3FBTIM=
Received: from MN2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:208:178::40)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:55:10 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::62) by MN2PR19CA0027.outlook.office365.com
 (2603:10b6:208:178::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Fri, 24 Feb 2023 16:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Fri, 24 Feb 2023 16:55:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 10:55:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 10:55:07 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 24 Feb 2023 10:55:06 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix dm irq error message in gpu recover
Date: Fri, 24 Feb 2023 11:55:06 -0500
Message-ID: <20230224165506.2276412-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0305c4f4-6579-4681-5415-08db1687e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ejd1f3NbbpaPd8lbR0rv5gLAA+F1xCTJ3GiIAdGkwV7d/tHwcLh2OrvOpSwRkEQGpUJOP3dwaVtUCw65garh4NAt7WaZquzi38fA5CIalclLw2fSyU0fwG7wvtFlQboiY321vSHNnUw3Q/20mpd8bjQgxoOs+OZn3MmarWJEYcABOBl5D7YbUBcIm9kgPCEpDPqHqEW0ICwToTNw/0RO3VJjOD+XE0B2ky+J847cuxT6C+BcMwoviLiHnZW7G8sy8R6K/hXL+jiN21ujltNCfbjG/mZC50hdB7or/KQBK8+AV6Ktd1FhR7qvqT6knos2Kmx8g/YiK9HOJ8lUVAemaG+rTNAPAhGq1oOfGtA9KcOvKX0fmPSUdws/+jWOrS7+f/3GvI1mAJzunxTpDHZdVuIR1F4T0ViX1tXLhvsiaRfTqKLqZp0u9pUyjzB6v4Q3mSjgQIabvpnxpahFD5GHsvRfv5n4UNjSIjwLOzgh0tlgtT1yU3GhLFmwx3xRYdEwL5T0RMnNQ2ZN3Swb0AJPBAHvBCMxv9R5y0c14U+80Y+ZjJ/kT8OLoCFdfCper06odvBPC/jA2OdI52eRpeyehg5Ko4axeMSFKRk3acFHCa7CUaELBdY3HBw6yZlfQ6Y3Xhon5yHou8V0WcKAUltVHJhiyN0lBBVVkk7+Wg6WvZ+R4+ykshV1C6Q9D+Htfsim84r0zg7gKvCUNUj6UDyUiU5EMwCFqODlzW6MIaowqjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(1076003)(186003)(26005)(36860700001)(47076005)(426003)(83380400001)(82310400005)(356005)(40460700003)(86362001)(40480700001)(81166007)(36756003)(82740400003)(2616005)(336012)(70206006)(70586007)(4326008)(8676002)(6916009)(15650500001)(44832011)(2906002)(8936002)(5660300002)(7696005)(478600001)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 16:55:09.6806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0305c4f4-6579-4681-5415-08db1687e38f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
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
Cc: harry.wentland@amd.com, tianci.yin@amd.com, rodrigo.siqueira@amd.com,
 aurabindo.pillai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[Why]
Variable adev->crtc_irq.num_types was initialized as the value of
adev->mode_info.num_crtc at early_init stage, later at hw_init stage,
the num_crtc changed due to the display pipe harvest on some SKUs,
but the num_types was not updated accordingly, that cause below error
in gpu recover.

  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
  *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3

[How]
Defer the initialization of num_types to eliminate the error logs.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 79cbf71c2eb3..038302dc1a40 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4270,6 +4270,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	/* Update the actual used number of crtc */
 	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
 
+	amdgpu_dm_set_irq_funcs(adev);
+
 	link_cnt = dm->dc->caps.max_links;
 	if (amdgpu_dm_mode_config_init(dm->adev)) {
 		DRM_ERROR("DM: Failed to initialize mode config\n");
@@ -4758,8 +4760,6 @@ static int dm_early_init(void *handle)
 		break;
 	}
 
-	amdgpu_dm_set_irq_funcs(adev);
-
 	if (adev->mode_info.funcs == NULL)
 		adev->mode_info.funcs = &dm_display_funcs;
 
-- 
2.39.2

