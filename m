Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E634C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C78320714
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C78320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAB789C9D;
	Wed,  6 May 2020 06:21:10 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66BA089C9D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeXcPIgjbWpj2pmy6SvlLbHhPYorGdiweOGDsh+3y7PNetbDYL22QqSI0g4xgR9wh21pmS7vu3b5wZoE2GO7d64ncBC9E2KcdFEx5k01wLxQSTtp3AEqL0lq08Rfe3WA9mtRpDUHLaEtPxRLWZRvaZYjeey9lvaVatFxHy9XcMlwOddAxH/7fWDsuKbLUfxHH7C5C/N22LtXZIPkZtTUpIxJQS7Hu2uFaqlPD6VY0Yjk+CxQFuwCgtXFzEO6rWVNT7bOQZ0Of+9fMKdkmYHUHtNEjKcV08Q7hXZ20Dc7jIdAX4yJjmUP1JR0pJRhOwW3qRIMINxA5K9XgQd2uKP7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqwQVwl6i+4Pj7HILweGHLLfyBvWhQ5vRkfYyww4j+s=;
 b=KmQvSva8OW+8A004h7CsASl3VXNvLvk1B/H8dzx2SROLlsXwY34rmGwsxJTgv1+GjhBXDIi3KKXNS4TPFGsLdxQJewq4Hw/E5XQbpMcxgX8srBBrMJ6uz5iicliwYfNymqTsg2N9E5U133StAJqedj98jKA2XfKJhCF/TpCRNqWV0EUbT9gDPRFHWX0w/h73I1CJDvvwC2NG8vn8EW4B21eF30ZLIO06lQrMoeSZq5ApUdhQJw4y5i6LNXnMKdtSjFstC8cFzLCZvE3CGLYUmuhVoVtFTLPFtGdXXfq698vrpgrZuffe6XTwtnuH8qtcydbPN5aWT0OKRbEQB2mkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqwQVwl6i+4Pj7HILweGHLLfyBvWhQ5vRkfYyww4j+s=;
 b=rwgH6Gx+Esa50k8JnBiqvsVPAxYJ8PeMPhKMjm/mabV30DtsjisJFFDR4o+gFmm6tFeW+g4IcnlTShWFpXME4WlpKiNHiXZ01DOPnwvlqvpfzBBFyS6bKj+pblmDHP1Vhz8LU5VOX9OUxQ3kFJGijjGXRja9smBsrUboaQLyMWY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Wed, 6 May
 2020 06:21:08 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:21:07 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup not_vf & pp_not_vf in powerplay
Date: Wed,  6 May 2020 14:20:40 +0800
Message-Id: <20200506062040.15692-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 06:21:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ecd80be-cb57-489c-bfb3-08d7f185a985
X-MS-TrafficTypeDiagnostic: BY5PR12MB4164:|BY5PR12MB4164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41640EEF28CD3C5B9D8DD39CA2A40@BY5PR12MB4164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6d0jleyW9jCHTOMVHfkkCO0hS4iUXhXcGRANl9jTXhb1Sv1GGL/IwwdBMlXneSD+cKTDX8xoe1J48v5pQvnZgZGsi/IhziE1XvwvrlwdOGMGYap30mCmmIuykcK+jgpRpP7o0yguXrwbvy1ufzIpVPGuJjJbJOIDc6l5k8t65Yn9uIX7NuIJ88ncaVFCW8jQKtH4k8/7VkVjGRniX2flT2dk7IuIVSBLm6SuhNx6cePyXZ13jbXInI0kVr23aEI7ZS874k5ETOR1otvVI/oczaHYdd4cF+1bbwf30b1JCHVh6K/31Xq119+KBAY18gSQzBGZ6HUpixnfRSuOolfjbHs25SoB9R9dZ4FmgxgStLYKMvmngkpE7QiTdoaTyJCzSjKVhyks2G+2/sRciZWNnKqLArM2NyAGbo4p9yjNys+s8LB9bOsXTGdYyobVOvdWswKDjOYCJyxIHf++m2mLmwFltNWeMqkJpMBy5xrezwArX/LdXVeMudamEwoIkAOJX5VuBWba3dsKmgViuJJoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(33430700001)(956004)(33440700001)(7696005)(4326008)(2616005)(52116002)(36756003)(5660300002)(86362001)(478600001)(316002)(6666004)(186003)(6486002)(66556008)(66946007)(2906002)(66476007)(26005)(16526019)(8676002)(1076003)(6916009)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: THr2KxSozReNaAbQN1A8eviPo6UnAUfk1hXyGPqaH6wfG8Y44jQoQrvotnqaiV9+puob9Pnkz29HndD/jwPML58PwULK7WsFZespa9mt6OcXFgFUHkiYnVJYI8Av1X9qGLQLHkS+cESU+uxaNccmrpD4Vfe/bE46TMoVdANdsiNDfUYf02jUAZGZvpasw3ujY0F2edDgkhl92hcPr1eXIBD2HBrXff5F5UNwk1ATByAlF1lO5QqO5XL6DGmIpl9yxxiuXauZs0ZJS65r05mx18QnKxJBq1ShizIeZbA2aPKpFM47ln6KgEXsyShsrNtIsoa3bRDkFapiZKxKF9JE0UvQb+TftlgWGOqIKsxmrAn6omXBNlPtbKnFruMh72F7RYDczfzSSPUZMGwbJMSUJLkRBmZcVZmGaMr7G5JLEOQGWumiKDH9uGHs3iKdqaCiYIUtzW3M4VA6xkhbZf9cIujYmURvo5cJo3RRUQ3bT8kIlha427/SjBfKoadUQ9r7X7cFgfJ3/mD+QcobUXiXzddMdDHp9fY8HQ3X7WtLFIeI0cNmTiJ9Uc53AowrmmiIRxLBhd1S73+AqdLObO+SE76bDlAPwoKaq4pkfHwUF2MvBbQm6CLWccf++4MCY96FJ6PIDS3ez8GmBkshwODm7M6UpTrluz+bx9xyPhldv0IFj4xEazl/Q7svlvx554wuBNNJGhfWo/oliwvdvzQVkgF8DAYMfBGn7moC0aIqljLJQMIjE7765ua5tufgipWqme3/+C72OcRoOl3csMPJY3FYsf9InT5M/VWUvl2IR9s=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecd80be-cb57-489c-bfb3-08d7f185a985
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:21:07.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRe4P6GCzlyMzg62g+lRfRPtRIF1QqMADYC0Tabjw3Ls4pWv0B8AehucRr9V3Q8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 kenneth.feng@amd.com, monk.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 14 +++++++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   |  6 +++---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  1 +
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index fc31499c2e5c..5d22a80c4dea 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -47,7 +47,7 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 		return -ENOMEM;
 
 	hwmgr->adev = adev;
-	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
+	hwmgr->vf_mode = amdgpu_virt_get_sriov_vf_mode(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
 	mutex_init(&hwmgr->smu_lock);
 	mutex_init(&hwmgr->msg_lock);
@@ -1438,12 +1438,12 @@ static int pp_get_asic_baco_capability(void *handle, bool *cap)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->get_asic_baco_capability)
+	if (!hwmgr->pm_en)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-	hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
+	if (hwmgr->hwmgr_func->get_asic_baco_capability)
+		hwmgr->hwmgr_func->get_asic_baco_capability(hwmgr, cap);
 	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
@@ -1473,12 +1473,12 @@ static int pp_set_asic_baco_state(void *handle, int state)
 	if (!hwmgr)
 		return -EINVAL;
 
-	if (!(hwmgr->not_vf && amdgpu_dpm) ||
-		!hwmgr->hwmgr_func->set_asic_baco_state)
+	if (!hwmgr->pm_en)
 		return 0;
 
 	mutex_lock(&hwmgr->smu_lock);
-	hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)state);
+	if (hwmgr->hwmgr_func->set_asic_baco_state)
+		hwmgr->hwmgr_func->set_asic_baco_state(hwmgr, (enum BACO_STATE)state);
 	mutex_unlock(&hwmgr->smu_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index f48fdc7f0382..e2379efcd621 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -221,9 +221,9 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
 {
 	int ret = 0;
 
-	hwmgr->pp_one_vf = amdgpu_sriov_is_pp_one_vf((struct amdgpu_device *)hwmgr->adev);
-	hwmgr->pm_en = (amdgpu_dpm && (hwmgr->not_vf || hwmgr->pp_one_vf))
-			? true : false;
+	hwmgr->pm_en = (amdgpu_dpm && vf_mode == SRIOV_VF_MODE_NORMAL)
+		? true : false;
+
 	if (!hwmgr->pm_en)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index 15ed6cbdf366..9edb70933c46 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -742,6 +742,7 @@ struct pp_hwmgr {
 	bool not_vf;
 	bool pm_en;
 	bool pp_one_vf;
+	enum amdgpu_sriov_vf_mode vf_mode;
 	struct mutex smu_lock;
 	struct mutex msg_lock;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
