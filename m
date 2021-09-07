Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E96C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5466D610E9
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5466D610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E467D6E04B;
	Tue,  7 Sep 2021 16:07:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419236E04B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 16:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtnEWc4DolNJYMVjNq8hUUqyGxciS2heFElgbzCnjAeRdYXc0UR5kT/0acUZQ+1uBgf3BFwKIGYsEvryenu+OGmw6MA15yAew91xQI09d0btd84722aDCeYO0hhqu5bBfZvFaR3eaVsCJ1lnM1qAIFz0X1Ux5vf9PSTJggxNvUryQBImjK+bP9K9mYx2jihZ/Bq1811V+k3EI2vz9fIkS5tuMly6ybmcvXwyycetFz+FhXNgdonZJ5UOtAvBe3GdIQERZQ1zOb5MuuQFRD3rg0Lt4eTwjqgF3rEhUZSUPO7yn2gDzu8vy7E6+xW0sOmMIQx3jKP1/u6Z3caMr5qgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Pg+GAkzOEoroYISFnWOGtXv4Q0mGDYmlfGkIc41HZtc=;
 b=lHnQTvcuJvo9SSxKNrrT9Nls2s/3Wlc0y8o+utECmZ1NN3BMca5dYTAskyVTboqgdob1Oua8F1+lMM7+hJMfvlDo/pyX9rPbKNT+JQdykLdhhMAm2paoYa4E80mdQoD6muTcz8yhX4EBimQcTlNSX79MWxW+QF6KIypL0uC8v3SEOGU0p0v7JC/ak164NpIpVIsr24eSytFgvmBTSr8Fc3ECtp0N6xToY7Uwp9eo0grASw0N/d7OVTOqozxHIM2JLV6RVoAQT40EMtYW592YRZFbGvQtLAAylGWvzFSzd1ITvK1EckkG0PUgZOcXijNiOfAgGEPGHqV5PF67GAa6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg+GAkzOEoroYISFnWOGtXv4Q0mGDYmlfGkIc41HZtc=;
 b=PXRlaI/MQBv0GbbRapd5XoO+o376zyiT6FyKkEdxzDJ36BFcHXDSuWkjNBm2uCDoR4ZiNlOGqCdsenQ1/DknHICaMONfFhxGGPGC71ZOAOcEq9icdkai2GtyJABAbSb/Emh645WbV/Ga8ewtyDsdNSG4+BnIO9bevAwvKQ5vmRo=
Received: from MWHPR22CA0004.namprd22.prod.outlook.com (2603:10b6:300:ef::14)
 by DM6PR12MB3660.namprd12.prod.outlook.com (2603:10b6:5:1c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 16:07:34 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::9) by MWHPR22CA0004.outlook.office365.com
 (2603:10b6:300:ef::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Tue, 7 Sep 2021 16:07:34 +0000
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
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 16:07:33 +0000
Received: from work_495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 11:07:32 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jamesz@amd.com>, <kolAflash@kolahilft.de>, <me@jeromec.com>,
 <alexdeucher@gmail.com>, <ted437@gmail.com>
Subject: [PATCH 1/3] drm/amdkfd: separate kfd_iommu_resume from kfd_resume
Date: Tue, 7 Sep 2021 12:07:21 -0400
Message-ID: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdc5ce88-8a74-4806-d6ff-08d972199a7e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3660:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3660B91C2E363711CF0A18E8E4D39@DM6PR12MB3660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jzh8Adq65u0VS4eTsaHUWF4ib/Xfkj5NAw8PKlaXaKf8hUtCcyTcLYNSvhIeZIKj2S45fL/V///LpIC6CIjLPdeVpKYiSVbxX1awBYjMNKnsLS6r54zhg53ztjaZLKIFZ3lwf0jrp+0r3JwfVCNkevTRgKFjhDC7198fg/dz6oAz7Zcl5Mp1OA29JtvHRRbx+HN7CcKjg0zD5gvNzW0F0R87ctoHmG7jV7Jw76ZLfZ+s5Z1v/sROqvaVbdKuJSjRgRqgXeVbruZboM72ZAZBaujNBTfKJ26Mx6j6Uj9k8/NqjMzpk0PSVvka8GOdoa2wFvjFHHPJVSBjHPo4d99vxOkyOeMwEf4ZvJ4AgfOK3SDg4DixdUNw9M7fkbONUgOty41rMMgBknKYjGP7Mb4jRb+k1X86AAFMoqqFNAtRtFysvhpNUQKRK+IKODMVd/yKVVFRZjOVUK6RNmE/m7qkeuI9YIljMnC3076TrbxnShB/3RzBXhN/mn7FsXI9eE7NiPEd/XVp7W2lXSHUU9C/ahTUyS8ZaIDED5whorfP4OOLu6l7Bvd/X26qaLshkqLBC3nW3T5Kx1gPh9n53D6OfbsqzQ9y5D2xDiWCsDk6migIw+1NP1gyHqQZHT5fCsv1U7K2fbeSRjlGpO5kgYk9MTsAGflDaKjcQ+bb20C6oSykwsetd8skE9b/VRrcbUqWNLBztJE4jwe8hKCOkz5plqFeGBjRcG7s2d9bp4dq90w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(36756003)(356005)(47076005)(4326008)(36860700001)(26005)(2906002)(6916009)(8676002)(81166007)(478600001)(8936002)(6666004)(83380400001)(16526019)(186003)(82740400003)(54906003)(5660300002)(336012)(426003)(316002)(70206006)(70586007)(82310400003)(7696005)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:07:33.9799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc5ce88-8a74-4806-d6ff-08d972199a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3660
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

Separate kfd_iommu_resume from kfd_resume for fine-tuning
of amdgpu device init/resume/reset/recovery sequence.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index ec028cf..fd9e60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -327,6 +327,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
+int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 16a57b7..f5d36c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1057,17 +1057,21 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	return ret;
 }
 
-static int kfd_resume(struct kfd_dev *kfd)
+int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
 {
 	int err = 0;
 
 	err = kfd_iommu_resume(kfd);
-	if (err) {
+	if (err)
 		dev_err(kfd_device,
 			"Failed to resume IOMMU for device %x:%x\n",
 			kfd->pdev->vendor, kfd->pdev->device);
-		return err;
-	}
+	return err;
+}
+
+static int kfd_resume(struct kfd_dev *kfd)
+{
+	int err = 0;
 
 	err = kfd->dqm->ops.start(kfd->dqm);
 	if (err) {
-- 
2.7.4

