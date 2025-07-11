Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD6CC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B147E10E9D6;
	Fri, 11 Jul 2025 09:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rof9jO8h";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F59F10E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkVX4IAesT0ZT1tfUY62EllRU7xAgISBBzara0ZECCsd0p7mhjZk2PFLDfQmwcuA5PORmVmefZ9NPG60UtUqeCY2v68EThk3OEc4VWdjxF4b4XuelK8lV1bYYQAg43juOfhYELQN8EG+cd4uoBLGSMXMwwd2DuQN1iSvyuF2vp4t4hGtlbFnMY6rTQ4vkgHdqBMpCK/lOxMD3tPYg7mhSM+an4t0tLxQwE4z1ET+0891+LfhVt1eHvVS5jS2VhfXVrZ/bGCHXDGc1NXbGNfDQQL+3t/Drmw0laY+SYwDi36w7h4tKnYwscfo8RelQoNVG3+Gf9N4G0pwEd5NN51beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dmn4SBdy6qYgFtPensoJP5Z51pg5Jb3Mx7FUBuSaJGM=;
 b=U7CYtrtzNnchU4cqNiCL8/KwVd2KNQ+BzqcDDj2vWBgzc0UNAarHlil2jTX7ku44+BlWEaY85EUn6o9JxfxH1ZvlkBk9sJ4z8b+LjSSYbaDpWiybkD/pl1lb5llNvwXCN6clNgleXFguHvwqAjy6y5AhQNnsJby8CJr1A0L8Ld0XVel9JN9EY/8wJQCrJ3Syn57HpFi1azaPSaIQBd2gNcVcQ4knuCku6p6CnML6lZHttA8I3449T0SDKXeCa1zf7M7JolTke+NgLHTwhTyc058cDHlBdTl2U1iSS/EZolr6AVoMj/oY5I3R0Zq1nmI+1aLHltWu3Cg226xYPSUlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dmn4SBdy6qYgFtPensoJP5Z51pg5Jb3Mx7FUBuSaJGM=;
 b=Rof9jO8h8d7NLR5820kEFAYObecsoEOiOCaFx+TIbAjtnF9iyytFemqndTd2wYfXqrw9F+UP5IGgLJQfnQ3xgeTPUhJa1PE/JY30dIebeCzPvSvxyAIWcIQ6w79VNbEAZU0QIM6DP5pqxFqjz+jWqQpYdXyl+w8l0oBcTr4lBMo=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 09:06:16 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::5a) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.11 via Frontend Transport; Fri,
 11 Jul 2025 09:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:06:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:06:14 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: adjust the update of RAS bad page number
Date: Fri, 11 Jul 2025 17:06:04 +0800
Message-ID: <20250711090604.9809-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711090604.9809-1-tao.zhou1@amd.com>
References: <20250711090604.9809-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d61a7f-aad4-46df-28cf-08ddc05a3130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MRC/9E5hHSKNsX36tbXNwOGqC9vRoLk7Tl4bWZr+vlh+JTdP89dyyTyq5aiA?=
 =?us-ascii?Q?T6v9XJ+v+kKb7j1rNxzCM5XZlOIlxv2oY6ew4t9kYdGK7sC4tZ0Cv5fFF6cd?=
 =?us-ascii?Q?oVAofjlToMvwCSofOW3/XReHGE2lp7xMyReDowl+jxwdFmWXg0L/ToB4H0su?=
 =?us-ascii?Q?OS0nAv6qNNwU7Ksrjd4PFJVAop3e+fp5yWSuQVSphUvPlePAhHlhcJ7q9TpZ?=
 =?us-ascii?Q?y42zdA+qYbBJRNt9A+H43dWMUVio+lob7ydVZyf6w7C0LeXAmhm4U95wSL/A?=
 =?us-ascii?Q?etPqu+TsWo2/wNndamp/sNp2I1rWMCk0xgZ5J3yJ23zfc1Vjy1AgHq1zGC6p?=
 =?us-ascii?Q?35aNXhGwvQTobEzvwZO5Y7auBSBloROTHhiG9f4o+jOdhzdFmxejoj0YHKK6?=
 =?us-ascii?Q?NtnQGOFHmQ7eDe3lZiJDWbPVsPIbw4wTGigadC/Iydx4y1Hnt/PcB4gGU42S?=
 =?us-ascii?Q?YgsXhfhMKRQBHNuOOQzhP+TRg6Gg4EvmfaooE64R+gzPz3a61XPh8UEhYaWA?=
 =?us-ascii?Q?unW3MP42BMU/Huy3fFfvJR9ZPrSVrNiINbcvDcV7yg5Lj+UDM1LJwgtYyhD9?=
 =?us-ascii?Q?6WIVsyFpJ4yDLnu7ao6ngpiCd+xYVBZixAAo8vEg4BTosGYlyZ9i86db9T0c?=
 =?us-ascii?Q?QukugPds2QLajQsDjA4o3HDVaNeyrcSmhpa2vYtDS3vI7dlY5SjN2vDnL5kh?=
 =?us-ascii?Q?+lCpBdQLprMqSqEUmqOyFRR1ORhR8PrZ6l48r4Ce+D4LRBvQM/Nally9mfkj?=
 =?us-ascii?Q?kK9pN3bGm2ZQFoxSeVGGBviK0/3BlgaT1E6FX6H9wV/AIxSzghO+a9tydPp5?=
 =?us-ascii?Q?YMNd9lZ74BUPqHH4P1vPCHX5ZzR9tq+kHlyWG6Pf2jj5mSGJVkjn02dnMQmI?=
 =?us-ascii?Q?cwWBOYDgiWHWni78kJvxWWAxsIm4kDUhsRV8IGPdr13oziEpjeH1oTh9doBf?=
 =?us-ascii?Q?pBSZ4sEj6g4c3YdoyF4pKEb6g2uaV0JzCBYZwHN9q3Z0cjwMhObARJi1s3yV?=
 =?us-ascii?Q?FFahVKMAK2yefnWILPgfXW/wSJVtTRwDlZgCEtJxZ1qZSSBjDL21wdUhOkGR?=
 =?us-ascii?Q?sI9KBsbWBxQm9Ooux0xY2euiMQ98NiO9IzT6qKt1wwWaQKJDKLaeVH3Dz0w8?=
 =?us-ascii?Q?+HVlPtDHK+g6OHfzhTMG9mRJyiNrBBrOGoBJu5fsEh3i0pQjetbhM7mhOc4x?=
 =?us-ascii?Q?hswKimb6/FBfSe3rbrdda6OC+2OsIdd2ya6vuk+ksDw6kLcolnRDkKpvQliH?=
 =?us-ascii?Q?PSFWD6EbV5NihO8gdArFUVhxH2k6PLgoV/lE3wvA46YtU3oJXV+d2Y3031L0?=
 =?us-ascii?Q?sCYpp+trTWPFMVaEOYSJdOpr/HPVtJkpRIx6y0FK5JmcVoklYQ/Ji8L64z79?=
 =?us-ascii?Q?/LyRi7eTbjO9bKgGNWf02bogQq8mYF1tFr60e1sRRL96HTrj/s+IVfbUVCaM?=
 =?us-ascii?Q?L3iaQBV4tcMJ0dMJmrFyDckkevn38ThLaQ44XDWsRqYNTR9yec0I8OASQhLS?=
 =?us-ascii?Q?o5aRs3NRX5FdJjTCdOMo9P2h2Alt88eOc1m5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:06:16.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d61a7f-aad4-46df-28cf-08ddc05a3130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

One eeprom record may not map to unit number of bad pages, the accurate
bad page number is gotten after bad page address check.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 43 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  6 +--
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1d6d4625abb3..ea3ab8c46115 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2568,6 +2568,9 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	}
 
 	for (; i < data->count; i++) {
+		if (!data->bps[i].ts)
+			continue;
+
 		(*bps)[i] = (struct ras_badpage){
 			.bp = data->bps[i].retired_page,
 			.size = AMDGPU_GPU_PAGE_SIZE,
@@ -2581,7 +2584,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_FAULT;
 	}
 
-	*count = data->count;
+	*count = con->bad_page_num;
 out:
 	mutex_unlock(&con->recovery_lock);
 	return ret;
@@ -2809,8 +2812,11 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 
 	for (j = 0; j < count; j++) {
 		if (amdgpu_ras_check_bad_page_unlock(con,
-			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+			data->count++;
+			data->space_left--;
 			continue;
+		}
 
 		if (!data->space_left &&
 		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
@@ -2823,6 +2829,7 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 				sizeof(struct eeprom_table_record));
 		data->count++;
 		data->space_left--;
+		con->bad_page_num++;
 	}
 
 	return 0;
@@ -2954,7 +2961,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 						ret = __amdgpu_ras_convert_rec_array_from_rom(adev,
 										&bps[i], &err_data, nps);
 						if (ret)
-							control->ras_num_bad_pages -= adev->umc.retire_unit;
+							con->bad_page_num -= adev->umc.retire_unit;
 						i += (adev->umc.retire_unit - 1);
 					} else {
 						break;
@@ -2968,8 +2975,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			ret = __amdgpu_ras_convert_rec_from_rom(adev,
 				&bps[i], &err_data, nps);
 			if (ret)
-				control->ras_num_bad_pages -= adev->umc.retire_unit;
+				con->bad_page_num -= adev->umc.retire_unit;
 		}
+
+		con->eh_data->count_saved = con->eh_data->count;
 	} else {
 		ret = __amdgpu_ras_restore_bad_pages(adev, bps, pages);
 	}
@@ -2992,7 +3001,7 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data;
 	struct amdgpu_ras_eeprom_control *control;
-	int save_count, unit_num, bad_page_num, i;
+	int unit_num, i;
 
 	if (!con || !con->eh_data) {
 		if (new_cnt)
@@ -3013,27 +3022,25 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	mutex_lock(&con->recovery_lock);
 	control = &con->eeprom_control;
 	data = con->eh_data;
-	bad_page_num = control->ras_num_bad_pages;
-	save_count = data->count - bad_page_num;
+	unit_num = data->count / adev->umc.retire_unit - control->ras_num_recs;
 	mutex_unlock(&con->recovery_lock);
 
-	unit_num = save_count / adev->umc.retire_unit;
 	if (new_cnt)
 		*new_cnt = unit_num;
 
 	/* only new entries are saved */
-	if (save_count > 0) {
+	if (unit_num > 0) {
 		/*old asics only save pa to eeprom like before*/
 		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) < 12) {
 			if (amdgpu_ras_eeprom_append(control,
-					&data->bps[bad_page_num], save_count)) {
+					&data->bps[data->count_saved], unit_num)) {
 				dev_err(adev->dev, "Failed to save EEPROM table data!");
 				return -EIO;
 			}
 		} else {
 			for (i = 0; i < unit_num; i++) {
 				if (amdgpu_ras_eeprom_append(control,
-						&data->bps[bad_page_num +
+						&data->bps[data->count_saved +
 						i * adev->umc.retire_unit], 1)) {
 					dev_err(adev->dev, "Failed to save EEPROM table data!");
 					return -EIO;
@@ -3041,7 +3048,9 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 			}
 		}
 
-		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n", save_count);
+		dev_info(adev->dev, "Saved %d pages to EEPROM table.\n",
+				con->bad_page_num - control->ras_num_bad_pages);
+		data->count_saved = data->count;
 	}
 
 	return 0;
@@ -3096,17 +3105,17 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 			}
 		}
 
+		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
+		if (ret)
+			goto out;
+
 		ret = amdgpu_ras_eeprom_check(control);
 		if (ret)
 			goto out;
 
 		/* HW not usable */
-		if (amdgpu_ras_is_rma(adev)) {
+		if (amdgpu_ras_is_rma(adev))
 			ret = -EHWPOISON;
-			goto out;
-		}
-
-		ret = amdgpu_ras_add_bad_pages(adev, bps, control->ras_num_recs, true);
 	}
 
 out:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 927d6bff734a..020245eb6aa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -570,6 +570,8 @@ struct amdgpu_ras {
 	struct ras_event_manager *event_mgr;
 
 	uint64_t reserved_pages_in_bytes;
+
+	int bad_page_num;
 };
 
 struct ras_fs_data {
@@ -608,6 +610,7 @@ struct ras_err_handler_data {
 	struct eeprom_table_record *bps;
 	/* the count of entries */
 	int count;
+	int count_saved;
 	/* the space can place new entries */
 	int space_left;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 54838746f97d..91e20e317cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -743,8 +743,7 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom_control *control,
 	else
 		control->ras_num_mca_recs += num;
 
-	control->ras_num_bad_pages = control->ras_num_pa_recs +
-				control->ras_num_mca_recs * adev->umc.retire_unit;
+	control->ras_num_bad_pages = con->bad_page_num;
 Out:
 	kfree(buf);
 	return res;
@@ -1457,8 +1456,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	if (!__get_eeprom_i2c_addr(adev, control))
 		return -EINVAL;
 
-	control->ras_num_bad_pages = control->ras_num_pa_recs +
-			control->ras_num_mca_recs * adev->umc.retire_unit;
+	control->ras_num_bad_pages = ras->bad_page_num;
 
 	if (hdr->header == RAS_TABLE_HDR_VAL) {
 		dev_dbg(adev->dev,
-- 
2.34.1

