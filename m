Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF6C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DDF10E0EA;
	Fri, 20 Oct 2023 21:30:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F32110E0EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGSvNb+UdxNFQSZb9/0oOGVT5yqwewZC6f6e9BwZIA7/pKqFvGjQ0em430J+ihrNxNwf3is1AvH8akeHiMARTDlV6t0M9XNCaW8tg9kvpaGm5Mykr/EjjDr7f8AXIoY9EnWS+U8N3D7LDEjOhaFMqykoQrLd/38JFrNOr2q15FRFCXb/SboUw77LjQAWrdTJpZfiiTzOZpdLBeUaSztbdRFzrEK5P2vFAAVXd5R6TyKqHn1PyDF6ZasH5+ucts7xhGX3FbfuqShaW2hPxZUkD4Td1EmDMkikJ4RMdoHrVbyrY9HxTYFuAcj5zwxlOtZcDjU+Mg9CI+X371nCQyCycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SOwEK3sxrLZVhIKLLeryA7FsiR2dRcc8clxG84TYmU=;
 b=Aj6n1uP8QydASUOKkQXQt318+SERghsZjAz6tqYGX6lfIqiW4C0dLcpf/Nq0QGDGbMNgXdkrb3ToT35DzI3aB+KgmYI1kW3NvPB2mo6vMxB8IcuLB5xAKgfADdY1gFZ/F//o+qKf6GI5WXNcjCOgQm8iw0UslJ/0juZ1bgqxJDi6v2hZ/EETL4NGAU2yVar8woq+7qJ+Qq+NOIWZjrkd4J6wcedbpk65tImvCr65Lf1J+qcKJGj/4gqIsZ39CEsVSswWSO8vXJDoYQRmfQ9d0OBKy/cj2dOCUMpg1RlVRWWC9PjUnj/gVhu/fvYqwYLyaoeasQ86yOIWfPUmJS0AeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SOwEK3sxrLZVhIKLLeryA7FsiR2dRcc8clxG84TYmU=;
 b=MpPWK0E9sGeBO8VwiIxQb0Vsxv5JB6WuD0X5D2Le2vYnMNavvSRbckfVOS+I4oQMQFxcnjz/WCrTgBVpMckFVRKplV/sRRaQR91NqOwN22GgcGlM4mISt+tFP/AdmB1wqHXvXDjTkVhWYr0mmEAd3fv0z3fEmdMPbUDzQ5MXxq4=
Received: from MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Fri, 20 Oct
 2023 21:30:38 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::4b) by MN2PR04CA0013.outlook.office365.com
 (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 21:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 21:30:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 16:30:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/2] Fix issues caused by DML2 in ASICs older than DCN35
Date: Fri, 20 Oct 2023 15:26:32 -0600
Message-ID: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 66864442-39e7-4a63-2bbc-08dbd1b3cd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: engAn2EKrjp7ox0rpobq/BGgCLsUOU9TrPvoBg7/VqxsYfU7bESvTJrYpKqPvWW8qcGw2glvmWFLJTkodd7zJH+uMcCMrAXNySDeyAqM4V63uSPEl9FNUICsd2aWYzfWE3wI5Q8H/Bw69KDd4l7yHYYvPpoORQYIigisBi5Q4dPFnw2pNldR3Avd5ZBRu50x64LPG0tQKldiKC69CTx8lR+CpEALCOE6HDhMS1zgL/oc8j6htCdoZadKmSoPQyGKHBz7b6+3+ay09i1hyS8Ylv6LR+1HzVH0vGuzjI37gRmzFN8FwQckmjGVh7SFgGRtxL1FE7O+eC8I6jX1U2bOVZfGQmOoDYShB+1QRIMvuzj7oP5NZIXv1o2GttEr79Yszb/I/FJdZ5ZvA7ZHlCdBWkKhVFjrV9765P6/nWpmvXTYYKfcoGZ1/Z01+8gZaF7wATKXI9C3eyOkvmHP+CvqDOSumxB+Z5vcBNtnaqtUNTpo+QkT0N17A7nsWyrDmQfidTGPLalr1HNx2EZKa/k87wYS+D6kIq3r5KvRIDpcPlZn5gcoOS4HSBGVwwdRyg98JlYUHCFIr5ZzYRGPvbhjo7vom4kEivuvc0/y+EQR5p6TIwn6AlHb3BItgWk9G9GtNVVgZVv0D+/WdOl9oo3pFXUt6C7j0fszUsSkyXlWIYpz7aPwbFawu8nnktNSLMKyRgC+TaIwba3Azu0Xhrd4Y2Q7iZxRZF79uDnsAK2q049qMIRtQSA1l3croIRMnKBNTOXtHmMnkfVwWBr4D1RSSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(336012)(47076005)(6916009)(40480700001)(426003)(8936002)(26005)(356005)(36756003)(82740400003)(1076003)(16526019)(81166007)(2616005)(4326008)(54906003)(8676002)(5660300002)(70586007)(70206006)(478600001)(83380400001)(316002)(40460700003)(86362001)(6666004)(41300700001)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:30:37.6875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66864442-39e7-4a63-2bbc-08dbd1b3cd53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The first commit of this series just sets the variable using_dml2 to
false for all ASICs that do not require it. The second commit adds a fix
to the DC sequence that calls a DML2 operation in ASICs that does not
use it.

Cc: Vitaly Prosyak <vprosyak@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>

Rodrigo Siqueira (2):
  drm/amd/display: Set the DML2 attribute to false in all DCNs older
    than version 3.5
  drm/amd/display: Fix DMUB errors introduced by DML2

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c       | 9 +++++----
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 14 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.42.0

