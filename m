Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D69C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 09:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5932814A101;
	Fri, 12 Aug 2022 09:14:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE5D11BB2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 09:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQAl5fTLiSfvmbHsEnrGxsrTnQThZO+5ORYEks8Fky/+L906VZkAiDNol9kc6Txwm+81D0Du6A4OJygqt+DlaM71R6cBFC5z+vhnXCtRNUxVWnoBJlWokGQ1kHE/J/LV+V9PWqQu7OaLedlmnhq5JPihEkJ6U8L1Xga61+ANdCZIFRVEWbjwaWoUNCb75UyTm1/4AZ2ZnQGiWImLvCq3E64/emrK6dDMfINcBPWwqS0Brse2SLFRHtZ09Vd2b0/th57jy4O1KZY512qWzayJZK3vCbwYp0G3Y19cYhUyxn2dz0uHq7g9F11Duuv6Zc7bHULgeFWfXd5tbL1z+4g2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhdnza4fogR23iO6vW8tzCQG3+JZfElOgnxJcTM7dvY=;
 b=T/TARHbg+BSPWASYnfdv+bMcpgIecMxfVclFnakkY8bcn7aRRYhZcVfEeL4rVsqgTHtGWj4cZTGNIscAV6sQ8p6f3R8aKhc1N3gWS4AZ2+YgjNlqgQ5vJ4C94TQ5ubpF6eVppNpdEODZys2y2YaFDbetARQ4JWag7BTfi+cUnzfzAI9Sf9WxUpwSe90+luP7OWLT2Kj3jRrcZO4ZUFgwQ/CX5uTQ2C7EJwX9E6ky4Qwtu+G3YvHLDCSZszs/bp/udHl0KUavGZEBIWGghdnkd5bvhjIkEqYM690Ho/gPy537FVlcAwTO2lpWwbpzxB5b4pPyGm5wCLDOapo1T8GozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhdnza4fogR23iO6vW8tzCQG3+JZfElOgnxJcTM7dvY=;
 b=S1QoQe14GMEhbf0h+urCbRTr+ApDFjdONK06NKsFBKQ6v+FQDQeLS7WxRNuc4hUOMls7TleIJCvqIWjW2cKOK6c4bw2iQTTnic2hQBHAkCu8OmkrQmiM79KONld9/PVHHX0JAVe6gEBwcTqZh0gPRQNs1ekU5PlfhK6mCV4bBKM=
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by DM6PR12MB3705.namprd12.prod.outlook.com (2603:10b6:5:14a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 09:13:52 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::81) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Fri, 12 Aug 2022 09:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 09:13:52 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 04:13:49 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: fix hive reference leak when adding xgmi
 device
Date: Fri, 12 Aug 2022 17:13:17 +0800
Message-ID: <20220812091317.338637-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812091317.338637-1-YiPeng.Chai@amd.com>
References: <20220812091317.338637-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89e91cca-b09a-44a1-3b98-08da7c42f991
X-MS-TrafficTypeDiagnostic: DM6PR12MB3705:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pkp8e7N+gVBnJTE+88VrGH8mWbCdsnDJlAO6oSvvn0TME02foxIebqFtbbYFDvHjLtpSpkX2VB1wLED1kf/GQUab5AJBOdm/+kVuE0o6ONmcKG2irsWRD4VdxgOuInabBvVb8jcznFIXpzJgDHl7/8C7oqop0HiWp9tKE0oERs6ezphgBQv0C9DEOAdTPTEkHeoLyWL/FlTjRaH9xPiRQgGenUCrxXoEP5rnfcTk3o1gfiC0l/rLFap8zWGCauq9pOHt5Sl8bA0y5Muzxa2doVuBJ0t3dI0TZNXcp7rQeZc1blkTPTe9GIHxprcV9kGWpSbmNeU7tegxS2XIfAqvURfqzTaaoUKKktpPjVkiVWHyCPZJPu9FDq/OI2bZNxRSaDOVS2QIRCcxCRWcDWQzlYVNc3AVNzJqsBx2b6OEgjuSdKWSe565Fnq0Cxf8+uBmisEYHiKUEIIok3pUSyowJ0sHI8i2cCxttZK1yByk9DCKD5aI4xnNH2QzstAuRMQ9rBbB9DArvZm/PCsPD5irAkIXN3vY5husBzmAsw+z4zcIoUpE6pSoDYScOigRAptuHL+18Ih3g6km9UzpkCDJBMy9UjnM9ZF6S4pdpogNwiJJ7PX9fDprimv1mlbttGrmDADnO3f4l5IqnKp2MM1pUCzlnWsK6OA7OEoMGjE10F+p8RTgi1cnyzJNfmaG9/3fmPeLniIYnqnwcpiAk5HMqkEPl0aUlKgz+3DGZ9fm21BdkwDuJ+DD2+7IEOP1TKWiOQIfJt7UpfE+f7Z1fn3bN/P/Vg8mYBGHkIZfVQMoTZYgKGk7jWS1BIjjPCBJMveP+wJfZSpstHT1BtstkKwSlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(336012)(41300700001)(6666004)(1076003)(16526019)(2906002)(478600001)(186003)(5660300002)(86362001)(4744005)(2616005)(7696005)(26005)(82740400003)(82310400005)(356005)(81166007)(40460700003)(47076005)(426003)(40480700001)(8676002)(8936002)(36860700001)(6916009)(36756003)(54906003)(4326008)(316002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:13:52.2139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e91cca-b09a-44a1-3b98-08da7c42f991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3705
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
Cc: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking.Zhang@amd.com,
 KevinYang.Wang@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only amdgpu_get_xgmi_hive but no amdgpu_put_xgmi_hive
which will leak the hive reference.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2445255bbf01..4cdc50873621 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2456,12 +2456,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			if (!hive->reset_domain ||
 			    !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
 				r = -ENOENT;
+				amdgpu_put_xgmi_hive(hive);
 				goto init_failed;
 			}
 
 			/* Drop the early temporary reset domain we created for device */
 			amdgpu_reset_put_reset_domain(adev->reset_domain);
 			adev->reset_domain = hive->reset_domain;
+			amdgpu_put_xgmi_hive(hive);
 		}
 	}
 
-- 
2.25.1

