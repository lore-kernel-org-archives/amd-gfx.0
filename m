Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEBCCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 14:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F5310E7CB;
	Wed, 22 Oct 2025 14:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+QYlfiz";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012068.outbound.protection.outlook.com [52.101.53.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD9410E7CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dROwZbxA/r5Qy0EyGNyo/78CJebkv27ucdjSWf3PQ8JpLToZgMoSe2tJZHuNppQKoMsXFV4i7HyP980ox0OYLf9yvWEidzNs2RsTA5BtgyJqq6Tca7O3+14nwvimIPDVEDhkstjr8e1Q5QUf827zMlkE7iW93BxOIRqVUhUhAzw/SnC161vNTd949TDxGT5vE/phLXDuOhTmUUL68MNxepzfCWS0qh0UwJrIgP1j4LTZxlZ7RWiNiy4+gSCTl5sU5f7HWIAjTFqcVC+zn3w2YK9YHm0UYXKqm13DSlYburfYeSwFiyQOnzd5QhXPUJyTEp/f9F8wE+EMhM6aSeBRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf38Ubrh3RON0kw8ghubgMRugqQzCkMrO1dp09lBfC4=;
 b=Kv0bvnAnVyhoCGQahkbF1MJxgRW2rjd4iT0wSIyE3iAoFX5AVuMH73GPg9VLT2ZpJfdRQz2Wy2NDiZDQtOeoONsOr4EHvOrrVEAGvwHoWhtZ49vUddhzwcBW1hL0Q61i/MlnbVwYBcI+kFw8rWU7hiBrq+nTCb1thsf3Tk3EBtktYr1cLjCAAkasNKIjS5MZxdvIN/MKkon+Rq1hZfCmkhU9f77uXPNhETHLoUK2qrYJFpmyaBeyIm2OABn5itLejZFw+rs2TQTLKFg1ITjhazwFap0jcEa7Px1x2nVzdK/vMZpRoD1EBdgnallBhNLyum1ehL5Cg5fwdZ7FbjSxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf38Ubrh3RON0kw8ghubgMRugqQzCkMrO1dp09lBfC4=;
 b=B+QYlfiz+wpjqKUWZuMYuJ1wW9zFr6SYCD++PjjOmTmQNnmcirsStw5ilcoiwMgedcYOTMbJD0zZ3nAY6DT/NY1hpaDvU3vO4DCuSQyhT6SQu41QNptnYcplmRW0pJzv8PAnECjfSrKtYNhfux4pw1M5Betfo1+CNEjdaphMO9U=
Received: from SA0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:130::15)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 14:25:40 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::68) by SA0PR13CA0010.outlook.office365.com
 (2603:10b6:806:130::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 14:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 14:25:40 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 07:25:37 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Date: Wed, 22 Oct 2025 19:55:29 +0530
Message-ID: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
References: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 4904142e-2082-42be-7f3d-08de1176e086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3NuWWN6QUw2T3QrU01QM3ByOVJaNVRycE9FMXdKaEZFVEhJeHViTmpmUTJ1?=
 =?utf-8?B?aU1KWGFkTlBBcWJjc1FnZUdxNUo3ZFYxSkVoV0c0ME5MV0VLVWlsS3pXNmhr?=
 =?utf-8?B?YjVPRlpGb0Rhbk1tTEtJS3BLNzJEdS8ybGZRV1lKeU5uTS95eXV5T3E3ekJR?=
 =?utf-8?B?eFdNeVVwN0NzSFB0TDBWdlZtZmE2YVN1aVErTzhWTGpRWGE5eURiaUtNVkNU?=
 =?utf-8?B?ai9UQlhKTVcwcjVkKzRkQmZFSE5yK0RsUENvVTlNSXI5bmhwcVNyVG0zcGZh?=
 =?utf-8?B?STBYUyt3QjB1NnNmY0NnK3RpRTErZGkvbFpHZU5xMWhQd0pKTFBRTEFqK1BG?=
 =?utf-8?B?SVpwUEhjY2d2d0wreW9pRXdLOXJwczQ1VStMamNlYkt3WC9PSzZ2MHlMRmxr?=
 =?utf-8?B?VlY1ZGNVeGptV0FOdXoyaEhTN0R4cERHOUJkS2w2Q3pobFFhanRVazNwMjlG?=
 =?utf-8?B?c1pGMmNiSGF0MlBNem1NWHFyTjdJdzJFT0orNE9OazFLSk93cW5IeHF5Nm1m?=
 =?utf-8?B?RkFCZ1lGRmU4NW5lVEZVYXBsN0VHdTJUQkFIYTR6STFCU3g4enVWa2lKUGN4?=
 =?utf-8?B?UjJoYTRiMEtkVm55MGlXRVZqS0FCU1FSZ0cvOU9rN0FBVTcxZWJObnFSV0U5?=
 =?utf-8?B?RUJTSTRPTDJ0S09OTHFoeFBZdWNZWWwyUEtZUTNpN2R0cWFZOG9pZVc5RElK?=
 =?utf-8?B?bEN4WUh5ZEUzSTVVZFBEMkUzR2NOK2c0c29xRUJKYWNzU3hxR0RJRFJOMlF1?=
 =?utf-8?B?N1ZFZnpSRUtTMzlMZG5YNlV1azVTMnhmaEVlanFjZXNlNTNpN2s5cG9ubHRH?=
 =?utf-8?B?M3RtV2c3MVJ2U0o3LzVCajJHcXI3RjlMNCswRXdmZVcwdzg2NUsxeXhCYm0v?=
 =?utf-8?B?SXVKVVJ2aUZPalpkNjYrM3dBOTA3bzM1V0ZxMVEwWGs4QXdYVmwwRzFxRTVp?=
 =?utf-8?B?SnVINDF3ZnYyNWo3TTZmdVhuN1c2MzExWkFXbUY3NEg2ZE5xZVYrVkhzcWhp?=
 =?utf-8?B?Qjl2YWVlU2hDQ3lCeHVMcGFxb2gvU1ZrazdEZDhuMlczd1VTQlZFb3Y3d0Mv?=
 =?utf-8?B?aWZxbUszQXUwVEZ0d1pYTkZXbk5CUHliMkZoVUlUb0dRK0JaczZFMXl6L3ZC?=
 =?utf-8?B?ODhoSU1DWkxLUm1rMWRlbGJ1VUVpcy9XQXFudGdrbEREVzdQUWlmU2xIMm9h?=
 =?utf-8?B?L28vZ213dTFPZEpOUldvZCtuZUZIV3ZPRHlQYTJpMkFNNENxaTZqMGNqZ0Zt?=
 =?utf-8?B?QUVnT2M2a2dQeWx2Zm9NdWI1WjJxWEU0TzFsVnUxTmU3R0Urbk9kY3N2S3VI?=
 =?utf-8?B?N2hibEU2bDlvZDF3UkR1bXpvODNNelFxZ2Rja05VYUZOSHJ3YTZTd01LL201?=
 =?utf-8?B?a0Nkb09EbjAxZmZIRHU4bVdsOVlNcU1aWVZvMmNYMlJsaDNxUElLalcwWk1Q?=
 =?utf-8?B?cUxUR2YxK3J5TlRiN2d5OEh2VzlFU24rcktYcVRBSkhZeittVjN2aHd5ZGVL?=
 =?utf-8?B?SGZjdnkzSHlZNUNiMVQ1blJSMzV1UlhHSEpOeXNrRlFzOTkzd2FVR1RjU0lw?=
 =?utf-8?B?MUdRQVBrUGZHNWs1MjFyOXFUc2xtVmVRR25zSnNqejFjVkk0Szcvam5hcmhI?=
 =?utf-8?B?R0RvaWpPb25XaVZnRG80aUpFWHkrMEtCa0RwcHd1SkpMY1FCUllxd1pBRW9V?=
 =?utf-8?B?S014VVVjZlJaT2xrYXZ5dWl4Mkp6RlFua3dubnY5ekdCSGZLb1ZNZUR3dFh3?=
 =?utf-8?B?U0lib2xvR2VGdXRoMmkrbFFIWk14SVBXVU1VTGowK3Y0cm80Q2hqY1NBMWp4?=
 =?utf-8?B?SkpKQ2dpU3pqdE1ScDBBSC93bXkweGk0TUVCNi83eFVNQmUzM2NHaHFXL0o5?=
 =?utf-8?B?K1Bqcm5yejVIOHBFWVloa2RYT1JiN0hwWG5Rc1RJY0c2SlAyZnpFR25EZ0Zu?=
 =?utf-8?B?aXJxSjZUNVpYZ3hRenNWcVkyWC9FZlN2bTNjTnFQYkRmcUEwMkZvYlc3dlJG?=
 =?utf-8?B?LzRZL0lZZFhpMk9USk1zZE5TaGV5dmdBMkRKaDJDSmd4cXd4aDQ2RDZRV0Nt?=
 =?utf-8?B?VFI1TG5xaXdoampHam1meHlXdXcyVUFZYU1oS2xxa1VrZng0ZzZ3OXQyalVQ?=
 =?utf-8?Q?3txw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:25:40.3268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4904142e-2082-42be-7f3d-08de1176e086
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
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

The function svm_range_validate_and_map() was freeing `range` when
amdgpu_hmm_range_get_pages() failed. But later, the code still used the
same `range` pointer and freed it again. This could cause a
use-after-free and double-free issue.

The fix sets `range = NULL` right after it is freed and checks for
`range` before using or freeing it again.

v2: Removed duplicate !r check in the condition for clarity.

Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f041643308ca..c057d892dea6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1744,13 +1744,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
 				amdgpu_hmm_range_free(range);
+				range = NULL;
 				pr_debug("failed %d to get svm range pages\n", r);
 			}
 		} else {
 			r = -EFAULT;
 		}
 
-		if (!r) {
+		if (!r && range) {
 			offset = (addr >> PAGE_SHIFT) - prange->start;
 			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
 					      range->hmm_range.hmm_pfns);
@@ -1764,12 +1765,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Overrride return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (!r && range && !amdgpu_hmm_range_valid(range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
 		/* Free the hmm range */
-		amdgpu_hmm_range_free(range);
+		if (range)
+			amdgpu_hmm_range_free(range);
 
 
 		if (!r && !list_empty(&prange->child_list)) {
-- 
2.34.1

