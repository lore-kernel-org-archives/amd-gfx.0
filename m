Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AFDC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 15:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A2010E981;
	Thu, 14 Dec 2023 15:47:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7B10E96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 15:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAdofFR+qzxLQtuUsrdER2kk2jZp1hhS/uJjMvb7TV/K7b8dxjoGs4HN/HNjnsEJvrYNi4usiuMDByEHi1m/dZ6/SRTJ4q1/gZ5vHQvLX7UbcZJj3Z+cB/nQfz0e47VhnjceExIteMe9XPwq6kNBFJ4bEuq9NyGVQWz0GQvyEJ8zDV90qoGHbJMCEvUouN+PJBasZtndRjmKNgnCjsAH6u2hBlZjArV+f62VFJMD4/2JoqdHMLyrUz1JD2EwiYAJ1K8XPyQlBhQ+naK4OeLLDy4d6Z97mk1roHS6O3ZYKxQOQ5etRBR+HMkJbM+hsiZO7YehDdp/xBvBtG4AAq84Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zeLd8aScdm2SUdnYQfFetpzU5DSaViZZcrgKgA4gHQ=;
 b=WcmHOsFAY0TwsSAg6K3ZOyofKROdWd77ay7Se/TKCkDoZriaQJ2Yq8aQrxFq55ckDwr9qIHVos+A45QIMzsXFZZwYbecyeXBXnXVpEAXV9TYloVPySHxKIjIQ4jppBWhGM+0GJUaUMkORpPwtPmLD9/yQiKzzKbrXpxo37HyXIZzLzMq8f5Ci26jms0gWZAWZwuqreqPlkJInFXyACsyQh5e4aXJfGAdxcxKbvvSHBeDdat1A0o+ytcVAPGuLA74SMq6cCOxbgxyoHMF7GqCHn7D34dcNuhPI+69JEvfqrZNoFOuk2i8Tf09057WTcaBnO73pNWwmWAElVdHOEhtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zeLd8aScdm2SUdnYQfFetpzU5DSaViZZcrgKgA4gHQ=;
 b=az1nk9w7xLSGnDl4hTQ7MJfZENYrv5tHYl8PNULn7X7lwppFrjZ5U5oIcsNtnV1fzcwJwab3ZAJEO2v3pJbc3KFbAFFETE2oj7MyM4kteC/qb9LbHMRJduYQijYZitCRsgLBsDhRTx4HpK+UDgrCy/1UCdvfcr+RHCdOFKzkRgw=
Received: from BYAPR05CA0051.namprd05.prod.outlook.com (2603:10b6:a03:74::28)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 15:47:19 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::3e) by BYAPR05CA0051.outlook.office365.com
 (2603:10b6:a03:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.9 via Frontend
 Transport; Thu, 14 Dec 2023 15:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 15:47:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 09:47:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix documentation for
 amdgpu_dm_verify_lut3d_size()
Date: Thu, 14 Dec 2023 10:46:46 -0500
Message-ID: <20231214154646.651468-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c231bd2-93e2-42c1-a053-08dbfcbbf431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OsrR06HEFSTSappDOl8m7eq+iz1Ab192MzdKCKHx0zQo/s9UvQxbmtahnvpkqHeBx0b9xDjY18nzJqc3oTbN9GNgdEouPlbuL8XtN7mNbBYC7zXKH9ljXYLkhIjlNhVcdFPoIOqOVg0zu6M0MtQjXDFe9ttXdqdUYhjYfprfYTbs4iiKAtbAt1X+7ZU9Dxstxjan0XvEjyXEwGejM6v496l6+3Kwpin2LRlWlbzSMeuCjEphJUX1vq+xENi8mZXzw2rflngkoMFSFv86OSKJibHYYjYGSxYkhLDeF/DR7fqNOlGSXdTbOQUlP10oIXLFpaa2AJ7aEnnTtDsrsuDNAedonEngDH3yPVyeLDzouaDZ3L/mVaLeuQe+UZDalBzxZHUcTrvthHJGJIFNfvgTHbiamuyLW3bCedrh8FfC9g2J8Y/uoh1hNaahVZlKkXTTws/zh8Lk+afIRdy/24/Z52/bBlrRLpcwLqods3ONMo7aLCYEIi+87okdinx5v0LDoD7yGWLoGphOAitAFfzfMhklZscj9yoftyLeabo9EKwA2XlTFe7P7lQW1K1HhKCKRGbeD3NjjAKMT9GIZaDkSPUpvcPEzwANdkv2vp/cocrnqK/nbYY+mQAYaPcfHN5p9zyMUl6f3R1zZ8vJUeU9HNH2OAYqc7H+DMffIBaTmW98q9YslCo3pzTL947E0yJmUVP32PvDUyZbUxFx0JuLKzY499Akk5OpRDrNOUEGc0Nt78FDb93u61m0pHMOzKwPQuQalWfLtmgnUjztmHpG3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(7696005)(356005)(8936002)(4326008)(8676002)(2616005)(81166007)(6916009)(26005)(16526019)(6666004)(1076003)(70206006)(70586007)(336012)(83380400001)(426003)(54906003)(316002)(478600001)(36756003)(82740400003)(41300700001)(5660300002)(2906002)(36860700001)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:47:18.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c231bd2-93e2-42c1-a053-08dbfcbbf431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Melissa Wen <mwen@igalia.com>,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It takes the plane state rather than the crtc state.

Fixes: aba8b76baabd ("drm/amd/display: add plane shaper LUT support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Harry.Wentland@amd.com
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 96aecc1a71a3..c6ed0d854b01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -796,7 +796,7 @@ static int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
  * amdgpu_dm_verify_lut3d_size - verifies if 3D LUT is supported and if user
  * shaper and 3D LUTs match the hw supported size
  * @adev: amdgpu device
- * @crtc_state: the DRM CRTC state
+ * @plane_state: the DRM plane state
  *
  * Verifies if pre-blending (DPP) 3D LUT is supported by the HW (DCN 2.0 or
  * newer) and if the user shaper and 3D LUTs match the supported size.
-- 
2.42.0

