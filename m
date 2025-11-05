Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF82CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 02:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5543110E697;
	Wed,  5 Nov 2025 02:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CcCiCirR";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 390DD10E697
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 02:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQATToUBhR9r2w3X7S1/t7sVIAki80Ov0enB2nSZSfV1kSuVKDb4dDHuKw+jHVdGuuqWnUJBtO6igURbm+BoArCRkI0i49sAnt86KOJYaoxyPHojsiVFbM7ZsI8ZB1ay1js5CEoERaUaaEboIUcGbC7GayrebO4BxW7jnB2mtWwRT1rT8WLJhRGH9Myji5h8tC+lntjF5PzZ0/UEnRUn8cK5qcQHwyI3oPWJc2qxg0DLQj6Sdw4YSz6B4iWTLksy1ZhFT7dIPC2Y/X5cVw8rnPbN2g/RAwATzQizp7NQF1JfcIgfBs3Rs7WpSgrM5NvmqHvcC3SKKW2krebMGl1O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToZUlUmQ4B9id8l0qByKIJsRNRj66veRwZcgjRgsc2I=;
 b=Xk5YIhtPoB1lGzIXTgF8NUaGDAlu16/DT6UFbBROICaP6RR4IgV2autwnZ/+q9x8vCKI0ByMX2GTaOHaOY/WD/0doWWDZsGe6uFnvigJVXiBiixomN5plsFs8LaQlr1mO+AEJPk6Cl7CZQtRfp96MJozryHIvxKTPmzRycZP86Y4E8GXGi1rFpR8YWedHveUtJ3LBAbEyc4o0JiEIWVfm2MdGcnFTsmedythjok4KEubErJXjxX0sWy5CsBEeIElCvW/RDH2CDjTo8Naj/+WRjkd/Vdcrh17eLmVhsRQmKwSSm3F2cHAY6LKlJ35uW1FBXcHgJFoKdRKO0gbqXErYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToZUlUmQ4B9id8l0qByKIJsRNRj66veRwZcgjRgsc2I=;
 b=CcCiCirRbgwkh1T5nzRLcHgUUBmUdDEe3Y39JYmLXNd3rY7cYPvPHZ/GSCTAhDf0jH+TUvXXI6yTXMXKy5WjUh3qkxed6EaGGaczluEsZOTirBMKGJsQskkM2jGF35Kx/+6sicQ6/51G/ELVLxsgIf5Duaol6pgBoyfu1HfOZcY=
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 02:04:59 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::99) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 02:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 02:04:59 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 18:04:56 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: support to load RAS bad pages from PMFW
Date: Wed, 5 Nov 2025 10:04:40 +0800
Message-ID: <20251105020445.1423034-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105020445.1423034-1-tao.zhou1@amd.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 032b3f7b-0ff2-4a08-cd13-08de1c0fb968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rYRwcs8k4u4hRSH8mIXPqHwwnT7lf0aN9b6QhPDSbcUyFUc41qBZmr26+azq?=
 =?us-ascii?Q?9T/TiiQMjEk4xWpfHwzb1wao5h22tEQWJUjfgbPHCQe2BIfeA5quXIPVrTiU?=
 =?us-ascii?Q?o87his2v2Lo7cG2b15pq6Uz5JY5eIpN889NYSV6A/PZjkNaieIMEoAjttIMj?=
 =?us-ascii?Q?RCV2qV+Ko8uK4QqpPrU6QLnbFF5L/WoWXGhbzIBbTd4ENQSgnvzNz6zhRkev?=
 =?us-ascii?Q?1+IDas9NXehRhSGWNyNPUWXTEXWQ+QpxjlaLC5FTwwJGlxGJRpiSvKb7TNx+?=
 =?us-ascii?Q?QUp8muazLF6XM/hL6p6olTxi3AURPif/oUL7X2LZCCkVKqQo03S8QiIK0Ymd?=
 =?us-ascii?Q?/Q/QonBtRGUd11KKfooVGTGUj47XvCaPng3hxNmrPlVxqmvH03baHXW3jQiY?=
 =?us-ascii?Q?NNZb7znDlVEFkd3/nJrSjhKhpPdx55ikRspT954UiWJKZqCCA+ujUqIA+cQS?=
 =?us-ascii?Q?YqdACrmMgteeAS4M0D1y36WGu6c7ixkNQwoS9+Ichxx/Yx7vPT44x9Ztefpc?=
 =?us-ascii?Q?KU7QCNEcLRDRkt5T/USHszZrSRo3nCDVvA3Or2+m8jLMkQWzYD/LKIevC/nh?=
 =?us-ascii?Q?KMa25AivVJUer7bpv5mjJSFR0hNDDh60qRm+M5oXggiKtqRgoJZb0bOkFRN6?=
 =?us-ascii?Q?3TcIcUewJlgN8DHDt8X2SOuvqNoOP3fYO6EPG5tWhRkoTdm001W4Sst1qhvc?=
 =?us-ascii?Q?C8g1IaDQH6yFFyVN6fG/U7NYq3vRfK3eDKAXBlm73kWv0Vi2Ewl3ZCcvof5x?=
 =?us-ascii?Q?m9utyb0YQAI6J1WBvKXpKL34r/P7W9XkftcNilvgr20HlXj2p9m6QMbSiopF?=
 =?us-ascii?Q?LuN8eLdpZGASfpq+fsinVKjFGqNVv4Ybl1qDJgAfF6BfwnBO34t/19nmivnO?=
 =?us-ascii?Q?XDSRCGTHbFN0DftukcqbJ1iisnrGOXSWGIZaecTZL5PAYsUKo3RlJmHfch/0?=
 =?us-ascii?Q?gkxM4677rxOKDVYrOaN13KOGDZH0+7Q8mcLuxy3C5EkyQAxOSsJj8wZK86G6?=
 =?us-ascii?Q?S21A20ZY+ajjlMxNlFOXotqJh249babRQcOAAigaZQkSZgLc4mjDvknBIK5T?=
 =?us-ascii?Q?3UrZY2kyPz3rh2jCPSrhJC8la7wiPGXcH11Gnj6bAiwSvC6Wp47p8EZATKrw?=
 =?us-ascii?Q?HYJl1VRgFBJ7guj3w0tBqNMFoagPNM3qeoFTRsVjluW303tOkZhaPip6u3Fv?=
 =?us-ascii?Q?iqfNl9xfkXh3vlS1P3JAPJp63d6bdfaHDp/DPjJoxbXUo/ohYqqzBLKi0b9r?=
 =?us-ascii?Q?yK8J8DnUAeJaEs8IzAohB4DtO9oudR9XBcwWa+EGonOkg4zaoUk1n2Oppi8W?=
 =?us-ascii?Q?yz5RDBDPFJuNxImkCO9Z1nfYZ/xwVP/FrV/WeG1dNTexfbBdo4OqibXMlUjw?=
 =?us-ascii?Q?s0wqNo73i53R14crxqTSrYnzfE7U0wUsFYBeGZPjsGWae2SG4QdoXBktle51?=
 =?us-ascii?Q?XTdsvZv8U7s1AwwCnKuxWqXZZiU59xoGvmDQ1m00qIemh/CwMzdTo2hgzyEU?=
 =?us-ascii?Q?0K0Ni/gaal3dx7wlsUxW04DjnhL6DNGqhmGHfjnnAKk0+PJnld37DFmOjwAh?=
 =?us-ascii?Q?7JSfGa91EycikbDBL2s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:04:59.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b3f7b-0ff2-4a08-cd13-08de1c0fb968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

PMFW manages eeprom bad page records, update bad page loading
accrodingly.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 402b6b002a11..de8aa2e36d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3154,8 +3154,12 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 	int i = 0;
 	enum amdgpu_memory_partition save_nps;
 
-	save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
-	bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
+		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
+	} else {
+		save_nps = nps;
+	}
 
 	if (save_nps == nps) {
 		if (amdgpu_umc_pages_in_a_row(adev, err_data,
@@ -3221,7 +3225,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 	if (from_rom) {
 		/* there is no pa recs in V3, so skip pa recs processing */
-		if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+		if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+		    !amdgpu_ras_smu_eeprom_supported(adev)) {
 			for (i = 0; i < pages; i++) {
 				if (control->ras_num_recs - i >= adev->umc.retire_unit) {
 					if ((bps[i].address == bps[i + 1].address) &&
@@ -3352,7 +3357,8 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 			/*In V3, there is no pa recs, and some cases(when address==0) may be parsed
 			as pa recs, so add verion check to avoid it.
 			*/
-			if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
+			if ((control->tbl_hdr.version < RAS_TABLE_VER_V3) &&
+			    !amdgpu_ras_smu_eeprom_supported(adev)) {
 				for (i = 0; i < control->ras_num_recs; i++) {
 					if ((control->ras_num_recs - i) >= adev->umc.retire_unit) {
 						if ((bps[i].address == bps[i + 1].address) &&
-- 
2.34.1

