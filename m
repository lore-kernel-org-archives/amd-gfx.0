Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003DC2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A7B2064A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lb0gRm1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A7B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 446AB6E588;
	Tue,  7 Apr 2020 08:01:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF286E588
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:01:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTNDv52SrjZuAKHHzp0Lm1laJzApH/YeTPyLxojXVSF3fG1VF0eGt4eTnfZtvd8i6XZp0ggqApM8YR4uLJA8wdriX43y9+PLpurR/Bz6Zwb5Zx9y85np6dAzDIr7JpbWp009aUPAsEW1aKnlqp9Wvjyt7klJeT5JGvy2Ie5NMjuFInlu7FGTAnVqWCrd4VFGVHUiwKATcBy3bwB4D+s/qnjNF2k0xyfIVqp6HJ6KEpSUFFAVPGdFgxbJ+j8DX2mEc8LkTz2duGdNYT8ylCRs7Lw92PGXlt6DjAlSH1xwyN+eE89jCyL4j6P7OlP5sXB+zM/AJMu4Be2Q3Gp4eGtsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MARmmQ4HZeY4UHHDp49jBgQSO2CkGBOPIvrjpE39B8A=;
 b=l+AXF0e/rb1HckPm2WTCKRriNr3gxw14t8kpT0sFshsu9xiK+IINCpAUqEL1eGSB3OvTYYru+NcwZuJHEF7fY4eE7K10LR9qRQ9aqUGZSmPkLWSEnVu4wYD5vzTkxfyqBTDV5qL7+ukwybivl9Ny7Asl3s0BYN4OoCezwkb1bqUcxqoLhJnNFgoyEpt2DgnFH/e656AHafa61db852Jq9yFq/+3nvUYCiim6vf43ksM2gfvOTLQJcph+ZLhejQdojqzdsC+9RSqeGbG6LCWLQA1moNDKaWiS2qsVrD1AyrHzuSI+1f3rZ27uOz+3HERSI7PrFhAcColP7nEBDv73Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MARmmQ4HZeY4UHHDp49jBgQSO2CkGBOPIvrjpE39B8A=;
 b=lb0gRm1/qia+bCHndwKeTq//DXyyeEh+AAwC754g1JkqO/tWX+YkvWNsx9JJNOP/uXpaM2kYRyR1+3QmCm6REdXAQqxZI6tSssNfScTMQddrxhlyuHK8/uCdfSfe6NtkDy9PnWQTFdCVPrGZlOFDcZjrwDvAO82DT6y1urV5VYc=
Received: from BN4PR12CA0018.namprd12.prod.outlook.com (2603:10b6:403:2::28)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Tue, 7 Apr
 2020 08:01:35 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::f3) by BN4PR12CA0018.outlook.office365.com
 (2603:10b6:403:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend
 Transport; Tue, 7 Apr 2020 08:01:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 08:01:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 03:01:34 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 03:01:34 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 03:01:33 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] Revert "drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in
 gpu reset"
Date: Tue, 7 Apr 2020 16:01:31 +0800
Message-ID: <1586246491-31865-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(428003)(46966005)(70586007)(4326008)(81166006)(8936002)(6916009)(478600001)(2906002)(36756003)(426003)(86362001)(5660300002)(7696005)(26005)(82740400003)(2616005)(336012)(186003)(47076004)(356004)(81156014)(70206006)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: def1942b-0730-4815-c04b-08d7dac9e45a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16416F1CE0547B1372F8779ABBC30@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxKKTa3v95egwpay3ab+hbHVBTt+jd2uoiYGhPWLjTPRxrJ5GO9QdlPoavyCz3CxZmOyNk3eOPuxYQ9wIlt2iZaN++aKgqEc52cHxBUO3jJ1t2m44yuPgOaHPClvND8wbQcViDf4oQvbeSlQd0lsudcPNczDroCwvmzzPN981X5ZjwIGqTqQoW3JnrsTc235P0jPRQlvYtYvv/pakNyyE6rQQ6lWJW/dmcXCJ8FTeg91FXCs5adoMVg6WdZp14uHPQSI/35P5fDd3BL1jmqhDBWCAENqhy8SxkgxJaP/QwglUkOJb1nntcb9N2J8vY7wl26M5y3Evhyb4onN2X7jDwTCurDtyiDhdP+Nb+Js5QzWs/FQg/53vX7rLu2MsgDBpwycDP651NhY2ZyDg22EkI5r6T4pw4n6t53lMAFMq6FI0KznE6ofG2T5Ewlz9dzxVsw+L67s668XYcEfWznSFNVl9U92qTz7T8f9fSJNTqPT2kfaEdE3TQgT12kBFFnYHGb761RNrLyXoYarUwibhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 08:01:35.0219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def1942b-0730-4815-c04b-08d7dac9e45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8a468ab2d75a6b0bacfb5da6a9036642436fc666.

[Reason]:
Revert this patch in order to split it into two
different patches, and this will make it easier to understand.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index bdc1f5a..4ec6d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,9 +543,6 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
-
 #if 0
 	unsigned long flags;
 	int retry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index c2562d6..df841c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,9 +541,6 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
-	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
-		return 0;
-
 	if (adev->in_gpu_reset)
 		return -EIO;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2e1f955..d94eff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,8 +3852,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
