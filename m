Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7089E606A32F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bn+NJWSp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18EA10E4B0;
	Fri,  6 Nov 2026 22:59:36 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF81410E4B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 22:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUoiACpikeK7ee65X+NOxO0bn6rgVsyu42oWDHl549YQP1YCE5oSKcewt8DkGAIl60zkXj367UWtJ1VTuVuTrTMY8tJsJerheZEg+LPvnZFv1Jh4fsQuCpfugzCvKSPpHKurabPwDk0zm7KIpRyS4RYV9yyXWo/vNCGQwcSdXd0z9aC4J9n060n/7CvuP+G4QuPgLzFl/aB8iKXtNSiywWCG2kOkr9tZeCAb7G6/19U0ufe83cy0JdSi0aybDI4Hlyma5UffKd5VD5V1UGr7FsFJ9jVjJyfqiPPfb237B6hg93jjb+9Bf9enO3jogs7DrOiCNUHixsvdrPzpY51FnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70B8PCl8eUZr0Szmm9/+LsYt6m14bqNvMgV4ZkUvs5g=;
 b=aBpJJtnpn0o2EiH9xxbe30ywe2tjSGeGEVsAjoIVGsonEnqOznqMiBD/EJZ1AmUFwe2Va1Ok9j/EP/fTjWQEkxM1azpUGcyXC2CaqVPg6HzIl4oURmlnb0Y2s7OB2Hw5SnEKvaB8NXMOutSEM2cbRPZDF9BLavq1X104vqJrk3CjY8+WJ28+GQCNLGk8j2if5HQW2EpCvEf/3932BS8wHaWts6hWmxqoJgxkugfnSQau9MshZEc1mxIKTB31xem33tGqmKtHg7xBT95T4d1XCZpoXaW1IeVvzIO5M7Q1j/He6T7pHPYEHBVLBOpiNWMYrUhyyOlN8suXqGUcFxqMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70B8PCl8eUZr0Szmm9/+LsYt6m14bqNvMgV4ZkUvs5g=;
 b=Bn+NJWSpIDrwcU2JuZSB5iyaj6554a8VVttt07TklcFKpn9Qi/8NunB6IAPZHTN3xzR6zGfpgrDNRPVOz4tLH2l7eQVxRZkPXZREanZMLXlbWd7WF+ECZAFvHbd+3Ea9b/Um9nIrmGBUG9cLQuGYu479RiN2TwrvBgpitRMnlCM=
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:59:27 +0000
Received: from BN7PEPF000000AA.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::3e) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 22:59:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000AA.mail.protection.outlook.com (10.167.245.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 22:59:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 16:59:26 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 16:59:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] Add SDMA v8.x support
Date: Fri, 6 Nov 2026 17:59:09 -0500
Message-ID: <20261106225913.3569203-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AA:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dced807-2872-4671-e681-08df3c599bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|11063799006|261102123227099003|261021121427099003|261021123027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: l1o/N0Mtzfhndo2MoBvQbn/4wd6pJxvd+CG056O6CpoxgEghdjzND2NACpb5rhf3fHLw4aGfzuCRNUS6cgVJIvYvvrG5nOW8cAQM+xTC51p19Q74bh12OohPfd0NSBkMOjFK7UZbtWg0CkVZT8Jl9OmcbNTHcllZOSXQ/X13de1FfFVqJgwd5nobjGygH6ac4HY/d1Lcu02TNB9FTgcnRwlyplu7gRP4JrJZvyN6dhhUdVyWR2pJSX0JytnxdGmcVKTWO2sEq38Fl167MLbU1KeRmJ9VF8zkiUrYaoJesrsxHNX5xCD3yixMf6oCVSpEVXuNErg5w7JZgcPYKq6GI+jTF13rxGjtOavPdAdOs7g14kbtD9dllRc8FuROodsCiBL9JlIqkwWnDAKNIWqkNuLvpl2p45Nbosp2HtGM/2c+I1vlLkft7koYaLaUzLQP/PAFOtTXA2fdmOCFLFhPHKK3zFn5Xi9KUhat4YcJhoWbcutjRFSnSSvQy/24xC8OtI7mS2TaWkaFgwh3Qw9EtoJEZBQMhw59TxgxTb4Bczc2aprwaMgcIpxkyhmDsqveCHqg+RvZUO6nCopfUGwukryJcAEGQ7zXlSf2TQlSBVs/GCVuxWzjnxZ6s/QsuwVboizVPcaoUzk33Fc5D01Ftj+5ckwK49tu4KTin7XZ2Qs1aogLK7nWwaKtDaL8YfevT3o341Wy0OzmLCndlxnNWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: owK9iy97ZFholZMruU0L5Wt7+s0kWhWwYDl9FYBXXm3P/T94/gIocEqnt9fxhZgymP3oW04XzSllxJMv9rYRxt0NYLlpox0iupIgqopHqbsj9hD8d4hewKBEDblYqjMLDekbs/H8OsOrVfOMgUjANwYzXgRP3sp/Z6tGsgqb630Omisut8k7BI4rNrlUcpHHl98Fyv6H4i+mfxaUsS7TR76cjEOM6AzwFpllGR4zoBETY9iweqQx96lfdMKuTbuyZNs9NsZEfp7PgVwFCjvEDH3mb6gf2F+cfntCdFS/0W3Kj2iAeL7dhH4ga1tXA5Jw0SukGHSJPRGfw37DN4dALTyKsTkpUpIAQriobkUmfjV9F/AQnv0FAqaQqYgrqGXwNUlSVw3yG/wAILJJa+U1NilGZ5FBFbpH99UHexls1Emto3wzI23tKJsUs1yb3qLz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:59:27.0965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dced807-2872-4671-e681-08df3c599bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000AA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial support for SDMA (System DMA) v8.  SDMA is the paging
and transfer engine on the GPU.

Frank Min (2):
  drm/amdgpu: add v13_structs.h
  drm/amdgpu: Add sdma v8 ip block

Hawking Zhang (1):
  drm/amdgpu: Add gfx v13_0_1 irqsrc header

Likun Gao (1):
  drm/amdgpu: add new sdma pkt header

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    4 +
 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c        | 1840 ++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h        |   30 +
 .../gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h | 3988 +++++++++++++++++
 .../include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h  |   77 +
 drivers/gpu/drm/amd/include/v13_structs.h     | 2288 ++++++++++
 7 files changed, 8229 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v8_0_0_pkt_open.h
 create mode 100644 drivers/gpu/drm/amd/include/ivsrcid/gfx/irqsrcs_gfx_13_0_1.h
 create mode 100644 drivers/gpu/drm/amd/include/v13_structs.h

-- 
2.56.0

