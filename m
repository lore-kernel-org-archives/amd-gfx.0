Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74A0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3841810EF45;
	Fri,  8 Apr 2022 17:27:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FCC10EEB8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/695t3nHapfbg0H2n1mp7odaI/q6M1aQ1y3ZVvKOA0NuuXkBuKB+swcK750j4kPm5HC2MIkxZ3l5X61kq1vJAYCLcIH98Peq39twd7SZrcrrI6PCDNIVDWG1Py173zRvwzXNxiejf4VjJn11INXf4Gytp9g3HOkRxQE4fRKa3OHtvcHHeS0vHTurDkDQSbW2r0zs3bRaxjkahZINZkYvAJPbVSqrZpfecoXMo/UN018Q/ju3YzlybuKCCTiAUh3HXxnI6J0OufgT7ZFJTZh3oH2VXK/WCr+wYkFB/EEpnkPO1bDG4BmQ/GeVLIIi0IqsPV+eyzJJ6EShtdsB8DSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9xAQNw59d/bc2ftg3pViEREml2C1XnsEBUAk3Cl4Wc=;
 b=n7B4vCxd77QDFRrBWjOxDXzoydmVqwSlVhBLZP4BIImqcyP7T/pPOUV/nqIgQSAzVfUZMat+wG8gb1NKl088bT/Gg3KXmy/x+u7DSOTFRzHENqCv8F0Y/dJ9iHgNffW+NO8gIi53bbLNNrJ/q+3ofJlr6NHMzMl7daBTC8QUVltyF8W6Sbs3OOnGmCMgQ+rT+R5zbN/cL/0REXhSjxnugGAuV8Yx6uxdHEJiLExfMHkGOew2V11n+2pn4s/pdhUWubLlUQznXnWNeH0hWA7MmLYiyZfL8R26duB9X2gThY8zidGPFfjdzqQy6ll9gGYllC3cgDfPfHUW0CmgRJUTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9xAQNw59d/bc2ftg3pViEREml2C1XnsEBUAk3Cl4Wc=;
 b=beGKzKk3H5d5b3JRHFqoH3zSPHQrZKLOKO3gzhFyypdBuV1oesO8SdDhbN1W5dNRGk0Lvgyfwd3Axt9cIoPDy4IW2zYpB9Z91SpY6+B0S2IFKgw6J8FBd7QVfEINGLcXXpjZpHLie121E5qDCSTl5pbBjKCwyl/+OACf0m01u+o=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by BN8PR12MB3266.namprd12.prod.outlook.com (2603:10b6:408:6e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:18 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::72) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:17 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:15 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] drm/amd/display: Disable FEC if DSC not supported for
 EDP
Date: Fri, 8 Apr 2022 13:18:56 -0400
Message-ID: <20220408171911.601615-6-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f674614-676a-41ec-9e73-08da19850791
X-MS-TrafficTypeDiagnostic: BN8PR12MB3266:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3266C1F1EC0AAA32E1322EF6FCE99@BN8PR12MB3266.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6f0/FU+rerqA77akolKbeyfF2t9fc+DGhhsVsSBz+MB95o9dmTRNKyea7IozD8Elx2d898p/DWOMCr+wQkWSU28pzT5IbsA9TzTXwesUOAGny5DYSlGpuun6p514lo5iHWDsTIf5wZb8g8Cmdpe3WBxgk0bFgHT0gkXHUOXYh/U8CJn5HimFHO0gOer0kAEoU1gsoe+5giwmoRxx1PiIJ+9c1qEB6TtsHqxAFr/jLHmGAIoJuxm/S4rSj1Z4paVXzAV9rHzqPtdRAH0fJw//wObz/85Hfbr4+ZKAHBB5I/SKcHTreWXZ3Mq6DdwCbmowHb2NPyZ5346NaeuXVl4dQInjRl0huK5BeGjuTpj61XU1IfAQV/IIkzE+Kb/Qkv/31QPNctjBMwcnNpVChE5YMWfNLNauxcj/lDgJ70lxncWN8MgWHjPuDr4Y36sDWz+Grz4rYxbTnNeGgOyg0vVEuDut+YqRRJXy1GqS/6QZHItdK/AdYR3D4lx4hH3CcNoFbpP731e0eC0NASY+3NMyfS8EcgPcL04y+91FoHneUyV7UeGIu4w/O4YJveR1nUqsp3XDk1PyuY97aEAq7cHo7mCnlHPRKPZN+2ygCc08sHm/picWZnoLIrH1jcK+xKzw2ILkYdoV9QITre1RROMjUfTRc8vTopd/igehRNwZ6AWwD2m/3yrq0VwiIW+i0r4s92RDa9sOzfKuxZCVca2SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(47076005)(36756003)(508600001)(36860700001)(6916009)(316002)(83380400001)(336012)(186003)(26005)(82310400005)(426003)(2616005)(7696005)(40460700003)(6666004)(8676002)(70206006)(70586007)(86362001)(4326008)(2906002)(81166007)(54906003)(16526019)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:17.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f674614-676a-41ec-9e73-08da19850791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3266
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
Cc: stylon.wang@amd.com, Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nicholas Choi <Nicholas.Choi@amd.com>,
 harry.vanzylldejong@amd.com, wayne.lin@amd.com,
 Iswara Nagulendran <inagulen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <inagulen@amd.com>

[WHY]
Screen was seen corrupted for a few ms
when switching both ways. There was also
not enough bandwidth for HDR to be
enabled in HG disabled mode.
This was due to FEC being
enabled although DSC was not supported
or disabled for the EDP.

[HOW]
Check for EDP DSC support in DC caps
or if DSC should be disabled for EDP
before enabling FEC for EDP.

Reviewed-by: Harry Vanzylldejong <USER DID NOT SET AN EMAIL>
Reviewed-by: Evgenii Krasnikov <Evgenii.Krasnikov@amd.com>
Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Iswara Nagulendran <inagulen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 22f2d88fab99..c1a727ff8b1d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4663,8 +4663,10 @@ bool dc_link_should_enable_fec(const struct dc_link *link)
 			link->local_sink->edid_caps.panel_patch.disable_fec)
 		force_disable = true;
 	else if (link->connector_signal == SIGNAL_TYPE_EDP
-			&& link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.
-			 dsc_support.DSC_SUPPORT == false)
+			&& (link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.
+			 dsc_support.DSC_SUPPORT == false
+				|| link->dc->debug.disable_dsc_edp
+				|| !link->dc->caps.edp_dsc_support))
 		force_disable = true;
 
 	return !force_disable && dc_link_is_fec_supported(link);
-- 
2.32.0

