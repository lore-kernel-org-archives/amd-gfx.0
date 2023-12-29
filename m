Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B998DC46CD4
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Dec 2023 09:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A41910E0BA;
	Fri, 29 Dec 2023 09:43:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6860210E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Dec 2023 09:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neJkqC2Ddwv3BgjXXwqD3EEtfu3gggldaAp/OOkw5de4qEhBWX3xDUSBjps5AQvFeADV/ivm2KCNmViHAYDH/Kkw3sb/dVW3MKH9jvo1jMmFGpC/WNlX8EcKHd/H+TTW1fzcwTGl9W+/LUfzossWXTP3bp7OKFkZGS2yO1shUYeLlyLFyWCWKM/oqsQOWehBw/BDuLVl0SZ1Jl480Lyg0IadN0l8WQKaEc9NZckD5oqOUl/075vVkrwkcwwJM3zuQNHpjjjXKekfRpy2OAivaL9kM/zFF2lH9yKbrfTo1coU5WKJubezOKwj/CnKCF2IvLSrrfGM+xDGgXxw1jtcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGV5TktGOYadkg9//R8JRkWbx5QZVHnDPCK+O5St+k4=;
 b=W9SpNx3Te4zeVvIf2suH0o3wfOo4RKXlZETn/Cnpj+sK14pyKalAsI8WhTD2wi6rmWTWFnW5Qh7BGA5PH9WlaCp7e7fZoA10K9wJV617w9FKpjF21kkk3LIsY5QS3/beUPN1Rq19ozqeEVFZwAkXUkX0XFJGYpWoAus07Mopa2FUQX3TiAlirayareXVOf9PkE/FY2sveGTkNvBhLe26vY9bQtXVZIXCmZEoKKc9+ZXGpR8oASSED4fsTnOYd+fCTEe6OuFN27xIQQqcSSmzhtxCWQAkA6ikh1w2ochwCJ2e7sxUNmUgaqmksjm/yNSslBZQdwGxdfJL3oKnedu9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGV5TktGOYadkg9//R8JRkWbx5QZVHnDPCK+O5St+k4=;
 b=GFUa0k642Sm3lHFyoij5LsOsuXwQHA3ueRni5dNs8PzsLlzLp1yXaKnAaaz2MYe2topCzMijgc4XmcujzAKGY9u2in0RRgcs0xCDV/pklAadpg3LDyPbti59B2bTKHbnvt47fA7LeBHBDXHwa4VH4uoC220P09Pe0m4ccltcy8g=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.29; Fri, 29 Dec 2023 09:43:54 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::32) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Fri, 29 Dec 2023 09:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 29 Dec 2023 09:43:53 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 29 Dec 2023 03:43:51 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unreachable code in 'atom_skip_src_int()'
Date: Fri, 29 Dec 2023 15:13:26 +0530
Message-ID: <20231229094326.44657-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
References: <20231229094326.44657-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd7c837-7b64-4a6a-e932-08dc0852aba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teDS9+LOdtpM+RwlwHxV74F77GfaOVDeT8wu+ofjI0P49BUafbC5ynYELh9Y8/MGr/I7+ZTk/mTNRilchTCLIo2fvLv8D+3kzIb/bOFLdNPGzbPn9M9YSNWiq1g2JOJwAW9jPW4rDSQXOYe2pddAIMyEMqolielkYjlLgE1tbnARQjUoEBn2CbuEQzBlK4G0AuwlE+CJdelnOnm/OpCcfG9BGqdaKKf6U/w/V9QyTQwe5n4LAJfVGHeB/GTmqWjwzpnLAjJybYHzxQyLZ3mhKcSq4+g5RnUmIwpOjZUx2N5lpc7R2LRBYxtbtB6Fca57aro3rxXaNkUKZU2WllG2U6M7Q/cZ9b45pVtCyeo2tYHiJ7MKCOyhl6/YL6ZBix84nTlcuqqvMRj+ke/fE+bPHvmREA6+CDhR8eLemZ9TGvI9ZZIY8iaj/lmE0CA1JKl3tvM6JrZFxhuDVip21RdGwp4CBiX8TZJyVtIVo+0LZmBb0HeHigp2TiBHw6yrBgKesd+O5MciCJifOYSuuIgW3NakuLnuFCV4y5Q/AqszuIx01LlaIdX5qJ9caq2mfIljpwfTljiO3lTNFv23P0j53Stu8bsQ2FW6c/f4QQA5w/YkRwrUWFlEuxTS0UstfVlp6OXWLJIaslUArwGsOM9eCv35QLO060Qz6IYPMy1kSVtIqKLRXB8Kq0oEpFOJlMlqsa92FGhn2H/285st8iPVa/VRCZ9ofmey/t3iGtszxUaEmzsggQiMbRQGJudVriAwwNDxE20erIdoQfaGTaprnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(7696005)(66574015)(336012)(2616005)(426003)(1076003)(26005)(40460700003)(36860700001)(86362001)(356005)(36756003)(82740400003)(81166007)(47076005)(4326008)(8676002)(5660300002)(83380400001)(44832011)(6666004)(110136005)(316002)(6636002)(70586007)(54906003)(70206006)(2906002)(4744005)(8936002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:43:53.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd7c837-7b64-4a6a-e932-08dc0852aba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:398 atom_skip_src_int() warn: ignoring unreachable code.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 2c221000782c..a33e890c70d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -395,7 +395,6 @@ static void atom_skip_src_int(atom_exec_context *ctx, uint8_t attr, int *ptr)
 			(*ptr)++;
 			return;
 		}
-		return;
 	}
 }
 
-- 
2.34.1

