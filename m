Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEADD12D60
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 904F610E414;
	Mon, 11 Nov 2024 02:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CWtVLJUZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C19810E414
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KI0P+cC8djOtFQ/WCFQE4N5JAXBYC0ZyP09DQWYcNxGcwic3yydySrGjqVE2aF3tnBDk+SKQ9xStrlfi8eVjNv/+Eol167pkeHTsry1wMcLBfQ6GuTSTmS893IlMbJ3mIMfFw44rd5Ij0CUhqIHH54rNW4ViLoyr3h8xSu7Ed8Tic2+/vlzVD8Bang2sgdGwZj8c/m9DH1XY2FlQUUnk2qPElNh90BM3A7JF8VaZAEXUA9hqide79rxEP2QxJ26FgRNMnhwIJ/zmEyZ0pxMvyPJsOd+k0Fptqjasen4Y3CRlwNSh/euT4a99dV2yc0sAoDxilZ1RAsVqaQ3mylAUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpT8IE/3+VEkXJ1/QC8nvSNm/j6xU0yib74TZCR51KY=;
 b=mmsuNys0dIkQGToTVXt1rUwtQ45p9h6Uc6j6I3cipVoGgKsasUKz2RSvMHhfT0QCMlgqn1yVkkuKbbVoELvm3zKTaZ6sgZwEM5BPclaUI8udhLQUvzgZ/nRpgDr8pHzlGUVIEZZqCjmXQTpYRh2Go+7gc2xdpDdMiHDJhwkqK439l+8QcDVnJ4nAegYtfm/2UKe7rpcrg/ja68rYNgMMeGZiHLf8MvOw8dUTBLDdcLIS384CpcUu5m7paXH+FjrD5jiSfo/6kZ87a588U9cayViT7AEtFeGHwrbU0sFHlwyamX/uoCZGT8D9MnUj516i115x/1OKUHFMOKMkXApC+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpT8IE/3+VEkXJ1/QC8nvSNm/j6xU0yib74TZCR51KY=;
 b=CWtVLJUZNNNFf9h29gDtKVLRJ+mz6vKmTyuoSmdhJxGyzGcst+Wj34ED2kPl+qRkL+eM5Nu3nxxBYZZpNRyceTUwHrI97gvsyw49qvtrTpVW0V5+BTEzms43/CxDJ2dzsd+qZ6p2hExf8DECAHJ2V4glxf3AIf04o6Ots8kudIs=
Received: from PH7P220CA0145.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::9)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:46:26 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::b8) by PH7P220CA0145.outlook.office365.com
 (2603:10b6:510:327::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 02:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:46:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:46:23 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add missing 'inst' parameter to VCN v4.0.3
 function interfaces
Date: Mon, 11 Nov 2024 08:16:09 +0530
Message-ID: <20241111024612.1881727-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b90e03-1f6b-41a8-29c6-08dd01fb096d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGJ4TklyTmtWMnR1VFhzZEdLcEY3Q1ZzQk1nemRUaFBCV3pNVlVsQjZJOXRF?=
 =?utf-8?B?ejh5bWY3TWlMTWp5WkVYNStJdkpLM2FnYnJDc0JXLzZ3L0NzdlZLOElCeTZa?=
 =?utf-8?B?V0h5eWpRcHY5RVdwaktqdG92UU8veEJMY04rSGt1LzVYY01kUFFlMDRRZDgw?=
 =?utf-8?B?aWt4alhjRUsyZnBveFZSM1ZuUkFYYWNvL1BrbWlzRzRSckovREhGRWRidk0y?=
 =?utf-8?B?ZlhCVHF5cGVlbE10Q2lSSzhHRGxwd3ZYdnpjRVlXUDRhTEorMzFaR3BJTCtH?=
 =?utf-8?B?b3hPV3p0QW8rRVhoNHJDL1B3MVBZTmpXbWtZTWI3cFVEZEZDY1lNYkd4TDJC?=
 =?utf-8?B?eFkrVldibElyeEI3V3NnNDJWSmFxa3RBMUR0dWE3WjhrSmhEeEd5QVVIcG8y?=
 =?utf-8?B?Ni9FUGsxU3pNSTF2c3VkQ3c1SGFJNDk1M3drSXFqaDZvSTFYdGM1S0JRN0oz?=
 =?utf-8?B?WWtUSTJ1bGk4T2tnK0RrcmhIeXN0TTUyajc5UDJYZWttTWRHREZlK0pyQTg3?=
 =?utf-8?B?VE1yeEE1RElFVE9sKzVEeWxvK01Lb2tqcnhzMHV1bG52dDB5NWJwNjhiVGh3?=
 =?utf-8?B?RFRobjAxNElFUDdzbmI3UGMxeWFZOXYzU29ZQlo1ZnVvMnppLzUrWE9YaS82?=
 =?utf-8?B?VEsrb3FYbFJob2pSK2YyZFVGMmJXeUVUb3RRamYzajVmYlMyRFk4WlA2c3Vh?=
 =?utf-8?B?T1RyNncxUTlXYi9UanY0eUZFblhBeWJrb0tsb0JNUFExNGVIVW1WTUFkWnVD?=
 =?utf-8?B?KzJMbWFUVW8wR3YwdjZNT0lSZDBIWUxpODZlMVFvYmU5QzQ3SWpNVDBFUGli?=
 =?utf-8?B?SGVxVkpDV25QOG92V0VhdUN0M28xQkxyVVFZeVdEY1hLWkREL1ZLYk94Nlls?=
 =?utf-8?B?aVpUZ0VPdkFkdnNpb3RXR1M5ektWM2cxSjdOWk5UdFZqeUl4cjR2V0VQZHRT?=
 =?utf-8?B?aDZDTVhLcnYvZ295MHltamxLN3hQTjlWd2J0aEFvemZHaDBzKytrWXdtVGtX?=
 =?utf-8?B?Rys2NWE3RkZNbCtkL29wK2RwK2pSZmM5VGpHUzdxTkx6aVpYSlpuYmQrVHh0?=
 =?utf-8?B?U3NiY21IMFFWVHRoMVR5eTlGRWhYWTc1dGpTbkRoeW5JazgxMGVub2F4SjNi?=
 =?utf-8?B?YzhWOHNETkszekNyYmN2dFdOcUsvZDBoWitZY0FmQTFzbHZPSCtueG5GWDln?=
 =?utf-8?B?enNJSzhOR1AxUmhVR1FzY2xNcE54bE5YSFNwQ0tJdWlJTC80RUtOVldsWjNw?=
 =?utf-8?B?b0cvU1MrMVNwdHUxUkVUcVdKM2N0eW9wblNPZnBUMkNnTFRONFEyd3BKMmov?=
 =?utf-8?B?cW14TmhlSFluV2I4aFVsWUZSVndhYUI5TVdMdkZzQ2xVZVh2UGhJZGJMbmFo?=
 =?utf-8?B?RzBsdUJPNForMUVkZ2dTMGtmU1BGNlhhNW5sejV3V2ltRk50S25KaitKSHEz?=
 =?utf-8?B?cnlYRlFmV0FqZ3pTTkFOYXRMeGw3M0VFQmgrTFoxQnRMVEdtZkswOXNFWkJ6?=
 =?utf-8?B?eExqR3ltWi80NjdaWno3SVpsUG5XTVNXRHM3cG5zOUlVYXZFdzdvY3ZvN1Rk?=
 =?utf-8?B?a05saVBwV2xyVXNzS2p6cmYzWDVhYUlLQ2Rnd0ZPMU4zUE1WV1BzVDlHTzU3?=
 =?utf-8?B?MFNIQVJ4cjZhVFRqa3pPMHdZVnIybldSWkdzdWwra1g5QjlDS1hrRHZ1bVF3?=
 =?utf-8?B?WnNISFRGT2RoN1VuQmlrQ2JzUklzZmIya0doYjVLRE5sM1lKZkt5SWlvZkJx?=
 =?utf-8?B?YmZyWG95TkhBR0pmWFZpellKRVo4cGFKQ2t3eXowcEhnOCsrYkoyNVhIbnJu?=
 =?utf-8?B?RUhTSGs2bnlsSjRRUWpaMWsxS3lkbnJhbHhydm5heHhFNldwbWhuS1F2Y3RQ?=
 =?utf-8?B?c0RtZ2xRNnBmd052TkpPWW0rc29Tbm1XM2xydGt2RjUrMFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:46:26.1952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b90e03-1f6b-41a8-29c6-08dd01fb096d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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

This patch adds the missing parameter descriptors to the functions
vcn_v4_0_3 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1104: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1310: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1545: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1732: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_3_set_irq_funcs'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index aa06b2fdeb7a..af351f12c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1097,6 +1097,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
  * vcn_v4_0_3_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1303,6 +1304,7 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_3_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1538,6 +1540,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
  * vcn_v4_0_3_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1725,6 +1728,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
  * vcn_v4_0_3_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
-- 
2.34.1

