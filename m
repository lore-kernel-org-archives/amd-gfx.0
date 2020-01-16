Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C49C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 471BC20663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Qp/LIdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471BC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE78C6E255;
	Thu, 16 Jan 2020 20:11:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDE06E24E
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDUXhyecCyoBz4LGlhGA5F5TjGu+gxFC8k89w0nNluVGhEBesnrR5kXdVsOhA4eON3cosuVfGlf69Pm63ZgdoRJu6aBP/6b9Ebysj3f+76AL36ErCAMZllhk3j1iBDXYbV09KhwJ1NiyahnYQq+T9CXz3/O8Epi4QCH26qg+zKNv/FSNX20cQT36F74F7h0iIZWc2+BjRLU2rt2PRKiG1mAbKdHiciZiKJ0YTLzCHhF3Ng9I1f1aSRkvyB9NfLyi1h1fYG/er0TzSWUKlLDum+oCZkT1wQFbPBBhEG/dgVJW6daBt/j2ngrC9nqLc6GZt0afS/2LCgp8U0vEpOyqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCrp9OuLPVdijkhH4r6c15aXxNd3VsXw+ImHXRYtF1U=;
 b=TDNXullLmi6LLBSbVHiO0KzS17fAfml8HIgINX+QTj+SW4SbflFav5whso5rYhdHcggGMLSN+RSncXmZtUwsHzJiaTdt8RIDs/TjIuJXaBppJib85F2HM/GQqDjneq00mrEsmYH4yu5dIy2isF6djNT1O/BDCiUbybj0rVSyV6Su2Y5S6Lstr1YoyLzfOCDEFlyJKoxEJ1ZN0ku8/bGm1WMjGlTJ9cbGU5aHO8MmjN0AjN4d6YBr3SWDejw9rnmUy8RGz54Z761WPWXserzS8GMM9XZ2CqBh5jF4m2V6cswpWBHopG6VavHPg3zBiAva/SwyVRRY3Ea3OJgA7stu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCrp9OuLPVdijkhH4r6c15aXxNd3VsXw+ImHXRYtF1U=;
 b=0Qp/LIdY2QnSp3RoXSJLB5K6O7/1Xngb7BRwKSshRnKFdfEDH9dy8ekSjfdoqsrhg+fEPqM1ueZYKIp789P7W3yu3DGFVpDTE4oiM8bYnAWTs1vsyPuAUeNQr8PFe4dnNLZ22H0xt1RHUMoWkVc92et+CyZdXN2XS/VViP+7tWg=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 16 Jan
 2020 20:11:26 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Thu, 16 Jan 2020 20:11:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:11:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:25 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:11:25 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:11:25 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Do not send training pattern if VS
 Different
Date: Thu, 16 Jan 2020 15:10:38 -0500
Message-ID: <20200116201058.29200-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201058.29200-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(189003)(199004)(2906002)(8936002)(5660300002)(6916009)(81166006)(26005)(478600001)(356004)(81156014)(8676002)(4326008)(7696005)(1076003)(70206006)(70586007)(2616005)(6666004)(316002)(86362001)(36756003)(54906003)(186003)(336012)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1641; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8416e1e8-c7d7-4f7a-add1-08d79ac04435
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641F85D54F3BA3B513B116EF9360@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXljmgqq0K0kXioerjQnDff797dLipDZl4rXAXfOaL3GYYsZKXP8xnMEq6peQlV+YEFgrNA/spvKD7arU3fg6yA4GAldMGQqBuTVinChsVMXoAAwSKMjwmEJCKfaASbpelyJ4AP5M+fklJFLoIdRlIoumkvKCYNs4ENCeZvIAb88Q+Rdo4D/NyM4e/ide36nUbCxKTCC5sIieaFaQgQVTxQwMEDPHMgtybqRaY2s3256HaWp/6+zTiej/AGBo7KkgLxmTW7VE4aWGHx1XtMmMXJAw4j1GixC3a04Ug+WWpQw4s65l+xej8XZxLxgeQZRC+oBDpPNj529eQAzToD3UQkvGLVpNEmIlrpB2QSqwaIpqeyUAUPrSos2etJxAbGdnwYembHVpeOzx05njmXq6YlAhmLNHQ+gHFIZgGC/3OMZQzkhm0tF6512ralOVQKc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:11:26.4090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416e1e8-c7d7-4f7a-add1-08d79ac04435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Sung Lee <sung.lee@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[Why]
The DP 1.4a Spec requires that training pattern only under certain
specific conditions. Currently driver will re-send
training pattern every time voltage swing value changes,
but that should not be the case.

[How]
Do not re-send training pattern every time VS values
are different. Only send it on the first iteration.

Change-Id: I5d98439de574c73c98edf21fe1741b947a365bf5
Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
IP-reviewed-by: Yongqiang Sun <yongqiang.sun@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1bd0946829e3..3bb1b481451b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -983,7 +983,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 				offset);
 
 		/* 2. update DPCD of the receiver*/
-		if (!retries_cr)
+		if (!retry_count)
 			/* EPR #361076 - write as a 5-byte burst,
 			 * but only for the 1-st iteration.*/
 			dpcd_set_lt_pattern_and_lane_settings(
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
