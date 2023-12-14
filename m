Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC1C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 10:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291DC89CF6;
	Thu, 14 Dec 2023 10:15:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFE110E2C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 10:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1HvFQ7OflAKduTbW9uQVupOqKtDe195GP7lcwYuNvRgXmmVIvForHnaUGFau97O7gz7FmgASCAjYGihkqud9h8vdgBpJDjM7PNxY8gH5bNXW6i0qhOn3jB+BLHiWUgtQk3cHlJjgiqzgztGzV30sNMHgJHD8hcVnn2SgXI9U6B6wnV6CeFySrQQIahAACMVO7ur3qNWS/cc5F+c8LkAWYtW9v0Fzj6VlIJigLTLXMZxXyrWapTF7aoHCwujMpSMRErQ3/3incnUeMyL/lpauc3iURALglB9sFXr9JEurI3K51NaMAWDuKFceK8Mr/2r/+LcXbNmL0XK/8xZHDeJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H040Hea9RAzna0LzXg8KPZd7vW9s4UOF3ONRw+C7lSk=;
 b=HIJvZIc4QHfskPTgmoCOPGzrb8BuP3dlgpLFZnzB4zoqaIxJkhFUOL7O6XNqh4eXwWyXW4o/0mCp2fZGXWplhvZTxDIgrZpB95qZxbqea+i9VA//vQ5o0uA22rHR56P5siSb/3IdQAuJo+q/nmyixawyZzxNDqGu+OSskp50MQeMYgL/sN9f3hHV8p85+6oaMqYVqGd5Polu3hImldUQJjNjJQU9HPKgTs2idJdqhB65UPpzJ+q+jZSCieLNjanF4cEnJcl13GN2+AKZj7w357dfWQxzG/nLY8YXP6bpxexl2T6W99U0H7IV1L24wGsC5ODxKTY1TDg1C1EulROwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H040Hea9RAzna0LzXg8KPZd7vW9s4UOF3ONRw+C7lSk=;
 b=XBougFH8hT1XPpDpvt60rYR6Ewnatq7LznVwPEo+Wfr/7uYXMSwdvulhmi8A8bTRraZ4lwVKbw5dnDnNlJVlf4A5lyuQgg/5uqGqYYJ8BAI9zOErpJrhbJX0FeRJ+oZa1/oFAFdVMiWEMQ/pPjGqV5Pr0299VAcA+mQ8eT7IGfE=
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 10:15:43 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::71) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Thu, 14 Dec 2023 10:15:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 10:15:43 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 04:15:38 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/swsmu: relocate the smu v14_0_0 driver if version
 define
Date: Thu, 14 Dec 2023 18:15:02 +0800
Message-ID: <20231214101502.2123128-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a47ca6-f1a8-4420-9233-08dbfc8da157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ct2R+OPGCGemkU8IgIoOdUomcbApghEDUGN9fX481mX00Puu9rSVaOJKT9MtAv4/ZEcLToYiNZzna7R3e2UhXF32XzA5RDhmVEHtZI+ZK/XDZr8GoqAJPrNEN+G7OWbGkrvipEvbn/L/5pYS+0TvrnTEU0lWN1efzzGGwgsXzvtO1++hl/xB6xydbrH+NoXVYVa6tYip7vDc5Hko6eRiwjyfq9oiUm7VH/LzFHplxXtjJozK0Pu+3IzPocbcfTM3LDrUNA4durzcG0KA/Egyjhaf8aiALYuGHgdGV84ZLGl9jJHoKXS2h4361H1mFwhSEwjWoh+fiAkKk2vZmYeQzh0685oSg0s9AlsDlkOZFjWR9Gh3v2BhvePf0+kDI4Bo7gFok8h2p0zpHQDV6zquZbd2xpZc7UKEYzYSODLbij9UyyJ8+q1L23rxXzWjdUJuEA35gvrYZGYhDzmIEK6f5qyIdHGPb2BLIprLoaJ8Uf0f1x6TclVUXEFLMKadFZAsE95zJWMK5vRM5k3vPUgk3H5ZbQZZVQyDqn6gm6L65wFtuBa2lQd1EqY80HpOkS8/nItpLX10yULuEBMhJgjp3CckxliLAoP5O2Z7TtcrltRtBLVjVNC36q37h7kXw0Wu9FeIPIlRALqiXnKK2AnMCTpvrYtWKaV6BtU78RWc5IlHrSVa+PmANEoymeJiUVfG/oDCQSkmpodY8o7Cqv4ms6u6QZAuz/eDhFjtiKi6ArYDxKuijPMwcD8Zs1pSQzQeXBq+ciEfQK6vhk6Tmd8GA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(356005)(36756003)(40480700001)(40460700003)(82740400003)(41300700001)(7696005)(6666004)(478600001)(70586007)(70206006)(54906003)(6916009)(1076003)(336012)(26005)(83380400001)(16526019)(2616005)(426003)(36860700001)(2906002)(316002)(44832011)(5660300002)(47076005)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 10:15:43.0047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a47ca6-f1a8-4420-9233-08dbfc8da157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, kenneth.feng@amd.com,
 lang.yu@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a repeated define of smu v14_0_0 driver if version, so delete
one and relocate the other define.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 8f42771e1f0a..42bdb06d4e86 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 7
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 7
 
 typedef struct {
   int32_t value;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index a5b569976f19..bfb731a980cf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -24,10 +24,10 @@
 #define __SMU_V14_0_H__
 
 #include "amdgpu_smu.h"
+#include "smu14_driver_if_v14_0_0.h"
 
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x1
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x6
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
-- 
2.25.1

