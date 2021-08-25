Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF5C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676466108F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 15:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 676466108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E2686E332;
	Wed, 25 Aug 2021 15:42:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F4E6E332
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 15:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyCCFVMDek5+iLzlTYXTif/VIAZ1VolnbOSA4UsmcShMSk8GwINe1PetO/am57QBXVVkYUb8dEQ+42mqq1sFF/Iup7wUPQxEuac+sa4ixlg02IwvF5wBZAXGp/fhE8+U3g2NOySzCa9gKtzKIyZC6pFg9++QnudLNLhhrBTxuOrRsBzBapY6svjsSOkU66PmWBXFN0L2Os8yuimC+lQo7LZ56A3XIGyOv5QUoDG/aPUopLVRfRWvkM8tmX8sgjXhMbMy7kUeJVRf3/CaKQ/c7QoQSH0Tt0hmCPy9+qrABcGa8KEy24A8FjIvakWU/ffnqlNJGGRbhBjaGXNKF3um2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QQM6aehQJNtrkwAnWT1b859xjWMQYmCQVDtyui5Efk=;
 b=MTi28PswwUgcdUmd5LnW5C6rTro1XTLAcYLMHjkngpJbTyN3QCAZhwNk45WO+jbkSMkemQoIW+EW0PuN4Ch1Aj1Wp/mrMymu8lfbujGtN9nES7pr26UFlag89F4I0OPG7YtEnImXgRzQpSGsSWQ1OqTTB5TC1R/CrLopjhr6j0QpVQYBFk/yZOUuEmPgPuvZH1ofxb+dxZVsblk3RlJqSWdQBSHifkQ7sCwF5nnW6ALZzBNEm8GWj8EK4+y8AyNafxaM2ahMYqG/B1bPvh7ceWkjV70W0nz+o4Fyt3Py6Eb8IWVM38dLx4GEiwL2O263Ti8xzdoR8l+54KdHs7pWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QQM6aehQJNtrkwAnWT1b859xjWMQYmCQVDtyui5Efk=;
 b=Ma8BtZ+C6f4MBjEumfq045AiK88+u+d2Y6bY++rvNbwcCqvWBxsVNPvNVpbbCpLw5iqa4VeNgLufn2gt6t2Eg4L5e+BJhRatf1V6SAaJuTxFQwDL0PfFRQkKyXMd+dnUumltSALmdOFv5XzQCdhzdQvxv+/jJgCKtsLx5RbuuU8=
Received: from BN8PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:70::27)
 by CY4PR12MB1511.namprd12.prod.outlook.com (2603:10b6:910:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 15:42:50 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7c) by BN8PR04CA0014.outlook.office365.com
 (2603:10b6:408:70::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 15:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 15:42:49 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 10:42:47 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>, <satyajit.sahu@amd.com>, 
 Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: detach ring priority from gfx priority
Date: Wed, 25 Aug 2021 17:42:33 +0200
Message-ID: <20210825154233.4882-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e7c776-1284-4aef-6f8d-08d967defe10
X-MS-TrafficTypeDiagnostic: CY4PR12MB1511:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1511DD98E55778830573E9938BC69@CY4PR12MB1511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHBGDhsV7g7SKEKzULU/T2k7ZXOwDr795LQEqFEFqg2Z+iHyTxLLZFjGBUCCEKMKEu90WSldEf/DjkM/AnDRM0BUTiBTqWDjS8v3+1daaACK7VxqSxGnCMyiU7Sa5r5W7r4ehJj06lI7JrqgQ595Y4ygfv3nhom//OUvaqg7JyZWqvoPXjaKDRQKiILE2WTKqmnfqmdJ4w4IwyUtvbEuzahnpdL2j3/5AAKRogXuFIx5d6aryk7HZXzg2ym1P1Yjnqol/dy3Ard8zwd+AvrVJ3X0/3CIizG7lULs7laCpcFvLQMSuGD/eysQBy5Dszl5JJqMSkUZE8sUwRZMBoExTpdlKLu4Y9rxItGqz0FzAqjz5xBQ+eWkuDSQekhgXy3c181nbQb220tZb7uU5YtjfeC7w+3PUO0J9ckXVZo3Pmlv970/c4vy4JHJ9n3GPLrSlDRGIfSPfaJTowDKmDp6r/oFASTRC1XCCgpnytfJawoWZsp94ZRg8bt2ZVxnhByl7GVrByyM/G+6denYQiAycqrlX/Im7WMJB81p1hHlBGt932OapsYoNUGiQZL45buObhSirEnDLAs8/Z2im2WLt4GJe8apPPPQXt7wd7C/jCqENg9LtJUfJjiEY0VPM/LfeTK2/D8OxIQCg8Etk4/smMhLUOnBFmJvqexoifpfwoDrHZiyjxhmIAZ4rZR0oYbDBiCOLpZ57UDN4dbXz68HjwZzPNNss7VpOiEbUnH96CM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(4326008)(6666004)(86362001)(356005)(81166007)(26005)(316002)(54906003)(186003)(82740400003)(16526019)(8676002)(82310400003)(8936002)(478600001)(47076005)(7696005)(5660300002)(83380400001)(1076003)(44832011)(336012)(2616005)(426003)(36756003)(36860700001)(70206006)(70586007)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 15:42:49.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e7c776-1284-4aef-6f8d-08d967defe10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1511
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

Currently AMDGPU_RING_PRIO_MAX is redefinition of a
max gfx hwip priority, this won't work well when we will
have a hwip with different set of priorities than gfx.
Also, HW ring priorities are different from ring priorities.

Create a global enum for ring priority levels which each
HWIP can use to define its own priority levels.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 10 ++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d43fe2ed8116..937320293029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,9 +43,9 @@
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
 
 enum gfx_pipe_priority {
-	AMDGPU_GFX_PIPE_PRIO_NORMAL = 1,
-	AMDGPU_GFX_PIPE_PRIO_HIGH,
-	AMDGPU_GFX_PIPE_PRIO_MAX
+	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
+	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2,
+	AMDGPU_GFX_PIPE_PRIO_MAX = AMDGPU_RING_PRIO_3
 };
 
 /* Argument for PPSMC_MSG_GpuChangeState */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e713d31619fe..85541005c1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,8 +36,14 @@
 #define AMDGPU_MAX_VCE_RINGS		3
 #define AMDGPU_MAX_UVD_ENC_RINGS	2
 
-#define AMDGPU_RING_PRIO_DEFAULT	1
-#define AMDGPU_RING_PRIO_MAX		AMDGPU_GFX_PIPE_PRIO_MAX
+enum amdgpu_ring_priority_level {
+	AMDGPU_RING_PRIO_0,
+	AMDGPU_RING_PRIO_1,
+	AMDGPU_RING_PRIO_DEFAULT = 1,
+	AMDGPU_RING_PRIO_2,
+	AMDGPU_RING_PRIO_3,
+	AMDGPU_RING_PRIO_MAX
+};
 
 /* some special values for the owner field */
 #define AMDGPU_FENCE_OWNER_UNDEFINED	((void *)0ul)
-- 
2.32.0

