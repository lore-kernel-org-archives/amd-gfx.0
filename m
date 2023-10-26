Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C3C25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 18:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889B210E850;
	Thu, 26 Oct 2023 18:21:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD5110E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 18:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFuyghhyl1rcnct7czpj6hW7ijXPE5bvBjAqKbNgzq60vt47zt6zmhebg7JNz6Zdcu+F7FU3470T/2Be9JLi5lJuF+f84P56ebhsjrIN3VPvUOIj+5/tpPTvsnFjVRQJLvLk9R7xzwkxPgoL3gZSchYk/zKKu/bJgXpQwcMGbrnYlNHbKtkZNB+swIk1O59WphkM0TKNZwTZ0BbdXqbrL4c6L1u1LDrA2GTCsajO4UloyGvC60SiM6h7uLzhUzSN0GvQhCnM0Sb202Ma5HwieygIIv71/xwNqg2x+nYK0bMx+wdKnZwy5oBCO2g1QpoiQx8ATiWOWJcZ6PqHtCvDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDIZKagSPpzyMP6Pj3a4dFVo9AtalCZnM1YqB6zwyEU=;
 b=S/l1W/POa7OzssrfgrIxaoX4EaTA+yNoYIF8k9Lt5C+Q5XxlSKnQ1g6/ma7iszEjvrFgtgS2Qk1kmDc19Y8YMEg4ROGPrK76zYQNtqAeJLmPtYgFzYTc7LSwA60dfoAT6DiQtgFMUbwgparu7je+xA+7puEmCRYvhBQZHIUSUUATRxvDy4fKtoq0bF3N+N3kRm/HB+C8pyHpzViUop0ADLu0ma+rIG4lb6G8CPhZU9eLqbR5t0bHPma5+NRM6uUiIwLZiKEVinXrP9rKjTUBUkMPZuoX6Lvi52XIDymIOsc1QvK5GTNRtXPwcBZRhUQ3sn27Uzz5onmt31Io7uSLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDIZKagSPpzyMP6Pj3a4dFVo9AtalCZnM1YqB6zwyEU=;
 b=4B6cKwtqSOdv7yja7+TokJOuRNpY3TTFYzPg6mXlzKeNEeV6QkmOcMVWhD8L9Q6H0Jw4t8BxeEC5zDcyWnBB25fkBekCFJWMfVq/Sf4TqMIeuScMxnubWa6CzQj8iZDFCby2MM93dTu8Oevin/Wernrou7+dv1CO+vaw+pIZdOg=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22; Thu, 26 Oct 2023 18:21:39 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::e2) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 18:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.18 via Frontend Transport; Thu, 26 Oct 2023 18:21:38 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 13:21:37 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2] drm/amdgpu: Fix typo in IP discovery parsing
Date: Thu, 26 Oct 2023 14:21:25 -0400
Message-ID: <20231026182125.264464-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef8f78d-6e2a-4005-8ab4-08dbd6506534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeEeJhPWFeTSz+BUXjTF0GMinVUhHI3yMRO8sexW1k0D/s1GCrXjWJmQeoN2BhiRBPVgkMU9aqnyTJeW+pXbv2xfNo2q5HkTgTWyvMjG8KQfIW4YzhJdES+32UH6A2Sa6Z7QPW1DmNGCF6hN8vCVxOKMLlS/hu/a+AnoR2Q1lSeYeVWaIaYVnw5Edi2evSwoZjTdp+4mVfp4Y60LCK17TM2fa93qrDKJFGtfbCtAh0hHCeAQttwCvPqDzzsveSyH+6qF/rUa82vv9QX8SolBm5Ufq/YccpUmQPTGA4zs3Iphr7fmvRu7B5XNyBdZgK0PZSA0l0nW45ZMUudMYqU7lpw+8Ufnk943CysuP/iF9iBXQJ4pEidpXDxxLYHOCPf1Sjkn+QKzBHGEMih+c9LuqTT64+gHNrz9kYcJW1ZSW/spQEgC4yLg9Fsm/RTFcrNIcwMR8W5+Wgb2A+jOEcj9zKGvewHEe4/9N/TSqiL75+kWxmEIvJZKFEGo0GxQoFx50lHUOEa0YOv9CHjx7X5kIvxKpdT+7laFnECwUhUkzs4q47LmAYg+whF+PajFSpODBXj6IzWuUFiqjsxUtt2aOXM32KskCUX9pOq4NgAW8AdckLG6g4REp2NQleItaBp+jmrfwOljBg7hc1MrcReJuJ1q/+MF7bBy9ymfB1mqtWEQO2+CIf49lrlknvnvOlDgDwRTfX5mtdoKvqXrOHIa5Oi9sH7sdgCJVomk9uox5sIEk8VuthgOufmObB/4+AhsEHPHwGpgdNiiL5eacdYgEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(2906002)(86362001)(83380400001)(36860700001)(47076005)(40460700003)(336012)(426003)(81166007)(1076003)(356005)(40480700001)(5660300002)(2616005)(82740400003)(41300700001)(44832011)(36756003)(54906003)(6916009)(70586007)(316002)(6666004)(7696005)(70206006)(8676002)(26005)(16526019)(478600001)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:21:38.5633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef8f78d-6e2a-4005-8ab4-08dbd6506534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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
Cc: alexander.deucher@amd.com, Mukul Joshi <mukul.joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a typo in parsing of the GC info table header when
reading the IP discovery table.

Fixes: ecb70926eb86 ("drm/amdgpu: add type conversion for gc info")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Add the Fixes tag.

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8d3681172cea..81476cd8461c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1488,7 +1488,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
-		if (le16_to_cpu(gc_info->v2.header.version_minor == 1)) {
+		if (le16_to_cpu(gc_info->v2.header.version_minor) == 1) {
 			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v2_1.gc_num_tcp_per_sh);
 			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v2_1.gc_tcp_size_per_cu);
 			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
-- 
2.35.1

