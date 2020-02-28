Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B99C3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5624688
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OaQOw/aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5624688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B14E6EDCE;
	Fri, 28 Feb 2020 02:37:44 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2289A6EDCE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 02:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYbAVzLRDO4XFt4Cd6x/1k24VCAT6K6dJ50Ixm2SKPqQWG81NRp+or9ydlLL76qigqpaceflqHie4P5co473ds7rJ9InS4IGkUf4XR3HMF7+62G1KVRQe+W2Ip9/wJH0zVzdBy1AcLrPAbjMLwwCD163p1schTNpZBAFr2g8Op7W58rcN+UTVdUl/cLwfx6CBtJCG2NKhxdOWZ7pv3OVMvFFI0IP8kybSPFnlp3/x9t+Q/2WpFCzCLvDeDtf/EQufTLyZyTx08+6vJkYIMbOa6Esz3BXniP5NRTFyOo8oJXCPPDi3gUhUkvbf/LYr83gxMxEYXteNRWx56B/+ebAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+atZShILhw07Dod8r/nYkWVDiVdlsGwNCtfdpVq88=;
 b=F4SsKKha1HlDyzVFoqqiyYTrdXSf7qcvXXD20Po4YY+3o0oCUA+W41XUauj/ThF2x0giq3Z15KkAa+wX8wxbjbu6JxOaclM0OVItILTk0/SvZ5nYlxpGkmzQAUiB7UHeQuqZ2VPQK4nXZ/ffAwapHJn6mtqnBProMg5moEDz2l/p33f03rDjuGUXYpL/1J/3Lrw9IVSDCkO7fdYFsh5kNqdedjr6ApoVrk/4KlXj8BfnhZhnjdYqYHGyASDOSul0CxoLl+h9+SufGidLUD2EWWinbF40Hu/Uzd9mEkwhLY/DtUs2WEc7IxnLU7ajSoNx/Dr7xRAwdMxrI0vxOWd9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT+atZShILhw07Dod8r/nYkWVDiVdlsGwNCtfdpVq88=;
 b=OaQOw/aqhxbNHtWdNpdb0P0XiNjK52TxR7ZlVKdKbZHbQqAIOeoSzYrpXxelYbdOf0o7gvrtRIbYMMuCgZ5UORvci7rokmWub6731ihHGLaLVZVNpYULmI25vrbB4Js+iBwxwbf26kTMCa+tMu0mVDzjZ0swtJjIE1/NsHH1mCI=
Received: from MWHPR2201CA0043.namprd22.prod.outlook.com
 (2603:10b6:301:16::17) by BY5PR12MB3906.namprd12.prod.outlook.com
 (2603:10b6:a03:1a9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 02:37:42 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::f7) by MWHPR2201CA0043.outlook.office365.com
 (2603:10b6:301:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Fri, 28 Feb 2020 02:37:42 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 02:37:42 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 20:37:41 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 20:37:39 -0600
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amdgpu: add sysfs interface to set arbitrary
 sclk value for navi14"
Date: Fri, 28 Feb 2020 10:37:20 +0800
Message-ID: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(428003)(199004)(189003)(5660300002)(36756003)(4326008)(70206006)(70586007)(7696005)(478600001)(2616005)(426003)(8936002)(8676002)(81166006)(26005)(336012)(86362001)(186003)(2906002)(316002)(356004)(6916009)(54906003)(81156014)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3906; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 433e8593-a0cf-406c-7a32-08d7bbf72f5c
X-MS-TrafficTypeDiagnostic: BY5PR12MB3906:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3906A1C0BDEE175A32E55B4D8BE80@BY5PR12MB3906.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LRmuYIUYju2yrvJQ/cRvZFV1Q+/z9N+rVCt4XAzpYGH33MPgF6NEg0ejEhMC3YezU8hKFKFpg7XzWh/LjfGXNZfX/FgWaAeMhzAtPD2CpQfVRai7e5ZLxY3T7PIzbhEZWLhAZMr2+fwT2V8FxhXt4S4X+MTRok0nQrOKud9EdSbbtRqrXZTB91vmOhs7x/T7KgYdQQKLsNrTbi+407/D62+MKcRRGYXkE+vwgpHGSfAKNm2QCoWayD8a3WxqCWtF0a/Wa2ZTO2EMX+eJjYwqK567d4q9lNPitu9s2ZCUccqBeRTP1X16oyQ/eLhuEuSHUzVuaHRgE9XNvbKZpTXXVJmUl3zZGeV0nGjKDkjkX6ssNkortOaHnHN66qe6PWBmLbiX5JNl76HCDGp37W+1JsDe7lfwA/sjS0/GEzIDIoOSPZJYAIQ5NRRfgRL6CVk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 02:37:42.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433e8593-a0cf-406c-7a32-08d7bbf72f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3906
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
Cc: Feifei.Xu@amd.com, Evan.Quan@amd.com, Kenneth.Feng@amd.com,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Revert this commit and than add debugfs interface to
replace this to meet the specitic requirement.

This reverts commit 3107269204f8e18f389080673f7848b420970aa5.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c    | 42 -------------------------------
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c |  9 ++-----
 2 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 9deff8c..bc3cf04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1034,40 +1034,6 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
-static ssize_t amdgpu_set_pp_sclk(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
-{
-	struct drm_device *ddev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = ddev->dev_private;
-	int ret;
-	uint32_t value;
-
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return -EINVAL;
-
-	ret = pm_runtime_get_sync(ddev->dev);
-	if (ret < 0)
-		return ret;
-
-	ret = kstrtou32(buf, 0, &value);
-	if (ret < 0)
-		return ret;
-	if (is_support_sw_smu(adev))
-		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, value, value);
-	else
-		return 0;
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-
-	if (ret)
-		return -EINVAL;
-
-	return count;
-}
-
 static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -1829,8 +1795,6 @@ static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_table,
 		amdgpu_set_pp_table);
-static DEVICE_ATTR(pp_sclk, S_IWUSR,
-		NULL, amdgpu_set_pp_sclk);
 static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_dpm_sclk,
 		amdgpu_set_pp_dpm_sclk);
@@ -3322,12 +3286,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	ret = device_create_file(adev->dev, &dev_attr_pp_sclk);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_sclk\n");
-		return ret;
-	}
-
 	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
 	if (ret) {
 		DRM_ERROR("failed to create device file pp_dpm_sclk\n");
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 1507bb7..c9e5ce1 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1803,17 +1803,12 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
-	uint32_t min_freq, max_freq;
 
 	clk_id = smu_clk_get_index(smu, clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
-	ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, true);
-	if (ret)
-		return ret;
-
-	if (max > 0 && max <=  max_freq) {
+	if (max > 0) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param);
@@ -1821,7 +1816,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 			return ret;
 	}
 
-	if (min > 0 && min >= min_freq) {
+	if (min > 0) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
