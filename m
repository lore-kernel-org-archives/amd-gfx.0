Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12639606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C9Dy+iyM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D3B10F771;
	Tue, 17 Nov 2026 14:17:29 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C2910F76D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/vTgE07iMxYwof5p01FtnNbG+A/jYxWJlP63uuYZnTm2jy3dmR6NIEvVlSMaDh9AEYzD81NbKV6bV60V5Bd4GOuPDYMgR+c/Iw02vUcwOHef2y+I9CbYTa0RE1yHBN7FHEBr+T2bOszf7jExIbNmCR8JMYBQryC5Bxf63gLByzpLuuGoYysRkTO8O1vSiSSfQfXoeavNgWknjOtTpJFOtR6/bHf5mNIyhi9jLLiTEOJPzRV4JeYliAbptwxdKygYiMHIeRGpNm5BMJNO2O4m7ThPrEDtyyVcnRTdJwmPk08bCeL9G1mcd/ZNtTFzVB3m03MhA+cP1xnu4kg7Rkpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFe6I9Thr8FbBgxTlqr1PtKYRjAEVqvvFIKsp+GIIdY=;
 b=veEjZ5cvadMD7lNLyBmVUe6sbdtyzPtzPPZ4eSZOdUxICGmMo44ra9eJwDQz3Zl2vM6wa/Fw3I5cpweKGRuXb5X0VQl7aR0vOhK4s30BeHBou0cd+/g4ihjfp+oHpJMJCtbwkdRfq6WzwZHqr2hrA4iYfwtZOsnseCl9wmpVY4mrkJCvqeib2rERP65IvU4uHynrC3JJVgcQbDeLSqn4BZ/vX7wh7c2wqOOLqK1Qz2o7G0qmLYjuhSouV6D8tkjmCZsa3EhPrhh5CZvOeKQT7cOVEJAPJ+kHm7kdFIN9av7nCp4yeCqJeR+Mj2V3UGD9vlAqQMQgxNQ2ZWU0cqg69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFe6I9Thr8FbBgxTlqr1PtKYRjAEVqvvFIKsp+GIIdY=;
 b=C9Dy+iyMMHVS4eTqQahmZsCRKn9muMvneOqqMDr/dv0MXoBOXFjoHDz7P9VTfjRe1C0129v08eV/AG8zzjyZ+Uc+HziwVh5orhqUArqfFom1y7Be8XWOpPb3JaDdGX0VxPKxQuyEIhQdyXL8zXBFgbQQQPgysMuUxhEWkSlu31k=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:17:11 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::7b) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 14:17:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 14:17:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 08:17:06 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/4] drm/amdgpu: Add CWSR and second-level trap handler support
Date: Tue, 17 Nov 2026 19:46:45 +0530
Message-ID: <20261117141649.1658444-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 85259699-0045-4da9-d554-08df44b5786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|261009223027099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: e8wGhThI4FA0oNFRX9cO9u37cnC7WoTv78Tyx1g7Wp0oL5iimcJ2A/OOJioP5GfqwxmbretIsB9j3qcIffqTcSHDMg9AOi7B0lbgtlqYe5koUcHkdLrLI9cBXjnbG/i4HaWBx3zY84w+l8a3sF3DWFEZR51sMh6DHxo2CeUxSHZLYOqSQQCgM9k0Mbhnk0yZpDeyUzLb2/fYFYVSGrHoz37mDfLUXCZ6oesYgQF2VNaHLPHcW//hT4yUslNNtRbThjHv53lkH1aigx39+ExD8xwC1zuCXcMq3TYTqWyBCD+DWakc9G4yQNuqlu8bkwsLfpTL2wVwQu4IVSFVPbiPPe5tSbhyfBT8X0QBZZglscb5WN+n4utyZuVuXJEdAUtOCRwY932VqutJKvOhs2rgJtJ9rD/V4rK0bWdNSJHqI6qkSD2lvF4G+qlVo4mZOiKYH4EyjcTeQ0CqiuXhTGk1cO1iZFir9cUH7PzFoiR9uy1gKI5P2curvYl9179jJKTF2jm+IYLKg5fTaRm5XyQnIbpyCONUBgXRMSAcC1tvz1+WRwwSRH/GYuDo1e0U/dwEgyUVN+dJIzpwhafdMB50vKDBcy7bkxXwnvn6JPZUPqbtqEuFTqshU7M+/iIJBhy4lxsws/fPOrSCUTxLL/jm7wJ2hMJSvi1X9OIP11Ai3d13SAxh5FSkpf6jWwBeod7670+Elj/EyeAR2H85WVuWhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j4ntsFrT6+64pgkLrinlOyf3NxuDgmQZ45Txmqo8F1ptzyta5v0Fdmtyn+/Y2PR7v6+RZyU+rbsP2S0bSYbrg5UoUpuCPcgf9CPW3dL0kzmdEuruzJ7RNx/dE5BwGzWfiwY7dDXhmzKvCch5+4L+0GVPY0rDLRnkwfYV2BOiJdvneBaWp3lkCOpqK3HGCF9duvOSJrWxn1T80awb+epIjH2/caKHWUNyNryCoobJ3hxeLDIP4Ozchzy1Maiww4ShgQktDQzQwqvQkMZzPLbbL3+i91s/tseJwK9vna3vEsDyqziFgv47AW7vAcZdqsmWRJrZAYbf/98xNhUsQpF0MZY3yLTefah6lcqA0mUBwTLb1nTbcd59BKXu9vK7k9gaUVHe/tcgVK5qnOuzHmWmRwlKR1leNivCsxTRTL0B51dBIkDxOmgTgdsFTN7uxDzp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:17:10.8973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85259699-0045-4da9-d554-08df44b5786f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

Changes since v4:
- Squashed the CWSR infrastructure, user queue integration,
  userspace interfaces, and second-level trap handler
  infrastructure into a single patch as suggested during review.

Lijo Lazar (1):
  drm/amdgpu: Add CWSR and second-level trap handler infrastructure

Srinivasan Shanmugam (3):
  drm/amdgpu: Make first-level trap state GPUVM-owned
  drm/amdgpu: Program trap TBA/TMA for kernel-managed VMIDs
  drm/amdgpu/uapi: Add SET/CLEAR L2 TRAP to VM ioctl

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 771 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 143 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  98 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 107 ++-
 include/uapi/drm/amdgpu_drm.h              |  90 +++
 16 files changed, 1317 insertions(+), 45 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h

-- 
2.34.1

