Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04188C432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 13:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B5161056
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 13:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2B5161056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8032E6E524;
	Thu,  2 Sep 2021 13:44:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3B36E524
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 13:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FErUf2QwmBUllV/BYnycZyqXk5DVUUEkOaRoLlG/cHJaU5+EiSvUbHUexPYyUWl1CRvFJgaWqo6aXirTKeqlh5XfD48FK0NfwexJkr/W1kOeAUgrf+ijzSN2UM4lW8I9ip1R9m0dd85LK2ld5xUvIsVddQCp5YFkAB7/k8OFRd7qQQIS6OvcGAr8ElDDoWOUAyyprbcIVk7IUBJ2CVsJExXUVpmNfzxwO1Zns70Wz7O7zLbzUxyyvFFxe6cYPg/S3cvMoyF7BDh6YI72IB2+/6fWknNV8ChI+YvoGlGRmcSoQiKkf+W3st1ETmvn7CqBwyFpq43Vu8OpgmfyqMFy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1DdZH+E0GvLEFURzRJ5xN2HpRIe6ZY9fGe7p0Xeq8S8=;
 b=ODF64UM4tHhNGCC11ixUAEIffwPMgMuJ28vt2P6gsNX106gaT6TVXjtqdws465bBwEe5PjigDHKTJAKGptSpEHgeW2OVkLlUjykAaSN5DtHTygXO1KPxwxL2NsfsTlRA1QLnQv9XkzoGNBnWU5KNIL7us1cMsRGvXWvJPhAEoWhCT2Q32Wf+X13a6mF/LbiiFteI6ax2jeTob9W7fMlKKpyGgGadd3sfc270OBdx0YXBBBBS5lJI5FXCVxzoBCgj2OkEUrFrNjYQgP/1ysTzB95rw+gSYRmMDL064lGqSRz+5HVTnFQITUK5+0UCyo2mOz9d68q2bkHZmJ/MuSALng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DdZH+E0GvLEFURzRJ5xN2HpRIe6ZY9fGe7p0Xeq8S8=;
 b=sEbgvMcQl0JIYWZl9EXIlE0RN2xV0xlYqP3UYdFW9qfNrEu4nPRX/TtSgf8r4F58AFyhA0dYg/e/ciqzOfWwFuiQLIy9IagQPQUb/EZ4amItRTwVuvN9Y1VstjC6Py9fjKaO7jNWZ7zqhnaRuDlIrRw3Oiqn6EymEQbd37IbZ/I=
Received: from DM5PR04CA0061.namprd04.prod.outlook.com (2603:10b6:3:ef::23) by
 BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 13:43:55 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ef:cafe::d8) by DM5PR04CA0061.outlook.office365.com
 (2603:10b6:3:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 13:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 13:43:54 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 2 Sep
 2021 08:43:53 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu:  use IS_ERR for debugfs APIs
Date: Thu, 2 Sep 2021 15:43:36 +0200
Message-ID: <20210902134337.3440-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95216de-d3cd-4c24-3743-08d96e17b502
X-MS-TrafficTypeDiagnostic: BN9PR12MB5382:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5382EEBEDE495EBDDA8E5A378BCE9@BN9PR12MB5382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rMEeiOxZqUd41QPLneo6/mEBUaeZwcPRsJXd79kWkGj6b1tO//rbNwizuvjfLmRYRdRxALvd9/9OGqw4PiZTa+oZj2LpSTNSCMwRugQHHoyjV9WQOUYlUx10To+aG5LGNsMUOlf3PhkNY96JmwZ3VcJ3dsnEvv3o6UaksG0k0VavA2cYO2R4nfV5JGLZj+7ZCoK/qcfCKxdfc3UZjsghNDEocmC646aft0zwAgDVXiofM5QwWpqxGxyMXjruaRIw/MsBgdBSCVc/z1gJOh1xyNXnCp70dhz5SiboLz8ray2PaovNZkPFkyt6fH9zJ0aYgpmCXYfscPdF093zPVMArGQgyJLv29HQ7FUzMsSzPM0f4uTDpkBAyKf2aEeP/yQpedQZT2CEw8xh+vmm0M8KP7Q1ucTFUpkDjhO0W+CgQoCJzhbU88m1Fc/7Wj+EDztRjAUeMB4nSIl5odOXEurKSjtQSyBlklbjNK8dLMfb/r6fziI7BKaqXbMOLVua3aE+jeokHKnkWgyWQ43FkNcc/baAe6JDgIw4TRbwm5VzfVyJrJS6vwtrhGe/UDOk6e+8NX3D+YnAHFVQCOqUXPqmbfd6ybM5iOte0mdpreZcsJwpNUuTI+mPSENZJl9NiOxCs1hoZMqYcmLi6fdJWCEaEZS1PE1uUxYUBKr2o8QjXUNXgcf4oPRTfqz6461jEl5M4cU8SXRPlPfcQMYTjdqdTQWNTv342EX7nRBFyQnaVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(86362001)(36860700001)(36756003)(2616005)(7696005)(70586007)(5660300002)(4326008)(54906003)(316002)(186003)(26005)(70206006)(16526019)(6666004)(336012)(47076005)(478600001)(426003)(44832011)(83380400001)(8676002)(82310400003)(966005)(8936002)(356005)(82740400003)(2906002)(1076003)(6916009)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 13:43:54.8880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95216de-d3cd-4c24-3743-08d96e17b502
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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

debugfs APIs returns encoded error so use
IS_ERR for checking return value.

v2: return PTR_ERR(ent)

References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  4 ++--
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index d256215ab2c7..60f46a4b0144 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1696,20 +1696,18 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;

-
-
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
-	if (!ent) {
+	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
-		return -EIO;
+		return PTR_ERR(ent);
 	}

 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
-	if (!ent) {
+	if (IS_ERR(ent)) {
 		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
-		return -EIO;
+		return PTR_ERR(ent);
 	}

 	/* Register debugfs entries for amdgpu_ttm */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 7b634a1517f9..0554576d3695 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -428,8 +428,8 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 	ent = debugfs_create_file(name,
 				  S_IFREG | S_IRUGO, root,
 				  ring, &amdgpu_debugfs_ring_fops);
-	if (!ent)
-		return -ENOMEM;
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);

 	i_size_write(ent->d_inode, ring->ring_size + 12);
 	ring->ent = ent;
--
2.32.0

