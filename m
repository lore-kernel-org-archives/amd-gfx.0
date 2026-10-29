Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053B606A322
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0ZabG6VT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1760F10E02D;
	Thu, 29 Oct 2026 12:47:13 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B542110E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 12:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vo7Ck1mP0LmvXPABhe14htNOsg0cim43MxXDy3jX9xJUZexOCmkj2UCXZYac/DKO5E9taPyIzDnocL65DjMPFbA6CQVInpekeh2kwHe0ZbshwzoRykd9oIeUTvu7MBHPLXqZNxOJoGYX4I05koe2z/xdfyUwKIn1MWa7yYWQX964ERDTrLJha6gWyHIPDb+UvnBnS7b2m5DQOds9eRWHJaKzlMLMYae+ALjsv6AKtYGvKjoRXz4OQf/9CPl9+7adzLpP/RXmWa2fIjU/L1ZxMN1+K2GWE6+Pk+0Xitna0HD7k39TyoIS+V/npKCC4t7l0CjOCGBcz/cVGFfuo72POQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BircI4aCFZvXHwYys/+jzo7O2zaVumUfH9A/gh/Ek9c=;
 b=i/rKSTYcySOY2zIf8Zt3GBRFIBXSZqwkmR0Uc6QBXkw5o092y3YA8KT8ZLRpwoagoJQHQQJ/jcPVS6tN+R2F4y+k05m2bnl2m1C46Hf2LuVB91qJwvcagdUuUiZvOtodW4dFeqfdXj5m52HXxN/HGvSSZy1CQ9ZI+9SnSplnCtwGXnxwZGkCk0tP3IFVI6D2ySoB8R7BgoghdF/3nuZiMMfMAgCVQolVEKWWJDhiS++nlwcPX5VbNDAwnAUa1FrVVeEBkWh+oh79AwbZ/omrXz0IaIYZAOUifXIPjIqU9BpGMd077ma2CSdlvWi35D2EL1CQvMIZk1b4lLjckLAu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BircI4aCFZvXHwYys/+jzo7O2zaVumUfH9A/gh/Ek9c=;
 b=0ZabG6VTGn8AyHBshp40jsNIXappxhrllDInrgLZ+KP5JTGBnFsV3LQJ1UZZ3nS+aVx/Dekuc1K1Jv+EKvSC9cuj8L6wbBFcxNJYFPQLuyJ3G40jtH+RYH5CfZV4Rs2xKaPpgwboNYBJdIZFay1Pp9pzPdH7wI4cMbEotPraesQ=
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 12:47:01 +0000
Received: from MWH0EPF000D894F.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::64) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 12:47:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894F.mail.protection.outlook.com (10.167.249.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 12:47:00 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 07:46:57 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <Vojislav.Tomasevic@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add 13.0.12 & 13.0.15 to TOS reload check
Date: Thu, 29 Oct 2026 20:46:41 +0800
Message-ID: <20261029124641.4154067-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894F:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e29845d-ce43-43ba-db82-08df35bab991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|11063799006|56012099006|10067099003|261009223027099003|261021121427099003|18002099003;
X-Microsoft-Antispam-Message-Info: XSm9VyEgX5WJLtooP8Q9EF7ythQmm5je/4Tm3o6AUHf7b3kgvudfFHjQ+0ERUP744O8UhjOOvR2AVChE2C7iE99JPhZ0hpzPgxuWr4nI+Eq1aKMJBzlWjg2EYIqoiUB7PEfYgkAyK544RLqTCRYBptgs5s7nehJBQgxDi9T4gfHKngl137mHILadLElaV0x1QvqmFyERxMmKbV+R1NUwTqvDKnHf7PtcOnmAS2lApPZytb+OUhzIbMGLDAqDLblUruGhPXKmsgoBDyI7hTbnC9sGzCAjl4/LWRdlDEzsEhlNrzZkDXRKD5cbbpuWRHnXMDiDv0h72yP8gJVPLPuef7FMv1B9x8RmXOqFEYNjJUnu6x415kHsbN0dzZz4lj171JX9QssnSudkUoqrb3lJgEYl3tw9/Y660LlHRQy/t+DnhY+sW3bzSPC0geVBc7vF5f5aTpEnAUIyDTmHM3a86yuh5tcA01gYjtGIj6mSVh9TkDXNjcwkLFGhB4BxXqxkzF4LZQMlPi5b0D9FHfGDHl9Gx0IvZfW/AjKu44TRcf4jnaH0+wSRQkdd/Q9bXJuNTcVSaFQIRiFfLGAO5+M0VuL1bV+IuIeqh0Z+kYQ3Ed1TnuGCum23fqsfn/hS52t/GNu5v/j7M/aUmhWQWYQNKElRPuKdbPvxg4rEoBebGo/lpEhCvQUa+hwhU5OglMeQ7EUiT1Q3uWgj88sv+HxpMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(261009223027099003)(261021121427099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kgnVijihk6N2WNkep3w1CzUxU6ecIqPxlLtOQPslqP/B6JX9DF4J18etJJd9PEQcPrLmAL3DXmffe9NYfw+idURcZ6+BiIos0tsn22zgTRE2BFtbguWy1aUuj9qTB4QFw4tmFxRh9e/QXCLjy0o3JPgSL5YAYSFdt5t+AlpVx7AXD4ltj3Ax4zQiEjT7Q7x+JEbdi34R10kLIg35p2PBS+wJ226G7RXB+qiWmYIs72yLbFHQQGXTUANSu1utP79LFDnFzC8B48bNfmgboN2Mu9WapgngiIhj1kCfeD7IvAW617OtG4r3Q4jEaw5AMSJFZnnOp9nAbY77mj+qMkfFMS3ynGJYAV8hInO646hy/3TShYtftLsqdljw5Hw/tJl2dcrlCTD3RWyJ3in9NABcF/HJZ6WVeTSOoeSPQnRxSpz4kk4oK/umK0JJswgYgtBR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 12:47:00.2079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e29845d-ce43-43ba-db82-08df35bab991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add sos reload support when new sos is detected from already
running sos for 13.0.12 & 13.0.15.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f9a3fbfc0634..2169cbc21811 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -915,7 +915,9 @@ static bool psp_v13_0_is_reload_needed(struct psp_context *psp)
 	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 		/* TOS version read from microcode header */
 		ucode_ver = psp->sos.fw_version;
 		/* Read TOS version from hardware */
-- 
2.46.0

