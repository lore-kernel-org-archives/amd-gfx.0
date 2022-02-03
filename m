Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D06C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 21:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506CD10EC70;
	Thu,  3 Feb 2022 21:26:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5729010E2F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 21:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3CTCgBbp+vpJndV3qOmIq1lsw8EQ8/x6u3bOzUJlyC263qxIed/wYPyBbB+8lP4s9+zNSID+geg3ij7dApV1uDePIvibFzsyYQw0khaSeHnUVCdCl29rjXWKJBctAQgBnSZ4hMNTIuhlaJSFV6s66Koqpp5GwmLu2KedV8KAPimEvB/HljIN92GQ5Bfxk3YZLrQaXkH9T4d9QNoPljW4/kj8h2epsf6ehIsAIEC+dbLN4EmZpwSEBvQiliZOl+wMQX1m6pqsp9Iet0JDTndj4s6zKfKCKbhgskEfw4kzahBuBLavacJKBvGLJq6MtAY+bueE6DXeEeQ5KBrb0IkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQe8UqrsF0/HyXf8KxGDDMrNJe389IGnl0F09Icm++M=;
 b=JUF7oEo5T2eDa69MapNafkUkTgI+w9j7OuE93dhCs5xhHPPbdmygqqQr/BVhVM9E580Q6zIo3CylOp5utYaekpkbHcK5kxKdWPAXBUgCKy2HOtdNu3fmKcVaIUY9FjStOXE1a0u3akg4sK2iohJHyelZCrhZnaE7SLIsm5Z77OtDC/5LGPupOxXCy4zN2DCLHj0CW8bDUwL4OL/alal6aELk/BXfL/wloG2oHeE6Dwd7XNCXBdR3Vog08kYUsnxev4kO4CvOivsITd4/LEH93Sh8lEgfkWCAoP7QUEkhE5208/KysadK1uqKC2NjtAt90Z7HumO/fnM+l4FnQrwSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQe8UqrsF0/HyXf8KxGDDMrNJe389IGnl0F09Icm++M=;
 b=mcfmXz3i/J472iYe95qaRi8b/QgUrMxfV11WSon3XKGz80FF7ApoC5FVOScEa6y4UiKJSBQXs+TV0qVWOdyRXIqmhhKhxWpWxjTzr7hmb6PM1/uznR6Rbq6j6dyA9C1F+HrSNNkGJJSIPMl4qQ7wO93bb8DnmqyI4BXobUEhRt0=
Received: from DS7PR03CA0307.namprd03.prod.outlook.com (2603:10b6:8:2b::13) by
 DM5PR12MB1483.namprd12.prod.outlook.com (2603:10b6:4:d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Thu, 3 Feb 2022 21:26:06 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::a5) by DS7PR03CA0307.outlook.office365.com
 (2603:10b6:8:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 21:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 21:26:05 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 15:26:04 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Date: Thu, 3 Feb 2022 21:25:25 +0000
Message-ID: <20220203212525.12738-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a92bcf7-2f0a-4d70-78ca-08d9e75bc99a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1483:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1483FD10B61E7D02A8820CF18B289@DM5PR12MB1483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXoPcfE+WvQ9qodgIDAjZ1oTqS2hzny2WLCNkvjl6ZLzCuGnBuXh1iwtTw3OHVVWrdYncwUf1DnZ/FGpNLENfwOG8blHfB645dKBlyKjuU9TtLhNQPxFyokIHbDa9dpGSUbAwOyYFuSwrVhJ8FkBr3tk7CqjdgDjlMBmdKBjLre0lFFvlEtTupRN5zpQLq47Rjrn6aeK7TlB5AM39EzeAUtabu1ChrD/w3X3AaBCCyu/R1TTtJb5we6PLUXDBExrFlNsoxsRmL9e1Qy1prKwT/LFVIl9lw09xwn6D72Sv+4rVal2ZkTdot+aS1kOpfhXG8oe94MEVvCLfxthwt29m0N6CNac1QE/TTSzbObFHpVeoAOPBGW6f3BHKG01kbrvvkVefkWGpaL1Hi8QQq3bW1nTMWL0BfSxmdPpxbAI7rFCZKP7OOH0xvfPb/w6RXapZQ41da3JIewXyy5dGpZ6192TV4KJMwJW22ttX8JlA6caKkV+pgRJj1wzMoSjv5lDH1EYDD608RaMfcfSsmn5LDaqF0JP9uy9o4z1Ys7JfRHU8B+dITXOAUP3n6eFIb0yQHLs7Uo+pxP/dJvtsHdFsdqwKvLj2uMbslXRTeIviC6nWcGuDr91LtAjBdJikLtbHmNgi+Itfcyg+IBP41UhgWozCueKCBoSlmekuXARZ4adhfpwhhL0Q+dxsXCNWnfcw7kA8EC8y7TC8CB4lQL7Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(70206006)(36756003)(81166007)(2906002)(36860700001)(356005)(6916009)(8676002)(82310400004)(8936002)(86362001)(4326008)(70586007)(508600001)(1076003)(26005)(16526019)(6666004)(426003)(44832011)(40460700003)(316002)(47076005)(5660300002)(186003)(7696005)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:26:05.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a92bcf7-2f0a-4d70-78ca-08d9e75bc99a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1483
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if (!(tmp & flag)) condition will always evaluate to true
when the flag is 0x0 (AMDGPU_RLCG_GC_WRITE). Instead check
that address bits are cleared to determine whether
the command is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index e1288901beb6..a8babe3bccb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -902,7 +902,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 
 		for (i = 0; i < timeout; i++) {
 			tmp = readl(scratch_reg1);
-			if (!(tmp & flag))
+			if (!(tmp & AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK))
 				break;
 			udelay(10);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 40803aab136f..68f592f0e992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -43,6 +43,8 @@
 #define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
 
+#define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
 /* tonga/fiji use this offset */
-- 
2.25.1

