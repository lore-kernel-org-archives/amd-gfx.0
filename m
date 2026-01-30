Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689CCD73EB4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 02:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF15710E355;
	Fri, 30 Jan 2026 02:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rztCbjN9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0035110E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 02:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh9TYrVAExiHw6kF3XaLkl/Rr+zQrGBIailNjJLI/DiK9yhPbHdE91ao1GIqMgQUGq1ZQYF1QCKGD+5NDbO3Ar0M20B8svQv8RUxuQE3HOYpqC+PknCLD6a0f2xjnyeYzrHP3Z9iJGV6W+7zoaBytoWWGIDzGZ9YgPSWsPgFhogGYFikoP070RVSJ4J6ASIjzYYeYju4B/cE8ggojq8ak2EVkNzPXp39CHnmVU5IB09Wr7XUI5E4Abzu8FBd91DN1EYrGoCs3dlFjK59hwsY3kMphqG72QHhQbGiPBIK4LMyISis70eV9sn1ALZ//8I4pvdM9Bx0wVQwL+kgrSqYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muR7KSmav49HHIFsYosuDvl0wgiefTQpqsjED14TsS0=;
 b=noqkedp0zTWfJkvRbbIUduYj9zL6emH8WwjwdI7d4MQzj4U+Z0otCrZryrkMRqa+6GNdchRTLgJ8+8yv3mShlFFKo1tcbVmbN3gmwwvYdFFDhidePovRiuO6HLW7ZZjjXQ7+l9ui87eOpP5jBYtqMSxUwzxPrw1fWtl4dRs76a6CM/8XFdzCTEdfUAcAsuc4I63ZpMZm8/IxP4zq1fINOk30OIg/rr3o3YtL7cM2ms/icqBu/JjV95zApGFAbd04ASr8mTPqMa1fikVasEQ0kRQDNT2COhPgYwXMguOnPv6Mg41Me8tLUjBfzf0QJs8pGkY6/CfK6KTwz6A3X/7thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muR7KSmav49HHIFsYosuDvl0wgiefTQpqsjED14TsS0=;
 b=rztCbjN9db8tE8LqmyUxpMKQYCF7Mc4Cr2wNe7+szHXjqytNp6EkfLk7YyQ6UFYH54j8vLn3zgP+b1+OQW+oyFtnmmDyyKeWBuWsJGDfAwp+WNRqJNEWHfuQzGwZbucA5mNW6mWRYuVT9IOUnkkGB0IeQ0uieKSbCKR3SKmMV+0=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 02:30:41 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::8) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 02:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 02:30:40 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 29 Jan 2026 20:30:39 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 11/14] drm/amd/ras: adapt page retirement process for pmfw
 eeprom
Date: Fri, 30 Jan 2026 10:29:47 +0800
Message-ID: <20260130022950.1160058-11-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130022950.1160058-1-ganglxie@amd.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4ef7e9-9211-490b-3229-08de5fa78fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BrQLLbVd2fzNl4CABj7ZD266v0biNKbTQi22jCnXgxOJdFPByXenzLSgbyFL?=
 =?us-ascii?Q?W+Syhqip09ufFt1pEh3qqvgrtDozbD65ZXuBVMnkfx8lFNmFafTM0fV7nbAf?=
 =?us-ascii?Q?ETnLm9AZpMkeAUN/njlq7CQpE8STikR6YZEP83rGUoBlKEh5hPqWMGr9PmEf?=
 =?us-ascii?Q?YgH5EGOpMx2T48izp3PlW8BVDN1IldJgy9KTLSRAMLij1+6lm+PSuC3M2Usd?=
 =?us-ascii?Q?PCA548ARBvZJ95VA2DcB14o0mDMDgezXvUl5/vTHHBfAiwcz39qTI9ah3nku?=
 =?us-ascii?Q?n/y8IG4Jv9mD8NGTPhDBJMo9eONNSH8D491fqiLNug7oueeMmZ3IOa9YIPf5?=
 =?us-ascii?Q?bDExdwRr0jZEnWi2U1zjB6KoqQX7xUhUOKABVCOeC2FDfKc/RDXDfRWLcxat?=
 =?us-ascii?Q?umhzdjIqYMf/YGdlSBYA1EHSp8oRCE8RTVh9NbJoFowcECaHsI6DlhulvKtr?=
 =?us-ascii?Q?FMQfWEsRZj/i19v0dwMUrihhAzyMo1fK09TmQ6cFAEXSRWY8SZkeIpDAZirq?=
 =?us-ascii?Q?/6+coxmjDa0buil0fSZm27k9ud7vzW+c+Hq5I59l2L8K29+yQJ7Xk0nWdw+g?=
 =?us-ascii?Q?y1qOm0H70z0BxiW18CSwuy6WllBMYc4/Q8xLC3yGWeMYxakXbPLKhk+MY2q4?=
 =?us-ascii?Q?Bk3TQSULWIkIXIk/mkngBMkyNDYdRs/OhM/ZNjShNFnIcc9y2JzNmbnhGzWz?=
 =?us-ascii?Q?6WyWZXRNxtONBObmCTz+3/Eq2BeYtYtHRMSKZukrsr7T7ygbmsfeYwyMueNv?=
 =?us-ascii?Q?AtfhCGZiYM/mbsihW/G8Go++z8LjWjBL4blxLny/3KJK4qfRp1BUZwXdQF1R?=
 =?us-ascii?Q?S9yexRWnW7/EzfnBFrFgxANd+0bW6rlaKiZBOpRdP/uvSZZQn2OW0M0zD7zi?=
 =?us-ascii?Q?rwmHa9x3R9dasP5U6I2C2poM2ABamPsgnm7+TEBLywBr858KdA7K5ICu2cB5?=
 =?us-ascii?Q?vFRnbCj3v84nf8DTF8UwjUXsDZNbrJGKs85ZrcQPeYh+RioffqD/i/+Nd75a?=
 =?us-ascii?Q?U+pnlnvw2msqHGnQwFsjqaK6ordIGfJXD9yvM3/7T5MIaytiaICdOgIHgss0?=
 =?us-ascii?Q?AsqcBif/pxJscwSC8wVIhYzqfA2uksqmB9c2d8LItW6kWoswJ29EA6jKUUkE?=
 =?us-ascii?Q?iKgEYzlilf9x2YyMcbzX+CcBKmXlUYz/PaexW00uplHdjFuutlNpPNJugOJo?=
 =?us-ascii?Q?hEIL+Sv9VNOHb6AVlEumzBAp0xAwQSBaFmx4qrBXAnvIm/p8DS3G8eyPtW2E?=
 =?us-ascii?Q?jooinWBR61w7sV7cP0XslmiD2V1wbWaJCD6ONoJVhLhdCdN42kk8ksVdUEb0?=
 =?us-ascii?Q?vVi7dP5UG73OUiXwENOz7h2XSt35mFctOwf3VP66cPZUdOsRUzPl3YW0k00p?=
 =?us-ascii?Q?YYSKKI+eVz8Pr6nZOIJKJ1HfbYi2/04uljW8vg3NElhA4vXr9xGtav4TBlGP?=
 =?us-ascii?Q?4D8N1vsKyG2PXKAy/nRCs+KZjg3HpLH3meBtq0tx+gTOmbptKa4nBjA//878?=
 =?us-ascii?Q?HOaTyPPxvh60m44xz/QM07AMBvHEnsHvUw4D29ZJ6xZNDyz9MmYnpIkGOwUE?=
 =?us-ascii?Q?aYU+Vhr1Nb7PAdbGFzdC2ttpGRYj8WGOjAwuJIIdawBgEvmyeQFovcPmUH4n?=
 =?us-ascii?Q?dHl2/jmC67VDZiKEtKeLkzvDR5GWglPQp9Y2L9W1SvqpZgHwn7eV5vJ+iFQi?=
 =?us-ascii?Q?9rh/ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GalTKHMW9c3d9/Da3ZCUWMYuKdU1EWpFVs3QXC+OQWdSEi/EDIynrZ2+0IQeuNn0+kyzfdQRupD/7Ou3ScD6q5EXAUf/Zhq5TIblk0H700y8WeVSC8XnJBr7ZAtXyugm28mL14rQiSgO+/OfYO6BRuwXXLmjRf5GxLBj8M1EZY2+jls6NV5xVKX6HT8n2Gc0vt2KvFTggy+qovAPN+BuHP5QJZY78iqkPU32lehtb9vB7udWWhEmonQmi2AnoTOISCWLGs/G4juHzkU8v3JH6UyiL4bI4NQhOjfhH5nrLxNnr9NijReIcLwN5nw6JbD6WF+3+RjxUua+0zX2cWngnNZS6ftDNuJisA+CcDAbTcI7iQTh+p9A5wRlKC/ZKYkl873TST8QCXfq0p6Zmrq4BipJhxy87Azn+otR4G9i/7lMje/WVpWswil27vUKO0zu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 02:30:40.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4ef7e9-9211-490b-3229-08de5fa78fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

read bad page data from pmfw eeprom when retirement
is triggered, use timestamp read from eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c     | 31 +++++++++-----
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++
 4 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index e433c70d2989..67a35409ff0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -234,16 +234,27 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 	    bank_ecc->de_count) {
 		struct ras_bank_ecc  ras_ecc = {0};
 
-		ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
-		ras_ecc.addr = bank_ecc->bank_info.addr;
-		ras_ecc.ipid = bank_ecc->bank_info.ipid;
-		ras_ecc.status = bank_ecc->bank_info.status;
-		ras_ecc.seq_no = bank->seq_no;
-
-		if (ras_core_gpu_in_reset(ras_core))
-			ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
-		else
-			ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		if (ras_fw_eeprom_supported(ras_core)) {
+			ret = ras_fw_eeprom_update_record(ras_core, &ras_ecc);
+			if (!ret) {
+				ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+				ras_ecc.status = bank_ecc->bank_info.status;
+				ras_ecc.seq_no = bank->seq_no;
+			}
+		} else {
+			ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+			ras_ecc.addr = bank_ecc->bank_info.addr;
+			ras_ecc.ipid = bank_ecc->bank_info.ipid;
+			ras_ecc.status = bank_ecc->bank_info.status;
+			ras_ecc.seq_no = bank->seq_no;
+		}
+
+		if (!ret) {
+			if (ras_core_gpu_in_reset(ras_core))
+				ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
+			else
+				ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		}
 	}
 
 	aca_report_ecc_info(ras_core,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 79494ad16ee5..4a1b966d22fa 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -24,6 +24,8 @@
 
 #include "ras.h"
 
+#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
+
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
@@ -329,3 +331,41 @@ uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
 
 	return ras_core->ras_fw_eeprom.ras_num_recs;
 }
+
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int ret, retry = 20;
+	u32 recs_num_new = control->ras_num_recs;
+
+	do {
+		/* 1000ms timeout is long enough, smu_get_badpage_count won't
+		 * return -EBUSY before timeout.
+		 */
+		ret = ras_fw_get_badpage_count(ras_core,
+			&recs_num_new, RAS_SMU_MESSAGE_TIMEOUT_MS);
+		if (!ret &&
+		    (recs_num_new == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time,
+			 * smu_get_badpage_count may return immediately without
+			 * count update, sleep for a while and retry again.
+			 */
+			msleep(50);
+			retry--;
+		} else {
+			break;
+		}
+	} while (retry);
+
+	if (ret)
+		return ret;
+
+	if (recs_num_new > control->ras_num_recs)
+		ret = ras_fw_eeprom_read_idx(ras_core, 0,
+					ras_ecc, control->ras_num_recs, 1);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 353977a2371e..18d6548e2151 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -75,5 +75,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 			 struct ras_bank_ecc *ras_ecc,
 			 u32 rec_idx, const u32 num);
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 53dc59e4de0c..b809a2f21d73 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -373,6 +373,9 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 		ACA_ADDR_2_ERR_ADDR(bank->addr), ACA_IPID_2_UMC_INST(bank->ipid),
 		&nps_addr, bank->nps, record);
 
+	if (ras_fw_eeprom_supported(ras_core) && bank->ts)
+		record->ts = bank->ts;
+
 	lookup_bad_pages_in_a_row(ras_core, record,
 		bank->nps, NULL, 0, bank->seq_no, true);
 
-- 
2.34.1

