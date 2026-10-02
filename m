Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CDACA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 15:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5508D10E510;
	Fri,  2 Oct 2026 15:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S1be38C9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5433D10E4E5
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 15:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwwX/fUcdKBQjtMrpP6kAdTiJSS41+7mhMgsmEEVwelY3rCwkW2n1Dw13YabBW42q7az6lQfeXbN3DwRDEJk1/YO72D71HN6lgnYTkFS4xfhXwWB3oufHhwak0JFe7qDI8G10FK2+xR9P2JKlsCKyM/W3VqyyVXYBvBx66rEnph9jBW8hSnr/hLKBZYucud9T3Fw2KBGO00hemPQ2Jjuw/fb4YRuaY3xCm9mTpFEitTSFnvn5Pybr6yV7XzGXGKKz4TLCKl358h04GsnFMCGT7NLXw/F3Ez8WSnR4OaXppjfY6MSDPegV0QfosZzMPeURpTBDC7JfZCE0+o3KhkWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PdujgJuZDpJQQ8JenueFHgeWd5v7EEsoom5+c533uM=;
 b=hKmsoDk+P8LhjB7FmaGNSRVYFY5ZVCmahKEgAbOeRClO1NAqZG9o46fLgOfo9SvijkpHxnIHxepXnFGYplz915spqp0KBtvCaP1f5axfCSOqv83Kf7ctDV2ihtYRDHPy4UutZ1cJXwhJ+50oOXqNlzdP2SvjSuo6gknaTFhcuDpySwlc12ZuIo+6FBUCp9VFisWbBIOGmpLOYvLIXCL1yw0lP7Vezg6A2urDThbF+06kB3YFdt4/D4HLNB6wCaaDpiDvTOdMVZkzRNrqlAz9m5N7pdVAkV1XJMiXIsnIjVdurpgntDVEc8bFdpOU/RSupGcRlOEaANtMunXP9FYPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PdujgJuZDpJQQ8JenueFHgeWd5v7EEsoom5+c533uM=;
 b=S1be38C9GrUeL9ZkrtRs/hRIvRiYvMDcyqhFkj2GMAZUlkox9t7mD1lph/Y2qxClcoe2dC8YIjv/9EFETTIznujAbsyu0xEDWQ5CY4h2wisR6dMs0GRHUKibztMNu7yq75PiYnkaaQEVZ2Ge+um06+PbRIQae1mca2cA5GYQxSM=
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 15:54:44 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::98) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 15:54:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 15:54:43 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 10:54:42 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Mukul.Joshi@amd.com>
CC: Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Flush NPA VM TLB after page table base is
 programmed
Date: Fri, 2 Oct 2026 11:54:32 -0400
Message-ID: <20261002155432.334448-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: aed59453-7078-46ea-8c73-08df209d7a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: ZN9WYoh5haGssEscevUgZSoJXPM96q8hkZx2fnfP79fJOEnPNaivEDQU5RwtGEARcHlxnbVC12mB9aunPrN6vsRxZrJdfXFhZRVheOIeHIPFHSRP3zU5Oi2zRMiFiOXL/6xQYb0vXVz8d1rFdrPps39tmQef1aPuTuYX7S3WYeyq2DYUIT8dub06EcZmnpYzlJhvpgLkz9S0V0Pe7Wjk6IX7RblaHj4W2YvezUORHBDRlxXPegWZDf6VS5Cecm0ae6wl4asoc3mg8qKoeo8j78ebk/qelo6dflqSIY12+rzuKN9Q4B/C53zTeo4m/WJYao6JBLh1QdVAwNAgjZXIPh3JbUneBn0ektb/GqQKIdprm5SJNkrj60ROiQDiiMixLTKuFMuMVyX7X+rKnQhTnnxTONlB6MSob2Tch+qEnmcE//WUax5tqLCtC6dAAeSM8l1Ab4146ytA+5IAgt1Lk8WOdVXADeWutYoFFvTbs/o44hk33U7uYCj5VcBAzDMFy4qXF6xjJ7XQSuMPDiK11znp4ySM1bby5aytnsgAYZU0l/IFqxreORppiXR6bWW9uie3Xv2kxH6LIlEYczDOZ5Wto2yp4nG78CCtAAF3NbC8evQ8CI89OSyd0KK3OocImNJkf0yagx/KshgysVFFSUAXVFNqjevN7snfJ1ieoEPXLXgwiJQPEOn8Are4i4gWVug4VEAx14yUr6+T0lwGFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wI7QQ3eaTgArnGwlLlWIZ9aZ34t0GdwtKUK1e76MkBoD76TK6Eh22I+npZ/zx/jRR9TTecLV9Sqa8wWAY8XWxFxnlY88n6CR296obao6UJOygffdp7xaAAK2k4bVy0FjDykEZkP6VkD+oMutpZUSh632Vr/UgrUD6SP85y4fvbANBgLuxYb3tV+sc4mbH7Jfqk5jIRJpltwzFTyzUzgToBzSQIW7JHZHhd7gJfAyLU4TKo/9Tr4DZJH1T1HiD0CCfHIS3wL0KuEMw2+xzRyVrXC7SWIP07W+Hgc7LOVB3bt8LLIBQM2il6k8TlgXQVazPJdd/DEBay5EvRqF26ekF2Tkb1b+mZncpwbnK6SzYjmhBHj1nbwomK9FPmmm0rtjXoZVFfTccq4kCJTvlfyvd56VMPWSC8CQowdptrpsZYGymc0YlK5ngcHLLUN1TDhl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 15:54:43.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed59453-7078-46ea-8c73-08df209d7a02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

Flush the NPA VMID TLB once, right after the NPA VM page directory base
address is programmed, so no stale translation is left behind from a
previous page table.

After that the TLB has nothing cached for the NPA VMID, so mapping a new
NPA address doesn't need a flush. Drop the flush from the metadata NPA
mapping and from amdgpu_ualink_map_npa_addr(), which never updates valid
page directory entries, it only maps a newly allocated NPA address.

The NPA unmap paths keep the TLB flush.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 758265670340..f49404a6dee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2148,9 +2148,6 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 
 	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
 
-	/* TLB flush may be needed after updated page directories */
-	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
-
 	return 0;
 
 unmap_npa:
@@ -4162,6 +4159,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
 			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
 
+	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
+
 	xa_init(&adev->ualink.exp_xa);
 	xa_init(&adev->ualink.imp_xa);
 	xa_init(&adev->ualink.handle_invalid_xa);
@@ -5056,8 +5055,6 @@ static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 			dev_dbg(adev->dev, "failed %d to dma fence wait\n", r);
 	}
 
-	amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
-
 	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
 	return 0;
 
-- 
2.50.1

