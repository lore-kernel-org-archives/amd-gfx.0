Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60EC3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017A224688
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 02:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uQiQKPrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017A224688
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFAF6EDD3;
	Fri, 28 Feb 2020 02:37:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146366EDD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 02:37:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxkRi3htx+g0a0g0wkPR1RVxsha2VezuPdU/ang5t/AWLk41lq9P3O7ZCubnuZW2Z1wz3ihs5XcK3LCZn7DutSw915AzMS82nM+V7J0q/lysvT9pwuEZtRuI170Brn453akdUIDYrMa+DMsLbuW7HjgT2CVMkGioJHu9v00Bf2R1ByQKk4dQL4P0y1YDH602SQc2XdM7b4IVSjpc0a5O7RtmD8vr6SN3LZ6fJVa7OasoRGPDoFTMDT+K+kwEYqNmRt5Q63sF5skmbPDEmaJnnPIr0sxWimWOlFQu8FcJEfv3Ha9ynZg9oMnyL1AtY0i/st2ZPxxKZm2aa3ErrqnUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLRAN2eVy+McWPTbSJYEzPJZ4s8xfQUcnoG38QlfCHE=;
 b=Z0pOfxemXE/MwRzYj0sUPpu/ESYFUp9FTrdJb4e3cyg6pU+bUdPPXThYq/5rfsGgBsVnFSTjQbHcnavgCCve+NeUnuIo/Nf1w70ot4sLTsxZFxI0QWyE+txX/NOUmC2QTiI3hy3lmX3sWSRVbY5fJENzwVchNH2d3T145H5Hf4eVElmFQT8dr8h9ZNbB4mcLNIBCR9ZfHQsxI9K7dTAgJLRCVD7m7l//c8Gp47G1mPEwaEPTsbYnzm0K4kYHc/tlKC2UevpNpA6IE5OAqSE8E6h4GygzCfNT70xgWY69e6OpwPDRGlJ+QP+PvQbOTcyfDsJzqigedBilntxNYB1CsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLRAN2eVy+McWPTbSJYEzPJZ4s8xfQUcnoG38QlfCHE=;
 b=uQiQKPrXRiH5kbB2nMyhXZwI1xIeTknUbokA2ecE6LbUIs+45tNtimoxTdXqLE0A5hvqywXJ0/F2k5BumzoMptrjtbl4qn5OlUkkO/1jZj+LmmtaeJi8j82tVSsFWB2vZfeyx+MrCOZRsY4lDTKc/e+DLCrEFD9QtoNkX+0A1gI=
Received: from DM5PR12CA0070.namprd12.prod.outlook.com (2603:10b6:3:103::32)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 28 Feb
 2020 02:37:55 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::3e) by DM5PR12CA0070.outlook.office365.com
 (2603:10b6:3:103::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 02:37:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 02:37:55 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 20:37:54 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 27 Feb 2020 20:37:52 -0600
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk
 for navi14
Date: Fri, 28 Feb 2020 10:37:21 +0800
Message-ID: <1582857441-32135-2-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
References: <1582857441-32135-1-git-send-email-Jack.Gui@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(428003)(199004)(189003)(186003)(26005)(86362001)(2906002)(478600001)(7696005)(2616005)(81156014)(336012)(81166006)(36756003)(426003)(8676002)(70206006)(70586007)(6666004)(316002)(6916009)(5660300002)(356004)(8936002)(4326008)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4235; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1de04986-87a1-4a3b-58ea-08d7bbf73714
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-Microsoft-Antispam-PRVS: <DM6PR12MB423535617B30D431E7F0F9E08BE80@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Oh2P1zE5eF8SPPzd2LolM1YnBkWcNaSs/s5A0kJZX1oukUVlWEQJlnny1UnrsFkZXeAZq7dXe8l+OqUsN2u4wI9yOQhCL56qyL8mHzIuGj0Lq2DSYig58Zey7f8V+Rc1fgAqZpVXOfNR6R5aEiMI3pdPXo/W4A8qbS/FzC79pAnJvqDDSl7d5UHCduu6Pq2ao2mzJUnMYmXyHH5Os/s+ipVmEP/EyPdMDCKBAIEfWEExzYdSKSe0rnGf7C1zod13wEaeyBYkHUfKtPQGrTIjmWe/Nsmy7jKx5sL444HbS2+UjiKT2XTDZ5GquEveyBEyQrttaFM8WZVuG3Gy3Wajo+UtZi8/TO1JnQpXLlsm++wlA6OWLOjGA5sC5QU6irDXiTgMTsXxuUBqhHsKefjPB8r6ElpDYxU7uGGDYR6z1lBdfyMClo6bzcTSuUeC//F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 02:37:55.0721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de04986-87a1-4a3b-58ea-08d7bbf73714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

add debugfs interface amdgpu_force_sclk
to set arbitrary sclk for navi14

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c    | 44 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3bb7405..5ee7e92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1269,9 +1269,43 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	return 0;
 }
 
+static int amdgpu_debugfs_sclk_set(void *data, u64 val)
+{
+	int ret = 0;
+	uint32_t max_freq, min_freq;
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(adev->ddev->dev);
+	if (ret < 0)
+		return ret;
+
+	if (is_support_sw_smu(adev)) {
+		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq, true);
+		if (ret || val > max_freq || val < min_freq)
+			return -EINVAL;
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
+	} else {
+		return 0;
+	}
+
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+}
+
 DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
 			amdgpu_debugfs_ib_preempt, "%llu\n");
 
+DEFINE_SIMPLE_ATTRIBUTE(fops_sclk_set, NULL,
+			amdgpu_debugfs_sclk_set, "%llu\n");
+
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	int r, i;
@@ -1285,6 +1319,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return -EIO;
 	}
 
+	adev->smu.debugfs_sclk =
+		debugfs_create_file("amdgpu_force_sclk", 0200,
+				    adev->ddev->primary->debugfs_root, adev,
+				    &fops_sclk_set);
+	if (!(adev->smu.debugfs_sclk)) {
+		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
+		return -EIO;
+	}
+
 	/* Register debugfs entries for amdgpu_ttm */
 	r = amdgpu_ttm_debugfs_init(adev);
 	if (r) {
@@ -1353,6 +1396,7 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_ttm_debugfs_fini(adev);
 	debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->smu.debugfs_sclk);
 }
 
 #else
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 97b6714..36fe19c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -371,6 +371,9 @@ struct smu_context
 	struct amd_pp_display_configuration  *display_config;
 	struct smu_baco_context		smu_baco;
 	void *od_settings;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry                   *debugfs_sclk;
+#endif
 
 	uint32_t pstate_sclk;
 	uint32_t pstate_mclk;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
