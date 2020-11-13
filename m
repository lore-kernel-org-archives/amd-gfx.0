Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8BBC63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCE22224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yGWnIyCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCE22224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9C26E83F;
	Fri, 13 Nov 2020 20:58:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7866E83C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/3KROGGGbTS3QIrcE419aMOpMQXUFuP5SmLu7DGkA0xquH7Cftx0v+TUB5kqfggf+UFW9e5m2oNxJrqDK3Sn72eoNkpES8Fvz18Pir2pQ8rixImVp8xTlmtQ3SnTOI2ZqNS6MLjdHSW91n1fGf6o6L93VwKd9Amz1UWZi8GBXfbei/WsL8JaI+QQf8Am+I79UpbtkVldZBrzGMp6aB601iLcW9S2mHzcTi0j8KGYkbjPyJBuAVS1SrTTtMkhzptKatO8CbsVy03MFGsJX5J/Q1mSv51kf70akCPPBBtmWvYgqoowe7CWdeQbLIrEGdneZN1NJ2uwvklN+8VYaNoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qtu1OE4rOjIVEOGnjh/j+w5IeBtwbhPRkdqLE3Wc5o=;
 b=TCnZdXh5Q0OI+HeCmt9i/namE+y6Jnaz1w4JvM1k28lEC/jgfSU53fv3HL4uz/F/Qs0B0UykoOp64iqWgsCz9fueNejTHxvipAGe54F721sjh3C5d2qsC+nOOPCiEhXe2dz5anU4wBp4Hpy06Sg0vVw+p3C31CHL7dZjc5FWfxEvEeKyG1k7osqhwRpMv/XAhbabT261pCAt7cF4fmHN6nw3irVs9wdnTebAQ8lORLMBMZILWtZ34El0JuKSO6nRc1dgrMkmZPoh0+ZSC/jfTkmJ5y8tD5yTBWonZf3wEAorM4V36h6gG/+sTNs+i41RY5Dt92SF+HVFa1CbcXp3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qtu1OE4rOjIVEOGnjh/j+w5IeBtwbhPRkdqLE3Wc5o=;
 b=yGWnIyCqeToCppblvLC9z2FkDwDpYsrS06P94Zaib1gJcLC14aB+HCrL2hCBXeubOmNoFEJwpHtl2ZRjYRsxQpYxRHmFQiki1Dxb4zy8OkTpZIC5orE2as09MxmyT1qFDnOxmVqK3bAbqrxTYc9lTO078zyIxIwNkCSAoV6PDho=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by MN2PR12MB3245.namprd12.prod.outlook.com (2603:10b6:208:103::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:00 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c6) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:58 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:58 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:57 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/17] drm/amd/display: remove unused dml variables
Date: Fri, 13 Nov 2020 15:56:33 -0500
Message-ID: <20201113205645.640981-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006cbd74-cb18-4743-8066-08d88816cdf5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3245DDE31D304983A6A681CAF5E60@MN2PR12MB3245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwCE0q/PVcrXufvR6Czsrrto/cEg/5RFpNuRObQGgksJNMfpQZK1z/1SsHUxMBZKn0WmgnXlSmUS9kjhTmDmwgIF9B38kq37HObS2Uy6v2nSdxJC8Okjlqy8xznE6Q6ElpKX+2cmzwmwl5A0xGwiv1jquRfVWyk2nXNA6qlxs9ZYFdZBZnA++yR0tfITyK0Y/FtO89zrZNw5gPsYJ9ez2HqDKMXXhAh/sy2GUg0IFU/j4ypERHwj97il/wbfbLSwVr4DtykkcPW5PuJuY6dl8VgzfbuStlLqyVhwVaYMQFpehZ4Ujk9qmXpJRARhpFOnXkNPTmKdoBuUwBfzw7UOZvKgbfY0lLvrOCh71X6OzpjjvMDv46lG4EHbUfYAn99+FeKgdh1XzVKlBHDszrVEaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966005)(36756003)(83380400001)(478600001)(356005)(6916009)(4326008)(26005)(8936002)(70586007)(336012)(82310400003)(7696005)(2906002)(70206006)(6666004)(186003)(426003)(8676002)(5660300002)(47076004)(54906003)(86362001)(81166007)(316002)(82740400003)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:59.7312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006cbd74-cb18-4743-8066-08d88816cdf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c     | 2 --
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h     | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 162464261205..dd0c3b1780d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -334,7 +334,6 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int vblank_end;
 	unsigned int htotal;
 	unsigned int vtotal;
-	unsigned int refresh_rate;
 	unsigned int vfront_porch;
 	unsigned int vactive;
 	unsigned int hactive;
@@ -345,7 +344,6 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned char interlaced;
 	double pixel_rate_mhz;
 	unsigned char synchronized_vblank_all_planes;
-	unsigned char synchronize_timing_if_single_refresh_rate;
 	unsigned char otg_inst;
 	unsigned int odm_combine;
 	unsigned char use_maximum_vstartup;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 3ae72e379402..c9fbb33f05a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -659,10 +659,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 
 	// TODO: ODMCombineEnabled => 2 * DPPPerPlane...actually maybe not since all pipes are specified
 	// Do we want the dscclk to automatically be halved? Guess not since the value is specified
-	mode_lib->vba.SynchronizeTimingsIfSingleRefreshRate = pipes[0].pipe.dest.synchronize_timing_if_single_refresh_rate;
 	mode_lib->vba.SynchronizedVBlank = pipes[0].pipe.dest.synchronized_vblank_all_planes;
 	for (k = 1; k < mode_lib->vba.cache_num_pipes; ++k) {
-		ASSERT(mode_lib->vba.SynchronizeTimingsIfSingleRefreshRate == pipes[k].pipe.dest.synchronize_timing_if_single_refresh_rate);
 		ASSERT(mode_lib->vba.SynchronizedVBlank == pipes[k].pipe.dest.synchronized_vblank_all_planes);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 4d4ed1287673..3529fedc4c52 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -921,7 +921,6 @@ struct vba_vars_st {
 	bool UseMinimumRequiredDCFCLK;
 	bool ClampMinDCFCLK;
 	bool AllowDramClockChangeOneDisplayVactive;
-	bool SynchronizeTimingsIfSingleRefreshRate;
 
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
