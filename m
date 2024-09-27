Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC16CDD1CE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 17:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233C010ECFB;
	Fri, 27 Sep 2024 17:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPWqdQS8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7425810ECF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 17:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2yMO3wFmFCz2UdbAVccoJAEMuukEZt69F4xDcdR4wpOBtRwDsnuU0mwtGFu7rtHNnTXhMetI2tkyFjP1JV3xtvG7SdUREulSNNhEeBdI7XRIzlDZzGp12rktroL6XRAyUi0jvEUACgQxcOcNXT4XhqInAltP+DmRC6SVki3uOlhWXuN/F1pSxArXsZLsTWUeoRdO4zIEwlaaIXbZ/U1aA5Nysl65ykjWYSsmKWqx+/lWX24gSBJY+545xnvhJZqd8mp4eL9BIdMrkNyqHW6kp4H8N4UljijMYBQSWwBGw7ceoIst3Qj4KH3W4DGos+MSc5dFh2NCUF6nKKGYiXKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PWXlAHQ1f+6TgQDV39VkWzAutoaQP/y2AUF5Ob2pVs=;
 b=d4qcFafYGpKXUrxnoicPgTEvrHOKMPl0EkJLkTLrrASbcdtzl0QZxLWAQfDe/ohAx0BH88DT7M7Hdqj9larAL6Qxb6QrP5pfqNNxIM0haQTAvV7LcxI22U558uZ9re+pmp57c1cNvsNbA159OqYPLJ+BE+UEEsSH0Pb/TyDcHV4F1TxUwqfhEm3y/HE6qCj/zTzsNlXO9Ycet9JzLHrw/q1m7z2zUc3ryK9qRkJ48i7nl1miaulNhkU82EMGHq7/s8eS/0XF9D1jVJ4nGROXhXs5Y3zC26avTAyAz/JzbhVeTFueV0EU8I+KCBJg+b6JNvIW7ILCIdN5YtPkiJGYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PWXlAHQ1f+6TgQDV39VkWzAutoaQP/y2AUF5Ob2pVs=;
 b=VPWqdQS8K3pWmuwisptJ+RD+faFMlmK/hSzRrl5RVFyKIN6QNnZByRwfqLMHiDa4Z5evq4NkKsKD1g/mPKU/nAe3XmgHLQI/BtOnb18ZdKOjOgfCTcDAIN3ltETzO9LhLGsLrRUvFboR4Tkok8LBlG8AgCxEcv5ZiNULnPInLAA=
Received: from PH0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::34)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 17:01:55 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::f9) by PH0P220CA0020.outlook.office365.com
 (2603:10b6:510:d3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 17:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 17:01:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 12:01:46 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 12:01:45 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Eliminate recursive header inclusion
Date: Fri, 27 Sep 2024 13:00:58 -0400
Message-ID: <20240927170103.102180-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927170103.102180-1-Jerry.Zuo@amd.com>
References: <20240927170103.102180-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc970d7-90eb-4d7f-8bcc-08dcdf161774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QSlHGQWX/zKbxhRLwP1EqLN4gQlzXFk7udiq5m0o0aVaiQe0u7/Up88JLjLu?=
 =?us-ascii?Q?7vn/0xCozY3frz0FtDeAuasGoY4UQ7BmWLr72dFg1i0pqthc7bsT3ODrDxKy?=
 =?us-ascii?Q?jpYCSq2pPDQrbuGMYrDK/4ViGca1dLnt8uSZxXS1jFI6jHf4UuYuJztKkDii?=
 =?us-ascii?Q?8C5Yu68lpMvJw0NKi3hljVD37MnCqHJEyT8i+zEY74cxZ2zP4YNfZEY0AANg?=
 =?us-ascii?Q?30XxerYDBXkzKXausKPhswQMZT2GegPwWiFpgp5NhT8xOdaYu6gEcPRsdNRG?=
 =?us-ascii?Q?QpR5xHxyscJLsczcLHeY8Hl80xedeiXyvPdsqh1W1Vg6TyqSWO3xFIrAmBdu?=
 =?us-ascii?Q?eCooP+QZZu4lH0NCatR+POaKH8ehDEWNLFkeT2hzguuJ99i4xOyPSEw9SayE?=
 =?us-ascii?Q?6VdKNlSYL7vmP88BrePZDM3fRyFyqomWyeWcl2V/l7UaKVxk7foXXsKjlFNx?=
 =?us-ascii?Q?9YssO/5Ly70c6oyvm8s3a2+3P+LG6EghcsOQ2BYyGZuBMS/z0hu1gddG8qIf?=
 =?us-ascii?Q?pQAP5xgGcDqGNPHG8VYp4rBoVWTbI48Wkwr7yW5wUDEkmF0iNRaOoqomPWv7?=
 =?us-ascii?Q?MrtYhUeZkBZLd1jeo7vzpVSHmtUKav9jT6CVEH9+hW4OwNQbUCf/Wt48GmC3?=
 =?us-ascii?Q?EPWbh9rQSr+VXaGC2Si/NqRzotVoz6b2Flw0n0cWHvBdev0tHVn8DCoBnvtK?=
 =?us-ascii?Q?nIRkGSZrLSgC+m7qVxUotM9vDgpEMDxsIuOQRCs9N7yNP5RxyRKtYNv01riR?=
 =?us-ascii?Q?obTW5Fp519j787NnamPkHFX3Sq9SnkPAn/LjTeMGzFh41JoUn/h5w4gbnX7q?=
 =?us-ascii?Q?T4svpdjyqczZD8QF5zhcuYuE84XUlnjWtC1x8xBKxXz2dKE5evEPIfxPMkgn?=
 =?us-ascii?Q?lGp7ep3jii3Lr59cSBsiMY6fy7bnzmpeox/gwfwkMEsnMrj+1MHBUfgb+bC1?=
 =?us-ascii?Q?B4rC11iuYsQ3OQvFxQi4Cduh+eHfB20bo5FP97K2lgA0yVzPbcSyWVDNK3+D?=
 =?us-ascii?Q?16CEeW5kAGDK8eSRrY8UZEhWg40csL3XKZN/hKPP5UWKlKWPqLztKzuRspad?=
 =?us-ascii?Q?sZOUH/qYOvj2WumkQhihOt8ifxv4K1Am+p7sqJHQuUOK37T4c9x8NqwB7n0A?=
 =?us-ascii?Q?/Od/r96EtJArevHF4DfVIsoPLjm9oHnAT70aj8lf5NdyldMRDcM/RGTaQhrd?=
 =?us-ascii?Q?84rB7yoF5bmZmTKT5MYlCSP2yFyakeIQ7ElN8tRXBFRXBiZEML+JpuenN7Vf?=
 =?us-ascii?Q?kIQzwTP3iTXj9GnQazp/nys9eh30yxWP1ylly7jHJwyh++3YfGBsVLvTv9cX?=
 =?us-ascii?Q?SyYmLvpUo2S42U6twlrSIPe7ALf4C1UlFXXeyXTjHqd9Q4uV8bKm9PSDLsnD?=
 =?us-ascii?Q?R8YpsYMp+YY5V21DO0ZfRk1SgjJB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:01:55.3837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc970d7-90eb-4d7f-8bcc-08dcdf161774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
This removes recursive inclusion like dc.h -> dc_state.h -> dc.h and
dc.h -> dc_plane.h -> dc.h

This fixes 4 PW.INCLUDE_RECURSION issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_plane.h | 1 -
 drivers/gpu/drm/amd/display/dc/dc_state.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index 44afcd989224..bd37ec82b42d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -26,7 +26,6 @@
 #ifndef _DC_PLANE_H_
 #define _DC_PLANE_H_
 
-#include "dc.h"
 #include "dc_hw_types.h"
 
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_state.h b/drivers/gpu/drm/amd/display/dc/dc_state.h
index caa45db50232..db1e63a7d460 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_state.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_state.h
@@ -26,7 +26,6 @@
 #ifndef _DC_STATE_H_
 #define _DC_STATE_H_
 
-#include "dc.h"
 #include "inc/core_status.h"
 
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_params *params);
-- 
2.34.1

