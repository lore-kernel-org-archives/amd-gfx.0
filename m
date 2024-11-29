Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C432FD70E06
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 02:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3217510ED7E;
	Fri, 29 Nov 2024 02:54:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jmk76RK+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B4310ED7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 02:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDW/cbOIitw6QWX8sLDgUNlkIbCp52kM42+NqBhLoHl3p/g17/+QnuPhesxjH9bagn4D8UjhvMdAlZgWYh5eXaI1YBfwisuuOhhcuig+4htXw1jrVuhGANzPHwXU0dP/Yw759OWMsX5RfjbiXzWuu3X4GoTxvhtg6oO8TBeF8qA0lujo2T08qHD9Mvaa83GfqkTTK/GmP5qIury0Ha9yGQOEdNdLByMQt11+6UDURgbDhInvIxD5DhWzwRUjBoNg0J3VVFD5SCLw4/Xfl9ixDeLX1WU7EPr2GJKJsU+8f5k4uyr0poT2cyp/pmqcAZ73Chp82kxtk6CCRqKTkMudvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2qbKhABhYNZakmCoWucKipQxk0ghe1JneAjzNoYwYo=;
 b=NjyJsBF+exAKxFJh7470ZXyG688Vk90c1e9lMjFRyCY542JP+lZjKqcT4U4h3UKKYAImdN6mWafw4GF+5KS+3IH20oZpnIqazPF82oCGGff0a/eakwodtWjOBD69zJxFd2EjLGqSP89EtlAsnwlqUQzMAzt9gNpZ8zv1drknGzCqOjh24aUqgnRjmzk+FgudOjLVZ+emveS0YUpR/sc7vv9K3L3+58tl+PUFN0yGD0gM2Z4prOsG/wDcbw2evE4W40gpEs1DMKQ8S0VyPQpILiyMGQYydjE039jcpE/fYbh0svt2HXGpGKTUFTJ3K7KNsvGjfHJFRSE9lAgay4xvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2qbKhABhYNZakmCoWucKipQxk0ghe1JneAjzNoYwYo=;
 b=Jmk76RK+MPnP6dmY6MMO4kiWz50r2fueFx7Rw7yxxhdbGal1uxe1zzmzRBrymED9X8tcMVbH3NPfiLiIyE41g1ET2Seibpst3y4UzVYzVAgvvDrNycA3GWmNdtmmQ5WD6TfuLCVN0ZPyYmPmszkuZ5OZLU7y0+od730UAvxHvqU=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 02:54:43 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::d9) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Fri,
 29 Nov 2024 02:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 02:54:43 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 20:54:41 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Simplify cleanup check for FRU sysfs
Date: Fri, 29 Nov 2024 08:24:25 +0530
Message-ID: <20241129025425.3476192-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: cb92775b-4e5b-49f6-2a0c-08dd10212d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5O1NUrMyTuW3G0SO7bCInFF6koera9jIuTyAtSjqOk8bCqT1hJWCBGXJ9yYT?=
 =?us-ascii?Q?oulAblTNKdQRW9Ze+esuKM2Z9CN3VDfbyPFnxdGACnyb0olmZfl9FYJWFGDZ?=
 =?us-ascii?Q?WNA2yMjqFCrnwhDyXYnGERjyH5ilYJwlSx2GIYUa2L3ASlJi8ZjNosC97zHn?=
 =?us-ascii?Q?wS/+OpFYgzpPh/dYy/5QdSjxTFX32+Txz1kb0Y5qAoaT+76BkNd9EW5fBqkT?=
 =?us-ascii?Q?icgaSVwDFsJHfUtdK9kk6opANCRMOVV6S5uSZc221i8sYY8/C00X3Ww/R4Bv?=
 =?us-ascii?Q?IGkmRBqiPxVY+C4B3LA81P1U8vv8M5h25uvsdm1AJkEpptP92LNKCoOXkid5?=
 =?us-ascii?Q?6gW3SnV1cKrShTCJJ0HEaL5SdMMfk+xxzOqIJ7Ek1euhkhmLbwRH9S6nMV9F?=
 =?us-ascii?Q?7oC5tIi6KO7oMBuFfmd+P01uqy7WnYrr/Yt9hQzIflWHjMjKrn18G5ceDMmR?=
 =?us-ascii?Q?4VTM/CrpP+1VobXgmS/53L+uqjfDRlz26S+bAIE89gWQL07SnaO9zn0MXJZX?=
 =?us-ascii?Q?OQvmyWKoWkwh8MFl4MHgO6nLyOV+JZct1O3CiDCEtv9FyIJUbYv4pQ4KEWxt?=
 =?us-ascii?Q?bXdlgAMRRl03p635NSIaKJFpicF6Sbfe9cr25zyWkDMih1BEL1tJVf30cK8B?=
 =?us-ascii?Q?UTPkrBbb6GdiATgxBwGrcwZ2sDuKr7XfKcXg59QGn1YvnswE3rhsEYpc4Z05?=
 =?us-ascii?Q?YI0BWEoulM8aEZOnBX8V/3uOnpqttZjR0VAEj01qogg3ZOuvxBDuxno8nl6q?=
 =?us-ascii?Q?WDo0WpGyC/A7bTw2XNjgnak+h9SkX/lsxb9Vfu9/wDMsijLw7Y8H7mnvl0jZ?=
 =?us-ascii?Q?6ZtvgO2UUIGvulFZX+A/T+5GVPUWkxB+cVD0lNYhUVkW4JLmTa4GzMR3ZdEv?=
 =?us-ascii?Q?xk8w2UX/K6DktJq0WhJpddeqrwTsP9ipkilaZLX0JGReVLeK1qTLHVvYT4Bz?=
 =?us-ascii?Q?1IfminPE9S2Dwnc2c3NX4EmblcD4+l6Z5fj0aW7gQdvBPc+c8vMM0hefyef3?=
 =?us-ascii?Q?wP555Sr8SUS7KtN4sgdyQEmu4NsLThq/LNwGfTd8ehQeXrwxAjc6k5et7JN9?=
 =?us-ascii?Q?9Yvuz9rmuYVARnd9TffuT5C9JedR9uFOlug35W5+OWgvjd3khtw3SkTXrkyn?=
 =?us-ascii?Q?WDy2Rqmkn4QykiU9FJktwWeic2D3jw/pZOn2QuN8uwAflQmJaXTH5fkWgvl6?=
 =?us-ascii?Q?Muk99imJuUPfkrZisV7l8O4rDBinksyQvV55xbSkQvphGzQ2IMdBSCyMJm5j?=
 =?us-ascii?Q?2Cso5GraOZ7YfEcoGAiuZArMFMsPqshn724vCYVnbmd4N07Lszk42p04Ulxy?=
 =?us-ascii?Q?ysbU5erNMoZmEq2Q0XANT50oNICGJ7/acM230IfhUMDO7aonTzKZhYRXSEfW?=
 =?us-ascii?Q?l5bHt7Xb21fsLqwR39TvNsuM+G7iM6G74/wQqsD1riwhL1Z17ta7lH4WcAP3?=
 =?us-ascii?Q?wPZCtlfUbs+1AJhskF1IAbnJ9UE5Y2+7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 02:54:43.1696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb92775b-4e5b-49f6-2a0c-08dd10212d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
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

FRU info is expected to be non-NULL if FRU sys files are created.
Simplify the check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index ceb5163480f4..09c9194d5bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -384,7 +384,7 @@ int amdgpu_fru_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev)
 {
-	if (!is_fru_eeprom_supported(adev, NULL) || !adev->fru_info)
+	if (!adev->fru_info)
 		return;
 
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_fru_attributes);
-- 
2.25.1

