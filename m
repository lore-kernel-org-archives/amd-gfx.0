Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD63C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1092076D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 09:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1cnyJ8At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1092076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378196EB8F;
	Thu, 17 Sep 2020 09:43:33 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690089.outbound.protection.outlook.com [40.107.69.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3BB6EB8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 09:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkJnirEvAye67qAtU5r+n0hevWhIL1h+TxiD0+ev2aIRauYTVSOssGHjuB0DEtkF+n12ordq1F3iA5mfB/EChIba3GOTPlIQozRbte10GxGgMVreUN9oqhCHGLdRQH1Ek8j5Oz0MC5xNAvWqAaLkyqP9J1Evlnp6CO5Bm55C+EzsA9u3tjiOVzQs6BHBWtWwFqzUEV2PJO2/KhZ5LnFZ1JmJjVzVY6ZCMkLOQh0MfSBS5foyQ3MJzyFhF+Yh8PAmek21CGCyekzqrg7tUdIvGE2omOnZHcEaBV/9k+eAcBQeoPJbkXxuZTc5NrYBo9T/SKUIWsF8Tyv9DUxo71bGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Q/ES23KtaazVkjEOV1XQmdLHZ5vb5ddxxQ31cfiAo=;
 b=afGk4qQu6PxLCVXop8I2vKgASqPDu7VWpCl/twOZUJYYOYnVnKzNmAqWI6hmYUHccoz7DHu1c8MET8NEi4rvMSSBrKsE4A9ctegHzVCzB8h/yAlHQnr8TlUvVgrpv+nGa8v6zWeux0EgEVIZGuZksA7mSZAOSS4SF1gtNmoWe1osh3VyMPG9hyccfC05YIDYxwa2PevOLffNKrNA98V0ZD1zzLrDHpD3TrA6HUPqv49M71E60VpfHmW7BG8ZNKupDY0JC3pYrLE83iC7iAvOh/0quIbFNz8mewjR6jvUo7sZcfB6Zt/ic+EMy/e/ly/YjDZy/uuTdN4jHea6IrUG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Q/ES23KtaazVkjEOV1XQmdLHZ5vb5ddxxQ31cfiAo=;
 b=1cnyJ8At33vGuv3vHuTiMfpmUWEehP1QTrwgrJWUzHDb1XzL2Gm55Pe3n3alEs+uDieWBLe9bcjwatAQQsj/GaxyNB0BGt8DAMlUAL8v7hiFlSm1Ae0pQfjqW1qrqW49jR2CTzzdR5rMhQOLEaPWa3DLX0tiQ66MPweDTH+UQlA=
Received: from DM3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:0:50::32) by
 DM5PR12MB1819.namprd12.prod.outlook.com (2603:10b6:3:113::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Thu, 17 Sep 2020 09:43:29 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::49) by DM3PR03CA0022.outlook.office365.com
 (2603:10b6:0:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 09:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Thu, 17 Sep 2020 09:43:29 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 17 Sep
 2020 04:43:28 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 17 Sep 2020 04:43:28 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Skip smu_post_init in SRIOV
Date: Thu, 17 Sep 2020 17:42:41 +0800
Message-ID: <20200917094239.1051328-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0142820f-1f2a-4fc5-e81e-08d85aee224a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1819:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18192E74DC12DD1AF7566BFAB73E0@DM5PR12MB1819.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BoiOZmHUWKxUn0nrW8qhYuhokG/4gM75UF65cCOBMPsAv+/Tl8EH9Y8EV80jAAZ6Hr0OmpIxmw7+17mSM4tJXpkCW1WAVk7OMT35r7TAMnT6/ZoGKg+xInYxE5lHviRRm3NMC5Of+/9SwIRMSfydA5tqSv6+1WPjPgTv32ry1mn/e2Qs1wVT+Vi+Z+CSL2q+yiNDHLugDyTJTeVamji6gsuWII50DbYvpffoeOF6XpnN33Oakot1m1qDW2XVNjpmHgf9SF5EfTQ/vfJtrQlZ3ez96PvYuRW1+qfK0FVCM5y/X5V/CNbvNGSQCT5LbOMJPfhNjWyLHW2hiPevH/S70xY0luFdh1Sp33CbRb14vqsyK6c3QEZCmjb3ySAUGuabPD95xhgLbw0cL3Kyj4Vfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(46966005)(70586007)(4744005)(81166007)(8676002)(86362001)(4326008)(478600001)(36756003)(26005)(8936002)(82310400003)(186003)(426003)(1076003)(5660300002)(2906002)(336012)(6666004)(70206006)(316002)(7696005)(2616005)(356005)(47076004)(6916009)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 09:43:29.6026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0142820f-1f2a-4fc5-e81e-08d85aee224a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1819
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_post_init needs to enable SMU feature, while this require
virtualization off. Skip it since this feature is not used in SRIOV.

v2: move the check to the early stage of smu_post_init.

v3: fix typo

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index a027c7fdad56..05cb1fdd15ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2631,6 +2631,9 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	uint64_t feature_mask = 0;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	/* For Naiv1x, enable these features only after DAL initialization */
 	if (adev->pm.pp_feature & PP_SOCCLK_DPM_MASK)
 		feature_mask |= FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
