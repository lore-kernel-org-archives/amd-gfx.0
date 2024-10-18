Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B955D30016
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 15:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4DA10E948;
	Fri, 18 Oct 2024 15:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39kbpTqY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B6610E948
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 15:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0ajU9pxNDANZoWWgwxNZQuYXuxlggPy7bdCgxm+UEZaJ36QXH+ea/VN5Idx+x2YfJAjObwiktc+z5OHCucAxffYBsAv/7P5+SB18kScqivHhIv7GoVYSCnfWMu+7GeoTRyl0iRqBtoSJumrIKLHB/XmgcBfHPdJAr6OJ1URxZf109difpmsp+H5BLEjOKH9vq8ODXWpzHDop4ZLmg+pkyyec+MwATYH/hw8eE0TMAncv94cS4uo+RwUUXu4ePqnkOKFYOVWz27gVLpZL60nFeHax+jlRe+tSht63IgauMZmIrkOhCBPp2eNmMyjH0DK6ogWBEtV4FxFaiTUmhUSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a8x2+a2WV2bnc8muvWc8xJpEvwa/6g7u3WbaLMmxxI=;
 b=soL5Cdcqu9H0IoLmQm67uRdoYfRK5k67K0luueTf88gNHS2gD3D6Bkydnb6ZAzoyN96k9kaiAZkm/1sPUINwLh6AevhgBusMCyJN5PPhwzALkteusWu3VARaIUEoqUXsNbkX2p7TOKD6PDu+d274bwbB/spgkxkDVcqvpRJNw0GV+t7UD9XGMf0lolAwRqGupnoPctWVKwIqm++8H5/bKqfh/F2YBNFUpu3KHSgZVEXsWF0WswWz0dkPWAnAeYuSgTBvPPwp+4zUtRmEN32cqmCpvbC50+8mFI7eDkfYWFGtLL1qKp+9mW6q0+eFM8qPbe9x3XtQ79MSZgQN0RlF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a8x2+a2WV2bnc8muvWc8xJpEvwa/6g7u3WbaLMmxxI=;
 b=39kbpTqYqLUF8LDkgOCBWzLWKgF/YRdctTs/C0iq0gAntOj0vZ73dmrlO+TVCKySt81ZBvMgll1YCRc5FlJzhKnIGLEurNFbFs5voPYJTCj2BtAUZZAUTVCT5Wa7v8JNRPh01twdq7VOvTRWijVXjL+wYd74ZadYIoUPJ5W2gyo=
Received: from CH0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:b0::25)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 15:12:30 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::27) by CH0PR03CA0020.outlook.office365.com
 (2603:10b6:610:b0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 15:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 15:12:30 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 10:12:29 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
Date: Fri, 18 Oct 2024 11:12:14 -0400
Message-ID: <20241018151214.96717-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: e43b68e9-e13d-4313-0674-08dcef874922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hVHMLycQJWadRt+3AV4sW/Iu/XEtKj6jGIol8o8rz1CP5Nt9pe2XJ86LbKne?=
 =?us-ascii?Q?1B/FVgjjFY1n9tOuYFgbIEFR2oy2Mq1wBxKhJ2ynvEHzaDlVlZybx7NqycNF?=
 =?us-ascii?Q?EduTd6KbU+yHHRV9fUe3Y3UgzUdHa2V8C3SVF6k86H/j45h/na5EJfhuBjmI?=
 =?us-ascii?Q?+HKlkaiKlf41Cty6lTV7PiIvNQj7z3d2mNG2Yk8800X0jqBvO2fyluzNUGgc?=
 =?us-ascii?Q?2dHtSC14Iv+Gu+Pl6Sj/bQVm4n504d/354bLa86uLGZ2jz5rYW2wKAdcVc3b?=
 =?us-ascii?Q?dve1GVyccAiKVLe9TWgRKL7ji76XUNAN48U07yX9+Veqfv28h4IFa+zQHi8/?=
 =?us-ascii?Q?yqWgH9Q6yCCCQQ8+PRxW5D8Caoq3kBlcS9t3djlMd+r/Tlk0VQQ4kw72VC2y?=
 =?us-ascii?Q?fkNhvUMukgvCFuMhPv9o3FvlrJ0H8Fe2gHKrxoa1KWPTmg1gbx4cH11Dn1s6?=
 =?us-ascii?Q?SVG6IeSLR7DgIsPfcgAiQvJG+dG1JItJwV82qHXWWJNXT8hK22wS7mTIHKi4?=
 =?us-ascii?Q?G4clVwqu9kHzoHFkmOkBDTAK2zbE0C4+jSXKuRZdjeHvzar3rJi4a3Sq/9Mb?=
 =?us-ascii?Q?SlQ3DwRro34d9Dv5/gwg94rrhPR5TimoSv+4YCZrQ30S+fwx0qWKImXp5Lc3?=
 =?us-ascii?Q?90GntXSbQB4QyEzqpAUzDfxJxfbS5EXJaPv7Y4/YwZWSl7WpdJm2KPMZdfPt?=
 =?us-ascii?Q?td5v+6T3k30Mwhh4Cv/ODpg15tGb42xwaBmQGbqDTzYlzM2NJzWW/z3jz58Y?=
 =?us-ascii?Q?GiOlqBjNAOWjJOY2J1qQNlnkzXrbtJ/8jsXo9MNMQACOYTAXDx5xaGtRUuzE?=
 =?us-ascii?Q?cBRmhMBoKVRgsGlgOTcWsQ2CAB9mG4Ez94xMVfs7OOTtredrS55Z78moJkQG?=
 =?us-ascii?Q?rdlw3D8BQG6MHJ65GZVgD/ZUNGo2kqkSAUvtj1fRRutRLbHCBOvhFrgbOipI?=
 =?us-ascii?Q?xERF0V/EhRZKVoP6dHRF5HGdhIY9b7cPXpbKWf+gMqMOWeGVDbkdfB5tw8bj?=
 =?us-ascii?Q?FJ+o2FTKuB5asIQwYmxr6FwhLD+VL6v4lwpu6JEXMfZpxKFLWIjpzkF1X65i?=
 =?us-ascii?Q?XrxONs6HA3hceAtibWVPl90N/3ePdHALYaXcKgxlrQuvHovzAR5s6Xog1T6v?=
 =?us-ascii?Q?o2AKvfmXNIq/G7ZKaj6Azw5y1I7Pc7hg+hCANdYlOJ6p+3PQbueFGx7AjDKH?=
 =?us-ascii?Q?We+JdF8B82+kSng0YXA91CGeh47fWWsgpICXoMg1Ax+AyqPPr7so1UvVPjJQ?=
 =?us-ascii?Q?hNFVImQCU39AgBgxf1FXzfiYrFg6PmjDqAl9Ao/zSHXvCi1QzqkPRBT8GwsZ?=
 =?us-ascii?Q?QfZ8/p0JQzYkQer7mQsqieAd8IIXAMHc4NAz8MpR6PC9BNNt6QlPMFhPQy8q?=
 =?us-ascii?Q?+YJQQ6E8KvIEqvTgV6ORfuF81wwlx79otDHL3yvjG0jofCKMsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:12:30.5420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b68e9-e13d-4313-0674-08dcef874922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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

If a 2nd fault comes in before the 1st is handled, the 1st fault will
clear out the FAULT STATUS registers before the 2nd fault is handled.
Thus we get a lot of zeroes. If status=0, just skip the L2 fault status
information, to avoid confusion of why some VM fault status prints in
dmesg are all zeroes.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5cf2002fcba8..14a52c33bffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -175,6 +175,16 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			addr, entry->client_id,
 			soc15_ih_clientid_name[entry->client_id]);
 
+	/* If status=0, we don't have anything to process. Most often, this is
+	 * caused by a 2nd fault coming in before the 1st one is handled.
+	 * Once the 1st fault is handled, the fault registers are cleared, so
+	 * we have nothing to print for fault #2. In that case, don't try to
+	 * print the fault status information. The information above is
+	 * sufficient to note that another fault occurred.
+	 */
+	if (!status)
+		return 0;
+
 	if (!amdgpu_sriov_vf(adev))
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
 								   status);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4df4d73038f8..c5fe31070cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -144,6 +144,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
+		/* If status=0, we don't have anything to process. Most often, this is
+		 * caused by a 2nd fault coming in before the 1st one is handled.
+		 * Once the 1st fault is handled, the fault registers are cleared, so
+		 * we have nothing to print for fault #2. In that case, don't try to
+		 * print the fault status information. The information above is
+		 * sufficient to note that another fault occurred.
+		 */
+		if (!status)
+			return 0;
+
 		if (!amdgpu_sriov_vf(adev))
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e33f9e9058cc..fcfe512f1271 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -137,6 +137,16 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
+		/* If status=0, we don't have anything to process. Most often, this is
+		 * caused by a 2nd fault coming in before the 1st one is handled.
+		 * Once the 1st fault is handled, the fault registers are cleared, so
+		 * we have nothing to print for fault #2. In that case, don't try to
+		 * print the fault status information. The information above is
+		 * sufficient to note that another fault occurred.
+		 */
+		if (!status)
+			return 0;
+
 		if (!amdgpu_sriov_vf(adev))
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 010db0e58650..6da2ca28375e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -675,6 +675,16 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
+	/* If status=0, we don't have anything to process. Most often, this is
+	 * caused by a 2nd fault coming in before the 1st one is handled.
+	 * Once the 1st fault is handled, the fault registers are cleared, so
+	 * we have nothing to print for fault #2. In that case, don't try to
+	 * print the fault status information. The information above is
+	 * sufficient to note that another fault occurred.
+	 */
+	if (!status)
+		return 0;
+
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
 
 	dev_err(adev->dev,
-- 
2.43.0

