Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36880C2D0E6
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0F7206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wkocpwQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0F7206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAC56E978;
	Fri, 27 Mar 2020 03:43:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE546E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTge/vntkSDp8rNN5Wptf/HlF1tCGrpLNpyUtiImG9ZkB3wLQsQ+8F95VGoN0W8l3oH0gOtIwEYBdXigI1GfJ1XMO3xftZdmae+BE+CtFOrlovAspDz5iatsLUPa0wcNF/rFdX+ajosTnJ3OJG3R0hYy2eidjpfGmQF9bo5wHVFjkDmTpnxuvSTdRGpjNBp7NbG73h039OFAuxVUryOIyMX8IVTQvMDr8oa+CEtePmtY6p825tk8l4dOs8o2AOl2IUqsEzZ7Ac2CNA/sGW4piqSfFGQt8xNvf45nd/lUZVX26rZe29KCO8mfptfKgCJdiZQs1Q1mHvVdNnG+VNPqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7a2sN6uVHN+QmW5c29DdqdAkONBgQtlvdIwcsIWvnI=;
 b=DFo+X1o6cFyhHcezKqxl0Vp6c3ZM33/4piDuSSTCfWzBU10uAyjXojSGMXCHgod1ccQANanXrblmSRiVJIpZtwZFRJsa0Ye1C9vgTy5MBnu0PbE/ORbBn6EiJOtqv9dCm6zECeiQB37NMjFgKGZ2TO21bWeQjfg4fVpaNPJEaLdW2Kg4OJGLda+t9FHXEa1wJXZzVbCVJvDznqrbci5ehurSTn9vGVJud2KUrZ+FT9FpbZRjA4wdeHAbwIHW8+4J0tqHrYSRuBg8UQqoHbEwMTs3n6CZTCHJVt8PoPouRJizVfC4r2ZjE5jhQi4XZRQsDgLz75mHHZujzQwaSnhCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7a2sN6uVHN+QmW5c29DdqdAkONBgQtlvdIwcsIWvnI=;
 b=wkocpwQ0nWhW8bHME5FtKVfzFeHNh2OxeZJrqO3nrLCf9lu6vhwQI79LXomDQvZ7lBYHrRkD+QuftVjPxhQtOGTUtMAPN/7FDxG3vetsX9SMIUNzR2qNwkkBH3KGVTneh6Nt/1IXNQsGrEWyYd17qRdRVrkbTzqwnUd8FZVtXGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:43:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:43:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/powerplay: added mutex protection on msg issuing
Date: Fri, 27 Mar 2020 11:41:38 +0800
Message-Id: <20200327034138.7653-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:43:07 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74059732-9b39-4144-a094-08d7d200f70e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4373B0A487F2BDE5A1BDC0A4E4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r23TJA/u+kiKzRQIExezXHvIMEVohXuBQjMNLvYCOe2lWk66dOdg7iDXDiwXvA8acrG4bQRMQXUAdJm8bbPyYFb7Fmmr6HQiu+GPPAjquC+xPZY0zNGPxRS7YJQSkNjry32lNw8UNlrSJ2GtFJOV6m3rWek2b8ALqxDI6PI1YG8oHb6iitPO03q90vVDdpyM5s7FRxPnduq7i2BsddNONxIxGz+nQ+mvek2WqoM6pz+wFwok9T6k4gr2QIQe55jBXNCGehv6WnhParNGWqPr8z93G6z4SS7hHfv+LEYVQBWQxDqFhGXXVfNfnPFEy0exoGi0gZ/wRUkXVPqaELr8obVCEjpztUB12q93SyZTNcMjFEE88A4OhaMacbk3+q/Zezu72Ch+vg5tWQV6UG8LN5me6IW5V1sp3WXXg6z88zIZt/ErQnvWaphy+cI5HaI4
X-MS-Exchange-AntiSpam-MessageData: vypNb47kVD63BwdygJr+Uto8tsE67vdEJ9lAqqIVRYVitD8N9DMmde6dSH8boJNyXQVLSS3/h1FQapTGJKPOhlAIX2ZzAICJXk6DzsnD2qGLzGu6renzTQFKbKUGY1uNbK1NhNPeVPp6eDlrz6pW/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74059732-9b39-4144-a094-08d7d200f70e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:43:08.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pr2LxSKMBweXKFi8Lgeg+Jk74GknDJPGkcIPKt+ZCkomfJuJayDVT0ifX2RoMwts
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This could avoid the possible race condition.

Change-Id: I518b6f96b1a836bda4f1c7e13c00f62cd316a90c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  3 +++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |  1 +
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c | 16 ++++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index a7f4164fe8d4..9881e20c1119 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -50,6 +50,7 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
 	hwmgr->not_vf = !amdgpu_sriov_vf(adev);
 	hwmgr->device = amdgpu_cgs_create_device(adev);
 	mutex_init(&hwmgr->smu_lock);
+	mutex_init(&hwmgr->msg_lock);
 	hwmgr->chip_family = adev->family;
 	hwmgr->chip_id = adev->asic_type;
 	hwmgr->feature_mask = adev->pm.pp_feature;
@@ -64,6 +65,8 @@ static void amd_powerplay_destroy(struct amdgpu_device *adev)
 {
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
 
+	mutex_destroy(&hwmgr->msg_lock);
+
 	kfree(hwmgr->hardcode_pp_table);
 	hwmgr->hardcode_pp_table = NULL;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index 34c48b6daa46..9b8fe00bd601 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -744,6 +744,7 @@ struct pp_hwmgr {
 	bool pm_en;
 	bool pp_one_vf;
 	struct mutex smu_lock;
+	struct mutex msg_lock;
 
 	uint32_t pp_table_version;
 	void *device;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
index 3bb0392994ec..b6fb48066841 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
@@ -136,13 +136,19 @@ int smum_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t *resp)
 	    (resp && !hwmgr->smumgr_funcs->get_argument))
 		return -EINVAL;
 
+	mutex_lock(&hwmgr->msg_lock);
+
 	ret = hwmgr->smumgr_funcs->send_msg_to_smc(hwmgr, msg);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&hwmgr->msg_lock);
 		return ret;
+	}
 
 	if (resp)
 		*resp = hwmgr->smumgr_funcs->get_argument(hwmgr);
 
+	mutex_unlock(&hwmgr->msg_lock);
+
 	return ret;
 }
 
@@ -158,14 +164,20 @@ int smum_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
 	    (resp && !hwmgr->smumgr_funcs->get_argument))
 		return -EINVAL;
 
+	mutex_lock(&hwmgr->msg_lock);
+
 	ret = hwmgr->smumgr_funcs->send_msg_to_smc_with_parameter(
 						hwmgr, msg, parameter);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&hwmgr->msg_lock);
 		return ret;
+	}
 
 	if (resp)
 		*resp = hwmgr->smumgr_funcs->get_argument(hwmgr);
 
+	mutex_unlock(&hwmgr->msg_lock);
+
 	return ret;
 }
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
