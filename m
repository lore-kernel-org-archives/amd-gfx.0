Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA08C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 02:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC856E219;
	Tue, 30 Nov 2021 02:40:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B486E219
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 02:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQppUz/USqG4OeXE0J1fx6h2Tz3co3msawTCkFen5fWVqpffs0Yu/nfGBUv4xPDq72LcZsbdkjZ+XFQyEJDM4JIJ1uHLQvtjtpWMBXCaj3Se5toQGIEZezldkSiDZIkrQvhWv/iFjAxN0fU1kEWDCb+LYGlMI6NuH9EZbBTX+s9AOSI9zRGlDReT+TVkkgXq/irOGqFgPgPJepsSUlFdlRTlYAaZrSTXaiHvYMi719P5PNVkYGR/dz6mTvar01uwZtZHMAwcYu3tOVGdFOwow6bQIy8KjmNPrZ6pyAWvmOh2u1dHbR0MJkMzeK2KBn8d7+LRSEdcyE0gvaIxER06HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWfWOFvLo30OnEv/CRY19EcRig7UYmJkBU90jQP9EXI=;
 b=j+DVV6tlCWN/LlL/EKDlxNUwgbWZdIS2P+jgRtra+2enaUoEr/DLgUsWVEpJ8PYF2qJbeG98OKKAFyphkQAWCNj3WAnQkFsydaDIQS8xY75d68bh+nS/6QKg1njFaVTbQnX4Th+B9AvBaQP8rynneHVe7duGo2LHEA4KFfxSXQf7eXk1NyWZK5OZUB9zHdwp5YCBkNzOWtj/83ASpblL+1EVnAtiiGrTYWzp1ywXoK6KmaErOSJRpAF9kMra1ljIi1V7uk9AUYyn/DlfNoqddjBeU6fCUNGGShE224n4cVf6uCB0+WvJCAPZMwaSIwZDqNuQlGNXKe8Q3hHFc5LtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWfWOFvLo30OnEv/CRY19EcRig7UYmJkBU90jQP9EXI=;
 b=owXdl/zy5SZotRG2T7MhusfK/7pqhcYrzO91Lki1YjGGxZOBpkUSns3Vpg7VmtmxPzqq4HI4P2LP5xIE1/3NRq20tlLf+lFIDEI88hvGsKhMlu2t3OnZrDzv/polbpNcSeFfM9GcDdcZaib6LYK8QNvMW9AleMHmShrfUB/w+lA=
Received: from MWHPR18CA0051.namprd18.prod.outlook.com (2603:10b6:300:39::13)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 30 Nov
 2021 02:40:24 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::6a) by MWHPR18CA0051.outlook.office365.com
 (2603:10b6:300:39::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 02:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 02:40:23 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 20:40:19 -0600
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: adjust the kfd reset sequence in reset sriov
 function
Date: Mon, 29 Nov 2021 21:40:02 -0500
Message-ID: <20211130024002.12492-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01b64351-a8b9-4d3d-8827-08d9b3aac21d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36037DB8ACDD757F09EBD339F4679@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhGJcp6Flq7gnpJ1V4L7eBfVtUElnJHT6UlKCvGbDJaNPxLlePgF9M2bartTAbmgRPDt7TjAGu1d09NffMSaizj7lksziOq4tlH/97yHbTxi5/W85qUmjpXb8+gS9O6Hz2KG2eDv6cumZTfeyijDYXssG3F3k1BNciUaK7Dbgis3D7zwvz6sXrS6b+Z1EUkSIBQB8I4/DjzkSLCfYKQLI1NvnC10TH2mENbI4l/DhmW9ezRQOtS6iHEjcUC1Q9XkMc5qR83/enFQdWLpi48uYUPnuG9JB5uV1RMV4fMDPQhfMbAXhdgSSbUZIEPG7bTjxbXNVucILhvfSFAWSp8wd82dGxCvlc6zibJrSbSlTzZN1btShnx7NqWtEO1q2mTWHCDBMHFr4UQjamI0ZBfNIb7GxE6PiaHJonGZICz4Cmke3TmDfbVUVXRUfE+3Gb63TH1wLc6l0tgofBLIoZJB/ektVc7dmyhCbYrdW/FwSbgOz5Q50c8qYkG3eMIrHySP3JQ8pRSe4SrMCVxdYFwnQ4RwST/da3/KDLyJenns8KUBG5jhK96wNM8R01Um3naw3J0oMD1FWDNYLhGGIrlXXGjdhw1WZVmjBcwOjxxVpuXLibka+HOqlApBGUzGJgkWuHt3F86VdgmVxIMIhIXU7TfJlz46FJNE1c3CNQqHUFCN0nzV0Ud90r1+wg1zTR3Z+rsARn+8UBE1tDTSNeuHZsTDSAQecB8WFJdE3DsxzkPj5U2PIkpa/drmsuTTxr/ueUx+aRfDI5Nqq/SUsQYFX7t5YJNtWnqcwKomAmnfGbh39SPOljXeNDbFzdAkwnbvjwGcW4XS6/u7sqDe3WHQdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(4326008)(26005)(2906002)(186003)(8936002)(81166007)(6666004)(7696005)(36756003)(426003)(356005)(508600001)(83380400001)(70586007)(5660300002)(36860700001)(70206006)(86362001)(47076005)(6916009)(336012)(82310400004)(2616005)(1076003)(16526019)(8676002)(316002)(40460700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 02:40:23.0584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b64351-a8b9-4d3d-8827-08d9b3aac21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
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

This change revert previous commit
7079e7d5c6bf: drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
cd547b93c62a: drm/amdgpu: move kfd post_reset out of reset_sriov function

Some register access(GRBM_GFX_CNTL) only be allowed on full access
mode. Move kfd_pre_reset and  kfd_post_reset back inside reset_sriov
function.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1989f9e9379e..3c5afa45173c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4285,6 +4285,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 {
 	int r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -4312,6 +4314,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 	r = amdgpu_ib_ring_tests(adev);
+	amdgpu_amdkfd_post_reset(adev);
 
 error:
 	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
@@ -5026,7 +5029,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		amdgpu_amdkfd_pre_reset(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev))
+			amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
@@ -5144,9 +5148,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* unlock kfd */
-		if (!need_emergency_restart)
-	                amdgpu_amdkfd_post_reset(tmp_adev);
+		/* unlock kfd: SRIOV would do it separately */
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
+			amdgpu_amdkfd_post_reset(tmp_adev);
 
 		/* kfd_post_reset will do nothing if kfd device is not initialized,
 		 * need to bring up kfd here if it's not be initialized before
-- 
2.17.1

