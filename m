Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1445AC41513
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 21:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9D01134D1;
	Thu, 30 May 2024 21:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tinT5t6a";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF37211353B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 21:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRc9Cs2K6ny3+BL/5oCy1z7nzRv9nxYkjlBfwVEVGOU/4AruI1GoKkFvATfOhvKFQdHPUvVYO9nrj9SfNzEaF9Ycaq2cwT1xg9ogKCRUofN7MbzaoQ0qySZ2upsA5pPH7duQbnn9KJCs4yNHbwtVUUQbctxQVzremyGovya0rXWM8U+1LQj2uzfeT6dCJ5qOk5WdcGQvj/Qhw8Nleb8Yeh2T5hGGvxAL+FwNl3izeBAUBrql+N8kGnatvSOYkn0q0DSIMHXq8T4dfof2A5FZfC0Vf4Tpjxwrbrzv9KMnrn+Ju5EEioEC5eD94fcTgreiCvlqg7BrXUl9EovkQluGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/6tXnQNzK0Sba+DUJysz55KMG0s7WRiY5nvK/RFXfw=;
 b=PySgYmhXCU5vapKvSO+6Lqtm1FgYzzwMDXMX79nTcu1jDCwDA+yeOuzowuwxWG1rwR1NhW7xBg5R0ILGSKy/Gf5xfH1R4waY4RG8Uysw2i8TmwS77cOmU0/v/RPuQIcxRVAtPWL9cwcbdxzedJaLu8LT96ZJci+tWPCtbmiR5w3Ymq9U/NaJilMabdDcfwMSbWeyxHgJncHCRZGRUNZ9dDToQqQrr9hkOwLq2tLwdA3PtFOX8PEGw2QYLoz0/46PdMg7SFu3XQ1d//k6NWiblrBdsAe5fvglXt3PHt6s0bu3RpAPUgWPMTJ3+lVGXXWhi7/e9KuJCdqR8VvOd3FUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/6tXnQNzK0Sba+DUJysz55KMG0s7WRiY5nvK/RFXfw=;
 b=tinT5t6amKHqxeBGHpcR1uOewPXf2Uigd521j74tzHemsFllrK+5qHZ8l9E2q/mDcC4GXXnJ5o1xWk476+qCqK1S/ILZfiOy2x08sZID1uQ4lfU01Ub7aWhMZ1j0/0qYK5CfXH2/YYUhkIU32rWJjpvUAoC5vH6kPZSWGtwtpJg=
Received: from SA0PR13CA0019.namprd13.prod.outlook.com (2603:10b6:806:130::24)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 30 May
 2024 21:48:31 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::e9) by SA0PR13CA0019.outlook.office365.com
 (2603:10b6:806:130::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 21:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:48:31 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 16:48:28 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v3 6/8] drm/amdgpu: use helper in amdgpu_gart_unbind
Date: Thu, 30 May 2024 17:48:03 -0400
Message-ID: <20240530214805.40970-7-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530214805.40970-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f31143c-b79f-4499-e09c-08dc80f23f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjZFUDZyTHZYVDVHRVRQUGVpTmZON25oTFZSQ3ZjRjljN1VKbHk1dElxYTdO?=
 =?utf-8?B?SzFSbFJvSDF5YVVxR01Wa1ZiMDlRSVNhendJWC9mTWhhaEZjUng3NE45ajhw?=
 =?utf-8?B?Zzh6WEdOMjFsaU4xZWdKSFV1eERlUjl4MW1CSG1JaVBjUTlyTTR4elJZQ3Bk?=
 =?utf-8?B?V0pDV2NrdHdaSUlydjlzZEM1TjNmVTdiQS9OQUZuOEdBRmtDQjl0UlZ6Y0xw?=
 =?utf-8?B?cVI2NWNFZ08yc0pPUXJnTmtDeDJsdldaQ0hwaWJYbUZvdmRNL3VUa0VLMDN1?=
 =?utf-8?B?bHI4V2tvb1YvUEQ5NG5VSWZkN3d0VjkxWEhvRDQvdUVncGc2eU9nNDRod2pq?=
 =?utf-8?B?OHlOdmVCNGg3MXNPUXdmZUsxK2xRNWlzVHVTeVdkSzh3VjkrMFNGeTdTTzB5?=
 =?utf-8?B?TENpZWgya0U4ckJmeWw2SnZFdUQ5bTMrRS9jK2YzbEpWTzNpZk1QS1Y3ZGIv?=
 =?utf-8?B?WVZjc2E5clg2cWxiZ2tJUUF2N0tGeDBWLzRnRzVuaE9McnNZRlcvb000alJ6?=
 =?utf-8?B?QkY4WDRaNk5nbithWEZCWm1GWlA2MWNibGt3R2lUVnhBOWk4MXE3SGEzL1o3?=
 =?utf-8?B?S0RQdjJ3YXFGVWVHL29rVW1kbW1hYnFtNGV5eGFmZi9wZlNqN1NjRXVtbm5D?=
 =?utf-8?B?T0NKKzF5SGJFWmpObSswV0FXZklyaWcvTVRiQ1hnK2pjRDBGd1lpTzdlb2pt?=
 =?utf-8?B?Zmwrd3dvQ0lBVndVSXRYYnlYZS9BMnlnTWZPblRUZkZDazNXUDJTc1lFazdT?=
 =?utf-8?B?ODhMb0hUVlpWZnlraUEvREtQYlpiVkY3VE5lYVZPamhVdTU1dkhNSHJHUTdM?=
 =?utf-8?B?M0ZHK0hTcXJ6WjVMZyt0RVFJSzFvWStab2JaNVBoOEdnWFo3aHA5Q2Vhd2JS?=
 =?utf-8?B?eTFFaFpYV2YxNWhnK0lDeGxidGJQaEJyaFFXK2ZVS3QzYzJiMFZPTzlzU0FD?=
 =?utf-8?B?SVNicysrc2dMODV2Zk1nVUdNdkhzTnorRHR3bThUbFVaSFRGT1JjN1JzRk5n?=
 =?utf-8?B?amxLYU9mdW00b3FzLy9TczNtYkJySGhJMkZUa0RBTFhNZzdUNlYwL0ZNVElq?=
 =?utf-8?B?eWR4cW9EMnpqZUJ0UzIxOEJwTUJLbWFVU0t4K2lrR1VzVCtSaFpLamdTRlE2?=
 =?utf-8?B?aTFYRmZtaGlqdUZJQTF0NUZYYVMybnJweVpoOUgwVWJaYkdxb1V1bkNjVGNZ?=
 =?utf-8?B?Ty90TnRWUHlUZytaU0pWQnB3cHVSZzVSSFJ4S1RPZU1qcVVEaEl2NkVubXcy?=
 =?utf-8?B?ZHZVOE5uTVJDdzhxM2FPLzM2TTJ2eEZjWU5qZ2NiV0FQcTdiZ1dwYnMyeVBv?=
 =?utf-8?B?QUFnMW9lSkNZUk5ZdGIzZDAwc1dlQUlhYjR2NW9xTGRWSTVKV1BzK2kzakxE?=
 =?utf-8?B?Vmh0T3VhbmRNMkVHL3JiR1RWYXg0VzMwcER4YXdtRWNsaytrR09QaGZybTF1?=
 =?utf-8?B?elN0Ty8vM010cGs1cC85OHQ0Nks2NGU1Y0IzNnNrV2VRU3pIOWIzMHdwMVJw?=
 =?utf-8?B?eGFFWEFQNmN0bEZGS082T2pHUHY0RGIrVVU1dGl1UmFTOXhObG4vQlV1NjA4?=
 =?utf-8?B?NU5UT09WajRUTmRBQ0t2amtYdG5JZThpMU5zd3FCTEJpbldyY0VEQnpOMTdl?=
 =?utf-8?B?M245WXVVQWdPQTdyb0VabnNpU3VYRU1MeVZEeEtLRlk4R3VSTDlpQ1kvZlla?=
 =?utf-8?B?L29kNjVqc09UTDZoZUpaWm44cGlhVEd1ZWMzUXFKNnFaOGFXa0g0bDh1MXdx?=
 =?utf-8?B?SUZFTUJCNXpPSkt2d0wzMEFjWFY0K1VkM0RWSXhua3RDQk85Ly8yd3MyZWtV?=
 =?utf-8?B?a09XUTlpcXFZU3hweHVxRFZVRDFsSjR3RVRBM0RCM2t5bi9rVXdrYUNEdS9a?=
 =?utf-8?Q?NK/jrtC+mOdKu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:48:31.3330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f31143c-b79f-4499-e09c-08dc80f23f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778
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

When amdgpu_gart_invalidate_tlb helper is introduced this part was left
out of the conversion. Avoid the code duplication here.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c623e23049d1..eb172388d99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -325,10 +325,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
-	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	amdgpu_gart_invalidate_tlb(adev);
 
 	drm_dev_exit(idx);
 }
-- 
2.34.1

