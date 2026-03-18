Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982A103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B4D10E839;
	Wed, 18 Mar 2026 14:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hG6A9sam";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3767910E836
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8rIb4sdnxp77g/2NFFfmk6DtIbVo2FyzzJZiq6EPOzJa9GDnQk62C40sOOeAps+H2EvCeKTqutNKX8AWPta4qQT0SYbQtFnIKCps6hAJuf8c20zB6IE9d/JG/NdqldBJA68iNc7AQn/SUrY1qsw3XYOnhecCgc1pvoGOKHceyOtEGdeIkM6bKEDVj4pjffDCRYeeFEPqA6FPoYPfMPrjUGYNUcd05MERZtpr2HCcogs+4VT0DFjRWDdTRC0ACyPmCJ94nWN0ImBiyIIXcGkkFWZ9FRnBwTs3Fukh8OcXFJWTloZ5LkTlTfHcGk+5vr4izQkagq8zzjEbk4sKTLUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzYnuvvy/V+D8sTV63kfse2qXMTBeDriINHGH/Z3tvE=;
 b=rxAMbEXk+g9EZgXSnqCoFnaPUJyuQZAb7u15/xLhC2RN/9q21Ky06idebvM+79jYERv2Me0uSM9E0vKhQuKg7dvg9TbGkOqws3z0yz3KHtAiCmx0m8LfhhsnNQkEWD4zdUUY/ctL/sFWzwmQBBkU7BhgsLvk1SFiYP83KbUeE0FWk9FGd3gIeK7JrUS1XCIcYjOl5zwjwQhQkXK4JBu0osyqNEkJZlwuUWuh4UKyDZQxUmyiSRj50PW1YyXPop2n6eLWhzwUG+yqCQ++Fuw61y5GgCmod3k3RzHeC5/p4cuHxv3tLwTMHr20jg/Y2squqQvRgnH5zSiDQT0BqJRj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzYnuvvy/V+D8sTV63kfse2qXMTBeDriINHGH/Z3tvE=;
 b=hG6A9samNOj0kyZdRpKV4FSsPwWN19IcGydyHenUpcHyVUy3ZDbBLaZ3poZKar1ZNC89OChaJyI64NuiXC3/NIrb9l7BeOEFRYucjgC9Y98nIWTlS4dKLyaq7Qz81nm9vFnLPlBnVIABejYACpVOAqQ2GwP96jJLaTz3thNwXdw=
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by DS5PPF78FC67EBA.namprd12.prod.outlook.com (2603:10b6:f:fc00::655)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 14:10:25 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::23) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:10:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:10:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:10:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:10:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add SDMA process quantum settings
Date: Wed, 18 Mar 2026 10:10:09 -0400
Message-ID: <20260318141012.583021-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS5PPF78FC67EBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 7422debb-7899-427c-ff38-08de84f8197e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0KFBn6lhrrUoVlXH4KwWGFmjOWXa9zibYXm4lu6dbRZMmYfsSsL7YobwovH29QHsmlQs8kmhzEN7nfiUVQWcXNeqSd4uYANW9hEJfb6YMQ5t5Ln9ZJpyqJQ2hlqJreyd5IG8dom5XlAYYVOAUMdJ319368wbeiq2TvZ6y2WgvJxW4sKsU+VT4jycfIK19BXeE5OlFapX+bRsnTTimKbbsWIv9uKPuim+PwAHhe9cDjBxJNlmJCheSBnCGSmkO2/5bgjXGvLuhB+3VKc/ExmG+/VgiPMZN3V8Zykpzh6GsvqIkYqMIGo1l8lW77Uhm+1tyFJp82b1tP/g0yXhNISBPnXjYOxKG35bggJ2arDoLQPaO/XT1yYqtwMsLodzwkE1ftQGts1Emp/mGsUd2qkq86riMRHbQgYvAWoKbHShcFXHHpnzzQUJMQJyfjUOrVO94j0gVOX7wR7joJ9xvBu5x5nc5pLoBaiYS/yQ+Fz3zvdCo9ESgNoQO+r9vmHVi9LYxnBfnucMcoQrz6A4YAZUrM9QZYZ5VhQAUYk4y5c69DiY56dfk+1pxrj6yO0tDu77xyojfUS69Ii6n3KC2C4NZxm5WZSDX/S2Ehjzc3yfoYsL1zqkJjGTsvdCXQGfbdJgheJsXBwF6HsqAvQHm+Jw9U9gJOpWlOtzMZFuv89leVlAzcSKvyHjhdkJHSV5yYgHXsYb32d5P/fOMVlc4We6exTkFS3VoOMLIx6bDF5P5aMw9IxEm6lAF6WPfIgBsWyjaqxxUGJsegzFCFAz5kgWgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vFwv7GSpzVCefmq/eV3PN84/6JrUKkjUpz2nc9T8Mf7cnPdJo41pXWWAwAb9sKC/+bnwDLyg4+F2Sgf/SNsZk82kYgyHJKNnBiDLSW6tq7h/XRCROq+Pj9InVqB/S98xHWwOyZJ9eYcOyOCIn91NJ41k/zgE5ZxPh0ce2incSvttCtrlyplegbSXaaqaxJzQmHtr4oG32izcu9ZqFETU0+fnfPIjn7zPzEDaVCOT0HxMzywilQ00C7W4FNdlOfkVnKjmD4MHrt66aRy1j9vVUCoHDEMbs1OJlRmUG1GsmWUFdZ/65F5ppfuRdU/DFm1VGOOm1m/ofpG7JGNGu1Vz54dB8EXljsv55pX7pkFa/BcwGvm2nVOLrUrn99q5Gcy2PvmDSInGOe/cWIc6gnRURMq6zwUUeVP8kkKUA1i3c0STk9Sx8MtfVv61GJ2A7t+/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:10:24.7186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7422debb-7899-427c-ff38-08de84f8197e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF78FC67EBA
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Will be used for programming the engine quantums.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775a..c0424e00ac591 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -28,6 +28,12 @@
 /* max number of IP instances */
 #define AMDGPU_MAX_SDMA_INSTANCES		16
 
+/* value * 100us */
+#define AMDGPU_SDMA_CONTEXT_QUANTUM 2
+#define AMDGPU_SDMA_FOCUS_QUANTUM 4
+#define AMDGPU_SDMA_NORMAL_QUANTUM 4
+#define AMDGPU_SDMA_PROCESS_QUANTUM 4
+
 enum amdgpu_sdma_irq {
 	AMDGPU_SDMA_IRQ_INSTANCE0  = 0,
 	AMDGPU_SDMA_IRQ_INSTANCE1,
-- 
2.53.0

