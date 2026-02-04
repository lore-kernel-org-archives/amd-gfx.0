Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1616BE9D40F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 17:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C0310E195;
	Wed,  4 Feb 2026 17:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hPLfRvLq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C2610E195
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 17:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+ABd2QmyBVWFyr35ouz0j+Bq+OPMgGfCoIPKEm2L8WeDoJXVpH6vowuvz7sDskK5R9zueLiq1bjVZd7DW2ksNLjBOAgUuJiGVEZ/Pu6km3k4Ltcw3DWVtaD7HfzldErDjzPEoPv0vprSimVCna3ZvF3GXrzgHZaYijYijHbMWft9cdaPc8OAYdFRrmi/GyxUgqxyEdiDs8qJgTpsr5/cgTz44dV364QawznYcXXBeNtWqEJlKssA6jy3qyYQe9EW3Um8G0nAJspMJGSwNvqr8bwMBOzNZXg7+XXLaxpChF3WJgt1jXnkQ3mMPgn3TkF9OKdcj690jD8SM1GQ1D1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5PfuAq/56PKcDlsw6daaL8dnnUdh5NGsyl9cWp/t38=;
 b=pG4oNB50tl/BbohX6U4FTsu0UECb8eNwi8RrvtwOlOhc/Apm/E2+zOGOTjiX4p3/SaKi/zzUI3EePPSHUDE5e1GSkTuIGRDSB6uSI+oq7YPzKx4KCqC3H1AhtXshJSE5d8dbJVQhu2StbfmO0ZsdVs/OYJbrcE8BZNTDKuEn4n2QsYhFKfM/9o1wvr3QrZCGCPw9zQKwXt9pQyYYsYeZJ2TggPzSQFozOBWTniYWLPxjlRty8ehd2894JmrdgSUgtMVbT8+VbAiFNX90C97LXWVeAzKYiyEjWEbFROQRGbdtirmnOfprFoHauhgNtO/yqDNPjzd1ahobqwvYzuvjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5PfuAq/56PKcDlsw6daaL8dnnUdh5NGsyl9cWp/t38=;
 b=hPLfRvLqhlB8P3sX02VpPXG/TuMNZ9x8i9jthteplGHMtLvN+6vqFv7o3BE/WvfeSRI8byk40nCxabQCb2mHKk7nvTiTHXrlA4u5r1XEaZwbjKK0mWIH1lptQndUW0JQJv8Pc8GjrO+M+ntnUKryVroCRpB77K4sDYo/bzo71Jg=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 17:52:02 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::f1) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 17:52:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 17:52:01 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 11:52:00 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Xiang.Liu@amd.com>, <tao.zhou1@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Send applicable RMA CPERs at end of RAS init
Date: Wed, 4 Feb 2026 12:51:51 -0500
Message-ID: <20260204175151.536589-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e9f518-0033-44a8-d4b4-08de64161994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JDZ3R0DX/EK0kfRw7rE4QcwUbJaRfC8r8VyYLnJYf1x3qSGPA5MPv+82gJQR?=
 =?us-ascii?Q?e77xearKVScQijDq86tZEKGSHlUPo0xxXky3fDwcRJSWMQK0TaQLQZ/CGYOo?=
 =?us-ascii?Q?8FqmHGEcgwR/+1un23qq9eF44zA2OkFXDaN/Z4h/pL2M0Z+sYIpKa893tGaw?=
 =?us-ascii?Q?nZWHUqoFvcPKfVEE56lzzBacurlmfnYLsyLqazJKIkoLX1wlq7MqQVT87j8A?=
 =?us-ascii?Q?EdahMJwhFsrGYt+yFW6A0LZMntHBU8yXadhNr9cRThfszLDj4g6wZnQg3r4I?=
 =?us-ascii?Q?4C2a03rLiU9/dfop2doKLAEKFwT5N6k0F6ghq6BLaiw6dhZMAMVlrKuJ5HnQ?=
 =?us-ascii?Q?fkLT9got2pgDBMxYRGmSvzvCCijHOEduWCxwOzgC2ypRwTHPbet0GNZvCf4v?=
 =?us-ascii?Q?Z6RhmwehmfFnrK9i1KOVLCZszRHGhN9IrC82wtjEMCsYqoh/K/v6HGulCas6?=
 =?us-ascii?Q?mDK46fDAhpbEfZH/sgSVTgqLS3lkuWdPewQHxXHdArETueW7WGphmFlIpU2R?=
 =?us-ascii?Q?9W+aSrC5temDX007MzQQOp3DBz2JiZa8ZMTuRK/SerUPxpPOMY4nVBgDMxSl?=
 =?us-ascii?Q?GS96lJGwYbn6S2PDYAT3l5CenBEbykR/AkTu+HcT77eAuiE2jCbV1v7CamFO?=
 =?us-ascii?Q?K23qZDn+IYmXD1McsImUkbLR17SpBgYZcgxLj4AWKvnHeDRnA7jgHUyEmwD+?=
 =?us-ascii?Q?hQMeQyxqqNvB35FncC67X8SSn+CrlOLrkzXd3k7rMSWhCXKvNFbuBUuRcTiJ?=
 =?us-ascii?Q?XBMZb3Xf6zmS8uDhPHpDG+nYEyq/kgvGiyS+hhg1PVyTVapHE0VNut/LzXw7?=
 =?us-ascii?Q?M0yysa02hej8iUkXwx2W59vRO/O8ywI5liJI8CZW0qL1I0yzRzMuFILQNA83?=
 =?us-ascii?Q?JGB5zADr4oBTw7ru7koD5H582n5mVoEXgiV0r27PkOS9F6n0q8wNmRPe8udv?=
 =?us-ascii?Q?qZKjb5aHyxxS1xVaKl2W71e4CHeJ7ZpVvT0Eda3zqKR1HrxDmrjMvDS9CoOv?=
 =?us-ascii?Q?jQCM4BG2qEWwSisSsLweNe+Q2A0VV2opi7SLWoNUQwJGavfs1Qstxqlrpifw?=
 =?us-ascii?Q?FOZNd2Ja/LvVppz7Vd22SMRy9ouLkjKWQmJZNgRPJrWEf38e0TPNbRc2fpr0?=
 =?us-ascii?Q?Oey+lZGIKfiIGpeeaN57XM/oKzqUAXfUjRiQEcm2uul53joLl/xZpl2wV+Xh?=
 =?us-ascii?Q?v58UGd+HMhIEtzQUBkecpamWQXJa+jqJNqBkydSVYU+rwr9M4FXB8EZXdWDH?=
 =?us-ascii?Q?XwzkFeCH83NQMYJ3iOfH2OEcUxlva+YmvCSuZrYdgGYvIdPWlijec8XN3/8l?=
 =?us-ascii?Q?0LWaxU66If0GJFes2+QfD0BSH9KjZiFcDRjTfnz6Rk4tRYxccEFcpTbuh/tg?=
 =?us-ascii?Q?DsQ9EMwEiRnEh8EaorxB5o6+Aepi/ADFWNDsxCDIB/NZ3StzKpPqr6ElInxI?=
 =?us-ascii?Q?t21Ms4+tO2HE/qHgAU7sVp2EFB2rrQjC67GivnhoWsLU9no1/L6pIqcceOrk?=
 =?us-ascii?Q?LRzkC2eoo3oDkeY1qz7zpqiF67IwnkrNsITq1bLUVwMSScj6qBpQpmOdAOo5?=
 =?us-ascii?Q?SyWGz7ngrnL3F77P3Tqe1NOMgtRG4dFoo7NwpqwJ+ZBOef92TQeHMQnYnv9o?=
 =?us-ascii?Q?zoiVToXixBZos2t4tZjp8F5JwgO6pEMUgCwIroMxaSRxWhHt/HnMwXjF1Xol?=
 =?us-ascii?Q?egxEow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8luzPFMmhMtwtGVbNRY1TeoaYzkV+vcMGYTrhZP8zuPq0mHSZPkBT0fwgLFVSClfgncP4OiQFFcE2UYUi22MzU1bAwZxkCIrDwrtc5+VKgxZ/17G5/p0nfOaG26XuJqSz2EEll5kyBz0HeugmPTPtDSbyNY5vkwVtFMRUNtg6Mr6btFhYH+aEYyMZvMcGDUtXXaN8m8PmXHGXJGnipZ9WHw+KZrmIzTih9A7DNq/40KTk9xLaXdUA5kcbPnyb3o9H1KdP4XUhn4JMEypfvtSlpeKnUw0sIMNKBCZ/3R/2lo8/11RJXfvj/YVx0RwMD2Fx3TukFTJcZBAqMDXswjSRmATIHUR1EHxvW/WjmJ+l3DHrnLgziXOOxjqUUkBxOraCxsjYXRjdYQPi7wDnnO4T1A3kaD+jSlWdv11lXFx1zvbLy2MlqtqnfVj/mWxsVeu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:52:01.3062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e9f518-0033-44a8-d4b4-08de64161994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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

Firmware and monitoring tools may not be ready to receive a CPER when we
read the bad pages, so send the CPERs at the end of RAs initialization
to ensure that the FW is ready to receive and process the CPER. This
removes the previous CPER submission that was added during bad page
load, and sends both in-band and out-of-band at the same time.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 27 ++++++++++++++++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b28fcf932f7e..856b1bf83533 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4650,6 +4650,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 			amdgpu_ras_block_late_init_default(adev, &obj->ras_comm);
 	}
 
+	amdgpu_ras_check_bad_page_status(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 469d04a39d7d..91de4085a66d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1712,10 +1712,6 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 			dev_warn(adev->dev, "RAS records:%u exceeds 90%% of threshold:%d",
 					control->ras_num_bad_pages,
 					ras->bad_page_cnt_threshold);
-		if (amdgpu_bad_page_threshold != 0 &&
-			control->ras_num_bad_pages >= ras->bad_page_cnt_threshold)
-			amdgpu_dpm_send_rma_reason(adev);
-
 	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
 		   amdgpu_bad_page_threshold != 0) {
 		if (hdr->version >= RAS_TABLE_VER_V2_1) {
@@ -1932,3 +1928,26 @@ int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
 									   result);
 	return -EOPNOTSUPP;
 }
+
+void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_eeprom_control *control = ras ? &ras->eeprom_control : NULL;
+
+	if (!control || amdgpu_bad_page_threshold == 0)
+		return;
+
+	if (control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
+		if (amdgpu_dpm_send_rma_reason(adev))
+			dev_warn(adev->dev, "Unable to send in-band RMA CPER");
+		else
+			dev_dbg(adev->dev, "Sent in-band RMA CPER");
+
+		if (adev->cper.enabled && !amdgpu_uniras_enabled(adev)) {
+			if (amdgpu_cper_generate_bp_threshold_record(adev))
+				dev_warn(adev->dev, "Unable to send out-of-band RMA CPER");
+			else
+				dev_dbg(adev->dev, "Sent out-of-band RMA CPER");
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 2e5d63957e71..a62114800a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -193,6 +193,8 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 
 int amdgpu_ras_eeprom_update_record_num(struct amdgpu_ras_eeprom_control *control);
 
+void amdgpu_ras_check_bad_page_status(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.43.0

