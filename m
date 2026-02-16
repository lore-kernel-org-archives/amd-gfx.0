Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADC4E83837
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 21:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D21510E3E9;
	Mon, 16 Feb 2026 21:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ip1l1VSw";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012019.outbound.protection.outlook.com
 [40.107.200.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C86010E0E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 21:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZckhJMX+LPYDtw1Ch9nb/SnlB6Kz7PDnQnxt5eqwqLO9Bhz16dm80Jfb385FBlseo551aa4vb6gQ/ECfiK/KdOqoWa+HeCDhOoVR2uDHz4m3aXVPRzq334/zG1ac7t+R0SgkZlrCl2otG5LHn5nXzzBIkfp0p0Z7aX+OLZpc4T63hHfyutq3bfXahmw6VNNUm6dUGiQiQ4tPYWYIhu52RENH34QzDP4O2zmDkYkrWCg7CfHFqt1ubjZMRgHJA2nQjP1thCPgHbAl+aZa0S2MWDZ9wP8NpuSDX4D4/Rvydz9gywIxJ6EBettzqYkVaj+9/5z+0edqJWvFN0xgkuoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTQe96ohxtK0tNLQGBUX4h6jd3ETLcF2DE+nwYmHd+E=;
 b=gmkQyWR3pUYjsCXn24trYtKFDovpU/CB4FTXTFj/ypXaW07DcsmIAavBgzSkvnyUVffYrgLhubNmUMpzeAXpas8cyMQO94P10UI/liDln71E4o+wDGgQ6hXdx8DBuIraPL0Y8TXxV/eAvK19mmtoe+3EzKdcX7UTW4Ec8FiJVqVkB5w6Lawb7e+gOF2y3/K1mw+lO2RxrX6XI9Z+TKJMIJtBDrTYkV/la/RKPz76/HyCMZmi2suimaX8ruR5/tRy4SJDzZtHS6+BABlgDEPMocWXWhegw51VlS6RLs3PSsFHfNLjbtiKtEkQ90TC9TTbXiESRWHixREijTjppcCl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTQe96ohxtK0tNLQGBUX4h6jd3ETLcF2DE+nwYmHd+E=;
 b=Ip1l1VSwxfYGC1jLez5OIMAxPVhbnic7FBRoVAMW86wfxJGgd16+n54G8Z4phmLsxJYS8p8J+zdR9MgIoPqQEsNv8URY5ieU0foWDryKmJrsdQNv9TiCjSTdzIYjd2jV2jmuNpzxBgZmv414vcDFfD6C+MxldRRPwSVcRctg700=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by DSWPR12MB999154.namprd12.prod.outlook.com (2603:10b6:8:36e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 21:13:53 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::b7) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 21:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 21:13:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 15:13:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 15:13:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/8] drm/amdgpu: plumb timedout fence through to force
 completion
Date: Mon, 16 Feb 2026 16:13:37 -0500
Message-ID: <20260216211340.16364-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216211340.16364-1-alexander.deucher@amd.com>
References: <20260216211340.16364-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DSWPR12MB999154:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e84027-8244-4dd3-f051-08de6da049ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXlTQXFsQ1JLN083Yzg2bFFZdmdUN3RGaWw4ZkxtbHM4eFAyb0Y2TG16Y0ow?=
 =?utf-8?B?Ui8vTlFYUExSeGorS3diS0VmeDg5Q0djYjFuOXN6UDEwVk1OVFNPOXFIVks3?=
 =?utf-8?B?cWlTajdGayt5UDlPNFdXQXF1RFVDQklsUkZuRTAzS3BOTGd4UkRENWlFQ3c4?=
 =?utf-8?B?NDZxcG9NMjdlZmx0alpTOXh6Tm5OT0NvUlk5azFkOGV4YWpDalppamZZQk9Q?=
 =?utf-8?B?SkM0S1pHZllkTVFsSmNla3R6akVHMzN0dWp0ZVFMcjRFR3R1a3VzR1lhcCtI?=
 =?utf-8?B?eithUll1Mk9TS1pPaWd3Z0pSTXFiWnVOcVgwTnpiK0lnQUw5V2tMUVlsZmor?=
 =?utf-8?B?WTdqZWlmVC81allqamhjZTF3LzVIWmNiai9udjZsNFFFZmtvQVVzNHVZR2FR?=
 =?utf-8?B?YWk4eDVab2ozRTMxWDFrOEtmUGc5V1QrcS9aN0dLNWlrOEJsNElvYlpUZUU5?=
 =?utf-8?B?TU10dlg1YnJqUlkwcmxwNjZWRFEza0pYWDFISHhuN0Izc0Fxa05TZHo1cHM5?=
 =?utf-8?B?aUJ4NmNtcXVBM2V0UklGRUYvSUVmZmE5V0NobGhoUkJwZ3pidzZ0M0VoV3ZF?=
 =?utf-8?B?RW5aeTJjcjdwSUZ6WTQ5b2l1OW5YV1loU0wvZVJLOXNFK3dTZ0x3M2tTdndk?=
 =?utf-8?B?YTRDbUdRVXpwcXcwNFJkc2FpelBZVXNzYkNNRWhRa2Zac1JkYlptZG1Oelc4?=
 =?utf-8?B?SWVlYjd3emdaWXkrR1hZWFBoSllKZ1Jpb0ZJS05iUGxhbWFveFlZN2MrVzdu?=
 =?utf-8?B?cXExcGlYem1nSDNxY0dBQXk4ZW5mT3VJMlJ4MUJFOFcrUGJiUmNJZHVYYzZq?=
 =?utf-8?B?STgwLy9zZnJYaEk2cTdoWmIrTDRtenpDaDdDQ2YzMFJNUjY4cjRrdlFxczRR?=
 =?utf-8?B?ZGlOTEt4eUJmVGt6Qi9jcGI0bnI3OHlUdEp6K0Y5RWx1YWNyeHdnTTc4ci9N?=
 =?utf-8?B?Z2YvWlJEUTIzWDl6QXpDSS9acm5WbE9lK3lrUWlCdFFHNnlSTnU0TjZxU3ds?=
 =?utf-8?B?Zit6TXJObVQ3cjJ6bUlKVjV5ZHhyMUZBK21kbEowK1Q1VTR3eHdYK2pXZCtn?=
 =?utf-8?B?ZTZGbzVwTGMySzg2MlhUTjJEeW1BeHNkeUo5VzMyR0dpSWhaNHVVRXNBbFlp?=
 =?utf-8?B?UXgyRXhrRG1nMUloU0FRNk9wNlB6SVZmdFBKOWVxWXgrVlMxRUo3VnROVVh0?=
 =?utf-8?B?clBVQjNYejJWcHo3ZHE1YWo1eHU1RjIvbEZadXN0cHB1emRaNGtZcmlnOGs3?=
 =?utf-8?B?Z2ZMSlRDUHBKVnlnL1E5U284M2E4Q1dKR2xPdGtmczFCdDdGbStPZi9GQlJx?=
 =?utf-8?B?aGhHVXI3elpIQytTSk4rNHBuNTlTMUlnQTA0NVFuK3hwZWtJSm5FeUlkdkRZ?=
 =?utf-8?B?MENnWW1pa1VGK2c3U05PcUZsTXRONmlETWRLNkZvMlhReXJyb0crcnFrVFEy?=
 =?utf-8?B?aWVOcEdoaG1hTzNzSSt0YTlycEw2eTdSVW5NZUJoTWRMS3BIKzdHc2pWN3lu?=
 =?utf-8?B?ektKZmN2NWhxclRWNEVGTUdnRVZoQW01bUZqL05FZFMxRmIrMk0xRWJxeEhp?=
 =?utf-8?B?cHNIY0h4dWhiYVc5QS9tWllWeXkwSEMyWU92QUo1Kzd3dUc5UlRvNzVyZHVi?=
 =?utf-8?B?RC94QmN6UUkvMUtDczgzU3RrSGxFdzlpbW1iSVhOcTkzOWZINXV1VDZ4eTJy?=
 =?utf-8?B?QllWeWlKWHlDTkttbjdWcW5sYnVEZ1BIK3Jtdkg1cVh3enZ0bHhzVldiSUlE?=
 =?utf-8?B?THBjZG0xMjFjcnFrWlVqdEg4dWdkUnBXZm5EbG5uTjd1S2hJenA0MVpoNEhH?=
 =?utf-8?B?aFZ4TjB3VTBvSkRmeGZRQnNINTFzdnZacHpUc1ozcGtXWmRmTUxJU0FFeWRC?=
 =?utf-8?B?Z25KdlBsS0RMQVJHaWkvMzJVMys1b3FsV2lFR3V0aVM5bGVOMGJDTW1TbCtn?=
 =?utf-8?B?UG9QSzF2QzdpZGloQUFYN1VCK2FLdVcyQ2M2cnpOQXVyQ05SS08wVThyN2xu?=
 =?utf-8?B?SWdBZE1hd1ZCNGpZMGp1ZUlOZEVrTHpVRWpXZ2pidTV2MDB0b2s3c2loRkt1?=
 =?utf-8?B?S2wvb09KSXMwc205c2JYOTZDYkVLbWNvN1YrRmVJQ3MyUVhBTGJvSDZFQkl0?=
 =?utf-8?B?aCtvSHJqNkQxVnZhdkdIekw1OTJnRU9iRWxmRWZhdTd3ajdnbGF0Tk0wYmRa?=
 =?utf-8?B?am9rYXp1RDl4bzZ2VllxMkZPSlU2UVB1VXkrZ0NvREZud2xJamdMR0VtaUJy?=
 =?utf-8?B?Y0NXdlFUc2hUUFl0MDJmVUp0ekZ3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1NUm5VfXR7Ismb/YxFVQJ8gaUyR9wL8AzNbW/j7qnnac5TAIAJyirPKYVjE0TMRKXymfiLpDd2ju2MXy1INojkYwhJLtpC4qFUmlOrfq6jqAeS6hUEHScnkjcHID+UNL5+wM+ReOW8flBiwtdD1PUF+MT9J5L2R0fISJrIdOmFPFfbwM2GEJKvvTN3xekvXMinGsI21oaPm3D0N8mhk6RGWIo6B3owKf0hVMj2rKSvaB8IKAmOfItpWFCaC93QYRBRtxW0yOlPZa+VvhZ3x/RkfqavE1im3dgG69N9bGgxyKsjoFMfG4HB7euEfeqshKEuoiVakueT80CuYttGo/OXAB4Qae3CY1KhCm/+gZ7p9xWOVHNb9qX2k/OhLm7qbUf1pasaHAIEEz2vi3SMmDT6SHLrlXaZmfTbuql9Ims2e39KCYQVrHARBGAl8K12lH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:13:53.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e84027-8244-4dd3-f051-08de6da049ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999154
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

When we do a full adapter reset, if we know the timedout fence
mark the fence with -ETIME rather than -ECANCELED so it
gets properly handled by userspace.

v2: rebase

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 26 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 21 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |  2 +-
 9 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeb90708f2293..663d115ab169c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1936,7 +1936,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		/* swap out the old fences */
 		amdgpu_ib_preempt_fences_swap(ring, fences);
 
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		/* resubmit unfinished jobs */
 		amdgpu_ib_preempt_job_recovery(&ring->sched);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c53954d3a529f..0ea170e7d4f7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5777,6 +5777,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct dma_fence *fence = NULL;
 	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -5789,6 +5790,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	amdgpu_fence_driver_isr_toggle(adev, true);
 
+	if (job)
+		fence = &job->hw_fence->base;
+
 	/* block all schedulers and reset given job's ring */
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
@@ -5797,7 +5801,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			continue;
 
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, fence);
 	}
 
 	amdgpu_fence_driver_isr_toggle(adev, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d209591e3710a..0542d88f7159a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -547,7 +547,7 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 			r = -ENODEV;
 		/* no need to trigger GPU reset as we are unloading */
 		if (r)
-			amdgpu_fence_driver_force_completion(ring);
+			amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
 		    ring->fence_drv.irq_src &&
@@ -662,16 +662,34 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  * amdgpu_fence_driver_force_completion - force signal latest fence of ring
  *
  * @ring: fence of the ring to signal
+ * @timedout_fence: fence of the timedout job
  *
  */
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence)
 {
-	amdgpu_fence_driver_set_error(ring, -ECANCELED);
+	struct amdgpu_fence_driver *drv = &ring->fence_drv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drv->lock, flags);
+	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
+		struct dma_fence *fence;
+
+		fence = rcu_dereference_protected(drv->fences[i],
+						  lockdep_is_held(&drv->lock));
+		if (fence && !dma_fence_is_signaled_locked(fence)) {
+			if (fence == timedout_fence)
+				dma_fence_set_error(fence, -ETIME);
+			else
+				dma_fence_set_error(fence, -ECANCELED);
+		}
+	}
+	spin_unlock_irqrestore(&drv->lock, flags);
+
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
 }
 
-
 /*
  * Kernel queue reset handling
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index fafb876d73da1..6ac66dac524ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -159,7 +159,8 @@ struct amdgpu_fence {
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
-void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
+					  struct dma_fence *timedout_fence);
 void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 					     struct amdgpu_fence *guilty_fence);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 321310ba2c08e..fcd81242059e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -600,10 +600,10 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * to be submitted to the queues after the reset is complete.
 		 */
 		if (!ret) {
-			amdgpu_fence_driver_force_completion(gfx_ring);
+			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
 			drm_sched_wqueue_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
-				amdgpu_fence_driver_force_completion(page_ring);
+				amdgpu_fence_driver_force_completion(page_ring, NULL);
 				drm_sched_wqueue_start(&page_ring->sched);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 9d5cca7da1d9e..3a3bc0d370fa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -512,7 +512,7 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring);
+			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 75ae9b429420e..d22c8980fa42b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1482,15 +1482,16 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 /**
  * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @adev: Pointer to the AMDGPU device
- * @instance_id: VCN engine instance to reset
+ * @ring: Pointer to the VCN ring
+ * @timedout_fence: fence that timed out
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
-				   uint32_t instance_id)
+static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
+				   struct amdgpu_fence *timedout_fence)
 {
-	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
 	mutex_lock(&vinst->engine_reset_mutex);
@@ -1514,9 +1515,13 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
 		if (r)
 			goto unlock;
 	}
-	amdgpu_fence_driver_force_completion(&vinst->ring_dec);
+	amdgpu_fence_driver_force_completion(&vinst->ring_dec,
+					     (&vinst->ring_dec == ring) ?
+					     &timedout_fence->base : NULL);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
+		amdgpu_fence_driver_force_completion(&vinst->ring_enc[i],
+						     (&vinst->ring_enc[i] == ring) ?
+						     &timedout_fence->base : NULL);
 
 	/* Restart the scheduler's work queue for the dec and enc rings
 	 * if they were stopped by this function. This allows new tasks
@@ -1552,7 +1557,7 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		return -EINVAL;
 
-	return amdgpu_vcn_reset_engine(adev, ring->me);
+	return amdgpu_vcn_reset_engine(ring, timedout_fence);
 }
 
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index e78526a4e521e..a6aa72ec8fb19 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1669,7 +1669,7 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index c28c6aff17aaa..100ea1a914b4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1332,7 +1332,7 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 		/* Force completion of any remaining jobs */
-		amdgpu_fence_driver_force_completion(ring);
+		amdgpu_fence_driver_force_completion(ring, NULL);
 
 		if (ring->use_doorbell)
 			WREG32_SOC15_OFFSET(
-- 
2.53.0

