Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D16C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9942B10F48F;
	Tue,  3 May 2022 20:51:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB09810F4A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=au7HYfgxGFgmoqyPwyeQDPs9QY5VsQcOESjDu658qMatXWyzYlK6PfW7Gom30ex2162uexzvYzJsuxHZeERKm8p1z7skI8DSLGvlDjaoD5wgozrUrmQ6lYW2+SjhSUo8nZHW50mznrNI/2y6qoz+50afRoIt8ntBhQmpefCcYLNjvNYqYtM4sItBeswRKUt0MB1Ra4F8yfwYMVhBASDOXDbgkRxFqHgDHM1g2kxhEoMhzr41vwBd90tSH/dOJiAvUavpFklNEvKkDzVp52FaQo1QSYg+pwJmtAXhETXtDJFc/EP2gm5Gv2Uj2Aw6htaLhjgGlcpiuJTT7koq5rlJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvwtSgLFGCbnKi4CZAFFAqrsiV+frcIozkPVGDKtv2Y=;
 b=T8mL1MP4V3aUl2XM/h+UDPs1cS3bEGblbmCu4TnaEEVM6Pou4982TmGU6D9hlz/AtD7L/9CRzh6nDQ5ITXVFxuR5zY7nfbMWcifGj0a5emfmirN9KUYhJkyKlCXy6/83MYF51AjQmY/alKdt1Y2g2xNPmbY9d2eEOVxG3sWnTwTN58Izv7/i9z8st7d/G1rZQ1YFGwv8s7p+GAfTQRo/M9vKn8Qn5ZHBhnP5KM2KCN3btcW7cvkmf2vJ3dBJhK48JdBuvcQPmRNvXB2S83l/g2LGqCnayrsXxVBimglwnWpLWKlNcCsFCTXFRVjRpPIFzR2GYIoGiXMD7384UZhrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvwtSgLFGCbnKi4CZAFFAqrsiV+frcIozkPVGDKtv2Y=;
 b=QuJQXi4aM2Jg+GhOmkTZVCbsToF0j6KekYfHJ7RuJi56NwLd3PVM69hIsO+gBmhkjY9yKf++b+Zi/5RDp0LuCIqOFal++gPTPxFg/OT2OTg8LbpVeOSKw8Y2Y23uZsHHflKP/iNk9ZpM1DDofD9zrR02W1MSuUf8Xe6kOplKhDs=
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:51:25 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::86) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Tue, 3 May 2022 20:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:51:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable soc21 common for GC 11.0.1
Date: Tue, 3 May 2022 16:50:57 -0400
Message-ID: <20220503205112.1285958-3-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd863206-a0a3-4126-2ea7-08da2d46b059
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4484EE82A9AE8C9B5DED0C5EF7C09@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6qkD5vKKBWHXINuYfen8pr1IsHMFkwOxoLmjTk9p3GUGIuCw2RBB/bwxVcbrufRjb1Dm6SVYMHlTPXjoEWriymujh2/YJa/0vedlmj7tKx+D+nNfCclzJIzIRFyHiffh4wcjHwWNAZTh4SDBtFzHGzCTduR+xlUyUsyxYsDv01WQpwIDcy3lhTLaudDABKXKWqUOxBzTHp0B1uxiVdiiYIY1sJx79viVMn2AESOB6mAZgRBc8UHnHu/KfNXFUQai1HFXaeaxF32uRYicR5nVqWajxRjLvIJb+kpsR16pPuKNrdUSK7S7oKYZo2suM86zDorouBGgXZX770fC97e8yw1WCze+ukD/u2OO9jNPwY0OkYhZykyvu5R/82LBZgb4kHHWwF/FPdJqAAzD9mGOPJg+M3l/0YFmcOl07DLs3Za3tjEDz9avzsbUGPToJSxG6VZ2TS0L1/HfrNF6Ni8h5QPkzAglRLTQ3hkhee59L0KEN4g+M5LsUWT0d4RAQ3MuArAhKJd24gbB/R3ynJJi62cLT2+Cnkc/Elic9XWVg+m4pYfe160wotvcIx1NxaOJ0T+RJoTLUKzz9gsUcyx0ZiJK+LEr5Pkqbbyp+E8n/Q+H7/1PMluwIQg7MikuHWDTtrT5yVT1F6DOY7/zleEfj5YU+2NeVBydINk/9NC8OyOIJ5kbtCBmM+7gYJFfwuglLrLLKEPZtsdtcakR+PhFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(5660300002)(8936002)(8676002)(70206006)(70586007)(86362001)(81166007)(4326008)(7696005)(26005)(316002)(356005)(6916009)(6666004)(54906003)(82310400005)(426003)(2616005)(40460700003)(186003)(16526019)(1076003)(47076005)(336012)(83380400001)(36860700001)(36756003)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:25.5004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd863206-a0a3-4126-2ea7-08da2d46b059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

Enable soc21 common for GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 50cf5c27f3b1..8f5c203c3c87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1481,6 +1481,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
-- 
2.35.1

