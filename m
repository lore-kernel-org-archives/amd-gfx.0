Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A2606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OHln7FTC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E721122BE;
	Thu, 22 Oct 2026 01:48:01 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DAF1122A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbfket9toxW80lfezi8KTJZp6aKAOWnIQoO8d1TrIC7McuYBhBvTeZibNHi0suRlM7h4fYH2WrNLOMT4zdguHRAykqOjT5n1KSbZwTsKQPZZJs0kQ2VSspmhneNWJVa3FbAUVpm1yPyTT4ohb1vcD4slKRjG0Kjmi9y8aoPcj7FPkxFZS1e6TwmP6XgOqY67c08GPY5ds7PT+4C7ZeFutAh8mLfeLxuxmZhxLDTc2/AjxNwm1kaAEksFlTGRtztl970+XsutmtfkTG1kekk1tvXU+s20O60bVUs9JREEXU0xUkV4YTtHOlXHjPT+zQSKdOsIVtjEtef7ELoN+mI1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsDlFxxe1j6q2WtzfRv0CWAFwDoaYSygqvQm4YpQemc=;
 b=IavIPevfgL+D/e65ikzvez9nEKelVoBrHOCR6/E1J7LyMlEkv+X5L3GdEvd/+wSpX9wrjzXITLxKLF/UDFY1IfcPsMExepUtlCeWYBKqQ/iZ/IC0p0Y7TXChf6PNF0DKygCi9E602gN8VwFX8LTSYRArzAQWZVYviAWekoxOcuOAa1pE8gLlW+ED4bXfbXyxjY0WNKU0MbaL9ii38ezUXXQJH4HIHX6fh8onQzYdkTUlvYfH0BY9YCyXFMPFT/Faje+ixXIt88j+hB4LBPUCXAjCg6OEibgMHyJ1hQNSVwIpEHInyQTRGLVRliWJRM5QJfRJNti0Mfvmy1+aHRLYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsDlFxxe1j6q2WtzfRv0CWAFwDoaYSygqvQm4YpQemc=;
 b=OHln7FTCQ3U1akR4h2D5EXEqQ+36BDnGlUaoA/XYBJG8CQfZpnoUsTxBAOjsylZYCtNNerGGMS8/jx/pohZFupB5Uq8vvACHNgGP/iDzeDwPYEjeFgd487CzIIsftwUW1M38O+ANboJfGTH+5wXUNIBGKo9fDTkYuFn6wBWdrb4=
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 01:47:50 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::92) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 22 Oct 2026 01:47:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 01:47:49 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 20:47:48 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Shaoyun.Liu@amd.com>, <alexander.deucher@amd.com>, Amber Lin
 <amber.lin@amd.com>
Subject: [PATCH 0/3] Support queue reset on non-SPX mode
Date: Wed, 21 Oct 2026 21:47:20 -0400
Message-ID: <20261022014728.84081-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 825546e2-6f52-4a74-4ea0-08df2fde7a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|261021123027099003|10067099003|261009223027099003|11063799006|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: nFBE6lv2HELfC1QBDTCHPmrJIeLay97Dx8w0FMxFGu3tEvKsb4UIgF+C3N6psgJazEWg7oqMxbZBWpiy+QtIsCfZkfQExFkCAzUf1G/lCLJvpKljunzcExiBgHA6YWAoqTedjfvPmy2UadNk9X0UQ7kQfDMpK0NTPfIavAhnKRo2/uUacpkBjcrstx+6Kr/OYneJeuN/C/II39J/rH0B6Zqx2a8uHP9VVL3RMg3T+eofB+fdNFkvntG1eKuknmWE8HrOyQWOcvlUTpUkL4WjuYvhq0uZBm029+KQWLluNQs/j1LtJPYO/pyLJCv2pNoVI/ZS4nLNiXB/bT1JvNpQopoW2B4zWt5QbGh4Ge/sx4FMcbJ9/pYpXIDmb7hU9myyJTYa08SD2Ofr13WF0FqQ/xJUwztEq9XotHC3gCjFuG/Vl/+6ifLXDMdxYkMnTbJznEATMWenLi0QgXicKx4/2FRMIoFJBptFREXnp9mFea1wu0x+bE1xKtdq+sjg5EFGsErIHxrvNMtOgFp3qDIC+OmUX5dxbIiJp1jX7+2Vh/HDqTQp215WJpCfOZ1f/rdUE6B2lWR6OW2Sub9xMNaLSjhqy84gl2zgd/u4BG0ZwZHq/duTXhip6b5F30V4/iS8fm8p18H0PbfwkjGFlzDFFcYsL7A7Tgj/KU/4/Uux2ylrn2j5akG8F1WHJJygs4SiJrWK+0Lb/nJc+yTod9uPLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(261021123027099003)(10067099003)(261009223027099003)(11063799006)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7irVDhxbTAXvNO0K+WVdd0ESRCY5xDLbjBknRdDxV66MRkdoY5uDi2DW4y8v3dAOFmp0wwiKeZLBwRl6MPVm6i6gMkgNm+q7lyFbN2QUmRY/DmCI6VmQwQ+Qw2N26pn5qr9hcNBx0lK5ld0fbcoRt1TaK4DPSvWWPdZe1kD1OptLn5RxzlUcpoHz+KMj5qdeN2iXhxIE9FKBBGYu+JnsknbG+7MhzOa59bkZqlDha4Wap6jquNcDp/qXk1h6ySNYQDFkl1juVHUGnwdB5f64lnfE0TDanXHb9uIIZtwBh4tD6G0xdlcSGcdFSnrmF3lVOSqp8wlEF+quX4sL6KinQX7vswKHpu0oAxy3bBXKa+YL/RCn0DziilsVssQdGWVuECNfCUrk6OG6W/in0r1suHtAOqEVyX6sMK6wn1/uxqMXF+ljlODYdItiRgWX8DtA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 01:47:49.3706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825546e2-6f52-4a74-4ea0-08df2fde7a81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

This series of patches fix the queue reset failure on non-SPX mode by
1. Specify the master XCC when calling MES.
2. Adjust the hqd_info offset when retrieving the hung queue information
from MES.

Amber Lin (3):
  drm/amdgpu: Add debug messages for MES queue reset
  drm/amdgpu: Add xcp to reset_mes_compute function
  drm/amdgpu: Correct hung queue number for reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 29 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 55 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 7 files changed, 66 insertions(+), 27 deletions(-)

-- 
2.43.0

