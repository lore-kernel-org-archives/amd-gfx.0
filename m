Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4DACCD1BE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 14:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BE1410E90D;
	Thu, 23 Oct 2025 14:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZYIxcHg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B82D10E90B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 14:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw6FmP7SKevWlyLpaZZNTAsJomq5pCejkDTkay0me4zEaOG3yZ0hc8CXywfWlHTlX+OWZU9qFShxtUlAhhGGipxOuWWa2LGv7fG57OQO55cyxPaPLJTD4ZJHQ5WhuHpVbmcd9wiXndP+TtvwXbWMFXQZOMpj9OJKDkurkGoRUzTJuuCJ+7thKcvAMGq2kaMv4vP1vAsaDb+rGMckOqHnSCNBrEWuYM2rO0K2djaJIjT9bMvcLDXYubwZSVfrsxi05+EciSGfFhJLSCvt6YuZ4gKQstfcnMhWP4lNRhG2co+Rr+IPGpsmhROsydhfHZbpl6MUv02r9p7n4xi8xrsEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSYJm9/fKuZypr3yrRiwB9FzC65ne9qh0af7RI+2yes=;
 b=nh3Q0b/mdkL2QWetNNmhkQYc4wP7Bl1nDIjDiVzSw+mer8DpRZf1xKRUxDYqx33hQyRfyWQNirwuai36baQYzLGzcc7+AspVRxWG4gaEqb+SLuuOCTLm22e0GL/Wa0kgQMJiuHA+YukEfcRO3+10iJG2DdOoilYFV17QBTg66SC5ZwJcoL6ctslyN0Q2u4rsnWOSoAfnrwOvYZ9ZwMmDQhr4EfBBeNuEiWF3ily9hCa70Cm5MEIG4JTg7H1FwKUX9hwy7w0qR6Mi/EsKd53bdb5yz9RSFG51rAcOawuOd0snR3u/KLkd5DdNl1RxQ5FYHt1/4Co7VdirdjNpPsF/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSYJm9/fKuZypr3yrRiwB9FzC65ne9qh0af7RI+2yes=;
 b=4ZYIxcHgSZdTPWC51PG1BCUJ34m4hEEShFvtkHgFXvcLiuQnWANfb06R2RaeQAcimca4R+UQvwMgb1A6F+Bvryf5v69SOWJVa8YRv8NGTVuKIGIpQ1PWeMunoP2361q/H+hQEJD4z4F7Hy2ajywS2YdRBeZtibqBAz4c36LeJfY=
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:35:00 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ba) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 14:35:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 07:34:58 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Philip Yang <Philip.Yang@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Date: Thu, 23 Oct 2025 20:04:43 +0530
Message-ID: <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 299ce182-9e8c-4421-f776-08de124158ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGxDU0NmMS9FajA4UllyRnVzTktSUmVLV3JFY1l1MW54Q25UdFJnU3A1UWtX?=
 =?utf-8?B?Y1Y2WGpTNUxFY3FoSTVmUGlLVmtGS3U2Vm9CODhrdGN5TFdWWWdzTEVBbmpw?=
 =?utf-8?B?eDFJRnEvOGN0cmd5cE1RNS9Ic0w0NTdxWHZzRXNXU1lVTjRzazZFTm5xVkQ4?=
 =?utf-8?B?djNheGZKK3A5UDlVcXhjQjlPQVZPZlE2aDQ0TVo2MDEyNlpmV1NlWmI2SjVh?=
 =?utf-8?B?MDhxYUtLYVdvSUFCYUxpcXZ0U1E1S2V0MzBhRGZuWW5KOWpmU3NlRUJSc21V?=
 =?utf-8?B?SXo3UUp5bUI2OGtEL2ZTTVpTQW9LNGdQeEYyR3ZvWUkzQUo1aHBKTGwwaWt3?=
 =?utf-8?B?U2poT1c0eDNhb1M2YVpHMkp0VkpaYXBuYVhhd09jUTRpRU5OTTBMNndHTm1I?=
 =?utf-8?B?dUE2V1ZGVENFaTl4VmhuNHdBdmt5elhsSGZvYUpxZUVxdXNkU1A4b1lSdHhO?=
 =?utf-8?B?aVFGbGFlQUlQczJPL3U1TU1hTVYvcUFsS3VrTk1mMERCSVR2bkxEWVg3NmhI?=
 =?utf-8?B?UHBETHlKc1JQa1pKZUJoZlZiWVY0c3Zob2MxNVp5L205ZllXVHh4WjgrTzlC?=
 =?utf-8?B?RTJ2V1d0Y0J1cXh0VXpadG53eDhDcSsvV0s1RVFLcHNQSU5FbnAzLzJOcmFX?=
 =?utf-8?B?YUwzNWE0Q1lkb3owTTljcURkSGFJSGRDR0pKWXdBNUo1S0hNYndKb0I5dHRI?=
 =?utf-8?B?bkluOXl3b0tYUWdGRHhZZVBVVFhtN2dacEtDKzl6RWpFY0xBdkxEVzRlRGMw?=
 =?utf-8?B?MDRIWHQyTUhWa1JsQjhYYXh2VVdsREpPa0J0cTFhazhEd2N5Y08rL0ZKdHRq?=
 =?utf-8?B?YXZkeVcvWGRLNlRWT0NWYjE5WEx1TUIwOFlHSTJCUmhJbDNkLzRJMnNMTlJC?=
 =?utf-8?B?SHNtaUhNZENSUmtwTGxWUDN4cGxZWWViYVRMdVdzOHM4U0RIQldPRkNJOXZP?=
 =?utf-8?B?MEF5d2M2MHc1UFRReFVvcHlXOWFZMm14aHJoci9HbEFGYWhUMVRsSG91UG9p?=
 =?utf-8?B?UjJOWnZaRGt2VWZBK1VXV1VHcHNlT3VzR3k3YlVHRTZ6OFdHWU82RExCeVlN?=
 =?utf-8?B?Tlc4bEZNNDkwTUlDaTJaNW1pUzRqNWVCTmhLMlY5Q3NrZHFVNHI0dTUwUU5G?=
 =?utf-8?B?bFJXTWtMdU0xNXN6SWx2OXJKTmtDaWJFbWVUb3BNaWgvZkZRQ3pORTVQUEow?=
 =?utf-8?B?ZzRWVG1RRmwrM1E1bVlXdXpUUnJyOHk5aVVtMkdpOStTSzJzYkJpM1VoSTlF?=
 =?utf-8?B?dHk1bVZVZDUrcjVMdUFmQVpEYkdlaWI3RjZIVloreGNTd05vSzUvTytpaHlj?=
 =?utf-8?B?bjcwdGxHV3VOMGttdHRWOVFqZmtZdWF2UjVjZTR6dzR5Sy94emVsNWxncm0v?=
 =?utf-8?B?a3h0WGlXcURFODRiMC9KNVZ3bTJqZzNQZlM5WDNUekpDd1RIK0o5WENYeito?=
 =?utf-8?B?VnR0STRQWUdNN21vdllsU2lGOElvV2FsM0ZvR0YzSDlqTVI1NmtkRld6NXRi?=
 =?utf-8?B?VkllMkx6blhjZVd6b3VpNVRFRFQzbFFvUUxacUhWdnU0aFJCc3RUSEpFL2Zu?=
 =?utf-8?B?OUlCUS9LT2llcnFmc1ZiUC9PNGtHUTNrZnYyZGFqeUwyMCsyeXNCZU1jdzc4?=
 =?utf-8?B?SkFHTHZKMmZPcVQ3czdVUWcyakhqRGcrYmR4dmQ5YkpXTmhiZ1NCaW11TzAz?=
 =?utf-8?B?Zm9IdklXeGlob1dLT0g0M0dYRVNPQ3cxTEpRVDZpNmIzdkZEU2k0UTQ3ZTg0?=
 =?utf-8?B?RnFudUxFcVRFdmhXZG9jRUl1RnV6bkR4dkNNTGFKZjZWSFZiT0Z0QnJMZTEr?=
 =?utf-8?B?Tlg1dVpZeFg1WjRVNzE0UFNYQ2FNNnRoM0pGR05CdUN5NXlVZFAwbkdLby9Y?=
 =?utf-8?B?UmhjTi94UHBaMXlBZHZoSUNLRXRrTEYydHJZMnZVYXhBZVFXY2FyVW1pVmZR?=
 =?utf-8?B?cjExK3I3am5oejZ2UVlXaFUyaEIzbVUwOGJJZGZBcjJXd1NzN2ZCLzZyZXpC?=
 =?utf-8?B?b1gybXhuK3gzdXlDejd3Tm50Tlh2OFdwcTNoY1BxNHdTWnJieDI1VEc5K3Fu?=
 =?utf-8?B?azBsY1dyMFpyMHBLT2ZHZDBlNEtTdlU1LzR5RXQ0N2VxMHRidVZUK0VxNGo4?=
 =?utf-8?Q?2fVI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:35:00.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299ce182-9e8c-4421-f776-08de124158ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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

v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails, we
kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still pointing
to freed memory. The caller (or amdgpu_hmm_range_free(range)) may try to
free range->hmm_range.hmm_pfns again, causing a double free, Setting
hmm_range->hmm_pfns = NULL immediately after kvfree(pfns) prevents both
double free. (Philip)

In svm_range_validate_and_map(), When r == 0, it means success → range
is not NULL.  When r != 0, it means failure → already made range = NULL.
So checking both (!r && range) is unnecessary because the moment r == 0,
we automatically know range exists and is safe to use. (Philip)

Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index d6f903a2d573..90d26d820bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 out_free_pfns:
 	kvfree(pfns);
+	hmm_range->hmm_pfns = NULL;
 out_free_range:
 	if (r == -EBUSY)
 		r = -EAGAIN;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f041643308ca..103acb925c2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
 				amdgpu_hmm_range_free(range);
+				range = NULL;
 				pr_debug("failed %d to get svm range pages\n", r);
 			}
 		} else {
@@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		svm_range_lock(prange);
 
 		/* Free backing memory of hmm_range if it was initialized
-		 * Overrride return value to TRY AGAIN only if prior returns
+		 * Override return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
 		if (range && !amdgpu_hmm_range_valid(range) && !r) {
@@ -1769,7 +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			r = -EAGAIN;
 		}
 		/* Free the hmm range */
-		amdgpu_hmm_range_free(range);
+		if (range)
+			amdgpu_hmm_range_free(range);
 
 
 		if (!r && !list_empty(&prange->child_list)) {
-- 
2.34.1

