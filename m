Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65E4C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 21:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB44510E17D;
	Thu,  1 Dec 2022 21:42:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE6810E17D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 21:42:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+CHtg+RkxXRnAQdTddxpc4bhpvXvlPn8qoag+8wczkLTiBnNzlMXr8oR+JVUNfm/Zyyvskm9SfaIABXjB46TJbew7fIauJgO44/6nwOnpHIBZlI+rwcUiDS5JVGs26hOe8YKOn4Qhc3TKP8XCrvQdXjZAVn0V2CtyRL7VJWlwJfNctqmps+zewHPMz4LVxoPD03gS2A2gIXe5riIKmdRb8/WocmKErmjKNCMV8Nv1XTRBKGAsMgWOK5qfYrfptvaLR5qEqYj/VMnpDFtD9d8/+gp6CxYQiIkVrGwZOxRWCfL29Wj8pKXj6bNC6bdXG4MlCM1tSfkTCrb2kbmW7j8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzRmZJv7klLKsK8F7GbE2jfr23XsqfeQNj6jkqA3ztQ=;
 b=i6+eQLqBnsB0tFXsqTKAqOXxIPc+rrtYn/hMdiGiui+xH2SvITE9bpOUMlrYRW+PGPI6ZZNbsToGzWDX86ez/f5UukPLhXuOZ9FoZTLvQ75s8qq/lNtsX8UiuQEfl+rVB8zSOm1n/UrgtMDHk90arZxSXzd+UwwmGFVYVachV4l5mIxjQwc7n3ObCNTSLSQm3Knlltkyo7oJ22rETGb+fxYfnCmSZRBkKQLx3dgXneEqQ8929ZaGGGm1V6aDpEhF8oIvKoxd78CsLLTrWIzdS0AWSIZ6S1Q9SH9l4LyBIjIYT9Y4FLIJ2I+FNezGzgE8eMhOR7e+Yp7rNcohTPzhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzRmZJv7klLKsK8F7GbE2jfr23XsqfeQNj6jkqA3ztQ=;
 b=dlhYbaNPzsUZv2UB8W/ooWy2ua0AjSf4Ael+IVhZFZ5z5U2JaGZgYQrN7Hj00YngWSgyzZqQecFJTHLnsuPkPDoZ21XA16eiP1jKhMDLoO0ikLJF+g9hQ0xh4YBn4rv3uy8TwnPtTeNA+F40G2PjrHd2VOSDh3+/ZVNc94ujIGM=
Received: from MWH0EPF00056D19.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1a) by CH2PR12MB4149.namprd12.prod.outlook.com
 (2603:10b6:610:7c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 21:42:11 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by MWH0EPF00056D19.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2 via Frontend
 Transport; Thu, 1 Dec 2022 21:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 21:42:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 15:42:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add GART, GPUVM, and GTT to glossary
Date: Thu, 1 Dec 2022 16:41:52 -0500
Message-ID: <20221201214153.8453-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: f80b02c6-045e-4f58-e77f-08dad3e4e727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du5k+lunXrVFfsG5BnqOuWi9cweCG7CsMQ4MV8xtFuZuBwxensRnu/bdOAuS1CaG46dasoqRsxAdy8lGAkTaIc126VlI897pJ4P/yfwT8YDJJbZ7KMufLjM2nW5W4dVLTVY9Nf1oio0sU5DZd+S+bGsITzNXjJ1SHL25OUFNY1WQ+bvUIrP735VUcWp2t65Z+acS5WnVPbmnwKpEeUjQrX4Sp6HPwF1rFa5Z4qBZkPl41C8aOniUqElQzW0bTpXdDIHg31sj8aOhOnLbOwMoHGv64mU6jV6wtF78JOB9viqeEEnfy3LWnO1GCMqoGmqOErputYb/pLnHUKoMPDjXSnYC5jt8W4Ci1FRKsM6P/LYmSnz4cq7jzDEhRuhveDcdEC+ahgpeF9m5pGzBeJy+oGK4Zklxa7A0LKHjXVlte5Fi+mNJQoLBUxlPVBVa7HBm4M4t547DbgZ0VdT2rgrF5kICKVS/vwXzwie48MR/LMlsnFyBfSUTj0pASUir+09IKBUq08NSFJnZ/cMAEPPYlYtOvj5CJsxWBzd/ScBnLItyxEJ9av8IbYhzQUOLx3QA4IRUrfW2pihOOLn0rZe0CM7emFvwXhDMK8s2IRJ0lql+phIvKjXMtstltS/h50ycpVUuaHJy/2Vm8bMAzKk53vub/DTzdmpd6trSUnmiyf7vtS17v6ax8bmDDVcT4WsO45Q4UjtYBMyl3vH0S9cdZHLp7Wjsp74IgZEK0DTRmlU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(7696005)(86362001)(83380400001)(36860700001)(478600001)(6666004)(54906003)(26005)(316002)(47076005)(6916009)(2616005)(70206006)(41300700001)(186003)(426003)(5660300002)(40480700001)(8936002)(1076003)(40460700003)(2906002)(356005)(16526019)(82740400003)(81166007)(4326008)(336012)(82310400005)(8676002)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 21:42:10.8784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b02c6-045e-4f58-e77f-08dad3e4e727
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Peter
 Maucher <bellosilicio@gmail.com>, luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add definitions to clarify GPU virtual memory.

v2: clarify the terms a bit more

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Suggested-by: Peter Maucher <bellosilicio@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 326896e9800d..00a47ebb0b0f 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -30,12 +30,35 @@ we have a dedicated glossary for Display Core at
     EOP
       End Of Pipe/Pipeline
 
+    GART
+      Graphics Address Remapping Table.  This is the name we use for the GPUVM
+      page table used by the GPU kernel driver.  It remaps system resources
+      (memory or MMIO space) into the GPU's address space so the GPU can access
+      them.  The name GART harkens back to the days of AGP when the platform
+      provided an MMU that the GPU could use to get a contiguous view of
+      scattered pages for DMA.  The MMU has since moved on to the GPU, but the
+      name stuck.
+
     GC
       Graphics and Compute
 
     GMC
       Graphic Memory Controller
 
+    GPUVM
+      GPU Virtual Memory.  This is the GPU's MMU.  The GPU supports multiple
+      virtual address spaces that can be in flight at any given time.  These
+      allow the GPU to remap VRAM and system resources into GPU virtual address
+      spaces for use by the GPU kernel driver and applications using the GPU.
+      These provide memory protection for different applications using the GPU.
+
+    GTT
+      Graphics Translation Tables.  This is a memory pool managed through TTM
+      which provides access to system resources (memory or MMIO space) for
+      use by the GPU. These addresses can be mapped into the "GART" GPUVM page
+      table for use by the kernel driver or into per process GPUVM page tables
+      for application usage.
+
     IH
       Interrupt Handler
 
-- 
2.38.1

