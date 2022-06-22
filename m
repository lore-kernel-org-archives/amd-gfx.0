Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25C3C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 06:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 224931134BE;
	Wed, 22 Jun 2022 06:46:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32BD1134BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 06:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld4j0b8ny0Lbi9aVC2JObb6Mq/3Bto/FbxEfhf4lCa0B4b+du+gw6Ct7WzbhZ2rRKTgoUgYzE90nsGQqc8MRLx5Akf1wmpcNat/fGsjQXZNaK9mtJ+FC+zwEMhLk/u7ua9x8WAxKE1AVU0h6iP1IltA4RGkNyi1cPRoe7JB165Tz+YM/0cZYHPSglH7ib2WxeQctIfXdpVNfk37CGCRxdvz5AB9VC7/37q+22b4TJMRGsBupkamm+tz9Y2wwbJhAGdqVIw9TAcVLCTqlbvO4DoiX9HSmIbFLXMoWZvjRNrjbU6nkevojwzH1k/pt4rH4zy/Rv5bcZ9fSy4BH1hdvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYhzLn2o7RL4WyRwXDKTH/WeOkzfHmO9hl80D49cqnw=;
 b=GB5r/TU367Sljm0LUZJfrHLimef1+sKixN+BmFi0i0ObnZ+PLxsVQuq/nGIhAzlmc315T+BdT1BlfhIbAhIuIXI0M4dBOV68nv+VdVnUZTvqytD52772D3Vl1bJ55kiZPaLvqstbDH3TGWGeQykrpGQ9xRrI8jgA4X5wsn3dDPdiilF4wPeaSPYFdUruFaEgxJgW+Z6Cmcccfd09hXqrA2PwdPQ6ST7lMHsbsM1Dole2n5nmzzyDiz2I4jMcL6kncXyoyRSUbypykWV2TCoxiAbP8JLFHz7Xd83mI6z6c4byONMoZ1B0Kq5617EB4+9eB3wHCxLk0ABVP8ZYrkXetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYhzLn2o7RL4WyRwXDKTH/WeOkzfHmO9hl80D49cqnw=;
 b=k6WLoXRT25XBCRCLBSPUZJVedFutAUC2wt0iqhyOjIe0mPHeWasXHqxgcEKi7TNOBxdhoWgSYDfKyjKdZG4HpjTBPDA3l9fsKxb5FbxevcguRkxx2/BMlNbnmR5/OQ1HnCMTC3O6t7oW7n30tDnkycbUgE/dZM3TCYTT9bGTpsk=
Received: from DM6PR02CA0159.namprd02.prod.outlook.com (2603:10b6:5:332::26)
 by MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Wed, 22 Jun
 2022 06:46:27 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::f8) by DM6PR02CA0159.outlook.office365.com
 (2603:10b6:5:332::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19 via Frontend
 Transport; Wed, 22 Jun 2022 06:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 06:46:27 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 01:46:24 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] mdkfd: To flush tlb for MMHUB of GFX9 series
Date: Wed, 22 Jun 2022 14:45:53 +0800
Message-ID: <20220622064553.526856-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 355f881d-4d43-453e-0b74-08da541aee61
X-MS-TrafficTypeDiagnostic: MN2PR12MB3455:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3455039AAD96BC98E217D2EA9BB29@MN2PR12MB3455.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NePWB/yDooDBDDkMKGHBxisE2UeOUIEuKPtuCjnhkyzA+cKKU0Djp02ADFj4lnoV0nSAJfSg2dYHzYgEvlDVmA2fi78NjlQ4fG3nxCLVfvs2+nWqYPPmFHbdE6gJdG8iFUI+RTebDwoHmXoxnIDPOGisPsgrpJa1YGPH4F2IvI6s7qfCoNI+SRZJzxzzT5CIoxUdJVhCEQklB5RzRzKAw/QVIQBxhcrsKeLBiEdJHgDw2Otu6BxTV/4RfEopaOlZnv9VBN/4NrBQmUYaKZXaqria8pRZGxfq3z8PSk1o54/sOvRU+q++uG3VUj8acCVpt17TrMQ09eA8l41PJ7kdAmZ7nOZm2rmFwNPS5msqtKTewDrnQNyZTCtZ0hw9j+lLMMQw+LgXqzSQMc9+CkYaoTeTshWmzH4X6kd2vPxaSxjjPxozIT1K/6bbP24dg/Z53WGBerV0HI6sRJelBxvwsNL2TAZUSKOUvxQdPWCWoVHUQ+sv33HEfHe/D9Nv4tLtjH7aVaaQdsFcfQx1jMVJDErQyig87PvL14/NnnE79Cx5EXNCIH6H5Hkr2Lqw4AfV3SSG/QRzA62Oy/YEP4nNEiGy5Mc0/MuaNhE2IhUZ80wKmpBjpvcK6kZjUq/+EjUqVHImw2g+DXmcmJUtkNGwDeYMxHW3WF1mmPe+nskHfk6ZxsKEjymJdnFWfrg2fZXc7vwvRFR8oCaV9cuBOW9tzhA1iB3LGDc1zXqHUevIZVYTjiMVk6Tb8YdKiTEnswiDtYDnQkXFlvKRLUSNCXCeK4YEdp3qEqVJcRJ0nuDuJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(26005)(41300700001)(47076005)(5660300002)(7696005)(6666004)(83380400001)(336012)(426003)(2906002)(2616005)(1076003)(16526019)(186003)(36860700001)(4326008)(70586007)(70206006)(36756003)(86362001)(40460700003)(40480700001)(316002)(356005)(82310400005)(82740400003)(6916009)(54906003)(81166007)(8676002)(478600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:46:27.0473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355f881d-4d43-453e-0b74-08da541aee61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <philip.yang@amd.com>,
 Ruili Ji <ruiliji2@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769, for process test_basic pid 3305 thread test_basic pid 3305)
amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x12 (VMC)
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
amdgpu: MORE_FAULTS: 0x1
amdgpu: WALKER_ERROR: 0x0
amdgpu: PERMISSION_FAULTS: 0x5
amdgpu: MAPPING_ERROR: 0x0
amdgpu: RW: 0x1

When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0.
There is page fault from MMHUB0.

v2:fix indentation

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d0c9762ebfb..1dfd82d5d379 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	bool all_hub = false;
 
-	if (adev->family == AMDGPU_FAMILY_AI)
+	if (adev->family == AMDGPU_FAMILY_AI ||
+                 adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
-- 
2.25.1

