Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D8E936E9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C783710E3BF;
	Wed,  4 Oct 2023 21:21:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6224810E3BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvjvbB+wUvyZrOt4KhA3U8Y8Eq8Hy6Dqk7GqiYgxCqTA17+BeQsejI2rjOSjeB/cta2bpkMRxW7AyGRl0/OeZv3s/BWEepBRbKeFqSuq2fC9DNF+aREWApRNZR4cg9d2vyMKB2s7hhw1KHIF/exc6Ul1prQKD5IGsA5or6VdNrt4O8sVSi4amb+Jx2AejdW7FHs8wnO2u/KiTLypJ4dW4ZREBWPD1kgmhMyNEWwUtQAeKQObJWDJdQJ4+a5uUso8PJ58D40viAYUgmlY2n0ptMaR0Fz9GzGZ6GxfnrPsRRX0qZ8IsPBT0CswAZb/2LneOm5Cw4yV5Mlyjaky/v3FxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQiE7oX8PlDBWGE0sBMjkajtNSzxrTT6iZz1qKSwksE=;
 b=EuA4Z/CSz9/Z9TTm7t4mYTHcPJnazOMQTSosDhDy1tPRFMXwRYzP05fql9UuvO8ft8jwOTHscyme2NLyXMeCVtMKaSe9gMISYONZcBCKqkqGPtvfg6WlSbMKiuemANccJhxI+hL3wtW3p7Ax+3vnAwLvx0DXSth+2mQUFYOGB6/WYclkJVoU0rrktKw5FmMpsWXoGPrICTrLe+FdVgYkdOstWxvkfm0Q76C0+Zu/VTV2U1NtwmAoQkWcJlw4hDefyOBXx+B6LEAE8ysVtogy5rFXKq6cKcdTT0ktdQ50SVJKfwrJpjM+ijL2L1Zz6uXZqpGIVF/C1BUvvHlfsH0kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQiE7oX8PlDBWGE0sBMjkajtNSzxrTT6iZz1qKSwksE=;
 b=gEmkH4OS0+3cnn9FrdK9u1Nk4+Ek6SHyv93wWdq9JQQZ4WoRXQ7SFx5Zrzhza+tPUlXq8ruQ8UPiQuiIJV+bIRDPqCBLshfsuLX3El5cEWXr2ispYDIC1O+LlvD3YjbdeqRrhU4sDuEapi1scriYuBJ0b7WRKa259IwPbdzsuNM=
Received: from MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Wed, 4 Oct
 2023 21:21:43 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::f7) by MN2PR19CA0033.outlook.office365.com
 (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 04/16] drm/amd/display: Move dml code under
 CONFIG_DRM_AMD_DC_FP guard
Date: Wed, 4 Oct 2023 15:20:58 -0600
Message-ID: <20231004212110.3753955-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: bd774520-09e2-4704-a743-08dbc51fe879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsPycnfrepMcMtmol9GevAw+MgG6qEHesM770/op7ZI+NEzH5jdwRi9mp1JLXeoe+zw+fQ1BwxIWkZHjJ0eIA65dnzTybODa6hIdPHr5KImpZK0dWBVIR/r/ReoU3hk0V6JRPEbyFEqYmKv2iNISWwzj6q9bKeoJkMCasfALeSQZfQxLGcYUpMVkFBrxaqi/KWlVs7PZYsAqniL2IHy+siUhyV2oBhXhU4UTDmEAddx8xRjNzVMoKc4uV29AGosw7XaNXonEaEwATh5E+F6vEYcdYpKCN3SgM6Wcst1Up676MeyxQGJfGC7JQ26Z0AVKfaJYba/TJrYtK9yHghI1koCAaYVToHACgUCg70o94pNcA3jfckrY0pQa7ZYJ69M12QuK6HUH5ET8COScH6/E4Z27mzBZJyiIpmX1Yj6nBM+tZKKm6gMMPrFZL9UlvQF3Qf5zqYHw8y/8OjFHtSjwM2CpuSAcbc7uYGOljLZ3Hd1j2O+bqbx8FgeqB0PFUcC5jCEvAxaVupUH7h0Ies9aoaB9+NqfrRhHKodrkdj9YmXbu0ZvRkLcgIrZdRT/dqfoTQGDLnMKpOWxBFmqHjtEJo0xj4Q0sf+Cnn3sfKJC8cYkIvfNixBzWglR+2Gi2r4hMJK2HwZf5UFxwwkqNrAN5aJH+kB5WOwQmOb/sEQfORgMXNpXmq+p9a40loVSmaOhDUmwN5jSBEQu4ouEYN3ASU2o2zPyfKfSHmJ8M8O3eHZ25G3ehBI0EHLTlUX/LI6ToXDUqrMRkwELToc0PF1Y8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(16526019)(2906002)(4744005)(5660300002)(8936002)(26005)(8676002)(2616005)(41300700001)(1076003)(316002)(40480700001)(54906003)(36756003)(70206006)(6916009)(70586007)(4326008)(40460700003)(6666004)(83380400001)(356005)(478600001)(36860700001)(336012)(426003)(82740400003)(81166007)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:43.7533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd774520-09e2-4704-a743-08dbc51fe879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For some reason, the dml code is not guarded under CONFIG_DRM_AMD_DC_FP
in the Makefile. This commit moves the dml code under the DC_FP guard.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 2f3d9602b7a0..dafa34bc2782 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual dsc
+DC_LIBS = basics bios clk_mgr dce gpio irq link virtual dsc
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
@@ -43,6 +43,7 @@ DC_LIBS += dcn316
 DC_LIBS += dcn32
 DC_LIBS += dcn321
 DC_LIBS += dcn35
+DC_LIBS += dml
 endif
 
 DC_LIBS += dce120
-- 
2.40.1

