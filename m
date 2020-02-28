Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BCCC3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132152064A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 09:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DRVEOq5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132152064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CB86EE90;
	Fri, 28 Feb 2020 09:00:48 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D826EE90
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 09:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcfZTjEdFf7trS52VxoHBissqp4j9lchUEeo5IvZeGMU7FLervR17wIKxx9fm7cEtxdAGx3Qpvnj5hMWTAyhSM3aHdXy1mPwwGfgL64SfS4JXSaUOWVWjn85ckVgHMfqfnmX6ItBisYs946JPwB4EJvx87UA6CeqnzK1plSre2X0RkRqazZFelb01BLC5EY2lXeX9vSBXFFxB0G8rqmHs6Q20hsaR02U8ft86Rc2KqTgrZueryNmk6ljbRTCeBdRk08u1mjSUiGx6ToYT3YpPf+Q67ocmLy2JGzNM/kJR1COREEkegiWDsc3sIMOYqRRjUesgnBSVrRm30rQCFRhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgcfxTewtHttusm5P2RwvxGOawFTki+8Q1lxNCMmCho=;
 b=ijDpY7Zcq71sQw6IJ+keUhrMLJ/1TaBaZ844k4x2ZcLcEYqCIHN5J1O7gnkHmvIkuDy7bbbyBcqQSzUvXESI5DxlP4xzr9LzQscd5k57fiBOKor1VFh15ZvPxyMJ9Xk1CcoTDqbxglgqvL++GhGCmU6Wv9eCPZAbz+4eaG/sP9Fj4ATvx9XcqevBLxP4rbO07R3/st6gLAvKBDUMWQFUM9qvyXI2D8FLJZ0WiGXcK/ARpfWj1bEgKgVihhHUmcXRHbiCEhtgJoIf/iTKw8m7JMzuLx6lL5DK371cIp3oBrMuwc0VUyY8+Ijwe6K8tXOMk1eC2dWj0wlnr+TP4M6puQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgcfxTewtHttusm5P2RwvxGOawFTki+8Q1lxNCMmCho=;
 b=DRVEOq5BwAt2XRJfWLonxHVSL/RuKP/zaG9VCmt8ZjDIyl3xt+xXDM+jw4GNcYvyNvJYzb5y95692ewuKO2q4Ouv8avJ+KyimEtPYDDLO/w3RqkdbQvu2TCKKiM0syKqvi3lg1LCjxwoAmoxMJcvvuWa5RxnuvyCeF4zqJP1rX4=
Received: from MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Fri, 28 Feb
 2020 09:00:45 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::c7) by MWHPR02CA0015.outlook.office365.com
 (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Fri, 28 Feb 2020 09:00:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Fri, 28 Feb 2020 09:00:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 03:00:44 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 03:00:43 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 28 Feb 2020 03:00:42 -0600
From: Chengming Gui <Jack.Gui@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add debugfs interface to set arbitrary sclk
 for navi14 (v2)
Date: Fri, 28 Feb 2020 17:00:10 +0800
Message-ID: <1582880410-12400-2-git-send-email-Jack.Gui@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582880410-12400-1-git-send-email-Jack.Gui@amd.com>
References: <1582880410-12400-1-git-send-email-Jack.Gui@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(199004)(189003)(6916009)(336012)(478600001)(7696005)(81156014)(36756003)(8676002)(2616005)(81166006)(426003)(8936002)(5660300002)(356004)(6666004)(316002)(86362001)(186003)(54906003)(2906002)(26005)(70206006)(4326008)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2491; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 645a7b14-d8dd-4f3b-2350-08d7bc2cb24e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491406E2DCDED79B1A309EC8BE80@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0327618309
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYWemxx72SvsKwTyoAzCNVkkPc7cCkR1x+FT5T5jCdpQACSaFbwpDNVJw0PNq88QqMQj4KmS9hhSXKjnNmNsyzE/S8ETQjh0ZKUGVvL953KIHbaoRDXwi7ORvc/yuzxfSYywd/6PpGQdAAvhc5L8NOg8jRRpqqs/DzXMe9GDZXRCodpQ7JJWMeP8Isjo28YAZP9LL1LsSBfCFpAkWUAA8tyTw3F0SGasEeIhbSeI2iKWhc05J4TNgFv+1bc3JvHW9xPk9vY/i1bxil5MkPXvd7O7BRLn1y6glU2pyzU42LA6rjwvV6h6ahOONHQzQ/2hhekaHj0DuMZdNGdDFpVG1qA3Wk4w+FOwjed0Dl8soXUvNvQwn0zUCcUKpq6DVoOXQUD0AnJlCX9ysUItU1/g2GvPeHQfCgeWQ7/DPct4MUhKFC2yWMgmJQsjwI8kdcQ9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 09:00:45.0683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645a7b14-d8dd-4f3b-2350-08d7bc2cb24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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

v2: Add lock

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c    | 43 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index abc1482..831f70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1257,9 +1257,43 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
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
+		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val, true);
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
@@ -1273,6 +1307,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index c8e72c7..657a6f1 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -372,6 +372,9 @@ struct smu_context
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
