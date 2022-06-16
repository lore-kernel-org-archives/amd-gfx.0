Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518F5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B20810EBCC;
	Thu, 16 Jun 2022 21:12:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CC510EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4qtfzuhRQBw8COxfb/JXG7y1sq/iESK2r9mK9dMpdGZBr1bDuTEw1p6iwH0z2B+RgKEtzjzC2r7oW0BXLrkcykbjImvvuU7z4xNtomK1bMONQq3BnKg3l7yCiWwE2hLUkcQPEQzj7jJwhyBtyKYtlEFFvXQ8ghHw1Yiz540XxD5aUGSPCljHS95UhjU4vB+0qERX/IR0Q9Kb42vxTPKnIImvhHggFu2uvW1utds5VQ5082UbqgM6EoM7c9/KFDidqSxP52htLi+PQ+crTn5R+WABudTrpvvaCC5F1XhXlzw/216t3eoA/tK7e+wO0sFK943btzLz2LEQfxUMYZQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFrWvE+VBAhSaGRSz/69qMe+dmk1f0KNSC5O5jnM65A=;
 b=mRWMnLfAsfsDAMqM/NdNUk4+s9eKa/vHwJhS5TJ4Kr+XAWH42ff6vr1T7PmH0lhQk5e2ZrJl+8+MpsaGPPSuU4F4yAAY/ewnJF1yEgfHKBjj5/OeFX1YofCPQyURDF/JgApMu8EUsq75HW1X91RtGGz9XthVbRpbZacdfx6iV8+3L96EIUJB7Ror4NSTh4szKBJXJmyl65UTZI5ZbIMdF1eIXCm2h4f4vLQAP9A1l1J3qPM2ARcNxi5YRcyAJn7AwzMA9Bsnox2fdEgbPQ1184oATDQXgmqIlvz2L8EuMogmL4Yc8hr4iD9QEnd8gc2dl96D7iMbxsZpTcGEDyKRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFrWvE+VBAhSaGRSz/69qMe+dmk1f0KNSC5O5jnM65A=;
 b=iDzjzJVuQnM+jDur1ArA8+XEOwLOtVeD7wsRC7ikeFawn3OkQOjFRS+yd3oIfCJHfedGpcrWeA1hSy6styPEhz4jFvTAYj0XQVtCAVzwgfCg7G5XyxH7yO+mMfKO3rRn3uTcJsNUUcBSKXd7xqsN+BlC35RnG2Xcc6+kcET1a3Q=
Received: from DS7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::23) by
 DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.15; Thu, 16 Jun 2022 21:12:52 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::7d) by DS7P222CA0006.outlook.office365.com
 (2603:10b6:8:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Thu, 16 Jun 2022 21:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 21:12:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 16:12:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix adev variable used in
 amdgpu_device_gpu_recover()
Date: Thu, 16 Jun 2022 17:12:38 -0400
Message-ID: <20220616211238.669152-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6198789c-cea8-4478-32f9-08da4fdcf969
X-MS-TrafficTypeDiagnostic: DS7PR12MB6024:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB602404A4F76B4AC1DD3EF7ECF7AC9@DS7PR12MB6024.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cEIJwkCjlGtK3zm2hQdVoIcb9iRP0o/DCa52+jBCAczqhgM7N2OtwlmlDOn9CjAp1FGj0FfGnJKvrfv5MdqT5NxbzJ9RXY170/8qqTFFU+t3SZ+YGSE1Sun/UBuBqrPNpnTTi7SH8eyrdaPQHAkaQHvEDr0i9BhYy/+RuBQYXZiflIh3cXejsu4HxsqzxotLPUCR2vutGKgIJV7MtQGz8bqr7a8WDS1C5t91kLAH/qKUOazz1y/Aw9DuUTTYNjpmDYUiyPzu84GHnROOrr1dbKTWr8wUUnJlwuoYah7stXbUPksp/s29bmcECzruIlzkrCGL2wjEUnrWkLtPa9+RmBXn0yzHIIVHoOePOXPf1oIu2fCbkv9i/wiv3J85xZIJsGkPRjlCyX1aKiP8K1AMlcIYjXkigWTVnlNeVCzVA+TLFgqa+Bh7xg4Q/TWHUnUTilyQyGVxUaB89JA1OQms5YBK3WLAymGk/x7McpBv4PpgxX/kI+5HciqCprGEgVYNxSnFFBu5dqqLGjLSWsgsy1v50mUDrslGxPmHqJae5Kb8oYbr4xTdCpnQ6Cg0SQ/Atj1cJCtNWI2+bWkh/4ossIUWr1ExpeSWHsA0c3oBRpxmsy1kLdZgvWTlnvzBCywBTE06kjKpIjdmuOVLzp+frxx0z70AoBRU+NHKAuIL6Pu3ULsWQQ3yPZj9rwKdMAvl+sX0sVd8we1T9cVrwvf/XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(336012)(426003)(47076005)(8676002)(4326008)(36860700001)(86362001)(316002)(6666004)(70586007)(81166007)(7696005)(70206006)(26005)(356005)(508600001)(6916009)(186003)(4744005)(82310400005)(36756003)(2906002)(83380400001)(40460700003)(16526019)(2616005)(1076003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:12:52.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6198789c-cea8-4478-32f9-08da4fdcf969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
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

Use the correct adev variable for the drm_fb_helper in
amdgpu_device_gpu_recover().  Noticed by inspection.

Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b92281dd0c1..eacecc672a4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5186,7 +5186,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		 */
 		amdgpu_unregister_gpu_instance(tmp_adev);
 
-		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
+		drm_fb_helper_set_suspend_unlocked(adev_to_drm(tmp_adev)->fb_helper, true);
 
 		/* disable ras on ALL IPs */
 		if (!need_emergency_restart &&
-- 
2.35.3

