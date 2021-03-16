Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B458664FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458664FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1756E239;
	Tue, 16 Mar 2021 08:43:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA296E239
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 08:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om1oyM+etOtJIrnPpRDx/ObCbPlxm8SqA1Q2HHusHXUY0PA3KuTCxwFIoQuWhkmtSGpYY/jUwU5MIvM66qwrSR4vqCwKsYX9G3dQfWTV4s/4Uz1svcOjB3k3rG2TxMd0j3idUvB2EJmXGGoljKBXVs91DtIScSv2fwvryQlR6bwu/m2lCOBDgFstyksYGniEoSYTKsQ0gsowfSqfAjkiZOPCJbUv0Fdko0+q4v/kacrMo3M8SCspvU1F9yGPafqSS34r+qrg4VouJDTRiekuMWirxsyswYeJPRZPDTBrQf509WW7cbFV4yl+LbJFf6JQPJy5FxIPPEV7/p0dp7pFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE2Z6wgAtd6C6Q3SP1CgbG7oRVSeZzqXDNPpILbqLfI=;
 b=EKaVpRgkobYnUiZKmCusJ0talpwE8/JD8yDQr4hVmun81YCiArvtPyAGTrUUeIvu5MahH5naObSDIxKbNCw9aQDi9jgq/y6pLE5NMucq5+gOwrjLv22sMl19mrCwKgLzqtBUs5n2rSBs89FEi9FPQxc6xwNCMyR/k2dXN1vPQvwYSHUpVq+jg8v/q43rPfHf1D0di4lF4xE4YaCryFOuqfCaEp24XUC8+ynDR8AyHk2VXiFIiptvLW8K/YI0J/PaNOpPAjXTzuYjSEeBq1gev38kYNIbAqWiPNdNJJCWaE+4VpwcSZML+TF6xaGuiyF9C1mGiGan3W50x+wCvqbozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE2Z6wgAtd6C6Q3SP1CgbG7oRVSeZzqXDNPpILbqLfI=;
 b=XM68yB2UOwkYfU6eEuCSrzkmH8y8TfDTF3OjJg0898n0Vx/dFlRLshPHfWGOlVjpq37RJvgxLW+vAXDEPGpq6/sdRWKuiwYNfcvGvgEwaUlXF200hKvpRMUV0Ih8CWgjgEE5DHNgca88dcN0I4v7tMyVB4I97nTJu/exY+2lF/8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3117.namprd12.prod.outlook.com (2603:10b6:208:d1::22)
 by MN2PR12MB3040.namprd12.prod.outlook.com (2603:10b6:208:ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 08:42:56 +0000
Received: from MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::b5bf:5e99:292d:87d4]) by MN2PR12MB3117.namprd12.prod.outlook.com
 ([fe80::b5bf:5e99:292d:87d4%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:42:56 +0000
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Skip GFX CG/PG state change during S0i3 resume
Date: Tue, 16 Mar 2021 14:12:28 +0530
Message-Id: <20210316084228.471863-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::16) To MN2PR12MB3117.namprd12.prod.outlook.com
 (2603:10b6:208:d1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ETHANOL.amd.com (165.204.156.251) by
 MAXPR0101CA0006.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 08:42:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c001cff-00c0-47d4-2472-08d8e8577f05
X-MS-TrafficTypeDiagnostic: MN2PR12MB3040:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3040E5BA9E4BA5FED1CF2004806B9@MN2PR12MB3040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hk3yC7/Cur7F1P6Pojq2eZB0U517VzYYhMd9M6v/HluR7rBe4e7CmDOt/UcZyF+SDShxJ2AUzA7wVfmQU1YaiJ+RLCEFmSgE5uEBhnmPNvLW0BE39p1p0PTVAKxm/EGiB5Aq4a+cwA++D9rkFmpSD20ZVJeNkoTbjF/A1xl0AUyQVpHsSY62/Q12CmPNfvGqkeOlzrcebZg6rbakUVoFlBbdRbKTAFYm8rqP478sS8NvJ4ExolKx5LIkzNs2qmv3lBXxQqPl6rU+Eua1DPa77vuZHQjiIG3F0925dyO/kQnbFwthGNvMAy5eg47N3xw5ZRcn0u3g8dtlKdY32xYtwEGDR8xqFFgeqAhRzKaXThR9ih5Jvt3dZ7BI/U0hlGJiGgFal/1AfXeuvYB9TnkeB6azos6en3iSui8sWzxqR8dzpJv2J71/Dj0nkca6ek85oPXx6L6uoGst0RWNAbjKx0QdMYY/wM7fIiSpHtYG+7cyDBDDNHaRyII8GXrufGO2t6Y5KR2Mw2jD/E3qKZV27ZJCBqj7H43p9KBrSa7gwqbM8j2ez3OJsN25MbJldVta
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3117.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(16526019)(66556008)(6486002)(52116002)(7696005)(66476007)(1076003)(66946007)(4326008)(86362001)(2906002)(8676002)(478600001)(186003)(2616005)(956004)(8936002)(83380400001)(26005)(6666004)(5660300002)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+EOw3ZMKHI2s1eQsJ6DwZu8FRSaPy6z/J0m3n+nuKKdt/4LKRoe4dxKu0GWx?=
 =?us-ascii?Q?nroeaG9xN5R1RQ0u9IbUmoGVUi5bxCJsvAVzgXFK2ysMSMWUtfoFfphNJ5P3?=
 =?us-ascii?Q?gV3c/arfyt+HhhawtZjiLM6gZ/0mmMygQPEQUPYnrwd+eCyteDFoQvL/2CsY?=
 =?us-ascii?Q?YTR+SKC/gYr9E6rqEnAQB+k8mFz4faW7pQZxzYLJz/oPAp6LlFrp06FVHMHS?=
 =?us-ascii?Q?qYhPjJS9T2x/SRkkxloowZIOLGGFvj86DbKyy+imp+on0sk2/DyeYuRXvYzX?=
 =?us-ascii?Q?b5nAxlExBNnP2mxtmnuLjq1ORwygAlPsTr0a78gFAS18zG9R4idx6SYkDwW1?=
 =?us-ascii?Q?0mHI32BbCl/pQ2yCZax8NWeSZCxSstT+9pOCrunUnGB9QBgTsWYN05HCvTe0?=
 =?us-ascii?Q?aFF3Bc5wNF1xj2VuzXnPfXKgePZez5b4BVfSZLWFwDZMUVqDycgV/khx29FB?=
 =?us-ascii?Q?dIZyGYB6XGw7brrdtF9yij2Vs2qRY3pEOsSBT3Y6qdv44NxnTFLD80eHRrag?=
 =?us-ascii?Q?xvTfKhmY9nwSGNbzfW796O3aUqlOYd+izuPC55je7mj4yab15dv+gu9yBFKe?=
 =?us-ascii?Q?23C2Jdm3lNiEIbptoSFlFumkQzt2ac2HBO2sN9mrgdpsEk9K8X/nICZySDDo?=
 =?us-ascii?Q?FWARPtfu2+rs8Wu2L8h05Mwaio/j9+kLV/R8R7VjYyhzcvbZzTD7yLch57fn?=
 =?us-ascii?Q?PrXv64M9TXKNZ2BRLKqCRcrpWAJLigjlQmXf6XD5GhykUGhCnmjJQF1oIzmE?=
 =?us-ascii?Q?uZy4fF+t8/keBXQrwymFYXqmLaItOaf6Z6wzAymX1CVcAYgmNhkmI7agqc9f?=
 =?us-ascii?Q?YzWCNIdVJKrrrpEbh46uK4QACZsVp3gbQ946he6TNuiUCTQFGEwLVIUpRvMY?=
 =?us-ascii?Q?RI9QbMDUdE290JbJvWo8Pa1mvErQU97cRl9Z2spKTQIR2ArVlLAZ7pbYVO++?=
 =?us-ascii?Q?+RF1+aQOR10A1DtLvDbolD+uqxoYF+74MtD2lqR3K0lxnQEpLAfa4OXlSOVF?=
 =?us-ascii?Q?2EOEC8T5lAzp3pllKYq7YPGyd/LxgItX98kvwPRLV9u776aRJcwuerA8y+PB?=
 =?us-ascii?Q?OoQ7RsduHxattCBHsvXOw8cqEacm6KTg2q69pIoBU93PFCgddyyIfCrmLdTi?=
 =?us-ascii?Q?b5rpmUCbJN1VOmE41AHMdOq5AtHJA/f6EA3TfhExQi7s8mIdVEIDf0J5+on5?=
 =?us-ascii?Q?1AP/a3IR5d9AtWy3x+kQ4A3PyuOvw6OT5BNFdXejCNQIAjyxrpwNdeDXc1mR?=
 =?us-ascii?Q?ChoHpigOMaTi/UYKw+0NhYDS1qE3u/CpsfMDZBTTLoNTK6VB3+hxHp6YdErj?=
 =?us-ascii?Q?4Yxuo/fO6kykL3fpvKERYAt8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c001cff-00c0-47d4-2472-08d8e8577f05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3117.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 08:42:56.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSbbTq7SspSp9YQhGE4kh/G8B1O7N9+Mo1ybMbzaZdb5+s/YjdkvD6m46df7ZYahyOHsB++2xa4F7O1tY3/uNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3040
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
amdgpu resume time is over 1 sec.

[How]
GFX CG/PG state change is skipped for S0ix suspend.
Skip CG/PG state chage for GFX during S0ix resume too.
This reduces resume time to under 150msec.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5da112b3feb0..036ca9f0c739 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1040,6 +1040,9 @@ struct amdgpu_device {
 	 */
 	bool 				in_poweroff_reboot_com;
 
+	/* Flag used to identify system is in resume sequence */
+	bool				in_resume;
+
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
 	struct rw_semaphore reset_sem;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3dbee9671d59..4089135b6493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2349,6 +2349,11 @@ static int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCN &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_clockgating_state) {
+			/* Skip GFX gating for S0ix during resume */
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX) {
+				if (amdgpu_acpi_is_s0ix_supported(adev) && adev->in_resume)
+					continue;
+			}
 			/* enable clockgating to save power */
 			r = adev->ip_blocks[i].version->funcs->set_clockgating_state((void *)adev,
 										     state);
@@ -2380,6 +2385,12 @@ static int amdgpu_device_set_pg_state(struct amdgpu_device *adev, enum amd_power
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_VCN &&
 		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
 		    adev->ip_blocks[i].version->funcs->set_powergating_state) {
+			/* Skip GFX gating for S0ix during resume */
+			if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX) {
+				if (amdgpu_acpi_is_s0ix_supported(adev) && adev->in_resume)
+					continue;
+			}
+
 			/* enable powergating to save power */
 			r = adev->ip_blocks[i].version->funcs->set_powergating_state((void *)adev,
 											state);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f98843eeb084..693ad3b3e6a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1400,8 +1400,13 @@ static int amdgpu_pmops_suspend(struct device *dev)
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->in_resume = true;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->in_resume = false;
+	return r;
 }
 
 static int amdgpu_pmops_freeze(struct device *dev)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
