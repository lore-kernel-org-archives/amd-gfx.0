Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EBCC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 11:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4BF10E6B4;
	Wed, 23 Mar 2022 11:49:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EF310E6AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 11:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfEnQn9294QIfg1fiuh63Z2Q0tnZ4y9qs+im9AzQM2lLg6HRHildX1aw0f4SJPtAgV9ZPbrbcbSH4ic5t0P0oxWOp1jPxXMk2CtEeduaeJHpsyZ4bCXLG7lTs9NnGcXj6WVCyCge6MtD0HCfzf9cjG+MNtleFU1RyWuBkyuvqkvfgOH8JCXxDj1PkIODRdvXiUZfdgqRp1dYO+/6zqGd2m2WOBmEEij0EGy1mOjdZP90DbqjeplJTldoGtrGl7TrsIcmnyRtNC1R6hstZZmQd/PlJiewgsqrDGc5LKP5MSPK5IZWnj/VkHnP1CJLFosxdpwkbM0XGGntCOHO1oPNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVUE9kVtQn537Hc4iQGApPqBkIYdFxq8Su+FfmnV7Kc=;
 b=NsfX6XuzjDL5+dwUNjxAv5pZJP4qpUCjT5aQ3adVvNofbih5DW3Fi5qwgAShsv/3+JqvMgeRneFp1dFWlz19cSiSiDUR+yX+xI2a1YzzHe4zm3dWk+/sYNhvznY9NNt7vwF+HfRnpTC0aaW2y1YrWN1t9mnDE14lV6r4SnEoMWmVUgyrHsVATElinqyFEyqV/YfO7yUrSLmAgC5GjjufgUMQKegs+NUCKoga0hIxMN07k8BYpDZ+NJQ97WBrsLE9f3BXx2FzdjKA9EoPRqCLF+VwLKZIoUffV4AX2/SonE9vtumvD9WrcVFDISbo0gYpB4x4MPwucNvny4O1E6hsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVUE9kVtQn537Hc4iQGApPqBkIYdFxq8Su+FfmnV7Kc=;
 b=YPrDqidGUm+uTRFqF+j67rAr4v1voNRZF35SS+LIlHXdeTreTwwWvMueN1CtAicNzrvCLSjwGe5iOfGg3t/YyklU2DrT7XNM8ImARxQ0MNQJKUUvatv4jblKfd/0gvQtrHBmKjWgWAl7m8rTXI1kgGUuMA/KH9nxtlPKXLnn4nY=
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by MN2PR12MB3502.namprd12.prod.outlook.com (2603:10b6:208:c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 11:49:21 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::e7) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Wed, 23 Mar 2022 11:49:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Wed, 23 Mar 2022 11:49:21 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 23 Mar
 2022 06:49:15 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] umr: Add FILES section to the man page
Date: Wed, 23 Mar 2022 07:48:42 -0400
Message-ID: <20220323114842.78516-7-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220323114842.78516-1-luben.tuikov@amd.com>
References: <20220323114842.78516-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61f35bb8-0541-4d66-12e8-08da0cc32bb7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3502:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB35026D5278C23ED9BC676E9199189@MN2PR12MB3502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq+rkTScsBCcXMSEoutsse27xWF3ODgpAmhlfmJQw7UH/Zs0iYN89xfOvGTjQeBZUtMVcXw90KIWJO3mLgmGbSMVAqQb4Wf8ydv877fajq29P1Mypdqb07Y7XJvKcqWgS9Q+OtLzVy7HhtPKOSGOHKs88u+zocnWBUoc0MB+eWs2YDWRfqahQ1kQOgkd7n+yMrY2lp8VEk9Unibj5ox5+kaTFTHmjIhi+nyU4s0ebZAJHQm6zVVamlyMPh2goGIvaNk8BFliVjQ3ybns41ilVTzZb/lSdP4tjs+ldY/91gXVnuEiZ+a3WPOZ8fUOONTeJHjXxW47i+WwpJi0ZFdC8DlCJUyqmYFDzIyrlusuZT4HVdUxs0TNgrj9hpyddBTtq8ygJsHIBjJ7YIddUpQmo+AlzA6+Sb0+beTF2s0IS9lmeEGK4JMy4Gkad9s59yEg7n3m+qF/eijQDOcF0woJaFdXZIeu04Z3gwDo4ANj5ljERhOPDMx0Ze4/1FQV+Omm0c3WetKfco914vt5AKtGzrP8WOcNBncIhzGGRrnRSlgrNG4JuTFQc+tiwrBqx+yJFINd6uXy3djq3+mD1iBm6yigGW8cjKii7yiapay90bP6kfw8nYJK+Uk3f15CX9x2IWG1zIRo5lg7ZT7JeWs9pqgQgtefZ62/XCV62a3gLz1fDmjzNZltWglhHGQHs3rpltRzY284chxhZ6/RiEImtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(6916009)(26005)(186003)(66574015)(426003)(336012)(54906003)(1076003)(36756003)(2616005)(4326008)(8676002)(70206006)(70586007)(508600001)(36860700001)(47076005)(86362001)(5660300002)(81166007)(82310400004)(8936002)(6666004)(44832011)(316002)(83380400001)(40460700003)(356005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 11:49:21.6983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f35bb8-0541-4d66-12e8-08da0cc32bb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3502
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom StDenis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add FILES section to the man page with entries the completion file and the
umr database tree root.

Reword the entry of the UMR_DATABASE_PATH to make it clearer that the user
should set this up.

Update the man page's copyright year and month.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 doc/umr.1 | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc/umr.1 b/doc/umr.1
index 575b522ad22e78..62eea7db320b88 100644
--- a/doc/umr.1
+++ b/doc/umr.1
@@ -1,4 +1,4 @@
-.TH UMR 1 "January 2020" "AMD (c) 2020" "User Manuals"
+.TH UMR 1 "February 2022" "AMD (c) 2022" "User Manuals"
 .SH NAME
 umr \- AMDGPU Userspace Register Debugger
 .SH DESCRIPTION
@@ -306,4 +306,13 @@ GPU hangs occur frequently.  When PG is enabled it will read a constant 0.
     Directory to output "umr.log" file when capturing samples with the --top command.
 
 .B UMR_DATABASE_PATH
-    Directory start of database tree used for register, ip, and asic model data.
+    Should be set to the top directory of the database tree used for register, IP, and ASIC model data.
+
+.SH FILES
+.B ${CMAKE_INSTALL_PREFIX}/share/bash-completion/completions/umr
+contains completion for bash shells. You'd normally source this file in your ~/.bashrc.
+
+.B ${CMAKE_INSTALL_PREFIX}/share/umr/database
+contains database files for ASICs, IPs, and registers.
+.B UMR_DATABASE_PATH
+is usually set to point to here.
-- 
2.35.1.607.gf01e51a7cf

