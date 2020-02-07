Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD67EC35247
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709BA20838
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mTu8f+rU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709BA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05AE6E48F;
	Fri,  7 Feb 2020 00:09:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9276E48F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 00:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuwUX9dbHMsME+Yr6oiUox/qp9GTbKDXrQe1fmWI3lam+J+HNq9EjOkTGRUATwdRMLN7s2E8H/JtuZM+gJr0HpxV847jHXIfcBk8JxqeWrCLo966pa7JilliY3XMsxh2fGqUenGB4imz60j3ptfJUscrc8rGQPhTpz8HEAM0GVElPmGxAtf0UltPHX/us7LN5ALDFI37jfPe2WG8wy4YkRkPLqhGheUIFjJgySon/fj+bqIMhU4SQzTOXuSHE3ZoyhmPwXhYrKGCVWItkSEe/Wm0DtH/rwBvn7iKlz6TFMLx1eE7hJktb3QvhgbZXpJELBnOtP3oX25sLaxC3buk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mprAfpRwgHicGzwyzy5PV5nbcnJcFIf1lUUYPZ3Wwps=;
 b=Tgg0u0XSaKLQDL+kS8P6URPsqe/mE6uc/u70fSuqlkxIeuDYMu3cxBPI/TCQD214N6c66G2vtmA73uX1Fhnvl/dT7nb/B5LIsrBMc2FOfttECxzU0wLksnhbTyVxCZE6i7OC/xC8czzvJxiBc9eVjt/DanW9le7VRQ2nmuQvvh2kw+dk2EH+NKLOmWX0CWLCIOMYDUmr1sqVTss6G6Kb0TdJI/rrIRTVbASoimoE2wkm09R65C2pNRj0dWdtLJa/Yi0x4jX32wD8qsosAbppO0+kl3+jlUOsNufUT4cKKwdTTq8YF0Wh4k8zMa3zD3qoBf6DPLkJUT57uArLH25lAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mprAfpRwgHicGzwyzy5PV5nbcnJcFIf1lUUYPZ3Wwps=;
 b=mTu8f+rUZvyDquOcskMdk5Yi6r6xS/FuHk70Xf9Fg3CRQ7Ds+bLAdElb7DvHtnRzMTFUtNkOUdoNvti5FNJrFwettMtbl3wTbjOnaX5rqzIAORVGZQqzmeR9gm0+Rhb+s16TiZLR80kUc/Uc/er54z+IZFMLHYZFOkwUbilehuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Fri, 7 Feb 2020 00:09:24 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:09:24 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v3 0/4] Enable BACO with KFD
Date: Thu,  6 Feb 2020 19:09:07 -0500
Message-Id: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 00:09:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6d1efc5-73b2-4c04-8f65-08d7ab61fcc0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15308DB82BD4225B9F9BBEC6FE1C0@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(26005)(66946007)(44832011)(66476007)(5660300002)(956004)(66556008)(478600001)(6486002)(7696005)(6666004)(186003)(16526019)(2906002)(52116002)(36756003)(316002)(86362001)(8676002)(2616005)(6916009)(81166006)(1076003)(4326008)(966005)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFkW31vhMWSzeOWL3T3krXMadwDI5VQSej89yePa/EQXi3I6K9yHdnKxHgepwAUsAyWGElObI6uqTC23iDq9/2clXSHwU/16tFldrnIlR9OWCcksOi2UWlcxW2GzTtGFCfHryTK1inYn05O4QOXbKmIicBFmvEAZ02LJRc25sq/FGKBYTJfVaTZYn030Lz/1eC+WzfmS8/5kT82oXlCtGpoqoXCB4sK/8kamyoQjs3kXrvtsh8iFZJLLaSf2qlc6RIVyz0/2DsGytKKZbfa5yzVpuPWaVqsgEYlBOvLzAW9R1bgLoSvbYrRx6sZ5WNuLCE13EjlctzoVPxdOKOQ9lhLmSxTgXk75VsHtrEEW3KrMylcVRpIUoGioOR1Z0vN/dhn45SW0Njhg14PRPaGjECgv2lotWwCZ/y0BRyhws/lSf+RGFrctmunxpHlw2DrziA9P7+1AEtKfSJiiA13bpaO3kZkkFERT4yhleJJYzsOhkqdCIxGYo8CSTxiXorLYGl61pIae9T75vDtEwH+sNA==
X-MS-Exchange-AntiSpam-MessageData: 88/HnnfyhXwKLUvXYlCAkyxdKxAXjVNCJ1TvXP/l1wz2SPtsId6fcPIaiCkfMNqRZIYLDn5FQyil7ctRXjT/MxbqHAoELtzc9VmH3VicnmoUBuYujtBExZoIsRMvfJI8LXdCaSgfi1EjqehijSnNRg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d1efc5-73b2-4c04-8f65-08d7ab61fcc0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:09:24.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1wRrK9hQnY98fT6+v4zpQUUFub4UrM8wEOwUl5QGimsU1jqzmS5qLuZfnb6+6pK5KAzMVSUw0de3Fm3d/zxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changes in v3:
 * Addressed review comments.
 * Rebased to latest amd-staging-drm-next.
 * Slightly modified patch 4 to avoid runpm on devices where baco is not
   yet fully supported for runtime pm but still is used for gpu reset.

Changes in v2:
 * Rebased on latest amd-staging-drm-next
 * Addressed review comments from Felix, Oak and Alex for v1
 * Removed 60 second hack for auto-suspend delay and simplified the
   logic
 * Dropped kfd debugfs patch
 * Folded in Alex's patch from this series to enable and test with kfd.
   https://patchwork.freedesktop.org/series/67885/ also fixed a
   checkpatch warning.

Link to v1: https://www.spinics.net/lists/amd-gfx/msg44551.html

This series aims to enable BACO by default on supported AMD platforms
and ensures that the AMD Kernel Fusion Driver can co-exist with this
feature when the GPU devices are runtime suspended and firmware pushes
the envelop to save more power with BACO entry sequence. Current
approach makes sure that if KFD is using GPU services for compute, it
won't let AMDGPU driver suspend and if the AMDGPU driver is already
runtime suspended with GPUs in deep power saving mode with BACO, the KFD
driver wakes up the AMDGPU and then starts the compute workload
execution.

This series has been tested with a single GPU (fiji), Dual GPUs (fiji
and fiji/tonga) and seems to work fine with kfdtest. Also tested system
wide suspend to mem and suspend to idle and with this series and it
worked fine.


Alex Deucher (1):
  drm/amdgpu/runpm: enable runpm on baco capable VI+ asics

Rajneesh Bhardwaj (3):
  drm/amdgpu: Fix missing error check in suspend
  drm/amdkfd: show warning when kfd is locked
  drm/amdkfd: refactor runtime pm for baco

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 10 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 40 ++++++++++++++++++++--
 9 files changed, 81 insertions(+), 28 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
