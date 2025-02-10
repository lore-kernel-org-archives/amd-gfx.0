Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DCEC0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 23:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C0C10E3FF;
	Mon, 10 Feb 2025 23:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nbsm32Gp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8183E10E3FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 23:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR9zv/axhJOhi7OmZWCLM4QfXlZ219mHO1R0XOTUGrG0P8u/PJkDPmZuD2gEntjOIDNOoLz96u8f7Z0hSYGjnQXN5fBxgrWwp1T2KU+bSR/0jPzuQ0e+lEPYvCpacs02kJ8m8AnytMX+4oVtTrgaYovCqJAsyTkLEcDD+u1x++W9uemw7y1QQkNoz+LdENKJ7JT5c/YlAtWQJUBk+swHJZ+9pfQDH87sWKho8nNnQ6F2UXMfzGA3dRtN9Lg3akb85F71l5+Gztw7g24DGExxryyeR10AP7ffGB5GchutN7X/gGQ1Kn2iq/Px6gDptxhTpEriMRUE1MzzjU+OCJhW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O3Y7nGA9mnu6rnsBSRAlfRtL2LUSdMU0HfvQmWhnkk=;
 b=T/RHGs61LasFW48rvuEUluVKMcdfgBNZo+AUJdwqi8uMFw2WUJUT3y0DzTR3dKyPW74u95gR+UfDjL0Gh1I/xkN9+tpdzZBPt6M0lzfDPKTAPwzmNvh2dOyzWuBSWvGL96d+Bx8udlHccZ7G8f6K8WQnFyLUlp0KTwg27ghH6sMxITSsApwXWQwH1F/jPNXezGNNm+XIO3T2tj78fXniEOxbuwf5SKFBa3ZtzSJxbD1iMcy1w/a4dpobBboPjXo7J5Zwn46a9OG04GxV4JqJbb8gYBTuNdq9fi1ymB0g3xJrIjJlrpiXcBZs+rM2exQHqGZ2ZM52tuWjfTs9gPJpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O3Y7nGA9mnu6rnsBSRAlfRtL2LUSdMU0HfvQmWhnkk=;
 b=Nbsm32GpbUwqRck1H/vgeDP6kWZ+cS5AmoTYhCm8vDotNQ/vA+WPv/54yJDs4jSv4IhBLHHmw/J9J/ff1ksB+u+imFqromzcXrFkGIUcjR3OnjJmA/eKDDt0Nf6Xm2mT9clfMXrretUo2m+odyXtPFC42C26Hoo7k3dndUrc3vY=
Received: from BYAPR07CA0044.namprd07.prod.outlook.com (2603:10b6:a03:60::21)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 23:31:50 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::ed) by BYAPR07CA0044.outlook.office365.com
 (2603:10b6:a03:60::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 23:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 23:31:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 17:31:47 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sonny Jiang <sonjiang@amd.com>, 
 Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/vcn5.0.1: use correct dpm helper
Date: Mon, 10 Feb 2025 18:31:30 -0500
Message-ID: <20250210233132.583035-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84f3a1-f5ac-456b-590c-08dd4a2b1773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HXvv4NtuNkLhCm0UNJPRj5YN+LrOYN1d8A9gBDOdUVMrjbDqb+DiGG3Vh1Oz?=
 =?us-ascii?Q?zdSwi9GsiDW4l04cwOKEDCj10Bn5kisolDD8UyQsixprOJCGbulr3i+4eBIu?=
 =?us-ascii?Q?Euz1O7VSFZQB4E83MLdegGgCVETg7VzPeJS/9zJ9OYypTe50CYgH8Ryz9Tgs?=
 =?us-ascii?Q?+J5Z5w6z2GO3qpM66wD7OfHDub6tFWZSQh2eSmPpAVVAOt2CwoPv09o6gwad?=
 =?us-ascii?Q?uCHLGj4jVBfp8Yh+tZRCZxpKeqwY11Z0YB6AATrWpOlitubYPD3DHRImEi/T?=
 =?us-ascii?Q?AHmt/bsE9vPu7E1mdOyS8kHcHhfhiLj2S+92jUoDrbj+kHLC9ORYdYu8VsM6?=
 =?us-ascii?Q?6CQFF3sCX2rmnjcd95OTRbC0wx9YEJaxoNkwvA5OWIYdxG2pC4WWMj7i+GD6?=
 =?us-ascii?Q?DzhdEjTuc791bxxhHCQ2Oz+5D4FiAj4oeCHq29Obh220G2O0WqegR3TdzcrP?=
 =?us-ascii?Q?HEY+3hnrpnH3IzpqUUVYDml36Mo7AGZRn9PEUsORt6R6YQSaN7RRIrMwdFHw?=
 =?us-ascii?Q?mV4cmt8V6wp1cx+1N7sk28tsw4oN8bilDPGSSISebp68bmgMK00bY17lrSKQ?=
 =?us-ascii?Q?oAqJpQvd0s1vLyed5ioUeqpa3FMrn7MVPqNNIjhPwUgaTq+S/SpaMfm5P1PP?=
 =?us-ascii?Q?Ir5HisxXZMyQQgjT9XUA+hvoXXIXFhOaWYaoIxGbCmVpkg2dmHhD3q/hbXW8?=
 =?us-ascii?Q?uCosXGb5f7hayxHZZbc1+CWL6bEAmGw1ebcTUiKqts3urFF/6l3b+9qYMQQo?=
 =?us-ascii?Q?vB4CrhRL+aF3GfYhathH0zpvO6TM3f4OuR8puC9Y1oq6flU2eLNj1+tv9hPW?=
 =?us-ascii?Q?qVV2i+frViSZfjiYeFh62Rfr+ijRdd5erQZosN/PVK1Y0Ji+/g0+XzXj5KV7?=
 =?us-ascii?Q?v9lp7c6WymBMCi2nkK9SWTsFCEAIsumrFeMNyr7DSwEjIK0dd4dkWpslW/dp?=
 =?us-ascii?Q?8u7K57XKvD4EnGus8dzoP1Vv/EkNfbirer9UwE2Xly2tpbwEv5t+K9Nfbom2?=
 =?us-ascii?Q?6Ng0oFrpjKDClYgXsW0w2by/mSi+E02xxSFMvt8RbwhRq4WILKVhcfhWRXbW?=
 =?us-ascii?Q?yI0fBpLvdUxponUkHsvOaCAXwkwRDm2dZcBUmCjwcJUK6/MAIOACa+2vGPdW?=
 =?us-ascii?Q?oYM82nSMFi0npjBmYSBE6unMngg5S+mjQP3pFdxKqYmlWBhhGzoNRJR9jwi7?=
 =?us-ascii?Q?gxPX9VRj7VbATgWzXwvvrbFfiroAIl4hZ+kNNS/63guPDDVwosYDU/DArdSi?=
 =?us-ascii?Q?cRQWYYwWibMAW8HLKd850vLCW1wU6MLAiDAmGcapN/Zc3vyvJmAscfHWUPSo?=
 =?us-ascii?Q?oZZXU+Rvko1jUyzy7qYu46nhysXV7QvENNKF+MNH7oY3ljEKAaC+Cmx9D7DM?=
 =?us-ascii?Q?1fzf6ib6nSQcMgqvsh5erQb/ddHUay85FIHZoOYNM2FO/iKeTLnXW2yJbZV0?=
 =?us-ascii?Q?CZCIpXp3/Nsqsj1RdoMyieiJq8GNfQrqh7CEMB957sMRj5hxABlcg5J/F7pJ?=
 =?us-ascii?Q?fyOaai3n0iuHX0g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:31:49.2400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84f3a1-f5ac-456b-590c-08dd4a2b1773
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

The VCN and UVD helpers were split in
commit ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
However, this happened in parallel to the vcn 5.0.1
development so it was missed there.

Fixes: 346492f30ce3 ("drm/amdgpu: Add VCN_5_0_1 support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Sonny Jiang <sonjiang@amd.com>
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 8b463c977d08f..8b0b3739a5377 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -575,8 +575,10 @@ static int vcn_v5_0_1_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r, vcn_inst;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
@@ -816,8 +818,10 @@ static int vcn_v5_0_1_stop(struct amdgpu_device *adev)
 		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_uvd(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
-- 
2.48.1

