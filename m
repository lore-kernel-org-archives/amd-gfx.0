Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02282C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833AB2469D
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 02:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i8GBCnpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AB2469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376606E1B4;
	Sun, 19 Jan 2020 02:46:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26986E1B4
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 02:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXn8pYJnBTBhuPFdZyexqlkEllrfbZi3587Ws/VifTzj0qcl8r+2ZqMKaXfUnghMaYMw3pvqRTiNsHIoIIgjew52JtWhNBPWB2KRa6os4gFYew3DgyaK4SHAhj3i31/5K3ROdxRictsJkHdOi8+8AASAL+dS3nPICfLAQOVtBqOdXzFLpR3sh2QZyobH1wY+eZ1Jq+4GsSlm9WhkNnoSma7N69jKroAZoVPFYkY69ocum64xYoH2gZY2wPWA2WX3VX6c/2HaO+6EBBcDsVTxmCum0Y4W4icHrQCW2PlS7EraB9XfRI+x4nBx8pFCKfG+uoGL+rURP38cReNHZDuZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6q+h6fDQb8Aqa7teqgR7CA/c0f8Hz8QsFwnPwZQ6uU=;
 b=IbD27JjflTX/Q4o+zIuqnmtlzu0qlRPuwv8Pr+GFwURnm2rkootjCKFhc2eCM0gfvvr8uCgBXitx8JIiwGj01Y6jgpJ4HKHzWjsEmuSsHClJQUXEco0HWcFt62nSVvR6HWD9CzgqJJQ7FLpMgeLg9LN6KjDAC0lfqDV/RLK3YN/SRhyDS5DFbOkBcUhTQcimSKSrQS7md/3wsPh1T1sGMH//AyfiW5081HkUd4GQPelFXbAf32uTcTDLQkQmqVCVNOJcPaJx8jyPRuf1SMYjOU30V0BMZM8j8joD3vxPgR7MKpBjc+Sn08Gf4z2Awz/zls5FT2I8zNMcs/xAPlySiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6q+h6fDQb8Aqa7teqgR7CA/c0f8Hz8QsFwnPwZQ6uU=;
 b=i8GBCnpW2Q/9YOxblNwrgLlPtk0d8ZraZFL8xvSetRA29yi/NIUCqr3z+n6Oa6u3V5x3ZuSu9UJ1NzT+7UVLU0CwAYw8G+h+eakFCpt4FkqGd8CBRDFVOmASgPXm7ZR5/HK94EBx/WhYKmp16ABDZU+hUPp3UExQoisQOAUzOSA=
Received: from DM3PR12CA0100.namprd12.prod.outlook.com (2603:10b6:0:55::20) by
 CH2PR12MB3655.namprd12.prod.outlook.com (2603:10b6:610:25::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Sun, 19 Jan 2020 02:46:14 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by DM3PR12CA0100.outlook.office365.com
 (2603:10b6:0:55::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Sun, 19 Jan 2020 02:46:13 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 02:46:13 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 18 Jan
 2020 20:46:13 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 18 Jan 2020 20:46:11 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH 0/4] Enable RAS feature for the gc of Arcturus
Date: Sun, 19 Jan 2020 10:45:58 +0800
Message-ID: <20200119024602.23079-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(36756003)(86362001)(2906002)(186003)(70586007)(70206006)(478600001)(81166006)(81156014)(1076003)(6636002)(8676002)(26005)(8936002)(4326008)(7696005)(426003)(5660300002)(2616005)(336012)(356004)(6666004)(110136005)(316002)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3655; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 982d6eec-5983-4c2a-63fc-08d79c89bfb0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3655:
X-Microsoft-Antispam-PRVS: <CH2PR12MB36550B069A96FFE30BBD3E54ED330@CH2PR12MB3655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WooL6WlPggmrmW7FUY8+0bd1JJj2lXaqnfbU7wWU6qZxrh1Wb1WESTZreuEyO8Fbj59dIt+s+oyFV4SMW3TBU/aHpxufMRngu+SSAD0tqfqDXGbXOS6PIHvOVZOOYbmclNPzzI+wgSlpfuCExpiLXF8Rq8q3yuXV2kT9Jcgdotlvv6hWZIlNfjUwrAKdHoyPoZzchQ+WjZxxEEJP61Q4Xa+ADNcSGITUIRF9y0JH5T7hGRp6z+/KHvMcQxkq2g68OyG1h7SjuHh1pbMgfiZheOOeme34qCh7eTixiQ04+7MSkgrddY5VKddALiAeLc6XCmC87eQUD1vFNyRge5gJhxTP44UQ6ipmgxPQlIpz4Sn5ZRSZOHC4cddxeoYe+unKwSplxbWZ2UAGuRnZRL9PuLxehr8RkIoC2XYTuAoPhnmwL4neEjzdnQdkzuQ7VUyE0f7pDpXCfygG+00jxeRtd5qOyERp5uKm+sSYLpP/dnU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 02:46:13.6245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982d6eec-5983-4c2a-63fc-08d79c89bfb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3655
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

Refactor the ras related codes of vega20:
1. refine the security check for RAS functions.
2. abstract clearing edc counters to a separated function.
3. add ip prefix to ip related codes.

Implementation of RAS feature for Arcturus gfx:
1. add new register head files for gfx v9.4.1.
2. add codes to support querying of EDC counter and error injection.

Dennis Li (4):
  drm/amdgpu: refine the security check for RAS functions
  drm/amdgpu: abstract EDC counter clear to a separated function
  drm/amdgpu: add EDC counter registers of gc for Arcturus
  drm/amdgpu: add RAS support for the gfx block of Arcturus

 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 138 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         | 978 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h         |  35 +
 .../amd/include/asic_reg/gc/gc_9_4_1_offset.h | 264 +++++
 .../include/asic_reg/gc/gc_9_4_1_sh_mask.h    | 748 ++++++++++++++
 6 files changed, 2128 insertions(+), 36 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
