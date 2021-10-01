Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CD661A58
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 19:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59CD661A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DDD6F39D;
	Fri,  1 Oct 2021 19:48:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593926F39D
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 19:48:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0Mnpe7BxjptUqBZeN5KUR11ELJjOxMFQvuEU8EAUOwvy3zVkBKcMPJVxFHcI1N4YRnNuBOO/a79jOtYpGsQbPOKgPpOgNY3zlZGdcdOi2sCTddlJ8t7navBqbLDUei72ePZS97vaMh4yEQOUu2G53OFFC+CH3lmuRWe5SXfQ/687Fd46hCJrgKjEADzE3IwN7lNK6OqtNA3UC8WO3fvPorzbvo0vHIUqW4ZqBhk4gJkCkgBZrQPwNt88XljgEkSeoYoo1V9KmeN6n2PrjIeMEixEs7mZiBMwbI18kxxiXXRrz8RZizYdasxcHlEruoegAlULpJrcO+btIKQtJQ9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Brzg0wpo41hx96B2ZB8AT6cxF5LmZHL4SIKUnjxLis=;
 b=gsscxXYJllm+PbuLKs+Tj+bMUsqYDK6Boojl31Uc0KMfaqL/TjtCgRncEKx2PN5jjlTFMRZ1LuONFJ/hNusjDTsYeenIQ3TOm1MUoODF3nuHdJWz07DStpYhRuR5pwLKBNn8MCz5JczfzCRH4VNH2t5PSiGLvsbxQxX6ii8fOgBKAsxBJ0nomRntDBqV4pfkNZN/jT723qi0tXEKDwYUMqbXbt5XNDIiPWbjztOf+kEb/qQceN+FL/YIIV0teTOMN6GuLKA3av3gvXDBnbjRajOztN/og1vbaGhH7loIOBbKlYbC8mnhA8FgcvjVpev5XDgzvtQr9L3W1R1J7AANsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Brzg0wpo41hx96B2ZB8AT6cxF5LmZHL4SIKUnjxLis=;
 b=M1Cc2xpx7sY/dbfCNbTOca3BeYi0XjOT3S5tF8Tu3Enr9DB8ojmJj3NUcflMsIISNZRZfu5u47Kn6HhptG3xO3Q28hGYdnq9BRftQ2e/pG/5pvwvc1jjtgBfpEc49ByBJ7IqPHz3F/2Xnd9A1GmiUrNCShX/qFBOqvzfQxuikPk=
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Fri, 1 Oct
 2021 19:48:41 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8d) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Fri, 1 Oct 2021 19:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 19:48:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 14:48:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix dependencies for DRM_AMD_DC_SI
Date: Fri, 1 Oct 2021 15:48:22 -0400
Message-ID: <20211001194822.1818798-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001194822.1818798-1-alexander.deucher@amd.com>
References: <20211001194822.1818798-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1e4729-d924-40e9-654d-08d98514787e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41776EFB3348D52B8F9DAC19F7AB9@BY5PR12MB4177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgwsiacnGSOS9B8DEgESg3v0Vflm9GyGR6yCCVOGEfm0N3Zn4IGaHSI1dwYHv3/f3Wl1+Uz8kvP0ZdojZD1KXAx43qhMour8G/eyxvaa9KhHIUceXW5fLOP2zmPgzE5itf97xQ5/UEHCuAz874a3Ts451kO81q8fUUKaF2hWYKAjwpLHYam92noXL/4zUX6gRjqcfsZswbgGHu/aFamQhajtQIvf72O1y3eTtsTmBcg/30BoucYQ1n9zhQzaSUTduDg7tZapIFFg83rwFyFczucfsWR44B3Or0B1jeUomvzPEqSmLC9odO9selYc2WWruz+cTZw6Xvi0FTFmB8SmQE0fdxRkaNnZ3x3/r40+dNGrN28HRE5l7uDHCAYKbt5N13zIfIcH2kDOBVwR4T8BYbC5fNPri120AoMCJVBtt1v8brn9E3mC4Xz5qoH4LvTyK1gELhbJHSDeW1WLQIP4P2ZuQO1UcKEHRKdaL8U2gb6eLa/Y8cu0ogcS26CjgBKQFqYoJqI27eNhrweKa0sFyKj6ijl5e4GWRVSwwNzrbGisxbsmOdFHaurUaLk5OJgJbphb4er9NMxPvoA7eNZq6uCJgAJ5R/XHz8TpL/xyEK2orRTLQHphGaTakVsPuMGPXENE0cISI1CFhh27ieJZ/MPhVBdffEauy1ZJOM19YRXpXuR3K4zMAO8uPqLyhTKkV0Xyqw7snWUvdu3/2a/lWb5nYQPaXVR42NP1/Sw8CEM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(47076005)(16526019)(26005)(6666004)(36756003)(5660300002)(6916009)(1076003)(4744005)(82310400003)(36860700001)(8676002)(8936002)(186003)(4326008)(2906002)(81166007)(356005)(86362001)(2616005)(426003)(7696005)(508600001)(70586007)(70206006)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 19:48:41.6226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1e4729-d924-40e9-654d-08d98514787e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Depends on DRM_AMDGPU_SI and DRM_AMD_DC

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 7dffc04a557e..127667e549c1 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -25,6 +25,8 @@ config DRM_AMD_DC_HDCP
 
 config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
+	depends on DRM_AMDGPU_SI
+	depends on DRM_AMD_DC
 	default n
 	help
 	  Choose this option to enable new AMD DC support for SI asics
-- 
2.31.1

