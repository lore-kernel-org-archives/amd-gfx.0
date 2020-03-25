Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC53C43331
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31052070A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0uui5Pjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31052070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEB16E86A;
	Wed, 25 Mar 2020 14:29:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97B26E86A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDfdX/nVklwSIx9a6ph4u+QGEbQzpA2zE/4JCUCyHtEgpY4wu+AbOO8oJdUCIpQ1ZC6g0CqvK4tsopvN7OKCm/CTcYpEAg42zGZvOFn7frVCCHamoe92xAEUMzbbet/pP62qYemjJ/zyw6z7ioDMLBX+i86rCRj2ZRTpQ4L21SWLCiHqRASElGx8f3DkB5a4j5uXwhpRZgkoH+CALpKK4TazHuFpHS5x+Mqz2yMFj7DUVZxEGvvHTT1N/6kF4uzHtLhP/PsqM0nZvICIAOEQ3RWqf+PXKuCSie935fmkkt0F6+Q4nJnIevlW3+iAmZ1HEnRpRmbizWXCLd/lhRJEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzhJP5vNARSGhR52NptYd2OdxoktF+Xysrv4rwR9VEo=;
 b=n+t+qm7a8IXF9YvkbAntp0YVF65/4Mzltk0sz7nGCfq57WqtcpTgpJSiMUpEmTiwn30PPsWrmB8KVYOBjY+huAXJ4Xu6ed0CD8gwHH2tiVRXa/E8mAc9V6FmHYiOOhQ+9o5zmMQmmUZYhPQdlfjpyrcNFyTB0ub0hlpei7M8XcERu69ItgewRt6MOeFFPi0JeYdfMGPWNwWsduEyzarAt0Bq3dtz4TZh/ip3EDnCZD6TFeeMRvlLOspMpYdEGt5qnbG8anQVtcTMiIguqxuJQ2shEdJ3BnL7HBKukWEWIPd20TzRR3WteV1M3rkcp1VrcWvye9wNzVoyaD4/Z7BhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzhJP5vNARSGhR52NptYd2OdxoktF+Xysrv4rwR9VEo=;
 b=0uui5PjdSavkcRniVOahYkRWYdSx7MBNKBcnhWYS/cgR8c+33NDkngfxPJZFG5N5QTefnVqG8nbs7nUD5Lf6+pLgpyFJpt3bonqISI786gb65hb3qTbyzx/885Nodvl/u2304CpQRi5BO3vEMuphguK45j5E8iKT5sQqVXXcw54=
Received: from BN6PR16CA0048.namprd16.prod.outlook.com (2603:10b6:405:14::34)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 25 Mar
 2020 14:29:50 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::3a) by BN6PR16CA0048.outlook.office365.com
 (2603:10b6:405:14::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Wed, 25 Mar 2020 14:29:50 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 14:29:49 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 09:29:48 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 25 Mar 2020 09:29:48 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Invalidate and flush caches at the beginning of every gfx
 IB
Date: Wed, 25 Mar 2020 10:29:36 -0400
Message-ID: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(428003)(46966005)(82740400003)(6916009)(47076004)(5660300002)(70586007)(26005)(2906002)(70206006)(36756003)(81156014)(81166006)(86362001)(8936002)(8676002)(356004)(6666004)(426003)(336012)(4326008)(2616005)(186003)(478600001)(44832011)(7696005)(54906003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4272; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ddacb9b-92a8-434c-745a-08d7d0c8f9a8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:
X-Microsoft-Antispam-PRVS: <MN2PR12MB427268B550C14B10084427D2EACE0@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmWAuJK8BWPHHjLTb46kc0xej5oRvcIZfJ4rAST1OKmW8aLD9deiFHCULU6EHyIv5VJ9m+O12q61A5dKVEdPwvt6qNSR89i6XECSFw3LbgGZFxN76FIa25hu172ZPr+EERYB/IniS5r4/YoGF6BP0qwTU6eEK7Yszv5zOAI7FnPU0S3WCKA8J9lVTyO2HFwsLZDP2CSU0xwIgNy0OFZFZK4quIdSXkFoLB7ult3e/VrQTfGz4poICCmkQ4hM3LfH66SYQP/cEGpmpaMfyC0KQ2d0sh9R3fTJG9fzWQ45CIHPURgRW+0JWOtsQ0rVnJZ8hzDugQ/KwSaKyonipbiMsMKV1wphDQV0IgDfEkd0eXcwnA39Bi9vjZEPhYoOOMNozU/swC5Vu3CgYMlJ6Iy/QVKvRX5gplcHqrGSocApm12Ixtvog4YSF0Ymsi/qruTd+qj9hEXSHpsxlXcO55QYHnGd8DaMYd8RDAg2DKg0EdkcOA2kkEs0vzNwbU7awAZBUHEG3nH3713Mu2fgnWgHsg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:29:49.6388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddacb9b-92a8-434c-745a-08d7d0c8f9a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset introduces AQUIRE_MEM packet submission at the begining of each gfx IB
if requested by user mode client. This is helpful in solving issues with cache coherency
during amdgpu_test and Vulkan CTS tests.


Andrey Grodzovsky (4):
  drm/amdgpu: Add new ring callback to insert memory sync
  drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
  drm/amdgpu: Add mem_sync implementation for all the ASICs.
  drm/amdgpu: Add a UAPI flag for user to call mem_sync

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 27 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    | 16 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 16 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 17 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 22 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/nvd.h         | 48 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h      | 25 ++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h            |  2 ++
 12 files changed, 178 insertions(+), 6 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
