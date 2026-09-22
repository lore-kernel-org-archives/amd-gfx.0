Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB70CC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB5B10ECCB;
	Tue, 22 Sep 2026 13:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jtOeOoNS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856AD10ECCB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmK3XSHl4aaieMfyw6i+WMYoHS6mvkMmBU2kXgSRi9g8tKWyKlK+YKLarT7z6o/ftVXB6/eJWwTs/aXlLhl3RXbuhTo3Beu8+qENerXEdgrPnmLn8IM7gEE4RHuUeMbxQ2/QP5b3fVplMbSdjd4WPgY6MZgvgOzdjwQ4Fgcsekzr/YBsGQhL2fr9u1ie0q0hkoZsfEKYIA7jSZYBtky9KPVyb8A0GlKfETkRYfdQWc3VdY+TSTr79hIL40WG7zJHXSI33+Ii/FwnI0bLtn9vh+DnOqlZumgLRKZeB2AOiggXdWBETkFscb9jcy0Jh9ezIUTRhz4DbAZnEx9H2v2VXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1iK5xAQlK7n+cLTh1yvjvp/RvPS11Ox54JOvBZfhzo=;
 b=ROXMV0eMSKsFSf/iYH1pjzLuVH7LhktG/qO+AxOcQAc8uqx++3txXS3m82WPeAuGu4Nk1djwCr4qshi/LhGJ/9zTuxrldbPZJE1L/RGxKW30z37Zb85DplAoU2PNs5NOnemAb1QlIOMZ2VZcZzdwOdWgeDc8pz/TOQXssGH2UHBBOJTBqQI0tg7YBWRb9H5nFU6QTBozPnLP/bYSLf1Kkw2wRgy8xbo6/htRF8zJ6zcT1IgyRl28p+JurKjH20slqXOj0Sq7/imBzvlGaGaOBgZImKrr7NDXZAAJdPfOuwWOkv29PXw/ArgVSA4Mh1aC7cAEGLU5IKKkNnoXgsGKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1iK5xAQlK7n+cLTh1yvjvp/RvPS11Ox54JOvBZfhzo=;
 b=jtOeOoNSDdOAhvVfcYwatals620IzJy6lKJdbVUdNJdTCxtvIGBit/mmA8WTlXfBT80YnTaxtaafh5X5gzaV1RBbRMIcCJRK5CKPXgW6zFmZr4epNBhuQBz7WI5oZ0GeBza7bamDT6GNwidUpMEzxWAUAKHV9sfC9WkuszMuF2M=
Received: from CH2PR17CA0030.namprd17.prod.outlook.com (2603:10b6:610:53::40)
 by IA3PR12MB951235.namprd12.prod.outlook.com (2603:10b6:208:709::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:44:20 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::2a) by CH2PR17CA0030.outlook.office365.com
 (2603:10b6:610:53::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 13:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:44:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:44:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:44:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:44:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] SMUIO v15.0.3 support
Date: Tue, 22 Sep 2026 09:43:58 -0400
Message-ID: <20260922134400.2145341-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA3PR12MB951235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6deefad3-300f-401f-c507-08df18af99f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: e4GKLRpLTQF1FcN7kGWCtQrmSm6Vno9OmJsjrqxe9WQtZwJkZuUAr7S2vt+I/0yqgtqwqVo2Pto9QOubU16kL/nnlzY+4qmLVVKRi57P7wEz7gSZ59rv//x2gXWjbiO+n9NE6zak9Cos5/7HYHl2fl/USvLUHFUxyOn1+O1sytp5eb2+m+34Gm54fafSlA/hws59stB2/Iv/Fpoqt0jy5jx4atImzgYNjAS52fh2pXzI3Al60K6CadZWvuJ3tlH3z+nTYnSAAKY0QvhzBq5jMvJf7mflbqHHMD2MzZj/NbsVkuDGdBXYwiVvQnhnnL7xoofKBqU83gVvSOlVTEL3ay42PWw6N9iLlVi/aQGLWtLC3S9bHTX09+vVNhwYsZQOr51Uo/bdLBFI3urxEOiWM2kPcILUo91Pb3Wqz45SVcH9AcuR7Lhbz6EFo7g2ia8f5+JxfrsAmAQOew0azJHImytF0gmRlcz+Fhl4e7gKYg4+anMHg+Z1gEsScVRB0hA9X11Hu74uSmcli51EuR0UWd2mn7M9Qw8jv1/HVqbyJj4aX41FvcuZhJ8yiFxXkrciSWMNKofGFdPigE7PoEtGHrvEuO25VWUK5Io/IheoVw+oqFb33bOdwP9UJxVu5WKRCoKkVO4Oar6GZXYskExZenV3g5cSSAlSleAwK2BkhNjJULB+1GzMJQxSzevrQnsCu3/x70AbkaP77GG0V05Z5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cR9dIl5/8ek5r0EVyiFJeYK4AU5dkp7pAzxtvKh9eeo3sPF/4YZAXwou2V8l7p3JUvmFSRtwuiEVGHJJlPgsVoEtD6/0yszN/yHaQAXzhzYnqkh4/tzABMba9EMX5TgqKttr02W5rMdS6ipg707xxCA0XlGPN7h+3qhWC23HLmcocUwg6JMd3Pwaxp0zUkO0FEo7QQgSTjWBsgdWlbJbnWtncvYSyFhNmN2RdJzZEU5cA3LKuQOg+uBpXllBjyuSsIZsk6C9i5ATZPhU4h0AksSiAEXaPjd/DAPXU9vheHt+P9Q+wcmhm1N5BbFnL30tze6JsIWXenCtNXg+x2ywm0JbxIWBv0sdMw0iNOy1esOZnBeGVuBKUB5xGqGsURIqhoi/i6t67qzJ6Y+CsPrBjgHEOk23C8Cgs11aAiA8ZOx/4HN4ieDOS2ExaK7Xr+/y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:44:19.0764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deefad3-300f-401f-c507-08df18af99f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB951235
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

This series adds SMUIO v15.0.3 support.

Hawking Zhang (2):
  drm/amdgpu: Add smuio v15_0_3 ip headers v4
  drm/amdgpu: Add smuio v15_0_3 support

 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c    |  84 +++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h    |  30 ++++
 .../asic_reg/smuio/smuio_15_0_3_offset.h      |  79 +++++++++
 .../asic_reg/smuio/smuio_15_0_3_sh_mask.h     | 164 ++++++++++++++++++
 6 files changed, 362 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_3_sh_mask.h

-- 
2.55.0

