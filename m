Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23619C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F832AE20;
	Thu, 11 Aug 2022 12:53:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BAC99DD35
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 12:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RohdYXYfT41WL/coCMKhM7dCLB90mF/vURl112letOawBXHQwMNJhBsmWyZW15YH1ICuFfZQ2utL9Uw9+mUnZWNvKElqJAFK3HmukIB/WCJAVIki8iOM3abWsVjCS8NuOUt+/v6qy2OQ7XUP8h23B0Q+eFlcxXVS9Gxwfb90i2dee5VeV1qMZCbjs6E1Hh/mtaIqECQL71jd/QsFPLhD4oq0d+ZAmUpGTV7LK4vRS06qzBhVs8HIqOIb/57vY0xzfQa2sGxaYP5e9pUnBNDEuYC3RCUOTHQsMK2HkbIg4HrCQWrzwvKuR7UzcyZHQApVf1mm0EnGS3nNtLPy+sS/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViWMFFKs8TGhcaIDHUiCaxBxytnBchA/uyABtGTJ89E=;
 b=M1Uk2OtUuXRvzQJxytdL8djQMzAryaN8cOIo69N9Rr7wr/lbZFiuLMO0WUaG8fxeyULJ8LMl6gaEko8SW+sk7PwEc3x4hPUUkikn7eAuHDM7XACGYiSSZvCn2ivQVcfnD7RQdopGOcWQQ3Rr3FRgSwL27d++lv0WnA7Rhr8JeZtP9G7fAWYiSn8nB68TdZLOCbBvw/AQ4n4ld72Wdt/aPxK0oEiByJ88CoU+yUdZeOJp8ROiMZyptx6le2971B7UVq4sfwLtDqm+ILsCL211nmew33LWP2YdNFFGVDbXvdAzKo/Y/tZs1LKVella7YNBIeiPvhzZdMn3+v6BkxdpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViWMFFKs8TGhcaIDHUiCaxBxytnBchA/uyABtGTJ89E=;
 b=vQwrps04zL3LI+dKO9Qmx6M9YIalvzHOgJXvxHpHBoDcsvV9rcfUmNmjKdPMmaMd/txNDsAM7X0Pt1I1lOAujQaritLq0X6Aqx8hT2mwiUwv/KdVpeRDG5dZajBqx3JeAdHMMIP4dGSqPTIjqEaQcEw3F/8EWqxncyJYPyPt5TM=
Received: from BN9PR03CA0351.namprd03.prod.outlook.com (2603:10b6:408:f6::26)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.24; Thu, 11 Aug 2022 12:53:10 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::ec) by BN9PR03CA0351.outlook.office365.com
 (2603:10b6:408:f6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Thu, 11 Aug 2022 12:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:53:09 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:53:07 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Date: Thu, 11 Aug 2022 20:45:37 +0800
Message-ID: <20220811124537.3958516-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d959d434-0613-4fc6-f7d4-08da7b987178
X-MS-TrafficTypeDiagnostic: DM4PR12MB6615:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzj8b8A2t91zm1m7QesKbR7xC0jgU1R8pl0Cxxnovhf2AwkYoDXylLEQJwdnBY0mZdCNJD3I9wcK23+MuNyhpmoZ7CAdEM3LqTT1+FcqbbC9DgdXxpmjgZvNGPhs4xw9pyYnR2guAIF2eDhBhaSgoAhsGU0rYORCDUTzHftC9fYZ7QUBWOK6YdpL+ptIFab+OZkBvI8QJd+v0BcmNZayAZvY7wVm5OyOEEudh5VdqsGtXOx461z46W6lA9YWCYaaZhrRtDYLLl+8F3NhdPQtcwuyL19OyMpMKSaru7RdQL/IgwVKcBeA5pegRFdFL6R1+caxINW0h8KbWTvC6fZwtp+V0NC+gPkYceTFoPOSnA/h77v3o8W4leYu4SW1mDwOh/SmBi30cLs62sPzkGK9/PW/+TB7pHAfH2lYuLQIwqjgIZjLQ8b4lHgCagyUROVFVUESMLEa2snHyNRS9lILDu7szdIuqxlEApYVa9Cs4eWYeeazaJLffhiRPkxwSR4BBrg11nvMEEuKKgj1wRN65nLjZwjQOe9x4ilcjHTsJy9RIkb62z2s824ahpz8aDPiAvE4ruIbLTITAlU/MqB3gPHY87wjGBk84EomQjCtaMNenb/ngMuQMI8fi6WVRsIiZtDd1NTGtigfc/XI9veeufo3SnWIy92ePIUOZ0s+sM4pxcrRuQGYk/VEKICG0JkIwuMk97RbhjATw4OHUBKKzyg9yBsbTV6ohNxOVodryhZrPXI8eYyEteGct6t7ao7QRqz/1pUVOJblRhXob9gpNEL+hHmEcGOFddCdjgwmageJurp9vmNVs2WStfyr/xPTgKied//3s2rmkXl5XG7Blw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(82310400005)(36860700001)(54906003)(6916009)(316002)(36756003)(40480700001)(26005)(2906002)(7696005)(41300700001)(6666004)(47076005)(426003)(336012)(5660300002)(4326008)(8676002)(8936002)(70206006)(70586007)(2616005)(478600001)(40460700003)(1076003)(86362001)(16526019)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:53:09.4563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d959d434-0613-4fc6-f7d4-08da7b987178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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
Cc: Alexander.Deucher@amd.com, Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is only one engine in sdma 6.0.1, the total number of
reserved queues should be 2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f5853835f03a..357298e69495 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -102,13 +102,18 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
 		kfd->device_info.reserved_sdma_queues_bitmap = 0xFULL;
 		break;
+	case IP_VERSION(6, 0, 1):
+		/* Reserve 1 for paging and 1 for gfx */
+		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
+		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-0 queue-1; ... */
+		kfd->device_info.reserved_sdma_queues_bitmap = 0x3ULL;
+		break;
 	default:
 		break;
 	}
-- 
2.37.1

