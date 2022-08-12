Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6FDC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F210AD611;
	Sat, 13 Aug 2022 02:12:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A438A2958
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWY5THcf+hV2ApcCssz0wO6JwMYDQV+NLy1ADzyLdrlGSRjteAviazax7Lj2p0NuGcwC5OUtRUrTYKW2WB6/4/72q6Kx5obpUxhVjfyLYFs9uHlm8dwb0vWvVi2nf+glihH5dSI7i+EFDfbocZD/o0T6AJ7Tes3rKtIqigI5fXdLUCy+mUEv/oJUx7zUdss47doMdjzv7JTVeeRq0HXLuzzxvrNHEPo7KBEpDAnvNCR1GMvrPAALXT1351+zqw0KHIOjMNCZ0xpGyonE57dy7K3dJO+NKWOQYpmhaPwdIlZtK7rPeLpT5TJax3/N+vF33SBDYr+Fyne0eZeJJ1mxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd6d/zFicXU0UIM/Rn+nBMNkDPd2hvjPF5nWqlm5RNk=;
 b=lyM+IrTLJQKHHrJMzZ4HXk1mTXrnTv0WW8fGWg1XvHBp1mtRv4EhteggG8x7iMUTe/z7LAetZF2+IIGDxQeBmSez5TMh52N2t0BM2bW0WkXYLbch0Ks9k/dud8njdACn74r7rb+qTUbk+wxAKWpuS9chg9Kxz2LDtsMe+7DCFIehBFnGugGY5SXGaSkMAzBH4KS40QuvWWbZea+qLMInP+4FCLrwaDCHOONU3Qo2P0LkOkPOj9gZb0WMcHAe95Cwv2w+F70PIgoKBYJRYgYAwpmyXRsGIB9BAXHWZrjt7QZ6z4JLMQL2f2574iS8cRa4O0ZhczukZR2QQBjUQKoBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd6d/zFicXU0UIM/Rn+nBMNkDPd2hvjPF5nWqlm5RNk=;
 b=ZgCTDp20gtoXI7+cKgAe6vyt3/JE42hQ2wLC/ximj5dju7NYbQ6GumsoxsvTn3bF0dfhdHw1ccvBwqlAQPRQ+l2XP6xgV4DG1aHIRuNgEqWFxp5nKUzl+6SBtxdTRUxZSDKVO7Zt3dyfhRczfonFGbZUcOp1L8IImYmR6ARpi3U=
Received: from BN9PR03CA0870.namprd03.prod.outlook.com (2603:10b6:408:13d::35)
 by MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sat, 13 Aug
 2022 02:12:37 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::fa) by BN9PR03CA0870.outlook.office365.com
 (2603:10b6:408:13d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:35 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:31
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: do not compare integers of different
 widths
Date: Sat, 13 Aug 2022 06:12:13 +0800
Message-ID: <20220812221222.1700948-6-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e90bcaf7-26fb-464e-88f0-08da7cd14a3b
X-MS-TrafficTypeDiagnostic: MW2PR12MB4684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+0CdCViQ2hD2V/GLe1yKmW5/2RL90JuzpoAa0aBBQxaBsYDy+9Ja4xP9fCRmzQrLANS3owRyWpDibkDCGVHApF15Xw30+OhqWeP/LkIWuNzFym5g1372LfQFE4wkPT8TrL+y6z0lMLbCc95+y79X0WbD1faF0tN+VSLl6lw+giTHlOoFedJnPA2rB+eLiLetygbkmN/VIAHhmUL3+IYXl8tav7x7Gx08hL0KpoN90uCirmIdH0PCAzJ2QOl5nGdmYXsSwpI8mgwcP2elEcLKb78FC0Q44wACuoiDD2g9J9bDZE03DwjGvddfixvdiSgF6mNe/bJU3yiya26T2PfFUt00qJ68fMUgW0plILWkfsPStGLuQv/PLtnHaGwCSkD85AVqOIDf1A4pQXYXABmUREzy1jSWAIyAJSNEU4B1TKjh5rthfWnaNQPMSqn/6gcxvy3fMTnhaap+ZJ8Ke+MGU7y+oenMA9UVIAF08GWwwYsaZasG5s5mNyUcRA3X/qsGMXgDpJGx2XPZP0Yw/LSoxfsi90mA3wMPWwrA4U2Gop6ll40bSGiKx4jVsfPlWLugNSnJ7KQZdcNu076XAfzh+hQWpE8fYOwEW1hfWwquNJ79BbqBjkeruU5XmR76swDvQBK/OzAKxLetEX2wPHeHOGnjMoxSuAYaSjezSmKAWk+Q1gHWXm6CBjFQzc2+V0s01tMXPLelgk1ohQkWg/0+zCKjG8R7apzZOLBtKUMWp9XR7sA2IKjGNcvmzYnogGXwYwbu6IEtnoZF94Q8sblWHfgS3jIKu02CF+HPsEVhTjCJ5WEQ6Hptd7e2VN5gqUz6J5FmOiJS2ZqqJXHtUKIdjBMh3uBMtrBVixqTEeleMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(70586007)(316002)(6666004)(6916009)(41300700001)(70206006)(4744005)(36756003)(86362001)(4326008)(7696005)(8936002)(2906002)(8676002)(26005)(81166007)(83380400001)(40480700001)(356005)(36860700001)(40460700003)(426003)(82310400005)(186003)(47076005)(2616005)(1076003)(336012)(478600001)(82740400003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:36.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90bcaf7-26fb-464e-88f0-08da7cd14a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4684
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 4aecbf230446..ebd3945c71f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -331,7 +331,8 @@ static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *c
 bool dcn32_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
 	union dmub_rb_cmd cmd;
-	uint8_t ways, i, j;
+	uint8_t ways, i;
+	int j;
 	bool stereo_in_use = false;
 	struct dc_plane_state *plane = NULL;
 
-- 
2.25.1

