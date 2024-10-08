Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282FDCF0429
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B8B10E5CC;
	Tue,  8 Oct 2024 21:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oNj6jbgv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8704310E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9dAzWQ7RAcj8EOji48IrAA3gomLVHUx+cMBriuNsARxnp7GoWwgCA7YjkD22i8Qi5hTp5KE1Nrs0I3Qd5fpXJPxH/xWdNmCzRxmxgdEjAdKJRJ/LJmVu4Nx3IJBXlxySFAl8iL60vYKiPLg46i+7xc6BNJy2UitKZYcySXMhAsTJrnpTxKW2V5DCXqlwEVzC0kKaGOLrz2yQKCPDnGyX5+Hh7tbtGoxUkUFWXDbMNAlCoPtTAHtBKrxlV+1FeO8N2SUVKJAL83UyxohFGdsQCu9Vf/ZBY9ustyVI29uDMkneDH/jNWwlxaQCZM1Q5NJEU3Wke82BxJae861DFyIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml5ytxsBVV6uaEwlqHLLQcH1opU6PNRVvx8CQSRXitY=;
 b=a2/ZhgCkoDXn7LLzsKpjiZDowd+gYiqHvlz2PR4+Xzn2A8fq52oapRqkcqxCJOT8K0hn7Exd1Ra9RomBlITk7/Zg6+kSdibgorSnYKhVnJzTjM8vaYqUTgOxg41tvFbTR3m9dxl1ZDHBHwmxyT2MhSjc5RmdMS3Kz3SZ1fZkORB3AG/maRiUr+hIXcU/w+22niqbStZLVVdgpohNqg6zVMqLlH76uKEf7VGW+ARrpLZRKzFioK4mlx9KOyWfSLFZy40953V9BUa7lDwZ4wuqV5M+nY6Gaa6X8om9PIqpEW15mw01Izw6mWSQgy0PrDhfpiz5Lxv8YBgHB9BGYMHe4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml5ytxsBVV6uaEwlqHLLQcH1opU6PNRVvx8CQSRXitY=;
 b=oNj6jbgvrn5a/2ksfJRT6/DT2fJKmdO4tqkQ8d+WXlRffqKZSUUfdoCkbSlcU061qIMNjPmCkSTs9i1dGnDRMkYlOLmNIG3L6EysWXyKyjREmXFD+SMoVka4pOnLnO0km/MOrRUlDFhRgkN8KrUmQEVAXxIdweyr/hNYl3J0tkU=
Received: from CH0PR03CA0407.namprd03.prod.outlook.com (2603:10b6:610:11b::34)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:23 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::6b) by CH0PR03CA0407.outlook.office365.com
 (2603:10b6:610:11b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:22 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:19 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 05/32] drm/amd/pm: add inst to dpm_set_powergating_by_smu
Date: Tue, 8 Oct 2024 17:15:26 -0400
Message-ID: <20241008211553.36264-6-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: ec471863-5793-492b-5fca-08dce7de7637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjHR1yFrNkfyZSnWi3P4tasxldgwnafmzozkEIHqKFXJi8JS7CzoUWbF8X9T?=
 =?us-ascii?Q?3aWDGiby4DPrFDlc+axc38X8t1THpQlnAruKF3vfFUbwtutQGKgB7fNFrfd6?=
 =?us-ascii?Q?cSR39QpIY1YqpSSOlM0KhSYzHnJi+tHBHA0uZKnmm1p6eQzdTLdY08z0Dgaf?=
 =?us-ascii?Q?x+/k6MN/OPc6SeAnhCD+7srLMRO4DTmzamz3+ScWgvB13/olZd0N42hhYYbO?=
 =?us-ascii?Q?t+vIp2xrWpVpbk+faAmRnIMuwETNacy/q8F3WjH/CqT+1E0o/b5iNehiArmO?=
 =?us-ascii?Q?7LgCtgefQbmYGrgKC6wzmOlFH3dyWChxq/HY6smgoXnxCT8+gSAe9tkeHWHr?=
 =?us-ascii?Q?CTe5WLtkHdziEBjVmYCwWiHN0sBck3tZCBw2pQ23E8aUgNywDV/24nb0cuEU?=
 =?us-ascii?Q?MVBiWIBCT6zmxk4wAZD6QxMLOlubG2zqGXqM4mPbn8Cvux6YyfTaDidibno2?=
 =?us-ascii?Q?+6T5hpbVszFwegBMS1+3z8qGeQlg2yljUDBovnO5WO2mn3GHuzPYLTDmnIxQ?=
 =?us-ascii?Q?YGQhJHCHHb473Eu1lRj09Qtwxch5gPFrF9RaDryPKLAEGKuTa+L5O7MXWL5X?=
 =?us-ascii?Q?d3zdRT0+9Slvsyhq4j88q4TH7wS6EbJr20OZjv5+YO8BWo0/MN89JAl66FSN?=
 =?us-ascii?Q?q1WPYcGfBipDhrv6uHy7qJHt8m9mvoCL7s2KSHfVntlN1zwlMRae/HGtLkHG?=
 =?us-ascii?Q?eMtGuvswWd81WbdWJKPIEfIVWgh58VBDo6d+sZTqptlKnYVF6/+ZFYrhUU5V?=
 =?us-ascii?Q?LZRCZaHaPBxAc12KTnObkopkChVfq8KympyTWLw0mHszgRg7Hb1rCKeR1tyF?=
 =?us-ascii?Q?kQDQiYHGKiJVEscJom1WOB4/Xv6QFuzFNhhnMOWrsMn800IHSfWyuB/ul0Zg?=
 =?us-ascii?Q?HuFtmAK/+4F0udKJUlN7GyTkghUHi8B+3HJfjHQyDX5QPOm6e/fbiWZ2+RWv?=
 =?us-ascii?Q?nxtscGLsG1ZIkXo/md7CSIalKBYZOhS9OG5b9vGJmZvllWI0+hkcFMevjGGp?=
 =?us-ascii?Q?ZoCbJh6GSywPscJ1KoSTb172+CiPQ1x2LuhGispNKJYA/4TlJDASTgFSlXqm?=
 =?us-ascii?Q?INQ0DQND98rGgG2IAiX5tqOHirZIxb85Z14oaV/i1evUBeS4+O9zNCQ/6t6R?=
 =?us-ascii?Q?zGEOxAC9yw3x/9/TWMWQsl99cDfQWY2QY06sMVZVwb9KCZwks7IaI+pXDYZ0?=
 =?us-ascii?Q?n3gojgFJh+/tj6sHzA3A/GX8Rha6k9v6ilVU2jJXu9+J87UsIAoKuI1Hp/y7?=
 =?us-ascii?Q?UO4z3egRAh3TWNZKUfr/6ARN1A7d9K2798IF1f42PsnuOoNnC2jaVin9xzma?=
 =?us-ascii?Q?RExeuIkinCZh9pXPWJBGp1GvM4M4fpu79RlOxy8ZJe2VzNy3rnFyycKLBGx/?=
 =?us-ascii?Q?2zzVJ5M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:22.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec471863-5793-492b-5fca-08dce7de7637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to amdgpu_dpm_set_powergating_by_smu() function,
and use the instance to call set_powergating_by_smu().

v2: remove duplicated functions.

remove for-loop in amdgpu_dpm_set_powergating_by_smu(), and temporarily
move it to amdgpu_dpm_enable_vcn(), in order to keep the exact same logic
as before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    | 14 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 51 +++++++++++++++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  3 +-
 16 files changed, 73 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 8e0725198dae..575826d220b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -140,7 +140,7 @@ static int acp_poweroff(struct generic_pm_domain *genpd)
 	 * 2. power off the acp tiles
 	 * 3. check and enter ulv state
 	 */
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 	return 0;
 }
 
@@ -157,7 +157,7 @@ static int acp_poweron(struct generic_pm_domain *genpd)
 	 * 2. turn on acp clock
 	 * 3. power on acp tiles
 	 */
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 	return 0;
 }
 
@@ -236,7 +236,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 			    ip_block->version->major, ip_block->version->minor);
 	/* -ENODEV means board uses AZ rather than ACP */
 	if (r == -ENODEV) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 		return 0;
 	} else if (r) {
 		return r;
@@ -508,7 +508,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 
 	/* return early if no ACP */
 	if (!adev->acp.acp_genpd) {
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 		return 0;
 	}
 
@@ -565,7 +565,7 @@ static int acp_suspend(struct amdgpu_ip_block *ip_block)
 
 	/* power up on suspend */
 	if (!adev->acp.acp_cell)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, false, 0);
 	return 0;
 }
 
@@ -575,7 +575,7 @@ static int acp_resume(struct amdgpu_ip_block *ip_block)
 
 	/* power down again on resume */
 	if (!adev->acp.acp_cell)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, true, 0);
 	return 0;
 }
 
@@ -606,7 +606,7 @@ static int acp_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 38a7423101f3..dbe4c26f63e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3425,7 +3425,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
 
-	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
 		adev->gfx.gfx_off_state = true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2fe75c920a73..94ca2da07cec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -787,7 +787,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 			/* If going to s2idle, no need to wait */
 			if (adev->in_s0ix) {
 				if (!amdgpu_dpm_set_powergating_by_smu(adev,
-						AMD_IP_BLOCK_TYPE_GFX, true))
+						AMD_IP_BLOCK_TYPE_GFX, true, 0))
 					adev->gfx.gfx_off_state = true;
 			} else {
 				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
@@ -799,7 +799,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 			cancel_delayed_work_sync(&adev->gfx.gfx_off_delay_work);
 
 			if (adev->gfx.gfx_off_state &&
-			    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
+			    !amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false, 0)) {
 				adev->gfx.gfx_off_state = false;
 
 				if (adev->gfx.funcs->init_spm_golden) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 88acf34e16fc..cb59ba3a6d1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5314,7 +5314,7 @@ static void gfx_v8_0_enable_gfx_static_mg_power_gating(struct amdgpu_device *ade
 	    (adev->asic_type == CHIP_POLARIS12) ||
 	    (adev->asic_type == CHIP_VEGAM))
 		/* Send msg to SMU via Powerplay */
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, enable, 0);
 
 	WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index e3ddd22aa172..21e66f81c5c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -307,7 +307,7 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
 	if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
 		amdgpu_dpm_set_powergating_by_smu(adev,
 						  AMD_IP_BLOCK_TYPE_GMC,
-						  enable);
+						  enable, 0);
 }
 
 static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c1f98f6cf20d..3f5959557727 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1956,7 +1956,7 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->flags & AMD_IS_APU)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
 
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_0_init_golden_registers(adev);
@@ -1983,7 +1983,7 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	sdma_v4_0_enable(adev, false);
 
 	if (adev->flags & AMD_IS_APU)
-		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true);
+		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 129c759772c2..746b3d282ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_uvd(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 19bbd49f760e..d0c3895dcf6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 30420ead7fc4..d4c062983bfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1013,7 +1013,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1486,7 +1486,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13632c22d2f9..1da9a7dfb667 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1142,7 +1142,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1633,7 +1633,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index e7b7a8150ea7..a04a64442809 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1089,7 +1089,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1615,7 +1615,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6dcae398b2dc..d433d2703995 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1092,7 +1092,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1366,7 +1366,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 	}
 Done:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index edb9cd8390b6..133ebb3c14db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1001,7 +1001,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1278,7 +1278,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 89bf29fa6f8d..c57894f1734a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -762,7 +762,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	int i, j, k, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true);
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1009,7 +1009,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 	}
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index bcedbeec082f..8531e0993b17 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -70,13 +70,18 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, bool low)
 	return ret;
 }
 
-int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block_type, bool gate)
+int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
+				       uint32_t block_type,
+				       bool gate,
+				       int inst)
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
+	bool is_vcn = (block_type == AMD_IP_BLOCK_TYPE_UVD || block_type == AMD_IP_BLOCK_TYPE_VCN);
 
-	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state) {
+	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
+			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
 		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
 				block_type, gate ? "gate" : "ungate");
 		return 0;
@@ -98,11 +103,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 				(adev)->powerplay.pp_handle, block_type, gate, 0));
 		break;
 	case AMD_IP_BLOCK_TYPE_VCN:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
-			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
-				ret = (pp_funcs->set_powergating_by_smu(
-					(adev)->powerplay.pp_handle, block_type, gate, i));
-		}
+		if (pp_funcs && pp_funcs->set_powergating_by_smu)
+			ret = (pp_funcs->set_powergating_by_smu(
+				(adev)->powerplay.pp_handle, block_type, gate, inst));
 		break;
 	default:
 		break;
@@ -572,12 +575,38 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
 }
 
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+{
+	int ret = 0;
+
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
+		if (enable) {
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+		} else {
+			adev->pm.dpm.uvd_active = false;
+		}
+		mutex_unlock(&adev->pm.mutex);
+
+		amdgpu_dpm_compute_clocks(adev);
+		return;
+	}
+
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
+		if (ret)
+			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+	}
+}
+
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
@@ -597,7 +626,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -607,7 +636,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -617,7 +646,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
 			  enable ? "enable" : "disable", ret);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c41..e7c84d4a431a 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -393,7 +393,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit
 int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit);
 
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
-				      uint32_t block_type, bool gate);
+				      uint32_t block_type, bool gate, int inst);
 
 extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
 
@@ -442,6 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

