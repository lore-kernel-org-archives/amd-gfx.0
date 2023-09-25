Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF5ECE79A2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4477110E321;
	Mon, 25 Sep 2023 19:52:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E31210E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKVKmz8VjdYrdFSwU2o6meUAdUjxi5Zn6ZrUPVwMyOPhdwzJVI+FjGvF9893eajxQL8rD/1Znclb3+FjhTwUwedmHVpJiDfm2Eo++LNh9+wj7mayiDCheIyxPm3LEOTVsXHHxXiLIW6/ullVAjIzAbfqYJep1M0i4JrSYInYZNeBUdvSqPlA+jKd3l41ah0erwLeqSm+mNLpnXxV8rTAH60MRdPZjiHqGK3f/ImpmnCJbOhI02Y/UOdwYgvAitAUTYizvRfohE4538cM6bUn3jDK2zxanK5OwAaVieAoV1Jbsm7V9zy9a9leiVdvTzJvWSSDdHf9ml38tKadV4Edog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYPCilx7c8jg+l+zHDP+UeeEWWKtrDNgRLPzo/PnZT4=;
 b=HBgj9RegdBbHBBnUTWiDr7fpjrcWNaQt75w/IsoIwr6ZT9loOKCxavvQLlTVokm7ykZlBSrj0Im9a5/U306ltJmLbgFudavWjbCqBtHgKNf7ObrQti8txdVhBdg91QxgEImvioshrMjcUGL25fb2oXagjf0xrMWVJZLdC2awYYIfvh5ZVwg3CQqnSsi8tvXaVZj4dB2XmEHJz9kv0Z1E8zqsConKwC/b2DiD42+D/97oDbdv6lqomVE5RJDBs+Idc6vx8qi/MbkI0TD4rYhuEr16Gdn9qLCssEJBrzix7qsZvev0R/Zea9h32FJpneOumKdTghCsnTEFcfSqx1pCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYPCilx7c8jg+l+zHDP+UeeEWWKtrDNgRLPzo/PnZT4=;
 b=fYLCT/pe2QdA7Gy9VKP1jqWy+K7/lSO8We1N2thQFciEBge9aZqzh6T5nqqUjVFyPbEIjVu2y1+qhZfw+nWj8i1iExNxSu1pTHbbLXmB2XAsK2CpYI85xcw9kZqD7RZhWPVdcL6oe4E6wX9EPHfSEJXQfkE9Ak4UR63mYh2HRT8=
Received: from SJ0PR13CA0150.namprd13.prod.outlook.com (2603:10b6:a03:2c6::35)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 19:52:50 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::5) by SJ0PR13CA0150.outlook.office365.com
 (2603:10b6:a03:2c6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 19:52:49 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:42 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd: Move microcode init from sw_init to early_init
 for SDMA v5.2
Date: Mon, 25 Sep 2023 14:52:04 -0500
Message-ID: <20230925195207.124850-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: eadab519-b67c-4c0f-cef4-08dbbe00ff9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEx9Fyt+yY08qq0UYwQN2QneMWRiAxavAGbUFHrXm1a4dwVCAlyuPNIpBLOsmRMCznHHj6Z1sUmMimvN3+1F43kxgZMgOaybnzlWswH6EI1/l0kfYSA/2qcggr+sXKEQrP1lrTGw+Dp8YVci5Lxl5orhK8kK4tssEnpz3txuvmoE4iEsjnsKrYojlOJwigHAyminaYXls83gNnHKId+YZBfz0uKcO7As9EdYvv3yi4WtsllZQyyf9XR01xYyfYWCgAJArAZS4eTzzST6qdj/wa/IO4lqmc8KmiajN9LkDOqCI6BCwQMSPK/mZ336CyzKgLFqNu/LK4Jf8zoww9D1/Y+AZF5ZPm4oz1pt0H3y967jqe5+n7gTWtN9EdEnK4MMZQiO1xvTFdydYwy9WykYAxB7VsIH4JkRR3Z11okbG3yMt2mEgBAmknisXJdC1NyZi0gHh+ZvlQaOF9WBGGm/KmkJfCMn0VUNokm0tC1uqfvH+55raSuIu9BTDykZZw1O4o63YISuo8U6B7PqEWI9+/kO+PSAeR106tNaJ68b/Nk93x1NlooAD+aKdEzj05rkYt+DGYYQzwxzxQquG85ZDz94GBI1+d0Mm8P/bhpzY8UvO1KODSPDWPkrgPY+loUdGhrl9wlnN7Pe3J39eMGz7KUwQ+P7WjKW3Sf/qXdhaPI3PiEin5SRmSqTJOzP6CZDjBIIU40rWIm2WmJZ41n8vVNKQA9Y8LJIwYNP8OF2P3zzHofuXCJFJfQ9lFO+WXmT2gtQ+/mSZN1RdWZbjo4gkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(8676002)(5660300002)(44832011)(40480700001)(2906002)(70586007)(70206006)(316002)(6916009)(40460700003)(4326008)(8936002)(41300700001)(36756003)(86362001)(356005)(6666004)(82740400003)(7696005)(478600001)(336012)(81166007)(426003)(26005)(16526019)(2616005)(1076003)(83380400001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:49.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eadab519-b67c-4c0f-cef4-08dbbe00ff9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
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

As part of IP discovery early_init is run for all HW IP blocks.
During this phase all firmware is supposed to be identified that may
be missing so that the driver can avoid releasing resources used by
the EFI framebuffer or simpledrm until the last possible moment.

Move microcode loading from sw_init to early_init.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 86661f9653fa..7d1e57189c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1172,6 +1172,11 @@ static void sdma_v5_2_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_sdma_init_microcode(adev, 0, true);
+	if (r)
+		return r;
 
 	sdma_v5_2_set_ring_funcs(adev);
 	sdma_v5_2_set_buffer_funcs(adev);
@@ -1231,10 +1236,6 @@ static int sdma_v5_2_sw_init(void *handle)
 			return r;
 	}
 
-	r = amdgpu_sdma_init_microcode(adev, 0, true);
-	if (r)
-		return r;
-
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.34.1

