Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E08C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA8820663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VMenL6lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA8820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499526E297;
	Thu, 16 Jan 2020 20:14:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D856E283
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW3CVBIKqvHapF5xhac8ZI51tjHwbAUXjqucMWFi5A2Jw2PCWOfmwyRzYS7vEmcmww4fBHNkMjhTrvQf2oOfpbvfQxNWTIPHHGvY1V9yCQga9NFmNA+I0BZ38hmqF/hV6c7Mhx/+i5S9Dn4GKOJnJEHb0iyJhVW5nXVK9bdIRDKRx+fLav7jW7qYkA4Ekc5CaDuQyjbW5rBsbkzZKYnEAkBrZpN3u+t8IZyjQHLS0BAinlnSxhRDUL9pq+HQyUaa/eXpbMZZvjcSuz+rTzrlzR2EOrINDaL+tUI0HFdJcYgSCZFmyA4cAE8Tg7wqdg1efNriz2O0GJjnO7x0+/QBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UfygoXigq1+j1/JQZdZLIClSlHLbbKsryIbDRAuWuc=;
 b=X5g86F28nvVRe1Rw8JJDe+tBbuivWLB8tGEb1/I03eiCYIOW0HhIsfzWvn06UpGLYFpTE2K4/br+myGUMdiJyXmrxUL/gtYO6yGinmWuno0EJD4JG/HGtxaWjlXJ/4Ghau10YFh+sv74Vi93UxhmVgMA/MPEhZFqT1pRFcR7KcUWMx06y3bSdzpnydB9VmUaHY47d52fJ571E2VnXwUaQ6dZxtmEAdfrFkpgPRnEb76fK6KjnTge4AtCP6WG6sOq5ptOnLKd+0971zX7xT+64dX+tLGH9S3C8J7Y7qRAzpfobNZh+VlFjMnoYe/NnSrbIPuDpoNh+k23Ff2F9wAcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UfygoXigq1+j1/JQZdZLIClSlHLbbKsryIbDRAuWuc=;
 b=VMenL6lWtwA84CFiGGETv7Qjb6ojICnSzhbDBKjLpEhudGGm66ysZ/GRgucYnl7i0yz8bRtUyzHvCzwZqzLSxmi8/+kS/LzGjMXh5QQa9lTeIgIhdWLGdascgeJQeD0PXL0IV+YB/bJ2UDDUBuyGAqLBMh+lSVzlsBhG+GHDyrU=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 20:14:27 +0000
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
 2020 14:14:25 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:25 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/22] drm/amd/display: Fixed comment styling
Date: Thu, 16 Jan 2020 15:14:03 -0500
Message-ID: <20200116201418.2254-8-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
References: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(189003)(199004)(4326008)(36756003)(186003)(86362001)(6916009)(2616005)(70586007)(2906002)(316002)(26005)(70206006)(1076003)(8676002)(81156014)(54906003)(478600001)(5660300002)(356004)(81166006)(8936002)(336012)(426003)(7696005)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2422; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8357694d-8412-49c6-18f2-08d79ac0b00e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2422:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24223CA59E0C1A7B46FFA4DCF9360@DM5PR12MB2422.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFFLm2y4J9CQvT8Ft387NyTfnSrtBUea6xBDR4bQzLoCq0scLj2Oo8FYWOFcaeO856ij3YNtHJCiW6bef6KoZB3AQyfVPcmP2iinQ8Zesh3dew7+y2BjVzryp4+6uQQGR9mg+lF8ujtp2h/xkEOxndMvathLoM4aWvKqLJeIKlxt/0myIu2TYq9biJ/UkRY0U85fnsFo64K16YFQ/HLYlexu5vCr9/cM2lg0RNnhw+DbPWCWfDN6nHcfArx6vuq5ZClnnwu+Hd161Evly2fNENrilxotjZnHyHoeZGzpD5ewO4G+AyzcRxPvjX46tXpR1w3HJkogi1D7566XfVzsAPDolKH1zalaI93o+Qxldsh5n+vKW8gEsirfJXtT1odyTTIKAJve7hiFUqPCLdIgqO9n/mAdMqzzIsOHFohocXIGE9sRltO82wXYWLn8+Kdd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:27.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8357694d-8412-49c6-18f2-08d79ac0b00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
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
 Haiyi Zhou <haiyi.zhou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haiyi Zhou <haiyi.zhou@amd.com>

Switched to C-style comments for consistency

Signed-off-by: Haiyi Zhou <haiyi.zhou@amd.com>
Reviewed-by: Reza Amini <Reza.Amini@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 6e5ecefe7d9d..b9992ebf77a6 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -381,7 +381,7 @@ static void apply_fixed_refresh(struct core_freesync *core_freesync,
 	bool update = false;
 	unsigned int max_render_time_in_us = in_out_vrr->max_duration_in_us;
 
-	//Compute the exit refresh rate and exit frame duration
+	/* Compute the exit refresh rate and exit frame duration */
 	unsigned int exit_refresh_rate_in_milli_hz = ((1000000000/max_render_time_in_us)
 			+ (1000*FIXED_REFRESH_EXIT_MARGIN_IN_HZ));
 	unsigned int exit_frame_duration_in_us = 1000000000/exit_refresh_rate_in_milli_hz;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
