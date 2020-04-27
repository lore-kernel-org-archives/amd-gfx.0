Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA3C54FD0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76142072A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 03:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GRS80HYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76142072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF4D89FF7;
	Mon, 27 Apr 2020 03:29:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0EF89FF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 03:29:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOyqkl5qr8mhXWGEuusJXpCNZSM/GSJAnKNl8/iWUGjpjS+pRFqnR1C1acoZeULV/LBBKqLBzL+juHNbtcxXnaLxLdG4acvOkp9Lxj30iw4jTERn0Rz6kyf3gZP/o55KTtL5Td7d0WzczAxui3qECM0L8PmgYpTxkV7n72/ewM/nm6fj3xLaW2lwxzZrxAi6z7dqsrat8dWgWbHFDRXgmxCjSjovlSdjGmZ42dH3SVnygFC/tFsCFPJxprmzUOYAcX1Uz+H/jFp1MOgVvk8ub8hwG5PRmCRpqFJrSwk4Z+Gd2GLCxT7LelMFLUF8TkLJdvh19aaO/VZNTW06xabuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92L+GqXcmXmZOvYyCJq0kSPw45bOLIM6BUMS5+QzfT8=;
 b=CNQaLlYjUF3xVGblr7n/wOgjQHWl/5VVDTPipfhsiTzVhoEFBS6cydMOnnZJnomWld1yUu7RUTAbm+v+wpg342kEhR+Rj8ntDeA91Mv2MYRwdhpaIjxnZrD/Ar+wIOsvr2OCzvklmkZwUO1DxPbtu5/g11WI4NNWnC5xkPHX4gDHE+zN6+mDS2Y/wjmuJ7t66JmwkcMb/W5WKqol5XTtdryFkzNQqiCpnBb1+5Gd7U+fb5DAJI91ydWW8+cmyGMQGJzni0TA8fm+cud/KxhuPhICtkOXKS05jMHa3L1/OMf6JQ8wN/qRFqoTYOYJeBm6SBls/DIFSMCAlE5RmMkcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92L+GqXcmXmZOvYyCJq0kSPw45bOLIM6BUMS5+QzfT8=;
 b=GRS80HYcJIZHUtmzeVH9AQO07PmXY4Fx5CVKjFAjBO3I5znRFGvxI1zQATwCwjy3hqzlOYb6z9msrCJ7PS+mYfTkpXwMwUWPNn4w4bRnahANpXi0k/AlQMtNsk0KN3/yiOUl6bmmV2yWPE6OZvVSqon65OXtsx948vddDrPkIrE=
Received: from BN6PR11CA0033.namprd11.prod.outlook.com (2603:10b6:404:4b::19)
 by MW2PR12MB2347.namprd12.prod.outlook.com (2603:10b6:907:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 03:29:27 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::fa) by BN6PR11CA0033.outlook.office365.com
 (2603:10b6:404:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 03:29:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Mon, 27 Apr 2020 03:29:26 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 26 Apr
 2020 22:29:25 -0500
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 26 Apr 2020 22:29:24 -0500
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amd/powerplay: avoid using pm_en before it is
 initialized"
Date: Mon, 27 Apr 2020 11:29:22 +0800
Message-ID: <20200427032922.13285-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(428003)(46966005)(8676002)(81156014)(8936002)(6916009)(26005)(478600001)(82740400003)(70586007)(1076003)(70206006)(5660300002)(36756003)(7696005)(47076004)(4744005)(86362001)(356005)(81166007)(82310400002)(316002)(4326008)(2906002)(336012)(186003)(426003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7020c7f5-ff1f-46b2-8004-08d7ea5b3001
X-MS-TrafficTypeDiagnostic: MW2PR12MB2347:
X-Microsoft-Antispam-PRVS: <MW2PR12MB234797A20CF3DEA5CD099CFEE4AF0@MW2PR12MB2347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-Forefront-PRVS: 0386B406AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riROcZYjyUxX/HSbvrQwgFilIyea/f5YiDBko+StDg4VHIuTub9da4VHbI3o5PNKrgHDvOXTKHKbRFiFoyr5Ct4yKTvLpqNKItBpHgEPI2jPV3FUm+7cF+K8sK5ybLxyPyCUZw6lqDAsDOrrqHyflmZBSLmxNMvSXw5iEkwWPsj2gMmGcRIaZjFusU41+gB7IANnXEn4qmmFCRUzftgxeZN6kzs752jMvTlZKZkfzRjTlBWOewYl+zQwkzyUjLiyoGmybN2lVyMtbzV4bZFOkIBIRgYnQ/JEzCjQwVeJOurk9rdqpXjFy9zUkloE6g0gHFTKTSA0cAW0s5KrFXMp4U0W0d+drDHyRjMldo4hRe5BcNcU8uKxViffy6pY+y0xL+nv5+B23rgjCLoMIqrLAUxyoUatxOl8iLS1PdvGm3ziQXVK0+Iw1o5RyZSY4yOpxbM1QC7YBXn1NnEilpFS6irlRvxCcFFOs+XOqHbEWsdAz7m6e2RuJgZBi++K4i6WAbuUaqtF9RA+JbbjbS6x7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 03:29:26.3683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7020c7f5-ff1f-46b2-8004-08d7ea5b3001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2347
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 764a21cb085b8d7d754b5d74e2ecc6adc064e3e7.

The commit being reverted changed the wrong place, it should have
changed in func get_asic_baco_capability.

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fdff3e1c5e95..71b843f542d8 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1455,8 +1455,7 @@ static int pp_get_asic_baco_state(void *handle, int *state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_state)
+	if (!hwmgr->pm_en || !hwmgr->hwmgr_func->get_asic_baco_state)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
