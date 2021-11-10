Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642DBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D12F61159
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 06:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D12F61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F69F6E03A;
	Wed, 10 Nov 2021 06:23:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4ED6E03A
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 06:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPPEoA6RSgLEv0UsKehadsFH7HYkPrO5RcwzKtUHL4JYOHtC59IXYB8haR6v1r0tvn5lbdayCl4InHJCOqWZDAHpZDW1NH/rbKvIS17IcHzR4QOKCHSBowYANJagLECPkf+SOfhg0y75K8DNo3+AZqq1lDPCELYu5etPeMyY8GyXfTvAqVGXc0xHFJmThQpMQ3HlTkn3tj2muv7m4UWJypnsSSyPnGbwmIa8pUr+8ytQ4mV70wN9DDXpodVhjI+ZYPT4nB6mYMMHemwxfCJpTWdWDIMoZ419TOS2hZ/G9z7P+5ws++++mmoLTjSA/DpyhFe64b23bq9d66Bpaeo75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pjy96Mwsti8bY4+cSXf8eWAUgggDaGDBDFz4E77QUrw=;
 b=ivtCGgm2BlWTvOlarGbg5M4RgIfTpLRqYQKJE7Ej+er0eGupIHGuOBzE2cU6tRBtl6MzocyCMC9mN3zgX62lhbYXhU3IjdfnxZd20dyQ/4Ceg36GlSTEu/nm+kEMymrmqQGxiKuBozUKWS+c8IBeFVWYavQC/BBI8eCzwM6cDGEE7j8VAvGMRFuBdwkgN4FBU1a0Q8FFAX4DkUGFgOhvkx+EOHfE/ZrGbndKptjZz2eUCIgQIa4zBH4LCHru8zaOizcKpMNsc/Idl2jWqAm3Kvmvs+0oPo4tMltsFD+uG1Pj7OWEaKZH34dYqzQTB5ng+U/+3PggUa6qYjeA8Dj4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pjy96Mwsti8bY4+cSXf8eWAUgggDaGDBDFz4E77QUrw=;
 b=DwJg434febzrY+wm5BeRmKLwdJ1KtS+LaFT7vbbx09Qf2WyrTrwUrcdttOrcZBhCOIJ+gs94AK6A5qJXsqOsWY0YsiweTopdvcLhTlWW+jb1AllwcV5rPaPw9qePLAZ4xhpXNxYB/8uVd0Ra2cpjMuLHXlZ5/0oaqGdzaRJhI9o=
Received: from BN9P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::29)
 by CY4PR1201MB0182.namprd12.prod.outlook.com (2603:10b6:910:18::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 06:23:48 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::6f) by BN9P222CA0024.outlook.office365.com
 (2603:10b6:408:10c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Wed, 10 Nov 2021 06:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 06:23:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 00:23:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 0/2] Let amdgpu react to platform profile changes
Date: Wed, 10 Nov 2021 00:23:41 -0600
Message-ID: <20211110062343.10041-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df15a3c4-496e-46b1-917d-08d9a412a80c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0182:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018204EF6B5B28515DDA54C8E2939@CY4PR1201MB0182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9vWns8LCAe7E5SbOISihVgAUfHI2PUKeOGv3DcS6p9gRrQq71nWAPceagROrS9afqKNTyPrOFgAx5YI/Qs6EwVl3kDGuVNxjdTqcG/2N1VlyxXNWEyg1sVi2LB42X++DpLXSQhfGUIMPLxwPCtQ57hDOItqXt1eT0F7oBUTq6zpxhyAxiflZ6ChIRaafyQOewUwhvHdvj/pLrZ9tTmfd/oLFS1tS1uI+1Vavs5I4fYDt/PCuUzMoNAdDXy6lbNYo94oBZLtuG5XT8HzbxbfwLwFvzP487Sl9pDpWD7q9bF/tbgw9q0L7cojbME/LRhq9SVaInAF4KGYjtoUXJtVI4UrV+Xal58SakfaIrAmmpyz/q3PdYqFzFOBzTV3PkpNra22KRW5oT4fW+TD4+EtzrTyhCvnRu1rWvb2cEHuV6dwXedB52Ja4mfwviqJ3CTZks8RX8cTCc7gdJLIo69EDedx87LlTCbiRu3OCYUm5EFUwnUE6wpr5CJMkNv47xpwHWPK8xmp8pKAERiKcbGA+X+P5C1g0vMPDUZhcCK6tEnIE0K+3AMno4URFSveKIivoBxLDbZg5KIeYfFwXpzqpzzdUuInnxAU9K2hYZBm3l9K3QKIjpTELuE29Ij5mbL9eU8vPEXZlJM3ih4oh/RS23aGTeVHpx0PyBGejloQDm2dm7oLdm6FHAeIbTKBe/ECMN4XPfnOcC4Lt0sh8YXfchfx5ZRpE1BTbU3NkzU1DHk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(5660300002)(26005)(6916009)(83380400001)(8676002)(4326008)(316002)(47076005)(6666004)(86362001)(82310400003)(2616005)(16526019)(508600001)(7696005)(36860700001)(2906002)(44832011)(36756003)(81166007)(426003)(356005)(1076003)(4744005)(70206006)(336012)(70586007)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 06:23:48.4968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df15a3c4-496e-46b1-917d-08d9a412a80c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Many OEM platform provide a platform profile knob that can be used to make
firmware tunings to the system to allow operating in a higher or lower
performance mode trading off power consumption.

Software like power-profiles-daemon to expose this knob to the UI.

As we know the user's intent to go into power saving or performance mode
from this, we can also let amdgpu react to the change.

This patch series is sent as RFC right now only to amd-gfx, and if it's
a good enough idea will re-send as PATCH to linux-acpi + amd-gfx.

Mario Limonciello (2):
  ACPI: platform_profile: Add support for notification chains
  drm/amd/pm: Add support for reacting to platform profile notification

 drivers/acpi/platform_profile.c     |  52 ++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu.h |   3 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 105 +++++++++++++++++++++++-----
 include/linux/platform_profile.h    |  10 +++
 4 files changed, 145 insertions(+), 25 deletions(-)

-- 
2.25.1

