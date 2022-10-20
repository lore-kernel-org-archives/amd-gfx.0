Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FB1C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6500110E469;
	Thu, 20 Oct 2022 15:48:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE5410E4C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIHV5aff8i6aZYaE75WBQzZ/WR8sPQja6iNsNuYY3arVDofcE2AC6bDacwft2/DL2ZPbbAXQb+Z3FRx9sG7jGYxxO1Miy2j93xxPSxaYvGEexj9ouBZCv/1BLxII6Pon0Na8RBHMChVJXMvfHYWMqjuw0ppJPJqEVKXwGyczq2ERjG12nNB3j0kvesJ5YJzyuTSCOT+yJOcO/OM2mp0evCVmcyJThlsuAyqG159RC3/uxx+oRNf6GgEoAG8us/XGVXW3FEJreK74L+Zdy86vdogJhQjpd6Z/XgHeMMEaPt5gH2thnAJEY6IzJYN4XIvTl2L2p2B7FG5dEBFDI07+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSH7q0FzZE5A4hrRJvrqLWlOXALWdD98aqsrVc7T73E=;
 b=g2i/qqvBq8U9C4CM8pLQYZifYjt2cgE8bSDm3BbLSsb/301/+kITlt7OTHNuIxFnIiUxsotmzsU33liK1KZK8Y7T3WBeRp9KW9X0qfDzRSMAJWw6tf906aDTPmv+l3b/AoRHe8wqRBdo9pc5eKRmZ5OHRshN5/59Ixkgsy+UjU+FGkL3cf5bM5GY/QjUxs0YO+GHP1Esr3r2qdhhpS5obP/LTvtd/6hRu+eqSmehqT7zZ7wY5LUbQHAWLuKZ+CNNIauqU4E/pYugpZMMP8olPATVMZO7FThrNk9sjVKZ2fjTCdih9+hGTz12YbOo7qy6iT70xgwKTssvOHk1npErGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSH7q0FzZE5A4hrRJvrqLWlOXALWdD98aqsrVc7T73E=;
 b=ZQqYaJInWqL1haMe5rLdJ/cwtQt0yY9GiQeMmcpGvCM8/jXKCArCp/KAZMb9yuW2f9Bhewtftn43uKYBFxvPzCKFNI2m5SCasrDVfP120b3bzaGosxwoEUpH+qgYM+OWtyWi0TcTe15j1+OwBCW9HOcbMdMdIL4gAqhnoobRvWw=
Received: from DS7PR06CA0048.namprd06.prod.outlook.com (2603:10b6:8:54::24) by
 PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Thu, 20 Oct 2022 15:48:07 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::f7) by DS7PR06CA0048.outlook.office365.com
 (2603:10b6:8:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:06 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:03 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/33] drm/amd/display: Fix HDCP 1.X 1A-04 failing
Date: Thu, 20 Oct 2022 11:46:50 -0400
Message-ID: <20221020154702.503934-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a5bb74-5ae2-4487-12ed-08dab2b27b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtMfvqz0ysrELT6S+mSHclpI3LYsfJv7orRgU9IFfMDbnypltZnHCqG3dHkQQG9B7lVxzjNTBLXEUl8E+O27jYZjFedcGP6q7Ldm6ijL5i8HoAAMbWZ/5kgeSkplXKHqotdfjnxuz6IyTuLdEP3V9yXxG1WI98GrMUSZLbvOujb5wiz6wC62TgvcJ+33Y0u431mJdmteBUmb1JhnQdKPGHexfQ36pJkyRWVRGwkH4Ml3HD/chkLO9RjGQ8nxwQp47iR8ldQkaT/MCmUNET152FKOixnhF6U8QWFqicRhBaNiiX9ZIddJN/zTcsC3byJpMlGbYjx98goyxVEWclLnGLZpq47r+Pb1LbMfCAWGMxCT8oxs/fNP3KgtZoKLAOc09sYkrYlZCx6xgtcrJL+qo+f8KXCdU7qeHnkwQU0u9V+9an04suUgm0tvfnSxPJWqY0u/RI2u2/5Gk0O8llKKks3Dim4v8oTmpE/nz4oHu9uTrzQ5c6JDDqKEyFik4vXJ8XCOsJjl7DZTQ0ecqdxXcBj1lL1MSq6HQW6WkMqAkVuOp2JFfS0FJ7ZLFxM/9op491c3b23GL/IdxcOWM6r9fzqrFzLtDKThTRsFdpCrcH46KHHPV5xqU+6uKSn/yUOb9/jFyFuG67953/2MBWqBGqi5EQ3dycYkSip6sP/DFrOEQxBZDlF2Gqh4gwByOOZJlQVcaF+TBaeJg2FOqyVsSTvE835Y7IwxjZSIXQ45vTx/7GRKMR40AO/XXH6N+fRjJTYTLR+UjeWFvrBglWJziTCr2lagmNsT3k9a21e7ebtTWO7WIEPcPZCIk2lFffNV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(478600001)(41300700001)(26005)(4326008)(6666004)(70586007)(70206006)(8676002)(6916009)(8936002)(5660300002)(316002)(7696005)(2616005)(82740400003)(83380400001)(336012)(186003)(2906002)(356005)(426003)(47076005)(40480700001)(16526019)(82310400005)(86362001)(81166007)(36756003)(40460700003)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:06.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5bb74-5ae2-4487-12ed-08dab2b27b41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
On some linux based OS, the hotplug->HDCP start takes longer than
4seconds (by ~100ms) This is due to the HDCP delay (3 sec) so we only
have 1 second to hotplug->stream enablement, which is not enough for
certain OS configs.

[How]
Change the Delay to 0 seconds. From testing it seems like 0 Seconds can
pass 1.x and 2.x compliances

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 6202e31c7e3a..a7fd98f57f94 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -495,7 +495,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	link->dp.mst_enabled = config->mst_enabled;
 	link->dp.usb4_enabled = config->usb4_enabled;
 	display->adjust.disable = MOD_HDCP_DISPLAY_DISABLE_AUTHENTICATION;
-	link->adjust.auth_delay = 3;
+	link->adjust.auth_delay = 0;
 	link->adjust.hdcp1.disable = 0;
 	conn_state = aconnector->base.state;
 
-- 
2.35.1

