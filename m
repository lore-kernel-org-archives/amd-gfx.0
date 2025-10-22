Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD20CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 14:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639EF10E7A9;
	Wed, 22 Oct 2025 14:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qdTIJtMz";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2397610E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ww5ZTGbx5fzzCqPm0X//ZJMte6po9ZfUYrP81WMlItlk0eCdxfzJQYuiiixyYUHeWhf4mVfm+/RCk/CnDXKAYj3xM7nAL70RpXOb/Z2dQWCzndWto14hMth4GWBBHQ9WFKiugA8EPDqY3he5/nIKqaFRizqHtHEKy4aXTsjVaQO3FIq+gNNhm/JpAEQW3X46yzraVOhHFi8GCzdXDj94jvG1xVZKobNt7zQ4Jnx2CJ1LMiBsgJhPLgJkeBRMbgADJS3I00iwefA+RUMa6hp2p+GE7XytkoVE3H3F3IrrnsBFO0gAPGhquIrLPliTdZZ1Je1LTb0jW+tfQsVhf3q1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESLJ+8YKJdHPx04BmXjC+/oZQ9CnC5eiK0ZeTp62eE0=;
 b=PfyMgcdn6ZoyAq3dxBx0bjPPUnMjWdaYaZDE5OvwwAoOwkmG3rDLpFeRxEDSc5zb5hCaU8m3AyaMVrTpVprX5u0PicfKTWvLNzB69rJsrPUxwPyhpbSc3QmhaL0/5tOGxJWm+kGEnz24LDmsfyrKWteSf2hzP5b9fuARh+RLHsYievm7njxgGfhajtRX2SlMN31xoDLdzkB+ggTn4KiuTRlcTkMQCN15kQ5H1Uzm3KOtVThnP7XyIVlITCgwvkvlQwzP2h+ziW9a1W0DOdTJLjTw6iQMO+AjRqEIsOQ4bMq6fqdV6gdPQRDw/MXseL6b4dk0+CP6wpvQasWa/GhNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESLJ+8YKJdHPx04BmXjC+/oZQ9CnC5eiK0ZeTp62eE0=;
 b=qdTIJtMzwPCeIJdNnDaOnu1bjpcRjX699AztvDiz5EJua7R5EoyEvSBEPK42SgHWsNk7mRR9Vkz1ZprA5AQA0C8tAweWb+/G6a8UwRdF7A2C/hPQmqnLVN+fpJiF7j6+2KNxDpehsw2jE9MHZzq8wd2/LomyBOdh0xPjQ170T0U=
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 22 Oct
 2025 14:13:48 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::e5) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 14:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 14:13:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 07:13:44 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Date: Wed, 22 Oct 2025 19:43:21 +0530
Message-ID: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: c25e764d-df4f-4830-68fe-08de11753795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3dHRXFHM1ozMm5OQzZQTWRieWQxYjFyeVZDajM0MFh5djJJME1nUW9SNUdq?=
 =?utf-8?B?N05QRTlHZk84WjgvbmF5N0NDUUFBY2Nnd3VFTDRUdCtTWFNmdXY3QWtJb2R0?=
 =?utf-8?B?UkZ1d1l6RSt4UjcrL0hjUU1SSWlqd3dxYmNacm5HZEd6akVNWWlzZ3NxbWtE?=
 =?utf-8?B?NDRqb0krZzRabzhnU3dNU2xORVZlK3hTc0VpRFlWNm5ScUgyeWlCNVlZOFVQ?=
 =?utf-8?B?U0lmaW5hd0JOMDUxQWM3Q0tuMCtuNFFyOThVZ09DUXdsekxaMFdoaTVHaFND?=
 =?utf-8?B?VGY3c2R2cHcxL21rbXBjNUhuMlRtSGVYU0FRYkc0TEdvYXpXMFhpbllEMVlN?=
 =?utf-8?B?RHRSR1J2OURNUmRZRHc5MGFHNmVxczJXeWpuZXRQYllFamxHcVZCak04My9m?=
 =?utf-8?B?S3NMMnFsZlMxOFNiNVQ2RGJ4c0EydXNzUzdpSEhiNzNub0FQdmZkcERzQmZr?=
 =?utf-8?B?SUpQSFAvbllEbGtSa2lKQ2E3ZDduNTUwQnNQNXFma0E0akR2a3o0dkVQZ0xn?=
 =?utf-8?B?cDE5Rk11anFrVmUrYU1NOGJMMkFTWlNCTW1xQkRNRWNxUTdsdnJQa1kxS1RM?=
 =?utf-8?B?aHc4bHp0WHFmdHJMOWtqaURXbWFYeFVKaisvU2xCSnZjOTZXTlh4RExQdDhh?=
 =?utf-8?B?dFpyUC8vZ3ppcThkT3Z2WXhOWSt4UWgyVVFuY0Jid2RuQy91RHRGZTlwV2ph?=
 =?utf-8?B?aUR1VW9UQVdmeFN0VFFUQUFKNVNXU0dsbjg3QUxLN1llMU1DQlB2ME9Jamsr?=
 =?utf-8?B?Q2FybDV5NmFIZlhBQ04wUlZLRVgvc3JYdklBOHhRM0pwSlRSSXV1VkRKWTVH?=
 =?utf-8?B?SExzUzk4SWJjeTdBWWMrZDBURlQxL2tzeGZyY1l6UFVsRkJ2Ty81QVI5bnJq?=
 =?utf-8?B?NW5qVHFsRXhuU0VVRUQ3VGo0NURVSmtORE41anY2S3BBa0wrYVgrMW5xbG9y?=
 =?utf-8?B?ZDlLN1AraXhJMUdqOEJ6b1dWZFdtUlpKN3pVdjZIYWFFa20rVHpZYUVvakNi?=
 =?utf-8?B?NzBrUUd0NEJibjRobEtVMkdyTnBrWmI1Z2ZyVEtUaDM4c3BLTHRyNFdKWUVS?=
 =?utf-8?B?RVkzdThtRVRCWGNhcmJiSHBwMUxlYU1QdmE2SGNwcE5qbXNqZm5KYUx0bVZw?=
 =?utf-8?B?SzJQL25pSzlsL0s0TWg0elIxL3NUSzhBbklpOW0raGJ0RmNucUQ2K2MwRTRQ?=
 =?utf-8?B?VWpoNHQvbTlXTkl4SVJrekRPZGJuNWN1Skd6aytQbmN4enMyMDBqaFA5eVNs?=
 =?utf-8?B?b1hVRFBjKy9iNngvd0tVdUJzNDh6aHgrcnd1L1lvLytUeHBiYlF0MXgxNlpI?=
 =?utf-8?B?cW9HQ1Ztd0x2STFZMTA1YUx6VStoTnBDK2xKQjZIQ0k3Y0RuNE9sd1FyazJI?=
 =?utf-8?B?cm4vR2NKcko3V2hXOFpTTm42NDRYUVVFSFFYMjRMejFrU1NLYmJlZ2NKVjJp?=
 =?utf-8?B?RTFXbWlScitUZjhQQVpuU2dhV2hHWW5XamxCQTYxbzlvb0lxWDN2ajB0SzE1?=
 =?utf-8?B?VjFqZjlHWVU5SkFqeUljbE93U1JxUlVkc21CRmEweGNQUGI5dEZLcTI1OExk?=
 =?utf-8?B?d0hsM1FaWkcxSzBQSDBnTExZQ1NCRFU4TUpwbWtrcTZPS1NRK1FydWJVaXhS?=
 =?utf-8?B?elVnTG1YMTBKZUdaU3l1OG1XMnNRcVkycjVWQ1VZeS9ZdmR0Y1doaFdMZ2tR?=
 =?utf-8?B?MXh1ZDQycmtyaDdqejFxbmJ6S0NHNWcxNkJYTXNTNjh5RjhyWW0rNWloYUdQ?=
 =?utf-8?B?TUpKT1ZRb29GZndqdlppMmpSQ1VGNkZyR2x0aFEzODM3M0s3SjFncDQvSkN6?=
 =?utf-8?B?b3dzWHBhejl5N3ZZQ0xFSEtjWnpsYWxsd2dlN0F5b25JdG82SUptempUeW5Y?=
 =?utf-8?B?Vy9ldjFEYVk2cG1zNk9UWnBkb1Ira0pZL3F6eVBEZkNZTlQyZmRIQU56TG9o?=
 =?utf-8?B?ekZIWld4SXpYRm41S1JnK1hQSXNyK0lJcjRJNlFaUjJvdzRVd0JMOHg0TXFl?=
 =?utf-8?B?dzAxeEpMNmUrc0tvZzRQRURhZHFOREtTVTFoa2FicmFYVUUwajZIN3NSQmVX?=
 =?utf-8?B?WWNkemZZZ09kelFtVjBsYkdSVmNERXk1aXB0RDFpZ29uVCtudjJjOHMvQ2tE?=
 =?utf-8?Q?4r3I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:13:47.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c25e764d-df4f-4830-68fe-08de11753795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B
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
index f041643308ca..a82915fe9807 100644
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
+		if (!r && range && !amdgpu_hmm_range_valid(range) && !r) {
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

