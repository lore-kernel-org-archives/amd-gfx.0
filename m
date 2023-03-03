Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C46BC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B8F10E6CB;
	Fri,  3 Mar 2023 15:44:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E3D710E6CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POYm29VW21GtDpTk/5fRXRPB9xGPsp4V1Y+memnJdS3/C4A6sEkgoa12F3fR5vkm7JBxAw+xZ0iaDsshoOk83ShSZYG9zhIGdrGe63Ly1QsEiUtmROlYmTFmVMTA+GrRWlLJCXLMMCuGBDSNv47MxoUDaPtrcDWP9KJst0R+wDNL1Y4B0zGfYq23d+D+jlAqRRJq4HA3Pnl03rAxb49bAKxSFmthB85oKhOc9KEgYxI+UASKKpEZ2yErFpCfJaZLpfyhYWXA9z8mAp42yiGT5waRobGGilydmZ/38X5zyqyszEjKkCt2+CuCUXSQAqhGnk0QpfRiL2yQrHW9YBbB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cqDwDM7E/PA6WFbL/cAYnj8svUu+U5zalngfEN8ucA=;
 b=kMkxeqQ9yZLt79eChuTu9deNwRcaWTznbknjOe3SnOQdME5CduCf+LyB32KAJlGFCIVc2vNjxFOhFCL2WjH1GkTlItmkM30STxhUImpADMnHxQAOmoykq9ADsH2CdMTauGzNBsvOBWHFgt7uVdBEUtrli2eLUeMqTmkJAujrc8NxLKYsXDsVeEePNhQGomTaUbgVoVzqsk5cqvaMhNiFroN/c+RN6bfA+TUMrCptYjnbWJmR6KSULTw+UVxWrLFsVO8NAL2CkASbTXiLO18V//dpQ7pILPN82L3XOQb+r6DW4hbCpmYKqnwuoHQCmCVJSnGcJsOHZ62vnr9mh7nLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cqDwDM7E/PA6WFbL/cAYnj8svUu+U5zalngfEN8ucA=;
 b=2g8MLCL/p5Fkr2tQAfn7HSpSAkHevTyYKcviO06V4JJt9cp4Auj+QDJ9L4n+OSJQ/tn0ZViaO1H/i4GRLkZDFg5Kpt6vW0MrT7wo7kCua7+0SXP4dNC1Wk/2BgO57VABrNM5hKYVwSS8cKXpWjwe2GqzthmaFThsXJvV8SicPi8=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:44:53 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b9) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:44:52 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:44:38 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: 3.2.225
Date: Fri, 3 Mar 2023 10:39:53 -0500
Message-ID: <20230303154022.2667-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5a197c-dbe9-4dae-acaf-08db1bfe3b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuvTPbxS/bCrV4n8svMXtt7ncKgixLd5rQBfNjn5gAtwuHtBcB1JnmEksTyyCVhZ2veEkLsB6BGqHC1BuO/beZ3hX4eOydxAz+sepL2qizRnphbh7o5nYNSVuT027rtSuO6RB/9Hg35XIte4NYW3p0bfrpbBuWA3YVKsEWGVj6WYMlwHyuk4qOqzRTlINAFUMhCksNK/Ieu527KEBi/5rJZV1ie1PH8GZzgjrxsjFojVC+FMl6QZkDObdCyv8YLS542AcbXJ7wOlU576g+GuhX4T9s30U+yp6D9ZpDhZmYitWGEWKHtsX2P4Y+w3jKGOoe2VKUU6CjSPtM5v/42DQtMl+FwJPqpQgi1XJpmSwU++Gfh072NWID5zoUpEIPoy6r+4uZjg3W/EZMAe1xIJZkOsiaOyJSBha1WXNzTySXa3cclqBxH2HRuKA/GKsvrHYvvizJKDwaBjNSjnd5/WwjAW9IMPkxXEPev3mTV390JxpZoOmiVzwBsAl7HgC1TIUzdHWw+60HXFkg2nL5bDV9g42zHJry1Dwr0uyRi4D65SGa9oyXIOo9h1cJ51SugZfc1xCOpqAdPz/W+GgzzYY0uwJQuXxLihserm1hsPWZmmFR/dTDqr1iZGIqIAHZ/RJ4buhn83OyI+3JxdOQUcCBYXZoJQCKeKqqerzBmCvEQtzi1Pum0Y2mZ2LQlweHpJZ8aeLBvfOBmqaeQ7jrSFV3YK+QNXXxUCI1XcAU25foI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(426003)(186003)(26005)(70586007)(16526019)(336012)(40460700003)(47076005)(478600001)(6916009)(4326008)(8676002)(54906003)(2616005)(6666004)(70206006)(1076003)(83380400001)(316002)(81166007)(41300700001)(8936002)(36860700001)(5660300002)(44832011)(4744005)(82740400003)(2906002)(356005)(36756003)(86362001)(40480700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:44:52.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5a197c-dbe9-4dae-acaf-08db1bfe3b09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:
- Correct way to find OPP index
- Unify DC logging for BW Alloc
- Add height granularity limitation for dsc slice height calculation

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 36dbe11256ac..c3814f40a102 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.224"
+#define DC_VER "3.2.225"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

