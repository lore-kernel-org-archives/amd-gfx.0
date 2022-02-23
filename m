Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75702C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A9710E423;
	Wed, 23 Feb 2022 02:28:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC0910E423
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHkIMmozajwVPVumwjaJeLYgI698Y9dUPJFs1D7kuSnVGYDMEqNvNfuZL8lEw3Ywlvup6lokS1LR+yC12qcjexT68MDaQ07NYDNW72KZ7Zn5RpchkEWFKGr715e2UGYhpxjDfWKGrIKx7oD2defdVyvVCapw/HV6jqCRudbwIPRl2YJuvotG007E5BiMJBDNC+Or9hEyilBdY3hy6aHhMWOjil4ArTWQq6mVvYyitPkPrzF7+PW3hfBzP0604n7S1KdRIZaJC2imtuBX+RqDW+IFKrRv8g/Uu3dyU6mjZX9N2wubW5JIEQSgjgPgKyV0X70drP0A2r9TjZf9A/INjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr93LCoGdvdqAE2SvnOIMvWW+uPlugM9mC8cT/VyKfg=;
 b=JJ0sbMB+QJUhV9RXFoLkyG+54OlPfqzdGjGyyQXUgTyB3lqxqp8EtSD42vvIEDZ9grldOd5B1OUZUyHgvYkPZIikEItN6HANrFQFmIXgptuFygDuT0GvRkahHNKmx1IHq/xrH1yiqdvluu+/qSnxTjvNSEOuNJs8Aye2L1l/L0tgYGBTNCg2Gi7czxuEJGIFKzzZj8C7SKWBLmGMNJlFvG2X5DnNe5+E9Za13DaSaH3X+9DF+hXdj+XwooGzgE9MJZxuD0HPUomMtVofet6zvLAvrdDkulrsK5+x6PDF4WIB1rBftLFFpOUE1htEh11vxxpiFBEZW0jSThgkEHEvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr93LCoGdvdqAE2SvnOIMvWW+uPlugM9mC8cT/VyKfg=;
 b=hleMFbH3KddvzzkCw1XheBsH8BLnaC+PU0oOWNBpIoTEjG6pEPi9lXltjwRG5SOySM0Y1IPSBNV55lIu/Ib7ovHcNi7ocN0FbJ8uSYIenWA0XxHwXzTj8XLdzmfrq30O1/QUakeSWNpvJORIqrv9VdE9sqCwX2R9AJbdEthXPrg=
Received: from DM6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:5:18f::21)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 02:28:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::c9) by DM6PR14CA0044.outlook.office365.com
 (2603:10b6:5:18f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 02:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 02:28:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 20:28:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: Remove unused temp variable"
Date: Tue, 22 Feb 2022 21:28:39 -0500
Message-ID: <20220223022839.1645469-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c07b5db-5f0f-467e-3941-08d9f6743cdc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4422:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44221DCC8F88B0EC6165D10CF73C9@MN2PR12MB4422.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNh0o1HxwrZYYbNxCIi+KhXN7nflICbvrEzakty1a8jAH01eBwL9cRG+WXYGtUVAV25X+kNfFe7IpYsl8ANig2lnNb2SDTdB/j/2I++3yOFrcb+tkgBafZkRWwQntU6thM6XCgkcJnoJPMg3/z2CrrygemAM7BMxOmtEua5Hu/gfMpOCgq6QliGF4TUd6bY7FGALGdxLbQ3CMzMGDNikdDB4lp5lLMR063m1XgH2wOXwXenDO47k7kJHIarfXM1tCtCWVuVuF1nuBfDd92KJ8Ue+sQeIxthalnDEuKa39RijfteWns5Pt86bYmKhlZm9DYbYoqvv9qWG+dck4krSBLJ92xWs+uMgctsORElbNmXWcUVIoi0VTm27x3wsD4fcAXYx/mNiObYMDdjgnIN9yFMT5pio2y8OeGr6Qc8UTkUOQqg4LZlcgdXeX3tknmg9dNFM2++eYMtTqtUZsSESRGV0peECb9xIxvFHc7XPOEIWOy1s68LWtBQ7g3cnYoN3dM+wG6nfrSk9aRQbn1WyYtqoqOA30f9dIydRmjGtC5WSUYwvlMXTB69ZE+o3ThrMmy74o65kDIWVqdKylEJQgAZMqUTVfMvhUpVwqpjOQemY3buqvt5I0bidvIKol0qlEP1Q8JdILZ+yIcH9fHiDmsigMlPVoT99ZDS10Sq2q4Ak43m+ztFQOr9J4MrCgcHrtDDeGrspyKA14vJ9F43Dtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(6666004)(7696005)(966005)(40460700003)(508600001)(36860700001)(47076005)(2906002)(1076003)(186003)(16526019)(5660300002)(54906003)(6916009)(66574015)(8936002)(26005)(4326008)(8676002)(316002)(356005)(82310400004)(336012)(426003)(86362001)(81166007)(70586007)(70206006)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:28:54.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c07b5db-5f0f-467e-3941-08d9f6743cdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit b1f0ab445ec609f9b58e0969c5d052b52d9a54e7.

This patch is not valid.  The driver needs to actually read the
entries in the ring buffer.  Add a comment to make this clear.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1916
Cc: Maíra Canal <maira.canal@usp.br>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index d3088836d4e4..cb92ab4c8b98 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2918,8 +2918,15 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	while (rptr != wptr) {
 		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
 		//uint64_t volatile *p = (uint64_t volatile *)data;
+		uint64_t temp;
+		uint8_t i;
 
-		*data += DMUB_RB_CMD_SIZE / sizeof(uint64_t);
+		/* Don't remove this.
+		 * The contents need to actually be read from the ring buffer
+		 * for this function to be effective.
+		 */
+		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+			temp = *data++;
 
 		rptr += DMUB_RB_CMD_SIZE;
 		if (rptr >= rb->capacity)
-- 
2.35.1

