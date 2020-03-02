Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D540BC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D32D21739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 10:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DDyXUFp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D32D21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4420C6E25A;
	Mon,  2 Mar 2020 10:34:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447886E25A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 10:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXzic9VUJqsqIX0JDj/vgMvXagMsLghH3/HCTrIdcj+TzZtUlR+G2W0bE5xpMsGpQkVhVQk1XVsiOcJp/2H/YzVwQs8I7UDyfKj4O4d9Xty+5lKP0iR9EP2LzosQ9oczucs1g8Ql1/e3n3qd6LH8P5ZxaMQIhAMJuWQsoIpKoqzLIvytZ237uvNcICq7H9B8/+0fxKxpUF3cdCqQ6hao6pKS02U65se6JaYSW5W9Hb1txd+jFyKekW/EAu3925v2YiRlOhiUTOcLgeBsdrbimv/D5Q6QjP9J7GE8WY5cjQ8gDKplQqTZ5VGlhef9Y10niPB3cqx3XLdR5fUffTIuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d6yDLgU1owm5mLr4Bp6ZV7AaF9/1P7nPwrQPYUX1F0=;
 b=jlWUAJ38ZG8m8eI/p2W7EaipbOnZ/742bZ1KQ4BNW6bER88YNVjG44P43aNnZJAy4SoLlY9UNPLahX5lyddP7u5Cuai5AnISaylZf1zowvIC5quohic+yMyGQmtJTSHWn0D4Cp44zgLRZD/vBewNvGJHxdHNtUGqp0Vb9P92JsM8m3FCBgEXT9QgLNvzl43KTVsCKZ+k5cnYQtXHx+2B4x0NyHjSlNYspnYNYxR06ztRyrbqPMKxTi47Z8Jx9cbBm9b2LNgKikexDEmx4XnQe8/hpdtnvvk5wiKrnQT/ydY+wth1gaFXfBLv3rz6FSdvxuo3ncRU2fRO/+yQp5jy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d6yDLgU1owm5mLr4Bp6ZV7AaF9/1P7nPwrQPYUX1F0=;
 b=DDyXUFp2w2xpbyECNoAFgfJQRc7rzpwhGBtp060chh895eWjynigXAkLOK2ZID2JJJAGEQIQ/lz3mWDnqDeGxI2AB6seeOLh6O54mqQdPcRXC1W4dZQk9UFzeS+RFu2IFCSiLxviRHi2rNhfJ95rf1vYppnPc8QdgMiXj3CQ+fE=
Received: from DM5PR18CA0066.namprd18.prod.outlook.com (2603:10b6:3:22::28) by
 DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Mon, 2 Mar 2020 10:34:19 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::69) by DM5PR18CA0066.outlook.office365.com
 (2603:10b6:3:22::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Mon, 2 Mar 2020 10:34:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 10:34:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:19 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 04:34:18 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 04:34:16 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <John.Clements@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Guchun Chen <Guchun.Chen@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] reset ras error counters in initialization sequence
Date: Mon, 2 Mar 2020 18:33:35 +0800
Message-ID: <20200302103339.31723-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(428003)(199004)(189003)(186003)(70206006)(1076003)(26005)(86362001)(478600001)(336012)(110136005)(426003)(316002)(4326008)(2616005)(6666004)(356004)(8936002)(2906002)(6636002)(70586007)(8676002)(81166006)(81156014)(7696005)(5660300002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3035; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7dead0-53d8-490b-eaf4-08d7be954415
X-MS-TrafficTypeDiagnostic: DM6PR12MB3035:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3035C07FE64FC043A8E29E28FCE70@DM6PR12MB3035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIsZ4s+AA2ZzJYaJbhI+iR8KOtS69Nx5XlqaM+O+kfe+i3umSAdjhkFpUoi9LvH7W94JLgeM7H5vbmGTyUTZSnsp954QsoHPgNBac5gehIOLsMyvXOiUFrxfARZ1edzoOcw2f+s5K5Vz1tEe1OwOAQbir2WWpsLfZY6u47My8fTNS5CtLoq9XN4JUOYpBBHOs12L+ePLFmRZMefoXiEWw15jq4wDhQiPL4vGxgFI/kPCji87PqnDx6GUG/aMKtSL5t/+oJDxhkGS3fOIolARwI9hDUodRnpKrDwSMTISGrBOHpGvatoEuOsXuQuy1Qm7bWZdEY866wQ6npy2scy7h4yC9O7zBr6QK2+4/uchb8pfXlWYQTQBDRESqQx3L5hZhqiq5HMKA7rA4YDzCqyYZ39wskla4n/iOVv82YTcpFuDwNKEqlpjvzphM3EyWxYf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 10:34:19.7016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7dead0-53d8-490b-eaf4-08d7be954415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3035
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The RAS hw error counters in most IP blocks could be dirty ones
after cold reboot. Read operation is required to reset those regs
to 0 so that user won't get random value when query those counters
via sysfs nodes.

In addition, the reset_ras_error_counter is also important interface
for amdgpu ras tool to force reset hw register counters.

Hawking Zhang (4):
  drm/amdgpu: add reset_ras_error_count function for SDMA
  drm/amdgpu: add reset_ras_error_count function for MMHUB
  drm/amdgpu: add reset_ras_error_count function for GFX
  drm/amdgpu: add reset_ras_error_count function for HDP

 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 27 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     |  3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c   | 12 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c   | 12 ++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 20 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/soc15.c        | 14 ++++++++++++
 12 files changed, 72 insertions(+), 24 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
