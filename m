Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E18C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BD210E9CE;
	Wed, 28 Sep 2022 19:41:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E66D10E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xfj9j0IserIKyMXcuDgcsenS2jnU9m1szLoO3AnHJu53UcL80pPmFRFD0/29/aikykXLTeR5ILTgCIRkvNkCxx4XTKyTlhsZgfZaNpygMfpW9Bkzwfr6pspyMk6S2RifIhqYMEUeyMUushiyVYv6mg8YjtyViZ8/G3WziffqYgeRDOBmdtjttMFlChx7lkDmMhlf/zldzGwfT/6yZzVW/W8kil8+WCadok0ljjQU+wkoQxe90OI/Mf66k7WWY8z3EOQxiNJvFyKDviGsK0rJec+e2FA6xMDEiqlDwRPhHc/c+jmuI0F9xO55TRS56GAWGOmYwzIpGA0RdbJokpWp8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GemGlWomOpDkzstXpIpTqodGsvFgSnR0jUN8JNI6KWA=;
 b=M56iayNZaaUDO5yOkll4I5lW/Qcj548AhIJEzycGUu5vGsOSjWxrYcnovlSRTi3s5Eurbf1OE9NEmf6YxD7mawLrfW9RTrQvKHSkoh2BPbBs2FLEd6pO+j/fAPZlasu0FOXEh4fCL6WkHJjEZgVHkVNjAu8PXIm1dQflHoVDfZcOFQAM2Z3dLRa/r4OsYiTrbTj1p4t2K2DzhHwR7gPl2/ph1xADp9CqaNcgqOeyMcw9wsFgngf9/e6dzK7hmBfeT8X3qmcsEmvSU6wXjfSAV5VRxFvW7XVUXLH+xMoACbF6eI9ddE9PSHIik8knEYVtsn0wBIwA+hD4JgpQzRqN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GemGlWomOpDkzstXpIpTqodGsvFgSnR0jUN8JNI6KWA=;
 b=sT9E2Igp+Z7BxXRbcI3G0yvtgx0TL2KFfZZ6Bk5Z58O82IbnPW+dO/y08LY2gVECZRaYj4oXuCjSbs1DeagJrIDdZBCZF/m7+mVEXDugSwxN1oLWRclAzjvn4i2Ggoy1iM9kA+dNdWKHmJD37/utgNpk9bAHIv4zOD2TNl0JHx0=
Received: from BN9PR03CA0308.namprd03.prod.outlook.com (2603:10b6:408:112::13)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Wed, 28 Sep
 2022 19:41:43 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::e0) by BN9PR03CA0308.outlook.office365.com
 (2603:10b6:408:112::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:43 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:42 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/36] drm/amd/display: Enable 2 to 1 ODM policy if supported
Date: Wed, 28 Sep 2022 15:40:25 -0400
Message-ID: <20220928194028.144879-34-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 562eefbe-5859-42d8-c7a8-08daa18978df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9M7b07SGufuiVFi0MIE/eoA8nkU04LyDFGucQPTQOb1Fz3oWN6Akfe4uuqPxGmwog4WIGQRLPeuCTJBDcYDt1T9gX2tYP61Q6UsvtWcBJ12mODWGlqpL72lNb9MjSWOcPcyy1KKr9K28KC62aWbzjvmfyAebeGA/ndT262Vn7zI9Rv2icsPejR+UDImHgC1PeSi70GdpNyLvvsB/vAOAzomdgBQl1b+R3o0OCzqliknF+52yyn7d1+IgqbqpaLs0FRQkVFuQBAEfPm4PNL1E4sP1xIWYhfHaW9tQN+AOOAbmxDnk144X/Cvp76a+wwAzE5JMO5/UtL8ZDA9ot23JQ+B9pDjXO4i30lBk5/5+DHZrWfrfL8TC1rkK7k8ImtlWAa6ezrVMoUeTasGnbGHa+YuthMOcBzQlypoZXOzqFi8sGx2FE9DHnQuRa/OMsWhVvCDv1s8V6TZbLmM2fxNgwXikpw/ieAKiwVOBOO/P3FkaXQv3hM5lxbqK2Vtv4vFrjwYV6eSKlgMtmy11LGwVFrZEFOSnqzU3TYpc8ulCV/fSRQT1A/63nc514ZxpFVNbE1LlrVElkhyWvky5lIa9Q41HflkfIhQuo8Ujk8KULglrh+XyAT+7oqnoSw6cDruDr6R4V7yldVFkZL1CjEHbrZ4hiJnOxaH+mcZlf0Jj/9Z3S4yWp0KByVuHW0MvuvVYN4+xuM3IPfQiqOOGAHbpm9VJV0zvAxNfvbbwF9BUINa1hFrBYYNmFyAUsnvANKvZD90KmBF+Q4iIYb4cPKgV6T9HQnBcptyCwKBJmFNDMPSJrclE5Kb5cKYuUNhtrYR+WU6bYPy3C+Je9dzeeqEoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(336012)(36756003)(316002)(426003)(70206006)(36860700001)(86362001)(26005)(16526019)(6916009)(8936002)(54906003)(8676002)(1076003)(5660300002)(2616005)(2906002)(4326008)(41300700001)(6666004)(186003)(7696005)(70586007)(44832011)(40460700003)(356005)(81166007)(82310400005)(82740400003)(40480700001)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:43.6244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562eefbe-5859-42d8-c7a8-08daa18978df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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

If the current configuration supports 2 to 1 ODM policy, let's also
enable the windowed MPO feature.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5213f4443531..33bdf56b2b3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -990,6 +990,10 @@ void dcn32_init_hw(struct dc *dc)
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 	}
+
+	/* Enable support for ODM and windowed MPO if policy flag is set */
+	if (dc->debug.enable_single_display_2to1_odm_policy)
+		dc->config.enable_windowed_mpo_odm = true;
 }
 
 static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
-- 
2.37.2

