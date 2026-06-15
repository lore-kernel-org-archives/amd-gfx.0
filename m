Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71542CD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 16:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E138610E1AC;
	Mon, 15 Jun 2026 16:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eVZYzjTV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE2E10E1AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 16:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRngAONfnywACG2c1yKtdEGFmpV89KPZfF+HwOKfYQit2/yOlLleM8pp1oJfaJNnpHiC7ZEGTDV9ozEapbFOSoTvC1NLGYNoDJWGcbak8gG0ja+QZlLZL8zIps/AzKN5CQkteDBW8M/RMnqIm+it+CfNQn3j5bW7y5Ta+cyWK3TykGP0Ih57M3NjB2/n7mFgDvL73WoPlznu2W2BJ/CWMNtZsjnuwnVF7M5H1ekMAhwZM05jqq0bWFIA2Ud8vvNbG093ThFFXQzDQPHSZpxI23ZTjc6iSIIfIPK5DuE1NNMltvzLP8zIYMZEGOmzgg9z+Q8z11DD7PZHsdAF0edFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqSf0rhtkDAjtof+tozy5qHdy7lmU6pu6vWN5nx1cOU=;
 b=aalVm/MJ6xiCPpHY13c4Ontds7coo+dXxMgEhGe76mFXpWI13tD2WSV2OpDHszhy2zjK+nAKMeEIzHxCI7nrsqkbn8niPv3oSJt9uzxIselazqMXv76ZCVCg6hUr/yoOWReDV8vIqOtZqOPKqZ23PRrvx269Ufkc62nu8znazDGblzlvUbhiTTeI6bg5cj0FrLMDvrcWqtIecsR5QzckkDyKYSFozMj4S7muFTVjiVCayDrSFZQrwwx6dI05WUn0qq+Prs0gRjYCp3rq/2RLA4SpmCALzTR8SBa8giLuVzsT13gFHh0VGQ88z7/27oe8/WhbJSmkQj4uqcyfe4zsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqSf0rhtkDAjtof+tozy5qHdy7lmU6pu6vWN5nx1cOU=;
 b=eVZYzjTVFpZoIMh2e4SReHaa8OuzpmJ8tpXzA6j8GtftR4wTm20BQfIm3Ft4SxRpq4z57Nr6oiSsGkiLwlIU6NCA6SbnSNvZgE6LvpYuRItBm8SoSpcvuIMtRSj16ZWwywlgY2eTM2nfqNeJBQx2SO4UqZQq9HIxBAVIPBwxxJ4=
Received: from SJ0PR13CA0051.namprd13.prod.outlook.com (2603:10b6:a03:2c2::26)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 16:12:58 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2e) by SJ0PR13CA0051.outlook.office365.com
 (2603:10b6:a03:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 15 Jun 2026 16:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 16:12:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 11:12:46 -0500
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 09:10:07 -0700
From: Amber Lin <Amber.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <kent.russell@amd.com>
CC: Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdkfd: Limit queue reset support on gfx9
Date: Mon, 15 Jun 2026 12:09:48 -0400
Message-ID: <20260615160948.4246-1-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9a25e0-f542-49c1-64ad-08decaf8f6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: V2AwtF3CfwEy19MLs3rWayOzHp9nLynX4sPO+215TKx+h3z4jFmGU2N6cWmx89Fwom/zrOR40HWK5jeDvmPgoDh+c6hYwjRP0g7CgGwFTrLnhuAF3enFAAjdlNci89gzDtzYR2wUZR2QUsCKRJgJ4WI5yQT1v3Zhwy9zMn+PVh+uKR3ui4HQVozmiSXeJ+WwVHvocTXTaeo3RvyM4fq6Qk7Bwit0fgwJ/3YKKQfUMWtWpG9mkMknx62Vx4+SWLKIJrl41xXeVaLr0D6Cljf9o0wvw3Whcmq/4ZQZ9Yb884Y6tOhUhLMkrIkpa24/nQgecYREXnS7oYROAbXbdvoe8vTXnCm14WpPwSvmvkBgSTNMwYtdWy+efeAcVZ8znJJfADH4YhLD6s96WQxILWOnqphWDVW8pdbkTLbZ/0zYItyfe0WEPCreaIybTX99DAfNd0hoSjgyE9HbViEUHu2rMQDyM2AqjfoRzA647h/Xf8/GGFBuzlOZsKsA/4rbwDjX+t2k5BvHBKP9zCt43iBI1f8yZ0X8UVanBzCr7XAdE2z+YKsiMX1xs1umoiwZiW+DOpqblK9R/EunCq95o5YHQYJMSWyao097EC8ibBqXzrlsm2B/XG2AslUtvcRzfL1PnQGdhUXwqD8VSgJf00v/7qpacderOh+I/EVhM1PCOacMsfkrSuPBGlQFmXnu1y1G2PmMnKPHf84ZGs4e5mF64PKcL+QBUnhQiT6qhXUvO3c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YcGxEm07TOjFbxylXjYsc2oTjtrsruTYuGYQjqNasSiSdt7buTv2NYKpjIcXraM2mVTkjQcgYwiJXdCzf9r7oz806ZsdfiTbjSDxHIRC18QSBgkVhKLJBdpVMCXFZzWueGj0QOjL3CJSJ9qUjzWha5/ZcOUe3gHdskkUbg2P1t9aZWdZBzvbn/d4v0xAJsdyEBtcaGFbX8xvfxiBWYcJT4uHT9qMgACdkHLGMeasWHOabtMJLuwpEG0jyP0fI6V05V6hUhCrxDZHqEnbQbcEAkQnaKS9dcHgwhcDuvkAzZQ+4rHxjDr9wn2NwuN0ShRS0gpxicriD+QF3AcobyLK1Nj/r2QSEfu/kB5fCSW2gioWtDLJjADG6QFyKDk+xWecNRjHASzit+VSNAKDs/iBmTGx06GL5f2nFyl596bGhIXf3O8ogREt5gdNu4TKShk1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 16:12:57.3117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a25e0-f542-49c1-64ad-08decaf8f6cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

For gfx9, queue reset is supported on gfx 9.4.3 and above.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 7688156d476a..4249d6f3a59b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2013,7 +2013,8 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
 
-		if (!amdgpu_sriov_vf(dev->gpu->adev))
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 4, 3) &&
+		    !amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
 	} else {
-- 
2.43.0

