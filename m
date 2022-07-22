Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0CC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 04:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9611C14B85A;
	Fri, 22 Jul 2022 04:57:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A48B14B691
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 04:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIEDf6pbN+8ZTICBfRort+6jyH8bug44iaexlQSkpuzCku77eLCJdYiU3Lhv4plIvc87FogWiikrFqgaG6S4sK+yNQD9q6v4mPPXJQLCIl2qhc78T1eeWIfgXEpy9qs/d8K124KLNCjg6o9yJ5cU/Qc3SyAaPFZlF9KCHgrRinNbG/T4CqsLPad+UnsspdXO+iko1CyRC/iA8n9owwGM6LzOjow+ckkyc8wE9zUpFijohN/xAUZs1qnFvKTdMYft1yXj8b72BB2+lJVEK7TsVrj91VYPlH4VlzlKwfLxa323nza3NVW++3Fh5BK95AEYQiOucIpXmxZh7kiBRKh8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT9CTsYcXGnGUGX+i2PeAGy5pvJw+io6qcbSQ1q2jj0=;
 b=OKywEp8drp4cnydg6QE4DrNP6D+H7b6hUuXiwAGlEFqWZTF/f/wkZ78n27iohYWhxS1ugaeJ25pXZhqHWnlOA7ohuZ31JQBgceYK2O4IaRLAsU6O7QJoHezvsY6vgosvmCyi3ZEmKRb3veCuBo8A6EJ9Robm4Z7iPL0I6LrtyyVqhy/V0BTkL02MKEYc2vh1XYAGSqRgaLBVv7V/VugW9NsSonE0GOMN+sK7UIw/JwMpjuc4kvM2kAF9XA1lZJFuNe+Qc3Lei7Q1y5arsfDIsFLZHpYmOKNJXoj/l4cnHeAq+DqyUR83xeHO20Vz7qegnKH0mGHaanatu5zdzg6m8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT9CTsYcXGnGUGX+i2PeAGy5pvJw+io6qcbSQ1q2jj0=;
 b=tkEIMwLrjFBIfWCHyBw10Y7+Y3z1J3ht2iW8r1oWiM4btj92dvTgLz6mDScYnovm2CoWZbSRk2DeDGKeo+8AJ4QuYcM4QRuSWYDURdq6mT0MNGgjwO8Bm4cDAvLWd0+LglqNtX7kegqe33puGHEt2wvje7MtzsjQDpsCMsH1HPA=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 22 Jul 2022 04:57:05 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::1f) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 04:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 04:57:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 23:57:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 23:56:54 -0500
Received: from roy.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 23:56:53 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix the incomplete product number
Date: Fri, 22 Jul 2022 12:56:46 +0800
Message-ID: <20220722045646.106225-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a266f50-bba2-4373-6312-08da6b9e9f67
X-MS-TrafficTypeDiagnostic: SA0PR12MB4398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIg5cXeKgZg/HK+yG9paG/+nIezyug2RFmtdGU8aoFZLZJuQf8g48jhOUOZjqk/6IyU+i77ewnuVsFmgZei5mNI1CQ5SIDKYyDVhOMmGhQkh/gZPjXE2/zUQ3kO8L7gSmJXWKVotfSuInE3ve/jRa/yjEibqPoeitPx0y3LccINsBMvY1NwuyhW8cpVQOIcJUmiC6PEZg40IpOQKQ2Ebex6dwYoTF+Mb+GySzrTGQB+7c1R0okBxIfo+LSayf4GZQIcBsg8F2X/cIjMIHht5oUTZx2uJdZYOC8pK6DgIGS1x/MMiZgVrhbjU/Iw0n0KSUuAsgpXyzft6rIHi2DVBvXG4sYq1N1Vx7GqObtUOwGIOXNiuRYxEV05DMQ8wv/cFh6tIRJdrw0gFPbSvznOX0QvlpyuMOFh4zXcQsuNzla/Pz6noAvVXiK08Jq3CkTAgbkKKK1JhIWQriEuCekbmdWAInNQ3ZxvjindwvVs+uncXbHNS5pZXIAyCnIbmVLfMbyhJFSo3hfdLGywRloBustCIxLYpEN+wntgidq6Dy0Qr3fsgA5y6gTuPIJ6echPwJUuDNhVqyMVgrdmA0gUwgnvTAi8Q3oO8oaHV7X6QbC1TiS/x389cKbPqP0NyNGUP4pF+KC5mHN+WDwSMDWCmX1cA7IoeVilJrQRsmS1hvShcBqaWLGA/aE92C8+SchJwtALf/C+7tKUY3BwVOw1xkLojSQ61o8Eakgvd/m4OmZn1M9W9s3M2WFjtLB3b6xIxTEtuw51CLZnEjLK2OiHQkbr97CisAO8G0gENGbh7VdyzefTr3oiBa8HlKbrsy8Z37wYqc68fG7t+Mdn5UVw/Lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(82740400003)(356005)(81166007)(86362001)(47076005)(36860700001)(40460700003)(8936002)(4326008)(70586007)(70206006)(82310400005)(8676002)(40480700001)(4744005)(5660300002)(7696005)(426003)(2906002)(2616005)(83380400001)(1076003)(186003)(26005)(336012)(316002)(6916009)(6666004)(41300700001)(36756003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 04:57:04.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a266f50-bba2-4373-6312-08da6b9e9f67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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
Cc: Roy Sun <Roy.Sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The comments say that the product number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator. Expand
the buffer size to 20 to avoid the alignment issues.

The comment:Product number should only be 16 characters. Any
more,and something could be wrong. Cap it at 16 to be safe

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9f729a648005..187e3dae3965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,7 +1019,7 @@ struct amdgpu_device {
 	bool                            psp_sysfs_en;
 
 	/* Chip product information */
-	char				product_number[16];
+	char				product_number[20];
 	char				product_name[AMDGPU_PRODUCT_NAME_LEN];
 	char				serial[20];
 
-- 
2.34.1

