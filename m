Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA67461261
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA67461261
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8CC89CB9;
	Thu, 18 Nov 2021 16:57:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CF588A33
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrVPFn1iWTbV9a6eHoeUuCeWUTjKhrmognLtEkJ4PX0ZYc/DDpPNw9IsqCm0Ud+53vxVPfCWwBt3V0nPUMMJcx6AEm94E0dOTlo/01K/ukKal0TKhmnBpfZ9lpHUG2UFnEb3yyq99KoJ8h1k1BKnYjlVDOXHIwoAWrK5cZ6M0SeRFWE+JreYXwSHguyovMadXb/Oc1UrVvKujS9sIC9rkpS+OOPCVzOHLlk5IKAMtR1F0kFPlQw8HYbyGkEBMqyVI3hi8mMl56aS0SM3vqRsLhFPFukKcWWSbkO8KV26FYHl21qWhkYYLbytY2TgDN/cR2CjSPAWUJ2HQq6XBHgi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQehIproxFu2O2Je43ycKJfIW/pvxITXD9BNnxuIjfo=;
 b=bkDenvODuWftsgQhqy6KayI6wjiZ1hF4zI2WAD0/LFVqtkJN4XlGRBvaMIcuqWRRPVmqW/zKP/2UydU6A9PQxgyVB66rxpLZLp8NWyYy69ZEWfhC+3rI4oYKvAmRm0O/ugCU5Au8AlqObi/gNi+IrJ2nDLk2veCc2uW/1TajWxWi2MmNNsGwE3b8ORdFn5iM0cR5zB/kS0/Rvc+F5nrusJ7jGFAbHPQHtmbK8VebyfQIM7zb+3dMkp4jo+z1UmO/WVX/qkWczQ9GhkKy9u7xyT8dmK+eqZcrF3C5DaUSNo0A08nMDWUkLAziUe8kh90UI2M/KLynQ9YmLqzjkRAosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQehIproxFu2O2Je43ycKJfIW/pvxITXD9BNnxuIjfo=;
 b=1AHZUJfhRliw3cdUdDzOzpvJjDZGvQ0hptDMzPEmvPEd5GA4i+Frh1T6UZVIypXwe3Ut8guKo1Thj2CTDYLkFnLVSwMDQt3XnGAVCSl280+z2k89MFKvnhGEWbH1XDZyz7RBoRjKVoTEbJ2ZbvzzWI8C2Jezr6mwNhQTn3OQa80=
Received: from CO2PR04CA0119.namprd04.prod.outlook.com (2603:10b6:104:7::21)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 16:57:52 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::31) by CO2PR04CA0119.outlook.office365.com
 (2603:10b6:104:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 16:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 16:57:51 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 18 Nov
 2021 10:57:50 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: move kfd post_reset out of reset_sriov
 function
Date: Thu, 18 Nov 2021 11:57:37 -0500
Message-ID: <20211118165737.27432-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c687e773-340e-462f-1c57-08d9aab48ef8
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4708E219E28AD20B0B05BC55F49B9@BL0PR12MB4708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX6MaefNWcPDdsCC+I5iGkWTUERthA3yIktfParhlf3F/MdioPFuoMZmDy0ozxRVFj+GWCEjr5TcexQ2nvVwZMEnwck1CGcr/s+bBAocihWnQ4aXx29F4K6KbH7+LhPcaeBO7436637OTnSY8LOJdQxMAcA7kxQC5Gz4L84O6F3K0uDIWOIZi/ZjdsyeAnspU/lo8XyFjLVQyzMEEhCW7MDKhjbCtIVOFePfyMuc3OPVdaqiasAXJKlpfb4UODGHNzK5MtWWfagf7XNHQYlxFqXQ6RRDmU++L/Z3Uc+TkTDn9ze/Nm3YLzLOvC8TbQm5Fyv8/IszyEInfMK2iTGwTHG6xzAr6LDPgaQ6JOZHFhNSdtol20DVd+13c6awBr6rzpZ5LMKl5xsBRWAsARTxoO0oufsFNR/khTBdkY0VLmWWxJRbTQ/lSMSJQjk2t8E4jSbNdoxL4EcoBHwaNnFnt3D1Xe6t/skneeVg5VHlGEeSZiJZlfJ+neNENxaMCd+phcc936RYHpMJ+3xq06/ikhUqATCPMy49NHzJHFkuIcgGUirSRE8jQnHp8Fyid4o2S0X+AGZv2YaGF8/X+GY7v6SnYyGlYWgmDZ9Ahb486AXwX8qIG+LWG8vzmChIOIGOAnnkVBmtLDr0e4h/2ENGVqzHGgOB7WjMcWi1QkzzJFOIIBKvF3tU34wn3NFOY6IwIgHI1i9W/5dWEtBYNnv+vneBlzUApRYCo++vZ3voBopd10OJ9grxMzPGoxo/9XYpDNuVE6fcNoH2Dr8P/NG+1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(426003)(498600001)(82310400003)(16526019)(26005)(1076003)(5660300002)(8676002)(36756003)(186003)(47076005)(83380400001)(2906002)(7696005)(4326008)(6916009)(86362001)(356005)(8936002)(36860700001)(81166007)(6666004)(70586007)(70206006)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 16:57:51.7486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c687e773-340e-462f-1c57-08d9aab48ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sriov XGMI  configuration, the host driver will handle the hive reset,
so in guest side, the reset_sriov only be called once on one device. This will
make kfd post_reset unblanced with kfd pre_reset since kfd pre_reset already
been moved out of reset_sriov function. Move kfd post_reset out of reset_sriov
function to make them balance .

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 10c8008d1da0..9a9d5493c676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4308,7 +4308,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 	r = amdgpu_ib_ring_tests(adev);
-	amdgpu_amdkfd_post_reset(adev);
 
 error:
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
@@ -5081,7 +5080,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
-	/* TODO Implement XGMI hive reset logic for SRIOV */
+	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_device_reset_sriov(adev, job ? false : true);
 		if (r)
@@ -5141,8 +5140,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd: SRIOV would do it separately */
-		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+		/* unlock kfd */
+		if (!need_emergency_restart)
 	                amdgpu_amdkfd_post_reset(tmp_adev);
 
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
-- 
2.17.1

