Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672A5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 12:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A8A10E55E;
	Tue, 22 Mar 2022 12:53:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856B710E54F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 12:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq0XW0IUP8YWKaLKv7xmakgPkxrGMlvhxe+TqXo0U8KP688KfOwNLPxLqV+RVh39PtpNRA1pEL8uSUNG2xQS4B4KlgDS3e5oK5HmmId85QuWBYFV701rOSDMggmuKvpDajmY7jwUbK38D8kcpR67F72nJ3PP1+JMo1D5WyoNgZCuDJmwf4KfUaefYC9Ny/mPviksxRP9tVVq9vr8F+TPN77kH4KFTyUI63WSAViOLvrZ3nvpfIskK0LpVqID95KqOrspypGUivJV8Tg/YjFrGVTIVrUWJstijdcPidzaHRMbt/dTZC4qrxfBXrI+UcHInVdnUaGw6EurnT1PAbCazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2YLkVSf/zh8SOu55U7McWHeq+ChZEcClLVPBosTY1Q=;
 b=lDtRMrrvpLnLkrUqG4JYOzaTgkyEa2hMPjZB6UG0b/ypKWPhlALAfXn9h4of19pwqt52kTzF4GxXjk6bJMBmROmsEbR6GHfoBJFxZhTNKdi1QMa9DGtl6Y8n44BFSr0m8Kq81o+6otX6hu7ZKQYUZ5YH92oWTUIn6dzPSMQgsu56hKy5f540eTfT9Pai2iwKx4suPLt01AZOqjW77pX7+/trU1gUQFHkjzydQ1yaPxdWM7X/LvqmYpuqNnaUvkKoDjBSib18zYRJf8RqwftE7NZeMXD4T3ORZfMkxZyH6gjDnR+vnHLvK/N17yzWchSO7poqvlUUmHQPh9yYMVj10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2YLkVSf/zh8SOu55U7McWHeq+ChZEcClLVPBosTY1Q=;
 b=SDxvWoIAZE95H9FG45gahW4ubt7DTqQEMs/2obyBZFjJMdx5L55IaM8cDrNpV13tA8DtgBdmm8lDrdw8cd2g1K1/79kyLcdS6HJz/RHq+uc7kDTQi0a2kUxgfq8n/JNkB5GpQoT4tgBVEOQb2bzWLzMPijOYj0DuzT6/GVtMMnU=
Received: from DM5PR16CA0042.namprd16.prod.outlook.com (2603:10b6:4:15::28) by
 SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.17; Tue, 22 Mar 2022 12:53:23 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::4d) by DM5PR16CA0042.outlook.office365.com
 (2603:10b6:4:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Tue, 22 Mar 2022 12:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 12:53:23 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 22 Mar
 2022 07:53:21 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Correct the parameter name of amdgpu_ring_init
Date: Tue, 22 Mar 2022 20:53:08 +0800
Message-ID: <20220322125308.3771732-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 599c96da-ae0f-4f41-8e43-08da0c02f345
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23670889FA8871AF9E396C16BC179@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWYMr8XlxnAxp/ZktYAqhGoDVFlU3cxzNLtd0AodmitSsAmwabi1Oc+QGLDH9DFGKCsMayYUDTU+nq8wZQpPrMNAzf44ONHlQDpk+GnJ5LaAe97AL50A3Nk8Hqx5y8w0+HPCtYekstYerMRkiR5KTnidriE+6K4/yeE2y0F/x3MI9yynliufWR1TswuuW0qfL11d8zeDlkKP5iavmvncgAsAEGUCLDj/M+hZIZsWq/YTh/sFVNWKZdLQ0dFpdPC+SyvWZbcOrkIWPwBpG+aA9ar+v2pG14Pi92z7NtMjZ9x0yHFH5Af4cG6ofv+kccK3QkzZg5X+kY1NVhMsuLYltP51z6ioI6QVyTSxKAHO9LQlne5IiTigaobRHrWWzxbaExHRRonk70Qn/rLPYahnCCMQvTzmbzSuJtzuxIFTzrDnRL4xSa8XYEhVyRz10+gglNfNJOBKvap3yzIFdSQ1FUzY3izhLGaBA+darAJS01e+pnJ8ek/NGEW06R3LtfZxvxfXrqI42kCD5BRkOReu9SglMY+sguYcSJK5AOg9bnDLcRCAbZ0HNJar2Sc7uYDNlem6efDti6woitUw0QKe2SUJaebdzQAYqabUN04IRi3sFsNFfXy22LCR+eE98rAk861zYXptpJSkixR5/p4DWoxuJTkgMInoA9bg9HtHhwKeIvVfLsxRwyJ76TDNgxFwoLqhRvu/9kfWSBmq6yqPvu34aoDaT6raoPEkLkTxxrHzQ5FI/x9LQG6+Qf96URQCHHuOed+xYkbmVopJL/wBSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(1076003)(336012)(186003)(16526019)(26005)(83380400001)(426003)(4326008)(356005)(81166007)(36860700001)(8936002)(6916009)(2616005)(5660300002)(8676002)(70206006)(70586007)(2906002)(508600001)(6666004)(7696005)(316002)(40460700003)(54906003)(86362001)(36756003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 12:53:23.6142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599c96da-ae0f-4f41-8e43-08da0c02f345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the parameter name of amdgpu_ring_init() in header file.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Change-Id: I202d76ba04b137926b456b1c8a4c05a5b1a01bff
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 5320bb0883d8..317d80209e95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -300,8 +300,8 @@ void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
-		     unsigned int ring_size, struct amdgpu_irq_src *irq_src,
-		     unsigned int irq_type, unsigned int prio,
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio,
 		     atomic_t *sched_score);
 void amdgpu_ring_fini(struct amdgpu_ring *ring);
 void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
-- 
2.25.1

