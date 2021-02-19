Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B14C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABA464E44
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 01:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABA464E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC176E128;
	Fri, 19 Feb 2021 01:19:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D780C6E128
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 01:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcJiwIQnVvLkVOvRRlHFMSKfkGnrRna+CCbFtcnyY39oJu/tfEWQjdhf4ixPII1Bk3OzIjLtTrCVXtsbZ3vUod9Qhe2iMV8v6Xolsk48CkNOMnW5BW9CdRBabxRXXwTvG+Wh76S0Aq38SSNEwrA0FLbgc5UOvbM2W3kEAqc9Fs8XtaIExy//1BjSbwhIjeLI303dT+CnhfPHH1mHLib+QRKMf+NU6Krpz+OCZU1QMBwwXh4IDBdUvxNbMoVJfhfuDJD7OYSaVvo3OFzlhcRU5ahO4cMCtJhhykfW3FolEXzOehofXHe4ZqjUyys9cp6HAFYjBSvNYxzK6DhyVCny3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g1gdYIPhLHyQtjnrbSwqXmFmWHmM3BZS4UyRbRHzqg=;
 b=EcH6AQaVdTgk6xX23lz67o0LDwOWBnfaqHjYe1sPX8inVIgIcw0ZiIHe8gVl9yscdxB/yQQ/Eo6SLNWYkhw8cwThm9PZ0jwo1TWeWnB6HkOfEl6uRVSnsPchdYz/2PoQgvKQi5Eautyn0tMh28p68cb1L1J13cQcF7/hONqQ9xfC1s//x0qyJSEseBpasUHKsqp5W+7rFGMS3Us4QCtBlItHKwiViMhCaSXZQsEpcyB+0P1jpXlxEDw75uLHxftVIQwReofjuTE7FTGM5QhHYB1BSgoLJPGiqp6n33ZMH04C8u2mi7jXaRC+WmdYtyoIKIBIzBCxjshb0V4f0DfMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g1gdYIPhLHyQtjnrbSwqXmFmWHmM3BZS4UyRbRHzqg=;
 b=IndjjCBSEo7B6bwqfYGbocVs+5JjbKmHcTkOs9eaYiufIxl3QukD8BfnQVPlCO+3ZJ3IVs1vXEc7RED7dWan3bVfgen0g2H1UXTMb0gN5N+FdVKj8MOU4jBZCdJD9dnIUcFsw6ip3NGYVM4kdmlnlyge8VENRxM/H4SCEeLih7Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Fri, 19 Feb
 2021 01:19:02 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.043; Fri, 19 Feb 2021
 01:19:02 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Date: Thu, 18 Feb 2021 20:18:46 -0500
Message-Id: <20210219011846.28413-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.36 via Frontend Transport; Fri, 19 Feb 2021 01:19:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dbc9cde-300e-4af7-8c73-08d8d4745797
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3020E222B9C6F455C5F460F7F4849@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSxvgKCTyc1nC4cMqxChmCwaETlfkYpFr1TthY3UvUK5y26ThVpoFHhYU8u/jM/MSUFBYjVlCQ0aFpw0rfc2AL/ABKJ0Q9DO8eZEKs5VnYXcfo3vP0/l1J6xiCFp0qUZoGkbgmxbHLlIuV33ftHlY+eFXnaNjMRTCUoX3+Zycm13mXam66l2L+swfkxNqWOFevoPTq9TNeANj6OgPCyeuD9KqJl+aKgBhaYYLR1rtgVB7rQnzvBbj9IEcg11u2p3v2DOsi0unRGw3Idkh9cwaf5VVqv5m12A1A4zOoFy/Qcn18vGeHrc2K6m3UeysFtujVe0Gx4HTjpVJ0JbbeSFOa6TCt71qMKQqnO1DobcSBQiKTpv8GzJDJ2q7uj+hu8UFEgM+VOSLyJ6JuKHlOaX0LRFo/R3j8R0nKcB1KFwfyq9K08qOy+ddSHnymd3ryzD3EojM5nlwYsW4ESsBYVtSlyc43OB8kiUxZEtTJyjKEK70J1ylA5Yr1W/UqHYgH4yncT4/M1/apdebUwOO+d9JfaUwGIPdEGlzDolQN/3CoIVWI6qFVPzAfTLdypCKRqAKhdurB6jkwSXkIadzjDINw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(86362001)(8676002)(66476007)(186003)(66556008)(26005)(83380400001)(6666004)(7696005)(4326008)(16526019)(8936002)(6486002)(52116002)(2616005)(5660300002)(66946007)(2906002)(478600001)(36756003)(1076003)(6916009)(316002)(956004)(43062004)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d8UkbDf4t50xP+1PL5sVlxVH5buKzv9ONCBKF8Oh0CtbGOnXQxTtNEgB6FCs?=
 =?us-ascii?Q?sMsBW+a4yL/df6PEGMgMZN0vNtMteC76yhMR1RWUwSrhz+W501o8SOTLFzuN?=
 =?us-ascii?Q?TNTRm7wlcHn6NnwodGSxhR+BUyf3SUcgtTDsSX2Xo8zrc4VjuU2ZWJf6vLN6?=
 =?us-ascii?Q?0hQuMHM4jbn9rjQ90LIEanqwT+Q86M31yRoWAZL40uCF0ov9mEEwlpOC+m7B?=
 =?us-ascii?Q?Zzj3mCpXNW5E7DM9UkQdsWz0FoJNaQkR6oyhZw/1FVykz22pGzWu/LHn/iJF?=
 =?us-ascii?Q?xBQB/F1QbLA9qdBaGks8WtvVfYo5W3VHmUgjckIuzVT2sRGsmRfS0pLv9QwJ?=
 =?us-ascii?Q?iwmMmXSxezUAJxF+0eiZstIMwltvmKuWVCv4PjZopYknEEgGN1gcsuHrRqdo?=
 =?us-ascii?Q?8bYc0rqbjOAsGWCOm0nX5CrqpF9hHYOmNplmhakXasKlYWb4h+W9tPo1fZka?=
 =?us-ascii?Q?jFdAioF5ZHbHyYurmKTJozmK3e2fwh0ZdMqoW4wBmHJJEJPBMio+DPdCcEm/?=
 =?us-ascii?Q?TzPFm50OfX4Cgxm9CB47p78Ri4HBCHyFCV4tuyHs4uRuq/KDRETP712tCmHe?=
 =?us-ascii?Q?XokXpyMXoDkk+MevKL2krzJM/0u45ALKSImxEU6+T99ScCBw5DNfraPsQmtr?=
 =?us-ascii?Q?fvEWiqpjsTRKF4SuSy9Q8hMy9BL4ZYoLXkCsgwSe8b5o5Fa22eOfOJUyqIVv?=
 =?us-ascii?Q?Rwo6kyLDnkGfywyNr6gloKjSK2TbYk7ORgPvjQZdoBskTWrti+048uFPGFQh?=
 =?us-ascii?Q?GQ4LzV2EkDlxYPhbh5xpI4qlPK6UwOQq0mH4zAU/gtXVGbdHd5lMv4liLC11?=
 =?us-ascii?Q?AiaLsY1fmO1HjlmsQo/aOgA2CJguxgWBk/jMTIydxEzC85vxJrkA1zGHwlO0?=
 =?us-ascii?Q?GIvrXjJsz1UoDvix9Hh6OyyW/Rv0oLCZngJtYMRHhT+wjqI6BP+L5xutdlri?=
 =?us-ascii?Q?2Itesb6D/+npFGXCqPBDKAv5HTeo0zHcSEHA3AJx5ph6hmQS1Q4jtf206z4a?=
 =?us-ascii?Q?LH7mPqgOWLzQAmNajBBQFG6ERgmbMK7oB5s/JeiluGxtR+3cRrGrwKZY7KjO?=
 =?us-ascii?Q?8kCJqA9Sxrx8tMvx4ygHyl3XBWLTbYn6gn74pLBYNVSSlpbpuIWUNPrBmdDP?=
 =?us-ascii?Q?pMp/Ly5JAMLqtqeqAJ9G+czSj4OOIaxF0guFo2/Pd3VeTJG0mEwbt2M8npDn?=
 =?us-ascii?Q?0DLAJyQATJmW+CEKqZOKXRhQPf/k89xBtkMajrZFlCMiBPKqUOL6jvwnmj6x?=
 =?us-ascii?Q?nCpv9AwKKO/pz1RTdlpRt2qgpx//ytt4hIzsllMtknL2sLKkd1zRm8qyHXfB?=
 =?us-ascii?Q?33/I64EFP2QFyWCN3Auv20qG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbc9cde-300e-4af7-8c73-08d8d4745797
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 01:19:02.6398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9KQcoJpcHMcJWZI1+WAiKUnPsl5UfItZXdmYa0HOFLWNadPbc4Ff/da+TSr2irXXkV5fJsQNogal3nVrstk6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In passthrough configuration, hypervisior will trigger the SBR(Secondary bus reset) to the devices
without sync to each other. This could cause device hang since for XGMI configuration, all the devices
within the hive need to be reset at a limit time slot. This serial of patches try to solve this issue
by co-operate with new SMU which will only do minimum house keeping to response the SBR request but don't
do the real reset job and leave it to driver. Driver need to do the whole sw init and minimum HW init
to bring up the SMU and trigger the reset(possibly BACO) on all the ASICs at the same time with existing
gpu_recovery routine.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 96 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  6 +-
 4 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f9ad7ed82be..9f574fd151bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Don't post if we need to reset whole hive on init */
+	if (adev->gmc.xgmi.pending_reset)
+		return false;
+
 	if (adev->has_hw_reset) {
 		adev->has_hw_reset = false;
 		return true;
@@ -2147,6 +2151,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
 				continue;
 
+			if (!adev->ip_blocks[i].status.sw)
+				continue;
+
 			/* no need to do the fw loading again if already done*/
 			if (adev->ip_blocks[i].status.hw == true)
 				break;
@@ -2287,7 +2294,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
-	amdgpu_amdkfd_device_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_amdkfd_device_init(adev);
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -2731,6 +2741,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = false;
 			continue;
 		}
+
+		/* skip unnecessary suspend if we do not initialize them yet */
+		if (adev->gmc.xgmi.pending_reset &&
+		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
+			adev->ip_blocks[i].status.hw = false;
+			continue;
+		}
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
@@ -3402,10 +3422,29 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
-		r = amdgpu_asic_reset(adev);
-		if (r) {
-			dev_err(adev->dev, "asic reset on init failed\n");
-			goto failed;
+		if (adev->gmc.xgmi.num_physical_nodes) {
+			dev_info(adev->dev, "Pending hive reset.\n");
+			adev->gmc.xgmi.pending_reset = true;
+			/* Only need to init necessary block for SMU to handle the reset */
+			for (i = 0; i < adev->num_ip_blocks; i++) {
+				if (!adev->ip_blocks[i].status.valid)
+					continue;
+				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
+					DRM_DEBUG("IP %s disabed for hw_init.\n",
+						adev->ip_blocks[i].version->funcs->name);
+					adev->ip_blocks[i].status.hw = true;
+				}
+			}
+		} else {
+			r = amdgpu_asic_reset(adev);
+			if (r) {
+				dev_err(adev->dev, "asic reset on init failed\n");
+				goto failed;
+			}
 		}
 	}
 
@@ -3536,19 +3575,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	r = amdgpu_device_ip_late_init(adev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
-		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
-		goto failed;
+	if (!adev->gmc.xgmi.pending_reset) {
+		r = amdgpu_device_ip_late_init(adev);
+		if (r) {
+			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
+			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
+			goto failed;
+		}
+		/* must succeed. */
+		amdgpu_ras_resume(adev);
+		queue_delayed_work(system_wq, &adev->delayed_init_work,
+				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
-	/* must succeed. */
-	amdgpu_ras_resume(adev);
-
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
-			   msecs_to_jiffies(AMDGPU_RESUME_MS));
-
 	if (amdgpu_sriov_vf(adev))
 		flush_delayed_work(&adev->delayed_init_work);
 
@@ -3565,6 +3604,18 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (amdgpu_device_cache_pci_state(adev->pdev))
 		pci_restore_state(pdev);
 
+	if (adev->gmc.xgmi.pending_reset) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
+
+		if (atomic_read(&hive->number_devices) ==
+		    adev->gmc.xgmi.num_physical_nodes) {
+			/* Trigger hive reset when all gpus within the hive is ready */
+			dev_info(adev->dev, "Trigger XGMI reset during init.\n");
+			amdgpu_device_gpu_recover(adev, NULL);
+		}
+		amdgpu_put_xgmi_hive(hive);
+	}
+
 	return 0;
 
 failed:
@@ -4241,7 +4292,9 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_full_reset  = *need_full_reset_arg;
 
-	amdgpu_debugfs_wait_dump(adev);
+	/* no need to dump if device is not in good state during probe period */
+	if (!adev->gmc.xgmi.pending_reset)
+		amdgpu_debugfs_wait_dump(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		/* stop the data exchange thread */
@@ -4304,6 +4357,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
+				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
@@ -4343,10 +4397,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
-			if (amdgpu_device_asic_init(tmp_adev))
+			r = amdgpu_device_asic_init(tmp_adev);
+			if (r) {
 				dev_warn(tmp_adev->dev, "asic atom init failed!");
-
-			if (!r) {
+			} else {
 				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
@@ -4790,6 +4844,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
+		/*enable buffer function after reset */
+		amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 	}
 
 skip_recovery:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index aa0c83776ce0..8c71d84a2fbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -149,6 +149,7 @@ struct amdgpu_xgmi {
 	struct list_head head;
 	bool supported;
 	struct ras_common_if *ras_if;
+	bool pending_reset;
 };
 
 struct amdgpu_gmc {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 839917eb7bc3..5e127a59b121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2261,6 +2261,12 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		goto failed;
 	}
 
+	/*Don't do the real PSP HW init if we are pending on XGMI reset.
+	 *The above init probably should move to psp_sw_init
+	 */
+	if (adev->gmc.xgmi.pending_reset)
+		return 0;
+
 skip_memalloc:
 	ret = psp_hw_start(psp);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..b1c8fd90c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp);
 		if (ret) {
 			dev_err(adev->dev,
@@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+	if (!adev->gmc.xgmi.pending_reset &&
+	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
 			if (tmp_adev != adev) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
