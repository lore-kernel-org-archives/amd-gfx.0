Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C393BC35254
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A43220715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="APJIOeeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A43220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D98F6ED0E;
	Mon, 10 Feb 2020 18:48:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D416ED0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMustQU9gN4+knldQgAleHdrJzvy541vQrl4I0Cprdd/8/pIGRIg2vLix/7Ak5belfjIeH2RaWLHtfxZh2+hMjnYaiH4HcLPU6+B4ptWsOXP3w9retvsPJkj2ttXgRZgLwgWvLwsBesq8KR1EMiL0k/J3aax7c4ymqjo0IxaHc3keRYGP/Irs42gGEgNbBxhjuKKmQ3Tfotxz9W6st59laj9wJuyHO1G+MX4l00i4lpL7mqvXdJ8SOwGkk8Yd6HfV293gS1xid5tGIa65yXiaXHsB9viV48KDVd5HMNhgIbfp5ZYGO2Q/wt86jjVnS95jy2714EWwzRhZVFhPzAmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOBE9IV3pRHP/tLNYYuC6S+Ef2L/4ttycwdpWuIxtD4=;
 b=ln3wWYBhsqkJiMAOP8Q10K+/qX3NhnG7xl5I5oc24a5yPlRYVD5MVQ4BYg57M2QlwMMn8MXQpUuR18QFU6VHHCxTEy0GEU2cKHY/MtYYDW4rBi7tspgEtL2zHLS1K+RWVYx0yls9rB6u0RN1TdemdtA74EwogmZuqhTI8ToKK9bkfRW0fxT5mRXHxtGTsiDo81WOD54wiM+FJtnZumcHbHEveZ+oeDlBZlhfI7FtiKyWLTqHr1vbNUn0iJFFihEWcFag6d9w6Hao4jdt1iX6Kqsuybd5bb42AqKoJv6KU+Z/co+xL8tHDAghtvbsj02iM1HNpnI2EAfOxbu1h/TVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOBE9IV3pRHP/tLNYYuC6S+Ef2L/4ttycwdpWuIxtD4=;
 b=APJIOeeWsJcbop7yGc9upBMLBJS1G9lDlSRZWSvOWbNeDIkfkOWuaNXEazTsyBxxsKzOi4hfV4DXZsXHg6cXX+0XJDDpS9E0YK9aLpPsQPF6MHgIBOoCea2L8aIU+kVudm9e+muC0AoiuLHELTX4gJNSWiUT8w0cGty1VXAErEw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 18:48:20 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:48:20 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v4 0/4] Enable BACO with KFD
Date: Mon, 10 Feb 2020 13:48:03 -0500
Message-Id: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 18:48:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 093c8800-6a6a-48a6-6f6a-08d7ae59cc72
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB238449AEB122173C6860A8DDFE190@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6666004)(4326008)(16526019)(966005)(186003)(26005)(316002)(5660300002)(956004)(2616005)(36756003)(66556008)(66476007)(66946007)(478600001)(8936002)(1076003)(8676002)(81156014)(81166006)(2906002)(44832011)(86362001)(6916009)(7696005)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ89NO6tZdsZNN/lxZViEa95Kq/ehEu+G3qYg7KbsXi7XdIP/mFENV6xRflQfQJpdwmsz7nVviunXBeGZRcLa31we2Jqw5eyUAVp8h6N6ky9a2uugjmUhXc+Bojtv0qySYQQxaNSK7kXFAgGpiVjtoqy0Ors+hCzFp5iH2xJlZGS3MtLMQdDvyHsxawZoBlf2epXiwPonL0N5uBksxelukmjEyAlGM+9DDlojvZheNdI2CjIaZd8yiovE6AdAQF6K7W4CIMa42gtXYD6obzu92rggxbBFwxhS4APs7mqkXGLiugLMeO756LL8g2rd5HuZzius+zJ4Fu8weM7XC6Y+KKUtRDt2rBYgnN+dF9Te4KBXRO+r74wEKtWeZXhE+dudEikCBov7JgrSAfM0U7UFS8leFvQX2RfTOgoQWqauJ7XpVpwhxDlXuPZY9jRq0ZI/sdO+dfSITA48cdHVbJPZGFvDj328Mk3dyec154p/c5+KPhBYB35EkvRV2w88wjdJHoNY5xePM7i8cg4YG1nzQ==
X-MS-Exchange-AntiSpam-MessageData: EN3z3tj9cOS28q1GItM9cYEVApnA/N+Q/UgD2nrsqMTsEPiMwKpVFKdVMNf2vg4qpRfF78Ix14RmpXR1AKC/Ci+hD1aAguVu5MnNOlLWP7JlRu2WUT1c071w0xL86PaCGj/LkbNR8NulAInl6XeNCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093c8800-6a6a-48a6-6f6a-08d7ae59cc72
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:48:20.3847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0ddBXT0MNb6Ce9ukHaW+QmDQElbSpNrK775pwZMJVY68t36e3pLcWcHG1PjFI7wFIzyt1rbdhxkCYIkfEYthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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

Changes in v4:
 * Addressed recent feedback from Felix.

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
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 ++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 42 ++++++++++++++++++++--
 9 files changed, 83 insertions(+), 28 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
