Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0283C25B08
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 03:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E15C0195;
	Tue,  9 Aug 2022 03:20:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD15C018C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 03:20:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAe4cqQ4gxEbvau5IoqB9asT/jMl9JzgbUbRqpGeokqKcfA3sooIHS7qCpwS5qTvlHXUt11GjwY5Ja6AEuZlRTbJ5RTI3HayYf5XDwmsdljcHhDmdJqsJDqIMV/DW67mOW291I686m1Vo6/bvElqcXct/6Uotq/uOhzJYIyyAeKsyH9CauyVPVFaa9QNLvdxIkEz5LxP+UJs/oFoAK2hHNr8gvFeEWvAIIf4RlC2BGOBqWq2JPfvXvv9/++ARUQ9Uj4P+PucpgFRgVcb3vGINZpPl1NXFlVoNcUnV/tIlOj7guDpjbkocZymz1qGqDVsMYilYA+BudmhYbXTegm4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=077kL5MZU7WX6i/bImLBZARcEUbJZaVGZ0YwyZ9BEoA=;
 b=bvfw/uXJikJiI5Qvvnb47J47uEr4vkQHjyW2dwPIKUfqhiWD7pZTZBEWKdnpm0O27tVFj0+/2sZKEa+9dF9+isbdshkVAg9W9nAiv4nl3GDb6yJnFGzeNWNWmXuZVGQcyNBhQ8dhszD/uJe0EOCeO7kX09JYoQfx+qousM0zThDinjfJziUxTR7uE5kTF4uFdEYggJMIMsnYEOLO0rHI5kNexZBPHne9M3z0ClDFJHXkssZ4X5vm8RNj3XSkGXpuQH5seQU9lao9SN88sMAhBANGwPz7AQWhdaECY8e87YZ50VRcPGTnqZvSUjssXZxQg6MKUK1Oy5i5PHo3KZMx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=077kL5MZU7WX6i/bImLBZARcEUbJZaVGZ0YwyZ9BEoA=;
 b=p1t4KKY4qLRGhPsQqUk7kr657CyqqNGsvB+sAxfeujDwvMuVP148nRFbMVfYVMidd6WehRjRvznDPtgr9wTC57doaG0cHQjaxJQhm5Wg/gQFr+YHQQcVW7bP7+qN5JL+vvr3A8jsDaQiq0U2BLjLCCX8PPkL9sML0slL/vKr/wg=
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 03:20:43 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::85) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 03:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 03:20:43 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 8 Aug
 2022 22:20:40 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
Date: Tue, 9 Aug 2022 11:19:55 +0800
Message-ID: <20220809031956.3162090-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40e8def-c565-4045-8691-08da79b624b8
X-MS-TrafficTypeDiagnostic: SN7PR12MB6714:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfDXVFBF3QVgAXUe5HDJDl9VK29L4CkBkBTJ7H+Kq50QNM5E4wzB3DW04waAcvdXO2sO9roTVsdGA6uSf9nSkB2wIqWn7/+r4zJwi5L0H2SAegc3c2w+j9mRMz5KkoEtO6FepdhnkAUzKwr2qbofYYH1IOrPX1nQRiHIhGsasQmh8ZU+FGUANR72K5kpRXDLOE8NPRvrKyQFdHNJsjofvP6wRb5EBl+D/oVhZaxBcslfoRItLA44Pu7Xvc73gl0kbc9lpq8s0yA3IrrIOjOI/znt5hntDVgyfuD/GgG12jICuDNu2Mm4i7pxWkrU9VpfGvmLBX8U33rHuL9zwKWE3es5mhccgox1OiBjy74bDN+YOMSGaRQ7gk0020etxhTyGAlDyyPkFumr3nQf11wACLx/f/0z6s+sC9nDn+D3/tVjealhnsWq6D3uwggsHHvETYgdUq5Dt33BgKIIV1i2dJaUu8gATDo4oN+5ctx8ck4bZJRvkpjfJ2MuGpH9avb5G6m6puQgtLIcdJL1bLXp8RDk8nyaPAgQWCmzXesr7Q5YOR14MuSmzXUUX7dLA2nVZYGt0ubQRwqTJnxtjuH3b/orUvvadQpakx9Nj4DHBzUcOSrE72ykxEwAA4iXk84S8Z1dFLiIL90daHfXX2ZGf3hzFb+PUdGedDne+GHlaQpO6VRXUP//rolypeAZtFFsCCOSlMES7Fnh7Hw3WA/8Q5h7kyOWCAupqieV2YF44CyoIXPxZkKfoKu6EfVGxfY5GNjLB8TIXAZf69oP/xn7VKxXf0wCjJLpUqNsyxIqbhgb4vEe6OeU1lYtwzW4m4sCe5btlYI88Puc46JQ/CZwkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(36756003)(336012)(83380400001)(26005)(2616005)(1076003)(186003)(4326008)(86362001)(426003)(316002)(16526019)(41300700001)(7696005)(6666004)(2906002)(6916009)(47076005)(40460700003)(478600001)(36860700001)(70206006)(44832011)(40480700001)(5660300002)(54906003)(70586007)(8676002)(82740400003)(356005)(81166007)(82310400005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 03:20:43.2334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40e8def-c565-4045-8691-08da79b624b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GFX Power Gating control for GC IP v11.0.1.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e03618803a1c..158d87e6805d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -53,6 +53,7 @@
 #define GFX11_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
+#define RLC_PG_DELAY_3_DEFAULT_GC_11_0_1	0x1388
 
 #define regCGTT_WD_CLK_CTRL		0x5086
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
@@ -5279,6 +5280,38 @@ static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
 	.update_spm_vmid = gfx_v11_0_update_spm_vmid,
 };
 
+static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
+{
+	u32 data = RREG32_SOC15(GC, 0, regRLC_PG_CNTL);
+
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
+		data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+	else
+		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
+
+	WREG32_SOC15(GC, 0, regRLC_PG_CNTL, data);
+
+	// Program RLC_PG_DELAY3 for CGPG hysteresis
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
+		switch (adev->ip_versions[GC_HWIP][0]) {
+		case IP_VERSION(11, 0, 1):
+			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void gfx_v11_cntl_pg(struct amdgpu_device *adev, bool enable)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev);
+
+	gfx_v11_cntl_power_gating(adev, enable);
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev);
+}
+
 static int gfx_v11_0_set_powergating_state(void *handle,
 					   enum amd_powergating_state state)
 {
@@ -5293,6 +5326,11 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 	case IP_VERSION(11, 0, 2):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
+	case IP_VERSION(11, 0, 1):
+		gfx_v11_cntl_pg(adev, enable);
+		/* TODO: Enable this when GFXOFF is ready */
+		// amdgpu_gfx_off_ctrl(adev, enable);
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

