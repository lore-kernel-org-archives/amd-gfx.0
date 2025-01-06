Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07170E7719A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6499810E39C;
	Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOtSomTD";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBA310E281
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCCHPmWbTjpkwT8/tjKobyxKQ55Kd1I9pVsa9/6Ch/6zjMgNqU1TFJkT0dR/Vbjy+K8FqSaHdSNIgEOzAom/BBdkGY8eMyi8bMHpinAEmfvCYwHSG2vgh8qhp5AXdQQgIBCzj1JYnGaHDkkeQW8dSlT77l0J0DtRw386MXgivv2Iy2drsHky8BTncHKZt3RoyyTLu54pPbq9A2Zinw6tcEkJIQ4/YThqMuS5gNvA05rMKqgubEPZeWm7f5lCiMoIE6dVwGQgejgv+S5g3DkdEX6zwGj6/v9YeDy2qnU+pz4j+1S89OKrqrBQEbLyMKlZBOYHeisJ4Px8KYRDj9MM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUh7BHlx3dhL0ZLN+7JLQ9fZB7QV31kfVP/leJh3Woc=;
 b=KXhnt/JPn+ZTC34vrb05YkY8Cc7vLBPEgSYeizH9oi/Qgw8izC3GiYOAChEwpfUEILmwtEaSQNauF0VfC9R/EaUHo9VOQsdzi37MfifqUYkX52xiiF79Px4rduBez9JhNo0e39GmK/rVGrDlMWDS3haqGrWi01DkupM1t/vasCmZw41Mqlg+6xYrz8iUo3vru0ACA5aM/sbIuxZuqVPy+lpKTat3n1WpW97buE+LSPzmNO1hlChjJk7vQxIsrWN16iWKCVIxrfUMz88tL/2Zg2FUylQKRxsDUuzG9tKbHr+xUZQB+w9qcbvhCa3BeOVIo0pRVbXrtVjyitMD+a5grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUh7BHlx3dhL0ZLN+7JLQ9fZB7QV31kfVP/leJh3Woc=;
 b=NOtSomTDOYGvMb+vMBpvZOHhdTAwqMacbDgYxMOAP6tzLCGFkwtyBZ3ZJZbYW0Ra1MXcjOu9fPNNPqgG4nxOJBFkUIEoO9qL0HKf76mfDAxeDwIldn43GaaNOkSxGnKxF4QuBO1wiogQQ9k8sMKmsTVr4PB9cP2F4bTcRpjzHao=
Received: from CH0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:33::18)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 20:33:27 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::b7) by CH0PR08CA0013.outlook.office365.com
 (2603:10b6:610:33::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 20:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/10] drm/amd/display/dm: drop extra parameters to
 create_i2c()
Date: Mon, 6 Jan 2025 15:33:01 -0500
Message-ID: <20250106203310.3349585-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: e248143a-64b1-4dbc-73df-08dd2e915fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?phulF1d9ul1aFMb58QJ1UotoBFWpVYf+ZHiDjvtADkCxKDrAi7kK1cc/Z2Mx?=
 =?us-ascii?Q?SpK5YHNueuABjke2SNlocYotdmG6u+t7bF/a6i6UjFLe0vgVBtZzAezkXwl2?=
 =?us-ascii?Q?uBDskFKEz+cOsoGqw1RjWSVKewTzfNLsPciiaT5ub3kJI9yoCKhfrW59ptHe?=
 =?us-ascii?Q?WvZw880X2mNp16DZ1q1XYi/fr/PU1KbgszEzYA+T+AJ9Pv3hiwkPtimFDINu?=
 =?us-ascii?Q?hretBVRUkZb8g5TC/HEN3NJFyAQcmKjHpG6f87bA3e1FXMhSzhjH2CwDEyPt?=
 =?us-ascii?Q?tsIO813l6Un5/AK2iU93PkwO5bdsDMXrx5E+wRBFcjCQGt3I4V3znipzX1Dm?=
 =?us-ascii?Q?jjMTGxDxTTUObRKbGRqAFhoD5YDzmZjp+upJOHw3pEYn62eiUtr4piCFS27x?=
 =?us-ascii?Q?2LPvMxUVUwlMatqUk36u7X8UkkXnSc1i38fiTv5l4KeIvteg00pTNmygXMDh?=
 =?us-ascii?Q?lLGtr+t3oxwygLAw2GsxtqZl+Q+dlcxuaxx+23ioEoP0JJFe1+oQc6f93UpS?=
 =?us-ascii?Q?jeDI7qp5saSXTHKQFAlziiESDjcu7uhyoXxba5Hc141QsgxhL2+dKsz/vau/?=
 =?us-ascii?Q?/qkQOmzZrBXzOk7A48B5nQTzButHxKpo8Id0YR5ObUKpusXXQus24HgiqYms?=
 =?us-ascii?Q?TBs44ms8K0cRm30cmfZkvXT7UU1umZkH0y38dpQGwuA1njGKH4Il61MLcyFf?=
 =?us-ascii?Q?UgweDm4/3A+wkxiXQF/aAPhN+e2AsYbyJFzK/W9Qfn4RpYGNAqQydzMQR/FS?=
 =?us-ascii?Q?uanvbwIBeatcKVqAggRkFo59lW/f2tuOXvKpyEF3J1atEoQwvkoVUnA/UtTg?=
 =?us-ascii?Q?NW96ScrkDv1CD2JRkabbfYu6dIz2ftAEaTds8kk1gMwsBSQkDckAKFEnjveE?=
 =?us-ascii?Q?LJPOZDEAExwz2hmZS+HNs2aeRjMmJ2xql6x41nAhjzrF7aGyCyc16bQtl4BL?=
 =?us-ascii?Q?9XDpxwR+FtZZd8r2ZzuVPApwZenAe5iafXflFGSEn3SGYiFtCpeuLqC3Ikok?=
 =?us-ascii?Q?OeTuiCzyPIG3Gl2QthJ7vZavqd6zrwvbUqT4KbKdy0K3iRcVd5sHF+NBvIjf?=
 =?us-ascii?Q?9bLZLDj+UksycJyII2addSSHk5Z3pk7vjwG+CTtDXAH8R927g/VmnEIFWAX+?=
 =?us-ascii?Q?hiGrKPws3PhGosKe3/25bbXk2NgqXjZoZauZSBLhB7hcKF0BinpretTRbmJ0?=
 =?us-ascii?Q?77ND9sXAByjCCHe2MywkEBqAJ6AICoARRhc5Wvgxif8QSNMfAvwKRp1UK5l4?=
 =?us-ascii?Q?ZC2SMtcrapKNgzLjsKcyzkN9Df5kgzX8gxdQSK93lNSHE6rO5gkABRAyjTXZ?=
 =?us-ascii?Q?7sQc2cKEaxjN1vwidfhfoT7vl5XESHEsJm/2qR20gV+8Ll/fwc+e8iLHG2xz?=
 =?us-ascii?Q?VIs9njHkui3QuyWBzLTiGx/GpAV5eC2bssYSKwl5rNaaD3Vgmr/exnB0rd8Y?=
 =?us-ascii?Q?13OVJAuU8Mz6WcnaXPC0bfDDCQlzby5qVd7+dPGGEeNcAXgqGCf6MJAHGKfK?=
 =?us-ascii?Q?txaK13GhP3HJNCk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:26.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e248143a-64b1-4dbc-73df-08dd2e915fc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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

link_index can be fetched from the ddc_service; no need for a separate
parameter.  res is not used.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e9a4750a83d6c..139f1a74f05d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8256,9 +8256,7 @@ static const struct i2c_algorithm amdgpu_dm_i2c_algo = {
 };
 
 static struct amdgpu_i2c_adapter *
-create_i2c(struct ddc_service *ddc_service,
-	   int link_index,
-	   int *res)
+create_i2c(struct ddc_service *ddc_service)
 {
 	struct amdgpu_device *adev = ddc_service->ctx->driver_context;
 	struct amdgpu_i2c_adapter *i2c;
@@ -8269,7 +8267,8 @@ create_i2c(struct ddc_service *ddc_service,
 	i2c->base.owner = THIS_MODULE;
 	i2c->base.dev.parent = &adev->pdev->dev;
 	i2c->base.algo = &amdgpu_dm_i2c_algo;
-	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);
+	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d",
+		 ddc_service->link->link_index);
 	i2c_set_adapdata(&i2c->base, i2c);
 	i2c->ddc_service = ddc_service;
 
@@ -8296,7 +8295,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	link->priv = aconnector;
 
 
-	i2c = create_i2c(link->ddc, link->link_index, &res);
+	i2c = create_i2c(link->ddc);
 	if (!i2c) {
 		DRM_ERROR("Failed to create i2c adapter data\n");
 		return -ENOMEM;
-- 
2.47.1

