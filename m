Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5452C25B73
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB58112CAD;
	Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNqgfGHL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD9A112C90
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq3KfEiB3BMrYOEp6YW2c0Zq/Cf4Bt8kCB1CSGrwOPkRk/r+RUSVmvOck+LAf9lRwPngIOH/us6weTxi86ABphW2EbFCr8mr5woAhhJ6h358yhpJUxDytwni3ZWgDaQksoPJoZQ+EZKkX/PciPR0Gc51YzcTa9kwU18tk4VbIJ23RvFygn5VFJku+YVZLPiTKPaTDbg0zh5RKbmRxswXNwwIgDUc+2BclT5FxPnM0NXfsWjdPI4F4cjyltAQuFZXlsviaiKIfNuH8QwYKMEfGqaElYzJNuD4zaU1io7kiY6fV7Y00CbEAoHwqQKejg5qf/+5DwVTa7RMClZlN6puSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61UqF0LHBNWFRp2KWGLUcSa14KD8ziKP1E7EZoAo41I=;
 b=guiUwdQFruqW3tze75foLFRgd3KjXojGBrwzqRK2Nu8Xh00HsAeywFgoFbrhfih792Go7B4Jo86JsqOwP+ZACiBSi6vebADJTMfpzKHVJSCu4AfnYEDjU6wuyHYOwhJBxlI5Dwoqy1vXkzmrdp74boPisxFOaXFDsPgV8Nqg7GovZtURW8bV0e4dcAUoEaA+m8HilBVMOvw7gzwoSW5tNt/gJcE6t73yjOQwi1aby538QlUPpEtsQWg2QDQ+mPL5fWGpVlzgoZjGKJkS9YGLGM7U3I30/moI40i4ySjkkhGZldXlBOzXgg+ohfg+cYXmGBDykJmAP114VsTXMpwB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61UqF0LHBNWFRp2KWGLUcSa14KD8ziKP1E7EZoAo41I=;
 b=WNqgfGHLZul965XtVFkclefKCzmKDQI3qr2CbCCARHbdIxcHS1KEsgU2uUUHIPA5t6HxqxB73mPMggRmvgkKyeGorniGs1xzTW3e9w7aWJo4JO2xleaOy4V9fwOgQZwqmfISB/OCoN3gUAix9MvHWhTh6nq/zfsDVj0zebp5lgA=
Received: from BYAPR06CA0001.namprd06.prod.outlook.com (2603:10b6:a03:d4::14)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:21 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d) by BYAPR06CA0001.outlook.office365.com
 (2603:10b6:a03:d4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 19/31] drm/amdgpu: support S&R fw load for gfx v12
Date: Mon, 29 Apr 2024 10:33:27 -0400
Message-ID: <20240429143339.3450256-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 72513ae3-f57c-4c77-34f7-08dc68597542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B9bXk/1cXWu6tfit3j/6XrJs2r1fHFHlEQ1VZDowjjKaJIoW8CrZ7h68iTGS?=
 =?us-ascii?Q?zwn6/+vabzkToyFehz6QnyIJKRmii9NRx9UrwATvfFOksEAh/QVyUZdHs5iq?=
 =?us-ascii?Q?va0deCB2ySQh++N6dHytIhsMZtljZRBsu5acVlUp24eVCR9C+ifAbwmU2OZJ?=
 =?us-ascii?Q?Lm8kNCh9QBx1XEjrtmYtbkMfX5K8uQwrsATI00RrNRTzIKQqEB694yclu4xB?=
 =?us-ascii?Q?3k6OAhuxLOoszc9JdzXb+ybZ/O+wpwNWYNTuDj3y4cv9yqZRER5fHSBFSYVw?=
 =?us-ascii?Q?bZYLmERC52CpIX6SbKUGsWLG1YmkrF6Num0VUBnHblPtmlW4yPJQp8w8ySX/?=
 =?us-ascii?Q?Ntjui1LRZavDIS9L7hpcbIkSh0OnsJEHWmW2Vg9NXYZS8jwlZYmebSE5iHZX?=
 =?us-ascii?Q?Ap1M8zgMdw4gt7zJrkXBcI0f3jFVHLseqm2oOpeH95wv0+YnGFBJk4phMyih?=
 =?us-ascii?Q?t6eg9d2yqJruEtITWneiUf1/nlj0TL3KDrJAkkkNIXqpcvE6eaTFds4XwSAa?=
 =?us-ascii?Q?AstSmhL1XZOOqYbVkt2r678E8JY88NxplnnUfuHknEkSlSSzETyDOakkdrcc?=
 =?us-ascii?Q?PAeB4r8xjDp87P//uHbRnrz7ilAb7vN5blrNqalLv8bq6IX5byGbBIdq4hry?=
 =?us-ascii?Q?HiAN4sp0mx8T8gw6tmlvVI1WJEvddSBDymMbuqa7OCVEtkrSSwrgp13AR9Bb?=
 =?us-ascii?Q?+s62HkfsVFuymKxo6v13RE4Z4le1fAzgLQPE0VQ5YNfvoMvFzJolLQ1elnlj?=
 =?us-ascii?Q?gAqeFkji7ne16G5MACDkGukP/7e6rWV57uDJJZQNxY2rjW67mppqjLle1waf?=
 =?us-ascii?Q?tYvioxMIMB9A3aaHZDvXu8r9ajWw6z/ZZxf/k0m1DrDP6WZUN+hHKOCwlv2Y?=
 =?us-ascii?Q?Z6zDTMUf3uXJuFJBumZrvbgh+BZ5Vn49XVUptdtcK/32NXjGXKg79dONE7sb?=
 =?us-ascii?Q?mnMchmdxJBUfBMmx0ljdSmqLt9L9rlS8EkcwkfDTzznzuTZUpBytLbyS8wAo?=
 =?us-ascii?Q?2rcqj3hZfHx57Ng3k/OEH41tLP2ENAp9687zoko7elnr/yoxEez9tRJq0trC?=
 =?us-ascii?Q?jE4UnAQhjnGNv2Y4CNqgZdRM9kdGDReNObmTwq5NVeBjtoopPRQONf1UaDBQ?=
 =?us-ascii?Q?KNrI8TRnGnUha4g/dseyJL9jxsQTJbKrA/n95rgm97GK7eG0nYgm2WcdI+k7?=
 =?us-ascii?Q?meAD7tbKSB34e4850nyAXCPeDg6eZ6n4q1Tn6+ZTgXdTEGUTa+UGsa3eh65m?=
 =?us-ascii?Q?q98Y/EvbIk1wHlAkM+eywfjSFIf8E2ejGYiIKtx87hN3H02v3pqEQUBoCo0b?=
 =?us-ascii?Q?L+nR21rCiWqKj7M9jtwTAJ/PZcQNgKMqCjBQk8lv0nL+PT0U3+GU/bvhATOu?=
 =?us-ascii?Q?Q9bXj1k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:20.2950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72513ae3-f57c-4c77-34f7-08dc68597542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

From: Likun Gao <Likun.Gao@amd.com>

Support Save & Restore related fw load with backdoor RLC
autoload type on gfx v12.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 06244d97c2831..df5873ba54e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -915,6 +915,7 @@ gfx_v12_0_rlc_backdoor_autoload_copy_gfx_ucode(struct amdgpu_device *adev)
 	uint32_t fw_size;
 	const struct gfx_firmware_header_v2_0 *cpv2_hdr;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
+	const struct rlc_firmware_header_v2_1 *rlcv21_hdr;
 	const struct rlc_firmware_header_v2_2 *rlcv22_hdr;
 	uint16_t version_major, version_minor;
 
@@ -986,6 +987,21 @@ gfx_v12_0_rlc_backdoor_autoload_copy_gfx_ucode(struct amdgpu_device *adev)
 	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
 	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
 	if (version_major == 2) {
+		if (version_minor >= 1) {
+			rlcv21_hdr = (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_fw->data;
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv21_hdr->save_restore_list_gpm_offset_bytes));
+			fw_size = le32_to_cpu(rlcv21_hdr->save_restore_list_gpm_size_bytes);
+			gfx_v12_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLCG_SCRATCH,
+						   fw_data, fw_size);
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv21_hdr->save_restore_list_srm_offset_bytes));
+			fw_size = le32_to_cpu(rlcv21_hdr->save_restore_list_srm_size_bytes);
+			gfx_v12_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLC_SRM_ARAM,
+						   fw_data, fw_size);
+		}
 		if (version_minor >= 2) {
 			rlcv22_hdr = (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_fw->data;
 
-- 
2.44.0

