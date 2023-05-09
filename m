Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E218CC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C4110E3E6;
	Tue,  9 May 2023 22:06:04 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36A8810E3E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5RBS4Kv2JJ9BgmMZXqaPSyUIJOLgLOKYglaHjB4OGPn7wdihWjb9nrctEotMhjF0wE0O8lNWpnbFwiRLc9/rhD3bYQX2G43t89HUXmJd0lUoXs+m3ZBC7HGYcfr/G2Fg7Dw8ivBMBZE30fhkUqLJ0DAwDENwP3SJdGkEz8bt+pCMtJpQmWsOq/m7tAX2Hs9rjzXIUiSWT1hxjMG3LsVLSlgfXCx3V566sMrUWh+q0LPnf6xpzrAYaO2/opLse8egVPQD0WfR7oKv4AYyQRUJZFKgHOeRMLIpIHVmZe3/5HqkIpKKXiDOTa8kRdyPnk+wRKkJozySX1bg0UTkvrUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsoHtayFZFodQJsxxN21IeT8UiQlJ12/fS80QboA+e4=;
 b=Kb2C1eI3Xr+ScP4ATmDYkxwwTGJGkyYmJk1aWUCfpoyGaB6F240wv7XtWqSb63BtsnamSGKF+KsnJrRMqQ895VF3kMt39n5bsEdFIKD1Qo+FGGdC0AJi+0XCNcd1YmV2b8O6UHQUIZYy2BnkHnZQ3XrA6moaGegqmjq/dZe5PLiBWZr22hUBw8uAGaC8zyKPOztNCpXVE0L0yr0BX7gQGFqznE0alsyL6AXpzGRpUj/6ss/KFEXIWJcpw0yvigVJigxkiflRSReHkRmB4CPcdJ6lLbPGCFxT2/jFLz32kqffGuwuMXzinz5bd5j9W2dV502o3bh0RtE4sLq61jUUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsoHtayFZFodQJsxxN21IeT8UiQlJ12/fS80QboA+e4=;
 b=BjCbHp4WtFWTdWhk3Isdi4FX9mWOnfCTQr429iVQ5WEeYrohUn4pUXtPcY7c+nXi9ezWZprkKqY6XEeEXzHzxeppApzB+IAYIjny8MijL/UVaTOboBfXNIxX+HuxrZPRm6Y3O96mUcrh8Emr1ZNHIUeHulXD2WcoNDq6KVsJH8Y=
Received: from BN9PR03CA0270.namprd03.prod.outlook.com (2603:10b6:408:ff::35)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:05:59 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::2f) by BN9PR03CA0270.outlook.office365.com
 (2603:10b6:408:ff::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:05:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:05:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: increase AMDGPU_MAX_RINGS
Date: Tue, 9 May 2023 18:05:41 -0400
Message-ID: <20230509220545.474998-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|PH7PR12MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b1189-d25c-4e45-6ec9-08db50d9922e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydx4YH5iursxI3ml4yX7TI0rViUSoWI37bkNeOb9LbwjZEEfSSJPdStq9ZdfR7j7E9Ub/gj1UUYTkwQpUD2/VdHkhLdGAqSB2W7uVuOrK99yi+U8TkzOcxlh+0X3P6NLUddaz2Ysr7nCwpjdcoo2ON5H8OhA0sibVh57bvKABJiB0YzC/E0y6IoFFHKV2xAF5V1yfZQwT0yMYwXnkvNDfAxtXUg0BvhypZcr40pgEz+ozaKHVbQMN1bYsND36KHVg9Czqd+HR/Xht/r4sNSjdDICeoY31ygw/tzap++adIJkVikNiwqLibt1lT9wEsUtmi1dAVwWXJUQSmX6/DHlJFN/8lBtoeiGq+r7aMo1H7esyfQE7HNcO3doN2jJeN+KLPxH01aXYrWPuR2FUp0SWSAU+eU67Lvp/ujijXCJsL+OsE8kypCuUyoSDXjiBX8mgu1+nVgyLEVsdrXNh7w1yjLWe7rWSMTnJuH5y7arYuLXFcfo4FuNOCQgX0T8Iet0NDmohBvv8kFCslRV/3/08668HKTG68rds6pft8aUJXci1cD3itIiZXuaoPDo797h24cA0bmSyXHlxskOxod7AVZXSIFf5fSmcEzljxWV0r0NwJt/SdMO+Vw3s5KqrPPIefmhy6e6HBpxr5pwJp5IPbxbo95bY3uXnwu0iK6kh6osEurWpN5nkjXytXwS0IJ3kZEB5K0bMxU2K6WLLQtByVn4bBlY2mYel0vjeMNDjMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(6666004)(41300700001)(8676002)(82310400005)(478600001)(70206006)(70586007)(82740400003)(8936002)(7696005)(316002)(86362001)(54906003)(5660300002)(26005)(186003)(40460700003)(16526019)(1076003)(4744005)(2906002)(81166007)(47076005)(356005)(40480700001)(2616005)(336012)(426003)(83380400001)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:05:59.3386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b1189-d25c-4e45-6ec9-08db50d9922e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

On newer GPUs, the number of kernel rings are increased.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 1ac8a82b9b09..5192e3577e99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -36,7 +36,7 @@ struct amdgpu_job;
 struct amdgpu_vm;
 
 /* max number of rings */
-#define AMDGPU_MAX_RINGS		102
+#define AMDGPU_MAX_RINGS		124
 #define AMDGPU_MAX_HWIP_RINGS		64
 #define AMDGPU_MAX_GFX_RINGS		2
 #define AMDGPU_MAX_SW_GFX_RINGS         2
-- 
2.40.1

