Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46067C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 11:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAF3510E8E7;
	Wed,  5 Apr 2023 11:29:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5184F10E8E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 11:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EklnPwegPFXmNS6USKA5tBdSB74uVFAZrz0ACdfTrrXcew4FwK17DDlygC6wOCSfNQZVStD0r5vvUAxDU8S1rIVqSqzqZISr6UhA/E8Zm/DrVJUvFnsYZKBrQjEkw3YUs51cY9G6o3IlXLq0NV+kZh837okRQ9KNFo/376PiiN83i8l/U3sjnfa9S9NM+TFtMuwzw8ExOG3uYVyVByuy67SrG0IfB4l8qi3721IbqlG8oGZd/g2ZueAyuUhWVy7LCw2esmVO+J97DvXZHh/jO918ir5Ud7wUQO+EXqIEdlpsg3wXVbDJnuoZnUpc2jOdAVqXUysvnyocBB9gpp0aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA/QNjcR5ZTkUN15m6t5ZkE7dpugd39frRKJqiwrRZM=;
 b=YGWVDQk5nGIfd5K2Qhr/mGj2IcnvnxzyQeNA2jSGbpEWF6inDZhvQweVpeLB4JFLvJZ9MbnIQ/eNq8aPFG2USY3xN9jRXKosJNSdoO+HPTnVEzr+U5ieOVXVbcpPs2NxtrLkyJT1Bln2pxNLaGOJf173iASx4VsCvoHY9seA6AZD4mwqH09CPiZ2GUiCRF0EEzUWq3Qdt6tD9dILmcHP0XgCw9htM+vvxHUdMls6PSCNY+xyxQD4sK95+gF3IRSTKCoEFRBfusfF/YXsjRmEvyNwig2q0XTW57kzbsIgo/F3F37uElmmtqVSuJ7Ke7cLunwbnLxXlunt/gJ675JVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA/QNjcR5ZTkUN15m6t5ZkE7dpugd39frRKJqiwrRZM=;
 b=0Ckg84pPKt0YrDVkT/WvPyF3j4zpqhSD0cm9K9Jreg862N6oEwrKg4bHGkOYlxyXl6VQBXGXqkUo64zAs1L4DIclpLbhr2NaGqRXDX1eLxKHZS/mBxSuQno2L0cI1AwoE34Icp3hZgmgj2wBg/TgPj/XFnwTkSdtM+xIgo0hgG4=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 11:29:50 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::c7) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Wed, 5 Apr 2023 11:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Wed, 5 Apr 2023 11:29:49 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 06:29:47 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: skip kfd-iommu suspend/resume for S0ix
Date: Wed, 5 Apr 2023 19:29:21 +0800
Message-ID: <20230405112921.3690452-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|DM6PR12MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ce7d30-1b76-4a57-b370-08db35c91145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvFNz9PvRdpwVPQ/Vx66FNNpYvaldyFtpNAEDXg+rjkehWaJbATcz4dDQlPseoHQTsCb16AvgjbhUgOvia2YKXblwxy7ZX9hf1JHKuzxRxnKQVUyg2XuykUw16qTlHGEX5CvpkU5YAawUvRaS1Z+nYtDOxm+n/jHviqq9j7sLTxLxB4rFh3auZ+TD08bNPxnyBgNHq7PsB2m8jZE2Pa9+7DWnkEUiZCLJmRzib1lAseTRQ8TBZI1QuKy6nXQO05snxEVSl03E2Qx7jOJ86b/TX0XvoV0PZMfZx/7EMAc6etfQVXWnT0FiX6IpKjFsJHoAgMfrliWsri+2tdBdS495cbSASBWuuB2wTWLlX2/u9xvafYpHsU/9fyrGSTdA6M7FZYFv4Y0ikJqJJhEURTpHLk8l7YsGj7sjw3UgxpNb9NGJhikfdbagxjzIISY5KO4+DCiMgcOHf3tONBraETsVW4RvShui5h9rB4lOpbokvFh30hqDwjLtVEqHRnMUMxdAzkdnih1+ANNMXPZaJjYFhGxbRJ6q1MAIdwjxXbPHNrveUfpKmAdCX3SXiYO9qWYfvYhrWSprOmhmlZXjihJK8ayq8QdaMxu5z2Oi/KBK2k3BQPCUrDKFq4jIDIBAZEriiJTmbNwkop3Zh/alJnHGQOBbiDWffSVMn3qlIbSYlUqwgqTG1bCV1Wudo57mMZxJyUr3Yp8Rw5wLcHdOagyx/cAJTtltbwVmhDx60fSC4524j2wRgBN8vCqpHHbKQit
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(4744005)(40480700001)(7696005)(5660300002)(426003)(82740400003)(83380400001)(336012)(70206006)(70586007)(8676002)(4326008)(6916009)(47076005)(2616005)(356005)(44832011)(81166007)(8936002)(41300700001)(2906002)(478600001)(36860700001)(86362001)(40460700003)(54906003)(316002)(186003)(36756003)(16526019)(82310400005)(6666004)(1076003)(26005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:29:49.6130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ce7d30-1b76-4a57-b370-08db35c91145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com, prike.liang@amd.com,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX is in gfxoff mode during s0ix so we shouldn't need to
actually execute kfd_iommu_suspend/kfd_iommu_resume operation.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3b6b85d9e0be..5094be94fa06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3304,9 +3304,11 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 {
 	int r;
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		return r;
+	if (!adev->in_s0ix) {
+		r = amdgpu_amdkfd_resume_iommu(adev);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_device_ip_resume_phase1(adev);
 	if (r)
-- 
2.39.0

