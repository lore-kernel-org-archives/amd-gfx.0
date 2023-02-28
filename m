Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B181C64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 04:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0371010E207;
	Tue, 28 Feb 2023 04:43:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7705310E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 04:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6obkbatp6YqaPW1pufuwFNLzhBDclL317lrBOfR4v9fKCn9DZDn2qjrXIEN4djZHwTPF0wsUCmQMfvEdJY0co2/bLV+WFPbd9/kGuEfut69S0B9HOZ1Ml/FMU6Dg9gbD/CHjrvzIQobwSTnlF/l06ErVOPQpyZLhhfff8MNy/KuR2pqw8WQgDIe3Lcp9LAinSJJpaQ/ZHfLL3KpNopFEh8VZbUO6xpwUhsFw0DuiDd7Pmy/NTpU9aCJVXWsoBTf3qsH5UujNMtZNpm5Qxwziwx1+Co5ZICSSB5vEHhRgqlsI7VcggQCwOygVzOB6GPT/fPh4xZJvLG/r9FOF7QSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJxRnSttFJiaexdRwceW8t04lB6RoJZBSe7wt4sTRbc=;
 b=OujBMm9RqU0SGboE7MKPQiQmD6WlZVzHBHLIsAPyHCrBgM4rrpGY2L2rEpJCivxgjw9HimOhd3MknEJB/dFKOevDFcsumDmFRvEIhPXtgspIcBT2j3oqwhT4HVVYvrejOYfEIPwZmgPXhanuXr0ey72DIs6+lc6TrFWSiT3Hxz2J1f/SSV6u9TW4Dj4x0sYvfjMQjfawbDIFRpe1u4Pss9a0Rx2L3pQduB54h5MbohNzl5FhqfsE6wTvXhS3cshPoHkcGW72VjvWlSv+6hA/NW5guIwAAoQnI5BxV7dSia6Tm6aCoUSxp3OnPJhIPSqF7GSWDtVYf0J584tp6jisIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJxRnSttFJiaexdRwceW8t04lB6RoJZBSe7wt4sTRbc=;
 b=qs9PoXvGSI1r63SzBpBIEjJ8jSiZ5bWUOThsZN4ZpuKr/7apqEZhhFhXLjutTMLPyf/YIAamZ6BtwSey5CxQp8QWdxbMzrR89GNp2+9WeMHt6s0yFoB4tRIbwtnsQvaP2x3Sk0v3iT0CANnIQgDrUrUubmKNloiP44tdVeou13s=
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Tue, 28 Feb
 2023 04:43:26 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::b2) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Tue, 28 Feb 2023 04:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Tue, 28 Feb 2023 04:43:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 22:43:23 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Adjust dGPU handling for BACO
Date: Mon, 27 Feb 2023 22:43:01 -0600
Message-ID: <20230228044304.27940-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: b59a088e-2672-4f22-f3bf-08db19465497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kE5ki4ohuvVp16L9fZ/SBmBtpYb/FB8ZJMNDad8d+Y9aZEN+lLTONBAgHGnOsHJKWZD0gR/9wOdt46creHXlRJbzMNxG2ASBQzGbVYTGIgBJMzFwPoXxlwUYyhJOgJ5dzMJtJ+nw7UTk/uwndh855qQEi99e1C3uomwtQYnqa4WnmgtZXvm81EZluU97FApjlOThy8bo1JD/qGnWSS7x6s6RCFUEEcZCa7/UPkCyBGdYUyNNGVlmVi7K3KvJrPgeZNye68lr4SB09E1AF1qv5rgTMU9dMIJEJFD4kSDCvK1CY3a/huPooRJD319URZGaEvJExWYkdiiYm9L0wQV7vhQZVNlrm2RyB6MWfQd0IB0xIxNW3yiwMksMohRC4wjMPXyi3PKyiuKDNzgU01OgGgvWzegrXMcC+xCrkdllOIpIvyryVHVYLrZk+8ffmySalbf4r/qxoKC5AyCj7vyMpnrl2XO7jz9BIxCNG9ny3gMxL99IAE/jsA9VB/9DUhl8A1Uh9Xbei3SWGTC9JNLRx4Iq7EafG4BfLkhPehTirQRXvezQ5hTGNqoU9TsclY8tWXrtqXyucG6/Ax9cPa2kidm9srxpPmPZxnuHfD26mqs7RX7UriguCVHOJUJIQf3A1pqfwI3KKKzRiWQCz5GpHmqeInXrTXm3verPiS415ZA5Jnp+qCWEUwGL6wietLLKJ+4zir34lEEAjk/6qk9GUlw3z3OgM1FvExfAhPdRgpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(336012)(47076005)(426003)(36860700001)(82310400005)(86362001)(81166007)(36756003)(40480700001)(356005)(82740400003)(40460700003)(83380400001)(2906002)(7696005)(5660300002)(8936002)(44832011)(4326008)(6916009)(70586007)(70206006)(54906003)(8676002)(41300700001)(316002)(2616005)(186003)(16526019)(26005)(6666004)(478600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:43:26.0238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b59a088e-2672-4f22-f3bf-08db19465497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This series adjusts the handling for dGPUs when the system is going into
s2idle.  The intent is to match the following truth table below:

+-------------------+----------------------------------+----------------------------------+-----------------------------+
|                   | s2idle (no FADT)                 | s2idle (FADT)                    | deep                        |
+-------------------+----------------------------------+----------------------------------+-----------------------------+
| APU Prepare       | 0                                | 0                                | 0                           |
| APU Suspend       | Run                              | Run                              | Run                         |
| BACO dGPU Prepare | 1 if suspended                   | 1 if suspended                   | 1 if suspended              |
| BACO dGPU Suspend | Runtime suspend if prepare was 0 | Runtime suspend if prepare was 0 | S3 suspend if prepare was 0 |
| BOCO dGPU Prepare | 1                                | 1                                | 1 if suspended              |
| BOCO dGPU Suspend | Runtime suspend if prepare was 0 | Runtime suspend if prepare was 0 | S3 suspend if prepare was 0 |
+-------------------+----------------------------------+----------------------------------+-----------------------------+

That is BACO and BOCO are handled very similarly when system is doing s2idle.

v1->v2:
 * Rework flags and flow
 * Try to do runtime suspend first, and if it fails do system suspend

Mario Limonciello (3):
  drm/amd: Allow dGPUs that support BACO to use smart suspend
  drm/amd: Don't always set s3 for dGPUs in all sleep modes
  drm/amd: Add special handling for system s0ix state w/ dGPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 44 +++++++++++++++---------
 2 files changed, 34 insertions(+), 21 deletions(-)

-- 
2.34.1

