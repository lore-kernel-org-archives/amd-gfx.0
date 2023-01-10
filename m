Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1562DC46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 15:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D2C10E5EF;
	Tue, 10 Jan 2023 15:44:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9154E10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 15:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6KdEwfNCOkCdaa4TjmmCkKLDOxsbRPwq0N8GvRBTWFIjt3+dyB6XcS9/3ibfeSGQPKGTrhujXMceljSsJZpgcAXbd5FLYou5kXjYP8ObyaTuAOnz6jGn6Yh8J8h1cI00mBnvwlN5QySuMR1x7jFb+gOZXKkJ70S5P87b+3x+lwtRxvOufqtvaP+a/CL/SxeafJAmnpq3IVkT83T6BIBXfolp8nY8EgjESab5oog+8A/glexWq4opNe46VuhrjGEAb1sTswdW2gbrJgFZlQ3IyAdEe5RR5ybgdollKSo0oLHZDAnRqUT6LUDrOlDcDc81PCbcpZyxMm3XtVipwtIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9NxnTSW4/BtUFsuFLfDGh1+fkex451k7xgJuEFHp/k=;
 b=CidMgVmFmcKEe1RHShxr6QKjEl7Ih89pOp+oQy2o/HjqF+uktrkxMUpNFWc6lZzYkperwoSqUdDfDfNCVL/ehyzTO+WxgpedBdKabkRfrCQ7f8lqfgA1Bnqk/D4hmDy94zhMDm57aZ935fyTtQGGsoa0FC7cqp0tSB5QTp/s3qS4NJkm5Rdik1C0xNSMzHQx13SLV58RgVZjPCQxwA1bHlWE6l2JQkZJeDIlF+0+w4NEWwNfAw2UjB9t4nYsQqLzUjk8fruIg156gqlJo66yAMFPBhMF7dYH+v4eoOJIKJhzLhgfdj5vdhCnCv+qAVHr4p2SCRO8Bd5l9oU2izgvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9NxnTSW4/BtUFsuFLfDGh1+fkex451k7xgJuEFHp/k=;
 b=3SZxcW7Ifj8xB8oKL0HRlgdzgLWL2eVmoE+FD66bbrO2iYZ62iC9pUQe79SFce1+jprZ0ylRAW51DIavWuNnA0EcCzSY58dOEcON4EvhgAnPjgvhVmKqScwx5cNda8y4eskpMD8c0wOTEMBR/kceALcL5zCJ9WLNQ1SO4dI1ry8=
Received: from DM6PR13CA0063.namprd13.prod.outlook.com (2603:10b6:5:134::40)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:44:50 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::b5) by DM6PR13CA0063.outlook.office365.com
 (2603:10b6:5:134::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 15:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Tue, 10 Jan 2023 15:44:50 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 09:44:45 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 0/9] Reduce stack size for DCN31/314
Date: Tue, 10 Jan 2023 10:43:16 -0500
Message-ID: <20230110154325.3350916-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8f7b77-4255-4728-3935-08daf3219c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zpWVTowqRsajfTXcAyjdDrH0A39l4Z7anAdeJvFKLk7XYutd2cVzhGJSuziE0apbc48/uZcfG7SR+1RZik59FmikSLjbFSBpL9Tg5LIgvDhs9REBsunQ7P9FZUka0tkvZmfBCTBInPxe8H+pU+e3utsGDEhKm/VyKlK3X5Ov8BXWoEPHwoG2rrVJsK1D/GjwWYSJedaBd18ZpetRZaBwmn3DA6nGwFDePg/PYWM3g4lezqhBX8w5JUhFfvZJIC7eneNMgWupXP0nir4cZ7b2/ueP0dpKlZXey0z1z+6BKJvh57XYtIGZj4pdfiudI//QUCn7OjKUIXkqCRABZ3ZM7DIhAHsACYsqlZ9RaK5LVaxhtYqw3ESonLF1rci69tKwandW0aFJONcSKdUKZj77t49PQfgtCtCbqyJxuZKxR/fmSZLhPjm5cR/XEuVaprgF8ul5zZ9q7pZkGmldCeCeRzupTAy9J6CMtj/lIrIXGngOeK5dWm1xYQTaiuFsIDFjFq42OhGkVE1p+cYortTBKtxJWGRGQVP7i6H7uprGNQzphLTb3+7e4EToLrwW1qUB7PJcZ8rdm9Cpj2J0yQcLMGJ+YvYbe4jcuwDhUh7UGplwmWKKGtAHG0s8H3eE7cuvaDLgw6zC8j0kWALkpMujvfcs/6KTgOliA4xanR75xcCa/ZIHvY4UwOinU309zauKimgerflmaxAJWeBkBMdciYlH2YqkWi9DuhrdDk5wxeUGvpzi9kr928yTt/NzCI61jHXtde4s+LNf2LnnKHNNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(86362001)(8936002)(5660300002)(40460700003)(426003)(47076005)(336012)(966005)(83380400001)(82310400005)(7696005)(478600001)(1076003)(26005)(186003)(2616005)(16526019)(6666004)(82740400003)(356005)(41300700001)(4326008)(70586007)(40480700001)(70206006)(8676002)(36860700001)(81166007)(316002)(110136005)(54906003)(6636002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 15:44:50.2361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8f7b77-4255-4728-3935-08daf3219c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx@lists.freedesktop.org, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Geert Uytterhoeven reported compiler issues in some specific gcc
versions that point to a large stack size for DCN31/314. Unfortunately,
I could not reproduce the problem with the latest version of GCC/Clang;
but I still believe this is a valid issue. Therefore, this patchset
attempts to address those issues by moving many arrays of doubles from
the local declaration to some specific structs. The first patch in this
series introduces the new struct, and the subsequent patches move arrays
of doubles from the local function in favor of using those values from
the struct.

Geert Uytterhoeven, since I don't have a simple way to reproduce this
issue, could you run the CI in this series to check if this patchset
solves the issues?

Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20221227082932.798359-1-geert@linux-m68k.org/

Thanks
Siqueira

Rodrigo Siqueira (9):
  drm/amd/display: Introduce UseMinimumDCFCLK_vars to reduce stack size
    in DML
  drm/amd/display: Move two arrays of doubles to UseMinimumDCFCLK_vars
  drm/amd/display: Move DCFCLKRequiredForPeakBandwidthPerPlane to
    UseMinimumDCFCLK_vars
  drm/amd/display: Move DynamicMetadataVMExtraLatency to
    UseMinimumDCFCLK_vars
  drm/amd/display: Use matrix of double from struct instead of local
    variable
  drm/amd/display: Use PixelDCFCLKCyclesRequiredInPrefetch from struct
  drm/amd/display: Use PrefetchPixelLinesTime from struct instead of
    local variable
  drm/amd/display: Use DCFCLKRequiredForPeakBandwidthPerPlane from
    struct
  drm/amd/display: Use DynamicMetadataVMExtraLatency from struct

 .../dc/dml/dcn31/display_mode_vba_31.c        | 49 +++++++++----------
 .../dc/dml/dcn314/display_mode_vba_314.c      | 49 +++++++++----------
 .../drm/amd/display/dc/dml/display_mode_vba.h |  9 ++++
 3 files changed, 53 insertions(+), 54 deletions(-)

-- 
2.39.0

