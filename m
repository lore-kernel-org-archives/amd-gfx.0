Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB3DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE3664E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE3664E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86B889F27;
	Wed, 24 Feb 2021 02:22:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3AB89F27
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 02:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l85l87lZTphbrgYwL7xCPGrc8p/erCy5m3tcAhkYqbi4hlThrsOE7yQn9E37EGrhHbKtaS4GciG9ihw+Uwgrf9WLTDGklKMja1/XSYMt5ursPobMn7AOwi8YXKhpKkdEvJFFfJGtOg2o+7RvaZV3w3rzvrb96p0Bgl6rYN3doiK82IkuHnEZgAtH00ULb+ZutqXdDj4vhrcv6OXMb8gZXwFwpWOHbRkAhyR96ZZ1UhmsgtUC9wOXIY84SkrvnRJf2uPU8D0BvIk7oFFzRUL7O/uGA50nktqJ56unI/sEYy9rIdy89XJLDlYvZ3jkN9Ynm3zq3Upz2TcbuunRvPHm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvGM+YdB+nCcG/6mIWOzkTC6Ao48RoYIBq1VnlQi4YU=;
 b=UYOp6bqBlX0yTl6jMl5xHCMkOxh7wG+otO6YBiwVHlPI4HoDSlGMdqk8GsbrhSNnGuM16TTRoJ3+Lx1KqVEqsdDp+y8yGZfnAbZoc4w4/sgHd44/z4MLFslFOOxdbeXDEuRXQ/nt5w1KcD7uV9b2D3qcQ617g9hHXbXOfn10irqAgqJW0Z+zmnxXF1DmnoXjXslXr6F6EebBl9SfEZ1QYM2yB/6tWID/9IBlu0JjSr88NTn7qVf7SoflIOh7xZGRmPX6k20eIREW0+VyAWTd8ABNug7s1S8vJ0JOnbpxlqVitJvcrhtu/GmRudptEP8lYBZTvAkzTzb43gYLPrwjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvGM+YdB+nCcG/6mIWOzkTC6Ao48RoYIBq1VnlQi4YU=;
 b=VvTQkrjFLLKq9NaDGP7FwFY5XtvAp0AEyq5KieXHCAHWaNywOAPU+2j6cP41+YGw8PVMyF8bdpF9p5IhMNkMsohkPNP2K0tK3joR6ph/uiX6HlieNMFd9dT5EomVd6BHHtO5L28KSpFkwGo8DVjIloZb3hJ/+01szx41ng91/OA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 02:22:11 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Wed, 24 Feb 2021
 02:22:11 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Add kfd init_complete flag to check from
 amdgpu side
Date: Tue, 23 Feb 2021 21:21:59 -0500
Message-Id: <20210224022159.23324-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31 via Frontend Transport; Wed, 24 Feb 2021 02:22:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4922c701-6cf7-4ead-24b4-08d8d86afdfb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35942CB269E564A32435D5E1F49F9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9FkzY4bXSQwVSicA3/ooiCColZVompieiT4RsdXx6UpTOTxC1YGj/GuOPLLfG2uMMHUqA/fHq0ZFwcb2/bIZy1ICj0BcIEicAzBb3ixmIusYsSbAJe/QhqC/eA7ik3kz+o1dkZQqAe2KD8TJQIl6pvtkFYsUXWXZqIvBXZBIcfAmVz91J308x2+hw4wRDF9AOtH1NYxnCraRAJRv7gzH1DXt9g84Oz4X89APw59GJRbV2+an9UHabcVS3ZYx5N91QAHB2dNOlxQ5xwvurLSNLoccA5Uwv316xDRu3CsHlJf42cSQ9hhiiKM5mp3WzupoaTNPjbdqCf/pBkS9f0RQ9iGFZq1hWOEq+IR3MBtG3NcqCbWdy4RaPBLUxRnYqJtxF9Bs5kwtZo0KetmlicVl3sXCBSVo84DSgb7EOuUMkdDVM7tsSMmsdNACUhdkCWdwLkZ18gJSk2XgzEVgCcOAfpC6FtmFZhksn+3IegSIWHaxO2nkAuAfzZfDIlwCir/lnmuS0hPe+CJTJZw8djunBlqmmk0DlFYoE0LgikxfuWjjQRD+0Y+SXQwB1eFXhFl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(316002)(6486002)(16526019)(956004)(86362001)(8936002)(66476007)(66946007)(186003)(8676002)(83380400001)(2906002)(2616005)(1076003)(6666004)(4326008)(66556008)(6916009)(26005)(7696005)(478600001)(36756003)(52116002)(5660300002)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bucu2ZBwxCfOoLgk3nL0GzQ0HkQSlwVaI7CcxCeoNPChbvk0wd9fYpuiOvUp?=
 =?us-ascii?Q?X+oWBRXbmjmihmQbBZq6PoYoeWRjfhZ9sDooTHWUAZkBUzxDvItV8H+NjYL4?=
 =?us-ascii?Q?cwhHtMqwFikzSZB/s1nr1K+r21Z4ssvw7wFGCuTG7OS2l8nIKtEioM2ERaeA?=
 =?us-ascii?Q?6Cx2q+F7zxK/TXZKQqFADlEschaQcXU161R1GoZ2viLGAxhoalD0E5ahEOyx?=
 =?us-ascii?Q?G+501jqGLAjQ5DVIPcbB5asXJlmZzFY0qW+jkqzBmxJc/7xau/KfwC4JVqk8?=
 =?us-ascii?Q?Sk8ICJZT4f+Y3801eJCtTVqBRidCJktL9jmr39wx/lZRXaFbeZrl/lAKajtv?=
 =?us-ascii?Q?ircoX1gyh5SANrtkWf5vcgmKqTA1sFaGbjWYNtiJkOgli6AMdFBWK10RmUjw?=
 =?us-ascii?Q?Oigsg8ACuQzYLtJNpmPzm5wTSQdKLeMjrVMMASeJOt6zsBRqIWuGRDoc+udG?=
 =?us-ascii?Q?/R68m3/40n7fxS/3iiifrlBUmuWQhzZWQ3oqrj/ZFfzMNcAL1rkaDy4ZL97m?=
 =?us-ascii?Q?uZwmXXnBU3oWhfjMzGzM6bqiV5tIaWdLrb6qJjXwTDThmflXgHau3IZ2AEx2?=
 =?us-ascii?Q?WokPv2fftMOvwvYqtqmhFhZdeeQe5GyoFTeX440Tyhey9514x/kQY5Bqe3WP?=
 =?us-ascii?Q?ok9xN1spFCgZuppIAChkzTCli1Y+j0GqkLtftyE+2T0hZddkX/N+G4dozQLF?=
 =?us-ascii?Q?fGMJAS5uQVDWzzg5uaWAkPsRg3hhT4//IIWj9k53Q8mZ1YjZnBARY8h3Flo0?=
 =?us-ascii?Q?juQ6NXJLsBCPBVIYlwp14C26NPtOaz6q32Ow2VNCbiCgfddU1y1hEdlI57R7?=
 =?us-ascii?Q?q7wUDaov6uIoW2d6KifHEVG/3n58Ty+hnsrLp6FW/Jk4yyK2l8aiNU+8zZx4?=
 =?us-ascii?Q?gF+9rxT+WP/A7CiQhcYwcZxc/MqQ7Vz3gZQNZrhju6S6AZTfiZej8Qr3w58y?=
 =?us-ascii?Q?fQG1lj5SUwf4tVDXEhUh2fjJK5oEzrvkCdGuBhQoi0v0vd9CC1cf8Zaj3zSJ?=
 =?us-ascii?Q?fE/59EZkgbRYKH3S5e7InGof8GwUp25g3NAteauEwy+SV4/xTRjDIkJNepNo?=
 =?us-ascii?Q?atOi1Gvi1bjw0vH6ApdM2W2GXc6rScuk2CBmekJYZ+6GZvw6Bj/2Vj6H+GTa?=
 =?us-ascii?Q?O82j60/zuMwnrMCIFw0QwcmcOD+NGg4GdBhdt/EB0gvkbfr4RScqVg6d7kI0?=
 =?us-ascii?Q?6y5x0IE+pAsfHXIIxMcxT7dqF5pDfvQOSi77W8fNSdndx2WDCG8bn8t4/DOE?=
 =?us-ascii?Q?JyQ0+oUTrf2GzZoNosccoMvs+bCH53nw35Y0t3tqv8EtjZs5Mh0n0PTiTprf?=
 =?us-ascii?Q?shOQ8sUS0ZdmR6gXtNdSyEf7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4922c701-6cf7-4ead-24b4-08d8d86afdfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 02:22:11.3961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxxa1CmD6VuwvvBR6viSdr7YwKn4whF/IqaRMVLG7S8D0xvq9pnossgq4m3CfJSSlaRmyqMGlGTdwz+qY1aQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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

amdgpu driver may be in reset state during init which will not initialize the kfd,
driver need to initialize the KFD after reset by check the flag

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ic1684b55b27e0afd42bee8b9b431c4fb0afcec15
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..a876dc3af017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -165,7 +165,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 					adev->doorbell_index.last_non_cp;
 		}
 
-		kgd2kfd_device_init(adev->kfd.dev, adev_to_drm(adev), &gpu_resources);
+		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
+						adev_to_drm(adev), &gpu_resources);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4687ff2961e1..3182dd97840e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -80,6 +80,7 @@ struct amdgpu_amdkfd_fence {
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
+	bool init_complete;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f9ad7ed82be..420ef08a51b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4784,9 +4784,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-		/*unlock kfd: SRIOV would do it separately */
+		/* unlock kfd: SRIOV would do it separately */
 		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
+
+		/* kfd_post_reset will do nothing if kfd device is not initialized,
+		 * need to bring up kfd here if it's not be initialized before
+		 */
+		if (!adev->kfd.init_complete)
+			amdgpu_amdkfd_device_init(adev);
+
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
 		amdgpu_device_unlock_adev(tmp_adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
