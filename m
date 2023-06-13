Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C18C88CB4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 11:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 996EA10E36D;
	Tue, 13 Jun 2023 11:03:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAC010E370
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 11:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+rvcKRGt31yroUXcLqY/dIDWBUjDGtyiI166GdiRHRMTNALxgTosaxDWo04Q0DE49Ha239zSS+EOcLQQdsuUVT+42x0Mo9CkscJ+E/e5xZQIBxJMqZXXKwSldgAeAGWvBDpb7AoL0/fDR8BGIBvwdP8ZSAObduVfxJia+5+2aKLdzk9TBRNSMXCMOWsUqjFgNND/gLpV8jBiyy+B8HfXTuj5b71yE1gcR/BtVbePrg8t4XEnsAkEvFg0wC4wTNkyniXJGyodkf2Bua2lWUPAY71vC2CRFjvL+bNkHvfkL7+sXad3qz5XW4+JfDq9v8xVfiOT71l00cSbjRDufleUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rKnQrHfhbv+hMqjl/1DCx0ZnUpNHaDSNAfZCqoCdVU=;
 b=OuCv0his7VPCTIngEJlSS1U7c6QOBzWS1VKv6Pien2+poz6GMbFXYe7DzbMcBaJoKhWy/rziXknhLbsCHaOzgO+XI6C65RIsU8SlpmzfbLJD5ImwijSvQT8dT8W3ReeslZLNsx+7qmf/DYZ5F5gJxI0KS+SWWBUZIhvezez6mIv6PIKov23kMQt33rN8jYYwJcFK7rarMnB6Wf8FNRrzxAkT/QfGZ14VeI4SBaFZVULdKyDmZLMXJIy7Mie2nmrB/E+6Ns3r8PImccElCjVL5A3nKIFLf3flN5M/ZaTtFUjas/8EJvI9t3V1xcuQTvyqHR4LEqW9AZsxpfLzEym+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rKnQrHfhbv+hMqjl/1DCx0ZnUpNHaDSNAfZCqoCdVU=;
 b=VBMWAo46zHrJwkSeI+M7ZeulvwbJUHkuTvXfVACPiNzL+lyT9RrGIo5RrFYbN1qW5Iw62faMIjD3Yuz6AfMjDN2ALo5/taOKBuXmnaOvNebiv4LqYLuOwRkb9SUjteDNfupVlcyZGxs8IGW8t+qUmNrbXvnyfLJYAnVH6xk7zcE=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 11:03:14 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::6b) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 11:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 11:03:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 06:03:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: Change nbio v7.9 xcp status definition
Date: Tue, 13 Jun 2023 16:32:54 +0530
Message-ID: <20230613110256.1562271-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6742180d-a7ac-42aa-c70f-08db6bfdc83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6Y4ZenD2eIkFNdz2NJz+9sDryKW+daqroFdNSdWrA8wojDBveWkbgvnZe2De7x2jZjdjncK9VgHZ6LPdewJZMJ6psZUXtJxEptKUI2tUgZjlNxzStJfr3hpUjbAcKlZoGJlCbghE+xinduiIs1xqursLo3OJXSvfoGOVR4nBu7N2g2TnZwG/Qplf0OT3DL+MI8wJjGUsZM7iHdjHIg4xXer/Vw13PmL0+hYg95L6D+bDpOVG9JAQAI5yJkN/e/lZs+ZTvCsZAGtHEREBW97zVyfLbWP/j82my/2OZ4b0fys9UM3OLpCfmnoH3WZCSOfQRZ61JKwA3u2g/4IadDZYFFvUQ0iyB5Ck6eJvLmCN0zhsIEh6HbVW29gFSt5mFBLpOWRJdJ/azDTZKNJ2Cq0LWRjitN8/mcHj+G7eHOAd8xqNKfQyXVY5NhpC+2vbPagcMa4lHAHWT829ajTN1YlwlTlp/nRLoOW28EqUKb0RJ3dZNOk5cagGW0rtmskzbtFqCWNDyRYAJJGHetXmCH1A3Af8cLGnXR4PLJKn+6FdIStXk+d4m7/PFaAfMA+8lOA0ADOXddtm5y+BHA9qJzAzMO701vSGKlBYUvv/PATmJv1pgbpuZGt1MwB4/xIXPeK0Ze0zwSAs2rzuUjIsGHraEl8K3KqIA70r4xjGGeUHdPwXlNLSsNDNHp5iFHfxWph9A/c9jIPvor1purqr7jsS0Af62wjJOGAgkZYaXqF39MipRHdiTQmaCqqEDXOf+ah23acOngbngLDBMp9LPZwjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(70206006)(8676002)(8936002)(5660300002)(6916009)(6666004)(4326008)(478600001)(54906003)(36756003)(40460700003)(41300700001)(7696005)(316002)(40480700001)(82740400003)(356005)(81166007)(426003)(86362001)(44832011)(186003)(16526019)(1076003)(2906002)(47076005)(2616005)(26005)(82310400005)(36860700001)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:03:13.1884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6742180d-a7ac-42aa-c70f-08db6bfdc83d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PARTITION_MODE field in PARTITION_COMPUTE_STATUS register is defined as
below by firmware.

	SPX = 0, DPX = 1, TPX = 2, QPX = 3, CPX = 4

Change driver definition accordingly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index d19325476752..b033935d6749 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -390,7 +390,7 @@ static int nbio_v7_9_get_compute_partition_mode(struct amdgpu_device *adev)
 	px = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
 			   PARTITION_MODE);
 
-	return ffs(px);
+	return px;
 }
 
 static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
@@ -398,12 +398,10 @@ static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
 {
 	u32 tmp;
 
-	/* Each bit represents DPX,TPX,QPX,CPX mode. No bit set means default
-	 * SPX mode.
-	 */
+	/* SPX=0, DPX=1, TPX=2, QPX=3, CPX=4 */
 	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
 	tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-			    PARTITION_MODE, mode ? BIT(mode - 1) : mode);
+			    PARTITION_MODE, mode);
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
 }
-- 
2.25.1

