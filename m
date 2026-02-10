Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811ECEA3F10
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 06:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF2710E4BB;
	Tue, 10 Feb 2026 06:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fXIFOaC0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE2910E4BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 06:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDw7JFRk/Iu98bYLRNmum3nnyw3wRUcJbAoEkyw/ugVMH6AnE1Ft8ZOpO14cI73W5HfLmN8JcTuDF+QcalWQXuwFoigKAFeMr9Off8R7kkcCTjixXGAWulsfB4L09bxq5iEPOX2up4VwzsxwMh1v9QtGOLCSLdnC/IpW4GxtWogk67rvOdbD6CbdTebQ3Mhf31zIQ8ll5ck9roDsBO52TPjcHoNFv8xddpGZFw423udhle5sWRyuYAZZR85QYdWb2pxmcfJsWtbeusk/MqKBt9jBkQ4nxQfCkrPn5R9D+cEIK/W+ADz466/faap++dkP/q38n72+oGT2dHFMYHlmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/5PMpAfzGhutz6N1nC4bDKnVuuPdJG4oQ4xl+G2A+Q=;
 b=G3uhyGEIhDBJ20THUr8HRk9uPxOEe4LhxZpEMuCqrGdJo9Jq8mPvWmXO8D+Ip1iiUCwcWY9wuPbWlnzSNH4+YN7JS5Pd6tF/T5YJHVCG3kULjTOIsJoYiDvKE7DBaMOdItwjhrdb6o1EO/0zqwh0Wqrx4fh/gq0JXDfPjfFM7BHsABYiDJBknBGnWzAGBwZ6QuxtcZOlxCd8iWAjNjSGaLH7Je/jBRGP4o8Q9dB9DM4wrTSeP7ZQWog9up27V1NxZ74IJYVp/QZU3Tx9ZQFjxtQZJoOvceVEccZ0Lp0IPapcQocQfC93kXctLWC3atQeaDF5Rm5gzbWJfPngv4ShyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/5PMpAfzGhutz6N1nC4bDKnVuuPdJG4oQ4xl+G2A+Q=;
 b=fXIFOaC05swoHN4Mu9roe4XEa5ugs1xBY8G3MkKFWwU7PkoprKQJVBCWubvnvo3G/5NwmpSY80q+qjRmT5oIw6mHIUd8QK3ZUJGatkKWelsbBPY6p3jz3fJkrbbfpVlE/6JrhCiuXshswre38nYs/yZzxHmU772bEfx05oU5LbA=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 06:34:48 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::ba) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 06:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 06:34:47 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 00:34:45 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove amdgpu_device_flush_hdp
Date: Tue, 10 Feb 2026 12:04:18 +0530
Message-ID: <20260210063419.4154560-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f882b8-a451-4c05-ae37-08de686e7c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u6OHge/teQRaga9silIdom/s6kAbSV4aT49QdzEhd5iuTcX99V/YOZfaYaHC?=
 =?us-ascii?Q?S3ucwGt2jRj5xSQOWWqJAcZIs30CItshVfw6y6K/RY86HqGOIAYktbI/MpxJ?=
 =?us-ascii?Q?6LW1UF5UN6Rb4hpp5k8+eFHxDJ1Q0d1bde0x1twAk3g0l65leE0qX3D3IVrA?=
 =?us-ascii?Q?fz19oy1CFZFWy0EMTraDorfiriXtmelDWzOkbNrb5xMz3mBO3RVs2s1cRXEx?=
 =?us-ascii?Q?OCxn6bNodGidwAHIfFmRcJIzLq/1NmKeb786SxC+PjyuhHTwRXjFw4Q1yQ+4?=
 =?us-ascii?Q?OehGg3qOBl0wsmcBDyXrdXP2Es15v0DOSBfDnuh3bZYdo12nuEVrp5zfo0p6?=
 =?us-ascii?Q?Q7oFv1i7+DaPG9WAadZUbTeoNJzvYNiOoiKUB0K5+Hft7bAwPkbionMJEbqh?=
 =?us-ascii?Q?O6umPj5+ZaFWwECW7yeh6wMs2IrrggVaxtj+yN24Hf7zfNzhCw3NLgSfaB8r?=
 =?us-ascii?Q?hJ6xa3ghDzw6aMklU1Cb3SgOSwOm9kBnDLFoxnV47pXBf5pU2UJIZx8WgUMY?=
 =?us-ascii?Q?PAmBSY6Qw4wRu5UE441Rk9Fuf8bUHL5F1hml+4pBfsscotqAnKXohV7qUncm?=
 =?us-ascii?Q?e6ZJ3gkXK8jNlOazXE7QFlF9N4nSrEKFa+8YB9L0fkNo41sOnpo8ThhFl3Xy?=
 =?us-ascii?Q?4VF6Dka6EkmRjWaXRuZJoHmw8RPvBRKbTMCDs3lTKATQ/tC8qi7NgscLkXJD?=
 =?us-ascii?Q?5zV2ZJZwdqe6mqns1hSgESFHxZj51Jla2kPTyu3o0Ua2OoHkc0n/ckQJ/uWH?=
 =?us-ascii?Q?Xpa73kMt8IJzElWX0cjY20r8Qqtmalm/BbbakIoTVvvvy0mX6RruO/pKgTel?=
 =?us-ascii?Q?G1y/Zc7PM9octCwQboiy53yNVw4mOMsp6IuW8Lg6MFn3ZfBtv165w3S7wHOu?=
 =?us-ascii?Q?WbmSApOiW17hEQHAxFeeUBjnxckao0ATVVdtctFghAH9HROpCWHq0J8GPgFF?=
 =?us-ascii?Q?sQDjjQB4rduWTUQn3VaNxo2mG0pzaj7wwi9yh78T9ofxR1EpIq013yQ3HtbV?=
 =?us-ascii?Q?mo8YDk+6cX5Rb5t+ns3xUbi/H7GPiqZNwlXs/3vVO9mbXbSIXWppYbSVouvV?=
 =?us-ascii?Q?2wJssySgVLmRSkiwObwp+OTl2Rnk/7LljWfMqvmH4TIJaEg2WYSk3lYUHnX4?=
 =?us-ascii?Q?rn1uwNTa7CzwCpcGnVvVPmbrYQKK7/MvlfgAcTx1CchlDAwiuhR3Wftcu+tI?=
 =?us-ascii?Q?/WP8QWH/AmJDtcq+3qkhGuWIFiPbCRTxcLPnBTe7XscLxgtoLVe5JfmegqGP?=
 =?us-ascii?Q?uS1uJmf5Bt3QK7esQyywXi1JCU6NCo/R+kuBtkVM79XAbeqMkQ9dWlCdMMAu?=
 =?us-ascii?Q?294Q8H2ssmZH5MRW7uU7tpmklB5WbPuq1fSItmPIgAA4vYAFX5iBxiAGbget?=
 =?us-ascii?Q?zcMMedasnAxJcisTCvTeWZg4xfx72f4+wesO8M+i4m+SBcEmiaR24sf20trA?=
 =?us-ascii?Q?LYwKp8l8/NXpE/+Mqa/9XGUIH6KbgcIWGHUaeLSmd/JJLmJAiYfu8QWmf8gS?=
 =?us-ascii?Q?f2yNThpS0nZ29AV2S7AfYPz6/0rOIoFZUJwEyzmm/evBJU6kdc66qcUMHDoT?=
 =?us-ascii?Q?gMg+8OmFo92tzW16f33NTalRi9PUroNUl8hbpbpOuX59Rgx1DJcShoiIWazH?=
 =?us-ascii?Q?AeyrTwxs8BZBbXeapFUDPUpEAlr8R5S1/DiT7J/3OFG2OyXMUkSWYYEpeMfw?=
 =?us-ascii?Q?JzFs9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P87/LivH/M0R1FxM4cb7VOUD99ABFNUzjxkCAqapI5B34h5U816oQb2H4tUvps+JPBGVWtouvz2GO4jro/2hCRPA8dQuBxqDmCQSrWwHC3LAEe6Kz7R7iRCQbl92wWv/ksABktRg0PeeHjUROPo55UadBq3iaH3dArYH0FejsqI/RLf6SrgkiPzzi1aA+/SRuiAuiGxfuZHg0ZRW/W4lv/YmyctC0I8EHWrG0S3MRBqi8uMmhy6XHfzTnTkLkXUfTWnr0ejv3nh3e64N4AUlkwpb1hWgjQW8p/XhAMaI1pDQHtbkZQWPyG1sZ4BA1kcnt5JztCca8JMvr8rr8c/2oNdIF4tUBO7sf1Hb18BeHSXITOIpOkGI5dJD4wza9yh597eKJ2ACRYzQy+gw6oQV1cpgbQZDooi5D19CIqMstLg1+LAUefbOkrOqvJHu3jVE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:34:47.6950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f882b8-a451-4c05-ae37-08de686e7c79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818
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

Merge the logic into amdgpu_hdp_flush and use it as the public
interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c       | 17 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  6 ++---
 23 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f5d15110e43..c1eded4bfa75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1527,8 +1527,6 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 int amdgpu_device_baco_enter(struct amdgpu_device *adev);
 int amdgpu_device_baco_exit(struct amdgpu_device *adev);
 
-void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring);
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..ed153e9008e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -738,7 +738,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev)
 {
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 }
 
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 48540300b10a..212eadb90c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -771,7 +771,7 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 			 * after the system memory contents are sent over PCIe device
 			 */
 			mb();
-			amdgpu_device_flush_hdp(adev, NULL);
+			amdgpu_hdp_flush(adev, NULL);
 		} else {
 			amdgpu_device_invalidate_hdp(adev, NULL);
 			/* Make sure HDP read cache is invalidated before issuing a read
@@ -7288,29 +7288,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
 	return true;
 }
 
-void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
-		struct amdgpu_ring *ring)
-{
-#ifdef CONFIG_X86_64
-	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
-		return;
-#endif
-	if (adev->gmc.xgmi.connected_to_cpu)
-		return;
-
-	if (ring && ring->funcs->emit_hdp_flush) {
-		amdgpu_ring_emit_hdp_flush(ring);
-		return;
-	}
-
-	if (!ring && amdgpu_sriov_runtime(adev)) {
-		if (!amdgpu_kiq_hdp_flush(adev))
-			return;
-	}
-
-	amdgpu_hdp_flush(adev, ring);
-}
-
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index ec911dce345f..0f4a39f48c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -443,7 +443,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 
 	mb();
 	if (down_read_trylock(&adev->reset_domain->sem)) {
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 		up_read(&adev->reset_domain->sem);
 	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cab3196a87fb..eeec7947fc49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -676,7 +676,7 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	uint64_t queue_mask = ~0ULL;
 	int r, i, j;
 
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	if (!adev->enable_uni_mes) {
 		spin_lock(&kiq->ring_lock);
@@ -736,7 +736,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		queue_mask |= (1ull << amdgpu_queue_mask_bit_to_set_resource_bit(adev, i));
 	}
 
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	dev_info(adev->dev, "kiq ring mec %d pipe %d q %d\n", kiq_ring->me,
 		 kiq_ring->pipe, kiq_ring->queue);
@@ -781,7 +781,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
 		return -EINVAL;
 
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	if (adev->mes.enable_legacy_queue_map) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 5a60d69a3e1f..c085031a6f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -77,6 +77,23 @@ void amdgpu_hdp_invalidate(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 
 void amdgpu_hdp_flush(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
+#ifdef CONFIG_X86_64
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
+		return;
+#endif
+	if (adev->gmc.xgmi.connected_to_cpu)
+		return;
+
+	if (ring && ring->funcs->emit_hdp_flush) {
+		amdgpu_ring_emit_hdp_flush(ring);
+		return;
+	}
+
+	if (!ring && amdgpu_sriov_runtime(adev)) {
+		if (!amdgpu_kiq_hdp_flush(adev))
+			return;
+	}
+
 	if (adev->asic_funcs && adev->asic_funcs->flush_hdp)
 		adev->asic_funcs->flush_hdp(adev, ring);
 	else if (adev->hdp.funcs && adev->hdp.funcs->flush_hdp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 44f230d67da2..f4885a140967 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -243,7 +243,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		cond_exec = amdgpu_ring_init_cond_exec(ring,
 						       ring->cond_exe_gpu_addr);
 
-	amdgpu_device_flush_hdp(adev, ring);
+	amdgpu_hdp_flush(adev, ring);
 
 	if (need_ctx_switch)
 		status |= AMDGPU_HAVE_CTX_SWITCH;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b0540b009e84..57a8ac2c69db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3479,7 +3479,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	write_frame->fence_addr_hi = upper_32_bits(fence_mc_addr);
 	write_frame->fence_addr_lo = lower_32_bits(fence_mc_addr);
 	write_frame->fence_value = index;
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	/* Update the write Pointer in DWORDs */
 	psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) % ring_size_dw;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 22e2e5b47341..df978a39ed96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -112,7 +112,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	amdgpu_hdp_flush(p->adev, NULL);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb26c..b413f10e51c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6153,7 +6153,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -6231,7 +6231,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
@@ -6308,7 +6308,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -6683,7 +6683,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08..f4eba3247533 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2522,7 +2522,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -2566,7 +2566,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -2611,7 +2611,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu_device *adev, uint64_t addr)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
@@ -3248,7 +3248,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -3466,7 +3466,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -4703,7 +4703,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c36..3d068dca1442 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2405,7 +2405,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
 		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -2549,7 +2549,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
 
 	if (amdgpu_emu_mode == 1)
-		amdgpu_device_flush_hdp(adev, NULL);
+		amdgpu_hdp_flush(adev, NULL);
 
 	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
 		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -3560,7 +3560,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2568eeaae945..dffb130489a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -250,7 +250,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -946,7 +946,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6349e239a367..c322b438d0e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -238,7 +238,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -918,7 +918,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index b9671fc39e2a..2e5c373a8289 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -309,7 +309,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 
 	/* flush hdp cache */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	/* This is necessary for SRIOV as well as for GFXOFF to function
 	 * properly under bare metal
@@ -969,7 +969,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	/* Flush HDP after it is initialized */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	value = amdgpu_vm_fault_stop != AMDGPU_VM_FAULT_STOP_ALWAYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e35ed0cc2ec6..47b989036de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2175,7 +2175,7 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0bd83820dd20..21eef7f6afb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -495,7 +495,7 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 	memcpy((void *)table_loc, &header, size);
 
 	/* Perform HDP flush before writing to MMSCH registers */
-	amdgpu_device_flush_hdp(adev, NULL);
+	amdgpu_hdp_flush(adev, NULL);
 
 	/* message MMSCH (in VCN[0]) to initialize this client
 	 * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 09ebb13ca5e8..ec50df3ea9d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1212,7 +1212,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
-	amdgpu_device_flush_hdp(ring->adev, NULL);
+	amdgpu_hdp_flush(ring->adev, NULL);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 9aa988982304..691b305f28c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -551,7 +551,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			amdgpu_device_flush_hdp(adev, NULL);
+			amdgpu_hdp_flush(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index af4a7d7c4abd..7106ad806a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -640,7 +640,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			amdgpu_device_flush_hdp(adev, NULL);
+			amdgpu_hdp_flush(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 38dfc5c19f2a..5fb35d9b0f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -505,7 +505,7 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
 			}
 
 			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-			amdgpu_device_flush_hdp(adev, NULL);
+			amdgpu_hdp_flush(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 804851632c4c..da062d13414f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3497,7 +3497,7 @@ int suspend_queues(struct kfd_process *p,
 
 		dqm_unlock(dqm);
 		mutex_unlock(&p->event_mutex);
-		amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
+		amdgpu_hdp_flush(dqm->dev->adev, NULL);
 	}
 
 	if (total_suspended) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..fbcb12e0888a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -754,7 +754,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	}
 
 	if (mqd_on_vram(mm->dev->adev))
-		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+		amdgpu_hdp_flush(mm->dev->adev, NULL);
 }
 
 static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
@@ -793,7 +793,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 	}
 
 	if (mqd_on_vram(mm->dev->adev))
-		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+		amdgpu_hdp_flush(mm->dev->adev, NULL);
 }
 
 static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
@@ -834,7 +834,7 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
 	}
 
 	if (mqd_on_vram(mm->dev->adev))
-		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+		amdgpu_hdp_flush(mm->dev->adev, NULL);
 }
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		   enum kfd_preempt_type type, unsigned int timeout,
-- 
2.49.0

