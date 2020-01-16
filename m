Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE8C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4120663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vV+MCDnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AFF6E2AF;
	Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380F86E283
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+N1aXiJQlFzrqHyJ52UmKjtxcnZ55OTY53+UmyNEK5XPtp5ywmYHE8zncD5RkrRgFrimZrDE4uoVNHi82M6AYBnXVCRVmD8e5FcWSVIXcxh+RXk/sNQiU+UPWjdzNJoLavio33kQoelg58hzg3feEOVNxnIi6DyjjCOVhh7dU/TBVovVXSCi5j+nZvmG2jG/I4BSJedmMLOBafcgAeH5nuDS4jTFf44SYvFPKHPx/l0KRdFBkE+kl/dZ/aCD4jXd/R7PXNKXg4dpphHUZUVTVjXEojm8/mAhjSSSPlKo0+axJGzJ7ypMpJCvuBj8Rih3DAkVmjijhLjoP2XOjmpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwmfCpy5bOkuP2ymPXvT5w70Gb5rr87SMA4M/5qt+Ew=;
 b=UFQc2G7l8LqMTbuRUp03a9gcjz+cf0O2c+pogrY4Z4/aVhJlj2JEHgXxKb9jAeRSrpQBmxKSmkiAFJ/7H5PpSi2UjhpmQEfgGKuL7K6EQ5e4qAQmmwcCet6EKVfOuvxJW7bfAFjC9x0lsPLioSUUGeI+DlmSp95p+JGvFyr3QPKQlQS07X2BkNIkIaJLq1GVC++Bu9OMPJMk0GgBvs9wnbFwEUItE2lw8t0KAyZSx1sBkKW6uFNP04XBTjSjTJ56KuAHDwV50neqNDNviMlEH7BlAkC7iqj32EWxJlkUPyR/jDcoEX9e8W/ypjRrfq6JxchQMqFMTJQR+96PwhVolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwmfCpy5bOkuP2ymPXvT5w70Gb5rr87SMA4M/5qt+Ew=;
 b=vV+MCDnfCgP+/abgadSb0KFyVsW2fiTky6PBC+uuchoutjgUI0ZJpSQ6STJ1y/qnBXBXyGN+pe5gdOYa7A0hjE0lIMmLdLUIBH9hxEvJW5EEYRSMAMOEpg5GxVG4LtwDeTVeTAbcPalK9FRHQARMr+silXcCNV8DmgMG8nsz5D4=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.16; Thu, 16 Jan 2020 20:14:27 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:27 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:26 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:25 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: Do DMCUB hw_init before DC
Date: Thu, 16 Jan 2020 15:14:04 -0500
Message-ID: <20200116201418.2254-9-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(428003)(199004)(189003)(4326008)(356004)(26005)(316002)(6916009)(54906003)(7696005)(426003)(186003)(6666004)(336012)(81156014)(8676002)(36756003)(86362001)(2616005)(2906002)(8936002)(81166006)(70206006)(1076003)(478600001)(70586007)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1257; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ab5658-19e9-4988-4406-08d79ac0b055
X-MS-TrafficTypeDiagnostic: DM5PR12MB1257:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1257D1A8A5088E1BE2C512CDF9360@DM5PR12MB1257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDOJcl0h2LLLsmefEWi3PBPwUv/hYKHk22naqLSw6EsRZ5JfPj6/PgHm0NLfbDbpcZJYfWnOn/sXJNoDS3lGm4Ppgt6WPl0ZfrH7pKbhLmZ6weBMyP2NRK4kDmMO5rmjec2HfgM/8ePdHNPhQHE5Zy8xJR0EO49xDJ2kpTvlPMUHzOSCR+UzXL3pbVJAMPX9Q3Gc4Dzs5qE2sOiKVlCszvEVZ6r2vFlRNvDcX+B5HMQug4Gscj1vBRdfQD4qNbu3QZompyYkfzJyctxRkXlKkFQAOSQ0n8tsn47LeEh1r3BI3jAynWADtbfOuZrv5A4NSNRHVJqNYTTeY/sZ5HgpcDi7reHZGTk/TJZxeWCLVhcGRufmSBWPvRcyWiJgcwAkgpQ76OBAT0uWvglMaBlEG0PIZuqRIMH6fX+cMalqGluYtczSal9OahlPq8eN0lz/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:27.7960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ab5658-19e9-4988-4406-08d79ac0b055
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
For DMCUB enabled hardware DC has a dependency on DMCUB already being
running.

Command table offloading will fail on first modeset if DMCUB isn't
initialized first.

[How]
Perform DMCUB hardware initialization before DC.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cddfe29de84f..51e51c0eda0c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -940,14 +940,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
-	dc_hardware_init(adev->dm.dc);
-
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
 		goto error;
 	}
 
+	dc_hardware_init(adev->dm.dc);
+
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
 		DRM_ERROR(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
