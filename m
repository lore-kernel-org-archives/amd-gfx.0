Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B39C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 10:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF5410EB3B;
	Wed, 22 Jun 2022 10:07:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4FD10EB3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 10:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chaosm0uH5orOc7VitNfLeUuYqj+Ojbh3eof2o6vJdJskqbENJFXjTIkVBJaRB/wfJ90OFuFpEASbwFgYAY+P2XDntcSK9fEHAuRc28sWLm4ye5ZQAiYLJMIz7LmyjrKyBZbq5YG4EgU0rrvmgK5o8N7BiezcDZzXjnHTenmD/bAIp8hQKtiXTEY9npbFYhoxmqOlsXai05pDcXlePpxpK/DddMSbaHCUi/dI/7HOU068gUPieSMNk3o4RrnN+R6ugk4x/gZx6DACMTagCshjpxA6DcdMQEUnqRYZ99VjXY/fpe6+hU7mlmecocY/pnUhThBULuFR92dHqUt4MUOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9ZRhmhdP6LZ4sLtfGWotfzD3xFxMJJ/eaZ9BaVygYU=;
 b=YW3iY6fINblCxdzAn+nsbN+zs3dl+SUrB95ZLqC55Km/yHYByhAy6zuxMw9T9mfAL7CekRfbBpmQTAo8aPt/nmazTivT6eEJQg8aM4ackDPFBjvDZx+4WQB++m65+zncvLVmPJfOR7sD3vWIdziW1r7+Ymai1E/8xdzCKA9aW7z7jOeV/2/Aw0FYHLCOj8Ox9XQQW5IQ/RCVb+I8SbhsbSe43VYgcWwzNG3VX8vGJklJ7EhSDkj7/z4yzYjm9hAqCq7vsw6sxHee738P5X6aw1wZAnbBnAYS+yCI7h+OgxUSSZuh9QsFben6HdSTMB8kLKitOWDEENJdioVqoxgdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9ZRhmhdP6LZ4sLtfGWotfzD3xFxMJJ/eaZ9BaVygYU=;
 b=CsxwOBbWFYlhjpNr9LihDnjFO7wVWBpgG1QSNzVuW+2mMIGllhiFFddu5t70+zmSsOIQeHmcpEIgixuS304xdOdGD80Xb3v2PFLm9dz7/uEvtT85hLa2FQyAtIPW/BjZ91MYIU8vHNlJFpFN2XUn3p+eIPMYRMB36MrjWFyzn2s=
Received: from DM5PR18CA0075.namprd18.prod.outlook.com (2603:10b6:3:3::13) by
 DM6PR12MB4700.namprd12.prod.outlook.com (2603:10b6:5:35::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.19; Wed, 22 Jun 2022 10:07:49 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::56) by DM5PR18CA0075.outlook.office365.com
 (2603:10b6:3:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Wed, 22 Jun 2022 10:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 10:07:49 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 05:07:47 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use real_vram_size in ttm_vram_fops
Date: Wed, 22 Jun 2022 12:07:03 +0200
Message-ID: <20220622100703.303697-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
References: <20220622100703.303697-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d892fa02-b974-4f40-5d6b-08da54370ff4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4700:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47001EBDC493948CBA6FE4388DB29@DM6PR12MB4700.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16Ns3vt57PyG924lcyhm5HztNfy5I55Y5kMwcFdXtpX/VBx84VfQwq0jjXOzqC7BLpbXfhGgdUmamR/o18lNl4kMljvc1I1Swwm2qQrrnVwkuwy33XobRzfxscgB0p+/KCQicENPb8nGdEjg+vEu8/T4rvEwsaEQ7sjW3xpGxklqFKCVtFKdLAY+ygJC9yAtej3s7CP77lqYwnGD8dTTVSUghMX61p3PviNJqumIb2Pxf6wEXginksjZjsRnWPUKKUJQ9ld5qT3KwU+3F/WmGTM9tUFnfD/7P9Oj5CWkVPNS0L62i+5P7iqarZBHVAJmsHBy9X6qOP/8whHpVX/iYYFZvil8XvLp7OZxjR2NIR2AxHLEC/W829H/M/y4Iuo5eOAR6a7GFyJGoppb6Tse0Z0aFP/eOTS2p2n/vew4vN0EhuYBqpueAk1WxqHCSxMgt25cReIW3jExlp7eqO+IvSpKUg/5Ntjk58S2LazO9UeSGaM8o0dnFNMF2oGgm4mSRINbIwkSfwBlWVLQkPsYgIpRubWvOP992XYhIQ7pZXB2iMxsdkR/qqUIukuYfdotNGkFqFJCHmpnlrJUvXG6IsARu/inZkEROckXKh9uFB6aKy2TPPj/fjP8LYvTVi5wX3A4ZUes4lGuuxA4XvESSzNSAjIXLhjUMm3baFKVfuuTwrp7Lmzbao/gLsS4lphYQfZmdmuebQanaYpbBX1o+G/vWKUiTiXHwtMwoiP885+pgZzpW458ZRHfLc+rY8yvZqwOx48JR+u3Q2y+ow86CHLCi0zfiQWZ37aHwOYMLcM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(336012)(86362001)(70206006)(186003)(47076005)(426003)(83380400001)(4326008)(478600001)(16526019)(82740400003)(36860700001)(40460700003)(1076003)(2616005)(2906002)(356005)(81166007)(40480700001)(5660300002)(70586007)(26005)(6916009)(6666004)(41300700001)(36756003)(8936002)(82310400005)(8676002)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 10:07:49.2860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d892fa02-b974-4f40-5d6b-08da54370ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4700
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If amdgpu.vramlimit=XXXX is used, amdgpu_gmc_vram_location will update
real_vram_size based on this value.
mc_vram_size is the real amount of VRAM, initialized in gmc_..._mc_init.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 952e99e6d07e..8f245e9f8f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2252,10 +2252,10 @@ static ssize_t amdgpu_ttm_vram_read(struct file *f, char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-	if (*pos >= adev->gmc.mc_vram_size)
+	if (*pos >= adev->gmc.real_vram_size)
 		return -ENXIO;
 
-	size = min(size, (size_t)(adev->gmc.mc_vram_size - *pos));
+	size = min(size, (size_t)(adev->gmc.real_vram_size - *pos));
 	while (size) {
 		size_t bytes = min(size, AMDGPU_TTM_VRAM_MAX_DW_READ * 4);
 		uint32_t value[AMDGPU_TTM_VRAM_MAX_DW_READ];
@@ -2288,13 +2288,13 @@ static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
 	if (size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
-	if (*pos >= adev->gmc.mc_vram_size)
+	if (*pos >= adev->gmc.real_vram_size)
 		return -ENXIO;
 
 	while (size) {
 		uint32_t value;
 
-		if (*pos >= adev->gmc.mc_vram_size)
+		if (*pos >= adev->gmc.real_vram_size)
 			return result;
 
 		r = get_user(value, (uint32_t *)buf);
@@ -2442,7 +2442,7 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *root = minor->debugfs_root;
 
 	debugfs_create_file_size("amdgpu_vram", 0444, root, adev,
-				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
+				 &amdgpu_ttm_vram_fops, adev->gmc.real_vram_size);
 	debugfs_create_file("amdgpu_iomem", 0444, root, adev,
 			    &amdgpu_ttm_iomem_fops);
 	debugfs_create_file("amdgpu_vram_mm", 0444, root, adev,
-- 
2.36.1

