Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B68C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5542210EF2E;
	Tue, 18 Oct 2022 12:28:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674808930B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJmQRFhC9FbNCt12o0B5rv2aTpY0XMm4tZtlQ15wgXB2ewq+mQWaAFO/6A73f4ri+tCFEKZpCOg2Fpjr0pDHBSzZH52vJKIueYldWvwnlokMt8snH+HRD4Y0SLbu6Bc331N40dLMLUrs/3oo+ufWR0rmLnL5foQwzB8pb23E5MoNSKU1G7lypdk1jNPst+KlTCdPHQIzOGirkOBRVVPaGhIzl59Ce84KffjlTICKy4Bv1sIWkiPRA/U2F9Vki1+fx3uRlqvpvwEj7CPOraas/5otOjcebGO6+CmTPj9UBOw9OEHpxnFClMyeD5EYls/nOJOM4YxgcoYS1KxEWbHdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xANMGlawaUEeBs+AGwtCkbvJe6ZxNbROye22bnrPOKQ=;
 b=BGjOci1O5l7ycfZ5dsXftUgX3v6Va/iuuObChr2OfIlKdC/G4OIGP6FIh01DVQTiYnjO7KY95L9UguGaN5fAUpvxzJ0j1mf4W/HQoHA5WiJ/22Dosb+WAa/KMNmaODDcDamLWSwQWaec+oVW867o5ZU1dvKuy4RYSq3dmVHC+xC58TSgijGX+2fGMaAooHgYUyQZpA6GzgWjnmFKTi7uGMxp9Vgi23F/pUBetmI/ctY17tOSAbqYNj312dLU+qMHqMWpsOc9hlAotyz38nzotfLSqHl2NtkD6OsAvgxk/qrpbPPTSHdLmJtJDiQK6Lce1nHSaEhTkiFKSZZYXOf/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xANMGlawaUEeBs+AGwtCkbvJe6ZxNbROye22bnrPOKQ=;
 b=Z5MlA57roiTI6aOg5OA1X7i7MKMfdL8qLjfg3FzVuLnrC2CtetjLvtuVYd7OP6euRJVAyIwA5OE5S8m59a7l+ESD8gWE0Q15c8RW4cSjm7GCj08G1OAjqAuKYrC8R6aos4YM+3lLdBH81QLY4hXsWEeZKc/mt8NGxF4q3ImiAxI=
Received: from DM6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:5:134::25)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 12:28:21 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::f7) by DM6PR13CA0048.outlook.office365.com
 (2603:10b6:5:134::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.16 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 05:28:20 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/12] drm/amd/display: Handle virtual hardware detect
Date: Tue, 18 Oct 2022 08:28:20 -0400
Message-ID: <20221018122826.1790114-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f4725d-a000-490f-d55d-08dab1043e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruwXZiIzZaveelFMjizOzM1xhTYa+Ul29381V0omyEuRrdIGh0jlrGA6m+SYM8uypP3Y3gXMn5B0tlLEJgOLgR7ck4RVHaNvsbDOehxl3di3ApWHGdzBUt66N83+mCIAso+Cr1fS9X0Gzz8yui1IacvU48B9Ug5N+lCIiHUpX9vZPKA7T+gegxmxitipAQFjk3BRYV3bdrqZB1UWj0Rrf47AVWCq7d1P7A7MquspcsVNbQP9f+kpHtmpLuDpUuY1nb68ImQ7juzZRPxxd+W+4PreFWn0+oOQW6Jb0CQbvW8vtqth8htmSejUw7URHjEDkh+3mvXXYQ42r+J2pjlztsb52YAuV8ny5D2cGVa2Bib4J60An+bPycNlBp+Jnx9TenaA+hQpCMMx9ea/YXX5eP7ArfxLvfehMQzd+UlayXFA1tnwBRRtVqWQljYKwDfRJ9aMsVESWzvmsYvg3LvRCF7THTFCnhrwBPBKa7bOVQ0C6m65W7jbooS/yKPGqxpHEeOI7TitPp6/mwHTo+HFAbLMErUKv9sYL9CdI3+BWJKWakenIKpNzt+h5HXJWbuxV+IcGDH507Xevzf7T0FKabraiBCfhLhds6PmzI7DgC7hVVIm/oCtVvZGCSYEyB2FCVrvE1BOC1GGqglDnfihPqmJ7Pq8CFSDLmPfsx7RGYcOkK1axUMnxhrrY6YrUjZU6dhjvOxGzjw1IIQVIttQg8atI8GLTxfwm2TnKUcvrfmtg6hFuePHAlGmLkD1iP9v0SuGAlt3SSHTSv24DE2zXPwVPHRwOaRqyQhPTm3Zezff1IV3t9uzccpn+hcgjPw5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(54906003)(6916009)(4744005)(8676002)(316002)(478600001)(4326008)(26005)(41300700001)(1076003)(186003)(2906002)(5660300002)(8936002)(336012)(2616005)(81166007)(36756003)(82740400003)(356005)(82310400005)(83380400001)(47076005)(426003)(6666004)(36860700001)(70206006)(70586007)(40460700003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:20.8929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f4725d-a000-490f-d55d-08dab1043e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If virtual hardware is detected, there is no reason to run the full
dc_commit_streams process, and DC can return true immediately.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b904b03cf94e..61b574b9e736 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1912,6 +1912,9 @@ enum dc_status dc_commit_streams(struct dc *dc,
 	enum dc_status res = DC_OK;
 	struct dc_validation_set set[MAX_STREAMS] = {0};
 
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
+		return res;
+
 	if (!streams_changed(dc, streams, stream_count))
 		return res;
 
-- 
2.38.0

