Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3096EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 06:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC6110E04E;
	Thu, 17 Nov 2022 06:08:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1F910E53B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 06:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed9FhD36nS2+tgq44tpmP4e6dlCz4hAwFo5SK1oUGimyLDpTacnF+SyUtbnVxlmKJiQZsAQTfNHsUiE9lT7tAgVoXYHZB/6Fpqtyh+OSW+2Sg31tLBx0U99z4NXOm/R0+OJu45Jpa4gSpBaJPFpiu3PVWWcoC4bEFwpRsOO1cwX4t+pPLLejAUeH028Rl8F7lwN+WM11Zf8U3rDYzaYht1rbUPaUL63LmVjOQG20EexHakwgUV0rbpbVvt5srMih/z3pacEr0ZINVBeAwKXscRdGSeLmwQEKk9oKu1M8suO+u3t2wsPugNpicDAwFGRoFVDOQIaiPENVQ3ySPmIcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVj7Dn0+MDAmhBPM7mEfQB9YAIP9RYkFgaxNedmLERY=;
 b=LM7OMIl1GQMwWcUT2qUYc+lEAsSefv6DcOeynDdch9rVYAMQOjR09qo5Hh0qQlgO3c9gEupJGxrpU86jU7B994qpA7UBUfg7CVrcAVlvf3Ng5904vf0UFRdYxFzY15bRA2BHclnIof5BbSGBovJY5afLGW441037abQUaFRRnWDGva0docTAK01ssdGWQh5I4BmzLZ6czMUu3ZfjSND93uMgDDJv45X/jN/kpLoNXixscXO9PKLc3KJheFofOmVyecHQxGnWgXxMmlWywYZeVTuPoo7ZZ8E4HJDNr5HFED5VvEEorqyFbEv2m/tV+3Be8cP8xith0fidxhyiKiYcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVj7Dn0+MDAmhBPM7mEfQB9YAIP9RYkFgaxNedmLERY=;
 b=miKIwW9eHpli25ozr0s3uFyrREpLvpF9e7RKTZ9BjCQdYmlRREcWdimiE9c5dCItNIEWrLjnRo1iWFjfV7xxQ8YUKk9x2LSQ2F70G5rqwrZgt6uPk+fG9Y3pu/Rw1K8q2Y9QPAVZ0FDEnFQxes7zZ7JmLAG5jwuaLhJD8CcxdYQ=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 06:08:47 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::94) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 06:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 06:08:46 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 00:08:44 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: define common vcn_set_ras_funcs
Date: Thu, 17 Nov 2022 14:07:49 +0800
Message-ID: <20221117060755.13655-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117060755.13655-1-tao.zhou1@amd.com>
References: <20221117060755.13655-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: ba95462a-f5a6-4312-aec1-08dac862305a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ITbphpQIkrzsrQ14gccyIdK1eJTPSDV0am46yYcICjAj1ac6v9lFG3w1FfYKQJHRDcNKpmD+C2KBC5CwMBlkEjuM8nJNUmP9sjyQZvBVt37kNwwr7oq86PfE+S/Os/UgJ7pNVN7EIIybXNwQH06t5J2O3jk5wvyKRpOSasR4M6t+1d/iKEHJFbyhEtKgz0EgKH5s2TDkgPn6dqWtU1vnXf5lL/0C52FBsVvy0sqbLg7Azif3Iq3oy1W/Mv5yMdxW/1ZfGr0LgpnzhDg5O83fc1jvmjI9qht865p0XlmXmLfhg0SwnqTDufO4SUEPyynxN0M/VgAWY7tuggPqNil4HE1C6oNY1HfxfQvZ0OTalOZpq8eiNQmzC/IkwjX8afd7nj3ZxeJ3dCBhoQyo4n9m85DKYbmGHKqV6Pd5MBZxY/hmUN/T2T7eciaQxhvYG7ZjuybAHGmxhgR0YUYRN/d2FlZnHASSDTLFBcqmtrFPE2FXZ+CH6S821Tw3EZ4svlQyq9werQXX4M4lkP1B+F82ZPnInaz+2fFKL2DS38hVy23iGzlyZg4Tq0756ksRq05bYoQ9rlLAu9J7n6iuGzrZfGMrVJYW2wa4QwF/VsIDO2MhWtJby1Vk8jLDiC0hUKuvYtlUFY81kb0kZjVAz7ptSqLIJIssyUpd5ieJknZ4VO/Y8kRgrD6X/Je8H1OGNU9cKlJD1zC+hfVN9luX0jbRgNagaCStYMn/G/V9EdrRvY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(40480700001)(36756003)(8936002)(81166007)(36860700001)(82740400003)(5660300002)(356005)(86362001)(83380400001)(336012)(40460700003)(426003)(47076005)(186003)(316002)(7696005)(26005)(6636002)(2906002)(54906003)(1076003)(110136005)(2616005)(70586007)(16526019)(70206006)(41300700001)(4326008)(8676002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 06:08:46.9477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba95462a-f5a6-4312-aec1-08dac862305a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So the code can be reused.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 +------------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 0b52af415b28..c448c1bdf84d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1248,3 +1248,20 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev)
+{
+	if (!adev->vcn.ras)
+		return;
+
+	amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+
+	strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
+	adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
+	adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
+	adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
+
+	/* If don't define special ras_late_init function, use default ras_late_init */
+	if (!adev->vcn.ras->ras_block.ras_late_init)
+		adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 253ea6b159df..dbb8d68a30c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -399,5 +399,6 @@ void amdgpu_debugfs_vcn_fwlog_init(struct amdgpu_device *adev,
 int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
 			struct amdgpu_irq_src *source,
 			struct amdgpu_iv_entry *entry);
+void amdgpu_vcn_set_ras_funcs(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8a7006d62a87..ce8374ee824d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -2002,16 +2002,5 @@ static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (adev->vcn.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
-
-		strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
-		adev->vcn.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__VCN;
-		adev->vcn.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__POISON;
-		adev->vcn.ras_if = &adev->vcn.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_init */
-		if (!adev->vcn.ras->ras_block.ras_late_init)
-			adev->vcn.ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
-	}
+	amdgpu_vcn_set_ras_funcs(adev);
 }
-- 
2.35.1

