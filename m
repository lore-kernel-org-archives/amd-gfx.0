Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14FC4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230E2206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 09:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y6JealtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230E2206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EFC86EB30;
	Tue, 27 Oct 2020 09:04:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038F76EB30
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 09:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrVHfGCi2BQ/3eoXixqd9Xbq12fT5GBBZsykrSDQcixhwtTXrmWNhsCZU5nM3CCvO9VwO9LaO5M1AWRBMF5uvJxh7SUEK04q2FhHIkm4rODL0nYwwHpuMwZcQ8YYbsXn1yBx0x7nP+3oacqSLF6jd8Gh5GSBKtGoE/IDjhZuoED32p1QWFhBzfIV3afWBaZAQwz4zdmi8aGRu/cP+j72qK2N2gCZFX8OC9L1xbbEwEZVvm9H+a/d3leWqaGyAqGUC8vrAWSm0WVaoTeTg4Ur7NUbS9Luq6lMCFL4TMOQi2HsctmS6ngud/zf55kXv3chGjN5QjsWCWbMUZnLmhGVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNuY3lmW6Nps9EkXPO3lg5hNLMg3cfhgL6sfQweIAMU=;
 b=fDI5J3SXk0V7dUnkpoRQLJLydbhMG273G4sReYUNPW+6H2ww1qRiMDkvYc3JNFNWr60clpCdXkGQHnUyoo30FeZczdTlVM5zCAtGDlYEJLa3yaOwPRpppR+sgYueYZMW/UnqIXjN1elsXAvdr/6+OnraEsHQPD3uh2ocUszSfIjFjVRRiShTtlFFrQXZbOqxRD3gFVUcBry2yA2ciLYlhcZDMMVUGWN+mygy0VdkXKUGlg6HMonck5aUXgiBV5p4LCPiUatwAAqyF54Rb0JETVt/D2629gsYH/NVKbJZ7ynyz/drjU7MuEOHsMc1EBf8c+a0wgR950YgWnPbcAIk4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNuY3lmW6Nps9EkXPO3lg5hNLMg3cfhgL6sfQweIAMU=;
 b=y6JealtWqYaxjFm43BulADS60/n1lVlYY5ZbG2rm3T0r011MKWxI4UcH9H8aghf2jVMnimKxPNdXPrjW7Ola/pRIPnWr9O4SwYqbmrykk5nSPRVPM1dFVqOe51Gjr2pfSBKLGOpyNnfjSv+iM5n0/gFQti4kpuRo3WL4CylkeVE=
Received: from MWHPR1601CA0023.namprd16.prod.outlook.com
 (2603:10b6:300:da::33) by BL0PR12MB2402.namprd12.prod.outlook.com
 (2603:10b6:207:45::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 09:04:06 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::50) by MWHPR1601CA0023.outlook.office365.com
 (2603:10b6:300:da::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 27 Oct 2020 09:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 09:04:05 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 27 Oct
 2020 04:04:04 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 27 Oct 2020 04:04:02 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 0/3] Refine the codes about reseving bad pages.
Date: Tue, 27 Oct 2020 17:03:47 +0800
Message-ID: <20201027090347.3476-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ce6cd5-0b8e-4e55-4331-08d87a57421b
X-MS-TrafficTypeDiagnostic: BL0PR12MB2402:
X-Microsoft-Antispam-PRVS: <BL0PR12MB240246DC80211A9D1316206AED160@BL0PR12MB2402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSTerAC1xm1AN6tYc1EPtgQS+Yi9GNLH2NnNBEKfeJ3GmOKr19Qm2cwubEzd8AMQiaZW+brbVzSVGMBhMcyBOskchqxRiUoBt5yTHhKdK7TPcJKk0zm2fWv+uTjBDeCTyWtWY2GmKsRatgdHdXunz9/sT0oCYah48jCkjp7AbnoA7+7PCWYR0J6BAiC8zByLxwhs9xujwYNB/rnFzZucXeWFgoJGSsX4adxucAj4wTvlMtcfNQ0zkxca1h49KOckKTJGcZXhiJz6xQC4TuG3Jt+oZ/LH9ZrqVQhrLdPO4FMzWe3rX9NJsLB2hln+dzGaUG/Snenh/Tmlvw3ITG5N9bVRFcl83eLebBNrGaGrmoEcmr98syp3yzUbHQM1IHRhZUnhRplFdcabuzp/0O9Lt05Lb3Pf4RIbZslM1QjUwVY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966005)(82740400003)(82310400003)(1076003)(4744005)(336012)(6636002)(83380400001)(2906002)(8676002)(5660300002)(81166007)(356005)(4326008)(316002)(8936002)(26005)(47076004)(7696005)(6666004)(70586007)(70206006)(110136005)(2616005)(86362001)(426003)(186003)(36756003)(478600001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 09:04:05.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ce6cd5-0b8e-4e55-4331-08d87a57421b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2402
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Beside umc, others' UE interrupt callback could enter into amdgpu_ras_reset_gpu,
so the first patch change to save bad pages in UMC error interrupt callback.

When bad page error happens, the bad page mostly still be hold by some
process, therefore driver will fail to reserve the bad page. The third
patch will reserve the bad page when freeing it, make system has no
chance to allocate it to other proccess.

Dennis Li (3):
  drm/amdgpu: change to save bad pages in UMC error interrupt callback
  drm/amdgpu: remove redundant GPU reset
  drm/amdgpu: fix the issue of reserving bad pages failed

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 155 +++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  17 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  16 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  | 115 +++++++++++++
 6 files changed, 164 insertions(+), 150 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
