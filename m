Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB72C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E8A20578
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2GjJIf9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E8A20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FD86E480;
	Mon, 30 Mar 2020 18:01:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B7D6E480
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 18:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhHUB4nVVKr01oLZU0o1GB5f30uFyu3E6lhJhYCJKBr0nftlZfHOLkCD4wFIaS/byAERyb0VYKJ3559SSHRoC9X5TOBSor1ochGzgifezoD0UEeBeBjLHFMRNPFh7bqnFKqgTiXMSpC3/WOvDXmTxViSXLw2Z4BDWOJG/XWTqDoNR0HxKiz2DgSorWI7cMHvVydgpk3wroGu6JQQ/lbGRrNIj2PQLg4dwTRp24U8IAIrw93V2DmP6Mc4xsCLoJoTV0ey9bqpUG8vtopm5Pu04wxkiTxaH5UNkhKZEIIstU1ncTfFHO92PN+fAUKTIW+r7+LfMmE16vtqPGIdbVYGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6BmLMcdpbkjs1nE+AJl2iQVDm5FdRFOAF59Hk9rPMg=;
 b=exu84LcmB5gQ7q7fYp+EZ34GTy/aVNowTDUUZg/O2lNA+G7r8geGkbW9BlHcA0PrB/GtASc+85iHDDiNOrVjEuXPS/noBxXtD7wuPha031DF1dMlWBaRBHAZR/G1Moc6R1gYfFL69/L97z/+arROI1/RlBNeJPUhHkN412L5hyK3eHcDm3cj65hL41tMmwGIHi1XZO3ClKYn5VfUXa2bOxXk+XGLVHZd6fE7g7ldDRyDiQtY9xR4WSW5GxEm01SQcpHLmpem6/Wd7DMWKJXdxFUFzOWD4kwsiTTkzds31OcDMm8ECAeqmcSYi47rghTjNRUXH7kWmOvF2Xzk8IDeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6BmLMcdpbkjs1nE+AJl2iQVDm5FdRFOAF59Hk9rPMg=;
 b=2GjJIf9B6j7tHfrVCj23GvJ0Ji3Q22DSuHqV1cilOzQH1CmpX3ZDUq2oTFSS0KdYhE/wljHFvUYL2bMibCoPPvM45uhtKUW8uti9bi+b9lfJwBxEfnOSQglDQuIHTKci1GMAgG+Mw0+GnVaaNkUEKWVFkScoOLR5+Bm0xRqG+p4=
Received: from BN6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:404:65::12)
 by BL0PR12MB2467.namprd12.prod.outlook.com (2603:10b6:207:4c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Mon, 30 Mar
 2020 18:00:59 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::4b) by BN6PR17CA0002.outlook.office365.com
 (2603:10b6:404:65::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Mon, 30 Mar 2020 18:00:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Mon, 30 Mar 2020 18:00:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 13:00:58 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 13:00:58 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 30 Mar 2020 13:00:58 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/display: Correctly cancel future watchdog and
 callback events
Date: Mon, 30 Mar 2020 14:00:24 -0400
Message-ID: <20200330180025.21433-2-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
References: <20200330180025.21433-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(428003)(46966005)(426003)(82740400003)(2906002)(5660300002)(6666004)(36756003)(54906003)(336012)(8676002)(7696005)(1076003)(356004)(81166006)(2616005)(26005)(8936002)(4326008)(186003)(110136005)(86362001)(316002)(70586007)(478600001)(70206006)(81156014)(47076004)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d46192c-7fe6-4949-6b9b-08d7d4d44d41
X-MS-TrafficTypeDiagnostic: BL0PR12MB2467:
X-Microsoft-Antispam-PRVS: <BL0PR12MB24678A58AB31829E736820F0F9CB0@BL0PR12MB2467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8Rh5sTj2ItA3K2HJSoyZF0sZiB9z6AQwBUu2yb66CUEnLWIXnNxF/3+1iec8eU8eoLGdMtJWCox4Tjxm9xH6sVDeTYcKgG9MOEIYcYp0GnSkOH47Yy+I4RBjQ48dzXn71R3IwDapCqbj502A8jo0F8XMDRFKPt1R5FQBFh9UWCMGaio2hwGST8EAJPVA/Cp3KNIknG06ns1+QIlcELf1Cir8GSgaaVPFrqtQx5lRtovZyjYQBp7dD7CKC0JWLDvg6nQuGCkdxsTssrDxeDi+QPL0+cT9Y9Fq7e89Wq+ce4DJfOGTiXeeHDu5XkUJXJRFRJrs0aJfrigelJ7JcUUYAWnVv1s4qlxNc3CGB7tCCbNNXNqeXT8pq/8u+Pw6l5dUFtsA1gTiec2vnTsPMLWnChUMfpOGoVArxaET9dhQL6QF4iryto4wfixJXktg+lFersraGf95vAE3uXd1bZizkaTM+OLe8puX2fyue+YBse8+q6680SC0jMaTlUuug8AEC4s+4FMYQsaSyn1l4my/Lpee/s7JmFkcsrJyc26eu8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 18:00:59.0063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d46192c-7fe6-4949-6b9b-08d7d4d44d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2467
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
-We need to cancel future callbacks/watchdogs events when a callback/watchdog event happens

[How]
-fix typo in event_callback()
	-cancel callback, not watchdog
-cancel watchdog events in event_watchdog_timer().

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 41fd1f5acff4..39804d2df9df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -266,7 +266,7 @@ static void event_callback(struct work_struct *work)
 
 	mutex_lock(&hdcp_work->mutex);
 
-	cancel_delayed_work(&hdcp_work->watchdog_timer_dwork);
+	cancel_delayed_work(&hdcp_work->callback_dwork);
 
 	mod_hdcp_process_event(&hdcp_work->hdcp, MOD_HDCP_EVENT_CALLBACK,
 			       &hdcp_work->output);
@@ -347,6 +347,8 @@ static void event_watchdog_timer(struct work_struct *work)
 
 	mutex_lock(&hdcp_work->mutex);
 
+	cancel_delayed_work(&hdcp_work->watchdog_timer_dwork);
+
 	mod_hdcp_process_event(&hdcp_work->hdcp,
 			       MOD_HDCP_EVENT_WATCHDOG_TIMEOUT,
 			       &hdcp_work->output);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
