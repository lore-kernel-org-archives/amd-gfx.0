Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC385C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 13:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFAC10E049;
	Mon, 29 May 2023 13:59:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B2810E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 13:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA05Tz35KTHCJiuWiLs6ZRgJnXv69uC0mFDtZIRVv8s6mXSdtWsAKnEAv5KPh7XS5Pqze9867Ba4C979i9gX0aguV9/6hazK8Ny2DQrerF8zVyLFSXSakbxRjgflwvvro8ehKjhpR3Pci2qHsMQRtCIazwVBVWF0ZQHHPxNx8YqVeU3j/haGzNYFem1SE8uY/47cA4Yho03sDyJp4aAWCTfLVzX2d27lQQ6Tu/c7NoRpOYvwI2TRy70bD9Bi+FHFeNrWqZR8QBOy+l2kXGjhSwT1J0OCP4xqm+zFDtECBQbNDL6ZWxN6sAsArmyW9xkAtQeMrpTw8DFkQvOQOZvnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GXm67krZqYdO0rZOJ5JXJVGYrV2RX0vT1QwTzfQB0c=;
 b=Ft21BQaAb8JlD2OtXkrgPd1DNqNwKvc+mC0ksHSFPU1eVV+VNDIFMwIYnlu6YLxiUAvK3JdXCTgI5r3MeI37vdgiMF0oYsL93KnKtZwwgBl5NI90oBgZyVX7Onbh7haX2QbCueSvIILv8yNZsOjB7sCmzdbUowfx8kZJpG3GhngC27U0Ra7fOHmFYuMRm2vjQtaI6SINASENfFSP0xiMzQq8BtlII/WEZb32o/cpYNby9H6Mz0zH2erAvq4XaMRSgcZrzLyjR2zNrqVMKZsJbNFXykpsK3Ux6AQnK3LalO1V0D+/OXq9EuaIRS6VOyt0Qy3WKPMiUc6m2/tWPKA2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GXm67krZqYdO0rZOJ5JXJVGYrV2RX0vT1QwTzfQB0c=;
 b=wFlEXb9idy78lEICRH3prW2auNJN3sWIopoZIw/LnlS5SGtaMEkjWrKEfH14TzBc3Zg7AXMDh9WcqQX76Tr6cUbzFJjBd8KP7LpsqJpGsa1ymDjx3ZS2UiG2bGsJFfa2JBraoI3LjFPeUEkjgneLiO24hIB6izjJUJiR44zvpJg=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 13:59:00 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f4) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 13:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:59:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 08:58:56 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix MEC pipe interrupt enablement
Date: Mon, 29 May 2023 19:28:13 +0530
Message-ID: <20230529135813.566730-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 8656fc62-eb99-4ce8-0fea-08db604cda9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsGfDzDXMeWESQU2Q6FyQFH4RLphHYoOYpjMm/4YuCv9qF3iPlJ+0gPX6gkluO8jZ/7jP00RWPSVwcJ5QB5DFWYWYwxzt4iNpdeQJjV+Jh03WTHlov7R89visANDgMjlVMZZWl02njbwz7XNo3/gvdaiwEwDjZZN1jxjjOKSaWngud+BRKjnn1cMGzF8Jac5LCx9Qj7wgMo+kTEXbV/fs73Zk5lPSuxCNUvbdUpNX1hhvnk0ltGDuJUtQtY2q+4lcULzE7iZnRe4YzhduuaXn3WpnHFsFyM5zQ1Q8oKFO3mfxg1JBHHx9n2pN1NcEt5/u5AjNapz0VD1RcGNYpbtKQwN+ZSY0Nwb3kZq29glno9KKo1yILiXV/R+oXDk813j8PBp550gjiof5caZClOhkInssjZRQ8DBkHYjMP1KxVAUYou5K6WWzQTk0LEaUpgcabVKxrOZMNl88zoqiiRHSonW5W6daMpIvxfUCWAs3P6QRx82FYY62d94XdQReS1sf0sMToRZ+eJ5IsQ3ZA3Lp1CAHMoSJhlOCzS/ri9N8eAesL3Oj42/8++aErDNpY0VOmWCFTyegM1E/5gcClIx7GazWh0+I+oEZC7C5fCnfuF8bQxxdN2uL/ozm2winwrU4q4189gYWVtDFHF3Jt2mqiwvJTgUjzXgRDRZ2Sq3ncsnj7jAsnxSmgd1gciseV01F/GwPmOzTtT28y48ExJu4zU8BJq08mMjHpIYYWYeWCD9ZJKxevP8lZTFMwg7N8T8CKe5woi3nyHd4J6y5lI/VQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(356005)(82740400003)(81166007)(478600001)(36860700001)(47076005)(2616005)(83380400001)(70586007)(70206006)(426003)(336012)(54906003)(86362001)(4326008)(6916009)(82310400005)(6666004)(2906002)(16526019)(186003)(316002)(26005)(7696005)(1076003)(41300700001)(36756003)(44832011)(5660300002)(8936002)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:59:00.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8656fc62-eb99-4ce8-0fea-08db604cda9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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
Cc: Alexander.Deucher@amd.com, Mukul.Joshi@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for_each_inst modifies xcc_mask and therefore the loop doesn't
initialize properly interrupts on all pipes. Keep looping through xcc as
the outer loop to fix this issue.

Fixes: 7b04c90a48b1 ("drm/amdkfd: Use xcc mask for identifying xcc")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 493b4b66f180..80cddb46657f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1274,11 +1274,12 @@ static void init_interrupts(struct device_queue_manager *dqm)
 	uint32_t xcc_mask = dqm->dev->xcc_mask;
 	unsigned int i, xcc_id;
 
-	for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
-		if (is_pipe_enabled(dqm, 0, i)) {
-			for_each_inst(xcc_id, xcc_mask)
+	for_each_inst(xcc_id, xcc_mask) {
+		for (i = 0 ; i < get_pipes_per_mec(dqm) ; i++) {
+			if (is_pipe_enabled(dqm, 0, i)) {
 				dqm->dev->kfd2kgd->init_interrupts(
 					dqm->dev->adev, i, xcc_id);
+			}
 		}
 	}
 }
-- 
2.25.1

