Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F79AECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEC910EFD2;
	Mon, 29 Aug 2022 21:18:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FA110EFA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRxSquq8tSlg+g9jdL9gz8nciSJrQ9KT/4EwjR8+gp7/R6IYCrfbnrYo8nL07BGU41FqjqgWsvAEsd/oA7lvtEmYzFqBhdgpe6Pk7lOMjBcy+LVo5R7olKJ4huHiDK5tljE37GlPa8c/RWggBu4gUnpWinXKJyCs/FhT7FZnxWPqR1xwkFzYTUdPmkW7SH6Hl/Q3WsJGYfZhCeo2zdyA1mfFyq6f0kCqTSbjAe2kpZH7utHCv0vKD2dWdYOuZO0HuSvBWwrxa6dws6hpiScJI+H2S1ZJqtH/wauUBpgw95Oq4ECBSbQlOUoDRYS50LXbmQqLHa+6tdrw3rr7/oMhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+/47mQxEvxiqaWz1Xk45oyMWctV3Wq7T45iY0lbCUM=;
 b=i4UsG4LGIA9AQzX2CZMVi61tGNLevp4mmjEtKqaGWpNBRBkiqncbTLZTUK4QFaHLAX4bswPcqMQp5n+1vMvEwuwKmK5hsOkj8xcagNWomt4rk7jpMeraUrutmvofIJeJ2pAdsunQLpp8ZwYx5YZC5OFOhkF3wdXi8Y1pdH8LaACzijfhlFSy0+pamqeWww2xSgYTuT2S9bKn/CNA8Dm6tnIJNIaDoVh7SNAmFNAsfY3dJUmSR+JwlusBbrJGV1OaxJ5jbQxatJiF8BCNNFuu4ryvR1ekFgXs5a7FS8z2Bbk5PmOJJQpI3Cjb6ty1+66RVEio2Uv4PbU7t26t1/mVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+/47mQxEvxiqaWz1Xk45oyMWctV3Wq7T45iY0lbCUM=;
 b=ugIKhaS4QS6PZYfHa7V1Jh0G+dEn0yYivWK8v4B6kY5Sem7dsZJUpmgAnZAHLfoQjiMQhW8cptOgncS+9+6utbNa2H6T2sWJ5GqeNxQ+bS/o6bmRKOcvLdNgTJM55RHIfuiFXWv62abLOr03lf3rT5eHj38xDGy241sTAbt/dAs=
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Mon, 29 Aug 2022 21:18:26 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::bd) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: declare firmware for new GC 11.0.3
Date: Mon, 29 Aug 2022 17:17:49 -0400
Message-ID: <20220829211756.1152505-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205fe40c-2c56-48f1-da88-08da8a0402f1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5122:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVMH2NQrUvJEEoHHH330x3yJR/2JHCTPEWZvC9pMbq1JLV8RoNaqR86AM4vX8dKN++D82t/hoxHuwqghufstcBg2+rQtyD3B6Ibmra6B5LauibYY4Bst+CpOJ+EQj9CBnz5oBaehFS1fe2PMAbVqAr+wFFKYdzzxRzsEm99ryFGL3+KTyzYl/N0SxJrbXzEMkeRxvOHmCV7jocP7jnlbitbJdRmOnGt5X0CF86tFkqWplvD4DA0HlKwxXcw0QsQ1yx4VbMcEwdqeBVofICyhMzLop+zQHgAP1mAGMIhgoKDFr+vNGdXE1UEtwALL70VIzXDLkeS8RVC8ltNtD3HG04lsaIX47/rw5cpBYsUcnk5afDYzP8XghdM5HvKFX/kH67HoWh7sJN7sgr78RfAG4d0TKAhwGZbj75tBGVKCAJPNf9mmh/0GpzluqXFHopxOJz9Fkxuj4Je24DWyCuAt+cLsZQ18hTE/jpazNszKpz074hXPrssA1sKjM9MXNamUxnxCbTAT/Xzz4YzWMn9usMYwbYS55IQyltPaGkiiWt+AV2MzL053Z7S5xB30cxaJYHvbaX6cS/YMDoGc9JAlj7m1hf5G6OgAOjj0SZFAd8cAfc8vFwUUCNJh/68eUp8GWbFa/MV/nT+GiiJMZ52VzwC1AEsPzkJ72VFQXJymHUVMBhr2ZouqLfXjLjmMAkR9z8iNWBlpBE5vF2UlxzHR5bxml/PJMJPbro7iUj7bGqVuFtubV36bUhAkPzEaPIm1ZQ45C2SBTNtK1Qr8vRap/CD258MF7RwDa4N8h6f92Yk8KYfDpqK3garnk+7ULsQv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(40470700004)(186003)(426003)(336012)(16526019)(83380400001)(1076003)(47076005)(81166007)(356005)(70206006)(40480700001)(86362001)(36860700001)(70586007)(82740400003)(40460700003)(8676002)(2616005)(4326008)(36756003)(316002)(5660300002)(4744005)(8936002)(54906003)(2906002)(82310400005)(6916009)(478600001)(41300700001)(26005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:25.9159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 205fe40c-2c56-48f1-da88-08da8a0402f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To support new gfx ip block

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8d985004927b..8114953f1268 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -73,6 +73,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =
 {
-- 
2.37.1

