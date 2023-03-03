Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A483CC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4367E10E6E3;
	Fri,  3 Mar 2023 15:51:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219C510E6E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO5XFcqz2z8GPnJVYH64y02QiK+OlAvNgvIqZbCePsSUjtXQ/WwQ6eTzFspL7MjL+6MbuvcahgohcX+lG2VDPuu4HaOytdJZq7/eHoKf8Cybx4HVtn8z1XrDJ8Ai+Wx9zwp5vjpcajWFacCismVHH03C2yE5PQyjvBCK20nrpLpX/u+nNzS4/Xs/fXBz4qbup0pxacQQjKukPdAM3IQ6HvYm5+Yqba216UJ25zgFvXuOPiyGi1YMdQMZU1fowXG84/cI5hflpI95iv0Bb5epG396DjE9Bm1tBIchiz/YMJU5W93pgZpwVfOh9McFVQ7xnWBhIM9DkDOelmxrfkNCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUl9b9h6PX7xxPC5OSHCvc/pv+kliHJSB3HSdLiu6ss=;
 b=eQypdzEnJbYXTN2u/o1FFRDrR31KwRhGtJ8TCNWzK0UY59JFHraTaJjgKaGjtQl+mML7cCwEFXZevp7YA0YZcu2ORITn3pEDvK4uy8RQSVDsntmTRerITL1VEI5DmTn5Hjk47/MtHpTYov9yZxn7bInO8oD9BGPqY4+kPok+OlqktBg4FnaVQdff+CB6adZAQeBUAJ96mVhiMo0En4TfwuDucW+oMo1x+Z7upFJ/gA763hWQrl/jpIyM9w1Oq2yiAzAZ7YCNvhfhRk97/lO8Cp21DKz0iaDY9kZyZ/oWuTK2fFPiwM7dw1CdlK5eJg5PFrt61m283cUHfL+eIOffWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUl9b9h6PX7xxPC5OSHCvc/pv+kliHJSB3HSdLiu6ss=;
 b=Z+GNENDAJLsukM2QW7YUGps409PeFp86nbGLQYPplE1oFLFcQVyoDOfC+8dXtJ/AhLBMLGoHrWvY9C93O5XNXctMYPTp+74VP3kIFHJ62yhWNkqt2ZZmeIG6soT9QgJp9XwtnsVoSrExTWU1QDCm5lcsjznpAE2Fq+stgJpEOec=
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 15:51:38 +0000
Received: from DS1PEPF0000E635.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::16) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E635.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:30 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: Ensure vmin and vmax adjust for DCE
Date: Fri, 3 Mar 2023 10:40:16 -0500
Message-ID: <20230303154022.2667-28-qingqing.zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E635:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 457c5745-7889-482f-20a7-08db1bff2cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dzWfqqcXK9k3N+IFdqqQVW/3Q5nX7S3laWe24FW0mfNdym/QDfmIz8hpEuERjlS0jTE5IqY3KkVTmCsW5MMrfcTdUtnIOZdLLXq7QWQ7I65mfiguHSMRbypuvC5msWnC2HUxgKZPFsCb6ea6xl53lLz8czRckfbh0mEqX/3rxpcWqQrS8GkxuJ9f/4Xbu7jTYPnwN0bdy20lwNxBJnDIdEHKcIauJFCP0FaouZj+LPLPxSV7NiAyXXuod/kJtir8OxZUecY/J0wpAGy0cPSi8MuR8B5W+4gV2/wK7cWO86np+9nxTieQWMxWnEr3QHuQOLCB6CxTWFFvD/7G0ncRnvt2c7aHBAOiYClssdhfkb4TuYJ/FaojuBduBCrTT5/+jaud4Urva0mEOcg3+ZCvtm4wiPtVMKVD9D4QfOuOvm4TF3YzoY9WwREPhGnw/m2Hlt5jj5K4CfgUGa76mOJ+u3MUrPHAFcWIVJluoxduHvHUKbjsoxK367rU4yskLnyeayIFSww9a3O8zTuazY4rxVMkOtZhlE3HJZvRXSVKDoDPG67jvUZnHFywaNr9XrPyy5GOdfKxbbyftloNYOwI24T1JgoIWisLoIqftwXr2duSCGFHHR499pyySCwMi7EtM0qFlMsjg6oN6AGx6ZL/1J/3ACphOGTuOoOFB1vLQy3iS0VmdlxKbAddEb4ZaMxu0vPJTqyoXP1rZ6omj9Fm/rylrhC3UiDZlSIDjU5Pik=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(6666004)(336012)(1076003)(2616005)(26005)(186003)(16526019)(6916009)(54906003)(41300700001)(4326008)(70586007)(2906002)(316002)(44832011)(8676002)(81166007)(8936002)(86362001)(5660300002)(356005)(82740400003)(40480700001)(82310400005)(478600001)(83380400001)(36860700001)(70206006)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:38.5313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457c5745-7889-482f-20a7-08db1bff2cd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
In the commit 68d1085eb2 ("drm/amd/display: Do not update DRR while
BW optimizations pending"), a modification was added to avoid adjusting
DRR if optimized bandwidth is set. This change was only intended for
DCN, but one part of the patch changed the code path for DCE devices and
caused regressions to the kms_vrr test. To address this problem, this
commit adds a modification in which dc_stream_adjust_vmin_vmax will be
fully executed in DCE devices.

Fixes: 68d1085eb2 ("drm/amd/display: Do not update DRR while BW optimizations pending")

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7bbbe64185aa..9146c9667c7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -404,8 +404,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * Don't adjust DRR while there's bandwidth optimizations pending to
 	 * avoid conflicting with firmware updates.
 	 */
-	if (dc->optimized_required || dc->wm_optimized_required)
-		return false;
+	if (dc->ctx->dce_version > DCE_VERSION_MAX)
+		if (dc->optimized_required || dc->wm_optimized_required)
+			return false;
 
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
-- 
2.34.1

