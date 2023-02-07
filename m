Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7A7C636D3
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 20:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD0510E5CE;
	Tue,  7 Feb 2023 20:35:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D6710E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 20:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNUlnRY1pphQX64NhNVKjxMCcdpbXG7FVytUywcHixx7OvGDCO1RmeUCZlkethlMKWYwRq8yXn0zy1K3LCHMt+p5PfNFF4U4Vd5+ZpyKruh3v3QoYZ4BYXcKm9+OxsbgmaWpOvXuayECTs5vbkaLj1mNC0AItLxCl6yYOdVXi0ek6QzJ1+hDue/xxkOX6qE71ro0Y+ILto5Wo0ByV/a6o7w6uT+GqL2BPXF7VsXMtRVJuYgEuw6dSRuF9UE/D8ebj6YhAjwhfwnHv8FSXrqjhdJJotsFSUJ/jvQ+Penl1p5qD4NSWm2PAVJ6gerWbWY3L+SKSn4YAMVYFs2NcrZqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUeUfgZEwD3tdJaRNxfhyB8byTpJJdZNCEg+ysL7gYA=;
 b=BYmGrVrI2+nul2omAUMGuFZje1xSPfUiQhVquFQd44+BIn8RtS/ImCQM+/PUf4yaZL3O6yq8J/A6jUz39E5xT6HKPar+xRmNVhuCnxIxBZzZl8K4EWXzKW02P7TgqV8/+yrLqvYBu1fHuBp6fOp+6OS08nnZoyK3UhwapyeI5aZiJMD2d6Do3EcK1PmKY3NW9GEwlISHaojInVvQWyiRj2gvypZuQA0oxWWtumBbLjPkCy1wjqc2AJ9EcAoxNcnn36vNZm2x0IBWW8UQ4CGJhySE1ba+sdMoSneNkkf/KyF9m7Z/njyQEAjfhuFiplqEMmHL9/SYM+rkagJDHZJC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUeUfgZEwD3tdJaRNxfhyB8byTpJJdZNCEg+ysL7gYA=;
 b=dgWuD8bGw6o6f57HQtsDluUSG9qq8WOXDE4jZ8MK119MruTLgFb002LcnTgqm/1+28A5kCrFV59uYvNp1uLC2suyzLvouxl2+E9P13kIH/6esKEG/qdM4gLSKYH0ViTDGvwqVQgY9uXxAaiTRi7W+tlA2eBA3EgykhEUJyqsMP0=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.36; Tue, 7 Feb 2023 20:35:42 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::4c) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 20:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 20:35:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 14:35:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 14:35:41 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Feb 2023 14:35:35 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Prevent user space using both svm and kfd api to
 register same user buffer
Date: Tue, 7 Feb 2023 14:35:04 -0600
Message-ID: <20230207203504.879056-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e033b5-76ad-41ea-09a7-08db094ae185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVA4whU0gxDhsAr4lRd23qibC2CJ0LKvsL2SPaPD9rdVMFu6ABf1H6iJL5m6oATaxguIpHHwblD8rON0ujCl1vp43A8GXwih7DFe9GcSHSGe8Jrirs4QyrI892XDmRV3hA/qKJu8yJ3lldL4qtFaFwGjdws6dYTJGax4wlPs3HL/juFSsoAiEN6ybeVV339OLkjhUK4YvgRNBIzlh7vK2tp8NdhxB0ja8ConvpkPk2jeZULycnPmQf53b+Z96L2Ar/QQdq1TNK9K7CJh1/e3PY2+LQHGqRW4uMZdc2vQpj4mMjQrdvINwwILcaBRrkB1vHecqdPaJOq2xCL+aaq/PVwsF0u2mdb2w23QKS7RS+hwxIkzehCOv9Zr/u7sf7H3HirekYOIRU/ynWIQ7geCszER2RgFc1QYseubgkpYiEGCWvwTjZ8BGiWJglEbrZrXAI+q9+KKCEroogAmx5J2kyHE3w+8daw3+XkPMCLlgyyAcFvZz/nlYu4OchebhBihesZBktHFLg77LWlFbP2Pl8nZFtuQL//50Ec2JdHih1D6Q+B9+YfCRTZwJQ55y3i/InZAAzqbTqIarRFNIZDFi8Kv3hkqT6kLjA+mydot//om9Cr7KE93s5Hx5OR1iDL0MT3E+F0CDSPbNDhNFxMMhMop10WNOX7zJwWvCZY2Y3t1PYKnl9i1zNuntRjBFXRQajysjaLIoFYBXUrTJrcIo+Md0wkf7g3sRDxFQCxWN04=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(26005)(5660300002)(36756003)(7696005)(40460700003)(336012)(186003)(6666004)(2906002)(2616005)(426003)(40480700001)(86362001)(83380400001)(478600001)(1076003)(47076005)(70586007)(70206006)(36860700001)(8936002)(6916009)(8676002)(41300700001)(82740400003)(82310400005)(4326008)(54906003)(356005)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 20:35:41.8098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e033b5-76ad-41ea-09a7-08db094ae185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

When xnack is on user space can use svm page restore to set a vm range without
setup it first, then use regular api to register. Currently kfd api and svm are
not interoperable. We already have check on that, but for user buffer the mapping
address is not same as buffer cpu virtual address. Add checking on that to
avoid error propagate to hmm.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f79b8e964140..cb7acb0b9b52 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1065,6 +1065,23 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		mutex_unlock(&p->svms.lock);
 		return -EADDRINUSE;
 	}
+
+	/* When register user buffer check if it has been registered by svm by
+	 * buffer cpu virtual address.
+	 */
+	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
+
+		if (interval_tree_iter_first(&p->svms.objects,
+				untagged_addr(args->mmap_offset) >> PAGE_SHIFT,
+				(untagged_addr(args->mmap_offset)  + args->size - 1) >> PAGE_SHIFT)) {
+
+			pr_err("User Buffer Address: 0x%llx already allocated by SVM\n",
+				untagged_addr(args->mmap_offset));
+			mutex_unlock(&p->svms.lock);
+			return -EADDRINUSE;
+		}
+
+	}
 	mutex_unlock(&p->svms.lock);
 #endif
 	mutex_lock(&p->mutex);
-- 
2.25.1

