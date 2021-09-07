Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50224C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17654610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17654610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AB76E04E;
	Tue,  7 Sep 2021 16:07:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309AE6E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 16:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlzPveiHXFsoCB+q/DfG+4X2CnFaK0nRX09rlaOGHMVTMgrseN1RJGb5UfI7rRXADPzK5tozC/WuUsNtCGIeJgKEUbjFnaHM84lK250xDqGuXAcTbZ1niafHlykcREXDcdS7ZsXJ5lw/PcsG10O9+TeEkF2/IkQgkHAkquRlhiizUEgV705GaceacV06/mkHXjhZ3mCl0igryckEeyppak1pfjUmSWoOMxKw3xx1AllsuzZPWthNqq9DZmWIq/o0lrLvye1PItBytqC7fDo6bGLpSrYebgXPb8jZGRdboE0jKyzCGYd+roTnzqSnEYxi4cjZiMaUr6t2nHVXOZBNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=RMGf0yEoEgaJcrBPrXln7KSyEvVRvEF5ya59IZDfKSg=;
 b=Rp7K/hTkhNCkgk+e6BYYW2/s12rMGo7OAj5wax59pa6HOis7f9sm/rQLijakyvdBu3x9R80ZPjxg+OFZCAuNzoqOaAEhaE8B0Mj8biaxjsvNkzVVrl6DTW4/oMJVXKdF/M+SCenIu3hc3uHVZ+12wQyYBk7T/E+IF8ZawOcogF1huAvohdMcigFjqRR26451LqRtuyhD1P9VWDPRUHAUCn6sBTXmNWv8VozYZqrh2bbH8IUvvh1zB1Mkb35aoC2wrkw4b0Uo/gbPJeN0PcA1JcTOXja3mgbIaKTe12yOsE9kg6AoZ5qfwo4PROf/0wU2gBZ6K8Y7u5YSWqlAzmb7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMGf0yEoEgaJcrBPrXln7KSyEvVRvEF5ya59IZDfKSg=;
 b=zEDs/MmfpX89OMp+iKxd3FISPESgwZ8QJEp684lWOQ/aKP6e/OEgCru4Y7ZJoF1v8qdPUR4ppvczzJHghrW+Rt4cgq0KYxbo3cMZ1wiIR8SeQPqquMB78OJa/HhVMw2AqvY8Chntwjr4zWgNUbROf5C1XvTE7YajeKG5ag24r0c=
Received: from MWHPR22CA0020.namprd22.prod.outlook.com (2603:10b6:300:ef::30)
 by CY4PR12MB1909.namprd12.prod.outlook.com (2603:10b6:903:124::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Tue, 7 Sep
 2021 16:07:36 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::51) by MWHPR22CA0020.outlook.office365.com
 (2603:10b6:300:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Tue, 7 Sep 2021 16:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 16:07:36 +0000
Received: from work_495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 11:07:33 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jamesz@amd.com>, <kolAflash@kolahilft.de>, <me@jeromec.com>,
 <alexdeucher@gmail.com>, <ted437@gmail.com>
Subject: [PATCH 2/3] drm/amdgpu: add amdgpu_amdkfd_resume_iommu
Date: Tue, 7 Sep 2021 12:07:22 -0400
Message-ID: <1631030843-18270-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c709c12-54b5-4e9f-3644-08d972199bc3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-Microsoft-Antispam-PRVS: <CY4PR12MB19098700B04341DB6B797F34E4D39@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsYwpB2p9//ZA8wtGlgIpdBm2ng76pMX4kVGmhnKgwlDl+gHTIIbDL6c2Nx8PDZ0lNFBRWitIK7yKXNsu8VrEg/jSEcJmdBvqfQvrukLEmClvHIp9MEzOzZlMQoiUdJY+BufsG3VhufJpxKljBvcjS/mL0GGHvee5d7gO6LOXYQK0QCKadANioXe6s1826lvQPX6frKqGvCTTkvYRaUbm15Jj40hAKwvA5qHdoU+KXUMNN1AP27xvpOlkVTPhWmO+x4vCJ1ier/v3pGTwPXSArih14uREJ4WqJZ1z5j0GysvL3X8nreoo4nRW1XCI01o/NBjCHueXu9PJdu66UAV3ajj2NwNFOW5zd4ohO8Mkt2fYhhTFHBGrbwgh9+b811eJ2UaxNkFe5HMk8bkWemv2RcurcYLTYglI2taQ/5IS8cV1M0x//KnPJLx1S0F8/Y3ztD6UFb+dihIsxV6iUXCe42e7cVSVhfjByF7d7/HC31iGQKRdKXtfo3cd9/7hc3v4vEegM/BZO7BjDdSi6nf9IbQONC+xgRultBOBgnytpeyqHIzfIq0W++vhvMWyefV9NY6Wko+vXGIyup4KK3UomMhjRC7kUxuxm1N5JDb+GD2vmCP0PjgYCChPVYcKECueKfpDLQw7AXs+Y+AC2lZJ60r/VJxMQcxnKFdl3uWiKeSKWhg/vPAmwWgJW8BIW0pUiq4yI3V5VOeBTmi1mNd9y/IwYl3mBTmaTyU0UhA5iU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(336012)(36860700001)(4326008)(47076005)(2616005)(54906003)(82740400003)(316002)(426003)(70206006)(82310400003)(70586007)(8936002)(356005)(6666004)(26005)(81166007)(8676002)(86362001)(5660300002)(6916009)(186003)(16526019)(36756003)(478600001)(7696005)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:07:36.1047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c709c12-54b5-4e9f-3644-08d972199bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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

Add amdgpu_amdkfd_resume_iommu for amdgpu.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 3003ee1..1d41c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -192,6 +192,16 @@ void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 		kgd2kfd_suspend(adev->kfd.dev, run_pm);
 }
 
+int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->kfd.dev)
+		r = kgd2kfd_resume_iommu(adev->kfd.dev);
+
+	return r;
+}
+
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fd9e60e..b40ed39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -137,6 +137,7 @@ int amdgpu_amdkfd_init(void);
 void amdgpu_amdkfd_fini(void);
 
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
+int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
 void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 			const void *ih_ring_entry);
-- 
2.7.4

