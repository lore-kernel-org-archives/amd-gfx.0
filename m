Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7DCCDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEBB10E488;
	Mon, 22 Jun 2026 04:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UKY04Uxk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F1510E485
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is+trM/wEC09/Hn5u3/EmQ/DWePDG481l1bOsIYej98hj1lDknZLkR2INKQBiUe3uUxrvEpWI0bB6U9Elf3L6CRPY13XUyHZPmMsXXprlWsUTIEb2HzCOLBq86o40cQ/Gw0LeJww96PcfKY6otZysiWFtuMbRFNf0rq+0usy/eVgIoaF26BuH3udVQYGnLghKNdNLFR8345tvfOIBDNfQ0aWmED6b1ZnVmkM4Xp6Nh3z2HqTuPz7jzm5tx9MjxKejBOZch797x+7DBR5YS7cqwp0Us6Sk22dB/7em5Hl97pvSuQE5JV+yRQGlt5CXtwYMtsRVG6QiDqiP0HlDF1aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=H1Zjbfio/Dw7tBhztKGw3ozwzb9VX7fPuqW+43K9C7HNf3MdPuNfwMT4hD7Lqk0LJogqazQcPX8YMsal/VNBvPpN9fDsm9l1CmOUUnQsFxFSK/7Ekxkv24/ukVIrnj5PFL2p9GI9aQ+1Z6xK0eSSMhOO+AlZfFhw7baZ7x0LZWB/VmLkAWM36SwDjUT5CHxfKjq1SdW9Z3W112CqzRUXWHayjK3mwBKCrVFiqqejl7tg7mYKX2BfEGQFfmRlcDuQwvNRMkcJeAFLt3z2ErrnhgJf7cts1sd7tN4N4cthJaiEKy8gbVR+flvHrOqaUjPa5JHV/j8fbQS7kYvKNPzxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDfQY3ggAbc3c/0l++f+CD+SRSEY5/vaBGCizK8wTnE=;
 b=UKY04UxkM1EK92FaC0t8IUyLEgsfBy64C4u1NjD6zNNtfF9wC9rq4DYbSbROh5kYln6En58U09rHfSqbGENr/qPSM5CkVZz57EC1xWcZyYvUsFfN/bYBCgyPn/YzQbJYhUHZdN3KUCXTrXex9iCorEo/ZVrNTncYNfKCOAB5zms=
Received: from BL1PR13CA0394.namprd13.prod.outlook.com (2603:10b6:208:2c2::9)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 04:43:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::4f) by BL1PR13CA0394.outlook.office365.com
 (2603:10b6:208:2c2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 04:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:43:14 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:43:06 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 36/48] drm/amdgpu: retire legacy pmfw eeprom check
Date: Mon, 22 Jun 2026 12:40:25 +0800
Message-ID: <8dc898c09d465d6b0a4532d0ccbd4b64cfc33a92.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: e978f9b9-4b24-45ec-f252-08ded018c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: b7EO/iyde0J/5W6+wPxsXsMmufh8v3nTqNXO6QbmasWhQIDdlbcn2dC9qtS3FiWv0QhDVJ8bomLdAkpQPe4PczMRg+Z1YUqB27oWY6KeHKDFO5nOxkX4q9ddVv3208OTZf2an/1kuNPLO0EV7NTP0cP40qOiTjyDrk3mwvb3DEo7q3QzfslORl8n8ZZQPs0WujCYNSwtGVT+/3EGOdcIn7YdkjZHxr0RzEevI/lMmPeNHqvkS5o3fImY6vQoheze919ZLub97tBn/gz50kkaeCVmqRmSDHMIJQV9VZ0oOC2oi2ui9VrSDBaJI7SL9l3pmh/WWGq8SjyYx8lUvyC2N6giWx1RXNPkDRCc0FXVSKgHgfwx6FTWC1ioz2YjxuLjiB1g0pyCKH6mB8qV3VsE+TJlxR4CVGcqb3heqG/ErfkKsBem7W0AN9UETNOyv/xPieb1QhhWFvIGoxVGOh6i6tbUnnWc5Y4rwEG520EoHnVOGCMUJrfg/agl6Kb6hneBFPMmOC10uDxUFSe/GX63d0WJNB0NFy7/PTwfc7lpDqY/ghu5oS/2HA+7PwpWW60b3IXWFSlOzDeFNfmkLgbjl3qV5296UoYFYaLE/LV3avgZhZbsoGiXS20gTvkQL4xxwi8qltZ4KflJTcUnV/aDY8f69CmD6ogOgLzEF0h8iPRcG/QJZ5drnTcqAACK5YnlmmXkQlmIt7mYb73o0YAi3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jYZsCyXrXLNrR0ezhofwr9pHKxgMUkSwAFl8LXrXCvx7at+5QlEl+A9vRnhbOX2pAiAqKZz3PosL5fZty0fQGDSVswDjLf07F6SHJBPcpn9VgqCRC3St36FsvrOz4kcQMd8Dz8+POT5coaT/FGrioZtclbrFT4glemCj2uLDwsS3lD4QhPXBKHBuLyD62+BYcjQN0slnWEychcqCoDLnoCls7HQFiiRosNwlbRbku9y577onMcFC7o4+UQVV5Qkv7tTyLMmY/lPAgHoISEbbgomEZkg2ErcBrp3xYgPs3zxEZ4QT/boXMXjQVs8vNevh+1+ZJdbdlA4zELU2IB3XCM6enPi7JS9po9+zfroS2bj3GshD9JuhnW7OHLusBqpufwmhVqZGoXLr3gE06YYc8mqTr7F4OCa7aTAH8w4jeFdm5Y55mJ1OAY9Eq0X4MIPK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:43:14.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e978f9b9-4b24-45ec-f252-08ded018c598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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

Remove the legacy pmfw eeprom check function, as the feature is deprecated and unused

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9a9633b57022..f5d1bc1142a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1627,47 +1627,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return 0;
 }
 
-static int amdgpu_ras_smu_eeprom_check(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-
-	control->ras_num_bad_pages = ras->bad_page_num;
-
-	if ((ras->bad_page_cnt_threshold < control->ras_num_bad_pages) &&
-	    amdgpu_bad_page_threshold != 0) {
-		dev_warn(adev->dev,
-			"RAS records:%d exceed threshold:%d\n",
-			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
-		if ((amdgpu_bad_page_threshold == -1) ||
-			(amdgpu_bad_page_threshold == -2)) {
-			dev_warn(adev->dev,
-				 "Please consult AMD Service Action Guide (SAG) for appropriate service procedures\n");
-		} else {
-			ras->is_rma = true;
-			dev_warn(adev->dev,
-				 "User defined threshold is set, runtime service will be halt when threshold is reached\n");
-		}
-
-		return 0;
-	}
-
-	dev_dbg(adev->dev,
-		"Found existing EEPROM table with %d records",
-		control->ras_num_bad_pages);
-
-	/* Warn if we are at 90% of the threshold or above
-	 */
-	if (10 * control->ras_num_bad_pages >= 9 * ras->bad_page_cnt_threshold)
-		dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
-				control->ras_num_bad_pages,
-				ras->bad_page_cnt_threshold);
-	return 0;
-}
-
 int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -1675,9 +1634,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int res = 0;
 
-	if (amdgpu_ras_smu_eeprom_supported(adev))
-		return amdgpu_ras_smu_eeprom_check(control);
-
 	if (!__is_ras_eeprom_supported(adev))
 		return 0;
 
-- 
2.34.1

