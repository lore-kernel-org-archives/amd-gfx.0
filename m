Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D151C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 10:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A8692A18;
	Mon, 25 Jul 2022 10:13:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317A78E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 10:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arFNXNwTi7lbSIV27G+DZ8HbVKwE4O05Mfjzv4KJr2C6xa0keUYY4H7Y92AUxGa4idwIeJbsruEStYhiW9Mzk8+jwBXfwdDamcekBTeR9endBvJkerni0meM0dbesePnidSViodDmWAL9oqSNSBPMwO6/QUDEMmEnIKjkMXgWz0WbvIytoiZrw74Mq0EWvF5X6yFVdoEX+p3yjcNmKod9imZFZoJFhbczFHC8sIdutYe+ZiHeUIMtSVbwLaIo84TIFSDNCUVWaG2V55FI2Tqw4A8/3eq/LB6EXJMKvnymfA7iDtvtyVBdvCpXxvOquCq7qUuYwZ7gPgvEJC/Cv14GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0mxxCsqi2WB8TNse/4KA3FmJCb2rNJ7iuHMaojnVJM=;
 b=ctRMvnTPCdBrEh7rUxqV5q8opPpufL9QsSMwNHegjdQYuh7pWAFzY7dL3hdS+bJ5fxCb74LAegeqNaRC6Qt9zCS3hNSpmAZCFSzVAkFyX4rJTffNyfPT6YlQggjhCECM/ZC3LDGvnYjTtsQNI4C0qgRA4Quzq+DI3u00KrJ30mknzo+Ypm2X8rhrL/dG0wlS2S+nVLSdGjUXAbTJnQRzs5GZyuRF8htOTmm7TQ0XuQcnjFRYKOva22Un8LQr3YFxXtuBv53vQS6LJByuwxqauyUJFS/ou/2Hv8GmVngwhG0XVfAJQiVADiZBaqSS7vsR3tJ7Y1habhE8qv0hjbP/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0mxxCsqi2WB8TNse/4KA3FmJCb2rNJ7iuHMaojnVJM=;
 b=zUx6Ob4Q6e9QMq12UdHe66yS91idNKaXS95v//bFCZFY1e+KsO35AmzrpnKNavJJlBma2armxD3dryT7XIasIctTOCamcrBpe25a5KbmNs2dLqWUDv6tsHeD/naPOKALu0fBXDioed10QQ9S7YIlK2XEQj0cgLnHYiCzFTTYGKA=
Received: from BN0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:408:e7::30)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Mon, 25 Jul
 2022 10:13:18 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::13) by BN0PR03CA0055.outlook.office365.com
 (2603:10b6:408:e7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Mon, 25 Jul 2022 10:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 10:13:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 05:13:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 03:13:17 -0700
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 25 Jul 2022 05:13:14 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: add a compute pipe reset for RS64
Date: Mon, 25 Jul 2022 18:13:00 +0800
Message-ID: <20220725101303.9474-3-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9350d6d0-1242-4c1a-be4c-08da6e264b84
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMX7WMS8+GQWxeNmw3hTgQXT7TPZNaQxnRzsNnoSVx2/nZMjaWauhAQmFKjMjLoi8T12vvlnC7JsWf1YRi1s/zMOQ2iS83BzTuHgJbSe1TDFD05fT634emptaxBJ0wAeUC08mQ0Gqi4uTvFFh0PhsvraUOko93pLv7xkJmlZQoOnsNk2ChxtrCXhAdk5i2QEpKuOzC009a32CmtgRypT5BJXEJUqLltzZDGgyLkA4Kerth9F36YAUNwqnWL7slVVPQ3TFx8y1+32P2UZ8m2/tX4apKGk2s/PFuhMkisY8d+Qkaugq9T3wYtnkddK+KeCp18ary4WiiZN8sa819VMQHpYWxrsAHDRlpBH5RkpT/DRUInO/2rEGIuImH1hhtAK3OlDyjQ3V7Y2CPqg+ayr2X0Omx3vtdx+QqCDXPvm3u45CS1LG4HmDChBB0axIQ3p6RUikpTvXe39LihtDCwpEhKF/F+aX6NFPq0Dj/kpqlvymgXkXnRuvLKuBwlmOlZpOmLXbmD9vPeHJHXGAAUtBRRVl1hCl+SMsZfkg7xwnBW0FhjTOgDGQTJeVEphKoqod1O7zd6IMD8cktFYvIXTO7eqQPD/eyTVvrq7ciQzMW4X3Doj9E/0WWTCq6IR1BNuTUa2X+xYmHmgtCYnszTm8SJjmdOPuDS4GFW5i0l7vyqhTi1TliLiRA+6VgCcSkhuspaQZQ9QqEOgKRewC5YMychBG4aYhD4hAceDK4PfcYcoNfF51zyIBQUFm6brDUwVJZ3atopHCmLGSbblKtCMElU9kbhYba/Bgvd8lzKrQD7Rrs+r7tcdDOQOfLOZRJG8Ysq3nOoKju2Z9s+egYzd1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(40470700004)(36840700001)(5660300002)(2616005)(8936002)(478600001)(86362001)(7696005)(26005)(44832011)(2906002)(41300700001)(356005)(82310400005)(6666004)(82740400003)(40480700001)(186003)(426003)(336012)(47076005)(40460700003)(36860700001)(1076003)(6916009)(4326008)(8676002)(316002)(70586007)(70206006)(54906003)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:13:17.9899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9350d6d0-1242-4c1a-be4c-08da6e264b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Under SR-IOV, we are not sure whether pipe status is
good or not when doing initialization. The compute engine
maybe fail to bringup if pipe status is bad.

[How]
Do an RS64 pipe reset for MEC before we do initialization.
Also apply to bare-metal.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d8193b30fc5..75556370028e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2754,6 +2754,21 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu_device *adev)
 					mec_hdr->ucode_start_addr_hi >> 2);
 	}
 	soc21_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset mec pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+
+	/* clear mec pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
 }
 
 static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
-- 
2.25.1

