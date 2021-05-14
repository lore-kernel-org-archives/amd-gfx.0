Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0711F61446
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0711F61446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D126E44E;
	Fri, 14 May 2021 21:07:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564826E434;
 Fri, 14 May 2021 21:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvPBm07qgFwcXAJYujEjHETTys2kUTs4mbVSVYOAMqtTM+hG8rht9lG1GCswWafQL6fPCwy3Uqyry7TqA9s6ffNf8U4kthJor40VACp00HJTjc9u9XqFaIaJKuW3NtCDDlqfeEl4P4GJWFFgWRJVVICZzmSt8OFXr0HrE474Yk3AZArhDsiPAusSG9gkltG6F54LRmtjbZXvmnr51fp7pK6izmOyZRnzc1cYgaENFJqvpvKBLiq57b1i4aroqtVC/Bj+I5KVk0a/gFHjuGDFGegYJRvAbClATkWqRUVCpwKoZXBo1y4Lg3HOhu09w9BdnyCN9GKXZ5mk+UNM8eCCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tykfPw1SgIy3mf4F0BWfkwNBQ/IdQG7m9E+5EiglpWw=;
 b=b6h/2cwqfj5Pk7XYgIDc+RFVAP6vbIcA28ih9Je+o6CWT+GgZgdoNlUVlvoJ69rjGsrk+ZXADyPUKspBcOQMT6XjJ2kmlktBjRwayfPWVT5PxaBGTD7a55vZN7LPFLyk2+T+EK1K8DyDWz+1Hz1DPzPp/2ACJSVugeC63LJ4mkXKeP+0nfaNq6yADLBA1QOP2rmbMOycYjsYnB+ntxqIR6RYNuOlFJdYSF1A5Rk7XByZueh8XzI4V+1J4HKA/lJmOviOWV4d1ysdNwfDtl7Xwgo1PDfWjvMFGkCUj9BBX82qJ6C4CSVsWuOkYTxcPQTqDSyoyjfYnqMaNzQKWRhpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tykfPw1SgIy3mf4F0BWfkwNBQ/IdQG7m9E+5EiglpWw=;
 b=cmp6czTczfUF9Wf8wJcwRWlemJ7U+LIPKHLIriANTyXWhNOLURHRBCY8/YaOqHtT5tlrVUM3KLHV3z/QZ3Gq0izYceU4dcPvkK1rLlCO8b3K2ynr6z0d40LY5w2i1F74xeu3CogfzSOH8A5TCR/kQiDzySHF4kIrxDl9CRMRgH4=
Received: from BN0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:408:ec::23)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 21:07:31 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::9b) by BN0PR04CA0108.outlook.office365.com
 (2603:10b6:408:ec::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 21:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 21:07:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 16:07:30 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 16:07:29 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <ppaalanen@gmail.com>, <sebastian@sebastianwick.net>, <mcasas@google.com>
Subject: [RFC PATCH v2 0/6] A drm_plane API to support HDR planes
Date: Fri, 14 May 2021 17:07:14 -0400
Message-ID: <20210514210720.157892-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4426526e-1455-4610-1e8e-08d9171c497d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3367444B19887909382BCF248C509@BYAPR12MB3367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXP7HIEbd07sBzfmSKxm7+NgKv04qEioX0l8C9uxCgRpgYRebdRH7NVbO0scWu0Rcc4qPUQgjFi0GLCTgQPYva2LgtgM7kpHajPIPA1EbqTWsKduTSRBDRyi5ILRKyknx6igOVxeYBHlx6TWgN/wg5Q9EfIV19wsrivaljcPvKb2DSF/FmE3V+Y6RiqnnQOaawHainBsCPS3SIsdPrJ/9QeJdQRWY8sldxAIyYI5h+cwiixFD8fthuuhbe1lB4eREcEK96H+5TKtxkqdjI4NGFMA8uDDTzlLgxcRMkc9VJMHTbrapqi91HaXHcHUNRvMiN9F0U58R2owk8zwMw+dtc8mq1iMIdwpNXonWouzGs9bQ1Rabw5FKoQumzpA3mwH9qQo+p+CDho79s74N/soZXpMn2Une6rj8N5S+Or6O50m8BylOw+HVNaJyGm3YrS7993v0NHlXg48yIVp8yereNgugaPOmRI/mMLF5EgKdqmzqQydlllWJUhFv60vJuXk0FapaB5Tturb4FxgnO12ApidJNcJFjl9G96rFgfHgWrlfHskzysYPNS2g5sSYZppljNPv2XLWQ4x4IZZPshQkAT6D+s38PLbHrGdz2SvGNtY49soeieBJvEKy9b8QDFCR6uCEeVEKLFAr9Fsed+T033BlxI3aXNnmiac3k45Y1qz4IWTlli9So0vWgZji3KI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(36840700001)(316002)(478600001)(5660300002)(47076005)(86362001)(4326008)(81166007)(70586007)(82310400003)(70206006)(7696005)(54906003)(110136005)(36756003)(1076003)(83380400001)(356005)(2906002)(2616005)(36860700001)(82740400003)(6666004)(336012)(426003)(44832011)(8936002)(8676002)(26005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 21:07:30.8665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4426526e-1455-4610-1e8e-08d9171c497d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
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
Cc: Deepak.Sharma@amd.com, aric.cyr@amd.com, Krunoslav.Kovac@amd.com,
 Shashank.Sharma@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Shirish.S@amd.com, hersenxs.wu@amd.com, Vitaly.Prosyak@amd.com,
 laurentiu.palcu@oss.nxp.com, Bhawanpreet.Lakha@amd.com,
 Nicholas.Kazlauskas@amd.com, ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are looking to enable HDR support for a couple of single-plane and
multi-plane scenarios. To do this effectively we recommend new interfaces
to drm_plane. The first patch gives a bit of background on HDR and why we
propose these interfaces.

v2:
 * Moved RFC from cover letter to kernel doc (Daniel Vetter)
 * Created new color space property instead of abusing
   color_encoding property (Ville)
 * Elaborated on need for named transfer functions
 * Expanded on reason for SDR luminance definition
 * Dropped 'color' from transfer function naming
 * Added output_transfer_function on crtc

Bhawanpreet Lakha (3):
  drm/color: Add transfer functions for HDR/SDR on drm_plane
  drm/color: Add sdr boost property
  drm/color: Add color space plane property

Harry Wentland (3):
  drm/doc: Color Management and HDR10 RFC
  drm/color: Add output transfer function to crtc
  drm/amd/display: reformat YCbCr-RGB conversion matrix

 Documentation/gpu/rfc/hdr-wide-gamut.rst      | 416 ++++++++++++++++++
 Documentation/gpu/rfc/index.rst               |   4 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  28 +-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |   7 +-
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   6 +-
 drivers/gpu/drm/arm/malidp_crtc.c             |   7 +-
 drivers/gpu/drm/arm/malidp_planes.c           |   6 +-
 drivers/gpu/drm/armada/armada_crtc.c          |   5 +-
 drivers/gpu/drm/armada/armada_overlay.c       |   6 +-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    |   7 +-
 drivers/gpu/drm/drm_atomic_uapi.c             |   8 +
 drivers/gpu/drm/drm_color_mgmt.c              | 177 +++++++-
 drivers/gpu/drm/i915/display/intel_color.c    |  11 +-
 drivers/gpu/drm/i915/display/intel_color.h    |   2 +-
 drivers/gpu/drm/i915/display/intel_crtc.c     |   4 +-
 drivers/gpu/drm/i915/display/intel_sprite.c   |   6 +-
 .../drm/i915/display/skl_universal_plane.c    |   6 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   9 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c       |   8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |   9 +-
 drivers/gpu/drm/nouveau/dispnv04/overlay.c    |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c       |  13 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c           |  10 +-
 drivers/gpu/drm/omapdrm/omap_plane.c          |   6 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |   7 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |   5 +-
 drivers/gpu/drm/stm/ltdc.c                    |   8 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  10 +-
 drivers/gpu/drm/tidss/tidss_crtc.c            |   9 +-
 drivers/gpu/drm/tidss/tidss_plane.c           |  10 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                |  16 +-
 include/drm/drm_color_mgmt.h                  |  49 ++-
 include/drm/drm_crtc.h                        |  20 +
 include/drm/drm_plane.h                       |  47 +-
 35 files changed, 905 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/gpu/rfc/hdr-wide-gamut.rst

-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
