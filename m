Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CB4EB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 09:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CE910E522;
	Thu, 22 Jun 2023 09:38:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5883589B62
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 09:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R06LXAIWqFCD/u6GY2gGL8hCIoDYls3xdjwBUh724KkaK79ibjb4T/HNpOvgOv+vxjQWnzxiqyg/JrSxSacvAXInlhGaeJGuLUUjkdviADsq4QfkHuelb4biDKzrCJ2cgDnVaZctRdr8XM7AGybbf8/D51X6WAClctGPYTkh3tL6NnA3GmkwmrTD8bxUAeX7j62T1rl5qpxFi8Oo3tT1FTt1Om866gDPvkNIPnIUvHHxvXfuoEKwKLjw6jQw7R61GyKNHU9QTtVadtPGMUXky8oFfYKcOzwKpxddOWWXybl/wD9RfDUg0VUV0G/h2MWhzvm0+YuW6R7eoUi476zqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDfbKj6HbGZdBeDy7xqd5126AuW6i0RrZ2pivKs2CkI=;
 b=b8c8+snWoaNhjoedAIr1Qwwcjitv+aOWC92HCk8HfSOlWid431S6sGc0r8eSwvVriMUsHETOZeBf0NFa5KeyuogUrw3sdd249fhnZrYVGjy4W/ikc8M0mIXyYAyLI0VM9Zv/ClMUNrASI/OXBmLDBHUpxGGLDhIJxMHWtkHHK0ZJ5oldF+jyK6HwMPPrDWcYRytsydFUJuoLxQfzkyBnxcQMyD4hGdLn6A/DpuksipU57yomFPUmKqWPvvCb49P78j7Xbxv/nrU8CXZChJIrPvVyO2kLBrmO1TRtcqbnwfIJmuR/1pnFvNNjPoxrQLfG5W/QRqVyGdSz82+i8y+5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDfbKj6HbGZdBeDy7xqd5126AuW6i0RrZ2pivKs2CkI=;
 b=bmwRThLPQWDu/peAzVNEBS490MwIFQAzBGdqKdvXQCy+XVp2apxvO7OcE77njmCxBBG0s9mXzeZgbgt2VoypdL3C4mBo/ti2ZLRHXRUXXquxdtgRgJTjBBMzKoap/XfkJG5hltpPGtXdlirX9WOAc/pJ3/V/03UEXtXAx2XZP8M=
Received: from SA1P222CA0174.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::23)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 09:38:26 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::58) by SA1P222CA0174.outlook.office365.com
 (2603:10b6:806:3c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 09:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 09:38:25 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 04:38:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant braces in
 'amdgpu_dm_crtc_notify_ta_to_read()'
Date: Thu, 22 Jun 2023 15:08:10 +0530
Message-ID: <20230622093810.1088449-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e5b1d7-fea9-42d6-19fc-08db73046db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjuZvCZIYH/W3TCMRrUG8pZAB9MG4ATao4UIzYL2zooY7ko8Bo1nZxA1c5W6zWJHocQDpM5YNwpRLq8efP2iEHGnosSxpo8+ygv+X7+faajIA2U++v3yAmxKeer11mXJV/cW8fF+3/4e/1venmbAEdt97EHhq/14XxCAz4PPQ/VRQkHORXV6UMZPeoVeRaun9/iTRPnqH7TskE5BT9+s/MMCBn7+sowB5mnIk1z/ChEIobH4eLik/iKzpe7pE4ns18ovNcZf7ichbwn8Kc1pT29Zwwg0FLyhhIfaMpPF57x1OtlXnQJza/O3RUC8l1PhzTsGwQxYNAaqu6c/SZMuX/e51SHjVFzEEcy3SsgPYDpyxuF1Ufs6S1IvdO1XchlguLqijKTqjcmqHEd229ibR6QyP2WM5AH7H3nuDUj7yn5yW5cJlDpy0PX0cC6UqDKlxWps6qpdydR746X3Va6FVzEPEa0VX+KY7pNuQfYRcd5jdvW8f4yLSkmq3UzF60Xz93Agsg40gUxl/QMOYTRVajpqiCiMcsg/mhArem2e3/LUX7WcGbVk41oYhFsLOIug+1Lv2Z+HaYsSguVzZvGCc/w+aORkXIEPb2HncTRrxHYiBi9J/yNpanKpStbL5gZh2blRsnQL7F5LEBdIC4ZQJeBImq0qf+a950yY17XmWLJYYeDN/KbbF6859NbM/mpya13gC1zMywHU7lJc4YZu5KVipruSiNwnnPhC63FIKQ6QbmnwUaKajxKwuiwRnVjm1k5c5Yrl42SfYrRlBx3vIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(186003)(16526019)(26005)(1076003)(2616005)(83380400001)(336012)(82740400003)(54906003)(426003)(82310400005)(7696005)(36756003)(2906002)(47076005)(478600001)(36860700001)(6666004)(110136005)(40480700001)(6636002)(40460700003)(70586007)(70206006)(4326008)(8676002)(44832011)(316002)(41300700001)(5660300002)(81166007)(8936002)(356005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 09:38:25.9818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e5b1d7-fea9-42d6-19fc-08db73046db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 0802f8e8fac5..52ecfa746b54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -123,9 +123,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
 	crtc = secure_display_ctx->crtc;
 
-	if (!crtc) {
+	if (!crtc)
 		return;
-	}
 
 	psp = &drm_to_adev(crtc->dev)->psp;
 
@@ -151,9 +150,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 
 	if (!ret) {
-		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
+		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS)
 			psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
-		}
 	}
 
 	mutex_unlock(&psp->securedisplay_context.mutex);
-- 
2.25.1

