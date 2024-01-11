Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E6C47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 07:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C8B10E7CF;
	Thu, 11 Jan 2024 07:22:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FE710E7CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 07:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+7y9jj8fvClxQJ86wF7qYBFpZqLwBZIxRK7l2cBBcfQ0mYkH/IZ1VwpKXmnVusyOMWGkFGlUpyXJlo+V639h0Ybl0kiJ3CkJKRujH/d5cakEN/CuMTCgaqeBMwIKV8mfk4VWW/MxV/gxGQw+0UnaZcmF+PAZm2weRBzfqEAm7VGjh1Hn3zkuiVdRISCyPkVcYPuNCLKrfe578SYB7FrXVBitiAqNTQP20xE9E8sCFvTtUg+/ixn67/A3iRE/M6I2+LCAfcPeIaIvi7lw8wRxWBmvRLTQK+t6DCf+HUxnQtW47UnQmEtkI7hCfZnYQlbki2Kvp+fav1Z0TqEve7xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr14fkch+XhHXy+jlw2bbEXs2I4G81OmuqtYBfAtHT8=;
 b=STyhruImOocmtqYJqczrMwCo4bnVw7VqCKzPyWxUsPIh3fEzYKqfCqhts+obno28DAv0Kb1Vr3LwxjaongoAKVRYt+dh7eQgdo0Bj/vdi/fl7PBx7IDERBBHXbCZ31JFVT8nhFNLEXJaYxXwSfll+uyfu6stAEIjSmSUfbhQV/0sWuKq1TWoweXeRPUn4rYJe57Cou8bKYqpKovv4xKpqSD1NA7rxFvbZQUMz0jWB7wu61hkUCEx2PWejyhlWRcNnVdRZxPRG2c1xFNYdq1+o/E3e1SMCR0Yd1pY1kh2RccRhqr+iNpRPTGks4UgigDDH/ZrgIhGHpvpaaXlnZQ8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr14fkch+XhHXy+jlw2bbEXs2I4G81OmuqtYBfAtHT8=;
 b=qelmLN2mURrt0eDTOMLlKWX0ryCXLzhbIwcnEp9UwoeH070G1dsM9XND6S8ApYVaon0xvH5ZzVx2lzB3Q/JJHGiYk9vujciCjx/ov8gnZFzUi8i6sAHERo2BMYGk8YxzJweEnvEHO/lddPK1vCjN2q7ybkp0BP1ZlbkiA5HiSRk=
Received: from SN6PR16CA0062.namprd16.prod.outlook.com (2603:10b6:805:ca::39)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Thu, 11 Jan
 2024 07:22:42 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::4c) by SN6PR16CA0062.outlook.office365.com
 (2603:10b6:805:ca::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 07:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 07:22:41 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 01:22:40 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: reserve the BO before validating it
Date: Thu, 11 Jan 2024 15:22:21 +0800
Message-ID: <20240111072221.90774-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 789eb86e-2ba7-45c4-b436-08dc12761940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMTbuewfQnanWZrQkI333BBvsxcgizse1svhaoqgVwYqpg27oHX4sz7lQA2KegyZaPf442Sb39xMGrVMhv7icsGwJ+os1nluYCD9c6iWPKI4CEv8dh9EwMCRfp5YjQ72oBMrpsbJhMEs9r5AwLDuljQMjaRo2LfppmiS2+IZaMpcV2xcFK28K3uvOjRcuL9w/aVI7amsi8aNuDWj2Mj2MiNH/S1Uar7WVCetoblDjMtXMeoXG5kYq0GjH4a3cwm8ZDeJXpL4MzwttApei73wRyKK5v0EqV8GzHAcGiLWpqw80sgb4c3Bj/PyVyZmTeLlsv0cYVsK0AVJvn6icB61MPs98pNaMr/62tdjgiGy/Fa6+K4luRTeHswL6Hg3QX4kNzfe+hN28jDvxJ34y20Blg6JTXmsbjh+d+t6kANNE0ovYymlLS7/s1zfrd/LrNaWqYrxGChGx9RnAFeK/Ub6yPbVAhYyl3RX5jZPu0ASJjMtcLhSzDt2u6TJ8AyjWTnXCOy5x+Sq0zE4YAN3x8cSyVfV0ru/CjeUZUNtVUMeLlMHVpRIp4vyn1Ag9FEHo7FymN5qt1LnxYWbGlycaljYgKmzRLi3lnzkzG4EdteYAjbTZ7PL346ehBQpc/JYSFyKHznv/4Tb6xfVcYCRx9gk0/ao//2VKB9O9nLgTbFPkXKPVyeMNpce/8VOoxJy+62W0yrMwgYYrEtusDhBPdDHGtm+JvJhPQQ0ipC9HnMkYztUNUnEskBPLXb+GpbgtEbL8qfJ6Wyat45ya/41sYU8gq2n1AMa/QfVE5rTumfAyJIvD0E+aHMwNcjbGFyY89nT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(426003)(6666004)(336012)(478600001)(16526019)(7696005)(2616005)(26005)(1076003)(82740400003)(356005)(81166007)(36756003)(86362001)(41300700001)(70206006)(70586007)(83380400001)(5660300002)(36860700001)(47076005)(8936002)(4326008)(8676002)(316002)(2906002)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:22:41.8254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789eb86e-2ba7-45c4-b436-08dc12761940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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
Cc: Philip Yang <Philip.Yang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 410f08516e0f ("drm/amdkfd: Move dma unmapping after TLB flush")

[   41.708711] WARNING: CPU: 0 PID: 1463 at drivers/gpu/drm/ttm/ttm_bo.c:846 ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.708989] Call Trace:
[   41.708992]  <TASK>
[   41.708996]  ? show_regs+0x6c/0x80
[   41.709000]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709008]  ? __warn+0x93/0x190
[   41.709014]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709024]  ? report_bug+0x1f9/0x210
[   41.709035]  ? handle_bug+0x46/0x80
[   41.709041]  ? exc_invalid_op+0x1d/0x80
[   41.709048]  ? asm_exc_invalid_op+0x1f/0x30
[   41.709057]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
[   41.709185]  ? ttm_bo_validate+0x146/0x1b0 [ttm]
[   41.709197]  ? amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x2c/0x80 [amdgpu]
[   41.709337]  ? srso_alias_return_thunk+0x5/0x7f
[   41.709346]  kfd_mem_dmaunmap_attachment+0x9e/0x1e0 [amdgpu]
[   41.709467]  amdgpu_amdkfd_gpuvm_dmaunmap_mem+0x56/0x80 [amdgpu]
[   41.709586]  kfd_ioctl_unmap_memory_from_gpu+0x1b7/0x300 [amdgpu]
[   41.709710]  kfd_ioctl+0x1ec/0x650 [amdgpu]
[   41.709822]  ? __pfx_kfd_ioctl_unmap_memory_from_gpu+0x10/0x10 [amdgpu]
[   41.709945]  ? srso_alias_return_thunk+0x5/0x7f
[   41.709949]  ? tomoyo_file_ioctl+0x20/0x30
[   41.709959]  __x64_sys_ioctl+0x9c/0xd0
[   41.709967]  do_syscall_64+0x3f/0x90
[   41.709973]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 48697b789342..f5542a4ab8ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2095,8 +2095,13 @@ void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv)
 	mutex_lock(&mem->lock);
 
 	list_for_each_entry(entry, &mem->attachments, list) {
-		if (entry->bo_va->base.vm == vm)
+		if (entry->bo_va->base.vm != vm)
+			continue;
+
+		if (!WARN_ON(amdgpu_bo_reserve(entry->bo_va->base.bo, true))) {
 			kfd_mem_dmaunmap_attachment(mem, entry);
+			amdgpu_bo_unreserve(entry->bo_va->base.bo);
+		}
 	}
 
 	mutex_unlock(&mem->lock);
-- 
2.25.1

