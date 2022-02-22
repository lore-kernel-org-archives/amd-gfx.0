Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F36C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 21:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC1410E7FC;
	Tue, 22 Feb 2022 21:53:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F1410E80E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 21:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeDXfhvVtF4DxA6jbGO5cQNBg1JJYP2d5cBSh4ZAxSiZOd68d2ixrRin/CsOJJ//xLfiWAWSsewNenHWqv9SjKU20LznGj9mzGM9XHakkB2CTQ9CVSds2tR/PbQ3awo5QVS7S5UXUtCutI29U+/KskMCMnt57Mrit9gZkxK2GrDD2ByCyvRYkGzqsjp0BthhIjrjkQ3sPOttOAo9XaeZxUP4gGpdrYD9dOcGFGWdUj8KAO3XLRpqiGgRFWN9fst/stNA4oR+YEC2sE9+KberqW769VEgbtjVqw7Z6mtfQ32bS7eQVKSVat58O8xD4VlUT374RiaHIqK9djcAFjyUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtbVAsSnkY6m4FrpxjJt+RiQtC9WklzSlh25FTMNN0s=;
 b=GjHvOfps21voyetNYVFzHOjHmG3q8aFrrwaxn/33NnMM/xZnQgzQUt2wdYqpg42BJCjIO72avBOIb/+romGEsdv6/DSJ9CLxk/fELPUYSbAB/WO9NZpcapAz2ypekwChZ+eXVP56lGiZ0iJRn/+lItUiGlJFKvjDVY7fWwIF76eZCtchl6cFUgUqgMkgD7Yi3zjtDu2JYZBK3ZZYaumsyZWIMaOqTNEdM6pvLt6tPklfhvXw4F+MrD/4AXziKXdUAL/xkCOhSC7hJPOyiuVMf4TcRek5pD/2Cwf9MUHr7MW72LgtP5W49eBniZ71MQG9Px6sJFT+jE5PUOvhqqfP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtbVAsSnkY6m4FrpxjJt+RiQtC9WklzSlh25FTMNN0s=;
 b=NIf0t3GiCMs8QuJHSZ85j5KCxqc1zN2A7cE86TbMnbklLidAdsmGLHBLYWrYJq/vfDOsRQir4eAB6kVeQHj2yilEchM5rR1cv6RM1cYSueHEs5jYLgG5P3w4UPebvHlkkeqDc1Zxza1aXGqlER+xd7gfYeGENCjCOCHrVXbn6U8=
Received: from MW4PR03CA0118.namprd03.prod.outlook.com (2603:10b6:303:b7::33)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 21:53:51 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::de) by MW4PR03CA0118.outlook.office365.com
 (2603:10b6:303:b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Tue, 22 Feb 2022 21:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 21:53:51 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 15:53:47 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/display: increasing DRAM BW percent for DCN315
Date: Tue, 22 Feb 2022 16:53:35 -0500
Message-ID: <20220222215335.3009315-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
References: <20220222215335.3009315-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cf61df2-7052-485b-e28a-08d9f64dd024
X-MS-TrafficTypeDiagnostic: BY5PR12MB4161:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4161A17694459831C0E0854AFB3B9@BY5PR12MB4161.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKbXAtHK5zD3OwPA0+ricrF0zfWneY15mth+SRgi+AzX2qMUZWhRs0re/hJDj2h6eTRe1tVcaO95/XIVAxicNewlTUjsBVwBuz2woL/Xqu6QywavH5EzA4/uKoPE6yz/fDMZcj/NHe1ZmUQ+7su/PPIL+b2PsCunRuNExm8cPoCAs07Sps42AtJo6d4hxQjbVjrIC6FmHkWdmXT7wDTEy0egMKttajpsVQ4H6R8XIg1a1qi+ssCMvg+ONZkbnFisfLpYIzTUzn66czeAlN+1O87NbKk9wwI0gWsQH7oh8bwKzOGMxe1woCRiavSLs4ZAQggakjE6cNwvdMNZCYwRiTWxradp2narUQok+CBcPl/38ZEvjZM2HQWN4iYCKXLq/ygV7AXKug0vXle6GxGnzTssZqWdVpiHah/ltD8HAEFoEt6VndmArv+EmpeXh+at2mHS8ACQDKOZFUm0FABPwwQlfI1p+bMYSnVMyFdjnJ92RYaPQ7UWunQ6Pf03XNRqnPwtp5RNDHOlh0Qq8WAltulONshOfTRQvGGJhvGM9wfA4fCjbK5WjMHL5nchaNP6pGrGBRx7uB4W3vtVw2QS4wsBsHS9OwJWn79RoLLo3BnbADRIQahmd7XVv1DMt5rDFnizW5X+CSd4T/BO5/EyizYjAomKjWPERFxhu3V7Wp11dtmF0G/DcDDzM4tpFhF68sGmoCHPPvd2CMFvQDWUig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(16526019)(44832011)(2616005)(186003)(336012)(1076003)(426003)(508600001)(26005)(82310400004)(2906002)(8936002)(40460700003)(86362001)(6666004)(36756003)(356005)(316002)(36860700001)(6916009)(83380400001)(8676002)(54906003)(4326008)(70206006)(70586007)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:53:51.2597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf61df2-7052-485b-e28a-08d9f64dd024
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Sung Joon Kim <sungkim@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
DML validation fails when we connect two or
more displays with HDR. Need to increase
DRAM BW to make the validation passing.
Following the value from DCN31.

[how]
Change the max DRAM BW DML field to 60%.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 46b170e60a54..a71073482881 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -273,7 +273,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0,
 	.max_avg_sdp_bw_use_normal_percent = 60.0,
-	.max_avg_dram_bw_use_normal_percent = 30.0,
+	.max_avg_dram_bw_use_normal_percent = 60.0,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.return_bus_width_bytes = 64,
 	.downspread_percent = 0.38,
-- 
2.25.1

