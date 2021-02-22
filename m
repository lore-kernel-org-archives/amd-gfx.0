Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F44C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AAA64E29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 08:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AAA64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335BC6E2D5;
	Mon, 22 Feb 2021 08:25:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1AC6E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 08:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOTs7xqpKIEqsJhUeOY+1998VPWa3X19z1k1tBJud/Or64b6X/pRaBHjzG9cbaO2CaneRU7DN7uPr1Q/7yOgyYKSlwJPBWRPB6gzjUAEYbXKHCUDwQ9kYmEWQ5RuYonAziEwVFKtTbVUxntXEnnPb4bzAC84/Ntql477Lyf2mHrapMvimA5UhY1PZHc4T2ihGOCds8IsBnhoZtLPdQcQ47wmaFzIcj7JtS7YEPfiPzYKpZnW7D3EeAurVwoHcwogft7LLAyMFP4JQZHj4W3A1/fVACf1ns/hmo5evdvjW6H6ynKkuevoNaTomC6Aa17pZSZd8lMYQH4RaJt4i755XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBW9qDQKYYuFolpEdRDt5sbrqhdxsg2s9ycMYx/hd0w=;
 b=CD4XD+RvXCpI0OuO7YDHhNB1b/4KfWxfUcQ0j5SzaSX/hGE6ESvxgx7w9MaprSyxGTzc/JXQRWDkWif9cz4tZkvWiJT24fdKWK0SvrktATSWFsFjXsaVD1P3X/DzNwQTcxC8t1CDg9kfl9UtI86OlwpTKt4p1djVONNn0OHmPIDnjbHkKvUz3DzN1zGaIuKbc7wKwcdRpem9Blxta/6K5PBDbKBheQbySGAZI5pjqtKxL98FFHaWpCH55JJEb5+P1d5XVb6vaIm4VpN1HzfftmO3MZQsSEylMoqm9tlzVbBrpBmwY7n5gDPFhdN+kbculBuyrwX/jFo6u7VPi1ta2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBW9qDQKYYuFolpEdRDt5sbrqhdxsg2s9ycMYx/hd0w=;
 b=0xAw07xu0XK4yVEmHfZ9EVagXt0uFcktC+Vuaea+uOXxPBSitxmUHhym9hbPpUaf5l5vzCob8Z6EnckWvtBMlufEaNP5P2vrjM6QIgqf1XKn69Ey/bUhWzi4lQ/+vwXRHOhZdLAwmz9Ve91+Zs+r+GBjFCNJenofy6sDJFEF32g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 08:25:26 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6daf:7d00:b03b:8a16%4]) with mapi id 15.20.3846.039; Mon, 22 Feb 2021
 08:25:26 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix shutdown and poweroff process failed with s0ix
Date: Mon, 22 Feb 2021 16:24:02 +0800
Message-Id: <1613982242-23437-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:203:c8::8) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (180.167.199.189) by
 HKAPR03CA0003.apcprd03.prod.outlook.com (2603:1096:203:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3890.8 via Frontend Transport; Mon, 22 Feb 2021 08:25:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a34f1fb8-2a57-4e24-f12d-08d8d70b6800
X-MS-TrafficTypeDiagnostic: BYAPR12MB2597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2597254E575DC249DBCDE0D1FB819@BYAPR12MB2597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/v0MPVa8ROCgZgmu7tfyoFo89qf53v7jTTD0ZKnTXbbDQPcHWH/xF9KlQQiLtgYcJeKwhfc2D94gGnnZNx6ElWDAnk2ZqngHKDO6OCgZgLbVARofxn26MMM2hgBjsmhBtsG9bI9jR4Bzgo0S2YNdTn6g0EVSwv40JcJo0iiM3maBPZoPMJ3f+W0RXphxfECSk3wzzK5hadJqqCgqeWXe+a+sL1RdCkblF52CKSfYLZxACvbDI/mFiblNKtQUK/erKCkYMNEoDp2k8qHrmdvsig5Ana14I8+72uyYJn7KDsnbMwtOUHMfND8Fzm9QGvjcmh10jcIp/txUyCEOn+bJQGCBGz8D/OoRNh3eQb9vwgZ7ubjRNnZGTATr60aKeKjt2LaANt2dzMen1N6IKieoWRQ5mZ4+9vK8ckwvbv8ZOfP7GeYmxBrlWGCccrqMI8QvrQO913+irbZZkfXCq76S4i2jkWucdl5WrJ4/Eh2QYnSq4DnNMkBsc7rpcA7gohTr4AyHgzDgNnV6wMd7MnzeX7knEWyxHXRygR1s80u8W+u+pjjWZqEPjo0/Bd5cRmrGQoK4gMM0LfbNLXCKrPpcrSDhoAOrcqZldw6OJYLahI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(86362001)(66946007)(66556008)(5660300002)(66476007)(6916009)(186003)(316002)(8676002)(45080400002)(6486002)(478600001)(8936002)(956004)(16526019)(4326008)(54906003)(83380400001)(26005)(2906002)(7696005)(2616005)(52116002)(36756003)(6666004)(966005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ywJpTm4Pf156Gytcab3S+9uKi35+1OWBHkiAkcimY86E1bNuiX/LPqVjoUDs?=
 =?us-ascii?Q?q0Ro9EYKtLrvwr05ngtzwpDRFGT7elxBL592Y2FGp9iRJAwP2H6o8dmWvb/2?=
 =?us-ascii?Q?P80lTcSlymc/BvsSaxQTvlhNj4VzbgiHH5mdIwRZ4B6lvZhbYTckkWpop10W?=
 =?us-ascii?Q?yB4FaYDItfdpe9i8+c/WEUw8LpuR5H35MLNWylkzmljAiWxhM+dLru7nlWhg?=
 =?us-ascii?Q?QbM7EHxbyllSTFWOUl86UzIjS9UNA3PReRFUn4vDd0cfdKoTUZnsoXthTE4A?=
 =?us-ascii?Q?bWGzmtSxCrpp6RFb72zWRHBpiXyXeAXZHE+oFTG5oNOrVYAO+lE20XLImzkv?=
 =?us-ascii?Q?xO26UfHYop8YCmuvgTn9c7BS1yOdb3wjuNBD4rAkfyDLlEYBlcnX2ZVH5PX8?=
 =?us-ascii?Q?zWYzx4KDIlY/LGWxmFAZb/6q+hp+cKLBhGRBXHyUzTFRSkMy/wog5pGTJY7o?=
 =?us-ascii?Q?tv3txnCARltw7LY9GJD1zAtbqcb2Yx5tEKjR4m+hZfqHWwP/LvG6nkiTdeoh?=
 =?us-ascii?Q?YU6WoAs7lRqJK5P1y88U4aS74v2fheQr2xF2VKB1QLqRR0/RuUclyNESAzND?=
 =?us-ascii?Q?Lyc6HTO4N0YvLSQzgUswGgTrfPLMj0uSSU3JgHi/7lLBoRDGlkVGxhOfoCts?=
 =?us-ascii?Q?r5iCgvQ7kevgE0rDoAMEUVDtb4BN6hTqUD3ZvfnEwRojBqGJkGGMtCV5xAVB?=
 =?us-ascii?Q?k39au5DNZO4z9ljd5Lvcs40iZFbAFdAN1Ic6WqFvqCoAbqUGCkpkrutbBYUH?=
 =?us-ascii?Q?vM4VmcU4u/1OQ0NYIYNV6aFSi8wOoViERxXJDqxClFD3boDZen9uVLEWqLwe?=
 =?us-ascii?Q?jO/qjpEV+Qd8Nmij8GYafZtG7TQ1gDx+KVuBDh+RnYkztiXBxxAIEEOl3BzC?=
 =?us-ascii?Q?4rPhLfqoDlY6j3EZW0BfvmkEghsVU4fXhCYm3w/xrXI/3GRcw9tqJVJNvku6?=
 =?us-ascii?Q?FxGUoI3TYtQFN3vKLupn065wtJfqSKsU+Kt9/+Qq1ZS8LY1/UyY/LET3jYzC?=
 =?us-ascii?Q?jG2ebkoqBNWYbZcXEdpRVcgnmvi8wodqZUZxyCaobf2F+PEwPCDp7dn2fQr/?=
 =?us-ascii?Q?p0nACPKWyegdmzD4AFOmWNouYaWRXGySTLkRoCwmaT3vSh5gkpGk8n+a0S1q?=
 =?us-ascii?Q?fFplZbC2YNAGHcZ+8cfQKFgTvjXcY7bzG52UXbUtZEE4Ia2nJ1cPF7z5o3F+?=
 =?us-ascii?Q?sCjx+ZTROLI+DdFX+7aP1QAJFfiASkLm5nqGbagF3MOKP9DH1CXpKCXxHRMn?=
 =?us-ascii?Q?11jx7fVpmvdMvmcVJ4Dhr9F6Ga9wkGq3/JlOLTz6cayrEr7lRiO8iGDUgfZN?=
 =?us-ascii?Q?ct9QM65y+BsDa/GOnePo8YN1vzkV4DBAY7R9GSSLVRTD+g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34f1fb8-2a57-4e24-f12d-08d8d70b6800
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 08:25:26.4318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/MMXKsqA4HeipKppPZyv9zYLCPEH5Ac/67oztm/C7uimAk/xJK3attNOzKFyFTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2597
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the shutdown and poweroff opt on the s0i3 system we still need
un-gate the gfx clock gating and power gating before destory amdgpu device.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1499&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C24759f57e2644f26deaf08d8d4302cc3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637492650673813454%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I0rH%2FFt2cs%2BdNwvNdqWKPE%2B3bOosUyBodViUsEwb6tE%3D&amp;reserved=0
Fixes: 628c36d7b238e2 ("drm/amdgpu: update amdgpu device suspend/resume sequence for s0i3 support")

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9bf7f49..0035c91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1007,6 +1007,12 @@ struct amdgpu_device {
 	bool                            in_suspend;
 	bool				in_hibernate;
 
+	/*
+	 * The combination flag in_poweroff_reboot_com used to identify the poweroff
+	 * and reboot opt in the s0i3 system-wide suspend.
+	 */
+	bool 				in_poweroff_reboot_com;
+
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore reset_sem;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f9ad7e..f0f7ed4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2676,7 +2676,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
+	if (adev->in_poweroff_reboot_com ||
+	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3739,7 +3740,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
+	if (adev->in_poweroff_reboot_com ||
+	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b7ee587..b539628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1278,7 +1278,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	 */
 	if (!amdgpu_passthrough(adev))
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
+	adev->in_poweroff_reboot_com = true;
 	amdgpu_device_ip_suspend(adev);
+	adev->in_poweroff_reboot_com = false;
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
@@ -1320,8 +1322,13 @@ static int amdgpu_pmops_thaw(struct device *dev)
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	adev->in_poweroff_reboot_com = true;
+	r =  amdgpu_device_suspend(drm_dev, true);
+	adev->in_poweroff_reboot_com = false;
+	return r;
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
