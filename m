Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7BC32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 21:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B67810E841;
	Wed, 18 Jan 2023 21:14:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B2C10E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 21:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy7YUrkavE0WLAkq/4SWF5TTjAteklu9B1O4MFedPKDQPU0Aq0L2xFD/8N5rS2CL/v/EdMV3MWuSocSIbhMReazNQ9Bx7Ssh6ReZktqShJi4P5VRqwV2C9jsh6sIud/iArCB5/fi4h49rTK01sb5q0fR1lF4t42oKJvUYZ0tD1iVpGMex+24RuqrLN3H2W6hdWxld9Q3HPQImNEVre8yV6eQdWOYnJJGWEq0vuadtV2T+AE4U/0DY5p34+rnhCdpYUjgbLALuLQnc+9iaGBWq3byST0iuuPEmgbAyqSfrnqmm8xGm4m7FkgAVfItkNhLcPxCtYZy5nkR/0CPxJLq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Y2OdihfOsqLfMI2SRSyvgBbNf0lDzIrLkvbaZ78Q4=;
 b=nHhwby34UKcDy1ek79LaUoKJM3hTkwwSKkEjyOmTa5u1s7vGiVvGizqltIstlYiga5tmkKZy4JOGxbk+hW7aXyEg5cIS+A2MfTBiglhebE/kgEsczLMmg+YT1ce57wpKbE1M37+clo8xElZu4v5wFUWw3Y8QyCQe8iEJlDubRw5Rx3vodznWZQBOFBBNLTMJeiD5RdHAixAT/KuV9uX0vBzSkYcDYNVMUhSCZE49zyMUfSgD+u7JubXO6/eHJ1MQe4iTXSAJ7vpYI7B2SH+cGmCos+xem9xfE7pL7fMDte5nLTyXgexq4uzc2BS7WtybLiqze//RmVIENJ1Fsp+A3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Y2OdihfOsqLfMI2SRSyvgBbNf0lDzIrLkvbaZ78Q4=;
 b=KbxHkxglpffoTZWgNFSuAWtQQv2z4pLWPqT5cl9eaVIPtMRQbaV4kXvgpkIGPCVzrWqHtqMpdn/ut3RQOFYcRoNTay8FXY6VTEpp3WK0OtwEgoqWVdFX73MeRraZzMGmSfdHRXclyf1IUY0UcOTN94CK0HJax34XptKQ5vL890w=
Received: from BN9PR03CA0809.namprd03.prod.outlook.com (2603:10b6:408:13f::34)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:14:32 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::30) by BN9PR03CA0809.outlook.office365.com
 (2603:10b6:408:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 21:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Wed, 18 Jan 2023 21:14:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 15:14:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Documentation/gpu: update dGPU asic info table
Date: Wed, 18 Jan 2023 16:14:14 -0500
Message-ID: <20230118211414.2662045-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d080ac-fc22-4ee4-e77e-08daf998fe6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/zuFYoTOOR5DqfZ7681JPUG4KR5DxYkWtATbUsYRaGh6gAjdueX9eNQj6vmPM2rSWtF5I8tpLzHabudn9B3f3lLOkcgqWHNACIBE6Q6ae6XdkESOusfNH+gEWwiMbZp7LoGmeEJxUOObUb83g0IGL6QjZ5WBLnGstJ5fODDxGYEoZ45dIJvumpJxh22wVFVNWNoUDy9SdEwo1/LzTZ4E8JWRbcDykROmNqcII5W68Gwr5OPKVE9vlEpM9C4JlBWDGVflv47fG2Zuawp/EgH3eXujPg7QymjRljI336hzonE7afp7P0YuqWf1DvRqyxfBlFGZoIxRnoF2jy58D4FZGzA6TGKDx5K2DbAWpvdZbYaYBdpJ9XLYKaDjqGegDkqmXokZT/ORWAMtgaEXdl6SuFu+czu464dsW6G7r/vb2Rl6h7GDI4dzSi5YOQYi8XBDBTba93jBhrHH0kCUOVtwySuv1rQN1bknt7fBLwVPQItxeGwF9X/I/4gQI3jX4tnYZd8g0CORHGqzn+yPnRCuztbnW53wOvvsip8TRaLIPU4mLW6zFyovB1AmYUKVXv7eQrIKSktTytpzxmE0SJzBU/6SRy/Q6nWSuR/tegIpHqSCu52dxJ5Jejoxwwr6DV9ALUbuYpmfoTtR7eZwA3flr7S3v3OGJObBE9zC5rRLPH0ZvQU93SVg/PMX0n3khhD/3VhvWq5wt5co74M/YCY409S9WzGv+0kYdBYWm70BZwiw8VBK4PGCDSJiX92tYZDNT7TdhgOxUWISvpXCXvJ5QTJfu+CVrCicDNxxqWCLRQyqeAGzm7TQcWvKjxJIIGG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(356005)(86362001)(70206006)(15650500001)(70586007)(5660300002)(2906002)(8936002)(82740400003)(81166007)(36860700001)(316002)(7696005)(6666004)(47076005)(426003)(966005)(478600001)(36756003)(6916009)(82310400005)(8676002)(4326008)(40480700001)(41300700001)(336012)(1076003)(186003)(16526019)(83380400001)(2616005)(40460700003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:14:32.4641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d080ac-fc22-4ee4-e77e-08daf998fe6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update to the latest launched dGPUs.

Link: https://www.amd.com/en/graphics/radeon-rx-graphics
Link: https://www.amd.com/en/graphics/amd-radeon-rx-laptops
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu/dgpu-asic-info-table.csv | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
index 84617aa35dab..882d2518f8ed 100644
--- a/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
+++ b/Documentation/gpu/amdgpu/dgpu-asic-info-table.csv
@@ -22,3 +22,5 @@ AMD Radeon RX 6800(XT) /6900(XT) /W6800, SIENNA_CICHLID, DCN 3.0.0, 10.3.0, VCN
 AMD Radeon RX 6700 XT / 6800M / 6700M, NAVY_FLOUNDER, DCN 3.0.0, 10.3.2, VCN 3.0.0, 5.2.2
 AMD Radeon RX 6600(XT) /6600M /W6600 /W6600M, DIMGREY_CAVEFISH, DCN 3.0.2, 10.3.4, VCN 3.0.16, 5.2.4
 AMD Radeon RX 6500M /6300M /W6500M /W6300M, BEIGE_GOBY, DCN 3.0.3, 10.3.5, VCN 3.0.33, 5.2.5
+AMD Radeon RX 7900 XT /XTX, , DCN 3.2.0, 11.0.0, VCN 4.0.0, 6.0.0
+AMD Radeon RX 7600M (XT) /7700S /7600S, , DCN 3.2.1, 11.0.2, VCN 4.0.4, 6.0.2
-- 
2.39.0

