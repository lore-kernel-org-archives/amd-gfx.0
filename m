Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7C9610F8
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C7C9610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341A36E054;
	Tue,  7 Sep 2021 16:07:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F40B6E04E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 16:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFsdC65jJMNoCu7l/Ne3IJdJ5liLf4aOZ1FBX8IlHDEWE/zfXcHxGwRGPws6sCENLtxOj7Po8ERsgdkQFbV04CjwHcP8St4cHDYS8vd71CiOKgRMyrsyoU9XmxJIDQ4l6K+I3ox+omcFAsOcu2PnH1ascJcl8t/UKhGtODkddmTPbSNtNwNfVJwiFwUA/ZIzIh5jkeBeomn+7Tp5ou1TjLXDRfESfs/aOwNtASMUSYyUa2xcc5x99xoTylah9QHb290vZinTBLQI/qDzFDFEAWYaSdCgI3doifHj6dV20tkFF5Ah1vOOa5B4AWkOvfKSoN0j7au4BEf92VGj1I/r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GtdFvRiSGEz6DflgVHGcrG2ZKcUKkA9wTQmtz/uOQZU=;
 b=KKIDKeX84K2c3wxx/ooeGc2hWfmHrWOXWTfMUJPN7JoqdBQf56c21WPfKQxKkroAtgFqYfdIlMQVtpdzXu3Q1/hzO8fNXZDULhjKEb8uSBXXZYPD1d/BOsL/G1Yf1GEnnGOzyzW4A2h5W4MQu5LtBoiH/ZftlmsceAjscY551zKmOwj+gZXGWeSWnhcIzw0GvSQy20ZZGkbtmP+79DcSAYQhDCilDbpgHYoh9QlMJKJ3nlKdgZ8mWSIAb72Tphqzm7G7uJ3qzrsgOD2fH66SpN0CjG0viokoVXeCfPgerJyZA03m+1c5ydzscf2tsYLbxLCXlNpyKQfEohnI6p58Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtdFvRiSGEz6DflgVHGcrG2ZKcUKkA9wTQmtz/uOQZU=;
 b=qBxYu6ERXOeRzLcVIaOnjXh56kA+LgDXJI8IT300gQ9/HZxiG0YY0LCG2XIa1r/QGdpPnM1PbXKv4u3wKGBfss+ZywyIQp/n/yIHlZpqVNCoqg/g35ft+vsS7E1+uGJP+DRfJKydYgdVB6+cjldA0tv14rWhjnPyCxuKIAlZXJQ=
Received: from MWHPR22CA0009.namprd22.prod.outlook.com (2603:10b6:300:ef::19)
 by BN8PR12MB3396.namprd12.prod.outlook.com (2603:10b6:408:45::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 16:07:37 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::35) by MWHPR22CA0009.outlook.office365.com
 (2603:10b6:300:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
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
Subject: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
Date: Tue, 7 Sep 2021 12:07:23 -0400
Message-ID: <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7fa07f0-3f0a-44ab-a5ea-08d972199c14
X-MS-TrafficTypeDiagnostic: BN8PR12MB3396:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33968ADF5BD061B2B22F0D60E4D39@BN8PR12MB3396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfjzTi3A4pU4BmEQlvJ0s7nFVjZvmRUUfhLNPdmOV+jKqN9A9zjHIuWC+F2BwMGb1+LDv0MCBWiLxkSThYs3iAcaW7VT9BXyiyYqaJF9jPS6cBvqg1VpFzxAlHtMhJIB2PUY0PFX3s2cU+Q+IQFxy3z2IBr9ESo+g2UhQdYb+I2WgBLsdfFuncg9z6VnQ3nsNQ9uk+xlmL5MciR1kRpXoCn3yJ9aml3u477vvPry8ny448txX8OzY1HHFrSfpDC1MnpZT5pC/fmnji0QGY1vVTLdBxh1HKYP1ILRrxEe23uUkjS/3QS7MZKT0gynUTncu5LmE8ND0qOFOL5KxZL0OTyYwuErxDF6k4h3PeuD1qBpOxU0R85j8rZGQmg9Q0FYOoseX8+yQ1fRp2/ci2ouyX/oBeX/e/qj5PRxbFyzKkY6t4WL9tQnik/uDvgLYVNacIO5g2xC8nVbbp2gxShx6XQA/hmZYljr64KY27IqZG1H1ZPZ8/VxoHRv8ruhbpqOrb3Qg9fyv59z0ROi5ohYzArHmkGySzRNNf1y9iMoIegCbSLOf5ipU1iKGKtWo9fPMRlbhehHFDH8TVdNbaUzPiEpJkZhkbNRAdEpJGEKSYseqxgWa4jqHVPpDm1ibTgciQTxvhO6Pcjjye+zzfUhXg5W7+weJulIUFv3cQ8PS2/JYM/jOUz3f32GyssreDH/mt2ZGqwPIsoFjyJxtfdnvP9QwHGqVGFM0cTZHYqfkGir7aWjP7KvS+1CCpVCBYBvK3dVPQWr4Rb8T7zavXbr+Gj7agJsQYYzU3H/c3BIxCdgWYIGAO0MRHsFi8Ye40in
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(5660300002)(8676002)(2906002)(478600001)(966005)(6666004)(86362001)(336012)(70206006)(316002)(54906003)(70586007)(6916009)(4326008)(7696005)(82740400003)(16526019)(47076005)(82310400003)(8936002)(186003)(2616005)(426003)(36756003)(26005)(36860700001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:07:36.6384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa07f0-3f0a-44ab-a5ea-08d972199c14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3396
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

Separate iommu_resume from kfd_resume, and move it before
other amdgpu ip init/resume.

Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 653bd8f..e3f0308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 {
 	int r;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_device_ip_resume_phase1(adev);
 	if (r)
 		return r;
@@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
 			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
+				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
+				if (r)
+					goto out;
+
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
 					goto out;
-- 
2.7.4

