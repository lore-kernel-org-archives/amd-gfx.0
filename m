Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC5DC27C50
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D727F10E676;
	Wed,  5 Jun 2024 01:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEjOSpDa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E30DB10E672
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MM/LduD3PWDT+NjVukNi2YwNNmlNBlMrYszn2LgpKMkdOVcId80OopAR4eed2D9gpCDIErsG45e4Xigc7nPm3T824Ex2l1CaI/Wik4WCJ/EU6ZlH4a/h6GHELADlw3ZZzqRrq2+MiaeuDk66q5YyQzJM3kKahqodCzn0t7BDdIjGHxzIZ5ZJCPXoaldFMX5R51mr+UadLdlTB6AZQdPi9QWwqDzdPCX6gx+rPVDcUL8Ya4ZaEAm+eMXLLwWVjdyONKWUZt6MQVljoGkWfhQKYup63TLk4Js9h3oEkzj512fOVaLgl/pDZU5XKyIPgRe5Q69q8WzQbihKz/34LchJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9iAaW8mKkOmeoxxavL+tLMWvQkZ01ASuq7x4OJ0Uwg=;
 b=kitzrDFRw9opumkUlSPRSeqAvAUbxx3qrDQk14c8FHlgGZelLCdeKrxC2fSpJQil07wZDNbNiLc+3pxSnKg+HNpPUQ2Co3mqY3nabR0wHn0iexP+BvOB1xKRfdTZz8+vXm1sBBT6ry/XPeue6sZPHCIVrPszW/KnM6dsMHOJmfI2yxe4wHIvoaqy5tHO3y1lcSw8i+aHnzDyGM6fFmAII8KJcTIhqVH8v7KTUEcLqU/8nNBs7cD7y5hQ03SeGrFGL/rTLb70OM3zEWv789aA48TUmuBQ2LaI5gOH7N75ZizVLmH3/wBqmoTJaZ2V7XaPJywe9nnQR6F1KYkdvsXsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9iAaW8mKkOmeoxxavL+tLMWvQkZ01ASuq7x4OJ0Uwg=;
 b=kEjOSpDaUTdVbDhmo2oz2tqhBCyZD6E4sCGopuOFGBgnIeckCRNOJxtz2ho8iWrca/2xxHhGvgsoCumeAdev/LOMzh19nuWR2Ah2So3HoHzGGqI9zUg2f5/HxbeHfleAPuAC+UILS/QqxPFKl4jCc+GYd50ZEuDPCgSczL5v8N0=
Received: from BN0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:e6::7)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 01:33:51 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::e5) by BN0PR03CA0002.outlook.office365.com
 (2603:10b6:408:e6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Wed, 5 Jun 2024 01:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 01:33:51 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 20:33:47 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4 2/9] drm/amdgpu: fix sriov host flr handler
Date: Tue, 4 Jun 2024 21:33:11 -0400
Message-ID: <20240605013318.11260-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605013318.11260-1-Yunxiang.Li@amd.com>
References: <20240605013318.11260-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 23760909-e8ac-417b-4768-08dc84ff8e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFFOV1JoRnhRVVJiUWFWYkpCWHdyTG1ER0JDaFI5bTFkaGNJdmRLeHI3dFlE?=
 =?utf-8?B?TXoxM2kvMit6YkN5cVZHcGNQazc2Smp2RkJrSjdQOHVadDhkcEV5bVZ5ZXZx?=
 =?utf-8?B?blRDS1UrUTZ6WEVHYXhoZ1RLODFzcFJPSGRKVkZPOFpYV0VPempaTTlsVFhK?=
 =?utf-8?B?NzdoWTNMS3NldUZQUUUwamx4eGF2S1JmNjJCYzFMcnM0VnJWa2NQMllIeElk?=
 =?utf-8?B?SHN5LzN6M1loeDVvWC9vYmpFajZieTVTS2w3OVQvcHFORmgzWGpEY1hNblla?=
 =?utf-8?B?aXc2MkhiSG5rQmd6ZU9TSUVINHY2REtodkdHTkt5YjlEZENxb1E3SzFDSHNH?=
 =?utf-8?B?YU03MitZWnA0dVlWQVRsTXVRaFRjT1plY1FNcHVlSi9jclE2dlQzSlQ5Q2JR?=
 =?utf-8?B?VCtzd1RoSm05Qk5oRkN5b1kybG1KRWEySXJSa0psci80Q3V5SVdtSEdYOTBi?=
 =?utf-8?B?VHIxZ1F1aTRuWjdLbGZvTHNHbEcrL2NVS0ZoRTlyTUEzaW1iZXlPdk5wQmNY?=
 =?utf-8?B?c1BjQmVMMXR1a29Td2lhN2p2dzRrL3d2QWswbnFXT3RPTFdBTW1hN21qNXoz?=
 =?utf-8?B?dTFpbjAxYjBQQ1FoRllmbHN5R3psamF0RWpWTGwrdzloZzFJV3FkWlV4OW5Q?=
 =?utf-8?B?Wktma1NLWTBiUEJEaEZNUVliMmk1dFpaMXV3aGs5b0wzRjBJUW0ycHlKYm13?=
 =?utf-8?B?S2k4SnNPVnMwMVhxOW5qRUtoa3RRU1JOdGhxNjFCaHoveDZDSVd2Z2tna05o?=
 =?utf-8?B?VHNGWUNQaVp1NVpVUnRjUS9CMmR5MTZtQlQ5QTVsY29kZzRYSGlGSHdDTHVk?=
 =?utf-8?B?SzhFaVlXM1BBL05ZdEVTbWlYS1c0ZTNCS2dYZXhCK2JEZWZzbUNzUGdUU2ha?=
 =?utf-8?B?VS8xdDJGb1VXWmFEZjczZW5HQis5Z2xJNmsvV215K2JxNWkvWmdiMkRVODUr?=
 =?utf-8?B?TUpxd3FLOXhFK0k1UVFBcENTOFJmRlRPNFRuSzB2anRPZWRhZGoxNWNma3hy?=
 =?utf-8?B?TEtPYTJVUDZHR3g2UFlxYW50dXpLR21FZW5XcHcyWXc4bWQ3aFllUGxNV1hE?=
 =?utf-8?B?ODJkOS9iWWhvQ05SSXBBODZGb3dFOEszKzN6eE1lMFh3dGFVQWtWUWt1STE1?=
 =?utf-8?B?RnVBVGJSVi9CU3hWTitVeDBnTDZHVFJLWHdkMUNzR2lXUUlCVmx0Smo1cUFN?=
 =?utf-8?B?YlZSenNJQ09DSld2eFBkejU4VEd1OUw2QkRYYzh2U0I5a3NxZ25iajBLZ0g2?=
 =?utf-8?B?V2tVeHhxMkxkR041emE3Z2NOaEg1VWdkb0VwREZHMmIzdUcvOTF5K2hGOVAz?=
 =?utf-8?B?SmdlVUFqSVhxQm5mZjRMVnppV05FeFpuZUMxdHE5Uy9HVVBGd2w3NUZzcW9v?=
 =?utf-8?B?VUJyYm55QW96R1JHMklTUitxYlFNRTR3eFU0aXh4RlJUNHF3dzN6Y3ZqektX?=
 =?utf-8?B?UUgyRmYvblNneTd2aGM5RFVvak03MmRkeGp4QlhMMGRndm5DN3FQSW5rVFZJ?=
 =?utf-8?B?UzlIL2xuYUpmTmJNdll3MUtmTjJ1SFp3bXczdnBJNTd6aVh3S3RhbVdGVUpi?=
 =?utf-8?B?NmMyc2p4Sm95S3E2MW1EMDRIcmNrMERNTDZoUU1BdnVweEtEcXdTR0VncXJF?=
 =?utf-8?B?TVRRdzEyR1NyNU5IZ3ZpVEFGQXdIQkVDZTNVVnp5N0NDOVVJQUxrUHFCOEVp?=
 =?utf-8?B?emlBczA2WEd2TmZPT2VJU0lyaElJMkxSQ3kya3Q1UXhyUXhoOFpZc2FLZk11?=
 =?utf-8?B?VTZ4bWR4ZCtXWURLQmxaK20vUzZYM0VqcDdoeXlGK1A1ckNqN3NGZTU5b2ZS?=
 =?utf-8?B?dzBoRjlLSDVpM25LeXR4SDlxc3lrRlYvRzdwakRSZHBnYzF1OTVUNFpFSVNI?=
 =?utf-8?B?RWhTclpCMTdIRFdTZXM0VTVXMmxpemVOVGJoVGMwNGdQd1E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 01:33:51.3642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23760909-e8ac-417b-4768-08dc84ff8e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
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

We send back the ready to reset message before we stop anything. This is
wrong. Move it to when we are actually ready for the FLR to happen.

In the current state since we take tens of seconds to stop everything,
it is very likely that host would give up waiting and reset the GPU
before we send ready, so it would be the same as before. But this gets
rid of the hack with reset_domain locking and also let us tell how slow
ready to reset actually is from the host. The ready to reset speed can
be improved later.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 14 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 39 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 39 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 ----
 6 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf1a6593dc5e..eb77b4ec3cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5069,6 +5069,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		amdgpu_virt_ready_to_reset(adev);
+		amdgpu_virt_wait_reset(adev);
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3cf8416f8cb0..44450507c140 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -152,6 +152,20 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
 		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
 }
 
+/**
+ * amdgpu_virt_ready_to_reset() - send ready to reset to host
+ * @adev:	amdgpu device.
+ * Send ready to reset message to GPU hypervisor to signal we have stopped GPU
+ * activity and is ready for host FLR
+ */
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev)
+{
+	struct amdgpu_virt *virt = &adev->virt;
+
+	if (virt->ops && virt->ops->reset_gpu)
+		virt->ops->ready_to_reset(adev);
+}
+
 /**
  * amdgpu_virt_wait_reset() - wait for reset gpu completed
  * @adev:	amdgpu device.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 642f1fd287d8..66de5380d9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
 	int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
 	int (*req_init_data)(struct amdgpu_device *adev);
 	int (*reset_gpu)(struct amdgpu_device *adev);
+	void (*ready_to_reset)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
 			  u32 data1, u32 data2, u32 data3);
@@ -345,6 +346,7 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
 void amdgpu_virt_request_init_data(struct amdgpu_device *adev);
+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
 int amdgpu_virt_wait_reset(struct amdgpu_device *adev);
 int amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);
 void amdgpu_virt_free_mm_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f4c47492e0cd..6b71ee85ee65 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -249,38 +249,30 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_ai_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	amdgpu_virt_fini_data_exchange(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -417,7 +409,8 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
 	.reset_gpu = xgpu_ai_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_ai_ready_to_reset,
+	.wait_reset = xgpu_ai_wait_reset,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
 	.ras_poison_handler = xgpu_ai_ras_poison_handler,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 37b49a5ed2a1..22af30a15a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -282,38 +282,30 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
-	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
-
-	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
-	 * otherwise the mailbox msg will be ruined/reseted by
-	 * the VF FLR.
-	 */
-	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
-		return;
-
-	down_write(&adev->reset_domain->sem);
-
-	amdgpu_virt_fini_data_exchange(adev);
-
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+}
 
+static int xgpu_nv_wait_reset(struct amdgpu_device *adev)
+{
+	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 	do {
 		if (xgpu_nv_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
-			goto flr_done;
-
+			return 0;
 		msleep(10);
 		timeout -= 10;
 	} while (timeout > 1);
-
 	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+	return -ETIME;
+}
 
-flr_done:
-	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
-	up_write(&adev->reset_domain->sem);
+static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+{
+	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
+	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+
+	amdgpu_virt_fini_data_exchange(adev);
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
@@ -455,7 +447,8 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
 	.req_init_data  = xgpu_nv_request_init_data,
 	.reset_gpu = xgpu_nv_request_reset,
-	.wait_reset = NULL,
+	.ready_to_reset = xgpu_nv_ready_to_reset,
+	.wait_reset = xgpu_nv_wait_reset,
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 78cd07744ebe..e1d63bed84bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -515,12 +515,6 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 
-	/* wait until RCV_MSG become 3 */
-	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
-		pr_err("failed to receive FLR_CMPL\n");
-		return;
-	}
-
 	/* Trigger recovery due to world switch failure */
 	if (amdgpu_device_should_recover_gpu(adev)) {
 		struct amdgpu_reset_context reset_context;
-- 
2.34.1

