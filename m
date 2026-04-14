Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2C2ED7B8D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE63A10E5C0;
	Tue, 14 Apr 2026 09:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Su4FrCVZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E8810E5BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb+OZNr39m3Um6zAYFI9aR92gcJEswl+YsFOj4PPI9vn0X9YbumfVrFgSzoP0iO6tiguI+JPkzHWM/ENQ44hyWtcSPew1yafwHk8L4dZBjUv5nYinbsutjunYX44Asw9vGP1kdQHUeBTceTNZn2qORCww41+3kiEbL217Tv3ziAmC+wvCqV/qy7xqWiZ6mah3nlP+eduZ4Td6knet+TLi76xht78H8qzBNuA9hIq17GiOPDrSBzJ8fRyMKuKecs6M/MY0sp+NDB87cY1Y3EOaOn+cBfLi6ztrIGBqhMlUtwt4m3X7WN7qOS2R6pt4xSJipP37aMrperLJfHz2GaLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63z4pPyWhEOW8TWMDXO6kxV3yck39zmQtt5dWBfVXOg=;
 b=T9tuSXxFgv1FGa5wZ50gYelJc5j2du5K1smX0V0U12HPGG0IOFvS0Aeo25tQOONRzmYThuUOmVWHjlrF8XiXBNLQu8K74M7GZggnNRvodA3dXS48n63qEn1x3kuBFrNdZCFb6Hp8YwauTtxV4tCC+pI3LUDGkSqVbT8Lx9Ki0wDfNvCKVLvKeyLHv8fh5nJInLIHQt0RcD+U1hnXrUZ358G4X8ULYrD0aW8ZWD4vsvm9TXKED/Fen85iDdcg8ruar+63Rg0N6PkUMZ3T9bzfmmgUbdLlwkmqfXXsntIzUt7jUODNf4gWVFIv7ixcy2gNyQoE25Ml0z1BtXgc7uq54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63z4pPyWhEOW8TWMDXO6kxV3yck39zmQtt5dWBfVXOg=;
 b=Su4FrCVZbCgcsPZL/kRw68T5dyp663RJquWUEBu5CSZzmN9Rg1BcuiC5J//ZUKfWyB47ECpdfESf3nUdkw8TUPOx3WCPjSCgzp0u0+yYL3V1jK7M5pVP9Gs60GgpMsH80ahYQwlnWF+KdM06ohdOINbQFMaTW2Kylod6JFcXYps=
Received: from BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) by
 CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 09:00:48 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::d7) by BL0PR0102CA0032.outlook.office365.com
 (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 09:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 09:00:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 04:00:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 04:00:41 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 8/8] drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP
 header on GFX12
Date: Tue, 14 Apr 2026 16:58:55 +0800
Message-ID: <20260414085926.3171086-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bfd5f1-9744-4624-a4c4-08de9a045205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wgyS0257Z7tUnZDvLiOu9TmiLRdPHF0TAV0+12BSTX+mBxtvoZNs0yx3DfdfPAnlAVzcJkGouGGMVmtSGCDNmQPi7Qh9EzDYqiGeKGrMz0CXzAG4MpU3PAfsBL0SJr0H/t3mGi5RmVp3CuVm065FaPJQTCNPqJWet0o0zBa03KM9nBK06NKsjxqBrgHE+Yb2rP1gy2QDoXbOw492OMHKmQFzvjH9ZUQxwqGLAZjOrOvFcRQrOjQvyKNRuZMp85nvA5VhmgUkvo4Yqhw0P/YPZMW3Ss1Sl4T5p/LzXr9Da1WK11iY63XVU8VXd0R6PnlTMxyw4xdhfuAYk1kSx1oKQwn31kpjEhzGmlVWkteqMaLHMqr5GvADBigohmUuow450jxA0azA5WBulEnOVIK5OTf473ED1r7JtUfQcqky3AUQm2XLfh616kXR4t3SfevV8qYxigFbEvq/Jjvkp8lldH95dh/8JMnWJ9aZZR2YtxX7Q2W4CxEyTHRpBw0bmBD0rLpZ2XXFXFk6SXJ2mJHCXrAKaduDzOpU7Bqa32z44phD7PnLTkofopkU9z/4uUTtdWfgJtX5uX2hxHi4YNDBWTK2APT1F5qVLFsI3mVzJanizAL6yL+dM6Cie79dTgr7IEGV2Hyj9RwpkpaAT6aj/9vhUp0uo6Nk9mTS5+ZR6AxsNkhWDOUIjA1/cXmJ/Cig8jQpgYjD7v4X5XjwH1bTGqmw8hhgyMJ2R1CUgWQsjd23IltNWG8ZNPIjuIekk8RvJ0Gyd5Dr1fT/ICwZbdJvIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lQbGjMYD5GuHuaSdWHshBJ//Qr2V4Vr1gkyrJsYXH1uuyt+d7MSAMQWcYOSKlh+Hi0QPggnwgeBd3HajgTwLgEU30yNi6noXVttCCOlNY/j0+1PZZD70CJspY8KrZtq6QDqCWwVP6pV15x0krQYc0tgBqO7T5l6gxyopGy3MUiWHj7YwWx417Og6zChLhVVTPO/tWB+GwPo/3IzEg+86aKUJzUrmpAG5OjcH4RZA4+Q6Yy0RmpepKuQQgrQozm6LAKJwwRUNMfikCOALRABqKag2CUaf+S8uxh64QDFj0AU7Nnrk5673nhEkAnD44SZ37AOqKMn0BDsymCwBrAmMJ5yVFOX+U7LMiAGmVycZ+WIxXB7AYzHP5bWjLPGc3N1prp0RaBDWwJY5hco+9iRn0LVBRL6J5029xbNKcvv2bks1vXM4rnYmqwOR0Bgr6ruS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:00:47.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bfd5f1-9744-4624-a4c4-08de9a045205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
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

gfx_v12_0_init_microcode() always loads RS64 CP ucode but never set
adev->gfx.rs64_enable, so it stayed false and code that branches on it
(e.g. MEC pipe reset) used the legacy CP_MEC_CNTL path incorrectly.

Match GFX11: derive RS64 mode from the PFP firmware header (v2.0) via
amdgpu_ucode_hdr_version(). Log at debug when RS64 is enabled.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 2dcdee1eef1c..a88c8bc4be64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -602,6 +602,13 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
+
+	adev->gfx.rs64_enable = amdgpu_ucode_hdr_version(
+				(union amdgpu_firmware_header *)
+				adev->gfx.pfp_fw->data, 2, 0);
+	if (adev->gfx.rs64_enable)
+		dev_dbg(adev->dev, "CP RS64 enable\n");
+
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
-- 
2.49.0

