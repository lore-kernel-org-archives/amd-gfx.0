Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4585C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3459E10E91B;
	Thu, 15 Feb 2024 20:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M7dY0XXA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEEA10E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi8W/RnvSddBLjCknrTsckH/z4Eliuf8VDUjGxRKib7qmitpHhKeKZlXOc05wqBNd/9ZRxYeVwdiwVOK4QHHjKHQgcsby7uoI15BOblWTuL7s/uORes5/CptubKlbLZC3PcClSVnnd7RWqXlBh/hV0I8BTeEDI0XVuK5376JcPScCGFBd0V9ujWBiOnRZT7DtnJHPjFPLT2A6Oo9tiy1oGFdnmXhk1e3yUXTuH2C/EVfUC2ukX/B0uPViUu+2bqOGTziYyuFefgy9eg9AJwh9VdCTGB201/rFLKIr+kkvo25F/fDUwEAxyDNbSR0jwHuNfZHLDQPmj69f010EyRMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGgNS7F6FvqAg8MQiTJNMUkr6AEETuJ74HEBDzyxmHs=;
 b=D634KZaDkLVSBCbXglgcTODWpffw3JXumWtOyZ+ToGSRwaMJey251ijjqSnxrMQfbeMzMDionMtoH/F0/cDcGtYaVtzPuz5T0jGyceePKCJISXUUEReiYQKkw/pUHtCI4tKhc46UwBouy0e5L3MptK7qsPbGTCzUvrmmCia009+ZuFL5tTnPoVHnlrnqEOdTtkRoikdaKtdG1dsuTa2+9uycmHCJCRFT/hJ7pK29U15aFAKmHVnMp8Ix+t3BL52Vk0/P0iK0iOz9MoAnoUUxTsjztdM+YFkfkTzFAL+sMFl09X66pe/wEDthHQhL5q7s++ENrL/K0b9mqTnDgVX1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGgNS7F6FvqAg8MQiTJNMUkr6AEETuJ74HEBDzyxmHs=;
 b=M7dY0XXAtdgM9K2+EGTTG7egM1otob0cnD8jW5GKchwB48EXoCLbAaCkY9qDyWPao2tqparZgQ/DQF9RLbT6aI9l+rCQTfpVgNNQZKYLhMducriXN7ZuuEsHfv+12RGlOmpHGzoVu3sH5c4dtsSCRxjQVWZpK3a2/9A04FY/Fxc=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 20:40:24 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::4f) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41 via Frontend
 Transport; Thu, 15 Feb 2024 20:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:40:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:40:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: enable MES discovery for GC 11.5.1
Date: Thu, 15 Feb 2024 15:39:55 -0500
Message-ID: <20240215203955.415314-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215203955.415314-1-alexander.deucher@amd.com>
References: <20240215203955.415314-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e681f20-554a-4be3-12fd-08dc2e665608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgD0zacDNeQIxxz//e4+yxszakqXiI8B1l7jCg4z95WjEonQA82JwD/NDf2W9AMiqnOxuMQOgBTAMmeDp3fObDq8qy1P6bKHWJFN3pzTLxUSxdk1UvQ8RNbJON18GFemgPQJT4RvBkA7EE7+bmm0orxylJYOOWlLVBxramocRKWRc23I+gbRQQuwz7Uau6tC07AMtB2P/Z0VsDYmBShdM/3IOfsCvCL3aw+c6lakUwdeX/Clsbuu2AyubVRGtoyloEueaVClmVlcU7P/qHxBk2PvoEwoNXnI/BiojJcfSjypuGlYfqo512djnbUAaJGqT3Rb9vqIVFRgfc1WdPipQgIuShYl/6XdT2UkWuoSeya9Z7lbX40H4lba7JYEua7RMVRIrBh6EeaWEgnRYzcoVatbfo93J+PnqPH6zoaTKmpyY9qSTSvrw+8C3IuaPWzddbMxqgzMWWF7IJkUh69qiCFkwvLp4LYbC1T6XdKdJnxA29AoP7xsjbnlShlXNe2qwLD4aHl4xfMnTbwJ8+42AAmM256NjecWltz15PJBYiVpOTmVuPE+i5RVqCDL5wAvL4TBPpPrYXjIaWXiwX/Sg+qVHjjOR4RVyGvd7Eydik6l20/a3XgZEhljQMs7stoBvIOQTbPzu3fjflqAYK4f05Owoo9NhFk8zaLvIlTxtJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(36860700004)(64100799003)(40470700004)(46966006)(8676002)(4326008)(8936002)(5660300002)(4744005)(2906002)(26005)(426003)(83380400001)(2616005)(336012)(356005)(1076003)(82740400003)(86362001)(16526019)(36756003)(70206006)(81166007)(7696005)(316002)(6916009)(70586007)(54906003)(6666004)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:40:24.2960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e681f20-554a-4be3-12fd-08dc2e665608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to enable MES for GC 11.5.1

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 70aeb56bfd53..704b7820c47c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2185,6 +2185,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
-- 
2.42.0

