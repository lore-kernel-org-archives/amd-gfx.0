Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5667A10E377;
	Tue, 22 Nov 2022 05:52:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5792510E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isWnZmsZv01jUTKgh/0bNJKXne+xXxIGEaikhD/x02MTu02VPmjhb1eUujmlIknZKaJx2CJVnuXev1I7U7/1ADrlOSH4P12LWTgFgpGmsx8po8Mx0+yHNa6HEdQBpO18/vJ/FGGSzPiWaA9fbWre1haxRVB0D03xvg7jkfEVeno6kQ0+dbzoyDrvdlFJ5It1Z4+OQcfEraoShUVgjqR6qREXMx56Y/eb/6gEJ8uD/JNchE1N7cMh8Q4Hwyc0/fq+jsaMJ8RY7SFibgvfHsmlNlKLsGMu1NS1KzN55VPZQuWasX3ihI9AtNpM9qItHTwKibVyKuerjG2f/3IGo5RkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkHYFCbBWseBNKy2InI9Q0R5oCHrdiFQJL8d3cnbEJw=;
 b=WKqSBJ/eHUcu9ZnQE5+wmYu+QBgK7EIIMrQz/il4q8G6akBfZhQNeSbAYpo+LXxthwydEAy6U4ys7tvPpN9ODa36UvJmBak4w6fSX0gSfK8NNDpLGc+SYomBCppfpu6KkwhdkeVRen3FGTrHXju6Z7I2SA2MiVlj8jQXvsEDU1WH2evg1UsTMqkPfNzKkjoBrjMZuzhzt4NTUesRMl5uK9GGK3BWuoaa9ZOS9MR6sYoiDUGky5zXfjcNIOnEhubRZbZmbo4SFyV4K3YIrWv4IHWS0iVxk/YXOZ+3aXiUxJTArAwwt1YDYSMedMEv5cSIqv+bfbWR20TzpTYx8h1BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkHYFCbBWseBNKy2InI9Q0R5oCHrdiFQJL8d3cnbEJw=;
 b=Okf5D8SgJab+6zVfq6PZS3dzcCtBMJYHhYjAq0g4WGC/4/amp3zPXF+SllrDqQN9/xi0bJt7RqzTk9AefyEc4pOeWgb0uxmeLahEnbptGzzG40DaI6iYHV0PiPsbrbhep+1TgXgZr21Mwhv1U6oLxE7BtvX4XvVjI3yODfYn/Pw=
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:52:06 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::e1) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:52:06 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:51:22 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/19] drm/amdgpu/discovery: enable gfx v11 for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:09 +0800
Message-ID: <20221122055025.2104075-3-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e0f005-7f5a-4b2f-50e0-08dacc4db01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU1ppc8GIsaivmiyyu9WfMnttZ/19V4Ab+fK++4lEZrazrgCfGfhAEwUaAgSM9wtBcaxmct9o27YvhLfwsKjU2yCuYgM9JZg2Gz5uSrz2wsbVwq0PmC1ydQrZpt/l0JbTVvpUaxMZ7B2v8oHl5v3EIvtATw6GRq4gD7jA3WW/CYCE+0KiDSjCMKUiVNW2C6qW7nDZexv+h3YQ5o0oVLI9s8OzYIX+LItDZVPFFLgPxL8AVivh2Np92Oj/UBer3bDOCw4/42IHBY+MkIy04hQ1cxjR/PomWaLaq3kx/PrcT2bKhGdYPVlbcm45Zw3t6WpISlckE173M9iQvfYHixwMnTl4uE5BOfMXNHzDA7rjBYbKWJxR6BFIPu/arSREaunS14fGCt9CQDPsea71V0PM1VtGDqPbcHfzPjXRQxGi3GOKS4tXp2qcJYBD8m+fGNJBMT7NOODImMCDoMTUj6Bbj8K1RXx877PhhjX+LOUVrBNplbfJFzaG2+aZ7iadKJDwRr+R10ykriPeBS3J57l/JHPY1KouiCyF4u9RX90JQtYR7ftZTBfpK0YPAXbxuIua0f7kb3yc1SmQE2txjfUOVndDJKKa1+6ov04HfEgSHtkOu80YElYmYzzqGdIoyzR42G2iZgifJ5NbrPY+K6LVjvTQXSae279kPGIxMU1eKKjdA1q4ol9p6zsY8KodL8ytPgo1pGGKaH+pu6q07z1kIokMG4+lWDNZTuhH08tRq8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(86362001)(81166007)(356005)(26005)(82310400005)(36860700001)(82740400003)(2616005)(336012)(16526019)(186003)(83380400001)(1076003)(426003)(6916009)(40460700003)(4744005)(47076005)(40480700001)(2906002)(54906003)(8936002)(5660300002)(7696005)(6666004)(478600001)(41300700001)(316002)(70586007)(4326008)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:52:06.4980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e0f005-7f5a-4b2f-50e0-08dacc4db01d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfx v11 for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a047db7f8ed5..de8c2d81e09f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1806,6 +1806,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	default:
-- 
2.37.3

