Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA93C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 08:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E55820753
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lz66R2qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E55820753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D626EC8C;
	Fri, 10 Apr 2020 08:02:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82096EC8C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 08:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFeKAi04NkJXN0GBeG5xzwn3sutk/er5rlIz3nA6s7GLMh8UkYt1/mhSrZUe2PS6u4qcZIDCqAR7ufNdt9Yodvsnw9o93HesscYPAxf1k9iyNexKUF51Nvx5uUt9zzhhapwHYMEMZD/IgjubEksu1wdyHpgdnnGR6OmFQuTTKuc/c/u1I4rRAI/a4CRW0a2OrYg6jMtNgbMQmWRqnFNzxzMtt9RCF1C4p1rYqQVnqFzeJ5jFeBBfRKIqQRFJyj01sbFcrRF0oo8a6imNgi3uXtl9GVFY3oMSz7Re6ANI8cYuKy3BuQaIOn6iCeBxzJxg6QVKwsr55oCP9z1B5e/B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOWWgjwXqnVSVnAZGmQqsj9sQnzv5ElFlgD3XjrrAGA=;
 b=O9jP6xDw4bAqDYH2O5PFiz6qjACqtKSCFiWXFU3i/NrSKLZhrFFD4E15vT/wsH3M7GutkU76zSfIFDpuoYphERXjscO+6UZwodtn63HyvtKdWUYRWW2qCaCt4ApJheoGKs0XmBjNdX+0pPEkPXjfkVPxM1wjm54BeL8cAVMk3jt9Ry1wTkJNUaIic/HsfG5z2qVYM0rYb5vV+b8E4p0IapM2pmXe+1SXGKyUGhPw9bsE85d+fwEcFFSox1gfb7CDYU1iJQ6SXjJEtTSssFMIJJYY8IaHzOudBeBAwsZD0q2ulBVfOjtbfB0OHq4+vrCG5kHXxlG2tkNXlQoFkA5E7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOWWgjwXqnVSVnAZGmQqsj9sQnzv5ElFlgD3XjrrAGA=;
 b=lz66R2qXDfm+klsWv0K1bZ6W1g480i+M0uXgBcmeljbor8JvbTNEJ3GgiIOtchWB27FNB7+41vhs7hbEF2Mlu+ol5uX1O/lzoKE7Rdy8TtVgjam/6KvU78JrpQGLOWG1NGpBGwrmiQ91r9VYGcBk+5OtymK8NK53t3u8iJdTyoY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3791.namprd12.prod.outlook.com (2603:10b6:208:167::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Fri, 10 Apr
 2020 08:01:56 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::2cda:a290:a058:bdd8]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::2cda:a290:a058:bdd8%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 08:01:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix wrong vram lost counter increment
Date: Fri, 10 Apr 2020 16:01:36 +0800
Message-Id: <20200410080136.29119-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0202.apcprd02.prod.outlook.com (2603:1096:201:20::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Fri, 10 Apr 2020 08:01:54 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3def6ef-f7c4-4885-6a87-08d7dd257020
X-MS-TrafficTypeDiagnostic: MN2PR12MB3791:|MN2PR12MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3791BA7CF517005F15F5A050E4DE0@MN2PR12MB3791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3344.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(8936002)(2906002)(4326008)(26005)(36756003)(2616005)(16526019)(186003)(52116002)(7696005)(956004)(6916009)(8676002)(81156014)(478600001)(1076003)(44832011)(5660300002)(66946007)(6486002)(66556008)(6666004)(316002)(86362001)(66476007)(309714004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oona3SCpKTUa8BxExMpdCxKM98u9AqnBX94h+cdzX/xS5QqHFc077Lg9hKO6e6hkas3TVzt99/K6OH2CHWVvbGrV6hITqrSb/7qNjkgy2fkUMl+uP8Aw6qI/f+7GyxLTjchrJJsgsy9b7JCtNfD7s47CJvOgfx1jeVLFbbK2mhiprOjImI+FP6HQl4YwnUtOWS5e+9AikS3BdvakzHpIqfXvMEgXKQPeCy8M3OxwO3IA5dmm6pqoZ2iN6E5njtFSznAvscrSaAoaTUpT79H9ERf1ae8soMHWlQOz0X1EfbrI46L9u+uocNQFmBNTGln1Uol3cI5fgt6vJmMWGGkXK2iOjvN9zIgApArORljPSs/PKBQ0Afvu18qtkNA51elKPonxI4lL4I5NCrTMYhgre3lLp8kk24CfKTfHHoxq1jFnFTP+84lMrWP0B+UgNPTgzPzJlyknkeEUk+F4YkYuDp2ceKrlTZVhOqxaeXDoPx4/jjBGKTlZBsSDQ99YmG9L
X-MS-Exchange-AntiSpam-MessageData: Chpp3NtL15+kZqxvjGmpLR/tfHJ2OSfwlVT2/bjLUkzDNFHVmIAzIBa0aUoosZWYl8DPPkAQ2GXXSgzmXdOOyQ6OPSovguqjXHt2cp2NF6DgtAG9qIpfPnbe74HBPakx6YruHdVZE6I5pnJH7j7Grw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3def6ef-f7c4-4885-6a87-08d7dd257020
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 08:01:56.2734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuv9nUuZppc/dEDYOZs7h3WZzbl+FqIgfmDsbPVSy6qKxjSUx0iJCYb5MpHwH2wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3791
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Vram lost counter is wrongly increased by two during baco reset.

Change-Id: I8b9959a5d1632abc774ba07d56cf295bdd8288eb
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/cik.c           |  2 --
 drivers/gpu/drm/amd/amdgpu/nv.c            |  4 ---
 drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 ---
 drivers/gpu/drm/amd/amdgpu/vi.c            |  2 --
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2a4e4b28d00..c9317975c46e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2087,8 +2087,40 @@ static void amdgpu_device_fill_reset_magic(struct amdgpu_device *adev)
  */
 static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 {
-	return !!memcmp(adev->gart.ptr, adev->reset_magic,
-			AMDGPU_RESET_MAGIC_NUM);
+	if (memcmp(adev->gart.ptr, adev->reset_magic,
+			AMDGPU_RESET_MAGIC_NUM))
+		return true;
+
+	if (!adev->in_gpu_reset)
+		return false;
+
+	/*
+	 * For all ASICs with baco reset, the VRAM is assumed to be
+	 * lost.
+	 * For SOC15 and NV ASICs with mode1 reset, the VRAM is also
+	 * assumed to be lost.
+	 */
+	switch (amdgpu_asic_reset_method(adev)) {
+	case AMD_RESET_METHOD_BACO:
+		return true;
+	case AMD_RESET_METHOD_MODE1:
+		switch (adev->asic_type) {
+		case CHIP_VEGA10:
+		case CHIP_VEGA12:
+		case CHIP_VEGA20:
+		case CHIP_RAVEN:
+		case CHIP_ARCTURUS:
+		case CHIP_RENOIR:
+		case CHIP_NAVI10:
+		case CHIP_NAVI14:
+		case CHIP_NAVI12:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index db68ffa27984..fe306d0f73f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1358,8 +1358,6 @@ static int cik_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (cik_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = cik_asic_pci_config_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7768880fcccf..995bdec9fa7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -351,8 +351,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
@@ -360,8 +358,6 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 		if (ret)
 			return ret;
 	} else {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		ret = nv_asic_mode1_reset(adev);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a597ad22b675..58a440a15525 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -569,14 +569,10 @@ static int soc15_asic_reset(struct amdgpu_device *adev)
 
 	switch (soc15_asic_reset_method(adev)) {
 		case AMD_RESET_METHOD_BACO:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_baco_reset(adev);
 		case AMD_RESET_METHOD_MODE2:
 			return amdgpu_dpm_mode2_reset(adev);
 		default:
-			if (!adev->in_suspend)
-				amdgpu_inc_vram_lost(adev);
 			return soc15_asic_mode1_reset(adev);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 0a90c296409b..af8986a55354 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -744,8 +744,6 @@ static int vi_asic_reset(struct amdgpu_device *adev)
 	int r;
 
 	if (vi_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
-		if (!adev->in_suspend)
-			amdgpu_inc_vram_lost(adev);
 		r = amdgpu_dpm_baco_reset(adev);
 	} else {
 		r = vi_asic_pci_config_reset(adev);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
