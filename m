Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A90C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE5510F379;
	Tue,  3 May 2022 20:29:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476D710F0B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7Qpj6r2xBqDh4ymvo704xFF3GoB1p4ndBFenCMjOkcR8GuAQvBxP3ICQyPuBv58fax/Xib2U/tdYlOXCiFofP0OdTHz0bc6378Uz7NZwIXhE841zrgWWoaI/Slz4KDA2WRs7R9RwWUnX/UEeZ8G8Gbh2MQQg9MoLFFptDbfocTd8mOn+ZbCNks9mWDwQq34AQkEEk+7eS8zdIKzaELYGr68eS1a+9JpMiPImV51NVu/xOyHuqFqTjm7H6yB3mi1URGAayZL5J1FP5+1An69DFkPbwsYx8owXWkO8sOwx2gn/md0x3Xvc61tDJIyeU2wFA/LQY7vkZOIvpQQA7S0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5qnuqYKL2BE/A6qupLbU83hLJG7EsWxaI3qq4oO6lk=;
 b=lQBIc2eC6x1/Dak+yqZvUPCninUDBLmneHHRU3YGdt2rAl3O+uO9mUSseMQIZP/H19PVJgivYAtmKMlP15xXhIqhZQf5eHpk1QaWde2AY3JwJFDYEu52nq2TKF3fHGhqXzrx3sf0JrqV8UovuHRcuOT4tJPitn6CSdful1M5OtlTV3zwdgaCFbxZBbjN02BWb1Ei91T7gmFjNA0LanV6rhC8OOlpk8i4Q2GP7bHXvi2/pn/MIhEgJA0TnPZRahuty1K6UiBqjFEZvmCyX0vDK21nd74z17Mfw/Gdxn8GIN7pUitqfd+S9FuXkOZ5Z7LVLy8cWBwAiLis/PYEm6f0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5qnuqYKL2BE/A6qupLbU83hLJG7EsWxaI3qq4oO6lk=;
 b=j0Bd8snwXZHFRi4eYPCFgBE5ktBGYnoca+arQjkW8B0YMtBIOidaHkt75r1WOpU/UBY2lMwfbSriAR6FTGOazOHCTCcphKzS9D3rDgGfxrsjoGQVvMmwcB6CRedBnpHkDT4iR7GLLbHnN0qozcNTpCHpaH+B9NYRllasAeim8zo=
Received: from DM6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:5:bc::32) by
 BN6PR1201MB0036.namprd12.prod.outlook.com (2603:10b6:405:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:29:34 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::fd) by DM6PR13CA0019.outlook.office365.com
 (2603:10b6:5:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.11 via Frontend
 Transport; Tue, 3 May 2022 20:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable vcn/jpeg v4_0_4
Date: Tue, 3 May 2022 16:29:00 -0400
Message-ID: <20220503202912.1211009-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c86f55a4-7f42-4c92-8f3f-08da2d43a26e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0036:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0036FD14ECF94944A0DBD9EBF7C09@BN6PR1201MB0036.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa3Tnd63stD+Lulv1sl6q/3GRVt9jRJVLsZyY+yGpklwuv471Ps+cxaZyLpvSbCxOGmkawcSbnln3WmTMxuWDIH98QM2CsNneTnaQ/RwvohWlchhDqWMZpPgfwm1l5vR+4upmiXE/1fonavl34wU8mc147mlo9hgmKkpM6H4B6NmbQfaaeysOsEuimBfzJNnQsY8GxQ5lBuroMrUJJPZYh3qP4fbzXPxIfm95oxfejGjUd0fFNSkZf/hX9DODXYYIByFD3KUGqGPpgSTxb3mQTFsUnia1UIgH2NWzPSQJe7UsDu3VbuDzrN1/3WMbo51t4sDC4n5vPbmO5TA8sIVsnszeD5KK/PA8+ixLtwRezv0uznG7cTgmdqqOBWwYfbuQIw8DTDgAuCHiEiPZKgEp0mOWxQVVFL/GqvtiS8e69tdgsvtdfXiCwWGf/ZACP3UmGWiS7LR6Pwjmq/KpIKKBUwFY7pXjkNwiZ1vKcgcJhOzfLTH4ljGKUM+UCbjpGkw43H2sFUU7PIuKmP+cNwwFFKU8kFqw8zWWZng1H3U37ohajDVbFaYMyYpvkLxhJtdEPG77W6QKcAt3qPrl9oYYFuN8FfZkXOQ3iE+RWH36/cOX5GYiubQQ7WsO/WVG7zTimzixsb5OfW7Rqn3cjAy3hcrd1MR6DF8rUrE1baOSrMLs2yXEvG4rZWT9y4vGmv01MYuL9chLvqCTd8suIusFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(70586007)(8676002)(70206006)(86362001)(4326008)(6666004)(7696005)(356005)(508600001)(26005)(2616005)(316002)(81166007)(54906003)(6916009)(186003)(426003)(336012)(16526019)(47076005)(1076003)(40460700003)(2906002)(5660300002)(36860700001)(82310400005)(4744005)(8936002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:33.6622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86f55a4-7f42-4c92-8f3f-08da2d43a26e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0036
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable vcn/jpeg 4_0_4.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index da2466b37839..abd2a6f96ad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1861,6 +1861,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		case IP_VERSION(4, 0, 0):
+		case IP_VERSION(4, 0, 4):
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
 			break;
-- 
2.35.1

