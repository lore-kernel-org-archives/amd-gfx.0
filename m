Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6755FC2A062
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Jan 2026 15:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C630810E26D;
	Sun,  4 Jan 2026 15:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="436OL9JQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03FFB10E26D
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Jan 2026 15:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tob7ZBC7jk1M7rU3+Wsw4cdHPNgwrkgrcV8rfibUeUxc3dLXsb4lryIqrRB/U/XXgLSCxT76qJBto0abNGJI2dLEp+x1L33xIeRtMwR4XTledOVTCDBAsjnu1XhMTRr+ixA8Zt15IU3jqpTc8t/+ZsQMn3hnArYV4PyCnWShzE2ySQIAEsJMUL4RkuvU2MloWY9RDMjIy0Hd6cyBabbJP0VhG5n5sZQEfl+Qcn1v9s+8estxfpCeLQxd50XouKcs/48hgdexBc7q0jEdDyMeLe7xQbPbyMkoPNcGkUhDCJ4PwSg/B/0qi5BTHVnYe69WsUybF84v/DjPqpXummFWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM3Irl7O9q7tVDX/SJyTMQ0E/TlRGdCPtl8LEaud9Cc=;
 b=CS73Rq7vYjokNd8a6rxGdM2/sO+7rcw0jw0sgIaqMXmc13kNNAy/AXERkDx5dvrGJlGM6ywq4tf8RN5/RNZrZVC+2u6qvpqZYGox0udHXE88EaFdqOcHhHz940Jbq5W+hTK01d+S/MdXV+6n7C8frp72OruXkTgSyANO2XuNgoPY/xnWegWPGInJY86WZzWbaRIWZZW0westcKehoAMnkh/I47vBsFapW4e/tXXL7e/l7pBZkgfeDwDhuhCihd28AqftRgM44DQBe0su0mEVyS3542HrOzqlaNQm2TprTDQ+oayD6JcrU49/iR7uLV9KONu3CEbJbWidOkgAoUdPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM3Irl7O9q7tVDX/SJyTMQ0E/TlRGdCPtl8LEaud9Cc=;
 b=436OL9JQ6/UDH4QiIdy8l9oWJZW/hH37wH1bZqJgL6iJHOpYNUAhJjpZhl5IexWn4V1vZLSk2t/4bVzCoLVAlIs5EdM5E0ZGxlsf6tA0gMzBaJ0qtJx0fbK7EyPVZFhUcsNiOF+HXBRtgwK3mqyA+cb2UKLQ7FIyVogvFvYmAcY=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Sun, 4 Jan 2026 15:04:46 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:60:cafe::74) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sun, 4
 Jan 2026 15:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Sun, 4 Jan 2026 15:04:45 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 4 Jan 2026 09:04:43 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Le Ma <Le.Ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Extend psp_skip_tmr for bare-metal and sriov
Date: Sun, 4 Jan 2026 23:04:28 +0800
Message-ID: <20260104150428.26348-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca9621a-e7c5-4f79-e62d-08de4ba298d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1FleU0zWHFVbWpiTS9ETmVlSGIyVHRqRjVMZ0RBVkNQYzVLZ0hxT25GT3dZ?=
 =?utf-8?B?WCs4N3FQN1pvejVVZy9hK1Vma3JqN1NmMFI0WUJzS2hVUlZQR2RwQzZreTQ4?=
 =?utf-8?B?QkVBZWJGOTZYQytlUkx0ZTFlOUxkRis2L0RRdXBLWWJIa1p3OTMxL3RHYXVB?=
 =?utf-8?B?K0ptbXdVU2p1UGUyckFqUHhjQUhNaC9QSHZreXppamx1Wk1FNDhTWWFCMmxi?=
 =?utf-8?B?TzlSbGN2VXUrZithZFRQS3RnVEh4NjhyRERGZDNIU3hrT3FGNkN3N2cyL3pu?=
 =?utf-8?B?ZkVjT3dsYVlBTU53R2VsMldkMTdRanNtSUM4VDZReVRLemdFcWZpNndHZFFp?=
 =?utf-8?B?N3F2WnNobHAzNzZnYmZLZzhmb0tPOTk2VUpqMENZVUx2MVFncHpncU56cGxT?=
 =?utf-8?B?OHB3Z29UVm5mVEdUSGxtTi9hb04yb21RbEVqUll5bk5hdllqaUhLdUhRRWlz?=
 =?utf-8?B?UDRqVkc4blFBcE1YU2FjMVpmS3FaR2l6NUZRa3JlaU85S1d4TU5vVkFhcmpp?=
 =?utf-8?B?TnlhVFliZHlreEtLUDlMRTZLZERUd1JlOVpNSjhnNENLVVFONmF2eFA4OS93?=
 =?utf-8?B?ZndQbU0yWFlyNEtZNm1GQnNoUE5OOFdWR0h6cE4zOUxNeE43OTE4bVBWNkpm?=
 =?utf-8?B?RW5vYkhEZjE3ZzlCaCtLQitKNmh3NnYyWE9OUzJWT2ZHWUEvcnJvMWR2c3Q2?=
 =?utf-8?B?cW8zVWJxQ1ptSmxBWlRlMURObWFmQXd3V1hCbFUvZ1ZTNXR5T1JLOUFxK2lP?=
 =?utf-8?B?NVhiekhBbDIzTHZodlZWRWRmdkFjalZTaGZ5Q09SQTBSdG1nbkhqd3dndy83?=
 =?utf-8?B?eDVseE1wR05rcExaZ1BSLzhlVUI0STJmaW40MDh4RE94OXFaV2pQUVFKYjY0?=
 =?utf-8?B?OWVxWFdUU1ZaQnJyUUxUMmFLQzVZNzNLUjJYODFDRmFJdzczKzNuMC9scDhN?=
 =?utf-8?B?UXRyZmI5UDdKdVN5OW9HaXZ2RmF2ZDRtZFRPeHJsbHVaVXFsTmx6UlZ3bDFW?=
 =?utf-8?B?NHhpMTc0cWtEb0hEVUNnTi9KWUlTUnF3cSttRDdNZW9xQ3M2NDFWWWszKzhw?=
 =?utf-8?B?SFJTczhhNmZZVzNjRnEzeWtNZHdLNDN0by9OYWxjeWVYbjBBQkRFNnZHRmp1?=
 =?utf-8?B?Zk5DUDFqaitubzcyVjNzeHJHZ2ZBZnJOdTFrUGlPWCthbjN0amFGcnpjdGFt?=
 =?utf-8?B?N2QzOFJsZU9RWXdHTWN5Q0NmK2ZGVlROQmJFZVUyNEQ5QXdnZEY0YjNpd0Jq?=
 =?utf-8?B?MFFnVElBOGdwSFhpVU1BOWo3VWYybUxiTFltdWxudXBmZ1c3N1ZHelJsRnpi?=
 =?utf-8?B?RnlRbm81TkVCVytBTHJTL3R5VHJhbkE3ZngzV2tEVHBKZWI4MG90VUtITDBx?=
 =?utf-8?B?bUI4UXBlMHNDMmN3MTNRZUNMcGc4VHRkeHlRZGdENTFFalp3OXFmS0xOSG9Q?=
 =?utf-8?B?VkZDa3VyVUdIRXlGcDBqSm84VkNKdHk4RmE3UjJlRmZXQXlrTXg4U1VYaTd5?=
 =?utf-8?B?bXYzQmNPTjEzQTRIRkd2bVJzU3ZZd3hFQnFQc1lSVFlMUHRvYnNhYlBSQTBk?=
 =?utf-8?B?STFZMi9LU2tadXBQajZNUHVxaVEwV2xKVGhzZUJmZGJrQ0FQSFlSbFl1ZEdF?=
 =?utf-8?B?V0F0SU5MUTZDU0xOeVFUUEZabkkzbTNMWHJEOVIwbGFmeUpWbFF2TFl0eTAw?=
 =?utf-8?B?VisybngrbGNJSVJIU001cjhVSUlkWk96dEV3MEtSUzRaMWFDT0FpTGFHb0Z0?=
 =?utf-8?B?QVlzWlN6Y2FIWVZSVVVGZVY0TkZSR2ZuLzkwL3FVOXBjNU9lb2FXdzJMbmdi?=
 =?utf-8?B?dEg1bk9lL290RG5wYUliRWk1MjEwOGU5b2p1Rm1WRmRCVmlCU1ZTY3RJdk12?=
 =?utf-8?B?a2x0ZlJhaWI3Q2FnazZIejlHVUJmelFxTXBqTGYwSndJM3JNKzR1SVNCZ3E2?=
 =?utf-8?B?UWp6bXU5RUdCRU5QV1N3dGZlcldZYTdVYm9rc0k1Y0gvNGpWZnUxSUFyMjU1?=
 =?utf-8?B?bFppYWo4SWVXYXRHK1ZvT2hDK1F1bWZrT3JSY213V08wRUNVWk1wem5kMTNa?=
 =?utf-8?B?MEU4aUloUVZsc2NmOHNvd3Eydk9peHlLNkc3QWlUeU9hamNsSmJQbFE1Vm5j?=
 =?utf-8?Q?v4BM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 15:04:45.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca9621a-e7c5-4f79-e62d-08de4ba298d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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

In SRIOV, guest drivers no longer setup/destory
VMR starting from mp0 v11_0_7.

In bare-metal, if boot-time TMR is enabled, some
generation (e.g., mp0 v13_0_x) don’t need runtime
TMR allocation but still require SETUP_TMR command
with tmr address 0 for backward compatibility.
some newer generations require neither SETUP_TMR nor
DESTROY_TMR and will return errors if they are sent.
Driver relies on boot_time_tmr and autoload_supported
to handle these cases correctly.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 ++++++++-----------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 08fb72adc9e9..a1bed8b874cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -902,20 +902,12 @@ static int psp_tmr_init(struct psp_context *psp)
 
 static bool psp_skip_tmr(struct psp_context *psp)
 {
-	switch (amdgpu_ip_version(psp->adev, MP0_HWIP, 0)) {
-	case IP_VERSION(11, 0, 9):
-	case IP_VERSION(11, 0, 7):
-	case IP_VERSION(13, 0, 2):
-	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 10):
-	case IP_VERSION(13, 0, 12):
-	case IP_VERSION(13, 0, 14):
-	case IP_VERSION(15, 0, 0):
-	case IP_VERSION(15, 0, 8):
-		return true;
-	default:
-		return false;
-	}
+	u32 ip_version = amdgpu_ip_version(psp->adev, MP0_HWIP, 0);
+
+	if (amdgpu_sriov_vf(psp->adev))
+		return (ip_version >= IP_VERSION(11, 0, 7)) ? true : false;
+	else
+		return (!psp->boot_time_tmr || !psp->autoload_supported) ? false : true;
 }
 
 static int psp_tmr_load(struct psp_context *psp)
@@ -923,10 +915,7 @@ static int psp_tmr_load(struct psp_context *psp)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
-	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
-	 * Already set up by host driver.
-	 */
-	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+	if (psp_skip_tmr(psp))
 		return 0;
 
 	cmd = acquire_psp_cmd_buf(psp);
@@ -958,10 +947,7 @@ static int psp_tmr_unload(struct psp_context *psp)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
-	/* skip TMR unload for Navi12 and CHIP_SIENNA_CICHLID SRIOV,
-	 * as TMR is not loaded at all
-	 */
-	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+	if (psp_skip_tmr(psp))
 		return 0;
 
 	cmd = acquire_psp_cmd_buf(psp);
@@ -2632,12 +2618,10 @@ static int psp_hw_start(struct psp_context *psp)
 			return ret;
 	}
 
-	if (!psp->boot_time_tmr || !psp->autoload_supported) {
-		ret = psp_tmr_load(psp);
-		if (ret) {
-			dev_err(adev->dev, "PSP load tmr failed!\n");
-			return ret;
-		}
+	ret = psp_tmr_load(psp);
+	if (ret) {
+		dev_err(adev->dev, "PSP load tmr failed!\n");
+		return ret;
 	}
 
 	return 0;
-- 
2.17.1

