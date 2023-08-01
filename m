Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24C9EB64DD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 05:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A8510E30A;
	Tue,  1 Aug 2023 05:02:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A648110E30A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 05:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwZbTvxmz9FpoFjsRTHkeF7M0c3uOviA8kKc1elgQ2cdJ5gCxtcKr5/uqZqj5Vo1R1QWCC1zgDeDZLq/h/Q5LQS3UHohQyS9CGcLcQz4iO6y9Gc+2Ff0Fawk5fwzArJ1u15f6e4/VMKnL6c144Hn+AqBamq+zPVyRrwbgBC2nO8k/NcjvA829+/LfVxgFIWxNFEvxuquJannhJKBRywk+aQ3ZCOT0dVb1jJSZzN+6tv98ejk8Dqq7+MXjk7Fm6khzngQw5I75o70Y6jYNPuYsnHmQdCh/GeQUneOBMLfBffcnUVIEF9llrsLt5D3KIYCrFMXco7tztlmvOHsHHiJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNK8kE1IcMRX+0KSiij3vqTiS3pHOO5g6NMmEoCgfPg=;
 b=ijiAjg6pbdg9/FXXwxewAh402Ly2geIegeBgRHDMfQIjNRwzZN55CFHwjTOHpzO6wlisA9l1v/hneptNedWk00ciquFClOrKGGAz1rrPmDwE/I8locSeu8GmOYRXa2Q4hh1wx9y/5Xg5N5L6jDgiIm7AVx8h3zHF1LFqki6wVhxtpbuiBDH/a4NFqBjhcYt6eB4Y7Vc36vMOH3x9d4qwoNL/+3Vg5I/8kiRVp1G3S6UJs1siUlJkOUwwt8Yj1VVlAX+ny6F+cvLikZ3Oopc6Hs1t4zYeYe4TTyMnLD+V31bdSIaxtvNkfh3UkoR+jsuQp/Zp9a9zkSH4qOL4lJlwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNK8kE1IcMRX+0KSiij3vqTiS3pHOO5g6NMmEoCgfPg=;
 b=Sien1avzFGlye9AvmdisMJi+u/5gM2NbtB83TFx1bEERw3go8vng2Q72fdbpDDt3XxMh5ofZ8Rch+daKTUni4Kobbcv4YexH962wVzz5EaAOSSKGdYTQxKePuk6yn4kCl6VTV5Wk85aHIDm5rHM/cmnLc96gr9bvMJWVeCOtvj0=
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 05:02:07 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::91) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 05:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 05:02:06 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 00:02:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Prefer pr_err/_warn/_notice over printk in
 amdgpu_atpx_handler.c
Date: Tue, 1 Aug 2023 10:31:46 +0530
Message-ID: <20230801050146.2970696-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
References: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 29657df4-e7ee-47fb-49e1-08db924c7448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKg/rZL2WshSNzs8BoDz2Y7xH/2kpBeJT3OIcZm1Q4RV39pGYDWkyjvc7rI6iT2NZKeBrfMtgV9kKFNXBU2S56JjXtVCpoXsFNTmVdDjIYyn89s56tk9vTXrpKcmSu/5ZZnk4bdL7jt4hblVFCjRJWI5WcKzlArl6q6ay+xu/bGRX/9LOFgCFfRtNL1o8/CYyCe6dO/BPOYNzJYJ0hJYEDI8VpiDlONxaxkpFs6ZXmyCpeBVQMTWfXYQhlkjdsxZPTdxsaXp/IotqkzQ0M0d74qmZ9a3a9Erc4v4tPddDF8KwKNBrTkFUjyAchCcvY94eE/p9wy9IYE/5oPs3seKKpYSzgdCWzxpDGqJSkv2lcyRNBZa8w10VmFTjcMxrbo+hvankVlZBbw6EWHWFf5xL3mvu0l4iJWMsUe/G1YzYmEwK5oR4yTspXCUYNQyHqJIkvDUBbOQMlt0ZcDkYjfcGAX+9EkOaXhL1ezjRYyen6vG++VPbXgsNfvEOxIYA1e7R6B6713KirRm5vLipynJj7oQuCOsp4k2NfrpBX2D/dViMR+FyCL4cUzkCidEH8ofR5xXeVe6QEuS/1HYpJwdrZCflzJTIgnE6bgUzQ0mgaIzE5e806F5JN+8GNapSq5vj3UsYcFYmQ56d+YFOXwLfCJgRJfIEp83MqyjEKPisQiBxZwE/3ILACOKYTwBEWnKbyuzL3y/l9wpJGheNgbM25Dmh00OTLGgV+7Ph2D94ggw7b9sgqHgj1CMce95YSzu20YZo+tajTx5Wh+w2t0arA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(44832011)(47076005)(36860700001)(7696005)(36756003)(16526019)(40460700003)(40480700001)(2616005)(26005)(1076003)(83380400001)(336012)(186003)(426003)(66574015)(70206006)(70586007)(81166007)(54906003)(110136005)(356005)(82740400003)(41300700001)(86362001)(316002)(5660300002)(6636002)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 05:02:06.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29657df4-e7ee-47fb-49e1-08db924c7448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following style issues:

ERROR: open brace '{' following function definitions go on the next line
WARNING: printk() should include KERN_<LEVEL> facility level

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Updated commit title as per log levels updated in this patch
 - Updated with appropriate log levels (Luben)

 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index d6d986be906a..375f02002579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -74,24 +74,29 @@ struct atpx_mux {
 	u16 mux;
 } __packed;
 
-bool amdgpu_has_atpx(void) {
+bool amdgpu_has_atpx(void)
+{
 	return amdgpu_atpx_priv.atpx_detected;
 }
 
-bool amdgpu_has_atpx_dgpu_power_cntl(void) {
+bool amdgpu_has_atpx_dgpu_power_cntl(void)
+{
 	return amdgpu_atpx_priv.atpx.functions.power_cntl;
 }
 
-bool amdgpu_is_atpx_hybrid(void) {
+bool amdgpu_is_atpx_hybrid(void)
+{
 	return amdgpu_atpx_priv.atpx.is_hybrid;
 }
 
-bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
+bool amdgpu_atpx_dgpu_req_power_for_displays(void)
+{
 	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
 }
 
 #if defined(CONFIG_ACPI)
-void *amdgpu_atpx_get_dhandle(void) {
+void *amdgpu_atpx_get_dhandle(void)
+{
 	return amdgpu_atpx_priv.dhandle;
 }
 #endif
@@ -134,7 +139,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
 
 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		printk("failed to evaluate ATPX got %s\n",
+		pr_err("failed to evaluate ATPX got %s\n",
 		       acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
@@ -190,7 +195,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			printk("ATPX buffer is too small: %zu\n", size);
+			pr_err("ATPX buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -223,11 +228,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 	atpx->is_hybrid = false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
 		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
-			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
+			pr_warn("ATPX Hybrid Graphics, forcing to ATPX\n");
 			atpx->functions.power_cntl = true;
 			atpx->is_hybrid = false;
 		} else {
-			printk("ATPX Hybrid Graphics\n");
+			pr_notice("ATPX Hybrid Graphics\n");
 			/*
 			 * Disable legacy PM methods only when pcie port PM is usable,
 			 * otherwise the device might fail to power off or power on.
@@ -269,7 +274,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 
 	size = *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		printk("ATPX buffer is too small: %zu\n", size);
+		pr_err("ATPX buffer is too small: %zu\n", size);
 		err = -EINVAL;
 		goto out;
 	}
@@ -278,8 +283,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
 	memcpy(&output, info->buffer.pointer, size);
 
 	/* TODO: check version? */
-	printk("ATPX version %u, functions 0x%08x\n",
-	       output.version, output.function_bits);
+	pr_notice("ATPX version %u, functions 0x%08x\n",
+		  output.version, output.function_bits);
 
 	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
 
-- 
2.25.1

