Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03030C25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 02:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01159BCF5;
	Thu, 18 Aug 2022 02:18:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9D410F4D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 02:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpQragIST5K+YGfqxjMe/+i5ofFLubvI5///odEfYfRToWV4COC8etljK0BFVoPq2MxBo/aTmGeNq9X1VQ3W6O+UDD9mF+2ZCHbot1dJ8CfkLsPyFLb3CU+3m/hbQwd/ky7yLHj5imzBNIkqDZlKaL6oV30Z+QjNURJfXi87hyiVIexrY/DtO807PIIstBFIMGSWvPIIirWdW+E5EdOeHER/SZTWsqg3xsakLzvWdERNIHfJ9WjFama5A9bNjdT7JWsj+DQ7g7W1l7jmeoieoiM0AfDrHj8ofukN+PzR/nKnGZA17ezdR3wKZ9MJ0z7VicXdTuiaDxVhctCHWid7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUsOdKdjPJ1kjiFEKb7x4ppJEU7/3mZPWwSCVrC4nIo=;
 b=GjuYNayRLJCZJTYKguktZ61Nm1piz61AH56gQnu5dcC9vxQ+WUq+ZDa6+YSsIuHr7GUq2c+nr2hRYeYuTLvp+JTRZ3ZcGxv8k1PQBLD93qtHVqMcQU8oJMCAzgTBIihyUvxen+agSxXowOs+5K+ZaC9uPTjEYFcUhuzatBBcLCjUm+T9b2RW1F3xx4pdBLIEUe/U+qrl6FUElBR3S0qeznfRlbmYxSnPUmqn+FlIhAqLhgs+9NkvT8LhUnXhxPlXAkHsrVwHnAfJwLyEAMFnGEpykmLCQ2O8IIVm0OOGhznBI+QQKVcP98iFoJTkjCFsIGkuy0bSbQQ7NlArsKTo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUsOdKdjPJ1kjiFEKb7x4ppJEU7/3mZPWwSCVrC4nIo=;
 b=Yv5gybGT/siI8rebF7NmmqLn3yyb98J8ZiGzL0faZFSYZM1ptmDDgYgIlpFE4ox1bpwD49/vLt9ybzY+yInO3c3ndRo1P4AuO3k0Jsw+UEt1+6D+0nMLoQAHv5vrwT+AV+/6kjkPUPROVKcWguwHFeRJ+Lh+T0Aed3Wwo1jrc7I=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by BY5PR12MB3955.namprd12.prod.outlook.com (2603:10b6:a03:1a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 02:18:42 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::c1) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Thu, 18 Aug 2022 02:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 02:18:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 21:18:32 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: enable NBIO IP v7.7.0 Clock Gating
Date: Thu, 18 Aug 2022 10:17:32 +0800
Message-ID: <20220818021732.4087442-3-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818021732.4087442-1-tim.huang@amd.com>
References: <20220818021732.4087442-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90cb64e2-cb69-480f-79a9-08da80bff889
X-MS-TrafficTypeDiagnostic: BY5PR12MB3955:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k00dQ1chhBpB/adF41O9znbEw0iediahRGum6XmHpOMWgplR6VDvceVJnqgpBK8xFGFHO0SY0rxDGKrAR/wauJ3As3VfzNZw8Q7+L3vm29ihUjWEiRt3mYQeIGJ4JK3Ccel1zpG3c0AWkM0VHzIzzH8uyv0mwE3/a70fJVzINdNnZS9rpIIbfeZavbR+O1t/c+OrJDZr3wvncJmy1XFeG7IGr69oDzCQMLc5ZoKMnFlas93xHejQSMvxTCXRUuEzGldRBU8nuQbvaaqwqy8BPbcIi9oOyX/3GRfhhOLV9X7igWaAsmDosC/pG88jcSJDebAhQUaMZJIpjDXUkPRvG7+YxOVWsH9+x/1lLcM6yWiL5vxKQxGn8uZkkVjqTg/owmWhgqkEMpx/Dia+bAM12sjhCjIekgCg/LyJd9CXLUrYDmv9xenJccd4U336enUaIzPkfAuzKJpa6TrnT+O4b/vLjwoAIXr9M6eug2OxibfZ/OCxCGNq6LkFRAdwdM2n2SpR6BclCbBbBAwHmO5/G3uXNEDspAMZyDOdZuyBginrLOeHtZWbRF0dPnBNRfphUcKrPm8Xo/Ltd18KmB+FMpKMOQ1yDDa484P5xmW9dsvcsym0hUq/a10wIFmr/IPgTHM20+h9DybmrcigE0IOEzHVqbNWDkwqw113vdNcHLNRYIx7Ae9tBI9JXFwwyfn5HzecTUzhXuJ8NV79e0QOGvcx8smFcsQFXy9zR4vDWjV8foT5wBayT02OrZXSB6of3AnMIkjPAgKRGKLM79PMVwPaIVP808y095DdFxBsJwc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(26005)(81166007)(2906002)(82740400003)(7696005)(186003)(40480700001)(47076005)(336012)(36860700001)(16526019)(426003)(83380400001)(82310400005)(1076003)(4326008)(8676002)(478600001)(36756003)(70206006)(70586007)(6916009)(54906003)(40460700003)(316002)(5660300002)(356005)(41300700001)(86362001)(44832011)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 02:18:42.2277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb64e2-cb69-480f-79a9-08da80bff889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3955
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable AMD_CG_SUPPORT_BIF_MGCG and AMD_CG_SUPPORT_BIF_LS support.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1ff7fc7bb340..982c12964879 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -603,6 +603,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
@@ -702,6 +704,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(4, 3, 0):
 	case IP_VERSION(4, 3, 1):
+	case IP_VERSION(7, 7, 0):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
@@ -709,10 +712,6 @@ static int soc21_common_set_clockgating_state(void *handle,
 		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
-	case IP_VERSION(7, 7, 0):
-		adev->hdp.funcs->update_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
-		break;
 	default:
 		break;
 	}
-- 
2.25.1

