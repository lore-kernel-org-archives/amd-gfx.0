Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3D4C55167
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 05:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CB910E1B0;
	Fri, 31 Jul 2026 05:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlV4PvMk";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E42210E1B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 05:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vq6nBdT9aqELl2+CgCys1SEIRslp+kjScT98B29CO0dtAJ5X09o3z1UpAnhNWkJN+aTZMbHeTZ0w7UIw9NZwYnw2disJT+szvU7nrFrINSuhxcjiBTezoYkhn27n/aIl+RwHsarTzTydtu/u7ugJ6kuVaifU4DxgfBgh1Gnx0QZ2RvAxhSCdP5LOccYvPLkfM0VUzLXhEU/YicU6GSpS7Ej2008AcEkC+et57XN+Z29HRWZvs16vosIWqgZbRyiq2n4I0jeACpnXYkZLAW1gUnJerbrDaXYQr55XwHHxOui5v+qJS5V6L94HwKfKU7G/WZui7/UtT+8uE1ap1ILPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLq3QVkx7tQOHep1SWnMZeWTPj+ijU3+VxZiUWONsbc=;
 b=hF2lIxIc02hLIhk5Vr87o49OeJDOhZoxO90kDSn63sIEloOG5ve5BYF1OSlnpc552qcwfvR7GpKbyz5ucQzdcHjCXqBBB095GH1/jJv1E5WoUgpDbIk169pcpXngMZHtbicOGmAkmM6SPYaOkl1rX5R7NzX08t3pQdtY3K32saAtQiyciEV6p5s+FIWzJV7nv5zAJlGk+3Kyn1mjIDiDj+lOjNr2eUpaUM8CKLbO/9LZzwynjn00hZt+W5nvjI9bk5+9l81isNcniWg/ici+EP7iREzhO7AIFZc2N6JxgsYnQNuuz6WRokJft6j9UrvqE8J0V3rs5h0PLIreFLTmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLq3QVkx7tQOHep1SWnMZeWTPj+ijU3+VxZiUWONsbc=;
 b=OlV4PvMkQRKMa7eRtfRA6376XNu9m8M1azi8OfmpOaz3CvDRg9vTD1eexjyDzr/XlfJoEjTXNHivad+bpb0NB7cEt9J2qIzmNczm/r1zqZwzY1CEZGq+ip1y5f1JsoksOVXUjYd/Ngsove1tdzeeMnyFuEDJwAFM4hxzGgH1yWk=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 05:44:46 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::52) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Fri,
 31 Jul 2026 05:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 05:44:45 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 00:44:43 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery
Date: Fri, 31 Jul 2026 13:44:28 +0800
Message-ID: <20260731054428.116651-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd9b5ea-0c20-4bff-3121-08deeec6d3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZGSoWZpXw6hlrWOKzAuYerJ3ZAAO9yc5g/sBQmrbpUwR5AShCUIRaKdiPeCeWBBV6MwMaCn3h1JeIyFZb3lA3QF+PlHvU80OSNm3gkessdzMkHVfaXvMh2XScj99k8aaQhOAO8H/7tb4OWV2ZtS0guwlep973hQ8ncPY/dpqM/Ks7DHtqjBpB6B+hdEGHmFTfnI8utplyJWpudFn57X07M5buUIutqHoyyI+Er7NmYiV2NhBcirO/Em+Ho5i5GESGz3IYeZEpF8OhjBrbLDyke2eXsswlZof0vwkSdpDPTFWW/7OnAAbHdXMJIgLu5ERkRABM70R8qTlRk5T1y5o5w/D460sj8h6M9DWF67ILv9NT3OSGL/5SK5l3ul1566fjMHrjcNZ75skqhf2InB3dgeePVi1nOEUZq1z6TA5ECMtXSqHSj0eT7VGvU4R4iupuY+/TiYhYHSwIjptISGjQHrTClhme3yA41WutTxVGNZjgSR6qgJM2eEuMbf0P4IZLIjc/CctWAa1MEdggTJDhsBf5TbrlbEygudhH5WMI0GQhbLWnUuB7x4RMwbW4GGbfCSEWzhoOKCHtX98fXWIXe8mtpi2CLPd13LXwa8vjlATHnbLRf9C/upEOOGdyhAmaB4sie7S1gO+UPBfCFJCmdmyskMiKy/29vUj8m+DmMRxcYd/NT76nQu8wCtR9Km+0u2B/AQLOwp/Xa/BanfGOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7jNKpZuUm0pnj8hsRMfIYEZJsUdMJQw/XAnrtB7fNm7CNjdfBjQ60QHoCZQIZtz2cg35O0Rk3cqYPT/NO+cmMkY1ZCCm3Ta3oYreqBVhZlcaRw32qSMccvIO3AGGJQ+tG6AEdoRoP0eNTYArYjqOblWOznkqBmo73eepDRc8iIRUY14hDr8E+4q5jhPkYiwzLc0O+1duh1KtjXh8FR+47l1NNl1KACjAJFoAGAZ8qSxmQK17RZANZvm61ookOwytYPfj1lkGB6pM30/9qrYVd7oIc1ZR62j962On6wyBuBGH5NXBtOzSyYWIN3qGBzF2v6hcwOOwCnIZv3J4dWQqZr1HPvy7xhLiKL3zga9cKCuVrmZZcXpP/bEWVBBjN6L0SjCaSMigBDy99vVNIHaWWhRXM3GiskofYdd3lo3TPvs7xbgEy/ts40nlNiSDbEKu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:44:45.5383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd9b5ea-0c20-4bff-3121-08deeec6d3bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

UniRAS fatal recovery reads MCA-derived ECC data through PMFW, but
direct query mode bypasses the existing firmware-query delay. The
recovery worker can therefore query before PMFW has finished polling
the MCA banks, causing the first fatal injection to miss its UE count
or time out.

Apply the same 500 ms settle delay whenever UniRAS is enabled before
harvesting ECC data.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d247d0ad063f..ad9a9545b1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2755,7 +2755,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 			device_list_handle = &device_list;
 		}
 
-		if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode)) {
+		if (amdgpu_uniras_enabled(adev)) {
+			/* wait 500ms to ensure pmfw polling mca bank info done */
+			msleep(500);
+		} else if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode)) {
 			if (error_query_mode == AMDGPU_RAS_FIRMWARE_ERROR_QUERY) {
 				/* wait 500ms to ensure pmfw polling mca bank info done */
 				msleep(500);
-- 
2.34.1

