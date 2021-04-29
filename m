Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB28C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712AE61447
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 06:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712AE61447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E2F6EC8E;
	Thu, 29 Apr 2021 06:29:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECB56EC8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 06:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8JU+d1N042CLtB9gndSx98DK0YtJvPIdwOPWvMoefuD8NSooVA7vQYeKNkuJSukUBxL9F4vY+fI8WFW3r8CbFqE/mNQt3FqrMq9cKRnTKBcRk4bukUdANijcfl+Ys2YQqnFm0kl1yNaXwwyeRfek/JC77hM8QaoBYoj0HeK8BzM0Z+a1S13wEbzPRZ3LadTvUSr0MR+DKjFLnVx48Krm8AHQb6k1dl+60gAHefe009QWcZyDkiN0yMirSxGA9Qs8LR1YvsBXlgYp711wRL12wSA4DXCvArG2bRek0mWDUydsftAjlmjUyVFSYHeqxvKKD9TtXrreppT2c2oPkqv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIxz0khDeipB3XWI1Pd0yKpSsotz9lbJIOD16x/u35Y=;
 b=UCQITL/7u3HtoL2RLtewcGjyv7k6dwG/+f/uZTIXOO4weO7vAVSwuUwuU0egOJ4SS01VZRfYm//JmUvjPxenfgjW37dbCrC1H4/8xoHMWOxUt8zkuZn4WlmD3AfzrIBqdzYAjZ7vrH+mhGg/HL6G9tj3tzd6tKUunmUeyH1CobydGRPcE8d4OCNTRuOaYWm0JekDfBwWv5JiRNCCS+ONvMPY4QtKXoRKEhlN0YsL1WGJ98Ejje3x/cxFcowoowRSyutrg8iUbpEvuITLpTBD+9/QhCcfXeX9tzHEbxRvQY2Kojw41Z4inO3OKsJMMhEUZmNv9FAbH9SlAb8Zn4abkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIxz0khDeipB3XWI1Pd0yKpSsotz9lbJIOD16x/u35Y=;
 b=LmLRjNnOc30g5cFoU1NfXviK08NCRUanDVbJ7EbrTvGPSrQsmW+iJZ4C5+Z+fiQFFPyq4wnZakFNl3cYuK0Cmu3zY1kVXMbFItwaJphZaBViiQUm9YxCEMS8klDYH/zWuQ0i5ic7bN6JESqi1lEQh43HartnBvRO3vubillDe7s=
Received: from BN6PR12CA0040.namprd12.prod.outlook.com (2603:10b6:405:70::26)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 06:29:37 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::8c) by BN6PR12CA0040.outlook.office365.com
 (2603:10b6:405:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend
 Transport; Thu, 29 Apr 2021 06:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 06:29:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:29:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 01:29:36 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 01:29:35 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 John Clements <John.Clements@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable gfx ras in aldebran by default
Date: Thu, 29 Apr 2021 14:29:32 +0800
Message-ID: <1619677772-2899-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051ccd35-2937-470d-c96f-08d90ad8296e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3463:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3463B3459A2222E6C3AEBDC2FC5F9@BYAPR12MB3463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsqYwClLAY+5eNrAdLrIKNwTth9uxlMK4JB89/zyoBGAO5Te+Cw51RaVXaUPwQlVyJ6zVwvFU+zk6XsuvjderUvHAhLmSPNjcjK6xUnNdwvrn7iNfilyAhLtv0e1Me4j6UgvwZ49kTpRG8VpwtYMxmlkDCQnKagbGuBpTCFbvRcEEpJXKRS8pF2Xd+1Z6BTkiRDV9BfuR8j1616v66VlpGoP8CNAnFIpjTQVjOznvXaElOoR503AuOZpfZI9P6Dv5QgljcKqTIwSfFMVybgrmmMF/nDHfUScOajqtWVTs7OEauYJ43/RAtOwc2T3vMxvTx3lxB4PF28wLvZ+I1sAYQns8G7OWESg4ox7X9IVOL4gAK9jZ+LfAxwCRoxpb+3xQHq/ErlixbVbNmYbrZaZppmrp7OJBXkDJKReYrBgRx9oZY2lXBL19hDPH0T8/+Cqtt+/U/P8Y0v3N1Ed9cmAxrRuanpi99FmESgWz6z2oDjQ0TmDGjUpnKOTJE6wuUZL/j3xlcHLv+jE+0xZbegKMfRZ0zBouNExtRbfaaAcPG7PGU66HjgM5QGgBbx7zHZoOMOU7FTi1p4QC71T3FZiO6HwuyrV1ZpNpxA4d+hMDB2yJxkEq5i9cd4/pEG5lDhccgXshHhz4DGJed+NOwlFvLMisQXsHZquanB/Y3qpbcAOkRR79euB2ze8MlZFbDX4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(36860700001)(4744005)(81166007)(82310400003)(478600001)(316002)(47076005)(36756003)(110136005)(83380400001)(26005)(5660300002)(186003)(7696005)(426003)(8936002)(6666004)(86362001)(82740400003)(336012)(8676002)(2616005)(356005)(70206006)(2906002)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 06:29:37.3536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051ccd35-2937-470d-c96f-08d90ad8296e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx ras now can be enabled by default in aldebaran

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 984e827..9306e39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2101,7 +2101,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__SDMA |
+		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
+				1 << AMDGPU_RAS_BLOCK__SDMA |
 				1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
