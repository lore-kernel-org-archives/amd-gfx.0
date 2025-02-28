Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7503C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E058210ECC8;
	Fri, 28 Feb 2025 14:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvZRVq9c";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E7610ECAD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgb8rt7yk/Tnz/q4uuSuJZTcR1HpuE6wO8Da1NjQWXSF3DHymqLcPsiG6rFVI3IH3uwctoD8g5laQNHMx57/7r3i02EaA1zGYUdKZlclzeEijhw1f/EhVkXNwdA2oUfgFwNDChunt2FwTdhL0T2c3oBr9A+x4sg+wALlBiw4wwhE/4mQhhggZ/t+Smv+YA7NrUUhGAJHZax8DSNMFIMpJOHejpICPpqdAGe11mNFUgzYYQExO90rIQ/YnEpV1DpGVY81W8PRRhk8umzH4r5AxgbIEPkddC+JHZo+lqNOZqfGSVTNFQBMB4jYxDkKwsPtKomd3jZcSrVI84efazxriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V19BADk36Rks/Gg1lgImc+tZB/0tnSUxo3Dzgr3zPdk=;
 b=mztFeEhloALHX8yFjdrD9bCki4YLTJvCHFMN+Cm5IFjFQRyVIqGj6Y9bVRIBqbjx/g0TGh+zsWHWyqpGS4Iv9wuIvihkCGe0Bjfvk/fOFu0y76ngRsMUuiZyB0xOHcKOwFYimXpwZIMMt95Oum6CdCU6FirgqQTjSXVg7efPRfzCNrD46agCL7fMSQGyOyK9SW8vDmjb8aC0NedmZiac/MsdnrCBcXTMhvV6ObKrtOMg3uUl0VM1HFxUYTAqNrrS9mGxtnxYzbMLFAr4LP9SgnPO/htlcMrhxO2W9NVheQHRGD5jtwKA6hY8tZWAhmaE9ynsWKLD2UvetTA6Lk1j6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V19BADk36Rks/Gg1lgImc+tZB/0tnSUxo3Dzgr3zPdk=;
 b=IvZRVq9cLixItllAAD6vEKNbr9uBB1RX/2rtXBit7a73aCPmz9J8P/k9cxoPf7OyyAM+6ixlFXxcItaPn1pLXGTFVc2mHrqtchzTG3wTl9nXak+crLFVkXzAnyKjUP9WpufVenboMcDuRuJdV34KetX1vRMgtrpqueA8nOy3eZQ=
Received: from MN2PR10CA0031.namprd10.prod.outlook.com (2603:10b6:208:120::44)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 14:50:53 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::52) by MN2PR10CA0031.outlook.office365.com
 (2603:10b6:208:120::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 14:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 14:50:52 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 08:50:51 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: Fix JPEG video caps max size for navi1x
 and raven
Date: Fri, 28 Feb 2025 15:48:31 +0100
Message-ID: <20250228144832.50699-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228144832.50699-2-david.rosca@amd.com>
References: <20250228144832.50699-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2d9008-17bb-487a-5f93-08dd58074c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REljVZDWPbk5uaI4w8Mr3oTlyPwM2giVQGsOeB6WKZkENZtTrARHKPLStxsa?=
 =?us-ascii?Q?xqVXwvRRhH5gpMGWLvrJQZ+FxQaZ1ZkWXQBB1qRVMoTvGFCp5eLZjQrCl/Ai?=
 =?us-ascii?Q?xoyNCRdsjp/MnTWuxaNByBNArlABAjhrFlC1OMSc+4heAe6WVVwgNDVs5QHp?=
 =?us-ascii?Q?Yy6jO9Z7Zp9p4CZwRk2oNUTLnnR+jA+DluMmbO02CpxT08ZvFKIwIqFjatXX?=
 =?us-ascii?Q?n01dIKHGVUmP6r4yTdfu4dQ9dplorF4ivAjHsA2ZD1zg/JmCdfZEYwUqF5wM?=
 =?us-ascii?Q?Mhw4PfBKGAwR27qFU4nbdPT5ihQx9EldOctSoPX5GW6BZJ0EIlKGXLF08eDT?=
 =?us-ascii?Q?IUQA1IWKbQ0oBjUoEySKnguYuwaTsd1js/K8thoNvjRJKVjuEjwrbppKm/h0?=
 =?us-ascii?Q?gfDjnxKSEZIDlXI5J5Ar48L3KDVs1F/gpUbuYCNhka3Ck2IX2kdzAsjJVxVt?=
 =?us-ascii?Q?iJMzHxgzMrQgZGRxyLHVz1haFYbIsYH+ArPUIFS9tDUaJZrH4XzReO2IrNU8?=
 =?us-ascii?Q?REElR3oJ94mY/BKu1i454Ig5BZa0v7bfEdG2nwu2uXWhK0MGqrTZjEfeIOhS?=
 =?us-ascii?Q?cVz6IFlTC6azKZ3UidtfJii6+6P1FDr5KECEDMktiSrCS0YDoE1pn8N/1G8C?=
 =?us-ascii?Q?umHEZyxPGHSRj2BoOsHhpEi5iRhw4U2jFL0Vd4BHszwrKG4XrCos37tHxeGr?=
 =?us-ascii?Q?kz4FVW2iF9I2+hgP66ommADsyVGHBzpt/YXC7euqDKx+zkdZ1gOVlrzm84Gn?=
 =?us-ascii?Q?MuSUxFy5nI3u6SYOnbUmmZrWxwL7/nnM2m1rVoSoh0voPF8uzrhZfcufwpMI?=
 =?us-ascii?Q?8K1o1fQExndgKQ98Sa0Ss+kOn95yBzPosQUVRxO7LLomk9Vout6wTOmz/xoD?=
 =?us-ascii?Q?03D+K8YAzkrDjrQCQXoiJYirzROSxMCMEEir63/VNef0iYe725ntWfYGEBlW?=
 =?us-ascii?Q?fMgBC1HVbFcd2TdgynfZkJL/BMAJ9jlG6sbrt6VWJ+QZMWLKDAVzw1l4vEWy?=
 =?us-ascii?Q?5tAs1L9LXenUb35btQw0r1U0W9Lhne2n0fsdFTLumlhMw/NU/+fGb13hQIgv?=
 =?us-ascii?Q?ztwUnogPejUvINy5f4yGF1XWW3yXnNtrOfZct1+pqgFtJ/6mOZvnmSA18OXC?=
 =?us-ascii?Q?R/CaainW1szawF9kp7jyUPX5rDfVfXrfnuhalDfC3i9ed7GFKREaCBdy0fhH?=
 =?us-ascii?Q?7HBNDxiO1opdKeLEBVWdyHClgC+kfO3qPxRxXp+FgJKihWU00McQoNiYaHDG?=
 =?us-ascii?Q?R4zikE1oGw6gpDgnwOQb8AuTs1qvW9D3orz82H315PhbHhuG2WxFj22awfK0?=
 =?us-ascii?Q?/dFY7GzpUTBp2Tt+VjiTtfNh5TmVb6Ve3+YYtEfgzGcqbjW3r3Z0/DA/7Ro8?=
 =?us-ascii?Q?kg1A5bYYw8Kzmpr1vWH9v/5ad0w9O1xHfqvJZdXnOKdyK++CyA3pFHF2vyNZ?=
 =?us-ascii?Q?iHT/aWHBpiS46ciqt3w7NBjopXxRtpQ9k1mHV4cEPR3jol95Ye/Foq5351EQ?=
 =?us-ascii?Q?inL6jK+9T/zU2CY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:50:52.6392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2d9008-17bb-487a-5f93-08dd58074c6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207
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

8192x8192 is the maximum supported resolution.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a18e6fb9fa3f..32b824c3658f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -83,7 +83,7 @@ static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c5a752d8aee5..d6db75258e66 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -124,7 +124,7 @@ static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
 };
 
-- 
2.43.0

