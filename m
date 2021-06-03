Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB41C47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5AE613EE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5AE613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318726F39A;
	Thu,  3 Jun 2021 04:56:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E965B6F39A
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 04:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4WW5UOr4qegGUPwcsUm1Jxd/wLgWoDCvJV7ciVSwFtUf941+jczObZL+kbvEcbDP3hKnPJ+CP+EhoucV3FzbI2OVkFT+WFvnulO49Fk/ZklL5q1GRPkS+R5qa2hd8z5z1mMeYq2vyy/SKPnCS3NRdg7NmuxIwOAveSaQnUpkU5F7HtKpPs3HHIH9hX8WpBnM5HO8oDFbloqiZl2XbEXqNbDQm+NCaRGXKwMeZtCdOpCeXIamEqvo0A0mkvJfthiEwkxyahGCP13E8PW8C58Wkda8fv/lpixKZR4xul4Sj2Th2nTOoh14ok1knsBA6I5iGu1F+na3ZD+W/YODjZPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgf2YG1gFTmvhYGsySoS1aoAMEO/+O75ttA1VhB+ONk=;
 b=DJ2YAN3uLNWuAlNAQHsdZQ/14l2uuDclXFexumSM5K7sD1fiedj2Tq1WoyVWepULi9yawSGfX+8v98pv0y0Riq/r8Ycvmi4XV3zF4inOXW3qVEemn7ajZxtNGmVIZMFzMw97A9kcz5DifYQ4KP+ihTOQEPQeq6zV3oWocMY2KvbYcnTdUwwitbQQVbUt+da7C3Ei9cMJ3I9JBtHLyGhT9GMTvAmQEqbBpWJC8ZsJ4eJBSLLxQSB3iXkrJ8zMI8myCdpzgmcq4drD+CZEh6ab41Hz02O1p/vHKZQcWTAGdmakvfDqfHv06wLWPAPQDbu0wp86VVx7hfLDzlSNMjw43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgf2YG1gFTmvhYGsySoS1aoAMEO/+O75ttA1VhB+ONk=;
 b=NsYeuoKmZshcNqEIuHfjPMynX2VZMFRMrC5nOYPpfQFqqDL88hZV1iCIfUOh1AWH8I++Q8UvTYP7dR1R/WbRJZ5/PH7TNo/oTisSVROnKKyWOzAjvdMX7YkjlDpunNyRarSmdup88vZ0uvN2WYNGbreAiqTZC3o1GCws5lf6kpk=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 04:56:28 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::c) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 04:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Thu, 3 Jun 2021 04:56:27 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 23:56:26 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/pm: correct the runpm handling for BACO supported
 ASIC
Date: Thu, 3 Jun 2021 12:56:00 +0800
Message-ID: <20210603045603.977998-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210603045603.977998-1-evan.quan@amd.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7849e2c8-441c-4e07-61f9-08d9264bf249
X-MS-TrafficTypeDiagnostic: DM6PR12MB5023:
X-Microsoft-Antispam-PRVS: <DM6PR12MB50238F51D47D2EB064654C3CE43C9@DM6PR12MB5023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uw9SuFtkgxzUG8f4ZQYnqtUQhrUI1Y/EGxUUd6tHJHOQ/11FMpdkN+AFlgl5TfCZ3BtPjemdqXjQyR7j9InfpbJbRjiJhL1vzbleHEPqyX9A6txTT5KhRmmQF2CEw9etRZJGDzh3e87xvoyr3jjrVHeJxADTr1F+kiNxJAciJR+FHPwtz7y7TXd0Gl1bA+fjqTlumr/hd44UIsyQ4x9FwiMT8R04YdWt4JOiUIsIyBI60WAzdZszM6YML6T0CQfILpD0Nv+lwVKraiE6z2LlAk2LFT8iFKYUODH7mleyxtG933PRguS9Pe6W64l5KuamSOzN/LIa8DUB3JidTpkOSSr11Q7eLpgYbCd2TdxsmU/9pPKpwT6TSlTV18MhEH3oP9QSjPw4rqrDO9pXBY9dyMa91Ij08+CUiYUbnsRE8vVy/E4o9TczWmqsl4LDQfdDFTCFWc+RrXpCgLgB0y+d1WYWX5db264ES0EF2fJiEbUwaz6LPXSV6oU0rVXJ8y3vw5bFaYhRUTcrjBQxG6yOCNORz8Owwcr2Qd3sOe31b9HIzOfWKV0gCT9xjRRK6U/s7q9GI+mAiRDp+fBnHs3lm900x7wasNJ9HkF1hRCUPRazTP5o/uXeFt0Y3IzznTXSFvGIxYVk+upEPxcqHU9Nxl4HS7jLHLjjMBsFarAlmO9zdwSo9j8/quhD+mxF39KS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(36840700001)(46966006)(316002)(2906002)(54906003)(1076003)(336012)(36756003)(5660300002)(2616005)(7696005)(70206006)(478600001)(47076005)(4326008)(82310400003)(6916009)(70586007)(81166007)(82740400003)(426003)(356005)(83380400001)(6666004)(8676002)(186003)(36860700001)(26005)(16526019)(8936002)(44832011)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:56:27.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7849e2c8-441c-4e07-61f9-08d9264bf249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Via the fSMC_MSG_ArmD3 message, PMFW can properly act on the
Dstate change. Driver involvement for determining the timing for
BACO enter/exit is not needed.

Change-Id: Id9ab5e308ff1873888d0acd822c71b0a303fbb01
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 20 ++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3de1accb060e..3fad67c32098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1574,6 +1574,8 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		 */
 		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 362696208fd8..61d00b989e49 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1581,25 +1581,27 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	/* Arcturus does not need this audio workaround */
-	if (adev->asic_type != CHIP_ARCTURUS) {
+	if (adev->in_runpm) {
 		ret = smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+	} else {
+		ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
 		if (ret)
 			return ret;
-	}
-
-	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
-	if (ret)
-		return ret;
 
-	msleep(10);
+		msleep(10);
+	}
 
 	return ret;
 }
 
 int smu_v11_0_baco_exit(struct smu_context *smu)
 {
-	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm)
+		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	else
+		return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
 }
 
 int smu_v11_0_mode1_reset(struct smu_context *smu)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
