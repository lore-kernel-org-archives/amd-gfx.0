Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5337DC04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 22:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AB9C7AF8;
	Wed, 27 Jul 2022 22:19:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F9CC7989
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 22:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imc1fqR/mKrpdkCpOL9FFytqa6kp5WOr9i3Cugts9DmQJ9AhufUqrMHf6kf4gKSvEqLZhrXdIqspWFVnv7nZ71er5XxI5n0tDcekm+RAQ2gYaRUuL8/D3M/FAoie+NxbOZtYmaemHOTptTmebg5og47qBf1lmyXOFl5JYCixqwcGqQfAtAsiisxb6RXzaMYN5IPrPh0md6JtrxChuPqb+62quF4bjUcowT0A0RZIfwyL4ldXPcgDMdRyCBS2eza0/rZeP25asc5i3J70syGPDJt4eC5u+C8sdFCdO0w3xmuU4AK0bXYm9Baa5b0ZyDakAuAV03aOkWQO6CTeGMCXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdjwgexnK07UuHONb39nwdSk0Ov+7H5gQeoNcLMLPds=;
 b=FXLL1xnPvgYe1f0MolhLLVgL3JUSq/npfeF+/A12l853cxkstC7RQpRzCezwV5hbj3YuODL9Ja0kA54LDFawfCytvhrmh4vM12iOfvxLgwaxo4gZAJ3yzLtLrc4YqxG9VhNINjHBbGuq0cb4WU5bVxbS5tldqT+lxPGtGwzuD3YkdynTlGLADiVGTWul1HWc3eRpA20+XtVM/lyIpVw7o26Hf4uxQFaGcZvHphGaUhgNxcu2hItYyvMk+ZAilXDQQfKkpICC3ZbsI0Ym7HiM+mruUxc56PCI9hRTWF+9d65KVZkdX+tpR1VJkKebJkoLiM657cl5RJAUUhcP8KJrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdjwgexnK07UuHONb39nwdSk0Ov+7H5gQeoNcLMLPds=;
 b=lJ7GnLoOS3GltfAmLDTvD7v5DK/gYGaIW2+2jV2bdfwGdKa/3Ait6axiNQAqzLriZ5xHAlbGCdVRKMYJdn2Fim1PZfUc73cCp8KIRSSZchHTBKrnrEj52Mu3zu0V4MR8BnHZwZlA5+6zPmZuD36dlqVmIj4UHR22OHgb66Q6w8c=
Received: from MW4PR04CA0239.namprd04.prod.outlook.com (2603:10b6:303:87::34)
 by DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 22:19:22 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::15) by MW4PR04CA0239.outlook.office365.com
 (2603:10b6:303:87::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21 via Frontend
 Transport; Wed, 27 Jul 2022 22:19:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 22:19:21 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 17:19:20 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Revert reduce stack size for DML code
Date: Wed, 27 Jul 2022 18:18:51 -0400
Message-ID: <20220727221855.324361-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef9f5d38-72f1-4841-2cae-08da701e0e7b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDBUn1bHWCoX8lQqnTC8PUrxYGEgk1Y4oCoDHZa7569WYyWEZy6AGAkr+Lu4ElzIyivy4RRGgvcrFdp4sKcq9p8zmQTBYmJMsIb1/+n3kzjTncY1mIKhfp8T50Py0H0W8Kqx+BogbC27KSIhsGnlai7lwmxCfX24VkY6p23VnfX3HjpjQhRcJjlwpzw0KYtDSNXjQaZmF4PS8FeKIU6c7DR2AsKZ2UkJJPv0qgsYqMsViJuapyBdoVelrqj4txDCvYcdVc52Vd7eC8gIYBfg6D5XvfiaCNfx7iqnO0dYVXhN0H0d5eEErPYAKb6dOc1JyWS9kUWSQlwrnh6gKkHmlTK9vaqrphoDvN9GJmqEeOkdG7t2j6RDPy0xRDuBQG0+4pJe+EiWyLaNfvK0+VbKZyiMSjkORfWvgxa1CgyopX/26wkf2IzqdY+VHCgqO54mvHU+wX4Tpi+XQYXqQtznFM5/vcO1+hK1UUTCP4F5w8Ypr58Bs8nECyrWOcV9FVvY9bC5QBpayIVka4MYKfiW5n9FPS9c5Qiz9aU919gd50NYup6PjTvzfh4yvbdDW9AD95okxVSOpa3im72UxcLGnZkES/b7AVcCG2//S0CRh716byM8oaYtFrEjfgnQNaDPHZNuC3JARHjGGY4JDxVxC9NHeN7D5VT+Oz2QPSxANKo2xRzZItBoLoEnNlSdWulGZ5ha6wdSvc4v9JhsANgJxVHM1COdCVatr+vkaIOqu08QfaF8qynbvtDhQI2brvYk1QJcomsLqe4fTcVnz+X4hVBYgCtf+elplyw9t5k1ssHORpUdRzVi1CW0MP+81yJNIhDaRTcw8cAuudDSMxL2DA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(7696005)(86362001)(186003)(478600001)(1076003)(6666004)(81166007)(41300700001)(316002)(83380400001)(47076005)(82310400005)(426003)(40460700003)(16526019)(26005)(36756003)(336012)(19627235002)(6916009)(54906003)(36860700001)(70586007)(8676002)(4326008)(82740400003)(70206006)(8936002)(2906002)(2616005)(356005)(40480700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 22:19:21.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9f5d38-72f1-4841-2cae-08da701e0e7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Leo Li <sunpeng.li@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We had a stack size issue on DML, and we tried to fix it by moving some
of the local variables to some of the DML struct. In this process of
reducing the stack size, we sent some other patches that fixed the issue
reported by Stephen, and the below set of patches become unnecessary:

987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration

For this reason, this patchset reverts all of the above patches.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alex Deucher <alexander.deucher@amd.com>

Thanks
Siqueira

Rodrigo Siqueira (4):
  Revert "drm/amd/display: reduce stack for
    dml32_CalculatePrefetchSchedule"
  Revert "drm/amd/display: reduce stack for
    dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
  Revert "drm/amd/display: reduce stack for
    dml32_CalculateVMRowAndSwath"
  Revert "drm/amd/display: reduce stack for
    dml32_CalculateSwathAndDETConfiguration"

 .../dc/dml/dcn32/display_mode_vba_32.c        |  12 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 812 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   5 -
 .../drm/amd/display/dc/dml/display_mode_vba.h | 106 ---
 4 files changed, 441 insertions(+), 494 deletions(-)

-- 
2.35.1

