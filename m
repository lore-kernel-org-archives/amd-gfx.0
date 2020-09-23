Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E24C4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 04:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2725420735
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gL2Hreg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2725420735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9125A892E4;
	Wed, 23 Sep 2020 04:13:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F006E42E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 04:11:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxrWsxVhmurN/SULR24k3dbOFOyKRChmHTAfE4YWfwxfWcrwvbiP4HWo4BPtCJbVf6jI9SKEpsUpghso5piII2JgUYHp+aHJsj7maT333XWZnhapGFnjVtsJc94Z5aF7j/UtRsQPb0fJAJkRu1MGSVVXgGNNfO+1eKjOMVm0JgfyXLBGSw9neNvbbWBAtZw22cuqh92rzRfAguFyPj+hBJJQAK6XKxGjGwhrZm9ji7PXZGPNsuoDvc9ZK3FfWF5hhAemey0f4sS4PIiYeXTqqwHk27l69Y3ms7Tn2sjSbrxh2To2g9tyzL13Wps31gH3RXy04VOL4FLXwck5l4Tfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F29PEVRAhAIXn5f5ae3uHjlm7eYSCxDOeqBrPxJq1g=;
 b=NrtHFrIB5f7fgZYzN8eQMmCNGw7XmI77L0/J/gRmJzBY2+jJeXSoGToSJfiuzJydBfwDpDlXYDuK04gTA/nYCzXu7ihmOUwjghrHU4eEYoIxEzb/VpU16UwOQ/5RXQjvaQQJAd7PimQKEufUlyL7/OoJwmry7AsmbcKRc1/SHEMrN6SH5uJrpvI0E/yxvcpo4+WIMtO4K9ZeOhUuxa589Udt3lB3fVyTUFJCiFX9HcmuIb1KrnQXCXj+5j/Fn9kUzetFEpXNmkDP+dGN2wZl9DEVpMIdp48/y78KCUFkS1P8zq9LkH2NWla7gmsp8K+O+rxYPiHQW/6GBjsDqEQp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F29PEVRAhAIXn5f5ae3uHjlm7eYSCxDOeqBrPxJq1g=;
 b=gL2Hreg29mmhSYDyocV5B4e5MiVqOcE3Uhy9A3nA26zqFqX3W0ws+p1ugMly3CYXRMaZh2tsIHpYV43pxEWNhcddocbXqCJXHXoZ4nhCWUqJOksP9zAj36dj/SQWL50MrbXqLqGAmpdJmO02KkXMS+RhSx9n2IaojoGpjry3a7U=
Received: from MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 04:11:19 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::cd) by MWHPR22CA0040.outlook.office365.com
 (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 23 Sep 2020 04:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Wed, 23 Sep 2020 04:11:18 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 23:11:17 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 22 Sep 2020 23:11:16 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove gpu_info fw support for sienna_cichlid etc.
Date: Wed, 23 Sep 2020 12:11:07 +0800
Message-ID: <20200923041107.53799-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb1ab17-1fbc-4ee2-856b-08d85f76b907
X-MS-TrafficTypeDiagnostic: BYAPR12MB3575:
X-Microsoft-Antispam-PRVS: <BYAPR12MB35758582C022734E065ED75AEA380@BYAPR12MB3575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vnWEr1vpv4Pr1ZraJhqt0ZdRaCnPCt+kDKEPRg0OKrGCbRVTYu5lVALwKkncZx5U0C/ixhYUk/SLpOBCeeipM+5yMmh19taksr68bDEdNpgzWQgLsux4hTo81EtEPm8Y7f9fcl3saTOwmeS3RjHXjV2NeGcwDY4fv/S6Hc+VDswkKmaPgbl7/cANe9mqEZ3iZpBzCVmRnzalI3eU0zSVFyMA/h+1ff6/K5muej3dGbFJyj4JMUL3zl/rGN4OGDPuTr0EzWokZH4C5XO/WibNKrjQS+5QscKbgVAKwJ+GNdk0MIjA8pbJ2XyN56J1C4s+ck1N/bdKuUHue+ErLQnli0Yh30jYMbCxI2jaPEwANeV7Exj9waTnOHudx369QnLMXi7NhPy6S8ab1/0hiV2XA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(86362001)(82740400003)(82310400003)(81166007)(2906002)(356005)(6916009)(2616005)(83380400001)(47076004)(316002)(5660300002)(426003)(336012)(1076003)(6666004)(70206006)(70586007)(186003)(26005)(36756003)(478600001)(8676002)(54906003)(7696005)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 04:11:18.6333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb1ab17-1fbc-4ee2-856b-08d85f76b907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
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
Cc: likun.gao@amd.com, tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove gpu_info fw support for sienna_cichlid etc., since the
information can be retrieved from discovery binary.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I4cb42aae5d680f28209122bb37962a2291ef785f
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c2eb46e9b71..a174431268b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -80,8 +80,6 @@ MODULE_FIRMWARE("amdgpu/renoir_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/sienna_cichlid_gpu_info.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_gpu_info.bin");
 
 #define AMDGPU_RESUME_MS		2000
 
@@ -1669,6 +1667,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_CARRIZO:
 	case CHIP_STONEY:
 	case CHIP_VEGA20:
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 	default:
 		return 0;
 	case CHIP_VEGA10:
@@ -1700,12 +1700,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
-	case CHIP_SIENNA_CICHLID:
-		chip_name = "sienna_cichlid";
-		break;
-	case CHIP_NAVY_FLOUNDER:
-		chip_name = "navy_flounder";
-		break;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", chip_name);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
