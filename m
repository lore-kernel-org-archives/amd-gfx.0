Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2891FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 14:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C2D10ECA9;
	Mon, 16 May 2022 14:43:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103E710F55C
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 14:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxMiLCFaB9qoqgV4+OHF/YKfQCQbJxt1LPbd2KpemGp3+Rpspm+zyLyzCRXG9sMY7pGOumKE/qYQAghIM2fRKbXH5xu1SmXR2VXyFB2fpO/uZVukwyfYVe1asSr5uO4RQ8F5EnR9iUDBZZ6eFH3WLg3wy828P97J/KZHwy/jtJCqGckzF7i6ZXXoFtXAhib4Z5eCkcHPBkFvcqNEOotpVrIctriHYV5L7tC6okNxbLSEOMuxuRq7XXDgXMz4sxio4ACXQ6yJNAMvof9WNS0GcFotwYoPtAn8RDnpCgeuKfRNzT6PszddybX80o3pvmNmp4xxyGSz7r15w9NKdAb/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koMWdu4vBXYi3xFuahFwbWA1RS3caDZNqU8Bmnnnl5w=;
 b=oE9xWN8CfgnAHJl37lwD1QaJM5fbFrBGbKKHb4AwcDoZGsl8ROIhVibnAHIYUzyXyyVd+XBC3O/TjC4tUOLExlfJkGPVazlOO+vmnuLO6cBJqI3ndRljYYudO146Pa+ZH5wWHPbtsZcP76PM8LXvA0Tmb7cr+jywZ4scU2XnYxkrLp2Th22ChQ4kspT//rd4Lnli0QjrEXXh0dKATHfJKTwtTwVLzznszr6YYfcFPLR/HFe80q9W4bEAMovXwa16vbHSPC3WqBJm7/jrYBT6ghbcgTEvCVAXQtzLEc24tTFt+dQbEINVOTGjnnq3tPlbPlvsJlD5mXXez5ofW1LVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koMWdu4vBXYi3xFuahFwbWA1RS3caDZNqU8Bmnnnl5w=;
 b=vc2Bz41bEIF8hSLfMfgzZdFweO5I4GjkJzOdufrKOW2uyHiAqjh8uOhrYM/mPhVnFhZhE3e30I+nER3h+ZD3Im708eMRJANe+K/3NwI1OZjfXprZYz+XuIdFfO0GgNp4kvAwMBu2xe1mmoquTvNMKrrmKlip+3y/eOWX5px38OE=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 14:43:41 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::2b) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.5 via Frontend
 Transport; Mon, 16 May 2022 14:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 14:43:41 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 09:43:40 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: simplify cpu hive assignment
Date: Mon, 16 May 2022 10:43:18 -0400
Message-ID: <20220516144318.2009474-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54bdcee-4e37-46a8-0a96-08da374a7892
X-MS-TrafficTypeDiagnostic: BL0PR12MB4884:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4884C07CC31167C15397C66285CF9@BL0PR12MB4884.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apX3nmosKElDhtVw6MODTpab2G3ifU0n6ZceIBQZH1ePmUjIvVYiqE9pk5JnTEMKUi0PY4r5NHZBPacPWmPkYxtHui9bA/zbNpZB1fbFD/5zsIrVTGLVWQRP+9yesyHQv0W9BEPgiJWRekLhiB+n2vBBLCYSH0cLwG0iLhxVNIsk+F6xz14jwOfuYn+v1rfzcIviocKbbkTxdUgbgsf9yKoBqTDp5n1SeOswwtthDZOl+Czj1Zwtbuk6kW5+A4qh4V66CcU5op14vvcc/votL22meJZpn6heu03ZV4y/ssm8r/A6PalB+qB8nsUJsKn1im2JcCU/W5t1Cun1kTkIfInSemBmzfsbJDX4g44Iaz2XdD+ES7VJakZZidN1XA/32H7uKWIgAVKNM8q6SWkMw/vufmr5q5dokLoO/onvTNOJPB/8OZm65dmFMZ2rMvPgavvxTClgC1U0YEoa7r3+l1CiJB0qgO6gPLXpDYO/3CBSp3JBB2d40t6aCkgu8VqZeYsTtKVz5N44bIy9XDz7lYGZY2p+gMW3DNodGLIfRfOOb73x+IerXx6BbHRYBxXr9H/aGbFEncyYsjhFravHyKpFpz2gr/hlrWFmL43yClA2W1f7NwF9/T48D+IE9tCXaU7bqO3711LBDHdfjQR5ioA7ZmxtRVwqnaRphtTztbAvwLodX2y7u5zMRd2MEf6KvVp8QRazmyTb6hhlrs1vSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(8936002)(54906003)(1076003)(8676002)(5660300002)(36756003)(26005)(47076005)(6916009)(2616005)(16526019)(186003)(316002)(70586007)(356005)(83380400001)(426003)(4326008)(86362001)(6666004)(36860700001)(44832011)(336012)(81166007)(82310400005)(7696005)(70206006)(508600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:43:41.5197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54bdcee-4e37-46a8-0a96-08da374a7892
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CPU hive assignment currently assumes when a GPU hive is connected_to_cpu,
there is only one hive in the system.

Only assign CPUs to the hive if they are explicitly directly connected to
the GPU hive to get rid of the need for this assumption.

It's more efficient to do this when querying IO links since other non-CRAT
info has to be filled in anyways.  Also, stop re-assigning the
same CPU to the same GPU hive if it has already been done before.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 2e20f54bb147..8d50d207cf66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1271,6 +1271,12 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 		if (!peer_dev)
 			continue;
 
+		/* Include the CPU peer in GPU hive if connected over xGMI. */
+		if (!peer_dev->gpu && !peer_dev->node_props.hive_id &&
+				dev->node_props.hive_id &&
+				dev->gpu->adev->gmc.xgmi.connected_to_cpu)
+			peer_dev->node_props.hive_id = dev->node_props.hive_id;
+
 		list_for_each_entry(inbound_link, &peer_dev->io_link_props,
 									list) {
 			if (inbound_link->node_to != link->node_from)
@@ -1302,22 +1308,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
-	/* Include the CPU in xGMI hive if xGMI connected by assigning it the hive ID. */
-	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
-		struct kfd_topology_device *top_dev;
-
-		down_read(&topology_lock);
-
-		list_for_each_entry(top_dev, &topology_device_list, list) {
-			if (top_dev->gpu)
-				break;
-
-			top_dev->node_props.hive_id = gpu->hive_id;
-		}
-
-		up_read(&topology_lock);
-	}
-
 	/* Check to see if this gpu device exists in the topology_device_list.
 	 * If so, assign the gpu to that device,
 	 * else create a Virtual CRAT for this gpu device and then parse that
-- 
2.25.1

