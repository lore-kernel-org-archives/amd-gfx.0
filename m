Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65D6ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C29910EB80;
	Thu, 15 Sep 2022 17:01:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBA510EB80
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLuRuslh5eKKZyBUj1LxqZmrUUTfgSzK8UdINdlYfLifsY8Zwq1juT3euntm1pw3XJ7+2lgDHfAR52xo909JYWtU217RuHBoSdPfquW21s1BTDVpr98dtsV0LaPdtoptTUqpsPWifzNIdY3YghbjGzDz3GDgyhymssLgiDIZQ3ddBZ3gYGALcitF14JJM8/5eOzAv67KPn29WHtr9orE46UDhSuAFWQ6b3Tx1YC+l0YwyQnFCOWRq+D0AddpLtCWEaYbJmtqL39y0rMm+o5orRwMrJjBymkSE/sb8uBy/PS6i8GNhX9qITHglY4AtSLIem0FzL5/716OfaCeFiJtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdY+Kd2C1NQIby7dhWMfdG571adkO4DH9dUDbKriu90=;
 b=RWCrRg0iXtpXHF0i+TDP4SNaWUSxP3WlSlWPeQA8ywbsPeQ19oONIdM61zqXmKkgLH8R40IcvLDz0SFWu3UqIo741sF+azFsF2YgP8m9Gbr5PzBRDLB/u2I6KDOX5NOhWB/aV0/yyzAcoysh+F2sPc/u86X1v7id/OwTYdC9KRiILcOeFLjoEjR+bCMj3XbOoeW9hlu5PO5wu+wXIq0DbtYpFVvHghuQv0lipbYjNiCzUWdra9JWAyfbjV9Z9jdmlV64jMhVzQM5aahVtrH8Lrfv7smRK+jnHEHrwknD8vzgDmzM3a3Djtje3GDqkL/e45cPSrdp3eOT7KJyzLRweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdY+Kd2C1NQIby7dhWMfdG571adkO4DH9dUDbKriu90=;
 b=ndgocfHbDiDMIXaMOb6FRe1RGrg2IUol2KuvsUajdLCc8B6kfF1QlGNmKQjFIudEQlL7YOjfUOPIpg6FNM7ijCLEzrbjXcYrlo37y2jn1B8in5We875q58eYQ/Pqx31e9ZiEzAc0RbOmWTCj5mIiORDm32GIKixMuQJSpt2FHBU=
Received: from DS7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:3b8::22)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 17:01:52 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::d7) by DS7PR03CA0017.outlook.office365.com
 (2603:10b6:5:3b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:01:51 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:01:48 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 00/10] switch to common helper for rlc fw init
Date: Fri, 16 Sep 2022 01:01:25 +0800
Message-ID: <20220915170135.23060-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E9:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1839da-17a1-4888-69ca-08da973bfc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brFnEyFMtpqJhoNdmC9uW2uiIGuD8ywuJT5v4EEH2aZZJydl6swUPiiF+7QmIimfaiyAOioh1Xq1mL+7oFsdUV6b5K6RCuOS2BvyyNZKJgiJue78+2AGpJ2fO/UIZ18kDJJRJVPKIU604eXbsAAROJ25eKvZOWwCemrGINIzlGP27orHj5Ed781IkkPGv+qu1e7PnesEbf9sOTky0WMi5xOjvKwQyaKGzXYsJKyrT/LEOuUdFcrRiOfMBEsDupl0PdoPYO3eIbfBDop3/ZT2Me4fknvkkZp52xIapAgHzDOC6CSQbFtKZa8lN+V58M79n3LSVf/ZQbaZ8o0RUdRfRojGuT/PRClFoTybxKzXzCALmGUqs9/tMP71nCRWM2KEg0zHMICoWeuks/EsTzhqzG3rej5tRbMYhqfS3ZRFpHh+4pcXAAVm/ICxmrJ2q4H987YPmcc/vzmQEZ+AtIIhYIYuJW5c0y1kEtnwN4TfYJyy7aRc1TNzdxnKE6d2q7gD8gRKqjW6OLNFFN95HH4qZoNmp45TgWMPaKKwG2tbl/ic0qjojKVxAYvZWszG9Ehs7b8a0xFH7xu5zBjJT6ZVwdjkAmCcRzx2SlU15377K1GJ2kdh7aRXDX7QtBsReam6/ZpjXFw6ti2cK5Ebx4QUcdfnl/U1GK+44+x14WQfwyyTDJjFfeBRSvnGLHllZqKweYdvhxVaHx8ZVwQtKOaqYXhaCLYpbD4FYMWGBC1bUDwmb3+4Xn3RhnEOxttC9PfAIx8OBfJNLl0A1Bx6a7ZJmKR8YCHy65e7ZtlX4iPvZhbJNz731UK03nwXFuNql1Xj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(426003)(2616005)(70206006)(1076003)(16526019)(186003)(83380400001)(336012)(82310400005)(82740400003)(36860700001)(81166007)(47076005)(2906002)(5660300002)(8936002)(4326008)(40460700003)(40480700001)(356005)(8676002)(478600001)(26005)(41300700001)(6666004)(7696005)(316002)(6636002)(110136005)(36756003)(86362001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:01:51.1867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1839da-17a1-4888-69ca-08da973bfc11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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

Replace IP specific implementation with common rlc helper
for rlc firmware initialization.

This also helps reduce duplicated code when introduce new
ip block support.

Hawking Zhang (10):
  drm/amdgpu: add helper to init rlc fw in header v2_0
  drm/amdgpu: add helper to init rlc fw in header v2_1
  drm/amdgpu: add helper to init rlc fw in header v2_2
  drm/amdgpu: add helper to init rlc fw in header v2_3
  drm/amdgpu: add helper to init rlc fw in header v2_4
  drm/amdgpu: add helper to init rlc firmware
  drm/amdgpu/gfx8: switch to amdgpu_gfx_rlc_init_microcode
  drm/amdgpu/gfx9: switch to amdgpu_gfx_rlc_init_microcode
  drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_microcode
  drm/amdgpu/gfx11: switch to amdgpu_gfx_rlc_init_microcode

 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 264 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 191 +----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 156 +-------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  60 +-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 106 +---------
 6 files changed, 289 insertions(+), 492 deletions(-)

-- 
2.17.1

