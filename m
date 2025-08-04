Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CBFC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C899910E449;
	Mon,  4 Aug 2025 11:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nbXHSj+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D72010E449
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbWr1kOdH7wQk4n7CvY91VJlsUr9xzChpOPXR8n4cGuK6+eAt9ELJ54DHA8gpugzDxglHQctixSkafwC9J+BSgpbwNl7gIryY4Bi6mf3WOofg3dhrgjpxCYzVYJtWPWL4v5y7oJRLqE03Zn0hOfETEC9vMht4/4uxuV5ei+7y4c/wImNtd+SRzHizM76gPgpMu+XI4Z6+uoogp4t+KR9pC+IxUOnoqfnSy01hA1yvVqbW1meCWWzk8gwgnKXRIqYxZN8cwvBX1//BdrfvQLXUADf9UwuDwHM/7/pkMsvTD4eU/mmeKloCqVfszjG3afHlp/xCTcTJSlJAZHulgVesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWcPykd4dtYX4ra7BotlHRs69FV9grCj3F8HwQOxWe8=;
 b=SAXyBulukzP4fMRVEbGQQJZyKoFsgCykJLzE5O60RtSYRqjKk0+C26VQySSWf2dsIjhnorA9qRhKMVH4G7mAJ64K6NeGP718vkmUU+L6lVsm2Z8KSctr3FihKyEw6av5g4U+9LvEbKPgTm6SqKb0mw1mm/A7WuJx6JfxONsPEdY3SZrshEMBkEZj9LYUXk1yWbSAh1uV/IL7ZDFrYYtVOtxsDTSgAVHQfnS/YA22Vo5bLMI1Vn97zHsRQ11cjLtJV3vDzFsfSvYmwjtKyLDaQyD9Ozu88jBXY3viL9jstVZCCCw+MXUSrSdT9Oh1L1Vbx95CAaAeZmKmMFVFbu8/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWcPykd4dtYX4ra7BotlHRs69FV9grCj3F8HwQOxWe8=;
 b=5nbXHSj+rithZN6YvTceoP1RHwJz0Zt5Rg+BS9LG6IQnywlM/swDHSIv/NCQXjyky92uhqE2809JLha0CA8zCqn2YeGB367mfdnuhRWDw+uoI7cXDq0xt+p5txwIvkuUADLfDcAyQacqUVlFgfWZwUewk+v3anFZX+AO3bnMXyc=
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 11:58:37 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::61) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Mon,
 4 Aug 2025 11:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:58:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:58:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <jinhuieric.huang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Assign unique id to compute partition
Date: Mon, 4 Aug 2025 17:28:08 +0530
Message-ID: <20250804115808.1758735-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804115808.1758735-1-lijo.lazar@amd.com>
References: <20250804115808.1758735-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: aac67ccc-9ec8-46e8-fcb0-08ddd34e3ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siAgFNflrS24fBXbDpQsF80Ok/gV32070Hfp8BZTJXTTHQ+bHDd+RXOrLFl+?=
 =?us-ascii?Q?r0nov/tOsa0ihSRY3M8n4VYaOIqucbvNYqUENImOh+dzuhZDhf/ht30y03+6?=
 =?us-ascii?Q?BXdUDwpuE/juR8k/BJFJ1yt26nq15Miw9Pn2kMWpHrGcA1vo7RniTxyxoVh5?=
 =?us-ascii?Q?jHrtp5D0KD9Nnp9FrxxK0xluxdwgUHU+xKV4D1vHwrqreWmys+pgExypy4pI?=
 =?us-ascii?Q?mxhFbGEQ1eYz4PDghY/rG5eJhV3igMg4LrmSkF/fSSDkMflRSM1GnjbwP5OH?=
 =?us-ascii?Q?5mWGzaGQI/gtchhs/dm39Zmue3jUWQ7c2lkOBCEGh7yLuno+xtvhj+GFZzD2?=
 =?us-ascii?Q?WUrFbqIYimMnUQYbVzxXBppq5eDFMnwIYfwIHHBJ1Xj4O3KhymXl4WjIP4zS?=
 =?us-ascii?Q?0soUw0t5qHfgu7iDNVwL3aYuqyw1+g69UhZbIQBiAebEEmCgHduhblmy2NbY?=
 =?us-ascii?Q?F6CyimfDacjuzSlU9pXY6tEpZFHvx4VzOnFC3Bu6HR2VYMGTuoOrmyDH/D/F?=
 =?us-ascii?Q?Q4LAfgxOG4JF8pytHAjI7YaJ820KzyftJZ4Em715c/tlOD0lfmZo+hsCc9xj?=
 =?us-ascii?Q?IXQZTpY84xNbEDRrHHdnNsV4U7cL6A0pv8zf/0LXHLrAM768WcfOcA9vchPA?=
 =?us-ascii?Q?qkem69TlKE+HFBTRm791jfy62eN82xH7JSGsEHHF4hCNE/i4/2x2sBPg72Jo?=
 =?us-ascii?Q?wpnmLjLWUs7bV4lK0wabPRHRZOel0Eeet4cn3ndLLcgY1OnP6Ml8HIz4Ylqa?=
 =?us-ascii?Q?RsEvPpLvcJ22lrcIz7x4Dm7OkAEayUpMSZg6FH9d382iqv3oYYFFr3msjQGg?=
 =?us-ascii?Q?FgYq5s3ccAyx1zzPLdr8+ZRnSm7/OQNu39QbH4r6RaFh5XYFR9UiIKqscTqQ?=
 =?us-ascii?Q?Ock4ui9xhJVefzu7D6gXGkWS68l08qa3Is/tQAlWSRP+dQWzsBOJZgENgrRo?=
 =?us-ascii?Q?lqrglktB+nlYDO+yPWwn86ViUlxVrCO+BLAML4TPLsR+q8EKSc6aeijutG8X?=
 =?us-ascii?Q?2uqccJOuCc7kjkffzrrmJPH5cHvphUt3aUBa16E+FgUbC/pnFkGWssE1n6HE?=
 =?us-ascii?Q?SUWWswisSqdYtUKAtgLHqVVJfl1U0PSUDndBjMQBUGv0qm5mbDyJuQ4j12LC?=
 =?us-ascii?Q?Omy4nnfASWqwel9Nn/BJ68mdLwVD7DUivmL/MTvPnmfj/n2iqHol4AsTcaVB?=
 =?us-ascii?Q?aapQxRyyrk8OpAgsSHuYYRhK3OWNgoQztiRWHbtLdo6bC/ma+ccKrgQSPnTT?=
 =?us-ascii?Q?9KHcIKVAe/uYLn/iG72B5E2+bFvFTZscyLfqMbuTeHAsnWoJQ2OjQ+Y1WO0B?=
 =?us-ascii?Q?A1p4hULxZMWjyCRp6D62ChN5pPJhS67UsMqg2JuGvrIaGD4ePFwvzHgMGaxX?=
 =?us-ascii?Q?OolkRiDpMelaUGSsEQblTAI4TBjHu5lE8dT5c4Gu9j3DpqVUoATpsT+YfqsR?=
 =?us-ascii?Q?zLwl9+1psP4lHP5vr/hzkq8N+yK+tHwAE2DG916/cF6a5dZ1jP9sjKqGPzH9?=
 =?us-ascii?Q?CZWmRtk0+8SbkdlooPLt89cRK9EnI2JedaY3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:58:37.1433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac67ccc-9ec8-46e8-fcb0-08ddd34e3ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
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

Assign unique id to compute partition. This is the unique id of the
first XCD instance belonging to the partition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 699acc1b46b5..1083db8cea2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -120,6 +120,25 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 	xcp->valid = true;
 }
 
+static void __amdgpu_xcp_set_unique_id(struct amdgpu_xcp_mgr *xcp_mgr,
+				       int xcp_id)
+{
+	struct amdgpu_xcp *xcp = &xcp_mgr->xcp[xcp_id];
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	uint32_t inst_mask;
+	uint64_t uid;
+	int i;
+
+	if (!amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask) &&
+	    inst_mask) {
+		i = GET_INST(GC, (ffs(inst_mask) - 1));
+		uid = amdgpu_device_get_uid(xcp_mgr->adev->uid_info,
+					    AMDGPU_UID_TYPE_XCD, i);
+		if (uid)
+			xcp->unique_id = uid;
+	}
+}
+
 int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 {
 	struct amdgpu_device *adev = xcp_mgr->adev;
@@ -158,6 +177,7 @@ int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
 			else
 				xcp_mgr->xcp[i].mem_id = mem_id;
 		}
+		__amdgpu_xcp_set_unique_id(xcp_mgr, i);
 	}
 
 	xcp_mgr->num_xcps = num_xcps;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 70a0f8400b57..1928d9e224fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -112,6 +112,7 @@ struct amdgpu_xcp {
 	struct amdgpu_sched	gpu_sched[AMDGPU_HW_IP_NUM][AMDGPU_RING_PRIO_MAX];
 	struct amdgpu_xcp_mgr *xcp_mgr;
 	struct kobject kobj;
+	uint64_t unique_id;
 };
 
 struct amdgpu_xcp_mgr {
-- 
2.49.0

