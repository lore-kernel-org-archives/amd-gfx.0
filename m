Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D755EC77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 09:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A2310E209;
	Thu, 11 May 2023 09:29:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA7C10E209
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 09:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0LHd6Mt3WmO100oqTaHoaeUdawzCWGYRRxanVXsjTIE6q+7O/JKnl73VIkYImJ7kkRpSaKpngO9gIM2YuVK9pzgGeJ8g2yqiN5EnNc9lYv9v1QpOVcwU6y1Wd5lGR4q82GjS4Wq1fBhhq1z0vwX8iYxK/x/FLTwsrwPaSiQy/cc4xCUAQLgZpKSgrs5avh6InEVRh9F/bc1fOi76VsmOCT6KCfXxbTXqOpXvNrAd7Poff8d9fbptJSFidICGz+5/qprwYcLqHAol485BdU04MlZO96UZoj/AWCMU6EGdCh0rV45Jg+BgRJKfrdr1EfMNaeGxTTSQOupA5TcxVbyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5zoZL8P8cPemqS1F+GJgcWnL3TzsOjK4VTicN8R5co=;
 b=kCrJV4Z6bnEEQGWUFF9NmfijMrmlvRZHutkVTKVwKaadoYByA5Naqqu2fUB+KMw/7tkPYDTuM2vbDdHG4i+WrrTZnRqMpFVi9CB2LH8eGhB7wp8H+/6jmYGHWwafIYqgle5+72mkcg2Iq6jdxmOiJNzC/L8bPYXJwjI401qUVtGLT5melygM18PcxMgT7067/mhi7KI0J3oTT2aaNbw7Rt2BK50H3v9Io7qfxvPYwdMJ43NqBHFQyQERm8e/o0fR5FIpBLzetHcxCb7jq0awlb3+x3XCoyRX7r0VJimM525hoyNdHH3jV5XtEja9BaaE8ql5PYjVIcIC/7hayMAOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5zoZL8P8cPemqS1F+GJgcWnL3TzsOjK4VTicN8R5co=;
 b=vueM1yqEosF5ZmqSwle8+Yb0dUcCaAgieLIBTodpCXDHcf86Mbks6V16ei/rhkaL5UAUyG0ZCB63Ri4X7M1JtWh69C+wfcfAHyNPxvUGcTX/DR4XaBAaFefKydaxB1CVN4SFsAWUZ/tNcYqgmzAb4SdDy5SvWcHjsfAM7iAukA4=
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 09:29:42 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::8b) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 09:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 09:29:40 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 04:29:37 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add entity error check in amdgpu_ctx_get_entity
Date: Thu, 11 May 2023 17:29:20 +0800
Message-ID: <20230511092920.3039185-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT006:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbd1216-3e25-461e-0373-08db52023f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZ0QIqhtr+N4nrvGTSCdQ78g6DijyDoDcL9ZThkM7Km1lt4a9N3pXx50565hh8NQNmfa2odBdavJyG0emu0fddcAuMihVxMznSDWUB6kyy2glV7fyeL54mwjC0uvVq3gDI+tNLKF/+yXo9+zxJYtkBJHl5o3nsiAMQYUng1J7yPWrhm4252uNYcj7k6o9R8To4thXpJ0wJMCLKigC2OX74eKrBTOBwzR+hyFlcWLrgIDZhSBPJkLPJOBplueUZ1pwpBUh7DJsya+1/iVkTvF5k9UgkLKWQIYiVIUzOC9diwJYI8r0W94p9q/kz1HIAWyLKuqAIt7nomy90+5Yk0PwscxNbTFsiywt9bcTdOBpPeTLg17RjLcBFww7heDjSYXOX/aqXpWFb7dcv2XPgxD5PQVozfJ/rEDXQyUF6AzTNNpO/rWaKy6krBralJ2+eiwQ79buKs5MpyCkPTOCxDh/mwOc3Mt/RTdWG4sVpwODWmGyf3Pm0ciAeZIS5eSAxH73pKelbWJ1Assw2PA7mXyIYe/NM9izFzYopNlZHTLHK2mtm32KOnD2EAmmVotkTTaRvdsdWI6sEL0kkrGquZ/EJ9WdTfw4w3t5GZ/tF06enoGs7AKmUDSdrZOQyD5UZTcdSBwh8dwdfsSCNZmXAvrW2DFS1JSzSLsPQDUt24Q24uWggjhj7dkKrPj/HE2MRj/EOtCSinNLm6swXRQOCB/TWBDV0EQ6mhNSGxTHRkyuxYPW4NsaRkKrxuNQM5yp0xNOMZUFC1LP6UQ6zweOJrFtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(336012)(2616005)(426003)(47076005)(40480700001)(86362001)(83380400001)(40460700003)(82310400005)(478600001)(36756003)(8936002)(8676002)(316002)(5660300002)(4326008)(2906002)(54906003)(70206006)(41300700001)(6916009)(70586007)(16526019)(186003)(1076003)(26005)(6666004)(7696005)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:29:40.3142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbd1216-3e25-461e-0373-08db52023f11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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
Cc: Alexander.Deucher@amd.com, ZhenGuo Yin <zhenguo.yin@amd.com>,
 Christian.Koenig@amd.com, Monk.Liu@amd.com, jingwen.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
UMD is not aware of entity error, and will keep submitting jobs
into the error entity.

[How]
Add entity error check when getting entity from ctx.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e3d047663d61..077e010e29d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -417,6 +417,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 			  u32 ring, struct drm_sched_entity **entity)
 {
 	int r;
+	struct drm_sched_entity *ctx_entity;
 
 	if (hw_ip >= AMDGPU_HW_IP_NUM) {
 		DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
@@ -440,7 +441,14 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 			return r;
 	}
 
-	*entity = &ctx->entities[hw_ip][ring]->entity;
+	ctx_entity = &ctx->entities[hw_ip][ring]->entity;
+	r = drm_sched_entity_error(ctx_entity);
+	if (r) {
+		DRM_DEBUG("error entity %p\n", ctx_entity);
+		return r;
+	}
+
+	*entity = ctx_entity;
 	return 0;
 }
 
-- 
2.35.1

