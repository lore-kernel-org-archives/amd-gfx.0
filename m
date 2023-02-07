Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E8C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 04:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D6310E2DB;
	Tue,  7 Feb 2023 04:05:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8185B10E2DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 04:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8gnHM25kH+0RR03JRR0R4nMf9wj3LoD8Ma6+ckI6QVe82ScNoCIDtJzwH3mmfYKSzssXq/2r01qHAe7LOh2J7V+bJObieLsAGTx0A1j1DVGOhB1lJLMhDu9O9utmVHDsZ/zQ8xbWhXfCNuyYWUWP+xliUeMZvWnU+VpQAsnXVNamyNH6GHx8fQ0K3yLnceQGyi1dskKyhQpnQ1ndzKVuBB1fZWzC6gEjOoF/6e5vOFpoVehwtoIQx9rbQYLUMrBjx61RXmrBPLbKVRdpdTXaZh88YNo6a3ezO5a7Kx6WUJFleVaa+/I5c4BBiQ/pdCrK1YJWNSSBPaJcMkWJecpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8nEGMyOpO9/1m9cMWwgoIIdzY/yMVtIuhkt511lLAQ=;
 b=Lz0fn14YZTrYhf+0WjO9SuzNMHM4F1ugrvwvNlbfL25s6bhoC8CAdPJ60unKzKM2ruLHB1SdKI6x4MDztn8HOYP4B2JV+iTZ1N8/AeGLTyMiZUZw+eBuuxsnPKxtLpRlTM0W9niIDV06hLBNyf/uULi+In72tJGbXo3NPhYAD1NqG+8i5VIl1nI9QhG3RpOxo864/E6I/K3wJsGQ7D9l7VYr8oHHNq/fPtJ9hHDCUf4jF7/YWgTewrTTNh1wAduswP7+EcwFKxrE9AidmqnDrcQJA3Si4LBD3yUIkSItoHasnANVPc4b62rbqxfqsnAYUczcjdmlzovwO5mX1F3f+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8nEGMyOpO9/1m9cMWwgoIIdzY/yMVtIuhkt511lLAQ=;
 b=XoDJDl22ZZaT66cE0S0vSBIaVFH0Gytv7vYBFxHJm5nDaPdNU1AFd5zTMlQGMlgZqJQYujYq2vDB6/+ZgAEQ0lUnb2cBU+gB9ZeEWIw1XLKT5BQLI9tosKF7AN5aWI38zOPfz7uieu7To/0BkiN+FqxmELOKkZbwBK05dU880SI=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Tue, 7 Feb
 2023 04:05:29 +0000
Received: from BL02EPF0000C408.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::32) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 04:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C408.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 7 Feb 2023 04:05:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 22:05:28 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 6 Feb 2023 22:05:26 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Align num_crtc to max_streams
Date: Tue, 7 Feb 2023 12:05:24 +0800
Message-ID: <20230207040524.4020763-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C408:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: ef035717-7aea-41de-8d00-08db08c08c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN7gDpxWd/eQ8mSatw7R3Gk8obsR1R6rEYbjO96TNzlkGmCQlgLjG6ZrQrSf6l+09w1lRNkl55Qik/yqCd/OfIyWbMTtUUuRTlG2QxzkH7H6KXmLxoBCITpkVvfWGN/FobxCsm4922rRJ5PO4gkRcXtMO20QtBmjzjcpp4DVoiYLb1ZavK5bj8vBFcYac2bCncIp21KvmRckxFHmnOT28vw/22XihGQXt4BRFd1UJ8eddDkl0y+NkxPLq7yw2/zkxPdQjd6+Vpr5dK7DM7CzfTuzvHIR6H4jnHvWJRI66082VWlBPvjPHY2roQT0s5jC3U0dcwFHZiQJewxiqph4/2M6+AaYBnlMkHiKjG0Q7L9SDvhbPgudCQPUwX9IXWvYlWDYGZjJMr/CzE1rmXe6VONeEzOEfTYEl0zCJKOnR4nRDTvRaQCgKxI24y2Ht6o4qxatrfCL3C0vD8hWESFuHQtA/9iDn3OG3afv75aaNssY1alPYFoi8FNo/5KfVNlJw1KP5XpGc9E9JweIH8UGxink+q8aLOUV7tT3ba5k6UmwmvwcD/KA7u0MbHbSTke0S9mTgSv9PM/paSG/DDdphg955s6HeP3lLvgT3gyULK8FkS6KCHQs3aBlGAJOARSZiw1YtsoZ2XX2ZNUtJoIkSJvgd7kSrOnEyJsOi6OK+Mr5G0PddGJqspFeL3a/47S+iqsguGE9MMC2hYz2ZRFAIsQebNqNff8uGNZtylhua7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(86362001)(40460700003)(70586007)(70206006)(8676002)(316002)(6916009)(4326008)(478600001)(81166007)(7696005)(36860700001)(5660300002)(54906003)(82310400005)(8936002)(41300700001)(2906002)(40480700001)(82740400003)(47076005)(44832011)(26005)(186003)(1076003)(83380400001)(426003)(336012)(356005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 04:05:28.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef035717-7aea-41de-8d00-08db08c08c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C408.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Tianci Yin <tianci.yin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: tiancyin <tianci.yin@amd.com>

[Why]
Display pipe might be harvested on some SKUs, that cause the
adev->mode_info.num_crtc mismatch with the usable crtc number,
then below error dmesgs observed after GPU recover.

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
The max_streams is limited number after pipe fuse, align num_crtc
to max_streams to eliminate the error logs.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b31cfda30ff9..87ec2574cc09 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* Adjust the crtc number according to the DCN pipe fuse. */
+	adev->mode_info.num_crtc = dm->dc->caps.max_streams;
+
 	for (i = 0; i < dm->dc->caps.max_streams; i++)
 		if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
 			DRM_ERROR("KMS: Failed to initialize crtc\n");
-- 
2.34.1

