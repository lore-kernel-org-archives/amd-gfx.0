Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA97C282DE
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Mar 2025 15:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804D810E18E;
	Sun, 16 Mar 2025 15:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvogPIyV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C2810E18E
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 15:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/JoyAKWKlj4zdL+qjgDBk23q1YfVc74GDoWs/p84lcbaeqLQ8mIapFtqzTXJq2o7dYefDe2qi/jGWkIolkCv1KnXDoGWJTdS33ux7YtGN1EAeitLZhcAMQ6vjxdW+DnLTIavKrPSfyGykMHvNlWiuqNwneYXNqgxfSjpLBLFzDBuDcNBGC9ls2SbkZwstq/OVQWjPVkhey9XyvhwmxK7oSQ8d4oHRRQlggGjXxPxvuxDdj9dvJ/Nh4KDJzpxL1I/i3zvHqOHqC/fwgneBjZj05NVMmoRNjlONQMz7EjfrHHA7e4URuWzlmT0e9H+1ynXFXhioqexmbq4PRvOTdsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDA2H0bIMCV8MWsVTOTZdN95/JXkxlmqL6nUHGkKEeg=;
 b=MOpa6E4ubQWVncUNoehLlzlkl9IUx7fl3LtWRNXzT6nmY7qzOa1kbnuW6nUv3ycQXnxMlu4V3ye5HfZjS32Zc72BfQ+mBtW2E59rlP90iptpp0LnFM8HQLqaKp0YujYN5p5SP0LWzKYJgVs5/EW9QYUCwUDodHnAFFu6P05t9/B56vtI74VSQX224tQ7zoMqIzXv4U327b1GbykK+7Xxr4gD+9Y5i9tmp0fE5n7S4tMfRdJLFPN/2YJg2x407jLJPVJ/7Sw8i8IGWPZguw6M8Fp/uj/+FvH2om3fBgGCz5M2j1WwUFeP4dW8/6cE66WJrLcapHvDUl3FCNrN62lFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDA2H0bIMCV8MWsVTOTZdN95/JXkxlmqL6nUHGkKEeg=;
 b=IvogPIyVdzDALEuROR1tgE12ToFUPr+7ZrTs/zov/+ganMJV4vEfwIn7NlSbLrqZ5bkyHQCdAqY/MImcKyk9oRlCltY2Cy2ElpWcV9tacrV8KhL8nxZVS+op+sF6jWbA7I3MhUAd0oTUCVOzouPPLp9h2o1JkxIuuCbQE30Im+0=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 15:37:13 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::9c) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 15:37:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:37:12 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Mar 2025 10:37:10 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
Date: Sun, 16 Mar 2025 21:06:35 +0530
Message-ID: <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: b21e6462-f415-4875-cb85-08dd64a06bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXB4QkkzNHNMSzZKZytNQzRubzBsMHJFOUk0eEN4Tk85dnZ5VUdIYWt3ZDRk?=
 =?utf-8?B?SEhrbjlCMk1qY1JWbElXUXN2K1NTTysxN0xiZ0VJa0FJUzFXMTRQS2cydTBs?=
 =?utf-8?B?ekZ0YTNPcjFxdk5rcnN3TzFmVlA0NmtGRnNoTFk4UFBzVDhid0lDMGdXbTRU?=
 =?utf-8?B?aS9tbXNTanRZejIyNFpQcTY3Mm5tQlBPdTNUbTZDVHk5NWdjQ2lLS0lxcE9z?=
 =?utf-8?B?emljSzJIenVzQ0d4TUkzSm1KUEFReVNZKytDWmhwRm1HN2RsYm9MNG9jTC9R?=
 =?utf-8?B?V3k0ZEk5NXFzNlVPeU1wc2x1dDQrOVhQNm1DamU3NFNMS245T2d4emFNZXNL?=
 =?utf-8?B?NWdMOWZlV1JuaitBWWdZNTZESHVTWkJ5VnM1NUd6SEF3eW5hUFltN2pzV2xn?=
 =?utf-8?B?WnFVVmlneDh1QlBuUE9ZM2ZaT2lvUEdTMmhzNjJDMjRuOEdFVFhzUmtzMjg3?=
 =?utf-8?B?U1h3L3NrbzZObCtKSHhwQnovVXBjNWw5UzZSMjJnSXFDZnY2T1J3QVlsQVZD?=
 =?utf-8?B?QUNva3ZKSFZjd0hHcVJVYXkvMVdYaldUUFF4b3pzRjB2WTJvUTV5cXlmQ0hK?=
 =?utf-8?B?aFBlYnNEdGhSdENVUUI0eWpva0w0V3NuOTBINHVKRFJ4ZmwrUDBWenZFcjNt?=
 =?utf-8?B?NU5ic0VDak16RWpDTFZaMklUOTVHSnJkZkJxZC9Jc3dMR3F6RElNdWN4YnlH?=
 =?utf-8?B?NlVjV1FtcS9yUkNHWmF6eForYndvM3AyREVxOWpMSHBkUzdpYXhrZWYyZ1Fq?=
 =?utf-8?B?dnFKTHJ5VGdQZjlTZFF3K2FvVXJCNnlXUitjb1ljWFF2aitjdWpTRjQra2NU?=
 =?utf-8?B?S3ZvUk5IUDNaaWFlQnlTTFdOeUFCZUZuNk4wWU42ZzRERHFNcGlNZXppMUps?=
 =?utf-8?B?UXBxN1ROOE5YWTdRSmd6ZnVHampzNU4yWHN0NEx0R0dzNTRzTFNPNDF6NE1I?=
 =?utf-8?B?MlFrRUl1Um5wV2tXUnhqVW1lVzFodU9WL1BPdU14TXR3alJDYlozb1BNemcz?=
 =?utf-8?B?OGFlbzJLeWE2N3RFSm1tN2E4RmswZWkzc1l5RFJDWVlpZzJZNExjS3RKdjBj?=
 =?utf-8?B?dGk4VzlHRG1jQkpLQzdYTENUZHlmeDNaTmhCUjNpMGpJV09LN1Fra2VwY2NS?=
 =?utf-8?B?SnA1bndjcGFvZGszcE5pV1ZnQmxrelBlUXJkVmYwajY3bXFvUzNUdEhnU3Rv?=
 =?utf-8?B?YkVtYWdxWlllSSt3Uis3ekdJWVBLU2VoNGdVZ2VHRDJBWDlXTEVuQUFENDgr?=
 =?utf-8?B?RnJNTnA5SFhiQmxURkZvajUxNThWVlF2cFVRT21xSXlhZnVkdzU0NFNlY3FU?=
 =?utf-8?B?SWlaVHd3OGFGbGNoWEVpZmRCVGxwaXErQzB2OVRqdWR5b3ZJNWpYQ1BiUHdV?=
 =?utf-8?B?MGVaTFRQUjRmYkxlMmpPNTRINElpOHdKdkdNQzJuNldFVWNFMW0weUU2eGVk?=
 =?utf-8?B?a1BRaEY5ZUdmR3BoV3VEOXBoRk9kOXpLTEhCZWJRa0lyZitZSXg4bkpnWVNB?=
 =?utf-8?B?anJBRzVjN1RxWkx1QUxiSnA3MmZaWkRIN1ovQnV1OWIvbmxXOTY3dXVhaHJ3?=
 =?utf-8?B?WC9lQkNoMTB4cjRwdVR0bSt1OS9PeG1lenNvN3hoQng5dml3UnJNQWZpeEw4?=
 =?utf-8?B?Rmk5dlBWSnUwSXAvcndqVm5hWmZYYlVmcXEzR2JmK2ltMWpPcG5GWUtTRTM1?=
 =?utf-8?B?QWl4L2lNYzBwZEpQcHpFTzFUeGlGUFM2cnFldVZUNlJxZWd2bjM5UjJpeTVM?=
 =?utf-8?B?ZENUbXJNMVhHQ016aENsb2MwZjV1ay9CNlcyN3pRWEIxb2U5cFUyb1dGRzhW?=
 =?utf-8?B?d1A2QTgzZ2NhT21DNmFVZzhodTVwSnVJaVFWTkZWYmcxR1FKc3BmSFdVYUpS?=
 =?utf-8?B?WCt0U25CYWRLMU94bmZCWDJRdnZ5cVBOZGZQM2FiUkc2ZkxMYnJPMUR3RDZz?=
 =?utf-8?B?MUFZbCs4TElLVWJFTFl2ODMvNklzeVR3RGl5bTRuSzJBQ2Q5bmhBZ1JiTkU5?=
 =?utf-8?Q?6Tv/3iIW2jDRlXBnrgjPTChaVpNsCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:37:12.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21e6462-f415-4875-cb85-08dd64a06bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

Wait for vm page table updates to finish before resuming user queues.
Resume must follow after completion of pte updates to avoid page faults.

amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
amdgpu:  in process  pid 0 thread  pid 0)
amdgpu:   in page starting at address 0x0000800105405000 from client 10
amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
amdgpu:      MORE_FAULTS: 0x1
amdgpu:      WALKER_ERROR: 0x0
amdgpu:      PERMISSION_FAULTS: 0x5
amdgpu:      MAPPING_ERROR: 0x0
amdgpu:      RW: 0x1
amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
amdgpu:  in process  pid 0 thread  pid 0)
amdgpu:   in page starting at address 0x0000800105404000 from client 10

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index f1d4e29772a5..4c3edd988a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
 static void amdgpu_userqueue_resume_worker(struct work_struct *work)
 {
 	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_eviction_fence *ev_fence;
 	int ret;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
+	spin_lock(&evf_mgr->ev_fence_lock);
+	ev_fence = evf_mgr->ev_fence;
+	spin_unlock(&evf_mgr->ev_fence_lock);
+	if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
+	/* Wait for the prior vm updates to complete before proceeding with resume */
+		dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
+				      DMA_RESV_USAGE_BOOKKEEP,
+				      true,
+				      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
+	}
 	ret = amdgpu_userqueue_validate_bos(uq_mgr);
 	if (ret) {
 		DRM_ERROR("Failed to validate BOs to restore\n");
-- 
2.48.1

