Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8409BC77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E773710EDB9;
	Fri, 14 Apr 2023 15:54:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069FB10EDB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPvjPsxSWc/b4vYYsLY0TdDUPrBomcYESTbAd8EA/SKQWHVcfKFsjEpgHRNpG1tauJCTqnKMgRTEM1AIp0kIJCt3t0lqB1NhmYNifCjX2OAYxA7xMjdTgkYOnjwcQh5j05QpASiYzPqI5DtoFrEqxlSLwqa55nd1jcExAuWwHNXmEL+mQbjENTOl5V6XKxaKyi3GU0BdLi5+FcgImQcgXx2/BPzicWnE6iuHFHw/0gIQWuIiMiSz/dJQEoSewc86v8uO4guwCfMjTPb1eSA+/18CEdPbXuJB8Fwh5HAPsYPT3FMAAjV9sSLEPmbCTJKqNa8PwqW7Qyw8eK+FfnMcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMcbtMJRIFQnTO9N+D4X36b+c4BIyfb/ZmOPlSQ3dlI=;
 b=L7cOB0p/B11U/w50/vJsD3OQaTFw8GNBF4Rvd2MIvP7fKhfmSsFlrzVeS9XC8ZiWIGPI76gDOyyUahkLR/CjgipBfWxiUTADa92Ws5l6N51ktD7C8f3p7AYjMD8bDI7AcxYX2uwTocirujeUeCIQ0aO3J9up29fWBNXqWD2Li41AztkahANKRBoubUy6+Zpaj4SKmOOXeiw+vEjxp+7DhtY36HntMxyZat6h4vesKVe/f98jqtYSbmAgau3sfRs53dMILR549+wEvV0UAz489z1ojlyslUm2nloNHpTt1Gho7TV8ZaoXTvCNxmEPct/ljVVX+fFGOWN9qnfcwmt4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMcbtMJRIFQnTO9N+D4X36b+c4BIyfb/ZmOPlSQ3dlI=;
 b=ke5oUuEuxQISEIzl8aAWRzNeV0KqLWwlkg/i8H5JEfg4PxeSxNfUuu306Jj0oDnA407Z4EB6poSevLB5JG6pzHG65BcfsqmQiQAxyIspXvyDloAOgEZEHkrrarmsqcI6trUCMP/A524AdBR19QDN6WRy6oLJ2gx2TGM9eHvjiXQ=
Received: from DM6PR07CA0102.namprd07.prod.outlook.com (2603:10b6:5:337::35)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:53:57 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c4) by DM6PR07CA0102.outlook.office365.com
 (2603:10b6:5:337::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:53:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:55 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/66] drm/amd/display: Use pointer in the memcpy
Date: Fri, 14 Apr 2023 11:52:31 -0400
Message-ID: <20230414155330.5215-8-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 65456e68-3065-4b13-6e6d-08db3d007511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiSWnVrP0kNE1alIu4m3Yyn28XnHGB7PBRWBDsaGpglG1L0nQpGsxOWrsCpgJwgSIJqhNgYUujnujAcH+vtn0FJw48ugcVP0tqi4SRHxqwSOa63nBviCiHHKsBjvwjCnfJGoDewNKT9zYdm6nI7rg6kuskzpOQVHsHuCCeWbrtJKjjlTp/OnUVuKYAV6/bonqxBFCW+Pe2O7zmjf83etIPK8vggT0RkBOMJn5hoyug+aZ2pGL3sItmgQgzJSk2+/s0cUKe3c372wxny7DNby9Ixmm0BcpAsDA6sGCA9CBimwwrTJZHFqmEVvw30pxnEnMVrjoJ0+qyb1XwCmiYjpqRN4UGjOOi9BgaL3KNosE2qF+r46GkSQm+f4revhS9DSH1VfwIhSWPGkCS7Nv/u/nzMHXMEuq765KmxKZ+Frp5qtcCM1ah77mHa3Kf4C412VpnhM3S5vQtCfyZMo5wIEikP1DO/1IQYz1uRoMLCLAt9l7oQ+o9eBpa2YOOZRT5+YzrmhrioXzsS3A8ibmimcUlfoKpQMvWo9r5dERV7ZSKG9T+bqoJowJt10vIgOJw0K1E9qGH0FiTyMS16+jUiZowBKMGRb/x5rrayAnZ16Om+F6QlnBKpuZxkWBDEMaJhcs/WIyrnbWVpkF0PEm1k96jij2VwgLDZHVlcIpyn2zZvQVvcNxakprpYcCg8jFaMUxJXY6iexn3W+l78hbsnWj14+mCEhBY1GugMjnNZJwjg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(1076003)(82740400003)(356005)(26005)(81166007)(83380400001)(47076005)(336012)(2616005)(16526019)(186003)(36860700001)(426003)(316002)(8936002)(4744005)(41300700001)(82310400005)(40460700003)(4326008)(6916009)(86362001)(36756003)(6666004)(8676002)(5660300002)(40480700001)(2906002)(54906003)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:57.5646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65456e68-3065-4b13-6e6d-08db3d007511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 03718cc148e0..f1c1a4b5fcac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2333,7 +2333,7 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 		k++;
 	}
 
-	memcpy(dcn2_1_soc.clock_limits, s, sizeof(dcn2_1_soc.clock_limits));
+	memcpy(&dcn2_1_soc.clock_limits, s, sizeof(dcn2_1_soc.clock_limits));
 
 	if (clk_table->num_entries) {
 		dcn2_1_soc.num_states = clk_table->num_entries + 1;
-- 
2.34.1

