Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF6C47258
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 07:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4B10E434;
	Tue, 23 Jan 2024 07:27:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8E710E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 07:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3yuW3a8SjimVCi6nVdWoPDvmYjlxCKIWOlRj26X43+1EApnKh0ielDH41QYIdZBvRkTq91G+iCdJPcfX9sEVVuOqC3ix/rlBBAZcTRhPzgqdJuy46nPPFRVFJP3emcezI7oMHN5yyYkEo+OUWIWFZN4y3Dux6wfMHRVTmLaoMr5mAJvff+hUioTe7Bms2qjaRKbe2OwrPU7Kh4cQsXeCxoTxI7iRBHD+gfaK0PWqjwFub2WQXwuupdz1rqX30BLrkazFtskI9aRCUO0h/FWo0cG0NUzsh3j+WASJQGQ5bRKPM9hZZVQD7L+YiyZK34oGm5SMHEJIsF/ZOyMlOhaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1apGp3hZdUapMVr2A8yIdgdWigfJM/PLvXU78AtrcBs=;
 b=VpHfbdIV5vu61+SG2OaUi+0vTzWdcqIZp3MOONr6PojxWFZSVTNUGadBulpw5bu6nb0F5UHmiASZQ4zUCjsl0yra5epND96bHF6T6wEWiTRa87wL3qE3qZyJyJ1hxuAIGU0ZcXwyqqwETkQx/YTRkj67wmJ1DCrxs2NdTFmlSmhhGucXAkExvdSbzziRQ8PKDYCJwZ2pq0wDaU0AnGu5KCYLH9yKQKt4U653NPZj0+eZkiLnxL5d5yBCoG18jCXgGKoS47PWpsV1K0KxtW+Mfob8EvGXwd87kvyT59xc2ZKScr2sgEE12qbFI9JaTKmmqZQyJ8pCrz52w5w0m9ugdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1apGp3hZdUapMVr2A8yIdgdWigfJM/PLvXU78AtrcBs=;
 b=gtjv52NsEWD/gIXouEPpjSYBgMzLKLf9PfIyet8vTeO84+yqfLPxHyvflW9Pe2KxqA5tNR1alYHd5Yvg4P89sf/QxmO6VgmYA5xuTQBa2cRU18957VRNX1PaMOWtLlTFTnajy4f3gyGflxIK0+vDkRg6SMkBZrROIQFoGnvPCvc=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 07:27:23 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::fc) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Tue, 23 Jan 2024 07:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 07:27:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 23 Jan 2024 01:27:16 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix return type in 'aca_bank_hwip_is_matched()'
Date: Tue, 23 Jan 2024 12:56:27 +0530
Message-ID: <20240123072627.358019-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c89bbab-ab8b-4471-dc8d-08dc1be4be1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhNwkCmX0Lu9cWG6nLiclffvqPZotklujaQF3sPtrp/MIsr5VklG5ZAEJKaiNpMDPk66YSx1XtX8+wS218QVmdx1yQynOm/xa5s6CscnDEgWZ3U/6dsHe+xKB0vtu0wfdhjq7DxqvEFEOvr7UoBmykHy6Pp6Kmtyueije6v1m1STjH/Q5iMgJlhstmmkwGiTU4sgsIlZiQunCXBury0e9P2LdIJIg3mDNimaxGi6isthJldvBYW46Hqb94x72yp42MznavGLYEJz+lupg9QmpHl97SmEcpnGVd0C/jsc0Iy8DNjnoJLbKrdLfgWImg8qMu+EFUslJBAOjy2surtonw+kpC5Xm37S13xvE56AK482KICmANZpGyt9P7SyKcV9qu2o4P2yXknIg7PjF/NDRw8lg0RkmlYHWjFfTj9on8X3vcz5RoHs228ZhSv5mBSebRFmMVmxrSapaJGoHjQ2u2n6rXOuLgBlWz5JynPSTHdiSb1U3NQOjOP4eOr9FNE4/HLgm+7v3KnFkDruYVr9PmnjsEHozk7SeyQRcQ4VIRxW1mV/IzpM0Ol1Z9bznUDQkrDAFo3BhtFK4pYIGGFnjE03LaKLz+8uCJuBqEQMX90wiOE5WrtPfF0Jf1sdOSznAvkAboJ7A3PrgJjh/tz5hfOkkpe3FC5u6PkKfL5szuqUn/tvX9vh1j5DD2J0rcV7fWADJQxvtXMCCGkQSffCDVDODU/L/UZbYnInCdKOglQdU4ijM5fjK7GDRSDCkjdq/XfSyYOJMhdc+nvt8C/Y/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(44832011)(8676002)(8936002)(4326008)(83380400001)(6636002)(316002)(81166007)(36860700001)(2906002)(41300700001)(40480700001)(40460700003)(86362001)(5660300002)(356005)(1076003)(426003)(2616005)(336012)(16526019)(26005)(70586007)(70206006)(54906003)(110136005)(66574015)(36756003)(7696005)(6666004)(478600001)(47076005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 07:27:23.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c89bbab-ab8b-4471-dc8d-08dc1be4be1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, Hawking
 Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change the return type of "if (!bank || type == ACA_HWIP_TYPE_UNKNOW)"
to be bool instead of int.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:185 aca_bank_hwip_is_matched() warn: signedness bug returning '(-22)'

Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 8a3c3a49415d..d2662f4d3d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -182,7 +182,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	u64 ipid;
 
 	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
-		return -EINVAL;
+		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
 	if (!hwip->hwid)
-- 
2.34.1

