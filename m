Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8F0CF885C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA6010EA99;
	Fri,  4 Oct 2024 18:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3dZnTk5+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FB910EA8D
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNeoFyT/6iUX2xy0pRCC2I/fbmN7koOjcAA2l0md9eyxKTycO7zZ9RPS57aY91WL+0GdyAK5ZF0Dd+YI3+0Zz8bDn/zEsRMux8ezRIDkF6pasd8ddE/IJWT+GYP0WpUl+BnGqHBpfF7i4YDAnGhZPqcxok/bPWJT5HtQOlZ4Pw2VF1jJ6ebgUKavHakM3lHFhJ1pJ/JF75qcJnDTSiaAi1gGLz/bs18K8l2we8NaJ9tCWsM1xq3VOaDYbcp16AJ5acXEpXEFnkl8g0Yit62et+yPMc53+Jnod2p8njWKSwU61AGpOHrBglAFuTTcIt8TxZx9QOPXxZkTpyM94c8/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkOfDWJlZv5oc4CHxVh5QAO5j8I63MNBBB0PJ+g44FQ=;
 b=drQapwYKj+MvWU79YdTRqrT7iOWAKShHtObPIiZ4cZ8wNvvceAYm9w3AAdiK+ksJEgk3TJG/SsjCS7h6EIMA4fd3QhjzFl8S4v5TqKr5LfRVJOkI+UbfcBxBu8eoDEdYVOax9NOgD+JTFxspNC3Ouq2DMrPS0p+LO3T0LIlwY/nwHeoZLefn53pc0eUawvgTAMrsaGuMK71LWe3ndhhiLXwH1cjl4e4swoB3ZRL1MzMqlXVmnDzzdyO0RDKGUc1GHgWvBXipZYF3WzdgoGAfML50WPPd/0BtU41aSvisazuNO6WilGajc/7ShhP/5kE3RhHkj0MnnJBNTRmBjhoK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkOfDWJlZv5oc4CHxVh5QAO5j8I63MNBBB0PJ+g44FQ=;
 b=3dZnTk5+PIwcoqcUkOdTlOLa2ouXHIvFAdgINKmAiYawZOb96O5wLE3sUq8edNxBnftaUk2y7+ydSWKfBIOWYRlOJzx60fwpd27SvqpDEvE0DN5/5LLK4OpHBLr6vXZNl0qsFcgeMPTIvqzWXnqa8HfzqgGqp2YyrtyT8ebAneo=
Received: from MN0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::11)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Fri, 4 Oct
 2024 18:45:11 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::f3) by MN0P220CA0021.outlook.office365.com
 (2603:10b6:208:52e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:10 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:08 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 18/18] drm/amdgpu: set powergating state by vcn instance
Date: Fri, 4 Oct 2024 14:44:44 -0400
Message-ID: <20241004184444.435356-19-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 97efe092-bf69-474b-b840-08dce4a4acf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RWyUo6eJh3Xv1+tEnvuapz+UYtVzoLPCEE09gWsqoCRp5bt8uFMeTBzNIybC?=
 =?us-ascii?Q?vD8bZRoEks8V67gNsoZhTzVuG05BTtdWjKSbLzP+XMM18ImWddvVS+q+/pPN?=
 =?us-ascii?Q?F4c5OCF6xw1QHQa2t6cYbdLpMs3MzyitaT0ZzGPWFgShDZgCsAqQciASXtjH?=
 =?us-ascii?Q?JP31WmLPqY8NA8VsZYjFtSJPjRf7MSaEa9h8Qr8/BII7c5VzvVd6JEz2lIcn?=
 =?us-ascii?Q?YYJNE5kzHnRWN8WpL/p9lgee8xnOOksgpJLVRHq6TaS+29jJ3mqYEk3bZ2JD?=
 =?us-ascii?Q?TEZUVPnzmaJV6+mSjeRg6n2RC43xHx1T/rWp/F3igdkr2sYW72eCHzZU53bu?=
 =?us-ascii?Q?EIaZBS7jxWhZY/alVqV3Rjzl+d5Gs4FZKwclKF1UVhJ931d6OC6+t93GMAtD?=
 =?us-ascii?Q?1HD5MuHLghL7O4jyQnp3HYh8vV0uhFohLx9NG+x7dbu6R3yPrc/9YVD7IpmF?=
 =?us-ascii?Q?+AoJycL7kAtyDcXQ7zJ766JyDJ9sH2mEon89TRTVCX32Gq6oHYNzfvBU2P81?=
 =?us-ascii?Q?5Vpzs/WMIBQXqyoi13cuBl7i9B2aC8Sb3Y2LEKQ0WSleAxSvV42SBkHRVPAL?=
 =?us-ascii?Q?QH4F0pc9akB1jn1rkKhrImfP8/tcvUKBSHa+OUsuuQB37i20PTA8G3PA6suu?=
 =?us-ascii?Q?aYFJMEUoiSAw9av98eBv6Li/bPsNxxGC0e5X3wQTvD1f/33GmjwoSLkwcHkz?=
 =?us-ascii?Q?1UjFQfxpoq3W7hS3UIi6UKZ4lyEKZp3MKm1jtgjJrV2uHp2AZNL500V5ZRSs?=
 =?us-ascii?Q?TQmFlPYXJ5HQmEFARh18608asx5VNEKX4SfoBdxwfBtxYkf4Zj5vHwrNrIk6?=
 =?us-ascii?Q?3U3mGHO5ZALMmMid/gxfGcoLKCp9xgM18tzt4g//tW762sZKXi+OD9vW0rKQ?=
 =?us-ascii?Q?kED55ihV4qL/utvI/D60TxKTw49pzE7LR9mJE+ix8YswlN3t2RvA35oa8JLN?=
 =?us-ascii?Q?BNuvuKg7DGPKGkdwDUF7gJEQxG/ZvniHWkekPy6oxNR801S/JMWDrkARPAUG?=
 =?us-ascii?Q?xqs7O/nr8K8fy4njn+vAIxZzlasL1wiet5PMOGz78k03Su1sHJqT+a9FfHC+?=
 =?us-ascii?Q?kRbk615L72XDunhY56/HbBxUekUmr/N8OoJSEroN3TW+QQjT8Az0Y4cdNqvz?=
 =?us-ascii?Q?bKxuWKOZoet8IBQrNCrMW9PQcbLhVoA/f6wgJ85iRfBuqXWXV5ReOdyO9U7G?=
 =?us-ascii?Q?0Zo/OfCanUZoFpVu/fRjao9xwTigeWex1VPsXLGZlHtUgjTRcohI9cPax8pa?=
 =?us-ascii?Q?OF6fKRq37lP4zoEfNqgqak/dRybIpA6Bn0hlSnIiepl9g6FSGf9O0u1/sLOi?=
 =?us-ascii?Q?6GkFnPe4A5RFSkndMyo2w5X3TvlF7DKb3FqBray7yz13dhKz+39UzmkzdE5V?=
 =?us-ascii?Q?N4ggQBA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:10.6202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97efe092-bf69-474b-b840-08dce4a4acf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 28c5e15d166d..9a8e8f88e1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -410,8 +410,12 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		if (adev->vcn.num_vcn_inst > 1)
+			amdgpu_device_ip_set_powergating_state_instance(adev,
+				AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+		else
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+				AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -436,8 +440,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+	if (adev->vcn.num_vcn_inst > 1)
+		amdgpu_device_ip_set_powergating_state_instance(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
+	else
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+			AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-- 
2.34.1

