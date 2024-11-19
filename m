Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EB6D591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDD410E5D7;
	Tue, 19 Nov 2024 06:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aa3t6oTG";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A1710E5D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKzjAR+9oeBVB4JpWZ7BgkcDj+2rNqYOujr2b50UC4l/K/Ulp0lp0FHo27vYaEPvHe7mdJI8dvPhFfd0n0d7LjDliktG4abkq7iZrcaTtvtrNzJilKM+nFXtlzHEfvBdsxHPwY50wo9HoXL7pvttHTlKwnaqsafy8+AlcJpBJWVa2Du3N/sIfUGIbP7pTQ8cY2otZjn31nnkDRU95OiufDvH6Jp01NXcwD315/2k67dwjBaJqCqXc/6gAp3mH7T3BTTVenAku2solveF6meQkDSzlRSXRMTNHQ4hzBEgQOocdfvLD6pPIZPAPBMkHSyJU7fMBF7gVDYA/iiSqmAkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IauJn0eULvHvExgP6kE2VCHB9P3lX0BeJknrmsHglg=;
 b=ojvPCzPzopJI/KaCXu+uR6sAKAltmgLCGLfBSR1W0Sr/ZAvROs8PHv+kkvHY5aLqlQ8x66kFdg74ltonYuEQSB05MGToHbVCNMaBpE2qOA5Or97rwPeR9fSd9wpwBb+9TzLgykkEbq8JNEPPt/QA9b9n44X1vTES8u1UOL+B0bLaiyk/euoHu8OudIr/A3CBZkNaXO3LvFUTuAVG61u49xbXuh8mIUjVHkHFnYrjKuOOZoQTLiLo7OY29ySLO44lfVO8mdqbMHuKnooX17d1OASNSw2J+kf44LAMFe9jR6G48R+oFJDBkaNuejdlh71OcgHlM4Ubk7GwFoNYjQbL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IauJn0eULvHvExgP6kE2VCHB9P3lX0BeJknrmsHglg=;
 b=Aa3t6oTGeE0vq9DoTXCwXW8Kb7epPYTXfTLnCGPInY/FOclr6kVVVNSmQeoaLeOB/rkuKYG1+490dAoaqlzg1VGdUA5BlFH8Mu6m3gQY0MR0d9gNwc376qANFBP7rrWeKXh6CswMUNzke6CCy59QEfeHD1EGGsoZO45v3EqY+b4=
Received: from MW4PR03CA0056.namprd03.prod.outlook.com (2603:10b6:303:8e::31)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:45 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::9b) by MW4PR03CA0056.outlook.office365.com
 (2603:10b6:303:8e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:45 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:43 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 18/21] drm/amdgpu: add from_rom parameter for ras_add_bad_pages
Date: Tue, 19 Nov 2024 14:36:01 +0800
Message-ID: <20241119063604.81461-18-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 899d5907-5d11-419e-4cb3-08dd0864899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4NugBm4kb22cNdbY/e8a0iGmp2yHqauNuTqPFNZh0qQeQRFhTEcogynC3H0K?=
 =?us-ascii?Q?MZ0C19P5kY9fGDKi2vOfhKTv2UPxLTg4HxsNT9+qsTP7GHopkgGrABAqflJT?=
 =?us-ascii?Q?V9ZdnU7lSVHnKOe0SwLaM9BNUm/L7hslxNC4R+R/52/k9uRaY0Af179z590q?=
 =?us-ascii?Q?UbY7fRllpHU3fMr1KZ/XyrfUBBDMOBGLMuT5Ziji/HKBDPSrYQWoxTcmahR5?=
 =?us-ascii?Q?MRle2FqsprSBi7o+qkvhKLQMeCP49r5UPl0gazFKK4TxJIjR4zWi5/znTNXm?=
 =?us-ascii?Q?4MQ3XM05Qk0ap7masCbVyoeoKtV+XoCXNXTl8gSP3haOaoKAmJcMhZo8+wz4?=
 =?us-ascii?Q?OqmGwvdmthYXRx/t0n3dvDA6YEhf5CloyQSbE7RrBh69fnTOlLQXOjdCsqGd?=
 =?us-ascii?Q?PI9c2uSmECTBV5Z6KYh6osMnWP1wvTFCRgJl4PMCYPx0+r7qIHWeTpXNWzWa?=
 =?us-ascii?Q?T9rYZjJLM1b17k9lYojbWOAujYtQHkCkpK2EXNTtpjNIRSSkPTxNULkRL3ma?=
 =?us-ascii?Q?5uUftKZ5RSE5Jn1xWwKCYTM2wO0XIvjFOssmqtscrVzgxuuN7Th4Va5KQS+O?=
 =?us-ascii?Q?8wJWE2jSZLSOnBVie5iAm8TOC4ukw8/N0ZNFvvQOeKIbV0h5fOvxrVZDLxMl?=
 =?us-ascii?Q?zgwT5TAp4170/O0wbm3gHHM++9owQarYGrnJpl/svEF986++GcTm9BfkJk2M?=
 =?us-ascii?Q?D4ZxXbXVpamleHTYCqTxVKRkpwJm6FTi/MXyfJ7PaBlLli7psM1atXd0Svvh?=
 =?us-ascii?Q?hRsZmu6cJ2kzdHwugpEjucCAIn97MTl5KOG6ezhniw2O6MClFYY+XMfve9LX?=
 =?us-ascii?Q?vhNSDs5xjoV20tiFYMUswxIr5Uk3GR+RPjY/gA1YKjYXJdINsXokSDKDT/GL?=
 =?us-ascii?Q?QwlHBIUWc8qFbg8m0k1r5D4dS7TKkBy62caavho/Y2HsMH+huVdqLg/eP3EY?=
 =?us-ascii?Q?TgbUFqmQXnzQoVmIPKtEwp38xHBgA81vwInDFZTkqVnUR0t8IISOGC/hF1HR?=
 =?us-ascii?Q?WNwGLz8EaaFe8f5LaQ8egf9xgSX9oc1ugJzKud1+VR2EgJzqyz/nkHAMhX27?=
 =?us-ascii?Q?q/Us+8L7E9iQ/kA1aUMeNjcxeQWrI8ht9dWsc2uMgcny8JVtCIaqif8T79P+?=
 =?us-ascii?Q?XRksyi7CZPlWPCEimuOOMSgd/KF6j+/4AS3JnExvF3ILtfxEyLSY+U07mguo?=
 =?us-ascii?Q?B9zFdVx1MAh9IpcTFOrhCiB/99s3UBunrRp2+9srzeFodA5BGMKkk0nVSwsl?=
 =?us-ascii?Q?16xkKosEVplTXsvcklZWdf3daftr3X2cUeUSLIJjYsOgZFqwzoqwO33RJ1nG?=
 =?us-ascii?Q?r2JvTrFVQSrqAnziLnv2TL41V1TClU8upL0ddaUS49EcSVVuOhCCRc3qKBJr?=
 =?us-ascii?Q?8+/xETFo5t08SqzQrniFpRlNuBsLLqXf1rAHAHzJivukir6jLQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:45.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d5907-5d11-419e-4cb3-08dd0864899c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

Tell the function if the error records come from eeprom.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f96cfcf405c5..be56938932d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -192,7 +192,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-					 err_data.err_addr_cnt);
+					 err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
@@ -2732,7 +2732,7 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages)
+		struct eeprom_table_record *bps, int pages, bool from_rom)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
@@ -2929,7 +2929,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 				control->rec_type = AMDGPU_RAS_EEPROM_REC_MCA;
 		}
 
-		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs);
+		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
 	}
 
 	kfree(bps);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 252e360c6416..4a3a1e73bcbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -751,7 +751,7 @@ int amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-		struct eeprom_table_record *bps, int pages);
+		struct eeprom_table_record *bps, int pages, bool from_rom);
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 		unsigned long *new_cnt);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 17659fa4450a..f7867c462ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -78,7 +78,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
-						err_data.err_addr_cnt);
+						err_data.err_addr_cnt, false);
 		amdgpu_ras_save_bad_pages(adev, NULL);
 	}
 
@@ -166,7 +166,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 		if ((amdgpu_bad_page_threshold != 0) &&
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
-						err_data->err_addr_cnt);
+						err_data->err_addr_cnt, false);
 			amdgpu_ras_save_bad_pages(adev, &err_count);
 
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
-- 
2.34.1

