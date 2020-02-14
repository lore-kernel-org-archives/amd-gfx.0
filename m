Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C315C3B19D
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224442187F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TBHpnpo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224442187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D211D6E811;
	Fri, 14 Feb 2020 14:05:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC936E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vhxiqo3gzLH17TcmBbSKnSuWxKwxoloT7YqTNVrQz6DgL6TEWN4BYFXHt7czgEjYdr2mQmWCNXDtAPrShjD9yvYrFU5llNCzZBdDSQcM49kTH28TLSlq73U0C7ycRaCRth0M2YnfUIUGLFoJbg8p7C8qHBqIOggPCkOXGF7QbKVLRR6T+DG294TREV7O/xHzoVx+pqhnVL9QRxT3yW44ta/1UvUtVHPv03O0yy8I/Og2QLyzbZJ9uOmxdnXYO4yazOWlaSj/N0+drtX7Qcee85VEG533eOSS7kfJHncndN961Vg9lsqimVgzqHRKjJy4AzWrfk/0qZ6EfOFOXQ9+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/+Krr0nUgLHp6wU382RfPl1iCXTaRgSfHU6+cz9hrw=;
 b=a2/3HNUFT/uEO+QMydJj0o7+Kc6XEi83tv0oZHs8DIg/T9woWKv9dFg6nh72bueo0wptcjtTdOiTg2jzGDSml2bv/mPIf/KklydISKsZhDQeanEorXnuyEiq0RIc15ToPc4LI4CYF4zpsHV+F8t3zoETqU0CTF11GvqduUlYPXFTJk+NyR3Jmk3JQnDTHI7OXMCX6N+RZrs3eXHGVUj+0A8ygplJiwmHOmYNjsqTsJAP84xGaSFn0OjgrXbY5rErawIVya3f9CleiN6R8PuK3ZDtC/Yh4OrgpP7vbQNOvDAawyUw907ZWuSFn+3CUs/yR2orUpWdthD+HWH+oVAAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/+Krr0nUgLHp6wU382RfPl1iCXTaRgSfHU6+cz9hrw=;
 b=TBHpnpo3+eDaon/h0utEPLy7GZHU09eHIApFDn2OdVmXURNMIZuzptyo9FDsQYuix/uFdmfqBVr4mXF/K/uAlBHvX1/scHECDGAy5bZpp7hcjikyM3Q1cAmR8macoM3cZLybwxl6Lb4PqkdLj7e6M1LjVkv28CaYfgUKbZSwXfQ=
Received: from MWHPR12CA0070.namprd12.prod.outlook.com (2603:10b6:300:103::32)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 14 Feb
 2020 14:05:16 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::206) by MWHPR12CA0070.outlook.office365.com
 (2603:10b6:300:103::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Fri, 14 Feb 2020 14:05:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 14:05:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 08:05:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 08:05:14 -0600
Received: from hersenwu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 14 Feb 2020 08:05:14 -0600
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/powerplay: nv1x,
 renior copy dcn clock settings of watermark to smu during boot up
Date: Fri, 14 Feb 2020 09:05:08 -0500
Message-ID: <20200214140508.4582-1-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(189003)(199004)(6916009)(336012)(6666004)(8936002)(70206006)(36756003)(478600001)(356004)(2616005)(8676002)(70586007)(2906002)(426003)(7696005)(81166006)(26005)(186003)(86362001)(4326008)(1076003)(316002)(5660300002)(81156014)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3212; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84c4e88-82af-4ff4-d7c5-08d7b156ea79
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212EE110C018492CEFCBD90FD150@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJxz21OVjM8L6ZR9YQi6M/pY90toZ/hehrbuYLp8lXH1F6TOqVXDlGv5akAn1dkGzJq7Up5HdwHFZosIjFIMGZnTnh6HOzMCB4M7R0MYJ+ISUFor9ahNMpf1WOrQVi0DP0Z++5P+sIuQJtBnksLt3iZILBWoBW2psUJBo2RxQyTR4baaeUMbpUzLJavInNlYRMkI2QXA7H3K0ZbfhVsDb2tmpoIfrwW0lGEv0MJn4AoHvKiJ/HKvHsS0w58X9iOvznc1TarVgrlyABjRrPeQeXPEj8vL71EJ+d3GPu3ILotuyn6mzb4x6KMjgFxWITcQaIrStFm0+n1CNlQIOdY+uiAOG9pn+rtAk/Qdabj3Jx8IKG57vm70izV0RC8maD5aROC1nIGGyogSCYod5Y5Lcigu4WQOtkEvGBR0fz742xgmCEMjzQNlBUrUhdz8vMi5N2vUgG7sMKib4MZSs0dDWVLLMzR/8OchSo3Ujn/dQcfnSSk8Jd4TJ46yujXEhYeUVFqDiEdE28VZJ3HXSRYsZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:05:15.4533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c4e88-82af-4ff4-d7c5-08d7b156ea79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: Hersen Wu <hersenxs.wu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dc to pplib interface is changed for navi1x, renoir.
display_config_changed is not called by dc anymore.
smu_write_watermarks_table is not executed for navi1x, renoir
during boot up.

solution: call smu_write_watermarks_table just after dc pass
watermark clock settings to pplib

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c |  7 +++++--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 22 +++++++++++++---------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c |  5 +++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9f2428fd98f6..882d5db427db 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2056,8 +2056,11 @@ int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 			smu_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		smu_set_watermarks_table(smu, table, clock_ranges);
-		smu->watermarks_bitmap |= WATERMARKS_EXIST;
-		smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
+
+		if (!(smu->watermarks_bitmap & WATERMARKS_EXIST)) {
+			smu->watermarks_bitmap |= WATERMARKS_EXIST;
+			smu->watermarks_bitmap &= ~WATERMARKS_LOADED;
+		}
 	}
 
 	mutex_unlock(&smu->mutex);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 0d73a49166af..aed4d6e60907 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1062,15 +1062,6 @@ static int navi10_display_config_changed(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
-		if (ret)
-			return ret;
-
-		smu->watermarks_bitmap |= WATERMARKS_LOADED;
-	}
-
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
@@ -1493,6 +1484,7 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				       *clock_ranges)
 {
 	int i;
+	int ret = 0;
 	Watermarks_t *table = watermarks;
 
 	if (!table || !clock_ranges)
@@ -1544,6 +1536,18 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
+	/* pass data to smu controller */
+	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 810994017f49..bdbf1fc48c68 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -810,9 +810,10 @@ static int renoir_set_watermarks_table(
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
 	/* pass data to smu controller */
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
 		ret = smu_write_watermarks_table(smu);
 		if (ret) {
 			pr_err("Failed to update WMTABLE!");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
