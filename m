Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE2D24470
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 17:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6451C10EBB5;
	Fri, 11 Oct 2024 17:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/JXZScI";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4897D10EBB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 17:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJLESDmdwREAUeaRf5YFf4V5GHCJHrBQUaYziQdKz2UFylJVQ01CNurAclhpdMF2lfYY38OKONoWvFR82BgeKHPaRRMb8CfS4OrN6wH2lVUjEONdopxKJ2bhS35BNJiqLwL6dUBA2eHlPGRMyeVb0p+9jlytC7sGUtIkQAk957pDjh57Bqfm0lptBd9o2+39GfPCfJjOvpFHllkrSzkKFE75Tcz+A9K7QIv/1pSjGMRGMf394kOyG9crRrJJzREgzNzm/R5FZrj68KDM58LuAjLdqEITjuKW5En3m2Vb/ojnsTGKzkDOi/3k9w2uZjPBOrTB8m5/fynKH3iGT9xpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxje4wUcAWCnGo7U6tyn6ULM/Opk2qAxVpWtJ7mKjbY=;
 b=lYSj4Z0W8F5d0CVH4V3axe8zuWZAzl1tT86cvQOtPTjbCKxK0RkzDXv2qRi+AjgmiW0inVCwPdZqfDTKyVchCEVXUVWsfTsRjNx7PiAcUMMZCUnj4fyEq4QLRPTEo/3NexkNwHkjw0ZuXECPjpnqJI2cY06OGrvyr8MVBruPeWyhyWF8pBOpBWw9KY8Huxb8mAgQU1akHQ28cj76eg81+2dNEjFtdP6Ko6PpNOHyk1GjJoOYym67OdXS/TKKhjS9h9zYLf23g51pDIxTrBPwgz/jCWXZsMHOAZUffM72sWm5/HDSyJr4ORECJDG+V9HBXDNWTIUq/L74hg8ZIhngmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxje4wUcAWCnGo7U6tyn6ULM/Opk2qAxVpWtJ7mKjbY=;
 b=W/JXZScI33G0pfEvVzvpolJR5hezhivVOITkbCtjFax2vEz6AUL5OMfSWibUr2k3KLa43YkNqbpY74lrP8B3xJeiqy1duVquvQ4ct/LCFYzEN6bptNWPey0R/dk/M9zqviF7ZPe9quiHCP1ZMDwR8VQzB3e6SYTAPVj9QA5XRpA=
Received: from SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 17:23:27 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::8a) by SJ0PR13CA0046.outlook.office365.com
 (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Fri, 11 Oct 2024 17:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 17:23:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 12:23:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Guard against bad data for ATIF ACPI method
Date: Fri, 11 Oct 2024 12:23:15 -0500
Message-ID: <20241011172315.35231-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf5ee6f-cf1c-45a8-014d-08dcea196b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xE5NmhMRyOueA0qMbQUC8NtVg/5Ry4o40OIyZEOuysu/DAknPjf+FQqQMAz6?=
 =?us-ascii?Q?ydoRDOCK7OaEPCnKpeXM5Mr6cv2CvJs5m4n+qdVYH/9m/Wbl/uqO7gAqlAy6?=
 =?us-ascii?Q?TgNlauEumeieBhsT207FPtUnFv7kZk6yMTAcNq6azq3HgqoY4dluK7cYTehz?=
 =?us-ascii?Q?A0sn8oTRgy3Xpwq0HzRC90/Y6xeDPZw1jlsKi3IAJF4isf9DWxIvrOfWPbS+?=
 =?us-ascii?Q?R5wW0f/SBb5DIqL3mkTiml4ewqJoCOXmjrN2TeR5CgMJYixcGqA2FWyxiFdm?=
 =?us-ascii?Q?0yvmkb1m6vreSkIuh2kmND86AOsg5X3LWaNk028t4RtqR6VjOe3QeKWXFJXL?=
 =?us-ascii?Q?h4o3cpRfI52jGvILIWdkBQPgWVPt3vXIaHTwVVzDFMZkG9DmM8aSHEC+zSzC?=
 =?us-ascii?Q?Zkyzz3VeF+hXlJleCUBJAW2rq3vRR4+cSyRtdRWNeAC7O1hffaSB0ekm/rZ8?=
 =?us-ascii?Q?XEYgkl0dCbDX68PVzS8viAQp0DN+tmOVBqVk6190zx+Zcs6ATJ3UXTQWzKOo?=
 =?us-ascii?Q?7pPnpn4HMk8pXz6yWcROhuVKuQmvwKdkXMGwB91y7rzewVXGhxMAXRaK6tbv?=
 =?us-ascii?Q?qHPfe0pWV7+owlQ0js2ypm//2GbacOHdPIgE54aZvCmjoWtS6L3p9r/Cwyzf?=
 =?us-ascii?Q?PKVSGZ/9co72MPnOhiY2/bKtcXtPI9j4m6+sbGu7IZWFPX8QFUMILbxv4FjB?=
 =?us-ascii?Q?igPo0NUcbL3ZKsnWljnL7mIBAGqVVnbkEj6No4X/pkxj2z6QuH5vtw512134?=
 =?us-ascii?Q?R8/os+cB4iHNkJ4YC1H8ula6/w8qZ9axsVIy6y33GT3GKea2Hvunery7FMry?=
 =?us-ascii?Q?RrXBSDeFhHTTJjG3VC3rqufPFdopY7O4vOs9fv/Avmu/J1B33BtC+LLZySly?=
 =?us-ascii?Q?AK45wUNuon/WSo8UyQQwsaHJOTYPQXF33HqO60I8PA5dJgJSAWObf7Vv3Uay?=
 =?us-ascii?Q?txi+64F3zp/R7pb8dEFF0oRzLKwUh6nZQOAjgk0+BFlpHLm4vLl7q5ujhLS2?=
 =?us-ascii?Q?sQYDYTYAP7cAFvofsIrI8WloaWL1CZ7idLqAIDPHoILLWvCbOxu2bysmuevd?=
 =?us-ascii?Q?9oP0qayrvFQWC/jiSBWT4MHKNU3WAId7erDcRniUcW+zlitStdxoJiqWcspx?=
 =?us-ascii?Q?GGasBAXmRRC4g50lIdQFVlofAqIK2RpBGHDGQ1rw1Y/5lCbGMgzYv0A2otN1?=
 =?us-ascii?Q?2BywfVGgfP7Tea53AbpZ/sKqe403OM/bZbDJP07FKfhvvFRIeWJ5qc+O4OUm?=
 =?us-ascii?Q?hwytwZDf7CzSjQ4gBY373MeyRCQ9D3Yw8mqylYADsOGbqSw3aptuo0E9UCsv?=
 =?us-ascii?Q?/3uM7ebQZRZyhdZlkWL02T0mjJwBtXBLE1VQiMFMJrYyQb+Qrm08xd+f+EWx?=
 =?us-ascii?Q?m1fwHwP38RLFiKrKnYWD6EzWALsY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:23:27.0244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf5ee6f-cf1c-45a8-014d-08dcea196b19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
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

If a BIOS provides bad data in response to an ATIF method call
this causes a NULL pointer dereference in the caller.

```
? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1))
? __die (arch/x86/kernel/dumpstack.c:423 arch/x86/kernel/dumpstack.c:434)
? page_fault_oops (arch/x86/mm/fault.c:544 (discriminator 2) arch/x86/mm/fault.c:705 (discriminator 2))
? do_user_addr_fault (arch/x86/mm/fault.c:440 (discriminator 1) arch/x86/mm/fault.c:1232 (discriminator 1))
? acpi_ut_update_object_reference (drivers/acpi/acpica/utdelete.c:642)
? exc_page_fault (arch/x86/mm/fault.c:1542)
? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
? amdgpu_atif_query_backlight_caps.constprop.0 (drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:387 (discriminator 2)) amdgpu
? amdgpu_atif_query_backlight_caps.constprop.0 (drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:386 (discriminator 1)) amdgpu
```

It has been encountered on at least one system, so guard for it.

Cc: stable@vger.kernel.org
Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index f85ace0384d2..1f5a296f5ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -147,6 +147,7 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
+	union acpi_object *obj;
 	union acpi_object atif_arg_elements[2];
 	struct acpi_object_list atif_arg;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -169,16 +170,24 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 
 	status = acpi_evaluate_object(atif->handle, NULL, &atif_arg,
 				      &buffer);
+	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail only if calling the method fails and ATIF is supported */
+	/* Fail if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
-		kfree(buffer.pointer);
+		kfree(obj);
 		return NULL;
 	}
 
-	return buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		DRM_DEBUG_DRIVER("bad object returned from ATIF: %d\n",
+				 obj->type);
+		kfree(obj);
+		return NULL;
+	}
+
+	return obj;
 }
 
 /**
-- 
2.43.0

