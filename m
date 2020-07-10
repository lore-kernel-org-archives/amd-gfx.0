Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0834DC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5B920720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QlG2sLxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2C76EB71;
	Fri, 10 Jul 2020 04:48:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5B16EB72
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVo7b7tx/zA4zcc/HwHyL9H7MroPpc8eZSC2aOHPbgfz149OHuvJFS5JXxIEUnf0iUv6dl0BXNVpsdTqY+OLwwbwE9aFthtCmjARd6BTMs01/N7YjcPx1NIJJcLIyy5wUgjy9ipubt+b+5ZDIgqaOP8+e55GEiQ4OWv7rMhHxhJgy/rOWNKGPfONB4BU+TMj8p1+swG6+eu9Rbn7aQzE7wOFFmH/ePm5lUodlpyRadTRkLa1sWwj1+72FIB984jQjVq9U2TVTaQ+910r6fyFNAZcCwJJksUvuP5qcVaAo9PzT5szqnuwP1TsS3IiT1KNeJdJnWOS+vmTKUXOzYTB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP46o5R24lER09WcY2CgBOTef/qwstZs7d8wO6RV5Co=;
 b=dXIiL7HwvAqf2SgZyVoEg1GL6cSMIRH0Rn6XutpjrOETZujBHc7AvF+q2jtjjgqY9j7kmGh96nvB+IkLxZHYL/QW6S0+F5zpD8tLgh+f4OOA/c3q9x4Iv9jmBy73yaXZ4SZh2HNdmVI8aXJA/gTynY6Dztp3brpnlk7ifsKDuCKOIk/AjcuuX0JMnmpaW7ycotxRF9Spurs94OH8sOeRZ859iivMa8bv+LAB5YLXcCQkmGTwfYG4qVEJFHAzigszGkV2ZuCdnppJ1DEe71BBEus62VeluJDu00IZLfwFmb6hTP0aan870U2XeTu4oeVdVuyyrrCKuAC1la8lSQVO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP46o5R24lER09WcY2CgBOTef/qwstZs7d8wO6RV5Co=;
 b=QlG2sLxoqcJPI9LSPDQud73vmo2PUUc6ptqFgfQLo5cNkWGvU+3T8POq7Db0yhDHz++EoAZ3f1q2eJyujHxgLIvBM/oqLit5N3xP5r5uZGUH3EEGGMiLNSuZsQLt0zZjJcyxaW3I/hDHlrk4tYIvcPO24CNqDN242hF6qHk0QaI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/16] drm/amd/powerplay: drop unnecessary wrappers
Date: Fri, 10 Jul 2020 12:47:44 +0800
Message-Id: <20200710044746.23538-14-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:32 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6d628f3-1cb8-47af-d436-08d8248c8022
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360B766546EAB1E12957FFCE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmWbiUT/oQfR102MFmt+IXRc7MDSKZ2her6TUWQw9axm8HQ4iTcXF2Wl5g7M0Bne1AJs5pEC7HuGE+S1MCVr+W/EPJjg7F6Xu81R9xq4wYDF8ChJhP5McLhi2PBROpux+DWD0nmMzfbQhF+Bfnm1NaKEuwqN7EV0kjOBwKc6nszEK9JcWLfyb0o95WRPpZ1UXpepZtqwHFEzRJLse3BoKTdndURS0HKXfX0PesuNydwg2Ezr8QNEZ1U2e5j8XBBg60Eg/fjQ0RbWL3SuE6utg6C+ZP9sZ2cgewz3BN1OU11Ossbt48VJG/94tvI57c6d8DEVa2KgIymp+7l5I8uVbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7iaNznyOPd3YaKJINQ76E+Txh+m9P4JYDptaQsN9hYIOOMT9nnRMWku5ZfO7JuK/BpnP6rNbB+YLBYPvbY37PpHLzyIK0Vxn1e2PeIlIHBeoNmGopE/GyKH1K4NmHoL/xEO7O1ug4NJgnoGxLpUeqsbS+7VbjSDEaVMtCFvYSpHoDvoCkDmzEQDe3O3jG3EiJ/dtRgSpPtFCETK+SQiFdf4RZOQJv5Zcu/UpLlYOouD7KYPTQUNM5UKTrx6I33QgfsWbEV5s6aU0h9UUSF16qgwM2Z5HYiQhES4wqAXjKjFGwx4Nn/mvxpyXgec7NmXQb+bVqFxKqYv3fYoSJoQfSAVSjgE+3QOCInyn9XO7gXy7LbWT/TCDGNryZ9K+w/WF5IrLm6mBFQ/D3xAlKoAoB+Utu0iSTaeF6apAbVbUdHINAbp5ukbH/lspRTlgWkyuvyWJMjJN9D64iUueg4656kU3xlgCybfdrZngNWT8UJJKEadoeSYYYklwc8EHiXqO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d628f3-1cb8-47af-d436-08d8248c8022
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:33.8991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyrxfdE7P1Luep2W1RVB+XF9OYB/y1apPHY5gd+irepvC3O7A9YclfjhoaGRBmJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By calling the target APIs directly.

Change-Id: I0f24f603d2fcb94d2078a35c405a1406093ba5e3
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index d4aa01a05c54..49a8d636ef4d 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -743,26 +743,26 @@ static int renoir_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
+		ret = renoir_force_dpm_limit_value(smu, true);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
+		ret = renoir_force_dpm_limit_value(smu, false);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = smu_unforce_dpm_levels(smu);
+		ret = renoir_unforce_dpm_levels(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
+		ret = renoir_get_profiling_clk_mask(smu, level,
+						    &sclk_mask,
+						    &mclk_mask,
+						    &soc_mask);
 		if (ret)
 			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
+		renoir_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask);
+		renoir_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask);
+		renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
 		ret = renoir_set_peak_clock_by_device(smu);
@@ -942,8 +942,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
-	.force_dpm_limit_value = renoir_force_dpm_limit_value,
-	.unforce_dpm_levels = renoir_unforce_dpm_levels,
 	.get_workload_type = renoir_get_workload_type,
 	.get_profiling_clk_mask = renoir_get_profiling_clk_mask,
 	.force_clk_levels = renoir_force_clk_levels,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
