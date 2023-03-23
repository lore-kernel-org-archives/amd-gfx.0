Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E325BC761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 21:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A69C10EB4C;
	Thu, 23 Mar 2023 21:41:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D72210EB33
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 21:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmdIhChIhexDjYXm+JFIW1hj/FwcoaBhd7Bz81HbZLRn+T1MuRsF5h+aZS6OGKzRc3S6QfrY2UGXGx2fuLUidcmPs1owlv9hPJunWCouoxIdvo92cHYUUv/3lYu/uqdop1bL+03BN7UPuZLr6EZ6KvkL5ganlvwQ5zViVDl+SR3wuK0nMgCNEOoAaXR2cB0UybhA/QyI+9Ca298ahHMDtFm8PGLGC1sr2qqVZvJmchQhzhtGo9X5HQtUGEMoh2AEiqoDyYcaJN0huM0cO6kQkwCvTEk/i1spZWiqp6QeH/jRdEK1FelimOl134hYYee1PvawKCzrr2ikafZ8/DivqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHJuJPaG0CoiXT3+wQIZsE58JX0gpCz8WLzPj/MTGWQ=;
 b=TlLv84CxnWtDXVaOPNroxgW+cZge3rwA4Mnx9GhDPWYZfTKqYBqM3H8A121IUDthUkALmPJgetVfV9XBCwuYDEqiGQvuC4yrnIqsevKxjKwkEpPfhaGfbMsz0je4bzCUomexYfGzuo1T9MUyxEdgtIaCB5doxomW3jyhPNNG5J7h/dMXPEp2FUgdg+82ijI246hMEm8zThiAjxfY7STEJ4ZWC3YExao6cQqcRvS/9kpPTvWJdgpYsp4s/YFiaoh6BzvrVhvplHZeXUUyHUXjm5mPrkMlpb3D9+tlTF1DzFuWqC8MCb9gqAbJejdrKNzzAt31IK60Mnv9VUhz+RfGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHJuJPaG0CoiXT3+wQIZsE58JX0gpCz8WLzPj/MTGWQ=;
 b=03pqEibR8mOjGv3pM9w1woeYtWSnOWVB1M3EqmtoAszPYh256oCdEUlHhZ+d3VPZth9itYK8g/pn/kuROLjQPwyeKDQxnYN/fiVo9i6V89B2zx298xntgPeIaK7nfyH/+7KUW3TuN+5hdsLNZkCFqvHCCEFPkXx4T9s+mjCU+Yk=
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 21:40:53 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::1d) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 21:40:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:40:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for gfx11
Date: Thu, 23 Mar 2023 17:40:30 -0400
Message-ID: <20230323214034.1169310-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323214034.1169310-1-alexander.deucher@amd.com>
References: <20230323214034.1169310-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: f359f604-482a-4122-c423-08db2be74770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mbLT9v5CgWCjAKvfMQSMiUoa80IoXzqH2NA0ZAm2iTCTxfNbT09NCw2upnm3P8e+yByy3L76jdbTB8b3qDBush1ijFt/hvtM9m8a3Mm/pv7ghw/0FMC4AvcSVhzP8Wl66PkdJFy0nEDBvllUEdBcRK/biWIG/EMeS0HHJpjZeLwqJcIgMMT7U0X8AW/xkPZXTFogLF5QPokqhbFX7CZWQY9s1Eojem5D5EOd+Mg8uCXHZm1qDc3s/BJEvRRPZCSybBrv8dxLbiekjiqNsy7R7XQehWpK4jMwGN2TJovRYGDIxio7a9U9oFvHh8HUvxtSo9u8uA+5AOxeY0lKBSrdbEx9GgrcYKjyTqtKcEfQHfCn62qPFEB4M07GO3Ed8Q/fADNpBBk3OnFrnW3NTkldtFFrgq3rt1RxLI+dMBUQ6TiyGrwCKHxCtDTbSc4Q4Uj10FJQwPE7Z5uDa3hfaafvjA1CfpJGmOEAY/inUVl0L5vXFaU7T57Y8DLdJEUMh8pAc4mJLeW1Pw5Fsxat7u0vFmyyRN9iP98/aFAyAcjtprQW3iOKpvL3bMGSlsidIE50h4oXIkarJJa1vwsSW+huoZTSSHp4YNmQHBkniUPj9ls22qdXV2cwf3WfBUcBy6Orw3M2jib7nFJ3SrpybOmpy8eul/Z/rkMK2oN64e7Q4MOSQzjYLgR/dwK8ihOf/+XZO4jzxRTFpl3FP1QstzdxyNemyI89yP7UWg/KXdDxDc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(6916009)(70586007)(70206006)(8676002)(4326008)(36860700001)(316002)(41300700001)(8936002)(82740400003)(5660300002)(47076005)(426003)(26005)(81166007)(1076003)(6666004)(336012)(186003)(2616005)(16526019)(83380400001)(478600001)(82310400005)(7696005)(86362001)(36756003)(40480700001)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:40:53.8288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f359f604-482a-4122-c423-08db2be74770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to get the size and alignment requirements for
the gfx shadow buffer for preemption.

v2: use FW version check to determine whether to
    return a valid size here
    return an error if not supported (Alex)
v3: drop GDS (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1fc1e941f7df..df2eabf50e6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -822,6 +822,30 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	if (shadow_info) {
+		if (adev->gfx.cp_gfx_shadow) {
+			shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+			shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+			shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+			shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+			return 0;
+		} else {
+			memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+			return -ENOTSUPP;
+		}
+	}
+	return -EINVAL;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -830,6 +854,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.39.2

