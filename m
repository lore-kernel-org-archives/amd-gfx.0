Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC96C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544DB61D01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 03:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544DB61D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59116E919;
	Wed, 30 Jun 2021 03:47:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF356E919
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 03:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYURR6fqlbCzXaN+tg3+VwAQwlRqqXPs31NbxrBq1zn48tl2hfmmsgNhckf0Oy25maWm1B5fS+hFX6X6D91AvC7oGR3gSaTocqARXyjMg9ToM5AGHRC8wj7vrsRzytrE4mCqj0StjTgQHWu9SK1nPEpn0IfN9PRZTZANsy8TtRsjESI9Gf2Gkwucxu9AyNCp/fGTKikfhlzA6BRcIIf2jkok7kOybswfdBU9zODNxxWXSIl8pm7YFP9fvG03lv3QFzKaXA1jGKdi0UTr8sc5ThtW3/YZ64l6R4A6LvnGxfDM6sDTUCnD5vK5fSawfqeMV4ALMeTgpYmxKDYDStUAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3jw3XdiQDELm8asSPacAM6HIeUVBFoYWpd1cgoPV74=;
 b=BH/q3Es20Ujw7yJSzT+B/50E+eJUWrS35CHAL1yNV7tAA8MSBSvW/xte1zUpI4vZKBsBhQLWmMZeKqYYad5ZPpHnc8W3YTaEeVpupJRQUSOgwPtnb163tY6LEYdbkVvhkL3E2r8qIzRM2UPM8lOd0V4WGXAelqBQNopY2P9KMGq0a6FftgB1DeUR+5nn26FDSUBPVWEfPyF0z72cTs3Twu4ORv/OLT0NXwBBPMa89ojNX+IjhSETOuuMYM5ymhxF5DJfWLzUH9rDVJYn2Hr8KEzwk+Hhw2z5mR+8EGG753VHwt+6i8qsQozux/v+ndnYjcfYymkiwNNdn6rlJsWd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3jw3XdiQDELm8asSPacAM6HIeUVBFoYWpd1cgoPV74=;
 b=Dgj0zosUjqn4D0Jp5zoCnqLzplWf9ka4JjEM6NCCR0UHjRVd8jNQLOvNTFHtc8HwODoNcrsAui1/JMP6yRznDPzynkFJvK9e+WaOERyY73Lfwx9AOXe4yT6BNs//Ss9UNokmcjmYm0hBjJ15KUBQQ5XI9qAPce9JPig107kll5I=
Received: from BN9PR03CA0457.namprd03.prod.outlook.com (2603:10b6:408:139::12)
 by SN6PR12MB4717.namprd12.prod.outlook.com (2603:10b6:805:e2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 03:47:25 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::48) by BN9PR03CA0457.outlook.office365.com
 (2603:10b6:408:139::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 03:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 30 Jun 2021 03:47:24 +0000
Received: from rocm-perf01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 22:47:24 -0500
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Put MODE register in wave debug info
Date: Tue, 29 Jun 2021 22:47:12 -0500
Message-ID: <20210630034712.304515-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a14106-9e2e-4237-5e6e-08d93b79c5fb
X-MS-TrafficTypeDiagnostic: SN6PR12MB4717:
X-Microsoft-Antispam-PRVS: <SN6PR12MB47170DDCBA3484D8FAEFFC4AF9019@SN6PR12MB4717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaaIgKLZjyAbKdYShwlOu4Hy8AYG1tLspLCk963gXx9YlDOcYvJXuyWmwPclS9aw+LiW6qqdhuZTn7kwAjQyTtmv8SfKdQbTamcJpY16Zuugu5x/ApO4T1dv8Rzq3zUb2mgSejl7yN07pi6STExQ0OGSyV+uCUEFHlfyoI28UJ/BSGJ31NUcRU6PvGfy1NJW9rw+yh0EXY/Yi6+ghtOtundnXaj4Q3mNnXTBqioGAEe0tbAo0S2xda0wsw7fYVaIcbNWGzNf0svfoK0uojOsdCe9XsrQQuxRA35ZtlMibox4nxl1ZEvykzND7NTfWhSQWAo5zhmblXxu0NZaKXJ3juUlhUukzNkrg9p/RXSe+IZWk1OmPuOckO3QSeWgQqqB/h5BWlNgs9zjFcACuHVwqVe81sJQnpSBuHRjwDFSJyMsE3UpqzABm00dhVNrhAC2KxIHJU8igtkoGfltmdzX4oUW/dfJ88Z1i5SxIUfVFrwZvvt7D7M+Cg/rdPxRn94fvaWEXwmahC/UrJMREKXwIPWpTi7JhacCSMDXfNx6iizuSV0yguY+L4aTjrf2K+6anNE5l7lDwc9p8739QOtYlFx13kZbMONBh8IikfmUMLDGsoHgDW40MXWlpVSwSfTlOXnt3hdwKPRYjQAr0PxZinqbTHmj6kk47MBIGiqFJzfHV2+ne+aZq5gMqPjWTjOjnL6ib2thMFszUBhOS112eNUGtGN2MRVx/DsffnyjMI0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(8936002)(82740400003)(86362001)(2616005)(82310400003)(81166007)(186003)(6916009)(336012)(426003)(16526019)(356005)(2906002)(26005)(7696005)(70586007)(5660300002)(1076003)(6666004)(4326008)(47076005)(316002)(8676002)(478600001)(36860700001)(54906003)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 03:47:24.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a14106-9e2e-4237-5e6e-08d93b79c5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4717
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
Cc: Tom.StDenis@amd.com, Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the MODE register into the per-wave debug information.
This register holds state such as FP rounding and denorm
modes, which exceptions are enabled, and active clamping
modes.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..abcd418e51f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4517,6 +4517,7 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd,
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
 	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 3a8d52a54873..6a8dadea40f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3027,6 +3027,7 @@ static void gfx_v6_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 685212c3ddae..37b4a3db6360 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4198,6 +4198,7 @@ static void gfx_v7_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v7_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index c26e06059466..e0302c23e9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5279,6 +5279,7 @@ static void gfx_v8_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_TMA_HI);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..d42363fcf068 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2080,6 +2080,7 @@ static void gfx_v9_0_read_wave_data(struct amdgpu_device *adev, uint32_t simd, u
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_DBG0);
 	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, simd, wave, ixSQ_WAVE_MODE);
 }
 
 static void gfx_v9_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t simd,
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
