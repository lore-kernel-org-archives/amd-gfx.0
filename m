Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B4C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174062224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h+oQ0vJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174062224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E35D6EDB2;
	Wed, 21 Oct 2020 14:24:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E996EDB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILVlgk7VNDJ04PGffc1GAESyUGgTOdVFL+ec6bZMFkeHpayWk4gF8pkpWJ+R4j0cI1pWh1KU7UkVzzbxjua3EVGhoEblW2ygFWyVQpnbBFKvVVsGE+8by1iTXE12ap6Pw4CneuJ0GVROOee173+TSFQwCyWnIedouloanfarL9JJeqEqMYSfBHkI71x0I9kn915y1boqsAuPc8wu2a4tEFe/jnYpUuhIGk0I39Rd8FjT+lKlcLYfNoqdi4ipySuzfdJiNkL39qQauXeSQpioksGkTvHmX+om9p/bEutIGY12qBtT7XqyYdhnJk2Tf9P4KL9YZuQKjbvxpoG0YwzGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3UWfLBFYFqlKsl1uIGeCfKRywSxzUuB5tXPtGIkLe0=;
 b=g60uioImnSt/6lkcmyqC1nheHoRoA/sJNQk+RaKyUnvxB2Ocm3cql9ux/3DxEK3jszTCLPBtaEIlBGx8AQ7QE82OrhZysrKqrsoLDKLQAtBAV8QHXnvyyDf2wTneHuSoH8oImSuoAId2Nqk97u2Th1ImZZyH1i97Lu3IftjIbv1Jf5EZ35lDBGQkaHHVLJwtA+srmqzxn9+1NfZNox5gvdMn5VwOsPhcFSa2NY8ZyG4yPbg/7Wj+SNeKFgD1YX1xdqFTUlZA263oGSVWKytTHjh3mmW1dptY74q4/yKU/+45vJqzQqika0e+c4iTfxeVekkpSolZTyWcTRLR5JFXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3UWfLBFYFqlKsl1uIGeCfKRywSxzUuB5tXPtGIkLe0=;
 b=h+oQ0vJCXdeMk1LZw5O6JTKJc++4MqFwMfYEBchM5MKjG7hhXZHhkVbm2F/Mh6U/vblj84qXyYmLtXAhtubWRQ8padq6nb5nY2DLtN/OkJx2I6NL62RyS+vX8/CK3jOT1+rxswEWcwMdElQOcpGlu5PByV4RtJc/RbdeMJT9hZU=
Received: from DM6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:5:120::21)
 by MN2PR12MB3933.namprd12.prod.outlook.com (2603:10b6:208:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 14:24:07 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::17) by DM6PR06CA0008.outlook.office365.com
 (2603:10b6:5:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:24:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:56 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:55 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:54 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix the display corruption issue on Navi10
Date: Wed, 21 Oct 2020 22:23:51 +0800
Message-ID: <20201021142351.71082-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21490724-4a37-4730-9ebc-08d875ccf88f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3933:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3933FC041051F8435BAE70FFC11C0@MN2PR12MB3933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAoj9ETlmwUgdU1nT3JXxmIwd3h8ZUmIFMIPGo82B4nOr6/72wa/azV1TZC15Q96yiriQxG6mSmiqS0Q2Dkv/pEIeQopoQOk2N7Sbpf8EqInuckOSN27Ztr+LOFefyhBgF5ELyB8v3K7+QJBo/qNZNii4QRVllMOH5Pk9wSjEFZ1oJ95Oq47pnoaL+Bs+z11HXzGe35VaYhF7gz8ubRfPGIoEp44lFhL5dq7NGq1+MmdbV8qvFkCScccoB+PXslPFIc8Qvb+0RuwBy1kDvC1SJsJ2BOzkyaGMsCr/gV28h0+s9DmICxvop/sJCnVJnPSYBAMMkPJZrV3SfkvUa/iv1kLNIlfvvDJlMApGtikC7gNh9fziLKhktMgG9mR4eivFrwX7VIbFV9WAsPANWoBHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(2906002)(54906003)(316002)(8676002)(83380400001)(82310400003)(4326008)(8936002)(81166007)(5660300002)(356005)(70586007)(82740400003)(47076004)(70206006)(36756003)(7696005)(2616005)(6666004)(336012)(186003)(86362001)(426003)(6916009)(26005)(1076003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:24:07.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21490724-4a37-4730-9ebc-08d875ccf88f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3933
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
Cc: sunpeng.li@amd.com, Yifan
 Zhang <yifan1.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, Roman.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Screen corruption on Navi10 card

[How]
Set system context in DCN only on Renoir

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71ecd963759e..ed0e7680b420 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1061,10 +1061,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	mmhub_read_system_context(adev, &pa_config);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (adev->asic_type == CHIP_RENOIR) {
+		mmhub_read_system_context(adev, &pa_config);
 
-	// Call the DC init_memory func
-	dc_setup_system_context(adev->dm.dc, &pa_config);
+		// Call the DC init_memory func
+		dc_setup_system_context(adev->dm.dc, &pa_config);
+	}
+#endif
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
