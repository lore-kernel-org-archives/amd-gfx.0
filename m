Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC0AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C2D10F237;
	Mon, 21 Feb 2022 10:17:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82B510F243
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFExW7e0gW5LCLdKsljSBb0tT0nUIMDE8pxjrNQdqqBk/RYF9Fs6e5SIRIUxjW7wjilgU6SC4yhMUYuKXNgl2r72pwU7KkpqWZ2kV1hm6wHVBLAknVqilK2rR/a/aotE3oi+n+Rpm/HlYB1IkOguS/0rpchl9o1PUnh+uuKOsJgigLz8vglWUnunPTvRoFumvRPWgInRXovqN0WCfP60QbtSNiUbZXdC46GAgtKuSER7Mm66WGnb/iKbnAONAFcfYzu8102hSZ2gc06KvUih917xkBbGOnvd1Sk9pPUe6zsXWrZc6JFu6BiAoWMClJI6qgbtfq5hJOYTAMicvbX+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBWLa06OxxaQ4NlLuzV66S6qkYKRo7xwLi7fEP5YeJI=;
 b=BCY/WBtsFshb9PYZ9WHzxwOBws7k53LsuAjCkg6yWiq0GEjUHUvalPFEVZRGEitVJoVJrsCsHuVop01ffuet35ApEwwQ9aUH75DyI36N0LDQJWuvJC2CUrX0pbpw/KNZo28WAJXzBdIMAMHfFDI/F/KGLa1DL+6f0saOhPAsFa0ggQUoK4cfnHDbDt/ofDl7P+c7i4pUHdkbsx6q1tc+w9e30J2bKCSrlnbJNKM18SKQe45P0uIzfQ142nBP7agve0GI16mvkHZdLAjY3qV8oOhrkszqHnZIgNTX+lkBwPCoLmbGUzx0qw45BU5yRC0uAfQ3R0lnH+wfXu4Poo9Hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBWLa06OxxaQ4NlLuzV66S6qkYKRo7xwLi7fEP5YeJI=;
 b=Ja2I+vBHdZnCb/gyJtLbhCsoT4BAaBht3YhbeUCFV4jc2ig5v1TgDQtK+OkbXY9lSPt1i14yT5/YPa3xU93JmyqNfqm+WfAl7mVkrbfCvfOMmtediZT9SPEbagUt19elApJspgXvATtrnP06BERlYC5vUdnHUBX4WKDIAGz4kO8=
Received: from DM5PR07CA0046.namprd07.prod.outlook.com (2603:10b6:3:16::32) by
 CH2PR12MB3735.namprd12.prod.outlook.com (2603:10b6:610:25::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 10:17:06 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::99) by DM5PR07CA0046.outlook.office365.com
 (2603:10b6:3:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24 via Frontend
 Transport; Mon, 21 Feb 2022 10:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:17:06 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:17:03 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amdgpu: Remove redundant calls of
 amdgpu_ras_block_late_fini in nbio ras block
Date: Mon, 21 Feb 2022 18:16:14 +0800
Message-ID: <20220221101620.3269611-6-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb040e7-0f53-4ebd-a1da-08d9f523502d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3735:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3735F830DC2C3D9D96A66695FC3A9@CH2PR12MB3735.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2B0Zga2nHwNhkepz4gyqbD7h9yB+H2qYepAf+JPMvS1oMv7ka/QYmDjF6Gz5pJ7LdVX+ZtTwew4fteN2F0Xb2DVpboFwKV34oa47iONObSpxbCzsWdzIYWggm2arbxanD8sbQJSHVBuQCITMGbLV8TFuL6bRrWODoTFa+00YQmBGj5AryWwlfdZUR3Ghm1/wXpM4sPeosthmt2l3GECDo7no2M/JuRfHhDUYyYB1WNTQ4FRTSXBMfNdyCh50lXgVWDspip/yC4HgGcs+CuEAvTO/zV3TIy3jW8aU1pj7rQ09j4XtvMS4G5+ZCkfk7eAfM8M1zpmLLoQUbPd9rjeMpO57OuiOpPvE/FrgXkkenQz8crb0VySGAzmz7pmff+M4aacxvHUwuEGCzNs75YzzzGajtwHHrqzXfLeTHicXNSY4z5sI2K4IOHt6amV2HRu68y/3fH4yKfpmLQF9fF1IGjuB5DvpnDDId3dO306ZlMl6OTBU2F1HiMQvqaZsPGthNbwy25c9XGoPpWtRN1/INyuBPR5On2WrIxyGFkWW+ji76qbLhyD9Wi/Nh51nWpFn9HDP3uiQE5KzZhW1socevqPhLzlMjeBDf4MM6di03BVV5KMgixyE/OT2423QhLRNTOYYv+nhuO1nu5uCUDY/j6bPhaHSr3SgBpWxwV09/DbzeDwTqGKbKz0iEcb1NJtGClVgLI6RPOqh1u+i4CVN1MS2GjuntP3jmm51b49fEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(336012)(5660300002)(1076003)(16526019)(426003)(2616005)(36860700001)(86362001)(36756003)(54906003)(6916009)(26005)(40460700003)(83380400001)(186003)(47076005)(70206006)(8936002)(8676002)(70586007)(2906002)(4326008)(508600001)(6666004)(7696005)(356005)(82310400004)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:17:06.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb040e7-0f53-4ebd-a1da-08d9f523502d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3735
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of amdgpu_ras_block_late_fini in nbio ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h | 1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 54a5a15272c1..37d779b8e4a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -43,10 +43,3 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
-
-void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF) &&
-			ras_block)
-		amdgpu_ras_block_late_fini(adev, ras_block);
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 3222e1cae134..3d13e601fc35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -105,5 +105,4 @@ struct amdgpu_nbio {
 };
 
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 14768570c298..485fd9239cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -671,7 +671,7 @@ struct amdgpu_nbio_ras nbio_v7_4_ras = {
 		},
 		.hw_ops = &nbio_v7_4_ras_hw_ops,
 		.ras_late_init = amdgpu_nbio_ras_late_init,
-		.ras_fini = amdgpu_nbio_ras_fini,
+		.ras_fini = amdgpu_ras_block_late_fini,
 	},
 	.handle_ras_controller_intr_no_bifring = nbio_v7_4_handle_ras_controller_intr_no_bifring,
 	.handle_ras_err_event_athub_intr_no_bifring = nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring,
-- 
2.25.1

