Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821F8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8989F10EAF6;
	Fri, 11 Feb 2022 18:59:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 368B310EAF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCAqvX2QJWaPtnxeTaXKVzxKmLTLhPW7rAQn2DSjh10hbarMzurKX5TVXjWiGstmm/AfCt7ExobBh0mxMb4IeHJDlN7spiqZp4B7a9pACk87GbX4AKbqf2XSl9kK/HPJuZkiN0+kuotAn8WbxXsWJmo8q+tXetzSaoJl3OgifDfQi4Xx+zCKBx80CvpZqMyqocKCN7AVMPwwxKm3Agx5zx/cCtmghN4ckk8F2ERZFCXkxwy1V23rvtTSxcHjQZdHKRnoeOl10GtgJDq+j4p5Xvs1/QuDWMa1gdUuWZeBDulUeQDKEl/UXNCtTDj2NoTvPnYxODBP9ilYjq1YXCCcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2K8MzK0mgnGiUUWWqpT0aPYY9ePvpWYS186HJE1gOg=;
 b=bgGy0fGRlrgzV/LiWHvcsUndkKHTBzQsH2hWk/8UwO9dsohI8PvaCQWDzP8s2jKATJnI1dScmmESByn5YuPkDpTDqUXolRBLpN2J9dMwbtjzgLn+G4T/lG6jjaAZKRiRFB8Do2G4IHEdzVYwbWRNCIHa0MwHXuMi7KNvqJMjTvVe5fsWz+zxK2pANjrBixin2PL8VHfmHYlKH4eIQ4VMnbgS6MnxZbpk22pg8QIv4t1qNanVqTEbmkuAMNH7V4mRuwqD9nqc5O6t8mVc0zH55gn6IhpkjX27xcAFHtVau6HNzg/X3g3Hd1Hv5VeY6V8MYa9h+pdr9LXel4sWfPm0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2K8MzK0mgnGiUUWWqpT0aPYY9ePvpWYS186HJE1gOg=;
 b=mXFT0YE+Ux4jKj/GsEhBfThoRGsyQSpU5CQU7N0YO6VVOIPXiTkEwtC7aUPeOzDbEcXaK7E7ZxESbovHyMCCrTid/2nD/RWbFliwfR9zpngt/K17rkbH/TCD+N7jYZLls660VasERzVX49RJEbKu8/Tpn8+cjEf4Mulr+vOEU5o=
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by BN8PR12MB2868.namprd12.prod.outlook.com (2603:10b6:408:9c::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 18:59:43 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::bf) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Fri, 11 Feb 2022 18:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 18:59:42 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 12:59:38 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Fix a kerneldoc warning
Date: Fri, 11 Feb 2022 13:59:25 -0500
Message-ID: <20220211185925.4178-5-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
References: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 974fd40a-3dd6-44e6-5d56-08d9ed90a9c8
X-MS-TrafficTypeDiagnostic: BN8PR12MB2868:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2868BE3D9858B5BD8670E980FE309@BN8PR12MB2868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFf9TombfZ8taImmFg6VEeQ7muw+A4hViGLiQqV0q9OIA8Q2DFddB/F4C34g3GfIsV9NLoS/d4moM4u+vrmZi4WvHhkNsqm7e8k3LKhjSP2c55zjRJdykdjNL+rPPmYTa1XuUzYtx/K0OR4IZfaM/bbC81tmkV/41/4wu+DvxhHVTy59QV/YV0g9bdxzfOK9KtjHVQNO7BQUQN+OyOr43cpqWwBQALWrse0GL4Kms/TLicuzIKBpSbyWJR2+ED1V2Flg7RL1i/FEtj616eOB5rCf0e8KusLD7hgaw6fUMJv5sLMW8Ph8e52g2o9LpD0TbSq1y14gvD7iJ39TeypaXp3JwAxJ4y2alWb3Dk8g9rbb4E0F2SyYZcghJYZjAhWFgx7n7T1oOJzDULfH8NNL6hKv8mSZ8DA3mzjiEIgA09VAepUIkAAhO337PrlFO6H5lUs8YihlgzSZkxCYVE0LckiAv8HdpQwd5eW4ivyaOx4IJS5Ypo0tPf2JJHm1wNiMzaLyodI2ZUVootiLDwVJt1pDo+u3E/rZt7q6Yq/3V3QWfH+Mbf2xfBGm0BSXSK6eijm2LIIVQuGjJiEKyWBkPN0pE+fVgRW3+hbnscsDJIcyjHv51twIbIEHwzr6LfbNEN3vJwaSJsZaoVM8lmfCKjwtavBurWjqy1FzZcIWAbQYdH+4Z9GTn6itcO5FIYCGPMRqAdwgNPIFR2eW9q/XMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(81166007)(44832011)(356005)(508600001)(86362001)(2616005)(6666004)(8936002)(16526019)(186003)(26005)(82310400004)(7696005)(1076003)(4744005)(2906002)(36860700001)(316002)(83380400001)(8676002)(47076005)(54906003)(36756003)(40460700003)(6916009)(426003)(336012)(4326008)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:42.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 974fd40a-3dd6-44e6-5d56-08d9ed90a9c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2868
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add missing parameters to fix a kerneldoc warning

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7931132ce6e3..a74a1b74a172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -554,7 +554,11 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 /**
  * amdgpu_mm_wreg_mmio_rlc -  write register either with direct/indirect mmio or with RLC path if in range
  *
- * this function is invoked only the debugfs register access
+ * @adev: amdgpu_device pointer
+ * @reg: mmio/rlc register
+ * @v: value to write
+ *
+ * this function is invoked only for the debugfs register access
  */
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 			     uint32_t reg, uint32_t v)
-- 
2.17.1

