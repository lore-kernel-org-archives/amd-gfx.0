Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EDC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6AE20723
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GamiNJho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6AE20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC1E6EB47;
	Tue, 27 Oct 2020 09:42:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 589FE6EB47
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFhnXZ55UYKC2MN2sDEvHCQJ9vBffrnxYghxEhVu9D4CQHX3qqqpPjG6rsu0dNRfcozivPJ8UEHrjGrpFLwpDx7eAoZvEVZikcGuMSO9xbKhv9nfotUM1Rz9v26tgRPr/EtaNYC9gl05HE4alQjSZbSGFAKnnEawAFeSMHJQuBeACvwG/i5/ePhevRd6YytR7wrpwgOUUJUNJ9Mex+buo2LsS+vHQji3OTWr5z6UoQo1sO4Z5elK1jCy/yMtJrzoRtHJl9EPAkclZ4rkLzpXHoAxxQiNIvwWxovRSvDlzp69HCdPIE8Xs+2x5t5cOCdUF5203BmC+qFddXI1Dd75SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l1aRrVdlCJamLLDAZj50x0vZ5QbhbWlBZ1wZOQtJK8=;
 b=Ap7++IpJ65mtdS4CTC4GebEB3fryuZmk5J2GkuK3wfejIRzvvhTtUdrjUSmEqjK/+01OEFOH8WgXCnT4h0L+HiYr2E7m+S8UW6uwnPb5qE6NrrpY0IAZnf9EPJTJrcWgSqANybZnjiPJHCmxSoYJWyUFe2K2q0+dByBxBkkbHNrMb483GxBfFZjfIPLyEJjnHOBU8S0+O/BCjIJF/PHqeY49SXUpymZK7wpMX+AoScscp5Zff7ZfxB2td1n3H9/QBnr4Ud0HKhY1zfL7Io1qGJwfCqgTRjQohY0DKRf/WoO/YwdrHi70tnH25lhqipKdO2XYBzOctTPVqTN9aLDJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l1aRrVdlCJamLLDAZj50x0vZ5QbhbWlBZ1wZOQtJK8=;
 b=GamiNJhoNrOLTp7f4PlnHsnoxxiXTPqoCwNoYM0phgQJAISHQnRCTE7Bzjdo/hFXHmoJkQ0KBYr6zsqaE+NaFr+Zd1+P+CPLyx0XWiQstf+M00rIkTsz+qwOUscLDd1JReoHloFwYF7/4PAtBs33i7PKNjLu/SHwO4pDuXZzm+s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:42:23 +0000
Received: from CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624]) by CY4PR12MB1639.namprd12.prod.outlook.com
 ([fe80::fddd:995b:6708:e624%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 09:42:23 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com, evan.quan@amd.com,
 Alexander.Deucher@amd.com, kevin1.wang@amd.com
Subject: [PATCH 08/10] drm/amd/pm: add one new function to get 32 bit feature
 mask for vangogh
Date: Tue, 27 Oct 2020 17:41:31 +0800
Message-Id: <20201027094133.21881-8-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027094133.21881-1-Xiaojian.Du@amd.com>
References: <20201027094133.21881-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To CY4PR12MB1639.namprd12.prod.outlook.com
 (2603:10b6:910:f::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:42:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be0e4563-d3e1-4923-7f47-08d87a5c9b54
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18459197495593A1AE92200CF1160@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M/YYD07ji1ConqBEzJaHmbl3tIVrCNb81TfGeHEj4aB4bqXYgSNwTKg8QXs6QsZ2+x6rUsDAR7z7io3XFfl5+s0Eg/VEMyE76QS51yytqibK4jQ0KJ3ShsF+fSd40BFXnb46iSAzyiCWBXsWqDzEjTC+JysEGHEWyyjKa+zBAj306CwaMbO5iYMNSK1DgmVLN4A0paIyBjhvnzNympXCFuE8mcqmp+gO8RQRahY6uz1mUGeC+/c8WKbCjXx3P6gdT8iFKUEG+LNxdktnEerfVvNzrUx52Yo5Z7FMjSbyGtRPUzrpidO6dk2TjujnyEWKn4IzXeok6MKj2bcDyFspA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1639.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(7696005)(16526019)(1076003)(52116002)(6486002)(8936002)(66476007)(4326008)(186003)(86362001)(8676002)(478600001)(316002)(6636002)(66946007)(2906002)(83380400001)(66556008)(2616005)(36756003)(26005)(6666004)(956004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: feJxSPOvRnbYnUnfYuD4kokLd1tRltr0aVa9/g5eIDaqnYzXMxYTRjWY0YWHMvXlGHkJSwXrHyH6LtOhlk1yIkgS5gtE48e6tFjAFH6J5qmaq89ZKJyQ0wJXWsTOYcmSMEi4+19VXNnGInx89cdc6kb+iHG/PrbIdkDjsKne6aB8m6odqVPSOQ9tvOScMSbzJNtKPCnkYJ2mf6F7q10UMGk4OCErb6ct4OFXVYDeoX3aUIQqcNmlsdrzw2qTO99lOwpUgkNuXDitzwBR8RAG63rrOCvRP/uJMDmKfT44qSnfEbDHW/O+PB4ulkjKLN+ftBbUVPawe1sbMU105tumBuYUPtOx8UhTs7745AtpQcYciUVG2e/svv5mpwpXmpR7dvwaSdj+nlY/Nm47Z3qYmvJVGLRPrUCia4VeYcumSL5I//1XmbdQ42I5orU5CPJKNwVJFlJJcZG9JTGaLnf0sMPWYdpXT2nrFPUAgpfP8Qfcm300zoCboC7msX2KAA1gHSanI8ZHz825xrrTq2Zo/r/zoaEeayz6W8B1+VphVr3oADdTwAKPXcCcNrvQwFFQP93KEPGA2SM/SzRfsEMV4/GdEzXVeg9sA8b35PHAeVfuqLKoTVJmPE9XRc8iMklkp+4SyHjq2AKgusJPhaEXvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0e4563-d3e1-4923-7f47-08d87a5c9b54
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1639.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:42:23.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXp61W8npxSXSgSMTNdbKqgZ6xzenH/esYNK314khxWLFJXzAg54dPjBKTosSbX5w92WSntHuve8rVYshxMLDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, xinmei.huang@amd.com,
 prike.liang@amd.com, changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add one new function to get 32 bit feature mask for
vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 55 +++++++++++++++++++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |  4 ++
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 92b2ea4c197b..dc28f22aeb38 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -346,6 +346,43 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
+int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
+					uint32_t *feature_mask,
+					uint32_t num)
+{
+	uint32_t feature_mask_en_low = 0;
+	uint32_t feature_mask_en_high = 0;
+	struct smu_feature *feature = &smu->smu_feature;
+	int ret = 0;
+
+	if (!feature_mask || num < 2)
+		return -EINVAL;
+
+	if (bitmap_empty(feature->enabled, feature->feature_num)) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 0,
+										 &feature_mask_en_low);
+
+		if (ret)
+			return ret;
+
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GetEnabledSmuFeatures, 1,
+										 &feature_mask_en_high);
+
+		if (ret)
+			return ret;
+
+		feature_mask[0] = feature_mask_en_low;
+		feature_mask[1] = feature_mask_en_high;
+
+	} else {
+		bitmap_copy((unsigned long *)feature_mask, feature->enabled,
+				 feature->feature_num);
+	}
+
+	return ret;
+
+}
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled)
@@ -437,11 +474,19 @@ size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 	size_t size = 0;
 	int ret = 0, i;
 
-	ret = smu_cmn_get_enabled_mask(smu,
-				       feature_mask,
-				       2);
-	if (ret)
-		return 0;
+	if (!smu->is_apu) {
+		ret = smu_cmn_get_enabled_mask(smu,
+						feature_mask,
+						2);
+		if (ret)
+			return 0;
+	} else {
+		ret = smu_cmn_get_enabled_32_bits_mask(smu,
+					feature_mask,
+					2);
+		if (ret)
+			return 0;
+	}
 
 	size =  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n",
 			feature_mask[1], feature_mask[0]);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index ab577be23c15..01e825d83d8d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -52,6 +52,10 @@ int smu_cmn_get_enabled_mask(struct smu_context *smu,
 			     uint32_t *feature_mask,
 			     uint32_t num);
 
+int smu_cmn_get_enabled_32_bits_mask(struct smu_context *smu,
+					uint32_t *feature_mask,
+					uint32_t num);
+
 int smu_cmn_feature_update_enable_state(struct smu_context *smu,
 					uint64_t feature_mask,
 					bool enabled);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
