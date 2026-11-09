Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A30606A334
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wP7dgNk+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF34210E1BB;
	Mon,  9 Nov 2026 18:47:03 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011011.outbound.protection.outlook.com
 [40.93.194.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EAB10E5CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS3ESy1NEysx5WMg0C3flW4dBFohqD0zwwH+7vHiCF8eC5FJcCbfR8r+lSlWyhiO4VFkctlkZSyTb2lC7BLBtydkXaQDjdeZ9m5LXuwDTKHs7xMVG1c71zM/IAYy9ePvlx0kb3qm/JkG18nTPMlGw0FdMUd+/f4UODvwyh6MvC7ROIp19zKIgzEAFMfUEMPcBGG3JrvHWKEqnoZlD4jcOHFE35UO6FzdaJEmki2oZpU5v2o/FiL0+JPMXPdj8AwW8qDhBhsWlKg1f+OaZat8iO+s+irRU4OyThyCQRjkwD88AtxI3rhjlTDJbElVE47GK5dHY7TzUml9T5WkAuP2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=353VzCD2nPpKP0Ra13Q4s7w+Ap8d3u+Z/QKrfEXX75E=;
 b=aiWUybsWwdyhR3LFXxcnDkeTnp/OE5gaUuWtscg2zTnmIIeEYrFLKJUHoEapxWudb/i5oNQS4sXJaQKI5NUd1C53w4ENUU7BqNRTdRiWb+T/cbDlY3tcmoZBPeFYY8jTMQE9cw5E7Wuc0DaJjMH59f7S71sAiG34+w8Tai4kAnN16DhaBLc6bobExSKTD6zypAOeAHOnZ5EG1DxX1dpHrv4YembMESbDokvnPBoLcKkQH+11tdZVSmc9Yiz3yEQ7pWoYg2abc3J/8jpeytYIfLcEOQxRuBaHZpxoqp9tHLlnP2JuthJlcaBzy6BtnkqS3iHY82SO/ZtmvpU9t8YcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353VzCD2nPpKP0Ra13Q4s7w+Ap8d3u+Z/QKrfEXX75E=;
 b=wP7dgNk+3pi3koKejgVlZ6Z3uJpg//+1kOzDo5BIbhafh95oswObFSWmjfU+FQmY3tBrc8nmLidPplCi0loiEZfAvroalRRcghJ+RV0pjkPYsGSkwx0fqrnfMMyGxBjoxkpE5lVZQEb95X54IFcb3+n+eLUuehtq+YzUGhLd4S4=
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 18:46:52 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::8b) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:46:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 18:46:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 6/8] drm/amdkfd: disable queue reset in topology for gfx13
Date: Mon, 9 Nov 2026 13:46:38 -0500
Message-ID: <20261109184641.3656885-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d388b3-8658-4225-11b1-08df3e91d1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|11063799006|261026121527099003|261009223027099003|261021121427099003|56012099006|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: a+eNGx2Aeph7RUl/86JFLsEi8jS9CocEvPi57j5bEXxbBzTyZZLSpidFGcfGmUwQBKrQaODdCi7RHUxVjMXdhkiKP0Xfj1p04F0/90gFe5FeAo97xWSybseLnG11MNCiAYG+R8X8+8Vj0T0Ucsg6OCvtmsXlob7BBMsFexmfUZ7jxt5U2ZLUyDM6OG7EjJIZHrXGE2bhtrxXgj1k9NPKkeLMfvSdnDR1Zfq10RqVRUV3vH24LWeHSlixeE4CWz62DTU4xB17bxPvcKYKCCJ+bhdBAZcHNzVFxZHXr8TY7hoBhMA1opDPpl5+ikXWOKTStDq6aOxYT8H2j5NlzHbDCklFCrd/aGD8P+mxJOw9h1BL887Nc0hsjqarEYqNNJUJsgHoMliP6hb3ID638kIBQcIJYlUKwQB/t3ji4e4NA4fDO9obCZ1Na4U+ORscwCBMHeZvOABLVZSy4XMytp8BOqmJB9flsu1m3I0g7S28BbaqtegVBHrjXIDw/QG1DzbXHCZxQxBjMl5qOBb0gDyoMGOkTxHdt4oj2QTb1FeqeaSyoqEmRrfC7JIX+R3sz0K7rnEPQU/d3UN3pk4gqgGwxcdOyk0P/mVtMURoH3uEzHWBuZ/bPO7X1O9LdqP3jjKI0Lii4L41OP181F6bGIPJ+iA2GISoL9efSxttVOkKgQkjRSYYVbxgxGsJpq4sT6rJHs/h6KLwkl7sjVK07l3NeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261026121527099003)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OCJ4cXTgniWRpZbau0EJAFmYCyW0pHanDWkaJ+RlZvmXtqiTbjzwgUGNEEhyDI4EH9pvnth1VBmwyBKdzfVXcs8WjRNlFOfuKNA/tkg10PxquaCSj2RW19aOILX5ZF2LGMYvQ4A+ZWm+MiAPxMa3epBSLBeplGLLwpBdXbCQezJ+JPtTcRcFBPD5kWmhlG87zuKI1ybGEHcm19srolBgjl3r6yCakNtYONAKZc6lH9tMUBOn3Or24TiE2BAZGOtRlYwME9leiYup2nGC5IjZ5B/txX32muxNbQu1+UWyBEbEAy8q7m2qpXdYiRu7se9YhxK0CTzpEQH80adSKVUXyHXbMd2FEZ/oYs541tYwY2P44bnjdrj+3Bj/KhBvN0ScCTZBEE66ZsAYc8SeVjT5iBq6tnA0T04KUqtrnvAViBTxnEFYSCOvx+c7bdtUPWoJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:51.9361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d388b3-8658-4225-11b1-08df3e91d1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Huang <jinhuieric.huang@amd.com>

MES doesn't support queue reset so far for gfx13.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index af0c161c520dd..faa7d26a2474c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2038,10 +2038,13 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0)) {
 			dev->node_props.capability |=
 				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
-			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 			dev->node_props.capability2 |=
 				HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED;
 		}
+
+		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(12, 1, 0) &&
+		    KFD_GC_VERSION(dev->gpu) < IP_VERSION(13, 0, 0))
+			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 	}
 
 	kfd_topology_set_dbg_firmware_support(dev);
-- 
2.56.0

