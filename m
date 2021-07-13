Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF2C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 05:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90B16102A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 05:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90B16102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443CB6E02D;
	Tue, 13 Jul 2021 05:56:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52E46E02D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 05:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrOM1IN0+rnrfCPHKyLDPI5fvQZvmdfUi6LllMNiWIJkYbGAGvrOK+kMrcvG9+URXnZUvRWt7AN4B2Pi1DwL8OCeDdt77qDj9zOoA54WpYPqdCD/5tHUbuIJVklA9thSbwnxDZ7pujqnO+fA8WxkG9wMivjVi7MieYsaTxghJ7GR/FGGIUWpzklkI6tcKsjQRw0hwPwz5XkCT4Seh1q9yoCoFq4SXrulac71XllSsRjq7Uer46wI6EzkWOnnSOM8M/Yi1kLjUcHoOf01HnDpvlrRzGFU4U/6yLTfMoV5kt3kF1VuJCSLURWYvnjfg32NTHL1Vtj7GZimw7W4gA9AVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y40iocCPYOldTyAapmOK6ZDCO24Zk+Lj46b+6KBtvDU=;
 b=ev7TgCAaaUNwRgQvmo7RaSjuLwV68NA1QWygFvbh1wQE6o1HcQypkqCyfOZhf49JrnbT+DXGhGjBSZDLWk5XAZGWU46Z8noF3BEGh5SvzBfo4DVytGLQp2vnYj4G8DpKVmwD+3FkHJdodZ5B39KPSDeVPdOeqPNa9vipa8WbcIfFN7gMn6yylYx0oNU1/mCUDemLan3KA45A5oAEdZpgep46MHMhzX1Py3ssldt75iY0Ct8tsCELOgym4bWvKEcNABqoliB7T9cSqUtBH4UyW8CKdyUqkyAfRsLKCFkr6/cYuvUXu8o2UcjHBz2bYkrdVERY5Pw/0zQMITo9GYG1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y40iocCPYOldTyAapmOK6ZDCO24Zk+Lj46b+6KBtvDU=;
 b=KpnTZc7Yz5Dp6Na4Q/nSuX69FhL/Q2pOyURP+eZUTf2t4vrplqaTFwtThNmPhrzcaWX0oaRCFE55JsMndi7rA3l/q1rDCZfeJBzJ9mfJw7iNqa/vaSoPNY6yqVyOlG7KIwWdYsIAMpYDLG6WgU0BAs774b/AbuTnV1YsrzWhmSE=
Received: from MWHPR21CA0040.namprd21.prod.outlook.com (2603:10b6:300:129::26)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 05:56:34 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::33) by MWHPR21CA0040.outlook.office365.com
 (2603:10b6:300:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.0 via Frontend
 Transport; Tue, 13 Jul 2021 05:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 05:56:33 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 13 Jul 2021 00:56:31 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <stylon.wang@amd.com>,
 <Nicholas.Kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <tianci.yin@amd.com>
Subject: [PATCH] drm/amd/display: avoid printing ERROR for unknown CEA parse
Date: Tue, 13 Jul 2021 13:56:17 +0800
Message-ID: <20210713055617.331-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63acffd7-0cac-486e-9c77-08d945c2f850
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-Microsoft-Antispam-PRVS: <DM5PR12MB177111317313D124C24E082BF1149@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNHT0C9mmGuNxki9dT6GqT5CrLVKy0m+g0rkmr+LE9hFXak45HLUFkvYJkJ91o44tqOqwYXM+EmK+YWlcNPcuB+jfNsBpbAuvBd/vhtk8dvp7XPIxd3qCcMfa5sJXLfcQFM2hOGLDvujb3JpcjfaXB2Y9XxROI0jm0XDzG12AHBHhVLx86T30S64c2e8mQpDg+GuDHSarFkz1cG1qjQ1EUNXPDTwflYk7Wu7vlRljCfbV35BaAxLkf4IoLV2wcCY20oFb1xlwwKIk3+suTsOq28j3WzTTf0fxwW0vAmvybThWnOv2vMKucS3MY+LhJgIAyxLo+lpBFYX8cJcCnEZ6okHPa7QNyGsDyQX1OwyW4Xwec1gVtzgYLgoO8Y4Wo2aiWth90J7BUfkGtuV46J+fzs0iqe9LHfIoWLJrPEL4h5pV9AUb2U7Aq6d0s7IFv8oXe7fZZTKdllnmLtR+kQ17aEVTCEQr+m7ezZH0MtlI/+Lf8GfBS7+4THAd5JM+cFcn9hR+CNxXFEVEMkkrzHKy/PTwSh9B8hWRSvvGK4AOj7e9HTnSXLzQ9wqx/Uo9alUQ+LvB4qzbJfflf90HN3SAgW/LTFNXlcmoaIbMZtR7F3IkKoloUP79RBKWiuQpA9kuati1N1Hu2t8CYyaHJPGcbOV42ANToVoT+Au9uJTAq3d6e0YtpHD7ibLeFkmRmlzBR9aQn4FMxIRM7vfqrZMXkxfkAnW8ApXI4cl9EZ4QsE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(82310400003)(5660300002)(47076005)(36756003)(2616005)(82740400003)(83380400001)(2906002)(478600001)(7696005)(70206006)(70586007)(36860700001)(81166007)(110136005)(44832011)(1076003)(426003)(8936002)(356005)(6636002)(6666004)(316002)(8676002)(4326008)(86362001)(16526019)(26005)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 05:56:33.9881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63acffd7-0cac-486e-9c77-08d945c2f850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the unknown CEA parse case on DMUB-enabled ASICs, dmesg will
print an error message like below, this will be captured by
automation tools as it has the word like ERROR during boot up
and treated as a false error, as it does not break bootup process.
So use DRM_INFO printing for this.

[drm:amdgpu_dm_update_freesync_caps [amdgpu]] *ERROR* Unknown EDID CEA parser results

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 03db86bfaec8..613540b0766e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10700,7 +10700,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
 		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
 	} else {
-		DRM_ERROR("Unknown EDID CEA parser results\n");
+		DRM_INFO("Unknown EDID CEA parser results\n");
 		return false;
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
