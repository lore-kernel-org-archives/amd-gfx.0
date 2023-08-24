Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45EFC6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7FA10E5C9;
	Thu, 24 Aug 2023 21:32:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D4210E5C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh3RZdTifHMuZ05SItmLp5H7uJ3fheBnLbdhfnwhaY673FGMvzz59vs7qNNr2ji2nogGbznlNHOrKopGmlYgQeDdtYicUgA5lQ8P3CJgIx1u+2EPEir/227OL5isxjqda1mrsEFsdnqr2ICnRyszMDr2FRfY2wA0y65+atZ5F+RnYaj0G0aTHXqs8eXboNnUA2yLLvu3OsO6LJbatBjm7NHa+j/+FWKM0ikzg/NzvfgYWmka5LJ++lZVIwfUsOkwqAreSCKPzolHlHPJ74+Z+vtq0DVauk1a0Yidhq6MdiLehcU5vEwevqWIO6w6JTloqYGCPj3oBpNwWoxEliHqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAIJ6OTHrQutxxlKXulAVNk0AvTGw9iz1OK88nUgXfo=;
 b=hH4yTIMNsqt/Z0IYeH43ELPdbsmVC/JKPsOvzXjfFu/s05VBsa2G43tX+1yi8WW6xC6crPIew8xudsQ6fzYzBv43wAwE/brihogDxxvO0pIrKmQWP9EE1ZXrU6Zd55Hu+n0sJrcUSH1kIokFFcfdDEaXHKjEUCKkrUTsfIeluc5ylpns45vSkhePW80/FVtoS5SGY8zW/ptYu1TbRpWzA+mO6IGmTb3H51fdjQNYDlSTVcDsedvVI48GZ9oSQurCwrSC1NhJLLQHjumcRoAvM9UMl/fBoYQc+j+2L7dTzlV1hO//D5JKWIfkNyAddiZIiinmo4ICbzg513/3CYKZ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAIJ6OTHrQutxxlKXulAVNk0AvTGw9iz1OK88nUgXfo=;
 b=rhHEePrgtiB6PVqLHrpMdhxNwNXAFdwyIyAiqhAOq04lzTkSY9slT28HIYj24EyJ2TVaDTbb6vJirlnqU535K9RLvyNQNd+S2jKa5qvP2uZuP8QUivMNeiqaTI2Iu3IbjA/whBaOG8RNMVQM3gUApNSXJorvxTP9Bym7O57XHCA=
Received: from SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::30)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:31:52 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::b0) by SJ0P220CA0026.outlook.office365.com
 (2603:10b6:a03:41b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 21:31:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:31:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amdgpu: add support for VPE firmware name decoding
Date: Thu, 24 Aug 2023 17:31:18 -0400
Message-ID: <20230824213127.2725850-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824213127.2725850-1-alexander.deucher@amd.com>
References: <20230824213127.2725850-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 394c7c76-556c-4f6e-3c90-08dba4e987b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwbhKdJuUsHD9cY0/zgeRZXG4BmjYp6YUkhK1t0pG6RRRLac7+HHTlv1RMTw1XXpw7dJNfYhxly6ysJPxsOoT7SH0sG71Z95lz55aVlJo7jm8pIg2LXBqEOx/fkr0KCU0BZcG/ERrouSuqFdjXNDI48HMKw2ItlQ6Ifa53W3OCDWl+2XRBwzh2pSJANCcIdHVPZowSXqqqHMgb3sutBgSubWxz4xXfmN0DWyk+wSvfeU0Y5kFgZquPx5h4Ma31+U/mSvEFzGTL8F7uArngfUYaqcspOfeKwxM37exPTXM45CAJ0QIfoNZj7oWCLP22+aqvQ90ms0DcBNa0IVBpRdS2Gow6UbinKw1e3w807X/NrrQd68JKVIzXGvkS0SRYHAVQoyQABcEouk7Fll9ajONhadDXMJQPuzwjy97R8GXcnZm0IcgUE++4qTBUkVaRcOxIAld0OBu7Bj5dcVTHOnykE4E9mK+8UvOhPGJfzJtgldGveKcQ0+ZQTfJ6qcUAo2nGvhf5MhAgTyqQ7HB3Di7JlZfcrolDcjW/AFdc9APB4h5B2HVeCpHQWeNdXZl+3yv7oajT+tqFCu5yO5smjVm9zH5TfzSh0Pgclgv3H1njOmiB8s0c1yH8g9kZAS70Y+uwNkEyi7wm2nBByamz7UBnUXZnt893+UWnqu+bu/nMoRmC886c1H8RVLXMAiTgbNl47FUXxRP+EncTAkBu//T3ihpi5OtfhIbScCp5VxfFRyGkpqAGZ/p3wdyoNdbR///YDD6OogiVBF7rN+fyt3TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(336012)(426003)(26005)(16526019)(83380400001)(1076003)(2616005)(41300700001)(47076005)(36860700001)(4744005)(70586007)(54906003)(2906002)(316002)(6916009)(70206006)(5660300002)(8936002)(4326008)(8676002)(478600001)(7696005)(6666004)(40480700001)(86362001)(356005)(82740400003)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:31:51.1900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394c7c76-556c-4f6e-3c90-08dba4e987b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add decoding VPE firmware name support.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 8beefc045e14..75be1ca6155c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1297,6 +1297,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
 	case UVD_HWIP:
 		ip_name = "vcn";
 		break;
+	case VPE_HWIP:
+		ip_name = "vpe";
+		break;
 	default:
 		BUG();
 	}
-- 
2.41.0

