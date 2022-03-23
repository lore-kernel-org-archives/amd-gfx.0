Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB97C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ED189DB7;
	Wed, 23 Mar 2022 11:49:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEED110E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ0AMkOLRFP1jhS2Lw4phrUXob/6hYjw+bhPXxMjRFVhpmo22iJAYGjyb82A7IFqJzkTlKuL5CuoxnqWEwtsbdgvGB12u9PWcCtN/VK6vSva4dv8zpAXje2iG/w23tbFI5QSmy7WWcDrcql2X6Rh9mRLS+kqj9FBd95pT8rNWzZCevecOhdRhPbC9HQCt/yW0FFMT5ZKZubDe6qfLE5JLSMJGQ5r9eaa+VQvCKeyb2gv4aUeFntB17otQCKLoHYQCZ1H2/lobPyxfgLc/GhVRBWK4GmrAHCpv0wcfi34vxj8pzMrgSN0IGDXw2kSI4K59P8Sjq6n08rMRTLaELYrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=453GLAgP3qR29ALIA+rdCERjFYaxfZTrqnNMJAJ1OV0=;
 b=P35tZE/P9aWcwxB91181DtTOXeJ3JtLDLN6vaKewG832JLQeqTcpK/W0kDbrV/ALesFW63vc5fCEFPEfTiQPBGdp9lnsDOpY2UBNbH2NRjnKDxWsNS0jw5809+qk6YyRDgcdk57oROIKfI1/AiUmGluCdKJyEUKraBKmmCMY+jq/oRp+Fd1JkS0s1dLTJeNZeSW8aobHVAt3Jxpob9BWw36mVwp5iZEfIK548b4uCKkdfqQDBa0X0qk7JU6wy1rpGM6JPogkZ0mECu3EZBRjbbOcqfd7NQKNKKk7NPdH+umLumfDwPA1PBTHZa7fcEWs/mHtVAYSFvTGMU68hKVLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=453GLAgP3qR29ALIA+rdCERjFYaxfZTrqnNMJAJ1OV0=;
 b=l82s7L9U1n44M4kIOHjLCUWIV9i2oPG1bHKPWLNPwnlHuSKzBiDe3119jaNEttslQEsPNUquFjqcusMSP68hTlXTuTTgl/y0tg1Xk2MArtWhNmBv6zqjU3qqxQsdpgaW+7Lm5y7cTp+5ybPbYJEMNlqz6DwMa206NAbG9RHNFe4=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 BL0PR12MB2452.namprd12.prod.outlook.com (2603:10b6:207:3f::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Wed, 23 Mar 2022 11:49:14 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::36) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:13 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:08 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] umr: Rename "scripts/umr" -->
 "scripts/umr-completion.bash"
Date: Wed, 23 Mar 2022 07:48:37 -0400
Message-ID: <20220323114842.78516-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220323114842.78516-1-luben.tuikov@amd.com>
References: <20220323114842.78516-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28ca318c-2aa2-4be3-fc56-08da0cc326cd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2452:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24524A036B37C88681D063A899189@BL0PR12MB2452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltKT4taufP6llzzQs8TTPfFY5aW6TUvK6zCbXcmJ5G1mS1BXDFCHBAe6o8ImRk7oYwt3lgKiyMPAu1Ujx7qbRZd+6VLHQCpXNVMwzS4Aw4BhHFzP1V6TQ7mX9LlGkYWg+h7FgkyF6Q8bz/dbGQfTz2QAIrzTuEi1zXjYglLTippDd1CBmw/l6mwXvU0L1jx/F/L7CDOnmc3DmofZcO1nmeW3e0Xpr+GW5ICddwg0ABt/JLTAtCM1T6robn2w4YfsEdiU9suSCPwgf1pD+T/hO2S+RqXOb75wWnbVvPaMC7N8u3ag8YujAv5lafnsnuqAweGtZmq6Te8EH3Hf8eF9JhgOu9NGx3h6YHfWxtuliJ/X10NahWa48i25H+adK2WUAfvCB5TynkMlo1/hlMTHzxTBEJoH8jZlUR2aLdov2XR/uH5DWQJ1oEzp00O1YpybQ09mWZfIiumE+0C3x+DJakpALzjJVceNKPUAIV3Ej2YjgPgDqj+eRUFZ6uvCeygV3AXLqvxaV673GHzyEhRUoyp1Um8c830A5pRWAGicY0s170N38mnJ5vJgdKq8+BxjJQNqDAYpOtWR5uJ0f94h/H8LYCpGhSP7Fntc5D18Ud8HN4nYa6mM+Ri9ZufFWUMv/61jY+kB/y/A61syYcENXAgp3HJAO/jdlrtgLtv2mrc9iNQQokcSn42s3U6WCS/kJwDqTQugMW+4m1+d6r6FrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(54906003)(6916009)(86362001)(2616005)(426003)(26005)(186003)(336012)(316002)(70206006)(66574015)(4326008)(36756003)(8676002)(81166007)(356005)(1076003)(40460700003)(6666004)(70586007)(508600001)(44832011)(36860700001)(2906002)(83380400001)(16526019)(47076005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:13.4598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ca318c-2aa2-4be3-fc56-08da0cc326cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom StDenis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename to fall in line with completion scripts from other packages,
e.g. Git, however the completion file is still installed as "umr" into
the destination directory.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/{umr => umr-completion.bash} | 0
 src/app/CMakeLists.txt               | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename scripts/{umr => umr-completion.bash} (100%)

diff --git a/scripts/umr b/scripts/umr-completion.bash
similarity index 100%
rename from scripts/umr
rename to scripts/umr-completion.bash
diff --git a/src/app/CMakeLists.txt b/src/app/CMakeLists.txt
index 6d15d67e3c021b..5087467d70d6fe 100644
--- a/src/app/CMakeLists.txt
+++ b/src/app/CMakeLists.txt
@@ -77,5 +77,5 @@ endif()
 if(NOT BASH_COMPLETION_FOUND)
 	set(BASH_COMPLETION_COMPLETIONSDIR "/usr/share/bash-completion/completions")
 endif()
-install(FILES ../../scripts/umr DESTINATION ${BASH_COMPLETION_COMPLETIONSDIR})
+install(FILES ../../scripts/umr-completion.bash DESTINATION ${BASH_COMPLETION_COMPLETIONSDIR} RENAME umr)
 install(DIRECTORY ../../database/ DESTINATION ${CMAKE_INSTALL_BINDIR}/../share/umr/database/)
-- 
2.35.1.607.gf01e51a7cf

