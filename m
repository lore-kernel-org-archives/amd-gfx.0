Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFACC55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7884222283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K0zAz1os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884222283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EC96EDD9;
	Wed, 21 Oct 2020 14:23:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA546EDD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBnJlMEaEJJp7N2JJji6Xuf0RHk+WJSYB0Y3H/C6tBk9Vu2dBPAvEVE9BvauV5hfIQWwy4sujkYaJLISpj4V+/VFLkCn5ck7Q39tTGFnS/TcZEu70qVh2V+1jOufBbPHIUl1x2K1s2LRIes0qsT/oPbuO+Noawm1DdStfXyI7n1Z2/vI73qtmYZVhAGZOReVXey6UnQ3Zzq+iZVbej9Q3f3Tx5NooWkHs10m88jjByAeCa6i0+PGPtGEmHOPMG0OJJTWZHIYm7RgdmJzxsqURVsN9xS9AXeBhOxRV9hehzKgwkKQrAx7V0RJ4xhhyrudY2kQk77yHuXr1wtb4qgVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGghzOGdgV4ifdId+qAkg6JwqNyWUwNtJiSFx9tvTrA=;
 b=eoqxA+u67Lu6ta5ql0VDt5tX+mT/o+MT1M5kQtsaH8XwO0hlLb5yHKQHSxlaXFfAQekTynwM3PqcUcRXjt22VCh6tQPEpC4fTroLhvv2Cp0B0n5PUhQoU8F4zz5HDK7SIJ0vBL/uuPVhnliY6dEJe3/Rjdr/1+mJck33aLJxXBvHmLl597g6kM7iqUbeLQwisgNLDq0G30cWrbSW1TU2VJZLXgqy3ek2sGMCn8G8KDIdjUlJhPzM7OdA8L8OHE+neJ91K2h/5rve/V2EYTrFRsDZ37R09wM8vcEWintydBz5YwOO46CWCy/0I8C3ECAIq+Wknar+ew3AKov3tkEMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGghzOGdgV4ifdId+qAkg6JwqNyWUwNtJiSFx9tvTrA=;
 b=K0zAz1osNXqbFiktdcuOmwPRwKMUm5+UiKhpcw0n+HfoKEvgEwU1jQQkKcgA3yH5/4eVRFa40BWcavuJn74cI3oiAiPv2M7QtQE8+UScxneM5RzjPjNR7NFwtDwEeNP+Ni9eQvc/LEKivc7FBr790P0DAhmBmRC+Je/LmL/C7Cg=
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Wed, 21 Oct 2020 14:23:30 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::29) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:28 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: prevent null pointer access
Date: Wed, 21 Oct 2020 10:22:54 -0400
Message-ID: <20201021142257.190969-31-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0a2a03-8498-436e-a927-08d875cce225
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4349D3D985C807A2B428A8838B1C0@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZoGEq/QiPpQg8lB+/LCbejo8R2OfckkSttgML8i1/UcV163SSfrvc2JWMsQHhEvHj0Bqsb+/akH4+GYYosBVQqpDw6CiyjltzFpW5iuwOYtfHQ+DpNzmE5V37uzevaO4piAPWYj47dypyANcd6CCk0E5IfwcxROQ9jG2oUkCVr2oFFmytqB6n8Ryg/iG42QP+50x87FeegXFXP0WsTJnm4/o4tuO6Y3dvvVJyBr+zfO8hj5ioy/FUWI8a6IG6lDNTvUSzKPX+Fh101EiF11X0gMjrzTc2LmVRxP+jELsSwUw02NA8ZbKuVRo7cm1ism5gaVXDcw4a909SrK2NVcBiGB2FiaSlVOLxwmacq+jVBr9oAeYGcibYDaXiikrnHdhxz1QIjTTMEYVevDKZTrGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(6916009)(2616005)(82310400003)(26005)(186003)(5660300002)(86362001)(478600001)(70206006)(1076003)(336012)(4326008)(2906002)(36756003)(70586007)(356005)(81166007)(44832011)(8676002)(426003)(47076004)(7696005)(316002)(6666004)(82740400003)(54906003)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:29.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0a2a03-8498-436e-a927-08d875cce225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, stable@vger.kernel.org, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Prevent null pointer access when checking odm tree.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: <stable@vger.kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c    | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f227f4653a71..ed222a3d76c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2120,12 +2120,12 @@ static bool dcn30_internal_validate_bw(
 
 		if (split[i]) {
 			if (odm) {
-				if (split[i] == 4 && old_pipe->next_odm_pipe->next_odm_pipe)
+				if (split[i] == 4 && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe)
 					old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
 				else if (old_pipe->next_odm_pipe)
 					old_index = old_pipe->next_odm_pipe->pipe_idx;
 			} else {
-				if (split[i] == 4 && old_pipe->bottom_pipe->bottom_pipe &&
+				if (split[i] == 4 && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
 						old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
 					old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
 				else if (old_pipe->bottom_pipe &&
@@ -2165,10 +2165,12 @@ static bool dcn30_internal_validate_bw(
 				goto validate_fail;
 			newly_split[pipe_4to1->pipe_idx] = true;
 
-			if (odm && old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
+			if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
+					&& old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
 				old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
-			else if (!odm && old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
-						old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+			else if (!odm && old_pipe->bottom_pipe && old_pipe->bottom_pipe->bottom_pipe &&
+					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
+					old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
 				old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
 			else
 				old_index = -1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
