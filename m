Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19A3C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 11:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721BA206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LfSALo1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721BA206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2685A898F5;
	Fri, 14 Feb 2020 11:32:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB533898F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 11:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEBYxr6NubsgxzzxjP/2mZVd+TtF9bPwnu35sGgt1rghkImfKWutAj2u9f/yBfBq6Le1P8fKSh/HAd1DIsw8eScpsuiNeH20H4Pg97POFJht3rTSUtF6YXx52t9SQA68y+iWWwOPgVx/bL4z8fHVIfcgM5ybwzHcFokkwDYo8EyAwy/EPCTxvqwOCLE6aRwksUY0D4SB7uJbg3EaUyS2EFT3NWibWvEWzsfQt++1HN98JPuUHaF7GCYbiJk1yEilTyJr2YMY7MKMYJy7hFgt25C8WjLJS5tX0ZN4cZyI1Q852dCLtC25xASs2adDqVgwh3PqIqJ/Q4N3mI5sMHkkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5pI/DIO0cDlCNHlp0OuflLkl+QLDB7TxZb6makefrs=;
 b=awlan3MDYNV3oYpePqDobyNWKf2vhuDm6AzvSytQHp/tmxAp4PnZYA2qlzUW4XoTjdvpky3nr5ztonfFM2IPw1S1HZPIwclfJ7C34SRjYMl+qST7D6UeK2XVtOyMMitG/tQ5l5QiOyGiF8yRtDOoFL49deKXpwBXN/BSbh9TpxszHHvvGd9opMcCiw/VfhdNfuwiGtiUGRbQCWm0Mw/vD7lMOVwoPoBm3aoNxvXvlLNx0Ms/UQ+4gjMoKnRWL5WpVQ1YYXvyw5ga+CuiM7H2yiwwXTk9IOvj00JZwak5jYjijbqFDWUVuJic3Ee9uMlL1OAg8l4L9dZgpe4ukbZM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5pI/DIO0cDlCNHlp0OuflLkl+QLDB7TxZb6makefrs=;
 b=LfSALo1qEz7StL4vWP33fRI9znGGcN4lfVzbj05QueQQQU5fraDoGjE0IZcqqn5Sg6CfMONN5MNmllBU7CF0YQ0DfHzOtXLagz+B3/+4xoRCTw7Mf1AIMzqf5u2U3YL5ibzWjs7VSzgYY7VnxdP8rAS9pvwv+Q/I28GkAzt/GRE=
Received: from BN4PR12CA0009.namprd12.prod.outlook.com (2603:10b6:403:2::19)
 by MN2PR12MB3517.namprd12.prod.outlook.com (2603:10b6:208:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Fri, 14 Feb
 2020 11:32:55 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by BN4PR12CA0009.outlook.office365.com
 (2603:10b6:403:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend
 Transport; Fri, 14 Feb 2020 11:32:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 11:32:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 05:32:54 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 05:32:53 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 14 Feb 2020 05:32:52 -0600
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sysfs interface to set arbitrary sclk value
 for navi14
Date: Fri, 14 Feb 2020 19:32:32 +0800
Message-ID: <1581679952-16214-1-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(428003)(199004)(189003)(70586007)(478600001)(70206006)(316002)(26005)(54906003)(2906002)(4326008)(6666004)(356004)(7696005)(86362001)(81156014)(8676002)(6916009)(2616005)(8936002)(186003)(426003)(36756003)(81166006)(5660300002)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3517; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a74030-9a4e-4552-e44a-08d7b141a236
X-MS-TrafficTypeDiagnostic: MN2PR12MB3517:
X-Microsoft-Antispam-PRVS: <MN2PR12MB35175C1D1CBF9075E615336A8B150@MN2PR12MB3517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZc51thFCzx7v3Xslp0o7jxm7EOZtINfxv59aB54wF+0m3fZjFAUsM4fGJCK09o/T3U8wEb/9HoJd0JfcEYmhMzw9YYPfRYQbTQEEiNfmBsPn/3KORj4AaImiDvJRsBk1gLSjZIotNCpVxbOKKDesN1IpCVi1CJ6+Lf9MMJYS/afFqWRqlF5Ldr5wKKBhIqSjWTdvg+yD588Aa2ar8gO2V9EZ4mkrGSqqM9n+zYXOZn8rcwfrXIM0EwUw5hqSbimTRXeN/wbb79lxYcrW0y7ljohVh3t7gt7MGbqZ3hfP4mX1lcAqNA3/QVc7ElRV9JL5/CXBfySrjcijAPgZZl3yyoORWgeh03ML/XZxLkWFp1VB9vmvJbyqJrAWGl1oacq5KaF0jhnXlbbEeDTGIBgh/Mb7Omx6tVG13P4hydMIrnIRGA6u76kEudSez62kN+5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 11:32:54.8291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a74030-9a4e-4552-e44a-08d7b141a236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
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

Add sysfs interface for arbitrary clock setting
pp_sclk - amdgpu_set_pp_sclk

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c    | 42 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c |  9 +++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b03b1eb..e32a1e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1036,6 +1036,40 @@ static ssize_t amdgpu_read_mask(const char *buf, size_t count, uint32_t *mask)
 	return 0;
 }
 
+static ssize_t amdgpu_set_pp_sclk(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	int ret;
+	uint32_t value;
+
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = kstrtou32(buf, 0, &value);
+	if (ret < 0)
+		return ret;
+	if (is_support_sw_smu(adev))
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, value, value);
+	else
+		return 0;
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	if (ret)
+		return -EINVAL;
+
+	return count;
+}
+
 static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -1797,6 +1831,8 @@ static DEVICE_ATTR(pp_force_state, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(pp_table, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_table,
 		amdgpu_set_pp_table);
+static DEVICE_ATTR(pp_sclk, S_IWUSR,
+		NULL, amdgpu_set_pp_sclk);
 static DEVICE_ATTR(pp_dpm_sclk, S_IRUGO | S_IWUSR,
 		amdgpu_get_pp_dpm_sclk,
 		amdgpu_set_pp_dpm_sclk);
@@ -3288,6 +3324,12 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
+	ret = device_create_file(adev->dev, &dev_attr_pp_sclk);
+	if (ret) {
+		DRM_ERROR("failed to create device file pp_sclk\n");
+		return ret;
+	}
+
 	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
 	if (ret) {
 		DRM_ERROR("failed to create device file pp_dpm_sclk\n");
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index b06c057..9d15acf 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1799,12 +1799,17 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 {
 	int ret = 0, clk_id = 0;
 	uint32_t param;
+	uint32_t min_freq, max_freq;
 
 	clk_id = smu_clk_get_index(smu, clk_type);
 	if (clk_id < 0)
 		return clk_id;
 
-	if (max > 0) {
+	ret = smu_get_dpm_freq_range(smu, clk_type, &min_freq, &max_freq, true);
+	if (ret)
+		return ret;
+
+	if (max > 0 && max <=  max_freq) {
 		param = (uint32_t)((clk_id << 16) | (max & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxByFreq,
 						  param);
@@ -1812,7 +1817,7 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 			return ret;
 	}
 
-	if (min > 0) {
+	if (min > 0 && min >= min_freq) {
 		param = (uint32_t)((clk_id << 16) | (min & 0xffff));
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinByFreq,
 						  param);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
