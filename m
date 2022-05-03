Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF58C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A50AB10F522;
	Tue,  3 May 2022 20:51:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B4A10F4BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDBSxeOYL7VCBOW4TUjwfGcsVh7j/aLXlE5NgotDNtAgE/TCvvyx+hfC69w8hiOAvrJzhzIaTGSWMsCSXb2wT45fLe9WZM3+Lw0ZUYo2myn/U46NgH6vv38XZYDrirPWGveJvVymnahThalqTqJShLcGWveyu61YlvV5SXoau0Z4VPPdm9m8bl8OX0Xkt6459+Aq8cSrIDsuo3Cb3YQBDdodIp5zarxopowk4WnmVkdO6UeSndlcka6BpnwmtVjroGGtXCRwSew6FY4ibKOiPLqc/aZOyJ00Z8LkjrjK5Hq5rz3EtYnHXWHKqgIrJSdvq8mrhpQu5JPOcBFiWMjNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BALQGN/Qyi+9ubvKqtq8xIIZRI4fnU35gCi08S1lgcg=;
 b=BZHvZApVyGNRXu4OIE2oDo5q3d794E/qCN7hSTy9fPV2uhqSAapatSef96fst2K1+CBrK81eYLGi5YxNu7MiQMfidKjdzpuPuxVQGZOYcb8iLMDFaO4wgNMFie3DEdekl1O9xpnfBixIJQQndAd0KR1GwT7KtDDmyPdCh6ZvVnymIbmXx/pkBjYNVsxJR29X044x4HzxfHqkGyljS1B0q+W+JMMYUGCMi5ccVokymF3om1o4jqWRZtx5K24HTt3FuHt7pkdQ293X7HEWR9PNYax7IKkHrHBHgR9bDSBhJAW6gQl6RszcE6nFWUPBHuRCM5nPacl1Ys72ZU7HhKcLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BALQGN/Qyi+9ubvKqtq8xIIZRI4fnU35gCi08S1lgcg=;
 b=NYCoG5nLuYVaAZRshrRxp38elXtcOtXI+PXIeTdMgcM4g1U+c8d5ggA5U3m/tMo2DdrkTR4+FLpsopmg5bdhTB2r/9AKsEm9cDrMQRSK0/RdAAyR7ULpJDJxraIeOvc+Ouis6ZdszuQb6R4qXWnthyoBGOemALckuOYuzK1T6q8=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by BN6PR12MB1473.namprd12.prod.outlook.com (2603:10b6:405:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:51:27 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::9a) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable ih v6 for OSS 6.0.1
Date: Tue, 3 May 2022 16:51:00 -0400
Message-ID: <20220503205112.1285958-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430b9dc8-b680-43cf-9eef-08da2d46b180
X-MS-TrafficTypeDiagnostic: BN6PR12MB1473:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14736145138E95FE8F895EF6F7C09@BN6PR12MB1473.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GsYIWjkGU3scyi0SIzMz3G6TKIsaM47Dkoiod6WXlXnugDON6e2jnHSPgvrz56/VowrJLN+oKMLnFwcypw1Emgy5GCKGVcSv9HMqsikWPneIM6D/v+fO5K4A8u0rcoqcuZ5s1l1uJaE8p2TzS6h/Whcmw2i2c2k1LeYelJKHY323xna1l88gf6t4yTDOtwEBtGDtGXOXyrCj/7k+JSpCkOLLFNLt0XzwizHYBJZKhEzMVnB/2ANrzn58Dv6m6NxfUNXMDrkCtDuMdbA+6lsYXYsofHR2tQ7kbyMnPAFd8VIrGI7hbVrmMYkc6Mm3B0UP/0S9qNAQI90an8sQ/mhmXu4S/MxA2nt0WwZ+Nk/ElLO+yUlXPdwe7PmlSFCNMNxiIrpTf7Ou6diggXktwthiEpmVZre8q0boF0ZfBSRKjpgAfKP3t4/x3OUh8XfkdYF3o5aC0F2yfbyauXuXpWxD/LAbn4IUT2iAqmgnTWCMekhl1twwWoQ5LIeCsK0WZLDRPPBN3AsAiGOH/kEgbmJmxVvcpnfuRfF2OtxiOrwGj7lFbDG0qSBHTiTP7oGS00iaoFBoGv7WVTBrYKGNlP0fc0Wx8/SgyEe4aTtBFURe7jQbJDCQ2xkoONscZMirFXWNnN6XpuhgWLMTUVEHyCr8xvY/RSTumh6pyMLfkTWFryr3uj7n3PohGnhgtxCU4Hf4lknHCgC3Y68PNncvkZa/nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(81166007)(40460700003)(47076005)(336012)(426003)(82310400005)(8676002)(70586007)(4326008)(83380400001)(6916009)(2616005)(54906003)(36860700001)(16526019)(316002)(1076003)(186003)(26005)(2906002)(86362001)(6666004)(356005)(36756003)(5660300002)(7696005)(4744005)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:27.4366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430b9dc8-b680-43cf-9eef-08da2d46b180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1473
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Enable ih (interrupt handler) v6 for OSS 6.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 90895b1af5c2..2ef93c8c63d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1561,6 +1561,7 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		amdgpu_device_ip_block_add(adev, &ih_v6_0_ip_block);
 		break;
-- 
2.35.1

