Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D0FD78302
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 10:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D8010E6B8;
	Mon,  2 Dec 2024 10:24:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IHvNd1ck";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75D10E6B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 10:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSCx9Z2/ieLah8LP4fdvDFL+vwEvq5q6dxCkddhD5r59I0CnMMBBIX7jnmObOxvx0Ge52GchZMTaS2ST2TA1AYjaJyLzyX7gFXKulRESsxn0KCQHY7mWKY30hGJwr3M/7wJtBDyG3e9wfPSfMVyJEpKLkU2vg5G1xMABYhIcrl5mRhRkolOYxjfLQKjhdTTZGgebuAQ+VwRqgVsnLfn0pchcnPeaeKuY5XJN9UVbQmkSHTJW9jY730GYuFANixMT52dt1xzXgnv8p4hN8u0wk9Hv3zGxpX28FFeqH44altCKfW4YSJYF7PPWkPrLjXgqlHdDpaVlBZ+RvShaONN6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xfT2iACnLQaBeVmSs1l5mNoHE2sWqDKSG77cb/MAWY=;
 b=o9inTIhz1Y64AjGUmovLAQDykRt/vm6CUwKPW0s9EdQ/TntDUZV561r8h5ViHCDhHZbK6gGzIquiHAhvj7+2ED72P52q2do9TdJLFiOfOKjZ5XeNuoPu5LzVKXA9o+NlkDWo7VCPXBxXwWlRRjaHno1/NEY0G9OWzhXbAveEMSeIFrHpgZxXmm/sPNy5Fj8FKRSsPIFP+vZ2QDwHN0cIPozNNg6kgY7Gs6ALW4MGTFfb27LuWf92MoAqI+HTPLDU8hWxvhFWKjcNASd2wS/Hk3AEAUNHYgoO01IpCF820n8wEJpFPusPFdXYdwrcloO9zlTWk3hOBTC1nl7wh9JuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xfT2iACnLQaBeVmSs1l5mNoHE2sWqDKSG77cb/MAWY=;
 b=IHvNd1ckk5RHE57qvHLRTZppj1iDmVoEaw4DoNztXdUPn4bEyf5oAQnZDb768fh9yhAfMgrryL7SSUHBWSQ/5jI1DB8Kd15o3LKXqnsI8zlkqS62ggcrx01df8Hz5FW0/synoNRWz5ZyN+7jT0yoLxDoy/ZtEFmrVbsbQTvedBs=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 10:24:45 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f2) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Mon,
 2 Dec 2024 10:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 10:24:44 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 04:24:42 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: split ras_eeprom_init into init and check
 functions
Date: Mon, 2 Dec 2024 18:24:32 +0800
Message-ID: <20241202102433.117496-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b62ea03-32c4-41d0-bdce-08dd12bb8a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?saYUuw5rA4+UTi0jiCRo0Kyo5x4Ip5S+WuVwp/D4x/4ypXnQgqbYPIpf7/qk?=
 =?us-ascii?Q?bvHf6/SHgNJUhOzocDiYPMwlwu7NYMHNHFyuq6+PfF65hiupu1pHl5y34czR?=
 =?us-ascii?Q?D1YjGoj39PXa5/wMBe3yhMcanltdidrKXOgBNV7lGLtEJ9QTrxDY93EtijZ/?=
 =?us-ascii?Q?b1KiM/bKCERGMqUC5I3U7fSy7wxRJefJ1kTGmPwrMhynIj1DSkdynwNhizWP?=
 =?us-ascii?Q?rfyMGeNdwazou8B3xJs8bZC+awdcI7FXPZ0CiydziOBhi6mpkf+stAI/gmpx?=
 =?us-ascii?Q?zV7f/yQTv3S5N+EyVOLEp6CvEIwbyb95FTseCmSZtv5BEPyCdjWX2NJ/lWSC?=
 =?us-ascii?Q?bfUleRWa33JkVmJqI4F5f4H7tIyKvpxdIMCf9deg18XjNbwaSzTs4rdg2rgD?=
 =?us-ascii?Q?wDazBt32ZBlIAE+ex3oQouAztJlctUHysV4gvl4NBImuYqcEnaIq7+Hw6HwP?=
 =?us-ascii?Q?BIm9voNWLCUP4Re9a3LI/zbi8G+plyCT7d4HIXIDLy18W/Mr2+VY1+E9aH1N?=
 =?us-ascii?Q?RY2JLsN2TBsPWaMK/BL63xrJTwNdhmDV0Zqhehe47eFI2IwkOzIQTGYkXcCx?=
 =?us-ascii?Q?M0RgfPnsPFI9in8HTLH3eppTprynm+ZL6F4kDNWURMy8rrCI/DUtazsYCklU?=
 =?us-ascii?Q?A2A3U8UMhmvqNy5+F8/iMTHIsKU351FXIgBD5moubNHX4ZwnVro6IyHsWSle?=
 =?us-ascii?Q?uLRJlHEsNGoMX6tvkYKQwtGmMipD9XdszoFPlpJveNdBLTm2LRZPNB8t3zJm?=
 =?us-ascii?Q?zNYf2Vqkb2iZGBFIVrfgGwjduXtQWJiWDJ0yniSUFXZm/BlHGc5p/G/P+3js?=
 =?us-ascii?Q?8zy3mW2yuY0xE5/J6x6tzvx3Jzp29T1U9NfxZ9J+luxJco8Rnuj/L5euqTvO?=
 =?us-ascii?Q?chM7K8QqWySbm1N0Qio4O9KlrQ3qtKt8w01paSqJqTLbYjRKbKLeQI3pLGl4?=
 =?us-ascii?Q?x6vRUoOSizjGC/V8UrswbxKbjTbWcHvJXBOlghYZAoarr9vxTXR6GlZpylRy?=
 =?us-ascii?Q?aLpQUlr82ShC9AnOkh7AyxBSw7fr5lmjVGbcCHvAYU+ws8Wcu+sUC6VVrBeU?=
 =?us-ascii?Q?xKnxHmY/ioEbaO0RG9+o7anS/Lp/w6p/k/yf/DxHIdcbrhpSMCtpBpACtsef?=
 =?us-ascii?Q?W6JZw7MKaqPv6C7t0RNzDidM5MsMU2Zed4hV6fZWvegto/OUlBgrs8bwkMMZ?=
 =?us-ascii?Q?qqzJphugDrraaCnUa+BQ7dj3uwpJcXqmrBrOnow78lRGRO9fRYENg8KHM7Ft?=
 =?us-ascii?Q?WpnA0Wmgv+jPG20OSp2M/gYBCbm2JJmMaxHRkX49XgC+R82dZ1PEGS23MsWU?=
 =?us-ascii?Q?kK5xmVKKs2/JlR/phY6fLEUuPNXFt6oJr5iQHMn0ovVTNAiE3L0NZXbMgvWz?=
 =?us-ascii?Q?g4Y5TOxc+18ydQCnBBxB1i9O/ajo/+Tid+kFgyyo71grb9AEQB3EI65fgo+0?=
 =?us-ascii?Q?8Zhmngrf82zRfbxa2bBRzoaCS97WFxQJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:24:44.2901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b62ea03-32c4-41d0-bdce-08dd12bb8a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

Init function is for ras table header read and check function is
responsible for the validation of the header. Call them in different
stages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 15 ++++++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 20 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 98bd2ff5aed9..da072ab3fb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3006,9 +3006,20 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
 		}
 
+		ret = amdgpu_ras_eeprom_check(control);
+		if (ret)
+			goto out;
+
+		/* HW not usable */
+		if (amdgpu_ras_is_rma(adev)) {
+			ret = -EHWPOISON;
+			goto out;
+		}
+
 		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
 	}
 
+out:
 	kfree(bps);
 	return ret;
 }
@@ -3407,10 +3418,6 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 	if (ret)
 		return ret;
 
-	/* HW not usable */
-	if (amdgpu_ras_is_rma(adev))
-		return -EHWPOISON;
-
 	if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
 		control->rec_type = AMDGPU_RAS_EEPROM_REC_PA;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..9dae4ac2f5d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1382,6 +1382,26 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	}
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
 
+	return res < 0 ? res : 0;
+}
+
+int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	int res;
+
+	if (!__is_ras_eeprom_supported(adev))
+		return 0;
+
+	/* Verify i2c adapter is initialized */
+	if (!adev->pm.ras_eeprom_i2c_bus || !adev->pm.ras_eeprom_i2c_bus->algo)
+		return -ENOENT;
+
+	if (!__get_eeprom_i2c_addr(adev, control))
+		return -EINVAL;
+
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->ras_num_recs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index d3a6f7205a2f..b87422df52fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -159,6 +159,8 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct amdgpu_ras_eeprom_control *co
 
 void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
 
+int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

