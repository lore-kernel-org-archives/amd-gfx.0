Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DACFC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD1810EBE7;
	Fri, 11 Apr 2025 15:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f5XcyxC2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1D110EBE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmIH8NzGPUaj9YPKkBuCutn40cFd1OapTHQRHcwux+mLdf6BP14TvA4tJ7SaPWuKiRkCpUO2wmNEuTah5Bmw8B7y/+dvcl3JhjZTafM/1Xjp2W2Wj0G5xK7B2f04i6ETxoLKdTZTpjRc8Cca3NuMA1kFoxri+CO+LdNmVT712agWVkgGKcr/tTBxI1tqX71HJPgH40tAGuysH+Z4FYFebzz2FX1h0/4Rd9TciKmQ66MBnuPhOf61Ok4qYaAnbasVMYtAApue0R321T/bHhRfHNxIf2Kvs6G+rQliMckqAQILJKLer/tFBCsTwoKodm7NrTYc2K5pyjqmW0thAtos1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLk+Pm6xiyKbaTsBbQKs+XMtdWdihZ0UJmRblD+C6m8=;
 b=OhIQZfHPIcfG0fE8pQogpa7jEfNggscqVou8l5XOjxv62SAoa/3U3eli24DdXD4jBJOlzFMhdiqEG7M5jAe8ncQkH3U3sjXyLRM4DzQU2IWFpnkaunYOdUcINptE45yZWgiquEmLk6EhE1KHXM0n4xdPRkCzAkbe1mKBldvdtiQq29d3xNd03KqzJmpMtPNYIECb2xZ7aMDN9cJoTec1YcIbZGEt/MM2RXlOVbwfs5EJhTUHv1v7Uag348szxkI8c6pU3PhQk4Y8uaIKkefJ5GrT0ey7upAXS6xBW3AKKcdXbUAVhBIfb5Kwaf4w8dTm8CqfGF39EnSDc3ZouTeniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLk+Pm6xiyKbaTsBbQKs+XMtdWdihZ0UJmRblD+C6m8=;
 b=f5XcyxC2O1I0n5kgeCa9fUM3gem8+kOrZr7swn63NjbVVwrTMvs0aBvPtKRXFSC8ktZcnMmWZZ45oEoBXjyVlor7yTqxWL7Jx4j6iGuRQ8P6wH5iVeg41YVbUctX/6r9htk0F0OeiQegLKiI6SPooeN8Fy6AAfGfWT/YT6WPtXU=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 15:01:08 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::c9) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Fri,
 11 Apr 2025 15:01:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 15:01:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 10:01:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amdgpu: Add NULL check for 'bo_va' in update_bo_mapping
Date: Fri, 11 Apr 2025 20:30:52 +0530
Message-ID: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: eb70047f-668b-4f43-4732-08dd7909b0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXpYUnZDdDd2TjlhelRMNGJJSUkvbXZGYmZDT1Y1K0tmUS9kMlZ5RjFjRTdR?=
 =?utf-8?B?YWdzeFdQSVMwY216eWd2dmNmdUVsVTF0TmZvcGNaRHUyWnE5YW9NbGNvMkhs?=
 =?utf-8?B?MXVmWFNiaXVlRHFRbzZ6QzhqbmxmdDNLQjdPemdzcFZ6STV6VkRXY253VGJi?=
 =?utf-8?B?NHpaK3lJeHBRZFowRGVsTjBiL1lpQ1ZZdjludlNpRmpsRHpGdHhQdklNL2tW?=
 =?utf-8?B?ZmRDMXhlWjI2VUJUR293TS9hb3gzTGxLWFpraUE3Y1NKT21peFkybmt4NlBN?=
 =?utf-8?B?K1RzaDR1VHFrVEhDNEJ6QlU5QzNPOGNaS1BwOVplOXQyKzlsaDA1b0dPZC92?=
 =?utf-8?B?dkw4OW51QmVlbXVpU2FDaHhUNWFWbmJOdjFEempJSkVxUG1WajNjYSsrRGpG?=
 =?utf-8?B?dHgxMzd1NDBIL2FUSmkzcURpUnBIMmh5aFIrak9wbG5iM1V1RzBhemVERUk2?=
 =?utf-8?B?Qy9OcHFXZjd4VDJZTDhSOG81REc1QmVzbkRmVTdndXQvZTVPVG5FK3k2emdz?=
 =?utf-8?B?YTBqcnh6eXJORHJVdUpoUmxZNGNCajJnMmpORVZwOS9TLzhrd0FOTEVQa01i?=
 =?utf-8?B?MWtwYVliOEltLzl6V0p0Wis3SE5QMHlYYVBweGpUV2tSWGNnVDc4SjcxNzB4?=
 =?utf-8?B?TWUvYXZUY1BJeXdkamlqK3lsejMvdU1sdUpBVTNBZGNKOW5aQnY4ckk4VHEy?=
 =?utf-8?B?Vi9jNEMrakI1WHFGS2o5dnB1elk5cmJ5aHdCbzM5NUc5RHkyenUvbzFGWlFq?=
 =?utf-8?B?SGdNeUFaRlcxTm4wc3IrYlovcE45OXFPTjNjT0xMTE83c0J0ZFB4QmNpN1gx?=
 =?utf-8?B?d1lwN3RQMzZJOEl2enlFT0dYdkVUaXhqcWMxc0hPNzM0NHdzby9RVHFsV1NK?=
 =?utf-8?B?Wk9pRUI5VGo0SWZYREY1Zmg0V1lrNTNGZy9UZzR5VWRJQzRUcjNIYk90VkJp?=
 =?utf-8?B?dUd0ZFRycDR0bm1oNG5WalFMdG80TzlCdDJ4RktycEswRjVtb3RFV2tDODBH?=
 =?utf-8?B?RzlkSEhzY0hXRHpzQURqVlJqMVlCdGJTSjJHQjlreVkvSFI4cG41YWd0WWVk?=
 =?utf-8?B?aUhwNjlkaFV5TDM5anZhRmY2TDV3OWJxV1dIQUdsZmhIamJDampiRE1YS0Vr?=
 =?utf-8?B?RHdXOEcvWmRQbDBHTGhOYjl6elcxbnFoV0Jua1RJNFpHZ25SYXFMK2FrRFo4?=
 =?utf-8?B?SkkvT3M0QnFHaWpSMEsyRldpYW9QY0hKTldnak8rRS9RQ0xKM0FxL1R1bTZT?=
 =?utf-8?B?Z3NxR3V1QmdrSzVCZjBFUGpSOGJDbzZvZTlqOFc4TEJod1dkSmt4M0QreWhT?=
 =?utf-8?B?WHBCVDBHRFczSnBML0xCV1VSVUtSeE9JdHh1bDArdDl0QW9rNGpXeDNsSXZs?=
 =?utf-8?B?SU9TMkNVazUvNUl0ZEpHM1lJYnpOOFBvRi8zUU1helNrdkZrY1JaV3I5aXBK?=
 =?utf-8?B?QjE5V01TdVZCVjRRZC9jRUQvckpQemR3TUsxdFhWanVPYm5vMjR2aHNETHZY?=
 =?utf-8?B?S2ZQVUVwcFdhRkVkSXZBeWxwNGRlTVNMTXB3c3dad284dHpZYnFXb0FIV0VN?=
 =?utf-8?B?eVVhMGlTVE5QdGExR0taczRtZGljaVJwcDNmaHhNcy9EQ2pFS0lYSzhpeU1y?=
 =?utf-8?B?VGd0cVV5K1pCNG00c0wvcHFFem52eVRlSjQ2Sjk5alNvUWgza0didjJUOXE3?=
 =?utf-8?B?dnVoVGU0ZVFmRStKbytoclBIdm51cXp1WVhvdTlqbmFaMG5KYytpR3NJUVlo?=
 =?utf-8?B?bTB6dkR5c3ZGbm56UnliUXVSKzRSY2NtdEY3Zmo3YkJxWGdyTUdGaXhqZERH?=
 =?utf-8?B?ckpjVkZabG8zS3N4Sm92alBSb2ZlVnpCeG5nUjhQczFseHJzd2VlZjRsYVF3?=
 =?utf-8?B?a2k4MkxoVHBMcjVZaGs4QmhpV05HZkRFeEdncDRvekRBdGhkbU9zTUNHSzlE?=
 =?utf-8?B?Z0tub3AyWGdVL2JMaVJhS3krZXVhc0RLaEZuNllZMXVZUVYrV0lrZ2JscmRa?=
 =?utf-8?B?WlFqeExJZ0JlaGY3VWhNR1l2L0hpcXBtWjJJZHRaTFlRU3NWZG1CcWQ0cCtY?=
 =?utf-8?Q?BzDIue?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:01:08.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb70047f-668b-4f43-4732-08dd7909b0df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

This change adds a check to ensure that 'bo_va' is not null before
dereferencing it. If 'bo_va' is null, the function returns early,
preventing any potential crashes or undefined behavior

Fixes the below:
	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
	error: we previously assumed 'bo_va' could be null (see line 124)

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
    115 static void
    116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
    117                              struct amdgpu_bo_va *bo_va,
    118                              uint32_t operation,
    119                              uint64_t point,
    120                              struct dma_fence *fence,
    121                              struct drm_syncobj *syncobj,
    122                              struct dma_fence_chain *chain)
    123 {
    124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
                                  ^^^^^^^^^^ If bo_va is NULL then bo is also NULL

	...
    135         case AMDGPU_VA_OP_REPLACE:
    136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
                            ^^

    137                         last_update = vm->last_update;
    138                 else
--> 139                         last_update = bo_va->last_pt_update;
                                              ^^^^^ This pointer is dereferenced without being checked.

    140                 break;

Fixes: 16856d135622 ("drm/amdgpu: update userqueue BOs and PDs")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c1d8cee7894b..247fbd014b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -134,8 +134,10 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 	case AMDGPU_VA_OP_REPLACE:
 		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
 			last_update = vm->last_update;
-		else
+		else if (bo_va)
 			last_update = bo_va->last_pt_update;
+		else
+			return;
 		break;
 	case AMDGPU_VA_OP_UNMAP:
 	case AMDGPU_VA_OP_CLEAR:
-- 
2.34.1

