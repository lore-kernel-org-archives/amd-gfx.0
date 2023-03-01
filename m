Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEDAC678D4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 21:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BC910E267;
	Wed,  1 Mar 2023 21:09:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919CA10E267
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 21:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC30c9ryDBBbcnS3cQvGuNvh9jKFbTOoQTa3vCVHudDJhfmQnjf/LKE57VTEctrFeQqZ2okiz84QQ+3Jgb2ULCQKImpwjhgJ4jURtLdEdAGCdsUZFF4y9csja3qEHRGnZmwbCBHU03zgGq8GUgQlb8j9dtqa6LaCql0+OsqYjnnkBUfSLzA8eTxgc5DGcvfiADdBWbIT6YSChTn/qP7iuqzbprTLl/kPGUweKM+oHag6kinBZ3sC4lYXGbdeGOotxuJ4On/7Hr5RKVUKQW+SoBZst1cOScWyYZOH/0SDFhWb3dhmF+bE4wyFIjPxk4z/nbd38ASH7NvHcBWR8/jnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vynO+L6ni7hBbyMgw1H1VJiqCJvF3iRiFyviEVmsABY=;
 b=KDAZUeZlSDFF3wRKJZTel+bqa+uSh4srbgwdbvcJko+e7+9dgLlkgbnb9qFxejN24TfXCmemrHfHLtj7kKxCCqzTc21uKwFrIVVO7f8kkAWeu6J6buseL/aOM6uitdNeZ8IOk4yGi/tQuJkswVYHo9/RXVxSR72LoN8CGu3od6JRwpYVfftB5bLmBjOgE3vKb7n79bYSi253hTksewLCVJNirlJ8iJrZg0nxUiohpD4x/nJBpyybRuU2bNJIerzEMObZN8LD6EDxwK6oLX3dfNxsJzu9GpiYoruEfBgyX/TMA8Ie/Q1cAmgXUAb3dlN0Il0dqkqj9dTSuLL8ODtVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vynO+L6ni7hBbyMgw1H1VJiqCJvF3iRiFyviEVmsABY=;
 b=aD1lPPv04NlJN5gRerlxxsqA/uZuQMPjb+Y+JoGX4MwJKeFTxs/IditOv1lOyYuxKIuAf9d/lF+mGM8F1plgjicl1PMc/Uxub6TLuY35/d8fj6g6XDl1/uhCplvQe2IFB+Et4HjIEEH6FfOt3kKMPsrHt9Ji/aUhYxi7eKc3+UI=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 21:09:14 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::cb) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 21:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 21:09:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 15:09:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: set ih chicken bit for IH 4.4.2
Date: Wed, 1 Mar 2023 16:08:50 -0500
Message-ID: <20230301210852.2098388-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 347efb39-804a-4577-2139-08db1a99361f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVnMBXqeZmt0pgJvAH08IMPiNA+6Vuy1pEusMDkpetVQQ3lAyg3GRCvczNiEN2/2DmjRaTynEcTvonNSx1nqxUfXinRBB9vKKItl9Kmin4MEmmt3OMwkM/O0sdQ/wFcFnLpvwA/DTokhQNknwwK5xf8chL5CA/xanYH/rv03Iv7CtSIzPbaPt6d/Ww3WVaWVYiSpbN+ZSYUbPQq/D+Y9VcZN1IpINzvzKIeRHGWAdQ1hV2kzhjK946CxfAgAFZ7rbm2wRvkfpYmFa2tOjFgU5Ocrijs2RVJfKtwbDK453AWWOyDfbYOH3g1NYWlmzUDOInocf/T02qkBOYkIOmpJXqHLtbCJLgACkiVVpxuit9f+s/5aV2Iba4bqn00+lr7XqFbwTrEqSDVNEJPBskIP8/tdNDijjJ1L4faQCjd6i6wY7Hor8GEzOUKVZaNl8a+7Ql9z+KYUkhIJ6EnBTmtifFr9xFGhRKcdgC/+0nV67mdV+dJ+b5biARb9KJ1VeEjVfSTxiAkImbAwNhBh+dGKoNRRM5Drbq/Vb59kwA8K8rc3+ajvo1tFK5yPZdcADEADjnRUryhzTrCeunyMQhdSsDPLV8viuxAvsgWkqr/er/IiO5vxvAbA66vcrdvsJYcL5Qok6pC4yNyijbOcVkfWOHkXRpijyNquujc13gYkZinMFEar4lEqcgrCt/vbSRZAL/Qm1nN5S1PZiPoLrddMACLlwrXrm605ofLPse5u1Zg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(47076005)(426003)(54906003)(81166007)(336012)(1076003)(2906002)(2616005)(316002)(16526019)(186003)(7696005)(36860700001)(26005)(36756003)(86362001)(6666004)(82740400003)(5660300002)(82310400005)(8936002)(478600001)(356005)(40460700003)(41300700001)(6916009)(8676002)(40480700001)(70206006)(4326008)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:09:14.2916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347efb39-804a-4577-2139-08db1a99361f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Share same register address with IH 4.4.0.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 1706081d054d..44bfa233487a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -321,7 +321,8 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	/* psp firmware won't program IH_CHICKEN for aldebaran
 	 * driver needs to program it properly according to
 	 * MC_SPACE type in IH_RB_CNTL */
-	if (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0)) {
+	if ((adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 0)) ||
+	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2))) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
 		if (adev->irq.ih.use_bus_addr) {
 			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
-- 
2.39.2

