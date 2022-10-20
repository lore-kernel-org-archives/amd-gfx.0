Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDEFC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DF810E5ED;
	Thu, 20 Oct 2022 15:48:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D897910E160
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlCrrPL4/7zdBMIjH/SB9I/p7roosSC+ZVTqbyyk/sY1nNZygOCOeIGHKeAjZgrVDuJqQgkctSJJa9QUMysK7HAC4dy/D21r/Myy2Y/uvNoEmGHz34wW1zV6WSCfi1AGyR+dWqyo5oYu3EZChSZFnxCS6bn0ReEb572a0IvsoX35YU7TxGrsUAVBjfZWMb4yZU2uoyehbIwCr12lntFeurLQgXPDl+dKOxAPq87a+LVGl804mi2gF8tpD9k1KT3j7Jt3QPdDjvjB7KtciCJi++Vupnn2nse2ypvnJZy4BXmkN3FXN555o3DdDVGSkmmDP0jafByKzlyZPU7gwlggPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzGu8nTbm7fVMe/xnxoVnnlYhbOyN+DYYq3KlyFE1XE=;
 b=KNtp+Y1I3NxY1ntSoNmtrkbGQ+XxQGtcSX7VAFKTNmmjutlHs9TIJEBucBHQTBNVFstRUPqKNF2+njayP8DevlYECI6F1CcK/4+0iHu8Lq/fKa5DontKiGTtrG/apEMBrqkhhjtm/29ebo4wydIdya/AWYckkE7Mb6tVMW6FSLNtB6aDV8q2HxLRuuOu6pCHbW7voK7eGpIZX1rYqvaRmgCrK7R7aZcZxkkKcDNQELbbBLwXsVigyxfbj8IoQQn+euC8rLYKbOASyQk+1tlj+YCP9KNWd9Fzttqvk86LFhcAshI8oEa7ozzTlrUwpdATCFcfUuwmVOyFCTqqgxNnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzGu8nTbm7fVMe/xnxoVnnlYhbOyN+DYYq3KlyFE1XE=;
 b=jfHAKqYT4aOfRehrFWYeNXzpLEuAL5DZL85DUf1S6fMUn9Clc0ZiCdwkGc73GgqK5HosyiBvtrfyWwW3ywu5pShGjfik92vQ6cx7cTdpXCPe2mC44zedbfS0J45Zqt7E35bfBPmGdVacqTvQOFTQZB1SkBgcdBSSaTMnDVMP+1M=
Received: from DS7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::27) by
 MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Thu, 20 Oct
 2022 15:47:58 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::99) by DS7P222CA0015.outlook.office365.com
 (2603:10b6:8:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:58 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/33] drm/amd/display: 3.2.208
Date: Thu, 20 Oct 2022 11:46:46 -0400
Message-ID: <20221020154702.503934-18-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1579a3f2-afb1-426d-6abe-08dab2b2766b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ms1fR2gwIQl14fvsVqXSLbVn4eer5t+QVSaj2PbClPOHs6g0BB4tNVfPblPuJQo6HV/124R9v2QHSjjMTk/clulqGVCrLz3ACtUwOG4eXQsrNft0LDhK7T6AMG1ol0vk1e4oErFiBjl/PaLoHNOsos4MeHJYqr0uOnVIlbV2mwWyy2EjQdn4AWR+bL+7kETH+7VrNNawOmPX/gTuUztFfgg0FHWDEPedjQYxAxN6qaVzoTX7jxv2VZGPDoIhGNpeUtzxuo8QXNW33zUvqkcO5FQh4SW3phBg8EzTILwcmo9RQuG/uWZeqdWQtjpM5VS0SKTak6VBEI2gosZJ8rmagy2/JF0UW/RN5wWXooGOG+XuS3v6mEzbT0WHez91Hq2j+WD2WaUVrcfABovivU83l+7TEnPhi1YlpcTcJIR82oiDLv4sDkFJrtZBXnU956ACmt2khgCaJO4M2x3zAmuJ0h7JDLE44m3zbxdf7mLVP7NNNVTx5dfJoX+a78cl2GmiEUmunvKYE/tCTF1R73u3hCgh5pkWdQNnwXeBHMuGB2fbiUKvHfWlQWVsL6RcaqvhhnzBmazR3UY5n57bC8TIWlw3KljpsgwCNPEzLowRu/KGqvBOPq8UXWKW3oPQY4TeQCdEXAz/s9W6MXG4FQRETURXiyAwHzpk2eeV2l+y9gLHm49rkQACu8S42Hq2HKW/uJMsOfUwwZz6cnurmKMZaR1Uz9oFuf1kQjuFEIZDZ+YK0a4y9zu1MzIsX5OiEzpH5o3QegLZcasotydqHjkP1cPZ8p8jtbfQqqq58cK/tE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(36756003)(81166007)(82740400003)(356005)(2906002)(426003)(16526019)(186003)(47076005)(40460700003)(1076003)(40480700001)(5660300002)(2616005)(36860700001)(6666004)(26005)(7696005)(478600001)(83380400001)(336012)(8676002)(70586007)(54906003)(6916009)(316002)(8936002)(41300700001)(82310400005)(4744005)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:58.6239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579a3f2-afb1-426d-6abe-08dab2b2766b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

DC version 3.2.208 brings along the following:

* Add more kernel doc
* Enable secure display on DCN21
* Limit dcn32 to 1950Mhz display clock
* PSR code refactor
* Rework audio stream sequence
* Generic bug fixes

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bd7a896fab49..9e0b59297661 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.207"
+#define DC_VER "3.2.208"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

