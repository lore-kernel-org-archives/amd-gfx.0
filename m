Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C280C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 11:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CEC10E1A5;
	Fri, 10 Dec 2021 11:42:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D6710E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPsxJNSCOBD/XShkD+nszzG5l7rJriFtC2o1Q0t95PQzJNSalneOv9LBxYZeJQOJQ0DTKZeZY7pPCLdSTlTWjja1IHN64Qsl6w/PmrOHCQvxq++Pz2ysPiNUtDvte8t/nBErNOSvbW3nj102gH0or2Dtr8h+WdbZPLHKs1yggY3OVqMq1OGFlUYI0d1pQhAF/AnjPASVdM4wss9JEMpo7SpQ4X0RQzbgOgVIOdonWTxTIVbfctF3VL03q01C25f5hDD72054SRu+Xcmk60vItA6aYF6WokccDg7uFjlwxhFsLBQgTBN6H+v+uNp4JTtgiSCTafpHb4/U50iC/rUZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8QmHnJrSmTWOJpWcqb8UECdfH35ZgyQRUSDaCjjnO0=;
 b=QgOHjeveX6F2C5KGrxtNu3bfvGi+S93ROkytx+9mldu0g8cRrKO9qgZ5NgXB7wyy2cWW2Gat8ByFWelNQVGVLipHw3a0o85oqlpVutPKvSCJBu2itONhOsWy++CAa/2FWmLnru05F7AuWd+eyzLniMJuNzNEhTeGEv1XXWPNWvq98N8rLIHIPF4DCbxtmiybwPxwdVrSG1H4TeI7ce5ZRiPnf/NaVDRI1NOtC50afLQIahHPcuK4jxMsLBRQeu1mdozfzh/AsDSoyCYEaXRh5zPEdZnnuggShOZ7gqTU1iPEyeX9mUDUc3aXRCfNenitbccv9nHpZ2oo/uIp4/oVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8QmHnJrSmTWOJpWcqb8UECdfH35ZgyQRUSDaCjjnO0=;
 b=OUaH0/ry3kYUkjzNMqcwNpDvu0+UyMk1Dc2J1eefCYsxIDFv2OiHSd+Zq+bWZ2Qt/yumRgTL6y302BFojgcGoFZ67fApw54Z0mg/QyQlW1mzSr6t/8mNJ0yP2/I1QSz1Ggi5SVMYh7erHHiwLXdlgBNsnXVB3FSCdfKEAMbuwTo=
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 11:41:57 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::7b) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Fri, 10 Dec 2021 11:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:41:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 05:41:56 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Fri, 10 Dec 2021 05:41:55 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
Date: Fri, 10 Dec 2021 19:41:51 +0800
Message-ID: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac82c51-7237-4321-d678-08d9bbd21236
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2523221BAC85BEE2A29DE1149D719@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDNrW7V2ua6qR/ljAPwR/t672WW6KSlfo5oKdVSSItrRofBdoD1Ah68ioQ6jzAIpSnIlW3ivOgXaNyZN3j63ke+NreUeNA339ZLhpCGTZ1YTu+MKm/4PbcvwK4EvpUaiOTjdPF0A8D45lfpjBr157+ZrQ3Mkmy5KKu3eIWN0i8/vvqYUiiVMRxEOIJx3jwklljvfuWKwcqK3K3S5HGg14MjFIr5Ug97O3ga2EZ2POkRyx+vRIfMu3Ust+InEOuYtvhCqpfcVzVmPp/5CbeqmwPGxU6j6URtepWEyN6ubYca4ROvIiny5VZFYkOLj0wDH0nK8vCTZrtWtzMSAQO6Psyzq7fFNFd/HkXIN3SCYUxDjweyke6rXapCnpbSQ8xHRzCTLRS/an7EQyHuqSc9RDvS2a29JMnEZSq91PjJfS5hvXP3a3NZi2CVzxA9hw34xdP5jqnBdTwZ+4try3A6IF6JjovN8pgnfOeYmducP5cebRPqDxGL4P9WQdowoOgXOdycZcHBxZWSgWr9522+SrjgNUqygnHQNF/fJL17wkWLZe8y/uhZBLkcl2ybYGaipnMUShbHTLjfrg9mAGLDwjU6nbHrBXLBefn+JjuMdN+FwHP9Qvogjv3k5QLnDUqyGpkQlwkzL+ZoolJhpav8f2CXi82VEqMtRCgfC+7baRvHubDwlkQhmRqigcpAhQAXjb6tfvx5ox3nitQYI9GuYziXrGgMXG/Ux/xOtgXGNenmmn2W9pdYfT1mTi2GRpRUGI02Bf9pBmf4NiJefpiZxHI74kfgXgbRIi3ixmOY1pyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(4326008)(83380400001)(336012)(7696005)(316002)(6916009)(54906003)(70586007)(426003)(5660300002)(70206006)(2616005)(356005)(86362001)(8936002)(40460700001)(8676002)(47076005)(36860700001)(186003)(26005)(81166007)(36756003)(2906002)(82310400004)(508600001)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:41:57.2433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac82c51-7237-4321-d678-08d9bbd21236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
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
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, leo.liu@amd.com,
 evan.quan@amd.com, chen gong <curry.gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Play a video on the raven (or PCO, raven2) platform, and then do the S3
test. When resume, the following error will be reported:

amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
vcn_dec test failed (-110)
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
<vcn_v1_0> failed -110
amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110

[why]
When playing the video: The power state flag of the vcn block is set to
POWER_STATE_ON.

When doing suspend: There is no change to the power state flag of the
vcn block, it is still POWER_STATE_ON.

When doing resume: Need to open the power gate of the vcn block and set
the power state flag of the VCN block to POWER_STATE_ON.
But at this time, the power state flag of the vcn block is already
POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:
avoid duplicate powergate/ungate setting" patch will return the
amdgpu_dpm_set_powergating_by_smu function directly.
As a result, the gate of the power was not opened, causing the
subsequent ring test to fail.

[how]
In the suspend function of the vcn block, explicitly change the power
state flag of the vcn block to POWER_STATE_OFF.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index d54d720..d73676b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool cancel_success;
+
+	cancel_success = cancel_delayed_work_sync(&adev->vcn.idle_work);
+	if (cancel_success) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_uvd(adev, false);
+	}
 
 	r = vcn_v1_0_hw_fini(adev);
 	if (r)
-- 
2.7.4

