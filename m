Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE269C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1511610FD7F;
	Tue, 28 May 2024 17:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="so01+rbL";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F78C10F66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfM9+kYMEoM4LZJSPMhn9nWA4cH8asKMH4g/qhrxBj7H9hIPOCWBSGUVVlQsvv9IMsYsGhXfz09o3a2jMF4USaKLy0IF17K/wdrRzkn+gBKYT/ZSo1F8KL1ON5A7LMYUK37KIKNJS4Go0j5u1QXLktZyKZQ04Qsb+43zxnms1PDFh1Pe8p4YpZQ06VgbkWMSW8NNdNt/+9Xnq7pW1vd4kDXHMFm4c680hqItSdcKIGyVYPA2FCJ588nuDZ/h+18fVLlXB7u8jqZdRgyXDREYEYPKN7RHyL2bNHVOzkRqFdDYCFTIPk6P3x8T3mBVDGruBV6U1LYYRW/QbImcY9jhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5RaWalfzYNZZ+igii70oUu/ZSYWZDLhHhHRQbgNVlI=;
 b=QpVEdkY0mzIujtHnlfuBtk2KDtS3v+2OiQVOy4c8Q8fGMQ1YDlkJnLm5y8Rfaqr0o/q7Ci/9GXabuWvWaZnGoMdDIJl4eF8yAfSYqhC09hiDJAK6fsVDo6I64T82lizgGS53CK/LNA31dspGs9PKAoK1iAKCr1nhHc0UV/LJvhP2yGxvPoLLF3q0i/QOLRIVjv/Mg2AjVsPwvaWnKCs753H0itSJlEPLRFmvbZr7CBibDaaG7rNY2E38PF4fO/WQgAFq0GB4HmEm9nKOgte4YfLiIXcY8GCxs6eXrwPCUSatZB930lpElITMefOVT80Vs77I76pNAzRoS6Kk11KxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5RaWalfzYNZZ+igii70oUu/ZSYWZDLhHhHRQbgNVlI=;
 b=so01+rbLadY5BQd+9tSKBUMgG7Pt+V2+QXg1uAqTIYuX27IzyC+8GcPn+frSzDeBM+868HmoLmFZ1MsZwroHIsaLeRmeX/qlw9OU2ekrYqTEpgPUDZmFuPjRxjeMhCfDXMGmhbz9Cx/MYZVoa/byXhmEQnOd/QJMbYnmIPO5I3I=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 17:24:19 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17 via Frontend
 Transport; Tue, 28 May 2024 17:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:18 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:15 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 10/10] Revert "drm/amdgpu: Queue KFD reset workitem in VF
 FED"
Date: Tue, 28 May 2024 13:23:40 -0400
Message-ID: <20240528172340.34517-11-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e57599-27ad-40fa-6d3e-08dc7f3b01c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ssoxdBcmBeGQB9Im+U9uKFXiRaUmYfV5C2r74aF58b8BNqmpw6jN2/Dr7ib?=
 =?us-ascii?Q?kCF8eNd5k8vW/pBH9/mFcm2EctZzkFEn1d78zrgsklJboMpnw5iGCHpxDcFb?=
 =?us-ascii?Q?2glytVMLj8PtiToLQl34QMv7fU2tMCXFHAzbkuWUIrUbZkBDzpHrO3KlGLV6?=
 =?us-ascii?Q?xBkOebf6OYjBZvD5lNbs9uxl1mTwlJKNiEWsw6aIujuWRC6OdeIW6dCzXkKf?=
 =?us-ascii?Q?zzcKatprhTaW5mHz4QI9F1Bpg4ZDmIqIuO6upuYL9fK4DjQsRTtaV4dl2/my?=
 =?us-ascii?Q?JIhV8td3TRnUj7yOCvcZ03t+IzXuxjOHENqPJMufoNU2Y6PgaIjRpd8rCq8M?=
 =?us-ascii?Q?o3giIPWEJ2v1WZGH3pxbRiL5pGh0CbqsQUOnPjslP1VY0W5XUcOtLce+Q4CU?=
 =?us-ascii?Q?VEnQm1+dfb8/GmH4Cd3xyZie2TA5u3qSclfdULlxnzXTtXeqj7WIGq1bvpTl?=
 =?us-ascii?Q?LCrumgAHIznW/dpSGxZY0fwaU6n8hmtB6hF9Zqd19MohSfW6/5Tf1vQiPVm9?=
 =?us-ascii?Q?te82NwNjYRfPagYEuPz+ALYw9EtnYBC1I2paSgtjQ/Wsf5Exv/2okcMgu/L/?=
 =?us-ascii?Q?ZzbKRqAqGdTc0xZP75HNmQL+rgEVjWFOdaADIbQ568plkrpe0HI+IHAhzEe/?=
 =?us-ascii?Q?/0SyhWgnybbFD/oDNK+IU9o2kgq2s1Rnlnf05fIYrXEw9ea59mnhBKoiaCko?=
 =?us-ascii?Q?5q1wzmA94iHFAHO88kiIdOh08mrIaBu93Bd16N5OXsmhePo+0CqSOpJIQjsC?=
 =?us-ascii?Q?nEYTcWSu6cjirWo7OH6Gj/CHbA4Rpedtr2yJUcGGXQl5aMTs9BuU2H+Qw9TN?=
 =?us-ascii?Q?9AiMCU64rH6vRzR0rDoCS80NtDHyWBgYoIVWJL9P6vGZyRRvDTzis5WZb9VJ?=
 =?us-ascii?Q?7prCT4HfqbwCLtbaJTUsz99WN3bvxWdJByrM3vC4djtMijJIf93/C78fSZTx?=
 =?us-ascii?Q?wgng/dDzrUL+naJgiOfCKqt16c+LDLDxBVFFT42VQsX2T7LcV1OVkR/jcX6y?=
 =?us-ascii?Q?bZsFPVOmThNiebdo0Bopn8HuhUcbvun6qqh0M4CIsAQ129mR2ifAdwk47bBs?=
 =?us-ascii?Q?Xe8oorOkRmQ5MN4vPiZ7U7XtDSCF3N9QpLgrM5vDxqYsy9vQR34yLj9FfKId?=
 =?us-ascii?Q?PhL6OaquoLMWOGX7RFHUL5dTKXdjXAxV9tJvByd+uYVBUz4Tdu2Idcd9+MdT?=
 =?us-ascii?Q?65oHT5ElGb/LMJRMayY0g5a1rJnCF9/pVBtqbFP5XcoyZDdDB4gAy9zSdGeS?=
 =?us-ascii?Q?OcjCE2IubnYZ9seXGxP5dNzzhZ7LxdZJ7xx3mEFntwXXaXGatrqJDp5BHkPW?=
 =?us-ascii?Q?UcD/XxljJat/xO0swRayYqz29FlpORKyearL29PCQ9IVfnaZHx12FJ19eXQt?=
 =?us-ascii?Q?vkWLIiUuCw9RguTES9u4lbnuU6rY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:18.8253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e57599-27ad-40fa-6d3e-08dc7f3b01c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 2149ee697a7a3091a16447c647d4a30f7468553a.

The issue is already fixed by
  fa5a7f2ccb7e ("drm/amdgpu: Fix two reset triggered in a row")

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 44450507c140..4bacbf1db9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -616,7 +616,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		    amdgpu_sriov_runtime(adev)) {
 			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
-							  &adev->kfd.reset_work))
+							  &adev->virt.flr_work))
 				return;
 			else
 				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
-- 
2.34.1

