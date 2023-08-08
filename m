Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C1FC04A6A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 19:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7BEC10E3EE;
	Tue,  8 Aug 2023 19:32:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603FB10E0D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 19:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU63RWBiAjBa61Fu0w1JAdpyOfzUSZibGofn4hbrHQNfNYqr7q3sXzfnzEwpOEXC7BllPspSkB9x/niWT6Qho8oqY0MQxJ1X16w/usXN9GzslrWYCGNQYpHidtC8hpSGEG19/+h219+57Q8RtIHAY6GXU11zfwsXuAfwAMWLhKK1tH4GSiBkzkcD9pzTYEc/RX478YnRtqpJHgUZTjHvQ37YC7m0kasOTdG7Kmto9Ffa2idZtbfS3RkMZPvNN67tisnoni0mapsaw1fT+cLJ4B+FD2v8zwciK21r5On4M8S6xnFN9F6sa+fZnLeowo4dGyRzxO+jG5tr0ch9mtLtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fcwp+I48fnlSXXRjwamNxwGqaBD0sDfW7NIfnnuaUw=;
 b=VMLrHNzgKNdHmi5Ct7wATaw6+ETEj8B9j6ZoRZ9Lv0QIhopxfYrzXsjGk7izN+vQnFg3X2OwxhsknEZb61E6AKM1Md1HO5ba94OsvSrOG+sZBUMjDDcdhP/sYM4+1GBu95nq1QEu2NE7MF70bJ8ad4sm7ByPksVKtS6d3iVr57rtwmZ8Gg/CpNLlVqTgcF6xcfw9RgeOITtC203XFVXZ2yyD9y0TSTs7GMH6dvLBpJ+vDXWE1Q5dspzV2lR9A9ndmBvDSsnckTXGuny167q87fE2/ozETmhp6d/sM1bHxqHCOoeOYhHOgbSICA4SSzofZNjFqfn1VM7/fkLUWElusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fcwp+I48fnlSXXRjwamNxwGqaBD0sDfW7NIfnnuaUw=;
 b=pheZhRZ7BES31jAb/FnXitkrY1YImG/j/Hh+CgSr5o9xg8j+OaMBNZVmlRSCn2c4rOhzSbWfZ8i7PSHhlyKIaiEb9f+elQvZh7B507sjkeU91F3w/fOlsvuWSEoEsvvRuks7jnxXdwh7orVN1XPOj9pzPRwXtmBphSws+Q2kiH0=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:32:11 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::31) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Tue, 8 Aug 2023 19:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 19:32:11 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:32:09 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add xcc_inst param to
 amdgpu_virt_kiq_reg_write_reg_wait
Date: Tue, 8 Aug 2023 15:31:48 -0400
Message-ID: <20230808193149.34505-2-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808193149.34505-1-victorchengchi.lu@amd.com>
References: <20230808193149.34505-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a71b276-11ee-4821-f398-08db984629b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJ7HD1BsR1JEl81kGwpl4RPHQuK//RDsKC4CX03Kp2c3islcX5j/uCNrT+hoIjjx58BH1nPBPlZCcCxaoimFg29ZBe1ahRaQbCCcSwgitUiRvnPdxla7xQ827nD2mHDqgrt1Dk+EoRWLSxxqGMK2cPaJSp+cCLndU6hsqcKS4E+bVkzlrAM2zP3ckMSxKDHz6zBqS5JWnM168skT7ZFuvFmZ3rdCkbu4xJSPQiLqo3yG18QiFXpiUiwG15lWOoZKds9vp2bDH5wBT1+4WG12w7AL0aNjRf3N3BBCUWDgoIlHzDj8VgUbsKSamkyk0CUOjUUH/nHdf+VtZPP6OzNdFyc2MtSZjZXcWnE0efhoKs0IV/0QtZixDejffr1hPiF4PEI7BRZsYbxACdL7edjGUVSHi3TzIhHGF/XK2qHTLy01qag+RqYdEuPN8twPqRMzt8CzMRvOCvHKoDQsxzEo0j3I0DWpEheV6+099n+8Uf/qBIbKzqllB2o+KxILdaISJ0zD+xognWp5kZ6PDzmBSbgFVROOKTqh4fmyVE+Vyo++pe6f6dQ2vU1QTwJhGIPgIFBWgz3GdritJu4/sMlziRHBhYBvaBG2b2Y4gVBpF/1oP+sSghjJebHkyiER4ALz4u2xkFU4DVeSOTiR8xjNQuK6Zi8v6UHDLneZ+KTlegGT+t1t/ImTs8YLL7O0GVRX4N+JRcXEZSu2DSg4+yi1H6RvSFF63C0nFg0sQqbDjhQ0d8wMJ/622V0kQimIeUKcbMrKI1a/Y7LX17GKo2PaTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186006)(1800799003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2616005)(36756003)(1076003)(26005)(7696005)(6666004)(478600001)(81166007)(356005)(82740400003)(54906003)(16526019)(336012)(70586007)(70206006)(6916009)(4326008)(316002)(41300700001)(426003)(8676002)(8936002)(5660300002)(2906002)(40460700003)(36860700001)(83380400001)(86362001)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:32:11.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a71b276-11ee-4821-f398-08db984629b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_virt_kiq_reg_write_reg_wait is hardcoded to use MEC engine 0.
Add xcc_inst as a parameter to allow it to use different MEC engines.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 10 +++++++---
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 96857ae7fb5b..105a1fdff2f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -73,9 +73,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t reg1,
-					uint32_t ref, uint32_t mask)
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_inst)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
 	struct amdgpu_ring *ring = &kiq->ring;
 	signed long r, cnt = 0;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fabb83e9d9ae..e9eb64e11c9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -330,7 +330,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
 					uint32_t reg0, uint32_t rreg1,
-					uint32_t ref, uint32_t mask);
+					uint32_t ref, uint32_t mask,
+					uint32_t xcc_id);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa87a85e1017..56f50abcf9e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -346,7 +346,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 
 		up_read(&adev->reset_domain->sem);
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e3b76fd28d15..3f6626f8c298 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -303,7 +303,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
+				1 << vmid, 0);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 11bad5475b31..5b040011bb92 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -815,7 +815,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 	const unsigned int eng = 17;
-	u32 j, inv_req, inv_req2, tmp;
+	u32 j, inv_req, inv_req2, tmp, inst;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
@@ -844,14 +844,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
-	if (adev->gfx.kiq[0].ring.sched.ready &&
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		inst = vmhub - AMDGPU_MMHUB0(0);
+	else
+		inst = vmhub;
+	if (adev->gfx.kiq[inst].ring.sched.ready &&
 	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
 	    down_read_trylock(&adev->reset_domain->sem)) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-						   1 << vmid);
+						   1 << vmid, inst);
 		up_read(&adev->reset_domain->sem);
 		return;
 	}
-- 
2.34.1

