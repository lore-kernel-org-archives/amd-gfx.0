Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEECC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 08:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0656E10E67B;
	Thu, 10 Nov 2022 08:43:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186E410E67B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 08:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTQbdEEmRj2G7xDBZ9JnbPFHoxnCW32K8chweGt7kOJziuX9gL35gLx2cGh6AbV/wEU+iHOpBsjwQ/6Awy1sjgPBLtVk4sN2KBqHqM1WC77dcdckwEefqD7LycbX3nV9Q+KOtt3zQqsuvuKR7nZqZUzhtjIDp70qCGqtN2HkZleY4gjnZrNvusFZ19iOZTItdqstUq7oV47uQkhABCaWspxDmGYitXG6oztvj5S7bHZMzmbTZAEmzLeFQzXBZ7YHBDMYp8urrCa708elyoDO58VspKok0vEGFIRV2U+cB0ucpnoifOP/CPaOOm7j0VnBPxps8pGfBKDKo7u8xboxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqtau9gbknz9voShM9PIDorgLS7dlWGNz/QDhNkqHBg=;
 b=W/9mKpsgi0U/B7RDI8557mltWMjrtPGwcjtRkBo4vjaSqU+waXz9LrfV6XZ44pgdFNmKraY0hZ4maEXv0ybgwfbXdFmgDTlMtx4e0tK95t6hsGR714+eqV3JbmHZazN2qp/0Y5/Tow15LoDTnsJAk6TY8wrCybmt0puzRi/+p2J1zQuyKafftcUNxA/nstOlQQjGUQouQG70RHYsEjnRxfKNpVYfw7IkWseYgSwfIcUr4WBHRa2q8gRGwQyKVGWbQfq55HYJPVl81OMdrR0u5ENaQ8Qppspq+KxArrvEI1A5Inayq3R/0EhHi14bGZGNLMdjfVj+dG7KE/df7HuyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqtau9gbknz9voShM9PIDorgLS7dlWGNz/QDhNkqHBg=;
 b=vqQOzi1aGQRvk0ABPphKsv1itO388OdAGPReAQ10+9Jsx0+IkdFfEh7P24zNTvzUlP2nntXaFULtVOPHcMciLjnA4Elwh+b7B4jmv4G2BB2phmElLhnnHyWWzTgmlD3iXpb8kA9g58YruwZLNYZW49nC+9pxvkBAxl0Px6V+N2c=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 08:43:25 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::16) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Thu, 10 Nov 2022 08:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 08:43:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 02:43:22 -0600
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Thu, 10 Nov 2022 02:43:09 -0600
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Stop clearing kiq position during unload
Date: Thu, 10 Nov 2022 16:42:41 +0800
Message-ID: <20221110084240.2949984-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT047:EE_|MW4PR12MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: d644c97e-0713-4d1e-263b-08dac2f7a0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxkXsgqsUMiyPwM5uhsSr8aVgSPvbuGDAABiG3uI5sKRZ44c6fCcAnmNiE54apNG6AA/TW6WnKFJtqd53Zxw9NLjmcxMc6a1aFWxtn4GO0NgvTKojb4aQr4+ZCbYfmqO25ol4mVNZATu0P5UZe3/0EY9iFlmclyWbYMY+8ICSWp0xsXsVTYLdTCRb5Ncv6DOlZdj8dyAcaKnCuPdkC8uqafq0CEdUEh7wfb2v74J93nZsTJq2Z1SKMch7hGFWO6/CeikcHraavM9LBxl7mEMy6q/p9t6Jh1kf+4cgWdsXFL97SsxS4Ny6WYHOskyfNjjRhssz4PM1TMUlBdW0uOh/FgCTFltFslbmnOeYOtdX3HJ8wTrZToH8rc2UdcVmcu/Wnn8aIR/ZcdVvoYGeqD13W3wPzg4woZg4BptlGXfiPZni26KrCJKo6mlwAd7K/f2VsMoIVxJKSfeoJ3fXiQAcU8nDw9qZWizsFRTtxs6WNM8jRZEXEC5a21fwgYGktY4kmWi1Vzjn87IiWeoiZEzX2rHsPz8GhL+64CX7Qwumi0jpmSSuti2JORc3NSIw7Mq0jti9W752+EK7wLYKrI1z2gpt7L4JzW2KTEInIsgw/+BEDuNxPVqAMuFNTDVcJWpDjfh8NXsndwo+XRYBAXAM4hFQCb+1uIzo/ZaVUG4Pc1fbOzWHUXlioLAzJgd+CI+tKN5vnWhwJKeslNlIMx6NCEr0Kf1GZq5PP4g+195vlikw5Xqqfm88ld1Lmu79SeStOuPv+4pPM6pTQRVryEWQ4y41tELe6F85KFDTz5QOsoXQiVrT6YdKAgLEvr74Ds3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(36756003)(81166007)(2906002)(6666004)(7696005)(40480700001)(2616005)(4326008)(8936002)(5660300002)(86362001)(8676002)(54906003)(36860700001)(6916009)(316002)(41300700001)(70206006)(40460700003)(70586007)(356005)(26005)(336012)(1076003)(83380400001)(186003)(47076005)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:43:23.4205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d644c97e-0713-4d1e-263b-08dac2f7a0ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not clear kiq position in RLC_CP_SCHEDULER so that CP could perform
IDLE-SAVE after VF fini. CPG also needs to be active in save command.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 14 ++++++--------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |  4 +++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 9447999a3a48..232ccd639184 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4411,15 +4411,13 @@ static int gfx_v11_0_hw_fini(void *handle)
 		amdgpu_mes_kiq_hw_fini(adev);
 	}
 
-	if (amdgpu_sriov_vf(adev)) {
-		gfx_v11_0_cp_gfx_enable(adev, false);
-		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
-		tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
-		tmp &= 0xffffff00;
-		WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
-
+	if (amdgpu_sriov_vf(adev))
+		/* Remove the steps disabling CPG and clearing KIQ position,
+		 * so that CP could perform IDLE-SAVE during switch.
+		 * Those steps were to avoid a DMAR error in gfx9 but it is not reproduced on gfx11.
+		 */
 		return 0;
-	}
+
 	gfx_v11_0_cp_enable(adev, false);
 	gfx_v11_0_enable_gui_idle_interrupt(adev, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 7bfe862aa83e..02ad84a1526a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1248,7 +1248,9 @@ static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev)
 	if (adev->mes.ring.sched.ready)
 		mes_v11_0_kiq_dequeue_sched(adev);
 
-	mes_v11_0_enable(adev, false);
+	if (!amdgpu_sriov_vf(adev))
+		mes_v11_0_enable(adev, false);
+
 	return 0;
 }
 
-- 
2.25.1

