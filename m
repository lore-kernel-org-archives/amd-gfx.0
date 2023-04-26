Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1E4C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 21:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8071C10EA3B;
	Wed, 26 Apr 2023 21:22:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39F710EA35
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 21:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEWoZE0/xm22d+INN8MJqoPY3uN4J4lVhwN9W8OdyQpacKu2109J0+kglX5XHqIKt12YB5XsKNoBSjNkfb3cki/LhlGXZUBUsHMEe5D2lszfttTtHgLG5cUIFWRWH2IKaLHboeRh1cDA4mFSIbBfmUP7gbr6a++ZfPOvwDaA5DXnpTMffRPoe0DiK7w+A8kRwKcCwN+9yr74ctYDTBtrMOzUxSKUTBZCZiMzPe5k/OqGDX+Bz6AX6FggJgprK88BsSXoUQHZsgs3EqnLLf6xSxhjRg0uo3J3dKvwStugnHVTuYqZJ7tDJqdChwdfjjJXVXatoJIkVbpGg4EBKTeGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LNx7E1Yjd9y6yzuTCzav5qvReFec8Bt19f4ubwkV7g=;
 b=T9XZh+48K6SPX4kg1Kl6yl2KtO2UYQJLRa6rd1cA2DeM9i3pTx+TVV0zd3h/ogW0EMlxYS96pS6OvxXOG9repI6db+KyAQm7bX0tSeq53K+9KpPGhvj7KRebrIyhKs8o2QLx1sx5iDU9OeIimkZvc7xd6o39HrzQpTpU3jdKVRfGaH4GsXhARPBCjv5kkeX1YckveFoqwFQi6KH2WJFZuCt/Ibwed8whvTzZbtq1d3PP83QXLd2m1W7+37wo+TyVSxyGpAet8zP1eYCrtM+B+XPikEoP1IDvK/5NkXCJtYKggYdMQ48Bxzr7EJUFmtgwYW2IWi57VhD9CruDM1awxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LNx7E1Yjd9y6yzuTCzav5qvReFec8Bt19f4ubwkV7g=;
 b=SSV3+gbJsTyVKOaJ8Iv+ajm5be/q86IZ+udx+8wDigwV8ZXRL8y6ir8+pod/vopYAsDmGLK4Tzefv/mBWI2BzIoWAR2/CE/GGsx4ac0g47ZsXl8bVfS1BLhqrDez86XE6P60E51ck+54tkBg+1cFLwIBhvqTqyHDy7yaAd3ONcY=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Wed, 26 Apr 2023 21:22:03 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::a) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Wed, 26 Apr 2023 21:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Wed, 26 Apr 2023 21:22:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 16:22:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdgpu/gfx10: drop unused variable
Date: Wed, 26 Apr 2023 17:21:37 -0400
Message-ID: <20230426212143.7696-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426212143.7696-1-alexander.deucher@amd.com>
References: <20230426212143.7696-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|DS7PR12MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 02406b10-e9e3-4bd9-c748-08db469c47a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UH9jOlnJNBiWBoc44ipKCIAphp5HI352BoWy7sL/LpbPL2LWPuwrtkHWpL6/YKNi6MXoXfSgnE0prDnEl5goO4rxMHZbp4FQz3gPRYaxpozkk7FsKZ5KAKbvzayXA9ZvXnuqoUJN5Dl1t14fUbuMS5/eCt3XyxzBzEjqdwCkpBo8WQ+X/D3qKRRD2IlyW9c57GpVWCzq3vD77uOudCCNBWYZIfXFkMIt68X918BvboNcSUcc8dcOkYh2mrTapRiYkArvowhC7/NueAcxP+8TA5qSIAV2h3PoqNVc29sFBU28JJt1zUrbIU2FqQQ7J0IgcDjsc92cRZ24SvOi9gEhqzz4tzxY0cYxk1XzODZ5BDC/4j6sBEi02qfVb6XVoTxoaFFp1AuROV834jgfI15jUYRncJaALs4WZ1Nnzwd4xZLMqdqsfoLGh1CFV8BII1mIFc9SEv8dT4qdKasBnZrSn6tDWSSTgtxOl8Z5b2defcHK5owxoEwTLguFMES/x8WLOByBSb63JkLy5mdhYw/alc0xfT9ebo2Xhi91W+IbyTbnTJDshyU7uBzuuwKupO6knUEGx9QEUG/PyyLB2+doAXkNYGoekZQ8SO6YhCImjCSoRbNLdplUV2xXE5VyQt8lUGLZ3SunqYkGOn2qU+5y/uoirpSlPuQl6PG4GOZq3YmAceLUimuoVC8a3r8DVmG7ka87dn5UFcxOsJIlUmwTULA6zj7i0ad+UwkU2rWBJrw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(83380400001)(36860700001)(2616005)(1076003)(26005)(7696005)(40480700001)(6666004)(70586007)(70206006)(186003)(16526019)(47076005)(426003)(336012)(81166007)(41300700001)(40460700003)(356005)(5660300002)(316002)(82740400003)(6916009)(4326008)(86362001)(4744005)(2906002)(8676002)(8936002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:22:03.3165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02406b10-e9e3-4bd9-c748-08db469c47a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
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

Just check the return value directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 24d7134228b0..5c67c91c4297 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7159,15 +7159,13 @@ static int gfx_v10_0_hw_init(void *handle)
 static int gfx_v10_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = amdgpu_gfx_disable_kgq(adev, 0);
-			if (r)
+			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
-- 
2.40.0

