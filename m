Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C6C54798
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 03:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923FC10EA4D;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JdjH3G+Q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E80510EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 03:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObtD03sGYOz09AHmHZLmGxOe8lgKQdHH0pTIm3zkC2sk1ALhNflZzNE4W0QjETgbeQ9uioCScetDaZAG7IKlTcXTj8YJIAKqONiWeTQkkF94ZbML65dfDUwJxeBn0DYyYk71oj+0qEjV3y2Gzja1BFU1H11oIt3Y4vnya0W7z2fAzXKOBRw8aq/W5a3Cq5RjU9aV1PHvF2JNQJK9uMzdJnERlpJLLyP7H79teXN+ecMUpSb4j18Dnal5BCWDE443XyWd9bx6/JO9xXZPrf20oK/7oON1OvC84hhvbCc34kRxm8VqLmXm3ANjjuZfdmRJbO4M6r/GHgWzPi55ITm/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlGkiD2dLx8bJlM9sLJvgqYcFAf03oG0MrA29J85a7A=;
 b=GMSLDF3+5l61el7n4Nn6ZFms0v+bd6p7z2iWNr5HbKraTXJZGrn4YovzU6AHmQ10cdH7smRrcLhOIImy/nMYywWQH+Jw81AT9e04mPh6aSsa/ST8zal8lh6RmiIhfr9pHWe9ePPjqpwc8NQ1KX7U2ts9TN8iGXFotxzngrhGOyY/WsXjaxo+rDEqwc4eANLn2Xq0Jf9p4LUnZX5SkooWhIkv0sIxnRvm1W/T+m+mrXs/z+1UhadOSNT9roLVQ48FKfwSVXuU4X0qA40o2QZoByt89bqwl48wLNOWb8nWHwSYomibK82b2uh+2WcsNfvF6vyO5uC2PXTHz/TTQIcWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlGkiD2dLx8bJlM9sLJvgqYcFAf03oG0MrA29J85a7A=;
 b=JdjH3G+Q7FHsMv3kP6NSlSwGSdywROSN9DVQZgBwfu/qDdSEyecRnBWb436Qzcvg6WuZDiMUf1cfcOJjhFFX7G5V7NvcBgyp9VBieDlVUFKJV7rMF2htNSRKYaY/GwXPwRkB0RaLqI0H34kry52Xun4fylfJuGDCVbUF9k899DM=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 03:49:46 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::6c) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 03:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Fri, 23 Feb 2024 03:49:45 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 21:49:43 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>, <charpoag@amd.com>, <donald.cheung@amd.com>,
 <david.yatsin@amd.com>, <jatchaud@amd.com>
Subject: [PATCH] drm/amdkfd: Add partition id field to location_id
Date: Fri, 23 Feb 2024 09:19:26 +0530
Message-ID: <20240223034926.151031-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecb891b-051f-431f-3572-08dc34227a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HL+avTxd14DcJvZRsEAjq9FqyZFA7KgHGbI0GgONmVPdRT9/uhXlt8Iju8zcn48Bjz/cEsUqxVk6991lJK2jjVv7luWcNPiv49cEh/BBKK8xD1A8tERHEajVOWk0joXCIbPRtdQkpXOjoVbV4v5KlUEvrhgw2d1Uai7KaAHDMPQ8wdxbg8mOk0OgFuS6XvRRpTM5kkmMWIGCiXIWvgUiWiyiwCui1Jvn87fB3kj98lzDSerCj8fMrbqKE73zQkyTYN1rI1oxUXPbTPrOKhJOFJLNUq19qfzzs5JfxLclXcL4aXazCyMMyxRlvYjESePZJc5oE7Sy3azZwAfwzDx9yhHn3Q7aQAWbOQ2prSG8Oi9i1W62lXhC7TUXT73T3XNyRON1FT3XCEJVHP1l1hTR+tNPG9o/ef8ahYP+sLQda0AE0vCY0cXLLjpNYiGkj6hom/HeZYv0IAF8KoH3a4r2hNjO6MR1RR1Y6gz9GvpQUI8+gNJ3qhq3IRBzwrpdhEzbPslNw5luKZhnBLvIFqnz/4JNQ6t9i8oWLtK35snxn48oPg0BGROUZ+RVaqPA+3JH0tffaNoWn8bJJVOzTKQ9KQjlgHlmtbZwrPJihNYoUf8GN76sDCBBO/QD6uJom38mb6xIQAyMUosYbWoyyDOCH19fB0HEKBYLF5ewpbSJvXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 03:49:45.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb891b-051f-431f-3572-08dc34227a05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

On devices which have multi-partition nodes, keep partition id in
location_id[31:28].

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index aee2fcab241f..0da747d52975 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1997,8 +1997,9 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 			HSA_CAP_ASIC_REVISION_MASK);
 
 	dev->node_props.location_id = pci_dev_id(gpu->adev->pdev);
-	if (KFD_GC_VERSION(dev->gpu->kfd) == IP_VERSION(9, 4, 3))
-		dev->node_props.location_id |= dev->gpu->node_id;
+	/* On multi-partition nodes, node id = location_id[31:28] */
+	if (gpu->kfd->num_nodes > 1)
+		dev->node_props.location_id |= (dev->gpu->node_id << 28);
 
 	dev->node_props.domain = pci_domain_nr(gpu->adev->pdev->bus);
 	dev->node_props.max_engine_clk_fcompute =
-- 
2.25.1

