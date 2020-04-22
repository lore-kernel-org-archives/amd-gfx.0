Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D92C5518E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13CA2071C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YYyFXeLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13CA2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD116E12E;
	Wed, 22 Apr 2020 22:08:34 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E94B89FCA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTwyo5m9CVzk6Ck+CVT32wz+vJnrpOjh1USJfqhmOoxV2JKyUQjJMxvU1nKpv1OqNU+sDfDwA9eTsO2UjyYDWcZUIOAm79OxzZjXsQi41IwaGSoyH01TizjITY6f/6K0c5YTBohtXQ3jQhaGwwg/QhFpZnHmbVdG8MqXop9YIVTpR0YQCAJli8uizyJll8QIRRwqCm9HIDyqfNHmrV2OgSIfyN63HoWN27SpqGfq+iXdNvTgt9ogHfgMTN3wwrl6nK9xocEHaqaUBdozH+EsP0hIQpJkkp3+POCXKe6tEQiG7GaWv2C+dZ/cECnR2l985dy595C0dBW/XEF2XJD0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vvHORoXiGzYraSx3FNTWo/qCNqTvsoiBbHcUONp7m8=;
 b=TH5llw1WmwjPJXt0ts+J6V8Kep8InC8sWLVwjRh5BF+KaTB6BOKkLQI+mAMJUSYXflrGhvkI2pkTHqavTWDhgAPt6AUPbsZVZ14Lkr+98r6AM9yZwJwPASneYTtCqKd4vcSUqHmrKgSl0g82kl+SUWDapSaHeoo5Btgwi1563kwSTqEzrv1NrgS7aB083EEpbdagT6BwmZqlE2svaoR6fyzNKSoUo3w+FlkfhvnQqf3/4DJ7n7FLgruDHzitAuZzG28JDE2pLvhSASl5pOXvsnHMDFikoV8EJgovX4D5RTEXY2uacsQtrd0QfDfZctF6OuUD094ZU0zXlWS3fuyr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vvHORoXiGzYraSx3FNTWo/qCNqTvsoiBbHcUONp7m8=;
 b=YYyFXeLuTwrDWmiklTdwE9TnRhXHBeT44rdIebIzsv6pvOK3CPJqJRgVAyHmF42ycJdpv5YF4D+IvptSyUuba8aJnKzurWUUUE2AfRAzUKSkusGLWII0bF8N5wH++YMyli3+9HkldUynsbq3MxzSNZa6A6HsGSN8JdUqAUiPvJk=
Received: from MWHPR22CA0051.namprd22.prod.outlook.com (2603:10b6:300:12a::13)
 by MN2PR12MB3264.namprd12.prod.outlook.com (2603:10b6:208:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:28 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::5e) by MWHPR22CA0051.outlook.office365.com
 (2603:10b6:300:12a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:26 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:26 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: Add dummy p-state latency bounding box
 override
Date: Wed, 22 Apr 2020 18:08:00 -0400
Message-ID: <20200422220805.15759-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(428003)(46966005)(426003)(70206006)(70586007)(54906003)(5660300002)(356005)(6916009)(44832011)(82310400002)(7696005)(81166007)(4326008)(81156014)(316002)(8936002)(1076003)(8676002)(336012)(2906002)(86362001)(2616005)(26005)(36756003)(47076004)(478600001)(6666004)(82740400003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03e08f71-a194-4650-b111-08d7e709af3f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3264:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3264DB156603A2B6808466B08BD20@MN2PR12MB3264.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDSbGGndQxdDAwRXa1B4la0TtMH5GawECJsb5zCMg6x0D6em6a207x2xqmO9PZSjWVMXJIi4BLnPQkYZgMez9o/FAoXVAadxG4LjP37SStpwLAczuaXtfNudxa+MEFRFpMurCdJN4x97Ne3TVjUNBLY0Z4zm0aBilAn7NHtPATnzXQzeoQFI3xdjwb6JSrQQTJ/Yvde4vxBKbHRHfS9bAQCi6RaakUjciTjXugr/OW37USBDlBNKs1n9WT/k6tM7LI+XvWXFeuFtEjf53wWz5nxcF/OLjfn9e6s5C1H6dgjV3Z337ljM+tSaOWZYqe2tvRD2Vn4XCrJzTo5YYxk3g3Swa+q0mGDNUd/3VK8qpianDwG84un8GzYFEdgd4fGhIqcKl04O4C91R/+gmolsP0rqtrjaEiMPy9cjv3oE/QDqqyb0M2oqY8r6j0PHI3hHiwtQKSiWsbhY+f85gTh6icpBEhGC8HBlMV7bxssTnYsSZCEzfibihuua9dPAOfMCE+P24u9H6aY6NSRXjo6mMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:27.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e08f71-a194-4650-b111-08d7e709af3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3264
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Joshua Aberback <joshua.aberback@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]

For debugging, it can be useful to be able to modify the dummy
p-state latency, this will make it easier to do so.

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 84e5056521a3..99c8e40049e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -478,6 +478,7 @@ struct dc_bounding_box_overrides {
 	int urgent_latency_ns;
 	int percent_of_ideal_drambw;
 	int dram_clock_change_latency_ns;
+	int dummy_clock_change_latency_ns;
 	/* This forces a hard min on the DCFCLK we use
 	 * for DML.  Unlike the debug option for forcing
 	 * DCFCLK, this override affects watermark calculations
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 3a8a4c54738a..b7e4d0c2432c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3467,6 +3467,13 @@ void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st
 		bb->dram_clock_change_latency_us =
 				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
 	}
+
+	if ((int)(bb->dummy_pstate_latency_us * 1000)
+				!= dc->bb_overrides.dummy_clock_change_latency_ns
+			&& dc->bb_overrides.dummy_clock_change_latency_ns) {
+		bb->dummy_pstate_latency_us =
+				dc->bb_overrides.dummy_clock_change_latency_ns / 1000.0;
+	}
 }
 
 static struct _vcs_dpi_soc_bounding_box_st *get_asic_rev_soc_bb(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
