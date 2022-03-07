Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A72AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D73010E4E4;
	Mon,  7 Mar 2022 05:50:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB5410E4E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6FMfH1v5+O3CVD6mUp/R+owuNJgk2cYCj93MjAQDyEkWgHtMVKLp390MTLI07Evhn4r4RGfPKlrC7TSHlNV49xeZvZqsnJbswyPKPTSxQoJlHhhkgVXE7lwO7gySPVnRmvDarxbZtngZQh2xiKEriR8/79x2UFJA5HXPPiLmAls6DLXKQhsnYHGRE+DGqIsNt7rUJ3NsipCigyVG4uc/NoLGVb5jlLL7VuJk/zb7bKM68VSHtWhWYeknjj8mPTsdx8o+t8ViYfM5SROAV01siAiaRwTUw6BxM0EroreybXUNcO3ocAE0tgDZxJYUKaqctgEDiK0kYQ2KyDm1bEiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhtWEswV27cP84AJyg2zfR6ZT1zGGCsvD0WK6RPjVF8=;
 b=IylAgsmYY+c+NmrfWo50sAueifOkEneVtNWxgv9z7Qs1IaLxPAfjY1OZoibt2k+fkL7IL6/k2Pwwu6muEFWABZ8rS+YWKwy7yzZLGm8E7yGUCm31YTAaSdkUwgoMJjyTysIcVWeVrHX5amkrMYpyT/0ZPdUcA1oRhYzevjPgzFIUzl0USLjs+/KadQkaGNOFogWATlyv1Gi+UaBpYnzLml1M4jBZ07BokJT/7eyJ/F3xZkQ22LrrUH888Ji6r7iBtu59wuLE7JBalJkSM/wS0cbfiBj0831xt7gdj9EzLkvOa4r2xTQBDxIUam719KvpbZh7OqcYw11KeqBoFVSuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhtWEswV27cP84AJyg2zfR6ZT1zGGCsvD0WK6RPjVF8=;
 b=uJ+Y0AfFWf+jd/+LyVnenAEBpIdQk9kL6n4lnGErMWeyEo9YiX+s61VrgYJsvMft5pNrpAhcH3r3jmU91XgNTCauwMS+iVMY1Gtc+BbqWpEUOKjpZUunJWDdla4W/+9bX7jpF25grmlM8Kkv3Abkk5o7ZS3v0Fsw1TSIJ6yqeAQ=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.25; Mon, 7 Mar 2022 05:50:06 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::7f) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Mon, 7 Mar 2022 05:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:50:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:04 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:00 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/21] drm/amd/display: Release AUX engine after failed acquire
Date: Tue, 8 Mar 2022 05:09:29 +0800
Message-ID: <20220307210942.444808-7-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3eccca-bf17-4a01-7419-08d9fffe548d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB29140F880784E9445B96DF7FF5089@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVGea/21Ojc9i6W8kklXeZDkANWbIGcC1H00GGvm9HjCApiYeoqb86FZdi/I85sZQ8zP5xj6IeXDtCCrCgfrf5NQolnmBgmEU8F9WBOwz9SN/gnbo/+TQU0uHICHoqtJdUWNPQM3W6l6qKACDMoFux2MHQFb+cbgbr1Y18slq2qa60ebuHGUSEVfMDGq3sAI9QEWKqzpwx7/vYlHuVpVJadBZi4eojKstjwq7YvqjgOmLbTgOZarfAmh/gp9TJZwTdTaERTxln2lcZYpn6DpxSIEkxOxh354HSFmtpR1ViyQRNcYNOvi94ldA9CEsMV8GuiimOQMuAkGUGYXYgI8mmj+ioNNJsU6+3r5EoxKklJJ7AtqZeAIEbuAf0TnvOM4c3r9U/JrJD9+3VEAU48iqSgAQ0tnbi52dINHDbOmx0w9Ypji/HSwJ2hSk/jLiLF78zreH06ziSX+6SuZ6SknUaPRDyCE6eZVK2pnILCMnR3EAh5YROBpK1cRum7AbBlHfexCD5vVkQEoXYcj5n9Es2DZcgNhozf2h1B7nz8PsHXRUXlfYFN/EQHeP0L4GSbBzt2Uog1rRXrtF8gyw89xF8nLYICJVOZeiaZHbh/8WPFBY0DNGeJ3J78hCImOYmfvUcPY0fseW9ElZ3mWLJz/2cLfKQH5jhtgSZgfW/xwRr+ns4tB9T1mpX0vwjkLI70a1mqyNmwDzUTQQYCX4xrgWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(40460700003)(186003)(2906002)(1076003)(26005)(2616005)(86362001)(7696005)(8936002)(81166007)(356005)(5660300002)(47076005)(70586007)(70206006)(6916009)(4326008)(8676002)(82310400004)(4744005)(336012)(316002)(83380400001)(426003)(508600001)(36756003)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:50:05.3874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3eccca-bf17-4a01-7419-08d9fffe548d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
There is a sequence in which aux arbitration
doesn't work correctly. Driver is left with
aux access after it times out waiting for access.
In future dmub fw is never granted aux access
and is stuck in a while loop.

[How]
Cancel aux request from driver after timing out.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 74b05b3aef08..b8d6f4202413 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -413,7 +413,7 @@ static bool acquire(
 		return false;
 
 	if (!acquire_engine(engine)) {
-		dal_ddc_close(ddc);
+		release_engine(engine);
 		return false;
 	}
 
-- 
2.25.1

