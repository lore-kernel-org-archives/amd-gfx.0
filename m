Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9171C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F9A11A9D4;
	Fri, 26 Apr 2024 03:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qQAmvg8p";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E1611A9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYcVOqLlZ9hxLjqFL7twXMISWDQqy1AgNas+8gYFlNR+NeeIamDdO3P7jD8bBXD5Ypz82P+KCX9V3UtXmRUfRhd1hj84d/N5gTZHdtfTSeGof/9Nsp4Pw0cLkUeJguzpN5i//OXp8EqmmD2aGzB1Meg267OXz2/oqxA3p+bfjLFOtXdQs9JhziP0irHg8S4B8Ay/Vj2X/FkHQxmjvn8MxcWd71HUWyTpyfQ8QOBDtL6jkUUKUcv/4dL3GAgV6zZsP/vS2nhvMcti145vBnUKgLdJFdEV5o3TCuBFxFwy+rcAQEwHgqOGKF8nXAtn8tgZViFzJvcyB07lp9IJzraDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58Je/DHV8WX5wZzooRkovmz1eMRIh3nY5YIs6NtFX1I=;
 b=abd1fuLFckDmuf+skOU5i6rlwm3mKyASK/+dCCFS6hnKg7WnwggAgipEO6Xmc4SkywSOshCGPDQCsIKVRlfL7/zflzwpM0BA4+TdqOGDhqRcwF6CwfRz+eTACugqkDGpCriq10TpSL6LeOIjPwAVLF0RqSuuZ9EGBdzl8FN8hzmlWgdBPSBmCdLrtmbMrRKO44ZISC3svAmyrur9wlXN8OAdWsEd5tMT7xUt9EWGNFmt4pZylD3yjpfKJTofvkzEdiW2VPjqz6XKXNtMP89WwIfWLQp18rd7i5eIJpmuiHjvWbQEvPYxKvYfA3myTZ0bnEWVVX8hC9HzdC2LL9ZC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58Je/DHV8WX5wZzooRkovmz1eMRIh3nY5YIs6NtFX1I=;
 b=qQAmvg8p98twQKMlQ/UrrDgMna0QCTSTJCGLGOvpp5bMim2HFESlMD6JwomrRB2tbkvET6W5/AQtgqDtzp/EB3S35vZmSsKIws2xIcxDbW/IKY91Ikra/gxnjb0nb4Onsedn96ySQ0ZgZMa32uMsIELB17TYg/zV01EuaPdRlm4=
Received: from BN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:408:e4::8)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 03:58:58 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::fd) by BN0PR02CA0003.outlook.office365.com
 (2603:10b6:408:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 03:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 03:58:57 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 22:58:56 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 1/4] drm/amdgpu: Fix two reset triggered in a row
Date: Thu, 25 Apr 2024 23:57:39 -0400
Message-ID: <20240426035742.90560-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b3bac4-a195-4980-9c22-08dc65a532f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?brVTbHGUvA49uDQZYZ+Kk4T4AZiO78W7MTJJp3lSnj6As/IYO4fdzwrOkUlX?=
 =?us-ascii?Q?AitDP2a6DIqgCDjVB93hIYAHTcAQN7QXqnAuEkCBthl/720Esc6ibX8ikyR+?=
 =?us-ascii?Q?YIiCOXE7XXz1sH3A5+29Lv5fIq8Qq2ccHQVlK01P70ioGXiclRiauUPJoGKC?=
 =?us-ascii?Q?Ztn1vE3fLb+kkeMkaUc7IkXaKTxUkdGwCCnNDXTVENkxcAlMDy1zXy/Q0i0y?=
 =?us-ascii?Q?ndfQJV3scNNlDYHbUv7yrdnLgT1TRtw7vruJ6HPkfAB0WZGNjafpU9mMxY0P?=
 =?us-ascii?Q?x/aafmihOeTG/rvsdum9bN3lqV+T3a5wwtwBm/HvTwWWgmhSij9DxuerFbJH?=
 =?us-ascii?Q?PJvWXFGDSKEo98GWk1fSBo+ORxZI6izFfhqIK2fJMLQTA7zPsftQ1t4e4xYt?=
 =?us-ascii?Q?JRGurajrxUVPJ2XGkwbQyER+gFFlU41ztOr35mzXTU18/V2sQ/lMUhiXmmxJ?=
 =?us-ascii?Q?PLR+0mm5xKV5IyE168Bn870fi7NZlMWIQrbIdYD4N7v93tqpStDMIZE6G4bN?=
 =?us-ascii?Q?vJ6g/XPHr1sMmRVodYeZoIAULf7qDH2bFlkAAG7rKG9Qw8e6VhYeOLUonBwT?=
 =?us-ascii?Q?Im/3rxxtA1qkC8wC4CcbgmHAF4KCzJVubceiVlzdVlw6lY1ABu+1wTskE43N?=
 =?us-ascii?Q?dX2I5FqNCo9NRYIL0Y2P/V8kSARK0FmcJVe/mk4qrfuzoybF5RtADeBR5l4C?=
 =?us-ascii?Q?1fAd5CvgvkeMvhCys0Al6UXQyWYu4yJlTXqXFaZuxvUTMAkHC2VoKhhy26uV?=
 =?us-ascii?Q?bWHBqfI5zNctlMBjRAjd5BovLQlqCgOyXskPZDDmSXcP5FUusYNIXvDACIm0?=
 =?us-ascii?Q?pzr6hw7N0+m96ztXfMFQFljxRGaXlN0P32epp1nzLOCk3BAYx+65MiaBwCPn?=
 =?us-ascii?Q?cUULHi/LiBee4cqI4xndDG5YFahxen7Z5i3tPXt5Mra2b+l8h7VBBFokCpy8?=
 =?us-ascii?Q?Acgdy6KNs+q7nB1pIFXSGVaZqQgJoxvWnmk3tIhTt6m2yLA0Gpj902oXYhwI?=
 =?us-ascii?Q?HalbQtKsdaIIoOagDWxRujhCk2Edq4a05oa0/1/LsNvTjHu/loWXnW8twrl3?=
 =?us-ascii?Q?u8t8JSQVTAJwTFr4jqRFG3J42egdPWmf2SR9h2dxghJnyfId4THAA1BVEtJt?=
 =?us-ascii?Q?5UcRAJUIegsxRKTYlkldlkPZO5ZJGVRF4Vk7zakzFBn0DelMKYaKVOoxFZvU?=
 =?us-ascii?Q?km5PUF/ddQvTUkYIoOxb5N+IYcUxSVlxC56DHPq3yh87vtkh8XwFolXMosX7?=
 =?us-ascii?Q?OGdoWpgyzStOJBUH7ZDcoTyTYtOhAGRIJdNGSF07kJjFCe2O/jpN48tJmZSk?=
 =?us-ascii?Q?F5HBFeFs6xd/CuC4reAn+NlGDn3dzvgv9E3laALDmfk4XXGUn6AXElOBH1bX?=
 =?us-ascii?Q?DcBqPOdp/l7PPGefcerxXyMVbaa9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:58:57.8527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b3bac4-a195-4980-9c22-08dc65a532f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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

Some times a hang GPU causes multiple reset sources to schedule resets.
The second source will be able to trigger an unnecessary reset if they
schedule after we call amdgpu_device_stop_pending_resets.

Move amdgpu_device_stop_pending_resets to after the reset is done. Since
at this point the GPU is supposedly in a good state, any reset scheduled
after this point would be a legitimate reset.

Remove unnecessary and incorrect checks for amdgpu_in_reset that was
kinda serving this purpose.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: instead of adding amdgpu_in_reset check, move when we cancel pending
resets
v3: no changes from v2, collect all the patches in one series for easier review

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 861ccff78af9..8befd10bf007 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5070,8 +5070,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
-	amdgpu_device_stop_pending_resets(adev);
-
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -5823,13 +5821,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 				  r, adev_to_drm(tmp_adev)->unique);
 			tmp_adev->asic_reset_res = r;
 		}
-
-		if (!amdgpu_sriov_vf(tmp_adev))
-			/*
-			* Drop all pending non scheduler resets. Scheduler resets
-			* were already dropped during drm_sched_stop
-			*/
-			amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	/* Actual ASIC resets if needed.*/
@@ -5851,6 +5842,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			goto retry;
 	}
 
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
+		/*
+		 * Drop any pending non scheduler resets queued before reset is done.
+		 * Any reset scheduled after this point would be valid. Scheduler resets
+		 * were already dropped during drm_sched_stop and no new ones can come
+		 * in before drm_sched_start.
+		 */
+		amdgpu_device_stop_pending_resets(tmp_adev);
+	}
+
 skip_hw_reset:
 
 	/* Post ASIC reset for all devs .*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada7..c2385178d6b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -597,7 +597,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	if (ret) {
 		adev->virt.vf2pf_update_retry_cnt++;
 		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
-		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
 							  &adev->virt.flr_work))
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 0c7275bca8f7..c5ba9c4757a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -319,7 +319,7 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 
 	switch (event) {
 		case IDH_FLR_NOTIFICATION:
-		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
+		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 								&adev->virt.flr_work),
 				  "Failed to queue work! at %s",
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index aba00d961627..fa9d1b02f391 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -358,7 +358,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 
 	switch (event) {
 	case IDH_FLR_NOTIFICATION:
-		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
+		if (amdgpu_sriov_runtime(adev))
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 				   &adev->virt.flr_work),
 				  "Failed to queue work! at %s",
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 59f53c743362..14a065516ae4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -560,7 +560,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
 		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
 
 		/* only handle FLR_NOTIFY now */
-		if (!r && !amdgpu_in_reset(adev))
+		if (!r)
 			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
 								&adev->virt.flr_work),
 				  "Failed to queue work! at %s",
-- 
2.34.1

