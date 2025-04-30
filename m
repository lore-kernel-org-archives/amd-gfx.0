Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A616CC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 04:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2578010E6BD;
	Wed, 30 Apr 2025 04:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBvytmX8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6287010E120
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 04:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECczv6RX25DQ77IzWLWFnMOu+WIss0XMNJoIT/F6GHI3jIx4yzk/TiyLdPRHJaeGT8YnD5lUxGM1k14gYDtWPfrnqAbpi+VFwPxlVL1T+1EHDKvP1KgziLLFag7IGHQxXXamCRkz6sVFV9+tmFTGkJ24pnH1hJviKL2iIKVdpGRQg/k/0p9M5j9+qSbq/v46JDfAYSBhWCv2fJ+HCR9om36ewnJjtsjvYBVbmvVICR7GGopUAuX036sWe+MEarwBxi3D2eRlndkDbDy2tWraQMiJevLrskj8qX/eRa/o+I45L9c+MAqlkq4E8b6fso2jTEqWtfGLl/UP9eLmhvAb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vTlvSsKnTThak6fQFtOXON70GWRMcdNrOnQeJKp6q8=;
 b=v3jxYhkDeiYJob13eNNixwKVaPdA2zNL9Tdsx6H5f7VrPKWZoqK6JzNrO06eVeaDP2Gg2jGuK+DZXCNrA894f7lO/dh9wOm92PMBC3eBiW/1F12tldgi88nbpcMpDD+jMoGAFVg7o0uY0poYH18wspkitcdowRIvaL0vlzbiAK55VWa1TVWG0ZBJwfpKrPoL7Om4b+3VnrFAkwK7VY6u3s2JqlO/mlO4pmVWntm2WyMX0qRtuNX9XiNcZSnQxVcijaCRE/R6y4RJOgeStDc0XDwpY1exO20r8TNAqPBUUNSb3Ca25qTbsvot4BLin3iEt+5LXNLKR2T+XxZKnOPfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vTlvSsKnTThak6fQFtOXON70GWRMcdNrOnQeJKp6q8=;
 b=PBvytmX8JLssycyiieY0WFRnP6HZ0YCb3iou2ji/9rEWTRLmhVafQrmjGhbBq2Jmzq+r7WAG7Slh6QYqS+qeJhZvMQ/s1KVl59/J0oNp22qkEfhNbsAOFcQW4uvEbj1VIfMrbHyI6Sbh09xQ7d4MDBOqgJENp71qHZ4Nit1STrA=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 04:05:33 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::39) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Wed,
 30 Apr 2025 04:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Wed, 30 Apr 2025 04:05:32 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 23:05:29 -0500
From: ganglxie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, ganglxie <ganglxie@amd.com>
Subject: [PATCH] Refine RAS bad page records counting and parsing in eeprom V3
Date: Wed, 30 Apr 2025 12:05:12 +0800
Message-ID: <20250430040512.307765-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c24bbaa-359f-49f6-e3ab-08dd879c4073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YY3cPH+f/8VI41eQWC2OTBAarLbAkUrxJg/+bIHYe4ZXvrPGn1pbpll73JT5?=
 =?us-ascii?Q?QrqCfz62NGGCyuBcq903hw9R/rrZKvmOy2pfUwdL+jhs0jCiB/JR6qxHf0It?=
 =?us-ascii?Q?RqfWw7gTdyH1XeZk9LYoKk5EtwF5plVrV9Ymq3BBfow64MhlW7/H9ydbz+QH?=
 =?us-ascii?Q?t/sVWuxfGvgRdJQpqNPU/ydfAAErMahAY64oDBPBREekr7Z4iMHmW4sC2c42?=
 =?us-ascii?Q?TSdVVpstWdsOtoFfOpvb9gkX5vTRS5h/5jyNq5XgX8YXgtbpqC6giYt7aifh?=
 =?us-ascii?Q?lit0gWJx1bGoILz3jAcuQsimoi+ybbDlc2Iya/u1VVvphkphhhja+oI0CGA0?=
 =?us-ascii?Q?3ZNYfRuvtmuYmCU96Jw+AFQnyUbq87GRj8Gx4+dwQFqxQirA1fI2AXV7A5kV?=
 =?us-ascii?Q?SEeNgrFhdnqrZAqL4udF7Q9f1dEbApsN62FD9rKg4zAH71EBCKWt+NT7/SF9?=
 =?us-ascii?Q?G64AiJ8XkDaqHuK9cv2woc9HOK2B8Tgd+kxcfc2sSM/VA9sZXlWReodKIA2m?=
 =?us-ascii?Q?4g+W+1kFDyvAfsKFDh3ipHh4DyZTm1QCwChPFze2FFqr1xarg8XdD+2rrm9c?=
 =?us-ascii?Q?iLsSxv4kEFxUzyxTRhcct4U1R/aJCK+hhP+8lBPP/jNOjBCjDbe7COV7C//c?=
 =?us-ascii?Q?Is2NHerRjdA5SqzOJeGhYHpiKcXyDgxZb0kiPasuKN/tSKj+3KBCtUT9jn4o?=
 =?us-ascii?Q?SeFsNf5xz7YR/9TvM4MqX/WH+ncu6SL3i7QU0aLCwQ5hGYrQ9HVM2bPepYnu?=
 =?us-ascii?Q?CCs114F7YtgKA4kPbut2ypLktEXvQi5NXmAnlqmcoeoRae84Lea9+gc/yOiQ?=
 =?us-ascii?Q?24mMCs2kTLBHB9+1/7w6jHmYxWkoCLiMg64NxYQhB5vUMPuO7TzHF3XAXUhq?=
 =?us-ascii?Q?YcGxh/syKag4YAno5fvM82SxlreVyLfFySWoD2NAB+Rg8sxlrwNgaTWDTKUw?=
 =?us-ascii?Q?1N10aKu49jXx+Rq3EIMf+tPXShggoB0tMcHuYr062dgg7X24uM4COqMe/7ce?=
 =?us-ascii?Q?sIcxuei4tnQO8p3QrFi3jGdRuFNvxXOhgBfW2p7XlsNWQi8z7/UvOTRY+tle?=
 =?us-ascii?Q?movk7k1ngFLWpJbDsnzDsBoKHi41WkMw7cTUkZ0MKQ+Xaa7hTPEi/uxhjDEA?=
 =?us-ascii?Q?KSJ977iMzNWSDw2bZ+G2vuWUcHIUiDYPuLxe2N/mW9aCvyPrIhxORk7MMU9w?=
 =?us-ascii?Q?xNsCi3rewGwvric7kLU+RylQSuT+2ny4YVW6Li9ZBdtwaB+yxpu8qdN8qEY+?=
 =?us-ascii?Q?+D0ocXmH947F4ylavGLf8SUSWm0ngYDsIlzy0eqal6KCrOGBw2yQFxqzgRe9?=
 =?us-ascii?Q?fMU9Vk10LxomhF+dIkxL1jSlRwICFDdFCd90ZEk0pUub2w/y7FzNEhE8DAXd?=
 =?us-ascii?Q?8Lq/WWdSVM3HhgXoHm2gRbjRBQIug4PhUfXSIafM65u4w2AUPKJd/IB21aeJ?=
 =?us-ascii?Q?Opgu6oHfIi85fUjKygzv78Ba43V+kpO/NFdpKNE1xuZ1Fm4UesGKwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 04:05:32.2039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c24bbaa-359f-49f6-e3ab-08dd879c4073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671
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

there is only MCA records in V3, no need to care about PA records.
recalculate the value of ras_num_bad_pages when parsing failed and
go on with the left records instead of quit.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 61 +++++++++++++++----------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e85143acf3a2..32f41f151c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2889,6 +2889,7 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
 			return -EINVAL;
 	}
+
 	return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
 									adev->umc.retire_unit);
 }
@@ -2903,7 +2904,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			&adev->psp.ras_context.ras->eeprom_control;
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
-	uint32_t i;
+	uint32_t i = 0;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -2924,28 +2925,31 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 
 	if (from_rom) {
-		for (i = 0; i < pages; i++) {
-			if (control->ras_num_recs - i >= adev->umc.retire_unit) {
-				if ((bps[i].address == bps[i + 1].address) &&
-				    (bps[i].mem_channel == bps[i + 1].mem_channel)) {
-					//deal with retire_unit records a time
-					ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
-									&bps[i], &err_data, nps);
-					if (ret)
-						goto free;
-					i += (adev->umc.retire_unit - 1);
+		/* there is no pa recs in V3, so skip pa recs processing */
+		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+			for (i = 0; i < pages; i++) {
+				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
+					if ((bps[i].address == bps[i + 1].address) &&
+						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+						/* deal with retire_unit records a time */
+						ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
+										&bps[i], &err_data, nps);
+						if (ret)
+							control->ras_num_bad_pages -= adev->umc.retire_unit;
+						i += (adev->umc.retire_unit - 1);
+					} else {
+						break;
+					}
 				} else {
 					break;
 				}
-			} else {
-				break;
 			}
 		}
 		for (; i < pages; i++) {
 			ret = __amdgpu_ras_convert_rec_from_rom(adev,
 				&bps[i], &err_data, nps);
 			if (ret)
-				goto free;
+				control->ras_num_bad_pages -= adev->umc.retire_unit;
 		}
 	} else {
 		ret = __amdgpu_ras_restore_bad_pages(adev, bps, pages);
@@ -3040,21 +3044,28 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 	} else {
 		if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-			for (i = 0; i < control->ras_num_recs; i++) {
-				if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
-					if ((bps[i].address == bps[i + 1].address) &&
-						(bps[i].mem_channel == bps[i + 1].mem_channel)) {
-						control->ras_num_pa_recs += adev->umc.retire_unit;
-						i += (adev->umc.retire_unit - 1);
+			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
+			as pa recs, so add verion check to avoid it.
+			*/
+			if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+				for (i = 0; i < control->ras_num_recs; i++) {
+					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
+						if ((bps[i].address == bps[i + 1].address) &&
+							(bps[i].mem_channel == bps[i + 1].mem_channel)) {
+							control->ras_num_pa_recs += adev->umc.retire_unit;
+							i += (adev->umc.retire_unit - 1);
+						} else {
+							control->ras_num_mca_recs +=
+										(control->ras_num_recs - i);
+							break;
+						}
 					} else {
-						control->ras_num_mca_recs +=
-									(control->ras_num_recs - i);
+						control->ras_num_mca_recs += (control->ras_num_recs - i);
 						break;
 					}
-				} else {
-					control->ras_num_mca_recs += (control->ras_num_recs - i);
-					break;
 				}
+			} else {
+				control->ras_num_mca_recs = control->ras_num_recs;
 			}
 		}
 
-- 
2.34.1

