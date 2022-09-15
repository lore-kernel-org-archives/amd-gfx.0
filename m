Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A462C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DC210E21F;
	Thu, 15 Sep 2022 17:01:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D6C10E21F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7+0fYnTK6sZ7uj7GVioU/tq4iHEBEp4mRR9hD5C2xoOAsa0IkKIOJq1qkFzixk55WTDAnMt07T6kbsCaWctwk3/nljSwomQ7GVwYz4v1zXwZTMuU+bNA46Y/gnaXA1arhjokjLM5t60V288PZxhXRqbpXQIi77F/IE+A+J6QaQK6KtPuEy51I9Ld03iwKEKsYZgrfxp5UyCtvItKrocS42+Yuz8Ve1Bk+lT/yMNGNFhIVc8t3ZecRgGpfjBFgSNGApb7KE4g62BXN8MyIMw1Q4MStAINsO3SdN7ELC92m0oyetASNQXPIZi2SYXwYXDGQd7wqNSUxZGsnwrQ/HiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ9HXMvIxS501gg7r63XLoxyiZ+YwIgyYXSJu7sBkz4=;
 b=LFEfLdN4aIN4yvmu8oUbZBHz8MbGYeOncwC1s4EetHvs3W6VUFQsvYBIXQKex3bfg4eUazX5WOObJ/of/CdnrWNRZwlVbJ2kAm/qd4sPBD92kuDeK8LCnQfKDM8xJEHJ+TRygP7CvMdKHCvPP48ea+cX1JYO5Ha7Pg6SlmhRtGtwjRotwU7yZ9ltZYVYLZdH1JMI6V0OOLhYlHDa+76ElZuN+X/s8YigarURG62hVDDfuUWbys/2ImpaQnDbCyVaGnfym6sYPkyOUiBw2XlmHV5hBF0owRJdVnXcj0HdJc7QfwsnTwIBPDBwbfjc9I2+t4ZrA30QOZXSEd8nULq9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ9HXMvIxS501gg7r63XLoxyiZ+YwIgyYXSJu7sBkz4=;
 b=kOatX6IW/6T7AFQH4vtvD5RTlyFCePrTRSy5r3Wl7piFlQrv/eMQRvu3cXjnkfgjwta+ZGcp8ebNGm1u0EWtewk9RyYlQ1HrIhjesYfsPf5y5Va12mcGb5QCMTQAS3XbErcExRzw+QN9uFQAA2/Vu4y+K6R/rmrkiPdrN02Q6lU=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 SJ0PR12MB5454.namprd12.prod.outlook.com (2603:10b6:a03:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 17:00:56 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::62) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Thu, 15 Sep 2022 17:00:55 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:00:41 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 0/4] support query rlcv/rlcp firmware version
Date: Fri, 16 Sep 2022 01:00:23 +0800
Message-ID: <20220915170027.23010-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|SJ0PR12MB5454:EE_
X-MS-Office365-Filtering-Correlation-Id: 487d92f2-d080-4ba3-2224-08da973bdac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7OqkEDnQZv13a92VGCLUjkxJhkir6PjBbn0qzircP4oRwb5N/xzxH5VktJD4kwqdE1moNDfkyr4FCFM90RW54cLf3R+WHlkSgtQcqujCNqkzV6kzGl2DLZSIWavimksMj1dNzpV9N2bkrjUvh/7AUQldcSkUoRbDSqNSeR9TgWOVKEY0A5BNeVjQ4D1tfucE/HJTE+ZnDD0qbCo5KOdTLyvO2gv08g27aKP5IIu13QMHxnSIlAeAXi6Kq5dVKotm1GcPABcn9KXUyzBYPViNGPPwVSLcsubTV4mujIWdZtvW6fuwHSIf4GYdQ6gdxbMM7B5nN0/eIGUYJG0SM3dh6GrCX47F2HUG2gBQFTW6vweiU6QhhixvfWjDBtOemqqUni5JueAbSpH/QWHxkXQ9ZKDVEii3oC6hsMmlDJPfzUeKD/KnowCpOXX1yOdTtx9N+LK5QRH+VAKjus8XYZvUqNkIvGoTAfk6UJQG+9ZLraw7dKtTZWLbuYuqlY+TknUVID9GEmcsYuuv3oQnqBqjl5Fmr1rrz/B06vZVD0sLXJqsQaP96CWIvzz2D9GI4IcRVVnmKOfH85ynSN1QS8AiB4WcywRiGR36yEVVwRB2IxMVKb1qSuS8hBbgKcN4Kg1BB5VGhaglyrV+BB3XNC1o7Pb7Wsp8TwUQKy6OHW/x9vITYCyp/jakrH3tGrT5Xzu9rzZPeGQaycnYxoP+/4fid0UjTytbhb420Pnt9IaLzhgOwJZwTgh8i9x40MeUZRIllAmCRJnp7Yljl6Leeb741Kh9kQpP/dOdMsvTLI1xdqL7pd3zLtRDktshBvnv7Ak
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(316002)(81166007)(478600001)(110136005)(36860700001)(6636002)(2616005)(70586007)(70206006)(426003)(83380400001)(47076005)(36756003)(16526019)(336012)(6666004)(40480700001)(2906002)(86362001)(356005)(7696005)(8676002)(41300700001)(82310400005)(4326008)(82740400003)(4744005)(5660300002)(186003)(40460700003)(1076003)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:00:55.4288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 487d92f2-d080-4ba3-2224-08da973bdac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5454
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To allow query rlcv/rlcp firmware verion info

Hawking Zhang (4):
  drm/amdgpu: save rlcv/rlcp ucode version in amdgpu_gfx
  drm/amdgpu: support print rlc v2_x ucode hdr
  drm/amdgpu: add two new subquery ids
  drm/amdgpu: add rlcv/rlcp version info to debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  24 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 168 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    |   5 +
 include/uapi/drm/amdgpu_drm.h             |   4 +
 6 files changed, 159 insertions(+), 50 deletions(-)

-- 
2.17.1

