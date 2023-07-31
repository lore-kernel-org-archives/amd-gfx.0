Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765FFC00528
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 20:41:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12BE710E2E1;
	Mon, 31 Jul 2023 20:41:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2885F10E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 20:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkbECXTuJS9fpPGYDzfyxos89dN2i8HQOg39T1nxVDSpX9k3YXLiEhXRc2FPGn/EMzPUOPfLUKBykul+RloyemL9JpNIBf4p4+0+5zwVxoLDwtB7mmOThIV+4nBZtisQxTKjwxgfhCtxWhYUsknqZBQLKyYNLiL1WXVvXsv2GjgMkvJPD0t/oLHHKZt3AFI05RL3G9JmWYk0sZLL89h4HNdW9RgshtUOpIOAb64vK4KkfWEws3YA+ytoqGjkBYZMlC8MzvfCSFAkc308qdEEEUO+W/bwcYdLHLv8tKITPhnOySREYrTjo2YFCe59bh+RwWD75ANFGvTLN4wPRgJuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBxPig6Hopmc+/MzxH4SCPs0wXdTZA2PYApu5pbzYgo=;
 b=T1ySQh8ABrDtzKuTb68aC/pGRyhUgRrq3vhqAF62xt3CP2lITvOBV0vjiu/KHO96MIKojZlYR+MLQ5wjsCKc0JpZrDqFcz53i9fx/04oieLn6M8wo1ykRF1pDmTUt5VZHpan+OYt0/mMAEYKXP4Trs3AMTB3sn94nV0Aauecd5v376wjggpHk1/fEsRIv4P1HIRt9Y69QooE2p712wlOlLoO1QKZk7MPPCUjkKezzjln/FE5vNQKnU/IR2caRIVBHdaR1nXLhPm9EK4C+dfkxzb8RiomYJycV/Oj4o88n84w9ghdr/ORMZQ9+sEY2b8U8V5nSAQQ9QaAcAHzgKrSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBxPig6Hopmc+/MzxH4SCPs0wXdTZA2PYApu5pbzYgo=;
 b=UTdifH0v03P7ZUeRpGGapJbIWxSyFdH3f+c4yajsoDv1QdLUI4wgDdQp/FYdnRFZfDnBDFbhfN4dUwYAPuqUcAgbu+7oguwGpKsP43pN+rwBOVU1o0Wo2joEEDEcJflTyZHdqccp/nH0NlhSodPjOr6M06YHhu9/r5GA5eKfSEs=
Received: from DS7PR03CA0277.namprd03.prod.outlook.com (2603:10b6:5:3ad::12)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Mon, 31 Jul 2023 20:41:35 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::ee) by DS7PR03CA0277.outlook.office365.com
 (2603:10b6:5:3ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Mon, 31 Jul 2023 20:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 31 Jul 2023 20:41:35 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 15:41:34 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
Date: Mon, 31 Jul 2023 15:40:19 -0500
Message-ID: <20230731204019.9519-3-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731204019.9519-1-jay.cornwall@amd.com>
References: <20230731204019.9519-1-jay.cornwall@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5274dbd8-7821-4769-61f9-08db92068840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZnp+lmUF/kT+7qoeS89QVy6iJ/OufKRDs4skASdtYFFDnOeWiJ/vQPCKtQEzSu7KleDmkhCDiaHut8Aj1zGKg0Vd66kzWGpSpBp22uRbh0kv9gXjX+oYMTHAzPTBvCZBls9klv7z8Sq33gljdPYjR4B/I0uo3KfjAoQEEHEH9MUUeWU/qlRqO7lJzhw4MQZzHp07DlCJtxIuHEY5QOtAuMvsUqLSsmicKGYL2sOQcEXzxJshGFg/bmNOjERt6AOlYsJCXpWK4RSGm/f9aq8FWVdpQMoiIEYhvoFIXnjqCEnD7/vp++CnIDF2O3rXL9UBRhVH03u6mAqlfVJIo/sFwTJhHTMoYru9SW33oCS8pqfDHVgEEfn7dSAP6SWiOJZkSMme+Q7s5hZ+N4iVJ2PwGnO3tqyaPFQbJfHS58YSUiquPSqll7XI5iCPvqwGNmmJ4YiwNf/8uvGfWmi4cgo7NnPiOCxEIClWwoCQPe6VKLtBxMAbL8TeucORXcsy95whglUBDfM3V48f9smFFqrL9tHfYH3JX7OHg8QsZ2NGlKWeUtwp7ZAutrWV+wgQboc7Mr0fOX6yQZoO7uS5AhLNm0howltw/QasOtuDitOqT6bBQj6LYAy5gx/p9Itu9jCAZ1LkXP89LyEC9d35IUZ6OlSk7TH/0aLFOOcBP7Nf+htKLT63rR6L7RjvMfrx8wrZUpWOesntUGgPDBsatjZ66yw736KZUzGiRHpTWVt/9/aiiZsMHa3Q1+eOkDnAobhH8Bf1qbyyKBLyJzZ6Oex/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(5660300002)(70206006)(6916009)(2906002)(4326008)(70586007)(41300700001)(316002)(2616005)(16526019)(6666004)(7696005)(8936002)(8676002)(1076003)(26005)(336012)(186003)(44832011)(426003)(36860700001)(47076005)(83380400001)(81166007)(356005)(82740400003)(478600001)(36756003)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:41:35.4874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5274dbd8-7821-4769-61f9-08db92068840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TBA and TMA, along with an unused IB allocation, reside at low
addresses in the VM address space. A stray VM fault which hits these
pages must be serviced by making their page table entries invalid.
The scheduler depends upon these pages being resident and fails,
preventing a debugger from inspecting the failure state.

By relocating these pages above 47 bits in the VM address space they
can only be reached when bits [63:48] are set to 1. This makes it much
less likely for a misbehaving program to generate accesses to them.
The current placement at VA (PAGE_SIZE*2) is readily hit by a NULL
access with a small offset.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 30 ++++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index da2ca00d79e5..dd6984c785ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -330,6 +330,12 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 		pdd->gpuvm_base = SVM_USER_BASE;
 		pdd->gpuvm_limit =
 			pdd->dev->kfd->shared_resources.gpuvm_size - 1;
+
+		/* dGPUs: the reserved space for kernel
+		 * before SVM
+		 */
+		pdd->qpd.cwsr_base = SVM_CWSR_BASE;
+		pdd->qpd.ib_base = SVM_IB_BASE;
 	} else {
 		/* set them to non CANONICAL addresses, and no SVM is
 		 * allocated.
@@ -348,18 +354,20 @@ static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
-	/* Raven needs SVM to support graphic handle, etc. Leave the small
-	 * reserved space before SVM on Raven as well, even though we don't
-	 * have to.
-	 * Set gpuvm_base and gpuvm_limit to CANONICAL addresses so that they
-	 * are used in Thunk to reserve SVM.
-	 */
-	pdd->gpuvm_base = SVM_USER_BASE;
+	pdd->gpuvm_base = PAGE_SIZE;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
 	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
+
+	if (!pdd->dev->kfd->use_iommu_v2) {
+		/*
+		 * Place TBA/TMA on opposite side of VM hole to prevent
+		 * stray faults from triggering SVM on these pages.
+		 */
+		pdd->qpd.cwsr_base = pdd->dev->kfd->shared_resources.gpuvm_size;
+	}
 }
 
 int kfd_init_apertures(struct kfd_process *process)
@@ -416,14 +424,6 @@ int kfd_init_apertures(struct kfd_process *process)
 					return -EINVAL;
 				}
 			}
-
-			if (!dev->kfd->use_iommu_v2) {
-				/* dGPUs: the reserved space for kernel
-				 * before SVM
-				 */
-				pdd->qpd.cwsr_base = SVM_CWSR_BASE;
-				pdd->qpd.ib_base = SVM_IB_BASE;
-			}
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
-- 
2.25.1

