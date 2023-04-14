Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968F9C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0908410EDF2;
	Fri, 14 Apr 2023 15:55:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C4210EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PobuJMlNKtHKoimeyh6F/rybSNLoULnMH/R/z8wAnyVVnRAs+rl1O1y+rZVU07OQEk7q2alaoA+mJrzqrRz2cYa3HFmveLF+yjDbm0CZJdquhNZFtqJogq+ao8cUyu2Gw0hU1eU5dEbNOfewJ4SyEtuMncAngKttUDWPojS9bwP11w99HwJi8Ywp2HV8QT4L/OC0tL73lW47pjv24MSXw9Sb7F3JcX7MtsN2E3sLSDTobeFwhFuPP6wGg4bolrbz4b49Jnkig77MsR5p/KeEu6Uds2ACpg8e66MKBuF00hV3Ot+nNwHtjvCHARUu26jLV82q+4nQHrkhny3F4PqrIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW/yynAFoiD6+Gsrv4no/0ppSNAeX19jFT5f7q8+lEI=;
 b=Mt2cK/P9mYvFahNWYF/bhRPTjOwoSL+PYPH1fk+JQNALEVDB6C+38VIF2N7PKwtquN73Vs/hr3yb8/S803lL/kK4MuvhjPgN89DjdSxdlqfEM4m0j/DiQWOF9sxByh9oS+7uWRLuDMrccqkT5P40IFdoVcfW2zHrsJO1k1zLiXTTUaJFkgYF+O3Ozk1AKHIN8ii66jFh1yTlyrLO4y3dmOtmytDrg5OfehHCsN8Fxnp6sZr8kpHL6SW1clubPGS9h7w8Yk3bDsFHnbdG/b1X4n+DVw8qMNwy4vGEb9erzS7AZKPXCNeh3LwF7uyXonEbGuC/HooFStYfHspRU9D9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mW/yynAFoiD6+Gsrv4no/0ppSNAeX19jFT5f7q8+lEI=;
 b=Cr6a8r2chEB50zjCBHaV1HXHe6M2VYiTtTsUpG2Mwvy2KG/71Biduzh1mql82fzc1F3zs4FtDu4eCSBj0SCeZ7LmDYhYpL6+XVnGgyhm+iQ/zwj0RLPD599KYdoUWbY1Q5ZXoIWYwplY+7aA73kISg/1em8FginGVGVlN1xWtyo=
Received: from BN8PR15CA0003.namprd15.prod.outlook.com (2603:10b6:408:c0::16)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:55:16 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::6e) by BN8PR15CA0003.outlook.office365.com
 (2603:10b6:408:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:55:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:14 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 59/66] drm/amd/display: Set min_width and min_height
 capability for DCN30
Date: Fri, 14 Apr 2023 11:53:23 -0400
Message-ID: <20230414155330.5215-60-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: fad8b574-7de6-408a-99f6-08db3d00a404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwsCkvXKkV663CFnmQHazMVyIQMXQqumWiO4mcxG5To3n9CMyT9vqd//ro/SuxUFIZaa0GpMPkViwnJ/8u++3eUMwC1hD7NtO7bqP1zFq22d0A7USvzvucDE3+m6N6RQXW9QgtX9G1+Rrzwa6PwdgTc7zeI49uOR+rB7phSW3pqzgJzRUcUKM4pNh0/AyLPDr5Ox7cujydbHtDz4eyAuT1IcAgK+Vc/2UWLUOb8sPi/PLvODLHRvGMYQ/zybOVfOiNM/kXADLngXyXMJp7Y8QWsMj2MZsfdiZNeNt0BU0KVVxG8rjTo35+o0yWZbHZRvymMuv9QmSQPvowdy1pvqdofWgYdSJMm3TOgLghE9zW+fRfbLw1kl9mSnGLEhakxjcKiOjxioNZ7tnRBxeDMlalRXdoKvtRcNFK1Xp7xZrebq0QNqdtMuspdomVrqXQ9/23+xQHEER4qcTU/10fo2OhN/YllzHsg05eiy3x2BkpJwXOGZsB1/lqfjCehFj72ON3NpQV5MxCoDFmoTxSwML0ZkuAfl7YreKI2m1nZPSqT1JSjunkIKfQibMIm4WAxaqdbPEOykrNaQ/29dMkPMELasSLAbGul/cyOWs3uNNjysygvUmQaCUi4jBR78y5rRq+jSZt0MObrttjwvGukZaWrXZe+rSM/s6DukZQsZfqB1DoiEqyEX0kt9DI80z5zqXp4KD/J1KDkjfl85j6gnPdBete1gi7cRsaYrqeQuln4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(86362001)(36756003)(316002)(54906003)(41300700001)(70206006)(6916009)(478600001)(8676002)(70586007)(4326008)(4744005)(40480700001)(82310400005)(8936002)(36860700001)(5660300002)(2906002)(82740400003)(16526019)(186003)(356005)(83380400001)(1076003)(26005)(6666004)(336012)(2616005)(426003)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:16.3647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fad8b574-7de6-408a-99f6-08db3d00a404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Igor Kravchenko <Igor.Kravchenko@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Igor Kravchenko <Igor.Kravchenko@amd.com>

Add min_width, min_height fields to dc_plane_cap structure. Set values
to 16x16 for discrete ASICs, and 64x64 for others.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Igor Kravchenko <Igor.Kravchenko@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 965f5ceb33f7..67a34cda3774 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -701,7 +701,9 @@ static const struct dc_plane_cap plane_cap = {
 			.argb8888 = 167,
 			.nv12 = 167,
 			.fp16 = 167
-	}
+	},
+	16,
+	16
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-- 
2.34.1

