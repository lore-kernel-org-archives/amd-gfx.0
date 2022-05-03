Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED35C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66A210F4EA;
	Tue,  3 May 2022 20:51:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F5C10F505
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHtlOOvQMHrLM1KjkfjCc9CG/JdiZTDicF6fMKPlkv70I/IgMZzO3DVgGAn5otZAOQjsCqnemP55H9fiVfPB52IE/SQtog1g4mDNU1Lr2z55I/hyNyERA+f1aUoUPUgBjTQ/nMK8t1SuGL2Fv10dKXXTtAsIgw0CWqWjewSEuETOr7OjbzaljHR0+41gyw48cetOurJVGTgTGJXHh+N9TwljuSU6jq/KKNzEUsjI8ACsAk5suhZJEtFeCm7rYR1/NSzZl1N0Hn4RK5nSc1eLDE96B13dyMiLU1oKFLHfHnxaCcx+LfVFma1f5wbu3Yn7tulD7UT9B1X4QNgRvMzX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdkc20lovQG33Sp+8xlSgCpph8lVXF7mXXHGdaISvNg=;
 b=jhqBEceLLCeUh9LBUN0N8Kzov6TwzwPjjsvUDpUW/BpK22/d17eZ000ywlL1Wy8KvFANcALxyvEpylrHeyMqRMMSy6lrMSbZGxfppvAty13bbVId06xn/uWzUJPUqj75YAyW+e4Zc5zHwCZPxsj5zHzf39IEU55NENJ1dgw/rUP6wOurnhqumwvfQxQ7iGtpK1d6DbOs+pfhGTWuxkRgPlp5Kg7ivNeuv0AyZKnGEfO3dLpisAOq1pECMActt7DZO++gOb4FxporM5cX4ZuC8Zj/Mft/sBZcjULduKQSp65A+usv2/FAP5Fd+zB2al4W1CwHoIB5mHM+Zgxt1sb6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdkc20lovQG33Sp+8xlSgCpph8lVXF7mXXHGdaISvNg=;
 b=tVeuxsTgV4RzWFgacl9D+fOf7RUOqIPwEIG8P0/Um6f+MsKMPNwX01WgWgkXXEphqvvP/d0/kiWJSd2WAW67pz6frTUF+pkgZ859p2eBcwlaiQfYUyr9+xixeKLwCQlu2ZPc3YN30aIk+zxlUun11bdTH5zVVBXR0WxUiV5erGQ=
Received: from DM6PR08CA0037.namprd08.prod.outlook.com (2603:10b6:5:1e0::11)
 by DM5PR1201MB0265.namprd12.prod.outlook.com (2603:10b6:4:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 3 May
 2022 20:51:28 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::98) by DM6PR08CA0037.outlook.office365.com
 (2603:10b6:5:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable sdma v6 for SDMA 6.0.1
Date: Tue, 3 May 2022 16:51:03 -0400
Message-ID: <20220503205112.1285958-9-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5bbda677-9411-4287-2f07-08da2d46b257
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0265:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0265171C066A91D1A9B7A744F7C09@DM5PR1201MB0265.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRiL80/0mKdbXUdaop6kfS7qIFkzPwmX9J1zUeE2AX6SVZjl8xCNZXlbcfVCdellzqpzp17O6P9oqORH0b8v0UtnscAzFa6EF/z4E8pDUa/QPiXzK2Sfco2Ur8Cmv/ZHclOYq/Pp+LskN3hgNyN+8850Uj7ntMRHXXzVfY02SUk16z9f/rOkkHZGp62ig+kOL3xDLyjEA2/baBdqTvXiTn02OpXaRstDpBdUXb3cobA53t97jKX2sMqv88gr90OnDAhWb/oUIXaXo2iNR9bs43tdvD/G6AHDYvi7+IVgBLtzJX1cCu0I0JS2zptKPEmU7+XUmX7tFGNt44co54aFL30oAL/ZhtbxbdFTUTLcffx0PA2uTi9fS6LkzLTQwKjAbvR9Wj/uSDSq603dUB+3f+EyJVW7gUZzK/1cTld63RYfPXkoGBduHoxF34ylZA1E+yg2oRuMs25zJz3vqsfT1hryTpM0MGq7v+TuU0LYp0m7d2+P3RFzi0tk0kI0US8Ci9evuQ5kidrSs+a3E9mEmXk8kgwg7EUACusAPJxQHMmeRPy+vIUWugMVpkaSlQOrMsww+JUw307QhJ/VApV+v15kMKvNw04lU4fV+CEth+2CYkE8yTNj3XiSRY6gQzArb+CdYzxBHoNBO9WJCxle0vqTcGFG2fNjNPJR8UuG5PWnIGAV2QcEHpGL27/bJUEi7KFSjElFE3bubpUTFYIQmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(316002)(508600001)(54906003)(6916009)(70586007)(356005)(4326008)(186003)(81166007)(40460700003)(8676002)(70206006)(2906002)(2616005)(5660300002)(6666004)(426003)(336012)(36860700001)(7696005)(1076003)(16526019)(47076005)(36756003)(8936002)(82310400005)(4744005)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:28.8427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbda677-9411-4287-2f07-08da2d46b257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0265
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

Enable sdma (system dma) v6 for SDMA 6.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2c742d46a837..3931c1af2b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1791,6 +1791,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
-- 
2.35.1

