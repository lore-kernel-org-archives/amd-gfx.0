Return-Path: <SRS0=gBm/=OQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D0BC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 14:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A5A60FDC
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92A5A60FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E676E526;
	Sun, 26 Sep 2021 14:28:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C386E526
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 14:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4pn8EE37jX9unjClh4dvTirRgvSkfVyARDFd2vyn5RVX3b+aVKUYpUZydhRNxv/Rp1q2753vAUB3qRJjG4u0xa8KbWIQIxF3jQJVkLz0uG3szlAhivFP9DeQM9M5spl+JaA+aMinnotR+I+iodtgWegrQ7DYtPCrleO77NAUmVxdxeiYpP211o2L/Q1FS70ePQsyxkpaI2gnQHV0tA+47fKmwzicCCMjBlNqI9YdxmHmzkJpQjoWLyxG7+v+E66LUA6+HFoAr+Ec7BF4pXT7J05gb/eZjrWKF1z0ytWOrT+hWhSGFXOkGBcM1bYXHWX3tVUwnt/vhtnQrePNcPPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Aq65fb/UzptzXgN/D0/Y6pl3CxVEqCqluwQTlVSlC60=;
 b=g8h/zoCrSfH1biJ6dtWTjL2HPJl7Wt0n+qp7SKZ1JZEFVPeE9zDSsRBVv72pqu6TSkBaKqwyz8fdATgovqr1eBiWubxGhAhQ2IVnDTUgXrOGfNEIEMflf0NQC/j7xTAMXKvQ/2Mgz9MFaUg6wUa7Tt2bJkrM7C8JfS8PDznB8nU4hydIThCfeSjiaWIeQmO8lcHyZ7f6cMuuey3ja4e9zdKYWHZ8A7S1xe9pCcYSKIB7VzhItAudctzOcITGoWzXNh3+JN8AojTURfdgPaechPWiRE/gJuIgX8BWuwHIKYP4XPSvZwbSIgpTopBA5Xb+QjDcq8ox3zXnrH9yjCmdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq65fb/UzptzXgN/D0/Y6pl3CxVEqCqluwQTlVSlC60=;
 b=Y/KLUOZJ/8UKstI2IyvmwJVwudVvdEBu37akT4nwahgTmZeNqf1CuikzBBENd8f1Va28Al8zUdgw+hQrEg/pN7flRQVMqIwY0gS1I8EtiwxL6NrpKfAxYmUKpSeb3AAwCcjuB2HBTH31jddH4o6I4tnzKTBQrZv8YSy2iWgLRfY=
Received: from DM6PR17CA0017.namprd17.prod.outlook.com (2603:10b6:5:1b3::30)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 26 Sep
 2021 14:28:40 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::7f) by DM6PR17CA0017.outlook.office365.com
 (2603:10b6:5:1b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Sun, 26 Sep 2021 14:28:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 14:28:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 09:28:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 09:28:38 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Sun, 26 Sep 2021 09:28:36 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct initial cp_hqd_quantum for gfx9
Date: Sun, 26 Sep 2021 22:28:32 +0800
Message-ID: <1632666512-4007-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9daa094-fea4-4c75-3113-08d980f9ef17
X-MS-TrafficTypeDiagnostic: BL0PR12MB2387:
X-Microsoft-Antispam-PRVS: <BL0PR12MB23875554AA25ED58F33A4653FCA69@BL0PR12MB2387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Df7+SCGx897wsXfDgIQJkQbnvE7g9UdaM8N++CqqD37tPoaP2Oa4WunsoA3lpEgXHsOxtvozIGNk7vTh/QbKECkSeioFVGNQJKvg4q4JRjIC2ewebk4+HvqXJYD+0Co/8ev4M5Neu74Yo+3e81fjb4GIqJYQdePUwQHPxCWKvpTugHawG5D40vPRMUXVk2MO6dziH4uNV+HLOh/MdS6QCPqFF7gV9/BN8av3NC6cH+pSiTzr03fUMrRU3EyOqcMpQ7z5kgnefjxzrfvyUDY4xp1QM5R0L3K6QHbIoBQPR/JUUkwHUgXamkGCH6f39Fu1/BjyR09EidXfKPg5vjb+HDUX3EfmIscSYtJU4ta5ttF6qdjZrvZ0wNj6vxmXJUyuivvhZJIlKLtpQAFnQleMpeK3XIZ54OaIZNfq+50Z967TeizDfsrP4iPIdMT3bqdhkBFr0RXzswvBrb/GhKZKMNVEUvXwCf+w1XeHEDfO+k/GXPKFPhYOM02AqDqXUWExcR0dVugu0x6jEOJGBPruhFTSWi2jZlQfnAqfyom68zUGoEp8pknd4YfkzyR5HdAMbugYAwpx8nvviELao0fAWvgmTh/lt1SG6/hapg1kGP4kT8mNSet+Z6FQPSFpE/0zVL5iZWekcPqReC116p6QngpD5az/aL35Smf6tBFdsA2Yp2OdL/yd8eEt3iM0ZJPCO2CR56AAxOUIrz+5itL7Xc89DK6D/nJn0DyMpo3tzHk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(110136005)(86362001)(186003)(47076005)(8676002)(8936002)(336012)(426003)(2616005)(316002)(36860700001)(83380400001)(4326008)(81166007)(2906002)(5660300002)(36756003)(70586007)(70206006)(6636002)(82310400003)(508600001)(26005)(356005)(4744005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 14:28:39.5272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9daa094-fea4-4c75-3113-08d980f9ef17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
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

didn't read the value of mmCP_HQD_QUANTUM from correct
register offset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 603c259..025184a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3599,7 +3599,7 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 
 	/* set static priority for a queue/ring */
 	gfx_v9_0_mqd_set_priority(ring, mqd);
-	mqd->cp_hqd_quantum = RREG32(mmCP_HQD_QUANTUM);
+	mqd->cp_hqd_quantum = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.7.4

