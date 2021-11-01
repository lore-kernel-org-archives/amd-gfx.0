Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED48C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E638A60EBB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 18:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E638A60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBDD6E2D8;
	Mon,  1 Nov 2021 18:45:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7CA6E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 18:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLbwruvmgmVRo7ZZwoz1kLVGNGlP8Xxn/pf1V2Dqt/aBZMNYEdH+aOmd6umE53CJOxiYO3jzysm7Djxo9ljns/GpRAm7+sxkBDozSA1Lq5DMYF8mgb/d/JL+m9+PlU4RRegoXyT5T/f8MjBmn7SrTwVdXkH+5OHa+vA/dDk4z8bCvm6BLIYYMNymAuo+96xQaxLJOyK7Nv5T7BBfYK4r3P7q7dp+V7iL5s8GluP7shu8GJuJZm4+VIGmZbREKRiCM0kU+Rh4Ed9yKm9PhjRPJ7ZydJvpRs9sdDK5oAlmsQfHNJU7sql9Iao+pk3LYVX6sSCRZ6Zz6AZuKrz8Vh0Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phdLL3FJhdkcT/2/aJjyCLfndk8C10vGBm4S+fTUMeE=;
 b=hShUQGaF1+NYbHl0VPMJ1aTkniS+jsH5/yR5KbYrNQoAAwk3YJvzZHDpdxGYCTghIbOj3TS7V0ybaLJ78eb4QBHTgaedOEZKPY6FJMqj1YIXh8f5TJwyIm6co777G3McpxInXugXUJSde7ag3jStpiptvUF+OaACFqdzHr+KgwiqMvY6e61DsATrFUAsbB3syQ2Cx4bdzMmoNzp4E3XLmGyR8133CtJSuGHIxemva5lutyEq90+Km5C0rdW924O89lZ8Sk52m5u3mGPzWm4jfd0D88wDKrf/jkG/5FmdApBU2i3Ccg9jD1eEFGTjCKb4A/UYubq4dEGkIpz3EDikKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phdLL3FJhdkcT/2/aJjyCLfndk8C10vGBm4S+fTUMeE=;
 b=4YMBSA/Exf91F7oxIPSC5AX3Cm56EWuBj6IuFLGRtW2MQKiANAaF7DjYxxgXcxieuihCxl05Yh/qnZiADedtTRBHKR0tHOXkn1EJDPKyKlVs9suPi1OqBZdbi0mrYo2Vgy+rgwJ+Z8i79IUuXNcdTnD/WzDI+6+gvXK/1aTE8lM=
Received: from CO2PR04CA0164.namprd04.prod.outlook.com (2603:10b6:104:4::18)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 18:45:46 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::98) by CO2PR04CA0164.outlook.office365.com
 (2603:10b6:104:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Mon, 1 Nov 2021 18:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 18:45:46 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 13:45:44 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21.40 1/2] drm/amdgpu: Make sure to reserve BOs before adding
 or removing
Date: Mon, 1 Nov 2021 14:45:20 -0400
Message-ID: <20211101184521.1689060-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e83d54-4e26-415a-660b-08d99d67d0fb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5246B0D2991D52593E449686858A9@DM4PR12MB5246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIWiY/F80Sl2ENRw0x+Umycqch4xD+jviEbVpifRst4ou1+7TzrdiOvspQFMtQTrBF4hS4o2943+CO39Xm+bjFvLFf8ZqAPqKZqicHv/QwI8jwWM8kXtbsemeXZCYAhA7PQT1COQF4Xa0fvfQ7GQZ1KSFV83SWthYoFFgguq8Srg2bkF7ZXNQ1nlbgt5oV++NcGgWqirpJHLPtF7GP9Z5o+4ZiMDF+IDWha684X7GXDCkERUQPCh1PO5gEgDuv53BSDH9809jp8F5yYsCKND1V/MkVy9MaXWpNMirDAxS+ys+zsXliqtAy6MjKex8IZaTTxsJsA9AmY5WROwRBWKohtXSNA/VD7GRhDq8kHljfmR9Mhu+R4g8E9etgaG4JGwMx2OZB0Yqx6PWT77S3/WJTpNKvXmjOLSTNZF4CoaEZEGzfpasF9dzAPtck33Ux4Y5Yw5wszLrW4/4WLHwYqfUIbpj3GC8O+VhcXndBbIqafay7GaZwgNe1jUIFZ5G6n6XSFjL4QipM9MSz3mazyvT0rm6uKktIDvgdA2LRdYwIkUART7aFpVWb8ygbg2x8gVhOqjqYSJf70XbQEATzw3VPH+UiQY5BTOuEl9gdxGSGodZC+cxuO2cuH8PpBTwFyhmVEEUNpemoJyfM4OK/uzFZ12tKAqs0B5wnb22yZbM+UqFX0D2zV9PaRhbGLopBS4xXKKsj26FVq8ytdzZTlqGbO6AfQK8dQ0Ble7pj1bL1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(316002)(356005)(26005)(81166007)(186003)(4326008)(508600001)(86362001)(6916009)(2906002)(83380400001)(36756003)(8676002)(7696005)(8936002)(70586007)(70206006)(36860700001)(44832011)(82310400003)(426003)(2616005)(336012)(6666004)(47076005)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:45:46.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e83d54-4e26-415a-660b-08d99d67d0fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
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
Cc: Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BOs need to be reserved before they are added or removed, so ensure that
they are reserved during kfd_mem_attach and kfd_mem_detach

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 61784bbfd7fd..8d30ccd70800 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -798,14 +798,19 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		}
 
 		/* Add BO to VM internal data structures */
+		ret = amdgpu_bo_reserve(bo[i], false);
+		if (ret) {
+			pr_debug("Unable to reserve BO during memory attach");
+			goto unwind;
+		}
 		attachment[i]->bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
+		amdgpu_bo_unreserve(bo[i]);
 		if (unlikely(!attachment[i]->bo_va)) {
 			ret = -ENOMEM;
 			pr_err("Failed to add BO object to VM. ret == %d\n",
 			       ret);
 			goto unwind;
 		}
-
 		attachment[i]->va = va;
 		attachment[i]->pte_flags = get_pte_flags(adev, mem);
 		attachment[i]->adev = adev;
@@ -821,7 +826,9 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		if (!attachment[i])
 			continue;
 		if (attachment[i]->bo_va) {
+			amdgpu_bo_reserve(bo[i], true);
 			amdgpu_vm_bo_rmv(adev, attachment[i]->bo_va);
+			amdgpu_bo_unreserve(bo[i]);
 			list_del(&attachment[i]->list);
 		}
 		if (bo[i])
@@ -1700,12 +1707,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	pr_debug("Release VA 0x%llx - 0x%llx\n", mem->va,
 		mem->va + bo_size * (1 + mem->aql_queue));
 
-	ret = unreserve_bo_and_vms(&ctx, false, false);
-
 	/* Remove from VM internal data structures */
 	list_for_each_entry_safe(entry, tmp, &mem->attachments, list)
 		kfd_mem_detach(entry);
 
+	ret = unreserve_bo_and_vms(&ctx, false, false);
+
 	/* Free the sync object */
 	amdgpu_sync_free(&mem->sync);
 
-- 
2.25.1

