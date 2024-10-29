Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B6DD3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323BD10E395;
	Tue, 29 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xIgzTmnF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F99510E6B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aphNwTxwriJevbqZM/V3VMknmtGo8XJUF3wUHoTpCrEpPORbxXrgqQcw3FFYQPT9lAm9BnuZCLcALg7rMktvBySti/l6q+kLAWNl8lGkOnMy3oFONgjA/C8lwinN8HBQPz5leDt95DkU3TcDtGkPUkcgmYcRdHDi6tFXuSVdMnl2UNBJ+oFXT9T7lYM3I7sNZo1B8jOLGKhqMAv8ym+AXUeVojSMvkej7nFPG1ecDczHJbCAoXu0T9kmEOKGMw8DLyKySgb8/aSaW3zjjhFwlUjOjSRrlXEFDZFap6o5VhKDlGmUmJvi71gBW7kWVy7XLVMHqh7AMUK7vj4ilfkO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yno3nZ/tMweVwSvbk+dyLF+A4pIly8PKOpn+tooaPKg=;
 b=j8SoiC9rUHv8GBHiLXr8plAfbTzwIuu+uJqmLftJw8Rj5KcBC4B0Uz18tCGz7R+aO6vbewObW5KieEWilAXaaK4dVyg8QJ+VRJyfUjWHKZJqLmWI4QVBUX0r7E9Chy/yYcfEGo5WPKZj7IiXJwqcsPYw/oImYVUZ8IUlBsQ7j/VPqdGcmrthhsQuwNJa8KclXSHZuzcpnE3sZeIGPjowAgU/CesU/J3huKUIe8ZJTeFqCkyqKUfdO9hYV93x4fLvtTD8Jj7QV7tb3JOeexz6JrrmDKhbw8yEszh3qNOu0MVx4Gj6gmb7z36629F2EAWY+pCKJV0YDr6gYDVeJfq6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yno3nZ/tMweVwSvbk+dyLF+A4pIly8PKOpn+tooaPKg=;
 b=xIgzTmnF91Pyy2QiU6fGngr00s3bmcU9nx/Mtc2fXb1c/Rm6pjd/rBQ+9YZrpPIRbVGEHUA61Bh9Pb56qOsbEqFvJ222SDpV3GSFb8165GRwVG3au8+co2s3UwTRE4qtQZeq4ZH27Jd2DA8ALu67jm+gG06KF+DU5pg+DrXDCKI=
Received: from SA9PR13CA0148.namprd13.prod.outlook.com (2603:10b6:806:27::33)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:42:56 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::26) by SA9PR13CA0148.outlook.office365.com
 (2603:10b6:806:27::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.11 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:55 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:54 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 05/29] drm/amd/pm: add inst to dpm_set_powergating_by_smu
Date: Tue, 29 Oct 2024 13:42:16 -0400
Message-ID: <20241029174240.682928-6-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f652140-71c1-4de5-79f0-08dcf8411f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjFXQkhUVkRBdHJqWU5LbFRmZXMvS256KzZPNEorMjFLUGNqdW1TejB1ejFs?=
 =?utf-8?B?VlVUV1R0cGU5SUhsOTU2Qk9FaXc4NHNOaUhPZHJZeXlLSU90eS9KKzM2anZq?=
 =?utf-8?B?VlNVMURlZTA2S0tlWSt2RDFjTFZoMER5WEd3WEVaM0dPS05mM3R4U3BxL01w?=
 =?utf-8?B?YWg4L01pamRaeU10T0pmbDBpRzg5SW9zdVpIN1YrQ2s4aVVBelFUSlFiK0x5?=
 =?utf-8?B?Z0tpSmhCa3NFYnFTWTZaMG1yQ0NUOHI2djUvcmptcGxpMlNtKzE4RTBOQUI5?=
 =?utf-8?B?RnZqbHNHc2ZtTmc3L1FPZGxOSm5SeGVVVWp1aGJQWkZLSVFnb0NVTVNicU1N?=
 =?utf-8?B?aHVFaUZqZUdFVkN5RDhJMUc4Z0VUZEhPL2grQVNTdE9SRmk3cEZMQ3Vsekxl?=
 =?utf-8?B?cFVHOThyRkZHd2R5NTRERU0zemlxOTAzVG9wRGV2NENPZk93em1OaHk4NmIr?=
 =?utf-8?B?WUpNYjVIMzZVaHdGdTdXNGlmV2JVbVpyMDdBL2xsNDlZWjhBcjNHa0RqWlUw?=
 =?utf-8?B?NVZ0OHB6NUk1YjdIS3VsdktZT21BSGRCSWlLYXBWZFpyc041emxiTzdmTFhv?=
 =?utf-8?B?OG92b1F5MW80WVlqcTExc3pIMFJkeGhkUi9VVnZTRXhNazU1eU83RHAvL1Zz?=
 =?utf-8?B?NXA5YlBmQ0t2V2tVbkQxcXdjMnk5cEVPN3NQZXVKdHpBSUNNK1Q1TFZmNklh?=
 =?utf-8?B?S0NuVFppU0NuV1RCbUM4NytUN2Vza24yanFTcHpReThodkpwdndFR2V0UkZI?=
 =?utf-8?B?ODAvWkFueVpJcVhpM2JJUlp6VDhvdTIwYmkyYno4S0lpeDZJMi9ydndRVzky?=
 =?utf-8?B?YmgxZUJ4OFEzcXMzOTI5eUE5dlpTKzlhdGcxbldEVVlLMmlSUEtIMVVNUFpK?=
 =?utf-8?B?UC9wZFBLMko5SHJkeHBEc3h3cHNybldzWWIrei9DUWtySzZneGFMbGs4UHds?=
 =?utf-8?B?L1JBekNiWWtpbkpzYVEyc0JnOVZhSEc3Skdpdk5SRHJ2WVZENXJZVmp6dWdj?=
 =?utf-8?B?VXBsU0phaFBSd3Byczk3VVNYdzdaQnlJOS83b3BjZHQwMzluRG9FMk1IazJN?=
 =?utf-8?B?SHBKa1dPaERXdGwxbjZxWm43SFBKYmEyUTArOFFNUVZGVHBOa3R3NEdlazVx?=
 =?utf-8?B?bFBWR2pKMHpJYXozYlhTbTAxREVGRFgvZDVLbGRDL0lPRk5ack9zZjRLaHo1?=
 =?utf-8?B?SzNhV0NLVzRJbHFZdkZzeDhUL1UrK2ltd05meCswYUE4ZEVsRHdHOHNLUlhG?=
 =?utf-8?B?UGlZOWV4SUx4RG5wdkx5Z3E3dDJ3R3ZmWVVJVi80c2wwUStJMnBJZS80SmFu?=
 =?utf-8?B?TThiUnZSMWxtdysrTXBOQzdVd3RYSzJMTkI4UjhhT3R6S2pCaUR5aXpUd1NQ?=
 =?utf-8?B?OWIzNGZ2ckFwR25Xc2M2QzJBQTFLb0syV0NzdjJZM0UyRUUyWitXWW45a0VV?=
 =?utf-8?B?UWpqZWJLb3VoSHNqOUJmRW0vS0FUQVFUVklOeWVYOTNuTnZTQjZHTUI0bnJS?=
 =?utf-8?B?SnN2TzEvLzF3eVd6TUtHVDNxdmJTNEFFdDdOMVA2MzI1R1VKMS9QYmRTelRp?=
 =?utf-8?B?Q0lJQXlGOHpmeUg5Y0xIOXRucU92cWp6NnVwKzBxbTAvcUwyelAxVno0RXdo?=
 =?utf-8?B?aEh6bkRNcFhoOU9nR0g0WFM5WEFPcDR2ODRjZW9Yb28rSUQ0Ny82Q3cyS3BX?=
 =?utf-8?B?Uk1UbU9QM2xZcmNLUUg2T2lOTFJFaDRYMlkwU2NGOWJaV3dEcmQwZXplNEh2?=
 =?utf-8?B?OGpkb0xFdEpMT0ZTYVZrQzJNRFZxVXhUQ29GNWsyYjEvbHZCV3lqaE9Ic2xo?=
 =?utf-8?B?U3VwVzV3SkJWeUFZdDFXeU1nZjNLSFdoVGJuQVI5eW5ZZGM1ZUtjcWYxeTVH?=
 =?utf-8?B?aEc5YlZiQnZzSEgxM29ZNFNMeWVsRFJ4R01Rb0MxQVB2b2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:55.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f652140-71c1-4de5-79f0-08dcf8411f37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
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

v3: drop SI logic in amdgpu_dpm_enable_vcn().

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 +--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 37 +++++++++++++++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  3 +-
 16 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index ec5e0dcf8613..769200cda626 100644
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
 
@@ -596,7 +596,7 @@ static int acp_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool enable = (state == AMD_PG_STATE_GATE);
 
-	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable);
+	amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, enable, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 383bbee87df5..172c5492d96c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3469,7 +3469,7 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
 	WARN_ON_ONCE(adev->gfx.gfx_off_state);
 	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
 
-	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true))
+	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
 		adev->gfx.gfx_off_state = true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..0c3249db2f98 100644
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
index 480c41ee947e..9f5a5b2e6de6 100644
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
index e9a6f33ca710..243eabda0607 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -356,7 +356,7 @@ static void mmhub_v1_0_update_power_gating(struct amdgpu_device *adev,
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
index 10e99c926fb8..511d76e188f2 100644
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
index e0322cbca3ec..697822abf3fc 100644
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
index 6aa08281d094..0afbcf72cd51 100644
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
index 6732ad7f16f5..b28aad37d9ed 100644
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
index 5512259cac79..d87850dec27c 100644
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
index 0d5c94bfc0ef..6fc52a1bda31 100644
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
index 71961fb3f7ff..398191a48446 100644
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
index fe2cc1a80c13..58f0611b8fb4 100644
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
index bcedbeec082f..d63abcc65948 100644
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
@@ -572,12 +575,24 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
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
+	int i, ret = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
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
@@ -597,7 +612,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -607,7 +622,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
 	if (ret)
 		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
 			  enable ? "enable" : "disable", ret);
@@ -617,7 +632,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
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

