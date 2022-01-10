Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E47AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD2E10E55E;
	Mon, 10 Jan 2022 23:39:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA96910E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWBWr1DfGwSJV1CcpdJbXyooxR54l03eO/e7vkMGngcb7eYT3qEGvqMeZ0HA5I2drs7M/PM7QEbP+S65xj4SEAeJKFVVFTyrm1isnUXh2Co1r4BupxxhAHvyfA8xZOotDqcQOXboSD/aVfnmXgE7X9lhxtuFEThyf+sYjF1isiIWeCyelDkmAT4YYnjtDpNYxAVkFo+XM7MvwiW8JLaVrsddr+quTETSYiCPUZ/+pTLrh9b96BsW2CVeHZJjiCtOKceBjiz25dv/UIUFWYvDMuIwL1dJiBwAod0uIbqmPqrqVJFK9RUWscv53xa6ozWXRIGPoXgV/sFT6YaT79glpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYJi4a06cijLj5A9/rYlSTQU2wt67oxAzjCF2s9Rlic=;
 b=KG7AY7I9Wbf2RE9Sn1VkS7B08tCZLXxPxOaDEfW1qLrzUddJTkuoS0sYHLLkKQ8Uj77ZlXJbqo3qgxY1FHxW0MaRcf+Hw4uF8hv+ENiZTxaXhqCzqTNmOGRtxGrzQyCWJ36BAL6VWyZLWOnSay8tCKiLx4kBV46X55B/cz2+RQGLvpRNIQVoFj9Slq2OOHcq5fP07KubXPW8rtat8o8Q5oyo3KtwJ2LjcEUGzgnC761nEhIm+6NBjB5prX4QfuvvMCf3z6LFhPN+51cdojFnElk+Jq20bQSHSWuyXu3gKBT0gAsKeezsVblNAgXuLzSZXvKv/iySRTRXBF4By9gnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYJi4a06cijLj5A9/rYlSTQU2wt67oxAzjCF2s9Rlic=;
 b=Y/dsysq9qjR/aaCZhjuA1XMVYL4PReqyVc7Ua5JL2SyUAAnv0Xjz2foY2rqZgn7l/lkJWozxOBpXmJ7Ukvar1ZP7DHn1lsw3wSuiJRks4RdSd4P5mGtMjl7KTUL3SnPiRHnsaO2AsE0/0Khf23fNJgQ9Sevd035D2eicnAztD5g=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 23:39:17 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::e6) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 10 Jan 2022 23:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 23:39:17 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 17:39:17 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 0/4] Use -Werror by default and fix compilation warnings
Date: Mon, 10 Jan 2022 18:39:02 -0500
Message-ID: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fde64e6-0dc6-43ca-ca5d-08d9d4926b2b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5236:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB523621956FC6D46036A27C2398509@CH0PR12MB5236.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XlqXh4uQxs3aEliz1lQ5krPtlVcKVbuBXIZksQodNzt8PWNoDE5wubSGIrYULUEllNso4IRZOA7Hs7ieg41HaK6vOGnl4L5ZWYx26yxgfcO8bX17HraIMfNqW2nQlRxupRt9nctCsNTsYHIGthnsOa5ALNUL4vdiMHJ7X4r0WMi83n6XV3R/SJGNzNDzMQ9hx9qs+hvcA8o8EUVjE48oq5UR+rcFIlmmLqst6tmdSM2aJutG5hcOvqGfdqzG8k8exZ/ZtqOfpbUIxMyEs4Qw795oWX9g7MNTqc0zXlG39d3zO4HKxrqVcDksBF2L4Xr1rKab1YgcgU0srGIIHKnuGnU7CTMw81lh4vpKa5Nccxtd+BjPljeYpgcZ3yuG6AqmLpuUEnhnRjyXk/bbx31NJwd1KvCUcuxZw7n5xJetjXagZZPBboSVblQVRPrfxnhZE+rC+6Sb4HEiH9VQokpHZhmN30GJdB0cEO5PffOpdKfULJHeRYs+MMkT9je9CBk/BlSOZ1O5Rs4V2daFOnmVuTUATZcaUQ1UGBDNq+VBkWCbl5wQA/wwL7maNYJAFsQNSYG+zQuaGrJhvmfKXGuP7KhFb8M+MN8Je1FF/f4a2ka5xouPJikZgsaXYmdvqfFt5z3lZZR9eAjb5PG7xeLycAsEn1AWUNC1qYvHdh6aEOKA8A3S8OETOUs1+EYdelNddLhW7sdDChfvsU0d+DrB5IaQ0dvynzNbG0s0f9XgY7TF6C+hpw0zC1T+DmKefHNmXBd1ilAWOgM7mvTsFlkb6eZeRxdfl3Txlk68ncCNwy0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(36756003)(54906003)(110136005)(336012)(36860700001)(4326008)(86362001)(2906002)(83380400001)(1076003)(508600001)(40460700001)(47076005)(82310400004)(26005)(2616005)(186003)(16526019)(6666004)(70586007)(70206006)(5660300002)(6636002)(426003)(8936002)(81166007)(356005)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:39:17.7512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fde64e6-0dc6-43ca-ca5d-08d9d4926b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We have an internal CI in the display team that uses a stable version of
amd-staging-drm-next to run a set of tests (from compilation to IGT);
usually, we have to create this stable version manually. We are trying
to automate this process, but we are getting failures because we compile
display code with the flag -Werror, which means we cannot ignore
warnings in amd-staging-drm-next. In this patchset, I propose enabling
-Werror flag by default in amdgpu to make it a little bit harder to
ignore warning messages. The first patch of this series updates amdgpu
Makefile, and the other patches fix warning issues in amdgpu.

I tested this series with DCN, DCN disabled, and with `allmodconfig`; I
did not have any compilation issue.

Thanks
Siqueira

Rodrigo Siqueira (4):
  drm/amdgpu: Treat warning as an error
  drm/amdgpu: Fix compilation warning due to double semicolon
  drm/amdgpu: Drop unused variable
  drm/amdgpu: Silent GCC warning

 drivers/gpu/drm/amd/amdgpu/Makefile      | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++--
 4 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

