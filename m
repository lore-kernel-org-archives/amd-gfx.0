Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5569C54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BCB10E605;
	Tue, 10 Jan 2023 16:56:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A5E10E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNm7Km+TKcg1Bg3s01e52Hq5avk4z4HKFa36KIBqmD+W8LpbpNt5YAndenyyf1Xb9IzA9hhnBnxxNHHMVOHGjW/jgbHGeDenbQkfucJQ2LfjI3Y3Cwd5y5C45axetsKrjeOWxkvXtlFYSFj6mnasWGevyPiK0lw5/8YXZ4hGaR4UdsytQ+GoloFOZvKTT9BC6oGWv30D5Ns6mgypH70mzB8inPfEym/ayWRulGYu3sz7XNV9hRqvgFRtknJERzLLcvlJJIqYAFho7Cs8uYyI3mRReQeHwn/Y6GYky+Us3GQB26yYSaOKgkks9H8qR7DwmU1JKbo0kJ2yP8glTTDDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wow3OEBM4vcIk6yx1CtKZD9uu4Xo+G8BEeoLsaRxW0o=;
 b=ntKMjcv+Hwmbo3ISCSe1avBxZzy5fdr3hNrAveawimPCLzE6Nw8Zp5PmXA4uet2h7JJDDsTvdUtINpXJLe9IpkuXg+Sfj5gxudN6QqvvJ7P8CQj9ocEJB2Uc73xn/HqpHovXOAfy5cgefSr54NeL4AM5xsWNDdMYppWFOz2TGaCMu3yBDy0Idyn/+12ubhzJbjUvpyrOK/CtJ0KqZUL8c0lujQXGMonxGjJ4ceLPrX9UXccrbCkEOBPclv1XfsK/sPwt8h/35hCoq1Wi2zhKLWs39Tl4z3Z3wBQb7aWZYQ19iRKoIgUcVJxi4RfDTjres14ILa2LcK+fwDR29atwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wow3OEBM4vcIk6yx1CtKZD9uu4Xo+G8BEeoLsaRxW0o=;
 b=hGgjSuCoNrbNV1rXn9SKBO9owS/LK2SRcTv3EkLhkBEympSCumrb5BnY1/JJp3AwuqpwNxk6WrxgfN9DproUorhXVkKUzOj4Fgz3jcF0lnUxgM8yil8O32qcn0MUFYwY9GtnHAcnHbP861qSrIKKWbugrfNE/Ch7z3PD/BojqKo=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:56:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::f6) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:56:47 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:56:43 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/37] drm/amd/display: fix multi edp panel instancing
Date: Tue, 10 Jan 2023 11:55:01 -0500
Message-ID: <20230110165535.3358492-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: f35df765-c425-4926-60aa-08daf32ba92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouxHcSfWYkyDz4+aebqMMU+Sl6zg5eVMP1EjP2U9e8v1zYmqo6ht8mdo6eHlc6lC4yAuf/fanK0h5rNb5KqzXnxkVzMx0X2RA73fqhgKleeWjvaY3GJIvYyOOpnLUZoLSINDHxCVE71AU5+j8UqmwYawAOqsprE7Y+w/FQ+Fx5txkMSiyTmh5ySGMrKVwhv9gUSkfyLfMfzLt+6xQgJ7B0TcAgEUhzbA6rhRti+mlVFSu3A06c3Pa4ghgh5xsI1zWwcqFMjBxnH/SwdRCE1f2rXKvLYtKabN1SHD43/cGK/6HklGWN2MJfsVNn2/ytEdBK4RaXtnUZtNRJez+gx1lB2dBtnrcvbguKQZ7iaSWplo35P5c7TGyWjTy2YiwB/kqokd/oPd9GMvxcrlIRsJDs1DC/p1LsXRgTJAcvdri9Bobbr0bVrAWkyUpckp9t9gZpmFWDxnxpKa4X80EZ3/CoXdWNh7BOTUqPEUK4XNTcnLKX0IpinJcy9rts3PlLRiseD0G3UsV7UTEP6YTJud68ROwX4VTmkIklbfplYH37NHEr5+xV/UKh7li6SAY8FiGbUM5px9JPGIRmsMhVns5jhCmifAcJcPHczO8sIHowlWXNJDd1WN95X5YLy7dlsN34kjpX1GZoJNUTp8TDJE0lT7IRKsy+CGcP5eCNzzkN4da4gpn0OsjNHOW+KwJeQoa6MQjizU5o+ED6F7MHj5otjBGolIzFZ/jD/1cix5JOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(26005)(40480700001)(478600001)(16526019)(1076003)(186003)(6916009)(336012)(70586007)(8676002)(6666004)(41300700001)(70206006)(2616005)(4326008)(54906003)(316002)(7696005)(47076005)(83380400001)(36860700001)(86362001)(81166007)(82740400003)(356005)(40460700003)(426003)(82310400005)(2906002)(8936002)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:56:47.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f35df765-c425-4926-60aa-08daf32ba92e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

A previous fix attempted to correct mismatch between DM display
targets and dc panel instancing by only counting connected panels.
This behaviour breaks a feature, thus this is an alternative solution
that allows mapping display targets to dc links during mod_power_create.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 3b9315a38b30..1226ecb625b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -338,14 +338,13 @@ static inline bool dc_get_edp_link_panel_inst(const struct dc *dc,
 	int edp_num, i;
 
 	*inst_out = 0;
-	if (link->connector_signal != SIGNAL_TYPE_EDP || !link->local_sink)
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
 		return false;
 	get_edp_links(dc, edp_links, &edp_num);
 	for (i = 0; i < edp_num; i++) {
 		if (link == edp_links[i])
 			break;
-		if (edp_links[i]->local_sink)
-			(*inst_out)++;
+		(*inst_out)++;
 	}
 	return true;
 }
-- 
2.39.0

