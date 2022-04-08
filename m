Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3180AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 10:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1CB10F1B2;
	Fri,  8 Apr 2022 10:07:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C33310F1A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 10:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc0UvZStZ4dCB6D+1SJYW6pz4QGFyxQaD+7uQSZdYt6U0w8owzXA+VWTo6k039pEg/9o+i8vrXrLw1iPpkTGbrt2a+E+A7ITbiel1dmC94eKDnDXPZbMCEL1vFEUW6vgYLhahqdDCrTJBxcuudtMt5qsExqEBUOKlVCEXbhBt8pDC1B+zWE5rOu8VW3hcj/w5LuOkbijzlrx5xZx4r/PSuJR0A2jazrAUyW08xbbGAENYZliBmhzJaOiW78F8szaAbO0+2K7/MLXao8FlGQX8LzqCDCje2uBglmzdl7+LKCzGkrAyjHYYTLeiQ1uQGa69ERYuBvRvrhXjA6JdoRC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXRR87/jQmt/rz0XUGqJ0Wvzy3Fv6aR2Qz+Vrrs+sn8=;
 b=iF5cfckaksmEJX/Xzt1AYAIxp2+qCfWjZYrB64jheT3xISeaSPk7T48/0s95l1CyWWZPVHliWfjPkf0nA10a8H7nBYgU0GDGmawBR7BTiLOCRwRjo/ma+PX8+XOdz7X6EpiIKsTHsZGGQzIeVZFX8HToqUPfG8agAFW8HJkZ1Vd9R3/EZOsJ5ZaETvKZTwremiB1MooSjAyn9hMeavUNqkK7V82T6RqvFjAW87+FtPa3ul93VUnHK2q5a+wOGH6wyh1Zgm2CLDdjOsMnoQZUr+i6YeLjn8lFQhNzDrDh0+7t+6l4zGkPLGexOKcL+jUfImG0l3gO3Rd4FouIEh/ntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXRR87/jQmt/rz0XUGqJ0Wvzy3Fv6aR2Qz+Vrrs+sn8=;
 b=c/5WzkDT9oTJfyX2C9oQsjx5hJoQNxkb7HxhcaE0lGJLdYC0z5klQ76GIZrbaGf4eU4NXeHsK36ONV/3vXQzq6x0n0/A51OL+xN9GJWTWFvWA+dcoj24h71Qsi9uVPp6pGYe0iviIgwzOwJkTtSi5BSzra9ctW7RForOwRzXfmg=
Received: from DM6PR02CA0151.namprd02.prod.outlook.com (2603:10b6:5:332::18)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 10:07:29 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::5f) by DM6PR02CA0151.outlook.office365.com
 (2603:10b6:5:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.23 via Frontend
 Transport; Fri, 8 Apr 2022 10:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 10:07:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 05:07:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Use flexible array member
Date: Fri, 8 Apr 2022 15:37:10 +0530
Message-ID: <20220408100710.211593-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4608466f-0179-41d4-48d8-08da19479689
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5120AF605D58A0BEE5A9E82697E99@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9Uo25KBrv387aMitt9uF9ZGbP4J8X/galBesH0lVI0KHr5o54m5wqWpMd8ciXWXAYcIZAkS2Vurv9UPkkP5eWD37qtP/1+8fhvPm+D+7+kXhLvWN/vg4WBNcGmkrmLgtSBpCfh6HrgPi4loILrtpiNxeW2NwyzzVXfUJPbudtDH6lZrIiEB+3IZXYiDVqZnDu7NjkmMfbYBLf6IUgtSKfiOGzeGdL4qIKnrHw4l5GZiP/xjt7M50FUwJ31UP2N1rM9lFVmn4lK8YJwDSbshOrVYhtyx6ehsusy/NQBhXHP51jH1glD3Q/fUa9BCh9ECxfjBAgFF9PpHErEtdodRmH5wl9DHnNdmMSPUj8uLjCMOY0xU/Lecx/r7PEBQkKC2SNLmZ6oa4CzD3dMRi4vDNP2blea49fp3JezcdCvA1Mg3RRyWQw+M0lG+nK1Ink5j9X4eLKEeU25MleOEP1wk1YCRCZJHGCl6HRcGmPtRdM3luD+SmQA9U1RFXjd7HIxqFOY7ThxjloZ2pV79S9gVgwBtGS6/GqUzMew7cgnWSdpXfakMRdMT9CtMOH5AQJ5S1H3lsxfcv4Z/bBUFJa7SKKwTOMjBMsV4n7eKR6Nd+s4lrNIWAR/OWQQKY31XybC0YlM2wuRWFn/YJUfODwRwdIovw/wzDPfrWHAtPOkxPEIQhuGbVwL2NuL61nP2CmLH7HayufWZ3cPlv9/amA09fwMlADie1ZY4nxVnQORZftU/twbjr0X23HM/wVp1Ntdes7zPG+mZyyIjmMvEdXOJsMzZMeC0ooK0mMGfCv4iIaU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(8676002)(316002)(336012)(36860700001)(7696005)(47076005)(4326008)(44832011)(82310400005)(36756003)(70586007)(70206006)(2906002)(86362001)(356005)(81166007)(8936002)(5660300002)(40460700003)(6666004)(54906003)(508600001)(966005)(6916009)(2616005)(1076003)(26005)(186003)(16526019)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 10:07:28.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4608466f-0179-41d4-48d8-08da19479689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use flexible array member in ip discovery struct as recommended[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 v2 : Use struct_size (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 drivers/gpu/drm/amd/include/discovery.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5a182288391b..766006a075ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -430,7 +430,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
                                 }
                         }
 next_ip:
-			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
+			ip_offset += struct_size(ip, base_address, ip->num_base_address);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/include/discovery.h b/drivers/gpu/drm/amd/include/discovery.h
index a486769b66c6..b25026c3ec96 100644
--- a/drivers/gpu/drm/amd/include/discovery.h
+++ b/drivers/gpu/drm/amd/include/discovery.h
@@ -93,7 +93,7 @@ typedef struct ip
 	uint8_t harvest : 4;      /* Harvest */
 	uint8_t reserved : 4;     /* Placeholder field */
 #endif
-	uint32_t base_address[1]; /* variable number of Addresses */
+	uint32_t base_address[]; /* variable number of Addresses */
 } ip;
 
 typedef struct die_header
-- 
2.25.1

