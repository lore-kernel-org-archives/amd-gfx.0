Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A2AC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC51206E6
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l/310qSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC51206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629F5891F4;
	Thu, 26 Mar 2020 20:03:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE83891F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 20:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3T6WyarZHMpyS2PoP+yksW75VVxJ5BqSbWHQ8FK7ZTjX4+czjoc7PHPpFZ6YLIGnUuZIPyrBBU+9mNj0e5HJaxU6yE5Z8OuPI8qTRSM6FN0VxUYgiuR3j4PViW8/Eane2MO5I9HomwYawXRVVBMOUdvI0HnSNt3SRyBqCQmGoXDtqOPSC/tvMRbm7VHhTqBbOW60jmEnDSyFmozm9uc6r+ASLxFXggBWtaNsab1uk7h0/avqBNVYcGouBB1ghD+Fw2rwWu80CuTaJZKW7tIWIXBR8MqWJWmfEyRc391wPyuvzBPJj6EmXWw3eqTwPnnFp1/6AM9nf3uxv2XSfKifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8gW+IzNM1nIaP3fKvjwOL27w4kErQuT8v/LKHT9vkc=;
 b=WlPfy5/xdM+OcJr443tKXs91WySeUNKJK8UR+Yhk+4y8AFFhKJoRoxE1EotM50J400SRUPyBoZPNgzi+tSiNbUU5or2feqWz16SeDQH3GqH6kw8mIg8VmP8NE9hzULngaebAqma963pkwcOaTOQJZ9KmBOMlhTIGhnV4DRHYY11c2LgcC08koWOrIIhDfWWGZpy3uNVIT2IpoQF7WlupKqNKzEDEl/TwDemc+32KLeSwzjF5+5zDjbzNvaWrUDt9wKMDvLDm008lPyalPcZvrKTRzdGwHIj+pq5lopP7kQgFS+SLI0QrM3zBemgvNrcv51zWibZ7SPGup7A3ipMt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8gW+IzNM1nIaP3fKvjwOL27w4kErQuT8v/LKHT9vkc=;
 b=l/310qSbQv+iTP6GeWqVoFMySuhwxH9oaA2+tfw7p2xV41NQymLB0rqnXAFgzvLiEy33XGp1gt024DfsmjSemmWYucBuBND30kit7NzXb5ECCNcpDRtyW53P97dbFvdMXBSOFlyGvbB2ED8OIP4PV5xEUkBi/Kyyw41oLUYawGk=
Received: from MWHPR10CA0053.namprd10.prod.outlook.com (2603:10b6:300:2c::15)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 20:02:59 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::4f) by MWHPR10CA0053.outlook.office365.com
 (2603:10b6:300:2c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Thu, 26 Mar 2020 20:02:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 20:02:58 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 26 Mar
 2020 15:02:58 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 15:02:57 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/4] Invalidate and flush caches at the beginning of every
 gfx IB
Date: Thu, 26 Mar 2020 16:02:44 -0400
Message-ID: <1585252968-1218-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(428003)(46966005)(336012)(2616005)(70586007)(356004)(426003)(70206006)(6666004)(6916009)(47076004)(82740400003)(186003)(26005)(2906002)(5660300002)(36756003)(8936002)(81156014)(8676002)(7696005)(86362001)(4326008)(44832011)(316002)(54906003)(478600001)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d5a7088-e57c-41d2-25b1-08d7d1c0aea4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4155E0A047BEA6BB373AB990EACF0@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0354B4BED2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDuRqZj8d5p8u88YK/K45MfF8OIl1LelJoqDRZb2UoAZaOC6TMlk5owVVHpm+mXid3I1aNZvVLX5HjMwHN+3XEBG5tqXyeRB9ljPLB7m5lTm+45nastLI/01Wl0jOUEuC1jGR21Yg/VDFjKIAXN1ZQS4DwSldDGkBsYXsZqQG1a+Rw2kuh0//XQb0AnzpzOsO0Xr6V27qsepnNR/7F8JTCvHLZiX+HF2yodoh+tzrt3J8ezRuzaXcKZn60UoAYITUY84c0fqVcfxXJV2tkgcsHw+HJ7ViuTSzDqC7dBma3ldKL6z2Jv5fS0WJtTy4Ys8nBWt4j9RDWZZjnpuD0Sx64keXJoR81okf62XpK8bZ6/Z6GQ5c+pF8hmlqSvHjtXaLWZUjiED/gXPSr3LBZXbgIpyxkh5AoB5Ehy+ka8+ZcsaFGhtV/5HNE6cLh2kEo4BKVkYwxYpfWkZpTVrqoK0hjyKYBXegqdtn1o23BINDjnixtnlJSLw5IWA+gi0yV8w00Hb50+QLl+bmZL54MAj8g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 20:02:58.8434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5a7088-e57c-41d2-25b1-08d7d1c0aea4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 ckoenig.leichtzumerken@gmail.com, Marek.Olsak@amd.com, Ken.Qiao@amd.com,
 luben.tuikov@amd.com, alexdeucher@gmail.com
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 27 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    | 16 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    | 16 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 17 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 22 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/nvd.h         | 48 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15d.h      | 25 ++++++++++++++++-
 include/uapi/drm/amdgpu_drm.h            |  4 +++
 11 files changed, 175 insertions(+), 7 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
