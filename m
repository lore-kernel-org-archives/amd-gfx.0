Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E840D3C54C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 06:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F8E10E355;
	Fri, 18 Oct 2024 06:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5leHfN1";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9710310E350
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 06:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND6n8BP/0xRe/pGeC4ER9zjyg0gQ/NZaOsI33vrbndCpHtK9+TDxQ1igJEMsoWzMs4xqKf63LaDQL7Zo1JjdqB7bDzWDo8VoP7eYQfEOJEsbQqdtOOdlTqzdxYdR551xNKcoj1BDP7++fedoEqtkcI4RVm/WyQPykHwCeUv6EQkKBOS4vVkNrLYyAoC9rqgpPk8iOf7Axauo+jVQiRREy5sWTLV9/kk8ezC5Nyg43JIlgCAIU6XsnO+WygkGGTL4lhg2FD+5qRFsxD3DlxRJeJmQ7uCuFDlPVECB+pRPDpOoqTJ4lrt7TkNpXWodZ+9w+BITWpnhkfek5gL782k4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0i3npKAk/XzFuwZHccL91yY3oQ14NVQti1IuGI+fTQ=;
 b=my1FJxm7DeGyLfqW1iO2uHg8Tec5MN3KRHO83PH27Ke9uH2kk2VRQrFCS4zXsuEvLw3Davfx2htJIEWKf1DtzvxN6yKtn6dewwjjpju0jLGivom8sdC8w1ZNLDSSKxG1OmwgJCnxgBTBo4JxHPH13kwbvznyAmeIKQ8338Z+CihbYzymaebubTq/S5IdItp0pist0EPh/YZDlAfvKT0Iuj64/aAIfy8NvH3FAH9gJkMaL3u0j2fYFzE60Vl3hcpqgMkn64tVKa+uxdOedPrcA4kSs10i6lSOepcv9Vrj4Ek3Ylg1FfVMaM1yxoYvQX34CDvipR1FUpyS2/DyWqKwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0i3npKAk/XzFuwZHccL91yY3oQ14NVQti1IuGI+fTQ=;
 b=p5leHfN1LG26Ia/3p6nXk9+SSjOeDaObjt5siHX24VN2rftFoxLnzotFQMzC16PkAB3PnicJdOxFlJAYfQTKNEp6nJWJ1sDLknmdzT2rf2br4NXo84rTpn75zdxhLIbkp7Y4mGqHHyRSA5qQ9kV3AcGFZtyHl81rNd597df6U+8=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:35:51 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::d7) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 06:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 06:35:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 01:35:48 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the logic for NPS request failure
Date: Fri, 18 Oct 2024 12:05:33 +0530
Message-ID: <20241018063533.3082692-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: cce2a265-f817-47a4-da4c-08dcef3f1be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2xZfHYXoN3qL2EgI+bBsjwBlRfNtswkWkKElGDF6VImqG6nbyhymviKTVKI+?=
 =?us-ascii?Q?PAJIrjHBceiZ2V50X3nxs5i17T0wvWuWLWGkWCUnKTsTaTudU8XflXkwZci6?=
 =?us-ascii?Q?zA5UzRUe7rYD9/wN/9xMY0B01jNAvrPDUoiF3TDaXqjgDdDK1O5YAUAKH+lN?=
 =?us-ascii?Q?pyXHk0f4ep/b6WfBRyZoDXj9uDawNkaTlxkIXypy8XK/ZQiDRFj+/zdT1KVn?=
 =?us-ascii?Q?4+cTesoMl5ODUxs+/Z/lBV/LL9a68VShxYP56PrVcHuFxPc+c/63vtlvbuWH?=
 =?us-ascii?Q?DJVY+ohoUwhMWw6p84yVwQu6Dtis+siIyveR1kD4TJ9ue1/8LicLZeQgxoeB?=
 =?us-ascii?Q?fyOnAGC0tO8C3S/3pedMgpJCTF1Kd8HjisCvQkR6PqNgGgTBOZcLpPTAlN38?=
 =?us-ascii?Q?0HoQ+kyKo0EEkB4PRt0Ixb+PhEhky3b0VDAqkZxvFx9QkcjZVZahQMoD+s6F?=
 =?us-ascii?Q?o23C1wN66SXEYIgQg3qJn4a5iFM2iRcKXfO7nNFyR5psza6D/MfEPAUfU2Fh?=
 =?us-ascii?Q?kcKz7/oEn0HHRGjhleFsklYzlnqMR8OxvJTE30WJg2UVEm0jnmvBIS9m1B/D?=
 =?us-ascii?Q?hTr/joUmzHJpRlT69DN0+BFGKdP0OIERAJlYscYr0W5DBbnTiXGA6DXw4pXY?=
 =?us-ascii?Q?PLxaod8PWjW1DsFUpvQUgeXCO9j91s9/hWM6lUh9c83ArOhQI+6Gq64AogWc?=
 =?us-ascii?Q?vFQ+MNvX0+PXXGJVe4dp8WGQx8RDxF7wj8BvzC7yJyVk6oQWW0trGrrX0o5S?=
 =?us-ascii?Q?ntDcDW5d/fd0EbFSDCEp2Liz0pEoUKtN3+CzngO59TDkqSkKaM4HL+pekltw?=
 =?us-ascii?Q?shLhTCGa+3OiZLnJWmYi76zea3C9An3/IBs5mTmhHNUqlk22yqAyL9LMU/Ya?=
 =?us-ascii?Q?D3vAkQ6b/W+GUv7DIo58ggvtzpdrisDdpmsMjEm5AzOKg/ozpVUpoZDKePPQ?=
 =?us-ascii?Q?37jU6Bc7HacP7nKJKkvf8ty4VZVjuBGuPBSvDP+qvTI2EjA2+Vr2aO5JErMd?=
 =?us-ascii?Q?JQLG8KT+Rta6dO9ljyEq8qCoQgOvAWuUBmhDbjSxTs2/pfHq7KifT3WuYGY9?=
 =?us-ascii?Q?FlKK05+40vdLfYvJJ+C0iT3dQTJMluSIYr4Veyr6j2hgw7nw+rTIT1Urri1/?=
 =?us-ascii?Q?qvfBPpcebT5VS0snqeuBdeO4tm4isB40W7nDn8pyrPHMqdR7wZ5UAMcvddXj?=
 =?us-ascii?Q?Uge6YcoHVmVXMgw6k+8gHNSBJVP9auGQSrWnmeLUQANvMzaepWDTiza4wSDU?=
 =?us-ascii?Q?MiBF8dFwLKx7R9Fa7pIdtewTsrfg09LcikVrp0yTGAHixmR+woxMqrdf+0ah?=
 =?us-ascii?Q?3NwMPlEXUw6Xzkdup1zv3MZKVKiMQPQcOyja+swpSRGuiILKGUunZyzwTj65?=
 =?us-ascii?Q?1X5nqaN/O4rbpCCS9WVD7gfx9BDbQhLSmxkJwuzKDEnnto3xYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:35:50.8791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce2a265-f817-47a4-da4c-08dcef3f1be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

On a hive, NPS request is placed by the first one for all devices in the
hive. If the request fails, mark the mode as UNKNOWN so that subsequent
devices on unload don't request it. Also, fix the mutex double lock
issue in error condition, should have been mutex_unlock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Fixes: 44d5206ec07c ("drm/amdgpu: Place NPS mode request on unload")
---
v2: Add a debug log for debug purpose (Rajneesh)

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 ++++++++++++++----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index fcdbcff57632..3ef5066ca529 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1586,26 +1586,30 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 	 * devices don't request anymore.
 	 */
 	mutex_lock(&hive->hive_lock);
+	if (atomic_read(&hive->requested_nps_mode) ==
+	    UNKNOWN_MEMORY_PARTITION_MODE) {
+		dev_dbg(adev->dev, "Unexpected entry for hive NPS change");
+		mutex_unlock(&hive->hive_lock);
+		return 0;
+	}
 	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 		r = adev->gmc.gmc_funcs->request_mem_partition_mode(
 			tmp_adev, req_nps_mode);
 		if (r)
-			goto err;
+			break;
+	}
+	if (r) {
+		/* Request back current mode if one of the requests failed */
+		cur_nps_mode =
+			adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
+		list_for_each_entry_continue_reverse(
+			tmp_adev, &hive->device_list, gmc.xgmi.head)
+			adev->gmc.gmc_funcs->request_mem_partition_mode(
+				tmp_adev, cur_nps_mode);
 	}
 	/* Set to UNKNOWN so that other devices don't request anymore */
 	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
-
 	mutex_unlock(&hive->hive_lock);
 
-	return 0;
-err:
-	/* Request back current mode if one of the requests failed */
-	cur_nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
-	list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
-					     gmc.xgmi.head)
-		adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
-								cur_nps_mode);
-	mutex_lock(&hive->hive_lock);
-
 	return r;
 }
-- 
2.25.1

