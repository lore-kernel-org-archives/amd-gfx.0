Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E8BC001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997CD10E9C8;
	Fri,  3 Nov 2023 13:12:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B1A10E9C1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ielTJfXIcPTA8TQ+MjQsMcRocWyIOKXxeRFbSFtN5JwzsnXJslL+Tf0gIQkf5D7v/KjQL5X9O3wgYly+yw7rmbv4EmbPJeNlqvy6Rd8NI5uPjJAQvB2aGIi2ouI60g1OxIc4yKwBBjevp0qwntEWnLZdy1JcB1EwRm5ri17KLENHcaebHVQWt29xk3tuVHhafYMPvEYULjYP5Eh1IVsmyC9CyUDsYHJOMMcZ6+89TxmMv6bI2gkUhNwS3IYYL6dC35ZJxYXCGeRJqCJxvLgdAHz3neD96lbOqXGSXBWI6whIUyv1SRKouy7tqm49DqIezfkuXsmnHd6/C6DiYfFjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PCZL85f9oFiTXODXrn22X/o/Ls7BFNzeFuMbaroHYE=;
 b=Fu5Rw0EWf8BfufavHexzb2tmA8Kbzyn8BB2ObrXwC/pYUquBEoORayP9omtLZ8AbmHab3IHeJFO/HSAgd0Se56yxMHwJNzEcKB05llD6207qup24aI3t7jDyIWgnj5bwFaHTTU0QqcgoVZbM/RC4x4v0hStuRfTmS46rOQq3kx4aawgTVhXGsYEXyu62SPEZOc0nVxaQ8AdAXkgGFsJWNpS0DBEvA59DffzZ6JedJ5trDooP/EDTA7VBYbXhxpxx8PBZ0dOBpJlh1I74sqUozlyujGtOsmJj+OCh85uectgZ6uKaHAOiC3nXruDgfdHKeWaXSyT2AiqHzCZ96Mb+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PCZL85f9oFiTXODXrn22X/o/Ls7BFNzeFuMbaroHYE=;
 b=mF39K+O9sWq2rg5wds0OPUId485pzNhgTrF/F9m2RyU4ZBTRkazyCmuSr6nLSbiHjgXIo0n9Nty5ev62rcbMsJ5Ftc7JQv+SF3KqUb7zm9dqZEtMgeWXZgNL3XunySEc+iWEY/XwJNuripjjZl5eKQhUGlGUV1NKlxtaSIHI1UE=
Received: from DS7PR03CA0104.namprd03.prod.outlook.com (2603:10b6:5:3b7::19)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:03 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::9b) by DS7PR03CA0104.outlook.office365.com
 (2603:10b6:5:3b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:02 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:00 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/24] drm/amdkfd: check pcs_enrty valid
Date: Fri, 3 Nov 2023 09:11:22 -0400
Message-ID: <20231103131139.766920-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: e5915ae8-e06c-4a88-c3bc-08dbdc6e7873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41xJuL/s7VkL7qTddFoOZFq9BFuiFnjQlHSGTLA5pg58HZuiqcYZS0Jmmyty+sbBwAvyuM+5ZkhUX/irTsfAS0JcyJugVsw0Qn5D9NVVlNks+er1zXQtNGwoKOXPkDACMeJPFb3W4Yyiq3+VZmC13p/DSmw8LqXzgvHbuyYD+Co8/wNsLFVXMonb4lBIGOvc1LQO5ApIM+6LABfxqBk2bxcmzSGhil3agvKo7Ls4wlKocqzs02IoXOJFL1ltGUdW2Ktde83qxFVTk0RKGxx30uejB5t9BMTOInUiate2srBf+BETXVOYls9u3d0ubSF9mHJ4uIYTqo+7cBVa5izPpDOHhwmRf5ThXnKTQMJrU4OJZzOE1JLqaBmqe5tBTkfPO5X0hw8zaIQVLkduKOLXtWJhP+xDVVh0G39lH1h6a8XAtRD5O9v3E+08iWjCn8qZ+cFOspq1cwfPPQdbyUuPzY4cu79polczWHmL9f/E6fKqtJ2oW4gV9x+9OXITxNVoOFt1jpwpOE1Erc4A0geQIxeL12L2P3CjK3TczOj8ox6GXah0hEgDZcZR9vReIJl6olmrJjB84y88gjhawoU7KZuFquQVXtFzBExZ9On08RUxE2fEc2HcBsXFCEgcsaj6mhkUcNqTrSKL7c7fUJvS1OKfCaWXWtXOv84We4eyAMxRPbj7axU1dtLTqrirq81xA0aW2rqF27AkXS1/oP6GUVTkRioAK4mqLdpqunZUaF4IOB9ZD3DpC6XfFYVhD7t50e5Fe57rFvJEOnaVpjPTkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(36756003)(86362001)(40480700001)(2906002)(2616005)(478600001)(41300700001)(82740400003)(4326008)(8936002)(8676002)(6666004)(7696005)(426003)(336012)(26005)(47076005)(1076003)(16526019)(40460700003)(54906003)(6916009)(36860700001)(5660300002)(70206006)(316002)(70586007)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:02.6391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5915ae8-e06c-4a88-c3bc-08dbdc6e7873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check pcs_enrty valid for pc sampling ioctl.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 30 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 4c9fc48e1a6a..36366c8847de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -179,6 +179,21 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
+	struct pc_sampling_entry *pcs_entry;
+
+	if (args->op != KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES &&
+		args->op != KFD_IOCTL_PCS_OP_CREATE) {
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pcs_entry = idr_find(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				args->trace_id);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+		if (!pcs_entry ||
+			pcs_entry->pdd != pdd)
+			return -EINVAL;
+	}
+
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
 		return kfd_pc_sample_query_cap(pdd, args);
@@ -187,13 +202,22 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		return kfd_pc_sample_create(pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
-		return kfd_pc_sample_destroy(pdd, args->trace_id);
+		if (pcs_entry->enabled)
+			return -EBUSY;
+		else
+			return kfd_pc_sample_destroy(pdd, args->trace_id);
 
 	case KFD_IOCTL_PCS_OP_START:
-		return kfd_pc_sample_start(pdd);
+		if (pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_start(pdd);
 
 	case KFD_IOCTL_PCS_OP_STOP:
-		return kfd_pc_sample_stop(pdd);
+		if (!pcs_entry->enabled)
+			return -EALREADY;
+		else
+			return kfd_pc_sample_stop(pdd);
 	}
 
 	return -EINVAL;
-- 
2.25.1

