Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580BCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 03:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF9510E514;
	Tue, 22 Mar 2022 03:29:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E8A10E515
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 03:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxyiyw4NvJTAt3CKPC/4kpLx/plcqzrzlP7NWgmcgFdqxRFLIzf/anPbezw7Rfb4TmZCqkVvN3VnkH4VNvo9cGpZdaI1Q9TbXICjJX6eJF32uaha0pYDEoRzbOybbmwAVFOV8oUiIEdzK49M5amcjxCtYnNNwDTwGUH6fHOz7bBbNW8L5RKz04oZLj/WrgCtGMP3u4LCFaP33vYd8WlRgri38uMbFHAuuzH1HjRGuhSZShFNKmzLmYyAHHUG2eqxbBv1OETmgOearQoFGn2oblS4y3OSw4YuU7T9YTa6kISVM0wXdyOlIH4PlmkMpE0idpuZ0tCTrpIeMXmbS5ICLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9RCXC0Uukhbvw/f77NdTJQW0VVRz746AVGH7C4j3rs=;
 b=lECrEub+qlHakHYcH6kbpTjTSeabnTA6pbIFsCxfrFgW+Q7Hi9ZQIvAF5k/0Gy5XMGhEj44AEGFbDGh4VL45TkWJVkJKEdAchyBJVjQJpILzayNcGJmP7ytpZVMlzg+hNeD3Tq8ZJoLJV6vpgzumesbUbEByiukitUhbPYeTGB9JGDlNhCZWz4DsJLmtuGSPyJzIXGl8AWF8wYczH6ZMY+XKK8d1rWd1JEIcmVgDNUi2eFUOE7ofZK6PSBlX02ZGltPQMZYq7dqY3AMLYRvMzMFllx/zdPo/tUrQdODcWWZcjRAfqZMdYORkIikV062JVIts36WCglJBOoS/6J2pYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9RCXC0Uukhbvw/f77NdTJQW0VVRz746AVGH7C4j3rs=;
 b=MYPHzZeUhbJJJRSVBfTo6otMTLUzORuON28ylF+Z2JB5QRX8GSEjinusqLFfextELu6AXWwKfJmn6/cYoaqpQIEsrD3+AOkJ3Fo55iT7MU9uHTOzVXSnXMjzvdsK+tyCWRIcHlfuzdLSx6InNI9oebXO2kAZ1bO3Rg4q66nA8LE=
Received: from MWHPR22CA0039.namprd22.prod.outlook.com (2603:10b6:300:69::25)
 by BL0PR12MB4881.namprd12.prod.outlook.com (2603:10b6:208:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 03:29:30 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::55) by MWHPR22CA0039.outlook.office365.com
 (2603:10b6:300:69::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Tue, 22 Mar 2022 03:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 03:29:28 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 22:29:25 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>,
 <Lijo.Lazar@amd.com>, <pmenzel@molgen.mpg.de>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v3)
Date: Tue, 22 Mar 2022 11:29:16 +0800
Message-ID: <20220322032916.3074-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f0c060-efc6-4827-47ed-08da0bb42c3d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4881:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4881CCA93A3B88A21B7E0051B0179@BL0PR12MB4881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4JUaMYI5FF4HFZkwwI4jWjK2hpDjVJiguWZ+923jiuFK3OG2PYk02KrEMxoHDJuHHRyz1M8jU6dc/UHRuM9ZQDosiWw9hg51I9Teubh6g7WiV9hjgjtscOVJW4hOeQztGTocpRuEWqksnNPGdSdu8sCVY7IVrXAUPUdUPvW+Dnypq4GD7YB+c6gw1edpm4PV+kJ0Po4fjPyqNGgI8KoqEh4DifTWibgb2YKHAwb/Il1YB1HYmExudkkE2escFR6zDb91zQ9Gqx7G8TDOP9Ccxu/Fv+NE8RaMEtuBK9lFs93gVJXJpZibPpyp1XM3XfuXscorzPqEkzDM2qcTAZqIqD7gYcUhF+CCDGBLo+iUbEPqZ43Iw2UAtplXuyykr3VHoSrXB8N6CxHRjf9xwz5foYFWY/nkEIJlSb4Ur5gQT877Gh9bD4AhpxYafTvXpBIccu/Z/mB2YDNsjiSCaTwllmuFW+oVBgCzeConBirhdgMfro5dSDsiuqKmI3CfWStK6Xfo/FMOLezDeGgFxH/wGeOP0Nxavj1qijCbq5jJATXAwKHmk0d9Q361QyPqFf7/H6X3g1sTw18pGdfG4d6F9CPngPaxPmm4gTtrruZa9G8a6nJCYEzhh6oH9WrHZ9G/lduQEn6L+kD7hwpl/MXI3RQWfrdPdhaBfdylY3O2L2R55Srq1/BAHayHNW3mSLigU/EFMkNIkCUTCycqTQ6mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(2906002)(508600001)(110136005)(40460700003)(8676002)(70206006)(70586007)(4326008)(316002)(6666004)(7696005)(8936002)(81166007)(26005)(1076003)(2616005)(356005)(186003)(16526019)(47076005)(83380400001)(336012)(426003)(5660300002)(36756003)(82310400004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 03:29:28.8704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f0c060-efc6-4827-47ed-08da0bb42c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4881
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the status out when it passes, and also tell user gpu reset
is triggered when we fallback to legacy way.

v2: make the message more explicitly.
v3: change succeeds to succeeded.
    replace pr_warn with dev_info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..cc9ddc4b4cb8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	if (old_poison)
 		return;
 
-	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
-
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SE0SH:
 	case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,17 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret)
+	if (!ret) {
+		dev_info(dev->adev->dev,
+			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
+			client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
-	else
+	} else {
+		dev_info(dev->adev->dev,
+			"RAS poison consumption, fallback to gpu reset flow: client id %d\n",
+			client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+	}
 }
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
-- 
2.35.1

