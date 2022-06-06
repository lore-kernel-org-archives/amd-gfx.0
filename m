Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA86C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B9E113FDE;
	Mon,  6 Jun 2022 15:42:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1A3113FDE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnpfb6jqbzWkWzQlQoTtdZgzDnq8GkjEaM50SNADiinlpO5CF4Yz2FYb2Ovoo9nb+S8SczPMukO4KEnZ/OAIoUQvaJvdsh7DFIf+FevTyVGW05vjhrnVGFESnK+GkXU0PIp/OpcSKhH9YEcT/98rxsj6rx+zPV4YMQfnwTNmVau6YbyTTJ8NAKFYl7gsLKPUK9R9f3JXiKhoRRAtTu25vhQEXFLDknaMmo857mMCRAJ+FOILJnO2PZnFD10jphQxVjCepiaHBFlENJ8aLJmGcIdPXmM23GLnmfWVTuqc483rv8FGV+MVedRvrUO4FVn4LoARs6Kgx53SAVRP1JJhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXdsrdvo+KyBUSHhiW9Kxj9d5AgDX8OmrZG8bThuKlw=;
 b=KJJNIb36nQpFcgCeyLe92ci7vEJdcCS2o2ytutwfLj4h777cRDXmFLY8mV1OREEO/SQ7qZRAU6c/3AZg8qQnCvIMdkxHq+YPlkVVybS1FfZQ1Igvqnxb0l1B4JZei3Su3PBxk15v5S41uIO71t65coh/As2Kb2FGyEc0gAryo+f9byoBl4NJ0xn5pp0e0lR3zMvkggs0Nk1Jk+GQx517jUMjTOVn8tl1LVtjFmnBzLOwJ9DOuX9eWF4YuoYEzpcfmKRT+vP0lVNSCXwlA7CL+koTO85LHHxvmgDjSilIrwsiup3uexbgPDoZM4PARkTNxNDnSE1jrw/uFlvoGf6yKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXdsrdvo+KyBUSHhiW9Kxj9d5AgDX8OmrZG8bThuKlw=;
 b=wGlr7Rn4zMQXdDleFOJGNDVb6jelhGGfM8Bvf2TtXMDmou7Xd6toS5eTUM3Mvn5v1LfvS7B6WUFvXU6FWvUdOW6WYpFKl2htW5h9EhVF2cN54Jfb/qGPk4zcWDurLKvdsMzhyglRbsKuxvwRPcBEzNBJHAGfXancu6YTNeIbjTM=
Received: from MWHPR19CA0053.namprd19.prod.outlook.com (2603:10b6:300:94::15)
 by MWHPR12MB1502.namprd12.prod.outlook.com (2603:10b6:301:10::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 15:42:45 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::9e) by MWHPR19CA0053.outlook.office365.com
 (2603:10b6:300:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Mon, 6 Jun 2022 15:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 15:42:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 6 Jun
 2022 10:42:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/display: fix DCN3.2 Makefiles for non-x86
Date: Mon, 6 Jun 2022 11:42:28 -0400
Message-ID: <20220606154228.839904-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606154228.839904-1-alexander.deucher@amd.com>
References: <20220606154228.839904-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4a8966-3ae0-4b69-ac6c-08da47d33350
X-MS-TrafficTypeDiagnostic: MWHPR12MB1502:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15023EBF63D0B2B296608395F7A29@MWHPR12MB1502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vokIKOIx3MbAzYIrDYyGDyIvRMSfMhe6Ey6MAZ35GiWw5OGO9UXG5wIUnZxj+OF6wvlam75jlXGMKY4IMQnJvgz9LGB8KQno9kjiH0qQus9aeV1+WGoKvcRaOqj17d1RyxX2NLf2e3rLDMTfwirCG+E87qI2qVxdg4cRRk9LDufKjACVzFQRSq3YtcUSe6Li9Hhm4CJP0Ng6Gdxr8a0Vf5blL9WCPlFU6z2AwJK3UpkATE5sFk8UjNpzwE6JffmSmuFT5+iHXfjU5by12rdhBQhcx485/eeb9QeCa1ZLyDsumCTaM/QNCUwEl5SdnI04qQKEVEOR8NGXbj1gq1bPAbb6KQFo4E9bfjO21Gs31r2JxOvwhPAmnd2J6SIQHBIPdReWWR2OqxXs/Gk8jaSVUuks7OABW+1C2k3q8l0zMFHMPCavaUMYm4GwstybLgFh/FimP5W9P+zDvbBvNUaTySjs0dG6J2IxuHZ3Cp1F7FQ+vshRQ2GgDvPYSYCRpdUKtv8ipHppDlTyco80lXeQPUeHAWJ63DiipcRX8KnQmlu5lTE9c+uHWQnRJE5ab6C/s6wITixcmWmXcYcHSaY6nXPeDR98tuB5jzLGPzzCgyCrc2DYtK82DXMcOuMb0tfKs/51JNkYo52LPy9NcDTzB5qxl+5L4g0VkCQzYKV/xmvEzFWql6PdRKtaWH1vRswXTTe/zQAUCjGmLDynjFrVzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(316002)(8676002)(356005)(86362001)(2906002)(5660300002)(40460700003)(81166007)(70586007)(8936002)(70206006)(26005)(1076003)(426003)(47076005)(336012)(16526019)(186003)(508600001)(2616005)(6666004)(7696005)(82310400005)(54906003)(6916009)(83380400001)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:42:44.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4a8966-3ae0-4b69-ac6c-08da47d33350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add proper handling for PPC64.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile  | 9 ++++++++-
 drivers/gpu/drm/amd/display/dc/dcn321/Makefile | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 6e0328060255..3d09db3070f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -15,12 +15,19 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
 		dcn32_mpc.o
 
-CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
+ifdef CONFIG_X86
+CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -maltivec
+endif
 
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
 endif
 
 ifdef IS_OLD_GCC
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
index 9b61d08700ca..5896ca303e39 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
@@ -12,12 +12,19 @@
 
 DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
 
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
+ifdef CONFIG_X86
+CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -maltivec
+endif
 
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
 endif
 
 ifdef IS_OLD_GCC
-- 
2.35.3

