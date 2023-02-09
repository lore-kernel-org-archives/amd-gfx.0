Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943BAC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E15210E21F;
	Thu,  9 Feb 2023 14:12:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BC010E21F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evd/t68pWJfHqtdAdSsJMiciZ+H6dPlM+3u1ejEZrTYgMSoDwHzgylpbBB74r5UFhKXVDCi99/+08PYUwNvRTY4FJyG5aNeXf6OVByFd0gKu7x6CnlwAwKEGcuvXFdzUCraUNE0GQZPOGL1UojD2x5sAzwq8H39z7amCFQQtD6NC4LuMnmAcPGDJFHPqtsn4LsJ5fDs8ZdxtrghbFKAYsX6bGRBRl84cf1Ze2V/+0jRZbheOEpp81q/T4vtrctzYxoKulcIBP/uGwSwaJSkoofwC7qXFLrKMuFf/JjfVgXA17+3EAqpz+8fKZyzzQNTFmnZGe71YB58cCCSrcyMFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAtM/VKdoR1jeLeRWUS43GbHtv6znG1ZtsUgxyDGvqU=;
 b=F+xIImkc2jk650n4pp8ZtDbcVKxOwtHCtdYBz5y8t4Ywb+T/vzbvn0+J3xWeII3GmfpWF7Jd/gZSsi1POrwuIsR1jwnuwSjAjCas4zEAXVWKi28sA8Q9eBjM4bNpDQO51eqN4HMmeOUXGmGlF0avNnDF7Qn+kcawYtx71SAf9KHwN+fAeRR4h+w7wQaUaZtEJylQCyb9RrdjRjrkUVKieJvSK22B9vSA7hRizbR7AAeDh7puTpIf5CeeDC06nsw2I9hdZvQULPm9QPMS78iZd+A7j2jZDmmyPpS2hhmUuGPlIYsxuOrr5nuXDdJ7a+saqyhpPE7hkEP+fpqmexqflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAtM/VKdoR1jeLeRWUS43GbHtv6znG1ZtsUgxyDGvqU=;
 b=spExQAhNszhpqfL85+4cpFY0dC6ouBNWnqbYKgoKjKZl6/Pgx1uHAkAZLWL082SPLhTHDgOo6qzKZnfkuPnPj4NmPSPtXjMb1UckzxBA2AgKPf4QZ8h7XlACtggytarJLLAkjZTWtDWuLaAZD60i3wiOzP6pDTBuKblHQGHgzZ8=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 9 Feb
 2023 14:12:11 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::6e) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 14:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Thu, 9 Feb 2023 14:12:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 08:12:09 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] Revert "drm/amd/display: disable S/G display on DCN
 3.1.2/3"
Date: Thu, 9 Feb 2023 09:11:48 -0500
Message-ID: <20230209141150.612825-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209141150.612825-1-alexander.deucher@amd.com>
References: <20230209141150.612825-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|BN9PR12MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4423cb1f-a032-4881-f02a-08db0aa7a2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgV56zhcq4c+xK+n3eLBCKeAUMMNoq4rXLs3NkVL+ZoyPr2p7Olk/9pxpnaA7llSaa5HXAp7FFeZJt5rSKM3VNqCZwtoTYMH/XjnSVcY8DJT1mdHc3IxCFfaoCbvfJUIicJ7bA9rDHJDTsx4jvTvVj0I+EXnqKBoDyZIrg6TS5eFErAcSWYVir7y8DUfNk3T2jhDKkN+cuInMvWnRHaR3REOP7DcNVDSNmqm4EMMyhjlkysQKCiOSghPdLFxq2yEAT9GIV+9ST6am+Mo5Znxkjg9sRx/GHGzjKJqXXui9YXtdU8bj7E3l0BLJpmWqvcz7f08+Snl67cUFrVknGAS8sQQ58TdfgDYDbgnLd5eZi45zLA2Z75Rc098yb8/dQd7gFg5wuqgs/1o8ae7unkniz11iwPZsq9pis9wF+JA8wCEVmVNFgbpvK9PE59CXERuRWrXYv+8aNWuW3ePSs0xcxPEJ4eAVJwPr/CTa5RZTuOgI8E4cz9Y+XYqvnGCZIrSydgpw05SPF695N3VlzfjW7dLSUJY3JH4tEXvwavFloB5wbB8lf9X+xoJ7tOvOU+Y3yMuuwwbQhmX3VnVGZA8LOzqrtriaPemZtGDXhHBjO6Q8mHbeeQDXuOJf9CXQ47dpls6GFa2ZH1OPOXi9Ho/QtQxRBrHnGkV7B8KAjabhm+YRTPtqq/kO3N+OG5rQvRF9jEtuaF490VxoOCyIRcVMDerziNmVFr6iD/QGY8fGXk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(47076005)(2906002)(82310400005)(36756003)(8936002)(5660300002)(41300700001)(40460700003)(83380400001)(426003)(336012)(70206006)(36860700001)(2616005)(70586007)(6916009)(4326008)(16526019)(86362001)(186003)(356005)(81166007)(1076003)(26005)(478600001)(40480700001)(8676002)(82740400003)(316002)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:12:10.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4423cb1f-a032-4881-f02a-08db0aa7a2aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5368
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f081cd4ca2658752a8c0e2353d50aec80d07c65f.

Some users have reported flickerng with S/G display.  We've
tried extensively to reproduce and debug the issue on a wide
variety of platform configurations (DRAM bandwidth, etc.) and
a variety of monitors, but so far have not been able to.  We
disabled S/G display on a number of platforms to address this
but that leads to failure to pin framebuffers errors and
blank displays when there is memory pressure or no displays
at all on systems with limited carveout (e.g., Chromebooks).
We have a parameter to disable this as a debugging option as a
way for users to disable this, depending on their use case,
and for us to help debug this further.  Having this enabled
seems like the lesser of to evils.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1babdfaa789a..d22bbd6d8ba5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1567,6 +1567,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 				init_data.flags.gpu_vm_support = true;
 			break;
 		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
-- 
2.39.1

