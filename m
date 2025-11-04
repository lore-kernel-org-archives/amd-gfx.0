Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C3CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F08B10E568;
	Tue,  4 Nov 2025 08:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B17gm9Ew";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012007.outbound.protection.outlook.com
 [40.93.195.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C8610E568
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6/oUFU9xlUEWn7BiAV90sn3jZcwZC65o5s5FZJZuLD6jlZLLIFqliz2pX5y+TwLR2fjA1CJcI/989DggmAlzcJAy/hmUVIl1sBemkkVD2RqMbd4ce2JoBXApxxA96JB3BGTXny8s9diHRFke8Cmt6VZOgfExUgQjOuVH3DkoQdg/kH3T8IkYLMJ/9gq+HlbJwJNjL9CD9f4xhujDQnNLID9diQD5opxKSJBSoHJM1HbPFOqxOyTs7EPHlYP+ms64fmoHDRDPDZQvnW7gxgwdCcTudeJjDWr5NGIcnVb1/7CM/YyxKPaASAtMt1VgqBlx/8ZS9o0U8ZmGUrk2OOzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmWKh3csLGieNKcnQHcre7b8ydcwAK2uKKtwL6rcfZ8=;
 b=W+0XNzLh31UqAS2+BJcZibO6Mb2HlBT4uWz7wmJ/4jzhijYi4thF+VAHnr1SDQNcs4U7YvwG2mHj3l8UP0JUcI45aQ4JD0qhDHsAK0X+o+TjOPvdews96ny+lIuuadW7i/f8yb+ginTSJm44FZ087ntpQqJxAzvnwkug2thGktTs1iBoPrnXl2xf5iBUJVgErNavEiHbWCgsYgDnVdkWeAP6m806HQvv2DRTloLTHLVDQ3J6scbHads/FSGWHMGWwtHNDIa5rtiSKRijUzuNDMoWW3xKpYAgt18NifQTpwmLJI6saaasvMGpcltEJjHHvL+p2l8PkjvGyWf7tmA3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmWKh3csLGieNKcnQHcre7b8ydcwAK2uKKtwL6rcfZ8=;
 b=B17gm9EwcniBFr57WKstBmFSaS7exsBz63Wp38FjyrJmXac4XfkPRUlvyFImYS3qUuj9xUo7APVd6UlGuSdD+mg6bfKaxDVRsfNb6iIS1CsONAq8Ord6hT2aYszlAHrrVSQ6VHm18Bb6Pdprs1kOcmOhmsXK2UtHAGCyX/+cDL4=
Received: from CH2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:610::24) by
 DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 08:47:19 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::68) by CH2PR05CA0011.outlook.office365.com
 (2603:10b6:610::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Tue, 4
 Nov 2025 08:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:19 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:14 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 8/8] drm/amdgpu: add RAS bad page threshold handling for PMFW
 manages eeprom
Date: Tue, 4 Nov 2025 16:46:57 +0800
Message-ID: <20251104084657.1412130-8-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: ab19ba92-f6f7-418d-350d-08de1b7ec39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Djy0QCzTeU/PGLw4ku/h8M6VzbCnCn0g4ShxtEwlT6clI9pUA6HPwhkvGWp5?=
 =?us-ascii?Q?pARJ70HgoaXe0PciUfiRa4Od8s5VjsNitRhPPJ+nk+5UxSnsqvPYYtbrcp38?=
 =?us-ascii?Q?OflrATGwnIINZFJQWxErGbH0If4RaRL+gxYh1LjNB/11ID+V/GNb5SoG44qr?=
 =?us-ascii?Q?9wgLKYdShV76PS0gHmr2ppSXRhAeZcnOECBLtAE9RVJlUlsMLhfIMSn0xwk7?=
 =?us-ascii?Q?dTYUgt+sEb+MAIjja37FSCgG991z8Tc0WXeuzV3mJdd4MfsM7k21JZFVZJUd?=
 =?us-ascii?Q?Fl9y2zgjInylORPA9gc4Sp68GLE7W8xre5orm0NqYkKBQyeNJhKO7Qq5KIjo?=
 =?us-ascii?Q?rrmcuvk49rjjVAlitQgF9eUMtYyw23fFuvBcOHjMCs+eJ4PsSwB8nphxZ1bn?=
 =?us-ascii?Q?17pwyaDNoLgfdRye9kJrONF4L3PuZPW2/TS5zg74HZrWCcVN5qMmxYua0RQ+?=
 =?us-ascii?Q?wst2XjL2xCGdoihxUy6NUJ2Nk5CvlkXh25/tkxFR77J8PlEc48+Kllx7NvFq?=
 =?us-ascii?Q?BlY7X5DJACcW1R3KrB6zduD+gL4yMVKpp9oXeAT96cgvxhDMLqzRk2pLCfE9?=
 =?us-ascii?Q?rwTYSSTXXODvxgqXOrHoauSFbMye7EOQBFxEBqOrbb+Ye6hCyLhLvZqn1Sew?=
 =?us-ascii?Q?UFFPva+nNrl+D7cBrM8SX88wOer302juLHnccPZX2ryn7hqVwWp9lRsBevfZ?=
 =?us-ascii?Q?I6GsY3R4ljnn3PY/Fim8aQCgnQJvFVp2QTWPYuOtDVfzuPZxoHFY03Nds+3O?=
 =?us-ascii?Q?qdg9uQO6ut1nMSmCKs4G3SuO5pRX0YYNcWck7ga4Q/wI+mI0Ko7iNfpq/sSi?=
 =?us-ascii?Q?+Mjub0zRav4LxpxXYoWo8XiGlO9kF4LCuqMKZfyjyCBl1DGY3PrFnqkyoCT4?=
 =?us-ascii?Q?UrbCzKRK0PbPWfnqt/RL/+zVj7BnRkAGWPeWXrnyrlliwHmkr+weN0g4QtVW?=
 =?us-ascii?Q?1wm2EkAapUoiQBM4rL8eBoXep5vtSmMQB/1mxSeOvCXWC457GFidbz10s/jl?=
 =?us-ascii?Q?lgGH7VPtiN1cwRzzziN6djorr72JOOPfxWTimy2PUIe0rMGcpz5+UAAQrgDv?=
 =?us-ascii?Q?mkBbj+9U1LoY241b3qdcpGHwnJGRBEudoIHsHhfgkjN6nXxhNdHCDQYfQNZG?=
 =?us-ascii?Q?kRlTsWtGrS1YpTXO1fCtanu1tOloX6r+DGbjtp6aF/+DVgzPb0r/lUXFGFcb?=
 =?us-ascii?Q?SmrOhLMudoNzEtk1HWL/sLcHMvGW3cdvLGEVHmmBGQujN34y4lCoORVf2xlV?=
 =?us-ascii?Q?BVR/9mL7qB+kN6l/wp5QVCTIs2H8t+g+rPscmdtC3tLmjgsouk5Qn8IkSHUq?=
 =?us-ascii?Q?6E0Xg3Brym8ExPyKc5KqZLpJJUcSl0L46xZO8i+2yqEck0SwdtWJB/1vT+V8?=
 =?us-ascii?Q?Ag7bP79HoJGSCbCI0/ph/kn0X96oImttWi2huiG1qrQ0rBatNFk7B1sQqLcq?=
 =?us-ascii?Q?VgDY3g8Icpalh+2LutGko+DcU+Bd6akLhTSshH1ypNZg6WgdOtCQ9mIoANjr?=
 =?us-ascii?Q?YBu6Y288MqMDm0+FOQtPJzUs5/e4BLE9e9DSINRO+vtc0pKX+E0F+xn6UUyj?=
 =?us-ascii?Q?K/21FgrOavffCF6jXKA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:19.4285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab19ba92-f6f7-418d-350d-08de1b7ec39c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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

Check if bad page threshold is reached and take actions accordingly.

v2: remove rma message sent to smu when pmfw manages eeprom.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4e1bb804753b..48c2278670ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -903,6 +903,33 @@ int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *contro
 	return ret;
 }
 
+static int amdgpu_ras_smu_eeprom_append(struct amdgpu_ras_eeprom_control *control)
+{
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!amdgpu_ras_smu_eeprom_supported(adev))
+		return 0;
+
+	control->ras_num_bad_pages = con->bad_page_num;
+
+	if (amdgpu_bad_page_threshold != 0 &&
+	    control->ras_num_bad_pages > con->bad_page_cnt_threshold) {
+		dev_warn(adev->dev,
+			"Saved bad pages %d reaches threshold value %d\n",
+			control->ras_num_bad_pages, con->bad_page_cnt_threshold);
+
+		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
+
+		if ((amdgpu_bad_page_threshold != -1) &&
+		    (amdgpu_bad_page_threshold != -2))
+			con->is_rma = true;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_append -- append records to the EEPROM RAS table
  * @control: pointer to control structure
@@ -921,17 +948,14 @@ int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
 			     const u32 num)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	int res, i;
 	uint64_t nps = AMDGPU_NPS1_PARTITION_MODE;
 
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev)) {
-		control->ras_num_bad_pages = con->bad_page_num;
-		return 0;
-	}
+	if (amdgpu_ras_smu_eeprom_supported(adev))
+		return amdgpu_ras_smu_eeprom_append(control);
 
 	if (num == 0) {
 		dev_err(adev->dev, "will not append 0 records\n");
-- 
2.34.1

