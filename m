Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156F9C48297
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Feb 2024 01:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0514110EF07;
	Sat, 10 Feb 2024 01:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddh4YLaK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F052710EF07
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Feb 2024 01:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8dRcK9LdpVJHfMdUlsX6eiv7GyXQpuX8JVKPPxGEWBdcSKUMYpgX5ZHnfzQ9nGjJ9TDLVhrkIk5g0LdmQl5RP8xZZh3RNe5z6ngxTtszEWo0TKQZY//PULdEGEjh/8fulrkhF4f1fePB/p1sAx1a2oxzO15xgP0EvedpQJG6jrceZMFgtpTDfTSn8GSbSMvOrQjbuD2OBmq8KB/sd82sL0PE6pz4BQuDnViPBWbYyA6SYzEYZVUHWW7yTaKg4VGBK17MApMcpGXqAnje+aSNZcLZniFtJD9mnJkRmJ+XqXmBGEPKoJJjH0SYa/N5gwjaI7NF/6MNg0byAgOeJzEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rff6KlHu9Liv2drVJI1l2duMwTyax+ezht3mLsV6VeY=;
 b=i6j52o6zcTDYqYXOUjnbYQJBqrV+I3c6nCtqKjFSK4Hp/XecZmS6pAsYu3GYjO7NhOifVCu/TcBZJi4EWuzA2B/PYR18kmLwJmDdSTTwfgHlHBUYdFtxG+aKZ6GI2/pj7jzRYiInF0LibpKCyWRaE4wkKANopXoBT94mme4kd/GsYi5/fEbgLjIMJFPLNBTkWMQ31kMBiqWCsqE251POb7ue4XoRKeAH+I5NxhMbHtYSHVIcQ7//4FMb63dH4x1/IgG4ee3GxNND+tdVRLoPx7X+4TskAv/Tr9BEj+gKFUi99tCOuo4ESV97gVnI7ewjQptE2VmvbTNg3Y2PAhXZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rff6KlHu9Liv2drVJI1l2duMwTyax+ezht3mLsV6VeY=;
 b=ddh4YLaKXN/4pqquhR1WGoG9vUekBuzHGlwt/ysKsm+fF82wb4bHcJRxfo5vJV9argeskYv0tfLd8TvdhBn7kS22QXmbWryIU/P/X/fLv1TH8otLQaYQzGPv4GtxFlZna+MZFpDDaKgFoht/cv6TFr16r5NTd3mH1Umb7X33gKA=
Received: from CH5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:1f1::7)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Sat, 10 Feb
 2024 01:50:09 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::3c) by CH5PR03CA0006.outlook.office365.com
 (2603:10b6:610:1f1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24 via Frontend
 Transport; Sat, 10 Feb 2024 01:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 01:50:09 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 19:50:04 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix implicit assumtion in gfx11 debug flags
Date: Fri, 9 Feb 2024 20:49:51 -0500
Message-ID: <20240210014951.73159-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
References: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: a3177a78-473a-4dda-756f-08dc29da9cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+Sf2K0ZKpniChpg9lAe7RUgOO0EIXKSxRMT9QB5p9leHTzymD8SnILZEQq0IaGon2zn2qc+Xx0fMbi1JKKW6t8AGfLf5Aj2QTOjmfBT7ZTEWWiLPQCSIzHjTTYhWvf6CigXs0lO6rIKA2hgRAp7yi25QdFNZ2Sspn8iL7qb2EiqLChPIX/7vGaMc1uQBKbiySlyjTf+BLs4LWHXTvZPHQLql/VbguvUirAkY+Gns7vNKqUFu8NAykvcWtvG3z0tiLO2ATeh/22LC5Y79kUepPxrLTHaMDc9LEDfWuxUNtdJb6nd1SicVzpvdl+7LuKYKOSI2r3S3qCXAC+owdgfaW6xcM5iWyM9Ju4n0cehm49l2IwWTO2OgGLPxT1YSnRTcn2W3dsgLFqtoXUAmXyo56s4DgD+c6vHzhD6ydfy8iIWTxMN9CbXRszmF/MdNEXO8pYMpK5r9NBAWtL3Cd2RcJvADZGmwej99Ao2BN/PJ8hE2AeL/SI3S2pkqJg04F7tdsKj3lyvz/OHtA6MZgN1UW39479Bo/OGhRI8BPprJk7uC+gO8WCuA81n8EZt08tjIKeYI81C1GcynMAVeru3ryInL4OdUSX3geBV+Psfl5s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(81166007)(336012)(83380400001)(82740400003)(26005)(70586007)(2616005)(44832011)(7696005)(316002)(54906003)(4326008)(8936002)(6666004)(478600001)(1076003)(8676002)(86362001)(36756003)(426003)(5660300002)(41300700001)(16526019)(70206006)(356005)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 01:50:09.0314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3177a78-473a-4dda-756f-08dc29da9cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

Gfx11 debug flags mask is currently set with an implicit assumption that
no other mqd update flags exist. This needs to be fixed with newly
introduced flag UPDATE_FLAG_IS_GWS by the previous patch.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index d722cbd31783..826bc4f6c8a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -55,8 +55,8 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 	m = get_mqd(mqd);
 
 	if (has_wa_flag) {
-		uint32_t wa_mask = minfo->update_flag == UPDATE_FLAG_DBG_WA_ENABLE ?
-						0xffff : 0xffffffff;
+		uint32_t wa_mask =
+			(minfo->update_flag & UPDATE_FLAG_DBG_WA_ENABLE) ? 0xffff : 0xffffffff;
 
 		m->compute_static_thread_mgmt_se0 = wa_mask;
 		m->compute_static_thread_mgmt_se1 = wa_mask;
-- 
2.34.1

