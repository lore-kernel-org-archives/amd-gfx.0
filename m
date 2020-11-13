Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAFFC56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357682224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WfrqN6Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357682224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9876E84B;
	Fri, 13 Nov 2020 20:58:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097E36E845
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evkc9Z1eV/t0ylqXWoH3qN8+j+woZEdqb+4cEhfbSFf38SDZRafSebjAzPK+b3SYv1WNyqYZyKlWFcMSmDqRgG1MU/qFVU7vj+qBgbJJy3zDC6NEj5+5cmtZyVZeQJVKVd2wd+/tF45txapI4sEz0QmD4O6mrKN79+w1VLFdJglaEbRP3CN0sBFUq768MfTCcSJE/YSwHbjt+y4VPsNg3HeG6GjGmOmGuZB9pDHSRUFc0ZzhUDKQSWxsHCnDVOc6LsxbYa+YKBcp6773zhaMwYeTqzYL4D+xcP887OUcrjGF0Ipjrih0SF+ZHv2GQuPYhySxDPi9NrREb65VgT/VOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHx4JKIT1oavqxLswobaLDvX3bYS8ajUxvbC9zsjpTo=;
 b=ChZjbEr3SP60xJsOVbsQ7Ndazn8vXxtYSKhm4ACAix6L4Y1y/1yGXrzWNWssMA7g2lYRJB4YWfPZX162bLj4M6Ei7wblyYBhM153lewJkx11W4/mlziJhkEMi+aveu8ggsR2Uw3hloWMlAFdX4Rq8UsZWz+FAMgYH/EXNhI2lIMZ8jZVEQTV3vAyllmfdd9F1bdeu2KNW07rIKHvc+wCUaO4qX2JCZN+NI8mnv+qYdGVIMUOvwWzJu3vRHmbPceCKb1BlJGBPRiFL3OANEPRxsmA91MucNSWNbABjsSG7aYqZnsZyAWNxVmST+ukSuC4FWEHHSDOKoRLsXWWahmtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHx4JKIT1oavqxLswobaLDvX3bYS8ajUxvbC9zsjpTo=;
 b=WfrqN6KqiL8y6F5NRV+vxF1gW6/3AF6IE8eqCVWuTYG1R8cTv6fTtV/YV4wqD8uxqnBH7v32GPhxuW9cEeniOfH7bof8KzLFJrJ5txuQPJVZ2Cb+UGfHhwMytVCZ+VwOeRqm19sMgtMNggkdf8vCwy1ReMPTTI5IURcVVjngm7Q=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by BN6PR1201MB0083.namprd12.prod.outlook.com (2603:10b6:405:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 13 Nov
 2020 20:58:14 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::bb) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:13 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:13 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:12 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/17] drm/amd/display: update vgh bounding box
Date: Fri, 13 Nov 2020 15:56:45 -0500
Message-ID: <20201113205645.640981-18-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5baf51d3-9e0c-4123-71ea-08d88816d672
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0083:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0083371707AD736E4D876B92F5E60@BN6PR1201MB0083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mU4nJkUvPRLnQhdf1uywWKkbjOg1ql821rgKWv/qLJY0eSxKq/wB4lHk+kfO6NVLC1btnq9WMnF11ixXCh5o+9FbYkq2GF/bSrrhygtJ1uknPhrJdLBK4No18ToZq2I3B8jz6j0uc0hsHwz4RsR+sucOseI7HQeJI1ikJ0da+vWJZk0+dITwqpSJC95LHcRL6jpTH4TH5W4ErT2uWA60EYtd0UTFvYKFBnucQHJos4OepSluuhXIbaYHF0TB0swI1bi2ukzs0uLBCHT0qKREHaP8OoVhquw5R5pHwlXrtBILEYPLKSr/Q+5w9PYc8PI58g498s8w6Soqgys6lb3YcYaosW5w+keq5JPDpECbiPoenaXHJJU0qT6lhAkFo92NodF4mm8cHZwFP52nebzCjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966005)(70586007)(47076004)(316002)(54906003)(70206006)(82310400003)(8676002)(478600001)(7696005)(86362001)(6666004)(36756003)(5660300002)(6916009)(2616005)(2906002)(336012)(8936002)(15650500001)(1076003)(356005)(83380400001)(4326008)(26005)(186003)(82740400003)(426003)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:14.0418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baf51d3-9e0c-4123-71ea-08d88816d672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0083
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Update bounding box as per spread sheet.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 60 +++++++++++++++----
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 8824dbce6f4a..0006d805b3b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -164,29 +164,63 @@ struct _vcs_dpi_ip_params_st dcn3_01_ip = {
 
 struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc = {
 	.clock_limits = {
-			/*TODO: fill out defaults once wm plociy is settled*/
 			{
 				.state = 0,
-				.dcfclk_mhz = 810.0,
-				.fabricclk_mhz = 1200.0,
+				.dram_speed_mts = 2400.0,
+				.fabricclk_mhz = 600,
+				.socclk_mhz = 278.0,
+				.dcfclk_mhz = 400.0,
+				.dscclk_mhz = 206.0,
+				.dppclk_mhz = 1015.0,
+				.dispclk_mhz = 1015.0,
+				.phyclk_mhz = 600.0,
+			},
+			{
+				.state = 1,
+				.dram_speed_mts = 2400.0,
+				.fabricclk_mhz = 688,
+				.socclk_mhz = 278.0,
+				.dcfclk_mhz = 400.0,
+				.dscclk_mhz = 206.0,
+				.dppclk_mhz = 1015.0,
 				.dispclk_mhz = 1015.0,
+				.phyclk_mhz = 600.0,
+			},
+			{
+				.state = 2,
+				.dram_speed_mts = 4267.0,
+				.fabricclk_mhz = 1067,
+				.socclk_mhz = 278.0,
+				.dcfclk_mhz = 608.0,
+				.dscclk_mhz = 296.0,
 				.dppclk_mhz = 1015.0,
+				.dispclk_mhz = 1015.0,
 				.phyclk_mhz = 810.0,
-				.socclk_mhz = 1000.0,
+			},
+
+			{
+				.state = 3,
+				.dram_speed_mts = 4267.0,
+				.fabricclk_mhz = 1067,
+				.socclk_mhz = 715.0,
+				.dcfclk_mhz = 676.0,
 				.dscclk_mhz = 338.0,
-				.dram_speed_mts = 4266.0,
+				.dppclk_mhz = 1015.0,
+				.dispclk_mhz = 1015.0,
+				.phyclk_mhz = 810.0,
 			},
+
 			{
-				.state = 1,
+				.state = 4,
+				.dram_speed_mts = 4267.0,
+				.fabricclk_mhz = 1067,
+				.socclk_mhz = 953.0,
 				.dcfclk_mhz = 810.0,
-				.fabricclk_mhz = 1200.0,
-				.dispclk_mhz = 1015.0,
+				.dscclk_mhz = 338.0,
 				.dppclk_mhz = 1015.0,
+				.dispclk_mhz = 1015.0,
 				.phyclk_mhz = 810.0,
-				.socclk_mhz = 1000.0,
-				.dscclk_mhz = 338.0,
-				.dram_speed_mts = 4266.0,
-			}
+			},
 		},
 
 	.sr_exit_time_us = 9.0,
@@ -226,7 +260,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc = {
 	.xfc_bus_transport_time_us = 20,      // ?
 	.xfc_xbuf_latency_tolerance_us = 4,  // ?
 	.use_urgent_burst_bw = 1,            // ?
-	.num_states = 2,
+	.num_states = 5,
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
