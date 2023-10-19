Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27138CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 07:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C37F10E488;
	Thu, 19 Oct 2023 07:00:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB1310E488
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 07:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDDta42SFsVc5AnpnbyjVzxzmAgamo1e7+cxkMPHYVCT3jdQUaG7tz8He2Bby5F5bn2VpNAyDmkfyBadSfzShhxOVx2IxZdRgjKcSrzi0qx4hQuMxLOYDgI+Za6yddloR4/FyjutjUB+cKuWRXKRqhRPpoY0ZuyXhQQ3Ytv4kndRZmxECTB1pLBd9KhgJFK6WhCzAzs86lqt8GLiZYt63DgXXwjQ8HWk2TPc/u6W4KxpAj8RKvQjt0UBpUwqPIck8rv8ZRfdEzgABRIf0YYycDpNVuTyf92icIlAcDrAAUxUOjhOBPo8/XGb07Q+VriCk3JRYsNYseB9uYv5tzYWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5A7SLi1+2gMvihGGm46exhg7o78tDjZn5+z6yCINcI=;
 b=FOzMcTjOgIw6gAdCAOWUZM54CM/Hyqj8RxFqEIqSKyRVaB44TiR8cCrFUpGs2YtcemCe52lzK+FxZ/6IQ9vFIDVSjzcsHjLHaGjmKd6Re4DGAQNK7jgCuxGH6i+hCNnA33etO66NO9YdJPCEnN6aBOLdyhwbhJ70AwhVUppy3gB1XzggLm6n8iH5COEeludL6Kz9RdVgkvBseAp1vbhEaFKAjOTtN/bD5QEkCk0wflLIkGrJdSmchQM8BhO4jtGJFy8x6y23/2JakcwXtX9DIRmZsQZbdrv1RZnaE5YIQImfiJE2plyk4Q/kFNsfdUvI41IPjDy2etnEdRJ4juwAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5A7SLi1+2gMvihGGm46exhg7o78tDjZn5+z6yCINcI=;
 b=aPHJkJ0qpQmKuJjjM/EttRZiat7ushEb/DMnHzx83GKBxeOuB04spkfh6pcwQQ4PXXvqyyfjjXSsJiFl1I0g82Iuxt70eXOMnoxDjsVntlYmZwBQi95Txpnc3PQZKzaS4/xxeXly8si5c4bcF2PqLqygBKVM1oF0Z31QvY8NSEA=
Received: from BL0PR01CA0025.prod.exchangelabs.com (2603:10b6:208:71::38) by
 IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 07:00:01 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::ba) by BL0PR01CA0025.outlook.office365.com
 (2603:10b6:208:71::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 06:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 06:59:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 01:59:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 23:59:58 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 01:59:57 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix delete nodes that have been relesed
Date: Thu, 19 Oct 2023 14:59:48 +0800
Message-ID: <20231019065948.3312040-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaff8c9-9297-4afd-d584-08dbd0710215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdn/+2izK6eX8JImiubkmNSuIQn58XBzJecLoxC3cKjo8d3/fO8CcvQ/HdNkV3Aw1eaLpMD22AbZf0liC3Bzn790pZbFWF6kxFli80UewSjELg23kxW/5ua+PFNrdpoSCUSj8C4sQ6qlDJZKXvLF58pkKQhO2m8tdaMSWw3XCHHQ1unszMg+Ntxa8R9TAnmX5WLggyFO4w7Hua365G+JBqtJ0i11FPoA5De4SOQV5Elh31aY80DadrPQdwdVn4Ut6d2SbK/NqTfN8xSoZXotIoPAtD1sMTEqnaXgqapgmO5O6TcXfskxNBCcL3Kfxd5/Plam/lXvWCohrG96h6Qa0nMpQXcc8+Ko/owXPUrOzHvMgWBx6PX4eZRS6/dLdp+JeLfnpcR+e5JR1oxW27Vtqn8a5Vy7v4d1LFiGPFGJ0qeSqrjBGiMoADuMZykT5ZCVuGv7p03/tkUsjWLDeAxupfx/QCnGN8BBKcTn2/B087+jzoyvgIWTXAFqMmK4us3BQNn8uvy0LE/2qn6BPn8pV3yEv5b1v3XhkK5MameBzeV8ipo8N8nWp1NvUblp4pIq3EGRzzbZyJQC//0SZBtK5vgATIdmWHpA7YBQUiC34gZILfVVe+7ODuu5UHGtCV1dbKVhGLRc3/nE8Y3Zk6yte5d9DleH/fxETVRADr255+NZeYqsu+jup9McOx/MVQuu002pOpHnl2wpabYiFg5r91yHgQ7nqRsPBdyf1L4H1tBdqolIsHfhExJm6XfZhM4/kn6fSR55PrlSmCr4BCt92A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(4744005)(40480700001)(40460700003)(36756003)(2616005)(81166007)(6916009)(2906002)(86362001)(316002)(1076003)(70206006)(41300700001)(5660300002)(70586007)(8676002)(8936002)(478600001)(4326008)(7696005)(6666004)(336012)(426003)(356005)(82740400003)(26005)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:59:58.7611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaff8c9-9297-4afd-d584-08dbd0710215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix delete nodes that it has been freed.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8831859a2c49..867afbf84223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3499,10 +3499,8 @@ void amdgpu_ras_error_data_fini(struct ras_err_data *err_data)
 {
 	struct ras_err_node *err_node, *tmp;
 
-	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node) {
+	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node)
 		amdgpu_ras_error_node_release(err_node);
-		list_del(&err_node->node);
-	}
 }
 
 static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_err_data *err_data,
-- 
2.25.1

